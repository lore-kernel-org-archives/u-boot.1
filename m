Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1645CCCA46D
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD4DE80965;
	Fri, 16 Oct 2026 06:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FqS8zXWtiFvk; Fri, 16 Oct 2026 06:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2681C808C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133922;
	b=taxn19BWldhXqntZmHhI/+AGYDm/QoSkAbNNPcO2mZNWIARyrkdcQ7OA3RTKfE+PmqWY
	 g3TiUZ5A8213+22oXV/eAloCuz0G1jFmXJPz4fGDXi83t90Tu09wTWqEmVxhDD4socUgr
	 s2Lgk4V59liVrYqETuBwT1stagpK4cX9KfMOdAcunvsHtUR73RhMwjB5ouFZw9Y8Nu3dH
	 TjCnBxhEtEBBoN6+r3n5JjcfnAJ480W8kvuJDApwmPGNl1+7Z0iqma794LjxcfYzXBcfd
	 ZkZ+gXOY5vi2mlzuwqigKngGCXxgO+MGMAW5p26/RAhOqearLdC032lZ0ZagyfF5CBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q5c3Hfz1jx8SD8RyhWGmu4/dFycD3rJLV8rPFhrRq+s=;
	b=Gxzq++srD/VRd6rE2gaadpsQzXwXVDCr/enUIzGOJwd/msioBLDR0ZpHmbm2Zzl3ycqA
	 SGgmd5osLwfeeiz7xiMK5/tseIyQw6V72Df3SByNP9ncYdDyGearJKz+l5AxnpCoBXx5r
	 Ur3J+fhzFwpf8n04zp+YWy/9L8SSHU8tF+EuFVl3rxBdj+Wr0h4QlpZ8vVg0tCeo9pBnm
	 8hikpytvF3OBlRR/QNW92rGPysueNas38xUak3lBkKMgflGLxMSTefJ69MLu/leKRWe5o
	 xzfXd/jgBzCT01meBOGmHTgvl0r1CjSlmf515nnng5ITh4r6mLE/qcHWEZkc9HmZmSw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133922;
	bh=q5c3Hfz1jx8SD8RyhWGmu4/dFycD3rJLV8rPFhrRq+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0LBTYq4EHsEdxpuSz+wattdNZ4gRr9UBD8p7Q6bi0wKkNcTAsRj7e2ahgeSSoCpfG
	 T0CVXhAqwNC9uXLMEkmgUxW8ZE7gpuyL1G5unNPYUS2YJcBzi6jX3iu+RYIy985EBW
	 NkqXOrInkX7t7wQk8h8hPEBo2sZtYPM+ZbSMeQf48/bddZWokbXiP00T93OtnamyTw
	 oCYRSjuMi+JiBjbONEeTYpJILahGdxkInzcMzxY+UNbRQ8iHUaRXJ0hRWjYGsBAsvz
	 8ZQjPZETn1CPDk9ABZKpHSbwgdaW6wpY3TWxGAbborO1mOxx+d2LH22PR/p0yOkcZt
	 BxJ2Op8liZZSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2681C808C0;
	Fri, 16 Oct 2026 06:58:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A581F1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 979DC4009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 337MF8d643V1 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E00A40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133917;
 b=VyaBIp2xLfKE+Xpg8iwNyRCAGDD2mGJBvaWevhjIERV+4ys5Ng6TZiHudRAUhVXsrY/T
 IJZWRjiqGgywH/B2deW/E/PqiG8NUKObAR/Ve03GDxNKhdnwMT34IqIaOgg+bOMykhmTZ
 E6ApxDqvkF0vPp/Tim5rdooD7zEjGzxG+IV6Qd5ykw18rz0dovVRsVrPZ5amcWHzbGEMC
 vpJlsoWSI7OQjwhoPyEcPvS0xIC+t34O8JYkF9Kw6sc3IDRRM4TKpiZHBUbe14AIhxjzi
 LX6drl3zh/8dE0CoalVtavaRjVVr096YfstgZwajioMRIo6qHRq/K8YRaeHeGMPKsCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133917;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=q5c3Hfz1jx8SD8RyhWGmu4/dFycD3rJLV8rPFhrRq+s=;
 b=dIMsDJ0IOEifkPGjWb5s5uYDXWqSnCRgIWYQ8WgtymkeyGBRJfA911zZwg+MWKDD6DKx
 SSDJvnE1qT8co5yNisC4FQduPDPHZx2kHbnaWx3qrkbHasZ8dQq9rBmSvkirhiogZExLR
 TFqj9WvVRUa330ZJRmF4XbXjr9GuTjHstkumAPafb5s9orP6dxDcacBX5gRWkXlzRRmc9
 kHiI6LZ+2AQnboudaMgMf2PedekekRzDtGqtAdbdBx7OwMdamfvhyx+0F6TdbhOgwgV+j
 I1q4s10Xi/sByWoA7g4gCtQgS1UxnY33j9D1CMmlxgVDTI77znQ/v/yXlfHjpKAGWlw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=pnVR+U04; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=pnVR+U04
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E00A40050
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133911; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DK73GeXdaxeptXvCrL79xGO9X5qsMGtwW+HOsE3w1FCXSu5dG8CUilpUY/IOci7F+kutvcQ6j4CrHU5f8InWBnyTg1clsGPeeZPaOiWz4nmVpu5shTlntELf4sPoSEMi55nnx2OTAcoDoVAO+A9i7SK5y53SB05910l3dke0fsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133911;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=q5c3Hfz1jx8SD8RyhWGmu4/dFycD3rJLV8rPFhrRq+s=; 
 b=hpO/hsPJH/t4KAQUaDNZG1Vs4cNAnAzCW1jB/v8olfduVt6ZW9M2JOXfnN2sfVOXC5GnHvk0hdv5ctHeieSGL1cKmj+ekn45zyCLQXpGCIMp+sQqunAsDqtytQI5iPsgkfMeMmui/BUuIZpJF6xfm8alZiQJYmZcFw9C/7Xf0MI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133911; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=q5c3Hfz1jx8SD8RyhWGmu4/dFycD3rJLV8rPFhrRq+s=;
 b=pnVR+U04tQpdfS7Srg1iVyCiw5e5uOLFQpE3wK5bEuyKPnOMhgI1WicoUR+xTp6m
 XKrYFJ+JVoaVmzWNmukxvEc1UZ/3hBDu2no1geGzaS9keghcr3hedTqzUrScth99+N9
 VYQjKnrPIIU4O+EfOKr0ijsa7A3gIF0vygXmGqt4=
