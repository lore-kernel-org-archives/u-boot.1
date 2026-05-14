Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD034CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 22:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3050084663;
	Fri, 15 May 2026 00:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U4XsMla3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B2A384674; Fri, 15 May 2026 00:21:40 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8122C8464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 00:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfFe6qECnKAEuWzzq6AslwNcUlneMWud6PjF0sbGfcgd9Ppp4YBge2yMQT72KgWNals4FInDhTFwnU4t6Bc/XhFDB0NHQqA+BckO5G/TQapyGqXJqW6/lp0NranMEVheh6Wlf080F8YWprh2T/oS/X5SRMN/YI9BnH7kg9V5KDvws9SyDPsMGpEnHRjIzitrAFKW9B/bhsUckMQetof0bTp3fQOVTFZHx0Z1pvX2jtbFUu1b2J8v4rhsMUyiDJ62gZPEKMv46926ZU4ewYiWmqobzK47+jagDA5mvI/TW22b18jSJYsOya6RvkAAvEcCNgs8cyqIGzh4F2oPClqI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA6PP0wZLi3cgqn/rnsNdlX6EhvAew9gcRkiaqqf9/o=;
 b=JyTtplGwxMw70JjhP3qXHkioQxCOthzz6il4CSr3PZIbY8PPwspFtryFSplrYdC5ORTVT5gVSZNOPaUhsZYTwJ/zzmS6pUQoT9mydVezap3lg3fKbv8pEhR3pta7ceSubK3xPvA5gU4js4wiIg5LnYjEGrmt6z84nw11fywm6SziCDgNKNKpIDyOQnrIokpLJIgMnZADkqp1ZmJDBXCVxf9TCp2zLOxp2rwLsydr41qISpkeBbslYjR0oaKRHdrdBhHcU4Ya8sGFkb2m0fVNwGUI4JAhSEJrHq6vgNuPbtpHuXwt1f+mS9+cz8FRswAhnW76qffxF5I/nwEADNWbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=altera.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA6PP0wZLi3cgqn/rnsNdlX6EhvAew9gcRkiaqqf9/o=;
 b=U4XsMla3YT1eg3PG28Uh8eaqfRSmgc2G2bgzGxM8JzIM+YnO1aitufT7B/5KjZxYircQhCi+L5dhn6lKmS62bchbQtMXvxQ6BGmzRxbYDLf40oXSoVUJZCCsnBpI/zf4T5EyFGqG+L/INC+jTSRTG0L60tCuBuYTsdOGclNkH1o=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by DS4PPFBD26857F8.namprd10.prod.outlook.com (2603:10b6:f:fc00::d44)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 22:21:29 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Thu, 14
 May 2026 22:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 22:21:27 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 17:21:26 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 17:21:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 17:21:26 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64EMLQob3119317;
 Thu, 14 May 2026 17:21:26 -0500
