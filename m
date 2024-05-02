Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963C4C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FC788D32;
	Thu,  2 May 2024 03:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HGazmotm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC2D88C9C; Thu,  2 May 2024 03:33:25 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706CE88CA0
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-61be4b9869dso31972717b3.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613598; x=1715218398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13LS/UbiA1xECcGZba4DSYkOrdiva2fJQToBWpBRmmY=;
 b=HGazmotmiDxQWy6kmKFQp4lFWupLllstAYCbq3d/rvSmIr7EcWeH9PrZkfFXhGiJiZ
 Z8kK+xHrJbE/jmEMRRTV6Lmyi6G60WmRAVULnNX5OXQ/Q6n5PpcAXdB4b/anW0FnNGgs
 t599BdpgP44IwW3LEGLlMP1sVcVg3w969D95w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613598; x=1715218398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13LS/UbiA1xECcGZba4DSYkOrdiva2fJQToBWpBRmmY=;
 b=BqxlpB8tFEoBA7NyBc28dN+nqe0afoK9Yp8ygRxy5aS4ZIm6kRBRwSIdTb2MJl6LtF
 MPVOgOoS5rGpOJVw6GVIZAfMGlPMpiPqQsECabC3DYM+orKTuQUzgkEX6sa9qd7lo14q
 xqQQXfMuwG5SflyD2uwFHK4vk6WPZBQhXH0dacbQWdwDGuXHC2Q1kCOcQnAFVPupVbke
 G/+J01X1LdTyESHkBWKjD9XJa517WVZlrN4EpNf2vDUCuj4HF3DRJV7iyzjp132cWN6I
 wYaC+rdiUUBN96+V6/D6E65EbfGU5h8YEugXTqsEVA0NPgT2WLVlGOTLuzp3iw0h8T1d
 +phQ==
X-Gm-Message-State: AOJu0YyOb65T/64GZFo5GKPLt3O2FuL80qVvcx+pPBCArkXwex2kD2z/
 Tvc89Riv7WKRXXOUXOV5xm2HtpVaDWHzhDJQBBpEtjQ1aRJuzV3DVQcxVu/FZkwPLHm1j0gYQhF
 J6nHQ7oky
X-Google-Smtp-Source: AGHT+IHOB64vVWet/QpW+tI9O4FfJljYqMw62Zs6ol24br6XiglesY6mXfroc05IVhequZ1dIuH1Tw==
X-Received: by 2002:a05:690c:f10:b0:61b:3454:8941 with SMTP id
 dc16-20020a05690c0f1000b0061b34548941mr544016ywb.43.1714613597807; 
 Wed, 01 May 2024 18:33:17 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Stefan Roese <sr@denx.de>,
 Stefan Bosch <stefan_b@posteo.net>, Mark Kettenis <kettenis@openbsd.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 51/81] pinctrl: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:08 -0600
