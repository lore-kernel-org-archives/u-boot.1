Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464DECD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E88C881B9;
	Thu, 28 Mar 2024 18:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w0OVPzc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5B8881C8; Thu, 28 Mar 2024 18:59:56 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F77881D6
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4148c6132b4so13750775e9.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648792; x=1712253592; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fSfO4nPxMkXp295NH+BMKdLi91fCv2a9KEPcm90GuVY=;
 b=w0OVPzc04H6QG4bAi3zgA1Gsf8llX9l7Uf+dCTqEVoLgKPT1BOe2/itJptYWQ2KTIt
 qcxYNq3Oq767+uVC4PQb4nXzD7fCqv5VnH/telUu0OC4pzLcmHFw1YKL5CW8HZMHcJUu
 IQCiJxFPShZumVbyXwwL4AaNxpxIqkylRzBKi9DMRj5F1/LIO04vbHn2h/Jt25r/B98/
 xQgNhHO7pAI3Ui7SgSXsIX97infeCv+iotDtZSeLGUHErKE9X2BSfwI8QgEyeCvo97bh
 OkGJFtdpR5rAhGedUVumnanaZ5/V/n8TCWgArYMYbBmjdNGdNpflzNCvD551n8jrWbR/
 59PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648792; x=1712253592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSfO4nPxMkXp295NH+BMKdLi91fCv2a9KEPcm90GuVY=;
 b=o6JCHxVDzT2nuCwhpqLjeKUeEpMiY8E+wL2ICbnBNz+sMA6+JVPp8Goy4yEqqN7cxy
 0GAVYW6fo9Spa6q/bNWFwFPNC67LeHxbsG9UkdUsw9xjYl51OiaR1IjGSXLJjt8cAKJ4
 G4f57he60VINkHHAOA9j0FSF5WJcpm6XRekp1Q7xrbtD4dd4gMyGXJ2gOpzw1ZZChGlN
 X8QbJDmAFMtwKEzJAFzq1BmnWlFD/bE2wE1uOYf7+ggRM0h5Pr6tCBtMG4g9iHfmoQ0L
 zxuWZ08IXWzG5Vh+EbngAOOjHBXsgxeCDS6oay2Zdo73AZKH6QulIWwyukstdwq3NwTe
 2k1g==
X-Gm-Message-State: AOJu0Yy+OcSOtJloXUneR1Trxc6Jb/7IdBh/hOhoIab6NI+6gsUToXNo
 jxJ0hgEa2+tshB7ICqjgXOXK6259TtTsepxWvL7e77c4M0QT99Sm69hQGgDul9o=
X-Google-Smtp-Source: AGHT+IHUcAtnzVBbWx/IzwglXQdEpumN9hc9BhLtihNBbw9tRbLLytDEw13YYzLpDmuUHftlT4SQIw==
X-Received: by 2002:a5d:5091:0:b0:33e:d139:412c with SMTP id
 a17-20020a5d5091000000b0033ed139412cmr2692461wrt.30.1711648792536; 
 Thu, 28 Mar 2024 10:59:52 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:17 +0000
Subject: [PATCH v5 11/16] mach-snapdragon: fixup power-domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-11-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=F5sYJt36I+PI1NFYlyJGjSiVgDKon6nM15HEp4AUWhc=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGYFsAqh5luzf0gKXsKWp8G8qE2qCaeyeQfqyGbbV7GkYEGo8
 Ih1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmYFsAoACgkQeTBFn7kwMhdwggEAsDXQ
 4cH2mFGXMJOFFbPipRBYuQpVctPOJydEB8gAINcA/3kn8dXEe1OLyhfFL9qD7W8kjfPzJnx8/5e
 GPxCAl2Lh
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
index 4fdfed2dff16..3f7ac227bd09 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -21,8 +21,9 @@
 #include <dm/of_access.h>
 #include <dm/of.h>
 #include <fdt_support.h>
 #include <linux/errno.h>
+#include <stdlib.h>
 #include <time.h>
 
 /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
  * USB controllers. Rather than requiring source level DT changes, we fix up
@@ -109,8 +110,38 @@ static void fixup_usb_nodes(void)
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
 #define time_call(func, ...) \
 	do { \
 		u64 start = timer_get_us(); \
 		func(__VA_ARGS__); \
@@ -119,5 +150,6 @@ static void fixup_usb_nodes(void)
 
 void qcom_of_fixup_nodes(void)
 {
 	time_call(fixup_usb_nodes);
+	time_call(fixup_power_domains);
 }

-- 
2.44.0

