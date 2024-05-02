Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A83BC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C3F88D26;
	Thu,  2 May 2024 03:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oZflZUE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCB888C9E; Thu,  2 May 2024 03:33:18 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8774488CA4
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4365c1451d4so49280331cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613594; x=1715218394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2AD/hwwpT8EV7YN7mwzvVNkZPAttqsmHs++vWZgpq4=;
 b=oZflZUE2fYtZvcVVP7fQwsa+sXjNpgLtIujBjRebf5gfhqaBwub2t1fTzDktt/K3xZ
 Zx36ANPkyjRHPB6bSxoqLGplI/KZpoq3AYYKzrh9mBhRmvISHZCOAD+QDjs16yz+8e8S
 E11O0YIXF47jmGpXXMTTb+v6aSJlPHUpWRMAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613594; x=1715218394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2AD/hwwpT8EV7YN7mwzvVNkZPAttqsmHs++vWZgpq4=;
 b=r8q6j3TIr1P1ANQiLoJmVsC9AM6TwV6f4Quy5+h5ZvDwUZT/+60iP+hZiR4kD7d50h
 w1pNusMlUNvcgdKbHATIWFTGs8RcfejPaUiysMykf1AyEwd1BsiXZF8SwyLsuls7ft06
 7jyMgoxtsY7wTGfOuRV1cOJNJksScLFBm8pdBldRrDO7V1BzAWAI66YEm6WYDcY7e1b2
 8DV0xiAV7GhkAUXdnPf86/4IM/Xra5g8KHJxAfnJWYoZCyCXcRG+tQEkvjwuEYTNs8ou
 vI/g+7ISqfQH9q7OigKcgtTLULSm70lxuf03z/1ezu12Feyb9LNPlsfNjGjEXDnb9AE4
 TrCA==
X-Gm-Message-State: AOJu0YzTcpi2iCIqbqwBn0tMZfZcvvpOCwGaXZXfmREisFwWVErwR1AB
 iPXzjRa42ozSm9UMNRMiNxd7/oFT3netQkE9gyPXdkSSied+HAQb7AhiKaHjx1yglwUbTAe3kft
 EQHGqFfhS
X-Google-Smtp-Source: AGHT+IHLhClKrm5rZRUBzfktWu5Q7h5BagL6IV7g0K27P8gd53nbmQMW1VXbLhoVNYNIIQCoxcJJhg==
X-Received: by 2002:a05:622a:1214:b0:43b:1571:e00b with SMTP id
 y20-20020a05622a121400b0043b1571e00bmr5164913qtx.43.1714613593768; 
 Wed, 01 May 2024 18:33:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>, Sean Anderson <seanga2@gmail.com>,
 Nishanth Menon <nm@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Fabio Estevam <festevam@denx.de>, Adam Ford <aford173@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Johan Jonker <jbx6244@gmail.com>,
 Jon Lin <jon.lin@rock-chips.com>, Ren Jianing <jianing.ren@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: [PATCH 50/81] phy: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:07 -0600