Message-Id: <20240502013138.2383421-51-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 May 2024 03:34:44 +0200
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Stefan Bosch <stefan_b@posteo.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Dai Okamura <okamura.dai@socionext.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Robert Marko <robert.marko@sartura.hr>
---
 drivers/pinctrl/aspeed/pinctrl_ast2500.c         | 1 -
 drivers/pinctrl/aspeed/pinctrl_ast2600.c         | 1 -
 drivers/pinctrl/ath79/pinctrl_ar933x.c           | 1 -
 drivers/pinctrl/ath79/pinctrl_qca953x.c          | 1 -
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c       | 1 -
 drivers/pinctrl/broadcom/pinctrl-bcm6838.c       | 1 -
 drivers/pinctrl/exynos/pinctrl-exynos.c          | 1 -
 drivers/pinctrl/exynos/pinctrl-exynos7420.c      | 1 -
 drivers/pinctrl/exynos/pinctrl-exynos78x0.c      | 1 -
 drivers/pinctrl/intel/pinctrl.c                  | 1 -
 drivers/pinctrl/intel/pinctrl_apl.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c    | 1 -
 drivers/pinctrl/meson/pinctrl-meson-a1.c         | 1 -
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c    | 1 -
 drivers/pinctrl/meson/pinctrl-meson-axg.c        | 1 -
 drivers/pinctrl/meson/pinctrl-meson-g12a.c       | 1 -
 drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c     | 1 -
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c       | 1 -
 drivers/pinctrl/meson/pinctrl-meson-gxl.c        | 1 -
 drivers/pinctrl/meson/pinctrl-meson.c            | 1 -
 drivers/pinctrl/mscc/mscc-common.c               | 1 -
 drivers/pinctrl/mscc/pinctrl-jr2.c               | 1 -
 drivers/pinctrl/mscc/pinctrl-luton.c             | 1 -
 drivers/pinctrl/mscc/pinctrl-ocelot.c            | 1 -
 drivers/pinctrl/mscc/pinctrl-serval.c            | 1 -
 drivers/pinctrl/mscc/pinctrl-servalt.c           | 1 -
 drivers/pinctrl/mtmips/pinctrl-mt7628.c          | 1 -
 drivers/pinctrl/mtmips/pinctrl-mtmips-common.c   | 1 -
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c      | 1 -
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c       | 1 -
 drivers/pinctrl/mvebu/pinctrl-mvebu.c            | 1 -
 drivers/pinctrl/nexell/pinctrl-nexell.c          | 1 -
 drivers/pinctrl/nexell/pinctrl-s5pxx18.c         | 1 -
 drivers/pinctrl/nxp/pinctrl-imx.c                | 1 -
 drivers/pinctrl/nxp/pinctrl-imx5.c               | 1 -
 drivers/pinctrl/nxp/pinctrl-imx6.c               | 1 -
 drivers/pinctrl/nxp/pinctrl-imx7.c               | 1 -
 drivers/pinctrl/nxp/pinctrl-imx7ulp.c            | 1 -
 drivers/pinctrl/nxp/pinctrl-imx8.c               | 1 -
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c            | 1 -
 drivers/pinctrl/nxp/pinctrl-imxrt.c              | 1 -
 drivers/pinctrl/nxp/pinctrl-mxs.c                | 1 -
 drivers/pinctrl/nxp/pinctrl-scu.c                | 1 -
 drivers/pinctrl/nxp/pinctrl-vf610.c              | 1 -
 drivers/pinctrl/pinctrl-apple.c                  | 1 -
 drivers/pinctrl/pinctrl-at91-pio4.c              | 1 -
 drivers/pinctrl/pinctrl-at91.c                   | 1 -
 drivers/pinctrl/pinctrl-generic.c                | 1 -
 drivers/pinctrl/pinctrl-k210.c                   | 1 -
 drivers/pinctrl/pinctrl-qe-io.c                  | 1 -
 drivers/pinctrl/pinctrl-sandbox.c                | 1 -
 drivers/pinctrl/pinctrl-single.c                 | 1 -
 drivers/pinctrl/pinctrl-sti.c                    | 1 -
 drivers/pinctrl/pinctrl-stmfx.c                  | 1 -
 drivers/pinctrl/pinctrl-uclass.c                 | 1 -
 drivers/pinctrl/pinctrl-zynqmp.c                 | 1 -
 drivers/pinctrl/pinctrl_pic32.c                  | 1 -
 drivers/pinctrl/pinctrl_stm32.c                  | 1 -
 drivers/pinctrl/qcom/pinctrl-apq8016.c           | 1 -
 drivers/pinctrl/qcom/pinctrl-apq8096.c           | 1 -
 drivers/pinctrl/qcom/pinctrl-ipq4019.c           | 1 -
 drivers/pinctrl/qcom/pinctrl-qcom.c              | 1 -
 drivers/pinctrl/qcom/pinctrl-qcs404.c            | 1 -
 drivers/pinctrl/qcom/pinctrl-sdm845.c            | 1 -
 drivers/pinctrl/rockchip/pinctrl-px30.c          | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3036.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3066.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3128.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3188.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk322x.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3288.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3308.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3328.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3368.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3399.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3568.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3588.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 1 -
 drivers/pinctrl/rockchip/pinctrl-rv1108.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rv1126.c        | 1 -
 drivers/pinctrl/starfive/pinctrl-starfive.c      | 1 -
 drivers/pinctrl/tegra/funcmux-tegra114.c         | 1 -
 drivers/pinctrl/tegra/funcmux-tegra124.c         | 1 -
 drivers/pinctrl/tegra/funcmux-tegra20.c          | 1 -
 drivers/pinctrl/tegra/funcmux-tegra210.c         | 1 -
 drivers/pinctrl/tegra/funcmux-tegra30.c          | 1 -
 drivers/pinctrl/tegra/pinmux-common.c            | 1 -
 drivers/pinctrl/tegra/pinmux-tegra114.c          | 1 -
 drivers/pinctrl/tegra/pinmux-tegra124.c          | 1 -
 drivers/pinctrl/tegra/pinmux-tegra20.c           | 1 -
 drivers/pinctrl/tegra/pinmux-tegra30.c           | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 1 -
 101 files changed, 101 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2500.c b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
