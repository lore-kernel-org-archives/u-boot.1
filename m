Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C7FC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EA588D4C;
	Thu,  2 May 2024 03:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QecKXvG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A89988CFC; Thu,  2 May 2024 03:34:13 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F4D88CC6
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4375ddb9eaeso45976131cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613646; x=1715218446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7wfbpHyQ3iP6hFGaOvKAcj2KcdkjXT5z/SF15boDys=;
 b=QecKXvG4iTsQ9IZMfthTmv6NAnqu10MtVhte5W1lImZ31FSCsXnLUmwP8ABMfWNpay
 /TLWLXav6zLVY7czYsk7asfETWtgaww00TkYAcjz/+XqbcOQPjJ96HKbxPOLpePunBfp
 hat/M5WS5nphFskxMFTeHCFv2pT0+qJmTcG5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613646; x=1715218446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7wfbpHyQ3iP6hFGaOvKAcj2KcdkjXT5z/SF15boDys=;
 b=qCKeAzVDau9ygaz7Pz9w1LRM3Bo03JNDApKG4xd93TYre2bfhzTdM8J4X1327GNHOy
 0n5VUV3Ie6Y4VCqZ17s0LOZPY4oT2NMhwdkcX2J4WZ7T46uZ+7DeO8ElZpLq/XL1H+Ad
 BjN4F8BrzPqkUJXQ8Z9vbA3XA2GIWXU7W+pwKpim/4rvot8C32up71RqcsBnosl1N97e
 xBLnqGUGniILi6BzJbOJT26d24do+NWCiQzi5/nnxSPiLoxvl8w7SCU1lYTQmEXbOCGh
 ENcssB4fDFf0bQSughsM/IDewrSjBeGoFN7weK428r2Ox1uodlFewbqjcw8BEgZoVBRA
 dZCQ==
X-Gm-Message-State: AOJu0Yzg5PuIUaU0QaRVnGNe3NItjro/VP2PC4i7bq9VgdU3QUVU6n1o
 xqTT6xPWgzYqGMbzWBKbIPpxZP1w4TIWtDN7KzSfvoMfsh4DelTHGfpFVgMcr9yS/gR6438pKNj
 oWcyMHrGD
X-Google-Smtp-Source: AGHT+IGccob+N1Rob5jdhp/r++V06XOrFNFTsY0Gt+EQbc1ckNCERMeL6YMTaLEeNn5Q1/Z5EYLHrQ==
X-Received: by 2002:a05:622a:351:b0:43c:76a4:dea5 with SMTP id
 r17-20020a05622a035100b0043c76a4dea5mr4518767qtw.0.1714613645803; 
 Wed, 01 May 2024 18:34:05 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 Linus Walleij <linus.walleij@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Roger Quadros <rogerq@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sean Anderson <seanga2@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Tim Harvey <tharvey@gateworks.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Fabio Estevam <festevam@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 73/81] usb: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:30 -0600
