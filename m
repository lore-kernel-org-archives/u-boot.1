Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E470C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 09:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A19E8096D;
	Fri, 24 Jan 2025 10:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wIhEQaDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE2368083C; Fri, 24 Jan 2025 10:10:50 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A4AC80780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43635796b48so12157885e9.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 01:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737709848; x=1738314648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+OcPxI2SSdquESZgqrciQ1/6QS8udlDuX8uSxv68oQ=;
 b=wIhEQaDtTRn2LIiCjjERs2MYQwiGWBoXI3Gd8OGobnRPR+XSqqDAxcwRW8Uhc0ewQ/
 0Pcoa6OcFBeUnipj91AGaAkcG9CJrOHYssE6treqrxpgBGNgTDbH01JUYAHGg7KlpSrU
 0UdWdB1BczKNcuaN9wR7umAE8IVeciqH+gx1UUj9Vw69P0yEOONnhStGV2HF/wbFPnbq
 k23GHqjCagB2okFSME0QtzTPujp/9zMXvhhdHujzijeNnFjr5/DkXK6jelQPWwM7XteL
 0uyr4ZiOAud4JxoVLUJzXm0btUcw3KWA0jMIYu97I3J5NAdNQHhYTgLt/skQsAoVXGA+
 3F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737709848; x=1738314648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+OcPxI2SSdquESZgqrciQ1/6QS8udlDuX8uSxv68oQ=;
 b=acAefIns0xphqTLs56w9RskZcCFUTPR4SQ7PvzuHDYdorp9wgOVqAwq02w6DsETXKp
 HmAewXfJnKAStAjrp1eQ8zGFEOF6i4AETXaECKnLfFtkMhiuBCd6rCbl2kj5KScblKAp
 E/XdiKJO9BNG6DruySuy5Ok+0F3+rETYj+4M/1otseWwkOyaFxQuuDjskqbTyoZt0hXr
 d/oPP9Yqg/tD+aSFiSmKFbfgbVlyhszYHTNooOX5LlGcq690EJdwscRSkqGrRzV0kxFi
 2e2msOlOfqmEOZWS01TECs3OrH8J0o/G/IY2/y5Ut+vT+V//XDQdcd2KnXBb82Y6O8e+
 CWyg==
X-Gm-Message-State: AOJu0YzX/1dLzw9T4P2mj/2lBwEFzWIh3BLxNUFI+lt3ZP2rn9y443rm
 p6mwVLmpcArhXiW9pq0//FBperP8u6zk6pTMGU5b7VgZU2z2rHWj4ugcRYz3ehTBLz5zprxtDRF
 4McG6ZQ==
X-Gm-Gg: ASbGncvz7F+XMr8HXqZShUkApt14acgt1w/RxX18r1Kq+3i9/Wc3EtQBt6kcyAcUj1D
 DHaS32ax3/DMjLXlo7vJ+7y7VSpK1WbdW9IgZlDan4e7MmsBGQS2v30S6NsR5/IbdoOZjPnCCW/
 bg03M4bJqMZeW9sUQ7DN4VmRRGKxY8Q9ABN3XFB6AkipLjBn27O5tYnO3KjqyQsrm2/P+IgZZ5Z
 bpJ5yiBRPus4i3NvB5RtqdGzryUPcx2V3e4+iIEei0/bGWLl1J8f2+KE2BcCs0HlH9xsM0wH67V
 uiASGxZ1rW98WA==
X-Google-Smtp-Source: AGHT+IFJNqQj6omg1wLSBwk+6LHeyUOyFzlV0XVv462bdAfLSCx+brr3v8u1kq+aRzTre+YgDgu5Vw==
X-Received: by 2002:a05:600c:1c14:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-438b8841d5amr59475185e9.1.1737709847897; 
 Fri, 24 Jan 2025 01:10:47 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e9c0:313f:f99a:cc15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm18943385e9.39.2025.01.24.01.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:10:47 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 3/3] initcall: remove initcall_run_list()
Date: Fri, 24 Jan 2025 10:10:29 +0100
Message-ID: <104d9b09b54bd6e27e8d468b1e06e657fa80d388.1737709089.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737709089.git.jerome.forissier@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
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
index 5cb3278d2ef..13fb36ce3ad 100644
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

