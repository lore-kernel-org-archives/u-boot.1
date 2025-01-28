Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FA8C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 10:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A330081DA8;
	Tue, 28 Jan 2025 11:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vehJIa2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B3F81D42; Tue, 28 Jan 2025 11:20:10 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A0781D5A
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 11:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso36335555e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 02:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738059607; x=1738664407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqWBxBeSBN85uoyU0epbXFnDKcvIpLM2onBGrSfc4vg=;
 b=vehJIa2eEzlk1fnQMCYu+iQhmYQH9Je4igXoDWQAXZ4n2gOunoZaGQphO8FoG10UWu
 Ngj91iDbINccGT0rnxO/5NEQOlitd5maXaCGi1sg7HWuRvYtp386g2eJKYQXK5Gfyffa
 rftnMLSaNJFVMgtvYWO1RH4o2Tw9m4mwQMyEBHvMIhTyovHy9wi3HOCqYo9RrBnNGs91
 PMGD45QYftjW0fBOodFdz7XRif/Aa0abwf9dPPMjtNVc8JQ58ntW57BzcYU0CWoDPxov
 GT7TSlmGVsfwz4sdR2aRVU8WzgS8KNCgFwfUDQrnrg1MoE0jFzLfjvxWr7h+O5F/wM1x
 tVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738059607; x=1738664407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqWBxBeSBN85uoyU0epbXFnDKcvIpLM2onBGrSfc4vg=;
 b=OTltHAG10kVeifjZ+Swb09KCmXQpjUXWAASX9eUpMpgyoyO7QryJVJgJjF9Sk2KrKW
 uD+FmsEDetZkdfPTiPCygXauwiEa6DRA+2VaIImzDNcwVGqIHLJnAeki5NOcnvHI5/1x
 JREYIKrPtRhOVt/nXjrp4w43ggeS1EhMbtgquSUNUjAhInF4L4C44SZuc8wCBnwdnYWO
 NVYiLdRIhKu2EVqxCBQAOpzu1QkCEHH6ELET2qfk0YHU2CeL1ImWnwFhH9arHacIPOEZ
 uS6o4D1PRABXQcOIyf+KXtcg5om1eQI4PfrcAhIX1Jpdfe2vb3dSGLRxQGYMs3zsSRH7
 SVrQ==
X-Gm-Message-State: AOJu0YzHQEiY/yepSnSPEFyPkq0EzIw1F3vQMXcRhcRi7G+P0Sjjm2jh
 Xx6crlBTlqYClEoEOSCTgtn1ar/jX+mtgXl9CJN/nd8BdZHg7qypmSR/TdQT0pOhrnXPQgSUOTV
 40/TX6Q==
X-Gm-Gg: ASbGncsSdJZjHbFJUDmsnYY+LkE982zskDHvqJln3U25VE7HEWY47sOo9QQBdbyiUIy
 idOpQP1gCBIMm+/kTpeoeDjeMJ0pUIuaWqMfC49EcgxZR5ULFQFLlGxWQMfyMZ/oXqrXuaO5q9t
 VqZd3Mx2na3ASCVz9Ob351vbjO0J61jqLIVc1b4jZxoRYDW9dwCJr7UBUGpgBXo9/8JVldQ8UBq
 66z8Knfi2Ch8VW9rZP8MQ/faOtWJVRbLE3LV3sguYlnTDUbU8UuZCgdw452MPl0Mj9236jyfIvk
 xQWA17nSbmTAk9s43Pt2ZVow2/vjqqwYAQ==
X-Google-Smtp-Source: AGHT+IGACiwijhxUeIJNRHrYLgKaffT/tX4+z1apZtRX9F7bSqlcrTEI4tFTKkORwjiW+cvDanPlDA==
X-Received: by 2002:a05:600c:3149:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-43891441f57mr423818165e9.29.1738059606927; 
 Tue, 28 Jan 2025 02:20:06 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:45e:43e2:ed61:42fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9977sm164651245e9.25.2025.01.28.02.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:20:06 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 2/3] efi_loader: optimize efi_init_obj_list() with
 coroutines
Date: Tue, 28 Jan 2025 11:19:16 +0100
Message-ID: <d4c18cf76488004c55af633ec87ac0c12550d399.1738059345.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738059345.git.jerome.forissier@linaro.org>
References: <cover.1738059345.git.jerome.forissier@linaro.org>
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

When COROUTINES is enabled, schedule efi_disks_register() and
efi_tcg2_register() as two coroutines in efi_init_obj_list() instead of
invoking them sequentially. The voluntary yield point is introduced
inside udelay() which is called frequently as a result of each function
polling the hardware. This allows the two coroutines to make progress
simultaneously and reduce the wall clock time required by
efi_init_obj_list().

Tested on Kria KV260 with a microSD card inserted with the "printenv
-e" command. With COROUTINES disabled, efi_init_obj_list() completes in
2821 ms on average (2825, 2822, 2817). With COROUTINES enabled, it
takes 2265 ms (2262, 2260, 2272). That is a reduction of 556 ms which
is not bad at all considering that measured separately,
efi_tcg2_register() takes ~825 ms and efi_disks_register() needs ~600
ms, so assuming they would overlap perfectly one can expect a 600 ms
improvement at best.

