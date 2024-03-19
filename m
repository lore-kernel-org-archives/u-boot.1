Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5583C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4233C880AA;
	Tue, 19 Mar 2024 13:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j8QhS6AN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52BF8807B; Tue, 19 Mar 2024 13:22:53 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A013388094
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33ec7e1d542so2993439f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850967; x=1711455767; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HxlOsugX2/wIO/P7KsmKCSR/CeuUXJcHxpYPD4HuMPo=;
 b=j8QhS6ANWD6jnh2MMmuBLEtXUXPgHQUKA8yQ2wlSapmfRUPzsxWVN4wi8dw1Wh3AOS
 FISr9fAx0Of3bXWt/fB0fVtIBxQvVPWH7+c74V+siB0qODyakg/W4vcyTFncNZ7RCt6k
 f4E1ufhOJEIcNMFTwg21YKqmtxaCkWYIfEcSZjqNlsqMxQGV8JuHx3y85jAr158kpK81
 /zskiDFMGSdbOS8lAAWvWPJhQkXzfCMqakLgdnhasRF1PhdxIWQIDejfBLS+20SLDDWe
 0wJCozKdK4PU8YOb3Mv7odgb37ETcnKXDkJ7NtzePSQlePx24PMWPgdN9owCKFD/2wwo
 nl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850967; x=1711455767;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxlOsugX2/wIO/P7KsmKCSR/CeuUXJcHxpYPD4HuMPo=;
 b=Y4NuhjndV9oxzLmfXqSa9sxcCYXZItRZ66XJcE0HXMDDNW8EiMe+20hMzrGVd5yzMN
 BE+4vEQ4abMkAb4bgsvhp82dHIW9bJHj65yRmOLNVFcIJIohOxbXI44I1jzZ9dJU98Ws
 oa8cRdIKcC+XSvmA4s0zL/yIJT+WV1mbv4wF1SJPY8lcZMwga4NAQL2GBulzOjZY/9yV
 00RsCOCbOKdfsBEaf3xXPKm/1e339YYywrYAyL0v1rebUR3D7I9CHKtukGc3EUSmHNWe
 u+U7y46xHUKYisug/pjcvMlQZwuaweBWTAc6kagSVsPLeqvrP7CQuJI477xp9LAfaz3t
 q9Eg==
X-Gm-Message-State: AOJu0Yzh5OJJ5CsWnlaBe+hyqyksh3CiIcGhepKYQAu6ShyzQBjWEHze
 KtjXIt3qTyip5/xI9okHPt9vIl0Arohjrwp1iyIdNx0UxZbS7/NFUCQWSnuC6RnbgtiyG3xee1g
 P
X-Google-Smtp-Source: AGHT+IELM1kvS79QmKAMyEAH+Sg4rZiE3WBvPxCTDBLYJ4sjxgXWZnxkR3HwNAdZeq97qN/ZFOWwvQ==
X-Received: by 2002:adf:e44d:0:b0:33e:7869:fbcd with SMTP id
 t13-20020adfe44d000000b0033e7869fbcdmr1687485wrm.53.1710850967033; 
 Tue, 19 Mar 2024 05:22:47 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:10 +0000
Subject: [PATCH v3 11/14] mach-snapdragon: fixup power-domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-11-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=eATLOOhI4TMycRloeb2rEN+Hpuc/Br8JMYSeGYyQmIY=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGX5g4qium5WzrsyrrVZXfmrT11BQUoNjTNFPdBkvxplb9k5T
 4h1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmX5g4oACgkQeTBFn7kwMhdkbAEAt5vo
 a/gG1e/2JX3o2VkxXh12EA3jSmPyElg81gV2gC0BAKJkFk1uUxUiKiCIa5N7XCtYWBOj0uVcEV0
 CVLQQF4/m
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

We don't support the RPM(h)PD power domains in U-Boot, and we don't need
to - the necessary resources are on, and we aren't going to enter any
low power modes.

We could try using a no-op device, but this requires adding a compatible
for every platform, and just pollutes the driver model. So instead let's
just remove every "power-domains" property that references the RPM(h)pd
power controller. This takes <1ms as we're using OF_LIVE.

Of note, this only applies to drivers which are loading post-relocation.
Drivers loaded pre-reloc that reference the rpm(h)pd still need
DM_FLAG_DEFAULT_PD_CTRL_OFF in their flags.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 6810c8617cc0..49f1fc1948f3 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -21,8 +21,9 @@
 #include <dm/of_access.h>
 #include <dm/of.h>
 #include <fdt_support.h>
 #include <linux/errno.h>
+#include <stdlib.h>
 
 /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
  * USB controllers. Rather than requiring source level DT changes, we fix up
  * DT here. This improves compatibility with upstream DT and simplifies the
@@ -108,8 +109,39 @@ static void fixup_usb_nodes(void)
 			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
 	}
 }
 
+/* Remove all references to the rpmhpd device */
+static void fixup_power_domains(void)
+{
+	struct device_node *pd = NULL, *np = NULL;
+	struct property *prop;
+	const __be32 *val;
+
+	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
+	for_each_of_allnodes(pd) {
+		if (pd->name && !strcmp("power-controller", pd->name))
+			break;
+	}
+
+	/* Sanity check that this is indeed a power domain controller */
+	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
+		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
+		return;
+	}
+
+	/* Remove all references to the power domain controller */
+	for_each_of_allnodes(np) {
+		if (!(prop = of_find_property(np, "power-domains", NULL)))
+			continue;
+
+		val = prop->value;
+		if (val[0] == cpu_to_fdt32(pd->phandle))
+			of_remove_property(np, prop);
+	}
+}
+
 void qcom_of_fixup_nodes(void)
 {
 	fixup_usb_nodes();
+	fixup_power_domains();
 }

-- 
2.44.0

