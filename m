Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057F0C55167
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 23:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D63340D01;
	Thu, 30 Jul 2026 23:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0zmvoOpLVPd3; Thu, 30 Jul 2026 23:16:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE45740AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785453368;
	bh=SbYCzCFinOv4fq3t2eNUSPInrO6M5NURnj8BvfxiZUQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uYlpy5qvhqSbHfRKgs9vTF50r+mb8Wc0THnD0XlkhXj3BVKmacRzyNy3jJpuCpb+i
	 /657Ku/QwxLSnaPJDt/AtE3JBGoyHo4SK8FP0IWTfYJs44NOEH0zOvL+Pq7v3C6YDA
	 2iRVNv1dFUMFgWH/a3QQO9oaHw0Xk/T8lzw4y8TGkaYrWvJEVcGY67oPLxzwO4LeGx
	 HwHJYruyRlsy8ah5lB4u/6oQwtCWkftz2Io4AVGVD7Uvej5/9rtqtjcoB9JPY2D/UV
	 F3qSJglzpmLvaUzG3RilvZhkuKX22nFDp1I3S4SKju+HkjegnzJtMnc3tBjKcYo9S8
	 EiauDxxn59ilw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE45740AC3;
	Thu, 30 Jul 2026 23:16:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B084197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 23:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40B0680F00
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 23:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ylTj6AVCNVE for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 23:16:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F28A680EFB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F28A680EFB
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F28A680EFB
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 23:16:04 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66UMsbWb3893011;
 Thu, 30 Jul 2026 18:16:03 -0500
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by m0384305.ppops.net (PPS) with ESMTPS id 4frf88g99r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 18:16:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfT/VfzjGXcJ2EpD7tEnlFBDvBF/7jbNKKIa79KbfOqeBLMYdajg3AUo4SmJ9nJI/mCmLRIwzF1IzmlvfQmRH1yt4SJcNpj3PCHBYpmBI1n9di1Fr0CAV3s7LpyLqdmhXIFwktw0bbtJIEgsKt5qmc5iVAYwTIophuwv+MI6/0UAlWqMm5G7NBJ0b63/ZBnBRHBEcemqFA2Cdr7Zm76oWQ+C2wHcNJK26PZ4OHnnlN6zsexoQcvwdt8ormUT3UeJHIRIMKy/fBVOHba2+HBvtfCgp+QmVv9JQ4wjD8aDPQrGpnJ9Y/pVMh3ENYRnQCMSxv8iMd1JsDmvmi+oi5VDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbYCzCFinOv4fq3t2eNUSPInrO6M5NURnj8BvfxiZUQ=;
 b=k3r9T2b5K9aLxag3PvFzbq1RSADPqB1d3YiVuXkD720cBxGk4ApqVBS0pRFpZKBNxPGLbMGmSwc/FVwF+UkH/GpaTsz9vmCEwwT543UL/NOdAaltWDgBc2gRjPjv3wjk66VTU+hrlwKTM5+8yns2HLOk8EATEuwBSAVqBb1zr7DRuiyO+4j/hIYJQS0pf01ZfCwc/fAAjBSEE2MjMfOIgsWhaLFqiU22FfmuOP9ODjHmXcfpXckX5roqgreMkCVHRBrKCdV2LYVg0cKakPKBISiWb7cjQJ0koFlrv9eSdF5z9os6BQwVqxMpUiDlp/1WfelnOhlZJC649YTwQptAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from PH1PEPF000132FB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2c)
 by PH3PPF0C5C46881.namprd10.prod.outlook.com (2603:10b6:518:1::789)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 23:15:58 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2a01:111:f403:f90e::3) by PH1PEPF000132FB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 23:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 23:15:58 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 18:15:55 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 18:15:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 30 Jul 2026 18:15:55 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66UNFtUX3591150;
 Thu, 30 Jul 2026 18:15:55 -0500
From: <rs@ti.com>
To: <nm@ti.com>, <robertcnelson@gmail.com>, <rs@ti.com>, <sparsh-kumar@ti.com>,
 <afd@ti.com>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCH] board: beagle: beagleplay: rm-cfg: resync with am62x
