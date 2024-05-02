Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84332C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0BA88D46;
	Thu,  2 May 2024 03:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aVQu/bgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F56D88CC2; Thu,  2 May 2024 03:33:53 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFA688CC5
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43969307359so46365671cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613629; x=1715218429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+WTxI28fGAy1foyqmfFFv58IoPsFR41MqEQ50q4qGg=;
 b=aVQu/bgTdBR/RyEtTOVUhf7ItNJtJ/EPueIzyBFMBHbjHPENSy3e3ii9ge9mNn3VmQ
 urDK/E3ao557/65ijQtnCKrWa6CRcOySmiIhBy4v8zRuuLNQbqsRWehBH2KRxMaTmwpv
 zc/10ddWdomtrElRRVTpgvAXwJ7Xl4E55aKUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613629; x=1715218429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+WTxI28fGAy1foyqmfFFv58IoPsFR41MqEQ50q4qGg=;
 b=T7E7StOb8/DyiQqUm0lLDIAmnvWvVHiWlf2tghfxxe4soZc1sn47il1WHP+6ZP8HIO
 xOdJnHvbIgc4LRWKjB3oeq1zfujhc79IPGWoE+Qd6Ny4IhcU8y7v5UAsTxIb7tIkDKh0
 H43rhT6oOjLtDec05X/MdVRFEZg0jBMcnvfkSpsgiV71uhdGUvwvFXQ7q3Yp9YJ5Vkbq
 wPelgUKVgnRUuf105wqvIFvGe9oX1gVESl3g8tFf/YSFVpPNvNjnR/Yw7D2X4N0nksTp
 GExwHcJ+SFhprX3aInrQSDHQtn5Zxy7GUlWm1zYbGaIfyFawRMGHGbOhcAOAF2HmU8Yp
 /TVw==
X-Gm-Message-State: AOJu0Yw+I45TSu6zRODB7tgN+XhSsNpc87XhCzWHxOUdm9Gj1LyqxQR1
 dKfOyFguql6Oxax4624Be2V0OXYiwgC7auQubxvGkuJgTJyrISbcx1Ksp6SClMVNhEuZ1stCoYH
 o96uzrEos
X-Google-Smtp-Source: AGHT+IG+4D2UWhFpSEbig/yeDRZwmrjuEl/Kk9JuUlY9jR+ITpUrKeQGpCuv+jqCdBINNtGobfuMZg==
X-Received: by 2002:a05:622a:178b:b0:43a:e77c:352a with SMTP id
 s11-20020a05622a178b00b0043ae77c352amr5079189qtk.17.1714613629224; 
 Wed, 01 May 2024 18:33:49 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Joel Peshkin <joel.peshkin@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Robert Marko <robert.marko@sartura.hr>,
 Luka Kovacic <luka.kovacic@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>
