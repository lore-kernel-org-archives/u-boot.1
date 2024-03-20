Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48E6C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4EB8811D;
	Wed, 20 Mar 2024 15:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LK4F/9Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DF78810E; Wed, 20 Mar 2024 15:57:24 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9151A879E2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-414618e6820so19193005e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946642; x=1711551442; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fSfO4nPxMkXp295NH+BMKdLi91fCv2a9KEPcm90GuVY=;
 b=LK4F/9RvUiWES07dQ/NfstefqXi6fW+iXqPy23MWILKjOIeFQKsxDYI5l9SW9UqFoo
 o7NQCJmw/yKVKAIOJv2t5qEsfnsi1J/CppRrtog1mSht2/k97Uzw6d4tq5HaERkhGPRB
 eUUHwXGycuAzCAB667slGhszyaWSTu1OaxJh0Y6COfeM6wOvVnugHhcidM9PoVXK340H
 0opvp5D5h4H1sytrQxJW0CQKUDcbZ2BshVZJWkZDNKpGdI2rhe4OwkMDfogzANnZ7edO
 cj2Ht4nwI+6AqfGNhhc+Il5AV5I9NyI71ETAgeTpsILTsa6UPnvlS09ZdP/NkORyWQd2
 UknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946642; x=1711551442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSfO4nPxMkXp295NH+BMKdLi91fCv2a9KEPcm90GuVY=;
 b=jgCIqej7ezwwCGmf8DxY8bKn/0595MR+NtAnkFlqEPqg1W94SdgU9wtACROKQdzIc8
 QOvk3t7tNfhHoL+uP8RAyV/G+bDFWQZ5p3oEUbzW51RiiCfeSeWxiRyYBkSJaYBkK9ul
 d9YCOyi1TnKLhiWfUf+AQfpbfvCCd6bWtnvqqNEf1KjHD46FcwzggAoGbC48dpzVv6Lf
 KvkA3/v3VOQ2TsVPY8GoeWgpnovIpwg26VLCGm/h25aigK8ulvU8f2rvmWfiH65NmJ+A
 VVvUDa6UpI3pnJqXUwFkYdoJfk95/aFHVDLTOf2ytDgyJy5uZeOqNWJOJFsl5u5Dld5M
 p/Cg==
X-Gm-Message-State: AOJu0YwYE2LvZapss6xEv0YOKPzjHci7Fvdxn045cHtrqIjZBf7Wsboj
 AW2WvncvYdh+psYRj9HaLbad+m10OcAUqvKkYcjVlTeDht/9Qf4C605Gbh9G4tk=
X-Google-Smtp-Source: AGHT+IFDYr/9TI0c1Wmb9OHshAI/mabwEUJiMlGOV+K/dzJdwYiZHI5RJ8uR3DCtFct5A4MaDF1tJQ==
X-Received: by 2002:a05:600c:4f51:b0:414:bc3:9fdb with SMTP id
 m17-20020a05600c4f5100b004140bc39fdbmr5080768wmq.21.1710946642165; 
 Wed, 20 Mar 2024 07:57:22 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:14 +0000
Subject: [PATCH v4 11/14] mach-snapdragon: fixup power-domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-11-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfP51413K6nwrVOcWunhUg6C/5lHmucojrhYIzV+w/X
 zt5Un1fRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiItDPDT8b3B97eXTLXZvOs
 VzHXt6zwlrYra3wR+3xKTdq7pb5+TXcZGbY6Led8nFOobcr3M/d107/GzrNJD0XzK9UYpSXyt62
 9sBkA
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

