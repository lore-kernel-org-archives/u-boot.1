Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E99EDB7F0
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 10:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6650F83A41;
	Tue,  7 Apr 2026 12:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lpSaYasO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4716584034; Tue,  7 Apr 2026 12:32:50 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0088352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 12:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHophRkmCYSxnzPFqJx8RUUdEaBAr0nfLDs7Dko5mVfPpHw1M3Q4A7I9qSR15LFxhNf+OE27wNxOzc12xgxLwX2mRd4iBC3Y6Zo5phuKOks4U2zJqa3bqT0pq8R1q8nu32TFk6ajx1WOm0sEgqyV6DawRuwu116RgnKNCE90R7tTpgTIDG70mzy1Nh6pmtGjMy9SZDdQIM3nBWjMhPPV76i5JjMW1TNCrlynOfnB9DzQq3iXSnWSJMDaZCHEIChv5jwD8W2eqp2wCOb9EN7D+QCmroLaGdTV3iiSbOTwbbT7KuVqdQVJ+aKkD38mUvvJWdbqAJDv7ya48TX87nf0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCvwRReBgqe2+cMoHFs1kNYt5GW+OM/08/aXOmQVDRQ=;
 b=iIJ1l3oSm6Zw/RZdRiej6rvwbk17DXSPXyyGzwtPaqYZmf46RZKbFsdRISkpt3a5HjFXK5GuxKKsCc1b+Y4fjzJSlY01jICJqYk71Y3zxg9z/KEZnCkqJdqV+WWWxQfCvt0OhpO7dDfkG9I0zwGYpaqopmBadyJQH2zi6WYx1StBonRexVEFeH2wGZVXPEWG9IX6tHnuDuRvL6u/Iq7X38/2QF/jPXh8B69oOwIR+NfD3M2tcLE983mgV8mufYcoJC7z1UTQoILtazFBicQNMNdYIQDBiPJqaod9ndjE1fbKeDjbcZ5HwsWCWW7takfzMFx3c5UkxVHUGF4oiqZ09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCvwRReBgqe2+cMoHFs1kNYt5GW+OM/08/aXOmQVDRQ=;
 b=lpSaYasO27BdYL5kFHbX0VUf8xT7Q0FbZw61g9GGdcCB/X9NN1E5x9IL1HUzMg0uxydgNHVkW+e3WFQ4bxJTlgrKnl8FQeZrmXxripoJgZG3lKxD4yHc0dhSYFKmVk+npY3SFmKI7JgMrd+oHSJdCxQlG1yaQtZcwJ/hyqW5244=
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 10:32:39 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::ef) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 10:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 10:32:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 05:32:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 05:32:38 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 05:32:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: =?UTF-8?q?Frank=20B=C3=B6wingloh?= <f.boewingloh@beckhoff.com>, "Naman
 Trivedi" <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] soc: xilinx: zynqmp: Add support for new ZynqMP devices