Subject: [PATCH 65/81] spi: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:22 -0600
Message-Id: <20240502013138.2383421-65-trini@konsulko.com>
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Anand Gore <anand.gore@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>
Cc: Kursad Oney <kursad.oney@broadcom.com>
Cc: Joel Peshkin <joel.peshkin@broadcom.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Dai Okamura <okamura.dai@socionext.com>
---
 drivers/spi/altera_spi.c          | 1 -
 drivers/spi/apple_spi.c           | 1 -
 drivers/spi/atcspi200_spi.c       | 1 -
 drivers/spi/ath79_spi.c           | 1 -
 drivers/spi/atmel-quadspi.c       | 1 -
 drivers/spi/atmel_spi.c           | 1 -
 drivers/spi/bcm63xx_hsspi.c       | 1 -
 drivers/spi/bcm63xx_spi.c         | 1 -
 drivers/spi/bcmbca_hsspi.c        | 1 -
 drivers/spi/ca_sflash.c           | 1 -
 drivers/spi/cadence_ospi_versal.c | 1 -
 drivers/spi/cadence_qspi.c        | 1 -
 drivers/spi/cadence_qspi_apb.c    | 1 -
 drivers/spi/cf_spi.c              | 1 -
 drivers/spi/davinci_spi.c         | 2 +-
 drivers/spi/designware_spi.c      | 1 -
 drivers/spi/exynos_spi.c          | 1 -
 drivers/spi/fsl_dspi.c            | 1 -
 drivers/spi/fsl_espi.c            | 2 +-
 drivers/spi/fsl_qspi.c            | 1 -
 drivers/spi/ich.c                 | 1 -
 drivers/spi/iproc_qspi.c          | 1 -
 drivers/spi/kirkwood_spi.c        | 2 +-
 drivers/spi/meson_spifc.c         | 1 -
 drivers/spi/microchip_coreqspi.c  | 1 -
 drivers/spi/mpc8xx_spi.c          | 1 -
 drivers/spi/mpc8xxx_spi.c         | 1 -
 drivers/spi/mscc_bb_spi.c         | 1 -
 drivers/spi/mt7621_spi.c          | 1 -
 drivers/spi/mtk_snfi_spi.c        | 1 -
 drivers/spi/mtk_snor.c            | 1 -
 drivers/spi/mvebu_a3700_spi.c     | 1 -
 drivers/spi/mxc_spi.c             | 2 +-
 drivers/spi/mxs_spi.c             | 1 -
 drivers/spi/npcm_pspi.c           | 1 -
 drivers/spi/nxp_fspi.c            | 1 -
 drivers/spi/omap3_spi.c           | 2 +-
 drivers/spi/pic32_spi.c           | 1 -
 drivers/spi/pl022_spi.c           | 1 -
 drivers/spi/renesas_rpc_spi.c     | 1 -
 drivers/spi/rk_spi.c              | 1 -
 drivers/spi/sandbox_spi.c         | 1 -
 drivers/spi/sh_qspi.c             | 1 -
 drivers/spi/soft_spi.c            | 1 -
 drivers/spi/spi-aspeed-smc.c      | 1 -
 drivers/spi/spi-emul-uclass.c     | 1 -
 drivers/spi/spi-mem.c             | 1 -
 drivers/spi/spi-mxic.c            | 1 -
 drivers/spi/spi-qup.c             | 1 -
 drivers/spi/spi-sifive.c          | 1 -
 drivers/spi/spi-sn-f-ospi.c       | 1 -
 drivers/spi/spi-sunxi.c           | 1 -
 drivers/spi/spi-synquacer.c       | 1 -
 drivers/spi/spi-uclass.c          | 1 -
 drivers/spi/spi.c                 | 1 -
 drivers/spi/stm32_qspi.c          | 1 -
 drivers/spi/stm32_spi.c           | 1 -
 drivers/spi/tegra114_spi.c        | 1 -
 drivers/spi/tegra20_sflash.c      | 1 -
 drivers/spi/tegra20_slink.c       | 1 -
 drivers/spi/tegra210_qspi.c       | 1 -
 drivers/spi/ti_qspi.c             | 1 -
 drivers/spi/uniphier_spi.c        | 1 -
 drivers/spi/xilinx_spi.c          | 1 -
 drivers/spi/zynq_qspi.c           | 1 -
 drivers/spi/zynq_spi.c            | 1 -
 drivers/spi/zynqmp_gqspi.c        | 1 -
 67 files changed, 5 insertions(+), 67 deletions(-)

diff --git a/drivers/spi/altera_spi.c b/drivers/spi/altera_spi.c
index 989679e881b5..8e227d187b0c 100644
--- a/drivers/spi/altera_spi.c
+++ b/drivers/spi/altera_spi.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2005-2008 Analog Devices Inc.
  * Copyright (C) 2010 Thomas Chou <thomas@wytron.com.tw>
  */
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/spi/apple_spi.c b/drivers/spi/apple_spi.c
index f35f5af1f6f8..5f94e9f7a74d 100644
--- a/drivers/spi/apple_spi.c
+++ b/drivers/spi/apple_spi.c
@@ -4,7 +4,6 @@
  * Copyright The Asahi Linux Contributors
  */
 
