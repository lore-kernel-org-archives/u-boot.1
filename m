Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED71C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C5C8796E;
	Thu, 14 Dec 2023 15:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="hdO3gmdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB82B87A8A; Thu, 14 Dec 2023 15:09:53 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD828781C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zong.li@sifive.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c701bd9a3cso2368899a12.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702562990; x=1703167790; darn=lists.denx.de;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=78AfNSw+BSXi+dTc/M2fZNScfGxUYBZNG0OzBRL4yTA=;
 b=hdO3gmdbbv+8dccjOJCCUpi+VbD1AYlYekJr3V5bxf2+CwbhG+ynauufk5WpZZeMVe
 b9JFtez2rN+isv4sZU62XL3Fm40aeiKUeujblAhtCngFkcSvTLAghKt942jJA1ja/hJA
 9Z/vWWYJlkaMBIfvLTAa0oH5qAjeJAGDeXVs/W4bob07MqGSRBdPBT28u5S45ed+a/8D
 Sn3iXms7LY5Px2pBE/IxcN5tEgYTD8y7kJKQd6tya8qCvOWY3f++a54oU6AYF3N2Pf/I
 PuPaNaUPK3Dmvki32DSyBoMxklB9bNsqvAlBCciLPs8QNN4WqSL8hez2XZGTVXMkGWgk
 HjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702562990; x=1703167790;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=78AfNSw+BSXi+dTc/M2fZNScfGxUYBZNG0OzBRL4yTA=;
 b=q7eUFJZ+V7Zd6YEFwGEWkpMi9DLuqnGGA9DmTrnL8013yUtYD8whElqHD8j1F900Y+
 cv0hO18hTgc1pf08DPPA/cIJ46HYJ3DqE7gYDO5i3RtTG4tcu/1tvFQVL2M/D5lp3jKA
 1UCO1nAHJ75ca4Kykqd7fgOtigy3oUWS1vkfTVMxuHHg/lDd86Zl9rhUAoXEWIS7fYdG
 sbaLIYNhifTf0HCYTNYj0RIW7Ad1vYhaY+73cCdHuXvX0ujn4RXQs8O9MXRTZn81iHlE
 yfaPmiNgvV6ie+eLw3f/8Ra4TmhQrdtHv1aR5tIOKt/ng02QTh0hBdRjLcJEIVZPyyhj
 KCSQ==
X-Gm-Message-State: AOJu0YwqheB77UM6ZnGZelPRh7YUylHbbq+I+ZqrQRnBZDGDMOlMLdks
 Ip53/llHEVLlAU7O0ueuK6gV3A==
X-Google-Smtp-Source: AGHT+IFlw1YjymaJl7WIduQfOwUAoJeViw2lH/rd2G0VYaJFMm2qYd3Hse4PqK/iEXqoA9QHSOnUDw==
X-Received: by 2002:a05:6a20:6a03:b0:187:e1cc:8cfc with SMTP id
 p3-20020a056a206a0300b00187e1cc8cfcmr4775860pzk.35.1702562990002; 
 Thu, 14 Dec 2023 06:09:50 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 16-20020a056a00071000b006ce921da705sm11800644pfl.136.2023.12.14.06.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 06:09:46 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: rick@andestech.com, ycliang@andestech.com, peterlin@andestech.com,
 u-boot@lists.denx.de
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/2] riscv: cache: support cache enable in SPL stage
Date: Thu, 14 Dec 2023 14:09:37 +0000
Message-Id: <20231214140937.27784-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231214140937.27784-1-zong.li@sifive.com>
References: <20231214140937.27784-1-zong.li@sifive.com>
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

The power gating feature of pl2 should be enabled as early as possible,
it would be better to put it in SPL stage.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/lib/sifive_cache.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/lib/sifive_cache.c b/arch/riscv/lib/sifive_cache.c
index 39b0248c32..d8fe1dfa95 100644
--- a/arch/riscv/lib/sifive_cache.c
+++ b/arch/riscv/lib/sifive_cache.c
@@ -7,7 +7,10 @@
 #include <cpu_func.h>
 #include <log.h>
 #include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
 
+#ifndef CONFIG_SPL_BUILD
 void enable_caches(void)
 {
 	struct udevice *dev;
@@ -25,3 +28,21 @@ void enable_caches(void)
 			log_debug("ccache enable failed");
 	}
 }
+#else
+static inline void probe_cache_device(struct driver *driver, struct udevice *dev)
+{
+	for (uclass_find_first_device(UCLASS_CACHE, &dev);
+	     dev;
+	     uclass_find_next_device(&dev)) {
+		if (dev->driver == driver)
+			device_probe(dev);
+	}
+}
+
+void enable_caches(void)
+{
+	struct udevice *dev = NULL;
+
+	probe_cache_device(DM_DRIVER_GET(sifive_pl2), dev);
+}
+#endif /* !CONFIG_SPL_BUILD */
-- 
2.17.1

