Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CC8C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682D688BAD;
	Thu,  8 Aug 2024 18:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FzHkte2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA03288BD1; Thu,  8 Aug 2024 18:21:31 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CFA88BBD
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f15dd0b489so14529381fa.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134088; x=1723738888; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wg4jRVbd7gY6hlKT6oDl/Hpvk5ZDWRpDHWHmszoBOm0=;
 b=FzHkte2lOrPaesciIfz/wUAihPdSbjbzDdVpUkL/SScQqBPJjZta5LJ1Jw3OoRm6p6
 R5f4g8kD8OdMkFpy3Keu6spc42bSrNEMUlnbjOtuRVXeMZfaEkVSuRG+W3K+DWaIzbbJ
 tYnKSHsANU5rZdf4sHF/dFU4T5hYoY1/dJ2zGzbPdNbfEf9SjxOpxaQ4EV0z+RlkCUDo
 qsrHywSVKyyHVvhCEdCB1WQncB/+/13Kjq6hKUHa450QnyXg3uLiyqXlg0RW/mvcgn/m
 EDmcWuhDu0PsTR588YFm+yrWJo07IOTs4EzfDq4UlfqGuzOn6qy2hIOT4qW5EzPrKiH9
 muEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134088; x=1723738888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wg4jRVbd7gY6hlKT6oDl/Hpvk5ZDWRpDHWHmszoBOm0=;
 b=ez3nBjpuzj08oINNfxhcHlmmzst7+XWoo2AP6VVcc9c8w0vl7T3+kQz0FMS9XVTuYY
 zakZPC/32vuhke6r5eKAxCPeYmepYIrrfmesxsh/uMWEQYUwYn7gqbPI7E9VSRwPZkt6
 gD6OKBA4iP57MzCbR3ERZjwnx5SgiML9vBl853pKVo+qj4ZMhfRX0tv1EqW6FaVssWXf
 WeDt2q7u9LeitbewXKF4DHg/lATCIW9xsbsKTIC1fl01F5RagBigFRrTzsIqs9Z0G/5D
 5RpUdkKv4dNuAopNhrjZwIorlvvcu1GhaeTVpSwLOj+TEYo819m5O9zfnvPNMpjz9non
 MPsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX+IzTGbe0QD/Wv9uPBS8TZmORhNjnmXzWkMq/5uoh2HrJ8gbrnWOxphKIc7YHb3G0ZclTU8k+J+0JUqnRv22uHkoZ0Q==
X-Gm-Message-State: AOJu0YzAiUeYNZt+mVDJel8HWxP+W1Y+t9zJlhCW51cyR1FKE2QiyB6Y
 7qIwOFdt0YogNhYGfDEMIIxQ1DnBbnPk6T76MbS0rrRMpGAqiPYANp0kuOII8F/xbspcfn1tsKR
 aj24=
X-Google-Smtp-Source: AGHT+IHlLVtAl53/vcRKhZmbk5v/U/oKRXis/2eJonXw6xemTazF+3u+tx2hrWv8ph3zJ6+9y9BZWQ==
X-Received: by 2002:a05:6512:3350:b0:530:ea60:7e07 with SMTP id
 2adb3069b0e04-530ea607f49mr174887e87.58.1723134087905; 
 Thu, 08 Aug 2024 09:21:27 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5d76dsm770396a12.80.2024.08.08.09.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:24 +0200
Subject: [PATCH v2 1/3] drop unused kallsyms support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-arm64-backtrace-v2-1-29665a2265cf@linaro.org>
References: <20240808-arm64-backtrace-v2-0-29665a2265cf@linaro.org>
In-Reply-To: <20240808-arm64-backtrace-v2-0-29665a2265cf@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3591;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=NO+PQveNYqHmlAO0iaQ7OWDTVqeT99W0zzS1ortQgtk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCF8YP+F9JuLYlyoVOVEFlY+xhOLodfx+MOP
 PxCe1Vy0YqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwhQAKCRAFgzErGV9k
 tm2ND/9dp157mQR51q0wfFGrf1LSHN0/U1zAWIYytYKmX0nuvyvaRILyd+S5fzmIiRoWr5aLMxi
 5PNcHBiAwpLfNW/jIOtd13dI6zyILA8tIYCi14NyoKFq+Rc37J5au5xqG1+kHgIiB5ZeuWeJQvO
 58IVexqYbViGdpP/kgzx5Hln/oMN2JS4W+PUQsk5F16GWgd6KSyWcn6AAQ7/90dgEGpQgrhkYU7
 Fz3Q388mHolAVoLE3MnttnmWgGXMdOk9ijCX5rtXI9hCi0QY28XhaRow/YcoMfz1k/V7uhKYiIZ
 Q8UZxTVZOGppgxzSqYTZjdljTkrtFSfyUnwCqxAPICLa75SaV9rp1c4qtgRgPszeWaywEjUgbpP
 HQKWLZ1YNY3nIDtGQjallo9hcAwdrBTDJotL1sJeceb6dKLf+neceALe2LBgzOCkIE5BaZ9941p
 v2mcjQzeYQbWkvgDn5Z+0pfKZxIWv9lxaJTUUW2C8kh762F6LRjkEkvWB3BPMof1/2GCqIjCfFB
 iS3OPlC8y3Y0j3SdrJv/HKjiTDLcQPqNdD7R7Tgtfo5g/+pzhIzec085Y+Rw70dVKsIOsJ4JTIH
 a8rqh2aFwYl/0Ms/2wTfeR/5VwdjkteWBlHV81Dnf/8DnXjynPsAT925t+9ET1HN9btxB5X+Hop
 w64km1IfV4qCg7A==
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

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
2.46.0

