Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD3AC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 946096073E;
	Wed, 29 Jul 2026 19:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8GozKBnpglri; Wed, 29 Jul 2026 19:34:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 815C86062B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785353685;
	bh=nscijIgc1qvTveC4dJpF4E9kuCOhVtpVQ6fUdvmCtko=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d3RmMbRSGP6OhGNIKq5ugoCYqFNCb8UwrZi3f8OXUPKT2MpkyEVWfXzXCzcS7YRAZ
	 /t7ammLVNwQiOhp1Pa9NzvC/H6w/a1WSTouJOqQ6yNNNbsAN5qhKQQvDOKkNGbL4UZ
	 NVNYcO6TaYF3Wb+hBPGPhh4z1kt3pc4xR8GnpezqJQTTHDwNqsiEs3qZsqrX0lP5nT
	 vlc9uUvGrH/nPOJjMuiHNZmMtzypm5Z3rAUBCDeoyh7uKXPMn/k1XG8rFedmCg++Jb
	 f83tgtMOrUV6E0A+OsWboSPR9gigZR4IVOiLCF2o3MiufA4TtnKwTlIWrQCbp4R1c0
	 rpkFj8frOCe2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 815C86062B;
	Wed, 29 Jul 2026 19:34:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A0A227B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C1B06062B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W9X_in0HFNt5 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:34:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DD5E96071D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD5E96071D
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD5E96071D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:41 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66TJAQwA680015;
 Wed, 29 Jul 2026 14:34:33 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fqqeq84tt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 14:34:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhaRzk3RoECBdm/vNO5MFnBMzaRRbehezArxhr81Wg1K2ZuE9eoXcKilBTdgKFhrdSFca2AHszebB3DZVZzimoTqqhbQozNEMPKw9TUS15Qi+QdNh9dtBzbPo4SUh8DcMyrDnF5N27Ezs8aqRUUod8bMqxUqUicDGnxm90nwT7m5YW/DscM4xIeQ0L131zz97fTsEBNxSgFFG1ET4LgwXM1+b1cwBEH6Cc7/aX52erbIhuvCmutB81pDKt9+PHkU6FUDUIiafshK7TsDC8E+buuqbdGrfAkUQl3GnM4q+GR6j4YxP+AKBr35f6HvWA5CvAp5jjS4bptvrIGVkJn41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nscijIgc1qvTveC4dJpF4E9kuCOhVtpVQ6fUdvmCtko=;
 b=wZ4f4Ia5CH6UgWywGDqTadwejeazcfOeucpgXObwlYrujpWsbt2/sMqO55bh/Dv04lz2NTN7R3MtzbZcsr7jMOsC7Opjy+VWhqFNiXAlp0hV9HMeXEOPeWdpK9AHpfFo8XQvOeBJSBpIrF9C6YlLCsGu80vIWK5F1525jClt8g7GXnHqENPnc8AWhuZxgEZP2W76vHn04Xo2MfWfbdnjADiGCwd+j2CesoBP9NwOjzfytR/5GdP1iTbhznPa2K4wXsJcuoNkaTwasF2mIKNN4PtZSHjng2gzNOs9JN5aCM6HyiCqG/iwm8NhGuj1TiJ0lxXPb+TrJKbXJKo+bs6m/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SA9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::6) by
 PH0PR10MB4471.namprd10.prod.outlook.com (2603:10b6:510:38::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.13; Wed, 29 Jul 2026 19:34:27 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::22) by SA9P223CA0001.outlook.office365.com
 (2603:10b6:806:26::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 19:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 19:34:27 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:34:25 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:34:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 14:34:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TJYPKQ1893221;
 Wed, 29 Jul 2026 14:34:25 -0500
From: <rs@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv4 0/3] k3-am62-pocketbeagle2: add board and variant support
Date: Wed, 29 Jul 2026 14:32:07 -0500
Message-ID: <20260729193209.798946-2-rs@ti.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH0PR10MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: d585143f-8d36-478f-3e13-08deeda8671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: Xfn+jO5DPPpdFk8M5xcxWI8X1nsQXT07KQw9AYvDS6SUveyjllRXSk+yeNKOCrg7GU5tHi6Lp87Xu3tntLY5eDDFh8bjEug8XEiZq6KszrBVSvB7Ve5hxqPYIeNKzAUpTQKqFaOE73FFSxTfULVwBh7b1uEP0vuOVA8tTAWId3bVG+JuZC7zaRK6gmFxUmB/T9iYvj1qAkET24oVu+jSFOG82VAbhjL0vmjywfZTMDabyhoNR9qc0yK7un7ZuGI2Li1bNtb1FnEeJZP+SvP9IqYyGMwmDKFsZKU4Bxp00VTbUndA8GjsmQuqDzusNwYyv/FgosQ5ouoRt6yFDUuVMjcIJAe/awp0k34VhCH3dUqZQ6lwt/n036Ul8W+LstlWIldW0FMSbzz4iNggXoOb3VeDrbwk17HNlffGyHNvxS8fCJqHpaZTJlvSYgY2lCPvnuniYDsqu9ic/+KiNZQdgXEVIv4jvLk2YOh/LJoybpSAVQYAR9mILgHwdYkXA7jBLfUeZVm+DFM48L/5blOriqZUbgWBmfSWNl9VqNjIrOKfgW+OyxrMARuZh8CKTiWoQ6si2NFcYF6PS3yiMvhzU14lCPIj1EyXdZFc1dlYPuIisG3rUrZG4LvrRMnoe9XukZ00ljlSRktkoYyCidjW/G968955oW3ZjfUnmLh2vhjqI3lMcPa7aG1M9/qtVnDZT+7Tf5Kz/JHcofKVha9n1g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pbhAlSGicSwVBCv+BLJ13HnpU4A/5RQ6KU5y41x4Qg8n+rVqO4eKE6Pf3aDEbqO/uWYSWazHzJnkiAKfL/E4W8KV/dtwL5fakKsHqudofLVzeq69HuJKD2nB3cd8u6eu9sM8Ne58c+K51jYypaRB4d5RKdZdUKNFeVp2lDGCR6gVs8iD+iQXDNDTUCtIJPtIPjB+kX/Kh3HalRo8zwzeQvwAGxuuy3TfR6uI0Rg6s5d6X7bVsoxQNQxrgoSc+mpcNMBLxNkFhSBSBS9jP8JPk+Xp0q33A/VcUtFyMrnkcIKzmfy5LfjziugdeA9b7+otinSiV//oRqxhk78Akq8CMhx9TsC9d93ANRev3wxkmqYGkzPWuuCe/uGRUwi1P2aGZE04hODq4XJ+jG5FBFk7GroYB4xNAjaGVexPUBwrOCFzQalW7gyG194eHECDXs/9
X-Exchange-RoutingPolicyChecked: LMiDQwfYQojRFYLBzGl56sQJSojYjKa68q+d7IqM/FzsqdaOy1eRdpQYH5ohD1mPfCDxJT/3Te8Jzt1gHo/xygHSC3+ol0goe9WN+hRlTyEUvP7ZjDSNOgYvg37eqVcY5pNOSFvAi1o+u19Cf58ZUy9OzYtliTWYyLVEG6zML+uaZrPAXZtTLOxYXm3QXK2LCM7Y86L3x051c6rU4Kc5WaXdyO+GxJVulERH8BYUOWeYnMURX6SbwX4Bcgq2y9m7OTw9DepzAdeGWzaQxLZzccoFNHfB53Vt6RkLkb0AX384ageqrnASa7gJ7UQrGBf2575xSqNYh1vUEEYHYBsOpA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:34:27.2791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d585143f-8d36-478f-3e13-08deeda8671e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4471
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MCBTYWx0ZWRfX0EfqabSvrmKm
 qeGJxZfbDE/svgdxq6vCNgocF3sEHuuK77iBW84ti8aGyn5gwhRrCY2W1UdZj4TB3+OKxSV2+rY
 fv+dOc+CUxBjrOLcMJTgCRQZe7sVIwY=
