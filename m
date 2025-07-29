Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F23C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C91D829E7;
	Tue, 29 Jul 2025 17:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CL9kWgZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED8B81E14; Tue, 29 Jul 2025 17:52:39 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76358319A
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4560d176f97so59613485e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804357; x=1754409157; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=23HAJPyBds+rtMfQhMB/WrHviJeG+UDmSQc0z9DZ2i4=;
 b=CL9kWgZsi2CdzRxMqtZKB4wfbUXOQv/DIbSR2ciH+1EX+LQDhXSYBdVTdenu/kmV5b
 +lLCioSWqQIvc5ZrLva5cWACnkegYEoG6XXGQHKkWC3MF7Fu+a07dM2hJs9OtSux9ytC
 4q2cBfD4f+bKeh6IUj/aCfVLPgydxxjCxwKwTUINXYINJrEVeuT6hHYA7hijDBuS0feE
 VyNd3GPpcanfKqd/OoiWoCki5hqpD7i9tCh62dwihyYe0UlcbUzKd2eQtAi5rcrbiW0v
 0z34PE8/qLgxf7z7NNHtpp7QzCC5LD629wznKrmLmY1NWCIMz28ybCg/hDayMWIQbPE9
 3w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804357; x=1754409157;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23HAJPyBds+rtMfQhMB/WrHviJeG+UDmSQc0z9DZ2i4=;
 b=mJheGsG4Sn/hJsChfRe6ogtahx7OTfa6ByLGOBXl+SSTJN0qpN4v+mb0YylOKtJeZI
 oJHnMZP6NxD0M/GG67hoGDN/d8kWcwaw1Uk/atwED8+0hSkGtSecX8nNRRHJ0yQYIWrj
 U+Wq1iyupFBCLcif5zxTpStqYudxMM2AIi19SvYvsyx6MObPvAUZ1hW1MqO/D72wFfTI
 F0DGL/sZkk00A8A1zJmLXYdS73appY3NHiYphceNSimi6hKOYADXnOZRQh8vaS6w4DpE
 nwopJP99el22tXEwMz6x1DxyazfFLBIT936m3BiEcud5InRAutXMrnRw37e/VEiaAGmt
 jfmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV427Ax8TgJbA7W/fOc69wK1l/+4HCnrBLySUH9uGX6Kjq4mGYsrREmY8saKkPNCt8/v2W6wXk=@lists.denx.de
X-Gm-Message-State: AOJu0Yya8wSEEqgv4G8sr5vx76ZGQ8iuGG4Js54shNVJ/zG0cLzf7Y9A
 D1+mzWWxcleyOjk4QjeHUEEjcoaK8rr2l6mXqaPqsJxMoDsKk7sbbd/4o1tPhJhcfYgz04bdhTe
 dCCeS
X-Gm-Gg: ASbGncu4DfTDXWf0MlNQwEKPKt3zlyzSW8WrhETmUcQex/4M+pU8yuQA0ImGfZh676w
 Xggyc8M72tQ3TM9GukOMqAKO1ojEsR4xNqx1XyIcEddrSoxKO1TaFnaUmn0lr7FhARwr0VHdenw
 77m2Lv15pDpSxi7zubuNF7VeRr3FPHpAwYY04K1yzkZSem7ZJPAP0DzT1Sq2J2qM1bnoLHahaQD
 +EsAH9fJfVkvZKzdmvOFnnagyQfo85tsF9HoMY3tgcTAsEQ69aD8iXdd2SvH7dHZG14vJIJ6HaD
 YQbNwT0tRWEndsw6gazhtAwWtBPTm4qzZIzBKnBznnRAsAFGMrM/AIwi04/Mlnh8y//rfSy8Qrm
 JqiUSdhlKoX8tYo1ZM+ClWX+GO8quDZexjpR7R9H0T9VuArKQdIS8ospMwrOwwrAg0NiuK+R/PL
 n5kES/eaAwsmVAgTzp2A1r
X-Google-Smtp-Source: AGHT+IFtZIQ3iJoIMoV0jpoWAG5WOVA+zrptTAtNU50DzEYnqmek/pJgoGfHuZ8qP796pjv/xHLQlw==
X-Received: by 2002:a05:600c:1c2a:b0:455:f59e:fd79 with SMTP id
 5b1f17b1804b1-45892b9d991mr2519235e9.11.1753804356942; 
 Tue, 29 Jul 2025 08:52:36 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:36 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:03 +0200
Subject: [PATCH v4 05/10] drop unused kallsyms support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-5-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=OTgQZ5nqFIFYUxbyy1RkWy1JphIwQqaXM69AdoLOqz8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4k5dvCzHmqLkwLU55CIjnhOy0Kop1fEpjEr
 VPV6RRsYzGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuJAAKCRAFgzErGV9k
 tmn+D/9Moh46wbPzKdys4Owyk43k7JKrsZK6Uv2Ju48GpeVvrIhVyssBq5rv8opemGx0272yA1L
 Pvue2+mC8JfzlpyW1bOpmtofY+kGMFL4rL6eG/bXerpCShwrp5YhhrIQ5aftvjMS26LJkRYe7WO
 aR4IREpIcUY+KOoJ/zR5c4HwtDjUyqX5qSAxm8YjbzbO1s5Jm0cD2y+fAQEctxFWVQ35DAFvSFw
 2NJdtwlXTELYTKadTJ6Rc+L3dZEebXTXRBZi2Q5taNSLOFJAyQECrFkO0Q8Ir95p2t+6kLhRBRj
 R4a/q1rPFYd4hrBxATC4j4LL9JmlZE5llOG+QVgNR+Z3inkrlCYnI3AxB3V4uIOWQNKhGT6lm4G
 ecGlxlRylQdX4DpI4NZRk0zq/a4bbFraLxTX/5WvY6V7Lxd30o0d5d/bKJlQHr5IINhccUpiEP1
 4qTWONFWIDKmNBnQ2HIo89tGm3ZZ9Xqh39Owjsis14KfDY0tW/o1qXsTYgzTE+c2VVTOJFnE9/z
 ySmZDVpil0h1GNk1pEyN9rY982d3bfMDL3Xiquv4mkAEWmm9sQm9fYvlLqQ0J+CTCEjLqV7C7IQ
 lHMOTHH5phr2frmGh3NHIFY4yiAAuEsRNIfv0QOR9+iR3gAVIbRndw/Hm/utnmYpHDAWoC/8Psp
 VNUWddzkxCq4B9w==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Makefile            | 11 -----------
 common/Makefile     |  1 -
 common/kallsyms.c   | 42 ------------------------------------------
 common/system_map.c |  8 --------
 4 files changed, 62 deletions(-)

diff --git a/Makefile b/Makefile
index c31bf7ecea976ba8f40f84cd6f03c666ebda0fee..3d557b301b0517935f1afe4ece87119df314c0c7 100644
--- a/Makefile
+++ b/Makefile
@@ -2018,21 +2018,10 @@ quiet_cmd_u-boot__ ?= LD      $@
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
index d62ea34599edfe07b29e819160fbb7e65aae1780..a30b46fa28f380c7ad79a2f12ea4bf5f391c606f 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -41,9 +41,8 @@ obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
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
index 91594414099fcb82fd1afc56283d8bb198ee3df5..0000000000000000000000000000000000000000
--- a/common/kallsyms.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Helper functions for working with the builtin symbol table
- *
- * Copyright (c) 2008-2009 Analog Devices Inc.
- * Licensed under the GPL-2 or later.
- */
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
index 8307293bf3ae660d6c5589a844d556f94d256b9e..0000000000000000000000000000000000000000
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
2.50.0

