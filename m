Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A19CC5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB1A8759F;
	Tue, 21 Nov 2023 03:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VXyjMpSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6323B875A1; Tue, 21 Nov 2023 03:09:43 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2B9875A8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1f060e059a3so3046078fac.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700532577; x=1701137377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ol4uia7yqllH9E+4nwUgKNF5ERbk8N70f5/8xamcT4=;
 b=VXyjMpSehtnf59BU2K0LFtfs9WriWfTeeo/J3NYKb/jrKz4y2SiX7rpg0XXohW57Nm
 bUuKk0OoESLgsZgO6zNlH0XYz4hEbt/dicsBNdYPm1I293ynN1LNzzkXZtfrGs41p6f6
 VQVdoCyspLHPfeNUG8bq8ng6y10y27bZl2Vko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700532577; x=1701137377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Ol4uia7yqllH9E+4nwUgKNF5ERbk8N70f5/8xamcT4=;
 b=hpCGmDTzz7QncqAen2ag1r4swRYoS8Ujz3+gw1ONAacussFeVjAWhF8I0L6YBRckPD
 DAAcqWoHZVOb34/2V9xBeTLZisZ5szqE/HZTPfCL5qHbfP5JNndPv+7beDfqCZiAnjvO
 feVJ0WbFQ9L9ajxRsND2DHdvaTgAW5WAcvgHfG2nbwuqfn54BcKvSaJdXdYqcicEcXxv
 fajnz++2y4mC21tzd4w1kC4x1EwYTJPBiSUVryi9UQvVKcImNcFQwPMZnWF+EtkFuJvs
 /jlo0BbHs3gsoJ54MJfy7pfhqXUWHP+M5r4spql8Q1MNnh8A9aVC+E8PJCYt34c+Nb/n
 M7cg==
X-Gm-Message-State: AOJu0YxrHct6sVUf/ogwr/wC00w3NDWF4T5VjfxZjOg7QaODz4FGnw3g
 e0/B8Qa5qkPw8AogvuSrQl3e8kLivt8WyNs9SxB0uA==
X-Google-Smtp-Source: AGHT+IF9641CnWE/HufdJiA9cuUz01UvX9HSxowujohmeE47H1HUYtzrPgxtWtQGJ6lB74U9YO/T4w==
X-Received: by 2002:a05:6870:724d:b0:1f0:5e1f:4518 with SMTP id
 y13-20020a056870724d00b001f05e1f4518mr11253345oaf.37.1700532576641; 
 Mon, 20 Nov 2023 18:09:36 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 du20-20020a0568716e1400b001e12f685592sm1542693oac.13.2023.11.20.18.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 18:09:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Date: Mon, 20 Nov 2023 19:09:25 -0700
Message-ID: <20231121020932.733405-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121020932.733405-1-sjg@chromium.org>
References: <20231121020932.733405-1-sjg@chromium.org>
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

The cyclic subsystem is currently enabled either in all build phases
or none. For tools this should not be enabled, but since lib/shc256.c
and other files include watchdog.h in the host build, we must make
sure that it is not enabled there.

Add an SPL symbol so that there is more control of this.

Add an include into cyclic.h so that tools can include this file.

Also add the kconfig.h header so that CONFIG_IS_ENABLED() works. We
could avoid this for now by moving the location of the watchdog.h
inclusion to outside the USE_HOSTCC area. But at some point the #ifdefs
from these files will likely be removed, so there is no benefit in
going that way.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add an SPL_CYCLIC symbol
- Add a lot more explanation about the header files

 common/Kconfig                    | 8 ++++++++
 common/Makefile                   | 2 +-
 drivers/watchdog/Kconfig          | 1 +
 include/asm-generic/global_data.h | 2 +-
 include/cyclic.h                  | 6 ++++--
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 0283701f1d05..5906a4af7c33 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -626,6 +626,14 @@ config CYCLIC
 
 if CYCLIC
 
+config SPL_CYCLIC
+	bool "General-purpose cyclic execution mechanism (SPL)"
+	help
+	  This enables a general-purpose cyclic execution infrastructure in SPL,
+	  to allow "small" (run-time wise) functions to be executed at
+	  a specified frequency. Things like LED blinking or watchdog
+	  triggering are examples for such tasks.
+
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
 	default 1000
diff --git a/common/Makefile b/common/Makefile
index 1495436d5d45..27443863bf9b 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -77,7 +77,7 @@ obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
 obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
 
-obj-$(CONFIG_CYCLIC) += cyclic.o
+obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
 obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
 
 obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 07fc4940e918..378435c55cc7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -395,6 +395,7 @@ config WDT_ARM_SMC
 config SPL_WDT
 	bool "Enable driver model for watchdog timer drivers in SPL"
 	depends on SPL_DM
+	select SPL_CYCLIC if CYCLIC
 	help
 	  Enable driver model for watchdog timer in SPL.
 	  This is similar to CONFIG_WDT in U-Boot.
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index e8c6412e3f8d..77f11a4383c9 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -485,7 +485,7 @@ struct global_data {
 	 */
 	struct event_state event_state;
 #endif
-#ifdef CONFIG_CYCLIC
+#if CONFIG_IS_ENABLED(CYCLIC)
 	/**
 	 * @cyclic_list: list of registered cyclic functions
 	 */
diff --git a/include/cyclic.h b/include/cyclic.h
index 44ad3cb6b803..d3b368dd90df 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -11,6 +11,7 @@
 #ifndef __cyclic_h
 #define __cyclic_h
 
+#include <linux/kconfig.h>
 #include <linux/list.h>
 #include <asm/types.h>
 
@@ -44,7 +45,8 @@ struct cyclic_info {
 /** Function type for cyclic functions */
 typedef void (*cyclic_func_t)(void *ctx);
 
-#if defined(CONFIG_CYCLIC)
+#if CONFIG_IS_ENABLED(CYCLIC)
+
 /**
  * cyclic_register - Register a new cyclic function
  *
@@ -122,6 +124,6 @@ static inline int cyclic_unregister_all(void)
 {
 	return 0;
 }
-#endif
+#endif /* CYCLIC */
 
 #endif
-- 
2.43.0.rc1.413.gea7ed67945-goog