Message-Id: <20240502013138.2383421-73-trini@konsulko.com>
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
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Igor Prusov <ivprusov@salutedevices.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Peter Korsgaard <peter@korsgaard.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Alexey Romanov <avromanov@salutedevices.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Teik Heng Chong <teik.heng.chong@intel.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>
---
 drivers/usb/cdns3/cdns3-ti.c               | 1 -
 drivers/usb/cdns3/core.c                   | 1 -
 drivers/usb/common/common.c                | 1 -
 drivers/usb/common/fsl-dt-fixup.c          | 1 -
 drivers/usb/common/fsl-errata.c            | 1 -
 drivers/usb/dwc3/core.c                    | 1 -
 drivers/usb/dwc3/dwc3-generic.c            | 1 -
 drivers/usb/dwc3/dwc3-layerscape.c         | 1 -
 drivers/usb/dwc3/dwc3-meson-g12a.c         | 1 -
 drivers/usb/dwc3/dwc3-meson-gxl.c          | 1 -
 drivers/usb/dwc3/dwc3-omap.c               | 1 -
 drivers/usb/dwc3/ep0.c                     | 1 -
 drivers/usb/dwc3/gadget.c                  | 1 -
 drivers/usb/dwc3/samsung_usb_phy.c         | 2 +-
 drivers/usb/dwc3/ti_usb_phy.c              | 1 -
 drivers/usb/emul/sandbox_flash.c           | 1 -
 drivers/usb/emul/sandbox_hub.c             | 1 -
 drivers/usb/emul/sandbox_keyb.c            | 1 -
 drivers/usb/emul/usb-emul-uclass.c         | 1 -
 drivers/usb/eth/asix.c                     | 1 -
 drivers/usb/eth/asix88179.c                | 1 -
 drivers/usb/eth/mcs7830.c                  | 1 -
 drivers/usb/eth/r8152.c                    | 1 -
 drivers/usb/eth/r8152_fw.c                 | 1 -
 drivers/usb/eth/smsc95xx.c                 | 1 -
 drivers/usb/eth/usb_ether.c                | 1 -
 drivers/usb/gadget/at91_udc.c              | 1 -
 drivers/usb/gadget/atmel_usba_udc.c        | 1 -
 drivers/usb/gadget/bcm_udc_otg_phy.c       | 1 -
 drivers/usb/gadget/ci_udc.c                | 1 -
 drivers/usb/gadget/config.c                | 1 -
 drivers/usb/gadget/dwc2_udc_otg.c          | 1 -
 drivers/usb/gadget/dwc2_udc_otg_phy.c      | 1 -
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 1 -
 drivers/usb/gadget/ep0.c                   | 1 -
 drivers/usb/gadget/epautoconf.c            | 1 -
 drivers/usb/gadget/ether.c                 | 1 -
 drivers/usb/gadget/f_acm.c                 | 1 -
 drivers/usb/gadget/f_dfu.c                 | 1 -
 drivers/usb/gadget/f_fastboot.c            | 1 -
 drivers/usb/gadget/f_mass_storage.c        | 1 -
 drivers/usb/gadget/f_rockusb.c             | 1 -
 drivers/usb/gadget/f_sdp.c                 | 1 -
 drivers/usb/gadget/f_thor.c                | 1 -
 drivers/usb/gadget/g_dnl.c                 | 1 -
 drivers/usb/gadget/max3420_udc.c           | 1 -
 drivers/usb/gadget/rndis.c                 | 1 -
 drivers/usb/gadget/udc/udc-core.c          | 1 -
 drivers/usb/gadget/udc/udc-uclass.c        | 1 -
 drivers/usb/gadget/usbstring.c             | 1 -
 drivers/usb/host/dwc2.c                    | 1 -
 drivers/usb/host/dwc3-of-simple.c          | 1 -
 drivers/usb/host/dwc3-sti-glue.c           | 1 -
 drivers/usb/host/ehci-atmel.c              | 1 -
 drivers/usb/host/ehci-exynos.c             | 1 -
 drivers/usb/host/ehci-fsl.c                | 1 -
 drivers/usb/host/ehci-generic.c            | 1 -
 drivers/usb/host/ehci-hcd.c                | 1 -
 drivers/usb/host/ehci-marvell.c            | 1 -
 drivers/usb/host/ehci-msm.c                | 1 -
 drivers/usb/host/ehci-mx5.c                | 1 -
 drivers/usb/host/ehci-mx6.c                | 1 -
 drivers/usb/host/ehci-mxs.c                | 1 -
 drivers/usb/host/ehci-npcm.c               | 1 -
 drivers/usb/host/ehci-omap.c               | 2 +-
 drivers/usb/host/ehci-pci.c                | 1 -
 drivers/usb/host/ehci-tegra.c              | 1 -
 drivers/usb/host/ehci-vf.c                 | 1 -
 drivers/usb/host/ehci-zynq.c               | 1 -
 drivers/usb/host/ohci-at91.c               | 1 -
 drivers/usb/host/ohci-da8xx.c              | 1 -
 drivers/usb/host/ohci-generic.c            | 1 -
 drivers/usb/host/ohci-hcd.c                | 2 +-
 drivers/usb/host/ohci-lpc32xx.c            | 1 -
 drivers/usb/host/ohci-npcm.c               | 1 -
 drivers/usb/host/ohci-pci.c                | 1 -
 drivers/usb/host/r8a66597-hcd.c            | 1 -
 drivers/usb/host/usb-sandbox.c             | 1 -
 drivers/usb/host/usb-uclass.c              | 1 -
 drivers/usb/host/usb_bootdev.c             | 1 -
 drivers/usb/host/xhci-brcm.c               | 1 -
 drivers/usb/host/xhci-dwc3.c               | 1 -
 drivers/usb/host/xhci-exynos5.c            | 1 -
 drivers/usb/host/xhci-fsl.c                | 1 -
 drivers/usb/host/xhci-mem.c                | 1 -
 drivers/usb/host/xhci-mtk.c                | 1 -
 drivers/usb/host/xhci-mvebu.c              | 1 -
 drivers/usb/host/xhci-omap.c               | 1 -
 drivers/usb/host/xhci-pci.c                | 1 -
 drivers/usb/host/xhci-rcar.c               | 1 -
 drivers/usb/host/xhci-ring.c               | 1 -
 drivers/usb/host/xhci.c                    | 1 -
 drivers/usb/isp1760/isp1760-hcd.c          | 1 -
 drivers/usb/isp1760/isp1760-if.c           | 1 -
 drivers/usb/isp1760/isp1760-uboot.c        | 1 -
 drivers/usb/mtu3/mtu3_plat.c               | 1 -
 drivers/usb/musb-new/am35x.c               | 1 -
 drivers/usb/musb-new/da8xx.c               | 1 -
 drivers/usb/musb-new/mt85xx.c              | 1 -
 drivers/usb/musb-new/musb_core.c           | 1 -
 drivers/usb/musb-new/musb_dsps.c           | 1 -
 drivers/usb/musb-new/musb_gadget.c         | 1 -
 drivers/usb/musb-new/musb_gadget_ep0.c     | 1 -
 drivers/usb/musb-new/musb_host.c           | 1 -
 drivers/usb/musb-new/musb_uboot.c          | 1 -
 drivers/usb/musb-new/omap2430.c            | 1 -
 drivers/usb/musb-new/pic32.c               | 1 -
 drivers/usb/musb-new/sunxi.c               | 1 -
 drivers/usb/musb-new/ti-musb.c             | 1 -
 drivers/usb/musb-new/ux500.c               | 1 -
 drivers/usb/musb/am35x.c                   | 1 -
 drivers/usb/musb/musb_core.c               | 1 -
 drivers/usb/musb/musb_hcd.c                | 1 -
 drivers/usb/musb/musb_udc.c                | 1 -
 drivers/usb/phy/rockchip_usb2_phy.c        | 1 -
 drivers/usb/ulpi/omap-ulpi-viewport.c      | 1 -
 drivers/usb/ulpi/ulpi-viewport.c           | 1 -
 drivers/usb/ulpi/ulpi.c                    | 1 -
 118 files changed, 3 insertions(+), 118 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 2e44aadea47b..ac072260c30a 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 12a741c6ea7c..b4e931646b88 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -11,7 +11,6 @@
  *         Roger Quadros <rogerq@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device-internal.h>
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 7137a569d97c..13e9a61072a9 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
diff --git a/drivers/usb/common/fsl-dt-fixup.c b/drivers/usb/common/fsl-dt-fixup.c
index 00b8cd368b1a..6a68bd76c274 100644
--- a/drivers/usb/common/fsl-dt-fixup.c
+++ b/drivers/usb/common/fsl-dt-fixup.c
@@ -7,7 +7,6 @@
  * Author: Tor Krill tor@excito.com
  */
 
