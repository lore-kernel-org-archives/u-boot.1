Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7989FC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E1E288891;
	Wed, 22 May 2024 17:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="5Zeh6nEX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hf5L1AaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A68587D43; Wed, 22 May 2024 17:35:40 +0200 (CEST)
Received: from wfout5-smtp.messagingengine.com
 (wfout5-smtp.messagingengine.com [64.147.123.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078268888B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 39EF91C00176;
 Wed, 22 May 2024 11:35:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 22 May 2024 11:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392135;
 x=1716478535; bh=NQT7g8SRe8FVrb9EBNPV1sFwfwpPTnqe2K6PnaWVTUM=; b=
 5Zeh6nEXPIO/GH6gMCBZAdNzHzBkgp6EBIznp/nxn1ew1Jr/97mEBkYA2dowz3+6
 U270AUoYfVjU5YBsoT7m+UgIrFSJfijT+zG8eq0REZtGxzcATC3eSJoApLjcP5yH
 iOjLxBIjyZJBSSkeQH8TAIHPwxFqDhBbRvRM4CqthoJIabaWv2BYsbuQyICHGVh4
 2hh0ZXWnAf/O6BkCfI6KnukNf/uKgyJh6g0Qe+JGrY9P3qqNNuWmr4wnhgO4t+K3
 2lW8u++A2ynkFUd/AZTjAz2ZsvMx7aOYXu37KchGOC88rx2701G4ENxMuntV6YkD
 5nykVUWBOu7YXyGznGc+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392135; x=
 1716478535; bh=NQT7g8SRe8FVrb9EBNPV1sFwfwpPTnqe2K6PnaWVTUM=; b=h
 f5L1AaYQkRnyrhX3+lGaK+/IXjzxVfdGzq6zleidjIeKd7nxGkujTeU2qVzew24e
 R/ZXUrLyXZOxSJacyeCHrghwDs2RJlgrB0emLPbe84oRm5azOTdIIo11my/ZSVM0
 KStphlwXT5PSDGx7otrQ0jDPqPbK+dQeDh1EVYd2Rl3gfAd0LzxwlrisH9vRK22/
 tZV4cvTT/DSMNxKrJHH5schGYt3CiyoCcNh0+r5+E0CisEWtbbsY0yJdO/8H6KNN
 bYJECYfmF7yv0fjwUvbMazt3WR5tYaqRLzRYCSNLb8HCl8CrwMECZ7EmPgdv079T
 VUd3w9bnL0jo0NPsdkrEw==
X-ME-Sender: <xms:xxBOZgFZE-d6vCVSgwFspHs3daIE6zj-L6d85GcrGTI3LhaFFLoyeA>
 <xme:xxBOZpXnFfjn3WuRMIQP4S42UieJ6bWkR7EalIOaKPyllZuv9uvpQiZ7NH1fu11cc
 qz8pnPUt2ojeRw69JA>
X-ME-Received: <xmr:xxBOZqLQH_okBRJVqOjtvHQ0ad5U5lOypb3ZrnGVFjOM5FVDlEuY2Xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:xxBOZiHNOCt3fdwAYCWdsuLNfEbDVes62ba52W7Mizm_2S_Gu4WzlA>
 <xmx:xxBOZmXBKmTp93aELwJ5M8Cj745UcsFe0aWILJD5nDTkxDlf8AL9HA>
 <xmx:xxBOZlOy92-7IcY-rDYTXrmhKiw6QtcSu5FzbS8xV-NApVUo5R-EQA>
 <xmx:xxBOZt0QzwddLoWdyey_CG9ytc4OL0nseaiMKvx-SXOQz19DLbBAyw>
 <xmx:xxBOZoIAfTJHQwbPKJbFqHj2bwfYiL1rMXCcXbKkTdI2GRUNk67CWNTh>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:34 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:58 +0100
Subject: [PATCH 15/16] efi: LoongArch: Define LoongArch bits everywhere
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-15-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4511;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=h4AK7VylH3+j8GPHduMM7FfejBGuAm/5Kj9eV6CDO0Y=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geXxWgLfDrV5nKswrq6cZ9ZXYPI1tfjTbdaS6ElMn
 d2CjUIdpSwMYlwMsmKKLCECSn0bGi8uuP4g6w/MHFYmkCEMXJwCMJGJFxgZbt2JDa2Qf7nw49YV
 9YbOIf/L/7Fee1X7R+guw+/XF7IlbjEyXG25wF7ooVXKzrxb63Sgjd7aWUpvD1aaam7k3BbAZGr
 MBAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

They are all coming from UEFI spec, Microsoft PE sepc,
or IANA websites.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 boot/bootmeth_efi.c                               | 2 ++
 include/asm-generic/pe.h                          | 2 ++
 include/config_distro_bootcmd.h                   | 5 +++++
 include/efi_default_filename.h                    | 2 ++
 lib/efi_loader/efi_image_loader.c                 | 7 +++++++
 lib/efi_loader/efi_runtime.c                      | 4 ++++
 lib/efi_selftest/efi_selftest_miniapp_exception.c | 2 ++
 7 files changed, 24 insertions(+)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index aebc5207fc01..b0207dac49c5 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -41,6 +41,8 @@ static int get_efi_pxe_arch(void)
 		return 0x19;
 	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
 		return 0x1b;
+	else if (IS_ENABLED(CONFIG_ARCH_LA64))
+		return 0x27;
 	else if (IS_ENABLED(CONFIG_SANDBOX))
 		return 0;	/* not used */
 
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
index 2a136b96a6d9..f8c3a4bb70ae 100644
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
 
@@ -366,6 +368,9 @@
 #elif defined(CONFIG_ARCH_RV64I) || ((defined(__riscv) && __riscv_xlen == 64))
 #define BOOTENV_EFI_PXE_ARCH "0x1b"
 #define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00027:UNDI:003000"
+#elif defined(CONFIG_ARCH_LA64) || defined(__loongarch64)
+#define BOOTENV_EFI_PXE_ARCH "0x27"
+#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00039:UNDI:003000"
 #elif defined(CONFIG_SANDBOX)
 # error "sandbox EFI support is only supported on ARM and x86"
 #else
diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
index 77932984b557..fac25039fd31 100644
--- a/include/efi_default_filename.h
+++ b/include/efi_default_filename.h
@@ -47,6 +47,8 @@
 #define BOOTEFI_NAME "BOOTRISCV32.EFI"
 #elif defined(CONFIG_ARCH_RV64I)
 #define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#elif defined(CONFIG_ARCH_LA64)
+#define BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
 #else
 #error Unsupported UEFI architecture
 #endif
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 604243603289..cb0619f27e8a 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -50,6 +50,13 @@ static int machines[] = {
 #if defined(__riscv) && (__riscv_xlen == 64)
 	IMAGE_FILE_MACHINE_RISCV64,
 #endif
+
+#if defined(__loongarch64)
+	IMAGE_FILE_MACHINE_LOONGARCH64,
+#endif
+#if defined(__loongarch32)
+	IMAGE_FILE_MACHINE_LOONGARCH32,
+#endif
 	0 };
 
 /**
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 011bcd04836d..45bdf45b5812 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -76,6 +76,10 @@ struct dyn_sym {
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
index f668cdac4ab2..1e500a5ccc35 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
@@ -35,6 +35,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 	asm volatile (".word 0xffffffff\n");
 #elif defined(CONFIG_X86)
 	asm volatile (".word 0xffff\n");
+#elif defined(CONFIG_LOONGARCH)
+	asm volatile ("break 0xf\n");
 #elif defined(CONFIG_SANDBOX)
 #if (HOST_ARCH == HOST_ARCH_ARM || HOST_ARCH == HOST_ARCH_AARCH64)
 	asm volatile (".word 0xe7f7defb\n");

-- 
2.43.0

