Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D4DF4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2632B84297;
	Fri, 17 Apr 2026 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOwPEpN0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B22D841F2; Thu, 16 Apr 2026 16:45:10 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3C1841C2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488c2690057so82109995e9.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776350707; x=1776955507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITezWZ76YZkfMJJHfN7K+7rosPUNBPmRwlq2NM1uEfk=;
 b=iOwPEpN01wCz5C7uPLGnzxIQx9hcQ0/eNnMbFkO7oskShTalna9r6hAqDA7PyV2+nE
 sBtmrdQkbXuDQQp96iX6a6a0/KfSV+7a8loe4hZOYVRJrb7BMcrdl+YkxEXdpeLnLKdX
 oydXlLjFr+jazAwZ9QI3kZkLuQvOegpC93DjSJVdKE3PWfvlz9NUM7RBjoiGkArfJIIN
 G2EUSM/pCFGZaL8Ll4wtBD7C36PqWVFjB1+Upq673qb2iDMmCk/tQN7uyhQ+r2cqbjz3
 l5M/hPXYTANcMDiiaRFx8bRfSFNVYaFb5zY94FrkM076TYyenGwdMxbUb10d2/YuzVDU
 IRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776350707; x=1776955507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ITezWZ76YZkfMJJHfN7K+7rosPUNBPmRwlq2NM1uEfk=;
 b=VvsAEn1/M9/LcbT256e8siPD1w24wOKLhUf7BLS0WsK3XUzaBGoeAw+r3hF6Nl7K4S
 7wJ1ddQHhSGQKsduMd/eNfmIGAmkeToZPyhcLur1CZ5qn3w7g9rStdbCS6QOpfCB7kyV
 KJUEkalEmVHyb8/Lgq/ZkgaCQ3XYxZghJwyll/cGiSBZWirmJyk0yUzLioqCbRwFHv1M
 r+pFxoRGqhgkFjdCi4GXA7AEHJ4mGsEdpBC7ygDLTMDBY82P2ZrTOUSPS1GBtay4BAlF
 zGfYk5R+ZVGg9pRk/vVi8ZzbKMrg3o0yzQFsEhs/6c0q5BpjFBWoJ1QowgI3etZKtQsu
 PzHg==
X-Gm-Message-State: AOJu0YyOZFyT4Srlw6T4wPHQ5rjWEiYYx1lA8fhSVWZ+sqGYPNaQb1rA
 7Zdye4+YApKAjNYIR9l1A42gcjfgnC9tVjmdjlbWRrQ/zsYzkVdU8i8Rl2VNsbqq
X-Gm-Gg: AeBDiesEorQ216gkWIo2cFtSWGN5T07EI8z+uD5s5ThAqb9ER+XAB2n7qaRiscAqJ19
 +MyOG3yHusCXnYYD2jPAkYOcRUyk44z6N92CTMca4n/eqOPCiMsvy8+tqJKzFyHYnS6po+gMQqi
 3BMHyT+BvjXv4wO0yx90J7z9l0WDDEAxum9sy+6BHu9LEZ3QEjy5xxzo6P/OEYkuABQA9p8PBxv
 7grywCKTrvbdCofRQZSiYN6Q48M1mpsh50+Mu7NwCiaFWjw1Y22/RP7gqgwm/cxGprpSjQ3Zn5g
 KgztrBjLSSbZFGjRy1q7q2WQ9w+r8gzkvF+B4zcac0ux/tMU0SWtYNYDx0qXRDCFVERLsdDw/4P
 4x9xiVr8UP6bNpHiXu3EDfS0Md9O5i2XmL3Bz47XAEOGgR5IcwTYQQsSnBNtHdNdz86Rp2GFT1C
 3bNdCWakj8W9nZhvqWAxUe233GMt/kdC0bE5VPrIh7NjcjKL6m8hc=
X-Received: by 2002:a05:600c:a105:b0:486:af22:4a2a with SMTP id
 5b1f17b1804b1-488d681f281mr255196975e9.7.1776350707077; 
 Thu, 16 Apr 2026 07:45:07 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f58163cbsm58756775e9.1.2026.04.16.07.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:45:06 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev, jh80.chung@samsung.com,
 peng.fan@nxp.com, lukma@denx.de, mkorpershoek@kernel.org,
 trini@konsulko.com, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v2 2/2] usb: gadget: renesas: add support for RZ/G2L SoC
Date: Thu, 16 Apr 2026 16:44:26 +0200
Message-Id: <20260416144426.12728-3-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416144426.12728-1-micbis.openwrt@gmail.com>
References: <20260416144426.12728-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

common: Add "renesas,rzg2l-usbhs" compatible and support
reset deassertion. Fix a re-entrancy bug by calling usb_del_gadget_udc()
in the remove callback to prevent stale UDC list entries.
fifo: Refactor PIO push/pop logic to handle trailing bytes
using iowrite8/ioread8. This ensures correct data alignment on
RZ/G2L and simplifies the data transfer loop.
---
 drivers/usb/gadget/rcar/common.c | 15 +++++++++++++++
 drivers/usb/gadget/rcar/fifo.c   | 23 +++++++++++++----------
 2 files changed, 28 insertions(+), 10 deletions(-)

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