-#include <common.h>
 #include <log.h>
 #include <usb.h>
 #include <asm/io.h>
diff --git a/drivers/usb/common/fsl-errata.c b/drivers/usb/common/fsl-errata.c
index 9eb1d2306725..89ae73f2ba48 100644
--- a/drivers/usb/common/fsl-errata.c
+++ b/drivers/usb/common/fsl-errata.c
@@ -5,7 +5,6 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <hwconfig.h>
 #include <fsl_errata.h>
 #include<fsl_usb.h>
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 96e850b7170f..c443d56746dd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -13,7 +13,6 @@
  * commit cd72f890d2 : usb: dwc3: core: enable phy suspend quirk on non-FPGA
  */
 
-#include <common.h>
 #include <clk.h>
 #include <cpu_func.h>
 #include <malloc.h>
diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 7a00529a2a8e..8db678eb85d4 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -7,7 +7,6 @@
  * Based on dwc3-omap.c.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <dm.h>
diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index c32df2396d74..ff83bf71e898 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -7,7 +7,6 @@
  * Based on dwc3-generic.c.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 1a3e9350c46d..21e4f637bb15 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -6,7 +6,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 2ce915701a85..3e693c5ff310 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -7,7 +7,6 @@
  */
 
 #define DEBUG
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 53c4d4826b45..4b219c35eb35 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -13,7 +13,6 @@
  * commit 7ee2566ff5 : usb: dwc3: dwc3-omap: get rid of ->prepare()/->complete()
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <asm/io.h>
 #include <dm.h>
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 1133cf82b1ae..117d38a0340b 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -12,7 +12,6 @@
  *
  * commit c00552ebaf : Merge 3.18-rc7 into usb-next
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 406d36ceafe4..4de007cb0c38 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -13,7 +13,6 @@
  * commit 8e74475b0e : usb: dwc3: gadget: use udc-core's reset notifier
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/usb/dwc3/samsung_usb_phy.c b/drivers/usb/dwc3/samsung_usb_phy.c
index abbd41368901..0a7713081636 100644
--- a/drivers/usb/dwc3/samsung_usb_phy.c
+++ b/drivers/usb/dwc3/samsung_usb_phy.c
@@ -7,7 +7,7 @@
  * Author: Joonyoung Shim <jy0922.shim@samsung.com>
  */
 
-#include <common.h>
+#include <asm/io.h>
 #include <asm/arch/power.h>
 #include <asm/arch/xhci-exynos.h>
 #include <linux/delay.h>
diff --git a/drivers/usb/dwc3/ti_usb_phy.c b/drivers/usb/dwc3/ti_usb_phy.c
index 8ae130860f79..f0ecdea958ae 100644
--- a/drivers/usb/dwc3/ti_usb_phy.c
+++ b/drivers/usb/dwc3/ti_usb_phy.c
@@ -16,7 +16,6 @@
  * and remove" for phy-omap-usb2.c
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <ti-usb-phy-uboot.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/emul/sandbox_flash.c b/drivers/usb/emul/sandbox_flash.c
index 7c5c1ab3de73..24420e3d51e1 100644
--- a/drivers/usb/emul/sandbox_flash.c
+++ b/drivers/usb/emul/sandbox_flash.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY	UCLASS_USB
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/usb/emul/sandbox_hub.c b/drivers/usb/emul/sandbox_hub.c
index 084cc16cc683..3b3e59f978f7 100644
--- a/drivers/usb/emul/sandbox_hub.c
+++ b/drivers/usb/emul/sandbox_hub.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <usb.h>
diff --git a/drivers/usb/emul/sandbox_keyb.c b/drivers/usb/emul/sandbox_keyb.c
index 5ec1e98e4ed4..db769883ba3b 100644
--- a/drivers/usb/emul/sandbox_keyb.c
+++ b/drivers/usb/emul/sandbox_keyb.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <os.h>
diff --git a/drivers/usb/emul/usb-emul-uclass.c b/drivers/usb/emul/usb-emul-uclass.c
index b31dc950e3ab..cdc18d6cbb97 100644
--- a/drivers/usb/emul/usb-emul-uclass.c
+++ b/drivers/usb/emul/usb-emul-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_USB_EMUL
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <usb.h>
diff --git a/drivers/usb/eth/asix.c b/drivers/usb/eth/asix.c
index 26dd312b7d06..c5a01ec922be 100644
--- a/drivers/usb/eth/asix.c
+++ b/drivers/usb/eth/asix.c
@@ -5,7 +5,6 @@
  * Patched for AX88772B by Antmicro Ltd <www.antmicro.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <net.h>
diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 2e737e606685..7bfd285b3aa4 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -5,7 +5,6 @@
  * from the Linux AX88179_178a driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <usb.h>
diff --git a/drivers/usb/eth/mcs7830.c b/drivers/usb/eth/mcs7830.c
index d94204f22d5f..199fb7a5d08e 100644
--- a/drivers/usb/eth/mcs7830.c
+++ b/drivers/usb/eth/mcs7830.c
@@ -9,7 +9,6 @@
  * MOSCHIP MCS7830 based (7730/7830/7832) USB 2.0 Ethernet Devices
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index 3c866f4f1e2d..e3f20e08c33c 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/usb/eth/r8152_fw.c b/drivers/usb/eth/r8152_fw.c
index a41abed3069a..3159f3010602 100644
--- a/drivers/usb/eth/r8152_fw.c
+++ b/drivers/usb/eth/r8152_fw.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2015 Realtek Semiconductor Corp. All rights reserved.
  *
   */
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <linux/bitops.h>
diff --git a/drivers/usb/eth/smsc95xx.c b/drivers/usb/eth/smsc95xx.c
index de6586e62639..b4fcb2c2bb0d 100644
--- a/drivers/usb/eth/smsc95xx.c
+++ b/drivers/usb/eth/smsc95xx.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2007-2008 SMSC (Steve Glendinning)
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/usb/eth/usb_ether.c b/drivers/usb/eth/usb_ether.c
index 2e9af54fd63d..8bba3e0974e6 100644
--- a/drivers/usb/eth/usb_ether.c
+++ b/drivers/usb/eth/usb_ether.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index e573a03477b9..86b2cbf3f6ae 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -13,7 +13,6 @@
 #undef	VERBOSE_DEBUG
 #undef	PACKET_TRACE
 
-#include <common.h>
 #include <dm/devres.h>
 #include <linux/bug.h>
 #include <linux/err.h>
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 4c420747b0b6..f99553df8d49 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -7,7 +7,6 @@
  *			   Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <asm/gpio.h>
diff --git a/drivers/usb/gadget/bcm_udc_otg_phy.c b/drivers/usb/gadget/bcm_udc_otg_phy.c
index c89cd57c253d..9875191091cc 100644
--- a/drivers/usb/gadget/bcm_udc_otg_phy.c
+++ b/drivers/usb/gadget/bcm_udc_otg_phy.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/sysmap.h>
 #include <asm/kona-common/clk.h>
diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 750d47148798..bbe03cfff1fb 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -7,7 +7,6 @@
  * Murray.Jensen@cmst.csiro.au, 27-Jan-01.
  */
 
-#include <common.h>
 #include <command.h>
 #include <config.h>
 #include <cpu_func.h>
diff --git a/drivers/usb/gadget/config.c b/drivers/usb/gadget/config.c
index e96782644f31..1363ef9e73df 100644
--- a/drivers/usb/gadget/config.c
+++ b/drivers/usb/gadget/config.c
@@ -8,7 +8,6 @@
  *                      Remy Bohmer <linux@bohmer.net>
  */
 
-#include <common.h>
 #include <asm/unaligned.h>
 #include <linux/errno.h>
 #include <linux/list.h>
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 27082f5152cb..6bd395a6235a 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -17,7 +17,6 @@
  * Lukasz Majewski <l.majewski@samsumg.com>
  */
 #undef DEBUG
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/usb/gadget/dwc2_udc_otg_phy.c b/drivers/usb/gadget/dwc2_udc_otg_phy.c
index 7f8e9564b9e5..c7eea7b34421 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_phy.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_phy.c
@@ -17,7 +17,6 @@
  * Lukasz Majewski <l.majewski@samsumg.com>
  */
 
-#include <common.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/list.h>
diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
index 1c34b753511d..16b2a03f9e4b 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -17,7 +17,6 @@
  * Lukasz Majewski <l.majewski@samsumg.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <linux/bug.h>
diff --git a/drivers/usb/gadget/ep0.c b/drivers/usb/gadget/ep0.c
index c256cc31fbd2..9d08640ff23a 100644
--- a/drivers/usb/gadget/ep0.c
+++ b/drivers/usb/gadget/ep0.c
@@ -36,7 +36,6 @@
  * XXX
  */
 
