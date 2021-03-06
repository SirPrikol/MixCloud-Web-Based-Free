{include file="sections/header.tpl"}

			<script>		
				function remove() {
					if(confirm('{$_L["Remove_Alert"]}')){
						document.getElementById("member").setAttribute("action", "{$_url}customers/remove-selected");
						document.forms['member'].submit();
					}
				}
			</script>

			<div class="content-wrapper">
				<section class="content">
					<div class="row">
						{if isset($notify)}
							{$notify}
						{/if}						
						<div class="col-sm-12">
							<div class="panel">
								<div class="panel-heading">{$_L['Manage_Member']} PPPOE</div>
								<div class="panel-body">
									<div class="group">
										<div style="margin-top:4px;margin-bottom:-20px" class="dropdown "><a style="width:170px" href="#" class="dropdown-toggle btn btn-success waves-effect" data-toggle="dropdown" aria-expanded="false"><i class="ion ion-navicon-round"></i> {$_L['Option_Menu']}<span class="caret"></a></span>
											<ul style="margin-left:2px;width:auto;min-width:168px" class="dropdown-menu">
												<li><a href="#add-member" data-toggle="modal" data-target="#add-member" title="ADD NEW PPPOE MEMBER"><i class="ion ion-plus"> </i> {$_L['Add_Member']}</a></li>
												<li><a href="{$_url}customers/pppoe" title="LIST PPPOE MEMBER"><i class="ion ion-person"></i> {$_L['List_Member']}</a></li>
												<li><a href="{$_url}prepaid/pppoe" title="LIST PREPAID PPPOE"><i class="ion ion-ribbon-b"></i> {$_L['Prepaid_PPPOE']}</a></li>
												<li><a href="{$_url}prepaid/recharge-pppoe" title="RECHARGE PPPOE MEMBER"><i class="ion ion-flash"></i> {$_L['Recharge_Member']}</a></li>
												<li><a href="#remove" onclick="remove();" title="REMOVE SELECTED PPPOE MEMBER"><i class="ion ion-trash-a"></i> {$_L['Remove_Selected']}</a></li>													
											</ul>
										</div>						
									</div>
									<br>
									<hr>
									<div class="adv-table table-responsive">
										<form id="member" method="post" role="form">
											<table  class="display table table-bordered table-bordered" id="customers-pppoe">
												<thead>
													<tr>
														<th class="text-center"><input onclick="toggle(this);" type="checkbox" id="checkAll"></th>
														<th>{$_L['Username']}</th>
														<th>{$_L['Phone_Number']}</th>
														<!--<th>Email</th>-->
														<th>IP Address</th>
														<th>{$_L['Type']}</th>
														<th>{$_L['Routers']}</th>
														<th>{$_L['Created_On']}</th>
														<th>{$_L['Owner']}</th>
														<th>{$_L['Recharge']}</th>
														<th>{$_L['Manage']}</th>
													</tr>
												</thead>
											</table>
										</form>
									</div>	
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>					
		
			<div>
			<!--modal add member -->
				<div class="modal fade" id="add-member" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
					<div  class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								<h4 class="modal-title" id="myModalLabel">{$_L['Add_Member']}</h4>
							</div>
							<div class="modal-body">
								<form id="modal-form" class="form-horizontal" method="post" role="form" action="{$_url}customers/add-post" > 
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="#service-plan">{$_L['Services_Plan']}</a></li>
										<li><a data-toggle="tab" href="#account">{$_L['Account']}</a></li>
										<li><a href="#existing-ip" data-toggle="modal" data-target="#existing-ip">{$_L['Check_IP']}</a></li>
									</ul>
									
									<div class="tab-content">
										<div id="service-plan" class="tab-pane fade in active">
											<div class="form-group">
												<label class="col-md-2 control-label">{$_L['Type']}</label>
												<div style="margin-top:3px;" class="col-md-6">
													<input type="radio" id="Hot" name="type" value="Hotspot" disabled> HOTSPOT 
													<input style="margin-left:10px;" type="radio" id="POE" name="type" value="PPPOE"> PPPOE
												</div>
											</div>
										<div class="col-md-3 col-sm-6">		
											<div class="form-group">
												<label class="col-md-2 control-label">{$_L['Owner']}</label>
												<div class="col-md-6">
												{if $_admin['user_type'] eq 'Admin'}
													<select class="form-control select2" name="owner" style="width: 100%" data-placeholder="- {$_L['Select_Owner']} -" required>						
														<option></option>
													{foreach $o as $os}
														<option value="{$os['id']}">{$os['username']}</option>
													{/foreach}						
													</select>
												{else}
													<select class="form-control select2" name="owner" style="width: 100%" data-placeholder="- {$_L['Select_Owner']} -" readonly>
														<option value="{$_admin['id']}">{$_admin['username']}</option>
													</select>
												{/if}
												</div>
											</div>
										</div>												
											<div class="col-md-3 col-sm-6">		
												<div class="form-group">
													<label class="col-md-2 control-label">{$_L['Routers']}</label>
													<div class="col-md-6">
														<select id="server" name="server" class="form-control">
															<option value=''>- {$_L['Select_Routers']} -</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">		
												<div class="form-group">
													<label class="col-md-2 control-label">{$_L['Service_Plan']}</label>
													<div class="col-md-6">
														<select class="form-control select2" name="plan" id="plan" style="width: 100%" data-placeholder="- {$_L['Select_Plans']} -" required>
															<option value=''>- {$_L['Select_Plans']} -</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">		
												<div class="form-group">
													<label class="col-md-2 control-label">{$_L['Expire_Action']}</label>
													<div class="col-md-6">
														<select id="action_on_expire" name="action_on_expire" class="form-control" required>
															<option value"">- {$_L['Select_Expire_Action']} -</option>
															<option value="disable_secret">{$_L['Disable_Secret']}</option>
															<option value="change_profile">{$_L['Use_Profile_Expire']}</option>
															<option value="no_action">{$_L['No_Action']}</option>
														</select>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-md-2 control-label">{$_L['IP_Address_Type']}</label>
												<div class="col-md-6">
													<select id="ip_address_type" name="ip_address_type" class="form-control">
														<option value='' id="select_addr" selected>- {$_L['Select_IP_Address_Type']} -</option>
														<option value='static' id="static" name="static">{$_L['Static_IP']}</option>
														<option value='automatic'id="automatic" name="automatic">{$_L['Automatic_IP']}</option>
													</select>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">	
												<div class="form-group" style="display:none" id="local_address">
													<label class="col-md-2 control-label">Local Address</label>
													<div class="col-md-6">
														<input type="text" class="form-control" id="local_address" name="local_address" placeholder="example: 10.50.75.1">
													</div>
												</div>
											</div>	
											<div class="col-md-3 col-sm-6">	
												<div class="form-group" style="display:none" id="remote_address">
													<label class="col-md-2 control-label">Remote Address</label>
													<div class="col-md-6">
														<input type="text" class="form-control" id="remote_address" name="remote_address" placeholder="example: 10.50.75.75">
													</div>
												</div>
											</div>	
											<div class="form-group" style="display:none" id="remote_address_dhcp">
												<label class="col-md-2 control-label">Remote Address</label>
												<div class="col-md-6">
													<input type="text" class="form-control" id="remote_address_dhcp" name="remote_address_dhcp" value="{$_L['Automatic_From_DHCP_Server']}" disabled>
												</div>
											</div>												
										</div>
										<div id="account" class="tab-pane fade">
											<div class="form-group">
												<label class="col-md-2 control-label">{$_L['Login_Method']}</label>
												<div class="col-md-6">
													<select id="loginmethod" name="loginmethod" class="form-control">
														<option id="select_method" selected>- {$_L['Select_Login_Method']} -</option>
														<option id="username_only" value="username_only" name="username_only">{$_L['Username_Only']} -> Password = Username</option>
														<option id="username_and_password" value="username_and_password" name="username_and_password">{$_L['Username_and_Password']}</option>
													</select>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">	
												<div class="form-group">
													<label class="col-md-2 control-label">{$_L['Name']}</label>
													<div class="col-md-6">
														<input type="text" class="form-control" id="fullname" name="fullname" placeholder="fullname">
													</div>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">	
												<div class="form-group">
													<label class="col-md-2 control-label">Email</label>
													<div class="col-md-6">
														<input type="text" class="form-control" id="email" name="email" placeholder="example@email.com">
													</div>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">	
												<div class="form-group">
													<label class="col-md-2 control-label">{$_L['Phone_Number']}</label>
													<div class="col-md-6">
														<input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="0877-0229-9005">
													</div>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">													
												<div class="form-group">
													<label class="col-md-2 control-label">{$_L['Address']}</label>
													<div class="col-md-6">
														<input type="text" class="form-control" id="address" name="address" placeholder="Jl. Ledjen Suprapto, Sidoharjo, Pacitan">
													</div>
												</div>
											</div>
											<div style="display:none;" class="form-group" id="username">
												<label class="col-md-2 control-label">{$_L['Username']}</label>
												<div class="col-md-6">
													<input type="text" class="form-control" id="username" name="username" placeholder="username">
												</div>
											</div>
											<div class="col-md-3 col-sm-6">	
												<div style="display:none;" id="password">
													<div class="form-group">
														<label class="col-md-2 control-label">{$_L['Password']}</label>
														<div class="col-md-6">
															<input type="text" class="form-control" id="password" name="password" placeholder="password">
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-3 col-sm-6">	
												<div style="display:none;" id="cpassword">
													<div class="form-group">
														<label class="col-md-2 control-label">{$_L['Confirm_Password']}</label>
														<div class="col-md-6">
															<input type="text" class="form-control" id="cpassword" name="cpassword" placeholder="repeat password">
														</div>
													</div>
												</div>
											</div>
										</div>
									<div  style="margin-bottom:-10px" class="form-group"></div>	
									<hr>
										<div>
											<button class="btn btn-success waves-effect waves-light" type="submit">{$_L['Create_Member']}</button>
										</div>										
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>	
			<!--modal add member -->
			</div>
				
			<div>		
			<!--modal search ip -->
				<div class="modal" id="existing-ip" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
					<div style="max-width:400px" class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								<h4 class="modal-title" id="myModalLabel">{$_L['All_Used_IP_Address']}</h4>
							</div>
							<div class="modal-body">
								<table class="display table table-bordered table-bordered" id="existing">
									<thead>
										<tr>
											<th style="height:35px">{$_L['Index_Number']}</th>
											<th style="height:35px">IP Address</th>
										</tr>
									</thead>
									<tbody>
									{foreach $c as $cs}
										<tr>
											<td style="text-align:left">{$cs['id']}</td>
											<td style="text-align:left">{$cs['remote_address']}</td>
										</tr>
									{/foreach}
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>	
			<!--modal search ip -->
			</div>				

{include file="sections/footer.tpl"}