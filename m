Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492F9C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFBA881120;
	Thu, 27 Feb 2025 13:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vz3RmQBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51F7810EA; Thu, 27 Feb 2025 13:15:47 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EC1801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abb7f539c35so158230066b.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658545; x=1741263345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qSeBQm8rIiofeh7plKeu/pk/Zyacx6XzEy5fwctVGo=;
 b=Vz3RmQBYTILp8QCodnkZCARKpp2BzjCMAridH7xaWiO4X9fZ2sTJuxtfzvgsEXYN+H
 ic8pYB8SYmx34x3oin9kufKuRNybxcXbbgfdom+Q4iSgcrSjALyKASydqRxIi99HG16X
 jJa3u93gczFfmJ1jZNr4j1gfamztcAiMQ9bU9wecXQVomnVwqa4ZZd2bDzJh6pydZaUb
 h4MPQFTFvrOxEyxKeaFMKFbZziPq3p/7V/nCq9GEWNrL3lFQwqIKmNmAGrjeptadim/Y
 EkTbCbYBB41CQvjETdBk6OfmEkz3/R73PLQQzw3648IwUjstM6lCgz1fPhGLsHS/tZSA
 kBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658545; x=1741263345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qSeBQm8rIiofeh7plKeu/pk/Zyacx6XzEy5fwctVGo=;
 b=lSPmGaAJJuR/gGXhcYVR+/Z2FHch3oxui5pQOEKT3Did4F2+PVzHazYchFLmt0e113
 /R/0r9iRetbIy6khmy315HymH6xHn4Z1ZJPzoxZU4QEPzXNAglPTvsz7y/JLFt+LXFHD
 1T6CqWjIzWCh7i3aoQYDv6YeZ2hPT1iEiOPXITxkwITSYCFMUa5FSLcrc8il4tLo231X
 JGZG4zohgPmIZaJYfruWlA51fd3Lt3B9+7zYS3GKyi7OzVgWkTDWe4kwaT/VJxAb5Ivh
 yvlR33cSLqFxbV1MtFpUv+vgBw4Vz83hScW+ySoWUFtit+SfokZHuZRelREAUhW71/Pu
 PhmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhydjJpMJ8bycYz4u81e9/xyi637ah2OtvVdX0tviIhTC5cG9p5Nih9Jyi2ayqaFCyQJmuxuM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0iW8NHx1oYEw8cKut9JLtaChxeMNB2bB9r1K+4PX8LDJOr4qa
 sl5bwhm75a8HW22dq+UsS2fB/nlIuSx5H4kkr6VBrcKJwhrCn0cJDQjGFomJc78=
X-Gm-Gg: ASbGncteL6yHanPBzMOkx1YRXHfiP3oaowf01qRd6tlqLgbe3w6Af4tyburJ8XRitMB
 jlKRcULDe9zIw1BX14/2ZpGM39i+JxKRXD6ng8y2F3QJqw9rzfpuBbnrzO5aDfQU2lQNREqwRFC
 c9dSokKV5R2OKwBL35Tro5TsLdz7d5/3a4IwO4IxQ8/brjc4E0riUs4NZJ31kiNbtCna6hZl86r
 YNbl3kP0UoqiAPqkjYhmQ7aE5XnNQL3mXfgqutOT54Dx77PslftQipd5t3D53KRLKteiZWTRDdg
 wr+zXw9oUhuj63eoF3Rv/KIaa6N+mFXqzCtd5/+WhDKnZdiEOToeh0mjkYqeLgbtEwZB2EbmnHR
 yOga/
X-Google-Smtp-Source: AGHT+IHmuZ7tbMK8YcRlWZTQPniCgvYlHo+3eAGVas0mJShtI26VxomfuZPpwiEtS5gILqswOwx1Rg==
X-Received: by 2002:a17:906:31c6:b0:aba:7a3a:e267 with SMTP id
 a640c23a62f3a-abed101d92fmr1207034366b.45.1740658545038; 
 Thu, 27 Feb 2025 04:15:45 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc168sm114736566b.70.2025.02.27.04.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:15:44 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v3 3/6] arm: Prepare linker scripts for memory permissions
Date: Thu, 27 Feb 2025 14:14:53 +0200
Message-ID: <20250227121515.232996-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
References: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Feb 2025 13:56:54 +0100
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