-#include <common.h>
 #include <dm.h>
 #include <clk.h>
 #include <spi.h>
diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 70cb242cd31e..929bf90458c3 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -6,7 +6,6 @@
  * Author: Rick Chen (rick@andestech.com)
  */
 
-#include <common.h>
 #include <clk.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/spi/ath79_spi.c b/drivers/spi/ath79_spi.c
index 205567ef54dd..faefac712608 100644
--- a/drivers/spi/ath79_spi.c
+++ b/drivers/spi/ath79_spi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <spi.h>
 #include <dm.h>
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index bd73e4fddf18..3efb661803b6 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -12,7 +12,6 @@
 #include <malloc.h>
 #include <asm/io.h>
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index d4f0c4c44836..79f010013184 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2007 Atmel Corporation
  */
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/drivers/spi/bcm63xx_hsspi.c b/drivers/spi/bcm63xx_hsspi.c
index 23ac5bb76c04..1aa43fd3a238 100644
--- a/drivers/spi/bcm63xx_hsspi.c
+++ b/drivers/spi/bcm63xx_hsspi.c
@@ -7,7 +7,6 @@
  *	Copyright (C) 2012-2013 Jonas Gorski <jogo@openwrt.org>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/bcm63xx_spi.c b/drivers/spi/bcm63xx_spi.c
index 889ac1f966e3..595b41c8ab8a 100644
--- a/drivers/spi/bcm63xx_spi.c
+++ b/drivers/spi/bcm63xx_spi.c
@@ -7,7 +7,6 @@
  *	Copyright (C) 2010 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/bcmbca_hsspi.c b/drivers/spi/bcmbca_hsspi.c
index af45882db0a7..eff9e1117d35 100644
--- a/drivers/spi/bcmbca_hsspi.c
+++ b/drivers/spi/bcmbca_hsspi.c
@@ -8,7 +8,6 @@
  *	Copyright (C) 2021 Broadcom Ltd
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <spi.h>
diff --git a/drivers/spi/ca_sflash.c b/drivers/spi/ca_sflash.c
index 38bddd38619e..a99a8a4485ab 100644
--- a/drivers/spi/ca_sflash.c
+++ b/drivers/spi/ca_sflash.c
@@ -7,7 +7,6 @@
  * Author: PengPeng Chen <pengpeng.chen@cortina-access.com>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index c2be307f1d87..222f828f54ec 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -6,7 +6,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <memalign.h>
 #include <wait_bit.h>
 #include <asm/io.h>
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index f4593c47b8c5..75e522320101 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -4,7 +4,6 @@
  * Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <log.h>
 #include <dm.h>
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index fb9053221782..93ab2b5635f3 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -25,7 +25,6 @@
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <dma.h>
diff --git a/drivers/spi/cf_spi.c b/drivers/spi/cf_spi.c
index 1a841b5dcefc..8234468b1d43 100644
--- a/drivers/spi/cf_spi.c
+++ b/drivers/spi/cf_spi.c
@@ -13,7 +13,6 @@
  * TODO: fsl_dspi.c should work as a driver for the DSPI module.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 25f5e9fdebd5..04c134be9edf 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2007 Atmel Corporation
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <spi.h>
 #include <malloc.h>
diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 22a79da2333e..6bd48b1b3739 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -11,7 +11,6 @@
  */
 
 #define LOG_CATEGORY UCLASS_SPI
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/spi/exynos_spi.c b/drivers/spi/exynos_spi.c
index 1bcc3ad318db..1b9bf004b7c1 100644
--- a/drivers/spi/exynos_spi.c
+++ b/drivers/spi/exynos_spi.c
@@ -4,7 +4,6 @@
  * Padmavathi Venna <padma.v@samsung.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index 9b3d5a94817f..1d4d90ce5aaf 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -11,7 +11,6 @@
 
 #include <asm/global_data.h>
 #include <linux/math64.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
