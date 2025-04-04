Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9A2C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 13:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDB282A0D;
	Fri,  4 Apr 2025 15:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nsOdJ5si";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA5F82991; Fri,  4 Apr 2025 15:51:01 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D242829CF
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 15:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so1263778f8f.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743774659; x=1744379459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxXNjaFFbCQWlsJplb+zVqDMjqzJpYEjfCrN3RSUMrY=;
 b=nsOdJ5siZTxcQ6yp2IRzZxo8XS9QWcOCXusu0XqvhA8KWrdtesAWkumzaKWhYEmtBJ
 DKHlNTLYgVLxF3onf6Ppplo1UQMqEqMRgepe3gh27PUqW/30mCfUabf/mRln+sf1A0gv
 vEKrPnSHMRBvBfGZaIzhAT4qam0U+Z5w36OgYsTH5tDcJ+XTVllO3xJcOsSaJhenf9t9
 CLYTCxdJKev735XYNhGHkj3HQVaEl58mPLcWnhatTVr6nVSlNBk+21OztHGQ3H2HKKjd
 AWpdSFCI6wau/KgY3HEqswuX/sWUmj8qTqj1WkDsIFVtK/ILdoGuKYV8WHrzU7l5mD1C
 f9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743774659; x=1744379459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxXNjaFFbCQWlsJplb+zVqDMjqzJpYEjfCrN3RSUMrY=;
 b=HgdOjMT478QQYpzvUQuv8+kvV1TzwVqqgKyp8eawNQqGH7BkpuZ/bXsVbY77eRK+uT
 k4bGP8XXtK99jYqmjMVtGydE7HJahPLyGXmXLuTzCLRycSCyM9odOTYxH27cMIHfsCiQ
 +Q3MK0awkx/OPFMUSfCplWTrpzqEWC6njqHs1BdutstWTo5wcMpw8JERgnXHoUXQUzz+
 luJUpc240ccf7ejrbdM7koHwoA+adNIv5kxwlHmCLBE6za7En4X89p8TJac4EZnm0ZG/
 HQFk2e3ewnqhufd7uilA3wDm22aGc/u/FcE9sE/o5rKiJJKYmw/lN8ZtwzGnOWCTX0Kv
 yncQ==
X-Gm-Message-State: AOJu0Yx36fCN0CI5cHAwdfqxmaysD7isPmrBi+gxPKndimjzHhQB29qp
 5eCK9siwRV6yILPV1hBiuAPkEcwzXZpZgeREhCovczJGFidFuog8lK5lsVo3l8g37o9ovRYEHPt
 K6JPc+g==
X-Gm-Gg: ASbGnctBLqrhGlYQueicStzIEC2C6LDbZ1BzsOU83tEktZy70nJh8uSy0y7On8rCfz0
 DPnSqHBesYxVL/9A7Mo8NhunUigv4irwOGm+ofgyUP+eTsiQ2aseow3fDNWwIodCrE9hkdzKwlp
 JW4OpukW1S80wbLxPXTibsyT2ydgdg3tHQ/xbueu124aGxKs+lHMh0qiyD8RJZ7K5PDOWiAmTst
 bvQgvXBUHrWtZvDWP3Z0tnr8/EbYi7T8EhL2QIp6IpgAunB4/brBDif4vrZks2KOwlylmkX4UG4
 k7hjHMoLQoldOoP1/LzS2Ih78y4mUQaqFfkd8Evrj+K8bAY2la5dQQ==
X-Google-Smtp-Source: AGHT+IHn0J3Qx29RbukYNSiX/LNVan42Uf+a7ehJgFOhjLMlpeTf7vEZm0RpUbDKYTYneqFeXs7InQ==
X-Received: by 2002:a05:6000:43c9:b0:39c:1258:2dca with SMTP id
 ffacd0b85a97d-39cba98760cmr2144796f8f.59.1743774658834; 
 Fri, 04 Apr 2025 06:50:58 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:70d5:66af:ee2d:db3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7064sm4531821f8f.34.2025.04.04.06.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 06:50:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v6 3/3] initcall: remove initcall_run_list()
Date: Fri,  4 Apr 2025 15:50:37 +0200
Message-ID: <20250404135038.2134570-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404135038.2134570-1-jerome.forissier@linaro.org>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
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
index 8e22526dd9e..220a55ad84d 100644
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
index a30ce1595d5..072bd933843 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -43,7 +43,6 @@ endif
 
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

