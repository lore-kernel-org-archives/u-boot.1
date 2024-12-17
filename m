Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911D0E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA20801CE;
	Tue, 17 Dec 2024 17:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d84CpowW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2C180274; Tue, 17 Dec 2024 17:00:12 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AC08022E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so53714645e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451209; x=1735056009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bc5dcGomkTmzvvZyWwHhfntlWLKNrTTzvh9e4xyRGnc=;
 b=d84CpowWsc3zc5QalMgPAGdXv4jOKrsGWkaEmaA7Cp2OQGagtq6r2/awldIATOUneJ
 qznUsCuhBfX96E91cFG8HDfuQIIn0zhdOvBDxOnTCWE23eAq6Z72e0Yh7PhBtIqUDfWP
 KEkd4igL+R6YT6/jGdfZhSOOwMNDqJQt2CLl0dz9+fGV3IYLCbzhhfan0sFTKIqy3LEw
 htL7sTL6BkDG/Lqj9uwCkb16NYN7M1l38OuyQfhGC0fgIQ5jUBLx4LT7s3NIOlCUE98N
 F4wtfxHjD7ESolYCZYsS4VE3gV5SNZ/qrB4K3bfiuXxvg17uGkgGqJu4STlRaeODDm2a
 FT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451209; x=1735056009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bc5dcGomkTmzvvZyWwHhfntlWLKNrTTzvh9e4xyRGnc=;
 b=l3GQo0705N+ndDoTOS8MyFG8UgFJwoByMcZs9hyA8P1D8Bg7n4JV202HH+a5ian8zb
 +0RncKHnfN/LHfbhkCia61gFjClSNOBuDYhfzmwqKWUoDtmiwlLB3fYCBEYQXsHBxYPo
 78ghXxaCZZGmKZym9W2q3Hxn1yTQmqW83JV/ytMXZI3kW3plrE+uKZ2h8ltDfQl9aLPL
 PFJ6rMWVbBXS7HMw/hc21nNvz8dqKsG4+QktiUPi6/WlQAfd7dt9t+F2uUPXyB/M6sfa
 liyh9E4+jSUpb52ozINtyO7deP2TxSMkI6k5i8fcdtk1mP7HPy4R7HpLpaF3RkNhHy8e
 12LQ==
X-Gm-Message-State: AOJu0YwIRxFr4G+Nh2ah8qn4Zaf+sej8IebOnoytAmXEGVxPSJTkJ0V/
 VKCAv1IdhJLJlbTnrImr+RhFlOjMGgrZo+bY+KS9a7pgBhpXivzXhNTFi2i/Aw4BcABkoY4ExUz
 bQF8=
X-Gm-Gg: ASbGncuXakDY8RaeNAefVwGyJzmE5tPt5wtECV1hAu/n/5tTv0bB03Xrikf5+vjGSVX
 4uJmzHryhbN0p6jYFHjimKHHVlJv6JCMvS9UJbHEADD+8MmBhZxdc/vGobI7x+Y4kJNOfPZPmjs
 pgN7BXvp0QBk0wDaT4/bUAZCfHpmD9R/4SxJwMKYLeQyvb37H/L+SYh9h3dn1TYFa4Huey9nhpf
 bkgg5GaT6dmW12DIW07k5q3w9IueukQkj7hMlG77Aeeg6/BQAoKGDA+r0xxHPI6Og==
X-Google-Smtp-Source: AGHT+IGqjhlBixDfrYQB++fjXq86nJmgMbfMAitlraUCi4e+/xLTzmItm9z8bGMRPgS0pNuK4gElIw==
X-Received: by 2002:a05:600c:1e19:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-4362aa52c65mr164849365e9.15.1734451208693; 
 Tue, 17 Dec 2024 08:00:08 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801ad9asm11390181f8f.58.2024.12.17.08.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 08:00:08 -0800 (PST)
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
Subject: [PATCH 5/5] initcall: remove initcall_run_list()
Date: Tue, 17 Dec 2024 16:59:36 +0100
Message-ID: <164daec366a7ad0e7c7a16b3d713fc1905a53125.1734448827.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734448827.git.jerome.forissier@linaro.org>
References: <cover.1734448827.git.jerome.forissier@linaro.org>
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
index 72faab42ada..c47a0410197 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -11,30 +11,6 @@
 
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
 		if (!ret) { \
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