index 93920a6389bf..9e7c347caf89 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2500.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
@@ -3,7 +3,6 @@
  * Copyright 2017 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2600.c b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
index 8a4f9705ca93..bc12590e5836 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2600.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
@@ -3,7 +3,6 @@
  * Copyright (C) ASPEED Technology Inc.
  */
 
-#include <common.h>
 #include <errno.h>
 #include <asm/arch/pinctrl.h>
 #include <asm/arch/scu_ast2600.h>
diff --git a/drivers/pinctrl/ath79/pinctrl_ar933x.c b/drivers/pinctrl/ath79/pinctrl_ar933x.c
index eb673a9f69cb..61e37a2e5598 100644
--- a/drivers/pinctrl/ath79/pinctrl_ar933x.c
+++ b/drivers/pinctrl/ath79/pinctrl_ar933x.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/pinctrl/ath79/pinctrl_qca953x.c b/drivers/pinctrl/ath79/pinctrl_qca953x.c
index 0d534268e966..e4f695fc4d44 100644
--- a/drivers/pinctrl/ath79/pinctrl_qca953x.c
+++ b/drivers/pinctrl/ath79/pinctrl_qca953x.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
index e949cb70900a..cf9350c151e0 100644
--- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
+++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
@@ -10,7 +10,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <config.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm6838.c b/drivers/pinctrl/broadcom/pinctrl-bcm6838.c
index 58f28a137096..7d0c09a130c6 100644
--- a/drivers/pinctrl/broadcom/pinctrl-bcm6838.c
+++ b/drivers/pinctrl/broadcom/pinctrl-bcm6838.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <common.h>
 #include <dm.h>
 #include <regmap.h>
 #include <syscon.h>
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index 8a045cdf7aa8..b393127c642c 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -6,7 +6,6 @@
  */
 
 #include <log.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos7420.c b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
index 77d510d8f600..8fdf60715a53 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos7420.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
@@ -5,7 +5,6 @@
  * Thomas Abraham <thomas.ab@samsung.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos78x0.c b/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
index 1b696fdfd288..61b98443daf3 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
@@ -9,7 +9,6 @@
  * Thomas Abraham <thomas.ab@samsung.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/drivers/pinctrl/intel/pinctrl.c b/drivers/pinctrl/intel/pinctrl.c
index 1607000dedc1..6cfe83a593a2 100644
--- a/drivers/pinctrl/intel/pinctrl.c
+++ b/drivers/pinctrl/intel/pinctrl.c
@@ -16,7 +16,6 @@
 
 #define LOG_CATEGORY UCLASS_GPIO
 
-#include <common.h>
 #include <dm.h>
 #include <irq.h>
 #include <log.h>
