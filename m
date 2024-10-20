Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5F1D3C92D
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 21:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE5388DC8;
	Sun, 20 Oct 2024 23:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729458088;
	bh=TadcLwZVCNXsJjEo0kbhcpD7PUxdnDp1gEcexrJh0GY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ctt3jJyGmklSjJRFN8LNOOHy70acdS+yKVA/g0OTeuAqVFCKF+M/CmZXV2Re4pAiJ
	 ZhcO9IEpetNmtAdOtyv0Wp/WjfqlZFjlEOn1g1U/wHLqvy9eGL7uidKU8fs+9xuZrU
	 FRhiOzyo251dgubD/M9fL1wrxm0zvHEHS37IsgUT5NbiKupYQe6h0K2pqFfQCYPK1P
	 bgp6VqEKvYCsmvPkrJAjLwef3ISBFfXYjv/hai2SUTF+R80ESNoujY/tWBai5KErGq
	 EWIRmQZQSkhTSPNaq12m9v9WZfz3cd9KpqD7KI9ank47BrfdoC48fWujF1HiDr1gHO
	 uoka2tv22yQoA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5551988936;
 Sun, 20 Oct 2024 23:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729458088;
 bh=TadcLwZVCNXsJjEo0kbhcpD7PUxdnDp1gEcexrJh0GY=;
 h=From:To:Cc:Subject:Date:From;
 b=J/ubSx7JrH1w46Na4Xes9/wuPq0X7yWxww6jQcxxcs5OpTeuPn3rP82O7e8A6diS1
 2KMwcIbQo3wx74nYc7AH70bnNooHQx0O/fm/K49lmYaZCLhp9EIfKvRzjeJjBvSZ6b
 87QO9TxhySQxn2x6DH9godPBzYs2ZikOwHOb6LK1The86VhlS3tDnKrWglhZ58lgP3
 hO4UlueUCG/q+tSYXUViVGV9lUeCX+aqnXLnJx1km2Ja1/Dqn00IcIDeplekdxruLK
 WO6uDFkn+3yMeMmCQYSD8zJ0geu2iduc7ylTtoEaQ5PrsM3vxPwIAALEl19VbKIt8o
 29zspx1l0QcFw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 1/2] ARM: imx: soc: Select default TEXT_BASE for i.MX6
Date: Sun, 20 Oct 2024 23:00:38 +0200
Message-ID: <20241020210113.1248062-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
and SPL text base is picked as the one used by various i.MX6 boards.
Update all the boards.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V2: - Move TEXT_BASE/SPL_TEXT_BASE to Kconfig and common/spl/Kconfig
    - Trim the CC list
