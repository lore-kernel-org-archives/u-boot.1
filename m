Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD88F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9EA842FC;
	Fri, 17 Apr 2026 14:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxEy2DPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25617841D5; Thu, 16 Apr 2026 17:38:58 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39834840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso2870243f8f.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776353935; x=1776958735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKs6aENMKW4t+lnLTj67wZVES85SNDfN6rKoecY7hbg=;
 b=kxEy2DPAHF/FD6pQe2kvCTVG1NuFTN7wXGgYFkSXwnM803vkYMoXskDBUTU9vvd3lN
 X0bz+slFcAuSdnYzaclqdkUj8SKmUqrNN9V8VERC/rWiKptRVAPKsBv/lJi52ovl4Rh4
 kwsIDCEyBjJ9tDnzzM7lsZcM11XhpL739lBskXS2ycA2LQ4soAQGsnPIgRJqS1nF7w+N
 uWkb6h1V2pNwUQbDqv8Z2BMfgoVfCePpUg7CY4HkxTiBiJgw2sk8ROWsOHl4B6+u+fMl
 w8QD5WWXb5YvKkBfmEIIr3B7AbuceFVUdlqIiBXBkJdEFRPwkhYt//LKgb+jibWIoQq3
 uUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776353935; x=1776958735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BKs6aENMKW4t+lnLTj67wZVES85SNDfN6rKoecY7hbg=;
 b=iD2rpZj1MDD6EJF9vEDL7jBzflMSUe6qULDrzZvg7GtLsU9FkSw51PTUJ6VJe7fRPp
 or5akHg41oKbc1fWo56D3o5JbUKnWntdwlaG1lbQdpELKFUmcdhVjvrYHP6rJQRiIGNi
 3xi2qLIrRVdH/PUWaIvUxV1UHVj5JB/AR3bu7Bj53YoQKMi/n1kzLeNqdYO0CgSGknYM
 X5krcg511mpyDm99X6rlGbyNXpO3iuF41H09MBHBgS5/bwicbAm/Ze2g0a6BgkpyEjO+
 HNKewlnorbdq4qOr3ucDpU2ObX2KjODzp8LOLBn0nAsvuxqTbtEooCSnFHV9lgEPLWNC
 Fe6Q==
X-Gm-Message-State: AOJu0YyNsiVHWYxCTglaTQgGzz8VlCdCaIDjvvRGDhnPHE/l+ZFFjrRV
 k/aqCfIvVIxoIreTz9RQ5iRpfjNSrdcsG1cLhxZxM8DmGBsxMTOLmuiZXkGchTfI
X-Gm-Gg: AeBDietlefp+iKNeoI/sTYjzkc8yUfJWhAAINid4B+we0QMXUW+8V5rvVlbSUh1dMI3
 D8PutqOkepX5rudnhSPeS6QX/vH6tTKxQxRxhBgKSkn/MBxGm1WeVMkdvmzyKGhxAmKUTD9RZf+
 34w3j1s/FIUWD7bNCFQzdpKceLEgtY3xSh9XLt5Kbb/00E9qyfT04Jv3aNhzwDSmuJJk4BVk1Cq
 RWrDBovjrIgsGUsE4dIbfBKqb27IPRj9jrRbsR0nu0r5Ccz24P4+Yz1uJRopR5RPfe6DWyT/RPI
 uJc/Z3qRjPaAq7X638lS/nrhmevK7DHcSOc5I8S6IHFAK+b8odbN9zKzbsNHbfPojPLRyMO2v4u
 pYhiZnbkYb+b6pAQ5BpEAP6BsqR/Tg02BpGNxVuk0xI6JUHxruL2q4dcGZ89HuWiNgHwpc+i1nQ
 ZEZyTqcw9Fyjm/H8OYsjP+oxienvTI6hGoD9o6t2uz
X-Received: by 2002:a05:6000:2583:b0:43d:7d24:b506 with SMTP id
 ffacd0b85a97d-43d7d24b82bmr22492802f8f.38.1776353934737; 
 Thu, 16 Apr 2026 08:38:54 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm15663463f8f.18.2026.04.16.08.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:38:53 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev, jh80.chung@samsung.com,
 peng.fan@nxp.com, lukma@denx.de, mkorpershoek@kernel.org,
 trini@konsulko.com, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v3 2/2] usb: gadget: renesas: add support for RZ/G2L SoC
Date: Thu, 16 Apr 2026 17:38:27 +0200
Message-Id: <20260416153827.14256-3-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416153827.14256-1-micbis.openwrt@gmail.com>
References: <20260416153827.14256-1-micbis.openwrt@gmail.com>
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

Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
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

