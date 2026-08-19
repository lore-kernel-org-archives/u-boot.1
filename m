Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88681C5DF89
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5959B60724;
	Wed, 19 Aug 2026 13:42:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MgJ8WIknUxQ5; Wed, 19 Aug 2026 13:42:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146925;
	bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OfRr9vNCSm3j+K9cU+X2GjdUY3BW4UlimnZfNfdBFGp3rLhsR2sDwDXdtEXzOocrX
	 yMBUWGE76nSUMFn2pRtEdKvbE2CLCqwai25w9M4T5hXEgG6by3nw7IdCJwCaXorOPs
	 lM+c8f8v35tQ6Jn9trA3LsTNB5yp3BUp065einVcPCIU4DTSNd0kJXC+rvkfdqfauU
	 Hl9OOOXTA56L/PKd5di6HaPxB52Qvp9LTR4xf/RX2qBzenbTQONdOtkfM7a+YhFMjA
	 mUmKu9ZY8hZXr9/iv9mgwopQNjGVb1fsyLECvfIwc0IVDT8CJdDfPtfjl9D+Kn7+Gn
	 pj/gepK9iS2EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7CA7606C2;
	Wed, 19 Aug 2026 13:42:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3679B334
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2896640077
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRxoxFiJtDXr for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:19:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=BJtMtPVV; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=fMotK/M7
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E35A140042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:28 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67JA67jd2020592;
 Wed, 19 Aug 2026 05:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9Nsgm
 G4=; b=BJtMtPVVWPKg0AbFfLl2PWItvcKzsxdRYxxYhShwr4y/iwK3gEdE7ov55
 UoCA5cDPfmMbrqz4Gx17sxIwt/LUv3eRYpr9ZrKq4V2Au5gV5ggLi+XMVD3FdiKp
 NSdxyzBLtpY8qS8pjDvTpDf88Cy/jAd/3PT+RWGnHZsr3Wx4dpXLjZV/cOmvUHpC
 NWlCBPY/Wzq1FydiJnYOjZr8GceF/0gGjWmnnm7jUQjYrCLAzK0xAZ5ThGmLyqHS
 1uUondFymMYZ0kWSUg8Z6B4KQr2avU1NdQaocyYHtStDZjO8NmBbENKLmPnYCOHI
 tuYH4AKdMTFPHzF5hOvYoXGoY/sRw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g4yejku9y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 05:19:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RC9DZZs7MhYqGIANwVr5JlBs1VT6rTuAaMjdDUacs14N+KvrhviUrfHgmR5Wq3fnYWfWRDo3xbijC1+MMJbvGDft5/dhd+rbzjOK1/cwV+jCeIvPdBd2IwRwTRmNf/5w/Zj+0eWAuzyII8b6drd764i3G2spm9sBTxNmqnOdKkOPBqbvABeHUOEiqn2MWVWPyAEd2tGAq9i6FTVXBJwezTx0/7Jt5LO5j/F7TkBLu7h+Duuvpllj/KCCljWlAxtO2vKvlZSwRmdPdYenTS1TB9Gr8HXSbaVOVTcZP1kOv+c7tielJaAXDZPyvRwOvS+zdCQxOtfBQKOqFggSr35nHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
 b=sUfdr7SWptQSB01pK5rKHSl8iRTScPyCBx9IWuFP70UbzQZZ8IPw7RVnraBMdleURWymAnBjkAGWgPQGzBFsWgrDHs6rB7g/+qbw5dAg5yZgbSgCs7nsvhB6e7Cei3kO3TCchg0Zc8W9b32nzeGTt8p2oAHSgZWMcqeoLRO4faWx3noB4O++stUZViBk9+27IaCOPT/wou3CEDWJIJ4YcUE0s7n7z3h9AdhnUxO966w2dZ3DaAKZ95ah8+CdGYmjajLsgm8iUasRpmJT+tqdtSBLOpE8+rBwrIRoYxDO2SXKIewz3w57/G/2FtHx7r9KvbB6gFEazJc2isGcDDstWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
 b=fMotK/M7kbogh4ztyMaVTaYLWZl/yTz6PMoXI2Y+6nJ0dGPTxwHHeo5e+pf6qHZiaUp1Ku3duPSdzZaKd3NUcXem4hOaRaiPWEUBX0MIWGG6CPJXS4Q8f2J5OjxKvF6Dk/wVyh3EwhFVgifnlm+oYmrjlzLK/4Vyi5CeX+d6/jo=
