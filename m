Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30971CF58F4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EC2893A3;
	Fri, 20 Sep 2024 11:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXjwJQdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B08892DA; Fri, 20 Sep 2024 03:39:51 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D4B8919A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 03:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=akashi.tkhro@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d8abac30ddso1383974a91.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 18:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726796387; x=1727401187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yZJRmwfhPlHfrwwJkgw8sJnH42IEBZL1ejXGgJH54WI=;
 b=iXjwJQdri2kf+n/u7kFDNUZeIUHPjglrvUvnflKe8oQbhgwUbA5mWVzyQWSPywD4al
 IqCqexIaQ8tak2VTopggHNt9nH7GL+17A9jyR/Z4Xl5ocRr7szWCHBBl9flsb61AItYa
 S5XAcNwHwreLajfCJtcdNVuqxu5J//7GtbEMVnl0/Ypbef44WkjHfPPnFnl9Ri9Pyn3Y
 vi02N4ytTiZvioDAHvYhKaRNg4QPCMFzZM7ndiZOZQtmWzr0p1KXOzQynlZyo5CrbBgw
 R4/ejkyu3dtVEMfEd+JDTqct/yDOOQxUNAg8G4adO7WAF9/6ZHzBttcSRXylaaVqVEhZ
 ZCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726796387; x=1727401187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yZJRmwfhPlHfrwwJkgw8sJnH42IEBZL1ejXGgJH54WI=;
 b=bQLRzuqmPC30/tnsEmCKJMnQergeHY+O5u8DKnc40VonkluWLZCB8Yu67B6GbfcFc7
 PAK+v31aatg7ZasEXCC5XAxy5bea0bGomrncQ8la5lxfhfQl2DfXTgIkFEGa3ofolbyY
 tKUd+P/VzTj1i6GQtV7V17VjwX1YukFpyKfHHYm7FCyvs+cmzPbzeN8z03BZ4JoZKraN
 Sdte7S7YPA1DdARgQugfme5rDkfdWj4tiAVQososuhBG9nzmt0LJ8+kk3bHmxSdmFw74
 FccwdeHE3uCWOSTJcxKXvhSwJOyTOPkjzWLCw7tMwO3mrVKqbrRq6g32K6Y3zZBlFrcC
 /UbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpCHQ23dWEC4Hk2D1Pg4UJ6MowAaen6rvrUCgv8zXLMKh/LxXhjQ/oapexu0BF9/JOSZyabU8=@lists.denx.de
X-Gm-Message-State: AOJu0YwE1equ8+DakXRcfdLaiA9OT0bAyd6g56HmhR1bsL8akdgd/QMw
 EEp1/sfZcXPbNMvq+zeRHqC0lExmeUbAywL8OrKDGwFfxvqokoybP5RNyXGKe6+EBG7DsshA3Oz
 ZEmXBsYgA7BCA++9PuLWhMHZXCu4=
X-Google-Smtp-Source: AGHT+IFuLDXhMAgGBNeWwgnZi5qvbVVRg7YXfOSJoPuKt63qutuk/LOFx0bEshWgnvXezsbFDhV5ZAw5QXP10TCPBYc=
X-Received: by 2002:a17:90a:ad92:b0:2d8:abdf:2ca9 with SMTP id
 98e67ed59e1d1-2dd7f37f258mr1657717a91.3.1726796387118; Thu, 19 Sep 2024
 18:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
