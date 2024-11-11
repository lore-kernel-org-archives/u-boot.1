Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E80AD2E9C0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F4888F8E;
	Mon, 11 Nov 2024 09:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="ersBZOia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835E488FCE; Mon, 11 Nov 2024 09:54:07 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA7C88D14
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcLTDyl3zoMMmsEbIj6XWk7ExUT3MSOsGI43MfwS8sfLA7B9+QreKimVzmQLxB+6ZtcUAMaHu3FnLaizcQkz5E40j+D7yhwAIrpjVUleocdH6gbQVPyFEaXfjQDX2v4DeQob4pR6+Y/FLxHx80+HwN/Rt2AwpO3j425rE8q+gcFdjvsghzfr9PLjsxpPSKqShKedABR+h5C6MpJEcgIkOtqmsHHKTF0+dsT0HcIGodS2fa1pMwtfqWdI3DmV+ZFAhxRRcIhjw8cgrir2b9scJK9z2RM4C0W76A+CcLk5Y4kd6DDRpPa0SbbTa4JGuBy3YZLmukjh5u23ih3wUn0IIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77rjlxAzzvRoGaNlCsZpNCSMIxhosRj0+SiPHHLAP7g=;
 b=Y2eAbq3OyWDNjpyORCLKD75T0GiP5bRJ+bOthvRA3ffU10s/jspklVscpekMiKtZGZ9Qla3MQHcsoBTflcrrg6klDQitEZZjnw5iQkGB9ulafR+OQe4Waz/DVK38HENUdquysjxOQyPBNl/XRKxS/phZXO0F3g3dnP/XEhcN4dHyxEJb3GtsuqkJ7XKQKL00dTdVNE1XfuHL9bc+dhSsDqiqWtOHCZJDMdyvS/VziLvsEpB1i8s+uEcfs0Dd2IxSIK5PWHWrXJXIlDykB96aFbO4ZjZApAFj7QMHSSr23Uqbr1j6V/DyyXCsoY3GuZGgmAOj9iS8vbAUlaxijV8fEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77rjlxAzzvRoGaNlCsZpNCSMIxhosRj0+SiPHHLAP7g=;
 b=ersBZOiatQlqCHBMPdcUdW+s2uMp6I8lYoOJrks5ZUYP5yHwRgQMNjaVxU9yYUOt1GdQgAkDx0tOT1xvxdS7/l2MDWTFz1rW/MHXgHwET/7UW7N+rEmgPa2qBh5vuOQtKq3brRkey8H2/plaTCDhbSl0P4dYBx9V1jl19nhssB4=
Received: from AM0PR10CA0087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::40)
 by AM0P195MB0690.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:14b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 08:54:00 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:208:15:cafe::c0) by AM0PR10CA0087.outlook.office365.com
 (2603:10a6:208:15::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 08:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 08:54:00 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Nov
 2024 09:53:59 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Nov
 2024 09:53:59 +0100
Message-ID: <0af9b688-e264-4249-bf32-dfa0434369e8@phytec.de>
Date: Mon, 11 Nov 2024 09:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 3/3] board: phytec: imx93: Add phyCORE-i.MX93
 support all SOM variants
To: Christoph Stoidner <C.Stoidner@phytec.de>, PHYTEC Upstream
 <upstream@lists.phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "m.othacehe@gmail.com" <m.othacehe@gmail.com>
References: <20241104112537.752027-1-c.stoidner@phytec.de>
 <1e96d288-f2ba-42f0-a20c-5527997b5fa6@phytec.de>
 <de475050b9f6d6580ae35c583c177a13f6dad8c5.camel@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <de475050b9f6d6580ae35c583c177a13f6dad8c5.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|AM0P195MB0690:EE_