Received: from BY3PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:217::23)
 by DM3PPF311E3C1FE.namprd10.prod.outlook.com (2603:10b6:f:fc00::c18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:19:22 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::44) by BY3PR04CA0018.outlook.office365.com
 (2603:10b6:a03:217::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 10:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 10:19:21 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:21 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 05:19:21 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67JAJCio2149110;
 Wed, 19 Aug 2026 05:19:19 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v3 2/3] arm: k3-binman: add tinospl.bin for direct U-Boot boot
Date: Wed, 19 Aug 2026 15:49:09 +0530
Message-ID: <20260819101910.39192-3-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819101910.39192-1-g-praveen@ti.com>
References: <20260819101910.39192-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DM3PPF311E3C1FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ab6a42-305d-41b9-3664-08defddb5643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F/bFW9wstFHpHP72no6g96deKg41l9BFOv2ZQV6tb0mp3IzOTdn82siIngDBKstYdzUHHj4Rh42TXtEQp8AjP4effjh+Gwwd9t2ZxioxlKcNH6FRaQOM+E0OJ4wgAdZIw6o14nlmozVaUsC8S5BUSQV1Hk/5g77Nae29aNwa/wNTvSQyffxEAcGIlN/zXki7JRB2W6RIc5RGm2BC33u4n6Nc4XCpxQBVWwXvH7wM7Cox6ZyYIb59hcAj19ipwCM6faOtXwiRVeM7/rfjLIK6jqfCmM8GlgPE3+v9381R7URlbvHTjtZt9bpm3mbxHAriXtcuD1tdi6f4eMc03t2DB2krJqJQZNouL4N/0naqYGh9Ya7XYjLrXDUbzhfcoXUsAgbUhtWQIXXLed82mSNU/Mz7iTHNJA9SlOnd3KRDzLMeR8RjzIjIjRDL/vbmLIFxZRI4zmPk96bt1ZHskFsJjvsYP9E/WtsN6qE5VwJKQ6D/DE64LGY7IrBhy36gnJDnrEVl7242p/48M1044aO4nqj0QnxbPnidmMfwyuNscVfp7cvp7dL+HSjyGwt2ayJlaP0e88uJc+dBSCeaQyTQ27NChMgeR/sGMs9L8jSIkpF/pnKOOeguE9zXhWEgXz3Yy7krYb4UMXQHEiqK2+/ny+Pe18XiJKEBOpZ/+3lJBwjgHqb+VjNBYhgQ37Aol888SVzMEW9dj0UUDwQp0kFD2w==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MSqOP6yyuvZGFwg2UWqdVNSTEupQDZJJAFnXJYwLf/MaCGaKwpl3oUG59u7Fy9ha77Ek/9yTKNjiNRnS+ZDo5RV2496tIjfu/qQFyrjKZ9TXjk9yf43f/FYF96y1H+Y8F3gpIFik3sd6t3oW3S/2lKui8BAKQ0WbPsiDGdA5gHELLL8AzBtgTBylHiaf2pAoYP+0xGKLZYDAzeN5B83PAaJZ/78XPAGMtzMaP1AJ2hC5ovam/DDQVRs0jgnor1cIsHExtQ05TBddvPGBQdVrs+o/9Kj95X1c0u11/3ua9K/0W5pSdtg0guyIxaW161erGzSJ1kSsfpgv9a9yQka/WdMBkfFke8LlPrhSUHvpvJgmmVDwA69zLxVSDKePJDd8i+SyroH87fJiOlk4ovmo10a/Ox+xVOawSrvksZlBHd479li2WClbgWdAGbz59KCH
X-Exchange-RoutingPolicyChecked: HPICiS75enLvkGDMVUXMElV+PFKihb26MQ3rXVHzKncMtUZ3bNtgxwy+NVWJ04dTqQzDGedzeRMSA0KhHSo0qdw7t+PfOsSlSB6aosnv7oeEoennD6Pi48R9zL4NnKys/O8MbZt8BFgICZ4AxXFIQy3BFdY5/CF7c0ZTZQDXjbVd6q2B3BhixgPyfvfmJkzqsgWap1UwcMRzgZ0Y17BRaM19/9RV37tuu1WnQRbMvHi1Z2DczJBwUnaW0l2+6vxLhHUXNDYCgj+SpvshEgPZTxGkxCEGAOBqliE2SEz5xD0mNMYTFykzDHQr1FwFqILnBBmyFZS6+uqvpTiSKoDqCA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:19:21.8748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ab6a42-305d-41b9-3664-08defddb5643
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF311E3C1FE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3OSBTYWx0ZWRfXz/Mz8Z2b1KwT
 6YZ2QxVjgkkai0ITUo9SSYEB9tno+aGz8TxFfbhrVydn0yU5P5Z1HIGzbT22vW8p70jDlsYU2AH
 M/BueDklXhcTsAVQoH7cr1bqMUxP0ms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3OSBTYWx0ZWRfX9vr+GnxqOmMy
 ne6SzBUVPymM/HsnyZDr+lLiIqFfEBqWfhxh/PGkc/MY0tDPtkzqGAcDCdAJgZ+OUssg6HInolv
 NL7R4lRoXIhvP9gYajCaNXEurPs4r7sRFLIRxpdP1Sf4TvU7aJXkXeg6sIcujzOsLYqEyNHCxDt
 EdUD1N5/qTWvbkwQhTkfyJPaaGrNjJd+Dd9f51VqrHBgQkXf1rgaQKOxhqYubtuWpvJV8f2dUHg
 Mwhm8ZEu/UUFRBi2RD/ya025ggp9a79pHKBQnlyPNRFI+rtsTGKOa8EJE5b/Mk8ywh5G7xmlHNY
 OWrvtgPsZC9zexdGnDWQkF01E/svvcdAV4qgo2gK8IOVUlZW7a8P31oExrl+CiY3gipzhrsd+Rn
 FvwWh+Ntxzv/pCQazdRUi6MoeP3Bl7LbPG1NQ/pS1yhdIzomvI/F7owhTTBN5EjtUgQLX0rGuKY
 RksvTOC48x1CE/yqL0A==
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a85832f cx=c_pps
 a=Yfwwr8Yczqb7c+94X7Exug==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=d6pU8RGRqkria7-D748A:9