The code size penalty for this improvement is 1340 bytes.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/efi_loader/efi_setup.c | 113 +++++++++++++++++++++++++++++++++++--
 lib/time.c                 |  14 ++++-
 2 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..94160f4bd86 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -7,10 +7,12 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <coroutines.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
 #include <asm-generic/unaligned.h>
+#include <stdlib.h>
 
 #define OBJ_LIST_NOT_INITIALIZED 1
 
@@ -208,6 +210,46 @@ out:
 	return -1;
 }
 
+#if CONFIG_IS_ENABLED(COROUTINES)
+
+static void efi_disks_register_co(void)
+{
+	efi_status_t ret;
+
+	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
+		goto out;
+
+	/*
+	 * Probe block devices to find the ESP.
+	 * efi_disks_register() must be called before efi_init_variables().
+	 */
+	ret = efi_disks_register();
+	if (ret != EFI_SUCCESS)
+		efi_obj_list_initialized = ret;
+out:
+	co_exit();
+}
+
+static void efi_tcg2_register_co(void)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
+		goto out;
+
+	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
+		ret = efi_tcg2_register();
+		if (ret != EFI_SUCCESS)
+			efi_obj_list_initialized = ret;
+	}
+out:
+	co_exit();
+}
+
+extern int udelay_yield;
+
+#endif /* COROUTINES */
+
 /**
  * efi_init_obj_list() - Initialize and populate EFI object list
  *
@@ -216,6 +258,12 @@ out:
 efi_status_t efi_init_obj_list(void)
 {
 	efi_status_t ret = EFI_SUCCESS;
+#if CONFIG_IS_ENABLED(COROUTINES)
+	struct co_stack *stk = NULL;
+	struct co *main_co = NULL;
+	struct co *co1 = NULL;
+	struct co *co2 = NULL;
+#endif
 
 	/* Initialize once only */
 	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
@@ -224,6 +272,53 @@ efi_status_t efi_init_obj_list(void)
 	/* Set up console modes */
 	efi_setup_console_size();
 
+#if CONFIG_IS_ENABLED(COROUTINES)
+	main_co = co_create(NULL, NULL, 0, NULL, NULL);
+	if (!main_co) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	stk = co_stack_new(8192);
+	if (!stk) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	co1 = co_create(main_co, stk, 0, efi_disks_register_co, NULL);
+	if (!co1) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	co2 = co_create(main_co, stk, 0, efi_tcg2_register_co, NULL);
+	if (!co2) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	udelay_yield = 0xCAFEDECA;
+	do {
+		if (!co1->done)
+			co_resume(co1);
+		if (!co2->done)
+			co_resume(co2);
+	} while (!(co1->done && co2->done));
+	udelay_yield = 0;
+
+	co_stack_destroy(stk);
+	co_destroy(main_co);
+	co_destroy(co1);
+	co_destroy(co2);
+	stk = NULL;
+	main_co = co1 = co2 = NULL;
+
+	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED) {
+		/* Some kind of error was saved by a coroutine */
+		ret = efi_obj_list_initialized;
+		goto out;
+	}
+#else
 	/*
 	 * Probe block devices to find the ESP.
 	 * efi_disks_register() must be called before efi_init_variables().
@@ -232,6 +327,13 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
+		ret = efi_tcg2_register();
+		if (ret != EFI_SUCCESS)
+			efi_obj_list_initialized = ret;
+	}
+#endif
+
 	/* Initialize variable services */
 	ret = efi_init_variables();
 	if (ret != EFI_SUCCESS)
@@ -272,10 +374,6 @@ efi_status_t efi_init_obj_list(void)
 	}
 
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
-		ret = efi_tcg2_register();
-		if (ret != EFI_SUCCESS)
-			goto out;
-
 		ret = efi_tcg2_do_initial_measurement();
 		if (ret == EFI_SECURITY_VIOLATION)
 			goto out;
@@ -350,6 +448,13 @@ efi_status_t efi_init_obj_list(void)
 	    !IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY))
 		ret = efi_launch_capsules();
 out:
+#if CONFIG_IS_ENABLED(COROUTINES)
+	co_stack_destroy(stk);
+	co_destroy(main_co);
+	co_destroy(co1);
+	co_destroy(co2);
 	efi_obj_list_initialized = ret;
+#endif
+
 	return ret;
 }
diff --git a/lib/time.c b/lib/time.c
index d88edafb196..c11288102fe 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -17,6 +17,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <coroutines.h>
 
 #ifndef CFG_WD_PERIOD
 # define CFG_WD_PERIOD	(10 * 1000 * 1000)	/* 10 seconds default */
@@ -190,6 +191,8 @@ void __weak __udelay(unsigned long usec)
 
 /* ------------------------------------------------------------------------- */
 
+int udelay_yield;
+
 void udelay(unsigned long usec)
 {
 	ulong kv;
@@ -197,7 +200,16 @@ void udelay(unsigned long usec)
 	do {
 		schedule();
 		kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
-		__udelay(kv);
+		if (CONFIG_IS_ENABLED(COROUTINES) &&
+		    udelay_yield == 0xCAFEDECA) {
+			ulong t0 = timer_get_us();
+			do {
+				co_yield();
+				__udelay(10);
+			} while (timer_get_us() < t0 + kv);
+		} else {
+			__udelay(kv);
+		}
 		usec -= kv;
 	} while(usec);
 }
-- 
2.43.0

