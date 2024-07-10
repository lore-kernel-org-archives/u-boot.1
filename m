Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8018C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 16:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490158870E;
	Wed, 10 Jul 2024 18:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NgAJ8daF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F8888667; Wed, 10 Jul 2024 18:26:44 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7468870D
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 18:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so1585085a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720628801; x=1721233601; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tCOuvDDk+/2qYoBr5g7+3ZZ7+LGborA8FZuZagzAWz4=;
 b=NgAJ8daFgjw5h3/+WphGSxJyetnIgZFV9QBHhyklWwWn55VkY8xVJj9yjJsqoWzab3
 OKsGTNgY71e36QjCZ5v5xcVk/ANkhetlfJlR2Sv4e6ynKw3dp1f7M4O16j4t0WzyHdrG
 rkcL1HPrmKbzV9dmDllGZms6OA9dtTpg5DM1GJ8KwZxkh0Af06Zt9unb/r9usk9BsLBM
 51/x034O23Rk0wp1T1wg70j4RFc71A3kPWD3098FM1Ir2Oe4chUvwUDqmXiDm7t5bgot
 rGhwwMyjF9pJ7mXty3TbNJDQ+Y8MTVUQ5yBWMCBnrnrO+rkUWZn7wbXr28KUbGgNLvm8
 BRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720628801; x=1721233601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tCOuvDDk+/2qYoBr5g7+3ZZ7+LGborA8FZuZagzAWz4=;
 b=n2JkDYCfTriCXgAgP+eWlt1o+VTiohYDJqNcSIRGr9rN/5ma6scKbtfYw1FGbVMgIE
 JciV2UabVbUEPZftmnWz5MAYHtsxIqrsvNnpbT3aug9wJ+YRxq8Mbmg1bpU86L4D1iVm
 HB/JdG6Qy0m4xR+uaCByEvme1ZTyDOLtWqCADlzKMJt+qe8v3djUCw/DRkGkXqFwY/ZE
 NSd9lZgF+jS3/b090DA6R0QKEpxECKUdIoMcLHsdE9klYLfRF6jNKf7dJsHA/gJ/zBTn
 eVmmr8iL4RKceB983ySD19wy4RrpeBbIK2cJon2v1B+NxGVEZfgMTUA+qmUMX/3iOqpD
 /k6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk9qah/Q6VvDSlONYEqyjO+br8u+rm4QL8bIWGxVEapoxZjMDW9lTQPcioSDOq7Xlve63IzUVezm1ItsEKe9BF8eicVA==
X-Gm-Message-State: AOJu0Yx06sISyPpM9E0CCKjwUSSTONDSoZTxoLPpqMbwZEM2O7qQU9qC
 T9UZ6+ttQA8ziYJ8ZpIe/op3ibjq79JTvC7Spegjc6n6hnIephnUcNS8CDdjgG/maMIoEL+Lddw
 i
X-Google-Smtp-Source: AGHT+IGrhpapRFoKqK9us8jetdnmFqW3CJsBnZeNPyTyDVZQiLCUQMOXFs0CbcdzQLH9MIlKLSCpeQ==
X-Received: by 2002:a05:6402:36c:b0:57d:3df:ba2d with SMTP id
 4fb4d7f45d1cf-5980c7008f9mr120336a12.2.1720628800861; 
 Wed, 10 Jul 2024 09:26:40 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bc4e8255sm2370348a12.48.2024.07.10.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 09:26:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Jul 2024 18:26:18 +0200
Subject: [PATCH RFC 1/3] drop unused kallsyms support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-arm64-backtrace-v1-1-5a2ba50485dd@linaro.org>
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
In-Reply-To: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3486;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7sQNs2gsAgpiFUG0cfslbQxYurbkJY6XdcDzqrU6UAk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjrY+6rN5J51kFQksdBLKc27p24oLPFkz5jpq9
 UO5iR26cAKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo62PgAKCRAFgzErGV9k
 tnG4D/9ZkvrzUNXRALf5SQGqFPNJy5pIZ3Mka/6nDFAzXINaI1pmtpKflpWWxkYSCUlq5tTik7Q
 82QIQAZYSEwCG6256G3+RomNS1j1xUQ/7HYeh61NYN38hYmN4O1GhSCRyp85uQ1DgtUuUttFCRr
 cPoPZxy/s/e0PtMNI74ZITIJDdkK6ij2DAAH+rRQH23yZi5MU1APVBxAxOvS8a9TbFko7vj3G5V
 fspWJs2Svvw+ErpWlwirT++HVdoaYhHVLfQsBDh5dOHb4sMQzYOdcn1B2K8gtIYuEBjs9qcMdBj
 17JgNMSFsEpp0oI3s4rbNdde0N4mEHqfyrfF2n1KTbRZWPpFz6GSEIpd8PJvp2Ya2/8JvV5B19Y
 bpa1LQShYp4SLtV4gGeY1ocB8mLcvWOi4vEyMZ1hIo7AK7m/oJ9uEatSRKC2+9N7+WaMxZPqbQd
 A2NPjUpRvJaAr1/sH9em1i16DOvjdzJB83/G+WMPllhLnG+yLXLTGeDvH9ujEtMZRtT2XMSCOpj
 cRPX6dzczJHiK9jbYFvdk99GvkSeeAgRmZGUGuVCqynDNycSTG8vmv6/8WjwZappGsOdwv9du2V
 w6zlXvAretLwv1kw3mZdUQVQBJDGbgrWwYIdE2h8JLHemEX3L72vubL6wonLQY/KtqahcgARFo9
 m19l3EPyhzmbDBA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

