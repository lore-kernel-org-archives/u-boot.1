Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C994C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D43582AFC;
	Tue, 29 Apr 2025 19:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zm6RAiIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0AB0829A1; Tue, 29 Apr 2025 17:45:03 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4462682958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 17:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 51DDE4A465;
 Tue, 29 Apr 2025 15:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB02EC4CEE3;
 Tue, 29 Apr 2025 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745941497;
 bh=6cKcD4OITLxOQPcXL8Kd6Xb1vW4oEWnGh3Xi4ckIM4g=;
 h=From:To:Cc:Subject:Date:From;
 b=Zm6RAiIVte+oVAM4ues9XAidTyvcxdbU4sfRRuuk5j8sUagSVHyWCXQ/M++V/Yddz
 xhuK9uV6jVUPUiOWi4rCDA9NHLg0c6Qar61qt2ang8bcgnqeyVap6USv33KYFKN4aV
 GJGjaH1yPP+ZlLwxLeOSuWWmZHc+H2jlZ7pseAQsKvUiNIuxKc6XQoodkadWaGiCQh
 QfVtbWWos8k7PROgp80rNeC7d9KnUI8DAdhM/Rwnhn+ZixYQMfRksLz4hupixfUqID
 t4Nqp/XFCuZfYDtl+Z/cPJ1SPjuxlbio3w2Xm8I/rPyYf/BlAy6GZrrHIG9+gIYYR2
 YuVI6dKIrem2Q==
Received: by wens.tw (Postfix, from userid 1000)
 id 8958C5FBEA; Tue, 29 Apr 2025 23:44:54 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Andy Yan <andyshrk@163.com>, Banglang Huang <banglang.huang@foxmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 David Bauer <mail@david-bauer.net>, Deepak Das <deepakdas.linux@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jacobe Zang <jacobe.zang@wesion.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>,
 Loic Devulder <ldevulder@suse.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nick Xie <nick@khadas.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ricardo Pardini <ricardo@pardini.net>, Sam Edwards <cfsworks@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tianling Shen <cnsztl@gmail.com>, Tim Lunn <tim@feathertop.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Wadim Egorov <w.egorov@phytec.de>, Xiaobo Tian <peterwillcn@gmail.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 1/2] mmc: rockchip_dw_mmc: Enable by default for all supported
 SoCs
Date: Tue, 29 Apr 2025 23:44:51 +0800
Message-Id: <20250429154453.2155923-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
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

The rockchip_dw_mmc driver supports the MMC controller found in Rockchip
SoCs. This controller is used for the SD card on all SoCs and eMMC on
older SoCs. Almost all defconfigs for Rockchip platforms have this
enabled.

