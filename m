Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F75FF885C
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 12:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D08841DF;
	Sun, 26 Apr 2026 14:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QLYHy9Pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0D88407E; Sun, 26 Apr 2026 09:43:47 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DFD283FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 09:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44261378651so500176f8f.0
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777189425; x=1777794225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ortHc4MwPeZtRaLj2m8Cf3zRQaygfEZpqaESEJAbLYE=;
 b=QLYHy9PvZcHNwC9mu9moNpcUcjVQy/cur0Pp6e3qylEFuOqGB6Bo2Hu78RjM1n80T6
 5LEQM5c1jwdpU3BcK4SORx2Mqcf8/cRz2SPs6QtqVqtLE/MjczJ6OgbwIxEBnEHDgeop
 cQSsk/9Q54CPrmEayhTmAqLmvEfGuLf6Qg3HajyZ6zXZ4pizZdktB+cKpJ+Hb/biO3OY
 5TArhcpetg5zQcyoE5FZjGxRjNgn7N2IRfBnNQlIVsNcRZmaGYZqJy8ER3Ye5EjX5x1G
 sx2xMl6b5y3DvrxqWOsy4aGMi5xV3hKV5borfcPhPnuZ0J6SOhK9KZ9v/bprpKehlRIw
 MRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777189425; x=1777794225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ortHc4MwPeZtRaLj2m8Cf3zRQaygfEZpqaESEJAbLYE=;
 b=Wj0xSrJBHJE0OyiZyJWyrWHGMFV+ljtWyIwPWJWgeJgXAkoZdbYkws8Gogn3g0a3Z+
 L21K/kx/TJJ8RfmMqbLq1nudtCFyKGH5J5yUpZYNvDCyqXaqdJD9VcUVRWflBJp6xvP+
 zfpZBD0AVSKIo8pxbupuc8oCF7rwhvnwKlaZskviemNwcMNRY+blZmFhf9BC9QemttQ1
 gTrNq/bhNvsjJatpp87xwxZ1Lfu6gMCUvV7r48FodNZssnhSbz2Hn3N5caX2bAobezU0
 i8xve8Lc7FyJ3bVgs1Zt1+xUrYM7T7W7zYW5c6IlC3oeU4sPwmuN4jKbHxYEv8Ek642l
 c/Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zRgHK977oeWKaG4YuwEjUj10w3neayWeQ3tHKxz4vMAj8QFtUoWovE/CZBzb6YImNJHCL358=@lists.denx.de
X-Gm-Message-State: AOJu0YzhajmRXth4QJ+A97W8SyySXI0+tTGVjdTgm2C3rPkNyPuHkL3S
 RzkntF04nHAlVkcqJHQWZrkAykCC9usUSiut+nAIm3fZQj5h8axwiL7rJAAkJA==
X-Gm-Gg: AeBDievrN4cJ9r1kzm1mzO3ta1zc0UzPdejMe43Xj1PYkpqJ6IPdfN83NSo6QG/jHxS
 jADtGqHKj+w5L9GJOQGSCYC6BJVyIT+G+1xsgV0ksEB7h2D/fI192j7IOyNuQmJBjRVGPdwhUab
 Kcrub7F1NjY1Hm7mS2S5dPLId3iFwl6T9jVNxHqJf3UIBUjXc2vmucj9LFjWViWwa94OLzGrKxM
 Xvgr6NfpZlEcJCuXuGNdaDYCutwbO43FILx95de9hA6SvTidVIB/DGpsOQe+2s0R5yYZ6lgyDBR
 UvaKAXuUEfrerqT0Q8BzuX9IgF5Hq62x0zOACh1w3u6PN8RLbEi+OgkrpXWIdUoK3qSjTXDeOeZ
 ztOTR4QffcHxgcm7MSrR4fS6nWj+/sgju292VPppFgTxnvFr8r3r76XDskKq1YF73oO7y8SyMGt
 Snzwy2EnnutyWMzR/dm1Hg4tDt8WMcB1Aq8nv9cZJBYAGNskY/j11OEjBLkvf+CA==
X-Received: by 2002:a5d:4527:0:b0:441:29c5:f90a with SMTP id
 ffacd0b85a97d-44129c5f92bmr16147649f8f.22.1777189424466; 
 Sun, 26 Apr 2026 00:43:44 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm76748031f8f.7.2026.04.26.00.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 00:43:44 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v7 2/3] usb: gadget: rcar: Add support for reset controller
Date: Sun, 26 Apr 2026 09:43:18 +0200
Message-Id: <20260426074319.5819-3-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426074319.5819-1-micbis.openwrt@gmail.com>
References: <20260426074319.5819-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 14:57:25 +0200
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

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
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