index b1d964d79d0c..2638ed252001 100644
--- a/drivers/spi/fsl_espi.c
+++ b/drivers/spi/fsl_espi.c
@@ -8,7 +8,7 @@
  *	   Chuanhua Han (chuanhua.han@nxp.com)
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 3f97730bad0b..8a0a53cb3720 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -23,7 +23,6 @@
  * Transition to spi-mem in spi-fsl-qspi.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <log.h>
diff --git a/drivers/spi/ich.c b/drivers/spi/ich.c
index 9142ffd23870..e48ca65fe726 100644
--- a/drivers/spi/ich.c
+++ b/drivers/spi/ich.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY	UCLASS_SPI
 
-#include <common.h>
 #include <bootstage.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/spi/iproc_qspi.c b/drivers/spi/iproc_qspi.c
index b5c274314b5b..09f30c227023 100644
--- a/drivers/spi/iproc_qspi.c
+++ b/drivers/spi/iproc_qspi.c
@@ -3,7 +3,6 @@
  * Copyright 2020-2021 Broadcom
  */
 
-#include <common.h>
 #include <dm.h>
 #include <spi.h>
 #include <spi-mem.h>
diff --git a/drivers/spi/kirkwood_spi.c b/drivers/spi/kirkwood_spi.c
index 2bb7390bbfb7..095cbea0fca9 100644
--- a/drivers/spi/kirkwood_spi.c
+++ b/drivers/spi/kirkwood_spi.c
@@ -7,7 +7,7 @@
  * Derived from drivers/spi/mpc8xxx_spi.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/spi/meson_spifc.c b/drivers/spi/meson_spifc.c
index d99a151406e6..d7ebb6bf1ac7 100644
--- a/drivers/spi/meson_spifc.c
+++ b/drivers/spi/meson_spifc.c
@@ -7,7 +7,6 @@
  * Amlogic Meson SPI Flash Controller driver
  */
 
-#include <common.h>
 #include <log.h>
 #include <spi.h>
 #include <clk.h>
diff --git a/drivers/spi/microchip_coreqspi.c b/drivers/spi/microchip_coreqspi.c
index 5fe0c8e1237e..234b16882726 100644
--- a/drivers/spi/microchip_coreqspi.c
+++ b/drivers/spi/microchip_coreqspi.c
@@ -5,7 +5,6 @@
  * Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/mpc8xx_spi.c b/drivers/spi/mpc8xx_spi.c
index e1448cc61969..7e72fb9e23dc 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -16,7 +16,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <mpc8xx.h>
diff --git a/drivers/spi/mpc8xxx_spi.c b/drivers/spi/mpc8xxx_spi.c
index 7d15390c56b3..cd624f4d6f0b 100644
--- a/drivers/spi/mpc8xxx_spi.c
+++ b/drivers/spi/mpc8xxx_spi.c
@@ -4,7 +4,6 @@
  * With help from the common/soft_spi and arch/powerpc/cpu/mpc8260 drivers
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/spi/mscc_bb_spi.c b/drivers/spi/mscc_bb_spi.c
index 95bea0da1b35..ad4daeba3cd8 100644
--- a/drivers/spi/mscc_bb_spi.c
+++ b/drivers/spi/mscc_bb_spi.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/spi/mt7621_spi.c b/drivers/spi/mt7621_spi.c
index 3d0080998625..e46942de2e3b 100644
--- a/drivers/spi/mt7621_spi.c
+++ b/drivers/spi/mt7621_spi.c
@@ -8,7 +8,6 @@
  *   Copyright (C) 2014-2015 Felix Fietkau <nbd@nbd.name>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/mtk_snfi_spi.c b/drivers/spi/mtk_snfi_spi.c
