Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E41EF4EB4
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 07:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21AA583936;
	Mon,  6 Apr 2026 09:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hE22fVuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED818394E; Mon,  6 Apr 2026 09:01:18 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7A88341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 09:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyiGnPbLdin6L0zHfgV9Pli8uj1rxuZ2Cxw7Y2ZLY3PSGJjSSzD5YoEypi4/kSx17PvgisRDY+hOhgJV5IgzAlIRidsYqDj9uB6GqJsyytQZrUwpweS3zlYyUL8Mla/Jul6c9N6RaC/PetdIq6uK5iBuho0PHhClANhY55fskRN4CxRwbV43XRshRdTe8ewZXYSLpXtgFBUO7CV6C1eeayBW+gmZPwmheDeY9bS2FVxgYBcj1B/E8BHHxTWKEHO0IfegGFwAXVaSOUVq8B9+ra1qAXFClsa0TfUt2i+PwT+rrdZQcaYv+ptHWOGvSbG9irgjnZnA88lcBkdwi/S/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQaJAS6FAWlfKp73SpUDP17YQWuyjDihCetnuNgezd8=;
 b=f4wvUZbXexAZ/i9uXU57Cu9xnam5zYwdxvYO/zsyIXcoa0mn23Yyqe8ln+pgV2Hj1X4/La8/3UAMyh5GSv0UcrlKlRfHZ2EzOy2zaVfAkggiRt5uxsORtigQn2whBDNMzpfvA92NuxeSt2r9k5hxGWRgOp8c0mM4zQBto6VvAJcwRyPgFtk07uvqOoMVuN8ps59eFIKmVdiPl+O1U90F4fxHUrP3djBeb3/2Azlt0lHvoSuSpuLH7uwUmZiUhc8PNZjtRenuyug52oJ1MKqZPFlXbt8noMRO524I6Qx4A9KiY9X8NYqxiG8EjKvwPeW+VC4dte84BdMK2qXmMgzjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQaJAS6FAWlfKp73SpUDP17YQWuyjDihCetnuNgezd8=;
 b=hE22fVuIQvCEag4J5ZwTCNVKT+C7k5SGdJ2BGhPWbzVCYKOaWWQPZfRqGetwsPZ5hibEN+aUzqjFu4fhSzkWIs5Vl1GMZCBcJN92hZYf+W6vRGs+w7UgJHVWj/S1AxIyMhKvx0I4V98T1nrIOFSeDdjyCnGBUqD7Y91TZdEREl0=
