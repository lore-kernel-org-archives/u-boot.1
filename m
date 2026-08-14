Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5622AC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 12:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4E3640C85;
	Fri, 14 Aug 2026 12:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wa1pdSH4g8Al; Fri, 14 Aug 2026 12:46:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7E0740C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786711597;
	bh=W3Kfw0AlSOKMWVEvke8Htn4/G/Hp3kyocBo4hJAZdDg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fp9Gms4IZs+alWFCDogDQCdopfgevQpHO/PBzRvJ9QjREXClZMvkP7TS4SAPfY1wA
	 sU/PZl4gBYLRBZnm3xZBDKaIHLYoJ+mKqlU72fZpPfENTbNP8wnxFpzso6tvu6AIk5
	 UHa9nln+BhPuU0VRin5utzXlM1/W9cwkl88RF/Oljz1vcY+ScnQy0KLJFzUEbTOoo4
	 H2g4oFhOsoNwjd/0DUaBxJbIgi6vxk8a8iL7Rgn6Da/wmiEqxplJNRdQ/3BgpALNoY
	 P0A1gInSSyYmZMWtYFsUsB8w6SrXblvU1ZB0I+CGEGbiSEEmr0hN2f3lt+jKcmU+T/
	 R+L0izwa7HbgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7E0740C55;
	Fri, 14 Aug 2026 12:46:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AA55733B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C5EC40029
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8hGqVwjaGjjD for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 10:22:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 602B540051
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 602B540051
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EYndDcTz; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Fmv63+/f
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 602B540051
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:23 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67E7e0a9935266;
 Fri, 14 Aug 2026 05:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=W3Kfw0AlSOKMWVEvke8Htn4/G/Hp3kyocBo4hJAZd
 Dg=; b=EYndDcTz/p9d/TXTGtwH+ztkVwBVUjJiONBL4+xsZuSVlvou1z/lyQUO2
 cKJTiH/GahDFshFMUhhyzuQ46ZjsHW4Cno+jvh+2tfHFK4iB7R5pkUCMZN07D16g
 544wXiCHYUuVhnfLeSeRXm48T++OMzFR7UyP68lT4wve20M/x7yRHLBdzx0zFFQj
 scxnb8U4sYCARjypL1k1Zak1imgKA193eeEscrheQLy+ts/WhvYts8R8O7m1iDyW
 y4rNZ623lGIYimc5JJIMSetLGg0uHSAMd3PsYxNl0P3SRhkz2vuhGXX2YCH7eixn
 osIFWsh8TAW5sDVkL9BAO8pAesyMg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g1xey0ux0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 05:22:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z49lDhMNqESh2+Eh5h92REVwIHmzbTggAP5Q3iNnjb2YV5pecGnxWWAU9fgsEuMD5A7oOb+agDv2VYsm8omaFniX40pgQElqWsOS//aCZvPxTDhyj0j8kH5hYM6+Nf2tXsSXenH4SYNXX9S+FFGIdp8fA6NdUKCqzzG/gKwALoT0yo3Wjk0uH+bfSJ3dVOvC3UsCYycBrrLisYWRHs/lo1cFoeHMl34wZ2qVL6P09GF4Hidi+8zBAGDxY484PEFsWdiD3RQDzROtwJdzf/6sp+LMy7CYiXH0j3gNH8Y5B2pQFWACTf7H5XplbJ+OWkMWw1s7kwjsWhMQqDcT1x3yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3Kfw0AlSOKMWVEvke8Htn4/G/Hp3kyocBo4hJAZdDg=;
 b=NGCMJCslLZrhsEQeeSSEZjm0UPm3gIcMBhYbRi43Bd+0R8OFo4piN/UdqD86qXBC2No1oMV2XmS0zblRaUdu/MHARafULq26pMBfUzNFy+Z/JTx77kMz8bmvneUwpDtHZQCLuNrVoQ/X+ZbTa67vpHnY6OJnEQ3aRGx08EWEPqlK3qxHnwpnpeGVnUSyQdfNoLdyROCgniNCnwgo8HCSk2wReLJpt5uzfj4jcnzCuMDd/z0kHcB+OQRBmxch51let/m6oVqhDHwCFw8XMo2MbUvaCzXWSQ1upgB6uvYXTuul/8k8hHHjduCtqTqZx97VR2UipZLvycxOZrGxJY51fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3Kfw0AlSOKMWVEvke8Htn4/G/Hp3kyocBo4hJAZdDg=;
 b=Fmv63+/fRka9cT7BhrJO4LDCffDZNGzAdrW6kjqTR3ZrxY39e0HcLyhQFjOLz62K6pRtIwVlriuixuNipf1N8AVPfYmikiru3ppvHNs2eusbOzhyyBO7ZUwkxI9K3Rkd371+FXUK+SOOsrwNv9Q/9j6RSv9kXAQGZX44WaFPQtE=