X-MS-Office365-Filtering-Correlation-Id: 334e85bd-f062-4293-869c-08dd022e6295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEw5SVNTOU5MdmszeFUrTElQdmVRZml0Y1NjcC9LMTV4enJUU1l1dU5IVk10?=
 =?utf-8?B?WjN2enYrczNtOHBFeXJGMmFZU0g5VHovdldNSEhDZUhPbE1EMzBtQkhhdm9t?=
 =?utf-8?B?ZDE4NjBVQnpWVkh5bFRoWXhzcEFIa0lscVR3eXp6ZnU2MXBHN1IvVTgvcFpY?=
 =?utf-8?B?UmMwQjZZQm40SHhrVjViY0VWS25XY3o1cW9rNkFlRlI2TjVqTTArcTdURXpv?=
 =?utf-8?B?VFI1MFlmWFR3bGJ4dFc2MmRvS2ZoaGhlUklKTkNnMjBTL2lGaW1UYzZiK1dW?=
 =?utf-8?B?OGxWSmR4LzloT04zdUoyY2ZsU3JIY0k4RmM3dTZqeWUvd05LYndzVG9VQ0hm?=
 =?utf-8?B?ZEJHYUNKaWVtblZkTUNPazlJZnJZWksrbWF5ZFp2OEp3MDNmTThGWklRdXZY?=
 =?utf-8?B?d1NrK3N0d1Ftc0hzMjlUSng2eHBSMXJzYUQyd3BDRkNlSlVlYnZsK0d6Wmda?=
 =?utf-8?B?VDZyU29pUFU3dXRMc3QyM2NoUFZ0MEppSWZKaXQvc0N4Ym5kTVpVMFNlejRY?=
 =?utf-8?B?TFR1YjZnUEpIQmlOZHV5MDBHb0pVSmtTYm9TZDJ3c3pKUktWVTRDZEhpdFBU?=
 =?utf-8?B?aVdqdm1xTnVoT3ZwekNCVWdXelNGazNWVFZIQ2RZWEdFZWdFa1ROK3doWG9I?=
 =?utf-8?B?NXlOK3dac1E3OXdKcTBxdkhnbUNGc3BQcVhBTkVGVHRMclB0SXQwenc5bXFa?=
 =?utf-8?B?ejZEWmVhY1NtSytlRDNOSW1MWW0wRTMvOTZRVUphU3JHNXlOYWhQUENhcDVY?=
 =?utf-8?B?ZWZLQnNOZTdLSktKOUJjaXZjVlhLY25SM3NBSTN1SU5PbnpwcytSYnh3N2Zz?=
 =?utf-8?B?ekR2REhwanhYRWh3N2F4V3QybVFWcE01Ry9POEdqdElHK09iQlloMG81MTJE?=
 =?utf-8?B?SFFsSDVmdExnV2NyNk14VjNSM3Uxdk5vUDVvUFFIMFA4N2NEeW9DQ0ttZEhy?=
 =?utf-8?B?djB6cGVpd25TOUlZV3BFQnNUczJvTldQamlnNjNZN0M5Z2JRek1JZ2FFTmVC?=
 =?utf-8?B?RWZKY0I1VkQ4RGIzY3daZFIvSFd3RWZRSmkxWDFzTldmMmlUTm14WWc3aEln?=
 =?utf-8?B?MXROR1NwNDk2UUtjTENTTFpXd1ljNWJwNTQyWWlzdU9tR3J6K1E3dU5IN0xs?=
 =?utf-8?B?RGQ3UGFGbUNhV0I0NW9kTEVnM0dXNkt4LzU1QjhRY1grT21hVGVNYlQyY0lQ?=
 =?utf-8?B?VXlHUVhiR3cxQVhXcXFseFg3N0tuMVVHNmtzd01FN3NHRThpN0ZaS1JGYWpi?=
 =?utf-8?B?Nm5CcnpKSE5OeE4xRlZnZ0MzSkN5U1dqZUxoeThPOHIrWVdpZ1VBSGN3azNo?=
 =?utf-8?B?OUxKaUxuWEhXWnVXYXlNWFZvdmRyVWhHamVXMUQ3T1dSSXRETWdFVG9tUUdu?=
 =?utf-8?B?OE9RRVdFY3lTZlYrWnhkenBFOStFUG5tVnFkdHV3VDRybnU3VVk2MFZGcHJk?=
 =?utf-8?B?ZkEvYmt4N2h5enZ0L1pjOVdheWFQbHp3b3ZiWGdEbUVhY3R5cnMvblpUNTNp?=
 =?utf-8?B?cjd0S1lYRy85RnA2YnJVUWF3ODRXL2ZwTnlzKzduaXpmcThhM3NtVzBvSEZx?=
 =?utf-8?B?cGVybkZueU5MQ2VOTnkyZ0tmZDhLZFVhUVN0clhRN1lOK2NLRDF0N0tLbUhD?=
 =?utf-8?B?YzZDQkFzYlJHbk1RVWUyUk14RnVOQUIzR2YzaVJIcmp4N215TExpS1FjUm5J?=
 =?utf-8?B?UFU0L2JiMENjSnZ6cnZqOVFpMGJaNVZPOU9jQ2ZYaDQ3a21HU3c4ZTdZNy9p?=
 =?utf-8?B?N3FLMHpTTEIxdGU5T3N3bGtTb1R5ODBoV0Y0MnpUQjBKNHovajZRY3VRamtU?=
 =?utf-8?Q?/pu/YVwI0LClijYB+850ra94w+uBedvJNFDSM=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:54:00.1727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334e85bd-f062-4293-869c-08dd022e6295
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0690
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



