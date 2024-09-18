Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F26CDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDB188F48;
	Wed, 18 Sep 2024 17:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Zz+yw5LV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2A088F50; Wed, 18 Sep 2024 17:22:35 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E95588F71
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso106210166b.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672952; x=1727277752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9TOGrGnzHKdrxgQXcdZTWbJ7DlQ4XjKRTjewhzj+lU=;
 b=Zz+yw5LVW6zYwN+vAXwh1aTfndEk2n59jdYqhlqezXsBibSqR4fNH0S6ZDzBA9dGkW
 d+sA6FudJoBVtOvVzl7Q72dOIhSCsMJgvHp/MEEDTS5NLcafNXpZPLexuULNK0pejqiJ
 63VKddAYJKFtIIgThkhXz+6WL+Fw6bpKY/5IlgnfsEGVlImepd1mTvwhlw2kYP/5iPYC
 0NWXKI2vrM2ieAcIxlAEqDRTocOlep0g4ywPWGj3dxzL5iKf0N562e8yhdYTTVV4tKSp
 fSmrMnW+cS5nW9W/QCU2qGoJ12Q2a2v5QcVhEx9X3dX9hf7ysriiQtvc8DylW5YIowFJ
 02sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672952; x=1727277752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9TOGrGnzHKdrxgQXcdZTWbJ7DlQ4XjKRTjewhzj+lU=;
 b=Ono7he1QNqIP1VYdJ51qLMyweecSmliFqeIoQ92yPhZwDp9WQPw9nQgM1kn3aSlPO2
 e0ZS95IZf0c9u4s0JJkpXRB1U20SyIauVB6JfYT44mnbobawxIY89ye7qmvBObjqy5SQ
 AhQNpKNputUbfYOzt/sVH3q+2bdABHTrXSFEQTYPed2sH3jkrUfr4xxJ4bI2uMeqctkY
 L5YzgdGfPSB5fYI3B0704bjw51crg2+fJGZHQjQfUuBSXIJ5MIECgnzjpDy05I87hvlG
 z8Y9SIzFzdfIr7oQ4B2Q/fLzH/4Zgnc/VEwrWIddoxUSxIezdTryRsb6i3J8RB6nRkR6
 614Q==
X-Gm-Message-State: AOJu0YyeBVFJVQzuH/WMQLszHk/FfAcuxjO4rxi7uf5TviPbjeEUK8F3
 MES5dSdAYfGqnY1Besn1mNSsI+DIjjk1PVO1tTFsVnq04naD/I555guoKYpY//sZvN+JrUlKEkW
 iWMA=
X-Google-Smtp-Source: AGHT+IH/GFBSOXKa/LtaeocPLlc3+d4+QKv1HE8KUc5ARTGxXe4QF/AebGaPUXzHIxiBNeGV/pwehA==
X-Received: by 2002:a17:906:fd8b:b0:a77:cf9d:f495 with SMTP id
 a640c23a62f3a-a902961bd22mr2438616066b.40.1726672951673; 
 Wed, 18 Sep 2024 08:22:31 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:31 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>, Dennis Gilmore <dgilmore@redhat.com>,
 Kostya Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>,
 Luka Kovacic <luka.kovacic@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Aaron Williams <awilliams@marvell.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 17/35] drivers: ata: Rename ahci_mvebu
Date: Wed, 18 Sep 2024 17:20:21 +0200
Message-ID: <20240918152136.3395170-18-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rename 'ahci_mvebu' to 'ahci_generic' and select it by default.
The AHCI driver contains no SoC specific code and only expects the
base address to be passed, thus rename it to ahci_generic and add the
DT compatible string "generic-ahci".

Update existing defconfigs to use the new Kconfig name as well.

