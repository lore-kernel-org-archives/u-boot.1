Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2004C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DBF8399C;
	Fri, 25 Jul 2025 14:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S9FEguqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB458398D; Fri, 25 Jul 2025 14:57:33 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA3681E06
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so14461235e9.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448251; x=1754053051; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n3lA1ZE8XKkgsSFjISuatDjwKsL/5BQS/HnWGxtz+9c=;
 b=S9FEguqu16SyE3yjPdNzrK7XrT/JK0pPBvYp6rgUPTIIx7uQw9eJMAejLZc1CXB2b/
 G7VA33asySKioqqACwQMpiPc5xzH+oX7rA9xaa2PQ89hcFRtKQtqwb6K8NwS7TxRURTI
 O2u5SGrfsGvRKfk1qOgyF4FKeLz6bjNYdaV+V8qZ7e+2i6G/kEqMnRHbGpYe9cJRLbYh
 A/m4ubMT440qQEGVdsi6ivJmbuN4C6wHEXeq2EcprXbnpFwpRcQleVwNR48WLkeRKo+f
 BM6INcai+keQMNn2vBsTqxN5tPQ5uSGRJ0Pt4kQQdRBpH+d513M+EmkXtG6i+b/dKffl
 8OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448251; x=1754053051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3lA1ZE8XKkgsSFjISuatDjwKsL/5BQS/HnWGxtz+9c=;
 b=koY1NlCsDKBlVVG9SuBdulEKupQp3Q6LvKYXBF19x/U3BrGVXRS7iuWemPnAF4rvuF
 BQojBuJOj8wKQTN2WsRgqq2uVatKp2LX8yHBe/fkwEre5jnbpSTZxSRXdQQ/yudaXSJX
 G+07T5X261eqAAAmtEQArGJGTU/0P9BJjT6UwSKCwbqY2mYYxSIkAxq0S8sMLHrvR/61
 wqzNxKIi1DhMIVuJGkPqMMZNn8sia4Bt9KEmbw88HaiSNTwAdRDXq6YhIyYusEcewMbu
 VGu/GjUD7HpP1o/iKe4RG4jTbmFljwjc7ocx56vxtIb1j7ZG/iBcwvwVldTklTdetyWD
 lSqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1dqWxnzQmIfukqoxJQv77OrFYehkTVsSqiHB90LRKk6isFY/PIf1erstAK1jzVpqRvi5isS0=@lists.denx.de
X-Gm-Message-State: AOJu0YwN0X0wTgQCibP57MRKcNpNQ5AbGI1AnuoSxtFSX7O+5ubeOD4q
 CCl2biUF/JqAfiXU/hBOjX+4rw/OakTXdC5vUoy44DOKKTfi5w6yLFGBgmDg7USJBRs=
X-Gm-Gg: ASbGncsCpsOl+uKKhXyGCWxNPOafRMNMin9JRGw1exq+1oRXih45stpI9VUx1tFVhDp
 mC82e4dgBLEHcWCtjs9f7i561nl12hBrP/nbBNpi6dMchBmg3+j5lvzlzGDGKepmaHWgm+9YxaJ
 cjr473kgJ4hwZ7qv8AZEcua9mdhkij+Fbh62NqOyoBHavWCF+o+OtgT+RrfR/6U5/lz1oxCnv6z
 9d6FZALVBo9Fqpdr2Nq12WVXn5FhwlF0nYYs2qtiFdlYxJcQUqfHd6xuu8G4QsXlbvwBJVUKuIK
 g2h1JZQrwaw/sP135nIRfc3W+odwdZ83aJL0joLyR4HAIRvQX7jg8/r736kbSoyW8eDUJzVu8hx
 OuD+eT8rzuKqDL8nRUz3nXTzIRAUgC6zwSpHUVIwQNWdwAS0Vngm0UmmHFmgsV+OdVQ==
X-Google-Smtp-Source: AGHT+IGORiz/S00ptWT1HmdvRS3MxcQsqQ4SrSd4bHEEDxaAGNg7QuxoB1nGovDH3rBPnXBWGmuRIQ==
X-Received: by 2002:a05:600c:3510:b0:456:2698:d4d9 with SMTP id
 5b1f17b1804b1-458762fd2acmr18410675e9.3.1753448251205; 
 Fri, 25 Jul 2025 05:57:31 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:30 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 25 Jul 2025 14:57:07 +0200
Subject: [PATCH v2 3/7] drop unused kallsyms support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-3-230a9665085b@linaro.org>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3587;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=LnrjoQ/OspqKUGVD7pri3D6NVtQQrLP9A8kx2YaqUO8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmejPDyQvfSFafv6Weed3W0EOw3pgxUOfNX///9z/HS
 Wif8bvUUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbSEMzIMONLn++snM1Pps5b
 cuHo3pkF9TVvhcNOrfo+8+PZeayXFFYw/A9YE5qwrVM+QjBp1dZlXuGrNrMq+HX93XnvVnWGbMy
 D7DoA
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
index 6a0251373c42..57f95db81202 100644
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
index d62ea34599ed..a30b46fa28f3 100644
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
index 91594414099f..000000000000
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
2.50.1

