Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7602C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B3783145;
	Tue, 29 Jul 2025 18:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HuL/Bfbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DA182BA7; Tue, 29 Jul 2025 18:07:57 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA112831C6
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-455ecacfc32so24164615e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805274; x=1754410074; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=23HAJPyBds+rtMfQhMB/WrHviJeG+UDmSQc0z9DZ2i4=;
 b=HuL/Bfbuk/xF/nhQVISMivKRqrnBJ04x/NPityo/SyI8p7JJSu+7UpxayiO8i2U8Wc
 1413KV49ljjH8ohfwDX9almP0SdveYfZ1mHGec+yuE1mgiof84hUBJ6MMBlQy+RSATOm
 SF3Tc3YLgwXeJoiVYuG4cEzyL3MlHrie5r05iNS473oynItB5YDt9J+ASHqhsJ7Jiazo
 Mj+Nfe3KVeYWWtBPLVWh8XrpMpAeGO+mv1Lv8BIrnRryw6YeGyRolUq8NS8+LtNbJwy6
 B2/NfZuclviiEn93HtcexLo6BJxoAxPaAil9MOd890OWTs8BDWoTaNjMLA+uwG7fuBIP
 aKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805274; x=1754410074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23HAJPyBds+rtMfQhMB/WrHviJeG+UDmSQc0z9DZ2i4=;
 b=QeAQ1+cQR62rzmNZFYcAZkIo1fuFKsYrODDoIdrWFR7/BPjrxHCLsFOwq8cJBOffHd
 DH/L7Ja9vl7JCGzc0DfnImGEjTp5yhCTzIqeyFrG6yZcIzucbvUi8RJ/jRSHoxaLHTD4
 DnVrSpYxLeGWU68+QmuoZLTr7q42c3wWC/dklRsgDJM9yieObXiHCjn4XRF5N+QUe64o
 RgjgTaoEgKdGealrFzPepw1CeSzDdb/9BtJicivkAkLcnvc6ddx7YX+F/NTBUpTtcNkY
 DKhdTtSBMNeYTUpjrG2/nFhpcq788vq2j/8dYMowYuTKlJa+xK9ho9BCGwW9ejzi5mq7
 IibQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4rx13mycqdxidyJ1KdDYRe7ExDY2bAsqZw+OF26xPv8QGZVNnnedb/t25W3++XQPpYYYoww4=@lists.denx.de
X-Gm-Message-State: AOJu0YzhUXupbjL+V6ArfrdDia0EIm5+WxtU1mcs+kTpH6SEINB5EBqT
 Rt8AYpTmWFR0mKJQByfTg8foXd99UnKTH6iipLZhN7mO8sNfk8DPKU14vRqdc5a4JRI=
X-Gm-Gg: ASbGncs78WDhyX0UFAOS6JOhnZNFUEW3Z5dsAXEajpTY1zVdRk8RSRkIpnHJhydpckB
 AmLhPdxeFA5v8B/mniUF+DhIgdvdijM4XF/shrfUVUpDaTUhvOagnvDt9AQvf9QqsSTGMsrsRHZ
 6dBZnwXR2XgxqDIFl1GoAS/5li/2pjKiBxUy/Wo7m6uP+RbQVN+ncztpEpDfWy2Ff0KNQK2KYxp
 kk0cDm15OmelwiUo5+xqjYv5/zWbw2VH/JVQTEiMChSGX+rMVKD2P6UtilFbDovuzNpnphrNU5s
 O/OfdP/ew7tnl02h7d2JwTKwHs4TWH4weJUbjlSBzA8uQ9OHUS689wc+/vd2zNFJNr7Lo02TOkM
 xJfrm/Yqkgqm7Gw2czjqpIMXa51J/iIgsPLhf4n2hrXv++DTH6PqLyI9MGkvxzsWBtRuyT7yn6a
 eGzC20V09J9A==
X-Google-Smtp-Source: AGHT+IEIPXZBDcyc64Tr/w/bHPWJRf6JHXXzUHozaxCBzbo7CMhdl7DOnseP0ENKvcxtCEhxlmWuQQ==
X-Received: by 2002:a05:600c:3589:b0:455:bd8a:7e7 with SMTP id
 5b1f17b1804b1-45892b9d99emr3430855e9.9.1753805274235; 
 Tue, 29 Jul 2025 09:07:54 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:07:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:26 +0200
Subject: [PATCH v5 05/10] drop unused kallsyms support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-5-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=OTgQZ5nqFIFYUxbyy1RkWy1JphIwQqaXM69AdoLOqz8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHC+A9E3ZllmdwL4BCkuLquEsQWH3R3Qy5Zc
 KNKggaYtHaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwgAKCRAFgzErGV9k
 tvh3D/9ouX983PVyBusVOZ/hAtX1NDBUWLHmJTuEZmV7xXB2SpLSbYzSlxQZnPc8OJLl7CJVJwW
 sEQb2H+yPwZJhBT1ZvwXgoXuXmv9PfI/9fC9UJtfg/qN59NGc/sr0xNcir4i/nvJdqocQVTl+kL
 T2by++yTKRZrxKWw7MSsdshu5uk5Pl1J+RkvuRCJZfRrYkDLAAdTnIUvafTFogo/Ptnn56yuooV
 FGRDHutzloVmmxZKRLb1zzI7kDrnkb+BPT8dFXZ8bw/6mE2TOU1bhoUqN0CBi8/VeNkDR85Vv33
 1zNHMjSYZBHU1nydSTQZUVKfbSzV9tX7Qsjtqc2ho4vUaaKkqcEs+a0MZHNO1wtVVReCoKAfzbb
 18aaZ0xcQOl/3K8OdldVR3zZuiBwWww5fMz97BPxHks++Bh5xmNvlzjnQK3/eygqMk7Q84KMh84
 rv3/MoWyqRd3jbHg/SLRZhl3fAw0sd2xozSj7y7iPyBxp9bbbupN3tLNzqEm0E/mXATpNtRohv2
 ZYOncRxOZQYwGiM9iesdKgxb5TH7CJ3xOdskbJ6E3glt1EJxWJSimF918YtmZhNcTlj6wLfUj0j
 lqx6AJBTeB2mfR/5SgiRe/5b2kOBY6cLOfskbAkM24vzz38D2yCP2IOJ6n6ncUKNwX/+mi45x1y
 Lqk0QIId91w17cQ==
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

