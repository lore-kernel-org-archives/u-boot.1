Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1D3C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 05:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3D2260809;
	Tue, 28 Jul 2026 05:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BytBECQ0ioep; Tue, 28 Jul 2026 05:27:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5136607FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785216436;
	bh=+g2SHbI8bJZB+1ZSMJTMNdqI5RuE+WhLw9fFrD7bLT8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VX7D21NEYQfa+AaQNIDlsZWQGKSpYkgzZDHQCTm5a1TAPs4YdGFxJZHaHJ5mq5eop
	 fwMgY72cQunAOw0xQFKxYon+ln6JWd4ZouSXWTchuttjh+LgzTS0Z6MvkYBbHNKJaf
	 tam/ngcpMvlc+BPzixJx9pEukI84kHMnZff4opBrQtS88ir7FI/amruXwacUt/K+zP
	 1wA6YKfwKwtZMNYczqfts739c9hBSEoqQ0XId5fov2Co5+I74b4JAh3CkdN0ayRCF0
	 b0rjG/bMN440LgJRK0tvejJm8nrwGtEYXAD8Kj6YJPcfAENXE3XxwPif/D8B9jywrx
	 bLLqcEOXWjC0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5136607FE;
	Tue, 28 Jul 2026 05:27:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32C37357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3076E607FE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:27:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZeZ_mcYajEo for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 05:27:14 +0000 (UTC)