Message-Id: <20240502013138.2383421-50-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
MIME-Version: 1.0
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
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Dai Okamura <okamura.dai@socionext.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Stefan Bosch <stefan_b@posteo.net>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Igor Prusov <ivprusov@salutedevices.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Adam Ford <aford173@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Jon Lin <jon.lin@rock-chips.com>
Cc: Ren Jianing <jianing.ren@rock-chips.com>
Cc: Frank Wang <frank.wang@rock-chips.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c              | 1 -
 drivers/phy/bcm6318-usbh-phy.c                     | 1 -
 drivers/phy/bcm6348-usbh-phy.c                     | 1 -
 drivers/phy/bcm6358-usbh-phy.c                     | 1 -
 drivers/phy/bcm6368-usbh-phy.c                     | 1 -
 drivers/phy/cadence/phy-cadence-sierra.c           | 1 -
 drivers/phy/cadence/phy-cadence-torrent.c          | 1 -
 drivers/phy/keystone-usb-phy.c                     | 1 -
 drivers/phy/marvell/comphy_a3700.c                 | 1 -
 drivers/phy/marvell/comphy_core.c                  | 1 -
 drivers/phy/marvell/comphy_cp110.c                 | 2 +-
 drivers/phy/marvell/comphy_mux.c                   | 1 -
 drivers/phy/meson-axg-mipi-dphy.c                  | 1 -
 drivers/phy/meson-axg-mipi-pcie-analog.c           | 1 -
 drivers/phy/meson-g12a-usb2.c                      | 1 -
 drivers/phy/meson-g12a-usb3-pcie.c                 | 1 -
 drivers/phy/meson-gxbb-usb2.c                      | 1 -
 drivers/phy/meson-gxl-usb2.c                       | 1 -
 drivers/phy/mt76x8-usb-phy.c                       | 1 -
 drivers/phy/nop-phy.c                              | 1 -
 drivers/phy/omap-usb2-phy.c                        | 1 -
 drivers/phy/phy-ab8500-usb.c                       | 1 -
 drivers/phy/phy-apple-atc.c                        | 1 -
 drivers/phy/phy-bcm-sr-pcie.c                      | 1 -
 drivers/phy/phy-core-mipi-dphy.c                   | 2 +-
 drivers/phy/phy-da8xx-usb.c                        | 2 +-
 drivers/phy/phy-imx8mq-usb.c                       | 1 -
 drivers/phy/phy-mtk-tphy.c                         | 1 -
 drivers/phy/phy-npcm-usb.c                         | 1 -
 drivers/phy/phy-rcar-gen2.c                        | 1 -
 drivers/phy/phy-rcar-gen3.c                        | 1 -
 drivers/phy/phy-stm32-usbphyc.c                    | 1 -
 drivers/phy/phy-ti-am654.c                         | 1 -
 drivers/phy/phy-uclass.c                           | 1 -
 drivers/phy/phy-zynqmp.c                           | 1 -
 drivers/phy/qcom/msm8916-usbh-phy.c                | 1 -
 drivers/phy/qcom/phy-qcom-ipq4019-usb.c            | 1 -
 drivers/phy/qcom/phy-qcom-usb-hs-28nm.c            | 1 -
 drivers/phy/qcom/phy-qcom-usb-ss.c                 | 1 -
 drivers/phy/renesas/r8a779f0-ether-serdes.c        | 1 -
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 1 -
 drivers/phy/rockchip/phy-rockchip-pcie.c           | 1 -
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 1 -
 drivers/phy/rockchip/phy-rockchip-typec.c          | 1 -
 drivers/phy/rockchip/phy-rockchip-usbdp.c          | 1 -
 drivers/phy/sandbox-phy.c                          | 1 -
 drivers/phy/socionext/phy-uniphier-pcie.c          | 1 -
 drivers/phy/socionext/phy-uniphier-usb3.c          | 1 -
 drivers/phy/sti_usb_phy.c                          | 1 -
 drivers/phy/ti-pipe3-phy.c                         | 1 -
 drivers/phy/ti/phy-j721e-wiz.c                     | 1 -
 51 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 6624e9134f43..b9306c9a8279 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -10,7 +10,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/phy/bcm6318-usbh-phy.c b/drivers/phy/bcm6318-usbh-phy.c
index a2fa446cb1c9..d715541bd4cb 100644
--- a/drivers/phy/bcm6318-usbh-phy.c
+++ b/drivers/phy/bcm6318-usbh-phy.c
@@ -7,7 +7,6 @@
  *	Copyright 2013 Florian Fainelli <florian@openwrt.org>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/bcm6348-usbh-phy.c b/drivers/phy/bcm6348-usbh-phy.c
index 857fb575ef19..ffb37b634a31 100644
--- a/drivers/phy/bcm6348-usbh-phy.c
+++ b/drivers/phy/bcm6348-usbh-phy.c
@@ -7,7 +7,6 @@
  *	Copyright 2013 Florian Fainelli <florian@openwrt.org>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/bcm6358-usbh-phy.c b/drivers/phy/bcm6358-usbh-phy.c
index bfdcfb0d245e..a8d24609bfc0 100644
--- a/drivers/phy/bcm6358-usbh-phy.c
+++ b/drivers/phy/bcm6358-usbh-phy.c
@@ -7,7 +7,6 @@
  *	Copyright 2013 Florian Fainelli <florian@openwrt.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <log.h>
diff --git a/drivers/phy/bcm6368-usbh-phy.c b/drivers/phy/bcm6368-usbh-phy.c
index 1a2870d51499..5bee130425d5 100644
--- a/drivers/phy/bcm6368-usbh-phy.c
+++ b/drivers/phy/bcm6368-usbh-phy.c
@@ -7,7 +7,6 @@
  *	Copyright 2013 Florian Fainelli <florian@openwrt.org>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 4bb8a0ca7f34..f5e23f36c56e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -11,7 +11,6 @@
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  *
  */
