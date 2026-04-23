Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820A5FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AF78457D;
	Sat, 25 Apr 2026 22:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W2M4cXZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03082841D7; Sat, 25 Apr 2026 22:10:31 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39A484178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-38ea6a5a0b3so87743481fa.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777147828; x=1777752628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkwmsnFoENg8PCpuC74lQSspv6JZWl+rFhjNSgslJ8M=;
 b=W2M4cXZgDZCKhCLqTJVNJDOfjpvI0i3OvRMyGQHgWLWmVgm8M/kGyLDqPnnUtmLif3
 1LVKQEoqm1l0RnubZJ1QfI3yu4d/nrcjuU5czwncRyVVUxSX99WuJz20v32iWIspaVET
 MKWCc7Ok2y5pw2a52PLdWGpXibysFozt9NcaU5DfQSZuPbuoM5WVRyvdIyVU0fwcJd1s
 igaYfHCDVEsLpKpSb0TblnhJ0dFb5NRg7Rlk2n8IWw02HIRK0btce1K2wYfR8+H5ddyG
 tvpkCRMD2EBEK8310QGEjx/eTV8dFWNEkTuXwX4a99m0qHjUdlnhgNwmGdREQaESRBo5
 RJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777147828; x=1777752628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zkwmsnFoENg8PCpuC74lQSspv6JZWl+rFhjNSgslJ8M=;
 b=h3YFIKis9xvi74Tncbp60x7QBKeCXW6PFzimJCbGTGrHWpJQfntRDObAsViOqYZF1R
 J0CvN7HfrediVHRqKE3NifN4PudVrPCuABC1AEfYd8mjpjyV9l74eBgpGje6PR652xCt
 oW0VRytz74pgmObXZRAwFV7wdF3FxXQQDbGrt6DPzEHWeubXHuZm/I14F9G0ctU8ySJh
 kZqwVMNfFkntpHeARQ0EG+LaCMdGFALCMvMMUonnDxBRgy4/LkIAvG9sfMm4MIU1dHDS
 bsvwjybB/49q5oKRNMAJOQvd5BPBrjbEVLoo0LEXoex7YjkDeaySrVYefOMyXquY3JM7
 Dmrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gmiIBLiuq1eLcZWrP5WhUYQ2TjCi2eRCHGf5Awx2gQr7hN4BC8loUCVgP11D1wdI8rK5w340=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9SMKsfKKprFGAv9xtwRFzo7p5iSrTthfO4K5L7yFBLfTwVt8R
 67hFGHMkPLxHiocpcKj9pcqh+HVukjXK7Bz/+Z5ou1wDf7GYR1RplIA/jERlvw==
X-Gm-Gg: AeBDieuOVewiT7MlEsl3SSnbOOT051lxpk18j3b8sjoqCSwIdIFwv8VVRq6hn2nzYQY
 Wu6gZhKPlz+I9cFsWRdPZOKy5j6oE/4zR/mHVTiXGa+IZj8d5J+fkAFSxMltBsVijBkQuW11qJv
 Pr/aqDQwN4k1fo1cVcTeBVqov0TTV5vdfSyiyPB72UB9ZonJEWGsUo68mlEV5hO84QK/Xx1r0+l
 2+kEAmhbifBS3Xx/xbInzpZZZp4v9pqZedpRdbs+nmc2MKRzi1mPkMsiu7hNmOe4chWL5M9tBV1
 FXp8WKCARnoltunBwwle93jbU1mue8NdC+A2yDVDRuhO5Pk2/IRXGsmhX8R8CR3WAKtg9g6Aha9
 1tu7c4uZd8gpeKQ7+zBI897AagQbNymr0z8PXsLT9dRb/rYznbCXseHcjUQhwcGxS7R/rJ1yWBF
 qbtgIm5nbkLv9ua8WQNuI+WNQQtBFzfGDUyUqlTDM8hS5NaEzfuKc=
X-Received: by 2002:a05:600c:5285:b0:48a:5333:811e with SMTP id
 5b1f17b1804b1-48a53338269mr225648525e9.15.1776949426857; 
 Thu, 23 Apr 2026 06:03:46 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm549381425e9.2.2026.04.23.06.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:03:45 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v5 2/3] usb: gadget: rcar: Add support for reset controller