TEST: Booted on QEMU sbsa using the generic-ahci node.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>
---
 MAINTAINERS                                     |  2 +-
 configs/clearfog_defconfig                      |  2 +-
 configs/clearfog_gt_8k_defconfig                |  2 +-
 configs/clearfog_sata_defconfig                 |  2 +-
 configs/clearfog_spi_defconfig                  |  2 +-
 configs/db-88f6820-gp_defconfig                 |  2 +-
 configs/ds116_defconfig                         |  2 +-
 configs/helios4_defconfig                       |  2 +-
 configs/mvebu_crb_cn9130_defconfig              |  2 +-
 configs/mvebu_db-88f3720_defconfig              |  2 +-
 configs/mvebu_db_armada8k_defconfig             |  2 +-
 configs/mvebu_db_cn9130_defconfig               |  2 +-
 configs/mvebu_espressobin-88f3720_defconfig     |  2 +-
 .../mvebu_espressobin_ultra-88f3720_defconfig   |  2 +-
 configs/mvebu_mcbin-88f8040_defconfig           |  2 +-
 configs/mvebu_puzzle-m801-88f8040_defconfig     |  2 +-
 configs/n2350_defconfig                         |  2 +-
 configs/octeon_nic23_defconfig                  |  2 +-
 configs/turris_omnia_defconfig                  |  2 +-
 drivers/ata/Kconfig                             | 12 +++++++-----
 drivers/ata/Makefile                            |  2 +-
 drivers/ata/{ahci_mvebu.c => ahci_generic.c}    | 17 +++++++++--------
 22 files changed, 36 insertions(+), 33 deletions(-)
 rename drivers/ata/{ahci_mvebu.c => ahci_generic.c} (71%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2050ae24df..d3a0469ca1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -356,7 +356,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
 F:	arch/arm/mach-kirkwood/
 F:	arch/arm/mach-mvebu/
-F:	drivers/ata/ahci_mvebu.c
+F:	drivers/ata/ahci_generic.c
 F:	drivers/clk/mvebu/
 F:	drivers/ddr/marvell/
 F:	drivers/gpio/mvebu_gpio.c
diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
index 62dbf2aa48..9cb4753685 100644
--- a/configs/clearfog_defconfig
+++ b/configs/clearfog_defconfig
@@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/clearfog_gt_8k_defconfig b/configs/clearfog_gt_8k_defconfig
index df7e04a75b..66eb5e2407 100644
--- a/configs/clearfog_gt_8k_defconfig
+++ b/configs/clearfog_gt_8k_defconfig
@@ -46,7 +46,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defconfig
index 41382f995d..b1e1fc75dd 100644
--- a/configs/clearfog_sata_defconfig
+++ b/configs/clearfog_sata_defconfig
@@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
index f345b12e6c..64f862d298 100644
--- a/configs/clearfog_spi_defconfig
+++ b/configs/clearfog_spi_defconfig
@@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/db-88f6820-gp_defconfig b/configs/db-88f6820-gp_defconfig
index ee8cb8ae66..16417a4e12 100644
--- a/configs/db-88f6820-gp_defconfig
+++ b/configs/db-88f6820-gp_defconfig
@@ -58,7 +58,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_SYS_I2C_LEGACY=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
index 1173e3a0f6..d687be2d5b 100644
--- a/configs/ds116_defconfig
+++ b/configs/ds116_defconfig
@@ -65,7 +65,7 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 29b6230e90..c0ae1de264 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/mvebu_crb_cn9130_defconfig b/configs/mvebu_crb_cn9130_defconfig
index 4d5f575b03..d253fe88d6 100644
--- a/configs/mvebu_crb_cn9130_defconfig
+++ b/configs/mvebu_crb_cn9130_defconfig
@@ -46,7 +46,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f3720_defconfig
index b955abb31e..1e9332c845 100644
--- a/configs/mvebu_db-88f3720_defconfig
+++ b/configs/mvebu_db-88f3720_defconfig
@@ -43,7 +43,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_CLK=y
diff --git a/configs/mvebu_db_armada8k_defconfig b/configs/mvebu_db_armada8k_defconfig
index 6913796c01..a9b76a3843 100644
--- a/configs/mvebu_db_armada8k_defconfig
+++ b/configs/mvebu_db_armada8k_defconfig
@@ -42,7 +42,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
diff --git a/configs/mvebu_db_cn9130_defconfig b/configs/mvebu_db_cn9130_defconfig
index 9133e25b24..2c345f7436 100644
--- a/configs/mvebu_db_cn9130_defconfig
+++ b/configs/mvebu_db_cn9130_defconfig
@@ -47,7 +47,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index 7ecf5ab0d6..c7015c9b13 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -54,7 +54,7 @@ CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_AHCI_PCI=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_CLK=y
diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
index 974b6df165..0a4329d786 100644
--- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -53,7 +53,7 @@ CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_AHCI_PCI=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_CLK=y
diff --git a/configs/mvebu_mcbin-88f8040_defconfig b/configs/mvebu_mcbin-88f8040_defconfig
index eef612a261..8bb26bd3d6 100644
--- a/configs/mvebu_mcbin-88f8040_defconfig
+++ b/configs/mvebu_mcbin-88f8040_defconfig
@@ -46,7 +46,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
diff --git a/configs/mvebu_puzzle-m801-88f8040_defconfig b/configs/mvebu_puzzle-m801-88f8040_defconfig
index b00e92908b..db7881c3fc 100644
--- a/configs/mvebu_puzzle-m801-88f8040_defconfig
+++ b/configs/mvebu_puzzle-m801-88f8040_defconfig
@@ -49,7 +49,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_PCA953X=y
diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
index e7d7deabfe..b6fc333906 100644
--- a/configs/n2350_defconfig
+++ b/configs/n2350_defconfig
@@ -65,7 +65,7 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
diff --git a/configs/octeon_nic23_defconfig b/configs/octeon_nic23_defconfig
index 5a8db5a087..d19d459555 100644
--- a/configs/octeon_nic23_defconfig
+++ b/configs/octeon_nic23_defconfig
@@ -46,7 +46,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_SATA=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_CLK=y
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 93f0bc53f9..85c71f2eef 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -90,7 +90,7 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_NETCONSOLE=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_AHCI_PCI=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_DM_PCA953X=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MV=y
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 6cca561f97..4fbb63a148 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -78,14 +78,16 @@ config MTK_AHCI
 	  Enable this driver to support Sata devices through
 	  Mediatek AHCI controller (e.g. MT7622).
 
-config AHCI_MVEBU
-	bool "Marvell EBU AHCI SATA support"
-	depends on ARCH_MVEBU || ARCH_OCTEON
+config AHCI_GENERIC
+	bool "Generic AHCI SATA support"
+	depends on OF_CONTROL
 	select SCSI_AHCI
 	select SCSI
 	help
-	  This option enables support for the Marvell EBU SoC's
-	  onboard AHCI SATA.
+	  This option enables support for generic onboard AHCI SATA controller
+	  that do not need platform specific quirks, like emulated devices,
+	  Marvell EBU SoC's onboard AHCI SATA controllers or Cavium's Octeon
+	  7130 AHCI controllers.
 
 	  If unsure, say N.
 
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index af6f0bf278..507bf84c14 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -14,6 +14,6 @@ obj-$(CONFIG_SATA) += sata.o sata_bootdev.o
 obj-$(CONFIG_SATA_CEVA) += sata_ceva.o
 obj-$(CONFIG_SATA_MV) += sata_mv.o
 obj-$(CONFIG_SATA_SIL) += sata_sil.o
-obj-$(CONFIG_AHCI_MVEBU) += ahci_mvebu.o
+obj-$(CONFIG_AHCI_GENERIC) += ahci_generic.o
 obj-$(CONFIG_SUNXI_AHCI) += ahci_sunxi.o
 obj-$(CONFIG_MTK_AHCI) += mtk_ahci.o
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_generic.c
similarity index 71%
rename from drivers/ata/ahci_mvebu.c
rename to drivers/ata/ahci_generic.c
index f6e2d6bee4..6e5a6cbafd 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_generic.c
@@ -16,7 +16,7 @@ __weak int board_ahci_enable(void)
 	return 0;
 }
 
