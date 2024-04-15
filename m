Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D03CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A0E1881F8;
	Mon, 15 Apr 2024 13:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KG9X5NWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECAC988089; Mon, 15 Apr 2024 13:35:44 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C14218818C
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afc9twjzk1GR9VfrBfX+4o9gVDxAHFrrT7Aj8p50bKhi4liH41pAbKp26SCPtllcOaDrlFgKQRxMmy96CofcP4uh4F0I2XWCS3u+jCmtcSkHUIqtg/7FYaF/gTFDfyavBXDW7bQrsvq2pWwGH7gy75pFu779uhjhAwJihFy5psMURKILfuqxieWOSzgo5UtiN1f0Spkeq9lJTXvD//zLvCcvXERNeGTQWCjOemm/l5qdp6j5SeKxUXoA7X2qQIUpIBmEvDZZBLcAcR3ll062mYIcyb+gs2HAfg2jgEEvdkv6Ek8SiF96ObZYedy4LddYT3wgO82Www9FZG7sSLhkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jYXJ/LPe3Qcah60w14HNo9JzRZbyDS260u8y4jZpZg=;
 b=DPaTp+Ds5AGuDMElx4SnZvpONG9ILajA+SdYkJ/pSfmZIJaD38uTfP8zh/kFCWC11bcpQ0Lpg4ddcRuCF7PfxUTFftCVnXqH/sZN66MqSMG7976iqTsSZFIcbZIPznxcUBgwK4f1DiT7KQVFtJKSZM1fYaAJ45AnJaL9vZ9DPSxjTFiVJM14flt5jhWFWxUDFkqqM6ca6pc0tzuPy84EfWJ1h9EKcd67dJbQ9xNHHTumdELHfjQt8Qj/JK5PClpGFvHdBKOzJwLK79Ii7vN5BnLMJA7U5Xgey9p2NE0aQemDhyJlQvCHi0EwcW9LvCoTwGgumSX/ofMuiu59TMnNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jYXJ/LPe3Qcah60w14HNo9JzRZbyDS260u8y4jZpZg=;
 b=KG9X5NWlunL1KxMIWqGFbiGWDEHOcIeHG2PWVcKYbFIZJd0oBDX/8DYatUM3CWIL5i9Fjfrn4vD4npuAMJXI+Y24UspWseQJAJU1LuM7KOzjnfbCOdcEzKecH0A50P1ZzR5AT4Qvpfw224gWyE5RqlM15IW9/1qt6D/IilPvPt8=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 11:35:39 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::c5) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 11:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 11:35:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 06:35:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Andre Przywara <andre.przywara@arm.com>, Angelo Dureghello
 <angelo@kernel-space.org>, Elon Zhang <zhangzj@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tim Lunn
 <tim@feathertop.org>, Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
Date: Mon, 15 Apr 2024 13:35:10 +0200
Message-ID: <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713180904.git.michal.simek@amd.com>
References: <cover.1713180904.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=jl1ASAa2UJOhYuyZzFzGqZegknKEGyaxN6B+YtyxEck=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjRZga+rNoj1uomxJdXOWXzd5G/2TcMlzuLvXhkuCUvZ9
 PmQ7+5NHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi4g4M81R/1d2zr4+dba76
 /rAby6699ovOyDPMD1xfq3A2jLtJeAJz+Za/jK5vj2vNAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 805cdf30-3ea7-4cba-d600-08dc5d402c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gq0KHzuDzGI2z2wjh6c6XgFfh2KpFl693CPrF6LiQNyhxi2pBldoCiq/L21rOV2efd7emT3TuQOafcMsvlgaQ6dXVfb4u+ZFLAQ4LkvOjRmnRh3fKbSXAkEDdOg3W8GE+8u1TehO2nvPuJtdiWVmvueo5uNDkkVVGSFN/OCDN54RCvn1IhHahyGQDwqbVdLGajmCkjrdD8Y4AgMNTs63PJKIagfiIth6Bl7s38HSIQcusgMy1ag1RyCHSSeoIoYngQoX9QImMGk9F/Fh3KzswNROvXx4eovOB2/dnh8K25flVSTPYRKviwC6xPHMJfKd6QTluwjp7NtXdaNSoM+gqBlCqk1QdYe6Ml1uVUkPV1nRDwnosDHD9aszmd0HtWPQ2xnqoqt/keZ5fsnRgi95xP7+2SYBwDReqSFQ52Z4UXVTpl1atvB8j5x9jy0Y+9LT3d4/ZJJQaFDzOCWj8h294fMmAZM4bzTdrAS9Z9pD945zRGaerYBoYElWySMlXYExFUZRTgYC8J74vbXCEVJjIFTEm0gO89gGIu5FBzHFugcQOYOtk7RkJm6hU4fkHIVrg2mzXZxGFZGJsxWa1YUaPYUDFZl8Gv5NwqBl3hneF9AQG/sZGUsqJlYjTmUfzTnE22BNJG/8aINSlAOVJEnzoZ2jWoN3RJmNuHB1WU28Vfk6q7RNNFKcIXnyinod6fKuc70Uux6Flx6OeMut24aRHeOPlf29bgeT7ZpKqwKSwgH3btpIuI0x/tCvhRvzqrYU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 11:35:38.7196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805cdf30-3ea7-4cba-d600-08dc5d402c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
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