diff --git a/drivers/pinctrl/intel/pinctrl_apl.c b/drivers/pinctrl/intel/pinctrl_apl.c
index 181a6ff27026..e554d2854353 100644
--- a/drivers/pinctrl/intel/pinctrl_apl.c
+++ b/drivers/pinctrl/intel/pinctrl_apl.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_GPIO
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <log.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 0baef57c1c2f..37fc28bb7790 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -4,7 +4,6 @@
  * Author: Ryder Lee <ryder.lee@mediatek.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 30cf3bc0be4e..7e9ac6390b1e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -6,7 +6,6 @@
  * Author: Igor Prusov <ivprusov@sberdevices.ru>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <dt-bindings/gpio/meson-a1-gpio.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
index cfe94cf9e17d..52c726cf038e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -6,7 +6,6 @@
 
 #include <log.h>
 #include <asm/gpio.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <linux/io.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 820a6c9bb1aa..94e09cd3f8a2 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -7,7 +7,6 @@
  *  Author: Xingyu Chen <xingyu.chen@amlogic.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 90a4f8056cdb..24f47f825582 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -8,7 +8,6 @@
  * Author: Yixun Lan <yixun.lan@amlogic.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
index 99502d89c6c0..396b3a0e842e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
@@ -5,7 +5,6 @@
 
 #include <log.h>
 #include <asm/gpio.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 93a895c9fa7f..03ae1f9f8a5d 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -6,7 +6,6 @@
  *   Copyright (C) 2016 Endless Mobile, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <dt-bindings/gpio/meson-gxbb-gpio.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index a44145e2d4e8..16517f95ddbf 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -6,7 +6,6 @@
  *   Copyright (C) 2016 Endless Mobile, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <dt-bindings/gpio/meson-gxl-gpio.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index ee362d8464fc..babf1bccc969 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 - Beniamino Galvani <b.galvani@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/pinctrl/mscc/mscc-common.c b/drivers/pinctrl/mscc/mscc-common.c
index 307ed1db8750..2af5587ec47a 100644
--- a/drivers/pinctrl/mscc/mscc-common.c
+++ b/drivers/pinctrl/mscc/mscc-common.c
@@ -10,7 +10,6 @@
 
 #include <asm/gpio.h>
 #include <asm/system.h>
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/mscc/pinctrl-jr2.c b/drivers/pinctrl/mscc/pinctrl-jr2.c
index cb340581cc0f..4ef4040cd702 100644
--- a/drivers/pinctrl/mscc/pinctrl-jr2.c
+++ b/drivers/pinctrl/mscc/pinctrl-jr2.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/mscc/pinctrl-luton.c b/drivers/pinctrl/mscc/pinctrl-luton.c
index 325c9a9705b2..7707350aace6 100644
--- a/drivers/pinctrl/mscc/pinctrl-luton.c
+++ b/drivers/pinctrl/mscc/pinctrl-luton.c
@@ -7,7 +7,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/mscc/pinctrl-ocelot.c b/drivers/pinctrl/mscc/pinctrl-ocelot.c
index 57e2ef0d7c16..826388c2f746 100644
--- a/drivers/pinctrl/mscc/pinctrl-ocelot.c
+++ b/drivers/pinctrl/mscc/pinctrl-ocelot.c
@@ -10,7 +10,6 @@
 
 #include <asm/gpio.h>
 #include <asm/system.h>
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/mscc/pinctrl-serval.c b/drivers/pinctrl/mscc/pinctrl-serval.c
index a6b9796df81f..2081cd6750c8 100644
--- a/drivers/pinctrl/mscc/pinctrl-serval.c
+++ b/drivers/pinctrl/mscc/pinctrl-serval.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2019 Microsemi Corporation
  */
 
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/mscc/pinctrl-servalt.c b/drivers/pinctrl/mscc/pinctrl-servalt.c
index 8e8678580db1..efa4e26d9f72 100644
--- a/drivers/pinctrl/mscc/pinctrl-servalt.c
+++ b/drivers/pinctrl/mscc/pinctrl-servalt.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2019 Microsemi Corporation
  */
 
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/mtmips/pinctrl-mt7628.c b/drivers/pinctrl/mtmips/pinctrl-mt7628.c
index 79c63c7caec6..dc7acec4a77f 100644
--- a/drivers/pinctrl/mtmips/pinctrl-mt7628.c
+++ b/drivers/pinctrl/mtmips/pinctrl-mt7628.c
@@ -5,7 +5,6 @@
  * Author: Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c b/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c
