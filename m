Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8476CC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7B784A60;
	Thu,  2 Jul 2026 16:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LQpEnU9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37AD284A6B; Thu,  2 Jul 2026 16:32:54 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF881849D2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3dvi6HiIqbXEeYrLpGojm1AKqcESDq/Od+hFYFI+XdD5qa968nl33aGZA2cpsDvJuEr+0L/H6T+rBMhnVGqKs+6eL7N7+8rx06sNsW7TmVThluQTvbKAo+Z1OfXVzNiTlCLOXH8dX1Visjr1469DGYs+SKDp/qE8JDXbgXiezVmxCx2uz71O4FxK2ZKUVCZb1PGonjhO2IPGZCaRmooOSIZZSmxfnop7k2Y/m5/ltvpy4KjvT65taHmUHyCoBjzrvL/NX06NAoXQylM1MWpLDn6+Y9qVG0lPir0Br2qLaXpi5D08nQdKG9HPjsr6c+YbcDzFlmm9u2zBdArLbggJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2F+tumWSpeXmU6F51/GoVz4AmwAAppNTiV5kBHawHg=;
 b=LplcwmKOj8HQOvKa1oSiAYrs2URfEdtp6A+loQODZuYL69M7CHBoqwGYNQRqK3+FOL2WDfAePXXoLsPIGrvbjqxZjygMOx1riBbv2oxXlxKRy8bh4XAHOf9lA8tpJzaguw1smo3/zgLcxxmkty/JMc8xdjS8NldcuwVfBvzf1TPxd65RY6Ye/bqDLPZ2Wj47CMmzCdpxZEMM/dMRRj34HBzbAMc4eu8rbGSrzNXtW7TqmXi0GZXU841BafC1CjlOnU7mpUeO7xwJDstNYldQWsMfqS0Ny2FWT6iBDwWsAnWK9HIzQBqRr8FmhRtOs17tW4FmgTIz20x8H2hMF9/MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2F+tumWSpeXmU6F51/GoVz4AmwAAppNTiV5kBHawHg=;
 b=LQpEnU9guT0vqnHCjL7mtUq6/9FM4D/sikAJiHvt/lN6p/JRJJ1tjh2LF34soSYyvcRO5ctqpm21uEQe99AicmitkC+TUqMeS7k+wrdUBv2C2BjKVh76BuNJnreETcC051cYZn+9ABA+iLmDTw/+oeAfSoNs4/vgT5EiNvcbpCKyZdEbMmVQLrvROtSOexki4O+IYbe2gLnaXQKjsu/Vtbu/9vNKf/wjv5w1rb4kfsIG7DhdyA4G26cm8jwD22NzJyLukUII+f8MJ+6++l/KRTIXlf4DfkvXpc+BWbqm/xNMB8ILW7pHP7yJrERDJO8/2mD7npVJ7sIpAFOTebKISg==
