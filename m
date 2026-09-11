Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813E5C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B315812C3;
	Fri, 11 Sep 2026 10:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yPcNCQq68nOV; Fri, 11 Sep 2026 10:48:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7123881292
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123735;
	b=UiZyvJKbNt8SFxOCfGrM9lfkQpaACf++KGSkt59CS9Mtcqd1wC0fYO0HuOxpqChu7CHa
	 42E1QEA+7eB88d3dW7JlmG97Qj0Ka3pURyaMnUVTxHY20+qkkEQ68Hk77cb2m2LUCk+OA
	 2DcrGlngNlFDIVu41u+mHTCg6DBj7njSnTS3gNIfss5jMLOb+YPWzGhEfVYMEh7g+FC7R
	 adQv5+zqiP/1M0WkGpHWJA8iKhgrRf9SDs2/j/hxLQyGKF46EWt2gARRIYfh2Kc18Vcbx
	 QKcKjAq/+nGc1R6w7sjryghNGXRIsR+fRlA4K9GCo9U124PEWUgIW90l+o36JeGt6VA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dc+SML8AbiuyIJt3gW7S3IUtv8k82Cpu5r/7HKXKsOA=;
	b=O8smJMjUzx3Yv8q6iAwc4n9yJDxpCDadjtjKETS4WE/XYY6tkxDcQGu4bAEmcehi44rk
	 AWjI6zt8b6YbiB3pqCx9cETidxmN0XBC6/yewslEbs6e1CIEb8pjfKCV3V9MLYrm0V32M
	 ozkMIqD5gFVO/i881wVzaSyOvryXW28ZkDe/ER6BpdBXkWTbI1STx7oUHMAecI67NXig7
	 4ZeUKvlGt79rHbtVbAQTkjMALh+wjPsPTf4DwjW673gqHBjTFgcHAtSDNkzd/qDOrrog6
	 uXGc6UiD5i0efNZd07o79mhsSVo6G45JyIVI1UPX9ujzkEVxUMulrEGTmO1hCkzzR3Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123735;
	bh=dc+SML8AbiuyIJt3gW7S3IUtv8k82Cpu5r/7HKXKsOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CdLoIS/GDYBoz+pEzuZmleD+aIhgBeKQ527tw79RVjh7LI86NZMdPZMgPAPs6jcWI
	 upYjFTFaloFpgQl9S8t3U1kr1e/Qfo8qULKyquOwsZ2VS5N8Da54f37oqo8HWYRaZW
	 K9aAj4ScCqiVC0FSlcxW9zt/+4enmGfv7lFf0LiO2ZO1iG5fChZ8EcKLbp3i59qu3t
	 jdU+HOsaH/cdtGcUVMDef7ByO0HJhTbzjMYw+CCfD6hBD7iZN24RlOD6C+ky5Jc3rT
	 jRX83BTon6kA0P8rvhtnvo07j8QTH6SnhS1JCjYlEkHawxuav8RGWvpsY8IVQCWVBC
	 DoMDSz/V6WNwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7123881292;
	Fri, 11 Sep 2026 10:48:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5ADC14C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A750640461
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FT6fbJTR2piL for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CCAB840460
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123734;
 b=rDFvQRg/9lzTK9ZWFsVPvwUgTSHEcf99mKwSExto4LhNzKvuk4KsiFSyKbOf0i4j8hEd
 xKpH6SEG1a6lfhG2gT502g32dyafOi6gXgvvW/w3uifDIC8N9SGYQL34X+qvHWZFdf2LY
 Fav2+DJGopY+nyvQNxN9KDtpWO2vWqIYkm+Rlx8K0cHJcb/UcyfxotFf0s1bqTlUpEFmd
 N19TwgpvGaOiHK+uc352vkxHOnL+cJVN4s0mApsrIwbjKqgQxBlBVt5TfVhMrzWFgSJNC
 POwxzUPEgNQSsYIaDYyyOtDMbdpV/CZA63zZ8ayQBirtSclFNopiveGXadPFoxLgj8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123734;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=dc+SML8AbiuyIJt3gW7S3IUtv8k82Cpu5r/7HKXKsOA=;
 b=KsifqFoI5ozCGCgwqTq5p2ZipZffV3hSGnBJNJw1etZLj6BRKAh7RLmV/OObkLPSVART
 6C0nw5R6V8nuSZZH+jVaIAm2UhmtizHGU7OWKaz5UcVtP4eeyyaDjeDTKpLZMeLXkQTWU
 2LPnuGNqc7mzdBIpcoAui6/++F3b9eS0nS6Gg3F9VJwxu04qW8fovKgUBC6oIfOY/x+ww
 sQxvhYIVVCPzbu1XrN+5tzA7FSfLecI/KbZJHC+EKjos7jS96+GnCnGUUFFyJ8XVXM/eS
 0GjnmlTgwb7gTayR1zO9YrlZwaYrHIw1Ed5EBy3IJSisEqPwCxdy2Qc2x+aynwiMeUg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=SOyAPluT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=SOyAPluT
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCAB840460
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123726; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HtvALiLJ7DV/kUYJP84gJ14tIqKt3Y1BS41NvQb+JsMU1O18p2Fhj7Q6EZ8b+uw8v36X52h4Msi2SYrrVNvP2u47Tq8PnitlyADnKo2F5sprExCMZ/4Jo71L8pFW4uo8arYdTRAFuZieDynXQ7tLqqSruZVCC1uso/gFi0Yz+lw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123726;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dc+SML8AbiuyIJt3gW7S3IUtv8k82Cpu5r/7HKXKsOA=; 
 b=EYCSaAE1X1H8xB4QC3FkSGn4fX78n7R4yb0PSq2ZELZlIxghrfSMKh7K+4Jgov8BDxLob73EiZc58yq39yZQ0mwZbfuGyeJeV2cEO2KHWvcz6mWFoO198YqHLqfOhTbkVbidJodxweiqxnp11Px3rfTQtolSYRA2joXnU9+bAJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123726; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=dc+SML8AbiuyIJt3gW7S3IUtv8k82Cpu5r/7HKXKsOA=;
 b=SOyAPluTKcQAzcTm0qCnYZc5jsTaXvF28SeXjr1tIpgPF+xbjShXFnb+nht1oo82
 FANv/BvxdeekDibdh2XXbagYv1u7E0yMoqF1O8fSo9yvIvl9cb8tKYLeg+nucryu5L1
 4IULXHdIz4ZeA2zBRswyuyC3xx7fLtoeyIe4VkfE=
Received: by mx.zohomail.com with SMTPS id 178912372509429.644471603770967;
 Fri, 11 Sep 2026 03:48:45 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 15/19] efi: LoongArch: Define LoongArch bits everywhere
Date: Fri, 11 Sep 2026 10:46:00 +0000
Message-ID: <20260911104604.2910944-16-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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

