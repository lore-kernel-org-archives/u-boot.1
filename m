Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE25C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 07:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192AA811CA;
	Thu, 30 Jan 2025 08:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SJNNSPB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3AB81FEE; Thu, 30 Jan 2025 08:21:25 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C8381250
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso2661545e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738221683; x=1738826483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gAXk5khHCJHZMkLiO2G7OIe/TkpJcjCDBqHXbwPC9U=;
 b=SJNNSPB2oUwAkt0BLACsVTT0MSCKlgzl8mczLsFNk2bOf37b6ALsAX8nFyEA5h5kHt
 3PLWtfuRSkddpOyp1cZEWB2ud2dilWI5vdt1gybofliAPwQvadeSNEjSSusnROy4sm/q
 tLzfSXkTUwnuAE894WZtY2HyiYFrLjU97ySlqwwZ/I6hgrwDzPZxZnpuCAUbXSuvRXDe
 dtTqBRZhDB0i2cdukAFWjtxFfu6lUfPX54a9NiGl1QlENY8M5WIhu31F6kCICjnWPDJ8
 7JIQvd2AGDYPXLsMQzuR3gYo9BFZoI2uh3tjWG+NyiQDq4Lh7KYi5f6rSUrG8frDe4UH
 ZXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738221683; x=1738826483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gAXk5khHCJHZMkLiO2G7OIe/TkpJcjCDBqHXbwPC9U=;
 b=it6chH88Ssetuk0wO/kN75Fmcy2h9izIKHrfja1GnoeMGOpA0JFdnFgooqpYraS9Av
 bQmDbtma6qhb+YOS+paAM3/KJIDUIF+UBsA+qlKvC+SHrymcrYfzwxqnTYm2Und0TVq0
 OzJXwLOZEdWv95L9/3NyiugV/vaxjXHqPYMtz1n5R2PxAUNiQOyDEb+n+zlvf2tRf5O8
 nR/phT3VAT7uxw2wL3HCwba4hUtQf5gkcqKRaPmuOFZpfoXnKUtkPxTyshAAIH6tDJLj
 93XQ8GyAlvTY1d0bmpNHJ58GBpzaL6kG05bmoDiBOYD/ZWGkrDENAKIywzaTd020gRd5
 /yTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVddbNk48bSLwsWgMFsXTz9y16zCzDqNkIw682FtftSEHBjDbvj+Mp6L9nEUDADRbAcUZrV/Ys=@lists.denx.de
X-Gm-Message-State: AOJu0YwPY6XbTeoGdBIbk2IBFAteedGVzjvIrOqzIiSbnSRF/lReSjQm
 fFU4sCfzLLmCqZlkFrbDGeSP1pg/KdnstnTJ9dGaD/2i6jOxGYezFZfZbO++FO8=
X-Gm-Gg: ASbGnctYBUUnp7SqXwwyBprXBrGY4Of1gjzeG9xKv+B0zmRqbBlQRs+SetuRb1GQ3WR
 oWngkjV43T6bgleXY+SIbj1AeWAqGZsj3kSSvIQ+JhRrE9SITxlYv6i6QyrRr2Nipr5xaqRt6mp
 YH2ziw7uAE21rSFqYfVeJwoixNh6mgoyDKv8WcD1V8idJSB41eZzAbZkvppKEAnfyE02f55hfg/
 p9vWvoDQ2NtLS3Q0+kERpY3glPqlnjUgAamkZ6O5wtf/gWV1CXj1zXJ8W9xDA8qkpMj3zp+h+dA
 OnYPbXjyvsFTqirj2CQoUAwWv56wAoO9Eg3ETd5obtAud6N0rg==
X-Google-Smtp-Source: AGHT+IE+j+9LRXHP6TrBMYDeSFfcu8k6vtjapU9qcJqNLpIbGsldgxum/OLMv8OU1h7TKu/mve90bQ==
X-Received: by 2002:a05:600c:5023:b0:436:5fc9:309d with SMTP id
 5b1f17b1804b1-438dc4346eemr54236165e9.30.1738221682823; 
 Wed, 29 Jan 2025 23:21:22 -0800 (PST)