index 869b78106851..bab34e97b615 100644
--- a/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c
+++ b/drivers/pinctrl/mtmips/pinctrl-mtmips-common.c
@@ -5,7 +5,6 @@
  * Author: Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index e834dddfd137..64036296e24d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -16,7 +16,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 252151f3e5d9..78184d2860a8 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // (C) 2022 Pali Rohár <pali@kernel.org>
 
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <dm/devres.h>
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index fd49a97b5b0a..0d5fa4ceb9ca 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -4,7 +4,6 @@
  * https://spdx.org/licenses
  */
 
-#include <common.h>
 #include <config.h>
 #include <fdtdec.h>
 #include <errno.h>
diff --git a/drivers/pinctrl/nexell/pinctrl-nexell.c b/drivers/pinctrl/nexell/pinctrl-nexell.c
index 20497a746d26..d5be7baf50dd 100644
--- a/drivers/pinctrl/nexell/pinctrl-nexell.c
+++ b/drivers/pinctrl/nexell/pinctrl-nexell.c
@@ -5,7 +5,6 @@
  * Bongyu, KOO <freestyle@nexell.co.kr>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/global_data.h>
diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
index 863eb1455d23..e7d0994f29e7 100644
--- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
+++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
@@ -7,7 +7,6 @@
  * (C) Copyright 2019 Stefan Bosch <stefan_b@posteo.net>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/global_data.h>
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 1596dcc4747e..ff466c491041 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
diff --git a/drivers/pinctrl/nxp/pinctrl-imx5.c b/drivers/pinctrl/nxp/pinctrl-imx5.c
index b32b748cfc63..6b690fdce8fd 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx5.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx5.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx6.c b/drivers/pinctrl/nxp/pinctrl-imx6.c
index 6994dbb61a3d..322eec87ff5d 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx6.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx6.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7.c b/drivers/pinctrl/nxp/pinctrl-imx7.c
index 77ddb8e0b9d5..a8275e26456b 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
index 6da9ff7c5bce..7ea2dbe7d36b 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
@@ -5,7 +5,6 @@
  * Peng Fan <peng.fan@nxp.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index 46af44ecb1f2..4e9a9ea68086 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index 4e8fa08bc6e3..73d3c009d5b6 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index 53b70da869ec..23f07f8d1e05 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -4,7 +4,6 @@
  * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/nxp/pinctrl-mxs.c b/drivers/pinctrl/nxp/pinctrl-mxs.c
index eb90e28d4b21..85ab5fdf6404 100644
--- a/drivers/pinctrl/nxp/pinctrl-mxs.c
+++ b/drivers/pinctrl/nxp/pinctrl-mxs.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <dm/device_compat.h>
diff --git a/drivers/pinctrl/nxp/pinctrl-scu.c b/drivers/pinctrl/nxp/pinctrl-scu.c
index 4959834c0fcd..42d5c96468c7 100644
--- a/drivers/pinctrl/nxp/pinctrl-scu.c
+++ b/drivers/pinctrl/nxp/pinctrl-scu.c
@@ -3,7 +3,6 @@
  * Copyright 2018-2019 NXP
  */
 
-#include <common.h>
 #include <errno.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index 14e2e9d3ee61..adf3073f1be0 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/pinctrl-apple.c b/drivers/pinctrl/pinctrl-apple.c
