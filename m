Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2823FC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6A9788004;
	Tue, 20 Feb 2024 19:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="hwobh5JW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFC488014; Tue, 20 Feb 2024 19:29:47 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49DFE88006
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id A73F122697;
 Tue, 20 Feb 2024 19:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708453773;
 bh=ViOgbBqSnhVqK0VQMhdT/1p1CXxKmNK5pgcMgiw+8aU=; h=From:To:Subject;
 b=hwobh5JWgzWxfo5hG5scNtBCGCDcgj/TCdliC1bczyI1e8OQOqm2pMpG2qH4JTc+3
 QUEjlfrPLIo5eLPkS5lSHgcsXYLfi+bUdnTX9AmisF0ReiQJ00fMg+VQQNd4yI0fpS
 oXdmnrlR0qOhy2Zv/uOUKKEtTdphlcTHL7HDZJtOHMWnsk96rh63FaAYszKu5MN/NH
 E6+3eCOULIk0tzJqFB1n0N+vJmV4L7P0fbiblrNpl7THnIr20j8zjJtisTDX/rEjZl
 Ym6o2K+2H0qggLFbH4kjdoVHIHYJSlkxDesk1RP9fBmVHVcCjo6FK9SKRUO8zc0aeT
 b7/kMtjnjAmOA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 6/7] toradex: common: Use random mac address if toradex
 config block is missing
Date: Tue, 20 Feb 2024 19:29:25 +0100
Message-Id: <20240220182926.101161-7-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220182926.101161-1-francesco@dolcini.it>
References: <20240220182926.101161-1-francesco@dolcini.it>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Set CONFIG_NET_RANDOM_ETHADDR=y, which sets random eth address in
case there is no toradex config block programmed.
In case of missing toradex config block the generated mac address was
always the same, linked to serial number 0.
Use random generated mac address instead.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/common/tdx-common.c      | 1 -
 configs/apalis-imx8_defconfig          | 1 +
 configs/apalis-tk1_defconfig           | 1 +
 configs/apalis_imx6_defconfig          | 1 +
 configs/apalis_t30_defconfig           | 1 +
 configs/colibri-imx6ull-emmc_defconfig | 1 +
 configs/colibri-imx6ull_defconfig      | 1 +
 configs/colibri-imx8x_defconfig        | 1 +
 configs/colibri_imx6_defconfig         | 1 +
 configs/colibri_imx7_defconfig         | 1 +
 configs/colibri_imx7_emmc_defconfig    | 1 +
 configs/colibri_t20_defconfig          | 1 +
 configs/colibri_t30_defconfig          | 1 +
 configs/colibri_vf_defconfig           | 1 +
 configs/verdin-am62_a53_defconfig      | 1 +
 configs/verdin-am62_r5_defconfig       | 1 +
 configs/verdin-imx8mm_defconfig        | 1 +
 configs/verdin-imx8mp_defconfig        | 1 +
 18 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index 1f3253f4222e..9f09788137d5 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -126,7 +126,6 @@ static int settings_r(void)
 
 	if (read_tdx_cfg_block()) {
 		printf("MISSING TORADEX CONFIG BLOCK\n");
-		get_mac_from_serial(tdx_serial, &tdx_eth_addr);
 
 		/* Board can run even if config block is not present */
 		return 0;
diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index 982098d81420..da3b0e254899 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -52,6 +52,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index 6ed3898b60c3..20c9c06cdeac 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -52,6 +52,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index 05ff6fa115ce..492550607035 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -75,6 +75,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_USE_IPADDR=y
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index 0a27509a97e6..03a1f2c23906 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -45,6 +45,7 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index 285fed9e4faf..2b04855770ab 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -51,6 +51,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index a8a633063d00..959930cf2e31 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -60,6 +60,7 @@ CONFIG_ENV_RANGE=0x80000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index aa18d28d3e6d..88928b0e4bc5 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -52,6 +52,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 70cb79531e92..55c71a000d00 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -74,6 +74,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_USE_IPADDR=y
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index d5c8604f7097..58eb4317857b 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -60,6 +60,7 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_USE_IPADDR=y
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index ae8406f70de5..3382371d40de 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -51,6 +51,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_USE_IPADDR=y
diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfig
index 3c506ffb6877..3405e02ad347 100644
--- a/configs/colibri_t20_defconfig
+++ b/configs/colibri_t20_defconfig
@@ -50,6 +50,7 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=1536
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index c7012031c0a8..394d656a1260 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -43,6 +43,7 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 3d1319cf812e..891637dee741 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -66,6 +66,7 @@ CONFIG_ENV_RANGE=0x80000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_USE_IPADDR=y
 CONFIG_IPADDR="192.168.10.2"
 CONFIG_USE_NETMASK=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 956e3a1ad75e..63e75474ca71 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -104,6 +104,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SPL_DM=y
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index a3febdcb6941..910340ea5a41 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -65,6 +65,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 0c88982f75c8..4e00fb4008dc 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -90,6 +90,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SPL_DM=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 22b8a334dfaf..a95edff961b2 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -99,6 +99,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SPL_DM=y
-- 
2.39.2