Enable it by default for all supported Rockchip SoCs. Disable it
explicitly in defconfigs that previously didn't have it enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

 configs/anbernic-rgxx3-rk3566_defconfig       | 2 --
 configs/bpi-r2-pro-rk3568_defconfig           | 2 --
 configs/chromebit_mickey_defconfig            | 2 --
 configs/chromebook_bob_defconfig              | 2 --
 configs/chromebook_jerry_defconfig            | 2 --
 configs/chromebook_kevin_defconfig            | 2 --
 configs/chromebook_minnie_defconfig           | 2 --
 configs/chromebook_speedy_defconfig           | 2 --
 configs/cm3588-nas-rk3588_defconfig           | 2 --
 configs/coolpi-4b-rk3588s_defconfig           | 2 --
 configs/coolpi-cm5-evb-rk3588_defconfig       | 2 --
 configs/coolpi-cm5-genbook-rk3588_defconfig   | 1 +
 configs/eaidk-610-rk3399_defconfig            | 2 --
 configs/elgin-rv1108_defconfig                | 2 --
 configs/evb-px30_defconfig                    | 5 -----
 configs/evb-px5_defconfig                     | 2 --
 configs/evb-rk3036_defconfig                  | 2 --
 configs/evb-rk3128_defconfig                  | 2 --
 configs/evb-rk3229_defconfig                  | 2 --
 configs/evb-rk3288_defconfig                  | 2 --
 configs/evb-rk3308_defconfig                  | 2 --
 configs/evb-rk3328_defconfig                  | 2 --
 configs/evb-rk3399_defconfig                  | 2 --
 configs/evb-rk3568_defconfig                  | 2 --
 configs/evb-rk3588_defconfig                  | 2 --
 configs/evb-rv1108_defconfig                  | 1 +
 configs/ficus-rk3399_defconfig                | 2 --
 configs/firefly-px30_defconfig                | 5 -----
 configs/firefly-rk3288_defconfig              | 2 --
 configs/firefly-rk3399_defconfig              | 2 --
 configs/geekbox_defconfig                     | 1 +
 configs/generic-rk3528_defconfig              | 2 --
 configs/generic-rk3568_defconfig              | 2 --
 configs/generic-rk3588_defconfig              | 2 --
 configs/jaguar-rk3588_defconfig               | 2 --
 configs/khadas-edge-captain-rk3399_defconfig  | 2 --
 configs/khadas-edge-rk3399_defconfig          | 2 --
 configs/khadas-edge-v-rk3399_defconfig        | 2 --
 configs/khadas-edge2-rk3588s_defconfig        | 2 --
 configs/kylin-rk3036_defconfig                | 2 --
 configs/leez-rk3399_defconfig                 | 2 --
 configs/lubancat-2-rk3568_defconfig           | 2 --
 configs/miqi-rk3288_defconfig                 | 2 --
 configs/mk808_defconfig                       | 2 --
 configs/nanopc-t4-rk3399_defconfig            | 2 --
 configs/nanopc-t6-rk3588_defconfig            | 2 --
 configs/nanopi-m4-2gb-rk3399_defconfig        | 2 --
 configs/nanopi-m4-rk3399_defconfig            | 2 --
 configs/nanopi-m4b-rk3399_defconfig           | 2 --
 configs/nanopi-neo4-rk3399_defconfig          | 2 --
 configs/nanopi-r2c-plus-rk3328_defconfig      | 2 --
 configs/nanopi-r2c-rk3328_defconfig           | 2 --
 configs/nanopi-r2s-plus-rk3328_defconfig      | 2 --
 configs/nanopi-r2s-rk3328_defconfig           | 2 --
 configs/nanopi-r3s-rk3566_defconfig           | 2 --
 configs/nanopi-r4s-rk3399_defconfig           | 2 --
 configs/nanopi-r5c-rk3568_defconfig           | 2 --
 configs/nanopi-r5s-rk3568_defconfig           | 2 --
 configs/nanopi-r6c-rk3588s_defconfig          | 2 --
 configs/nanopi-r6s-rk3588s_defconfig          | 2 --
 configs/neu2-io-rv1126_defconfig              | 2 --
 configs/neu6a-io-rk3588_defconfig             | 2 --
 configs/neu6b-io-rk3588_defconfig             | 2 --
 configs/nova-rk3588s_defconfig                | 2 --
 configs/odroid-go2_defconfig                  | 5 -----
 configs/odroid-m1-rk3568_defconfig            | 2 --
 configs/odroid-m1s-rk3566_defconfig           | 2 --
 configs/odroid-m2-rk3588s_defconfig           | 2 --
 configs/orangepi-3b-rk3566_defconfig          | 2 --
 configs/orangepi-5-plus-rk3588_defconfig      | 2 --
 configs/orangepi-5-rk3588s_defconfig          | 2 --
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 --
 configs/orangepi-r1-plus-rk3328_defconfig     | 2 --
 configs/orangepi-rk3399_defconfig             | 2 --
 configs/phycore-rk3288_defconfig              | 2 --
 configs/pinebook-pro-rk3399_defconfig         | 2 --
 configs/pinephone-pro-rk3399_defconfig        | 2 --
 configs/pinetab2-rk3566_defconfig             | 2 --
 configs/popmetal-rk3288_defconfig             | 2 --
 configs/powkiddy-x55-rk3566_defconfig         | 2 --
 configs/puma-rk3399_defconfig                 | 2 --
 configs/px30-core-ctouch2-of10-px30_defconfig | 5 -----
 configs/px30-core-ctouch2-px30_defconfig      | 5 -----
 configs/px30-core-edimm2.2-px30_defconfig     | 5 -----
 configs/qnap-ts433-rk3568_defconfig           | 2 --
 configs/quartz64-a-rk3566_defconfig           | 2 --
 configs/quartz64-b-rk3566_defconfig           | 2 --
 configs/quartzpro64-rk3588_defconfig          | 2 --
 configs/radxa-cm3-io-rk3566_defconfig         | 2 --
 configs/radxa-e20c-rk3528_defconfig           | 2 --
 configs/radxa-e25-rk3568_defconfig            | 2 --
 configs/radxa-zero-3-rk3566_defconfig         | 2 --
 configs/ringneck-px30_defconfig               | 6 ------
 configs/roc-cc-rk3308_defconfig               | 2 --
 configs/roc-cc-rk3328_defconfig               | 2 --
 configs/roc-pc-mezzanine-rk3399_defconfig     | 2 --
 configs/roc-pc-rk3399_defconfig               | 2 --
 configs/roc-pc-rk3576_defconfig               | 2 --
 configs/rock-3a-rk3568_defconfig              | 2 --
 configs/rock-3b-rk3568_defconfig              | 2 --
 configs/rock-3c-rk3566_defconfig              | 2 --
 configs/rock-4c-plus-rk3399_defconfig         | 2 --
 configs/rock-4se-rk3399_defconfig             | 2 --
 configs/rock-5-itx-rk3588_defconfig           | 2 --
 configs/rock-5c-rk3588s_defconfig             | 2 --
 configs/rock-pi-4-rk3399_defconfig            | 2 --
 configs/rock-pi-4c-rk3399_defconfig           | 2 --
 configs/rock-pi-e-rk3328_defconfig            | 2 --
 configs/rock-pi-e-v3-rk3328_defconfig         | 2 --
 configs/rock-pi-n10-rk3399pro_defconfig       | 2 --
 configs/rock-pi-n8-rk3288_defconfig           | 2 --
 configs/rock-pi-s-rk3308_defconfig            | 2 --
 configs/rock-s0-rk3308_defconfig              | 2 --
 configs/rock2_defconfig                       | 2 --
 configs/rock5a-rk3588s_defconfig              | 2 --
 configs/rock5b-rk3588_defconfig               | 2 --
 configs/rock64-rk3328_defconfig               | 2 --
 configs/rock960-rk3399_defconfig              | 2 --
 configs/rock_defconfig                        | 2 --
 configs/rockpro64-rk3399_defconfig            | 2 --
 configs/sheep-rk3368_defconfig                | 2 --
 configs/sige7-rk3588_defconfig                | 2 --
 configs/sonoff-ihost-rv1126_defconfig         | 2 --
 configs/soquartz-blade-rk3566_defconfig       | 2 --
 configs/soquartz-cm4-rk3566_defconfig         | 2 --
 configs/soquartz-model-a-rk3566_defconfig     | 2 --
 configs/tiger-rk3588_defconfig                | 2 --
 configs/tinker-rk3288_defconfig               | 2 --
 configs/tinker-s-rk3288_defconfig             | 2 --
 configs/toybrick-rk3588_defconfig             | 2 --
 configs/turing-rk1-rk3588_defconfig           | 2 --
 configs/vyasa-rk3288_defconfig                | 2 --
 drivers/mmc/Kconfig                           | 2 ++
 133 files changed, 5 insertions(+), 280 deletions(-)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index 14c97b4c5bf1..e76de60b5b28 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -54,8 +54,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index d84ea2f955fa..2e06d44f71f9 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -45,8 +45,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 1b8d1d4c9e6c..2e56055e1edf 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -79,8 +79,6 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PINCTRL=y
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 2c44afeddcd3..e7b986a40f67 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -62,8 +62,6 @@ CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index 36b123d2cc7f..31898698cb33 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -79,8 +79,6 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PINCTRL=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index e7c42befe97f..87ecc90d2fc3 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -63,8 +63,6 @@ CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 6b3387a7fb41..f310155bfe0b 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -80,8 +80,6 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PINCTRL=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 99a0e454f1df..65d3e5ea90a0 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -80,8 +80,6 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
 CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PINCTRL=y
