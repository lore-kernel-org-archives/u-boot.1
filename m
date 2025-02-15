Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8A0C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 345C680F53;
	Sat, 15 Feb 2025 04:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O2lnk6KC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B23780F0A; Sat, 15 Feb 2025 04:23:33 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E83B80F64
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so8456305ab.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589809; x=1740194609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mu653RLQsXsWeWb6m0AEHwLXwguonPXFebX1ipwaL1s=;
 b=O2lnk6KCxCcAIiaBmr0tcXlbLb/SxOvUxxzvEwVG43wAFXpbINt7rZbNrtQ4Olm20p
 m5Fena+8HrikUHq2yqt4usR2pU12NBgotF8NYsQhunW0DRL2ALAZiNkKrQMXu1Dau2LV
 9wXB4jmhPGCHNkfLUXRG/kJq7UUd6FMxm3/fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589809; x=1740194609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mu653RLQsXsWeWb6m0AEHwLXwguonPXFebX1ipwaL1s=;
 b=B3FFEPyijUwweH1GZ9Lh7iPyyoL0pWcZXCyHnjsMIcqS5ewbouRDBaU9AzBXEXMmjq
 icR/Who4odGgjEGfdbmtpuwq15H8NONFmO5JkR7Hv/+QC2upW370mwYQ/Yvw8Yqosdrb
 C8IY2URm/qVpPfkavFdQ07KHWhXP6uDLgbhsF/GuQTNymLrdK3/MdpEQRLeDaVMYFaeB
 gG42qHgrpGc59VSOhpufXvUZlSHwDjLEO0qRYMB4+DcWQoelrVd5FHL1BmeQ//dZGMH/
 UernN3+O69+MCgiyg85fLlTi9vCV/FxnLa+s9Uk6BCW78DB4vDsUdshEwY7ZWwHABng9
 Na4w==
X-Gm-Message-State: AOJu0Yzs+OQ5oo8cKuq7JP7CxRvywnleu3SAzCGFjm3GYUZo6bQiuno2
 wi5j/GilgFTj16spBw//D4FKIAOMkIceaC2QnJy8jLlNs4CA2J/LYKMLCvqMhUaANJ8aQLTkO40
 =
X-Gm-Gg: ASbGncu2dVP1HR+IIr4URE69dhnE6+PSJOl+baeY9kZMELx5zZ0iGnHjlzBwtql3atJ
 Dm7tWQUnFyzZjbdxDCsTo7X74MfVXX18w3ZKKOkdf+gxVdqYxHkJDz1laush5oWV0eJDB/2ACHw
 M5jP2z8RNytLVH+OtwFbnWRLWsfEdEEnb3e+FJpPF5Z4dradsguCMxcmeDm8ZUaFo7RDfqPmzdj
 lpJWzM2EeS63XywvP2RO+zH1CNgi6sr3hRjnjMBU5bYelIVXKlBYg5apPkICwO8H+xPWC2ESBIT
 9gjtJo39jUgBKlVaiM68JjXaNXaHpcvhHdYqfJ0uHZzzFt2phlo/
X-Google-Smtp-Source: AGHT+IFcHJpyoNe6GslV+xWd6jhZ/SN6GwriyY2IyyJ+6eTP7sbOwcfX8HbU4eVCBFGa+dEKRiLkvQ==
X-Received: by 2002:a05:6e02:2610:b0:3d1:78f1:8a86 with SMTP id
 e9e14a558f8ab-3d2809471f1mr15268655ab.15.1739589808920; 
 Fri, 14 Feb 2025 19:23:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 08/29] treewide: Rename VENDOR_EFI to ARCH_EFI
Date: Fri, 14 Feb 2025 20:22:29 -0700
Message-ID: <20250215032254.4121030-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The 'vendor' concept comes from arch/x86. Rather than letting this
spread around the tree, rename it to ARCH_EFI.

While EFI is not quite an architecture in the strict sense, it is
similar to sandbox in that it sits somewhat above the CPU architecture.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Ideas for a better name are welcome.

(no changes since v2)

Changes in v2:
- Add new patch to rename VENDOR_EFI to ARCH_EFI

 arch/arm/lib/crt0_aarch64_efi.S     | 2 +-
 arch/arm/lib/crt0_arm_efi.S         | 2 +-
 arch/riscv/lib/crt0_riscv_efi.S     | 2 +-
 arch/x86/Kconfig                    | 2 +-
 board/efi/Kconfig                   | 2 +-
 configs/efi-x86_app32_defconfig     | 2 +-
 configs/efi-x86_app64_defconfig     | 2 +-
 configs/efi-x86_payload32_defconfig | 2 +-
 configs/efi-x86_payload64_defconfig | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
index fe6eca576ec..f1d5de6a93d 100644
--- a/arch/arm/lib/crt0_aarch64_efi.S
+++ b/arch/arm/lib/crt0_aarch64_efi.S
@@ -66,7 +66,7 @@ extra_header_fields:
 	.long	_start - ImageBase		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
-#if CONFIG_VENDOR_EFI
+#if CONFIG_ARCH_EFI
 	.short	0				/* DllCharacteristics */
 #else
 	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index b5dfd4e3819..f58256223aa 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -65,7 +65,7 @@ extra_header_fields:
 	.long	_start - image_base		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION	/* Subsystem */
-#if CONFIG_VENDOR_EFI
+#if CONFIG_ARCH_EFI
 	.short	0				/* DllCharacteristics */
 #else
 	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
index c7a4559eac8..424f18480fa 100644
--- a/arch/riscv/lib/crt0_riscv_efi.S
+++ b/arch/riscv/lib/crt0_riscv_efi.S
@@ -96,7 +96,7 @@ extra_header_fields:
 	.long	_start - ImageBase		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
-#if CONFIG_VENDOR_EFI
+#if CONFIG_ARCH_EFI
 	.short	0				/* DllCharacteristics */
 #else
 	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80396a3a2d5..8c225f314ff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -65,7 +65,7 @@ config VENDOR_COREBOOT
 config VENDOR_DFI
 	bool "dfi"
 
-config VENDOR_EFI
+config ARCH_EFI
 	bool "efi"
 
 config VENDOR_EMULATION
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 7545f808585..05ac8d15d49 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -1,4 +1,4 @@
-if VENDOR_EFI
+if ARCH_EFI
 
 if X86
 
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index bfcef9afa88..0cdfe467f53 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -4,7 +4,7 @@ CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_app"
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
-CONFIG_VENDOR_EFI=y
+CONFIG_ARCH_EFI=y
 CONFIG_TARGET_EFI_X86_APP32=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 8f1319c0b4c..ca3f084ef4c 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_app"
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_X86_RUN_64BIT=y
-CONFIG_VENDOR_EFI=y
+CONFIG_ARCH_EFI=y
 CONFIG_TARGET_EFI_X86_APP64=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 48e757f629d..d96228c0694 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -3,7 +3,7 @@ CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
-CONFIG_VENDOR_EFI=y
+CONFIG_ARCH_EFI=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 2606ac261c1..9e055da297c 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -3,7 +3,7 @@ CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
-CONFIG_VENDOR_EFI=y
+CONFIG_ARCH_EFI=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
-- 
2.43.0

