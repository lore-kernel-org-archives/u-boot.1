Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C02EDEC15
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 06:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB03C83D8A;
	Wed,  4 Mar 2026 07:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tvbHdIuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753FE83F7D; Wed,  4 Mar 2026 07:44:59 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6146839A8
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 07:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7TGMWSKmxh4e3LEs9O/Qj9/l9HsG9IZ4GxvbIyeP+Qes3fJ9PCs0LEnuKHWWZr5ukmWrQubHsRzg4eauBlUQ7ZA5vNVE1BQJY7J0OKwdwEMX2pv61sDBZI04U7k9UtYiqiFvz9rs8dy0LdS3y+gV2ZE7ig0M2RUPOFTpOqEX4xoTmcYUM72s7FW/vWIZbpxZjqPGhP5kpjh3ZJnAibJL1d2dI8CfJqFmFaTexwy38hzbNqKbClW6OuKv4FDYUiFkOdpctkR7TKulhqnT7/kPZ3tOWWd1sRJSvMtjD08jWlZZuCdwzdI7PazAIltn8lpYr9rd5Z0eTcdQaXulgPZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjgYVDCKQITkRg3gGO0j9Cu2WKG1Q/b/ZXDPhPNaR0o=;
 b=XMzt8Jr12U/CO4DPwVKx7AldCy25ig3q3AIize6fbgcFrF3vA2liAOe0wSBn28WuLpmHqzedpfLimLi0NSGiunLzZOyB4Y/Z9xqmFwxFmukhyjxOdXEaseOO4pjfm+WV3Xnlo4jsAsLa15mP3FQI66iUTF09uuDL50uLWCqKqEo8hmR0Ow5Z8VOlbcZ+hciDhoJaofnW0L8GzbwReXbti5NIJp9eQGuaBSsvkjlZSov96jo6FdMjIWtMqH41ZZ1lzao3VFa68Lv0gG7VyOXTHsrmCfgiTFhesmXebuAVG96haoWYQIpfleC5x054Ja2An5+wh6CQeIoenDB5oDYbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjgYVDCKQITkRg3gGO0j9Cu2WKG1Q/b/ZXDPhPNaR0o=;
 b=tvbHdIuL0M2ZP6gcG6Uf7bwFyNOgJk6zB4guWxePS8dImH3RFzNLk0Hwc/8of9T3lpKmhwOnbv7cNhBd6gs8Ihaf50+n37r0l0Vrl+0ENst9F6yhxpnwq9OtVvhr0CLGiWbLcpZDMdsIUUIp4d5MSSV8jgSS3cvapHL//RAMW2M=