From: Takahiro AKASHI <akashi.tkhro@gmail.com>
Date: Fri, 20 Sep 2024 10:39:36 +0900
Message-ID: <CAAmdEy2HD9tqU2OqqqhmnArK_BUbaiVBozf0XLNX1JSt9iT+tw@mail.gmail.com>
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Anton.Antonov@arm.com, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 20 Sep 2024 11:15:35 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 30 Aug 2024 at 20:45, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:
>
> The EFI_LOADER and EFI config options are randomly scattered under lib/
> making it cumbersome to navigate and enable options, unless you really
> know what you are doing. On top of that the existing options are in
> random order instead of a logical one.
>
> So let's move things around a bit and move them under boot/. Present a
> generic UEFI entry where people can select Capsules, Protocols,
> Services,  and an option to compile U-Boot as an EFI for X86
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - Move the EFI Loader under boot/ instead of having it on the main menu
> - Fold in the U-Boot as an EFI app option under the new EFI menu
>  boot/Kconfig           |   2 +
>  lib/Kconfig            |   2 -
>  lib/efi/Kconfig        |   5 +
>  lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++------------------
>  4 files changed, 124 insertions(+), 89 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 940389d4882f..a1477eb8c7e1 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1,5 +1,7 @@
>  menu "Boot options"
>
> +source "lib/efi_loader/Kconfig"
> +
>  menu "Boot images"
>
>  config ANDROID_BOOT_IMAGE
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 2059219a1207..06b4e9a73135 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
>         help
>           A simple parser for SMBIOS data.
>
> -source "lib/efi/Kconfig"
> -source "lib/efi_loader/Kconfig"
>  source "lib/optee/Kconfig"
>
>  config TEST_FDTDEC
> diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
> index c2b9bb73f718..81ed3e66b34d 100644
> --- a/lib/efi/Kconfig
> +++ b/lib/efi/Kconfig
> @@ -1,3 +1,6 @@
> +menu "U-Boot as UEFI application"
> +       depends on X86
> +
>  config EFI
>         bool "Support running U-Boot from EFI"
>         depends on X86
> @@ -72,3 +75,5 @@ config EFI_RAM_SIZE
>           use. U-Boot allocates this from EFI on start-up (along with a
few
>           other smaller amounts) and it can never be increased after that.
>           It is used as the RAM size in with U-Boot.
> +
> +endmenu
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 6ffefa9103ff..0756be61d688 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -1,3 +1,5 @@
> +menu "UEFI Support"
> +
>  config EFI_LOADER
>         bool "Support running UEFI applications"
>         depends on OF_LIBFDT && ( \
> @@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
>           You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
>           command to do that.
>
> -config EFI_BOOTMGR
> -       bool "UEFI Boot Manager"
> +config EFI_SECURE_BOOT
> +       bool "Enable EFI secure boot support"
> +       depends on EFI_LOADER && FIT_SIGNATURE
> +       select HASH
> +       select SHA256
> +       select RSA
> +       select RSA_VERIFY_WITH_PKEY
> +       select IMAGE_SIGN_INFO
> +       select ASYMMETRIC_KEY_TYPE
> +       select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select X509_CERTIFICATE_PARSER
> +       select PKCS7_MESSAGE_PARSER
> +       select PKCS7_VERIFY
> +       select MSCODE_PARSER
> +       select EFI_SIGNATURE_SUPPORT
> +       help
> +         Select this option to enable EFI secure boot support.
> +         Once SecureBoot mode is enforced, any EFI binary can run only if
> +         it is signed with a trusted key. To do that, you need to
install,
> +         at least, PK, KEK and db.
> +
> +config EFI_SIGNATURE_SUPPORT
> +       bool
> +
> +menu "UEFI services"
> +
> +config EFI_GET_TIME
> +       bool "GetTime() runtime service"
> +       depends on DM_RTC
>         default y
>         help
> -         Select this option if you want to select the UEFI binary to be
booted
> -         via UEFI variables Boot####, BootOrder, and BootNext. You
should also
> -         normally enable CMD_BOOTEFI_BOOTMGR so that the command is
available.
> +         Provide the GetTime() runtime service at boottime. This service
> +         can be used by an EFI application to read the real time clock.
> +
> +config EFI_SET_TIME
> +       bool "SetTime() runtime service"
> +       depends on EFI_GET_TIME
> +       default y if ARCH_QEMU || SANDBOX
> +       help
> +         Provide the SetTime() runtime service at boottime. This service
> +         can be used by an EFI application to adjust the real time clock.
> +
> +config EFI_HAVE_RUNTIME_RESET
> +       # bool "Reset runtime service is available"
> +       bool
> +       default y
> +       depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> +                  SANDBOX || SYSRESET_SBI || SYSRESET_X86
> +
> +endmenu
> +
> +menu "UEFI Variables"
>
>  choice
>         prompt "Store for non-volatile UEFI variables"
> @@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
>
>           Minimum 4096, default 131072
>
> -config EFI_GET_TIME
> -       bool "GetTime() runtime service"
> -       depends on DM_RTC
> -       default y
> +config EFI_PLATFORM_LANG_CODES
> +       string "Language codes supported by firmware"
> +       default "en-US"
>         help
> -         Provide the GetTime() runtime service at boottime. This service
> -         can be used by an EFI application to read the real time clock.
> +         This value is used to initialize the PlatformLangCodes
variable. Its
> +         value is a semicolon (;) separated list of language codes in
native
> +         RFC 4646 format, e.g. "en-US;de-DE". The first language code is
used
> +         to initialize the PlatformLang variable.
>
> -config EFI_SET_TIME
> -       bool "SetTime() runtime service"
> -       depends on EFI_GET_TIME
> -       default y if ARCH_QEMU || SANDBOX
> -       help
> -         Provide the SetTime() runtime service at boottime. This service
> -         can be used by an EFI application to adjust the real time clock.
> +endmenu
>
> -config EFI_SCROLL_ON_CLEAR_SCREEN
> -       bool "Avoid overwriting previous output on clear screen"
> -       help
> -         Instead of erasing the screen content when the console screen
should
> -         be cleared, emit blank new lines so that previous output is
scrolled
> -         out of sight rather than overwritten. On serial consoles this
allows
> -         to capture complete boot logs (except for interactive menus
etc.)
> -         and can ease debugging related issues.
> +menu "Capsule support"
>
>  config EFI_HAVE_CAPSULE_SUPPORT
>         bool
> @@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
>           embedded in the platform's device tree and used for capsule
>           authentication at the time of capsule update.
>
> +endmenu
> +
> +menu "UEFI protocol support"
> +
>  config EFI_DEVICE_PATH_TO_TEXT
>         bool "Device path to text protocol"
>         default y
> @@ -362,39 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
>
>  endif
>
> -config EFI_LOADER_BOUNCE_BUFFER
> -       bool "EFI Applications use bounce buffers for DMA operations"
> -       help
> -         Some hardware does not support DMA to full 64bit addresses. For
this
> -         hardware we can create a bounce buffer so that payloads don't
have to
> -         worry about platform details.
> -
> -config EFI_PLATFORM_LANG_CODES
> -       string "Language codes supported by firmware"
> -       default "en-US"
> -       help
> -         This value is used to initialize the PlatformLangCodes
variable. Its
> -         value is a semicolon (;) separated list of language codes in
native
> -         RFC 4646 format, e.g. "en-US;de-DE". The first language code is
used
> -         to initialize the PlatformLang variable.
> -
> -config EFI_HAVE_RUNTIME_RESET
> -       # bool "Reset runtime service is available"
> -       bool
> -       default y
> -       depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> -                  SANDBOX || SYSRESET_SBI || SYSRESET_X86
> -
> -config EFI_GRUB_ARM32_WORKAROUND
> -       bool "Workaround for GRUB on 32bit ARM"
> -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> -       default y
> -       depends on ARM && !ARM64
> -       help
> -         GRUB prior to version 2.04 requires U-Boot to disable caches.
This
> -         workaround currently is also needed on systems with caches that
> -         cannot be managed via CP15.
> -
>  config EFI_RNG_PROTOCOL
>         bool "EFI_RNG_PROTOCOL support"
>         depends on DM_RNG
> @@ -447,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
>           installed and Linux 5.7+ will ignore any initrd=<ramdisk>
command line
>           argument.
>
> -config EFI_SECURE_BOOT
> -       bool "Enable EFI secure boot support"
> -       depends on EFI_LOADER && FIT_SIGNATURE
> -       select HASH
> -       select SHA256
> -       select RSA
> -       select RSA_VERIFY_WITH_PKEY
> -       select IMAGE_SIGN_INFO
> -       select ASYMMETRIC_KEY_TYPE
> -       select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> -       select X509_CERTIFICATE_PARSER
> -       select PKCS7_MESSAGE_PARSER
> -       select PKCS7_VERIFY
> -       select MSCODE_PARSER
> -       select EFI_SIGNATURE_SUPPORT
> +config EFI_RISCV_BOOT_PROTOCOL
> +       bool "RISCV_EFI_BOOT_PROTOCOL support"
> +       default y
> +       depends on RISCV
>         help
> -         Select this option to enable EFI secure boot support.
> -         Once SecureBoot mode is enforced, any EFI binary can run only if
> -         it is signed with a trusted key. To do that, you need to
install,
> -         at least, PK, KEK and db.
> +         The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> +         to the next boot stage. It should be enabled as it is meant to
> +         replace the transfer via the device-tree. The latter is not
> +         possible on systems using ACPI.
>
> -config EFI_SIGNATURE_SUPPORT
> -       bool
> +endmenu
> +
> +menu "Misc options"
> +config EFI_LOADER_BOUNCE_BUFFER
> +       bool "EFI Applications use bounce buffers for DMA operations"
> +       depends on ARM64
> +       help
> +         Some hardware does not support DMA to full 64bit addresses. For
this
> +         hardware we can create a bounce buffer so that payloads don't
have to
> +         worry about platform details.
> +
> +config EFI_GRUB_ARM32_WORKAROUND
> +       bool "Workaround for GRUB on 32bit ARM"
> +       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> +       default y
> +       depends on ARM && !ARM64
> +       help
> +         GRUB prior to version 2.04 requires U-Boot to disable caches.
This
> +         workaround currently is also needed on systems with caches that
> +         cannot be managed via CP15.
>
>  config EFI_ESRT
>         bool "Enable the UEFI ESRT generation"
> @@ -496,15 +509,26 @@ config EFI_EBBR_2_1_CONFORMANCE
>         help
>           Enabling this option adds the EBBRv2.1 conformance entry to the
ECPT UEFI table.
>
> -config EFI_RISCV_BOOT_PROTOCOL
> -       bool "RISCV_EFI_BOOT_PROTOCOL support"
> +config EFI_SCROLL_ON_CLEAR_SCREEN
> +       bool "Avoid overwriting previous output on clear screen"
> +       help
> +         Instead of erasing the screen content when the console screen
should
> +         be cleared, emit blank new lines so that previous output is
scrolled
> +         out of sight rather than overwritten. On serial consoles this
allows
> +         to capture complete boot logs (except for interactive menus
etc.)
> +         and can ease debugging related issues.
> +
> +endmenu
> +
> +menu "EFI bootmanager"
> +
> +config EFI_BOOTMGR
> +       bool "UEFI Boot Manager"
>         default y
> -       depends on RISCV
>         help
> -         The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> -         to the next boot stage. It should be enabled as it is meant to
> -         replace the transfer via the device-tree. The latter is not
> -         possible on systems using ACPI.
> +         Select this option if you want to select the UEFI binary to be
booted
> +         via UEFI variables Boot####, BootOrder, and BootNext. You
should also
> +         normally enable CMD_BOOTEFI_BOOTMGR so that the command is
available.
>
>  config EFI_HTTP_BOOT
>         bool "EFI HTTP Boot support"
> @@ -514,5 +538,11 @@ config EFI_HTTP_BOOT
>         help
>           Enabling this option adds EFI HTTP Boot support. It allows to
>           directly boot from network.
> +endmenu
>
>  endif
> +
> +source "lib/efi/Kconfig"

While you might have already discussed the issue, it looks weird to me that
lib/efi/Kconfig
is contained in lib/efi_loader/Kconfig.

-Takahiro AKASHI

> +
> +endmenu
> +
> --
> 2.45.2
