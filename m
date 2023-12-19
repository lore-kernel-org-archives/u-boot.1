Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09F7C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF21A8752B;
	Tue, 19 Dec 2023 17:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pnM1GS6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6FF87729; Tue, 19 Dec 2023 17:04:29 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53B787646
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c3fe6c1b5so51933935e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001864; x=1703606664; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fck7kwG7s/JPNczN5pI04EsIr9yeduUZAtln9zEiAhs=;
 b=pnM1GS6ZsvKWXzgFHqWvpkyqwzyo+vUrk8NnjKbTh5ohBEpwTh0WdO+smB+xK5JgRz
 h0GsyJ6GncoXiIqh4kmCgzFyCCFjSAGQTwVDCgTUtHFOu4ahzj2XVVoXy27dhq2k5DLW
 nyB29+Cm3viMba9nw+hlXmQ/fivvrz88nXPcfQeGLFpL/26vd1vGrIjoJ4EcMIlf/Aut
 HZZqa3jyR9W+ztI9XUCsdY1OQUxV1ZkA6oaeCCBftp6ZYWPOf54u0TuEx4uCF7BXv0Dt
 2Okithxb5AP7UXL+nRsXO9GaCmkTC2R7Sc2eqwuVzA4JgM8+ehCgOBkj2NZY/L+dQcm3
 aYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001864; x=1703606664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fck7kwG7s/JPNczN5pI04EsIr9yeduUZAtln9zEiAhs=;
 b=jsLNbYZ1jvMvhNzrMJEwWauESf/H4Gg2ktOj1roWZiS03pvqbQj0ofOwUKxbBRDSFh
 7opGl682WWedpbVaAi5a+h9QtTqDbAzLPkFNHCpXi3LsAK2mPrW4jLaB1+fYw30P8kNo
 DBOlC3XjKMzYv5hV/U5THT0OwYzQANkxH3ClR8DFXvsycJzZv5LHCR6aNERz6mBJCkQw
 axWbAl2LCz1knO49FubA4ydYCl8bqf93QhiIKJ3394WVYvEe0nF4ZgHyMGk36z8INFyy
 ImPSo5kxWKt4Bs5XLIC2W4Zi9WJPYnJOppz09ji9M1IJTAxIZkdrR6YakiWrxDnBl/2b
 ELFg==
X-Gm-Message-State: AOJu0Yz3zsJKGbzCmd6plHfEqrY4+Tdz8CksAC+VvJPQiP+8Ahm2b275
 qrw22VdqtawUlOAWMxezEv1irQ==
X-Google-Smtp-Source: AGHT+IG54rY+i3zvv6qCMEHVXEQWQEdcTTodQFAxV5B3gie8ELB5M0ze8oQsWPfHjd5+VPuOS1rlUA==
X-Received: by 2002:a05:600c:450e:b0:40c:2b2b:6414 with SMTP id
 t14-20020a05600c450e00b0040c2b2b6414mr8572973wmo.100.1703001864274; 
 Tue, 19 Dec 2023 08:04:24 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:23 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:03 +0000
Subject: [PATCH v2 02/32] usb: dwc3-generic: support external vbus
 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-2-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/YxrjO5dkpz4pqh1dUexN4fOyV+fYxZ3b43crxP0Z
 tqv8pAHHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAit48y/FOQ2uPkxTZ91q63
 8TbFlnqvVnpOq5//lTPz7tOqPR/VexQZGSZ4vt/yJu/a05VpLK/CopQWn/33+cFbq0Pq+skOtaJ
 ua74CAA==
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