Date: Tue, 7 Apr 2026 12:32:30 +0200
Message-ID: <330098196cc84115899ea7a14665a8df7e279fae.1775557948.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1XaSVIwxZFVQh4rUTkU3fbH0kh10K8u2imXZIq8GP8Q=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWReuWvHETzTJ5k/XFv776yZIVKPHnw1fGkUxXfzEYtVw
 zSrfjmtjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjI7gkM/wM3fDgbINrTzvfq
 1utjPp4X3vA7S12PsrhYOmfhqSNfI1QY/vt8MfJyO1i0YWO58BbXiVx+nGkLdb5uFM//X7w1rD0
 vkw0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a38c491-2f79-48c7-6c1b-08de9490fe46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0WQxZLsAd9mkKUiGxMKufJxAwQoypuChlRtVcafv4IBqaymoQGehy/sG+2d7BLqythUCESMk+EW+j8L8+TYkRG+vqhgvZaxccVGBvsDDiOPG8Rt3EnCJJYWoqzRV8AN/JBuJh/p/csaDyfGQdMrOfOv1x/lD4uhhoS3uHnou+dowRr1eAiH5XPVgkM/jlz06jUE2UUuysGr92SjxO6NRVGkLT+1gz6xjpTpKkEviSlg+jdiAQDpCl7q9Yu48QFIY+26ES2+GxFmC1i89TOeXfTs1PS/oiEOSdh13IHmtZ2zMX6YcM7THuWKwdI9C7q1FYAnygGks8h/MOeQgg7i/zUQ/p4Dmx9Q45/kFfiOaKfOXnsrnVliHoC/Ap6HgaLxyvuMxk3iAzsAmHZLvudQ5JNMxxaWfGfu8XndZOePB0MYzRr54EmlSYaZuOB0kcqkKKNZ41O2aGus+o4FQDleaaBXgWk9wGOYQ+VwVYbyJjwTjgt7Hcg00HL0jdy+3appi2vPSmsbRk1V9o1xKQ8XPI0nH135oG1E2ZzHf/HpNxym/an9m7QjzdYH0Lln9gJJLwtx4un/woVoPBfb8fgUIGhtYKCRytjDB41mTQ981wE8Zo2zsoz9wlTRV7GVUt85fr70b2t1DpcfwnmyIQEyQBN29PLd0PgsqMXnhFRtfajvGMjnFzSwHdq8z6hFMtRQJcWCREAuBwRk65oAesXyuyJxyDe+25jHa3EyPWiBh5fNmLE99hqdhj4023XsdLF1IoAVE7UcGvlQxCjjBnSpd2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +06kxBo3uGKf/GJFTl0YfgA0+8ddTRwdv81WnuFadcVpR90zFzXq1/3iAFo83VB7olo3lfM1AoV9m0YftIqUSPyu0Mbe4j3ltMz7ycoCdL/pqZvItEQprcVnF0D6IKTTtVCXkMR8pnA48jxq4YBNxbnGykh5g+zxohOxE0/6sw744y/vJaQH7jaWCe56ta0efDmwwA2DmR5gmjHQBc/w1di2jH7fI+Gzq5mFcaYKXYOCcU6vGJ+eAHYwmyuzyH8AGWX7mXhy8cOmOSBO9SaqPJbE/Pa4KEdIhSk/a0Jxdu79mNgWmpM+WKJ1KA9+gZapmUnydFYW+896sZerBA6Q+6lcB0ThNqVfjrfRJd9IfdSqBSKOSKUrXXqWcdAscR4UOhoHp0gdDE506nnNXtnlay7mHqrJGEXrrvtJVaH80qriiWxhq4/vrYcr+rglkd8X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:32:39.5015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a38c491-2f79-48c7-6c1b-08de9490fe46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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

Add ID codes for the following ZynqMP devices:
- XCZU1EG_LR (0x0468A093)
- XCZU42DR (0x046D4093)
- XCZU55DR (0x046D2093)
- XCZU57DR (0x046D3093)
- XCZU58DR (0x047F9093)
- XCZU59DR (0x047FC093)
- XCZU63DR (0x046D5093)
- XCZU64DR (0x046D6093)
- XCZU65DR (0x046D1093)

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/soc/soc_xilinx_zynqmp.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index b97cd443c607..4abc73013eb1 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -70,6 +70,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 1,
 		.variants = ZYNQMP_VARIANT_EG_LR,
 	},
+	{
+		.id = 0x0468A093,
+		.device = 1,
+		.variants = ZYNQMP_VARIANT_EG_LR,
+	},
 	{
 		.id = 0x04711093,
 		.device = 2,
@@ -208,6 +213,16 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 49,
 		.variants = ZYNQMP_VARIANT_DR,
 	},
+	{
+		.id = 0x047F9093,
+		.device = 58,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
+	{
+		.id = 0x047FC093,
+		.device = 59,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
 	{
 		.id = 0x046d0093,
 		.device = 67,
@@ -218,6 +233,36 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 67,
 		.variants = ZYNQMP_VARIANT_DR_SE,
 	},
+	{
+		.id = 0x046D1093,
+		.device = 65,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
+	{
+		.id = 0x046D2093,
+		.device = 55,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
+	{
+		.id = 0x046D3093,
+		.device = 57,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
+	{
+		.id = 0x046D4093,
+		.device = 42,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
+	{
+		.id = 0x046D5093,
+		.device = 63,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
+	{
+		.id = 0x046D6093,
+		.device = 64,
+		.variants = ZYNQMP_VARIANT_DR,
+	},
 	{
 		.id = 0x04712093,
 		.device = 24,
-- 
2.43.0

base-commit: 366dfe78e2028f53a6274da75547fb68844764cc