diff --git a/configs/cm3588-nas-rk3588_defconfig b/configs/cm3588-nas-rk3588_defconfig
index fd0a32d6d790..b718761f3695 100644
--- a/configs/cm3588-nas-rk3588_defconfig
+++ b/configs/cm3588-nas-rk3588_defconfig
@@ -53,8 +53,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index ea985b816707..6a5bd3ca59f6 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -62,8 +62,6 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index 58ffe7baf5f7..0cf4de88fffd 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -62,8 +62,6 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi-cm5-genbook-rk3588_defconfig
index 3eb5dc968af6..92676ebb984a 100644
--- a/configs/coolpi-cm5-genbook-rk3588_defconfig
+++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
@@ -65,6 +65,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
+# CONFIG_MMC_DW is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 45a2d9016830..0bdc7d04b0a1 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -31,8 +31,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/elgin-rv1108_defconfig b/configs/elgin-rv1108_defconfig
index 601165be85ad..1c08728001db 100644
--- a/configs/elgin-rv1108_defconfig
+++ b/configs/elgin-rv1108_defconfig
@@ -38,8 +38,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x62000000
 CONFIG_FASTBOOT_BUF_SIZE=0x08000000
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index 50dd29fcb01f..c11ac71e6abe 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -6,9 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-evb"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
-# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_EVB_PX30=y
-# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xff178000
@@ -31,7 +29,6 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
-# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
@@ -68,8 +65,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
index 9dbd26ed6bfc..94312fa0edb9 100644
--- a/configs/evb-px5_defconfig
+++ b/configs/evb-px5_defconfig
@@ -69,8 +69,6 @@ CONFIG_TPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_TPL_CLK=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_RAM=y
diff --git a/configs/evb-rk3036_defconfig b/configs/evb-rk3036_defconfig
index 209d6b6ca90d..0eaebe52e63b 100644
--- a/configs/evb-rk3036_defconfig
+++ b/configs/evb-rk3036_defconfig
@@ -48,8 +48,6 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PINCTRL=y
 # CONFIG_SPL_DM_SERIAL is not set
