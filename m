Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EDAF433CC
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 23:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B852F84201;
	Thu, 16 Apr 2026 01:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oIor773y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3358407E; Wed, 15 Apr 2026 19:21:40 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B4583936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 19:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so4394075f8f.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776273697; x=1776878497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ChralTyzbjqayJnfM9/H7w8B69XsMq5McNeKcy90Vys=;
 b=oIor773y6bu+zp/duqpRaFjYSpbovgQGEja2QhMKX/Z41gzN1Ve4zLI9eoHJTnjEDx
 9aQ2fI5EHhwjqdB4Gq5n7ctGxHoCvh01cyfwn+EWesKNjGS3LN0VfL4dTvxOsVBO/HH/
 Si69iX5efY+SgmHdoj4SkcMgt+j5OtcE3s5FsVbM7VD0ShjTGRumsi8qwMmqsQggf/SK
 18JTJjcUjxsnM2cvF+z03V84CTyxn1id1iW0yj3YY9grQuw4K/BT0Pu6XwXcrE18PNU2
 XYHrg4vJCb14Cup7ZiCgK0oJYvKkmFl0hnqmmbx1Zelq5xgRoxtZyK8V6pqes3w1Eq/S
 GAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776273697; x=1776878497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChralTyzbjqayJnfM9/H7w8B69XsMq5McNeKcy90Vys=;
 b=fwAzor9daSv8dGnYZaKObYWb5m1sNmJuaUGUc0tV+sQ2OV7hlDAmhKzUYOxyKxjUnm
 sfnsZciKZvYQ44ke0yl3IEtTUZdGKe0ZURZs3EieIMHryUrJ2Fqs9jCaPB8FjBtIRrbi
 MgiB4aM5nGyXKVyS7JQNXy5G9fWFG/h25+lY+79HAEqqrWmnN5CsiLmgcruf49WbAn+P
 DS2YiAqYxc0VAaiB/0SyNLEi+xLIcypQkuhRwQCGGQWC+vFvu0NM9J+GoR4WQzvM8sK6
 O0OQuV90FQGGIYNpUKU6yNVLw8jJc6K6r+Mp1Qs7kspq92WdOuUDjiMchH1chn/trzw+
 Jxkg==
X-Gm-Message-State: AOJu0Ywv6fn27oYtL+A97WC8dH2f2AAt+ePV11bOqW3tB9RAHyQY37gp
 J/pN8kam3Qh4ecwl0QYYO52d1Es0fjB6lnSOjdfYkrjZCy7sGAIcgbPNlsv1FCXf4UA=
X-Gm-Gg: AeBDievN+34qt/0Vht3uZsg0fc0vywFY4SnNAFmspj5z1Hkc7vrD1LzMC6uv1rYH9rY
 I4VNBVvOkPr7sQ8N6bOgRqc50jnScFwmRMxQjlE0cZi5r+ORvA9DrUvsZMaxyA/NAhw9KTCmH0O
 /oZq0acSfnZev8ObmBYz5tnKvynx6b88X4Lt69/MTqsgS9VH4zSV0BPj16sJzSLCAoWVwxJesy2
 oJGNlS5jR2n4NIuRIOgT2MN8GlMzTgQ16YSJdYEokBLnHK/P/Uoxc1Qrhfdg2oGr+cjpRo3sfxx
 Wk5WmrH7PvjUsPeomY1l+pYfwQc5XIqCQANlQwGluOI8eAP+JjzuePYVXAzgPWp7qbt+M3zePPV
 Jftp7egUywXVRsc73V4Kmb2gJMVrWe+ING6HjKErjquXWjozim9yuOsTA8EiWyCLm/deqFauUN1
 yhPN0/ZWcrnG1cuGL7mvgZ/zpBsjQDHOMWskc4sUfa
X-Received: by 2002:a5d:64e4:0:b0:43e:a638:250f with SMTP id
 ffacd0b85a97d-43ea638264cmr11844620f8f.1.1776273697008; 
 Wed, 15 Apr 2026 10:21:37 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33da6esm6210954f8f.5.2026.04.15.10.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 10:21:36 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev, jh80.chung@samsung.com,
 peng.fan@nxp.com, lukma@denx.de, mkorpershoek@kernel.org,
 trini@konsulko.com, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH] usb: gadget: renesas: add support for RZ/G2L SoC
Date: Wed, 15 Apr 2026 19:21:13 +0200
Message-Id: <20260415172113.273702-1-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Apr 2026 01:59:51 +0200
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

Support the Renesas RZ/G2L (r9a07g044) USBHS IP by addressing
platform-specific reset, glue logic, and FIFO access requirements.

- regulator: rzg2l: Implement CON_CTRL manual connectivity notification.
  By setting SEL_CONNECT and CONNECT_1, the UTM+ core is notified of
  connection status in peripheral mode.
- gadget: common: Add "renesas,rzg2l-usbhs" compatible and support
  reset deassertion. Fix a re-entrancy bug by calling usb_del_gadget_udc()
  in the remove callback to prevent stale UDC list entries.
