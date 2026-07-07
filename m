Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66528C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 06:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7611E846B4;
	Tue,  7 Jul 2026 08:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ATIA/eEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6FA84844; Tue,  7 Jul 2026 08:04:25 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F72801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 08:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezLsCu/UUesRuYvJRYqNCVrTRm4Br+gWT1kN7c9R7vln2wmnPdR/IEDuzuZrYTmui4S3P8OEhqri2GsnB3cUKJ3d6n7a9qt+mvRfbaBc4nFkIPMIx2FGwTVx6ZB3IoAZplVnpVf6gQmGcP5AqeKNGgcZ3t7+xhPL0kFy33NQ77lSabK6gAXgaKPtz5frrO3W/A/sUpP+Z0rftn9fAvzgKmdN6KW8qQe1/SRazKBH28+ZeUopWGS9GsRQFCTwgqCZrHJ3bWbm3o65XZdMVdA/J63PfY+Vi6kf3LzD0V6pMzfeWC6inE6ATP4ghuXkNai643B5zekAgnj0ohLsTyygZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oZfR8WVDTazObdGusItLs9Bxl0vI5dZvNC8FRv377I=;
 b=GlO7Gtfy7hxMBevdnK2BYUqgX+ZzY5hwGbZsiQPdGMV2i1QaLe+/HyXZOGXiGFPmqBnSBqr/06SZPJOtsHoGyF+elNkZcZnLzo8iR5hERGfKpBFIeT4VEmoyAlaRebkEo5fwIlQMnEPPOUAcJ63kydySgbPPfa7dUaQgREJF0YSflmZHuzV70V+3hYksTa+Js3lQmwE7TonBl4wCFF7tYSJUtXP9f6UgSem2jI0uzsI43QubU922Jqb9+IN45AEy2a/0TFECGRoHem+ycVqioVhjFLpF0DAJSDti4sowDyoIcc3Vx3Wv/6MW++4Bw2mecytGj0XPzC8XRBMkzWdPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oZfR8WVDTazObdGusItLs9Bxl0vI5dZvNC8FRv377I=;
 b=ATIA/eEwzcik8DvZBBXIkbWlt61r6+x7Hz1pwQSkc5eDdS2su002JhzOCqOGCQjr9FpK8loyZVij4dy/zG9S651XQjnic3F7CLN9Y9JM1/Z8TSJRAJgKChPoz7VvGKov3C5rbypCg9wUKv3QErAAa+vrpjkViq0CjCqCazTSk5qsr9vxDcvORG/Yvh9D9+lUbuOh+9m5LNIAd356eUtrSdgsmyaGTJsqrUKsoCSNv87U0vS/cjw530IgU1Mj2CxiJKx0OX8tMTa4pp5t+lCJccCnfVDrfdbfMRpFYEFAf6RU2O/nunGK4/cPtnEL+65k61HhXp+9SDKAdtSFN5zgKg==
