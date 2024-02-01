Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D8DC47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5C087C64;
	Thu,  1 Feb 2024 13:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fhnw5cF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CF487C56; Thu,  1 Feb 2024 13:38:59 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2778B877D7
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 13:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si5md5FVxUdwz9uXvRxfjnjy9h8yGqvG9/LvYpscWAgn1vckCxBizfBvxGlYmNAOWHd6jldpmqew606y+mRgFT6c8LBTmBomCL0Mx6OdF1Fq4/Hyt1VRxFJ1ke1QyId5ptuvfj6SjEHCJguXuRwydEiM1T/D6kU2DbjYxzHvTahgDzg6WwnsHZohRMooteg3NHc9kOih+CuIgZq8gUJOQ5Rk5+GBuuA6qhRSbphW5klfDBuNMweowpFxn71l1J/FNYsIr3CpnKWW6R5duUDk7n3LelPM5Fd3IHbkRH4MNIaYzRrurL2QGso3xRDvcuIR4+LDhq7FlPFI5Rg2ddnIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBbGdEFic6QcRR1Pyz9Iif73b4iXIyfpX1i3WtKJ2u0=;
 b=EZNar5sNb9YPhp0WGBsYB9tzaSY08IjQv9roBp2pnJw+LveqUW/joeKSTdX7IPSzos/f0QDkEebG18mgtk/yOqH73IQlPXCWJzMmWQUFZTRm959DxODAfUd/J4jgsZhvgVgvcL00oT6/kl46cAMuKhF8jB3jZ5sxap/B/7l3dG0XnsE6o+Kd4QArAYe3EBckGh8uCbsYU146WUO7JohBBnKt1HxtNg9nwRuVrN4MDCU98mNzGToJ75sVoIW7A6NAYYbkoNC07lcsB63vQh4n96+QtdXY4+SO5MjFNaFe4UO8v04RLv1JcvmBDq/jzNFaBHCgozDmZd0fJumU3XQh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBbGdEFic6QcRR1Pyz9Iif73b4iXIyfpX1i3WtKJ2u0=;
 b=Fhnw5cF5zEHrFrZdRPzw7BeMTIAjpw4hhhCymCIB6ROf5K8O4PFINPauKUdLarm/yHmeoFq+mH9yUxmy6cy10JeGa+ulfSytyvsrUTCB1brTezjBVTFq4ZpTywSF2ulBnbgZTtv0nWLP0RqOIB2tutyJ3qCfPeLWhekAgu9aWtE=
Received: from SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19) by
 PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 12:38:53 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::e) by SN6PR01CA0006.outlook.office365.com
 (2603:10b6:805:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 12:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 12:38:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 06:38:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/5] arm64: zynqmp: Remove arm,cortex-a53-edac node
Date: Thu, 1 Feb 2024 13:38:41 +0100
Message-ID: <6685ee980d9b475f95eef6b2a74795adc4ac4619.1706791116.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
References: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=734; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+VI2eM55KnU3Hann6LcuNGK8n6oB5ZActhOFLRRy54A=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTdEy62rln7TpxJMNGi8J6Rf7eRb4vOW6XzP/YlFDzXt
 d9xo2BKRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIkRcM88tjFLl0/siJWu2O
 sPr7aeJBSdO5SgzzPbMmTP/7v8rE2KZwZqq2jdqiSeo2AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bd4dd9-89c2-4c61-1aaa-08dc2322bf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wjIO335vsf110XKmQ73/ZVCbeAQhmTaQH9nobHGuLHAZUC8QnBSZY2/kSZjico+/7jqycS0gMAMWkf1qfb5ghAjzsUeDS+WF6jZ72QpxDLccBMMZVHG9kxdPb2ZxOtUPDWnaw5bMn6krvW1ik/q2j4n2+3TKerOJ9/SusG/MGspKI1Vwp617NAJXjcgvymd3BcWqTCY+bwCOrJW3q8t/g6rV44hruTrZFUefF4+Q/scK/f2NDmfT3brzWAcYj4nIDxhZe8coEkOT8CeeUN2eAKYMKZMLZLS79pTcBfR/PipY/Amj8BNXtZdYy4BFshcfmG82M+TRRST+giH34nT/bg/XoqSk8C70Q3hTNPblaeT2v6owg/AopZz5kzjte1s/qKRa0J8wwjwLq5V7epIhzMtiD6SBpEPu6x7OTKEaclQyAQn6T8rKItQkcbQrJoG6LR+r/07COjgQokp4VNqZHDboHDOHujMfsg9FBxvEnPqMR721jMb/GNuLXG31G6Sb0R7swvym5BbnX/ATKeSaM9M86McUZ0dHeccg5B1g4X7BJzXYx+E+/WxLXLJWTxYTnjt/btjpvuBSoOYJD0KNEk/nv0n13PvhZCROWrperSO2AdryQNTs31QV7wuPTJ6LrthoEQbK9Jvtu8feA2Bl3kPadprDU/nyRSsdMMG+mzvmsoKaxTeDUbFVbOPvqGt+FvA8qGOhleJ6woIJTzcX0sLJGVisN1geNONBPQLF13ySBmGcR/RVaG4ietAM+yIk1wOEG8TqHUmhsqaCbTloQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(40470700004)(46966006)(36840700001)(316002)(44832011)(8676002)(4744005)(4326008)(2906002)(86362001)(8936002)(5660300002)(70586007)(70206006)(54906003)(356005)(36756003)(47076005)(110136005)(81166007)(82740400003)(6666004)(36860700001)(478600001)(83380400001)(26005)(426003)(2616005)(336012)(16526019)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:38:52.9878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bd4dd9-89c2-4c61-1aaa-08dc2322bf9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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

There is no dt schema associated with it. Also Linux driver have been
removed in Xilinx Linux tree and never gets to upstream that's why remove
description for it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index ee2fbcaedc52..e539fa329e19 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -303,10 +303,6 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	edac {
-		compatible = "arm,cortex-a53-edac";
-	};
-
 	fpga_full: fpga-region {
 		compatible = "fpga-region";
 		fpga-mgr = <&zynqmp_pcap>;
-- 
2.36.1