index 62476358c349..f373afde58e4 100644
--- a/drivers/pinctrl/pinctrl-apple.c
+++ b/drivers/pinctrl/pinctrl-apple.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 84b398619c47..c697a4c3456a 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -6,7 +6,6 @@
  *               Wenyou.Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index b7aab12f11c1..5038cb535e38 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -6,7 +6,6 @@
  *               Wenyou.Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/drivers/pinctrl/pinctrl-generic.c b/drivers/pinctrl/pinctrl-generic.c
index 8909b57810af..2464acf0b854 100644
--- a/drivers/pinctrl/pinctrl-generic.c
+++ b/drivers/pinctrl/pinctrl-generic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015  Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/compat.h>
diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index ee35dfe14203..dad036610c9e 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/pinctrl-qe-io.c b/drivers/pinctrl/pinctrl-qe-io.c
index dc0be7ce3bd6..61db9274cc3e 100644
--- a/drivers/pinctrl/pinctrl-qe-io.c
+++ b/drivers/pinctrl/pinctrl-qe-io.c
@@ -6,7 +6,6 @@
  * based on source code of Shlomi Gridish
  */
 
-#include <common.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/immap_83xx.h>
diff --git a/drivers/pinctrl/pinctrl-sandbox.c b/drivers/pinctrl/pinctrl-sandbox.c
index 776597745099..a5d056643a0f 100644
--- a/drivers/pinctrl/pinctrl-sandbox.c
+++ b/drivers/pinctrl/pinctrl-sandbox.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <dt-bindings/pinctrl/sandbox-pinmux.h>
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index d1db377c1379..a3802d22d4f9 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2021 Dario Binacchi <dariobin@libero.it>
  */
 
-#include <common.h>
 #include <mapmem.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/pinctrl/pinctrl-sti.c b/drivers/pinctrl/pinctrl-sti.c
index 1ff7ea005551..4996b69d9afb 100644
--- a/drivers/pinctrl/pinctrl-sti.c
+++ b/drivers/pinctrl/pinctrl-sti.c
@@ -6,7 +6,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <bitfield.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 509e2a80e9a5..61f335c4eb14 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_PINCTRL
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <i2c.h>
diff --git a/drivers/pinctrl/pinctrl-uclass.c b/drivers/pinctrl/pinctrl-uclass.c
index fe2ba5021a78..d9bda7494e23 100644
--- a/drivers/pinctrl/pinctrl-uclass.c
+++ b/drivers/pinctrl/pinctrl-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_PINCTRL
 
-#include <common.h>
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <dm/device_compat.h>
diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index eb17a4290b7d..6fa203a3b861 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2021 Xilinx, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <malloc.h>
diff --git a/drivers/pinctrl/pinctrl_pic32.c b/drivers/pinctrl/pinctrl_pic32.c
index 54d97ac0ae37..9f38b56e9c0e 100644
--- a/drivers/pinctrl/pinctrl_pic32.c
+++ b/drivers/pinctrl/pinctrl_pic32.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2015 Microchip Technology Inc.
  * Written by Purna Chandra Mandal <purna.mandal@microchip.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index 7120b8edba00..eada1001240c 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_PINCTRL
 
-#include <common.h>
 #include <dm.h>
 #include <hwspinlock.h>
 #include <log.h>
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index b14a8921af4f..0c7437822ff2 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 
 #include "pinctrl-qcom.h"
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
index 9697cb5beb7a..132ece868bf2 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 
 #include "pinctrl-qcom.h"
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 26ab487857fe..3215c677b263 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -7,7 +7,6 @@
  * Author: Robert Marko <robert.marko@sartura.hr>
  */
 
-#include <common.h>
 #include <dm.h>
 
 #include "pinctrl-qcom.h"
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index e68971b37ff0..3c3336e76358 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index 4b7c670c90b7..fb6defaeddf0 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
  */
 
-#include <common.h>
 #include <dm.h>
 
 #include "pinctrl-qcom.h"
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index c1e5cc01fded..f1a23f510999 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 
 #include "pinctrl-qcom.h"