---
 Kconfig                              | 1 +
 common/spl/Kconfig                   | 1 +
 configs/apalis_imx6_defconfig        | 2 --
 configs/aristainetos2c_defconfig     | 1 -
 configs/aristainetos2ccslb_defconfig | 1 -
 configs/brppt2_defconfig             | 1 -
 configs/cm_fx6_defconfig             | 2 --
 configs/colibri_imx6_defconfig       | 2 --
 configs/dh_imx6_defconfig            | 2 --
 configs/display5_defconfig           | 2 --
 configs/display5_factory_defconfig   | 2 --
 configs/ge_b1x5v2_defconfig          | 2 --
 configs/ge_bx50v3_defconfig          | 1 -
 configs/gwventana_emmc_defconfig     | 2 --
 configs/gwventana_nand_defconfig     | 2 --
 configs/imx6dl_icore_nand_defconfig  | 2 --
 configs/imx6dl_mamoj_defconfig       | 2 --
 configs/imx6dl_sielaff_defconfig     | 2 --
 configs/imx6q_bosch_acc_defconfig    | 1 -
 configs/imx6q_icore_nand_defconfig   | 2 --
 configs/imx6q_logic_defconfig        | 2 --
 configs/imx6qdl_icore_mipi_defconfig | 2 --
 configs/imx6qdl_icore_mmc_defconfig  | 2 --
 configs/imx6qdl_icore_nand_defconfig | 2 --
 configs/imx6qdl_icore_rqs_defconfig  | 2 --
 configs/imx6ul_geam_mmc_defconfig    | 1 -
 configs/imx6ul_geam_nand_defconfig   | 1 -
 configs/imx6ul_isiot_emmc_defconfig  | 1 -
 configs/imx6ul_isiot_nand_defconfig  | 1 -
 configs/imx6ulz_smm_m2_defconfig     | 1 -
 configs/kontron-sl-mx6ul_defconfig   | 1 -
 configs/kp_imx6q_tpc_defconfig       | 2 --
 configs/liteboard_defconfig          | 1 -
 configs/lxr2_defconfig               | 2 --
 configs/marsboard_defconfig          | 1 -
 configs/mccmon6_nor_defconfig        | 2 --
 configs/mccmon6_sd_defconfig         | 2 --
 configs/mx6cuboxi_defconfig          | 2 --
 configs/mx6memcal_defconfig          | 2 --
 configs/mx6qsabrelite_defconfig      | 1 -
 configs/mx6sabreauto_defconfig       | 2 --
 configs/mx6sabresd_defconfig         | 2 --
 configs/mx6ul_14x14_evk_defconfig    | 1 -
 configs/mx6ul_9x9_evk_defconfig      | 1 -
 configs/nitrogen6dl2g_defconfig      | 1 -
 configs/nitrogen6dl_defconfig        | 1 -
 configs/nitrogen6q2g_defconfig       | 1 -
 configs/nitrogen6q_defconfig         | 1 -
 configs/nitrogen6s1g_defconfig       | 1 -
 configs/nitrogen6s_defconfig         | 1 -
 configs/novena_defconfig             | 2 --
 configs/opos6uldev_defconfig         | 1 -
 configs/pcm058_defconfig             | 2 --
 configs/pico-hobbit-imx6ul_defconfig | 1 -
 configs/pico-imx6_defconfig          | 2 --
 configs/pico-imx6ul_defconfig        | 1 -
 configs/pico-pi-imx6ul_defconfig     | 1 -
 configs/riotboard_defconfig          | 2 --
 configs/tbs2910_defconfig            | 1 -
 configs/udoo_defconfig               | 2 --
 configs/udoo_neo_defconfig           | 1 -
 configs/variscite_dart6ul_defconfig  | 1 -
 configs/vining_2000_defconfig        | 1 -
 configs/wandboard_defconfig          | 2 --
 64 files changed, 2 insertions(+), 94 deletions(-)

diff --git a/Kconfig b/Kconfig
index a206d1f8124..b1dd4556a4e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -647,6 +647,7 @@ config HAVE_TEXT_BASE
 config TEXT_BASE
 	depends on HAVE_TEXT_BASE
 	default 0x0 if POSITION_INDEPENDENT
+	default 0x17800000 if ARCH_MX6
 	default 0x80800000 if ARCH_OMAP2PLUS || ARCH_K3
 	default 0x81700000 if MACH_SUNIV
 	default 0x2a000000 if MACH_SUN9I
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 9a27eabd741..ed997d82cfc 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -271,6 +271,7 @@ config SPL_TEXT_BASE
 	default 0x40200000 if OMAP34XX
 	default 0x402F4000 if AM43XX
 	default 0x402F0400 if AM33XX
+	default 0x00908000 if ARCH_MX6
 	default 0x40301350 if OMAP54XX
 	default 0x10060 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN9I
 	default 0x20060 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index 92d304a880d..b44861df5c8 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -16,7 +15,6 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-apalis-eval"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
diff --git a/configs/aristainetos2c_defconfig b/configs/aristainetos2c_defconfig
index 95d6f3f7246..b6e259b490b 100644
--- a/configs/aristainetos2c_defconfig
+++ b/configs/aristainetos2c_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_F_LEN=0x13000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
diff --git a/configs/aristainetos2ccslb_defconfig b/configs/aristainetos2ccslb_defconfig
index 7de378388fa..0ea13d46f31 100644
--- a/configs/aristainetos2ccslb_defconfig
+++ b/configs/aristainetos2ccslb_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_F_LEN=0x13000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
index 299e2633c2f..0bbb682c8f2 100644
--- a/configs/brppt2_defconfig
+++ b/configs/brppt2_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 # CONFIG_SPL_SYS_THUMB_BUILD is not set
 CONFIG_SYS_L2CACHE_OFF=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_GPIO=y
diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
index cfe7c2a349b..0e916771d9f 100644
--- a/configs/cm_fx6_defconfig
+++ b/configs/cm_fx6_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -13,7 +12,6 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_CM_FX6=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-cm-fx6"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index fc9404a7c43..facf0b299a4 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -16,7 +15,6 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-colibri-eval-v3"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
index f435ecc8450..5a5d59902f5 100644
--- a/configs/dh_imx6_defconfig
+++ b/configs/dh_imx6_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
 CONFIG_MX6QDL=y
 CONFIG_TARGET_DHCOMIMX6=y
-CONFIG_TEXT_BASE=0x17800000
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SYS_L2_PL310=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-dhcom-pdk2"
 CONFIG_MX6_DDRCAL=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index c91cb64d288..765920bd5d1 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_GPIO=y
@@ -18,7 +17,6 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-display5"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index c5a4f820714..4007c8900ce 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_GPIO=y
@@ -18,7 +17,6 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-display5"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
index 403a5a526f0..cfa51b2c47d 100644
--- a/configs/ge_b1x5v2_defconfig
+++ b/configs/ge_b1x5v2_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_GPIO=y
@@ -16,7 +15,6 @@ CONFIG_MX6QDL=y
 CONFIG_TARGET_GE_B1X5V2=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-b1x5v2"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=10
 CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
diff --git a/configs/ge_bx50v3_defconfig b/configs/ge_bx50v3_defconfig
index 9cd88af9da6..c24513f6ab1 100644
--- a/configs/ge_bx50v3_defconfig
+++ b/configs/ge_bx50v3_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index 44f37c55f27..95d5b1172ff 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -15,7 +14,6 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_CMD_EECONFIG=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-gw54xx"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_defconfig
index 82b359da68d..1d8af5ce103 100644
--- a/configs/gwventana_nand_defconfig
+++ b/configs/gwventana_nand_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -15,7 +14,6 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_CMD_EECONFIG=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-gw54xx"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6dl_icore_nand_defconfig b/configs/imx6dl_icore_nand_defconfig
index 3a20b7acc26..4352e3871f5 100644
--- a/configs/imx6dl_icore_nand_defconfig
+++ b/configs/imx6dl_icore_nand_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -11,7 +10,6 @@ CONFIG_ENV_OFFSET=0x400000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6Q_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-icore"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 # CONFIG_CMD_BMODE is not set
diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defconfig
index 0e4ac2f1e4c..95797ff0f12 100644
--- a/configs/imx6dl_mamoj_defconfig
+++ b/configs/imx6dl_mamoj_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x2300000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x20000
@@ -8,7 +7,6 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6DL_MAMOJ=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-mamoj"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_IMX_HAB=y
 # CONFIG_CMD_BMODE is not set
diff --git a/configs/imx6dl_sielaff_defconfig b/configs/imx6dl_sielaff_defconfig
index c4e02a8f0b9..a364e2c9cdd 100644
--- a/configs/imx6dl_sielaff_defconfig
+++ b/configs/imx6dl_sielaff_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_GPIO=y
@@ -16,7 +15,6 @@ CONFIG_MX6S=y
 CONFIG_TARGET_MX6S_SIELAFF=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-sielaff"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SF_DEFAULT_BUS=1
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index a46b3250b2e..54758df8c01 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -13,7 +13,6 @@ CONFIG_MX6QDL=y
 CONFIG_MX6_DDRCAL=y
 CONFIG_TARGET_MX6Q_ACC=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-bosch-acc"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6q_icore_nand_defconfig b/configs/imx6q_icore_nand_defconfig
index 48d08d3127f..2c7b8cc2c44 100644
--- a/configs/imx6q_icore_nand_defconfig
+++ b/configs/imx6q_icore_nand_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -11,7 +10,6 @@ CONFIG_ENV_OFFSET=0x400000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6Q_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-icore"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 # CONFIG_CMD_BMODE is not set
diff --git a/configs/imx6q_logic_defconfig b/configs/imx6q_logic_defconfig
index 2f68e2cf384..fd251e7cdd8 100644
--- a/configs/imx6q_logic_defconfig
+++ b/configs/imx6q_logic_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -12,7 +11,6 @@ CONFIG_MX6Q=y
 CONFIG_MX6_OCRAM_256KB=y
 CONFIG_TARGET_MX6LOGICPD=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-logicpd"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6qdl_icore_mipi_defconfig b/configs/imx6qdl_icore_mipi_defconfig