diff --git a/configs/evb-rk3128_defconfig b/configs/evb-rk3128_defconfig
index b46da229d541..a8da5d4b04d4 100644
--- a/configs/evb-rk3128_defconfig
+++ b/configs/evb-rk3128_defconfig
@@ -37,8 +37,6 @@ CONFIG_FASTBOOT_BUF_SIZE=0x04000000
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_REGULATOR_PWM=y
diff --git a/configs/evb-rk3229_defconfig b/configs/evb-rk3229_defconfig
index 3cbc22662a62..ce994b769a38 100644
--- a/configs/evb-rk3229_defconfig
+++ b/configs/evb-rk3229_defconfig
@@ -55,8 +55,6 @@ CONFIG_FASTBOOT_BUF_SIZE=0x04000000
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY=y
diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288_defconfig
index 95615ce17074..687279967664 100644
--- a/configs/evb-rk3288_defconfig
+++ b/configs/evb-rk3288_defconfig
@@ -68,8 +68,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index c8e1753b2812..df7d120ace33 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -39,8 +39,6 @@ CONFIG_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index fd5285358385..3d343d6d0caf 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -58,8 +58,6 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index 87b4949de064..1ee4808bf9d1 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -34,8 +34,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
 CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index a068bc6846c6..9666f8ec19c5 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -40,8 +40,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 3d4d2747145d..343f8bab6b02 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -40,8 +40,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
index 46b949531017..d23f90a6a606 100644
--- a/configs/evb-rv1108_defconfig
+++ b/configs/evb-rv1108_defconfig
@@ -31,6 +31,7 @@ CONFIG_FASTBOOT_BUF_SIZE=0x08000000
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+# CONFIG_MMC_DW is not set
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index 3a72156d3894..bc55aa2951df 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -37,8 +37,6 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index 7398d06274f9..0b9203cfd7a9 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -6,10 +6,8 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="px30-firefly"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
-# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_EVB_PX30=y
 CONFIG_DEBUG_UART_CHANNEL=1
-# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
@@ -32,7 +30,6 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
-# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
@@ -70,8 +67,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index d8a671b7a8a4..5583bcb8d2d1 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -62,8 +62,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index be8cde094466..918cacef49a3 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -34,8 +34,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
index 80f91de7a11d..9dc642dc4ad9 100644
--- a/configs/geekbox_defconfig
+++ b/configs/geekbox_defconfig
@@ -22,6 +22,7 @@ CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_CLK=y
+# CONFIG_MMC_DW is not set
 CONFIG_PINCTRL=y
 CONFIG_RAM=y
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/generic-rk3528_defconfig b/configs/generic-rk3528_defconfig
index e19c7bc4801d..8d44bfc45cea 100644
--- a/configs/generic-rk3528_defconfig
+++ b/configs/generic-rk3528_defconfig
@@ -29,8 +29,6 @@ CONFIG_NO_NET=y
 # CONFIG_ADC is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 76418ba7032c..5839726d8076 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -55,8 +55,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 2075584cf564..57ef9b87d977 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -48,8 +48,6 @@ CONFIG_SPL_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index 6e853991d1d3..9a480cdf6367 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -80,8 +80,6 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index ce425eb9b20c..76c2cf2d8543 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -45,8 +45,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index 10a20d749ba5..b46658c622e8 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -43,8 +43,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index d3345c12fe25..efe7ed5c0267 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -45,8 +45,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