Received: from AS9PR06CA0075.eurprd06.prod.outlook.com (2603:10a6:20b:464::23)
 by AS8PR10MB5808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:523::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 14:32:48 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:464:cafe::7) by AS9PR06CA0075.outlook.office365.com
 (2603:10a6:20b:464::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 14:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 14:32:47 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 16:37:04 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 2 Jul
 2026 16:32:46 +0200
Message-ID: <26a24fc7-98f3-4126-b565-aab28f722463@foss.st.com>
Date: Thu, 2 Jul 2026 16:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
References: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
 <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
 <d239690c-4503-4c60-90ce-478394aed4c0@foss.st.com>
 <2051a113-6091-4ece-bf1d-affb2797374a@mailbox.org>
 <4db136c5-aa08-4506-99ac-bbfe0c7963d8@foss.st.com>
 <1d7dec66-5da1-4555-8514-ef89de5491e0@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <1d7dec66-5da1-4555-8514-ef89de5491e0@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|AS8PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: af57cccc-382f-4a5f-7142-08ded846c9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|6133799003|11063799006|4143699003|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: K6TBvrBR452tNvbnF7mdN53GdQl0nMMvPm0BYht1Yr2PweHzuGCpH0y/MoGa5a9SdPaAggVhpp/GL6MT+d4iqRK037ixVEc1iEUa9AR3xBLJynEDVAoo5FVpZF5b7Vlewixre7DEkVXTDCGO3uQARVhm37M980KCyVV7bVvJHLyTkhCVDNx1UR8qCeNQ4G0TR4CC1+l7sRhvwEhuhDoOC1P9zJyZTHbtmH326aNK0jsaaxIbo/laznq0n9LbHAbZoJ9bqn8dd9bnWtrxBmBYR9C6xpT5C+49Xgrf0+SKt5uQDBmDxZDyD0dgrHKeQ1hsa30SjHg2N1gP4Y7ExwCPFkXYRT65RFSNepuLR9B5ilh+RBobhwmi4j3dafjSblULQYpMYSfq30njT5+rLCszLuIjSFFIVQwHTKL7m2hqxc68+eoSHK/EwQDHvCyvxBVX+bXqnUqHkeGc3gNZrjJZSeLFevCCDrWgqAMA01txs3MnBe2pMJN/lICdmNRusg3x0W2v0XhD0dgHIn2A1JG46ty3Emd1SQF+vmeMm5QlfvYZBer2+aksyobTvdo3zroLXVEbOBW26ew23wVtucFuTeULUH+l8ulZUbjkTIR/akjQzbSsxQacbPxD7AcN00M1oinOxU/iJDcXTuWmJMo8uxpdToLCa1Lb+Ju+trlT2LxbBFohRKoz6dS5tSBiAn5dLty+V21ZwM0bg5ZV2z8LaQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(11063799006)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z1BGAd0RYm5N4vhq0vFwJSzepwVarxYQxxfSatlgFlPOOEqBzYDH9hCpDf08uZ517Z5oOFOAsPkxCSzHPI7fbeLVBr/q8biN4537xJZBNly2p8e945cbCUHcWoNiXSZcJOA+JqhOzpgMR4RvagUC3fJ/rmgIwJEPvL4Di4EzbwGq6PJRn4H9qe60iU1dx0CWJU0r+2Fkqn2BLcbC14POhD+AedGI9sILLXOWXE+H3fB8hcn1dvegAveVrfWD1eOUZmOp8RbLBCfg+zKwjgHlWA/asLzATbD2KgM57/OevDInYf8wOa/W/UQduYnp9LQVDDYZuRZjhgG8e+ESL3KWjFwtOSCuAx9cKKjFsaHp8xrRi5htK+0bHwhmfxXMBqfyP7TufMnZvRiM+smHLUAl+DfEr8RivMhMiyKIWJAPQKgYiBq9SnsveH+TXvM+y1cP
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:32:47.6453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af57cccc-382f-4a5f-7142-08ded846c9c0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5808
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



On 7/1/26 09:24, Marek Vasut wrote:
> On 7/1/26 8:27 AM, Patrice CHOTARD wrote:
> 
> Hello Patrice,
> 
>>> What takes 700ms in sleep_thread() , surely not schedule() ?
>>
>> Hi Marek
>>
>> On STM32MP157C-dk2, each schedule() execution takes between 2 and 4us depending of the cyclics function to execute.
> 
> That is about 1100 instructions on 650 MHz CA7 which is way too much , I think that is the problem we need to solve first.
> 
> Look ta common/cyclic.c schedule() , I think it is the list iteration in cyclic_run() that takes forever. And I think the fix is simple, let the list iteration surely run through once on the first run of cyclic_run(), and while it is running, for each entry, figure out when the entry should be run NEXT, and note the NEXT run timestamp down. At the end of cyclic_run(), figure out when the nearest NEXT timestamp is (you can do that as part of the list iteration of course), and store that information in some global variable. Finally, add at the beginning of cyclic_run() a test whether this timestamp was reached. If not, do nothing, because you already know that nothing has to be executed yet, and you will avoid the expensive list traversal this way.
> 
> That should make the execution time of cyclic_run() negligible for the majority case.
> 
> What do you think ?


Hi Marek 

Agree with your analysis, i will send a fix to exit from cyclic_run() in case the next cyclic timestamp is not reached.
But, in parallel, to gain more reactivity, schedule() can also be moved at the same level of ctrcl() as this patch is proposing.

Thanks
Patrice