-#include <common.h>
 #include <clk.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ef924e7af508..d4e8ece4935a 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -10,7 +10,6 @@
  *
  */
 
-#include <common.h>
 #include <clk.h>
 #include <generic-phy.h>
 #include <reset.h>
diff --git a/drivers/phy/keystone-usb-phy.c b/drivers/phy/keystone-usb-phy.c
index 3bb9c0814c14..cfc15203d632 100644
--- a/drivers/phy/keystone-usb-phy.c
+++ b/drivers/phy/keystone-usb-phy.c
@@ -4,7 +4,6 @@
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device.h>
diff --git a/drivers/phy/marvell/comphy_a3700.c b/drivers/phy/marvell/comphy_a3700.c
index c490dc69c695..bca325d19960 100644
--- a/drivers/phy/marvell/comphy_a3700.c
+++ b/drivers/phy/marvell/comphy_a3700.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Marvell International Ltd.
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy_core.c
index 7272dfb9fe80..a666a4e794ee 100644
--- a/drivers/phy/marvell/comphy_core.c
+++ b/drivers/phy/marvell/comphy_core.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <asm/global_data.h>
diff --git a/drivers/phy/marvell/comphy_cp110.c b/drivers/phy/marvell/comphy_cp110.c
index bb15fbaf347e..b8cdedf6edf0 100644
--- a/drivers/phy/marvell/comphy_cp110.c
+++ b/drivers/phy/marvell/comphy_cp110.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Marvell International Ltd.
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/global_data.h>
@@ -12,6 +11,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/printk.h>
 
 #include "comphy_core.h"
diff --git a/drivers/phy/marvell/comphy_mux.c b/drivers/phy/marvell/comphy_mux.c
index 10981d25ec95..a8aa37fc46f3 100644
--- a/drivers/phy/marvell/comphy_mux.c
+++ b/drivers/phy/marvell/comphy_mux.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Marvell International Ltd.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 
diff --git a/drivers/phy/meson-axg-mipi-dphy.c b/drivers/phy/meson-axg-mipi-dphy.c
index faa1d9d6d378..3f89de19970b 100644
--- a/drivers/phy/meson-axg-mipi-dphy.c
+++ b/drivers/phy/meson-axg-mipi-dphy.c
@@ -7,7 +7,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/io.h>
diff --git a/drivers/phy/meson-axg-mipi-pcie-analog.c b/drivers/phy/meson-axg-mipi-pcie-analog.c
index 236ea1ce5ca7..731917cef434 100644
--- a/drivers/phy/meson-axg-mipi-pcie-analog.c
+++ b/drivers/phy/meson-axg-mipi-pcie-analog.c
@@ -7,7 +7,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/io.h>
diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 3958d2404b85..8cded12438b9 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -7,7 +7,6 @@
  * Author: Neil Armstrong <narmstron@baylibre.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/io.h>
diff --git a/drivers/phy/meson-g12a-usb3-pcie.c b/drivers/phy/meson-g12a-usb3-pcie.c
index 1eaff410efa4..4d183867c3a0 100644
--- a/drivers/phy/meson-g12a-usb3-pcie.c
+++ b/drivers/phy/meson-g12a-usb3-pcie.c
@@ -7,7 +7,6 @@
  * Author: Neil Armstrong <narmstron@baylibre.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/drivers/phy/meson-gxbb-usb2.c b/drivers/phy/meson-gxbb-usb2.c
index 725b056a71a7..4c88ccf39276 100644
--- a/drivers/phy/meson-gxbb-usb2.c
+++ b/drivers/phy/meson-gxbb-usb2.c
@@ -8,7 +8,6 @@
  * Author: Beniamino Galvani <b.galvani@gmail.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index d633effa4042..92c285103c4a 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -7,7 +7,6 @@
  * Author: Neil Armstrong <narmstron@baylibre.com>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <asm/io.h>
 #include <bitfield.h>
