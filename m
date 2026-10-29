Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FfyhUQbs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=b5cuDjDf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A614606CA;
	Thu, 29 Oct 2026 05:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJNmDHy2cXj3; Thu, 29 Oct 2026 05:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73DF1606DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250699;
	b=BRp7xiD2VjL4Z0MGG+rZ/Y2BkejFGEQTSwJILzdpb7ip0j7PalZDrKncXliKIrWQYolw
	 sp9l1XrSmWJKWsrEzYrcOmfLMBU/xmSSzdR+NyFir5NV586tFYPJDITdaDRIp8tUVNUxV
	 3/5kcTB9WZ0ix5Zli3SLAdNnbJlPvfbdbBLw8Q8peX/0q/kMzFFjw/cxtJiYG2/rBjiZ5
	 ONtF8086z+OolOBNSjKzaPPgqL9EEZPeDkxKPVJ01PYHvjyB+7cSXP5UO7xawllmBcQVx
	 TvNTQ8gsc6ycBud5dDjErzp7+y57AKcLePPN4cLydw1Dkol2wViDtcMVYmfxoiSAK0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OVN69ZMt2tYN4JpODM1nj2JSN4z/L3CCUi1NqjeHslY=;
	b=T7uc5Pl5O0YvvsxPkxQYG8cfLeNpW0WtpaXdvQ4LPmaJpmwtSMIHKVwt0AFVDa61Sg2w
	 uTE8bUaiilQT6c3aFHSuzIBjjGSgcGViSM6uwXUHqMKQZW2n31gFm+xDPBEwsDd9KuCcq
	 Mjv/bJfjtggEx5txb74dLpaBijFDsUeFCIeEk+k3Q91Ut5Es3t/905l/Run+MVWnRrI/d
	 /8zQr5sPyMbg2DCRvoFzHIfHIgEhdOAwC+q1XgOe+z1crTYEwsCeT69loUoERK/LNIFKv
	 QwI7mBjGydYHcw78ERQT6ghjiMPHMeYdHRJXB69vD/LptvYSXDrcmKJEPFThT3ceZQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=b5cuDjDf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250699;
	bh=OVN69ZMt2tYN4JpODM1nj2JSN4z/L3CCUi1NqjeHslY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FfyhUQbsaIXu6nPo72l7r8QMmDwZ0iehZbAqdL5oLA9lid9mtxujL/85ivgN+oOPF
	 9ocvAEy2CgxZDQyUdyUBuxRrd3LdbSRj5+lFh4FZSL84PWurzikFEP0GZ3ItiDZrIr
	 sXsaOwGmWDvZPXrOfaAZKJLlDohRP+Ftu3xr2mmsc+xS9O9S6FwTcDB+KKmV4psGa8
	 aXPfhaQsYzKTeyGtRip1c8qA7npWkNESbKSOzgAAbXosZu5Ue4GDybs5Kh8gmvGLN5
	 C4z7nzAG2EM3yoc7szNpXNyJcCLRfv9jyET13HVQivg/HPFlKFPGvFIkVXfCPRHDS0
	 5IfRyXe8sqOyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73DF1606DE;
	Thu, 29 Oct 2026 05:11:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 041F32FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD7E6606DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aiOXpUo6AoaE for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A0C5606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250695;
 b=FDXlk53/Tgqd2dVYcsQCzyuSfX+twD+aSx12xw+s//WxP7CymMA++/xN6cd+M2ha9fPN
 K0aMq9RK2ln8LmWpJQPE3O7QA/NimtPacBaPP+JhBJeXUdTgjbIWuFMVKRTrVeuLqgfq8
 R1HcE1mpGQc+fEPfPB02hUXQp3IkZp8AKK0EbVxf3N4cHxsUbll1KfRd8XqJZm/E0kShN
 y0Mz0zi422Kc2q+pIUW+ISx2NHBqXmvL4/XmoJ73+RRzFzoCuCY2yRfzUdIxm2VmX8PYy
 Gj/DjqRFDNU5A112NYl9YGiNGWPe+g4LcYR7JHqpyDabfyikVZ0JyYPySaR1nLWjNUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250695;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=OVN69ZMt2tYN4JpODM1nj2JSN4z/L3CCUi1NqjeHslY=;
 b=QxdbBhYPjlskOXXcxZRp4rPHQ5DEUocevK1HwYWuEPNKA5Dgjs65fRO3SScicDyimX3j
 wXuH0JYva3031earhd8a4P84pvRrDqcuZDKUhpzS+vsCWsFxdXJFJV+dWa8GFjd643e/2
 jSlzvdhsqjFbSjwjdH1oijCOFJt/FENKd9n4I13HORTEDTIIINOwOwp+KzevGcNEsp+jI
 KB2as6za7S1ARYPiABkrPPcS7ACelZjBoT2QuBc9c5sKaz3tyPQCRFN8y06sUONcCP4Nd
 WsekGP1xku3zM2FPmqZqvtupd+B6Nux7pN7HclcaLphHPiRT7mkZfuDC82NgF/7fvvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=b5cuDjDf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=b5cuDjDf
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A0C5606CA
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250689; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cZUOCC0Dx2sLBCvdCrgp+eXCdliOhx6pRcFeezHKZiixx3EXGWcVGaqNgq9OP5hgVESQ6R+KrawA32uCn2rK9ivkWWbnFq6k+n6HvHvul7mGIv2DgNLi76eVpXU1ddSAMPLS3s6FRZ0c/gAtj/aWU+CKf7+JqTblQXAiOUpOEj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250689;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OVN69ZMt2tYN4JpODM1nj2JSN4z/L3CCUi1NqjeHslY=; 
 b=gEbkEuxEpnrZRklkOkKotkBcyzZKGaw+Rueciptrsov70X7mfgklaccjCarr4Tre5z3Pq0FmSyplngaXbhMM9M3B2Z7xkPsSuNN4n54p4g0Nt05NJSu76igf7pyeeGi1vyFhY9kSDlv4UxOuHk3/DRHDv2zCVkLAsYlrfHKlNRc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=b5cuDjDfO1151u9sdf589Uuz+nB7mcQbxQkyqszy2keMnLXs5gfgXmmHnUQZ/L4cLC+zWDw8T3dU2qql3A6hC9TdI/wGmaNSGdeU5nOwxb2EzWoOpWHOHkk26Nn2rlkLLJ9WXrF4RY2y4J0fEvbzfFN/ygHwQOYFMe/ocoCv62g=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=OVN69ZMt2tYN4JpODM1nj2JSN4z/L3CCUi1NqjeHslY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250687779744.4983251098888;
 Wed, 28 Oct 2026 22:11:27 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 17/20] efi: LoongArch: Implement everything
