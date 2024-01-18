Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D26DC47422
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6773A87835;
	Thu, 18 Jan 2024 15:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vua+Cps/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B6087B93; Thu, 18 Jan 2024 15:24:47 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8215E87801
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWvkB2tkx7t4nx2qWKg5A0GoGSvtcxuF6aGYw7lF2zVmRne3iWHbWsmo5Y1OW0N9dETPO/EPjyN1O6vulju7vmiuBorwtbZPO0aPEoLoAQMLgVtQJD8/QlIAp/JOcbEjh+0cL6mOzV0lmMQPJ8gNBBormma614XFsojBRBQr4INBfNn56JuObqvxSzQDM2mMOz8tUJGdYTIJFSmETwETiGsAYW1TNFSRxhctGYgpAEWbis1t++xZIUrmarGOkc2rswpeJCRi8kJuqnWQS3kjIwCHqKWvF1FA4eomcMlMNtV2FTLpEGeWaDSmrtE9ROW+8fZxFT55udGNh3At9WmBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui2B96g00ek8l8zx86w6EQLSshQSpH2X1+oqOaHAXwU=;
 b=PIpeWLMRHIJiteVvkLZk5uMcr7+8k2GETHgdFJJi7GJTTc3fzEIIFalWEPNeed2LDXh3INw/7ip7NGjZeZ5DnKoZ/msA2T62uUeQDBNZk4q2+Qhd3mnAVW8ZJaFFam6U+1mCsAeunPhU3pFt70guN5RuI9RLX3R2cJIr8IbozeRsvf4cAGZ2VlFoKk3RuDf2mPfyOAQM2cyJ6SgEJD5IVuCE0xg+RyQZ+54nBJ8yWJTmHe/Zk35XyfU8EJ6O46QhKXk0r5JzblNViz7AN1JzsUordVssMb2GUBOoVh1tCS+1aW0sZdyVWIVFezK1IbyLi8Cpif3kesIjfBAetvIWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui2B96g00ek8l8zx86w6EQLSshQSpH2X1+oqOaHAXwU=;
 b=Vua+Cps/rYjQbm1x3jcEYZVRUeKljOnUOnBH9pA5JwS2drSHd31MAgtVugEYrXSACpwiiwqIzCjD68sNElqruBpEsx/oR7rG/8q1jmn2F44RbOBoF3MZA0tx5ld0GvxGrpSP4esG01XIekQIbUD2VcvzfnnV6zonC/Rj8CiHxiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:24:39 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:24:39 +0000
Message-ID: <24cd63c5-026d-47dc-af1f-24c04d046ee2@amd.com>
Date: Thu, 18 Jan 2024 15:24:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [UBOOT PATCH v4] test/py: net: Add dhcp abort test
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, neil.armstrong@linaro.org
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com, seanedmond@microsoft.com,
 emohandesi@linux.microsoft.com
