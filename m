Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0999C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B59387F56;
	Mon, 26 Feb 2024 18:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UnUX+q1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B254D87F25; Mon, 26 Feb 2024 18:26:28 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1CC387F2C
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d2533089f6so40078711fa.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968384; x=1709573184; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gT115ImxSsstmDbYl/cOUJ4kQloLdD5lNxvH9PvgL1w=;
 b=UnUX+q1yM6C5PpotU1U690HCDkRid9RWQf85POdLlFI8MmfYILtr4GqtlCiOXMjTn+
 P5oCzb/fSh9zM6cA5+1XmS6T+JoXZzbOJLYX2nu/uj1PcuAM1DJYik58yzz0SprrhSuf
 IWAeV9sHUelk4A9TsIvWECB3dLaE7B20OLOeBJ03FrJvH6Uzln7sB9/vX9vizS2TRllQ
 17oA5jIvQseqRSbQAjoWfhlH+d9NCh1mfHjSR7HPUGUj38ecvCTWxORG9SmLNQ+sbfmV
 zHmcXgtAn3D5+THzBNf+ZlzTWlyXO/n3LVjIZ7TxHFzU936bAO4ja/NuQzMqoQuVUNs/
 GjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968384; x=1709573184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gT115ImxSsstmDbYl/cOUJ4kQloLdD5lNxvH9PvgL1w=;
 b=suVoe4X6qJrR0PUYlM14QLugBtcG3oYv3zQ9rAqo0daDi3Wzo3P1J90W0q3sOSHBZ/
 +3mDo2kVIBxfqBomOudkiYrtihPGYgS9Y38F+cn8FWC6/dtqQ0CxWgwCdDJPwUjP8VYh
 zbcOTusLs/V2mSn3YJ5VWSK7KreDnQCtNqr41mHaJg2UWTXhJSwbvUjUOtnYgd7ha7GV
 UrL22J8ItG6Q8/FQ9hVDF6Mit7eyQCU9+3B8jrIvMaTIWM+irhGH4EXkMUfv0EhDNomh
 EqNhnFdWdWPVBCRZPvvAHJsH5iHRAHKNcsRCT04HF9MaQgDieqe62My1VMWTbfcOj1A/
 Z+2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVimJwevkWbdcPZGkgVQaKenn6Vac3EjwTKgRTWaTLn1dVz84K1U/a96iiAB6x1bG0f2/aWJGRymqyoDGijCHpZidlP6g==
X-Gm-Message-State: AOJu0YxF+D6yKeirYt3j6CMs/C6QN4uaZaEV7WDoa9ygLTiIGQZxgQe9
 gUH+2B5jVB6a0BJzcyz1j3CkJNkoVmJF1V+v7oiVlB4EDyLiNyD/8nkbM28qhq0=
X-Google-Smtp-Source: AGHT+IHKFWF5hgLY6tdJK3/f47TxUKm21GwixD9NaPOFQxgvOfTqzECBTngnuBryTJ1naNG6487U+g==
X-Received: by 2002:a2e:3a0f:0:b0:2d2:373b:5b27 with SMTP id
 h15-20020a2e3a0f000000b002d2373b5b27mr4506597lja.20.1708968384256; 
 Mon, 26 Feb 2024 09:26:24 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:23 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:06 +0000
Subject: [PATCH v5 02/39] usb: dwc3-generic: support external vbus
 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-2-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=zy8d/bLtlahzsjEnrt0CqTXILH2QKUQ9ydQgSemoQQE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3defPrDVH7z9wJHlp3PGuw52iVzXm8IZ2nMObnao
 ezaVznFjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjARcWNGhlk8pjtz+Xolb0xK
 WiusNSkuajdDUpHU6TvzXQv9uFvndjP8z2kUOzaR8279WnuWZF35Bcf6vmxdz/A38vLsOO6Cr2o
 n5wIA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add support for a vbus-supply regulator specified in devicetree. This
provides generic support to avoid hardcoded GPIO configuration in board
init code.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Marek Vasut <marex@denx.de>
---
 drivers/usb/dwc3/dwc3-generic.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 6fb2de8a5ace..a379a0002e77 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -20,8 +20,9 @@
 #include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <malloc.h>
+#include <power/regulator.h>
 #include <usb.h>
 #include "core.h"
 #include "gadget.h"
 #include <reset.h>
@@ -46,8 +47,9 @@ struct dwc3_generic_priv {
 
 struct dwc3_generic_host_priv {
 	struct xhci_ctrl xhci_ctrl;
 	struct dwc3_generic_priv gen_priv;
+	struct udevice *vbus_supply;
 };
 
 static int dwc3_generic_probe(struct udevice *dev,
 			      struct dwc3_generic_priv *priv)
@@ -239,23 +241,39 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	rc = dwc3_generic_probe(dev, &priv->gen_priv);
 	if (rc)
 		return rc;
 
+	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_supply);
+	if (rc)
+		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
+
+	/* Only returns an error if regulator is valid and failed to enable due to a driver issue */
+	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
+	if (rc)
+		return rc;
+
 	hccr = (struct xhci_hccr *)priv->gen_priv.base;
 	hcor = (struct xhci_hcor *)(priv->gen_priv.base +
 			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
 
-	return xhci_register(dev, hccr, hcor);
+	rc = xhci_register(dev, hccr, hcor);
+	if (rc)
+		regulator_set_enable_if_allowed(priv->vbus_supply, false);
+
+	return rc;
 }
 
 static int dwc3_generic_host_remove(struct udevice *dev)
 {
 	struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
 	int rc;
 
-	rc = xhci_deregister(dev);
+	/* This function always returns 0 */
+	xhci_deregister(dev);
+
+	rc = regulator_set_enable_if_allowed(priv->vbus_supply, false);
 	if (rc)
-		return rc;
+		debug("%s: Failed to disable vbus regulator: %d\n", dev->name, rc);
 
 	return dwc3_generic_remove(dev, &priv->gen_priv);
 }
 

-- 
2.43.1

