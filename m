Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBDFC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 13:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB8D889A1;
	Wed, 14 Aug 2024 15:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rcXfXZFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B0D889AA; Wed, 14 Aug 2024 15:45:26 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50AFA8800C
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 15:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso147633466b.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723643124; x=1724247924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WYvq+6z9nIfhAeMp3Z3ruvOS53QGblg9BL0clQ06/5g=;
 b=rcXfXZFbVlg4Tw4cHj27B6F97lntjt1NYy0Wd+RIJJyF9MvnzpenXK2VY2PN9FzDta
 +YEVTbaff4u1fJD5vsOvvely2UfkOtK4o30xAI3pJR3dLP6H7xvCD1Yg9fUnr3G52no5
 Jg1c8t2A6PCoie7ekWh0YELDmzw0iKmcQMglIB7R4F08hY8rkVwPGXIWfUu94AkQJGU6
 a4bwOmKwAseJLJKjhoxRAvVGzoNCIJzjKzqWlSx4gITkME01Ac2CUoxj089xCL/pgAjo
 zdXmyi3UKHk9z9Dbb+XdNmV8qITJH81uWx6+pkMIrSmPH/Yx5xdn0Z2C8yF5uOJnj1HN
 /MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723643124; x=1724247924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WYvq+6z9nIfhAeMp3Z3ruvOS53QGblg9BL0clQ06/5g=;
 b=uT9WVCHC3fhIf0YcHm8r7dcerOsJnUk1JgagQ5Vb6EKOTy9Ctq0LI2xeBDN4ktvSIk
 7v6VXc6iI1YfK3mtw/OFrkVDR10ea/12bNcmx216NlFiVYcu60OA61lNMF2sB4jCMX8K
 LSOuiw5h11E4tlJy3UXbJMAvu5ZKNBchd3lhrUhBV1SsNttWtmWO8VyFbujI49UHUlU6
 fyoedaKU5tW2n9NwX1vPCTWyaiGv70Ih3EKzGmmJFafToNqIO5gBxjhkfNcbzbumChSR
 M4WmQZGHgFrUkbkL9kwFmHBL+kBw8J1yfGY/+T47PMq6ESU9Gj6nkGZU+bx9KMMOu1nZ
 6rqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpB58MlqBBWuApfuV8qLeuMgQMnD5MVx+Z4qDCFakkPjXHn/p4dhZ7fLeEqohtzg+EDSh9ZdU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5wsh66u/4Q5diIjXPNAsd5GRD1BmKmlMdgEACDrDtC+SX5Ys6
 xdLBJ6+JJZoCruoU9oosXFNPSb1b3gJb/ZzRpXHGfU8n6UYfdBPbebSUHuWEclA=
X-Google-Smtp-Source: AGHT+IFr7Wfu0Lj7trthFirRlucH26+AGda/zTcRiDPqVQEqxHIxGwgxFbC1URgZbF9+p/cS+iLqzg==
X-Received: by 2002:a17:907:60ca:b0:a77:db39:cc04 with SMTP id
 a640c23a62f3a-a80f0aa2260mr574261166b.11.1723643123025; 
 Wed, 14 Aug 2024 06:45:23 -0700 (PDT)