index 3decb3744de9..830424b31d6a 100644
--- a/drivers/spi/mtk_snfi_spi.c
+++ b/drivers/spi/mtk_snfi_spi.c
@@ -5,7 +5,6 @@
  * Author: Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 4b7d4a6e0741..f202b2f49f58 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -7,7 +7,6 @@
 // Some parts are based on drivers/spi/spi-mtk-nor.c of linux version
 
 #include <clk.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device.h>
diff --git a/drivers/spi/mvebu_a3700_spi.c b/drivers/spi/mvebu_a3700_spi.c
index bba2383a1116..fde9b142fb89 100644
--- a/drivers/spi/mvebu_a3700_spi.c
+++ b/drivers/spi/mvebu_a3700_spi.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index e291092c481a..ff61a14f095d 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2008, Guennadi Liakhovetski <lg@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/mxs_spi.c b/drivers/spi/mxs_spi.c
index 773e26bbed74..ad9e490faa9f 100644
--- a/drivers/spi/mxs_spi.c
+++ b/drivers/spi/mxs_spi.c
@@ -12,7 +12,6 @@
  *       GPIO driven chipselects are not supported.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <cpu_func.h>
diff --git a/drivers/spi/npcm_pspi.c b/drivers/spi/npcm_pspi.c
index eb14185273e9..36d1f174bebb 100644
--- a/drivers/spi/npcm_pspi.c
+++ b/drivers/spi/npcm_pspi.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2021 Nuvoton Technology.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <spi.h>
 #include <clk.h>
diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 5db27f9ae2c9..fefdaaa9e901 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -33,7 +33,6 @@
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/spi/omap3_spi.c b/drivers/spi/omap3_spi.c
index 5cce6baa6213..3d82fc74ff58 100644
--- a/drivers/spi/omap3_spi.c
+++ b/drivers/spi/omap3_spi.c
@@ -16,9 +16,9 @@
  * Modified by Ruslan Araslanov <ruslan.araslanov@vitecmm.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <spi.h>
+#include <time.h>
 #include <malloc.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/spi/pic32_spi.c b/drivers/spi/pic32_spi.c
index 45f07f083da8..e11ae7fc7a4a 100644
--- a/drivers/spi/pic32_spi.c
+++ b/drivers/spi/pic32_spi.c
@@ -6,7 +6,6 @@
  *      Purna Chandra Mandal <purna.mandal@microchip.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/pl022_spi.c b/drivers/spi/pl022_spi.c
index e2b49ebd149a..1e20701d0d35 100644
--- a/drivers/spi/pl022_spi.c
+++ b/drivers/spi/pl022_spi.c
@@ -10,7 +10,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <fdtdec.h>
diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 8aff22386458..e6b602cf7b47 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <clk.h>
diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index c8694fdff954..4571dc9f9b69 100644
--- a/drivers/spi/rk_spi.c
+++ b/drivers/spi/rk_spi.c
@@ -10,7 +10,6 @@
  * Peter, Software Engineering, <superpeter.cai@gmail.com>.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index f844597d04cf..4cc016138b11 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -10,7 +10,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/spi/sh_qspi.c b/drivers/spi/sh_qspi.c
index 72594993853b..b7364a61929f 100644
--- a/drivers/spi/sh_qspi.c
+++ b/drivers/spi/sh_qspi.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI
 
-#include <common.h>
 #include <console.h>
 #include <malloc.h>
 #include <spi.h>
diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 0fa14339bdcd..9bdb4a5bff9b 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -9,7 +9,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 7d5f101a7662..d91d58da4596 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -12,7 +12,6 @@
 
 #include <asm/io.h>
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/drivers/spi/spi-emul-uclass.c b/drivers/spi/spi-emul-uclass.c
index 64bc19c00112..d92f36bd20e5 100644
--- a/drivers/spi/spi-emul-uclass.c
+++ b/drivers/spi/spi-emul-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI_EMUL
 
