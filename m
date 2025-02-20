Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B53CC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB06F80F91;
	Thu, 20 Feb 2025 22:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NAo6AjJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D580580F5C; Thu, 20 Feb 2025 14:55:53 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7059A8001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dd9b3419cso512398f8f.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059751; x=1740664551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFo02FrkhIKmKk+dIhsgUH/KahGMd8Gr637V7DagyXo=;
 b=NAo6AjJv2X4mPIphLERqyCjvT0ClKOkZzJsW57B7Fg/lmlWuJiQKBVsAjOMGWg5XZp
 Cuzdo9jZpVOJDMM5bj9i+rn2036u28i2oYQx8Fv069LBhLZRMV2A9MLXqccB5zkTFZWR
 D8nAzxgPuQgIVCiFspRBW8sLC03mIoY5nTQGzsdS2UgmzK/l/YS85JBiCSHfOPQDQauX
 TUJB0Og/4+hj9v185DKF2WXjpM+TW6dQ7NPetD6iAwzuKWekdUkbz4jiw1w9TtDHQZe4
 pDg8PrN3o+9BAG3mFvqHQzbwgUn1uViXc+9voxTsrOxborrMr+SDWFHbOSZ5j31lwk+v
 WY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059751; x=1740664551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFo02FrkhIKmKk+dIhsgUH/KahGMd8Gr637V7DagyXo=;
 b=GwnSQ7BB4i8bU8xh8Pip4WL7YkydKz+1Z5duxa1vmtzi9HlZyaWqoFY39i2TEK+lhH
 zePFSOt6a20BWh15PXq9h9uOipF1DJq10koqVTQFuSN/fjsqGew3DGl5m0+SFe+Yxd7C
 8yel1SEInoLKpSfc8olA8hUZSxcns8pDKUZL1v+bFsPkLZQhXbUoxMpKEmytrd9FcVEP
 Nv1F431Qp2aquQlGYGGrBUzfM3IG1PM8xCJe+lKsgtHff/G/jYkKx1H5JznuOkUfrI+B
 ZAYBhFM2IM/wUucB1ORZYgwjydRxx2lzpaa0Aymsllok1ATDPEhGGnV/ctk1tkJkb68C
 W1ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlM+XDpYegcycOZuOUEAxtCW+U9HPMvdTCmNUUl9T4tgi3tsAh81jKc9RjGt3XPvyNc3Wml4s=@lists.denx.de
X-Gm-Message-State: AOJu0YxaewrjFTrt2EedYgp6y//arnrgbp4bLkQz3ICvyJ9txLNkSPhr
 NQJzpXOBonFwpBWoEnHo49D83fpqtGDfeSDLot+3mgHr+5k/ybT4QQVFsarLtic=
X-Gm-Gg: ASbGncv/z3PgTXSkHkwsQUuhwrZeG2cD/b/oj9EYp7bWQeufNbYuak98f8uTYI63lRb
 4zIr+xfaTnGzOfOpedQ93YBjYU1jf1rFDVuZwIE7J/lXnYJI39PzZGlfnlSoS8/5PcY0w9uxr5N
 uTQick4r/jzalFROrKXzuKQfjTv5jilp7u9OeLlfgE/HfK8O2iieQfdXMBk3dNaVwzBd8AJR7n9
 8L2F46HhPOxnL/XsKjjfQHjKG89JRTH0bY6uFkoqlZoELDrZV2FxpM7GwjoVpe7KUv9IkMUdOoe
 iscu5inmSnn2tgIYSgs9SNKlTwMqyd4eqkTO604SKdK1GzHRpKoenQ5UIw0pAwZMX4MCzg==
X-Google-Smtp-Source: AGHT+IEs2YLjlfQ0qZuonIKkvAkuvCIGKRQi46emKRLIXQYikGSDFJc2obWa+L7TrHPnTYXuLLb/EA==
X-Received: by 2002:a05:6000:1885:b0:38f:579f:de15 with SMTP id
 ffacd0b85a97d-38f650e2555mr2219514f8f.14.1740059750719; 
 Thu, 20 Feb 2025 05:55:50 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987088ecbsm111659865e9.31.2025.02.20.05.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:55:50 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marc Zyngier <maz@kernel.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 3/6] arm: Prepare linker scripts for memory permissions
Date: Thu, 20 Feb 2025 15:54:40 +0200
Message-ID: <20250220135506.151894-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