X-Proofpoint-ORIG-GUID: VbnPmhPpYD_1GagPA9K3icvP8WZBZyv1
X-Authority-Analysis: v=2.4 cv=EPE2FVZC c=1 sm=1 tr=0 ts=6a6a55c8 cx=c_pps
 a=AqWYtYKdvuqIQX7AE/aD9Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=fGhLjsSNAAAA:8 a=oX_uPFj6TbJlzFLWTcAA:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-GUID: VbnPmhPpYD_1GagPA9K3icvP8WZBZyv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MCBTYWx0ZWRfX1wluZb1tjMKr
 n/y4VnYWN/w2UdYv5R3Zi6/oNa2UucGyh01s+vxpGZtabLW/s4at03JsKl8varO6bjzv7lLazKj
 ej0h2Rb/VsNscwqfg9gDqY/aBtEhxKXrrGggYQFn/WIxItitNBhxj4aScPz6AtwmAl1jUtyUwh0
 uAEQQxTXN+qljASVmac5zA7KpVu0GwQSybcQm6QCXJgXrtLjox229/jcrRzyVagHw4ePt4Y5UCx
 9FL2OknLydV3cK5tGm2ayrOO/tS+2yMgbgprkWuA3N1OVFTh4Tbu/Y2LTJ1S1m421MOB87wCoEM
 0XIcFnePcawWsvVj6zvwgWXKeEKR8+2MRCi+dy3Hm0SqkW04lRfBIAPye28t72nKbKeBKKv3BbM
 itRdGF7qs5J55WWRMe/C/0Cm08uc20KwIzUItLTUR99PKeDZtXByG4fnCYGd98tg8SSQPlHuKch
 1krVIklYDUZeBVTYIwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290150
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=nscijIgc1qvTv
 eC4dJpF4E9kuCOhVtpVQ6fUdvmCtko=; b=YaUivw7p4o8SmiXpFlM6uTkwW+uSU
 xSRwu9v8V9adSedhGnlIKKB1d0i7xabXgpcQggyl40hdOu4iOJkl8TBYNkxk7rpl
 4Z455gi/JoJWRok2PEPclbDcUfgB2Eu7hacHVei9x3hODaXNVClD08BF1OFZisP7
 PmTI3ySvgBkysQjYaRo2JTl9wLXVCBxwWIJxqg5OMAxG03+RZDlTwH1nLva784Jl
 VC9cbA8yv+sFMx1Pj06gRm++9fNqvqWExYS6gN6pkVpkOZf543obaMmFsGSgEeTa
 iErhrfU/8jDVFfMwy/KgQsdvqJKKrrkmg5+lY4vMUSOaZEGeRumdtpM1Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nscijIgc1qvTveC4dJpF4E9kuCOhVtpVQ6fUdvmCtko=;
 b=rzL/6Mayo7eKxn7V33K2/Ud+yxlHcMHVGIC+JVHkcs5VYdyJ1WTl/ub3dn++JQoDx6XqOJIGuIp9IwvdqdRCWAH/5p07MFMh2wiCTyCzxfWtrAu6VQg9sqyX4nWoJYOyLbbQX4PiQAwsxvPQ5WOeCf4Y5D6zoxADnp5tmlIwjco=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=YaUivw7p; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=rzL/6May
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Randolph Sapp <rs@ti.com>