Received: from localhost.localdomain (ppp046103060252.access.hol.gr.
 [46.103.60.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f4183f72sm171494866b.205.2024.08.14.06.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 06:45:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Anton.Antonov@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ian Roberts <ian.roberts@timesys.com>,
 Kever Yang <kever.yang@rock-chips.com>, Shengyu Qu <wiagn233@outlook.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Anand Moon <linux.amoon@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
Subject: [PATCH] Kconfig: clean up the efi configuration status
Date: Wed, 14 Aug 2024 16:45:17 +0300
Message-ID: <20240814134518.82692-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

The EFI_LOADER and EFI config options are randomly scattered under lib/
making it cumbersome to navigate and enable options, unless you really
know what you are doing. On top of that the existing options are in
random order instead of a logical one.

So let's move things around a bit and present two enties for the
EFI_LOADER and EFI options in the main config screen.
While at it add menus for Capsules, Protocols, and Services in the
EFI_LOADER so people can find their way around easier

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig                |   4 +
 lib/Kconfig            |   2 -
 lib/efi/Kconfig        |   5 +
 lib/efi_loader/Kconfig | 202 +++++++++++++++++++++++------------------
 4 files changed, 123 insertions(+), 90 deletions(-)

diff --git a/Kconfig b/Kconfig
index 82df59f176ec..62c5441e3576 100644
--- a/Kconfig
+++ b/Kconfig
@@ -756,3 +756,7 @@ source "lib/Kconfig"
 source "test/Kconfig"
 
 source "tools/Kconfig"
+
+source "lib/efi_loader/Kconfig"
+
+source "lib/efi/Kconfig"
diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a1207..06b4e9a73135 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
 	help
 	  A simple parser for SMBIOS data.
 
-source "lib/efi/Kconfig"
-source "lib/efi_loader/Kconfig"
 source "lib/optee/Kconfig"
 
 config TEST_FDTDEC
diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
index c2b9bb73f718..81ed3e66b34d 100644
--- a/lib/efi/Kconfig
+++ b/lib/efi/Kconfig
@@ -1,3 +1,6 @@
+menu "U-Boot as UEFI application"
+	depends on X86
+
 config EFI
 	bool "Support running U-Boot from EFI"
 	depends on X86
@@ -72,3 +75,5 @@ config EFI_RAM_SIZE
 	  use. U-Boot allocates this from EFI on start-up (along with a few
 	  other smaller amounts) and it can never be increased after that.
 	  It is used as the RAM size in with U-Boot.
+
+endmenu
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 1179c31bb136..26838d20f2de 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -1,3 +1,5 @@
+menu "UEFI Loader"
+
 config EFI_LOADER
 	bool "Support running UEFI applications"
 	depends on OF_LIBFDT && ( \
@@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
 	  You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
 	  command to do that.
 
-config EFI_BOOTMGR
-	bool "UEFI Boot Manager"
+config EFI_SECURE_BOOT
+	bool "Enable EFI secure boot support"
+	depends on EFI_LOADER && FIT_SIGNATURE
+	select HASH
+	select SHA256
+	select RSA
+	select RSA_VERIFY_WITH_PKEY
+	select IMAGE_SIGN_INFO
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER
+	select PKCS7_MESSAGE_PARSER
+	select PKCS7_VERIFY
+	select MSCODE_PARSER
+	select EFI_SIGNATURE_SUPPORT
+	help
+	  Select this option to enable EFI secure boot support.
+	  Once SecureBoot mode is enforced, any EFI binary can run only if
+	  it is signed with a trusted key. To do that, you need to install,
+	  at least, PK, KEK and db.
+
+config EFI_SIGNATURE_SUPPORT
+	bool
+
+menu "UEFI services"
+
+config EFI_GET_TIME
+	bool "GetTime() runtime service"
+	depends on DM_RTC
 	default y
 	help
-	  Select this option if you want to select the UEFI binary to be booted
-	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
-	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
+	  Provide the GetTime() runtime service at boottime. This service
+	  can be used by an EFI application to read the real time clock.
+
+config EFI_SET_TIME
+	bool "SetTime() runtime service"
+	depends on EFI_GET_TIME
+	default y if ARCH_QEMU || SANDBOX
+	help
+	  Provide the SetTime() runtime service at boottime. This service
+	  can be used by an EFI application to adjust the real time clock.
+
+config EFI_HAVE_RUNTIME_RESET
+	# bool "Reset runtime service is available"
+	bool
+	default y
+	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
+		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
+
+endmenu
+
+menu "UEFI Variables"
 
 choice
 	prompt "Store for non-volatile UEFI variables"
@@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
 
 	  Minimum 4096, default 131072
 
-config EFI_GET_TIME
-	bool "GetTime() runtime service"
-	depends on DM_RTC
-	default y
+config EFI_PLATFORM_LANG_CODES
+	string "Language codes supported by firmware"
+	default "en-US"
 	help
-	  Provide the GetTime() runtime service at boottime. This service
-	  can be used by an EFI application to read the real time clock.
+	  This value is used to initialize the PlatformLangCodes variable. Its
+	  value is a semicolon (;) separated list of language codes in native
+	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
+	  to initialize the PlatformLang variable.
 
-config EFI_SET_TIME
-	bool "SetTime() runtime service"
-	depends on EFI_GET_TIME
-	default y if ARCH_QEMU || SANDBOX
-	help
-	  Provide the SetTime() runtime service at boottime. This service
-	  can be used by an EFI application to adjust the real time clock.
+endmenu
 
-config EFI_SCROLL_ON_CLEAR_SCREEN
-	bool "Avoid overwriting previous output on clear screen"
-	help
-	  Instead of erasing the screen content when the console screen should
-	  be cleared, emit blank new lines so that previous output is scrolled
-	  out of sight rather than overwritten. On serial consoles this allows
-	  to capture complete boot logs (except for interactive menus etc.)
-	  and can ease debugging related issues.
+menu "Capsule support"
 
 config EFI_HAVE_CAPSULE_SUPPORT
 	bool
@@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
 	  embedded in the platform's device tree and used for capsule
 	  authentication at the time of capsule update.
 
+endmenu
+
+menu "UEFI protocol support"
+
 config EFI_DEVICE_PATH_TO_TEXT
 	bool "Device path to text protocol"
 	default y
@@ -362,40 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
 
 endif
 
-config EFI_LOADER_BOUNCE_BUFFER
-	bool "EFI Applications use bounce buffers for DMA operations"
-	depends on ARM64
-	help
-	  Some hardware does not support DMA to full 64bit addresses. For this
-	  hardware we can create a bounce buffer so that payloads don't have to
-	  worry about platform details.
-
-config EFI_PLATFORM_LANG_CODES
-	string "Language codes supported by firmware"
-	default "en-US"
-	help
-	  This value is used to initialize the PlatformLangCodes variable. Its
-	  value is a semicolon (;) separated list of language codes in native
-	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
-	  to initialize the PlatformLang variable.
-
-config EFI_HAVE_RUNTIME_RESET
-	# bool "Reset runtime service is available"
-	bool
-	default y
-	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
-		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
-
-config EFI_GRUB_ARM32_WORKAROUND
-	bool "Workaround for GRUB on 32bit ARM"
-	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
-	default y
-	depends on ARM && !ARM64
-	help
-	  GRUB prior to version 2.04 requires U-Boot to disable caches. This
-	  workaround currently is also needed on systems with caches that
-	  cannot be managed via CP15.
-
 config EFI_RNG_PROTOCOL
 	bool "EFI_RNG_PROTOCOL support"
 	depends on DM_RNG
@@ -448,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
 	  installed and Linux 5.7+ will ignore any initrd=<ramdisk> command line
 	  argument.
 
-config EFI_SECURE_BOOT
-	bool "Enable EFI secure boot support"
-	depends on EFI_LOADER && FIT_SIGNATURE
-	select HASH
-	select SHA256
-	select RSA
-	select RSA_VERIFY_WITH_PKEY
-	select IMAGE_SIGN_INFO
-	select ASYMMETRIC_KEY_TYPE
-	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	select X509_CERTIFICATE_PARSER
-	select PKCS7_MESSAGE_PARSER
-	select PKCS7_VERIFY
-	select MSCODE_PARSER
-	select EFI_SIGNATURE_SUPPORT
+config EFI_RISCV_BOOT_PROTOCOL
+	bool "RISCV_EFI_BOOT_PROTOCOL support"
+	default y
+	depends on RISCV
 	help
-	  Select this option to enable EFI secure boot support.
-	  Once SecureBoot mode is enforced, any EFI binary can run only if
-	  it is signed with a trusted key. To do that, you need to install,
-	  at least, PK, KEK and db.
+	  The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
+	  to the next boot stage. It should be enabled as it is meant to
+	  replace the transfer via the device-tree. The latter is not
+	  possible on systems using ACPI.
 
-config EFI_SIGNATURE_SUPPORT
-	bool
+endmenu
+
+menu "Misc options"
+config EFI_LOADER_BOUNCE_BUFFER
+	bool "EFI Applications use bounce buffers for DMA operations"
+	depends on ARM64
+	help
+	  Some hardware does not support DMA to full 64bit addresses. For this
+	  hardware we can create a bounce buffer so that payloads don't have to
+	  worry about platform details.
+
+config EFI_GRUB_ARM32_WORKAROUND
+	bool "Workaround for GRUB on 32bit ARM"
+	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
+	default y
+	depends on ARM && !ARM64
+	help
+	  GRUB prior to version 2.04 requires U-Boot to disable caches. This
+	  workaround currently is also needed on systems with caches that
+	  cannot be managed via CP15.
 
 config EFI_ESRT
 	bool "Enable the UEFI ESRT generation"
@@ -497,15 +509,26 @@ config EFI_EBBR_2_1_CONFORMANCE
 	help
 	  Enabling this option adds the EBBRv2.1 conformance entry to the ECPT UEFI table.
 
-config EFI_RISCV_BOOT_PROTOCOL
-	bool "RISCV_EFI_BOOT_PROTOCOL support"
+config EFI_SCROLL_ON_CLEAR_SCREEN
+	bool "Avoid overwriting previous output on clear screen"
+	help
+	  Instead of erasing the screen content when the console screen should
+	  be cleared, emit blank new lines so that previous output is scrolled
+	  out of sight rather than overwritten. On serial consoles this allows
+	  to capture complete boot logs (except for interactive menus etc.)
+	  and can ease debugging related issues.
+
+endmenu
+
+menu "EFI bootmanager"
+
+config EFI_BOOTMGR
+	bool "UEFI Boot Manager"
 	default y
-	depends on RISCV
 	help
-	  The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
-	  to the next boot stage. It should be enabled as it is meant to
-	  replace the transfer via the device-tree. The latter is not
-	  possible on systems using ACPI.
+	  Select this option if you want to select the UEFI binary to be booted
+	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
+	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
 
 config EFI_HTTP_BOOT
 	bool "EFI HTTP Boot support"
@@ -515,5 +538,8 @@ config EFI_HTTP_BOOT
 	help
 	  Enabling this option adds EFI HTTP Boot support. It allows to
 	  directly boot from network.
+endmenu
 
 endif
+
+endmenu
-- 
2.45.2

