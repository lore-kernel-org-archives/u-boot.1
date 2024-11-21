Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D7E64004
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 18:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D8E89706;
	Thu, 21 Nov 2024 19:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VXpNfSJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B727F88F7B; Thu, 21 Nov 2024 19:47:35 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F7C89706
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 19:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so86035366b.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732214853; x=1732819653; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mATwiy8o01/ntR3HFZNFSCa4bnQKw2v8lklR0lBTksQ=;
 b=VXpNfSJZPTrZJR6CSEgdF7CkmKQxZdWaqYslvMKVBW3cpGK7mfe/v4Y2XlC+rzNa9a
 iZfWMDva1BnE1STUksQDu+jESp4q1P+osSLBwbypMfMajv+78yBE1vmFejStKPdofp9V
 VSCJr5TB9+XVdijlQNPEOPmkbad04PIcU1pxY8Rf3hjGXRI2yTGuVZ+prZmUGR5OUOvF
 76HHI7ET8fwXvqsy9CqpULAjnzTcFX/12pVhGSqUlWxAqaRYcNfF45FhQjxlYIKa0zcY
 9OJiEHmyDA0rjAyxyTeiSTG36j0qWo892okNzAcZL7ZiNCaJEu7B18w+AslMvy+529F4
 hSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732214853; x=1732819653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mATwiy8o01/ntR3HFZNFSCa4bnQKw2v8lklR0lBTksQ=;
 b=AfsdoeRVlVfkENDCxXTc21v423uRcWBQ89jzu9d32iNWiuauQDBFEVu9eyxA5Kl50/
 cactbZwlSLfTJgqCM/UH+gBXwccpkLg24jHYWupls3tj5hcYzycl74gr+r4+XH2OVt86
 107cl3goV9P9LE5B7/mbTAtwLTOgj2bfdW/rHb4DS5z76szkNRK0lEHQ8A3yPt54Oeyc
 6SpzplIjoSkZyaF5cyylDtblKraWzIFrNPTwnWb7Zoi6WRHOFgCuRV4zCItAHvtAPV7Z
 57pr9CQaO6n09/CXjuVIIR46148IZUnf9Y1hqxI9akMCED9AJXBnWlyLAj/gAVAPpdjU
 V5Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRS4ykR/uMzxLub/Q4B0E+FEvI9oNDzuC+/gQ5zJ9To50prNqv63feFDltoeb46p5shQFM/l8=@lists.denx.de
X-Gm-Message-State: AOJu0YzOSLbYUgTR84ZHTxvml8Ft+DtCkoppJgJ3P3bMpJtPljO2hFrM
 jKrugvZHN+kicm/q3JZXcScm61AUCHI86Bl8nDq3j8EESKkuPtmozWK1fGAc1RGvrqka/C9JPzw
 FrWTaPDIrp0CEnLb7+GGsUqzbWQXL2T5BAkdABA==
X-Gm-Gg: ASbGnctMeSh9ZqqUYpeP7MfPHh7rolgmDzFCYxU8WLaub+KTniaTXiymltTsmxlGl6g
 2ZQaQVXBfCx7nmsG8nkNKl3HEh/qtC0+W
X-Google-Smtp-Source: AGHT+IE8kjHMIblQRLdnRz9qt7cQ+5UL+xHO8NDy5A5E/pp4os7A4QdBjern70lts0wmRskjM4wBEHj2kb4Kx1lyDkQ=
X-Received: by 2002:a05:6402:27d3:b0:5cf:cfa8:d6cf with SMTP id
 4fb4d7f45d1cf-5cff4c34147mr8046527a12.17.1732214852591; Thu, 21 Nov 2024
 10:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
 <b4bbd3db-c099-44d0-b532-99070865d55c@gmx.de>
 <20241121140155.GI3600562@bill-the-cat>
 <294edbe6-4e91-495f-923a-71c196a29514@gmx.de>
In-Reply-To: <294edbe6-4e91-495f-923a-71c196a29514@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 22 Nov 2024 00:17:21 +0530
Message-ID: <CADg8p959BP5JQuJN3d0v4DAT_Z8sfRfdRHJ4ZEiz45zTY5ZyhA@mail.gmail.com>
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anton.Antonov@arm.com, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <sean.anderson@seco.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de, 
 E Shattow <lucent@gmail.com>, minda.chen@starfivetech.com,
 hal.feng@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 21 Nov 2024 at 19:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 21.11.24 15:01, Tom Rini wrote:
