Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349BACF34DA
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE1B83FEC;
	Wed, 19 Nov 2025 16:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="1IjXihJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB2883DBF; Wed, 19 Nov 2025 13:35:49 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CF683952
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 13:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4116289e6=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1763555747; x=1795091747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1nHUqlQoVJr/jxCAzI52Vg4uKDS3v3dc+4W+75dQjB0=;
 b=1IjXihJu+vTBxBv0mS67WxUfk7Jn9O4EUdmXJlMkGZUEGN/xVKCYpEJy
 Ok0vNMwQa1sGS+nmuP1wd1JCi1gDO12pd5QjLJVM8Z7emzITK4hwcuLRA
 NtBcpNZ9f1blbo1Qo4IvMVCf9hLk5Tbg/VyWkyIb0C85XHFIkHg6fLcuF
 U4KWhNz9/+MiP3GMhB9JRwrGePXCkVAFbrGWZYk57Jx7dA1Hl56g5B121
 xpUHtgMM9DAbP9/AZzZwdjoiNIv/26LZeNzmeUAoJx3AM8rLq3HgoYDlT
 S53VoeIz1gyPB17/zkQfq+ccvtwVAtbvgiKFnhiFvPDglYDqSpW+iof71 w==;
X-CSE-ConnectionGUID: op5iT1CpSQKdtf1Y/Gc5KA==
X-CSE-MsgGUID: KZLUvU+ERCaP8TGccIoOjA==
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="280742894"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 05:35:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 19 Nov 2025 05:35:19 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 19 Nov 2025 05:35:18 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>, Leo
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Yao Zi
 <ziyao@disroot.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH 2/2] riscv: mpfs: move SoC level options to the CPU Kconfig
Date: Wed, 19 Nov 2025 12:38:43 +0000
Message-ID: <20251119123843.4171699-3-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
References: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 19 Nov 2025 16:39:33 +0100
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

From: Conor Dooley <conor.dooley@microchip.com>

There are multiple boards that use the PolarFire SoC, so extract
the Kconfig sections that are determined at a CPU level from the board
Kconfigs now that we have a CPU Kconfig.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/cpu/mpfs/Kconfig          | 17 +++++++++++++++++
 board/microchip/mpfs_generic/Kconfig | 20 --------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
index 3e99c1aae38..bcf1ede818b 100644
--- a/arch/riscv/cpu/mpfs/Kconfig
+++ b/arch/riscv/cpu/mpfs/Kconfig
@@ -14,3 +14,20 @@ config MICROCHIP_MPFS
 	imply SPL_LOAD_FIT
 	imply REGMAP
 	imply SYSCON
+	imply CLK_CCF
+	imply CLK_MPFS
+	imply SYS_NS16550
+	imply MACB
+	imply MII
+	imply CMD_I2C
+	imply DM_I2C
+	imply SYS_I2C_MICROCHIP
+	imply MMC
+	imply MMC_WRITE
+	imply MMC_SDHCI
+	imply MMC_SDHCI_CADENCE
+	imply MMC_SDHCI_ADMA
+	imply MMC_HS200_SUPPORT
+	imply SPI
+	imply DM_SPI
+	imply MICROCHIP_QSPI
diff --git a/board/microchip/mpfs_generic/Kconfig b/board/microchip/mpfs_generic/Kconfig
index 49663a4c562..d38e56c742d 100644
--- a/board/microchip/mpfs_generic/Kconfig
+++ b/board/microchip/mpfs_generic/Kconfig
@@ -22,11 +22,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	imply SMP
-	imply CLK_CCF
-	imply CLK_MPFS
-	imply REGMAP
-	imply SYSCON
-	imply SYS_NS16550
 	imply CMD_DHCP
 	imply CMD_EXT2
 	imply CMD_EXT4
@@ -39,23 +34,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply EFI_PARTITION
 	imply IP_DYN
 	imply ISO_PARTITION
-	imply MACB
-	imply MII
 	imply PHY_LIB
 	imply PHY_VITESSE
-	imply MMC
-	imply MMC_WRITE
-	imply MMC_SDHCI
-	imply MMC_SDHCI_CADENCE
-	imply MMC_SDHCI_ADMA
-	imply MMC_HS200_SUPPORT
-	imply CMD_I2C
-	imply DM_I2C
-	imply SYS_I2C_MICROCHIP
-	imply MTD
-	imply SPI
-	imply DM_SPI
-	imply MICROCHIP_COREQSPI
 	imply MTD_SPI_NAND
 	imply CMD_MTD
 	imply CMD_MTDPARTS
-- 
2.43.0