Date: Thu, 23 Apr 2026 15:03:22 +0200
Message-Id: <20260423130323.32533-3-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423130323.32533-1-micbis.openwrt@gmail.com>
References: <20260423130323.32533-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

Some Renesas SoCs, such as the RZ/G2L, require the USBHS core to
be explicitly deasserted from reset before register access is
possible.

Update the OTG probe to handle a bulk reset controller. To maintain
hardware stability, the reset is deasserted after clocks are
enabled in probe(), and asserted before clocks are disabled
in remove().

Update the error paths in probe to ensures clocks are disabled
if the reset initialization fails.

Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 drivers/usb/gadget/rcar/common.c | 35 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index d40d6736a54..32c4f1fadb1 100644
--- a/drivers/usb/gadget/rcar/common.c
+++ b/drivers/usb/gadget/rcar/common.c
@@ -16,6 +16,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <usb.h>
+#include <reset.h>
 
 #include "common.h"
 
@@ -290,6 +291,9 @@ struct usbhs_priv_otg_data {
 	void __iomem		*base;
 	void __iomem		*phybase;
 
+	struct clk_bulk clk_bulk;
+	struct reset_ctl_bulk reset_bulk;
+
 	struct platform_device	usbhs_dev;
 	struct usbhs_priv	usbhs_priv;
 
@@ -355,8 +359,10 @@ static int usbhs_udc_otg_gadget_handle_interrupts(struct udevice *dev)
 	return 0;
 }
 
-static int usbhs_probe(struct usbhs_priv *priv)
+static int usbhs_probe(struct udevice *dev)
 {
+	struct usbhs_priv_otg_data *otg_priv = dev_get_priv(dev);
+	struct usbhs_priv *priv = &otg_priv->usbhs_priv;
 	int ret;
 
 	priv->dparam.type = USBHS_TYPE_RCAR_GEN3;
@@ -396,34 +402,41 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
 {
 	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
 	struct usb_gadget *gadget;
-	struct clk_bulk clk_bulk;
 	int ret = -EINVAL;
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -EINVAL;
 
-	ret = clk_get_bulk(dev, &clk_bulk);
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
 	if (ret)
 		return ret;
 
-	ret = clk_enable_bulk(&clk_bulk);
+	ret = clk_enable_bulk(&priv->clk_bulk);
 	if (ret)
 		return ret;
 
+	ret = reset_get_bulk(dev, &priv->reset_bulk);
+	if (ret)
+		goto err_clk;
+
+	ret = reset_deassert_bulk(&priv->reset_bulk);
+	if (ret)
+		goto err_clk;
+
 	clrsetbits_le32(priv->base + UGCTRL2, UGCTRL2_USB0SEL_MASK, UGCTRL2_USB0SEL_EHCI);
 	clrsetbits_le16(priv->base + LPSTS, LPSTS_SUSPM, LPSTS_SUSPM);
 
 	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_OTG, 1);
 	if (ret)
-		goto err_clk;
+		goto err_reset;
 
 	priv->phybase = dev_read_addr_ptr(priv->phy.dev);
 
 	priv->usbhs_priv.pdev = &priv->usbhs_dev;
 	priv->usbhs_priv.base = priv->base;
 	priv->usbhs_dev.dev.driver_data = &priv->usbhs_priv;
-	ret = usbhs_probe(&priv->usbhs_priv);
+	ret = usbhs_probe(dev);
 	if (ret < 0)
 		goto err_phy;
 
@@ -439,8 +452,10 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
 
 err_phy:
 	generic_shutdown_phy(&priv->phy);
+err_reset:
+	reset_assert_bulk(&priv->reset_bulk);
 err_clk:
-	clk_disable_bulk(&clk_bulk);
+	clk_disable_bulk(&priv->clk_bulk);
 	return ret;
 }
 
@@ -456,6 +471,12 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
 	usbhs_fifo_remove(&priv->usbhs_priv);
 	usbhs_pipe_remove(&priv->usbhs_priv);
 
+	reset_assert_bulk(&priv->reset_bulk);
+	reset_release_bulk(&priv->reset_bulk);
+
+	clk_disable_bulk(&priv->clk_bulk);
+	clk_release_bulk(&priv->clk_bulk);
+
 	generic_shutdown_phy(&priv->phy);
 
 	return dm_scan_fdt_dev(dev);
-- 
2.34.1

