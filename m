Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C32ECCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51CDF60606;
	Mon, 19 Oct 2026 10:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-JyVmOVvjrI; Mon, 19 Oct 2026 10:40:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36CD6606CF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406406;
	b=pDN1Sv62Vo90e6/feegk+rq4dWNRTjbt0nKYnV5Q63ykRLNUnpL0JN1qvJ9QJqaRtYD8
	 fHgb9/hoETRIF9TP5NjV68GOc90ANrBM1/1jnIVvXs2U8PDAiflStwTmCSaHyPgkzPgYa
	 +SQT0q7ygruF59FeHTnqMUGjNOkN6nWszTaw8FW1tOnUQDoFtHfKCzuBK7P+P3nUiwoaB
	 TP88QyHu816vgtBW1Pea5Bt07GIiAFEgnNMdQkMJg1XtgOvS86sTH+Y/Ijsa/j4McmNs3
	 7MDoFDk+vN2Zq16p3vqR++1+xa9WiV3QrZnsh1RuYBtMr+NKP7tTkztqwWCiz05YI9A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XaYRmVuFK1dy9x3Et7LvqSzJPvi9vm2YYI0RirWJeeI=;
	b=oNJkOY1WM4dtpwpvNcZ77a8iI0CHcikTXWpXMFubFpbPYiTTUqlECoiFqTpY5nhgQKSi
	 Hzm059O22s56iiaEU+Zg+bp8GoeQ4sZdzEAyaUJjF8mdAnC0YV+gusCOZmBUj8GgCEwak
	 0W77v55v4kif4o35cMy18apatRD/KHfXrnlOZcWGODMU0eKMulJKXHIXN2UG3mj+JEf4e
	 dcl+0YhWgGuMqfG2IATWVxLE4bqSAg6nbFcDpR7ZiTOGZF1GELBQMeRFIeUrHVPv4fJyI
	 yY15FPjNG5f7OltBT8B8PR3epfoGxj0RRyL0sWEEBkvzRUhE8ecJQ6RVbuNvbhfpM7A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JI5Eomh1;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=iX9bCqZG;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406406;
	bh=XaYRmVuFK1dy9x3Et7LvqSzJPvi9vm2YYI0RirWJeeI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ymNvZ0i2+lEkiDyaFRYHRPjl/pZrRluQJwdgavp6hbraN1RGPQX7hBdGcZ3jepyRI
	 X02FLegZybTZsUf/tnClUQ82ahFgqWkGW16SOjhXTqfrTRVCXxRggGHHCDEfACBfMw
	 AuFJjK1kS82avtpViIVNOpJkj+b/ATpQarMcipR0ROph03QHy0WY/wuw+CE+Dt5DFR
	 A4NYIT923CutozoxwPzmlcrBN7N8SnMmnkZcWsOc5muEDFzl6pcCljXd/5SVXO55KB
	 lJVV+JWarklJ1tQ6A8rsN8PcWDnga8OTwjtk6bAKhtR/kFNUcnEI0eRJAPdT/pS0AN
	 df40IaM2g5z0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36CD6606CF;
	Mon, 19 Oct 2026 10:40:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0072523F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1FB0606EB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KWqIwk9--wTh for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:40:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA1E260606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406404;
 b=Ow6YD8XdZS4eNY5zruIYKR8+fp/t19aN6x3m183Z9vWUrkov3t/CxEdsb8sG32uIKyzS
 MrE1WkxDPgSFxhEC04CaYULICOfDNJrEo6nw58nRBb2loE2oIy/uaZErW36CEi69CaMLk
 d3DQ6iQjBpKeglDmsDsMvt4zxJcFNmZKR4bG6OBvR3ClrMlEn65hzhbxhXNDU34U7sDaI
 eyCqycVUzt/W/sUla3/3h2yaDKvvKX9lnjcH+VXlJppZMjk2KnRrn2atm9k2tgQRkYjAr
 3pIUzNPz6+4bEmwDX649MRM4ZTTeYN19vQawE8CNqtKP/SkOCemjDNEW7ZWKTUVL4dA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406404;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=XaYRmVuFK1dy9x3Et7LvqSzJPvi9vm2YYI0RirWJeeI=;
 b=RWGxoheZDpdMsf3ih6CpRQGe545UO4sf4UQU5qjx/QYLd9QljTL+2aSmvHDAXfPCiwfM
 S+SJcGQ325/Mvv1JiVGDcc/rLGS7JE/sAzQhbYFJybOkssCWDS+Wc2zfjT1qnmYHi7Def
 D2T0M6IhoWuZdh5V41LD2o+A8sT7VglUsEzlto9mvy/zFxOvhHl++h5II5GbRPU+dpb/8
 QHjH8TTl7xcWbgmuBpdwDgoKqdkl0KhxundH4hQZG1JDtPV7JzavL4g9K2IFzl9hx6h/K
 YtQ1I7riWgRRIMQj4aOm1RgaeKAHHIeyp4em7SNvT6Pa0PkW1ugg2T4OvvKxk3EDWog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=JI5Eomh1; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=iX9bCqZG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=JI5Eomh1; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=iX9bCqZG
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA1E260606
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:40:02 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8NVPF4031198; Mon, 19 Oct 2026 05:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XaYRmVuFK1dy9x3Et7LvqSzJPvi9vm2YYI0RirWJe
 eI=; b=JI5Eomh1Cz6nFGHSNmhgaXFRtvI9Gq3uvo7r4sHV2ulwQho6nwNo8jmGy
 EwsnUSXTY+C/Kk/vvwf/RrTR2LYcWJ6w3T0L/9Fzl/W1DXSJ8qk+46UmYJxvRd2A
 csmSA8HdnpuI6hjmzAe0OghSBXKZfOvSREUtDKrIYPq00LyW7jnP7RSyKgJnH7l+
 e3pOdo1ibJITovJGy9sgZcjHHIOvNnuLyxhAtj5Wt3WQs5XvtAYfv7Z2/4ZSEQ+/
 Inl3cTBlfWl4tV91Q9WkukIUXHVdwlootc3L5ItYirLDUCUPjJyo8rtuqr5HvOfc
 +Vp74ustd7EcxEOor2OgP6GRF03GA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd5w89h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:39:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH81nqGfeUfqZ8dQ5I4rkBg/cUeuXQjTwN7ph586ss2lGYN8RbgVOta/ZHFkrrfXfvjOid18Twu3rT467QG6wC9nk+Fca8eH1THUkdAHbSufMsQJcTLhEdOVi099QDoP4UMSzMMDw6aNFT9vsXujG6VPqy+2u3DN5BM+rhgXekmAoaTZTAEX/GaAWCClZ8Wubi/Cewui4yS6CXpwe8cihVup1SDTFKygeEibLjcEyupUn/B3QpNComtaKkW2lNASfh85IUk7EeB6F6nUH1ynVj49gke2WQ0NXLLturgxl3PWNCX7Fk9xSAkBkwaIfs5FGQ8b6/UlZXkcE+8+pyQ83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaYRmVuFK1dy9x3Et7LvqSzJPvi9vm2YYI0RirWJeeI=;
 b=R2V3KnP0j95CxhSg9H1Ptwv3yDXaCswTYmBfxAQs9t+XpwzA7Y+ETyK6r7xbfWa3gR8Xgl9U9ZcIHiZOirKcnKmaW5aCRiyvVleeSgOgVAEH9U3JnaRdHGTjSXgPxvB5mGNBcxuFnOaWPxD3kqYJeZNtMk44aCA9W8p/R0ZTswHdKGCRpuojvsph2RyyEzTwdQhr4TNHoUta0dUVcPMypjiYqSt1W3BLULzYDXHDMoSlAhjG8IiB7Oy9Sbkqa7wBN+uD2d1Q3IPCqs3rBdpfHQxnwdVUUn9E8Zte0RGKzCByI1iS1pkNV6dsSRfQEYk4+fWULpDaGbPxuJlS54iepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaYRmVuFK1dy9x3Et7LvqSzJPvi9vm2YYI0RirWJeeI=;
 b=iX9bCqZGAsDwCOrBpJlFlXR6e8cH16AJeGC8OlGme4AhugLib4LTXKudBtXsglW5rV1BfxtoHu2hY4AKFwr0MgiqE/JozhIrGKmzLg2BtZF22cNN350GFLloK3ziEZVEjmy+27l1qyJ2zKNk8Va9Svrcad2ZKaNbWnyxKHbP7Ps=
