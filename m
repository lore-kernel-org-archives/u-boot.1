Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161E9EE0212
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B8C891AF;
	Wed, 11 Sep 2024 08:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="C9pze7q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CB38918D; Wed, 11 Sep 2024 08:25:54 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10686891BE
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so395689566b.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035949; x=1726640749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xoss0ArbZMZ8SxA3VPpofX3KHAVY7qT41IQTV6H3kes=;
 b=C9pze7q4wbntSd5K+xLzA3qvqHIeUGfH5HWrB6etzE5rCb4nSg5f70hAa5bQYqugav
 IxeDPhZYuZxGUUI9/OXQVs5QwfBL8EI2lUJYRv3AM0NRCqLp9DVs34RGGSYIG0K94IuM
 OUHPKZBLnVnfcCCTbHM59CvTvm42v2WXnEIQu7AKTZs+TgzNwB+gBrkLx17thXRuEeo1
 M0b6Aea00jGQWdon3kv07CTLOSckJgrwXdw2j1hiVPHXr9QOOXOuc1NGGyT5VUPpGS5e
 pcE8oMlZtKDo4+3YXgOF7Iy2cou+jvvvf556SzEtE2zT1BLlIYVdYP4PdBoKp5WMh9l9
 9wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035949; x=1726640749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xoss0ArbZMZ8SxA3VPpofX3KHAVY7qT41IQTV6H3kes=;
 b=bbhZudyo6DdEQPGLmjHbEDdpuVDWURS3cHbsnBKb6P1GBS+6GJsBb2ybLL9C2AJZBI
 WdFQ8vCh3z96HmMoszccnM/lkrRCkHmNH/cEbfi9/NRbqGVNIoSdEcz4BgaSD9q8D8qV
 AWZN38HH8TJgsP9gbdtGHpBLzsR0ka+x5zHmBWYQq17u+YsiLIISGs4rFx6H2IOGzKep
 qHtryzIa2+2knGXytYuotuRtSnyMn5kTpVmUNG4Emr5OoCXBHJ3WCC3BxzbG4+tMuStO
 r35EWHsbEkviZ9rq6DHIODzeQK2ITHwDlC0ToC3fGy60415qsjfe1pP+N3Elo49/t51f
 dEJQ==
X-Gm-Message-State: AOJu0Yxvb6gYKhOuiqGnw0ui+QWKVtyvCp8Uearch08hJL9jz6uB8pmT
 +A3PcNeEpfjF70W/Wf0VL2vF1pkx2ODZfD1RMcPiNycbNI5kAW/JPvU4qfpJTVYhB5QcDbKo1M4
 QK2U=
X-Google-Smtp-Source: AGHT+IGRO6lhSfXKM+U681SlnA6tT45eFFvLEc/LD4fjS6AfKljBUjDhi8FIK8uY0rYhWqZUWQSpkA==
X-Received: by 2002:a17:907:6eaa:b0:a86:92a5:247a with SMTP id
 a640c23a62f3a-a8ffab294eamr260351566b.17.1726035949416; 
 Tue, 10 Sep 2024 23:25:49 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:49 -0700 (PDT)
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
Subject: [PATCH v3 17/30] drivers: ata: Rename ahci_mvebu
Date: Wed, 11 Sep 2024 08:24:07 +0200
Message-ID: <20240911062511.494855-18-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
index c8756a3a78..45e38210ed 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -90,7 +90,7 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_NETCONSOLE=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_AHCI_PCI=y
-CONFIG_AHCI_MVEBU=y
+CONFIG_AHCI_GENERIC=y
 CONFIG_DM_PCA953X=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
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