Received: from DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15)
 by LV3PR10MB7795.namprd10.prod.outlook.com (2603:10b6:408:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 07:01:13 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::ae) by DM6PR08CA0041.outlook.office365.com
 (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 07:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 07:01:10 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:01:10 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:01:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Apr 2026 02:01:09 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 636717lj275275;
 Mon, 6 Apr 2026 02:01:07 -0500
Message-ID: <d8699cf4-3e4e-456e-894b-f086bd7a6ece@ti.com>
Date: Mon, 6 Apr 2026 12:33:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
To: Marek Vasut <marek.vasut@mailbox.org>, <marex@denx.de>
References: <20260227055954.3916518-1-s-vadapalli@ti.com>
 <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
 <c5e0e61b-a8ab-4186-9460-84221d843542@ti.com>
 <f19e58ad-58ed-4d5b-a348-6d2270e546f0@mailbox.org>
 <992e9023-48dd-460e-a783-9caf58f5e944@ti.com>
 <860de90a-ef7f-499f-9288-61b1f6150342@mailbox.org>
 <17a341aa-4711-4389-8ea1-a8169616baeb@ti.com>
 <a0d9a46b-1040-4c0a-bb64-4d1fb0d8e8f0@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <a0d9a46b-1040-4c0a-bb64-4d1fb0d8e8f0@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|LV3PR10MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc15f14-24ce-4a5a-2eca-08de93aa48a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d9Gl/hklAc0eGVzPQPEN3SbTI+cX/+TTHUaQ0mQtja9HbQef6FuiN8I7+qNTMiBc+UQk2hDE56DIYwl9bRQWv2IsIXPobXi/YyxMnnHsrcZxn94iaMMRAS/Qc0AEMNBAoB6/IC2j1W+eRkNKr7nEy1zL8xl/3SsTjIJzWzKk6JAnYZJuzJqycwVPOQoHuT7wqk8QLOWSqH9lsu0ld7vQSICpjfzc8auq1ZBwxN/paT4pIF9dK3JRyg1ZEZwOOVLI1HN3I2/w1IRXGeMsYI93vTTMNcHpeGBTHLWNLqeLjNve41c2FrD29DjjX7WLNq3r9e57zocPbyrutWuRI2SN9fSSzaINFxYOv4N4ETj4PNnRNoahX8JYffSga3jX478/hHPjF6oa9vRDxnT1Dp1LhQfdn2O545nedu8FlihVMu9jFLx6lj+NwhvFX1kMG4NcAIy27j4e1udR0r3/qo0lQtHxX5CnM1w3aYhTgcOZOEMSCVE6BW5hnTXSQ9HjHAcy69C4nhf0BOKwgGLzkfhnjjyplgb2Km55yPVO3zkyP47JaGGzSqnQXSp5Efn1U4qA3L2ym3+mmZwX6qO53QVZ4vDBzkxn5W2Ik3HQItvQL6qHttae3aUrjh0PAQljpvpupwmD7FhdIp69vA7I0Rmj6ZB0B6d75nM//hJGKk4eI79qkXVvXgprdQJ1dpLLu+XwSlIjNitkCn5Z2FuaYiwWVp7E77o4T46XuOzsCezeOPvliqpShMnvX4/UtM5cn4xZbCor8hq8te705bDco+N+Dg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Ktv3UF6SdlpMNDpK8jp8/Z3Zh24GriXvDFAlG3N5i4WlvJYt9MxENuDsjF6nTMr+ioPU6/PI0i0NC8HeteV0VdrzVNJnyvCzLu0YMFM5XEIr53hUgJS2SgHWumLfjaJ+AkLCReN7JlMPMmoH6j3pKGVqF5ttM439nHdULXyagYOIkHKa1F7+3p2j6OP0KjiimbVVF3vKrLDHdTdv5GCz/Tu/h/U8P07VZt3OfYAGLniLT+ZtE2BSfkHTIXgoEyOYw7RCw8u5sYSBR7W8hX4CA4JNBmEkvIZOzkHpEZg+FVZssVI5xDEUmi4gKVJHZrVEAx5kO8ju98ctsCzj1KhTJ0yLo2+tDxN2MgSvvZYXzXnCb8XBYBQOM5bGWM0OtWhImg59FU134mIgxBIXr+e3snLMznyL8xACLvdwn++iU93A7HGsjDn5ne7Z8E35x1+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 07:01:10.4454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc15f14-24ce-4a5a-2eca-08de93aa48a1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7795
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

On 04/04/26 04:05, Marek Vasut wrote:
> On 3/4/26 7:46 AM, Siddharth Vadapalli wrote:
>> On 03/03/26 19:37, Marek Vasut wrote:
>>> On 3/1/26 6:25 AM, Siddharth Vadapalli wrote:
>>>
>>>>>> There are two users of cdns3_bind() which have registered their 
>>>>>> own .bind() callback as cdns3_bind():
>>>>>> 1. cdns3-starfive.c driver
>>>>>> 2. cdns3-ti.c driver
>>>>>> Since .bind() is called before .probe()
>>>>>
>>>>> .bind callback is meant to BIND the driver instance (to a DT node), it 
>>>>> is not meant to initialize the hardware. .probe callback is meant to 
>>>>
>>>> I agree. But that's exactly where the issue lies. When 'dr_mode' is set 
>>>> to OTG, cdns3_bind() is unable to determine if the driver to bind to 
>>>> the DT node is "cdns-usb3-host" or "cdns-usb3-peripheral".
>>>>
>>>> Since [0], we attempt to identify if OTG should imply 'peripheral' or 
>>>> 'host'. But to do that, [0] needs to read the VBUS Valid field of the 
>>>> OTG Status register. And register access requires the USB Controller to 
>>>> be powered ON.
>>>
>>> Correct, so bind is the wrong place to do any HW access .
>>>
>>>> [0]: bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role for 
>>>> dr_mode OTG")
>>>>
>>>>> initialize the hardware. This is fundamental part of the U-Boot DM 
>>>>> lazy initialization scheme. If something does initialize hardware 
>>>>> in .bind, then it is very likely wrong.
>>>>>
>>>>>> , and, since cdns3_bind() is also the .bind() callback of the above 
>>>>>> drivers, device_probe() has to be added here itself. Moreover, it is 
>>>>>> only due to the register accesses being performed by the recently 
>>>>>> introduced cdns3_get_otg_mode() function that we need the USB 
>>>>>> Controller to be powered ON at this stage.
>>>>> So, can we fix this so the HW initialization won't be happening in 
>>>>> bind, but instead in .probe ?
>>>>
>>>> That isn't possible
>>>
>>> Can you investigate how to make that possible ? Maybe by having some 
>>> common .probe implementation that would determine the OTG state, or by 
>>> having some stub driver which handles the OTG selection ?
>> A common .probe will not work because the .id has to be either
>> UCLASS_USB_GADGET_GENERIC OR UCLASS_USB
>> for the new stub driver (say cdns-usb3-otg). By fixing .id beforehand, we 
>> will always fail to probe the driver for the case where the desired role 
>> is the opposite of the role corresponding to .id.
> 
> Looking at this one more time, drivers/usb/cdns3/cdns3-ti.c is already 
> UCLASS_NOP , that is the parent driver that you are trying to probe in bind 
> here, right ?

Yes.

> 
> Could you instead flag that cdns3-ti.c with dev_or_flags(dev, 
> DM_FLAG_PROBE_AFTER_BIND); so it would probe early ? Would that resolve 
> this problem too ?

DM_FLAG_PROBE_AFTER_BIND will not fix the issue because:
1. cdns3-ti.c registers cdns3_bind() as its .bind() callback.
2. cdns3_bind() will be called before the .probe() callback of cdns3-ti.c
    even with DM_FLAG_PROBE_AFTER_BIND
3. With cdns3_bind() being called before .probe() of cdns3-ti.c, the USB
    Controller is still Powered OFF.
I have tested it nevertheless and have confirmed that the issue isn't fixed.

> 
> And just a follow up idea, if you were to stop DM scan at DT compatible = 
> "ti,j721e-usb"; in dts/upstream/src/arm64/ti/k3-j784s4-j742s2-main- 
> common.dtsi (i.e. the cdns3 driver wouldn't bind at all), maybe you could 
> make the cdns3-ti.c bind the right driver (peripheral or host) the same way

For cdns3-ti.c to bind the right driver, it still needs to read the OTG 
register when dr_mode is set to otg in the device-tree. This would mean 
that the USB Controller has to be powered ON. Since controller is powered 
ON by cdns_ti_probe (.probe callback of cdns3-ti.c), a different .bind 
callback in cdns3-ti.c will still not fix the issue.

> e.g. block device partitions or USB devices are bound during 'mmc rescan' 
> or 'usb reset' . All those devices are instantiated after the initial DM 
> scan and after the controller to which they are attached has been probed. 
> This might be the way to avoid probe in bind too ?

The device-tree node layout and the corresponding drivers / callbacks are 
as follows:

	usbss0: usb@4104000 {
		compatible = "ti,j721e-usb"; => cdns3-ti.c driver
		[...]
		usb0: usb@6000000 {
			compatible = "cdns,usb3";
			[...]
		};
	};

First, the cdns3-ti.c driver's .bind callback is invoked. Since cdns3-ti.c 
registered cdns3_bind() as the .bind callback, cdns3_bind() is invoked 
before the .probe callback of cdns3-ti.c driver is invoked. As a result,
the USB Controller is still powered OFF for non-USB Boot Modes when 
cdns3_bind() executes.

Regards,
Siddharth.
