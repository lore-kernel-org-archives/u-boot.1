Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26A4C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA2E8763C;
	Tue, 21 Nov 2023 18:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b3K1yhjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E954C8762A; Tue, 21 Nov 2023 18:09:36 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F99875FD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b2ad4953cso4721625e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586572; x=1701191372; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fck7kwG7s/JPNczN5pI04EsIr9yeduUZAtln9zEiAhs=;
 b=b3K1yhjjBJiUIuaobvXKoGzScUTWSw6ol6GVM0R30sFbMkEl2CzkG76REJJvbo+ck4
 cqvWsNZwldOM1mStjpXL3PuVd4aAkbqYN5wFmr2Llq6d6kjqrOxBJ5l0aCRqDkrB6AWq
 qXJtIgi1xJo3+400jj/oHTj5X1Ffo1629I/xdSXnmadqXKy7+qQLS0xTgqhlsEuGRNiA
 0XsMnIyazTAG3RTlj/D4iKRKlQSxSQiC1evR9/pvSWEX5luNvlxKOAYqH/8/IXgyhlew
 7w9IFFYzXzb3qKJMVgCL7hCzw0YdrZGelndvRyPvDtzVYetdpKHLq5JseqEJ/oPvkyul
 o80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586572; x=1701191372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fck7kwG7s/JPNczN5pI04EsIr9yeduUZAtln9zEiAhs=;
 b=LnTvk+SRZFWy6PrRMxCIZSBk5Qz5E0BtaK+pBfPFVWUkyzMu+bwcsMo175RoL0NlTY
 yNGEfRVVgPvujecZJpQkPBR0TPNEZxBeq0SU6eyNAXLAbrtKyKiXQXCyPMJAFP6thIgW
 R2rIAdEX0/CZm1q1Saosq9qw/IqrtZY/MrhwV6G/Wv/zsBSiq6RK2U8sqAXG0wITwLEy
 L4Y2ozkWt1TG9uk+NTVz7+NVAbh26rD+WU8szfgrocfvRXrAgtUGJZXMPoKOSRdZMYCq
 5HSQlYfNPNj/Hlh6XKOj8gkriLDWt5Lb8OolO+xJprssU42o6nTUpzp4CUrKY69UgI7s
 sCSQ==
X-Gm-Message-State: AOJu0YxpgN3mQyXi7WqgS0OqeIHy/G9RwHA44a1gGS3H6SQn6/CvlaN4
 51XVraysnCZAEXqlLpj6iHGR/A==
X-Google-Smtp-Source: AGHT+IHB9+8HHm7zrLdQuGq2fdmpD3D8XJ01YJOI3qgD5hQNY/0+ziu5vQAbkK1X5B9D2NfB7AiUAw==
X-Received: by 2002:a05:600c:a2a2:b0:3fe:d67d:5040 with SMTP id
 hu34-20020a05600ca2a200b003fed67d5040mr2886468wmb.5.1700586572059; 
 Tue, 21 Nov 2023 09:09:32 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:26 +0000
Subject: [PATCH 03/21] usb: dwc3-generic: support external vbus regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-3-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=AYKQKTYOB4WSQ5O/zOkvXjHUummdDNXBGhhB4keYTpE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ64LH320/HUusrxbJYb5S9Fd/Q3374dyc97g9bdK+
 Hgz7WxuRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiI9mlGhnU2c1aVb0n/5ZL+
 OS3FLXWH7IJSdh5dfaMIiTyBh4sXMzEyTJMJqj/yz+5xWlCz1IX5e9ujX8s6rWKxKWBgEdLtDX4
 tDgA=
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch has no dependencies

Cc: Marek Vasut <marex@denx.de>
---
 drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 744fde806948..e66e7961c70f 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -21,6 +21,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <malloc.h>
+#include <power/regulator.h>
 #include <usb.h>
 #include "core.h"
 #include "gadget.h"
@@ -47,6 +48,7 @@ struct dwc3_generic_priv {
 struct dwc3_generic_host_priv {
 	struct xhci_ctrl xhci_ctrl;
 	struct dwc3_generic_priv gen_priv;
+	struct udevice *vbus_dev;
 };
 
 static int dwc3_generic_probe(struct udevice *dev,
@@ -240,6 +242,13 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	if (rc)
 		return rc;
 
+	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_dev);
+	if (rc)
+		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
+
+	if (priv->vbus_dev)
+		regulator_set_enable(priv->vbus_dev, true);
+
 	hccr = (struct xhci_hccr *)priv->gen_priv.base;
 	hcor = (struct xhci_hcor *)(priv->gen_priv.base +
 			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
@@ -256,6 +265,9 @@ static int dwc3_generic_host_remove(struct udevice *dev)
 	if (rc)
 		return rc;
 
+	if (priv->vbus_dev)
+		regulator_set_enable(priv->vbus_dev, false);
+
 	return dwc3_generic_remove(dev, &priv->gen_priv);
 }
 

-- 
2.42.1