index 12a6b6e049c8..7ba29fc30e1e 100644
--- a/configs/khadas-edge2-rk3588s_defconfig
+++ b/configs/khadas-edge2-rk3588s_defconfig
@@ -60,8 +60,6 @@ CONFIG_I2C_MUX=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/kylin-rk3036_defconfig b/configs/kylin-rk3036_defconfig
index df5b9b949b0e..3588f2edbaa9 100644
--- a/configs/kylin-rk3036_defconfig
+++ b/configs/kylin-rk3036_defconfig
@@ -52,8 +52,6 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PINCTRL=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index f12f39857e00..4fb4b95ea524 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -31,8 +31,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 46cc3c03fffb..84bc678839ec 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -42,8 +42,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 166468fd4e72..49756f6d1eb6 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -59,8 +59,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index ecb9afa2f952..1643edeacecc 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -91,8 +91,6 @@ CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_SPL_MMC_UHS_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index 40844753ccd8..7c4956fb622c 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -34,8 +34,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 772b7df15557..63400e526113 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -60,8 +60,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index 31b0e83cdea6..c9c431beb235 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -38,8 +38,6 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index 1a9b770c1692..d86abb8e39f3 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -37,8 +37,6 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index d3a8b5bb6d1f..4db517abf4e3 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -37,8 +37,6 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 1e422befdf8e..48ee321c2f9c 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -32,8 +32,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index bef1e22d6447..901af3929c06 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -59,8 +59,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index 4d66a76c7dc3..bc8b1aefff0c 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -59,8 +59,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/nanopi-r2s-plus-rk3328_defconfig b/configs/nanopi-r2s-plus-rk3328_defconfig
index 3a75566ed4d7..162a4ff7ce6b 100644
--- a/configs/nanopi-r2s-plus-rk3328_defconfig
+++ b/configs/nanopi-r2s-plus-rk3328_defconfig
@@ -58,8 +58,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 2b9193d1ff59..e7c9852f0610 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -59,8 +59,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
index 16e09753a72d..0d9ea44b7e5c 100644
--- a/configs/nanopi-r3s-rk3566_defconfig
+++ b/configs/nanopi-r3s-rk3566_defconfig
@@ -45,8 +45,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index 04642bca7cbd..62bc683b91df 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -32,8 +32,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index 4a43b17ccb16..61cff621ee6c 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -43,8 +43,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index a60d229fbbf7..65b381439c97 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -43,8 +43,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-r6c-rk3588s_defconfig b/configs/nanopi-r6c-rk3588s_defconfig
index c4de5518a728..fa9f9ce7b538 100644
--- a/configs/nanopi-r6c-rk3588s_defconfig
+++ b/configs/nanopi-r6c-rk3588s_defconfig
@@ -47,8 +47,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nanopi-r6s-rk3588s_defconfig b/configs/nanopi-r6s-rk3588s_defconfig
index 2726729b9ac4..256304ccbfaf 100644
--- a/configs/nanopi-r6s-rk3588s_defconfig
+++ b/configs/nanopi-r6s-rk3588s_defconfig
@@ -47,8 +47,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_defconfig
index 18230859b182..bb807632b9b4 100644
--- a/configs/neu2-io-rv1126_defconfig
+++ b/configs/neu2-io-rv1126_defconfig
@@ -41,8 +41,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index 291e0d26d42d..c0aba52777a3 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -37,8 +37,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index 4e22852f23c8..c9c61240ac2f 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -37,8 +37,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/nova-rk3588s_defconfig b/configs/nova-rk3588s_defconfig
index fb30dfd1db81..551030a724da 100644
--- a/configs/nova-rk3588s_defconfig
+++ b/configs/nova-rk3588s_defconfig
@@ -42,8 +42,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 492802dddaee..7ba71c852bc8 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -8,10 +8,8 @@ CONFIG_ENV_OFFSET=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3326-odroid-go2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
-# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_ODROID_GO2=y
 CONFIG_DEBUG_UART_CHANNEL=1
-# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
@@ -37,7 +35,6 @@ CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
-# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
@@ -71,8 +68,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index a8e8a8781e1e..ee94fc9e3959 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -59,8 +59,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index 39e815ad317e..24fb18bb7219 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -56,8 +56,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
index 4c3fa8500d8e..5351e6fac108 100644
--- a/configs/odroid-m2-rk3588s_defconfig
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -56,8 +56,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
index 2181c9caf58f..b531a69dc4e3 100644
--- a/configs/orangepi-3b-rk3566_defconfig
+++ b/configs/orangepi-3b-rk3566_defconfig
@@ -62,8 +62,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 9050fceda455..05ef291dfcde 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -55,8 +55,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index 6e2ff7d338a8..5dc72ebd82a7 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -54,8 +54,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_PHY_MOTORCOMM=y
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 6d5d8b9dcc9d..79b9af7cfd4f 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -64,8 +64,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index b382f9b9f181..5d8c33d03bb3 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -64,8 +64,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index d5091ee8a0c5..5de5d994f321 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -32,8 +32,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index cbdc0a2bd270..a4aa1550c554 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -66,8 +66,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index 676d1e718945..e438473e87d2 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -59,8 +59,6 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 85833c654b8f..da4dba7cf2ee 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -47,8 +47,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index 45e63b42d192..30d6ebda6c45 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -62,8 +62,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 13315df0607d..a24c8931eda6 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -61,8 +61,6 @@ CONFIG_SPL_CLK=y
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
index 85280839889b..4163afd17041 100644
--- a/configs/powkiddy-x55-rk3566_defconfig
+++ b/configs/powkiddy-x55-rk3566_defconfig
@@ -40,8 +40,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 95ed6eea953d..50bc542d71ca 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -64,8 +64,6 @@ CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index 97a6d45f39b3..052ed4efea0d 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -6,10 +6,8 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-engicam-px30-core-ctouch2-of10"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
-# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
-# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
@@ -31,7 +29,6 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
-# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
@@ -66,8 +63,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index 0d20546a7467..93054bd2c493 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -6,10 +6,8 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-engicam-px30-core-ctouch2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
-# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
-# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
@@ -31,7 +29,6 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
-# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
@@ -66,8 +63,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index 6d7ec8f35982..f9f6041d3db4 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -6,10 +6,8 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-engicam-px30-core-edimm2.2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
-# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
-# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
@@ -31,7 +29,6 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
-# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
@@ -66,8 +63,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index ceef0d25dc01..2b683080bea0 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -52,8 +52,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index fe3fa37611a5..d2c9a27ad091 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -58,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index 72db0cb86d82..79faf318aeab 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -56,8 +56,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index ade7be27e928..e60087356056 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -47,8 +47,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 2655fdc31703..88d51b0e046c 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -43,8 +43,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
index 08f3a13af3b2..1baaa74239b3 100644
--- a/configs/radxa-e20c-rk3528_defconfig
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -33,8 +33,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index 4df594ddc019..295b44da1235 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -48,8 +48,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
index 5989b07ad794..ee7bd91ae45f 100644
--- a/configs/radxa-zero-3-rk3566_defconfig
+++ b/configs/radxa-zero-3-rk3566_defconfig
@@ -52,8 +52,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index a334d822e9e4..f4fa895e443e 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -5,12 +5,9 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-ringneck-haikou"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
-# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_RINGNECK_PX30=y
-# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF030000
@@ -36,7 +33,6 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
-# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_BOOTM_NETBSD is not set
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
@@ -83,8 +79,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_TI_GENERIC=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index fb81d3bccfb3..efc561f24dca 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -39,8 +39,6 @@ CONFIG_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 183332ab7ce1..e62b711c7c87 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -55,8 +55,6 @@ CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 9c063ce82d34..4d5643778052 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -45,8 +45,6 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 68c4267d2426..2c77c419d75f 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -43,8 +43,6 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/roc-pc-rk3576_defconfig b/configs/roc-pc-rk3576_defconfig
index af2c1026636a..52a555273f70 100644
--- a/configs/roc-pc-rk3576_defconfig
+++ b/configs/roc-pc-rk3576_defconfig
@@ -27,8 +27,6 @@ CONFIG_BUTTON_ADC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 733ce6314573..255f727a582d 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -57,8 +57,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-3b-rk3568_defconfig b/configs/rock-3b-rk3568_defconfig
index 2023feb36c25..14edf6baf2d1 100644
--- a/configs/rock-3b-rk3568_defconfig
+++ b/configs/rock-3b-rk3568_defconfig
@@ -61,8 +61,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
index 2528c7c639c0..70d97038fc2d 100644
--- a/configs/rock-3c-rk3566_defconfig
+++ b/configs/rock-3c-rk3566_defconfig
@@ -58,8 +58,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 2f1ea314302f..2288e79b9f81 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -49,8 +49,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 7387130ecc18..cf1bcd33cec3 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -53,8 +53,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index d0dd1c20ece6..04866dd94d81 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -61,8 +61,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
index 59f9f25edcb8..a974a7eb4f36 100644
--- a/configs/rock-5c-rk3588s_defconfig
+++ b/configs/rock-5c-rk3588s_defconfig
@@ -47,8 +47,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 97a7db3730df..df93080d197e 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -54,8 +54,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 7da7ee4bce16..9effb934747f 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -54,8 +54,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index 52dad765a8a1..ee3298abb143 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -55,8 +55,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
index 518ea4ebe51a..6e50fa06a48e 100644
--- a/configs/rock-pi-e-v3-rk3328_defconfig
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -56,8 +56,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index a38670d95d0e..9235b312a5b1 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -35,8 +35,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index eb642b012fce..a14fafea9015 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -60,8 +60,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 907b999b274d..889ca8ca72ca 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -41,8 +41,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
index d46977b34a4b..bd32e83b3fc5 100644
--- a/configs/rock-s0-rk3308_defconfig
+++ b/configs/rock-s0-rk3308_defconfig
@@ -42,8 +42,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index ccef4e399558..60443f2f0ef9 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -62,8 +62,6 @@ CONFIG_SPL_CLK=y
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index 9618d5900096..be360f8a5e95 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -43,8 +43,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 47ee2109f8e4..b8863b241cc0 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -62,8 +62,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 6d00b52e62fc..d4aaa2f5ab54 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -60,8 +60,6 @@ CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index 607aa61ba172..4457156683b6 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -41,8 +41,6 @@ CONFIG_SYS_MMC_ENV_DEV=1
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index 8243948d5404..a0a9220a0675 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -52,8 +52,6 @@ CONFIG_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 1b887cd9f3ea..90237a727726 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -49,8 +49,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/sheep-rk3368_defconfig b/configs/sheep-rk3368_defconfig
index 52677a27bdc5..425b80e95651 100644
--- a/configs/sheep-rk3368_defconfig
+++ b/configs/sheep-rk3368_defconfig
@@ -21,8 +21,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PINCTRL=y
 CONFIG_RAM=y
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/sige7-rk3588_defconfig b/configs/sige7-rk3588_defconfig
index 8b033e22b843..aca1b664a8b5 100644
--- a/configs/sige7-rk3588_defconfig
+++ b/configs/sige7-rk3588_defconfig
@@ -50,8 +50,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
index 78ca7a3859e5..d384ed9c0671 100644
--- a/configs/sonoff-ihost-rv1126_defconfig
+++ b/configs/sonoff-ihost-rv1126_defconfig
@@ -42,8 +42,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index a1a51b2c657a..14f801d96190 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -48,8 +48,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index a8bca0eacccc..deaee8e9f4e5 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -48,8 +48,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index f080d2e36d2f..cfc7c0deb845 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -49,8 +49,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index f962ac416f39..6b4330bf10d9 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -81,8 +81,6 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index bc5379d43430..72cd49da7cb8 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -62,8 +62,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index f0c8cc5bbc1b..11793af6d11b 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -62,8 +62,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 5e70341c9879..215a40793383 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -43,8 +43,6 @@ CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 0eddf15833ce..59421e24d767 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -52,8 +52,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index b5f20f18ab81..fcc87f61669e 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -69,8 +69,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 6740591a6533..f2f0e7dbe601 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -251,6 +251,7 @@ config MMC_DAVINCI
 config MMC_DW
 	bool "Synopsys DesignWare Memory Card Interface"
 	select BOUNCE_BUFFER
+	default y if ARCH_ROCKCHIP
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
@@ -286,6 +287,7 @@ config MMC_DW_ROCKCHIP
 	bool "Rockchip SD/MMC controller support"
 	depends on OF_CONTROL
 	depends on MMC_DW
+	default y
 	help
 	  This enables support for the Rockchip SD/MMM controller, which is
 	  based on Designware IP. The device is compatible with at least
-- 
2.39.5

