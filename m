Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3272C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF47280BA4;
	Sat,  8 Feb 2025 18:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OcslA40g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A304F80AE3; Sat,  8 Feb 2025 18:12:27 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635A78083C
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85517db52a2so2491139f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034743; x=1739639543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhQoJ2rqz7jFb/cNnH3R3Dew1FMnZYuWKuXlc6BRg/g=;
 b=OcslA40gEbLy7cO4mB9al7G0qxKsvoF9E9JJeH4QHUx0fbHZXOiv+ffvWhzptllvNc
 Qll5jlaKRon3DLZnGMiBirnxw4PV8SAJ3NF21uxo3TglbCsow0vRNE3BtilAE70e01ah
 gbWlNsWqboxoYKV04gF5j3x8Q4tKnUdxOa194=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034743; x=1739639543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhQoJ2rqz7jFb/cNnH3R3Dew1FMnZYuWKuXlc6BRg/g=;
 b=grbHMvZxnj1DRF6shRZ0yU09vRkPd3JVCZ90D87GQqDb3rlUG9tfIsazRhQtw3rUXH
 HWH4uWWKuUIpBt6H4FgcKObmeGX8GtmyxVuIn6h1Q4iypdbTN3CywJjtEGg1K+kRdMei
 LZEBtUfyqTDTshxcUU88Qqiq1yCJxzHv1oRmWvR+jiYfz1syDbtR+JLmJQ7MbBICEij3
 SXL/I1vmh4agpLY9O4li45B1VY5qlXGVVVwP1kaxcX1QAt23lX2X/lm6efPOGWVwCP4C
 vvR/DpRVDlQYWXlfP07VMHM0tYe6y8rlUWWlKAtJMWRJN6RYN1Sv/y5gaGR7lq8wN93j
 cSbg==
X-Gm-Message-State: AOJu0Yx+9OABO4ctf//0/bm0HUv6SvFllzkgiqatDLz0vRQuQMr0XKSM
 N70Uy0eH8Bo9pUFmgJVcK67XRAnpYBk1ZiLeAAspxe/s7TAiAe8Jxyv1GwC3EHpwE/nHn3y7C94
 =
X-Gm-Gg: ASbGncuKJmQYRCMMKN8QJnMsYPIevcszw2KI6G9LJGpzMLS8S6TWrc2RkuK4ILna1/e
 FvNp7SWWnIhEIszlsZbDq7MN6J8mZqqueH6n9mnFKYXkGpZLUdfXvqd/C1nDHSyl6j6cRNPjmlB
 PWO5+/6AmFpvaHh1zdblGgHaYH4FL5QnNrUXckofSSGfbP5qr0q1meI9KRx5Jmhk+W6nHHXRmmG
 xhHB7eEImnVSP7G/2w0KZ+0UYWv2ivVVixnUiu+9qGO4/oa4xZdaleCYsSp0KXzjsBCxWXcJyct
 yH0+rFfuUw7VUp3PmbsylPMFPUJIqGRi2iaKMyBSXasmD5F6bokL
X-Google-Smtp-Source: AGHT+IEynQD1gFMjGHAQiCc+JB7qJKPgm5E82unsGnTcum39+UoP3Cds1g/6l2qs4sWSjhtzB7ufNw==
X-Received: by 2002:a05:6e02:190f:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3d13df2bfb0mr51251855ab.19.1739034743575; 
 Sat, 08 Feb 2025 09:12:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/29] treewide: Rename VENDOR_EFI to ARCH_EFI
Date: Sat,  8 Feb 2025 10:11:28 -0700
Message-ID: <20250208171154.1305761-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

