Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A29E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C93802F2;
	Wed, 18 Dec 2024 16:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sojm6M3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56128036D; Wed, 18 Dec 2024 16:54:26 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8921A80316
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso53261495e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537264; x=1735142064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfQbeffR+wV3yx3YnO6qFvNIxYUPN2RkZEsAar5iRYA=;
 b=Sojm6M3vZnBPqfMOA1DttkBjPOe6HSDctgK26Q7HCW6Go4rRUuU/C+OQbHg6fwdrOg
 r2m5G/qe1h7xcr1ZlKklLnikQ5N3a2PQkj0zf/gPRwLNdCC1aVjppETg5Vs07pLh2Y1E
 v+B8wfvBwqPzTGgx97ZhYIFnQDA9yDZAr6+DNYO3ij4mgR30ouBRWlzGg7/lb3iXb6Z2
 Cji/QUmEiLWKTu1VSRDi9Tx5vWMC1nKnyrbRS+LU/phGBQo0n1oQbXRdc9I88+fhiXV1
 rZPsARdsX4dsN23r/OdSdrCADOe56qO9yZCJQBUOvmkCGk7ancMjeN3fJF/R8Ksp71jS
 Z+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537264; x=1735142064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BfQbeffR+wV3yx3YnO6qFvNIxYUPN2RkZEsAar5iRYA=;
 b=PFGhlzfBATTp4NzqbmkwJo/TjJjw44AVh6vOUzxFWO7oSfLkV47PDEYgqdPxucwG1U
 C6ZN+KF791SmYXZsiTEMie5uFmSG8Z8UO9RKG4CCxyODaln7N1iRhywLEaPM/U08SoZC
 aUf9yIqD5fDnTdqmtp5ms8R5Rz7sGO58tO3cuX2tTb7pWIMOrtzi5UkwgcZJNjta7AJD
 kdAc3UoV6A0q5sealbnVemTyNRMtned1fv2i+N83R/M1FHOxMx78CNNKg5yVYSxjXh4p
 dZBODueXejhTSUL9pAahNPuiFJC3fHnJvYH3BqCxapR1hvOoLWvaXL+/Jz4hvY9TvNBJ
 OfZQ==
X-Gm-Message-State: AOJu0YwkmyZe1/DiMKsXIghHEVm7ilwPXWqD0UnOqZU4c258M6qJ80Qx
 rO19mFlr252xp2SFDh0cv85d2TOySJbWzRiYpSR12I5uE8eRcV3Tkqp1io4AeHpbVW1U5hy4J8m
 95Bo=
X-Gm-Gg: ASbGncuy60DCmfa6HhBVDFgEuat1rQPcSVrHk05DqLiSECwJMvE276JZoQxK5ehlSRk
 M0S4yTd/SF+yZ0rxQ8T+ssO7sDejWPArDW2WP9dYjVIhWJ94YSgF9PsEwGGEh4Sg2+ak4yck+vn
 k1n/qL8keciuFkAJzAdcLhtPAQSnKnULIAlQ/jFn31ZvWkaM8+rsGIb6h5EiCBlKD40t6Fw4jOu
 kYacfE8mzdms9aoji7YBQOlase3SkGXNudb6f5vdpTjHHS6L5QdbMq5O8hRp/oCyw==
X-Google-Smtp-Source: AGHT+IGQ0qphZhFMUt4Fd9MEp2q5CzEnxP4DCNp98oOLJjmMqgOyF9JaRuZa8F8YzY7gMoZ9ymU0/g==
X-Received: by 2002:a05:600c:350c:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-4365536be84mr29119275e9.19.1734537263764; 
 Wed, 18 Dec 2024 07:54:23 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc125sm25181705e9.6.2024.12.18.07.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:54:23 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 5/5] initcall: remove initcall_run_list()
Date: Wed, 18 Dec 2024 16:53:58 +0100
Message-ID: <c82384c9655e3065dbe550183c24ede9c458a332.1734537135.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734537135.git.jerome.forissier@linaro.org>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
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

Now that all initcalls have been converted to static calls, remove
initcall_run_list().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/initcall.h |  24 -----------
 lib/Makefile       |   1 -
 lib/initcall.c     | 102 ---------------------------------------------
 3 files changed, 127 deletions(-)
 delete mode 100644 lib/initcall.c