index 77a12125803..cf4c2d9c6f1 100644
--- a/configs/imx6qdl_icore_mipi_defconfig
+++ b/configs/imx6qdl_icore_mipi_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -11,7 +10,6 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6Q_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-icore-mipi"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_mmc_defconfig
index 1e79c4f6c4e..fb0787d1beb 100644
--- a/configs/imx6qdl_icore_mmc_defconfig
+++ b/configs/imx6qdl_icore_mmc_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -11,7 +10,6 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6Q_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-icore"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6qdl_icore_nand_defconfig b/configs/imx6qdl_icore_nand_defconfig
index 48d08d3127f..2c7b8cc2c44 100644
--- a/configs/imx6qdl_icore_nand_defconfig
+++ b/configs/imx6qdl_icore_nand_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -11,7 +10,6 @@ CONFIG_ENV_OFFSET=0x400000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6Q_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-icore"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 # CONFIG_CMD_BMODE is not set
diff --git a/configs/imx6qdl_icore_rqs_defconfig b/configs/imx6qdl_icore_rqs_defconfig
index 69ba60ffa46..49feb1af830 100644
--- a/configs/imx6qdl_icore_rqs_defconfig
+++ b/configs/imx6qdl_icore_rqs_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -11,7 +10,6 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6Q_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-icore-rqs"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6ul_geam_mmc_defconfig b/configs/imx6ul_geam_mmc_defconfig
index 6a84c0a9676..a5c3b486987 100644
--- a/configs/imx6ul_geam_mmc_defconfig
+++ b/configs/imx6ul_geam_mmc_defconfig
@@ -11,7 +11,6 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6UL=y
 CONFIG_TARGET_MX6UL_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-geam"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6ul_geam_nand_defconfig b/configs/imx6ul_geam_nand_defconfig
index 32e18bdac54..187fae80ff9 100644
--- a/configs/imx6ul_geam_nand_defconfig
+++ b/configs/imx6ul_geam_nand_defconfig
@@ -11,7 +11,6 @@ CONFIG_ENV_OFFSET=0x400000
 CONFIG_MX6UL=y
 CONFIG_TARGET_MX6UL_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-geam"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 # CONFIG_CMD_BMODE is not set
diff --git a/configs/imx6ul_isiot_emmc_defconfig b/configs/imx6ul_isiot_emmc_defconfig
index a65659e8792..f285b82e6dc 100644
--- a/configs/imx6ul_isiot_emmc_defconfig
+++ b/configs/imx6ul_isiot_emmc_defconfig
@@ -11,7 +11,6 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6UL=y
 CONFIG_TARGET_MX6UL_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-isiot-emmc"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/imx6ul_isiot_nand_defconfig b/configs/imx6ul_isiot_nand_defconfig
index acd49fb1d48..fe70c199288 100644
--- a/configs/imx6ul_isiot_nand_defconfig
+++ b/configs/imx6ul_isiot_nand_defconfig
@@ -11,7 +11,6 @@ CONFIG_ENV_OFFSET=0x400000
 CONFIG_MX6UL=y
 CONFIG_TARGET_MX6UL_ENGICAM=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-isiot-nand"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 # CONFIG_CMD_BMODE is not set
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index c2adff17abf..15a3ec5c627 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -12,7 +12,6 @@ CONFIG_ENV_OFFSET=0x400000
 CONFIG_MX6ULL=y
 CONFIG_TARGET_MX6ULZ_SMM_M2=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ulz-bsh-smm-m2"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_BSS_START_ADDR=0x84100000
 CONFIG_SPL=y
diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 0ca7d33da10..9ee02259948 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -14,7 +14,6 @@ CONFIG_MX6UL=y
 CONFIG_TARGET_KONTRON_MX6UL=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-kontron-bl"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
diff --git a/configs/kp_imx6q_tpc_defconfig b/configs/kp_imx6q_tpc_defconfig
index fceda3f14d4..7fd2bfb0efa 100644
--- a/configs/kp_imx6q_tpc_defconfig
+++ b/configs/kp_imx6q_tpc_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_F_LEN=0x2200
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -12,7 +11,6 @@ CONFIG_MX6QDL=y
 CONFIG_MX6_DDRCAL=y
 CONFIG_TARGET_KP_IMX6Q_TPC=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-kp"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/liteboard_defconfig b/configs/liteboard_defconfig
