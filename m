Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42276C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0303C82AEF;
	Tue, 29 Apr 2025 19:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Inunoh7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986E082A55; Tue, 29 Apr 2025 17:45:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C347F829A1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 17:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8868D5C3A7B;
 Tue, 29 Apr 2025 15:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE3CC4CEE9;
 Tue, 29 Apr 2025 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745941497;
 bh=TxpI396FfLcVtASQCpSFjYeqy+c6hWhua6VAfX7dsXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Inunoh7UyJMLCGk79vDTFPxJZqpqLmVZ3SMjL0CcfcLNV/gQn+oVymsb0ji5l6TmL
 9zRhzt9+mY7QqM+xKqNL2FgD9zgdHxHq+b0VcO4hYPkwzheYCazPRLeHrz9kQgKmj/
 oapJPyzBDm7RKvoqbR0/qazFTJxqaa3Z0tEKQAuyzu9/L1SKzIxk7fWOl4wdoBqvzY
 zYCMPa+4ypyWKIq1nSOQX++6TaIbX2uSILciFAvr2HCpdujdmHdEF+CsK8DzsWLUs6
 8KkS3HX27HpD4yvVH0zRcBtmJLRGu2K5k6QM9ar26t5/cVYj2cKGy/z3ndRhd0bDp2
 43Ez/XaEfRWGQ==
Received: by wens.tw (Postfix, from userid 1000)
 id CE3925FDF8; Tue, 29 Apr 2025 23:44:54 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Andy Yan <andyshrk@163.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jacobe Zang <jacobe.zang@wesion.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nick Xie <nick@khadas.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ricardo Pardini <ricardo@pardini.net>, Sam Edwards <cfsworks@gmail.com>,
 Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Tianling Shen <cnsztl@gmail.com>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH 2/2] mmc: rockchip_sdhci: Enable by default for all supported
 SoCs
Date: Tue, 29 Apr 2025 23:44:52 +0800
Message-Id: <20250429154453.2155923-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429154453.2155923-1-wens@kernel.org>
References: <20250429154453.2155923-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:00:39 +0200
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

From: Chen-Yu Tsai <wens@csie.org>

The rockchip_sdhci driver supports the alternative MMC controller found
in newer Rockchip SoCs. This controller is used for eMMC. Almost all
defconfigs for Rockchip platforms with this controller have it enabled.