diff --git a/include/initcall.h b/include/initcall.h
index 9398a3ec7d5..9d1af44778b 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -12,30 +12,6 @@
 
 _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
 
-/**
- * init_fnc_t - Init function
- *
- * Return: 0 if OK -ve on error
- */
-typedef int (*init_fnc_t)(void);
-
-/* Top bit indicates that the initcall is an event */
-#define INITCALL_IS_EVENT	GENMASK(BITS_PER_LONG - 1, 8)
-#define INITCALL_EVENT_TYPE	GENMASK(7, 0)
-
-#define INITCALL_EVENT(_type)	(void *)((_type) | INITCALL_IS_EVENT)
-
-/**
- * initcall_run_list() - Run through a list of function calls
- *
- * This calls functions one after the other, stopping at the first error, or
- * when NULL is obtained.
- *
- * @init_sequence: NULL-terminated init sequence to run
- * Return: 0 if OK, or -ve error code from the first failure
- */
-int initcall_run_list(const init_fnc_t init_sequence[]);
-
 #define INITCALL(_call) \
 	do { \
 		if (_call()) { \
diff --git a/lib/Makefile b/lib/Makefile
index d24ed629732..78d9d02369b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_GZIP_COMPRESSED) += gzip.o
 obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
 obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
-obj-y += initcall.o
 obj-y += ldiv.o
 obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
diff --git a/lib/initcall.c b/lib/initcall.c
deleted file mode 100644
index 2686b9aed5c..00000000000
--- a/lib/initcall.c
+++ /dev/null
@@ -1,102 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2013 The Chromium OS Authors.
- */
-
-#include <efi.h>
-#include <initcall.h>
-#include <log.h>
-#include <relocate.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-static ulong calc_reloc_ofs(void)
-{
-#ifdef CONFIG_EFI_APP
-	return (ulong)image_base;
-#endif
-	/*
-	 * Sandbox is relocated by the OS, so symbols always appear at
-	 * the relocated address.
-	 */
-	if (IS_ENABLED(CONFIG_SANDBOX) || (gd->flags & GD_FLG_RELOC))
-		return gd->reloc_off;
-
-	return 0;
-}
-
-/**
- * initcall_is_event() - Get the event number for an initcall
- *
- * func: Function pointer to check
- * Return: Event number, if this is an event, else 0
- */
-static int initcall_is_event(init_fnc_t func)
-{
-	ulong val = (ulong)func;
-
-	if ((val & INITCALL_IS_EVENT) == INITCALL_IS_EVENT)
-		return val & INITCALL_EVENT_TYPE;
-
-	return 0;
-}
-
-/*
- * To enable debugging. add #define DEBUG at the top of the including file.
- *
- * To find a symbol, use grep on u-boot.map
- */
-int initcall_run_list(const init_fnc_t init_sequence[])
-{
-	ulong reloc_ofs;
-	const init_fnc_t *ptr;
-	enum event_t type;
-	init_fnc_t func;
-	int ret = 0;
-
-	for (ptr = init_sequence; func = *ptr, func; ptr++) {
-		reloc_ofs = calc_reloc_ofs();
-		type = initcall_is_event(func);
-
-		if (type) {
-			if (!CONFIG_IS_ENABLED(EVENT))
-				continue;
-			debug("initcall: event %d/%s\n", type,
-			      event_type_name(type));
-		} else if (reloc_ofs) {
-			debug("initcall: %p (relocated to %p)\n",
-			      (char *)func - reloc_ofs, (char *)func);
-		} else {
-			debug("initcall: %p\n", (char *)func - reloc_ofs);
-		}
-
-		ret = type ? event_notify_null(type) : func();
-		if (ret)
-			break;
-	}
-
-	if (ret) {
-		if (CONFIG_IS_ENABLED(EVENT)) {
-			char buf[60];
-
-			/* don't worry about buf size as we are dying here */
-			if (type) {
-				sprintf(buf, "event %d/%s", type,
-					event_type_name(type));
-			} else {
-				sprintf(buf, "call %p",
-					(char *)func - reloc_ofs);
-			}
-
-			printf("initcall failed at %s (err=%dE)\n", buf, ret);
-		} else {
-			printf("initcall failed at call %p (err=%d)\n",
-			       (char *)func - reloc_ofs, ret);
-		}
-
-		return ret;
-	}
-
-	return 0;
-}
-- 
2.43.0