index 941a1cfdf47..9a81e973e3c 100644
--- a/configs/liteboard_defconfig
+++ b/configs/liteboard_defconfig
@@ -12,7 +12,6 @@ CONFIG_MX6UL=y
 CONFIG_TARGET_LITEBOARD=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-liteboard"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index d202cad0ad9..7ab817960a2 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_GPIO=y
@@ -15,7 +14,6 @@ CONFIG_MX6Q=y
 CONFIG_TARGET_LXR2=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-lxr"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/marsboard_defconfig b/configs/marsboard_defconfig
index 198fec2cb2c..b90d294ec7d 100644
--- a/configs/marsboard_defconfig
+++ b/configs/marsboard_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
diff --git a/configs/mccmon6_nor_defconfig b/configs/mccmon6_nor_defconfig
index 8edc461088c..9b60ce3d2fc 100644
--- a/configs/mccmon6_nor_defconfig
+++ b/configs/mccmon6_nor_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -13,7 +12,6 @@ CONFIG_IMX_CONFIG="board/liebherr/mccmon6/mon6_imximage_nor.cfg"
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MCCMON6=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-mccmon6"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 # CONFIG_CMD_BMODE is not set
diff --git a/configs/mccmon6_sd_defconfig b/configs/mccmon6_sd_defconfig
index 6088d08a87e..ecd3e31e676 100644
--- a/configs/mccmon6_sd_defconfig
+++ b/configs/mccmon6_sd_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -13,7 +12,6 @@ CONFIG_IMX_CONFIG="board/liebherr/mccmon6/mon6_imximage_sd.cfg"
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MCCMON6=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-mccmon6"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index e3aba715aa5..14c1386e11f 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -12,7 +11,6 @@ CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6CUBOXI=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-hummingboard2-emmc-som-v15"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index bfde8b0cfb3..b5cc341b923 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -9,7 +8,6 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_MX6QDL=y
 CONFIG_MX6_DDRCAL=y
 CONFIG_TARGET_MX6MEMCAL=y
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 CONFIG_SYS_MEMTEST_START=0x10000000
diff --git a/configs/mx6qsabrelite_defconfig b/configs/mx6qsabrelite_defconfig
index bb830c429d0..916992351ce 100644
--- a/configs/mx6qsabrelite_defconfig
+++ b/configs/mx6qsabrelite_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/mx6sabreauto_defconfig b/configs/mx6sabreauto_defconfig
index 76f6eec4658..94b251cbdeb 100644
--- a/configs/mx6sabreauto_defconfig
+++ b/configs/mx6sabreauto_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_GPIO=y
@@ -14,7 +13,6 @@ CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6SABREAUTO=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-sabreauto"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 2a83b8cd067..f041f1fd1a3 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_GPIO=y
@@ -14,7 +13,6 @@ CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6SABRESD=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-sabresd"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index bbeb364e256..ecb7a46308f 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -15,7 +15,6 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-14x14-evk"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/mx6ul_9x9_evk_defconfig b/configs/mx6ul_9x9_evk_defconfig
index 101653a3dfd..11a18d16f52 100644
--- a/configs/mx6ul_9x9_evk_defconfig
+++ b/configs/mx6ul_9x9_evk_defconfig
@@ -15,7 +15,6 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-9x9-evk"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/nitrogen6dl2g_defconfig b/configs/nitrogen6dl2g_defconfig
index 7060d3cf961..a0d77725083 100644
--- a/configs/nitrogen6dl2g_defconfig
+++ b/configs/nitrogen6dl2g_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/nitrogen6dl_defconfig b/configs/nitrogen6dl_defconfig
index c2566c96aba..436ce289f1f 100644
--- a/configs/nitrogen6dl_defconfig
+++ b/configs/nitrogen6dl_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/nitrogen6q2g_defconfig b/configs/nitrogen6q2g_defconfig
index 07800eff08a..827e8830602 100644
--- a/configs/nitrogen6q2g_defconfig
+++ b/configs/nitrogen6q2g_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/nitrogen6q_defconfig b/configs/nitrogen6q_defconfig
index c5e6ce52858..62fc8d8f3b6 100644
--- a/configs/nitrogen6q_defconfig
+++ b/configs/nitrogen6q_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/nitrogen6s1g_defconfig b/configs/nitrogen6s1g_defconfig
index e91c19d30e9..d16cf2ac30f 100644
--- a/configs/nitrogen6s1g_defconfig
+++ b/configs/nitrogen6s1g_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/nitrogen6s_defconfig b/configs/nitrogen6s_defconfig
index b8b410c2cfe..bd3ae139362 100644
--- a/configs/nitrogen6s_defconfig
+++ b/configs/nitrogen6s_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index dd3541bc59a..bcd40b3f5e5 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -15,7 +14,6 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-novena"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index 2b06de5d4c6..ef26332eb5f 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -11,7 +11,6 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6UL=y
 CONFIG_TARGET_OPOS6ULDEV=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-opos6uldev"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