diff --git a/drivers/phy/mt76x8-usb-phy.c b/drivers/phy/mt76x8-usb-phy.c
index 4069208b6790..99f8a221f5a1 100644
--- a/drivers/phy/mt76x8-usb-phy.c
+++ b/drivers/phy/mt76x8-usb-phy.c
@@ -7,7 +7,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <log.h>
diff --git a/drivers/phy/nop-phy.c b/drivers/phy/nop-phy.c
index c53e3216d0fd..286171cba76a 100644
--- a/drivers/phy/nop-phy.c
+++ b/drivers/phy/nop-phy.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
diff --git a/drivers/phy/omap-usb2-phy.c b/drivers/phy/omap-usb2-phy.c
index d3d38062ecf7..2be0178882a4 100644
--- a/drivers/phy/omap-usb2-phy.c
+++ b/drivers/phy/omap-usb2-phy.c
@@ -6,7 +6,6 @@
  * Written by Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
diff --git a/drivers/phy/phy-ab8500-usb.c b/drivers/phy/phy-ab8500-usb.c
index 3d3d48c9733a..5de7b6f86cca 100644
--- a/drivers/phy/phy-ab8500-usb.c
+++ b/drivers/phy/phy-ab8500-usb.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (C) 2019 Stephan Gerhold */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <linux/bitops.h>
diff --git a/drivers/phy/phy-apple-atc.c b/drivers/phy/phy-apple-atc.c
index 15c5b8a1c2d0..78eedf676b09 100644
--- a/drivers/phy/phy-apple-atc.c
+++ b/drivers/phy/phy-apple-atc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/phy-bcm-sr-pcie.c b/drivers/phy/phy-bcm-sr-pcie.c
index cf33bab37072..97859a0cb87e 100644
--- a/drivers/phy/phy-bcm-sr-pcie.c
+++ b/drivers/phy/phy-bcm-sr-pcie.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Broadcom
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <asm/io.h>
diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index bb61816add27..8fb985a1e682 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -4,8 +4,8 @@
  * Copyright (C) 2018 Cadence Design Systems Inc.
  */
 
-#include <common.h>
 #include <div64.h>
+#include <linux/kernel.h>
 #include <linux/time.h>
 
 #include <phy-mipi-dphy.h>
diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
index d025188eae98..cf26aaaa3d82 100644
--- a/drivers/phy/phy-da8xx-usb.c
+++ b/drivers/phy/phy-da8xx-usb.c
@@ -6,9 +6,9 @@
  * DT support added by: Adam Ford <aford173@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <asm/arch/hardware.h>
diff --git a/drivers/phy/phy-imx8mq-usb.c b/drivers/phy/phy-imx8mq-usb.c
index e5e96e77a681..75763046adc1 100644
--- a/drivers/phy/phy-imx8mq-usb.c
+++ b/drivers/phy/phy-imx8mq-usb.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/phy-mtk-tphy.c
index ea9edf212c6f..6f9ac1528e88 100644
--- a/drivers/phy/phy-mtk-tphy.c
+++ b/drivers/phy/phy-mtk-tphy.c
@@ -5,7 +5,6 @@
  *	   Ryder Lee <ryder.lee@mediatek.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/phy-npcm-usb.c b/drivers/phy/phy-npcm-usb.c
index 24eba6655435..028fedf92dc3 100644
--- a/drivers/phy/phy-npcm-usb.c
+++ b/drivers/phy/phy-npcm-usb.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2021 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <regmap.h>
diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index e528c4ec5793..f9428c7ad122 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
index 03c747b373b1..7c292cae0e2f 100644
--- a/drivers/phy/phy-rcar-gen3.c
+++ b/drivers/phy/phy-rcar-gen3.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/phy/phy-stm32-usbphyc.c b/drivers/phy/phy-stm32-usbphyc.c
index 000e495dbd4e..8d643b762f90 100644
--- a/drivers/phy/phy-stm32-usbphyc.c
+++ b/drivers/phy/phy-stm32-usbphyc.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_PHY
 
-#include <common.h>
 #include <clk.h>
 #include <clk-uclass.h>
 #include <div64.h>
diff --git a/drivers/phy/phy-ti-am654.c b/drivers/phy/phy-ti-am654.c
index 70a746d2c92d..c3d9972397aa 100644
--- a/drivers/phy/phy-ti-am654.c
+++ b/drivers/phy/phy-ti-am654.c
@@ -6,7 +6,6 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 0dcfe258bc44..acdcda15b5b8 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_PHY
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
index d1288bb17f3c..7049e740d569 100644
--- a/drivers/phy/phy-zynqmp.c
+++ b/drivers/phy/phy-zynqmp.c
@@ -9,7 +9,6 @@
  * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/qcom/msm8916-usbh-phy.c b/drivers/phy/qcom/msm8916-usbh-phy.c
