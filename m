Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C2C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 225EF83020;
	Tue, 29 Jul 2025 17:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mlK46xVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D988311B; Tue, 29 Jul 2025 17:50:32 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F4481E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-455b002833bso22055055e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804229; x=1754409029; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=23HAJPyBds+rtMfQhMB/WrHviJeG+UDmSQc0z9DZ2i4=;
 b=mlK46xVedWZ1HqLmPLWnDmhc78IiJrjDDsSwzNzN3A2NaOyedt76/dv+flAHRcCXgW
 Wo95wReuzU6l97UtjRaT80hpHEg51WkHQNKT0t043dN9YTdINxz8Yy0uJrcGIj350Jnj
 G93c26mX8u1JkPVPZaYnRlBTnoal97ZI/YeX7UKqgkQBuBExnxpj+L8glqViwCTQ9RIS
 wa5lC4puyHJBk97nQwGcWkHHkHmSIEkuT8gC3lTmRchg2q3tSQYQ8981rX/Z6Xbk2luE
 uap/Pplqpos5j1UhpbPzOXehoiEsCWSLozeSifVc+T99+9s5jV+R/HlMRPjLOBTtamJ4
 bULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804229; x=1754409029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23HAJPyBds+rtMfQhMB/WrHviJeG+UDmSQc0z9DZ2i4=;
 b=YjbQoCmHO1GIPtLWuBY1yBq9mf+BdUUEjRjit4k5kZVVIVouhm2NZwpSkAReCF0ehV
 pXwhaITTfcruUF6ayA4THizSh5gm7/qIWHVSoBc1KXkE9WLqNDL77VNW7uyzdrJQ7ITh
 fTto/8lCNZyrckBVxvFWHpY5vnZBn0IxRHfT8jj7QZrjbvvoAtWLUGtVm/8KFbT3kxkU
 Lm/1sumop494whuFNnnygr0O5Jix3eOeiUQmVFmfoyf6QpkFVs1kOwiBdjArEydxRDnW
 SngazZw3s3JgVb3AHgygUM5oldSOCs3BU5Qr/q+XbJsvyMHR/LbUmA6rlI/2WqnLdeor
 xBsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmRsvscaEuEJZ91i6hT+sG4fphlTQz9GUX8CUnj41gvhxdnT4ZC+UB20UwGt/OAPPZ3cHQ8Ww=@lists.denx.de
X-Gm-Message-State: AOJu0YzVmbEYCF9Lb1/NklwklmWdlZBoynaTn17hCSeyf/DaD3xhlkfc
 hLT/fkxcAhhRuUwcmw5c5QD7JhnfauSQzL5zp3bNqurJbz67DNRdaNtuo2Mg5tE/JMY=
X-Gm-Gg: ASbGncuvHcIaGjBvAOQJQkflh6E5mrkCxuxiNFer3o+1sGMgeRgNEDqeWxWzNJ9JZF4
 Bb33/2En9Y7PsB8Usks59INfOp0fuZxzNesM+T7/SLW659eRcWCbFP5M/KiBFDvIsUKvbK8Cosf
 8JaM5gyaVzass9M8XYvg1sRdjjYBT5odl9CCFLPnRsCqhi/AHbY8uHjQU1Tdp8fLNkfBWVsn0Xq
 qde6pbUMbf4viUhwpAINpAbYxRDPoeFtNjoJ6JfJiaG1h1uwyHNO6sz2c4u1eKSJT3McoQT4Uya
 6acoDZIUmw3uj9jXuPj8mUPtvdUeQMYT3uUknJ3CMk9T3ws4WVKEZoguftLSFWPdt5iXP6dtejk
 TsOyViGNC3AcVZfOw76ugWq1EyBKnvB96p55Hp9norP4XwLu+PMFCPqhqxv+vUX/N2Kuu4q4jK1
 iU7gNyJ2elYzCkZ0OQqkky
X-Google-Smtp-Source: AGHT+IF5iUtsMdbu0Y7RCwJD3ml++ghE5rhJMTaGFxs2HHZuK6c0oENIaLvZM4lbem943+V1lrYyVA==
X-Received: by 2002:a05:600c:3b95:b0:441:a715:664a with SMTP id
 5b1f17b1804b1-45892bc6b91mr2664085e9.20.1753804229312; 
 Tue, 29 Jul 2025 08:50:29 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:03 +0200
Subject: [PATCH v3 05/10] drop unused kallsyms support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-5-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2qtrcdyDjw+AGTk8pwg6QURzJSTyrRX4nya
 Z7cEfW1ziqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqgAKCRAFgzErGV9k
 tiw1EACj8IY0K6WzgHkNQwb+vw8i9L2YWuOoi/LopSGdEGLYSM+vTFFK4ikdImWwuo2CYjzSWvz
 0qp5t+6mZtn4paObdxptTSunhxPvtZKlI/+Y+sTYvaM/4hsXbW952u2a4GZPtE+th14Emuv60lw
 vtfHWLZH4MbUExAOihP1A67iHNZ8ozNW17tlH9EYWdsbiKJa+MSXK0oRFtY8eo7CNNw2nQPd758
 54WazA1qf+spas7uhl1KYrT4Xvlb0s3vBQGJfLOYTswHlKqU8TWHTG0e6dS65BdDCHowLEIENZO
 3K2DrtSfsf7INdGYYMpWNknLT+Sg4kQsjvQf/21zdmqZD5zg3R16+fm/8C2iHgu1/qCiVzHkHYm
 21sV759zTEa3dk6AzFfWq6ZAPRkwIPGvAnpfgdfjRCoh7SSRdUZ2AQ1pc1ZuVA59wydLWupdHTf
 f1WM1XgNTudwVrvNOVLL+x32dqUmRiVyeDLdckyskI02/64t3EOd/qvyoK6qAKlpqvhaQSygrzk
 2hjTTzXO4JCHoqnDYuw/Fsd3GXQa1z/GycFujGlN6jviEvYpg0xkppBwJZoa2TZuMwqs+S8InZU
 zJauw0zpfGjz4iHjHo4Kl5W5mJZjgo8zPl9EUeJA9rsnaECbDvRsyPmxCm58kW2y3cU6MNQCu8k
 CeLvSeSmJpR4kBQ==
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

