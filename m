Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8D606A32A
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mtobd4kT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=EoWAmSUl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96E2A40C66;
	Thu, 12 Nov 2026 12:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tBnoev0zlFz6; Thu, 12 Nov 2026 12:02:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE96440B51
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484956;
	b=rncV1rjKRXPgaW3OlrY1LxZdOCUT+73QV1R/uWL/6F+tU26BCoFrIOI7X7dpwbojrSOo
	 F6g+IbP3VPMtWzGNtLfjLvDNH/mrbRe31VLBId73jUdKdZNu1OilmZlORjP/SA5VjN0Pe
	 UNnQImPvIOaXYzlutKt+U/dymzrdp7KSNSoNfJnGefXY1/raJ6brFmFzxDVF3EjY//OHr
	 cCOznUDurY/UTzIZCJ9W6wb9AcR4ExYXQyzxyxNvhWOX5As4DMJWtd7OFhfPPjTxkt8uD
	 9ck5quzaNWIDHZ2UtU9kESSRWTjr/7AnlPqcBxLQWUzEEomTrtpVX0aOhETg1hYVQWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=;
	b=sqRcTvjnMrgebIxm3AfMKdcYK2tHYT+YUksU4vFLBX8xCCtFaokjiE6+3+6VvydVjKS2
	 Xx7dEk3mw20J3LGZNarqvRxSiTjs5Qt4HqcQEl6jYVSN7xnSL4012c1vRu+SvI6hZ0U5Q
	 nmZ2mQWZIqnTcVgwIeZ7lusx3aOE5//TAAVTMU20V0sE8YZTScPRVUQqh9u9EuGacetJG
	 2XKSAHz7fcusyNQrPHq4GcoRvqliJ3IKxwo3O/SgQGlb/wce9oHIcC7+6/i4KyXMXmGIF
	 f71VhvIhkSCSqwjhENPUjFeGGYwHED8B/NFLVJlDzFhoGCJFeNj7rZCbFBYwpsJPZwA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484956;
	bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mtobd4kTXQ47I5cleNZsFUQrZbxpWLziNl2n7GGZ5eLE3goRahFxQCm3ezMnlcTSF
	 4djSHGM9YIgPZfQYaeODk4DceVY3JhZhYCNGVotVcGFHQlOcOGwKbKzUgNe1zzO3Y6
	 EdNo7sF0SrsHAsLWI7lf314OOWWDc3o0Vw2f89WPRBNtmBoqw2FxlwucaB8iQOR3HB
	 qYoak6nbEdxtAT/Rp9cmar9RJRkyPqi66oqXAjMWMsLeyIZ7Z5HP9rlqWtSiG8WMmE
	 qFx3zTiLodPOmBhU+R00s1kY/UIsM5YGwSs/tRZv+nqwfCEThwGc/Kg7X1dbItRiv2
	 DxJszpz50tWWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE96440B51;
	Thu, 12 Nov 2026 12:02:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D5EF1399
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E47FF8107C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JND4Lm0luV-6 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 12:02:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5557A80CE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=EoWAmSUl
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5557A80CE0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:32 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=EoWAmSUllW4M2n/wdRwSB9BX+NuPyIK/WN4zSp6K9G0WgYrsSd3rxiDnEFocPnuQmv7IMBLYLxZv3raFqPaK1ycGr1Wo5shzSC0g3e6c6KUOEEly/X55ZcfUk5G/hH3C+qcJ+UF65QIfhizhAsAwEcW3N4jWJEmjqgLg6Q0IQKw=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484675762601.1371388701463;
 Thu, 12 Nov 2026 03:57:55 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 16/20] efi: LoongArch: Define LoongArch bits everywhere
Date: Thu, 12 Nov 2026 11:54:34 +0000
Message-ID: <20261112115438.1837663-17-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add PE machine type, removable boot image name, vendor class identifier,
client architecture identifier, relative ELF relocation, and undefined
instruction for LoongArch. They are all coming from UEFI specification,
PE-COFF specification, or IANA websites.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v3

Changed from v2
- Describe what has been added in commit message
- Drop extra paretheses in elif condition in config_distro_bootcmd.h
- Define IMAGE_REL_BASED_LOONGARCH32_MARK_LA as well in include/pe.h

Changed from v1
- Reword commit message, replacing "PE spec" with "PE-COFF specification"
- Replace obsolete __loongarch64 macro with __loongarch__ and
  __loongarch_grlen
- Use a true undefined instruction in efi_selftest_miniapp_exception.c
- Define HOST_BOOTEFI_NAME and HOST_PXE_ARCH
- Introduce definition for IMAGE_REL_BASEd_LOONGARCH64_MARK_LA
---
 include/asm-generic/pe.h                          | 2 ++
 include/config_distro_bootcmd.h                   | 5 +++++
 include/pe.h                                      | 2 ++
 lib/efi_loader/efi_helper.c                       | 4 ++++
 lib/efi_loader/efi_image_loader.c                 | 7 +++++++
 lib/efi_loader/efi_runtime.c                      | 4 ++++
 lib/efi_selftest/efi_selftest_miniapp_exception.c | 3 +++
 7 files changed, 27 insertions(+)

