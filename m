Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3754C624A5
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 08:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 930EC60607;
	Mon, 31 Aug 2026 08:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hzCQOYUPI_PZ; Mon, 31 Aug 2026 08:01:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788163313;
	bh=ul2yG1KrW77LxTnmQBMzg20VoheY8w6ek+RcXedx90Y=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lreNvOQzcNypnSTaPyK16HD4M3n0/duY1X5wDDN/PvLe1HhQGTR6bvM2QQm0bwM/2
	 f917JwOFLSfj5tNgIDbeDfrXmWuFK//+O0Rrf+3ojXELhtOtgXfx2qSKHogcTgbFcK
	 IQpfLs24shR/r+Zxonx5Y5JCTVt+KJ1bM/Yos5bUcudWmU1q1i6iG8a09GQu18aroa
	 VDmgCwbEdSrmtVEj1jYGZRfbdXoXRKx6C2waBJLqBFRnB2vV+6Ex+zaFKTWOf4zSk0
	 Hhju8O3uN7X5lq5zNN0m6iEUuiMXP25rPe4Qs58tPxT9s/IwKgs/NPw/K67rgTy0DZ
	 CmFvT8EJVXmXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DEFA605D8;
	Mon, 31 Aug 2026 08:01:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E4558356
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C938A8086C
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cE8ky6_mVDcX for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 06:36:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=l9p6lJsg; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=eodbTYe9
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9696380827
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:36:12 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V503SJ4076810; Mon, 31 Aug 2026 01:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ul2yG1KrW77LxTnmQBMzg20VoheY8w6ek+RcXedx9
 0Y=; b=l9p6lJsgK7gXYVc/Y+zGU1QK66EeGK+obCUnBo0+tCzRPg+nZ6fD5Cwno
 STx9hPuxcBlOPrf2UZzz4FMTa0eRyuFI6b+wFcgSoCqEz2R7a8sGf+SdzRXQBj33
 4Ymdr0LRhNDyFebpErXA+3usvDggHMgVSsVHdc8H3Hj50cvoli4iLwwpp84Blqph
 kiL2oRhTcITic3UGEcyl/BFIHCt5vmk9QMDxBPuXxOV7Gk+9q7sFIVgGPFPmHRi7
 fwRnaMGOY56z9lmX/pVv95scP5YSQD17/nYQx9NgHYNaB9dFSZQGY8xZZ2jD6kPR
 yb4lojVP2Oh8Z74xo0O1hXheeu9Tg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gcejpv2jx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 01:36:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNRxWXZToEHCU0GO5I1YS4LU5FaikBFfxypLdXaZvzVJgJLHjoEYeUo4WqYclQ76YtcIZ7hGhvk3to+ihdgAtxZWIPsEDzuqQb+s4rrRTeO13422ycVkSGC8vXDarwhY5tSfc0MB8KEmH1Xcer0NaAdKzktcPwKAMMdQaEJmUdZtYjg+ZYQWutSiyVeyt+52rKweLRnIgU33pPk/9xKPV1EJ1D1ijcy/KML1PKOkndG0l9lmvmKUCyyK1U0yMYijlA9+pF6KVSDAxlSEBDnEepN+v/FffgNypmZNwgso0U2DoKMk+rwZEk48dSHBvnpumuTrvLjDic+bwZrf7Db39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul2yG1KrW77LxTnmQBMzg20VoheY8w6ek+RcXedx90Y=;
 b=dfqZOCQHzgb0q4JgQALmLKzSpVgPt4L/yclAMk42CC1ewH1aR8fyMXXRYglNsszEotBN4FDRiHJFSuK7uDDGUfVwXP0hDuzsNfsPMtg1D8H+aUok+m8bNzeiJlO0T9I/vQj0mUenYkthXhJmNP6hhzHMNCtziJY2IUMCoFBem4eEOyvpRUKDVxhtJ03c/1eicfF5C3QSa/c9VAU1smdlNMh6OOJJlWghxcGbVMp9zfo5JFC+cl9LkU7nl5KMjsKUg0qAuia1y/mEqvk3tJkYMt7/drBZ2iWCZN2/jtdP3Bj5GumcrHveRXK2y2p2BtUa2uGabxL36hm7/Wez1fkqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul2yG1KrW77LxTnmQBMzg20VoheY8w6ek+RcXedx90Y=;
 b=eodbTYe9kl33X8WQ1VP2pfGra7KRPxxzH1t+G6h8jZjQB31syAuqRy/y5xrFQ+w4vl1BTJEOAPMucuFuFumqfXyQ7n5SCxcnxV7AkuJbvbFmDjLYBQezAnA6LM0UJd/ZZYScphx2xDpMMjDXakXBnks0vOkbKJV2qs4C9THAyEg=