-static int mvebu_ahci_bind(struct udevice *dev)
+static int generic_ahci_bind(struct udevice *dev)
 {
 	struct udevice *scsi_dev;
 	int ret;
@@ -30,7 +30,7 @@ static int mvebu_ahci_bind(struct udevice *dev)
 	return 0;
 }
 
-static int mvebu_ahci_probe(struct udevice *dev)
+static int generic_ahci_probe(struct udevice *dev)
 {
 	/*
 	 * Board specific SATA / AHCI enable code, e.g. enable the
@@ -43,18 +43,19 @@ static int mvebu_ahci_probe(struct udevice *dev)
 	return 0;
 }
 
-static const struct udevice_id mvebu_ahci_ids[] = {
+static const struct udevice_id generic_ahci_ids[] = {
 	{ .compatible = "marvell,armada-380-ahci" },
 	{ .compatible = "marvell,armada-3700-ahci" },
 	{ .compatible = "marvell,armada-8k-ahci" },
 	{ .compatible = "cavium,octeon-7130-ahci" },
+	{ .compatible = "generic-ahci" },
 	{ }
 };
 
-U_BOOT_DRIVER(ahci_mvebu_drv) = {
-	.name		= "ahci_mvebu",
+U_BOOT_DRIVER(ahci_generic_drv) = {
+	.name		= "ahci_generic",
 	.id		= UCLASS_AHCI,
-	.of_match	= mvebu_ahci_ids,
-	.bind		= mvebu_ahci_bind,
-	.probe		= mvebu_ahci_probe,
+	.of_match	= generic_ahci_ids,
+	.bind		= generic_ahci_bind,
+	.probe		= generic_ahci_probe,
 };
-- 
2.46.0