Received: from BLAPR03CA0070.namprd03.prod.outlook.com (2603:10b6:208:329::15)
 by IA0PR10MB7273.namprd10.prod.outlook.com (2603:10b6:208:40b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 06:44:54 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::c1) by BLAPR03CA0070.outlook.office365.com
 (2603:10b6:208:329::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 06:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 06:44:53 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 00:44:49 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 00:44:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 00:44:48 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6246ik4f4078878;
 Wed, 4 Mar 2026 00:44:46 -0600
Message-ID: <17a341aa-4711-4389-8ea1-a8169616baeb@ti.com>
Date: Wed, 4 Mar 2026 12:16:36 +0530
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
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <860de90a-ef7f-499f-9288-61b1f6150342@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|IA0PR10MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 31793d93-5ed9-4381-9627-08de79b98a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|1800799024|36860700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: xLqyVoC0IxU2Uf577MhYXjjO/TMN5SyTt+dI8q3rBb5YaWMk7hCNlaVleDC5YByzaMB8kVhu/QMDXfrR1Yj1Pdc5Q9AlEYv86hOXrlmHsKHU2FUar9CP2lUHVFOmFIsC3azMOtGgxltD1ubc5bxnsse2j0aPnJ9q1oDGPzKs3+zC9pIGV4nIe6SAqVv5lQuWZ0voBzXVFDmBW24ZCCcRAAl8yJpuE8CmuqznfBpLbvKLrOrVYxp6Qn+uFmFTI9SLDy+olhIpu8+Da5/IdLCjfyrmXZDzYyfwFxITwNhtcka3MQa0DLAkk687TIDuwrZG2w0iW7zxi7aSLCt9CAWTgvC3o0UiSpLeZ/QZNR+FtY5fbkzcnkFLTk7iuK+FKcGC5MEn8tSEC/yd4CeQ3S+jgbuR0KczrzWJ/7uAycnaC/o61UxA8q2amfIGKFK4anoRKdZoNlR/N+vhqYGhu39ht2HsulBauB9ds8pm2Cuf2t+ATYhpyHHNTQSMRbhCl0RaLant/6qHVXEf4HpJqWY3eiPvxnECJp5e6rv9EAT0cZpf3x8KaX60FeDU2FXsZtlWeqrm9KqGSCsULegMwms6hoCvZcAPTCvGUQxjJpSCLKESzpZ25eeTCPKH3PwMGCLI1B+vyAm7hq4zg39oewSvq5O6N3PGa9XJmjNPofBAQ5szGHxqL/nI1BYlRt2pTmqQx6ICgXd9YtF89/7sjatjiAJIcxJ38VuqV3TPpoQo56ESUMp7UElIwdX0ZvpJMCL8/zdh3WvKUKaqbntpaZFY3A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(1800799024)(36860700016)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VkNUtBMEbA+yG0FbuNzZ5Mkz6of85Zpz4Y0B+6fhkS9i7c6p5kszO6EC54cW5M6Epb+hS++yFyYgueH5Oh3hH/tgXWI/acmhxaes5gWzE37IvodQ58TUB+/TPg2EeYKF9vax+mYcmGUMxILB4ovXSohLYB6OrYMflg88W6MG3s24SoZyQk3IxhkK1lBnAkPwJKAaEAOu2FzJprSsD3z/sP8Iknqs57kHbzl5Wnj4/hUHeAnYorcmOdYnck8Du5c8hJDZ8B+mm7vsN4X8ZnkogiawgmLn0ZrbexN2WDCtT4dmkd5lt7XPAxi5jAbfrzg1IFzVyxiqO/TxXYMC/FshkB17RnfCOXsvEL4c8w/gl44sltANA9zucIZ8eqlEiWL8y9bDoBGwoUprurPB3VT5qTEHzfOsqIOa7khoTD+zYaP/7kr2wvlxM+H5WowXm9hO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 06:44:53.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31793d93-5ed9-4381-9627-08de79b98a94
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7273
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

On 03/03/26 19:37, Marek Vasut wrote:
> On 3/1/26 6:25 AM, Siddharth Vadapalli wrote:
> 
>>>> There are two users of cdns3_bind() which have registered their 
>>>> own .bind() callback as cdns3_bind():
>>>> 1. cdns3-starfive.c driver
>>>> 2. cdns3-ti.c driver
>>>> Since .bind() is called before .probe()
>>>
>>> .bind callback is meant to BIND the driver instance (to a DT node), it 
>>> is not meant to initialize the hardware. .probe callback is meant to 
>>
>> I agree. But that's exactly where the issue lies. When 'dr_mode' is set 
>> to OTG, cdns3_bind() is unable to determine if the driver to bind to the 
>> DT node is "cdns-usb3-host" or "cdns-usb3-peripheral".
>>
>> Since [0], we attempt to identify if OTG should imply 'peripheral' or 
>> 'host'. But to do that, [0] needs to read the VBUS Valid field of the OTG 
>> Status register. And register access requires the USB Controller to be 
>> powered ON.
> 
> Correct, so bind is the wrong place to do any HW access .
> 
>> [0]: bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role for 
>> dr_mode OTG")
>>
>>> initialize the hardware. This is fundamental part of the U-Boot DM lazy 
>>> initialization scheme. If something does initialize hardware in .bind, 
>>> then it is very likely wrong.
>>>
>>>> , and, since cdns3_bind() is also the .bind() callback of the above 
>>>> drivers, device_probe() has to be added here itself. Moreover, it is 
>>>> only due to the register accesses being performed by the recently 
>>>> introduced cdns3_get_otg_mode() function that we need the USB 
>>>> Controller to be powered ON at this stage.
>>> So, can we fix this so the HW initialization won't be happening in bind, 
>>> but instead in .probe ?
>>
>> That isn't possible
> 
> Can you investigate how to make that possible ? Maybe by having some 
> common .probe implementation that would determine the OTG state, or by 
> having some stub driver which handles the OTG selection ?
A common .probe will not work because the .id has to be either
UCLASS_USB_GADGET_GENERIC OR UCLASS_USB
for the new stub driver (say cdns-usb3-otg). By fixing .id beforehand, we 
will always fail to probe the driver for the case where the desired role is 
the opposite of the role corresponding to .id.
