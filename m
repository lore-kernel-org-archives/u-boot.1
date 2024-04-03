Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90938CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53306883B1;
	Wed,  3 Apr 2024 14:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bNd8wJuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C444C883C2; Wed,  3 Apr 2024 14:08:04 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AD98837E
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4e65dec03eso423720766b.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146080; x=1712750880; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=atk6K8T5n8lDURrFo1/qujfmQUqqKVW2EVC2laZ1DQA=;
 b=bNd8wJuCfrLOgD5ZgJPoiWVGwjZFG/pjikJUqw00S4a4A4XR6bv4daDv9O3zC8ZIDu
 nskExG/bC7Iv6F0UGsAFfMDZEmR6RcAS3IKXxwlK2fpaiTEsrS0esZiRp4pPB/c/VndJ
 oyf4UL56PEzrBueUOS3v4ydBry97SM8sXavunSP04vLTkwvpnnsXX9/aKMjNiYprGpr6
 F+Hndw/fPXNizUeUMTbuzAycoDWRhrvIVdhDejX5LECiAoupPYEzQv0orwTHwLM/CSPb
 6vfwjFDgGJ9gxps5AtJfM3hZQGNGYvXWGvbcETst0bPsc9VgSSSEsvwNejkiGVUfKW9e
 ztNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146080; x=1712750880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atk6K8T5n8lDURrFo1/qujfmQUqqKVW2EVC2laZ1DQA=;
 b=mDENC7RTs/H0CZw+p+rj/QThcXb1XRIDcf4Erbd7B9nZvSu6wHoZYq3YI/ZyJJf5VM
 WONtPXAxlSwCCNlC7O1j9nBj8v/LwM904dF2UPSL5JKf6Xcz2Xy5Fy17W4ucUCFJtJGk
 sfNtFDRsqHeHqdjSp8BWTRJQem9H6Om3TemSfgFA4pzp5qjXta+ims+u1usoKxKUzFfc
 NSbsM6kIfb2chSabhh8Vjtx//ra8/XLlm4oKqz1h34wFecd5RVbdMQXt9i3eUZPGym6J
 /oMCgHRxqQt4q9CIGiZrFbsGNTepP8k4WtXgOyONYycsuV0foD0OElPq5oZV/pIP4sjI
 zWpg==
X-Gm-Message-State: AOJu0Ywn7NRxIej5Y1nJMKVVtZi/wsJhMc2eUoFDfXlv9P5qPb01UN3o
 9eYK6lmDjID+Y6ysQ5Re7t+48cnbqKUhZqVvsJMEMZHwWsrWpV9jbAoDDpXL/O4=
X-Google-Smtp-Source: AGHT+IGs5iivAuYyZOL71uKP2HJY+XkG9adNdMyD8u397dQGL4q/DmlNk+I9wIeMOSv1MpDrHvVmiQ==
X-Received: by 2002:a17:906:f6d1:b0:a4d:f927:f747 with SMTP id
 jo17-20020a170906f6d100b00a4df927f747mr1667039ejb.4.1712146080715; 
 Wed, 03 Apr 2024 05:08:00 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:08:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:46 +0200
Subject: [PATCH v6 11/16] mach-snapdragon: fixup power-domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-11-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=+xkPcC5ur3MqWn3Swwn7ynawtVqmdU6FvDe+TLJNJp0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaR+lLCJ75/J9UzxAWvDD/XxTQTUvryQFyWq
 C9vmSgOneyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 thm5D/wJO61B+q1mAWrgarXFIvpD1kR95szbkgIE3PhHqrog6o4W2+o6K/dgcwC7hyT8cnJ4LPj
 5uh6j3ksd29UJEPLaAWewfJbRZ0HE7ozTy0RrkG7xnF5su8vIYXqO1YpiyesaECVSysT4+BPUZl
 IDtV3LtonAKsVU1S1WleE69waK0fZ4NRHhqdqk5cfw6/Iore1u4gLinXuA0o3nNtc2iYJ3uh9dK
 ibEYeEUP3wtCqWIcBQgW6N5tsxvv7KGIeFiAru9+jCNI8RW3gGsZQ1iXo516pPc/e6DWncLUBFb
 zUvum/7rd6t4m/mxTde3OrV++JlS9rtbe/keDNGKog3h6fZF6svyi+0BLhKvx+K6lAg2lhLJo49
 gUP39LMfOqGDxOZhKSVOnLlclZ6txw2F+Bx3R/BlMxOIUXOHUEOuxQVkH/hOGGgJwXaAdFJPiKC
 zvzMYsrpM5KSS68fxT6ddQz+gaMrcu0wI6K94mPcF4XEfmVYWgrp5b5INPbnmxLlFTsxKGgHPnl
 yT5a/wHerFzLtnK2PrITFrI5O/b/Ec17j9mxRrElHdIPCuVHMt73ztdYEOqPSv1AX6IsWkj2r19
 jZAufl1PK5kwaCE3w4eHBLvJsQ8HWGVB4bJrZtmzJm3lNm6GtR7bx9VZFihaGDPqu34Fg0lmMbA
 z8eFhnxuE2Ku2sQ==
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

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
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