-#include <common.h>
 #include <serial.h>
 #include <usbdevice.h>
 
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index bb0d2971d06b..0a70035ce04b 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -8,7 +8,6 @@
  *                      Remy Bohmer <linux@bohmer.net>
  */
 
-#include <common.h>
 #include <linux/usb/ch9.h>
 #include <linux/errno.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 36618f0bdf36..b8b29d399b13 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2008 Nokia Corporation
  */
 
-#include <common.h>
 #include <console.h>
 #include <env.h>
 #include <log.h>
diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index ba216128ab27..f18c6a0a7611 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -10,7 +10,6 @@
  */
 
 #include <circbuf.h>
-#include <common.h>
 #include <console.h>
 #include <errno.h>
 #include <g_dnl.h>
diff --git a/drivers/usb/gadget/f_dfu.c b/drivers/usb/gadget/f_dfu.c
index 44877df4ec6b..ca8b36e077bc 100644
--- a/drivers/usb/gadget/f_dfu.c
+++ b/drivers/usb/gadget/f_dfu.c
@@ -16,7 +16,6 @@
 
 #include <env.h>
 #include <errno.h>
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 09e740cc9622..8df0e3f331d1 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -11,7 +11,6 @@
  */
 #include <command.h>
 #include <config.h>
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <fastboot.h>
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index ef90c7ec7fb5..89a96dbb7a74 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -244,7 +244,6 @@
 #include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
-#include <common.h>
 #include <console.h>
 #include <g_dnl.h>
 #include <dm/devres.h>
diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index 98a7ffa2a752..d679cdae97c8 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -6,7 +6,6 @@
  */
 #include <command.h>
 #include <config.h>
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index ca2760c00d0d..89496917a61f 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -17,7 +17,6 @@
  */
 
 #include <errno.h>
-#include <common.h>
 #include <console.h>
 #include <env.h>
 #include <log.h>
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 0e7529dcdbb6..543721183480 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -15,7 +15,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index afb7b74f3057..b5b5f5d8c118 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -6,7 +6,6 @@
  * Lukasz Majewski  <l.majewski@samsung.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 
diff --git a/drivers/usb/gadget/max3420_udc.c b/drivers/usb/gadget/max3420_udc.c
index fa655c98dcc5..5a227c0ffd99 100644
--- a/drivers/usb/gadget/max3420_udc.c
+++ b/drivers/usb/gadget/max3420_udc.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <asm/gpio.h>
diff --git a/drivers/usb/gadget/rndis.c b/drivers/usb/gadget/rndis.c
index e7276ccd37a3..5e6e5a054ca7 100644
--- a/drivers/usb/gadget/rndis.c
+++ b/drivers/usb/gadget/rndis.c
@@ -18,7 +18,6 @@
  *		updates to merge with Linux 2.6, better match RNDIS spec
  */
 
-#include <common.h>
 #include <log.h>
 #include <net.h>
 #include <malloc.h>
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index ba658d922966..6bb419ae2abc 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -19,7 +19,6 @@
 #include <malloc.h>
 #include <asm/cache.h>
 #include <linux/dma-mapping.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <linux/usb/ch9.h>
diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index 30ee1cab0668..5dc23a55bb58 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_USB_GADGET_GENERIC
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <linux/printk.h>
diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index e2464ad923f8..4617a95bd0a7 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -6,7 +6,6 @@
  *                      Remy Bohmer <linux@bohmer.net>
  */
 
-#include <common.h>
 #include <linux/errno.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 637eb2dd06f5..a9dbb85f4e6c 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2014 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/drivers/usb/host/dwc3-of-simple.c b/drivers/usb/host/dwc3-of-simple.c
index f9df59d2e5d7..d52e7d22d1a7 100644
--- a/drivers/usb/host/dwc3-of-simple.c
+++ b/drivers/usb/host/dwc3-of-simple.c
@@ -10,7 +10,6 @@
  * Author: Neil Armstrong <narmstron@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <reset.h>
 #include <clk.h>
diff --git a/drivers/usb/host/dwc3-sti-glue.c b/drivers/usb/host/dwc3-sti-glue.c
index 4a3ab6111276..3e6834e38e38 100644
--- a/drivers/usb/host/dwc3-sti-glue.c
+++ b/drivers/usb/host/dwc3-sti-glue.c
@@ -6,7 +6,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index c6d50fd4551a..ee751224463a 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -5,7 +5,6 @@
  * Written-by: Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index c1cdd4b0889a..1e4a5a0b6f6c 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -6,7 +6,6 @@
  *	Vivek Gautam <gautam.vivek@samsung.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0569dd54fff9..ee3eb065b142 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -7,7 +7,6 @@
  * Author: Tor Krill tor@excito.com
  */
 
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <pci.h>
diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
index 936e30438d9f..23c3ed25554f 100644
--- a/drivers/usb/host/ehci-generic.c
+++ b/drivers/usb/host/ehci-generic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Alexey Brodkin <abrodkin@synopsys.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <log.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 9839aa17492d..7d5519c65a9e 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -6,7 +6,6 @@
  *
  * All rights reserved.
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/usb/host/ehci-marvell.c b/drivers/usb/host/ehci-marvell.c
index 6093c8fb0b68..ca0ab57d49c2 100644
--- a/drivers/usb/host/ehci-marvell.c
+++ b/drivers/usb/host/ehci-marvell.c
@@ -5,7 +5,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 98fe7bc3bcb1..a081f71b187d 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -7,7 +7,6 @@
  * Based on Linux driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <errno.h>
diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
index c11279867c7c..fb912654097e 100644
--- a/drivers/usb/host/ehci-mx5.c
+++ b/drivers/usb/host/ehci-mx5.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2010 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <usb.h>
 #include <errno.h>
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index a35fcca43a23..31cd8a50f4a2 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2010 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <log.h>
 #include <usb.h>
diff --git a/drivers/usb/host/ehci-mxs.c b/drivers/usb/host/ehci-mxs.c
index ddf7cc2d00a7..95af5c9254cb 100644
--- a/drivers/usb/host/ehci-mxs.c
+++ b/drivers/usb/host/ehci-mxs.c
@@ -6,7 +6,6 @@
  * on behalf of DENX Software Engineering GmbH
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 #include <errno.h>
diff --git a/drivers/usb/host/ehci-npcm.c b/drivers/usb/host/ehci-npcm.c
index 357a5614edb7..d2a9965b4b4f 100644
--- a/drivers/usb/host/ehci-npcm.c
+++ b/drivers/usb/host/ehci-npcm.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2021 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <reset.h>
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 765336a3c42b..a95fcad02131 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -10,8 +10,8 @@
  *
  */
 
-#include <common.h>
 #include <log.h>
+#include <time.h>
 #include <usb.h>
 #include <linux/delay.h>
 #include <usb/ulpi.h>
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index e98ab312618d..572686580cd5 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -4,7 +4,6 @@
  * All rights reserved.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <init.h>
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 2cf16256703d..343893b9f19a 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2013 Lucas Stach
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <linux/delay.h>
diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 648e136447d9..5afe28ea3033 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -6,7 +6,6 @@
  * Based on ehci-mx6 driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <usb.h>
diff --git a/drivers/usb/host/ehci-zynq.c b/drivers/usb/host/ehci-zynq.c
index f7e458cb15a2..dfaff5c60f4e 100644
--- a/drivers/usb/host/ehci-zynq.c
+++ b/drivers/usb/host/ehci-zynq.c
@@ -5,7 +5,6 @@
  * USB Low level initialization(Specific to zynq)
  */
 
-#include <common.h>
 #include <dm.h>
 #include <usb.h>
 #include <asm/arch/hardware.h>
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 9b955c1bd678..b170f26e6c6a 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -4,7 +4,6 @@
  * DENX Software Engineering <mk@denx.de>
  */
 
-#include <common.h>
 #include <asm/arch/clk.h>
 
 int usb_cpu_init(void)
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index d3d73d238442..d321d147c2f9 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2012 Sughosh Ganu <urwithsughosh@gmail.com>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <asm/io.h>
 #include <clk.h>
diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index ceed1911a95a..f1325cd49534 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Alexey Brodkin <abrodkin@synopsys.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 3f4418198ccd..c020d13c43d2 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -27,7 +27,7 @@
  *     to activate workaround for bug #41 or this driver will NOT work!
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <asm/byteorder.h>
 #include <dm.h>
diff --git a/drivers/usb/host/ohci-lpc32xx.c b/drivers/usb/host/ohci-lpc32xx.c
index a04b2961b961..ed04cae7afed 100644
--- a/drivers/usb/host/ohci-lpc32xx.c
+++ b/drivers/usb/host/ohci-lpc32xx.c
@@ -7,7 +7,6 @@
  * Copyright (c) 2015 Tyco Fire Protection Products.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <init.h>
diff --git a/drivers/usb/host/ohci-npcm.c b/drivers/usb/host/ohci-npcm.c
index 9e1d52988099..ffeb6bc206a8 100644
--- a/drivers/usb/host/ohci-npcm.c
+++ b/drivers/usb/host/ohci-npcm.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2021 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <reset.h>
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index f061aec28966..f10f10924205 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <pci.h>
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 3ccbc16da379..f0b18bffba41 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2008  Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
index 3d4f8d653b5d..e26f0b292ed5 100644
--- a/drivers/usb/host/usb-sandbox.c
+++ b/drivers/usb/host/usb-sandbox.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <usb.h>
diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d669..cd3a07e4c374 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_USB
 
-#include <common.h>
 #include <bootdev.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/usb/host/usb_bootdev.c b/drivers/usb/host/usb_bootdev.c
index 7fa1c601dff5..362b46dc466e 100644
--- a/drivers/usb/host/usb_bootdev.c
+++ b/drivers/usb/host/usb_bootdev.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <dm.h>
 #include <usb.h>
diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
index fe17924028cd..2ffad148dea6 100644
--- a/drivers/usb/host/xhci-brcm.c
+++ b/drivers/usb/host/xhci-brcm.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Broadcom.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <usb.h>
diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 6cebe1cc30cb..e3e0ceff43e6 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -8,7 +8,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <log.h>
diff --git a/drivers/usb/host/xhci-exynos5.c b/drivers/usb/host/xhci-exynos5.c
index 270be934e7fc..6a2d422c4b8e 100644
--- a/drivers/usb/host/xhci-exynos5.c
+++ b/drivers/usb/host/xhci-exynos5.c
@@ -12,7 +12,6 @@
  * exynos5 specific PHY-init sequence.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/drivers/usb/host/xhci-fsl.c b/drivers/usb/host/xhci-fsl.c
index e67e09e31e4a..3484ae1d21ee 100644
--- a/drivers/usb/host/xhci-fsl.c
+++ b/drivers/usb/host/xhci-fsl.c
@@ -7,7 +7,6 @@
  * Author: Ramneek Mehresh<ramneek.mehresh@freescale.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <usb.h>
 #include <linux/errno.h>
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 72b753062650..045b0fba8128 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -13,7 +13,6 @@
  *	    Vikas Sajjan <vikas.sajjan@samsung.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 63dfb793c6bd..7e288f0575b6 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 46b89de85d1e..1338b1021c64 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -5,7 +5,6 @@
  * MVEBU USB HOST xHCI Controller
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/drivers/usb/host/xhci-omap.c b/drivers/usb/host/xhci-omap.c
index 501129d769a2..66da94c07098 100644
--- a/drivers/usb/host/xhci-omap.c
+++ b/drivers/usb/host/xhci-omap.c
@@ -8,7 +8,6 @@
  * Author: Dan Murphy <dmurphy@ti.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <usb.h>
 #include <linux/errno.h>
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 11f1c02000af..f6972af7963d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -5,7 +5,6 @@
  * All rights reserved.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <init.h>
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index fedcf7869295..38c5928faed5 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -5,7 +5,6 @@
  * Renesas RCar USB HOST xHCI Controller
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 910c5f3352b8..1360a5940fa0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -13,7 +13,6 @@
  *	    Vikas Sajjan <vikas.sajjan@samsung.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/byteorder.h>
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 741e186ee05b..d30725d3fcaa 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -19,7 +19,6 @@
  * The quirk devices support hasn't been given yet.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index a6c4d97aee3f..96c483fb9afa 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -7,7 +7,6 @@
  */
 
 #include <hexdump.h>
-#include <common.h>
 #include <asm/cache.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/drivers/usb/isp1760/isp1760-if.c b/drivers/usb/isp1760/isp1760-if.c
index c96ab459f93e..54246b49d5fe 100644
--- a/drivers/usb/isp1760/isp1760-if.c
+++ b/drivers/usb/isp1760/isp1760-if.c
@@ -6,7 +6,6 @@
  * (c) 2007 Sebastian Siewior <bigeasy@linutronix.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/isp1760/isp1760-uboot.c b/drivers/usb/isp1760/isp1760-uboot.c
index 203500a4cb7f..8dcb7768a2c2 100644
--- a/drivers/usb/isp1760/isp1760-uboot.c
+++ b/drivers/usb/isp1760/isp1760-uboot.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index b1b22b9357ce..ca86b58dfcd7 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -5,7 +5,6 @@
  * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
  */
 
-#include <common.h>
 #include <dm/lists.h>
 #include <linux/iopoll.h>
 
diff --git a/drivers/usb/musb-new/am35x.c b/drivers/usb/musb-new/am35x.c
index 0a52e09e19f1..42bc816e4f1e 100644
--- a/drivers/usb/musb-new/am35x.c
+++ b/drivers/usb/musb-new/am35x.c
@@ -24,7 +24,6 @@
 
 #include <plat/usb.h>
 #else
-#include <common.h>
 #include <asm/omap_musb.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
diff --git a/drivers/usb/musb-new/da8xx.c b/drivers/usb/musb-new/da8xx.c
index 68fc0c36146d..7caf03cc2e14 100644
--- a/drivers/usb/musb-new/da8xx.c
+++ b/drivers/usb/musb-new/da8xx.c
@@ -13,7 +13,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device-internal.h>
diff --git a/drivers/usb/musb-new/mt85xx.c b/drivers/usb/musb-new/mt85xx.c
index 1e632dca0462..14b28bbae6b1 100644
--- a/drivers/usb/musb-new/mt85xx.c
+++ b/drivers/usb/musb-new/mt85xx.c
@@ -9,7 +9,6 @@
  *
  * This file is part of the Inventra Controller Driver for Linux.
  */
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb_core.c
index 00da554982fe..257e7685cfa3 100644
--- a/drivers/usb/musb-new/musb_core.c
+++ b/drivers/usb/musb-new/musb_core.c
@@ -79,7 +79,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #else
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <usb.h>
diff --git a/drivers/usb/musb-new/musb_dsps.c b/drivers/usb/musb-new/musb_dsps.c
index a8ff7434c9f7..b73f3531ce24 100644
--- a/drivers/usb/musb-new/musb_dsps.c
+++ b/drivers/usb/musb-new/musb_dsps.c
@@ -31,7 +31,6 @@
 
 #include <plat/usb.h>
 #else
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <asm/omap_musb.h>
diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index c6083963ede9..29e225aa0f11 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #else
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/bug.h>
diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index 55ce8de99bb1..63eee31a6b3e 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -18,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #else
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/printk.h>
diff --git a/drivers/usb/musb-new/musb_host.c b/drivers/usb/musb-new/musb_host.c
index e5905d90d66f..2f2fc7c1359b 100644
--- a/drivers/usb/musb-new/musb_host.c
+++ b/drivers/usb/musb-new/musb_host.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
 #include <linux/dma-mapping.h>
 #else
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <usb.h>
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 7cea9a2ed65c..43ab3245e5c3 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index 308eff832c9e..c8dd73050b29 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -8,7 +8,6 @@
  *
  * This file is part of the Inventra Controller Driver for Linux.
  */
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <serial.h>
diff --git a/drivers/usb/musb-new/pic32.c b/drivers/usb/musb-new/pic32.c
index 4ed5e6e90c6c..0b25e5893b3c 100644
--- a/drivers/usb/musb-new/pic32.c
+++ b/drivers/usb/musb-new/pic32.c
@@ -9,7 +9,6 @@
  * Based on the dsps "glue layer" code.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