Received: from SA1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:2d3::10)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 06:36:08 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::10) by SA1PR03CA0014.outlook.office365.com
 (2603:10b6:806:2d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 06:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 06:36:06 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 01:35:32 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 01:35:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 31 Aug 2026 01:35:32 -0500
Received: from [10.24.51.66]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67V6ZUl7227796;
 Mon, 31 Aug 2026 01:35:30 -0500
Message-ID: <d0fbdfdd-64a6-4ea7-9800-7c5926bd9267@ti.com>
Date: Mon, 31 Aug 2026 12:05:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] A-core no-SPL Boot Support
To: <trini@konsulko.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>, Gokul Praveen <g-praveen@ti.com>
References: <20260819101910.39192-1-g-praveen@ti.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260819101910.39192-1-g-praveen@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: e10837a7-14ce-46ee-aff6-08df072a22bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|13003099007|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: peMA2oJc1ezSIv4kGgjC4UhibkJ7DfYf1F/0qF35cVMW4OJfS+wNNnSiAC2zUvX8Vvevtl1Twit74TlMvQiKKl21RzUvnz1i/OgTJAHOlRUArw/aHOqfjbHbixOJ+G+e5EWZNQSKWzw0AQQ/VCAhtQBIDXfCvu++WWzsvTpKcFYU6yA/twnmO4BbEO6HxrYi1HcxtF+AXjg2lDhMpgjqE5p0ta5ypwZu5RigTZdYDjcgyAJth61n6M11wYMPSNIEFrmeacphbeP8/t4JxVoCs+0xCth8vozjzeBAXusS0cKG7UD8DkwohSBNmPAhfkbW2fm0rvodQ0sFmFJB2iaXwkQxr4nV5DthMs7IDrVtwKdFA9W0UPEzlFnfOZBYU6kzs4QhYwR0F5y8ZYpVRV1lWbbC91klj3a1rra41G7Q4+lEEi94SS5ZqxD3r/vF6LZLLJqUC2QVhw13QYLX+4YhzmPUJWOxSasrYfm0r2ivlwNVY9mAlDXcdK1vlDg8tptA9wdgfVQAvNSMzaWAF1i+PvowfukqttK5FJy02RMvqO1Kk/AHq/Sf5gojNh6V/QUzw/hPEvAY77KmqbIVLb3FYS4NDwu/oQ6L0gZST6H3QfJ7Y5CASpa1RxMvDAKSsByk9vu77KdSSsDZW3bPQGn22f1t+Gec/EqK/W6H7ofGkLI4QEh54T1X4HiNt/ZEhwFg04vm4icDGcH1j/UZSfCYnQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sJMAlNXyDk8QHm2XLMSn+buAtZdI7KwHLv0E5M4BPe5VB1oerZnP6sMXKgmgA7K70LLvapn1VWeyNBsxfwiLphoZI1lphJxHTANnQn8GY+KFktQLj+DWzCjcPkzHbHXhpwgswAXQxGYe6iJ2FlAx/eYvKMlVfqlubPptp3EAwNbz9lUmV+qIIPyPnQwM7NyZyT8HEBO7SWtlMqEhf5ZCQD0zavqtQow6zV1QS2586jpMycLes5p3g63BIYAk447xT3q1JHBMg6WSyUzBELfKvVZaEyaEf99HKzCvIRpt+sqFs7dFIpu5bs9aT2vDYKDPHmnppE4Q2DfB9yGAPaqx0TFBPHz7OJlitBG4t0iZWK/qz5enpH2hnt6XHWM50LmiInXq4s+OvPm6xgi+IQ4TwPy3VlTuBClNBIlC4BMPNS4f2cec5qXGEgOdPgKNc+3b
X-Exchange-RoutingPolicyChecked: OzysUln/FENWtA3KBInfbgUdnkdqJ+Ob3/WVZGcChAyikibthLlhFTbO6kxMqL8kHbWXDJW726mZfrECCvcd1AxmYfqbIqG/62ZYnsTHqEBTsvuL8lErIJhlhvo1Uw3rmHdKPWWuqXLGpGQTJnP9S4Sem7Def3BzWyITDgriW1DF9ABL7chPgooYsjfThWd6m9AtdUShArd/si1DlKSGv3UOvbWyzpODK34c0v9+Cd37qQjRFtNrvl0fVQJZou7GF+bWdUZKKIhAP3VzpBsEDgVi44cBtr9Lub97OmGIWdgPWddFdLLlYCj0xPD2oRgmCZNOm4Gb2OQSVWQajCnsLA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:36:06.2094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10837a7-14ce-46ee-aff6-08df072a22bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX20OQCAWA73kJ
 Fi8HQagVv6P2ra0aAJFfovDx7vtmMZXlwi12Jfv8b5ptHXck6LLbzzZlttv+RGPQUYrF45qBpxX
 h01TReAmoUpf1hGDIxDK+0cKXVrTH4A=
