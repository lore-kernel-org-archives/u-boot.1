Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C33AC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35E682A8B;
	Tue, 29 Apr 2025 19:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YESu4G56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81425829A1; Tue, 29 Apr 2025 19:41:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4405382A64
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B52355C0C80;
 Tue, 29 Apr 2025 17:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA0DC4CEE9;
 Tue, 29 Apr 2025 17:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745948488;
 bh=ov2tcFbDvUXFJdTJmf1W4gJjQ+kxa8CeHwYhGwDKjVg=;
 h=From:To:Cc:Subject:Date:From;
 b=YESu4G56vZYbUSKFWjPtp8Oi8pPjUTrGg9fgSxiWY1nDg1U3OBNHdfTt2t0FkpN4u
 GUzl+tOsI6oseMLTdvA73Ad6ZJODODSfZQ7A66w9TzNKPKZeBpv1ReqRos2WYZHa7B
 L/8ATPXWJ2sjzrzyOzKWZfsbMuQltJjiq1IsgrLPqSqKBp1EPt5m2AVxMsmu0eilMS
 B8V4m3yl8460yFJOGC/BntM3zZo03y1Q4dXS2KepBPUiLy92GWQgVPr+gp8kSf5LZ6
 6o1+WSxN8nvQg3urGsdCsCky38qGa8WFaGP/NCAJCarbGggYjDfmKCH0dN7/GXUIRV
 u6UeOePrt+M8Q==
Received: by wens.tw (Postfix, from userid 1000)
 id 3FB315FBEA; Wed, 30 Apr 2025 01:41:26 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Andy Yan <andyshrk@163.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 1/2] mmc: rockchip_dw_mmc: Enable by default for all supported
 SoCs
Date: Wed, 30 Apr 2025 01:41:24 +0800
Message-Id: <20250429174125.2194499-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Chen-Yu Tsai <wens@csie.org>

The rockchip_dw_mmc driver supports the MMC controller found in Rockchip
SoCs. This controller is used for the SD card on all SoCs and eMMC on
older SoCs. Almost all defconfigs for Rockchip platforms have this
enabled.

Enable it by default for all supported Rockchip SoCs. Disable it
explicitly in defconfigs that previously didn't have it enabled. Of
these, only the Cool Pi GenBook w/ CM5 doesn't actually use the
controller. The other two, the Geekbox and the RV1108 EVB, both have
MMC enabled in their device trees. With this patch, they will gain
support for MMC automatically.

Also limit the driver to Rockchip platforms only, like what is done for
the other dw_mmc platform glue drivers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes in v2:
- Made CONFIG_MMC_DW_ROCKCHIP depend on ARCH_ROCKCHIP

 configs/coolpi-cm5-genbook-rk3588_defconfig | 1 +
 drivers/mmc/Kconfig                         | 3 +++
 2 files changed, 4 insertions(+)

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
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 6740591a6533..ec9e9d51fbf9 100644
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
@@ -286,6 +287,8 @@ config MMC_DW_ROCKCHIP
 	bool "Rockchip SD/MMC controller support"
 	depends on OF_CONTROL
 	depends on MMC_DW
+	depends on ARCH_ROCKCHIP
+	default y
 	help
 	  This enables support for the Rockchip SD/MMM controller, which is
 	  based on Designware IP. The device is compatible with at least
-- 
2.39.5

