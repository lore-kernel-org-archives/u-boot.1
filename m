Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9994C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5F1481137;
	Fri, 21 Aug 2026 08:45:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fwRatID_LaM; Fri, 21 Aug 2026 08:45:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301912;
	bh=mgcv61xYqm++NSX/7mJvBZASom9d3axve4xWuRHgqBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9u3zGPmOPaoTHd0JAXkgs1ixx0CMmIr1GFXAayZdOg3vgxwWskca8QkU6t+omdHd
	 1ue3CY/op9NP5zVNKj3R0HoJU67A1EhztJbyLekQ4tZzZTgmFSbOobj0+F9c/ymrBv
	 JCS0wyQGbxhBFjkjL67lLMrACCRdERINQ9mjmegNt+r6ASx0GYJ3aoLiSw5ugb2kKS
	 aUyr4UuNe0fha/X9Nfo0PmEbsN4JljsXVEHQZdbMPsUnGiuxv2+MzmBs44ORwH9ail
	 Y/vOZjsmeikE5n/cfwlaB2M43C2gLWI+wANvB5JawiCWBXsB0LBnqmzBEbF8nfpdeE
	 seNymz2KieYOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC3CD8110C;
	Fri, 21 Aug 2026 08:45:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 926774B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 789B740927
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IamwtV83f3Xz for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:45:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=Hs/0y81N
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7359040911
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301901; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NsPAiGppN9P51SHXv+UoOQvJlIY0EftvunIJT6jlJPTonel0UnT7ZGW3gsun7wZ1kbQ63X1Tjl3H8A6dwQAKC0NI5NjHbEkkzolwrb8C5tn5H44KuENuUBPW/0zCdzdRaizc4+eDv+W0dCfdv5RH3mrceTFIznjTxHGabcpIWEo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301901;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mgcv61xYqm++NSX/7mJvBZASom9d3axve4xWuRHgqBw=; 
 b=WPA1yNK0Z3nwDXbvK0vUtnfPEuHpo/pW70W+cbAi1H/YDUOD4y3cIswHygHBWlNWxCtWI0AQhVV6BgCYn4HJS+Q/yzoVEbNVsYCWQuGlud6FAU9g4ZH/5FmQnckki7S9+W0v2apo+P9LXEaPTvnqpPijfR/iiXDQI1D1FuKzXzc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301901; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=mgcv61xYqm++NSX/7mJvBZASom9d3axve4xWuRHgqBw=;
 b=Hs/0y81NxfBnh+VtkCVX3947qYsvJUo8N90nJEkXzEMtr1FlRCR/jYeJf9ktRC0+
 qojLhfzENi74kh17zQZi9u3sDvtDi0LZ5qJmF7AiAIki0JRhhToSIOpHHgReJ/ywMct
 DNc0blC4+II1duQKFAkk+KY7rYipTTiWGxKlXpgI=
Received: by mx.zohomail.com with SMTPS id 1787301899330204.65886081284418;
 Fri, 21 Aug 2026 01:44:59 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 15/19] efi: LoongArch: Define LoongArch bits everywhere
Date: Fri, 21 Aug 2026 08:42:15 +0000
Message-ID: <20260821084219.1703743-16-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
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

Add PE machine type, removable boot image name, vendor class identifier,
client architecture identifier, relative ELF relocation, and undefined
instruction for LoongArch. They are all coming from UEFI specification,
PE-COFF specification, or IANA websites.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

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
2.55.0