Enable it by default for all supported Rockchip SoCs. Disable it
explicitly in defconfigs that previously didn't have it enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

 configs/anbernic-rgxx3-rk3566_defconfig      | 2 --
 configs/bpi-r2-pro-rk3568_defconfig          | 2 --
 configs/chromebook_bob_defconfig             | 2 --
 configs/chromebook_kevin_defconfig           | 2 --
 configs/cm3588-nas-rk3588_defconfig          | 2 --
 configs/coolpi-4b-rk3588s_defconfig          | 2 --
 configs/coolpi-cm5-evb-rk3588_defconfig      | 2 --
 configs/coolpi-cm5-genbook-rk3588_defconfig  | 2 --
 configs/eaidk-610-rk3399_defconfig           | 2 --
 configs/evb-rk3399_defconfig                 | 2 --
 configs/evb-rk3568_defconfig                 | 2 --
 configs/evb-rk3588_defconfig                 | 2 --
 configs/ficus-rk3399_defconfig               | 2 --
 configs/firefly-rk3399_defconfig             | 2 --
 configs/generic-rk3528_defconfig             | 2 --
 configs/generic-rk3568_defconfig             | 2 --
 configs/generic-rk3588_defconfig             | 2 --
 configs/jaguar-rk3588_defconfig              | 2 --
 configs/khadas-edge-captain-rk3399_defconfig | 2 --
 configs/khadas-edge-rk3399_defconfig         | 2 --
 configs/khadas-edge-v-rk3399_defconfig       | 2 --
 configs/khadas-edge2-rk3588s_defconfig       | 2 --
 configs/leez-rk3399_defconfig                | 2 --
 configs/lubancat-2-rk3568_defconfig          | 2 --
 configs/nanopc-t4-rk3399_defconfig           | 2 --
 configs/nanopc-t6-rk3588_defconfig           | 2 --
 configs/nanopi-m4-2gb-rk3399_defconfig       | 2 --
 configs/nanopi-m4-rk3399_defconfig           | 2 --
 configs/nanopi-m4b-rk3399_defconfig          | 2 --
 configs/nanopi-neo4-rk3399_defconfig         | 2 --
 configs/nanopi-r3s-rk3566_defconfig          | 2 --
 configs/nanopi-r4s-rk3399_defconfig          | 2 --
 configs/nanopi-r5c-rk3568_defconfig          | 2 --
 configs/nanopi-r5s-rk3568_defconfig          | 2 --
 configs/nanopi-r6c-rk3588s_defconfig         | 2 --
 configs/nanopi-r6s-rk3588s_defconfig         | 2 --
 configs/neu6a-io-rk3588_defconfig            | 2 --
 configs/neu6b-io-rk3588_defconfig            | 2 --
 configs/nova-rk3588s_defconfig               | 2 --
 configs/odroid-m1-rk3568_defconfig           | 2 --
 configs/odroid-m1s-rk3566_defconfig          | 2 --
 configs/odroid-m2-rk3588s_defconfig          | 2 --
 configs/orangepi-3b-rk3566_defconfig         | 2 --
 configs/orangepi-5-plus-rk3588_defconfig     | 2 --
 configs/orangepi-5-rk3588s_defconfig         | 1 +
 configs/orangepi-rk3399_defconfig            | 2 --
 configs/pinebook-pro-rk3399_defconfig        | 2 --
 configs/pinephone-pro-rk3399_defconfig       | 2 --
 configs/pinetab2-rk3566_defconfig            | 2 --
 configs/powkiddy-x55-rk3566_defconfig        | 2 --
 configs/puma-rk3399_defconfig                | 2 --
 configs/qnap-ts433-rk3568_defconfig          | 2 --
 configs/quartz64-a-rk3566_defconfig          | 2 --
 configs/quartz64-b-rk3566_defconfig          | 2 --
 configs/quartzpro64-rk3588_defconfig         | 2 --
 configs/radxa-cm3-io-rk3566_defconfig        | 2 --
 configs/radxa-e20c-rk3528_defconfig          | 2 --
 configs/radxa-e25-rk3568_defconfig           | 2 --
 configs/radxa-zero-3-rk3566_defconfig        | 2 --
 configs/roc-pc-mezzanine-rk3399_defconfig    | 2 --
 configs/roc-pc-rk3399_defconfig              | 2 --
 configs/roc-pc-rk3576_defconfig              | 2 --
 configs/rock-3a-rk3568_defconfig             | 2 --
 configs/rock-3b-rk3568_defconfig             | 2 --
 configs/rock-3c-rk3566_defconfig             | 2 --
 configs/rock-4c-plus-rk3399_defconfig        | 2 --
 configs/rock-4se-rk3399_defconfig            | 2 --
 configs/rock-5-itx-rk3588_defconfig          | 2 --
 configs/rock-5c-rk3588s_defconfig            | 2 --
 configs/rock-pi-4-rk3399_defconfig           | 2 --
 configs/rock-pi-4c-rk3399_defconfig          | 2 --
 configs/rock-pi-n10-rk3399pro_defconfig      | 2 --
 configs/rock5a-rk3588s_defconfig             | 2 --
 configs/rock5b-rk3588_defconfig              | 2 --
 configs/rock960-rk3399_defconfig             | 2 --
 configs/rockpro64-rk3399_defconfig           | 2 --
 configs/sige7-rk3588_defconfig               | 2 --
 configs/soquartz-blade-rk3566_defconfig      | 2 --
 configs/soquartz-cm4-rk3566_defconfig        | 2 --
 configs/soquartz-model-a-rk3566_defconfig    | 2 --
 configs/tiger-rk3588_defconfig               | 2 --
 configs/toybrick-rk3588_defconfig            | 2 --
 configs/turing-rk1-rk3588_defconfig          | 2 --
 drivers/mmc/Kconfig                          | 6 ++++++
 84 files changed, 7 insertions(+), 164 deletions(-)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index e76de60b5b28..54f74fff902c 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -54,9 +54,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index 2e06d44f71f9..655b5263729d 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -45,9 +45,7 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index e7b986a40f67..5ff742e4b3e0 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -62,9 +62,7 @@ CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 87ecc90d2fc3..1c979c7f9d4c 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -63,9 +63,7 @@ CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/cm3588-nas-rk3588_defconfig b/configs/cm3588-nas-rk3588_defconfig