Received: from SJ0PR13CA0142.namprd13.prod.outlook.com (2603:10b6:a03:2c6::27)
 by CY8PR10MB7268.namprd10.prod.outlook.com (2603:10b6:930:7d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 10:39:55 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::58) by SJ0PR13CA0142.outlook.office365.com
 (2603:10b6:a03:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 10:39:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 10:39:55 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:54 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:39:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:39:54 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTi2629975; Mon, 19 Oct 2026 05:39:51 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 2/7] arm: dts: k3-{j721s2/j722s/j784s4}-binman: Add
 template for packing HSM firmware
Date: Mon, 19 Oct 2026 16:09:37 +0530
Message-ID: <20261019103942.2497201-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|CY8PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bc1095-f491-4e42-db27-08df2dcd507b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10063799003|18002099003|10067099003|22082099003|13003099007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: WLVqpuc5E1VRw1yv90/LaORVMDusmqVqLzHnNIyKoGWpz31eyfsl3uPXA2sV2nX5daM3T4gaYPMyMzE9KW6jOsYi+M9nZBIOyy6tvkRv6fK8Hgaum/rTYj9AnbBa1vp3iT0gHzuzWO6nZao4QrNDveEi2H1NfvN5Fvj4PSEd//apGFZqE3+T2rDXIf8eKHtNd8IMBXv6hCGLmKCBGFOm71EXDo3dxhxUQAl0gv4V/yslxpKBRFZKn/uQdf0PreAToVtdBaLUPb9YqYT91GlCzwW9kqcz+tc9ZQF0iVeRn9uQGgartXaGaC6/hayTI56xF+KK+IXM5Fqtf51+Od9IWIVq1JYTcuhs/OBOb68PoOW+Y+tLVxL61XGVp/DmkdnpHLzrraYiItyRNImxVQn/iRZR7f66BST8XyNCf1VPSxtRP66qoe5GL+C8I0Jh+lSTKFCXi0D/um3MZVIw40nqCnVfSJGuZb9BsSw+1FieOJM0aN6LGEYJxHw/klXDW8DO5vMWTCxnNtTxWGnhmakiwQoGyOhm0HjPTJNhiQH4D/cf8wvMmZJ6kDZzjlO04CvUC+mIgf0DGlk6AZjzRZp9fNqnr0xziqZmLB/jGDhZYx7ONynciE2/gA6K93NHIZjSbRjXT5Iq6OjU5qUWMgdL/kYV0cQffvMGCNxey0MhUTo=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10063799003)(18002099003)(10067099003)(22082099003)(13003099007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fYxWoh+uyOBP+aslzVj5AN/JBG9d6IeoROAjULZkJvAohFQIhHNKUASUognXQObiE8r/wKGYB34cTvYz0+bYis0k93/q2DLmCE656axFMeMV4wGovMVfXLxvH7qs5M0qZfHm9Bzm/H21O7gZiO25zMeCFThOIj19cW6ZKyPQfdLkpHi54s5fI5aDEu+6eUfBS6qfgZMZKbDmSaMKvsnD464phOo3Ht/ZoYTHwo1eLJOMCazXBovvLC0YSnrXl714IX9vw1SAoRXiRSU5P8GuiVZjo7tf/uFrq5b46JFyWyJmDNkcMoLi7afZQDAI4NBVHfI9Gza6u1gO8sGloXTVD5e0MD8CvN+vZ2rvZ1mVNIsaIPmwO2z3Ly2CHX81SfINMzWO9w3Gy0TcHN6GCno5M6rS1kAmkn+c82o1fdzdZw5Kf2TzVqbXzSTOnu1Znxyr
X-Exchange-RoutingPolicyChecked: tQDKC47P7y+gn2IGPmHRfuoiA68td66vpH4RO7ZZOHsgi0H/yfGHCTtIUBTKg/fsk3cLwOY8/bAl5hR1TPb1aMGHNCsnox7BJYj0jFmGH34in8fs4IMUkn4FPnzMsDEft/zLn6RrL6F4x3Twk8QQRMPRJXFWAnVroHXE2HmNQreMbrm6ghpR7sgGrqeSG8r4uXz3jvRxQsk0w/nYYHSg9u66LZfVIC/05Mj1ZFoMmMq+nSPhGOjtLoTAj0VK3eLOdWFO+vPZgm2BfxWmeXFkTyAaRMCDoMfkWPenoZhlWZgKSLQsg0m/cHfCST0JSpDrYv/9J+S9L1BDymjmJ2ONag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:39:55.0444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc1095-f491-4e42-db27-08df2dcd507b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7268
X-Proofpoint-ORIG-GUID: ipqYIyOlsPyg-pOjLjBVdIKRwv5eEdO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfXzs3W4eNCmZZP
 qglBQ8tVpcxUuaUwIKzR8R5T7q/2Adxt9GMVK7hhIjEIAuCOFzQ8JZqxee5QtmfNX1iyG20hAOv
 q4++XhZHfnqLlkykQVVYDWa7jh5rFd5qtG3Q9NgVko+W4Q3muJthViKlu5KHByb3et/5n/GOdmt
 z17sFgX0BKTki3wyM6YYcwwbf5PJTZ5npU0Wa/9OcgaEpMgCMYEvJo+aQiFipvFfQkl1fbuasXP
 aXGzF4+9X7EAxph7Whk6T5bisc4Pbz/scQz7AYIop4d8yuD5mZcQalsQ87PA8hl0kOcG8LB4PMe
 Tg2q65addAdqKQVqybx2MO5y6yRaKup4Hh0OEFmnCEp8tDX2jy6DO6MPV9qXZS/i4i3L3Dl7PQ4
 QQ5YpnjMEQ5hk2qvAf2MwvplvR5HP3QwMEA6Z5OqPuc2uJJcmlxKx7sTPnq1tHTQPGkUsb+2116
 QMezAQJC25ixSufIOng==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad5f37f cx=c_pps
 a=oYvfaNmKcCZhiE/ts8qH8g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8
 a=cm27Pg_UAAAA:8 a=Km_S4n7QHxOTcXp55K8A:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: ipqYIyOlsPyg-pOjLjBVdIKRwv5eEdO8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfXwCiKb3+atzl7
 FQwn2xo30BJCnp1M9vQXe9xd+ggHBng01iPrYQY9o13b0FRWdwbYLgrv12BfjyEjhTW9F9oLAmV
 UxOYX2uLph0XaMXUDpz8gkTDtjtBX24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190042
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

