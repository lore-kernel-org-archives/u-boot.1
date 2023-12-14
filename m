Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C191C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C77B87BB7;
	Thu, 14 Dec 2023 19:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S6uSGPor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C719687B6C; Thu, 14 Dec 2023 19:17:15 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B0F87B6B
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5e2cfece112so20033997b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577832; x=1703182632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17WMgjji7V5sM+nqrrMrtN2GmRl+b0tqYxgBgGsX2Vs=;
 b=S6uSGPorD1/4pY+9A9bzzPCq85A2zea1tmXybLz0oM4aCmQ4WBzTDr7bUpC4OQIehH
 AKxsd9xWoIaFESL0IJEa+RJxEZJqq9PuB3T76bX0NH3jSavdOMOxomxbD55cWNSHw1Lr
 gHN5SO0w1HreXehnqQDI8s/5GRAZzd+/qVZ2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577832; x=1703182632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17WMgjji7V5sM+nqrrMrtN2GmRl+b0tqYxgBgGsX2Vs=;
 b=ao3OxWGJ5P4CuoEaaTDCR6yh9ruP8JDiGjn1oAnhedBJXOvEM7PubVKtbIy8sXmKBy
 7FrDVwZske9sSrPVmP58+sDX3cKfRLbjm5RIdvlMfo/KOA8RaLyqQ1egGXlKZROIqBq8
 3rSZyJWHFSSwsAseRG2zO5ejDZewKRwBsvfg+jbFMWQtc1oUTKtZZVHx5dwmbuG+3lIW
 WgCkXhypBekGfb4maZ2j0b8bWkqDt38J6yvilfTAcEN5b3kUbSVQqMsjFeMEGCIoQNs/
 uM33G+iRPUO0xdECDfU9xefsUHjW0WoqhvnjEVRExUZQhPqfy/e+I9eU6AN/c8YbDzgx
 WzBQ==
X-Gm-Message-State: AOJu0YymXLVBUurKqn2sffwn5WJFe4Ogw8XvQ4sQzuqlla+Uihj6YNQ1
 dpkj6OoqGU/n78VSotwx3ljabi8sbvVNgSl22ws=
X-Google-Smtp-Source: AGHT+IEFiHm5I5G14QC1vnjogdPk8KPfi0VxhrKzimBeP57EfRV693BggFNneChBX+9g3M2y/sz5JA==
X-Received: by 2002:a81:a552:0:b0:5e3:ba78:35c1 with SMTP id
 v18-20020a81a552000000b005e3ba7835c1mr1094091ywg.26.1702577831968; 
 Thu, 14 Dec 2023 10:17:11 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 15/16] include: Further cleanup includes
Date: Thu, 14 Dec 2023 13:16:57 -0500
Message-Id: <20231214181658.3359902-15-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add some missing headers such as <linux/errno.h> or <linux/types.h> or
<linux/kernel.h> to header files that make direct usage of things
provided by these headers.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/atmel_lcd.h | 2 ++
 include/getopt.h    | 2 ++
 include/mapmem.h    | 2 ++
 include/memalign.h  | 1 +
 include/net6.h      | 1 +
 include/rtc.h       | 1 +
 6 files changed, 9 insertions(+)

diff --git a/include/atmel_lcd.h b/include/atmel_lcd.h
index 66436b9b2772..a115d6c17014 100644
--- a/include/atmel_lcd.h
+++ b/include/atmel_lcd.h
@@ -9,6 +9,8 @@
 #ifndef _ATMEL_LCD_H_
 #define _ATMEL_LCD_H_
 
+#include <linux/types.h>
+
 /**
  * struct atmel_lcd_plat - platform data for Atmel LCDs with driver model
  *
diff --git a/include/getopt.h b/include/getopt.h
index 6f5811e64be9..8645082da2a7 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -9,6 +9,8 @@
 #ifndef __GETOPT_H
 #define __GETOPT_H
 
+#include <stdbool.h>
+
 /**
  * struct getopt_state - Saved state across getopt() calls
  */
diff --git a/include/mapmem.h b/include/mapmem.h
index 2134c8004d94..bb68b4c11afd 100644
--- a/include/mapmem.h
+++ b/include/mapmem.h
@@ -13,6 +13,8 @@
 # ifdef CONFIG_ARCH_MAP_SYSMEM
 #include <asm/io.h>
 # else
+#include <linux/types.h>
+
 static inline void *map_sysmem(phys_addr_t paddr, unsigned long len)
 {
 	return (void *)(uintptr_t)paddr;
diff --git a/include/memalign.h b/include/memalign.h
index f67f0a74f2e8..eaa9f6b5cbd6 100644
--- a/include/memalign.h
+++ b/include/memalign.h
@@ -11,6 +11,7 @@
  * is used to align DMA buffers.
  */
 #ifndef __ASSEMBLY__
+#include <linux/kernel.h>
 #include <asm/cache.h>
 #include <malloc.h>
 
diff --git a/include/net6.h b/include/net6.h
index 1e766aa72092..1ed989e584ae 100644
--- a/include/net6.h
+++ b/include/net6.h
@@ -12,6 +12,7 @@
 
 #include <net.h>
 #include <linux/ctype.h>
+#include <linux/errno.h>
 
 /* struct in6_addr - 128 bits long IPv6 address */
 struct in6_addr {
diff --git a/include/rtc.h b/include/rtc.h
index b6fdbb60dc2b..22f6d3705917 100644
--- a/include/rtc.h
+++ b/include/rtc.h
@@ -16,6 +16,7 @@
 #include <bcd.h>
 #include <rtc_def.h>
 #include <linux/errno.h>
+#include <linux/types.h>
 
 typedef int64_t time64_t;
 struct udevice;
-- 
2.34.1