X-Authority-Analysis: v=2.4 cv=b6eCJNGx c=1 sm=1 tr=0 ts=6a9520da cx=c_pps
 a=eN70jGNn7EKSdYhrfilGAg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=0Ie-PWlWDQCjZsF76TsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX2GO+zq7Tuczt
 uk6AytbCsHutzF8zMpfzayYA1V8LwrThYyyPHZP2dpKm2aRwd7pPao2wEm6CB9StDUL/q27Fstp
 vKarhRpO02c8vaRXg1vXmabtN7ZyVW0p+QZ+AW1LA8tpX9qHBEwFmqZjAs+SyD9BMDA6fgOz5z7
 9MmFSkGSpp6UuUYgjRrfjPx032SWnWxUV3rOl01gNoo5wq8/vm+pxBjiBUbz5sw6NZISjGZkNw2
 3mJi3pIM4BjpLu3R6NPze0Tr/vk+LJpOAasTrrMotYEkdBR0/NXjzS3kI9f4R/E3leQAGwmKIVA
 y2iqJXMfoW4RZHTq8HrtLUILeKQvrnrctx+uooWRmpYsjXusBmCrqBGQvMYROrNG2Afq9orlEuR
 FNAjVTTpBcXxMnjh84855mvX97pDkpBLO0/zBejz4f/fvx2S7VmNt/xlmz/0+xD+Nec92WOS7eJ
 pE8FTn2H7V5RD0dA/nw==
X-Proofpoint-ORIG-GUID: x9rc05e_6zyV_igA2lIJ0OyX7ksHzNTg
X-Proofpoint-GUID: x9rc05e_6zyV_igA2lIJ0OyX7ksHzNTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310055
X-Mailman-Approved-At: Mon, 31 Aug 2026 08:01:52 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

Apologies for the reminder. Hope I have clarified your queries.

Best Regards

Gokul Praveen

On 19/08/26 15:49, Gokul Praveen wrote:
> A-Core no-SPL Mode is a boot approach that bypasses
> the A Core SPL while retaining U-Boot in the boot flow.
> This mode provides faster boot times compared to normal boot
> while maintaining U-Boot's flexibility for kernel loading
> and system configuration..
>
> v3<==> v2
> ===========
> * Updated the naming convention used from "no-spl" to "A-core no-spl" to
> * make it more specific and clear..
> * Link to v2:https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/
>
> v2<==> v1
> ===========
> * Updated the naming convention used from "semi-falcon" to "no-spl".
> * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/
>
> Boot logs link :
> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
>
> Gokul Praveen (3):
>    configs: add A-core no-SPL mode fragment for k3 devices
>    arm: k3-binman: add tinospl.bin for direct U-Boot boot
>    doc: ti: document A Core no-SPL boot mode for J784S4 EVM
>
>   Makefile                               |   2 +-
>   arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
>   arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
>   configs/k3_a72_nospl.config            |   1 +
>   configs/k3_r5_nospl.config             |   1 +
>   doc/board/ti/j784s4_evm.rst            | 143 +++++++++++++++++++++++++
>   7 files changed, 272 insertions(+), 1 deletion(-)
>   create mode 100644 configs/k3_a72_nospl.config
>   create mode 100644 configs/k3_r5_nospl.config
>
