Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01D6C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC2D84C02;
	Wed,  1 Jul 2026 13:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="UXBoxZrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E19C84C01; Wed,  1 Jul 2026 13:19:15 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1AC84C02
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904749; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GIbpzACAMCuoPrZj2m5fB566jmKs7iBR4djzgbs1vFbLXpLXMZi0aJ9l4UX1WwiLfoKZZJZgocglNxCoo1yqJlRmQ0hi3f8pBG4miJezUY22x8907penVd9oU4WmmA3rf8b/BfGFj6XWEUNZGjEyjuq9qZpGkpKxfFgeIZgKb4s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904749;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FN2y0ZFw7BD2EduEUg1HrKOajCvRHx8GNtOUEiwEnvU=; 
 b=KsloZ8YUHZZD+ziExO1yoA4MZaOgRhJnrL8cPOE+Zl5YLHcPjj82ipeHl+i2C8/vOrhsQDl7jSozm+WpWAemNvXmTRGbbuuKu+xvu5nZIRONdrcZPMTb9zdGfjqKjyi5/BfH5dUVLw39Jjy8poL9hCfpLQoAJWME0l1U8UWtOJw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904749; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=FN2y0ZFw7BD2EduEUg1HrKOajCvRHx8GNtOUEiwEnvU=;
 b=UXBoxZrCmlN6QAnsZXfoNLh6tIHItmBhP6KcE5+Hv/WJT2LqHlxEiPM2v7wWWPhZ
 6KkCqi8vfHAleofaMtrVP/omevGa2b+/WvOJNkUCboW0FQZHUg919ZTfMr1opObFKCd
 asUzewY/QXgE28beeWYtmP95zPeysT3X16zz0uWg=
Received: by mx.zohomail.com with SMTPS id 178290474654132.096412460895294;
 Wed, 1 Jul 2026 04:19:06 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 15/16] efi: LoongArch: Define LoongArch bits everywhere
Date: Wed,  1 Jul 2026 11:18:07 +0000
Message-ID: <20260701111808.870705-16-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

They are all coming from UEFI specification, PE-COFF specification,
or IANA websites.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

- Reword commit message, replacing "PE spec" with "PE-COFF specification"
- Replace obsolete __loongarch64 macro with __loongarch__ and
  __loongarch_grlen
- Use a true undefined instruction in efi_selftest_miniapp_exception.c
- Define HOST_BOOTEFI_NAME and HOST_PXE_ARCH
- Introduce definition for IMAGE_REL_BASEd_LOONGARCH64_MARK_LA

 include/asm-generic/pe.h                          | 2 ++
 include/config_distro_bootcmd.h                   | 5 +++++
 include/pe.h                                      | 1 +
 lib/efi_loader/efi_helper.c                       | 4 ++++
 lib/efi_loader/efi_image_loader.c                 | 7 +++++++
 lib/efi_loader/efi_runtime.c                      | 4 ++++
 lib/efi_selftest/efi_selftest_miniapp_exception.c | 3 +++
 7 files changed, 26 insertions(+)

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
index 8d6f80a0ce5c..7722ba7627fc 100644
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
+#elif defined(CONFIG_ARCH_LA64) || (defined(__loongarch__) && __loongarch_grlen == 64))
+#define BOOTENV_EFI_PXE_ARCH "0x27"
+#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00039:UNDI:003000"
 #elif defined(CONFIG_SANDBOX)
 # error "sandbox EFI support is only supported on ARM and x86"
 #else
diff --git a/include/pe.h b/include/pe.h
index 086f2b860e99..2340631f82fe 100644
--- a/include/pe.h
+++ b/include/pe.h
@@ -194,6 +194,7 @@ typedef struct _IMAGE_RELOCATION
 #define IMAGE_REL_BASED_THUMB_MOV32             7 /* yes, 7 too */
 #define IMAGE_REL_BASED_RISCV_LOW12I		7 /* yes, 7 too */
 #define IMAGE_REL_BASED_RISCV_LOW12S		8
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
2.54.0

