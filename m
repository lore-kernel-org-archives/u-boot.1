Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE66CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2A3C405E2;
	Fri, 16 Oct 2026 06:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbXKUpwly4te; Fri, 16 Oct 2026 06:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F237E4099A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133920;
	b=lJ/N9MFUQ+so6vfWAlAkiEAqJ2dSnNgVFKiAQbRM6sowiSX/YFUa3wnqi8HBAsPjErL0
	 Bb81GixIy8kxq6onmpaNv03CdwjF46c5EbTpoc2q40ljh7/Q46pL9Gcr2aO6bu3twt+F3
	 rTObqHZbdmTAo7o2SYZTmnWnOIlQfTPDxYVPY6ErUwuBOQ8kCCyj2i9XKMyPXY6hUq2zO
	 BebPE4aFik9tfRHtHW1ehCAXZRMo8zZJVk8hoGVwHiyHflvxYoQur0qZU46xwk48W/Mek
	 koRwJsUu/+q6gDyDFVmKYe29Xcodb8XaOCV/sBwmLd5eOfUpKTmK/IFxSB06kz2URYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BUaXRmS2RMdnHBceXxzwlzV9rPujiCLye+xQiVnXxtQ=;
	b=teXvSGt/jggvAm+zkWNr3kEhOKsCEUeAgjRHV/vF7qbpjWQNQMu1deRTaRKFGxI+cwr7
	 X7Gw7JEvJ9Ar253uLtxZWy29p5casJbtOUOjl1DQYUgNsWeB7XUVRHJ/RF8b3/oouSORu
	 hed/Mx1RKwwyGDw4gtgq3pGAp6gtH3Q5fL52kJwwRhjUypZ3MDEvdBXXxqq3yHlCfnMwT
	 LmhMP+9hNO9VjMX41CjGrErAJGBT9xBvaWY/RSZUj6YFvC2sfFErTDobr82QTHpknQh70
	 rP7OilBuAXo2fh+6cnaIGjMrINj/v4PGPX+UTD1vJ8b9Apb2ebkfe5bsJCduDSAUVAA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133920;
	bh=BUaXRmS2RMdnHBceXxzwlzV9rPujiCLye+xQiVnXxtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M5hAWLRq8FnQRdUAnf3iKcUu5SawpKPcZ9CxijQmVn/tGqqtcNdJuHDCBZnsMg8LL
	 8oq8jWZqcHxDsT3UW641E3S142N2mQFjziaS+yW3oIo3S6akitbtEv6dt33A/IDogn
	 oRu7G33XNRkVPPumW+4q6lzICFAxHAgTN47HQQhvETYR0o+fOEDKMiGgfWf9+QiZ3P
	 cmF0QaB70Nzpwg2rf26phEd4TpdMSKhOSjFRKaGvXVYB7PYgxHPydJ2WR/iR27r01l
	 SgcOVqQdkDwJY2K4shFYpMoHos34rH0h+L6jvWkhdo65rOQreVDyMv/oM6oY55ZKHG
	 iKSx6x+U8fQtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F237E4099A;
	Fri, 16 Oct 2026 06:58:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A58F105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 212F360AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DZ6O4jU-Z6O for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:58:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5AE566087B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133916;
 b=XJ9KViFiKe+qIXX8Q4RGT7WL2TdDoz0ojFEL8Jq5NffVGq2Lh6jr8uxl4sBUQXF2LE94
 AVI8rgL7ki+Xw9y+41IMHKtJpJijodGVMMDApUB5ePqn4u7u0wGL1JPJpopS3isC6l9ax
 zWRHki7t0ydzjmmrZx/FdlRYlhOOPY8s5mDmb3F/Alhp96MuE5CZg+kjQFDTlelMeo6IW
 Vfh1qXlssY/lsi0FzmQOGZ+I6UVSSae1UGCdNQp885j5oX0O/aVOtd2czVDfXz/a+ZUKS
 DkUOujxfaavH6xJ44tQKfUMPDvP9xU6MHPKHFi8yRir4nYuFG+Jd9u6ybhHctnGnmvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133916;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=BUaXRmS2RMdnHBceXxzwlzV9rPujiCLye+xQiVnXxtQ=;
 b=F4mpxkK0LPNACL0piVUr8esersd6aXBDHR8t9nGVysDoyqFT9a1XlWTqPxaxp0Ge+Dpy
 uZtiHmdIBQ9nfN7bVgzsS2dTa9hCixB91QXSymYHLG7lLsDVXQ15WoEc8R2ZAoxMA9q9E
 JQOT1RnAy0r643WdQCNy/jvqp2y47JGMDlX03MEOXdW60FxmE9tuZuygPQngKo1Uv3zd1
 phYJxiiPjD+QM7jF3PVOuKqDx10H7W0DmjzkFgkblLd8RAWpaPP0/peMONk5jdFiR6ZeU
 8ICVjEtzKa652BtSd2Rgan0VFjF13arGMKGCyRIbLHKr2v6biwGQmEL+P0vGQ+2UNqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=aZd+Le44; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=aZd+Le44
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AE566087B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133909; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OzI+nruWP4bVU1Bf0sFwF5TL9LAfvPD3Wbj4IVLbDr9pLkt8OH8JExG/G3yy1tsMdV0KnhRk3qfm7ncml5gg6QHb+t4GrQd3ZI64UZp3EQk2wOsfw2TRTEiGQKefi0yb5248Ungbmbxu0z/t8EjLd3fJJog0LIlmrUdWL0100ME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133909;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BUaXRmS2RMdnHBceXxzwlzV9rPujiCLye+xQiVnXxtQ=; 
 b=SE1AiLaoO8aLuYIDWu0MOhfSFN76xCJm8/C9nVj+QBswoExXvmsNNs95Z0Sj7IZtsqmGGZ4tkrs39qRay7nQqmVKEHpoetjsgUTLD3BSNrXFkv37+2EhPZil50R+t7Z/XXCFod3BqzIWDRwvhKs48wHHVg+D/xRB3JjIQor5vlk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133909; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=BUaXRmS2RMdnHBceXxzwlzV9rPujiCLye+xQiVnXxtQ=;
 b=aZd+Le44TI7jq3Gv+cBbdWAEzNfh8/m6QSjdeoc/eO8RsXynrYt0f5HFibzDdlJR
 zDqV1eneZ/h1xDcnkw1N7CXsLDMgOUa7E6rntk97jBgjBZ5DjqoU7ovFz7uCEzDsO7H
 otFYw+n8KbHSlP+MU9RY1LxkAHZVONRKZM/Wtm7Y=
Received: by smtp.zohomail.com with SMTPS id 1792133907671932.8069422095834;
 Thu, 15 Oct 2026 23:58:27 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 16/20] efi: LoongArch: Define LoongArch bits everywhere
Date: Fri, 16 Oct 2026 06:54:56 +0000
Message-ID: <20261016065500.137544-17-me@ziyao.cc>
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
2.55.0