Some of Kconfigs are using utf-8 encoding because of used chars. Convert
all of them to ascii enconging.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

There are other files which are using utf-8 enconding and pretty much I
think we should convert all of them because there is no reason to use utf-8
encoding.

---
 arch/arm/mach-rockchip/px30/Kconfig   | 4 ++--
 arch/arm/mach-rockchip/rk3588/Kconfig | 6 +++---
 arch/arm/mach-rockchip/rv1126/Kconfig | 4 ++--
 drivers/mtd/spi/Kconfig               | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index 41893920cb4d..23f8f430c4ae 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -36,9 +36,9 @@ config TARGET_PX30_CORE
             10.1" OF for creating complete PX30.Core C.TOUCH 2.0 10.1" Open Frame.
 
 config TARGET_RINGNECK_PX30
-	bool "Theobroma Systems PX30-µQ7 (Ringneck)"
+	bool "Theobroma Systems PX30-uQ7 (Ringneck)"
 	help
-	  The PX30-uQ7 (Ringneck) SoM is a µQseven-compatible (40mmx70mm,
+	  The PX30-uQ7 (Ringneck) SoM is a uQseven-compatible (40mmx70mm,
           MXM-230 connector) system-on-module from Theobroma Systems[1],
 	  featuring the Rockchip PX30.
 
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index eb956b097c74..39049ab35a9c 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -66,7 +66,7 @@ config TARGET_NANOPCT6_RK3588
 	                HDMI2.0, and HDMI1.4
 	  2x 4-lane MIPI-DSI, compatible with MIPI DPHY 2.0 or CPHY 1.1
 	  USB-A: USB 3.0, Type A
-	  USB-C: Full function USB Type‑C port, DP display up to 4Kp60, USB 3.0
+	  USB-C: Full function USB Type-C port, DP display up to 4Kp60, USB 3.0
 	  40-pin 2.54mm header connector: up to 2x SPIs, 6x UARTs, 1x I2Cs,
 	                                  8x PWMs, 2x I2Ss, 28x GPIOs
 	  Debug UART: 3 Pin 2.54mm header, 3V level, 1500000bps
@@ -117,7 +117,7 @@ config TARGET_ROCK5A_RK3588
 	  Mali G610MC4 GPU
 	  MIPI CSI 2 multiple lanes connector
 	  4-lane MIPI DSI connector
-	  Audio – 3.5mm earphone jack
+	  Audio - 3.5mm earphone jack
 	  eMMC module connector
 	  uSD slot (up to 128GB)
 	  2x USB 2.0, 2x USB 3.0
@@ -197,7 +197,7 @@ config TARGET_TOYBRICK_RK3588
 	  4x ARM Cortex-A76, 4x ARM Cortex-A55
 	  8/16GB Memory LPDDR4x
 	  Mali G610MC4 GPU
-	  2× MIPI-CSI0 Connector
+	  2x MIPI-CSI0 Connector
 	  1x 2Lanes PCIe3.0 Connector
 	  1x SATA3.0 Connector
 	  32GB eMMC Module
diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index ae323ee91235..64a70f61f894 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -6,8 +6,8 @@ config TARGET_RV1126_NEU2
 	  Neu2:
 	  Neural Compute Module 2(Neu2) is a 96boards SoM-CB compute module
 	  based on Rockchip RV1126 from Edgeble AI.
-	  Neu2 powered with Consumer grade (0 to +80 °C) RV1126 SoC.
-	  Neu2k powered with Industrial grade (-40 °C to +85 °C) RV1126K SoC.
+	  Neu2 powered with Consumer grade (0 to +80 C) RV1126 SoC.
+	  Neu2k powered with Industrial grade (-40 C to +85 C) RV1126K SoC.
 
 	  Neu2-IO:
 	  Neural Compute Module 2(Neu2) IO board is an industrial form factor
diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index d068b7860e1c..bedc4e970e43 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -246,7 +246,7 @@ config SPI_FLASH_USE_4K_SECTORS
 	  to erasing whole blocks (32/64 KiB).
 	  Changing a small part of the flash's contents is usually faster with
 	  small sectors. On the other hand erasing should be faster when using
-	  64 KiB block instead of 16 × 4 KiB sectors.
+	  64 KiB block instead of 16 x 4 KiB sectors.
 
 	  Please note that some tools/drivers/filesystems may not work with
 	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
-- 
2.44.0