References: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
 <e19b68f5-acc5-4838-8fec-b0fb4b4f1a5e@linaro.org>
 <20240118140635.GA12635@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240118140635.GA12635@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::27) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: fa35c547-dea5-42ec-9f33-08dc18313419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kr7jmjwy97OF9BTw4LMunNL2fLTaSjNwkngA6EJwv+KfbY55YhrVVzWLJglvyc5yNZFAKfK8KQSEkbtT3Y+W9onP0cNbvScH/K4r3q/a5yEX56j2quzAOC2WK+J0zXS7NyKlxtqEDQtpIR0I47tGsxpABhR1vQLy3r+W2XgSL3gSynpfHa1WR9t9KuHTmgbCusZx6JPzGgu0G+U9Bp0dmw/7r8X41ULz6LzPubKbcCDquvqpeChMpKknbTZ4vftKPe0iljYmMs/diZaM5f6nOtrRlIloGqIG3ttymO3MJ2XtRadeCH5GR3Cul/AYFJ+AwA2bsCdW1hnPIMghjAk53wwwrJ4Rjc8OWdkwajgHPTmVtoGckEWEqhMnarOhuSd/7QVLusiv7uoFpNDviGFodkNGzLjS53h2AShb+yeh0+Q2MEeCavl42+t+/yIwN4YLOfOx00LeCCDa1oCTNJSx0e58EL/cbwmj9ng7EhYv2hHFdXO2CDCCkwLwraZGW02hPiYzAcUbUxcB5mHxG0iH+oCj1bNCjLyzggwGpuXVY6lwUM3HGGNHPlQzjPUaWYEgQs+R3Ftw6b8zb2X+wkC9IyBDkXZ51pPNfnmU2yX3odeqg5yXjmuZbOQLXcCeXbsezS4cbGA0l3zo+p5bthAvSnPGvhqEB8m1XTo9/xU1ddY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(478600001)(966005)(6666004)(4326008)(83380400001)(41300700001)(86362001)(36756003)(31696002)(6486002)(8936002)(44832011)(66556008)(8676002)(38100700002)(5660300002)(2906002)(316002)(66476007)(66946007)(26005)(53546011)(31686004)(6512007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHF2dnNJanB3Vy9rTlYyelN1U0cyakxtQXM2Ym5zdzZlUDNhc3RWaThSSldk?=
 =?utf-8?B?enFnRXU4N2lwZWlRdjVCNWsrelp5ejhTRkRCNjFMbSttdFRhYVFWcElzZEFo?=
 =?utf-8?B?cGhSRDNQUmtTK2RLZCtoZ2l5TUR3RkVoRjZ4WFNjWXR2WnE0eVpZRUVmUG9w?=
 =?utf-8?B?cERBanVjdDZOMmJzMEtGQzNBRVJmM0pwbUt1SkYxN1ZkcUxobjU2SWFNZVpE?=
 =?utf-8?B?THZWRkI5SnBIdzZ0WnFmZ0g0NWpod2VzbDk0SFdYZXNjUXA4OWhOS0hZOER3?=
 =?utf-8?B?MEc0a3hsb2UzYktEb1ZYdTdBWm0rdG1zWkRVT3h5VnBxTTBlV0F4UlhobTRs?=
 =?utf-8?B?Ym9ia2M2UVg5Z1BrSE9ZMDIwcU1vMWFyVWl3dVlKRTlPc2NZcU9VQ01MVkU0?=
 =?utf-8?B?UmNiOTJKQ3VicVRKRzlUTzBabElvbEhHT3EyZnpnM2VkcVhjbFhxV0VhaWFH?=
 =?utf-8?B?amVLbHNHdkcwaHoybWN1My91RnpGWXRzRVN4eE1jWVhJeHJMWVU3Q01iS1dE?=
 =?utf-8?B?QUJSR0p2Q0o1V09XM0Z5NUdTaURzbHdhbkRCTmR3cXVLS2pKZ0VEMG5qMTBZ?=
 =?utf-8?B?ME1KQlJwVk4raFdFN25Benk2alRNa3RHR0RzbCt0R1BrbDlrd3BEM3FhYkdx?=
 =?utf-8?B?OHU4UkZCcDNqZ3cydlptRzVabEhIZ1AyVXV1S2prRGNqMGNCL3hycnJwYjFy?=
 =?utf-8?B?blIyZE16b2pxNUVyV2lqczhWYnQ2eFg1QU9vRDZOeERRdGRrWGdoYkpOUG1M?=
 =?utf-8?B?T0pwNWpiWkpIbHpqSmV2QmcxNmJiR25RZWxGT1FicnN5L1h2eEJtbGgwclJx?=
 =?utf-8?B?dVV0Y1BpN3NaaW1vMWhKVXR1MWd4bnNmUEhUc243YzJraTJ3L2VTZmhiTk1v?=
 =?utf-8?B?VXdqc1dDTUtqWjFLMk9hcGRXQnYzdWg5ZGtsZ2FJRURJNHNOTnpXRDl3dkVK?=
 =?utf-8?B?Z3pjV1JiR3hPYmNBWGorM3BVUzhZL1dUSXZFTlBYNDNYNWZpNWRheXcvS1VV?=
 =?utf-8?B?NXF2MkxadUFLWjVGbHpWeFpWamc0QjdVRkpISWVFOThrK2JxZ3hvU05IZm9I?=
 =?utf-8?B?UEV3endtc3ZBSnJNMUU2eDlYd2wrOVRUb0ZzVXNDTG1yeEVsZktiV1o0UXJy?=
 =?utf-8?B?cFM5K2hEc0ZVMEJWZFR4ZWVuT3FuSVdIQXZocjYrTlFxUTY0UjMwS3h2NW8z?=
 =?utf-8?B?YXhyOWZiTCtiMzJnenMvWGJNQ2FGZ3loam1rekJZUFFSTzVuZi9yZ2xtR01B?=
 =?utf-8?B?SjN3QnZaMzJieCtRb21RTGpLOVlDbldxZUZLTGpvMExqeUFnZTdZRFZoeWFI?=
 =?utf-8?B?MVl1YitvU3E1ZHRERGY0ZWhOWElUakVxS3NiZzFvVmFselhUTnd1SGRNWXZ5?=
 =?utf-8?B?eEJpeklhanZkL2dFbmhQMnduUkk4WkNKU0hDQ09MSWR1TDF5dFFwUlNZWVBH?=
 =?utf-8?B?UFVkbjkwcERwalpWQkZTU1FaSmJ2OTNTNGFWS2wwWDllZTNqK3JRRnBrMi8y?=
 =?utf-8?B?dVZFMmR1RnluUW9HMk5MSGlEQ0J1VTVBNFhhZG9BNm56ejBaWVFWMldGVWxX?=
 =?utf-8?B?eHozRUp5a1RDbDl3c29hem1zVGVsdllVZnF6aWpFUzhhczVIMHhSRHZpMWlu?=
 =?utf-8?B?MXBVM1BWV1VvWDlpVVdoSk0wQTAvd0VYcmw1UmY5K29QcnBvOGpzL2ZLcnNq?=
 =?utf-8?B?c25vVmF3anlCUk9yaU5OY09xVWpBVTZRWnBkQVM4YWY3NnlHbXdZZGI0cEdj?=
 =?utf-8?B?SXBFNFEwVGhMZ1FsYzUrMCtpRWEwL0kxZEVpMjFScWtnQ3JSSlZvSkJJOWtS?=
 =?utf-8?B?bW5KVzFpdnJxbzVJZ0dzY3ZBNUhNOEJFV2tiaWxnS1BBRGVoQXRrQUN3VEp4?=
 =?utf-8?B?bkNUNE5GcnlHZjJJWjZsaGRhOEJZNU5SSzdhTER6eWxjcmtNTXpYdFFBaVp0?=
 =?utf-8?B?RjEzTUJkWklHNGZweFRkOWZvZEx6OHkxNmFqcEtqYjYyQjM0WkowTG01VE9v?=
 =?utf-8?B?TkxxOWphYzIrUGZyd2tqWXo5ZFMzSG1EeEJaaWd4b1dxYjA4Zm5jcGUySFBI?=
 =?utf-8?B?Z0VCUG5sUldqcU1RZGxvaU9hOXlTcG5hVTFGUWlxdlRkY09rVnBoUjN5clVt?=
 =?utf-8?Q?7FkGrgR2f+4lcd8rUZt/HfAnH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa35c547-dea5-42ec-9f33-08dc18313419
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:24:39.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyv2T2N9K19GLDxXeOXPWgjJc9lva3RgWkE9k1n3hVAr8AYdr6KeFDNnB1mnNx29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 1/18/24 15:06, Tom Rini wrote:
> On Thu, Jan 18, 2024 at 09:56:58AM +0100, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 21/11/2023 14:02, Love Kumar wrote:
>>> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
>>> prompt and validate the abort status.
>>>
>>> Signed-off-by: Love Kumar <love.kumar@amd.com>
>>> ---
>>> Changes in v2:
>>>    - Mark CMD_MII command dependency
>>>
>>> Changes in v3:
>>>    - Skip the test if PHY device not present
>>>
>>> Changes in v4:
>>>    - Setup the network configuration by running dhcp test at the end of
>>>    test
>>>    - Add option to skip the test if it is not desired or possible
>>> ---
>>>    test/py/tests/test_net.py | 57 +++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 57 insertions(+)
>>>
>>> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
>>> index b2241ae6a482..e0749125fd53 100644
>>> --- a/test/py/tests/test_net.py
>>> +++ b/test/py/tests/test_net.py
>>> @@ -7,6 +7,7 @@
>>>    import pytest
>>>    import u_boot_utils
>>>    import uuid
>>> +import re
>>>    """
>>>    Note: This test relies on boardenv_* containing configuration values to define
>>> @@ -30,6 +31,11 @@ env__net_uses_pci = True
>>>    # set to False.
>>>    env__net_dhcp_server = True
>>> +# False or omitted if a DHCP server is attached to the network, and dhcp abort
>>> +# case should be tested.
>>> +# If DHCP abort testing is not possible or desired, set this variable to True.
>>> +env__dhcp_abort_test_skip = True
>>> +
>>>    # True if a DHCPv6 server is attached to the network, and should be tested.
>>>    # If DHCPv6 testing is not possible or desired, this variable may be omitted or
>>>    # set to False.
>>> @@ -115,6 +121,57 @@ def test_net_dhcp(u_boot_console):
>>>        global net_set_up
>>>        net_set_up = True
>>> +@pytest.mark.buildconfigspec("cmd_dhcp")
>>> +@pytest.mark.buildconfigspec("cmd_mii")
>>> +def test_net_dhcp_abort(u_boot_console):
>>> +    """Test the dhcp command by pressing ctrl+c in the middle of dhcp request
>>> +
>>> +    The boardenv_* file may be used to enable/disable this test; see the
>>> +    comment at the beginning of this file.
>>> +    """
>>> +
>>> +    test_dhcp = u_boot_console.config.env.get("env__net_dhcp_server", False)
>>> +    if not test_dhcp:
>>> +        pytest.skip("No DHCP server available")
>>> +
>>> +    if u_boot_console.config.env.get("env__dhcp_abort_test_skip", False):
>>> +        pytest.skip("DHCP abort test is not enabled!")
>>> +
>>> +    u_boot_console.run_command("setenv autoload no")
>>> +
>>> +    # Phy reset before running dhcp command
>>> +    output = u_boot_console.run_command("mii device")
>>> +    if not re.search(r"Current device: '(.+?)'", output):
>>> +        pytest.skip("PHY device does not exist!")
>>> +    eth_num = re.search(r"Current device: '(.+?)'", output).groups()[0]
>>> +    u_boot_console.run_command(f"mii device {eth_num}")
>>> +    output = u_boot_console.run_command("mii info")
>>> +    eth_addr = hex(int(re.search(r"PHY (.+?):", output).groups()[0], 16))
>>> +    u_boot_console.run_command(f"mii modify {eth_addr} 0 0x8000 0x8000")
>>> +
>>> +    u_boot_console.run_command("dhcp", wait_for_prompt=False)
>>> +    try:
>>> +        u_boot_console.wait_for("Waiting for PHY auto negotiation to complete")
>>> +    except:
>>> +        pytest.skip("Timeout waiting for PHY auto negotiation to complete")
>>> +
>>> +    u_boot_console.wait_for("done")
>>> +
>>> +    # Sending Ctrl-C
>>> +    output = u_boot_console.run_command(
>>> +        chr(3), wait_for_echo=False, send_nl=False
>>> +    )
>>> +
>>> +    assert "TIMEOUT" not in output
>>> +    assert "DHCP client bound to address " not in output
>>> +    assert "Abort" in output
>>> +
>>> +    # Provide a time to recover from Abort - if it is not performed
>>> +    # There is message like: ethernet@ff0e0000: No link.
>>> +    u_boot_console.run_command("sleep 1")
>>> +    # Run the dhcp test to setup the network configuration
>>> +    test_net_dhcp(u_boot_console)
>>> +
>>>    @pytest.mark.buildconfigspec('cmd_dhcp6')
>>>    def test_net_dhcp6(u_boot_console):
>>>        """Test the dhcp6 command.
>>
>> This test fails on the BPI-M2S and BPI-M5 boards:
>>
>> Section: test_net_dhcp_abort
>> TIME: NOW: 2024/01/18 08:43:48.152149
>> TIME: SINCE-PREV: 0:00:00.000629
>> TIME: SINCE-START: 0:02:17.928462
>> Stream: console
>> => setenv autoload no
>> =>
>> End stream: console
>> TIME: NOW: 2024/01/18 08:43:48.232597
>> TIME: SINCE-PREV: 0:00:00.080448
>> TIME: SINCE-START: 0:02:18.008910
>> Stream: console
>> => mii device
>> MII devices: 'mdio' 'mdio@0'
>> Current device: 'mdio'
>> =>
>> End stream: console
>> TIME: NOW: 2024/01/18 08:43:48.277449
>> TIME: SINCE-PREV: 0:00:00.044852
>> TIME: SINCE-START: 0:02:18.053762
>> Stream: console
>> => mii device mdio
>> =>
>> End stream: console
>> TIME: NOW: 2024/01/18 08:43:48.318273
>> TIME: SINCE-PREV: 0:00:00.040824
>> TIME: SINCE-START: 0:02:18.094586
>> Stream: console
>> => mii info
>> PHY 0x00: OUI = 0x0732, Model = 0x11, Rev = 0x06, 100baseT, FDX
>> PHY 0x01: OUI = 0x0732, Model = 0x11, Rev = 0x06, 100baseT, FDX
>> =>
>> End stream: console
>> TIME: NOW: 2024/01/18 08:43:48.370420
>> TIME: SINCE-PREV: 0:00:00.052147
>> TIME: SINCE-START: 0:02:18.146733
>> Stream: console
>> => mii modify 0x0 0 0x8000 0x8000
>> =>
>> End stream: console
>> TIME: NOW: 2024/01/18 08:43:48.451550
>> TIME: SINCE-PREV: 0:00:00.081130
>> TIME: SINCE-START: 0:02:18.227863
>> Stream: console
>> => dhcp
>> End stream: console
>> TIME: NOW: 2024/01/18 08:43:48.493680
>> TIME: SINCE-PREV: 0:00:00.042130
>> TIME: SINCE-START: 0:02:18.269993
>> Stream: console
>> ethernet@ff3f0000 Waiting for PHY auto negotiation to complete..... done
>> Speed: 100, full duplex
>> BOOTP broadcast 1
>> DHCP client bound to address 10.34.56.144 (3 ms)
>> =>
>> End stream: console
>> TIME: NOW: 2024/01/18 08:43:51.002287
>> TIME: SINCE-PREV: 0:00:02.508607
>> TIME: SINCE-START: 0:02:20.778600
>> Stream: console
>> =>
>> End stream: console
>> FAILED:
>> test/py/tests/test_net.py:171: in test_net_dhcp_abort
>>      assert "DHCP client bound to address " not in output
>> E   AssertionError: assert 'DHCP client... to address ' not in 'Speed: 100,...6.144 (3 ms)'
>> E     'DHCP client bound to address ' is contained here:
>> E       dcast 1
>> E
>> E       DHCP client bound to address 10.34.56.144 (3 ms)
>> TIME: SINCE-SECTION: 0:00:03.866916
>> End section: test_net_dhcp_abort
>>
>> Full test logs:
>> Job https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5956146503 :
>> https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5956146503/artifacts/test-log.html
>> Job https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5956097398 :
>> https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5956097398/artifacts/test-log.html
>>
>> It seems it makes DHCP fail on subsequent board reboots.
> 
> We need to rework this test to be opt-in rather than opt-out, I'll
> revert for now.

yes. It should be disabled by default for sure. I told to Love to designed all 
new tests like that.

Thanks,
Michal

