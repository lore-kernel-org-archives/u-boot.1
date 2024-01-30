Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F8C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0971C87DE1;
	Tue, 30 Jan 2024 15:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VbhMKu6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35A787D07; Tue, 30 Jan 2024 15:05:15 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E02987DD9
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso2883152f8f.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623510; x=1707228310; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EVXtAJt0RWPFPqCspXGKKXYX/CTnEDPhz3G28EzFNWY=;
 b=VbhMKu6fAzmVRVfeq7Orh8vVRLfow57d4tJd+F1eEyF8p/2PnrxoFmaa2yHtiOvAc2
 uqKNQYhsUz9QIhQ5H3Uh2nJ8hmOqRoQYgxdUG2mpzSLzcy+24u25Z8Bvo4qH+ebbLkfN
 bPuGIAtIVxl1JWK38HAnHHxVneR4Ux+j0mo1gWdiGnKIRiRtJInSU/98l2Bh7iiYpOAf
 WzKf/uUVX4jY641GC+GuHwPFFwjnkoXQn1sYFcTPJUDx85rZ5PJxfibl3odH2KCoFgUV
 WfT/htE7WT5/36yjKj+b9CEKT+ng124Lktvg+fLPM0AFb6I23H8UDhKOWES5+M9ZWQ9N
 SCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623510; x=1707228310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVXtAJt0RWPFPqCspXGKKXYX/CTnEDPhz3G28EzFNWY=;
 b=Jal8fbns7VPOy0nWtBYBYRlFFIPcmK2eeXkIdhHCMu8I0D0f+H0ocDq72CJefZyqLn
 RGixyOs70CPLZo7dA620sKZkRAWp0nr2QmlTaZ7E4ONjQElaF23tMhr2qVZXH6z1yD3c
 hmHz7+MaexZdqOFVPqLoHA/XsBnQZvroPQ/IHiVBylBuAyNaYzdEIkffjgWgGPyrlCfx
 K7z3dxaRbiO5DaxMHQ2gqdJpC0+VrcySSK/+e3grP8kzGVekEAsQ7+8a5vJ7Xyt35Rpk
 dwMUMsCTwM5Ql4fUlVyDWWZYhPrrAuRyXHUXWMdqPQBjZ8Yu/tu+0AuaRm02+Hn4j7wj
 pDGA==
X-Gm-Message-State: AOJu0YxK31h/11BgYvfgLcA9kgATppT9ke2v2jQcxDsZavLXKRBSXpBh
 aeQ0ZbZJ9reO14JXiHz0HmHG6qK67qCcvRq4eBcBwbuaKa256E+Q3urTgGv+9lg=
X-Google-Smtp-Source: AGHT+IEoK9yVFRTVaAI6t2d5IqTDMqmR8rl5NBeJj7ughyCNmGYJMYx887D1Szjaa0psfMcIfB0w2Q==
X-Received: by 2002:adf:f851:0:b0:338:ba2:46c7 with SMTP id
 d17-20020adff851000000b003380ba246c7mr1515193wrq.25.1706623510625; 
 Tue, 30 Jan 2024 06:05:10 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:10 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:50 +0000
Subject: [PATCH v3 02/36] usb: dwc3-generic: support external vbus
 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-2-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
 bh=7kDelKlGUqK6+fQsLaAztxpo9tkTDfdhIho8Tum7TpM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTPz60Wyvo9yef1V0qXhoLepY8Wph9KXQp7en6S3s8
 foxq2VvRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhI5SlGhr7yrk9blbVM0x9M
 VtgxjyMh0nNP7DJTsz0xKd82Vm9+zsfwz2b+lF2xMQcDxN/JLnGPjrlwak6vZpNkPnf09yLWi2d
 f3AAA
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
2.43.0