Date: Thu, 30 Jul 2026 18:13:40 -0500
Message-ID: <20260730231339.1020610-2-rs@ti.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH3PPF0C5C46881:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c898014-d0c6-4c96-ce3a-08deee90837e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|3023799007|10067099003|56012099006|13003099007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ScgBAJHilllv8qE7BwRo6Am4LkMxJuFuQQj8yoE1QDpfPHl1/EX3/7jV1S8igQBnSEUS8CEPB5CBJhzLgyNZy6c3V/LlPDHoehVpA3KapdJVekn6dlS8ckeOm0jSkxTsXJLSH3V69EkpsN17+kOvfWtUY87y721YOcP4VaATdakOCq03SVL7vlADpe7OfdQw2Weh0lstLAgCQgBCIB82AfHhKEt8iax0Fc9NHQUdKTIiNQ/kMAtKXdbOEXCRCSPZ5aqFRxjww4qKZVgB0lzeWykCFKWfCVNpJlrvIqjnvkOaXkoa5vheo2E9LdXOQ1FGKgLP9I+UheGX+Nqnc9Yivy7WM3qE638SQSveV34YqABwMzjUA6aobsUCq9GGjoRs2SVNUJ24jEksGgsVvFwl5aJ9NnxuUnouaadElPx3LELNnIzI9nPl0xYuRNrBrW9SIIJZcsVNPk6Fct29+/8DxiJV082pvSI8pyo3VehG1O4MYGyQgsQSaay4pSlrUhWv4YbYxeK+Szn8uzgJ1Xi+G0sP1gcuuyqSAU58YMjaHeUfkdMxreLcE8ucviZ9CX+AKVj/uRlU49C2/bmcJeQWTCdyV+mGfT2oA4M7VpeOfhSYqPjWVLgH6V6nV2OzJR0ZV2QxcqcPslEHsZNHDeQuSg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(3023799007)(10067099003)(56012099006)(13003099007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uzup1+Xi27W7nLpsDe/az8b978+MtoPtOh/mYCCnZA0BiIbrpjfxFYK7qASW/0GDwmG70tk2DRVgIw2djGOeSVijNWL7PMQC1DsJZk2+r00N6Xp0ehnVMEf3xJdGfgXYFDrmGtqt92VM9Kj7eSn+aG2Ct1yUSM7u3mTLDQnFXs2x56DROupno2RGGGddmf+i7gNBfnxmBdw3k8j1xBFT0UFHJqj63I+9u9H7Uzc71tfZxQvIBSvsnOZrfFapHlqDcKyG+dgFZLMjzD0aYaheGOKRl77iUd7ftU65hH3DlGFlkCvcH/ZGIgS2axzkQU2ID2u2oqpXqoEH6zISKF8mdnamZdClA5xmfui4X6VRgEtr3BhVz0xPhKKxFerv80Bo116xFWsgPZFGcjoUpBAFqScl6UxiWuAQnChmFdBCDNkd/R4zhPP8OYTuVfeHvMod
X-Exchange-RoutingPolicyChecked: ahvZppBcmqd04t7Y/Ds+Ccs+/L/K02R3ZkpRz3XjNtm3oVd+5EKTNybxVY1MPC3d58ybqsXFtCVD81TvDPFfoKaVayrqnVSjWmOC4CZv4kLtYVoYoq9NqJh18qJqv4aqxVyJWTTlhTOJ7fnj5ZUsHTXKJI1wXF99lzp3QJz1XVOVP72lq87zAgX6ajZR7mpUK37IelTwOTf8cVgguMwDU11AogWAJ448YXbdRfnm6692mREEHQRnUmU6i89T9w0qgpdA7j4yI/j3DdGlFcf3BXz88iv4dJZY0IqtzFX8Qx38Ny3WlYZPsPLINVeszxEYl5p0sfPjYReCo9W3BA0WuQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 23:15:58.1287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c898014-d0c6-4c96-ce3a-08deee90837e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0C5C46881
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2NSBTYWx0ZWRfX9BJwTBnZ5xCV
 bc+py/RqDb26YT5CZI6KYJoCsgCU8NRiwdZLP/eTUlpTCv564kfKmRSclH0ej0m8sFQ636Q/cX0
 td4hl6vmph2C00y5SduBCpf1cOCACsI=
X-Authority-Analysis: v=2.4 cv=E5X9Y6dl c=1 sm=1 tr=0 ts=6a6bdb33 cx=c_pps
 a=yf4wneJBeBA4fm5+j3KMTA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=5OSrbQjr0cexXExiaJIA:9
X-Proofpoint-ORIG-GUID: GlgjvWn-W-rsREOKjUNzTvmp1M39WEJ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2NSBTYWx0ZWRfX3N03X1aTida6
 DZgCzFRVkvksbGf2CG4mg/AwArIQdQyqAVh3Nkxw0wlxKYfqDnf5ljOiWoy4mYqMduAoEeLADC/
 1bdRzuRCyEKZhx6IRxGi50hpg6KMvuhTYqEZH5DAFotxISpeJr5v3VBzO8sIJ+8IiBhAhszbSci
 uC9SSKvU6pwbd7zSvtyu59F88tbCZVsmQfLSCWhg6kwX1uuJ9gDB7cpvxt3mB2U2df8JCZ5+xRa
 OPDy53seshod4qBKn+p0RwjtKgo3w8mlIuokEruw1cDDputg6lquV77KUfW1NcviY45M0um89ue
 CP/7ucZ+8Z+h2r+Cqr6GW5e73yhr/p5Y3g1zgSnM94iFPE+29ei5YIX0mZHGkKvHbSD42jhPw0V
 /Z2NybPHQ0VaH8QQj8fXCjYMVqXcgEH+9VIALOA9M24By5cXIoeFf5x3JmkZsUB3zlC3L/hRaCE
 aRFYfPeULMMW7rJhjdQ==
X-Proofpoint-GUID: GlgjvWn-W-rsREOKjUNzTvmp1M39WEJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300165
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=SbYCzCFinOv4f
 q3t2eNUSPInrO6M5NURnj8BvfxiZUQ=; b=VL6ae52W0Aa8VTMY6F5IZlu+27/u+
 zMXZnBb8M4U1vSAy2mM//g8cdiy4TasjzNEVChyT4f7wpS3CAnq3KKEgZoyGZKP1
 A6bQEJ018P/yk0uo01mm8hhMWWAOwXogc6TB+tKPDsrJj1aTXwmTTRLLC1a0iE8p
 ruZeUePFZEl4S7s2ef9FMvgh/OBWS9h0HkHgJmMud03SceeNmV4GFOKfgaxLf74+
 XBz+Bt4ldtYxg5foqFLKYFxo2Da3kQ3JLlOB1N+HOJwf4LnvWIGERm0m74eGiXI0
 cqAdJAJBvieziY0dZ+8mSq9hARdiMlEhu9350TFHGoCHIcvjj9ZAxoAlg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbYCzCFinOv4fq3t2eNUSPInrO6M5NURnj8BvfxiZUQ=;
 b=qiFwHpnlo4qLhknTQPvlynFoc+vPaxFLN1bIWWHU6ptp9GiX5eNSTHPdE5JyjcmbdQ8m8Y8DdH++uHNfbqlqaF0uuGWoWhFMEI68mrHuHpmAkzwVAKD5DZx0UWQoz5HQj1UH2S45je1El3zenSkwSWgJPO8HnwQCBBxmWuyHRDY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VL6ae52W; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=qiFwHpnl
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

Apparently this wasn't being kept in sync properly. Commit 2a64978fa89a
("board: beagle: beagleplay: rm-cfg: Update rm-cfg to reflect new
resource reservation"), which was supposed to be equivalent to
7f9c2a6f7be7 ("board: ti: rm-cfg: Update rm-cfg to reflect new resource
reservation") was subtly different to work around this.

This file was missing the following commits:

87720385ab69 ("board: ti: rm-cfg: Update rm-cfg to reflect new resource reservation")
ef756f1bcd2c ("board: ti: am62x/am62ax: Update MCU GPIO interrupt allocation in board config")

Signed-off-by: Randolph Sapp <rs@ti.com>
---

The am62px/beagley-ai only has one old entry. The j721e/beagleboneai64 diff
though. That's a nightmare. I'll look at those a little more before submitting
them. Boot testing everything.

 board/beagle/beagleplay/rm-cfg.yaml | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/board/beagle/beagleplay/rm-cfg.yaml b/board/beagle/beagleplay/rm-cfg.yaml
index aa999c2ef671..a7035dc0bd91 100644
--- a/board/beagle/beagleplay/rm-cfg.yaml
+++ b/board/beagle/beagleplay/rm-cfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
-# Resource management configuration for AM62
+# Resource management configuration for AM62X
 #
 
 ---
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 960
+            resasg_entries_size: 976
             reserved: 0
     resasg_entries:
         -
@@ -285,10 +285,22 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 4
+            num_resource: 2
             type: 320
             host_id: 12
             reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
         -
             start_resource: 4
             num_resource: 4
@@ -501,13 +513,13 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 35
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 36
             reserved: 0
@@ -543,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 626
+            num_resource: 625
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.55.0