diff --git a/drivers/pinctrl/rockchip/pinctrl-px30.c b/drivers/pinctrl/rockchip/pinctrl-px30.c
index 2c35491b24d8..cc7885bae408 100644
--- a/drivers/pinctrl/rockchip/pinctrl-px30.c
+++ b/drivers/pinctrl/rockchip/pinctrl-px30.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3036.c b/drivers/pinctrl/rockchip/pinctrl-rk3036.c
index afcd34396e27..b14386ccd937 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3036.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3036.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <regmap.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3066.c b/drivers/pinctrl/rockchip/pinctrl-rk3066.c
index 598b63223e36..60e088a9a6f0 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3066.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3066.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <regmap.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3128.c b/drivers/pinctrl/rockchip/pinctrl-rk3128.c
index 355c45eb7f8c..d00fc3da8b23 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3128.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3128.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <regmap.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3188.c b/drivers/pinctrl/rockchip/pinctrl-rk3188.c
index 9a982cbfad9c..83db51f66ae4 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3188.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3188.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk322x.c b/drivers/pinctrl/rockchip/pinctrl-rk322x.c
index 351406da2d45..b804597c0484 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk322x.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk322x.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3288.c b/drivers/pinctrl/rockchip/pinctrl-rk3288.c
index a976b7aeeb27..3870c1b7a341 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3288.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3288.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3308.c b/drivers/pinctrl/rockchip/pinctrl-rk3308.c
index f9ac6347eaf1..2cd91b10a3bd 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3308.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3308.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3328.c b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
index 65a750076773..47c2e923a1bb 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3328.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3368.c b/drivers/pinctrl/rockchip/pinctrl-rk3368.c
index ba867a891748..9ae06ed19e9c 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3368.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3368.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3399.c b/drivers/pinctrl/rockchip/pinctrl-rk3399.c
index ae785573baf5..b7a5092c032b 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3399.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3399.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3568.c b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
index 1d4391982605..5deedc648a41 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3568.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2020 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <regmap.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3588.c b/drivers/pinctrl/rockchip/pinctrl-rk3588.c
index 548cf09bcca4..98ababc7c907 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3588.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3588.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <regmap.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 8ef089994f46..3e74e2f14895 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1108.c b/drivers/pinctrl/rockchip/pinctrl-rv1108.c
index 5b70b503d2b1..3eff5f59598c 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rv1108.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1108.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1126.c b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
index eefb8b17768b..efa2408b204b 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rv1126.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2020 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.c b/drivers/pinctrl/starfive/pinctrl-starfive.c
index 9b09cc21cfaa..95b1a752de2e 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive.c
@@ -7,7 +7,6 @@
  *   Author: Jianlong Huang <jianlong.huang@starfivetech.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/pinctrl/tegra/funcmux-tegra114.c b/drivers/pinctrl/tegra/funcmux-tegra114.c
index 23a27c868881..23e9e2383679 100644
--- a/drivers/pinctrl/tegra/funcmux-tegra114.c
+++ b/drivers/pinctrl/tegra/funcmux-tegra114.c
@@ -5,7 +5,6 @@
 
 /* Tegra114 high-level function multiplexing */
 
-#include <common.h>
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/drivers/pinctrl/tegra/funcmux-tegra124.c b/drivers/pinctrl/tegra/funcmux-tegra124.c
index e7ad85fde2d0..b041cead3446 100644
--- a/drivers/pinctrl/tegra/funcmux-tegra124.c
+++ b/drivers/pinctrl/tegra/funcmux-tegra124.c
@@ -6,7 +6,6 @@
 
 /* Tegra124 high-level function multiplexing */
 
-#include <common.h>
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/drivers/pinctrl/tegra/funcmux-tegra20.c b/drivers/pinctrl/tegra/funcmux-tegra20.c
index 90fe0cba8ea4..b8c913237853 100644
--- a/drivers/pinctrl/tegra/funcmux-tegra20.c
+++ b/drivers/pinctrl/tegra/funcmux-tegra20.c
@@ -4,7 +4,6 @@
  */
 
 /* Tegra20 high-level function multiplexing */