Received: by smtp.zohomail.com with SMTPS id 1792133909808953.6773810372385;
 Thu, 15 Oct 2026 23:58:29 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 17/20] efi: LoongArch: Implement everything
Date: Fri, 16 Oct 2026 06:54:57 +0000
Message-ID: <20261016065500.137544-18-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement crt, relocator, linker scripts, and handling of PE relocation
IMAGE_REL_BASED_LOONGARCH64_MARK_LA. Wire things up in Makefiles and
Kconfig. The relocator originates gnu-efi project.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

No changes since v4

Changed from v3
- Read addend from Rela entry when processing relative relocations in
  reloc_loongarch_efi.c
  - This has been submitted to gnu-efi upstream[1]

Changed from v2
- Mention IMAGE_REL_BASED_LOONGARCH64_MARK_LA handling in the commit
  message, explain the instruction sequence in comments
- Mention the origin of reloc_loongarch_efi.c
- Fix typo in copyright of crt0_loongarch_efi.S
- Clean up whitespaces in crt0_loongarch_efi.S
- Fix SPDX identifier for reloc_loongarch_efi.c
- Drop the meaningless branch for DT_PLTGOT in reloc_loongarch_efi.c

Changed from v1
- Replace obsolete macro __loongarch64 with __loongarch__ and
  __loongarch_grlen
- Support relocation of IMAGE_REL_BASED_LOONGARCH64_MARK_LA