The HSM M4 core needs to be booted at R5 SPL stage so that it can be
used for further Authentication and security services. Therefore, the
firmware for the HSM core needs to be packed in tispl.bin fit image so
that it can be used by R5 SPL to boot the HSM core. By default, point to
the firmware for HS-SE device type. This needs to be changed to point to
appropriate firmware when using a different device type.

Add a template for packing the HSM firmware in tispl.bin. The template
also contains necessary fields which will be populated in the boot
extension and load extension in the x509 certificate for HSM firmware.
This is required as the HSM firmware needs to be signed before invoking
TIFS to authenticate and load the blob to HSM core.

Note: The os = "hsm" property is matched against
image_os_match[IMAGE_ID_HSM] in arch/arm/mach-k3/r5/common.c during
post-processing. This string must be kept consistent between the device
tree and code, as changing it will break the image identification logic.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v8: Changelog:
1. None to this patch.

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-3-b-padhi@ti.com/

v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-3-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-4-b-padhi@ti.com/

v5: Changelog:
1. Squash [PATCH v4 05/11] and [PATCH v4 06/11] into [PATCH v5 3/7] for
bisectability.
2. Use hyphens in DT property names.
3. Update commit message to call out os = "hsm" matching criteria.
4. Add comments explaining DT property values and add link to ti-sci
documentation.
5. Use whitespaces consistently.
6. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-6-b-padhi@ti.com/