index 778b01b22ea7..b577ba418780 100644
--- a/drivers/usb/musb-new/sunxi.c
+++ b/drivers/usb/musb-new/sunxi.c
@@ -15,7 +15,6 @@
  *
  * This file is part of the Inventra Controller Driver for Linux.
  */
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index ed5e5194d8c9..76e8b88369e3 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2016
  *     Texas Instruments Incorporated, <www.ti.com>
  */
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <dm.h>
diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
index 57c7d5630d37..6b4ef3c85782 100644
--- a/drivers/usb/musb-new/ux500.c
+++ b/drivers/usb/musb-new/ux500.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (C) 2019 Stephan Gerhold */
 
-#include <common.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index f945f1f5e2c5..2c23043d40e9 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -9,7 +9,6 @@
  * Copyright (c) 2010 Texas Instruments Incorporated
  */
 
-#include <common.h>
 #include <linux/delay.h>
 
 #include "am35x.h"
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9651f074a49d..260552e4dbd4 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -8,7 +8,6 @@
  * Author: Thomas Abraham t-abraham@ti.com, Texas Instruments
  */
 
-#include <common.h>
 #include <linux/bitops.h>
 
 #include "musb_core.h"
diff --git a/drivers/usb/musb/musb_hcd.c b/drivers/usb/musb/musb_hcd.c
index 4676cabae0aa..c95c6a482812 100644
--- a/drivers/usb/musb/musb_hcd.c
+++ b/drivers/usb/musb/musb_hcd.c
@@ -7,7 +7,6 @@
  * Author: Thomas Abraham t-abraham@ti.com, Texas Instruments
  */
 
-#include <common.h>
 #include <log.h>
 #include <usb.h>
 #include <linux/delay.h>
diff --git a/drivers/usb/musb/musb_udc.c b/drivers/usb/musb/musb_udc.c
index 2ffcb7caaad7..696855ee3a61 100644
--- a/drivers/usb/musb/musb_udc.c
+++ b/drivers/usb/musb/musb_udc.c
@@ -37,7 +37,6 @@
  * -------------------------------------------------------------------------
  */
 
-#include <common.h>
 #include <hang.h>
 #include <serial.h>
 #include <usbdevice.h>
diff --git a/drivers/usb/phy/rockchip_usb2_phy.c b/drivers/usb/phy/rockchip_usb2_phy.c
index c46ad86d3d65..9ec5b2d172b8 100644
--- a/drivers/usb/phy/rockchip_usb2_phy.c
+++ b/drivers/usb/phy/rockchip_usb2_phy.c
@@ -3,7 +3,6 @@
  * Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <hang.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/drivers/usb/ulpi/omap-ulpi-viewport.c b/drivers/usb/ulpi/omap-ulpi-viewport.c
index 1b01cd4c559f..6f0c3eb154ee 100644
--- a/drivers/usb/ulpi/omap-ulpi-viewport.c
+++ b/drivers/usb/ulpi/omap-ulpi-viewport.c
@@ -7,7 +7,6 @@
  * Author: Govindraj R <govindraj.raja@ti.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/drivers/usb/ulpi/ulpi-viewport.c b/drivers/usb/ulpi/ulpi-viewport.c
index 55a62808384d..bac20a02f018 100644
--- a/drivers/usb/ulpi/ulpi-viewport.c
+++ b/drivers/usb/ulpi/ulpi-viewport.c
@@ -13,7 +13,6 @@
  * Copyright (C) 2011 Google, Inc.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <usb/ulpi.h>
diff --git a/drivers/usb/ulpi/ulpi.c b/drivers/usb/ulpi/ulpi.c
index b5d2c2c2d1c3..128adcbde134 100644
--- a/drivers/usb/ulpi/ulpi.c
+++ b/drivers/usb/ulpi/ulpi.c
@@ -19,7 +19,6 @@
  *   Freescale Semiconductors
  */
 
-#include <common.h>
 #include <exports.h>
 #include <log.h>
 #include <linux/delay.h>
-- 
2.34.1