Received: from BYAPR21CA0012.namprd21.prod.outlook.com (2603:10b6:a03:114::22)
 by MN2PR10MB4255.namprd10.prod.outlook.com (2603:10b6:208:1d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 10:22:18 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::46) by BYAPR21CA0012.outlook.office365.com
 (2603:10b6:a03:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 10:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 10:22:16 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:22:05 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:22:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 05:22:05 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EALueS2569179;
 Fri, 14 Aug 2026 05:22:03 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH 2/3] arm: k3-binman: add tisemifalcon.bin for semi-falcon mode
Date: Fri, 14 Aug 2026 15:51:52 +0530
Message-ID: <20260814102153.44487-3-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814102153.44487-1-g-praveen@ti.com>
References: <20260814102153.44487-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN2PR10MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: df8819ed-eb52-4cad-42fa-08def9edea20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FgEEqKp3DHEfp7ckRthouOcMLlahKjGd0A2lYpMg709MYiZX27LiIzLUvZbpmpCsfqy9YntKmFIi7EPeN/XrHEZdBw4GR1eLXktftVTg72WJyZ7tdvw9ZVfutg57jyXkX4WkR2hVScwMWNVj6NwM/WapF1BkcKrXjmzcvhPj/UpTIdovatj88cGvzNyltaACAILo1sTVU3bfXiLCtlfpRNC6YngTsazFszMmBNJjkCbg023H/fH67qZYLNCra/5hRPeVvH02blXLz8wtgAxtal1uUMlEJCsewEVgOhdhdwMg691idJFvJWGswEh/WSM3xFgxMd+g6jWbuXZAdjPTz2fI+h5tKMpV4dHrPfFMmeXEPlH0rpgpuaU42k3UUz4ocIb1nSSEdFICvCucWf+kn5kzAlKs9Z/31rl/1+34Sg1F0Q0/mAmNmB27S7ysZzYn91D73R/HI/ce5zDA6scFqRcfeSP5MxK7z3qhXcf+4febRu3o545lNSqmmAE2WsnWeQ8Rkmmp/EpqbIc7KbDvrlao8xhYA+/9gYtZuTqWz1+vSg3v2fNQNiMbB1mlHHpRgWbemoNzx/084SaA2+5WfpLFjftqfBXyovXFApa0jiAwzU4EXTvY2RRz5w4odWMeC/KmjiQp/HIF8tDFLFVnfjmGyNbWpdnRsW1q+3v1CFZzfSMI/Cl9qOxUeWfQKzHsbNMiGHo+/LaVvR0fxP571Q==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q/dxrD/+UY4L1sr1KDPbLsCgs4TYoMjh9fcyOPOG68M8DOjQ3jUJ1offJ+j0l0ZjRVryK3zwk0g+sACAlmV3+X/bJRRojvF03ZOF+kT0qXa5Xd1NXQMWhE/s0S5zpomFT7a8k98jxuyDgP6X53166QDBnpOqPKIL64dl7bH9hrv45ChbVRBd6HKe8a3a3fuWyFJTzuPWoQjgCduih9aKmOwwo77ewpxn0Rw9O6VEOr8aewEQF2WqoaTRQGRIhb8jqPZOYeYZqD0k93GwTmqXTC/EyIQze4thrxQ52R0uvl9eQhqPHCOpf0HcmUHwcgNiZDsPBOo3/KCioM2Lry1JwPwR+czi5ByhqOg/ZWzkfoCENak5Lypi4tbVFOFxURmEo8JB/jkT8X4zoVdH/ukPTV6s3wbypegm/Q924x/9g3RaSCku1NhHTn35wI3m4BJk
X-Exchange-RoutingPolicyChecked: pxW9oFbOpRwemJ+xLfFWTAZLU91m+vgWjaSLGaDS9xSZHHTf6F6bC5D6H4ZnX36OeJrEAw2KhMEwnXW1spL1DTKnJPD9OYrbSQrzYA0R7EaX4x86+2PJb7WBpOIzP12DPTZm+VWfvPGCVtnPVFdWxOvIVaUNiTVY4U5aFoxRa6zTDA4p5Zjws63/W3xDgID5mK5Ft0YQiNulKW6qu1f//qfREuFpdik4uRj4YWfJCUvHdgOXHwYV5LZtnExnpwDFAr5vqNT2AAGPItbHqGNxPAHgT5G4AFkFii3EGyTUrQSOXR7otO80verlOCLsEXT+qdJLU30ByUXVocEV3x9qgg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:22:16.2427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8819ed-eb52-4cad-42fa-08def9edea20
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4255
X-Authority-Analysis: v=2.4 cv=F9ZnsKhN c=1 sm=1 tr=0 ts=6a7eec5d cx=c_pps
 a=YQq2SbcpNRFTj3qt8lmqwA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=d6pU8RGRqkria7-D748A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX/fcdoXaIJwut
 JlcCeDRH0qQ500eReqlsNjy27sncwSJemY87zu096zRBYGYE38nhtKZpILsx48sJs2Qfly0BFZ/
 jlpxGyiJOlk02f1o0X18U3MNNvAlzXU=
