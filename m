Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6F5FA1FEF
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 20:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6629884401;
	Wed, 22 Apr 2026 22:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KoXpTwKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C5E84277; Wed, 22 Apr 2026 19:00:43 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA1384314
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso48814355e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776877235; x=1777482035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXkH/ZC1/r1mtLVPLqLEHNs4+L4xtL+8l1G0DSlOQ0Y=;
 b=KoXpTwKB0GUy1az1hkG6vR2GoAXSlBzquHM6PwWQ/N6i7BPJy2xtgKEp3sg+rhGwzA
 slkiPF63UTZ+EgPLg5VQMIv95GeoIkUJdJoK/vrYBlwYMmChnqMsmBoB88QbwC4ml1H5
 EeGfqtebxOLPk7AGIYovFAlumyY3zrEArUw4V1t/CZW+QwkzYDICJ0jGNg+hQBenLoI4
 k47Q3iXzxy9f0FHTOVU8EgSYNEY1ZqtJNV2vGnpEMvOy5bNZgG6vMeI7gQX9bSyBp5bC
 c9DmfpvDLRvvthUsRfls0bLADNAiQQo22xpC/kdIPDLelnAbhaCbKgTSjQpiVvIg/S6N
 J4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877235; x=1777482035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eXkH/ZC1/r1mtLVPLqLEHNs4+L4xtL+8l1G0DSlOQ0Y=;
 b=jqadZVIF1HOasej+YVSQDm/2axUTr9N+5KF6kmKwD3pcN/kK97tXAXXxFzAJPTZxWa
 v19mjduTL96vj7WEkwfHa0k9MxtTDAqzytS1t+nrcqLHxypP/llysjnLZhDnR8afz9ZU
 oPAoqiHavA2Pqo16asN0HMxsrncb8pCiOs8h853DlhP7QkbTyOl13kuExSgEuJgndTPT
 ITderPR7E0hP92DSWjCRpwByNqzgJMJe7g+L5GYF09gXrlJLNpVkXQoKMRCOiuSlU9eh
 r7D1/YJ0qqPjJALVEgdBLjqm1BJt4kfrWeFaTR8MLNz5vA452FCC7oyS+hYhc6aDgFyh
 j2/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PGsevCSkRbiFNNeiRTXnBCRMOX24pV4maEYU3KxmLJusvxlalOgChsLpHonx9DwrpKDbCF7s=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1xAflVBypylNRMyy+sbLJITtEMweTpmrtuE+pewCTH+UijJ6R
 MW8Cwsq1cwo+Q2iavsEYPL/sSNvpI6GEPFKsE8phAPaMHeRZBB39nc8Q
X-Gm-Gg: AeBDiesHdzUjF6xwk0WHvuJAP4yGBk+I4/6QnKWs28eWTJJH06QDTPe31F3oa2b6Fv8
 JkZBSBvFs8FPdbgYUsrOmuvfcFzl06TmaFUk7u+pISftpvHyd5fnSIusfGo82iBzZS0Okf1UcBw
 7bMCF/W7uuyzeEFg0uPDcndmEhaROV126qW3oc4hvuu3mlSKivNlTKKVFLdLnYorwqufxSrATLZ
 XYlK0wTJOxF93N4pdSH2QjPNzwaLoo4u/vrM+IQEbN8SZC5dnFJahBDtg4a58QbIj/73A+gukap
 7vayG84rFEoV5uus4cF8A5V+b7IdkmEXj6BqQ3j+iR018QUO2YzYuRIbqTUS2navxYq/hb0yV0d
 n3uCD++AD+RTm0R8eUMCsaxlDItMCeWwipOFMelPws8TdtUBuaK5ipIxrE8rRDJtn/dZbTGOrUi
 jZsRkHezzC4uvWLUkSr8Sf9OTEbpGB7BQJwGAjIdjwSsekeOclA5Y=
X-Received: by 2002:a05:600c:3053:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48a53ea1526mr85749075e9.28.1776877235034; 
 Wed, 22 Apr 2026 10:00:35 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm453725165e9.1.2026.04.22.10.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:00:34 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v4 2/3] usb: gadget: rcar: Add support for reset controller
Date: Wed, 22 Apr 2026 18:59:37 +0200
Message-Id: <20260422165938.35925-3-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165938.35925-1-micbis.openwrt@gmail.com>
References: <20260422165938.35925-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 22:21:26 +0200
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
 drivers/usb/gadget/rcar/common.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index f7b34f0485f..a5d56f8dbe4 100644
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
 
@@ -355,7 +359,7 @@ static int usbhs_udc_otg_gadget_handle_interrupts(struct udevice *dev)
 	return 0;
 }
 
-static int usbhs_probe(struct usbhs_priv *priv)
+static int usbhs_probe(struct usbhs_priv *priv, struct udevice *dev)
 {
 	int ret;
 
@@ -396,21 +400,28 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
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
 
@@ -423,7 +434,7 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
 	priv->usbhs_priv.pdev = &priv->usbhs_dev;
 	priv->usbhs_priv.base = priv->base;
 	priv->usbhs_dev.dev.driver_data = &priv->usbhs_priv;
-	ret = usbhs_probe(&priv->usbhs_priv);
+	ret = usbhs_probe(&priv->usbhs_priv, dev);
 	if (ret < 0)
 		goto err_phy;
 
@@ -440,7 +451,7 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
 err_phy:
 	generic_shutdown_phy(&priv->phy);
 err_clk:
-	clk_disable_bulk(&clk_bulk);
+	clk_disable_bulk(&priv->clk_bulk);
 	return ret;
 }
 
@@ -457,6 +468,12 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
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

