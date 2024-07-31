Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C11C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307E688A8C;
	Wed, 31 Jul 2024 16:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZTufZrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B80788A64; Wed, 31 Jul 2024 16:44:24 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED65E88A6D
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso235522339f.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437059; x=1723041859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyt2834cePAfMWqSrwH9IB7r/M9sRkmMG6FpH9x7eHU=;
 b=cZTufZrF1F2j4ntOcbHty2cU3ka2ryHBq1UlkNEBsVwDkmKsIWyZP0bt6yq6KVXwJs
 3v8QBvYjJIVoqIy5EcUA7BfL1savldrwfijjwTNTVnyZED+RY0ivORbrY0d9CQ6qRy7n
 5sqb2wcV/h6I5+glRjpRGr/bYEOlcTP6OfdaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437059; x=1723041859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyt2834cePAfMWqSrwH9IB7r/M9sRkmMG6FpH9x7eHU=;
 b=rSN55a0kh7zkj6iatiexhgQoTbuS2fM1hpbKRtbIOcxcvz3zgK8rLHau7o7VuslW8h
 +YveTXeLczeaGkkHxIh/M3xxK26ltwKj6cemmK/m4+vUPaOt7W2790QynjJYOHgA4sP9
 cOA7UsqN2jXWXh4VYjuIfAVuZc9ziEvv63Y43BC2i0jYJ6SEZItmCe8xKI6HW82/YjoL
 gWYaZsr0+Ky7JwfuD8vv33NbiQ8BYVBO8d7NaVQidOnyjEpfJ2wGHNq3TJF1JwSnE76i
 cIWOBqFrxP0kmwtQj7nHn+N3dahI2GvxMl2QT2JUrArgGThu/DYAEr2MDeMGgQaNKCDT
 V0Zg==
X-Gm-Message-State: AOJu0Yw61xP9wtAI35FySkTxggJ7iQHEqciXewf9VljJkFoOu4I2vy3r
 roavI0Y1zLHA6vOuA7Uw1dReEpN0WIfg+eWv24XNyUgoxpTqHVVDHbGsylz427HAP8GKy81mRPQ
 =
X-Google-Smtp-Source: AGHT+IGSIxG5ZUWkE74dkWy6Axfj1KPvlelWflKfw1oAM45poQ4hiwqZ8LVHxAJb/532a+tqz0DHwA==
X-Received: by 2002:a92:cdac:0:b0:375:8b0e:4434 with SMTP id
 e9e14a558f8ab-39aec2eda9cmr154024645ab.16.1722437059557; 
 Wed, 31 Jul 2024 07:44:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7e4f9sm55575845ab.2.2024.07.31.07.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:44:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v4 1/5] cyclic: Add a symbol for SPL
Date: Wed, 31 Jul 2024 08:44:08 -0600
Message-Id: <20240731144412.790317-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144412.790317-1-sjg@chromium.org>
References: <20240731144412.790317-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Stefan Roese <sr@denx.de>
---

Changes in v4:
- Imply SPL_CYCLIC if WATCHDOG is enabled

Changes in v3:
- Drop inclusion of kconfig.h in cyclic.h

Changes in v2:
- Add an SPL_CYCLIC symbol
- Add a lot more explanation about the header files

 common/Kconfig                    | 8 ++++++++
 common/Makefile                   | 2 +-
 drivers/watchdog/Kconfig          | 2 ++
 include/asm-generic/global_data.h | 2 +-
 include/cyclic.h                  | 5 +++--
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 4bb9f08977a..87b0ec3ea8f 100644
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
 	default 5000
diff --git a/common/Makefile b/common/Makefile
index e9835473420..d871113cbb9 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
 obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
 
-obj-$(CONFIG_CYCLIC) += cyclic.o
+obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
 obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
 
 obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8318fd77a32..0c3e9913318 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -4,6 +4,7 @@ config WATCHDOG
 	bool "Enable U-Boot watchdog reset"
 	depends on !HW_WATCHDOG
 	select CYCLIC
+	imply SPL_CYCLIC if SPL
 	help
 	  This option enables U-Boot watchdog support where U-Boot is using
 	  watchdog_reset function to service watchdog device in U-Boot. Enable
@@ -408,6 +409,7 @@ config WDT_ARM_SMC
 config SPL_WDT
 	bool "Enable driver model for watchdog timer drivers in SPL"
 	depends on SPL_DM
+	select SPL_CYCLIC if CYCLIC
 	help
 	  Enable driver model for watchdog timer in SPL.
 	  This is similar to CONFIG_WDT in U-Boot.
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index aa336d63e3a..27aa75e7036 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -481,7 +481,7 @@ struct global_data {
 	 */
 	struct event_state event_state;
 #endif
-#ifdef CONFIG_CYCLIC
+#if CONFIG_IS_ENABLED(CYCLIC)
 	/**
 	 * @cyclic_list: list of registered cyclic functions
 	 */
diff --git a/include/cyclic.h b/include/cyclic.h
index 2c3d383c5ef..cd95b691d48 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -46,7 +46,8 @@ struct cyclic_info {
 /** Function type for cyclic functions */
 typedef void (*cyclic_func_t)(struct cyclic_info *c);
 
-#if defined(CONFIG_CYCLIC)
+#if CONFIG_IS_ENABLED(CYCLIC)
+
 /**
  * cyclic_register - Register a new cyclic function
  *
@@ -123,6 +124,6 @@ static inline int cyclic_unregister_all(void)
 {
 	return 0;
 }
-#endif
+#endif /* CYCLIC */
 
 #endif
-- 
2.34.1

