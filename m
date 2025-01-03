Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07243E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 11:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285588044A;
	Fri,  3 Jan 2025 12:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EVaRkp/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172EF80295; Fri,  3 Jan 2025 12:13:44 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE7B80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 12:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so137493525e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 03:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735902821; x=1736507621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+OcPxI2SSdquESZgqrciQ1/6QS8udlDuX8uSxv68oQ=;
 b=EVaRkp/KKh+qLCU7JY48Vd/Kd4kVu25yj2fP0zQjddzsXXHt/AAAyPDjBTxp7gR+Jq
 eoN15DelYihHB0RB2s9NLcWaBt4n7alpHdCjRaVlPt1tIg92zd+Mj/WqEndfVWO66ywy
 e09d+mmUQjmnrtopV5iRSqreJVeMp6HSZCrC7cpRAK3STOctrWq5GhTctdNnuPBKBGkk
 qgjKaErl9hdpurrBCuVc7GNPhAxKii/LnL1w27l+yYApBz4j3k0n57ixL6k+eD9+QNuQ
 14Gwxh72Yg7VPwDeMF+qsjgX56q+rls0gklkAcXT4OYsn15xTcWhd2NRGfV4PRX8e5Mx
 pbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735902821; x=1736507621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+OcPxI2SSdquESZgqrciQ1/6QS8udlDuX8uSxv68oQ=;
 b=aTQp6/rHPIEtVBOfFOCWJAFwvfpdxbSXX0v039wPkPtlRuMFOaqiOK/e6eJhXlz4rB
 Dxol7Hs4mwgWGoJySHci3SooDdLkQV/d+gOTO85A23ieJX1ooTeQm1gT7seci4mx6p45
 OjvC0JjQX85iMoGO/keO9bDJQ0YIaxaG18kUQsl23nqUcM5K/MyFHhFX/cXBxbG7dRQt
 FzdhElaeQr/oHb8+tfOII4a2xMAMHGtRc69aCUWNDXsBm8U9KsgQ5YPdxtg76AOOzB6L
 RlHwrBi7FzAjSLAdfuaj7f4jErJ/Mo38KxZh0UzLb7EwAyx5W2nqO0j2WV8z2VhJuvOH
 gp6w==
X-Gm-Message-State: AOJu0Yzt2vpG7stciFZoFPAUHT41M+nsNTHZuPJD+9dBQJxBFhrO/6Cx
 WMhpf8dDZ6vQqlhnHFbPKcbwpc21M9my/OtnbLPAlGo10vuwdakx/4ujHxy8rMJHyiSnQ9lY1fM
 AxRs=
X-Gm-Gg: ASbGncucpQbQfl/QjGxZ8t3QvplTMsE/xaBV6pC4VEM1zy99KaxFkhKLLxHQ8R1CLHo
 pwJ6rCLCLeAX4TjcYPv20NKBlpvaKf1yZcvRGYgH8WyHdliLEUUGTC+p1jr/QeTzUXF32QODnow
 hIauvs1q6TPy0MSOMA32AHNqDhzNn4hqxBuvuETFiPgnfiJO/IBAOGbNMNsbuDmNsyphLrbAHyW
 9rM5e+CeK74iI4Xr2dxjK2fSVh+MjusS09sivq/w6ERgbO1Qv8M2H9nqRU7OEBm/w==
X-Google-Smtp-Source: AGHT+IGu6F2ViuvAN27k9Y/FExXLnLg1bEYdZgU0+w4HJTACIDpJ0qJxAa+m0nPTruzZ1SWiXP4oYg==
X-Received: by 2002:a05:600c:1388:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-436686440abmr400101335e9.11.1735902820604; 
 Fri, 03 Jan 2025 03:13:40 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm513138075e9.0.2025.01.03.03.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 03:13:40 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 5/5] initcall: remove initcall_run_list()
Date: Fri,  3 Jan 2025 12:13:17 +0100
Message-ID: <ac96c110f35c718d66acce3295af7cb23586f46d.1735896540.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735896540.git.jerome.forissier@linaro.org>
References: <cover.1735896540.git.jerome.forissier@linaro.org>
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