X-Greylist: delayed 580 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 28 Jul 2026 05:27:13 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0F59B607F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F59B607F5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F59B607F5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:27:13 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3YrCQ2589853; Tue, 28 Jul 2026 00:17:32 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpkvtgnkp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 00:17:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwBF3sTIm4pv3SCV8hHtMPWTXuG+TmwzQU1GzE+HQuzpGlzaqdiDMP9kYnRcNdPUqbD7GFNz9hfgcf4rHkb8Ue4cs8o5MWi2n3+w16JNiSSIS1+U0HAnqGpc/0EYtVNbma3wzPb4H3Xr0iiDcLkMPRdQMItmweuC1/5qOQcydt1IYFSbXpbiEJFKj7Get8q0DkLU6FwLtHP8CLpkqpmV18BckLL2IRvDNYlQVe+J3eYZmZWko+HSO7zgE8FktvRZlRxBUd6EQeVcoV6x7/ZRiNsaFhfD8u4yXS0RpsI/ujKWUjZRh89Ee9O0TxsnK1fktsaOO+Y8u3+FIVICxX4oQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g2SHbI8bJZB+1ZSMJTMNdqI5RuE+WhLw9fFrD7bLT8=;
 b=Vqr+dytxYpcpWypybkg+uZGmG9v/yELjcg8PB5Cbrw/mhgwDZEugO0pybBWrUwm5QQejgg5MeRcgOccq8ycTcqj4aNCpKsr6Iwt8tER8pSRzVHfdGqRGBpZImNn8kh6F3H8bHuYuThv1uJESeU1lm6nUHxHFX6Z3r/eyeKdoblnk/f1fxreFvDqlJxyF4xfH/qk/8+gjb/jzDyxHqomfDBtZ/5sQ4w0yG4Kz4wq45eCY65a11Z3BWtuMI6stUlvYiOPR/S9Mer9UGOv2D1I5qm3/79Q3SJpKBKvPwPkey/O0OqVui5q+NYz/klFiYtwtMH1yBQkB0UOCHenC++P5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=prevas.dk smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BLAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:335::22)
 by CO1PR10MB4546.namprd10.prod.outlook.com (2603:10b6:303:6e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 05:17:27 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::9) by BLAPR05CA0042.outlook.office365.com
 (2603:10b6:208:335::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 05:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:17:26 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:17:26 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:17:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 00:17:26 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66S5HP9J2611016;
 Tue, 28 Jul 2026 00:17:25 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 28 Jul 2026 10:47:18 +0530
Subject: [PATCH 1/2] cli: hush_modern: fix negation during run_pipe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260728-negation_fix-v1-1-c8021b2b74c0@ti.com>
References: <20260728-negation_fix-v1-0-c8021b2b74c0@ti.com>
In-Reply-To: <20260728-negation_fix-v1-0-c8021b2b74c0@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785215843; l=1050;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=M1xloPpq27Fp76LruLcw/9Q2FORbMDDUa9Muq5WEKCA=;
 b=PT+Lt+ZlC/gBW8borDVp+BJVEynOy8e/v9vLDbZMRK2vWXTgFQcakGgA2qpeV6kkGUoxxnb4X
 TgRPvH9lXJ/Cu1aXvXoDQZzmtTGH0XCEQlelW1iafr4typcTGbircjo
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CO1PR10MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: d87b3b2f-a188-44a5-ff3a-08deec6783c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|6133799003|56012099006|18002099003|22082099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: Ad2WHyCc1AasFyqHRpRE56DFA2FkY+JykkYyuSajd8XvPvt3t+KO7xzLeJPi2xMw1BXL1fsYOn6bTVjPiktwjXo04DljavsjuOhM3WK1Z8yI8gFYMDL168dPwD/2JEP34M83VSZtrp50lpQfQahDYsTjFIOwAjBkIMk/Skzc4Iwx95K8FHI8cnUmbbow4rsuhjTGQKnEZUb6modefOFtYJa262ZvhsX/NIt/5PIHJjy9wcaaURD26H07CWXmnMATs6gLWaj/Y5bC1zxahaHMr6aVCKjAi2ek983K8xrGozM+eLVufcf7oQZ0LSQ3TaM6JIpFEnY0W1Br0S3poEI7HQHDYHAZipHsKDqWiF3JLWay45U4Z/VR4/BoESV171/Nqnrwxd4s/Pj0IFCWCu/5ldBne7fo5I98yJt3OE7zlueGWdZohLUMFpPZ80nzr/V49vYudBdhdVp1qnEjL4tqBPpeTnsTLnxdgblEpoAOR+LAF55blBmTrrz0R/5X29IISKYfzHZqKZwZWzSyCQLDUVCxqLQU1U5cGJrX++kcEj3wbm+q7FzyPUB2mDj3O1Adzi9jabLjSs6CMv9aUAhKqNu81zlcIumV/w8KlUGaRceGM4+3OuEPD2vQvKn3oCYGKnGbYDCklXxOXUOOHu4irj7QPvijiXYLDWRMJwYYH2c=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /9UI+IhAaBpAPjlrEtGjsTdGvoGeR2kUcNpyf7/JypKcfP34ouHONQ42FUAV1ww5AqnY2ghNN3jo2CdpMTuflXT7+0654vZWZu2gB9dsedLO5BB0wYB6S3yOWJEpZyHLBgdA6oyiStgmNBqFQ8kgqZBFU/qa5X+uRa0HxNPyzTcUQ4lyWGU59AFTYvOy2rTNQfCP53xAVez/ZTnjYU8iw/FblaEavF58Ggwem7Nn68NfDL0IolharjGUUfSLeDVTS/USjOaI7IiyO5f0lkm5WaFS8aJY/XSIxoreY94c63HGG+m4ms5D0yelDCfbTGvCJgdy8qCKUu9oL8ERfSdTsNN5BwsqgCMc1CmrN3yjMXM8EsPQ03c1usSCpan2lPWy22tn7odutFUne1SMfNu51LgC7PpA/9JkqSYrXORnBerxMZK0B0tAPxNBDm9NGYzZ
X-Exchange-RoutingPolicyChecked: nQ5ktc/y3ff6FmiTf/pXJrQV0k3VgAYtQ1j31cuiteoWm4npvd0LiH2v85oanM4DrYHxdSyC2n49G5r8FbDw5pr4TAtmKegIHZc/z4TsiOfR55O8Yv3nb2HPRrKLMFl1H4idvMltjxus3CwaeSDkquuoy/5SgEFMLXQp0Ltx7h8xHQE8mJoGm16r2lHYMvv6d5vmSb+HMnkkTKQvEswtLIlOJuu7Ul43HtJLWFkG3SEI+XHJNT8MBCLeuc5ASZfD5f5/8uBUQx0DqOQkYWjkhuKDJOLC/UBSoUhrObdusr/rzF4lpmPpiOG0PwQunwDQjAAnTywL4+pA8kBQ+SeZWg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:17:26.8312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87b3b2f-a188-44a5-ff3a-08deec6783c1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0NSBTYWx0ZWRfX4xmxY68Br+ov
 Skadcd1EUZTSoEIwj7OoT8JVFe0SDplZmJJiX+uWH2ZTXCj/ogtBn5i75S9H43mSxpIBYrR/4SK
 8c0KeF/pB0+RcwkNSoulMeqq104W4ow=
X-Proofpoint-ORIG-GUID: YLN8fPZkkTIutbQDmoNPLueyIbYSkTwo
X-Authority-Analysis: v=2.4 cv=W88IkxWk c=1 sm=1 tr=0 ts=6a683b6c cx=c_pps
 a=oJ9tI0XfeScUaspqi3eqJg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=mMrDTT1gzlvVaODb3v0A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0NSBTYWx0ZWRfXxWNoez0WcQ4A
 fZsrVswfbK/NeKBQGK06sJnQx3zKg2Pxijzv0xdv2AbHTyYPDPGxU9GMtLFTAaAqZJqFPWCelYj
 aEmdpjKtFqtFgcHwyiaSw4P6PiKaEXpn4pUIwF+qQ0y5kUUcwSDKCkaOllkYaDVzYozMSsQ0b6q
 dWH+y1xO0+LlSk71XccwAoFNaj2GI/yq0a6Ypb0jA1CAMQkYsBF0pmA8VTZfbWCyBl0Oehbny9y
 A90YfGdnLzH8Ftd2Vsne4YxEQ3NI2B/kNF4O7izXMYN6nY29g5bW0xhFkZrkOBxfFfTFS+7cBBy
 LBvOqV4Cp8cawgEncueSfzciSToetTEM3JbQnECevxHFTaytln/5myys7CSR72E1CNGmf29Yl0J
 shprXkS8MEN0/g1BIGjetS43Yc6ouEUbmbQnJsaAZsbudkL0wlEN0qr+ADGw52s/fMBrypJBCRu
 sMBshqrGG4KqkAb2qOA==
X-Proofpoint-GUID: YLN8fPZkkTIutbQDmoNPLueyIbYSkTwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280045
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=+g2SHbI8bJZB+1ZSMJTMNdqI5RuE+WhLw9fFrD7bL
 T8=; b=Fe1MCIXGY4BfhNcTbB0V6P8wyM56cHtIWDbZdMYFtrPMZiLerxK+64UdV
 gCiaI8WREhrcLecAULXUmUleMKY29h0KCq6fzHXSchQ+qHrP44qBvl8E3I+wiNez
 btv1sQlXWuLfNbWRBM75d6M3+ey5LgpPJs3p2qBj+XYmQMWWE9H13zJeWpsliTxB
 jf+jepEge7eD5GFW4TfyixQWwdgBv7P3Fcm9cMnyHmNhtO2qXOjVpo+UWRMD8izI
 hao5/qwA0ZYPlTtBMriiq6AzJQGAAEx5QKG38pD76I5aaedBRwzEEVpUgActAFsp
 XIGRNw4/AE4Wdp/LNT9AEH2Ix2WjQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g2SHbI8bJZB+1ZSMJTMNdqI5RuE+WhLw9fFrD7bLT8=;
 b=i1OUUUCO1H7WM0FzFTq7u6XwYTkpl3vPDzoxNzYIR8SXKLSRIweICJ7Oze9DjrppImYiOgoAVqiJJLDSiDLjkkwnP6txT9qS4UZO6MUowFuFdrirZdLxvOFhGMykNRyIg/aye5d32MIQ5dgo3O/47de6Gwea4Pdu3bT1PZZlKOk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Fe1MCIXG; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=i1OUUUCO
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

The negation rule was not being applied when run_pipe was executed
leading to '! command' not actually negating the return code when using
modern shell.

  => cli set modern
  => ! false
  => echo $?
  <Prints 1 before this patch with the expected output being 0>

Reported-by: Rasmus Villemoes <ravi@prevas.dk>
Closes: https://lore.kernel.org/u-boot/878qbyr2wg.fsf@prevas.dk/
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/cli_hush_upstream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 748ef60ac90b..c01ba00e4754 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -10377,6 +10377,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 	debug_printf_exec("run_pipe return -1 (%u children started)\n", pi->alive_cmds);
 	return -1;
 #else /* __U_BOOT__ */
+	IF_HAS_KEYWORDS(if (pi->pi_inverted) rcode = !rcode;)
 	debug_printf_exec("run_pipe return %d\n", rcode);
 	return rcode;
 #endif /* __U_BOOT__ */

-- 
2.55.0