Message-ID: <2fc6397f-83d9-49ff-aaa1-ab4d773c95bd@ti.com>
Date: Thu, 14 May 2026 17:21:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <marex@denx.de>, <tien.fong.chee@altera.com>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <52ec8007-ce50-4f12-b796-4b8c2aa1822e@ti.com>
 <190995da-40e1-422d-baec-dd3bdad0b315@altera.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <190995da-40e1-422d-baec-dd3bdad0b315@altera.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DS4PPFBD26857F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f37eb19-f5a5-4166-f66e-08deb207243a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: JhLbGoKCSjXdShtI8VPtysj9YbHV8sd1sPWtAfeKowP9KRhCzqqNZv8LEIQl24+gYSiwKSOjxdY3PfXvNbGXHseF7Q9n1wt+ZPfXmNjfdH7ysjO8j8DG0nYTjlJ5nJs5J/CnFOaL1AXOs7VoR2vhKn6Jo5nvwbBEu+auS5trWq5rEiBUWqPoo9T+psbInAG81QbwKqyc087DbMM1hyuu1AuaLkdeGAKaHkfuHLOIqW5J4V2xXRgl01TEuHnjhD1AEISPkgAuk+lB3m4HWYD/oF0nK8ZAMHFijGdEHp3BxxnnFOgcQolsyjBzmRVLXJHlVuFNdvMC8XNQLhy75S//DMvPgExS9/l5nmI0tF6OpVwD5Yh6Yiy21YtnLbgejJAA49SUZfpoqeAHNVZy2EX5vks42mXhwBT49GFy2E7PMPLsaUFVn/WVqzOkWSZL03yX+x3RNPAZJK2KNxbNzSBdYsKWT9hFwptRggAdcpEuGwTlhp6kzkyH0Y0Saj1FSWQDCp7PiFds6K7HeMpHrwgyvJwdeRE8RxgNMToTV+bPQvBC5wNLiN4ryAqn2Fa3ua8sDLq16n8AtME2RYKOOSHrWhjOJ/JEHB5zqxSA/K+iGs6TlKZXAd82vKHKCu9A95dk72b+8Vl1OUXSK1jLnV0kmoVGrJ2npOYPC3Xci6/VC08yObfBgZf74i3+3NhLI1HN
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: unNPWjMPdIfyt3ouhO4cjCAxoAwU1pa+fcO8qzpzunjjcCJTQf6vVY1DxrgW3UysY22Powp2j/tBfAv1ii/sRUhl2V0SzCcWuXmYGWS5mYWEDOksRUV2vStZoINKaxQ7YC7ISdAg9NRKu1qGbc/x/sTm4p+nnbP/eFEP+FOsKQfehz4jsGF8PImxzIAejrkKho+jFShAuH4z+ysXba6auZad0E9sn9U5gjuFniRaiWvxUpzSrhJFTvF19rqMDKzw/VPUa8X73sFDpfR3xlynNvxA9D27KrfnVhkpScS4NygFb3loC6q407qGBjmUh1YLJuSVCaYOgYs+BdCngGjkLPzT/G2Ds3xoVNiKfHmRRtN9/5UOpe6JEtb0JsDonNldtpLn8BatrtOYWAjk9/CCNytXbZXV13fKztMNcW/S4LI8MJlQcortA7tr51ZXHeYk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 22:21:27.4224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f37eb19-f5a5-4166-f66e-08deb207243a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBD26857F8
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

Hi,

On 5/14/26 1:50 PM, Kathpalia, Tanmay wrote:
> 
> On 5/14/2026 5:09 AM, Judith Mendez wrote:
>> Hi Tanmay, all,
>>
>> On 10/21/25 3:45 PM, Tanmay Kathpalia wrote:
>>> Some boards have SD card connectors where the power rail cannot be 
>>> switched
>>> off by the driver. However there are various circumstances when a card
>>> might be re-initialized, such as after system resume, warm re-boot, or
>>> error handling. However, a UHS card will continue to use 1.8V signaling
>>> unless it is power cycled.
>>>
>>> If the card has not been power cycled, it may still be using 1.8V
>>> signaling. According to the SD spec., the Bus Speed Mode (function 
>>> group 1)
>>> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. 
>>> Thus
>>> they can be used to determine if the card has already switched to 1.8V
>>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>>> transfer mode.
>>
>> This implementation broke am65 IDK board SD card boot, I have still
>> to check why this breaks only one board, potentially there might
>> be a quirk only for this board... But for now sending the question
>> in case anyone might have an idea what is going on & save me some
>> time.
>>
>>
> 
> Thanks for reporting this. I had a deeper look at the code and found
> an issue that is likely the root cause of the failure on am65 IDK.
> 
> During a normal cold boot with a UHS-capable host and UHS card, the
> voltage switch to 1.8V is already performed inside sd_send_op_cond()
> as part of the ACMD41 handshake, and this is recorded in mmc->ocr via
> the S18R bit. By the time mmc_startup() calls sd_get_capabilities(),
> the card is already operating at 1.8V and reports UHS bus speed modes,
> causing mmc_sd_card_using_v18() to return true. The warm-reboot
> recovery path then fires unconditionally and switches the host voltage
> a second time, which on boards like am65 IDK can leave the controller
> in a bad state.
> 
> The fix is to guard the recovery path so it only activates when the
> voltage switch was not already performed during the current session:
> 
> -        if (mmc_sd_card_using_v18(mmc)) {
> +        if (!(mmc->ocr & OCR_S18R) && mmc_sd_card_using_v18(mmc)) {
> 
> Could you please try this change and let me know if it resolves the
> failure on am65 IDK?
> 
> I will send the patch for review on the mailing list.
> 

Seems like that did not work for me [0] :(

[0] https://gist.github.com/jmenti/bb2dfc93630219a4d137edf2e20ce66c

I might not have a chance to debug/respond here soon since ill be out
until may 25, so until then, happy hacking :D

~ Judith