X-Proofpoint-GUID: PSxOSWIXKi8UT20q1EiydodqQea8lOGq
X-Proofpoint-ORIG-GUID: PSxOSWIXKi8UT20q1EiydodqQea8lOGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190079
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
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

This patch adds creation of tinospl.bin for J784S4 EVM.

The contents are similar to the existing tispl.bin but the A72 SPL
and its FDT have been removed and replaced with U-Boot proper and its
FDT. This binary is used in a boot mode where R5 SPL directly loads
U-Boot, bypassing the A Core SPL stage.

This reduces boot time by eliminating the A Core SPL stage.

tispl.bin   = TFA + TEE + DM + A72 SPL + FDT(A72 SPL)
tinospl.bin = TFA + TEE + DM + U-Boot  + FDT(U-Boot)

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 Makefile                               |  2 +-
 arch/arm/dts/k3-binman.dtsi            | 47 +++++++++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi     | 65 ++++++++++++++++++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi | 14 ++++++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c6253670a94..c6723d63f59 100644
--- a/Makefile
+++ b/Makefile
@@ -2556,7 +2556,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
 	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
-	       imx9image* m33-oei-ddrfw* tifalcon.bin
+	       imx9image* m33-oei-ddrfw* tifalcon.bin tinospl.bin
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..aa8479bc0f6 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -543,6 +543,53 @@
 		};
 	};
 
+	ti_nospl_template: template-16 {
+		filename = "tinospl.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration for no-SPL boot";
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
index 34b2cc1e681..0dec4316d6b 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -317,4 +317,69 @@
 		};
 	};
 };
+
+&binman{
+	ti_nospl: template-17{
+		insert-template = <&ti_nospl_template>;
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
+						content = <&u_boot_nodtb_nospl>;
+						keyfile = "custMpk.pem";
+					};
+					u_boot_nodtb_nospl: blob-ext {
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
+						content = <&j784s4_evm_dtb_nospl>;
+						keyfile = "custMpk.pem";
+					};
+
+					j784s4_evm_dtb_nospl: blob-ext {
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
index cc0b562d27e..fc6f23736ae 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -87,6 +87,20 @@
 	u-boot-unsigned {
 		insert-template = <&u_boot_unsigned>;
 	};
+
+	ti-nospl {
+		insert-template = <&ti_nospl>;
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