[1]: https://github.com/ncroxon/gnu-efi/pull/109
---
 arch/loongarch/config.mk                 |   4 +
 arch/loongarch/lib/Makefile              |  12 ++
 arch/loongarch/lib/crt0_loongarch_efi.S  | 182 +++++++++++++++++++++++
 arch/loongarch/lib/elf_loongarch_efi.lds |  76 ++++++++++
 arch/loongarch/lib/reloc_loongarch_efi.c | 102 +++++++++++++
 lib/efi_loader/Kconfig                   |   2 +-
 lib/efi_loader/efi_helper.c              |   3 +
 lib/efi_loader/efi_image_loader.c        |  31 ++++
 8 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/lib/crt0_loongarch_efi.S
 create mode 100644 arch/loongarch/lib/elf_loongarch_efi.lds
 create mode 100644 arch/loongarch/lib/reloc_loongarch_efi.c

diff --git a/arch/loongarch/config.mk b/arch/loongarch/config.mk
index 7c247400e361..bae4566e9b62 100644
--- a/arch/loongarch/config.mk
+++ b/arch/loongarch/config.mk
@@ -21,3 +21,7 @@ endif
 PLATFORM_CPPFLAGS	+= -fpic
 PLATFORM_RELFLAGS	+= -fno-common -ffunction-sections -fdata-sections
 LDFLAGS_u-boot		+= --gc-sections -static -pie
+
+EFI_LDS				:= elf_loongarch_efi.lds
+EFI_CRT0			:= crt0_loongarch_efi.o
+EFI_RELOC			:= reloc_loongarch_efi.o
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 9eb9662066a5..3dc264aa9b42 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -12,3 +12,15 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
 obj-y	+= reset.o
 endif
 obj-y	+= setjmp.o