-#include <common.h>
 #include <dm.h>
 #include <spi.h>
 #include <spi_flash.h>
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b7eca5835956..3579b7d7db58 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -13,7 +13,6 @@
 #include <linux/pm_runtime.h>
 #include "internals.h"
 #else
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <malloc.h>
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f663b9dcbb16..b98bcd9b6ba5 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -6,7 +6,6 @@
  *	zhengxunli <zhengxunli@mxic.com.tw>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 572cef1694c8..836c550b0bb6 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -15,7 +15,6 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <linux/delay.h>
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index ea372a05f836..0c8666c05f94 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -6,7 +6,6 @@
  * SiFive SPI controller driver (master mode only)
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <malloc.h>
diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index e3633a526080..fc82791006ec 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/bitfield.h>
diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index 9ec6b359e227..13725ee7a2dc 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -18,7 +18,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 553f9687e3b3..eb522fd7b3d9 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -6,7 +6,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <time.h>
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index f4795e68672f..6e2817252391 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 22910de0dd93..50a076a98be6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <malloc.h>
 #include <spi.h>
diff --git a/drivers/spi/stm32_qspi.c b/drivers/spi/stm32_qspi.c
index 2ffa201a66ed..2812a4da4113 100644
--- a/drivers/spi/stm32_qspi.c
+++ b/drivers/spi/stm32_qspi.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index ddb410a94c01..97b83b171670 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/spi/tegra114_spi.c b/drivers/spi/tegra114_spi.c
index f0256d8e6641..57f1a8fc703f 100644
--- a/drivers/spi/tegra114_spi.c
+++ b/drivers/spi/tegra114_spi.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2010-2013 NVIDIA Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <time.h>
diff --git a/drivers/spi/tegra20_sflash.c b/drivers/spi/tegra20_sflash.c
index 10e38cf839dc..19114808e9df 100644
--- a/drivers/spi/tegra20_sflash.c
+++ b/drivers/spi/tegra20_sflash.c
@@ -5,7 +5,6 @@
  * With more help from omap3_spi SPI driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/spi/tegra20_slink.c b/drivers/spi/tegra20_slink.c
index d0e788539e0b..d54a5049205b 100644
--- a/drivers/spi/tegra20_slink.c
+++ b/drivers/spi/tegra20_slink.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2010-2013 NVIDIA Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <time.h>
diff --git a/drivers/spi/tegra210_qspi.c b/drivers/spi/tegra210_qspi.c
index 5c8c1859cc96..b969a7993d40 100644
--- a/drivers/spi/tegra210_qspi.c
+++ b/drivers/spi/tegra210_qspi.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <time.h>
diff --git a/drivers/spi/ti_qspi.c b/drivers/spi/ti_qspi.c
index 99acb108823e..a16412ec6fb9 100644
--- a/drivers/spi/ti_qspi.c
+++ b/drivers/spi/ti_qspi.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2013, Texas Instruments, Incorporated
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/cache.h>
diff --git a/drivers/spi/uniphier_spi.c b/drivers/spi/uniphier_spi.c
index 6402acbf14a1..8f2c0fb4b8ee 100644
--- a/drivers/spi/uniphier_spi.c
+++ b/drivers/spi/uniphier_spi.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <time.h>
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 94ddf4967eaf..0e7fa3a4525d 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -13,7 +13,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index cb52c0f30721..b71b9a6fd6c8 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -7,7 +7,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <log.h>
diff --git a/drivers/spi/zynq_spi.c b/drivers/spi/zynq_spi.c
index b3e0858eb945..ebcb5b6cc883 100644
--- a/drivers/spi/zynq_spi.c
+++ b/drivers/spi/zynq_spi.c
@@ -6,7 +6,6 @@
  * Xilinx Zynq PS SPI controller driver (master mode only)
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <log.h>
diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index a323994fb2d3..61349a4da53f 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/arch/sys_proto.h>
-- 
2.34.1

