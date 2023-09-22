Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1FFCD4F49
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA11A8667B;
	Fri, 22 Sep 2023 12:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhM/BauY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663FB86AD8; Fri, 22 Sep 2023 12:36:04 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3877E86ABC
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdOlEPSPACy4zGwYid4BxdZGrskG6kDtOkKsYOLXERST4Al7VihgcfexxPr1Vwm4hITgJtaXv6k1QQDyjEdSes5cI0h/VoxbcMuXwd646BvlixjaG8rBMiwIgMdAkFzdX0H8EVIzzU5zkU+rYKEmFGiTqRR5uCG0PQfIxaMmprVFag5avv0WXVli87No8121eJYDRWeKgbfAyuQunddBEOzRcJ+cvSizSf3mETLBrY9eoXxICgQYsw56AfSvgfNBN7zGEsa5NwlbdHbAo1ItZ+XTxF4o9uwDDY1pkfRyhKgiDl5tpugUf58X6FARSUTmWUIKHnqw4/vK+w+kajoziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJD11AyI+UiRXQL55M/fQmqj4udBp/RTm5lzlk8gpkU=;
 b=Q3Qnx/D2Z1UjtwCWEnJJCLdCIbDP6+x199Gkd1lyX5GK8H0IG1cMo5DbfSRfrFYE3we1Q64RZNnDy/fN4nRfutZ9L+oVfxOVhP+EnuXQKwyKKZg+NNSTrO2NJvB4JMTBtuwckdyPuqamkmFF52Hr69omz3zFTsoaChOJ5d/Y98uhROMZnqFc2wzl8q0FCKpZQWFGp25rOW4lccTxIKr9O0HDwjWkCVNaPrL6VekmkO/u3cIzm8BgHBtvLj4rKjTZDU+dbvRy6HoZV38bRlwZYNc2VlKVA5LXnIhko3U705/N1BGKCSmULbKdxDyFZrmuWZ/MytO7E5rdTVDtCwA3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJD11AyI+UiRXQL55M/fQmqj4udBp/RTm5lzlk8gpkU=;
 b=mhM/BauYynzJX0f+bvLXirfIZwOpKGRLxSjdaqIBIf07nCz2b0wjd848Hq3zM2p4I5c1BPE+eb+9o/MzI1EyV4NBbu4QYSmsjGKGO8kvXiqqX1FcnoLKA0Y/J2rDX3Sg5tP9Kjw7+JUgRQ2rvlMuiwhfO8J3NP1amShY9j0xgSE=
Received: from CH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:32::24)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 10:35:56 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::f2) by CH0PR07CA0019.outlook.office365.com
 (2603:10b6:610:32::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 10:35:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:35:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 03/14] arm64: xilinx: Remove address/size-cells from flash node
Date: Fri, 22 Sep 2023 12:35:32 +0200
Message-ID: <c704be9d9f3d09c1cc55b092efeb9c73fcda6451.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7hSgCZGpVJi/xAfHNIJZsi4UHWwZnGr68psr0gN+WZo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3Ck7pOxECwLq1/TZLdtoN8v20f9OXeadpzk3+JUWx
 hXO9HzYEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZyvZ1hNst3y9ups35KFl9f
 8Wn7fdFoUd1LXQzznYtKXCfEP3/12Sv8Q6Oi3OX8VZ9WAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: ae52e0d2-f27f-4eb3-fc3f-08dbbb57b336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4A6C2328SGndXVg7UtkujyDXPlGqNDmDrQ2V42LoSix/5OqO/Z5W3OuKOdzv2K4LB1es6Ys25HB6VP5+LWUuRyo40CfkdCcaXWPmBMy7RQcsbKtg52jQMyK1xdg2plCKgRPtryGLa+BTq3urTpiVbgn6iRFMnu979TOZDetWZz+HSbsolNejwf6EzoHKk/Tf7qKcHKJR/QGQKPbxuCbNi8wODYsT2tPnUKuDXYm8nJc4/41fbhdd6k0SKUaP6KwMnBeJobuLESTqjev+97DA23wM8lLikLFts5+CkZjSc2tNshNHQ/09rfz25QIXuoMM2LbIM76ncKx9WzesYB9okcw8AXzNDqR1SJ1XJL4ZLKNn3LG/Kck6jvAM3CHYEjvXmp7FVB7Kn/tM7yOmjLyMbKIsuAnVEC0qbjCpQ8Yo+fdMyoKbwRumN3fzzQBc2yFk8yX9MQfao1uOTIWGK41YUN4ZUBbtBQItenx3AuYLeMzP/U2yd0p4NJ/VrOYPViPSdmi4PAXMxpJCXhlSGZtdbnj3saSbqCwY+AXlRGExUBpoaLjsGXPLwgLB5ZeeoM5Q1/n7itSJVl4W8AJxU01YLnZa9/hSXrDEmwMmIc4KT3LEZOQ3JtAE0ZwpA2psI8kFb9EHWWH4lEuUuGlrFaba6Moa0hgGSXVqGEU3afL+t/fOfWDXfSP0VpZtE7nCOmZb0xZgmt/nU/Pm7gLuVdk3E6PPU3VDY6xJeOw3ZCnRAjSjX2W3Fvzm6NEnpF1i+InfQ1nIGANFGotf8RR3BIbpSb3UeVpZvijvrSrnRaa9RftKUBJjhPf97PRG4BgCZaC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(186009)(82310400011)(1800799009)(451199024)(230921699003)(40470700004)(36840700001)(46966006)(426003)(336012)(40480700001)(82740400003)(81166007)(6666004)(26005)(16526019)(40460700003)(2616005)(356005)(36756003)(41300700001)(316002)(70586007)(70206006)(110136005)(36860700001)(47076005)(2906002)(4744005)(86362001)(8676002)(8936002)(5660300002)(44832011)(478600001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:35:54.5549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae52e0d2-f27f-4eb3-fc3f-08dbbb57b336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

Partitions are described via fixed-partitions that's why there is no need
to have address/size-cells in flash node.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 80b9face7483..47e8e747ba36 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -145,8 +145,6 @@
 	status = "okay";
 	spi_flash: flash@0 { /* MT25QU512A */
 		compatible = "mt25qu512a", "jedec,spi-nor"; /* 64MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
-- 
2.36.1