Date: Thu, 29 Oct 2026 05:07:34 +0000
Message-ID: <20261029050738.1107663-18-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement crt, relocator, linker scripts, and handling of PE relocation
IMAGE_REL_BASED_LOONGARCH64_MARK_LA. Wire things up in Makefiles and
Kconfig. The relocator originates from gnu-efi project.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed from v5:
- Remove unnecessary settings of extra-$(CONFIG_*) in
  arch/loongarch/lib/Makefile for EFI applications
- Whitespace/empty line clean up
- Localize the temporary variable used only by loongarch in
  efi_loader_relocate()
- Fix grammar nits in the commit message

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
 arch/loongarch/lib/Makefile              |   8 +
 arch/loongarch/lib/crt0_loongarch_efi.S  | 182 +++++++++++++++++++++++
 arch/loongarch/lib/elf_loongarch_efi.lds |  76 ++++++++++
 arch/loongarch/lib/reloc_loongarch_efi.c | 101 +++++++++++++
 lib/efi_loader/Kconfig                   |   2 +-
 lib/efi_loader/efi_helper.c              |   3 +
 lib/efi_loader/efi_image_loader.c        |  33 ++++
 8 files changed, 408 insertions(+), 1 deletion(-)
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
index 9eb9662066a5..d67cfa9ed18c 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -12,3 +12,11 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
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
diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/lib/crt0_loongarch_efi.S
new file mode 100644
index 000000000000..ba3d9b4ad71d
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
+	bl		_relocate
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
index 000000000000..72acfe525c3f
--- /dev/null
+++ b/arch/loongarch/lib/reloc_loongarch_efi.c
@@ -0,0 +1,101 @@
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
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c4b0c2137b87..6a417e75bf46 100644
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
index bed5f1817266..612e0cfec2ce 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -19,6 +19,7 @@
 #include <crypto/mscode.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
+#include <linux/bitfield.h>
 
 const efi_guid_t efi_global_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 const efi_guid_t efi_guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
@@ -231,6 +232,38 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 					return EFI_LOAD_ERROR;
 				}
 				break;
+#elif defined(__loongarch__) && __loongarch_grlen == 64
+			case IMAGE_REL_BASED_LOONGARCH64_MARK_LA: {
+				uint64_t tmp;
+
+				if (virt_size - offset < 16) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
+
+				/*
+				 * Apply an offset to a 64-bit immediate loaded
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
+				break;
+			}
 #endif
 			default:
 				log_err("Unknown Relocation off %lx type %x\n",
-- 
2.56.0