There was some very old code floating around for decoding symbols, it's
incomplete and is never built. Remove it so we can add a new
implementation.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 Makefile            | 11 -----------
 common/Makefile     |  1 -
 common/kallsyms.c   | 43 -------------------------------------------
 common/system_map.c |  8 --------
 4 files changed, 63 deletions(-)

diff --git a/Makefile b/Makefile
index f5b2512f3690..fcb9565d2fff 100644
--- a/Makefile
+++ b/Makefile
@@ -1786,21 +1786,10 @@ quiet_cmd_u-boot__ ?= LD      $@
 		$(PLATFORM_LIBS) -Map u-boot.map;				\
 		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 endif
 
-quiet_cmd_smap = GEN     common/system_map.o
-cmd_smap = \
-	smap=`$(call SYSTEM_MAP,u-boot) | \
-		awk '$$2 ~ /[tTwW]/ {printf $$1 $$3 "\\\\000"}'` ; \
-	$(CC) $(c_flags) -DSYSTEM_MAP="\"$${smap}\"" \
-		-c $(srctree)/common/system_map.c -o common/system_map.o
-
 u-boot:	$(u-boot-init) $(u-boot-main) $(u-boot-keep-syms-lto) u-boot.lds FORCE
 	+$(call if_changed,u-boot__)
-ifeq ($(CONFIG_KALLSYMS),y)
-	$(call cmd,smap)
-	$(call cmd,u-boot__) common/system_map.o
-endif
 
 ifeq ($(CONFIG_RISCV),y)
 	@tools/prelink-riscv $@
 endif
diff --git a/common/Makefile b/common/Makefile
index e98354734206..bca02e4c362f 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -34,9 +34,8 @@ obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
 obj-$(CONFIG_CONSOLE_MUX) += iomux.o
 obj-$(CONFIG_MTD_NOR_FLASH) += flash.o
 obj-$(CONFIG_CMD_KGDB) += kgdb.o kgdb_stubs.o
 obj-$(CONFIG_I2C_EDID) += edid.o
-obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-y += splash.o
 obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
 obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
diff --git a/common/kallsyms.c b/common/kallsyms.c
deleted file mode 100644
index 49b3897078ae..000000000000
--- a/common/kallsyms.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Helper functions for working with the builtin symbol table
- *
- * Copyright (c) 2008-2009 Analog Devices Inc.
- * Licensed under the GPL-2 or later.
- */
-
-
-/* We need the weak marking as this symbol is provided specially */
-extern const char system_map[] __attribute__((weak));
-
-/* Given an address, return a pointer to the symbol name and store
- * the base address in caddr.  So if the symbol map had an entry:
- *		03fb9b7c_spi_cs_deactivate
- * Then the following call:
- *		unsigned long base;
- *		const char *sym = symbol_lookup(0x03fb9b80, &base);
- * Would end up setting the variables like so:
- *		base = 0x03fb9b7c;
- *		sym = "_spi_cs_deactivate";
- */
-const char *symbol_lookup(unsigned long addr, unsigned long *caddr)
-{
-	const char *sym, *csym;
-	char *esym;
-	unsigned long sym_addr;
-
-	sym = system_map;
-	csym = NULL;
-	*caddr = 0;
-
-	while (*sym) {
-		sym_addr = hextoul(sym, &esym);
-		sym = esym;
-		if (sym_addr > addr)
-			break;
-		*caddr = sym_addr;
-		csym = sym;
-		sym += strlen(sym) + 1;
-	}
-
-	return csym;
-}
diff --git a/common/system_map.c b/common/system_map.c
deleted file mode 100644
index 8307293bf3ae..000000000000
--- a/common/system_map.c
+++ /dev/null
@@ -1,8 +0,0 @@
-/*
- * The builtin symbol table for use with kallsyms
- *
- * Copyright (c) 2008-2009 Analog Devices Inc.
- * Licensed under the GPL-2 or later.
- */
-
-const char const system_map[] = SYSTEM_MAP;

-- 
2.45.2