diff --git a/configs/pcm058_defconfig b/configs/pcm058_defconfig
index 48f63c982eb..8ab2c1c069e 100644
--- a/configs/pcm058_defconfig
+++ b/configs/pcm058_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x800000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -16,7 +15,6 @@ CONFIG_TARGET_PCM058=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-phytec-mira-rdk-nand"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/pico-hobbit-imx6ul_defconfig b/configs/pico-hobbit-imx6ul_defconfig
index e3aca6e82e1..b945adfe734 100644
--- a/configs/pico-hobbit-imx6ul_defconfig
+++ b/configs/pico-hobbit-imx6ul_defconfig
@@ -12,7 +12,6 @@ CONFIG_MX6UL=y
 CONFIG_TARGET_PICO_IMX6UL=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-pico-hobbit"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/pico-imx6_defconfig b/configs/pico-imx6_defconfig
index 9b2496e4fa6..4a9c5ac1a98 100644
--- a/configs/pico-imx6_defconfig
+++ b/configs/pico-imx6_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x2300000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -12,7 +11,6 @@ CONFIG_MX6QDL=y
 CONFIG_TARGET_PICO_IMX6=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-pico"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/pico-imx6ul_defconfig b/configs/pico-imx6ul_defconfig
index ce29718a903..c9a0ccd15f6 100644
--- a/configs/pico-imx6ul_defconfig
+++ b/configs/pico-imx6ul_defconfig
@@ -12,7 +12,6 @@ CONFIG_MX6UL=y
 CONFIG_TARGET_PICO_IMX6UL=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-pico-hobbit"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 81f3e9bbebb..daff2e36b00 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -12,7 +12,6 @@ CONFIG_MX6UL=y
 CONFIG_TARGET_PICO_IMX6UL=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ul-pico-pi"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
index a1e806be421..24c6c59ac2b 100644
--- a/configs/riotboard_defconfig
+++ b/configs/riotboard_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -14,7 +13,6 @@ CONFIG_MX6S=y
 CONFIG_TARGET_EMBESTMX6BOARDS=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-riotboard"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index 3ab6799ef1e..99fe65d3109 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x8000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
diff --git a/configs/udoo_defconfig b/configs/udoo_defconfig
index 00b732b9288..5730dacd060 100644
--- a/configs/udoo_defconfig
+++ b/configs/udoo_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0x0200000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -12,7 +11,6 @@ CONFIG_MX6QDL=y
 CONFIG_TARGET_UDOO=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-udoo"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 0c76b005557..8183edd1f62 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -12,7 +12,6 @@ CONFIG_MX6SX=y
 CONFIG_TARGET_UDOO_NEO=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6sx-udoo-neo-basic"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/variscite_dart6ul_defconfig b/configs/variscite_dart6ul_defconfig
index 0b96484b030..9c69d9aef97 100644
--- a/configs/variscite_dart6ul_defconfig
+++ b/configs/variscite_dart6ul_defconfig
@@ -10,7 +10,6 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_MX6ULL=y
 CONFIG_TARGET_DART_6UL=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6ull-dart-6ul"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index e5c9c2861e1..5842916fbdb 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -16,7 +16,6 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6sx-softing-vining-2000"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
index e9deab38038..e0dc56b1d00 100644
--- a/configs/wandboard_defconfig
+++ b/configs/wandboard_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
 CONFIG_SYS_MALLOC_LEN=0xa00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
@@ -15,7 +14,6 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-wandboard-revd1"
-CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
-- 
2.45.2

