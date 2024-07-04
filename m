Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDF6C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE80A88914;
	Thu,  4 Jul 2024 09:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SCM8u9wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B2C888CF; Thu,  4 Jul 2024 09:49:10 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26FA888E8
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so2625595e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720079347; x=1720684147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3xii0B5kxNWqUQxGGhR+L9oO3YJpUU6fHdLM/+A1FU=;
 b=SCM8u9wrM+dhWlDRcLa51m8DXBUzTbTrUmWUbJanfHfNZ6zC3YMB3W5b/TH7Ni/8OD
 h6FetEQ9KJ8tNdCEciAOpA7tL5hC35P0MzYbhPV2m4xcUuP9YQ7jLhCO6jYTjIwxxZOB
 b4NKj78OH6FMb5SVx5ZjKgWOTVHRRIj/1EyvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079347; x=1720684147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3xii0B5kxNWqUQxGGhR+L9oO3YJpUU6fHdLM/+A1FU=;
 b=JNGuGyP83fwa1qtNdTEfmR5r12xPuAt9woflYODtVnx5bA4U6yxSmmj4LDENWKd0x+
 p5XSk8FlzgLSpXeYa6hO0xEbH4epHh+KvBG7Q7ZzBY7x/UvDp4+3rJ6iC4XNLUMOrd7Y
 LmlCsBCeFf1UPh/lKPKrw3Jqn580e1zhSgRPnTyGu3WNyXNENHK60zaE7WI4/uM5z9qf
 /BfjyrcXxNRT3UbAIu43Fxa2WaS8U3JwR6+l2iQJOK+3kMYbUhSzhxvRg3WBKWk9+9f1
 gJxnP248NZMI5PWG95u/oRNzzVq97XkuILBWyrwLIeVD1J1MRgtyRmKcYHF4VYLVmgeA
 G1AA==
X-Gm-Message-State: AOJu0YysKmwvxmv4vu8+IfgzxGFD3dz/sIFD4yDM5/IDhLZgsvO1udLj
 D/TKsS7KGjOtxOEsdJQONl13Plo+q7xpIOGpmx680lyOPWWqr/t+WpS4slXpCfzgiPaQ9j1mzRo
 =
X-Google-Smtp-Source: AGHT+IEPKCXIVrjJjX9ceNl6myFsDsHG13wGKOB/FshAHcKAD8GXNd7XJK4fuUpSdlKt9G++LhEoBg==
X-Received: by 2002:a05:600c:4344:b0:425:657a:518d with SMTP id
 5b1f17b1804b1-4264a3cfff8mr9290525e9.14.1720079347113; 
 Thu, 04 Jul 2024 00:49:07 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm12885515e9.32.2024.07.04.00.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:49:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Stefan Roese <sr@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng@tinylab.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v3 1/5] cyclic: Add a symbol for SPL
Date: Thu,  4 Jul 2024 08:48:55 +0100
Message-Id: <20240704074859.2956745-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704074859.2956745-1-sjg@chromium.org>
References: <20240704074859.2956745-1-sjg@chromium.org>
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
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Stefan Roese <sr@denx.de>
---

Changes in v3:
- Drop inclusion of kconfig.h in cyclic.h

Changes in v2:
- Add an SPL_CYCLIC symbol
- Add a lot more explanation about the header files

 common/Kconfig                    | 8 ++++++++
 common/Makefile                   | 2 +-
 drivers/watchdog/Kconfig          | 1 +
 include/asm-generic/global_data.h | 2 +-
 include/cyclic.h                  | 5 +++--
 5 files changed, 14 insertions(+), 4 deletions(-)

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
index 8318fd77a32..05de46db024 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -408,6 +408,7 @@ config WDT_ARM_SMC
 config SPL_WDT
 	bool "Enable driver model for watchdog timer drivers in SPL"
 	depends on SPL_DM
+	select SPL_CYCLIC if CYCLIC
 	help
 	  Enable driver model for watchdog timer in SPL.
 	  This is similar to CONFIG_WDT in U-Boot.
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index fcc3c6e14ca..21fb94f95f8 100644
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