index b718761f3695..e7f86b40c2c5 100644
--- a/configs/cm3588-nas-rk3588_defconfig
+++ b/configs/cm3588-nas-rk3588_defconfig
@@ -53,9 +53,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHYLIB=y
 CONFIG_RTL8169=y
 CONFIG_NVME_PCI=y
diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index 6a5bd3ca59f6..5500ad65c3ed 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -62,9 +62,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_SPI_FLASH_XTX=y
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index 0cf4de88fffd..37d586cff1c9 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -62,9 +62,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_SPI_FLASH_XTX=y
diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi-cm5-genbook-rk3588_defconfig
index 92676ebb984a..6600446968c3 100644
--- a/configs/coolpi-cm5-genbook-rk3588_defconfig
+++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
@@ -66,9 +66,7 @@ CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 # CONFIG_MMC_DW is not set
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_SPI_FLASH_XTX=y
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 0bdc7d04b0a1..4a09df1026f6 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -31,9 +31,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index 1ee4808bf9d1..73b0c2786b0d 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -34,9 +34,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
 CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index 9666f8ec19c5..a6ed1a3e3225 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -40,9 +40,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 343f8bab6b02..49df991a4db5 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -40,9 +40,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index bc55aa2951df..f3bdde50c342 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -37,9 +37,7 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index 918cacef49a3..e2e59aafd5c5 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -34,9 +34,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/generic-rk3528_defconfig b/configs/generic-rk3528_defconfig