- gadget: fifo: Refactor PIO push/pop logic to handle trailing bytes
  using iowrite8/ioread8. This ensures correct data alignment on
  RZ/G2L and simplifies the data transfer loop.

Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 .../power/regulator/rzg2l-usbphy-regulator.c  | 10 ++++++--
 drivers/usb/gadget/rcar/common.c              | 15 ++++++++++++
 drivers/usb/gadget/rcar/fifo.c                | 23 +++++++++++--------
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/power/regulator/rzg2l-usbphy-regulator.c b/drivers/power/regulator/rzg2l-usbphy-regulator.c
index 0354555d0b5..03f8dec4f08 100644
--- a/drivers/power/regulator/rzg2l-usbphy-regulator.c
+++ b/drivers/power/regulator/rzg2l-usbphy-regulator.c
@@ -9,16 +9,22 @@
 #include <renesas/rzg2l-usbphy.h>
 
 #define VBENCTL			0x03c
+#define CON_CTRL		0x020
 #define VBENCTL_VBUS_SEL	BIT(0)
+#define SEL_CONNECT		BIT(4)
+#define CONNECT_1		BIT(0)
 
 static int rzg2l_usbphy_regulator_set_enable(struct udevice *dev, bool enable)
 {
 	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev->parent);
 
-	if (enable)
+	if (enable) {
 		clrbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
-	else
+		setbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
+	} else {
 		setbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
+		clrbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index 2ba022a3f2c..1f266ae5ac9 100644
--- a/drivers/usb/gadget/rcar/common.c
+++ b/drivers/usb/gadget/rcar/common.c
@@ -16,6 +16,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <usb.h>
+#include <reset.h>
 
 #include "common.h"
 
@@ -397,6 +398,7 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
 	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
 	struct usb_gadget *gadget;
 	struct clk_bulk clk_bulk;
+	struct reset_ctl_bulk reset_bulk;
 	int ret = -EINVAL;
 
 	priv->base = dev_read_addr_ptr(dev);
@@ -411,6 +413,14 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = reset_get_bulk(dev, &reset_bulk);
+	if (ret)
+		return ret;
+
+	ret = reset_deassert_bulk(&reset_bulk);
+	if (ret)
+		return ret;
+
 	clrsetbits_le32(priv->base + UGCTRL2, UGCTRL2_USB0SEL_MASK, UGCTRL2_USB0SEL_EHCI);
 	clrsetbits_le16(priv->base + LPSTS, LPSTS_SUSPM, LPSTS_SUSPM);
 
@@ -447,7 +457,11 @@ err_clk:
 static int usbhs_udc_otg_remove(struct udevice *dev)
 {
 	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
+	struct usb_gadget *gadget;
 
+	gadget = usbhsg_get_gadget(&priv->usbhs_priv);
+	if (gadget)
+		usb_del_gadget_udc(gadget);
 	usbhs_rcar3_power_ctrl(&priv->usbhs_priv, false);
 	usbhs_mod_remove(&priv->usbhs_priv);
 	usbhs_fifo_remove(&priv->usbhs_priv);
@@ -460,6 +474,7 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
 
 static const struct udevice_id usbhs_udc_otg_ids[] = {
 	{ .compatible = "renesas,rcar-gen3-usbhs" },
+	{ .compatible = "renesas,rzg2l-usbhs"},
 	{},
 };
 
diff --git a/drivers/usb/gadget/rcar/fifo.c b/drivers/usb/gadget/rcar/fifo.c
index 6016b2987d5..b5340b4d860 100644
--- a/drivers/usb/gadget/rcar/fifo.c
+++ b/drivers/usb/gadget/rcar/fifo.c
@@ -535,18 +535,21 @@ static int usbhsf_pio_try_push(struct usbhs_pkt *pkt, int *is_done)
 	 * 32-bit access only
 	 */
 	if (len >= 4 && !((unsigned long)buf & 0x03)) {
-		iowrite32_rep(addr, buf, len / 4);
-		len %= 4;
-		buf += total_len - len;
+		int words = len / 4;
+
+		iowrite32_rep(addr, buf, words);
+		buf += (words * 4);
+		len -= (words * 4);
 	}
 
 	/* the rest operation */
-	if (usbhs_get_dparam(priv, cfifo_byte_addr)) {
-		for (i = 0; i < len; i++)
-			iowrite8(buf[i], addr + (i & 0x03));
-	} else {
-		for (i = 0; i < len; i++)
-			iowrite8(buf[i], addr + (0x03 - (i & 0x03)));
+	if (len > 0) {
+		if (len == 2 && !((unsigned long)buf & 0x01)) {
+			iowrite16(*(u16 *)buf, addr);
+		} else {
+			for (i = 0; i < len; i++)
+				iowrite8(buf[i], addr);
+		}
 	}
 
 	/*
@@ -716,7 +719,7 @@ static int usbhsf_pio_try_pop(struct usbhs_pkt *pkt, int *is_done)
 		if (!(i & 0x03))
 			data = ioread32(addr);
 
-		buf[i] = (data >> ((i & 0x03) * 8)) & 0xff;
+		buf[i] = ioread8(addr);
 	}
 
 usbhs_fifo_read_end:
-- 
2.34.1