Am 08.11.24 um 19:02 schrieb Christoph Stoidner:
> Hi Wadim,
> 
> On Di, 2024-11-05 at 08:42 +0100, Wadim Egorov wrote:
>> Hi Christoph,
>>
>> Am 04.11.24 um 12:25 schrieb Christoph Stoidner:
>>> The phyCORE-i.MX 93 is available in various variants (e.g.
>>> different ram
>>> sizes, eMMC HS400 yes/no). Add a new SOM-scoped defconfig that
>>> makes use
>>> of the hardware introspection of the phycore-imx93 board-code, to
>>> detect
>>> the SOM module variant, and to configure the hardware accordingly.
>>> The
>>> resulting SPL and u-boot binary shall able to boot each phyCORE-
>>> i.MX93
>>> module variant on each carrier board.
>>
>> I think it would be better to simply rename the current
>> imx93-phyboard-segin_defconfig to phycore_imx93_defconfig. This is
>> less
>> confusing and follows the idea of our other SoMs.
> 
> I see. My original reason to keep the existing
> imx93-phyboard-segin_defconfig was to avoid any breaking change. And I
> thought limiting the existing one to the SOM would be a breaking
> change. But a further look to the imx93-phyboard-segin_defconfig
> confirms what you said. It is already scoped to the SOM, only the name
> "phyboard" is confusing.
> 
> So, I will rename imx93-phyboard-segin_defconfig and just add the SOM
> detection. I will send a v2 for that.
> 
> Just one more note: Other than you suggested above I will use the final
> name "imx93-phycore_defconfig" instead of "phycore_imx93_defconfig".
> Although this does not match the Phytec names, it does fit the existing
> naming scheme in the upstream u-boot. I talked a while ago with Teresa
> about that. The existing phytec names have historically grown, and
> later the naming scheme with imx* prefix has established in upstream.
> Teresa and me agreed that we should use the upstream way.
> 
>>
>>>
>>> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
>>> Cc: Mathieu Othacehe <m.othacehe@gmail.com>, Christoph Stoidner
>>> <c.stoidner@phytec.de>, Stefano Babic <sbabic@denx.de>, Fabio
>>> Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-
>>> imx@nxp.com>, Tom Rini <trini@konsulko.com>, Yannic Moog
>>> <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrej
>>> Picej <andrej.picej@norik.com>, Wadim Egorov <w.egorov@phytec.de>
>>> ---
>>>    arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  14 +-
>>>    board/phytec/phycore_imx93/MAINTAINERS        |   1 +
>>>    configs/imx93-phycore_defconfig               | 156
>>> ++++++++++++++++++
>>>    3 files changed, 169 insertions(+), 2 deletions(-)
>>>    create mode 100644 configs/imx93-phycore_defconfig
>>>
>>> diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>>> b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>>> index 25c778bb07..e84476c38a 100644
>>> --- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>>> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>>> @@ -2,15 +2,25 @@
>>>    /*
>>>     * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>>>     * Christoph Stoidner <c.stoidner@phytec.de>
>>> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
>>>     *
>>>     * Product homepage:
>>> - * phyBOARD-Segin carrier board is reused for the i.MX93 design.
>>> - * https://www.phytec.eu/en/produkte/single-board-
>>> computer/phyboard-segin-imx6ul/
>>> +   https://www.phytec.de/produkte/system-on-modules/phycore-imx-
>>> 91-93/
>>>     */
>>>    
>>>    #include "imx93-u-boot.dtsi"
>>>    
>>>    / {
>>> +
>>> +       /*
>>> +        * If the u-boot build uses the device tree of a phyCORE-
>>> i.MX93 carrier
>>> +        * board (i.E. imx93-phyboard-segin.dts), then this u-
>>> boot.dtsi
>>> +        * deactivates all carrier board-specific peripherals. This
>>> means that
>>> +        * the resulting SPL and u-boot binary can boot the
>>> phyCORE-i.MX 93 module
>>> +        * on each carrier board.
>>> +        */
>> This comment does not seem to reflect what
>> imx93-phyboard-segin-u-boot.dtsi is actually doing.
> 
> I dont know what you mean. Do you see any carrier board peripherals
> that keep activated? Or anything else? What missmatch do you mean?

You are not deactivating anything in this u-boot.dtsi file so the 
comment does not make a lot of sense to me.

Regards,
Wadim

