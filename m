Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822B3C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18F0875F2;
	Wed, 22 Nov 2023 14:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UZor0T3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6FB875B2; Wed, 22 Nov 2023 14:12:07 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B069E87463
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d9fe0a598d8so6165728276.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658724; x=1701263524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lXfv1nqlvb5uQr+uPTdtXZDX2AZkw8g3Z8uEe+hKb74=;
 b=UZor0T3jfMaAQo/PsOhzu/y3FXABcdQCmDGDZnBlup/Zv/oCLQ9vscRJzZpzl/RfkP
 jxAC6q2SFzcHVOmOm+YiAruM3QurcltAttDV9aH8W35+bfyxURvEvp8DGj9a5+tAqONN
 yQaWL0vlDmIgCHzRfoX2DObxHjm5PFipA2118=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658724; x=1701263524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXfv1nqlvb5uQr+uPTdtXZDX2AZkw8g3Z8uEe+hKb74=;
 b=fIrvsNKeGNXhVoDPlwwYSxJHmuMItGhIJVIMGYAeGiEINj26tURzM0RETbgJlNSxmZ
 KvkWar4V5YIToAsJT+7mSFbbej1mAxX5wKFND9DvULG8LrWpsSY0lJkkmlnjTRTUGJp6
 J6ZNY2DO8gCUqp5i/OdaaV5UX9zx5Hd3X0mL5IoH2DKQVrePbWjf1q1tlH4UvuCumrUN
 ptUlmZmYj9McZSHjLV2LibZ0ZwXFQPRAwEGfMJ7E4mN/14MTBzBbJR504tWXaXhtHqvu
 nXyxG9p0YyLLr0lP2hPyRLlpS51RT6qwjz5x9eLtmicXAv5YqRrO5nPk36ih2oTS7Pz6
 F2sw==
X-Gm-Message-State: AOJu0YyEVP1bY5yzc1wZ3oG5KDBIL+6IX0QhwuwhhtbT2S271rJCy2NQ
 ev2gx0kerTR6/diL5RKI1Fup/I4OQteDENPo4x99Cg==
X-Google-Smtp-Source: AGHT+IHqymRch0WfWeqhA7vo6dUOXp4nfS+m1iCPCxGRL/oAQ+ACW8QIDMni4Jhp/08J6wqaEntJjA==
X-Received: by 2002:a25:5589:0:b0:da0:50f9:dc32 with SMTP id
 j131-20020a255589000000b00da050f9dc32mr1703016ybb.33.1700658724110; 
 Wed, 22 Nov 2023 05:12:04 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.12.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:12:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 10/11] include: Further cleanup includes
Date: Wed, 22 Nov 2023 08:11:53 -0500
Message-Id: <20231122131154.2444690-10-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
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