Upcoming patches are switching the memory mappings to RW, RO, RX
after the U-Boot binary and its data are relocated. Add
annotations in the linker scripts to and mark text, data, rodata
sections and align them to a page boundary.

It's worth noting that .efi_runtime memory permissions are left
untouched for now. There's two problems with EFI currently.

The first problem is that we bundle data, rodata and text in a single
.efi_runtime section which also must be close to .text for now.
As a result we also dont change the permissions for anything contained
in CPUDIR/start.o. In order to fix that we have to decoule .text_rest,
.text and .efi_runtime and have the runtime services on their own
section with proper memory permission annotations (efi_rodata etc).

The efi runtime regions (.efi_runtime_rel) can be relocated by the OS when
the latter is calling SetVirtualAddressMap. Which means we have to
configure those pages as RX for U-Boot but convert them to RWX just before
ExitBootServices. It also needs extra code in efi_tuntime relocation
code since R_AARCH64_NONE are emitted as well if we page align the
section.

Due to the above ignore EFI for now and fix it later once we have the
rest in place.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905X-CC
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds  | 59 +++++++++++++++++++++++-----------
 include/asm-generic/sections.h |  2 ++
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 857f44412e07..f4ce98c82c8d 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -36,9 +36,18 @@ SECTIONS
                 __efi_runtime_stop = .;
 	}
 
+#ifdef CONFIG_MMU_PGPROT
+	.text_rest ALIGN(CONSTANT(COMMONPAGESIZE)) :
+#else
 	.text_rest :
+#endif
 	{
+		__text_start = .;
 		*(.text*)
+#ifdef CONFIG_MMU_PGPROT
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+#endif
+		__text_end = .;
 	}
 
 #ifdef CONFIG_ARMV8_PSCI
@@ -97,35 +106,43 @@ SECTIONS
 		LONG(0x1d1071c);	/* Must output something to reset LMA */
 	}
 #endif
-
-	. = ALIGN(8);
-	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
-
-	. = ALIGN(8);
-	.data : {
-		*(.data*)
+	.efi_runtime_rel : {
+                __efi_runtime_rel_start = .;
+		*(.rel*.efi_runtime)
+		*(.rel*.efi_runtime.*)
+                __efi_runtime_rel_stop = .;
 	}
 
-	. = ALIGN(8);
-
-	. = .;
+#ifdef CONFIG_MMU_PGPROT
+	.rodata ALIGN(CONSTANT(COMMONPAGESIZE)): {
+#else
+	.rodata ALIGN(8) : {
+#endif
+		__start_rodata = .;
+		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
+	}
 
-	. = ALIGN(8);
-	__u_boot_list : {
+	__u_boot_list ALIGN(8) : {
 		KEEP(*(SORT(__u_boot_list*)));
+#ifdef CONFIG_MMU_PGPROT
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+#endif
+		__end_rodata = .;
 	}
 
-	.efi_runtime_rel : {
-                __efi_runtime_rel_start = .;
-		*(.rel*.efi_runtime)
-		*(.rel*.efi_runtime.*)
-                __efi_runtime_rel_stop = .;
+#ifdef CONFIG_MMU_PGPROT
+	.data ALIGN(CONSTANT(COMMONPAGESIZE)) : {
+#else
+	.data ALIGN(8) : {
+#endif
+	    __start_data = .;
+		*(.data*)
 	}
 
 	. = ALIGN(8);
 	__image_copy_end = .;
 
-	.rela.dyn : {
+	.rela.dyn ALIGN(8) : {
 		__rel_dyn_start = .;
 		*(.rela*)
 		__rel_dyn_end = .;
@@ -136,11 +153,15 @@ SECTIONS
 	/*
 	 * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
 	 */
-	.bss ALIGN(8) : {
+	.bss ADDR(.rela.dyn) (OVERLAY) : {
 		__bss_start = .;
 		*(.bss*)
 		. = ALIGN(8);
 		__bss_end = .;
+#ifdef CONFIG_MMU_PGPROT
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+#endif
+		__end_data = .;
 	}
 
 	/DISCARD/ : { *(.dynsym) }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 3fd5c772a1af..024b1adde270 100644
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
-- 
2.47.2