diff --git a/include/asm-generic/pe.h b/include/asm-generic/pe.h
index cd5b6ad62bf0..fb93f2621715 100644
--- a/include/asm-generic/pe.h
+++ b/include/asm-generic/pe.h
@@ -38,6 +38,8 @@
 #define IMAGE_FILE_MACHINE_ARM64		0xaa64
 #define IMAGE_FILE_MACHINE_RISCV32		0x5032
 #define IMAGE_FILE_MACHINE_RISCV64		0x5064
+#define IMAGE_FILE_MACHINE_LOONGARCH32	0x6232
+#define IMAGE_FILE_MACHINE_LOONGARCH64	0x6264
 
 /* Header magic constants */
 #define IMAGE_NT_OPTIONAL_HDR32_MAGIC		0x010b
diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 8d6f80a0ce5c..0eb6bd742b9f 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -118,6 +118,8 @@
 #define BOOTEFI_NAME "bootriscv32.efi"
 #elif defined(CONFIG_ARCH_RV64I)
 #define BOOTEFI_NAME "bootriscv64.efi"
+#elif defined(CONFIG_ARCH_LA64)
+#define BOOTEFI_NAME "bootloongarch64.efi"
 #endif
 #endif
 
@@ -371,6 +373,9 @@
 #elif defined(CONFIG_ARCH_RV64I) || ((defined(__riscv) && __riscv_xlen == 64))
 #define BOOTENV_EFI_PXE_ARCH "0x1b"
 #define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00027:UNDI:003000"
+#elif defined(CONFIG_ARCH_LA64) || (defined(__loongarch__) && __loongarch_grlen == 64)
+#define BOOTENV_EFI_PXE_ARCH "0x27"
+#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00039:UNDI:003000"
 #elif defined(CONFIG_SANDBOX)
 # error "sandbox EFI support is only supported on ARM and x86"
 #else
diff --git a/include/pe.h b/include/pe.h
index 086f2b860e99..eac9eb25ce47 100644
--- a/include/pe.h
+++ b/include/pe.h
@@ -194,6 +194,8 @@ typedef struct _IMAGE_RELOCATION
 #define IMAGE_REL_BASED_THUMB_MOV32             7 /* yes, 7 too */
 #define IMAGE_REL_BASED_RISCV_LOW12I		7 /* yes, 7 too */
 #define IMAGE_REL_BASED_RISCV_LOW12S		8
+#define IMAGE_REL_BASED_LOONGARCH32_MARK_LA	8 /* yes, 8 too */
+#define IMAGE_REL_BASED_LOONGARCH64_MARK_LA	8 /* yes, 8 too */
 #define IMAGE_REL_BASED_MIPS_JMPADDR16          9
 #define IMAGE_REL_BASED_IA64_IMM64              9 /* yes, 9 too */
 #define IMAGE_REL_BASED_DIR64                   10
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 44b806aadc4f..bc48e265b901 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -62,6 +62,8 @@
 #define BOOTEFI_NAME "BOOTRISCV32.EFI"
 #elif defined(CONFIG_ARCH_RV64I)
 #define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#elif defined(CONFIG_ARCH_LA64)
+#define BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
 #else
 #error Unsupported UEFI architecture
 #endif
@@ -94,6 +96,8 @@ int efi_get_pxe_arch(void)
 		return 0x19;
 	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
 		return 0x1b;
+	else if (IS_ENABLED(CONFIG_ARCH_LA64))
+		return 0x27;
 
 	return -EINVAL;
 }
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f9a2d2df405d..bed5f1817266 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -51,6 +51,13 @@ static int machines[] = {
 #if defined(__riscv) && (__riscv_xlen == 64)
 	IMAGE_FILE_MACHINE_RISCV64,
 #endif
+
+#if defined(__loongarch__) && __loongarch_grlen == 64
+	IMAGE_FILE_MACHINE_LOONGARCH64,
+#endif
+#if defined(__loongarch__) && __loongarch_grlen == 32
+	IMAGE_FILE_MACHINE_LOONGARCH32,
+#endif
 	0 };
 
 /**
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73d4097464c0..de50d72d634a 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -78,6 +78,10 @@ struct dyn_sym {
 #else
 #error unknown riscv target
 #endif
+#elif defined(__loongarch__)
+#define R_RELATIVE	R_LARCH_RELATIVE
+#define R_MASK		0xffffffffULL
+#define IS_RELA		1
 #else
 #error Need to add relocation awareness
 #endif
diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
index f668cdac4ab2..648206c17098 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
@@ -35,6 +35,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 	asm volatile (".word 0xffffffff\n");
 #elif defined(CONFIG_X86)
 	asm volatile (".word 0xffff\n");
+#elif defined(CONFIG_LOONGARCH)
+	/* ud 31 */
+	asm volatile (".word 0x386007ff\n");
 #elif defined(CONFIG_SANDBOX)
 #if (HOST_ARCH == HOST_ARCH_ARM || HOST_ARCH == HOST_ARCH_AARCH64)
 	asm volatile (".word 0xe7f7defb\n");
-- 
2.56.0