+
+# For building EFI apps
+CFLAGS_NON_EFI := -fstack-protector-strong
+CFLAGS_$(EFI_CRT0) := $(CFLAGS_EFI)
+CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
+
+CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
+CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
+
+extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
+extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
+extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/lib/crt0_loongarch_efi.S
new file mode 100644
index 000000000000..605ac58bc865
--- /dev/null
+++ b/arch/loongarch/lib/crt0_loongarch_efi.S
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * crt0-efi-loongarch.S - PE/COFF header for LoongArch EFI applications
+ *
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm-generic/pe.h>
+#include <asm/asm.h>
+
+#if __loongarch_grlen == 64
+#define PE_MACHINE	IMAGE_FILE_MACHINE_LOONGARCH64
+#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR64_MAGIC
+#define IMG_CHARACTERISTICS \
+	(IMAGE_FILE_EXECUTABLE_IMAGE | \
+	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
+	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
+	 IMAGE_FILE_LARGE_ADDRESS_AWARE | \
+	 IMAGE_FILE_DEBUG_STRIPPED)
+#else
+#define PE_MACHINE	IMAGE_FILE_MACHINE_LOONGARCH32
+#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR32_MAGIC
+#define IMG_CHARACTERISTICS \
+	(IMAGE_FILE_EXECUTABLE_IMAGE | \
+	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
+	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
+	 IMAGE_FILE_DEBUG_STRIPPED)
+#endif
+
+	.section	.text.head
+
+	/*
+	 * Magic "MZ" signature for PE/COFF
+	 */
+	.globl	ImageBase
+ImageBase:
+	.short	IMAGE_DOS_SIGNATURE		/* 'MZ' */
+	.skip	58
+	.long	pe_header - ImageBase		/* Offset to the PE header */
+pe_header:
+	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
+coff_header:
+	.short	PE_MACHINE			/* LoongArch 64/32-bit */
+	.short	3				/* nr_sections */
+	.long	0				/* TimeDateStamp */
+	.long	0				/* PointerToSymbolTable */
+	.long	0				/* NumberOfSymbols */
+	.short	section_table - optional_header	/* SizeOfOptionalHeader */
+	.short	IMG_CHARACTERISTICS		/* Characteristics */
+optional_header:
+	.short	PE_MAGIC			/* PE32(+) format */
+	.byte	0x02				/* MajorLinkerVersion */
+	.byte	0x14				/* MinorLinkerVersion */
+	.long	_edata - _start			/* SizeOfCode */
+	.long	0				/* SizeOfInitializedData */
+	.long	0				/* SizeOfUninitializedData */
+	.long	_start - ImageBase		/* AddressOfEntryPoint */
+	.long	_start - ImageBase		/* BaseOfCode */
+#if __loongarch_grlen != 64
+	.long	0				/* BaseOfData */
+#endif
+
+extra_header_fields:
+	LONG	0
+	.long	0x200				/* SectionAlignment */
+	.long	0x200				/* FileAlignment */
+	.short	0				/* MajorOperatingSystemVersion */
+	.short	0				/* MinorOperatingSystemVersion */
+	.short	1				/* MajorImageVersion */
+	.short	0				/* MinorImageVersion */
+	.short	0				/* MajorSubsystemVersion */
+	.short	0				/* MinorSubsystemVersion */
+	.long	0				/* Win32VersionValue */
+
+	.long	_edata - ImageBase		/* SizeOfImage */
+
+	/*
+	 * Everything before the kernel image is considered part of the header
+	 */
+	.long	_start - ImageBase		/* SizeOfHeaders */
+	.long	0				/* CheckSum */
+	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
+#if CONFIG_VENDOR_EFI
+	.short	0				/* DllCharacteristics */
+#else
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
+#endif
+	LONG	0				/* SizeOfStackReserve */
+	LONG	0				/* SizeOfStackCommit */
+	LONG	0				/* SizeOfHeapReserve */
+	LONG	0				/* SizeOfHeapCommit */
+
+	.long	0				/* LoaderFlags */
+	.long	0x6				/* NumberOfRvaAndSizes */
+
+	.quad	0				/* ExportTable */
+	.quad	0				/* ImportTable */
+	.quad	0				/* ResourceTable */
+	.quad	0				/* ExceptionTable */
+	.quad	0				/* CertificationTable */
+	.quad	0				/* BaseRelocationTable */
+
+	/* Section table */
+section_table:
+
+	/*
+	 * The EFI application loader requires a relocation section
+	 * because EFI applications must be relocatable.  This is a
+	 * dummy section as far as we are concerned.
+	 */
+	.ascii	".reloc"
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	0
+	.long	0
+	.long	0			/* SizeOfRawData */
+	.long	0			/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	.long	0x42100040		/* Characteristics (section flags) */
+
+
+	.ascii	".text"
+	.byte	0
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	_etext - _start		/* VirtualSize */
+	.long	_start - ImageBase	/* VirtualAddress */
+	.long	_etext - _start		/* SizeOfRawData */
+	.long	_start - ImageBase	/* PointerToRawData */
+	.long	0			/* PointerToRelocations (0 for executables) */
+	.long	0			/* PointerToLineNumbers (0 for executables) */
+	.short	0			/* NumberOfRelocations  (0 for executables) */
+	.short	0			/* NumberOfLineNumbers  (0 for executables) */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_MEM_EXECUTE | \
+		 IMAGE_SCN_CNT_CODE)
+
+	.ascii	".data"
+	.byte	0
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	_edata - _data		/* VirtualSize */
+	.long	_data - ImageBase	/* VirtualAddress */
+	.long	_edata - _data		/* SizeOfRawData */
+	.long	_data - ImageBase	/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_WRITE | \
+		 IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_CNT_INITIALIZED_DATA)
+
+	.align		12
+	.globl	_start
+	.type	_start, @function
+_start:
+	PTR_ADDI	sp, sp, -(3 * LONGSIZE)
+	LONG_S		ra, sp, 0
+	LONG_S		a0, sp, (1 * LONGSIZE)
+	LONG_S		a1, sp, (2 * LONGSIZE)
+
+	move		a2, a0		/* a2: ImageHandle */
+	move		a3, a1		/* a3: SystemTable */
+	la.local	a0, ImageBase	/* a0: ImageBase */
+	la.local	a1, _DYNAMIC	/* a1: DynamicSection */
+	bl 	  	_relocate
+	bnez		a0, 0f
+
+	LONG_L		a0, sp, (1 * LONGSIZE)
+	LONG_L		a1, sp, (2 * LONGSIZE)
+	bl		efi_main
+
+0:	LONG_L		ra, sp, 0
+	PTR_ADDI	sp, sp, (3 * LONGSIZE)
+	jr		ra
+	.end	_start
diff --git a/arch/loongarch/lib/elf_loongarch_efi.lds b/arch/loongarch/lib/elf_loongarch_efi.lds
new file mode 100644
index 000000000000..050e5a52a0b3
--- /dev/null
+++ b/arch/loongarch/lib/elf_loongarch_efi.lds
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * U-Boot LoongArch
+ *
+ * Modified from arch/riscv/lib/elf_riscv64_efi.lds
+ */
+
+OUTPUT_ARCH(loongarch)
+
+PHDRS
+{
+	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
+}
+
+ENTRY(_start)
+SECTIONS
+{
+	.text 0x0 : {
+		_text = .;
+		*(.text.head)
+		*(.text)
+		*(.text.*)
+		*(.gnu.linkonce.t.*)
+		*(.srodata)
+		*(.rodata*)
+		. = ALIGN(16);
+		*(.dynamic);
+		. = ALIGN(512);
+	}
+	.rela.dyn : { *(.rela.dyn) }
+	.rela.plt : { *(.rela.plt) }
+	.rela.got : { *(.rela.got) }
+	.rela.data : { *(.rela.data) *(.rela.data*) }
+	_etext = .;
+	_text_size = . - _text;
+	. = ALIGN(4096);
+	.data : {
+		_data = .;
+		*(.sdata)
+		*(.data)
+		*(.data1)
+		*(.data.*)
+		*(.got.plt)
+		*(.got)
+
+		/*
+		 * The EFI loader doesn't seem to like a .bss section, so we
+		 * stick it all into .data:
+		 */
+		. = ALIGN(16);
+		_bss = .;
+		*(.sbss)
+		*(.scommon)
+		*(.dynbss)
+		*(.bss)
+		*(.bss.*)
+		*(COMMON)
+		. = ALIGN(512);
+		_bss_end = .;
+		_edata = .;
+	} :data
+	_data_size = _edata - _data;
+
+	. = ALIGN(4096);
+	.dynsym   : { *(.dynsym) }
+	. = ALIGN(4096);
+	.dynstr   : { *(.dynstr) }
+	. = ALIGN(4096);
+	.note.gnu.build-id : { *(.note.gnu.build-id) }
+	/DISCARD/ : {
+		*(.rel.reloc)
+		*(.eh_frame)
+		*(.note.GNU-stack)
+	}
+	.comment 0 : { *(.comment) }
+}
diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarch/lib/reloc_loongarch_efi.c
new file mode 100644
index 000000000000..db748cb889ae
--- /dev/null
+++ b/arch/loongarch/lib/reloc_loongarch_efi.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* reloc_loongarch.c - position independent ELF shared object relocator
+   Copyright (C) 2018 Alexander Graf <agraf@suse.de>
+   Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+   Copyright (C) 1999 Hewlett-Packard Co.
+	Contributed by David Mosberger <davidm@hpl.hp.com>.
+
+    All rights reserved.
+
+    Redistribution and use in source and binary forms, with or without
+    modification, are permitted provided that the following conditions
+    are met:
+
+    * Redistributions of source code must retain the above copyright
+      notice, this list of conditions and the following disclaimer.
+    * Redistributions in binary form must reproduce the above
+      copyright notice, this list of conditions and the following
+      disclaimer in the documentation and/or other materials
+      provided with the distribution.
+    * Neither the name of Hewlett-Packard Co. nor the names of its
+      contributors may be used to endorse or promote products derived
+      from this software without specific prior written permission.
+
+    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+    MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
+    BE LIABLE FOR ANYDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
+    OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+    TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
+    THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+    SUCH DAMAGE.
+*/
+
+#include <efi.h>
+
+#include <elf.h>
+
+#if __loongarch_grlen == 64
+#define Elf_Dyn		Elf64_Dyn
+#define Elf_Rela	Elf64_Rela
+#define ELF_R_TYPE	ELF64_R_TYPE
+#else
+#define Elf_Dyn		Elf32_Dyn
+#define Elf_Rela	Elf32_Rela
+#define ELF_R_TYPE	ELF32_R_TYPE
+#endif
+
+efi_status_t EFIAPI _relocate(long ldbase, Elf_Dyn *dyn)
+{
+	long relsz = 0, relent = 0;
+	Elf_Rela *rel = 0;
+	unsigned long *addr;
+	int i;
+
+	for (i = 0; dyn[i].d_tag != DT_NULL; ++i) {
+		switch (dyn[i].d_tag) {
+		case DT_RELA:
+			rel = (Elf_Rela *)
+				((unsigned long)dyn[i].d_un.d_ptr
+					+ ldbase);
+			break;
+		case DT_RELASZ:
+			relsz = dyn[i].d_un.d_val;
+			break;
+		case DT_RELAENT:
+			relent = dyn[i].d_un.d_val;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!rel && relent == 0)
+		return EFI_SUCCESS;
+
+	if (!rel || relent == 0)
+		return EFI_LOAD_ERROR;
+
+	while (relsz > 0) {
+		/* apply the relocs */
+		switch (ELF_R_TYPE(rel->r_info)) {
+		case R_LARCH_NONE:
+			break;
+		case R_LARCH_RELATIVE:
+			addr = (unsigned long *)
+				(ldbase + rel->r_offset);
+			*addr = ldbase + rel->r_addend;
+			break;
+		default:
+			break;
+		}
+		rel = (Elf_Rela *)((char *)rel + relent);
+		relsz -= relent;
+	}
+	return EFI_SUCCESS;
+}
+
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a8..89988f199f7b 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -7,7 +7,7 @@ config EFI_LOADER
 			SYS_CPU = arm1176 || \
 			SYS_CPU = armv7   || \
 			SYS_CPU = armv8)  || \