Received: from hades.. (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df2asm48076345e9.29.2025.01.29.23.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 23:21:22 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: maz@kernel.org,
	trini@konsulko.com,
	CFSworks@gmail.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [RFC PATCH 2/4] arm: Prepare linker scripts for memory permissions
Date: Thu, 30 Jan 2025 09:20:27 +0200
Message-ID: <20250130072100.27297-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
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

Upcoming patches are switching the memory mappings to RW, RO, RW^X page
permissions after the U-Boot binary and its data are relocated. Add
annotations in the linker scripts to and mark text, data, rodata etc
sections and align them to a page boundary

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile                       | 15 +++++++++------
 arch/arm/cpu/armv8/u-boot.lds  | 32 +++++++++++++++++++-------------
 include/asm-generic/sections.h |  2 ++
 lib/efi_loader/efi_runtime.c   |  2 ++
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 33bb86343c5b..8d7c062ec830 100644
--- a/Makefile
+++ b/Makefile
@@ -2176,13 +2176,16 @@ System.map:	u-boot
 # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
 # R_AARCH64_RELATIVE (64-bit).
 checkarmreloc: u-boot
-	@RELOC="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
+	@RELOCS="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
 		grep R_A | sort -u`"; \
-	if test "$$RELOC" != "R_ARM_RELATIVE" -a \
-		 "$$RELOC" != "R_AARCH64_RELATIVE"; then \
-		echo "$< contains unexpected relocations: $$RELOC"; \
-		false; \
-	fi
+	for reloc in $$RELOCS; do \
+		if [ "$$reloc" != "R_ARM_RELATIVE" -a \
+		     "$$reloc" != "R_AARCH64_RELATIVE" -a \
+		"$$reloc" != "R_AARCH64_NONE" ]; then \
+			echo "$< contains unexpected relocations: $$reloc"; \
+			false; \
+		fi; \
+	done
 
 tools/version.h: include/version.h
 	$(Q)mkdir -p $(dir $@)
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 857f44412e07..18e168e27135 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -22,7 +22,7 @@ SECTIONS
 
 	. = ALIGN(8);
 	__image_copy_start = ADDR(.text);
-	.text :
+	.text ALIGN(4096):
 	{
 		CPUDIR/start.o (.text*)
 	}
@@ -36,9 +36,12 @@ SECTIONS
                 __efi_runtime_stop = .;
 	}
 
-	.text_rest :
+	.text_rest ALIGN(4096) :
 	{
+		__text_start = .;
 		*(.text*)
+		. = ALIGN(4096);
+		__text_end = .;
 	}
 
 #ifdef CONFIG_ARMV8_PSCI
@@ -98,27 +101,30 @@ SECTIONS
 	}
 #endif
 
-	. = ALIGN(8);
-	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
+	.rodata ALIGN(4096): {
+	    __start_rodata = .;
+	    *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
+	    . = ALIGN(4096);
+	    __end_rodata = .;
+	}
 
-	. = ALIGN(8);
-	.data : {
+	.data ALIGN(4096) : {
+	    __start_data = .;
 		*(.data*)
+	    . = ALIGN(4096);
+	    __end_data = .;
 	}
 
-	. = ALIGN(8);
-
-	. = .;
-
 	. = ALIGN(8);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	.efi_runtime_rel : {
+	.efi_runtime_rel ALIGN(4096) : {
                 __efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
+		. = ALIGN(4096);
                 __efi_runtime_rel_stop = .;
 	}
 
@@ -136,10 +142,10 @@ SECTIONS
 	/*
 	 * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
 	 */
-	.bss ALIGN(8) : {
+	.bss ALIGN(4096) : {
 		__bss_start = .;
 		*(.bss*)
-		. = ALIGN(8);
+		. = ALIGN(4096);
 		__bss_end = .;
 	}
 
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index b6bca53db10d..5626df796f33 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -23,6 +23,7 @@ extern char __kprobes_text_start[], __kprobes_text_end[];
 extern char __entry_text_start[], __entry_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __start_rodata[], __end_rodata[];
+extern char __start_data[], __end_data[];
 extern char __efi_helloworld_begin[];
 extern char __efi_helloworld_end[];
 extern char __efi_var_file_begin[];
@@ -63,6 +64,7 @@ static inline int arch_is_kernel_data(unsigned long addr)
 
 /* Start of U-Boot text region */
 extern char __text_start[];
+extern char __text_end[];
 
 /* This marks the text region which must be relocated */
 extern char __image_copy_start[], __image_copy_end[];
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 35eb6a777665..c10a79301a92 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -742,6 +742,8 @@ void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map)
 		      rel->info, *p, rel->offset);
 
 		switch (rel->info & R_MASK) {
+		case 0:
+			break;
 		case R_RELATIVE:
 #ifdef IS_RELA
 		newaddr = rel->addend + offset - CONFIG_TEXT_BASE;
-- 
2.43.0