[Uh, I thought I sent this a while back. Looks like that wasn't the case (or our
faulty mail server ate it again). Man.]

Since it's been decided internally to follow along with what Zephyr is doing and
make a completely separate device tree for the 1GB + eMMC Industrial board, I'm
resubmitting v3 with the variant support patch dropped. We will circle back to
enable the Industrial part once the dt has been accepted kernel side.

See the following link for more information regarding that decision:
https://lore.kernel.org/u-boot/DJLTHZL0ERIG.JV1UL67GFIVJ@ti.com/

Add initial board support for the PocketBeagle 2 from BeagleBoard.org. This is
based on the current official series from Robert Nelson [1] and work from Bryan
Brattlof [2].

Now that the various memory issues have been resolved we can clearly see at
runtime that there's an issue with the current device. One of our reservations
overlaps with the u-boot stack. To get around this we'll need to change the
relocation address to something we know will not collide.

[1] https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2
[2] https://github.com/bryanbrattlof/beagleboot/tree/b4/pb2i

Bryan Brattlof (1):
  arm: mach-k3: am62: add &main_uart6 to clock and pwr tree

Randolph Sapp (2):
  k3-am62-pocketbeagle2: add initial board support
  k3-am62-pocketbeagle2: add support for efi capsules

 arch/arm/dts/Makefile                         |   1 +
 ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 ++---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 336 ++++++++++++++++++
 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 ++
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 arch/arm/mach-k3/r5/am62x/clk-data.c          |  19 +-
 arch/arm/mach-k3/r5/am62x/dev-data.c          |   5 +-
 board/beagle/pocketbeagle2/Kconfig            |  60 ++++
 board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
 board/beagle/pocketbeagle2/Makefile           |   9 +
 .../board-cfg.yaml                            |   0
 .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
 board/beagle/pocketbeagle2/pocketbeagle2.c    |  84 +++++
 .../pocketbeagle2/pocketbeagle2.env}          |  20 +-
 .../pocketbeagle2}/rm-cfg.yaml                |   4 +-
 .../sec-cfg.yaml                              |   0
 ...onfig => am62_pocketbeagle2_a53_defconfig} |  25 +-
 ...config => am62_pocketbeagle2_r5_defconfig} |  11 +-
 doc/board/beagle/am62_pocketbeagle2.rst       | 279 +++++++++++++++
 doc/board/beagle/index.rst                    |   1 +
 include/configs/pocketbeagle2.h               |  39 ++
 21 files changed, 949 insertions(+), 82 deletions(-)
 copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
 create mode 100644 arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
 create mode 100644 board/beagle/pocketbeagle2/Kconfig
 create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
 create mode 100644 board/beagle/pocketbeagle2/Makefile
 copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
 copy board/{ti/am62x/am62x.env => beagle/pocketbeagle2/pocketbeagle2.env} (64%)
 copy board/{phytec/phycore_am62x => beagle/pocketbeagle2}/rm-cfg.yaml (99%)
 copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
 copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (88%)
 copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (89%)
 create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
 create mode 100644 include/configs/pocketbeagle2.h

-- 
2.55.0