X-Proofpoint-ORIG-GUID: EjbjhZwcBiyuzKxatTGCrA5Q4E-vEzyI
X-Proofpoint-GUID: EjbjhZwcBiyuzKxatTGCrA5Q4E-vEzyI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX78jvVm5bHF4o
 smam3TMMjQ34OGYUuGJQ+Mv/QSHfwzJ4z03xrLtjPK0B/I/xL7mlKKY3d7KeyqgU5UNT1Eyv+29
 ttqc8OuCbDJAQD5cp2QieskMgJrbmYlBog2hXGtdQZE3wF26yn917KEPSuyvzcSzGf/Bk1HtloA
 QY3VXxqvPJt8mH4gb/Je387K0veIO7yLkTfk9PbYXlCKP0fbDcG6cCWET4d23WnBbNtjiFKlJP8
 /u0Tzo09yzykRCxiSNh/4w2V0O2Dfn4/Q+VvNJuJuUqape+ANloJ5rTXrblDYDxXdYHydjga1Lt
 anIdrhHpnRJtQVknHngApt+T5R37Seg2HuYYg5ATuVRbsdgNTRKT2rpOpvnHvGVVrj3+PwHEPbo
 lSIi7tJfptcGXxiLhHal3tc1adCIO6c3Bnj9LbsBWcGK7UszMm6Mt5ZsLVgpRni/lylqPDO38xQ
 EV58YV05q8bXiswhLPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140078
X-Mailman-Approved-At: Fri, 14 Aug 2026 12:46:31 +0000
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

This patch adds creation of tisemifalcon.bin for J784S4 EVM.

The contents are the same as the existing tispl.bin but A72's SPL and
the FDT have been removed as they are not needed in semi-falcon mode
and instead UBOOT and its FDT are added.

This reduces boot time since A72 SPL is skipped.

tispl.bin = TFA + TEE + DM + A72 SPL + FDT(A72 SPL)
tifalcon.bin = TFA + TEE + DM + UBOOT + FDT(UBOOT)

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 Makefile                               |  2 +-
 arch/arm/dts/k3-binman.dtsi            | 47 +++++++++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi     | 65 ++++++++++++++++++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi | 14 ++++++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c6253670a94..ce2501602f4 100644
--- a/Makefile
+++ b/Makefile
@@ -2556,7 +2556,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
 	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
-	       imx9image* m33-oei-ddrfw* tifalcon.bin
+	       imx9image* m33-oei-ddrfw* tifalcon.bin tisemifalcon.bin
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..d82b8630554 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -543,6 +543,53 @@
 		};
 	};
 
+	ti_semifalcon_template: template-16 {
+		filename = "tisemifalcon.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration for semi-falcon boot";
+			#address-cells = <1>;
+
+			images {
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+				};
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					tee-os {
+						filename = "tee-raw.bin";
+						optional;
+					};
+				};
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+				};
+			};
+		};
+	};
+
 };
 
 #endif
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..d109b3d460c 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -317,4 +317,69 @@
 		};
 	};
 };
+
+&binman{
+	ti_semifalcon: template-17{
+		insert-template = <&ti_semifalcon_template>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+					};
+				};
+
+				uboot {
+					description = UBOOT_BOARD_DESCRIPTION;
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					ti-secure {
+						content = <&u_boot_nodtb_semifalcon>;
+						keyfile = "custMpk.pem";
+					};
+					u_boot_nodtb_semifalcon: blob-ext {
+						filename = "u-boot-nodtb.bin";
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
+				fdt-0 {
+					description = BOARD_DESCRIPTION;
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&j784s4_evm_dtb_semifalcon>;
+						keyfile = "custMpk.pem";
+					};
+
+					j784s4_evm_dtb_semifalcon: blob-ext {
+						filename = "u-boot.dtb";
+					};
+
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = BOARD_DESCRIPTION;
+					firmware = "atf";
+					loadables = "tee", "dm", "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
 #endif
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index cc0b562d27e..d22cdc09a7e 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -87,6 +87,20 @@
 	u-boot-unsigned {
 		insert-template = <&u_boot_unsigned>;
 	};
+
+	ti-semifalcon {
+		insert-template = <&ti_semifalcon>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
 };
 
 #endif
-- 
2.34.1