-#include <common.h>
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/drivers/pinctrl/tegra/funcmux-tegra210.c b/drivers/pinctrl/tegra/funcmux-tegra210.c
index 30d994a17ffa..d52b6150e590 100644
--- a/drivers/pinctrl/tegra/funcmux-tegra210.c
+++ b/drivers/pinctrl/tegra/funcmux-tegra210.c
@@ -6,7 +6,6 @@
 
 /* Tegra210 high-level function multiplexing */
 
-#include <common.h>
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/drivers/pinctrl/tegra/funcmux-tegra30.c b/drivers/pinctrl/tegra/funcmux-tegra30.c
index c3ee787f33b1..e31b859beb8a 100644
--- a/drivers/pinctrl/tegra/funcmux-tegra30.c
+++ b/drivers/pinctrl/tegra/funcmux-tegra30.c
@@ -5,7 +5,6 @@
 
 /* Tegra30 high-level function multiplexing */
 
-#include <common.h>
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/drivers/pinctrl/tegra/pinmux-common.c b/drivers/pinctrl/tegra/pinmux-common.c
index 16b03bfe7b06..5266c8db4876 100644
--- a/drivers/pinctrl/tegra/pinmux-common.c
+++ b/drivers/pinctrl/tegra/pinmux-common.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch/pinmux.h>
diff --git a/drivers/pinctrl/tegra/pinmux-tegra114.c b/drivers/pinctrl/tegra/pinmux-tegra114.c
index 11796602c548..15c6b653aed8 100644
--- a/drivers/pinctrl/tegra/pinmux-tegra114.c
+++ b/drivers/pinctrl/tegra/pinmux-tegra114.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010-2014, NVIDIA CORPORATION. All rights reserved.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/pinmux.h>
 
diff --git a/drivers/pinctrl/tegra/pinmux-tegra124.c b/drivers/pinctrl/tegra/pinmux-tegra124.c
index 261ce64b205e..6d5b720aa0e6 100644
--- a/drivers/pinctrl/tegra/pinmux-tegra124.c
+++ b/drivers/pinctrl/tegra/pinmux-tegra124.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013-2014, NVIDIA CORPORATION. All rights reserved.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/pinmux.h>
 
diff --git a/drivers/pinctrl/tegra/pinmux-tegra20.c b/drivers/pinctrl/tegra/pinmux-tegra20.c
index 0af39e74c53b..c1f86476b9ef 100644
--- a/drivers/pinctrl/tegra/pinmux-tegra20.c
+++ b/drivers/pinctrl/tegra/pinmux-tegra20.c
@@ -5,7 +5,6 @@
 
 /* Tegra20 pin multiplexing functions */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/pinmux.h>
 
diff --git a/drivers/pinctrl/tegra/pinmux-tegra30.c b/drivers/pinctrl/tegra/pinmux-tegra30.c
index d11b2aa572df..59ce9cea4a97 100644
--- a/drivers/pinctrl/tegra/pinmux-tegra30.c
+++ b/drivers/pinctrl/tegra/pinmux-tegra30.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010-2014, NVIDIA CORPORATION. All rights reserved.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/pinmux.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index bdca3f2f7156..eafb65496a3d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index a1a3cd73859a..778a9899483c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index 7a92a46c17f5..3ef10151dabf 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index d33e4d7dd259..9302e309e20f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 0e3eb131ecf7..f7c5bf3bcaed 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 7ba2266092f0..2704a50749e5 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 9ce2e2c270ef..655ec6e60573 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index e8c2018097c2..226272c2b82f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
index 8a8f1269bb51..8df13ca209c7 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -5,7 +5,6 @@
  *   Author: Dai Okamura <dai.okamura@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index 04c06fb280e2..c045ae99ac53 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
 
-- 
2.34.1