index 8d44bfc45cea..17d6a445cc52 100644
--- a/configs/generic-rk3528_defconfig
+++ b/configs/generic-rk3528_defconfig
@@ -29,9 +29,7 @@ CONFIG_NO_NET=y
 # CONFIG_ADC is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 5839726d8076..dbf659121ee4 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -55,9 +55,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 57ef9b87d977..63c4c0a0acb1 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -48,9 +48,7 @@ CONFIG_SPL_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index 9a480cdf6367..386a0ee55d5a 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -80,9 +80,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 # CONFIG_SPI_FLASH is not set
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index 76c2cf2d8543..f8521c7574c2 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -45,9 +45,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index b46658c622e8..35bbeb0a4aed 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -43,9 +43,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index efe7ed5c0267..d33ffeb56b30 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -45,9 +45,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
index 7ba29fc30e1e..f0465b4bcb4e 100644
--- a/configs/khadas-edge2-rk3588s_defconfig
+++ b/configs/khadas-edge2-rk3588s_defconfig
@@ -60,9 +60,7 @@ CONFIG_I2C_MUX=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_EON=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index 4fb4b95ea524..4e85e8aeb9d4 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -31,9 +31,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 84bc678839ec..5292e42cfca1 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -42,9 +42,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 # CONFIG_SPI_FLASH is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index 7c4956fb622c..ae1505665638 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -34,9 +34,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 63400e526113..7f7023e5fc48 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -60,9 +60,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index c9c431beb235..0bbe6426da51 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -38,9 +38,7 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index d86abb8e39f3..c4dedb22484f 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -37,9 +37,7 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index 4db517abf4e3..ef142fc40011 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -37,9 +37,7 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 48ee321c2f9c..1fd7fca81d9a 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -32,9 +32,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
index 0d9ea44b7e5c..e3daee5f0c41 100644
--- a/configs/nanopi-r3s-rk3566_defconfig
+++ b/configs/nanopi-r3s-rk3566_defconfig
@@ -45,9 +45,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index 62bc683b91df..6bb3f0a18a76 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -32,9 +32,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index 61cff621ee6c..78a0051db8d4 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -43,9 +43,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_RTL8169=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index 65b381439c97..19b42b12eefc 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -43,9 +43,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/nanopi-r6c-rk3588s_defconfig b/configs/nanopi-r6c-rk3588s_defconfig
index fa9f9ce7b538..44fb165b623b 100644
--- a/configs/nanopi-r6c-rk3588s_defconfig
+++ b/configs/nanopi-r6c-rk3588s_defconfig
@@ -47,9 +47,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 # CONFIG_SPI_FLASH is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/nanopi-r6s-rk3588s_defconfig b/configs/nanopi-r6s-rk3588s_defconfig
index 256304ccbfaf..4c32c5189a6a 100644
--- a/configs/nanopi-r6s-rk3588s_defconfig
+++ b/configs/nanopi-r6s-rk3588s_defconfig
@@ -47,9 +47,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 # CONFIG_SPI_FLASH is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index c0aba52777a3..6efa83f4fec9 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -37,9 +37,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index c9c61240ac2f..812eedada0c7 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -37,9 +37,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
diff --git a/configs/nova-rk3588s_defconfig b/configs/nova-rk3588s_defconfig
index 551030a724da..bb264ac1f0e8 100644
--- a/configs/nova-rk3588s_defconfig
+++ b/configs/nova-rk3588s_defconfig
@@ -42,9 +42,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index ee94fc9e3959..a942bc6fbc7c 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -59,9 +59,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index 24fb18bb7219..5c0f798037b0 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -56,9 +56,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
index 5351e6fac108..da2e8fc49a52 100644
--- a/configs/odroid-m2-rk3588s_defconfig
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -56,9 +56,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
index b531a69dc4e3..10357aa03f1b 100644
--- a/configs/orangepi-3b-rk3566_defconfig
+++ b/configs/orangepi-3b-rk3566_defconfig
@@ -62,9 +62,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_XMC=y
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 05ef291dfcde..0b3e8cc25196 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -55,9 +55,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_PHYLIB=y
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index 5dc72ebd82a7..e90390f6daff 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -54,6 +54,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+# CONFIG_MMC_SDHCI is not set
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_PHY_MOTORCOMM=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index 5de5d994f321..7385c75b0db8 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -32,9 +32,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index e438473e87d2..c3c3e68f0ec8 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -59,9 +59,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_SILICONKAISER=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index da4dba7cf2ee..197bac284100 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -47,9 +47,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_SILICONKAISER=y
diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index 30d6ebda6c45..441523c8ef2d 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -62,9 +62,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SILICONKAISER=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
index 4163afd17041..b78eaeb92d9f 100644
--- a/configs/powkiddy-x55-rk3566_defconfig
+++ b/configs/powkiddy-x55-rk3566_defconfig
@@ -40,9 +40,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 50bc542d71ca..97f6c63787c9 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -64,9 +64,7 @@ CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_ANEG_TIMEOUT=30000
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index 2b683080bea0..aa8633eefee7 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -52,9 +52,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_RTL8169=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index d2c9a27ad091..864188d45320 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -58,9 +58,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index 79faf318aeab..011e031bc08b 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -56,9 +56,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index e60087356056..2918bc934370 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -47,9 +47,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 88d51b0e046c..20fa1d960656 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -43,9 +43,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
index 1baaa74239b3..4a0178030a0e 100644
--- a/configs/radxa-e20c-rk3528_defconfig
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -33,9 +33,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index 295b44da1235..dd5a3ac4de40 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -48,9 +48,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_RTL8169=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
index ee7bd91ae45f..001ee2071760 100644
--- a/configs/radxa-zero-3-rk3566_defconfig
+++ b/configs/radxa-zero-3-rk3566_defconfig
@@ -52,9 +52,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 4d5643778052..c0afa8e7579d 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -45,9 +45,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 2c77c419d75f..96a693b07402 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -43,9 +43,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/roc-pc-rk3576_defconfig b/configs/roc-pc-rk3576_defconfig
index 52a555273f70..359bb4d7df7b 100644
--- a/configs/roc-pc-rk3576_defconfig
+++ b/configs/roc-pc-rk3576_defconfig
@@ -27,9 +27,7 @@ CONFIG_BUTTON_ADC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 255f727a582d..40f24ae68cd6 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -57,9 +57,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_XTX=y
diff --git a/configs/rock-3b-rk3568_defconfig b/configs/rock-3b-rk3568_defconfig
index 14edf6baf2d1..62c6cc0014df 100644
--- a/configs/rock-3b-rk3568_defconfig
+++ b/configs/rock-3b-rk3568_defconfig
@@ -61,9 +61,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_XTX=y
diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
index 70d97038fc2d..3f0e469d9cef 100644
--- a/configs/rock-3c-rk3566_defconfig
+++ b/configs/rock-3c-rk3566_defconfig
@@ -58,9 +58,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 2288e79b9f81..1f1d6c113610 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -49,9 +49,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index cf1bcd33cec3..99b89ddb0f4c 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -53,9 +53,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index 04866dd94d81..fe96c6c28302 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -61,9 +61,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_XTX=y
diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
index a974a7eb4f36..b77273dd42b0 100644
--- a/configs/rock-5c-rk3588s_defconfig
+++ b/configs/rock-5c-rk3588s_defconfig
@@ -47,9 +47,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index df93080d197e..817a54913e67 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -54,9 +54,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 9effb934747f..d9994dd27a01 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -54,9 +54,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index 9235b312a5b1..ef1fd83f38fe 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -35,9 +35,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index be360f8a5e95..5d80f8b5f1e1 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -43,9 +43,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index b8863b241cc0..a6f014249117 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -62,9 +62,7 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_XTX=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index 4457156683b6..f69c0da3b872 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -41,9 +41,7 @@ CONFIG_SYS_MMC_ENV_DEV=1
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 90237a727726..3da7d349549f 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -49,9 +49,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/sige7-rk3588_defconfig b/configs/sige7-rk3588_defconfig
index aca1b664a8b5..aff8a3bf9f85 100644
--- a/configs/sige7-rk3588_defconfig
+++ b/configs/sige7-rk3588_defconfig
@@ -50,9 +50,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHYLIB=y
 CONFIG_RTL8169=y
 CONFIG_NVME_PCI=y
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 14f801d96190..d1a65cbf6998 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -48,9 +48,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index deaee8e9f4e5..6c65744f6f7e 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -48,9 +48,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index cfc7c0deb845..dd233e112f12 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -49,9 +49,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index 6b4330bf10d9..1791f585904c 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -81,9 +81,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 # CONFIG_SPI_FLASH is not set
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 215a40793383..4a606b01af92 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -43,9 +43,7 @@ CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 59421e24d767..303940785596 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -52,9 +52,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
 # CONFIG_SPI_FLASH is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f2f0e7dbe601..94377a1a1419 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -481,6 +481,11 @@ config MMC_SANDBOX
 
 config MMC_SDHCI
 	bool "Secure Digital Host Controller Interface support"
+	default y if ROCKCHIP_RK3399
+	default y if ROCKCHIP_RK3528
+	default y if ROCKCHIP_RK3568
+	default y if ROCKCHIP_RK3576
+	default y if ROCKCHIP_RK3588
 	help
 	  This selects the generic Secure Digital Host Controller Interface.
 	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)
@@ -713,6 +718,7 @@ config MMC_SDHCI_ROCKCHIP
 	bool "Arasan SDHCI controller for Rockchip support"
 	depends on ARCH_ROCKCHIP
 	depends on MMC_SDHCI
+	default y
 	help
 	  Support for Arasan SDHCI host controller on Rockchip ARM SoCs platform
 
-- 
2.39.5