-		X86 || RISCV || SANDBOX)
+		X86 || RISCV || LOONGARCH || SANDBOX)
 	# We have not fully removed the requirement for some block device
 	depends on BLK
 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index bc48e265b901..641b001a9a16 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -44,6 +44,9 @@
 #elif HOST_ARCH == HOST_ARCH_RISCV64
 #define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
 #define HOST_PXE_ARCH 0x1b
+#elif HOST_ARCH == HOST_ARCH_LOONGARCH64
+#define HOST_BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
+#define HOST_PXE_ARCH 0x27
 #else
 #error Unsupported Host architecture
 #endif
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index bed5f1817266..cf1352cf6d72 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -19,6 +19,7 @@
 #include <crypto/mscode.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
+#include <linux/bitfield.h>
 
 const efi_guid_t efi_global_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 const efi_guid_t efi_guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
@@ -165,6 +166,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 			uint32_t entry_offset = *relocs & 0xfff;
 			unsigned long offset;
 			int type = *relocs >> EFI_PAGE_SHIFT;
+			__maybe_unused uint64_t tmp;
 			uint64_t *x64;
 			uint32_t *x32;
 			uint16_t *x16;
@@ -230,6 +232,35 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 					log_err("Unsupported reloc offset\n");
 					return EFI_LOAD_ERROR;
 				}