index f52046f7cb02..4b435aa2a6eb 100644
--- a/drivers/phy/qcom/msm8916-usbh-phy.c
+++ b/drivers/phy/qcom/msm8916-usbh-phy.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <linux/bitops.h>
diff --git a/drivers/phy/qcom/phy-qcom-ipq4019-usb.c b/drivers/phy/qcom/phy-qcom-ipq4019-usb.c
index 5808489249f5..3b647324e021 100644
--- a/drivers/phy/qcom/phy-qcom-ipq4019-usb.c
+++ b/drivers/phy/qcom/phy-qcom-ipq4019-usb.c
@@ -8,7 +8,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <log.h>
diff --git a/drivers/phy/qcom/phy-qcom-usb-hs-28nm.c b/drivers/phy/qcom/phy-qcom-usb-hs-28nm.c
index 05a9a2cf1d7c..c344809a6086 100644
--- a/drivers/phy/qcom/phy-qcom-usb-hs-28nm.c
+++ b/drivers/phy/qcom/phy-qcom-usb-hs-28nm.c
@@ -5,7 +5,6 @@
  * Based on Linux driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <reset.h>
diff --git a/drivers/phy/qcom/phy-qcom-usb-ss.c b/drivers/phy/qcom/phy-qcom-usb-ss.c
index 1b03a3c43dc8..270d09d883c4 100644
--- a/drivers/phy/qcom/phy-qcom-usb-ss.c
+++ b/drivers/phy/qcom/phy-qcom-usb-ss.c
@@ -5,7 +5,6 @@
  * Based on Linux driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <linux/bitops.h>
diff --git a/drivers/phy/renesas/r8a779f0-ether-serdes.c b/drivers/phy/renesas/r8a779f0-ether-serdes.c
index bd1fdd3a667d..40284ef2fd34 100644
--- a/drivers/phy/renesas/r8a779f0-ether-serdes.c
+++ b/drivers/phy/renesas/r8a779f0-ether-serdes.c
@@ -7,7 +7,6 @@
 #include <asm/io.h>
 #include <clk-uclass.h>
 #include <clk.h>
-#include <common.h>
 #include <div64.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 9ca66bf8db92..3ad339bccc1d 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/lists.h>
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 44ca4bc7919e..660037034ec0 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2016 ROCKCHIP, Inc.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <asm/global_data.h>
diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index a4392daf4c92..2737bd81dd96 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 47c69dd6c453..c7459dbc5fc6 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -8,7 +8,6 @@
  *         Kever Yang <kever.yang@rock-chips.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <asm/global_data.h>
diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index baf92529348c..5bcc76613d14 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/phy/sandbox-phy.c b/drivers/phy/sandbox-phy.c
index 7e123da25fb4..b159147a765b 100644
--- a/drivers/phy/sandbox-phy.c
+++ b/drivers/phy/sandbox-phy.c
@@ -4,7 +4,6 @@
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 
diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
index d352c4ca3a9c..91208dfe1200 100644
--- a/drivers/phy/socionext/phy-uniphier-pcie.c
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -4,7 +4,6 @@
  * Copyright 2019-2021 Socionext, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <linux/bitops.h>
diff --git a/drivers/phy/socionext/phy-uniphier-usb3.c b/drivers/phy/socionext/phy-uniphier-usb3.c
index 1d65b0b08f76..1d65c1f7da52 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3.c
@@ -4,7 +4,6 @@
  * Copyright 2019-2023 Socionext, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 
diff --git a/drivers/phy/sti_usb_phy.c b/drivers/phy/sti_usb_phy.c
index 9e5ac9bfde67..2447e89f50df 100644
--- a/drivers/phy/sti_usb_phy.c
+++ b/drivers/phy/sti_usb_phy.c
@@ -4,7 +4,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/phy/ti-pipe3-phy.c b/drivers/phy/ti-pipe3-phy.c
index 29a35ae5ffb9..62f6cc2bfbfd 100644
--- a/drivers/phy/ti-pipe3-phy.c
+++ b/drivers/phy/ti-pipe3-phy.c
@@ -4,7 +4,6 @@
  * Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device.h>
 #include <generic-phy.h>
diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index daf62f5deda0..c69a342e2b49 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -4,7 +4,6 @@
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <dm/device_compat.h>
-- 
2.34.1

