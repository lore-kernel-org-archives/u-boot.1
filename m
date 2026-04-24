Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C18DFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E1D843E3;
	Sat, 25 Apr 2026 18:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOg4Lso1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC86684105; Sat, 25 Apr 2026 18:46:24 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D51C683FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6729c6f0ca7so10586543a12.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777135582; x=1777740382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUe2stPyjsAPPulSulQOXixF15m5m+LFwVhBMoJRTYk=;
 b=MOg4Lso13MufdlyBr7uLmNJyZlRZNMzFgADZpQhu35C0LxNUF7hnV8S11WC4jTrfip
 VcfQ+IY/uBhSHPrzlEaHECAtCJ0qTNMlPWb0ONUsyeuJ1exdFMJn5Rtncb1GdzyC/dC1
 A2KOpjgFFA0JsQpu3apCsHXvj3WxVSGK+Rnn502pjQUhPOiaBYw+ilozD0ezs129+g8A
 HVWXiPyoncygaFUiu5EBb0h4b1IrWfFk+4rZWPVEbRblICHETzQIxdh4XEr9hOPg6KTW
 xVB8uCTEOH+TUvAIX/g9vCeN/OWbioJxNon5519OmcHEvYFTeZqkThK73v/2rGpgSfMq
 40wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135582; x=1777740382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xUe2stPyjsAPPulSulQOXixF15m5m+LFwVhBMoJRTYk=;
 b=gQn0ghLMREqh1tACT6qwF/YnrDhiqXHajpJJOJGs66tNzEE2QEY7F7Trncwy5u8NBd
 2Q9ZSp85fAy0hQRrGvFrhlWc1XGq1eokjA0eXiM2p7FV53Y7X3MzQtqknEKc1T0u8YkX
 YjTjacuOIqu8bXMw7V5hk508XX80twVPikiiKAg3Bu4li4JLiLC/5kJ3L0oHTKUnmbpE
 yNDBNLRokxGZl/tckqJSIFSw4mJZ3B6KoKoa9mRIWY93/YSK9MM5//15pdS34ppp7K3S
 3TkzbBoLxeugnE41GGlivDl/NoIPTPnRX3eU46+a0gBpjUyUEvH6kfFEGOd88v+Fi16P
 JQ4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ95PgI+BI6iQa20me2h0NbnHxOItTn27MAlcfx1ECDrYmcluf5N13ZqNj/49+GVu2vt0HQfudk=@lists.denx.de
X-Gm-Message-State: AOJu0YzNze4wDQqp8mQIIdtF7E+RklAwkt2Hz0a+dkYixWqxBSyjibaI
 2TIjOurCFKHs9JgmYQMR0OEBvHLw3xEaCo7/JnEfLckLDlUcY4/L+3IjuIdG7w==
X-Gm-Gg: AeBDietpw8gmS3BIly0GdqFPviBUhN6SdH+O8t2cn3cdi6WzCPdJtXV/4RITk6VvLu2
 pwuWwrH9CnF6lgOJ7QMK0N9ETaY0PSU3tf7n2xODRJMa3ax5PF+OdCkO3REdI9JqXs55PyVZfc0
 ER4CJeC0C6CUT/llUWIVmYADybrUs3/RJNJ4MoxImFtp0OzJP4eaeJHcC5cdYEbILe/lDycJ0Sx
 m2N5nPsKHwOhjudG2/rPG0VNmb0rgez7gojqa8f4Ir8w9EMA3t61y28MuomdDwlhecqGOnMwsgE
 Mm4im2DL/m2ptwUK4jhB5IoG/20l6ZDPQaWPso+RoDpJieRbvE7HJdMoTj0xk60kZCvtizVXGlZ
 zr0efdvcwyOQMwjL8RKsGn5PxjdNXs7W/JWXzFN3mr21GzutWEQlrWCtFE2/Pa2FWtt44NUGJyC
 2EdWJbB7TwjbnjZt3tebd44A+pkXIaUlbZ3fPD0ArmSvu70cVZFyo=
X-Received: by 2002:a05:600c:621b:b0:487:5c0:671f with SMTP id
 5b1f17b1804b1-488fb742e74mr498815105e9.9.1777046647088; 
 Fri, 24 Apr 2026 09:04:07 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm678783845e9.8.2026.04.24.09.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:04:06 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v6 2/3] usb: gadget: rcar: Add support for reset controller
Date: Fri, 24 Apr 2026 18:03:15 +0200
Message-Id: <20260424160316.157380-3-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424160316.157380-1-micbis.openwrt@gmail.com>
References: <20260424160316.157380-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:44 +0200
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
 drivers/usb/gadget/rcar/common.c | 42 ++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index d40d6736a54..2bf0dcff393 100644
--- a/drivers/usb/gadget/rcar/common.c
+++ b/drivers/usb/gadget/rcar/common.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <reset.h>
 #include <usb.h>
 
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
-		return ret;
+		goto err_clk_enable;
+
+	ret = reset_get_bulk(dev, &priv->reset_bulk);
+	if (ret)
+		goto err_clk;
+
+	ret = reset_deassert_bulk(&priv->reset_bulk);
+	if (ret)
+		goto err_reset_deassert;
 
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
 
@@ -439,8 +452,15 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
 
 err_phy:
 	generic_shutdown_phy(&priv->phy);
+err_reset:
+	reset_assert_bulk(&priv->reset_bulk);
+err_reset_deassert:
+	reset_release_bulk(&priv->reset_bulk);
 err_clk:
-	clk_disable_bulk(&clk_bulk);
+	clk_disable_bulk(&priv->clk_bulk);
+err_clk_enable:
+	clk_release_bulk(&priv->clk_bulk);
+
 	return ret;
 }
 
@@ -458,6 +478,12 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
 
 	generic_shutdown_phy(&priv->phy);
 
+	reset_assert_bulk(&priv->reset_bulk);
+	reset_release_bulk(&priv->reset_bulk);
+
+	clk_disable_bulk(&priv->clk_bulk);
+	clk_release_bulk(&priv->clk_bulk);
+
 	return dm_scan_fdt_dev(dev);
 }
 
-- 
2.34.1