+				break;
+#elif defined(__loongarch__) && __loongarch_grlen == 64
+			case IMAGE_REL_BASED_LOONGARCH64_MARK_LA:
+				if (virt_size - offset < 16) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
+
+				/*
+				 * Apply an offset to a 64-bit immedate loaded
+				 * by four instructions, lu12i.w, ori, lu32i.d,
+				 * and lu52i.d.
+				 */
+				tmp = FIELD_GET(GENMASK(24, 5), x32[0]) << 12;
+				tmp |= FIELD_GET(GENMASK(21, 10), x32[1]);
+				tmp |= FIELD_GET(GENMASK(24, 5), x32[2]) << 32;
+				tmp |= FIELD_GET(GENMASK(21, 10), x32[3]) << 52;
+				tmp += (uint64_t)delta;
+
+				x32[0] &= ~GENMASK(24, 5);
+				x32[0] |= FIELD_PREP(GENMASK(24, 5), tmp >> 12);
+				x32[1] &= ~GENMASK(21, 10);
+				x32[1] |= FIELD_PREP(GENMASK(21, 10), tmp);
+				x32[2] &= ~GENMASK(24, 5);
+				x32[2] |= FIELD_PREP(GENMASK(24, 5), tmp >> 32);
+				x32[3] &= ~GENMASK(21, 10);
+				x32[3] |= FIELD_PREP(GENMASK(21, 10),
+						     tmp >> 52);
+
 				break;
 #endif
 			default:
-- 
2.55.0