v4: Changelog:
1. Changed phandle from hsm to hsm_fw in 'content' field to match with
   node label.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-6-b-padhi@ti.com/

v3: Changelog:
1. Added ti-secure node for signing hsm firmware image in U-Boot.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-4-b-padhi@ti.com/

v2: Changelog:
1. Got rid of 'load' and 'entry' properties. Rely on U-Boot to set it.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-3-b-padhi@ti.com/

 arch/arm/dts/k3-binman.dtsi        | 26 ++++++++++++++++++++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
 arch/arm/dts/k3-j722s-binman.dtsi  | 12 ++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 12 ++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..af752619255 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -297,6 +297,32 @@
 					};
 				};
 
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					description = "HSM binary";
+					type = "standalone";
+					compression = "none";
+					os = "hsm";
+					load = <CONFIG_K3_HSM_LOAD_ADDR>;
+
+					ti-secure {
+						/*
+						 * HSM (Hardware Security Module) core boot configuration.
+						 * Refer to TIFS Boot Extension format specification:
+						 * https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/sec_cert_format.html#sysfw-boot-ext
+						 */
+						content = <&hsm_fw>;
+						keyfile = "custMpk.pem";
+						proc-id = <0x80>;      /* HSM core processor ID */
+						flags-set = <0x04>;    /* Bit 2: Release processor from reset */
+						flags-clr = <0x00>;    /* No flags to clear */
+						reset-vector = <0x00>; /* HSM starts execution from address 0x0 */
+						dest-addr = <0x43c00000>; /* Load address: HSM SRAM base */
+						auth-type = <0xfd00>;  /* Upper byte 0xfd: HSM host ID, lower byte 0x00: Copy to dest-addr */
+					};
+				};
+#endif
+
 				dm {
 					description = "DM binary";
 					type = "firmware";
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index f79b3e543ae..2b36b04965e 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -268,6 +268,14 @@
 
 					};
 				};
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -300,7 +308,11 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 278b7bfac7f..3834d081c30 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -117,6 +117,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j722s-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -153,7 +161,11 @@
 				conf-0 {
 					description = "k3-j722s-evm";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..ac12335a84c 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -154,6 +154,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -188,7 +196,11 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

