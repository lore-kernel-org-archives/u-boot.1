Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC8AC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E3F811B3;
	Sun,  2 Mar 2025 13:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mknH8YN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23DAD81111; Sat,  1 Mar 2025 17:50:06 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D94810F6
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e4ce6e3b8cso4135368a12.1
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740847802; x=1741452602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qSeBQm8rIiofeh7plKeu/pk/Zyacx6XzEy5fwctVGo=;
 b=mknH8YN3fX/phRXTi12biSqFTrW0gRKQ+VDc8lQMX20KJ+m/D5hlw+wYQo2+jc+lXR
 D8xZBjMCCMvlJUU3e7m8unlOzq9Fnv39YLKXiqDtDZEFMf3oVhjB5cKJMbNLfMDQSCut
 E8Wk7s2YbEMYvccVUbac2ph4Kzmi+700BfZMqPXwXjdH8rE+bpMBGfr0DBtG7oi/oIYb
 BfTjlja2GLZuc1ONrA4/oxN629aW7GsA4clHbw4dyiOmiwV4i7d+HBO2g1HJtVSNRY35
 vbb1wtL7fw0sLZoOJQto7CbeodUfyOITGYLCUJOq4VGtTsjA1GeLZfHOgad0EsDLNP3I
 Gfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740847802; x=1741452602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qSeBQm8rIiofeh7plKeu/pk/Zyacx6XzEy5fwctVGo=;
 b=tDpBvH9HvgGyRsaMQJ23a2YNj/qPtAE29Y4hWmaZRuFfjVk95M9q1iGIL3g/D5kepD
 hpFRlru/y6AOVZjosVUdm9Xxsj3L5/4UdaD8bJsxiG5H9l/JZ5nYJQ+L5GXlB2ot4/0G
 Emjfp8m4H0ushlHhylvQNFmVDcfoYtwG5TVwtHm//HF9s6edAm5Q66mPyaAp1/vZxBX0
 miQrmupikLDPRuHQXH1AdZOZye8wN4qu7wda5oUrUpISx5kdwccL35cf731O6o6MXJ4t
 2jAiXrcVkyyYCBmfDbJG38xK2h7GUXLnjbU31Pp/4r6V9wmcfWHOjh1JJjdXoX1PhBe0
 KYFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhA34i/r9O2o1TsZtDsU+QTK9L4VaxKFD411pT1S4TiTjzFX8LUaYHSBgVDDCiDfN7o4pfKRM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6plio0ZmRWDM4Hk3GUy6FE+rp2Rw24+FzMBBqBZm1K4RehfYs
 3BaZikcYiAlGpFg6WzJ74F3vT0SXHC340z7pj6pmyc3pd6k1hGkfM3uhz2oK/Ss=
X-Gm-Gg: ASbGncsIr15tFRTJLPh8iXZxLMBsuEfgDlPrgsFYPHMpvbDclSWghlLuz9f4+2gak8u
 pRVp2yXbtJzdaH7borTRiFu/NnnkbYsrcSK9zBD3fPQfhoXqXAkrBPTwqeihBOO2nPLRAajssz4
 I7bUnJV6SrRmlFIPxgqFH9bNX/aEz6qHfsK9ed8WB51673iPiIGU/cauRxq3AbkFUzboRpBRdCP
 FjEqJkIc7n/uXBRflGcxgShXT7H54fkZjUGxot7Cq7ysWjip9QYhCyK7/w+qJCbFl5CI1zv5aqD
 V04PVLyMAZmir8bOOWU/U8j+3Bb4cDB8sGhQ+9GjcR2zki1UANL91QdG9n/D5zRr9UNeYwtIoQX
 GCayvBI4rCf6osI+m7SWfMIQ=
X-Google-Smtp-Source: AGHT+IFPOi+Oubi2UgBZefaSHEYdJ309uhrmk45xxUzrbuyihvb6lj1s07v4wbgJ1vHWIxpgXhkflQ==
X-Received: by 2002:a05:6402:1e91:b0:5dc:eb2:570d with SMTP id
 4fb4d7f45d1cf-5e4d52ac8b1mr9819986a12.2.1740847802125; 
 Sat, 01 Mar 2025 08:50:02 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb5927sm4257231a12.53.2025.03.01.08.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 08:50:01 -0800 (PST)
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
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v4 3/6] arm: Prepare linker scripts for memory permissions
Date: Sat,  1 Mar 2025 18:49:01 +0200
Message-ID: <20250301164922.397441-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Mar 2025 13:40:23 +0100
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

