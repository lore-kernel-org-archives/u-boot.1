Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42806C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 15:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C3387631;
	Sat,  2 Dec 2023 16:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d1kOibbm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D9787616; Sat,  2 Dec 2023 16:34:26 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 654C78765B
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 16:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d07aaba357so2320465ad.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701531257; x=1702136057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUKUMQpeL+hoa1HluyyOT5muE5ZuEy52L7WOpe/V+ns=;
 b=d1kOibbmQP14QqUARzhMksSIHrhvpIa20TqM2ijnIeW97PDoqYXC/Zkcw/PhiLGgcf
 jWLsEnFmnQJlQF/7PVdvMWvvtf6xVEexHcH0oNJ/9YtzU9buYK3Iy3XAhczviW33fd+A
 jW8JuDKCtU/f9tnFcxEPrxcBdeKyZTpU94Y+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701531257; x=1702136057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUKUMQpeL+hoa1HluyyOT5muE5ZuEy52L7WOpe/V+ns=;
 b=xAIVIPTpFuVZd+u4trHZ+CQVMAR9iG1t2FKArIA8WCzHWhT3Wj2Fs9ozhO+Uzwq+oj
 9dy7G7RqLbHorjhyB6bwR0yAaWLelc2pyt5ArjKU/r16zYVtEjx8yKT4aLujqJ8W2MBX
 NaTTSb/wCjIS2aQ7KcceZHD6ORaD2Y54YXi+5JPPSbsl9+sAQMhKg/eWmmMC1I8RCx3h
 PMiLm1dldF1WaWtrY38AYKW00SyoZj3oxti0foLQ5/lkEZ+B19KHDelvPC0Q9h0DH/gV
 ucPeua/DAEkYo2tEsqBXRBLP/8Y19nwSs6BVhdfGRIZdQz/fp/wAXhFw5xrQZBFC/js1
 ydxQ==
X-Gm-Message-State: AOJu0YyN9a+VvGwIY8gGXjs/jod+3CS+s69FvwFRbppGE45raZah2kaQ
 Cr0CoOohhRFGwFBo9HMuElALDQIS+UVUuZl2s7h3Eg==
X-Google-Smtp-Source: AGHT+IFaoHOhviUAejQnqrIIuQATSfdekJNfTIO5566ScAGV5V2bLJvSFec6Mp/NCRM+24U9OI41YA==
X-Received: by 2002:a17:902:f20b:b0:1d0:6ffe:9f7 with SMTP id
 m11-20020a170902f20b00b001d06ffe09f7mr1070059plc.85.1701531257601; 
 Sat, 02 Dec 2023 07:34:17 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d30500b001cf8546335fsm2869217plc.5.2023.12.02.07.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 07:34:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Date: Sat,  2 Dec 2023 08:33:48 -0700
Message-ID: <20231202153400.537050-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231202153400.537050-1-sjg@chromium.org>
References: <20231202153400.537050-1-sjg@chromium.org>
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
2.43.0.rc2.451.g8631bc7472-goog