> > On Thu, Nov 21, 2024 at 02:53:53PM +0100, Heinrich Schuchardt wrote:
> >> On 30.08.24 13:45, Ilias Apalodimas wrote:
> >>> The EFI_LOADER and EFI config options are randomly scattered under lib/
> >>> making it cumbersome to navigate and enable options, unless you really
> >>> know what you are doing. On top of that the existing options are in
> >>> random order instead of a logical one.
> >>>
> >>> So let's move things around a bit and move them under boot/. Present a
> >>> generic UEFI entry where people can select Capsules, Protocols,
> >>> Services,  and an option to compile U-Boot as an EFI for X86
> >>>
> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>> ---
> >>> Changes since v1:
> >>> - Move the EFI Loader under boot/ instead of having it on the main menu
> >>> - Fold in the U-Boot as an EFI app option under the new EFI menu
> >>>    boot/Kconfig           |   2 +
> >>>    lib/Kconfig            |   2 -
> >>>    lib/efi/Kconfig        |   5 +
> >>>    lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++------------------
> >>>    4 files changed, 124 insertions(+), 89 deletions(-)
> >>>
> >>> diff --git a/boot/Kconfig b/boot/Kconfig
> >>> index 940389d4882f..a1477eb8c7e1 100644
> >>> --- a/boot/Kconfig
> >>> +++ b/boot/Kconfig
> >>> @@ -1,5 +1,7 @@
> >>>    menu "Boot options"
> >>>
> >>> +source "lib/efi_loader/Kconfig"
> >>> +
> >>>    menu "Boot images"
> >>>
> >>>    config ANDROID_BOOT_IMAGE
> >>> diff --git a/lib/Kconfig b/lib/Kconfig
> >>> index 2059219a1207..06b4e9a73135 100644
> >>> --- a/lib/Kconfig
> >>> +++ b/lib/Kconfig
> >>> @@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
> >>>     help
> >>>       A simple parser for SMBIOS data.
> >>>
> >>> -source "lib/efi/Kconfig"
> >>> -source "lib/efi_loader/Kconfig"
> >>>    source "lib/optee/Kconfig"
> >>>
> >>>    config TEST_FDTDEC
> >>> diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
> >>> index c2b9bb73f718..81ed3e66b34d 100644
> >>> --- a/lib/efi/Kconfig
> >>> +++ b/lib/efi/Kconfig
> >>> @@ -1,3 +1,6 @@
> >>> +menu "U-Boot as UEFI application"
> >>> +   depends on X86
> >>> +
> >>>    config EFI
> >>>     bool "Support running U-Boot from EFI"
> >>>     depends on X86
> >>> @@ -72,3 +75,5 @@ config EFI_RAM_SIZE
> >>>       use. U-Boot allocates this from EFI on start-up (along with a few
> >>>       other smaller amounts) and it can never be increased after that.
> >>>       It is used as the RAM size in with U-Boot.
> >>> +
> >>> +endmenu
> >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>> index 6ffefa9103ff..0756be61d688 100644
> >>> --- a/lib/efi_loader/Kconfig
> >>> +++ b/lib/efi_loader/Kconfig
> >>> @@ -1,3 +1,5 @@
> >>> +menu "UEFI Support"
> >>> +
> >>>    config EFI_LOADER
> >>>     bool "Support running UEFI applications"
> >>>     depends on OF_LIBFDT && ( \
> >>> @@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
> >>>       You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
> >>>       command to do that.
> >>>
> >>> -config EFI_BOOTMGR
> >>> -   bool "UEFI Boot Manager"
> >>> +config EFI_SECURE_BOOT
> >>> +   bool "Enable EFI secure boot support"
> >>> +   depends on EFI_LOADER && FIT_SIGNATURE
> >>> +   select HASH
> >>> +   select SHA256
> >>> +   select RSA
> >>> +   select RSA_VERIFY_WITH_PKEY
> >>> +   select IMAGE_SIGN_INFO
> >>> +   select ASYMMETRIC_KEY_TYPE
> >>> +   select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> >>> +   select X509_CERTIFICATE_PARSER
> >>> +   select PKCS7_MESSAGE_PARSER
> >>> +   select PKCS7_VERIFY
> >>> +   select MSCODE_PARSER
> >>> +   select EFI_SIGNATURE_SUPPORT
> >>> +   help
> >>> +     Select this option to enable EFI secure boot support.
> >>> +     Once SecureBoot mode is enforced, any EFI binary can run only if
> >>> +     it is signed with a trusted key. To do that, you need to install,
> >>> +     at least, PK, KEK and db.
> >>> +
> >>> +config EFI_SIGNATURE_SUPPORT
> >>> +   bool
> >>> +
> >>> +menu "UEFI services"
> >>> +
> >>> +config EFI_GET_TIME
> >>> +   bool "GetTime() runtime service"
> >>> +   depends on DM_RTC
> >>>     default y
> >>>     help
> >>> -     Select this option if you want to select the UEFI binary to be booted
> >>> -     via UEFI variables Boot####, BootOrder, and BootNext. You should also
> >>> -     normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
> >>> +     Provide the GetTime() runtime service at boottime. This service
> >>> +     can be used by an EFI application to read the real time clock.
> >>> +
> >>> +config EFI_SET_TIME
> >>> +   bool "SetTime() runtime service"
> >>> +   depends on EFI_GET_TIME
> >>> +   default y if ARCH_QEMU || SANDBOX
> >>> +   help
> >>> +     Provide the SetTime() runtime service at boottime. This service
> >>> +     can be used by an EFI application to adjust the real time clock.
> >>> +
> >>> +config EFI_HAVE_RUNTIME_RESET
> >>> +   # bool "Reset runtime service is available"
> >>> +   bool
> >>> +   default y
> >>> +   depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> >>> +              SANDBOX || SYSRESET_SBI || SYSRESET_X86
> >>> +
> >>> +endmenu
> >>> +
> >>> +menu "UEFI Variables"
> >>>
> >>>    choice
> >>>     prompt "Store for non-volatile UEFI variables"
> >>> @@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
> >>>
> >>>       Minimum 4096, default 131072
> >>>
> >>> -config EFI_GET_TIME
> >>> -   bool "GetTime() runtime service"
> >>> -   depends on DM_RTC
> >>> -   default y
> >>> +config EFI_PLATFORM_LANG_CODES
> >>> +   string "Language codes supported by firmware"
> >>> +   default "en-US"
> >>>     help
> >>> -     Provide the GetTime() runtime service at boottime. This service
> >>> -     can be used by an EFI application to read the real time clock.
> >>> +     This value is used to initialize the PlatformLangCodes variable. Its
> >>> +     value is a semicolon (;) separated list of language codes in native
> >>> +     RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> >>> +     to initialize the PlatformLang variable.
> >>>
> >>> -config EFI_SET_TIME
> >>> -   bool "SetTime() runtime service"
> >>> -   depends on EFI_GET_TIME
> >>> -   default y if ARCH_QEMU || SANDBOX
> >>> -   help
> >>> -     Provide the SetTime() runtime service at boottime. This service
> >>> -     can be used by an EFI application to adjust the real time clock.
> >>> +endmenu
> >>>
> >>> -config EFI_SCROLL_ON_CLEAR_SCREEN
> >>> -   bool "Avoid overwriting previous output on clear screen"
> >>> -   help
> >>> -     Instead of erasing the screen content when the console screen should
> >>> -     be cleared, emit blank new lines so that previous output is scrolled
> >>> -     out of sight rather than overwritten. On serial consoles this allows
> >>> -     to capture complete boot logs (except for interactive menus etc.)
> >>> -     and can ease debugging related issues.
> >>> +menu "Capsule support"
> >>>
> >>>    config EFI_HAVE_CAPSULE_SUPPORT
> >>>     bool
> >>> @@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
> >>>       embedded in the platform's device tree and used for capsule
> >>>       authentication at the time of capsule update.
> >>>
> >>> +endmenu
> >>> +
> >>> +menu "UEFI protocol support"
> >>> +
> >>>    config EFI_DEVICE_PATH_TO_TEXT
> >>>     bool "Device path to text protocol"
> >>>     default y
> >>> @@ -362,39 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
> >>>
> >>>    endif
> >>>
> >>> -config EFI_LOADER_BOUNCE_BUFFER
> >>> -   bool "EFI Applications use bounce buffers for DMA operations"
> >>> -   help
> >>> -     Some hardware does not support DMA to full 64bit addresses. For this
> >>> -     hardware we can create a bounce buffer so that payloads don't have to
> >>> -     worry about platform details.
> >>> -
> >>> -config EFI_PLATFORM_LANG_CODES
> >>> -   string "Language codes supported by firmware"
> >>> -   default "en-US"
> >>> -   help
> >>> -     This value is used to initialize the PlatformLangCodes variable. Its
> >>> -     value is a semicolon (;) separated list of language codes in native
> >>> -     RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> >>> -     to initialize the PlatformLang variable.
> >>> -
> >>> -config EFI_HAVE_RUNTIME_RESET
> >>> -   # bool "Reset runtime service is available"
> >>> -   bool
> >>> -   default y
> >>> -   depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> >>> -              SANDBOX || SYSRESET_SBI || SYSRESET_X86
> >>> -
> >>> -config EFI_GRUB_ARM32_WORKAROUND
> >>> -   bool "Workaround for GRUB on 32bit ARM"
> >>> -   default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> >>> -   default y
> >>> -   depends on ARM && !ARM64
> >>> -   help
> >>> -     GRUB prior to version 2.04 requires U-Boot to disable caches. This
> >>> -     workaround currently is also needed on systems with caches that
> >>> -     cannot be managed via CP15.
> >>> -
> >>>    config EFI_RNG_PROTOCOL
> >>>     bool "EFI_RNG_PROTOCOL support"
> >>>     depends on DM_RNG
> >>> @@ -447,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
> >>>       installed and Linux 5.7+ will ignore any initrd=<ramdisk> command line
> >>>       argument.
> >>>
> >>> -config EFI_SECURE_BOOT
> >>> -   bool "Enable EFI secure boot support"
> >>> -   depends on EFI_LOADER && FIT_SIGNATURE
> >>> -   select HASH
> >>> -   select SHA256
> >>> -   select RSA
> >>> -   select RSA_VERIFY_WITH_PKEY
> >>> -   select IMAGE_SIGN_INFO
> >>> -   select ASYMMETRIC_KEY_TYPE
> >>> -   select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> >>> -   select X509_CERTIFICATE_PARSER
> >>> -   select PKCS7_MESSAGE_PARSER
> >>> -   select PKCS7_VERIFY
> >>> -   select MSCODE_PARSER
> >>> -   select EFI_SIGNATURE_SUPPORT
> >>> +config EFI_RISCV_BOOT_PROTOCOL
> >>> +   bool "RISCV_EFI_BOOT_PROTOCOL support"
> >>> +   default y
> >>> +   depends on RISCV
> >>>     help
> >>> -     Select this option to enable EFI secure boot support.
> >>> -     Once SecureBoot mode is enforced, any EFI binary can run only if
> >>> -     it is signed with a trusted key. To do that, you need to install,
> >>> -     at least, PK, KEK and db.
> >>> +     The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> >>> +     to the next boot stage. It should be enabled as it is meant to
> >>> +     replace the transfer via the device-tree. The latter is not
> >>> +     possible on systems using ACPI.
> >>>
> >>> -config EFI_SIGNATURE_SUPPORT
> >>> -   bool
> >>> +endmenu
> >>> +
> >>> +menu "Misc options"
> >>> +config EFI_LOADER_BOUNCE_BUFFER
> >>> +   bool "EFI Applications use bounce buffers for DMA operations"
> >>> +   depends on ARM64
> >>
> >> Hello Ilias,
> >>
> >> your merged patch revoked
> >>
> >> dcd1b63b7072 ("efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
> >> architectures")
> >>
> >> which we need to fix problems on JH7110 boards with more than 4 GiB.
> >>
> >> We need to add the revoked patch again.
> >>
> >
> > Can we do that as a "today" solution, and make EFI_LOADER_BOUNCE_BUFFER
> > disappear and just be enabled by BOUNCE_BUFFER for v2025.04 please?
> >
>
> As discussed with Simon the implementation of a bounce buffer should
> only exist in the block device layer and not in the UEFI sub-system. We
> should strive to make that change with the April release.
>
> But as off today JH7110 board with more than 4 GiB fail to boot without
> this setting.

Also, another thing to check (probably with respective board
maintainers) would be if we can remove the ram_top restriction on
jh7110 boards. There is a comment in arch/riscv/cpu/jh7110/dram.c that
the ram_top limit is to get 32 bit DMA capable devices to work. But
that should not be an issue with bounce buffers enabled?

-sughosh

>
> Best regards
>
> Heinrich
