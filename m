Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CFFC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908A7809A4;
	Sun,  9 Feb 2025 03:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TYtN76tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0150B8091A; Sun,  9 Feb 2025 03:02:13 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BCC809A5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d051dca3b6so12263475ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066526; x=1739671326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mu653RLQsXsWeWb6m0AEHwLXwguonPXFebX1ipwaL1s=;
 b=TYtN76tkoNtG1t0un28au90tR73O1Xk2a9fx2QcxFiW7r2bXmtCVFbY/5XS6a/+drH
 iIs1QCu7PkRMv14MnzJxdqQGZeDa2Tn+swRKG44lV44cXHsadksb84vCZQwccKU/kS5v
 qsjZz8y/MYX5E4cSdnOF8FtM/pSPPtpnoeP4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066526; x=1739671326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mu653RLQsXsWeWb6m0AEHwLXwguonPXFebX1ipwaL1s=;
 b=CTOq/bfSSeLbTeFTYX1VojdZ9VrJbNiOItMmx3EalSIvJQoqc01QMgPtk4/tQtMdvM
 O8bFmI3eGw0xwaUePU37uvJEQaFKwMDhu5CPjJID/a/aQzU29GmsLzh3PuViZPU9We9n
 avWn96oIYm24YIq//mPcwRO29LU+YQda0jx6l+k6bSmoHbyQ00vZwTKfoPGdtWVvFYQC
 YgTWyHrVqd+BIOb45nmAE79gL+UGg/gyXiKjx0sfNCTvDa9qilxtlqCMHN1oRPKQzkrn
 kfcqHo9G/16f/ed6TQ1XjSoLsjI3/rwyqDFf80y8UHcA/4FeyZUO6fb5i6XooJ7Dkzer
 v3OQ==
X-Gm-Message-State: AOJu0Yz4L/FkAJzZdTsCcFnmHj/BphsZNwb6y87bUKGkxv5V6wJSS4C5
 OxxpJO+iRV6RRezCqtoFqTnsFb/RrmtES5s+tLKWrVHK3R2tpsyaXb6ibORksgvewRwhCgZN96k
 =
X-Gm-Gg: ASbGncv0d0RYrtlqvPJcBnWQXavU3KCyWITSakAlT6oKF4hMKwL/b6OkkhW2LsnyloF
 3Su0hLw7Bp+Gc7rs7mOP6+kqQWNsjIHM2iJtQdfE4VYlKo+aHPLDMC3nqFzixJ5Wtjm5dMUbVJr
 XtYZDpvdnYE5hU+okXUS8SwX8+Lyu1z9x0owIkhrMzWZ1E0z1z1pAkhJFj3Db5gMw4xfYhuel8z
 g+vZXjNi6xeNvdaLJmSCjJ5jNsBRE9V6WEQ4/eaOpIwtxh+gI0tVz1g0B6L1QeQJTkS63BSZIZ+
 lJP5h488kA9RA/GkKaIsYg6s6XTGWTnIth20cybS1b0C2Zopi//7
X-Google-Smtp-Source: AGHT+IE8byLBroh/ibESp8BhDzMZpST3o/PhjMwHreZfU7s4VjmZvaEg/xZOKmTQSQ3VXRBdySl5ag==
X-Received: by 2002:a05:6e02:3c05:b0:3cf:e76b:3937 with SMTP id
 e9e14a558f8ab-3d13db4808emr71514955ab.0.1739066525785; 
 Sat, 08 Feb 2025 18:02:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/29] treewide: Rename VENDOR_EFI to ARCH_EFI
Date: Sat,  8 Feb 2025 19:01:07 -0700
Message-ID: <20250209020136.4108987-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

