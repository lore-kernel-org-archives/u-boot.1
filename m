Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5407C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32848081E;
	Wed,  5 Feb 2025 14:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="khl/pd3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43067805D7; Wed,  5 Feb 2025 08:17:45 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9A380207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so1002361466b.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 23:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738739863; x=1739344663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUGPK86DWi9+WCYvLPgrYc5wTB8ycSj3VW2D0BfVeDA=;
 b=khl/pd3igjFLyTCIhwqtPV4ScGWKq7I0Brnfo93lklfVo8PpogD6l5vWnbGARPCCLu
 gpKUtzT4SbMxFohiXo/JoXXFnUFDbGyzUeEEZqNCINyf43eouDTDZqxeVb0TVSURmbg2
 X1r4Y9KmqxLmMTNe/FogE7K3LhSsHEsuhY5QULsbtAZ1PoGXS5HbS1EpjkRhO0oLSRJ0
 OchALk7zEyGlT6An8RAma+99zX+55GSYq0bgO8BpIaYvBxtWPxMTRN5L7WqIfr6P4pHb
 sIppQ+k/jgAFzKdlwQ5QCfwRfGO1AYFlxt9XUKdwEcTeT2WG10/9f547UIMHkTr9q25P
 QJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739863; x=1739344663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUGPK86DWi9+WCYvLPgrYc5wTB8ycSj3VW2D0BfVeDA=;
 b=JNRJUGoMgbFO5wPDF0bSUytveQZxLl1o9Q9fcQIMu9d/BYZ3xZooRSysfRMhG3boNx
 F+32Fi6tkLBW7j0EzhJmT7CNmNT81VZk7ZdVYZOApllO3TF2+44+XYaqzstBOnkBebCO
 zWenu08eWDe+5y2gfeg6gwV+JxgfH2bLMNWOmDjx7AoNiEvT4p54w77+n28U4J5PKLmO
 ym9sdRIX50ZB1rWx7ZZ+m6ykczxjwXWgjWSVNtoRfpYHEUyRwfAmdMVoll9NhfU5wy9u
 M6vpRGneXjnNpkUaaqMwJ8sdL+fhks+TFLzDaveJ8jk6fnuzi6QAo/VwDvUyhcCgRFo/
 i1SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT7z4zKGBsaNPO19iPdzbmut6faaY7E0xv9SE1Sf39YIZW9bo+IjFy7cuob/AR6o+Z2Drv/Uk=@lists.denx.de
X-Gm-Message-State: AOJu0YypN5e0ysHycA9G9FpHI198m/KGxB+PBbjFNATKaItXo5czobo6
 tRxZ+5X9EJcLUgwqhf2tAvhZc/qWGn7+TR9IWNNqX9hsGIXiOlsu+dfE2zXHId4=
X-Gm-Gg: ASbGncti6OhEokNzUtRsvQZYH4cA6a+OFHkomrc037u3L2Ycb4ksgBZ6a6ETqaiUVeG
 oAZSNSftNnFoXGnNXnzGCxFamxHEUhwZm1vczEeS+IPc+lnhx8zDhnwnbpAwoRRiFCu/FY37V78
 EIRaZ9NIaMxVJIf7QCXuTClnwJiLx2JTdB2xKIMEvUESThjmb+ppz7sOKc2afLBrQAz5PbwJSqT
 CW6ktiQSCSjdulo1+xM4resXmTDyjYSZrshf362t3Dkqjj4otMQGtQ4SF15a4j+6KJUim9ArxNh
 /o/KMz9bvvJAkTydxMmObaLDuYtvSilS5oysRBvugv62B+mK65By/5Kgv8OV06RENf5D
X-Google-Smtp-Source: AGHT+IE5D8ZQdN1IhU9dfiISo7Bmxg2QtADSSYROeJmFtqmY4J0Aw6pIfXSqJXroji9rEeU+QMAO5g==
X-Received: by 2002:a17:906:f593:b0:aaf:c27e:12e8 with SMTP id
 a640c23a62f3a-ab75e35dbc2mr190125066b.37.1738739862549; 
 Tue, 04 Feb 2025 23:17:42 -0800 (PST)
Received: from localhost.localdomain (ppp176092167070.access.hol.gr.
 [176.92.167.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcda28cbcesm1107191a12.43.2025.02.04.23.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 23:17:42 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
Date: Wed,  5 Feb 2025 09:16:47 +0200
Message-ID: <20250205071714.635518-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

It's worth noting that efi_runtime relocations are left untouched for
now. The efi runtime regions can be relocated by the OS when the latter
is calling SetVirtualAddressMap. Which means we have to configure the
pages as RX for U-Boot but convert them to RWX just before
ExitBootServices. It also needs extra code in efi_tuntime relocation
code since R_AARCH64_NONE are emitted as well if we page align the
section. Keep it out for now and we can fix it in future patches.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds  | 29 +++++++++++++++++------------
 include/asm-generic/sections.h |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 857f44412e07..35afc3cbe7ec 100644
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
@@ -98,18 +101,20 @@ SECTIONS
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
@@ -136,10 +141,10 @@ SECTIONS
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