Received: from DB9PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:10:1d9::14)
 by AM7PR10MB3780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 06:04:20 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::a3) by DB9PR02CA0009.outlook.office365.com
 (2603:10a6:10:1d9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 06:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 06:04:20 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 08:08:58 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 08:03:53 +0200
Message-ID: <62451a3d-6fe2-49fd-a724-197774305286@foss.st.com>
Date: Tue, 7 Jul 2026 08:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
 <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
 <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
 <5ce8de52-2fec-4d08-a9e6-cfc69edbaa0a@mailbox.org>
 <13f510d9-6b08-499f-a6c0-f76484488899@foss.st.com>
 <ec6ed9f4-b302-4336-af02-1645aff668d1@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ec6ed9f4-b302-4336-af02-1645aff668d1@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AM7PR10MB3780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aeed211-91d9-4194-b240-08dedbed9615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|56012099006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: YfcoP34hbCYTlQ1Ntl39yfYUaKtFtSpRI+PRuYjUbs9Yj1pipsBtloBJwVXBn4Ukgf6nI0sumH+Z36gL2E72pMj4EbEHYPb1/Ab+Fo+FONv8mRGTjDPlS8rJYfn7adXKUuNJFS3fZC7McYNjIBw/1MpXXWKooFOqZ274eHReDdQjU0dwoexnh9pWAwb2vVJWix1sOzU1lbdvowRNyvz6Rhtfh3Gz1xAvTDZopwU7pC/wLu2DUBYqeL/KuvBDf532a0yi65+Pf+CH2IL2Hkm7cOuhw5WKUsVMVticu/csfzbyr1ZXK08fv42WeSda5PGZP85F6xo5hOFNZnwJd0p9z18OHo/0ckMoh29EhojQY/BvkJo9wtZ+w+zUyDmo6M4qMusiUoO2Q2sZ/5TV9BI4Iuuca2ImzQ4HKPQ7Y+Sl5LvFACUozVUshmG54vY/jlb7wBKqygR5GFX2X9Jdv64iOUD1xMycr5Zri9ZoGPXSubeG2q+FG/KtiiBHc4r6BLeYuU759NpmeRP1HEkHxWtpNzrkBvBdbpijh+h1Tk3EPfLNZ0RdnpUxALFITNaY5hXVE2bj9k87rpK4iX6ckowscVdWhjxD4tyGiuNaQ5LBTV7cQFv3bg64f8rdJdzqEhO82lB/c325VBQVYKdfQ8oHqmZ3oyBTHAWgdjwY5xxnP/hvagNDzBDHh7ISfZNVHt9mK/z254aa39agf2CSzmW2NQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YdqHkv6fdiaKyRTyuVgYfsmRN2646HDoDbxHrrZ/q5moNRcOOxfkXzT15OAKx0zKEPHHbA9eAqGRrpiTphu9ovfgxmX3dfuL5JUoHXEbTH+PlEu2tO9Gr2DXoyCFdNbL+c/VvBJDThhrlq+7vOY4Q1g9bwBbNLna0VRAy4DP0+UvI/Hydg7qJ+OkqfvrIBEVGkXRRVl+qdw4DP7D8IAd4fhOenu8ofeMxf6elRihsgpoe77TEsChFgyxKugOPneMqeHkiY55ZSiXSkEUYvF2kFeWOUf3X9gISYa4YVTNKaZLnTOS4AHvrtE4bmltFB8Og/PINPsdngzZ0VfkCNdH50I1jgC5NGKN5iGzEEP8qLJz3WOkqjPW6Kj+Hvi3C4sMfR3rCLM7I8ViuG/pKUISgRWa5f2vouuSvmGjwsZ+j2b++GCOeVH2fNEtT6IuxNSq
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:04:20.3840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeed211-91d9-4194-b240-08dedbed9615
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3780
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



On 7/6/26 18:00, Marek Vasut wrote:
> On 7/6/26 5:16 PM, Patrice CHOTARD wrote:
> 
> Hello Patrice,
> 
>>>> I did a test, it doesn't bring any noticeable improvements, but nevertheless i will submit a v3 with this update.
>>>
>>> Does the list iteration exit when it finds the first entry that is not going to be executed at this time ? If it does not, then there will be no improvement. But for this to work, the list would have to be surely fully ordered in incrementing timestamp order, is it ?
>>
>> No, the list iteration parse all entries.
>>
>> I see your point, on original implementation, entries are not sort by incrementing timestamp order.
>> I did some implementation test, by sorting cyclic entries in cyclic_list when :
>>    _ registering a new cyclic callback, put it directly in the right position in cyclic_list.
>>    _ in cyclic_run(), after running a cyclic, compute its next call and insrt it in the right position in cyclic_list.
>>
>> There is no noticeable gain.
> 
> Did you also break from the iteration when you reached the first entry with future timestamp ? That might actually help.
> 

In cyclic_run(), as now entries was sorted by increasing timestamp, only the first cyclic in cyclic_list is parsed, 
we don't need to parse all cyclic_list element.

Nevertheless, in v2, Rasmus identified that get_timer_us() is the expensive part of the cyclic_run() execution. 
And he also noticed that my patch didn't cover every corner cases.

He suggested me a more simple patch i tested and the result are identical to mine, 
see v3 : https://patchwork.ozlabs.org/project/uboot/list/?series=512333
 

Patrice
