Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADC3C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 06:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E26882BA;
	Tue, 16 Apr 2024 08:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="caRlvI2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61D588278; Tue, 16 Apr 2024 08:55:48 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A86587F01
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI/sL7ii6o5yw6IB95eClEX6bH8tkV93lzdq+bEYdEJ3G6YyNuswRQZ5F+7Acs4QHGyQJ7dVK2mqFNr3QLTibN5Rbp4A4bl6KDMqNUq0rbZgocovXuBqqBYt0h7a6Wo4m6jJ/NrOxFdC6x8HSSj9GewceR1vgRl2CiU0Ome7XzyIqm9prfHlz3gIyYmEzqB96Kq2TCiQObJZxSOERYQDbS2f4Q4ImH91yNmS/nSCDeBlrks0QP8XS5tR6tabjxgpUt0m8sayUGQIgUqrsY34vs2oOt9C0ObdB2FEJ8uA/xpWFxP4G3pY/BAxGZE/+K1qsK5qupw/sJ3H4q/uN/ofMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjOeEPmZ3GRje/CDF7owuiI7R1qishjcKbDFG2C0sRA=;
 b=BRH8+EZ+E7NrWTX/sJ0xvf/IQWk4Nmt59b2qQlRK2Mx6zjDxfvQLkqpnA1DLc85m79nDacfdZFBrVQecu6Kvcqr0esj6+2ODNfth/A0q6ODWBYQwsePrByLeB3We/l/QH6kvtRNntm0ziavkQZyHh0huqaFgbpXcIuyyjgP15NGcy057C/Phx3Lwab963HxMOIsjv0cEbynuFCJcmP2pu3YhWBM+WAW+TXXDUoYXbOp+5sqk5wjb2HNojQIEWJgYhYmxQRxmzO/FMwOLR7TWn+qorTbkR9gZSi1JpqWpZwGTVbda+JYPI7KMieWP3S1vxi1Ngx/YIa/dEFlxkOquQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjOeEPmZ3GRje/CDF7owuiI7R1qishjcKbDFG2C0sRA=;
 b=caRlvI2YOjncWyiDF3q6MCAEhkQXnQ1oqYYzZdBdairmfkLdWaV6XNL+mcwsc56C9fPXLPChYsOp/B+Be9Z8yyd7tQPYKNtxZSnkmu9mbzjCWYQn4hNZJooz4gsjScz4y6t5ap4RU/MuDoDC2p/5sHOhYbw+BnZP4U1gupdWehU=
Received: from SA9PR13CA0095.namprd13.prod.outlook.com (2603:10b6:806:24::10)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 06:55:43 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::f5) by SA9PR13CA0095.outlook.office365.com
 (2603:10b6:806:24::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 06:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:55:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 01:55:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Andre Przywara <andre.przywara@arm.com>, Dragan Simic
 <dsimic@manjaro.org>, Elon Zhang <zhangzj@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Simon Glass
 <sjg@chromium.org>, Tim Lunn <tim@feathertop.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 4/5] Kconfig: Make all Kconfig encoding ascii
Date: Tue, 16 Apr 2024 08:55:18 +0200
Message-ID: <1e5b7558d30fa17b08f112e8804c7f4eca25a722.1713250508.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4106; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MWKwmHVy+K8beoW/eFME9drs/W8RgTC+qG5h2aw14Bw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQ5hVtL92bqBUy8M+H63xIJ83faL9s3PGLjSC2v/a45f
 2u5mpd4RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIFQOGBVN6njAn9v8zvPr3
 zdyTQqpiTaeYXBnmx16MMJBp2jpZe90ppv5b5qYJXLX1AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: f13cc1d1-91e9-468e-763c-08dc5de23c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKAQor87jvVtr5XvCqC+R4fxLMpgR24AuLGFIAbp/eDJMapvu/teFv0j38Z6U4rnOJhd3TrSTQ+EqBCFrvGjD6bBgAfe5C/eCbwAhvgk73fbuWK4RTjDDz3LiyRQMvwMrWFMUjGJSb/Hx4Kdu/xdP85OCY71G0F3tbK5YKC4yAA3fsfHZIl99/jhmkohQrF3r/tlRa2J5Z6vKAOpAak1iFgx3rj9WVmd1M8ym9zZw/3qEDkPqOlplnTo4sje6cvQsM9lprMJxvI+w9+5NXJmjUxxnwhvMBR1sBAF7ckXga18VvSPO5MEyvzq/DdAd9W+2WXJ/0IaO3eMi3iw7KWH8ZmF6MOsmyOIRfoQedVQYSib4E/8I4GF/qRyFfdvfW8kPkBpYBg5kwklh3FZvULnpulgaedfauDP7Th/84abKZKdMNw+KwbeRkh720zKGgff7MukwXTBASbgX5hhiXL1HFxJvJK69F7pAQjksfE/8JOSXkIUR/39yfmzKjDt+GGvpdTDmoo114jTECyto+uBCj93AMlRhCIv/7j9zLwzsuPBmtPjB0Vt1yyR7tONcT3bj5mtnNvNhZTYlsxgvNpk7f5xKfvUFpTIr8SNGxG8nQGn/tl8kLSRTVMujwOPUUpIr1CmWUG9O4RYuXDy8ZYid2oAcc2ZwMCcjrrHMOT7xf2OpVJmyBmp4b3F/bd8OTdPtHcdrdaGS2FQ7LUrH4XkFAucCwYUcGRnAL0DJcMTfcUxmKr7MvlKocBK4f68S+lZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(7416005)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:55:43.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13cc1d1-91e9-468e-763c-08dc5de23c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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
all of them to ascii enconging. Based on discussion ASCII should be used in
general with the exception of names.

Signed-off-by: Michal Simek <michal.simek@amd.com>

---

Changes in v2:
- Describe temperature as deg C instead of just C
- Update commit message to explain the reason

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
index ae323ee91235..330b7df2312e 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -6,8 +6,8 @@ config TARGET_RV1126_NEU2
 	  Neu2:
 	  Neural Compute Module 2(Neu2) is a 96boards SoM-CB compute module
 	  based on Rockchip RV1126 from Edgeble AI.
-	  Neu2 powered with Consumer grade (0 to +80 °C) RV1126 SoC.
-	  Neu2k powered with Industrial grade (-40 °C to +85 °C) RV1126K SoC.
+	  Neu2 powered with Consumer grade (0 to +80 deg C) RV1126 SoC.
+	  Neu2k powered with Industrial grade (-40 C to +85 deg C) RV1126K SoC.
 
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

