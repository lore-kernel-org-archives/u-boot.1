Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037A8C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E86387F29;
	Thu, 15 Feb 2024 21:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ma7uDfeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2677387F53; Thu, 15 Feb 2024 21:53:11 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC8F87E50
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40fd72f7125so11023015e9.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030347; x=1708635147; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AmAsykR2ASS6uTprdalJMQpA365W1guRuSmzmRpAuPc=;
 b=Ma7uDfeDgO6ulpSczruxk7k0Cv3Zl/GkutzxuyY3giu/oHVXnzXdgFRR5U9ymjRjft
 92HooqKaY01weF2nWaLsSFD1SvNGhKg5WRQ7UrHlGkKFjD82oTUW4LH23xmnlmuqHJDS
 3mAfbs52Vdo5IGlVdRl1DGKyAGPLmIsLieWST/lIdzpxroa+IBInDiVTUes0t/0xZwCM
 NcxQX6R36D9J1MPca6tOAc+oTI6NkzeoL3MBhEY9RzJ6ixCD0SaxwG++1ed6pzBi+4Gl
 yYkJERa5YNy76wPm2bdyvrEngrYsw0FAhbE0Okif9M8A0IRewNId1FI9IUAw4SpTOKMq
 sd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030347; x=1708635147;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmAsykR2ASS6uTprdalJMQpA365W1guRuSmzmRpAuPc=;
 b=sbhr9h5A7TjjQu8eFj9Yr/k80Wd4ysuAmcSDW2rrjTN12wr/TRQEfQ5frngtvhQVJx
 LDavuUp3YeDk40d399D0lCKopVaUtAHiu8ztTxyq5vCGc7C79ksoTS5YngeieMgYmidb
 WEahxDTPcYGc2UNSJqOqpIxM4qQ7vFT1I0qw6eIuHK4T3EcenmQRO3vqEgwdV0myjLBb
 TISdZbusId0LGBEUFQPfnpKHMh+GYBM1s+RsV2zVVka/FXw60C2FWAPI/aJ/E+S4t8ut
 BvMdPA7wA+6zqMhrMAGkEXLj/HtFsN6JgNq720pAgfOE3UA7nHsiYSUpGd72JjRaJwUQ
 xPLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC2bdO0XXyL9IpZBL6XO4aepJ/wxFCMPzdrCDOuWuc32fSLVatp1PY/5ZmVOvXuoYZOuHpyryJF9OsQkK4oqWylHIO8w==
X-Gm-Message-State: AOJu0YyiEWjMVUgEuPUW5PHyW2DC1P0yhjsAZ7+nhkfm+NmToO0M4+ao
 K+FJLa6BTJ75Na7+Gy+bpNYgFSWhTfByLJecJtErX5j0NdpVBcEIclfFeFXEPSkSWqRpcEZgXEx
 A
X-Google-Smtp-Source: AGHT+IHL/gD4KiduW8XOJbktaBnSFmL8Np0qhxMLPfKuxJEFH5cGMaEdpd8muwpERS2kRZM7h/wMiw==
X-Received: by 2002:a05:600c:3b25:b0:40f:afa9:7f1 with SMTP id
 m37-20020a05600c3b2500b0040fafa907f1mr2217745wms.22.1708030347317; 
 Thu, 15 Feb 2024 12:52:27 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:26 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:20 +0000
Subject: [PATCH v4 02/39] usb: dwc3-generic: support external vbus
 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-2-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1cPAKwE8m1YNpFhOr2z4SkRQLhitlHWzK25zyS5mjcg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS3t+35HXOu6UDB72sasY/Vp/Qrmd7027N9zh2eW3
 6L+Ju27HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAinwIYGab3rhYO1FXxmyU4
 u+vLLOXGqmhf/b0u5a7R3uL38+20FRj+Fyx/mCix8dx65e5FRybFvjqYuvXNP68EPsZfv7r9Dz3
 93AcA
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
This patch has no dependencies

Cc: Marek Vasut <marex@denx.de>
---
 drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 6fb2de8a5ace..48da621ba966 100644
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
2.43.1

