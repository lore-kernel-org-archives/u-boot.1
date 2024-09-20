Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C10CF58CC
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 04:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0FA892C1;
	Fri, 20 Sep 2024 06:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zo37eltx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9748855C; Fri, 20 Sep 2024 06:49:47 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6699687BF4
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 06:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso1317749b3a.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 21:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726807783; x=1727412583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zyb8ysFqfcMLK8vBSNgykFSQX+xb5LXjNIkAG2fUPm4=;
 b=zo37eltxY+g7IMg1kdMqjP19nIE0AnyYfG8wZrdlhwxxABS0CH2EueILaXZ63vW1x4
 cItdlN0Ia4Ia1u2Lq2nbENDHuxSsCkSj4lxmZ5o17Qpthv4OYk2UCIAaNgEmR8z3GnhX
 XtjFnA4MFkKfAjYghieoT/klZ+hJ9e+7GhRyNJglkCOyaH448WY13joosPLmdTvAXAOI
 cqbgXtNKBqI0tHIyWYGwydn2hmo9klquBxRF6VFDLqQ8X6/fU3pelSs33aKnp2sI8WiU
 Dbifqgmnb9vNyylA37JTWiKCO9mAjV3dVqeYH17CXuuyZFUAY+IkyVw6m1IRbNoyJ4b1
 JL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726807783; x=1727412583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zyb8ysFqfcMLK8vBSNgykFSQX+xb5LXjNIkAG2fUPm4=;
 b=hHkUfnCusWbupVpgPMvVM335ZzBn/+3ttfr2e/c/W+4PDOtRANthzRcILUWnCar/I2
 8mvVOzQsOeModA29MZsXLaZbq8thaDIGoISKAm0Y+CqaEaEyojfNQKVRjUdxxog77XuP
 2ELoKMJszQzLrs9RebqUEqegjNKxtUS1Zzny1P6lKwPrwM6VpFr577bwbNPKdNyHu6q2
 y+84PWRilhZ1ot+Pc0sIv731z9HBCstmz5KpvWoghD2bI4GI4O0UDt7bl99/dT5ama8k
 UWqsJM4sLMtjS5Z+2K92KV+M3qqZmByBni5IEPHh+I4/hEkfBOvYaigsX/yqkIO5nxL3
 NJWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVawobiRu44EdBiLdgM6C6U8rvlCjWzyxPi2miKVkrPKDrenkSjuHqyqIQSl2GRSBqhXL8Nsxs=@lists.denx.de
X-Gm-Message-State: AOJu0YwY7XRiNQKtnp6SQzaLlve/a7OWljh4hfpHeuiBGkFWsphysXZL
 7i2uKUNuCa90WUxbBVCwKUNvDcY68Z6QdSc/WIpqP9JNaP9qE4iGMJn17WHojRxjR9EUrZP1eR7
 aw6gSU+Gkl2D2dgy3raQBmwfICOdVs+/VfvnuJQ==
X-Google-Smtp-Source: AGHT+IGZr2PopnFO+cRWwOJ4si/btbT6BDXv99ImshZf4tDYKVDIpX6T1SGQTQHDbf5iqcJOOO9mcCzNTBzDgVdwzD4=
X-Received: by 2002:a05:6a00:8d0:b0:714:3a4b:f78f with SMTP id
 d2e1a72fcca58-7199ca0372fmr2470653b3a.20.1726807782641; Thu, 19 Sep 2024
 21:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
 <CAAmdEy2HD9tqU2OqqqhmnArK_BUbaiVBozf0XLNX1JSt9iT+tw@mail.gmail.com>
In-Reply-To: <CAAmdEy2HD9tqU2OqqqhmnArK_BUbaiVBozf0XLNX1JSt9iT+tw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Sep 2024 07:49:05 +0300
Message-ID: <CAC_iWjL0HvO-tE2R5tjX65qYL4oTWrGusGO6nodkZ8Wued7B0Q@mail.gmail.com>
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
To: Takahiro AKASHI <akashi.tkhro@gmail.com>
Cc: xypron.glpk@gmx.de, Anton.Antonov@arm.com, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

Akashi-san

On Fri, 20 Sept 2024 at 04:39, Takahiro AKASHI <akashi.tkhro@gmail.com> wrote:
>
>
>
> On Fri, 30 Aug 2024 at 20:45, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >
> > The EFI_LOADER and EFI config options are randomly scattered under lib/
> > making it cumbersome to navigate and enable options, unless you really
> > know what you are doing. On top of that the existing options are in
> > random order instead of a logical one.
> >
> > So let's move things around a bit and move them under boot/. Present a
> > generic UEFI entry where people can select Capsules, Protocols,
> > Services,  and an option to compile U-Boot as an EFI for X86
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since v1:
> > - Move the EFI Loader under boot/ instead of having it on the main menu
> > - Fold in the U-Boot as an EFI app option under the new EFI menu
> >  boot/Kconfig           |   2 +
> >  lib/Kconfig            |   2 -
> >  lib/efi/Kconfig        |   5 +
> >  lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++------------------
> >  4 files changed, 124 insertions(+), 89 deletions(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 940389d4882f..a1477eb8c7e1 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -1,5 +1,7 @@
> >  menu "Boot options"
> >
> > +source "lib/efi_loader/Kconfig"
> > +
> >  menu "Boot images"
> >
> >  config ANDROID_BOOT_IMAGE
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 2059219a1207..06b4e9a73135 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
> >         help
> >           A simple parser for SMBIOS data.
> >
> > -source "lib/efi/Kconfig"
> > -source "lib/efi_loader/Kconfig"
> >  source "lib/optee/Kconfig"
> >
> >  config TEST_FDTDEC
> > diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
> > index c2b9bb73f718..81ed3e66b34d 100644
> > --- a/lib/efi/Kconfig
> > +++ b/lib/efi/Kconfig
> > @@ -1,3 +1,6 @@
> > +menu "U-Boot as UEFI application"
> > +       depends on X86
> > +
> >  config EFI
> >         bool "Support running U-Boot from EFI"
> >         depends on X86
> > @@ -72,3 +75,5 @@ config EFI_RAM_SIZE
> >           use. U-Boot allocates this from EFI on start-up (along with a few
> >           other smaller amounts) and it can never be increased after that.
> >           It is used as the RAM size in with U-Boot.
> > +
> > +endmenu
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 6ffefa9103ff..0756be61d688 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -1,3 +1,5 @@
> > +menu "UEFI Support"
> > +
> >  config EFI_LOADER
> >         bool "Support running UEFI applications"
> >         depends on OF_LIBFDT && ( \
> > @@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
> >           You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
> >           command to do that.
> >
> > -config EFI_BOOTMGR
> > -       bool "UEFI Boot Manager"
> > +config EFI_SECURE_BOOT
> > +       bool "Enable EFI secure boot support"
> > +       depends on EFI_LOADER && FIT_SIGNATURE
> > +       select HASH
> > +       select SHA256
> > +       select RSA
> > +       select RSA_VERIFY_WITH_PKEY
> > +       select IMAGE_SIGN_INFO
> > +       select ASYMMETRIC_KEY_TYPE
> > +       select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +       select X509_CERTIFICATE_PARSER
> > +       select PKCS7_MESSAGE_PARSER
> > +       select PKCS7_VERIFY
> > +       select MSCODE_PARSER
> > +       select EFI_SIGNATURE_SUPPORT
> > +       help
> > +         Select this option to enable EFI secure boot support.
> > +         Once SecureBoot mode is enforced, any EFI binary can run only if
> > +         it is signed with a trusted key. To do that, you need to install,
> > +         at least, PK, KEK and db.
> > +
> > +config EFI_SIGNATURE_SUPPORT
> > +       bool
> > +
> > +menu "UEFI services"
> > +
> > +config EFI_GET_TIME
> > +       bool "GetTime() runtime service"
> > +       depends on DM_RTC
> >         default y
> >         help
> > -         Select this option if you want to select the UEFI binary to be booted
> > -         via UEFI variables Boot####, BootOrder, and BootNext. You should also
> > -         normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
> > +         Provide the GetTime() runtime service at boottime. This service
> > +         can be used by an EFI application to read the real time clock.
> > +
> > +config EFI_SET_TIME
> > +       bool "SetTime() runtime service"
> > +       depends on EFI_GET_TIME
> > +       default y if ARCH_QEMU || SANDBOX
> > +       help
> > +         Provide the SetTime() runtime service at boottime. This service
> > +         can be used by an EFI application to adjust the real time clock.
> > +
> > +config EFI_HAVE_RUNTIME_RESET
> > +       # bool "Reset runtime service is available"
> > +       bool
> > +       default y
> > +       depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> > +                  SANDBOX || SYSRESET_SBI || SYSRESET_X86
> > +
> > +endmenu
> > +
> > +menu "UEFI Variables"
> >
> >  choice
> >         prompt "Store for non-volatile UEFI variables"
> > @@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
> >
> >           Minimum 4096, default 131072
> >
> > -config EFI_GET_TIME
> > -       bool "GetTime() runtime service"
> > -       depends on DM_RTC
> > -       default y
> > +config EFI_PLATFORM_LANG_CODES
> > +       string "Language codes supported by firmware"
> > +       default "en-US"
> >         help
> > -         Provide the GetTime() runtime service at boottime. This service
> > -         can be used by an EFI application to read the real time clock.
> > +         This value is used to initialize the PlatformLangCodes variable. Its
> > +         value is a semicolon (;) separated list of language codes in native
> > +         RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> > +         to initialize the PlatformLang variable.
> >
> > -config EFI_SET_TIME
> > -       bool "SetTime() runtime service"
> > -       depends on EFI_GET_TIME
> > -       default y if ARCH_QEMU || SANDBOX
> > -       help
> > -         Provide the SetTime() runtime service at boottime. This service
> > -         can be used by an EFI application to adjust the real time clock.
> > +endmenu
> >
> > -config EFI_SCROLL_ON_CLEAR_SCREEN
> > -       bool "Avoid overwriting previous output on clear screen"
> > -       help
> > -         Instead of erasing the screen content when the console screen should
> > -         be cleared, emit blank new lines so that previous output is scrolled
> > -         out of sight rather than overwritten. On serial consoles this allows
> > -         to capture complete boot logs (except for interactive menus etc.)
> > -         and can ease debugging related issues.
> > +menu "Capsule support"
> >
> >  config EFI_HAVE_CAPSULE_SUPPORT
> >         bool
> > @@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
> >           embedded in the platform's device tree and used for capsule
> >           authentication at the time of capsule update.
> >
> > +endmenu
> > +
> > +menu "UEFI protocol support"
> > +
> >  config EFI_DEVICE_PATH_TO_TEXT
> >         bool "Device path to text protocol"
> >         default y
> > @@ -362,39 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
> >
> >  endif
> >
> > -config EFI_LOADER_BOUNCE_BUFFER
> > -       bool "EFI Applications use bounce buffers for DMA operations"
> > -       help
> > -         Some hardware does not support DMA to full 64bit addresses. For this
> > -         hardware we can create a bounce buffer so that payloads don't have to
> > -         worry about platform details.
> > -
> > -config EFI_PLATFORM_LANG_CODES
> > -       string "Language codes supported by firmware"
> > -       default "en-US"
> > -       help
> > -         This value is used to initialize the PlatformLangCodes variable. Its
> > -         value is a semicolon (;) separated list of language codes in native
> > -         RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> > -         to initialize the PlatformLang variable.
> > -
> > -config EFI_HAVE_RUNTIME_RESET
> > -       # bool "Reset runtime service is available"
> > -       bool
> > -       default y
> > -       depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> > -                  SANDBOX || SYSRESET_SBI || SYSRESET_X86
> > -
> > -config EFI_GRUB_ARM32_WORKAROUND
> > -       bool "Workaround for GRUB on 32bit ARM"
> > -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > -       default y
> > -       depends on ARM && !ARM64
> > -       help
> > -         GRUB prior to version 2.04 requires U-Boot to disable caches. This
> > -         workaround currently is also needed on systems with caches that
> > -         cannot be managed via CP15.
> > -
> >  config EFI_RNG_PROTOCOL
> >         bool "EFI_RNG_PROTOCOL support"
> >         depends on DM_RNG
> > @@ -447,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
> >           installed and Linux 5.7+ will ignore any initrd=<ramdisk> command line
> >           argument.
> >
> > -config EFI_SECURE_BOOT
> > -       bool "Enable EFI secure boot support"
> > -       depends on EFI_LOADER && FIT_SIGNATURE
> > -       select HASH
> > -       select SHA256
> > -       select RSA
> > -       select RSA_VERIFY_WITH_PKEY
> > -       select IMAGE_SIGN_INFO
> > -       select ASYMMETRIC_KEY_TYPE
> > -       select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > -       select X509_CERTIFICATE_PARSER
> > -       select PKCS7_MESSAGE_PARSER
> > -       select PKCS7_VERIFY
> > -       select MSCODE_PARSER
> > -       select EFI_SIGNATURE_SUPPORT
> > +config EFI_RISCV_BOOT_PROTOCOL
> > +       bool "RISCV_EFI_BOOT_PROTOCOL support"
> > +       default y
> > +       depends on RISCV
> >         help
> > -         Select this option to enable EFI secure boot support.
> > -         Once SecureBoot mode is enforced, any EFI binary can run only if
> > -         it is signed with a trusted key. To do that, you need to install,
> > -         at least, PK, KEK and db.
> > +         The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> > +         to the next boot stage. It should be enabled as it is meant to
> > +         replace the transfer via the device-tree. The latter is not
> > +         possible on systems using ACPI.
> >
> > -config EFI_SIGNATURE_SUPPORT
> > -       bool
> > +endmenu
> > +
> > +menu "Misc options"
> > +config EFI_LOADER_BOUNCE_BUFFER
> > +       bool "EFI Applications use bounce buffers for DMA operations"
> > +       depends on ARM64
> > +       help
> > +         Some hardware does not support DMA to full 64bit addresses. For this
> > +         hardware we can create a bounce buffer so that payloads don't have to
> > +         worry about platform details.
> > +
> > +config EFI_GRUB_ARM32_WORKAROUND
> > +       bool "Workaround for GRUB on 32bit ARM"
> > +       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > +       default y
> > +       depends on ARM && !ARM64
> > +       help
> > +         GRUB prior to version 2.04 requires U-Boot to disable caches. This
> > +         workaround currently is also needed on systems with caches that
> > +         cannot be managed via CP15.
> >
> >  config EFI_ESRT
> >         bool "Enable the UEFI ESRT generation"
> > @@ -496,15 +509,26 @@ config EFI_EBBR_2_1_CONFORMANCE
> >         help
> >           Enabling this option adds the EBBRv2.1 conformance entry to the ECPT UEFI table.
> >
> > -config EFI_RISCV_BOOT_PROTOCOL
> > -       bool "RISCV_EFI_BOOT_PROTOCOL support"
> > +config EFI_SCROLL_ON_CLEAR_SCREEN
> > +       bool "Avoid overwriting previous output on clear screen"
> > +       help
> > +         Instead of erasing the screen content when the console screen should
> > +         be cleared, emit blank new lines so that previous output is scrolled
> > +         out of sight rather than overwritten. On serial consoles this allows
> > +         to capture complete boot logs (except for interactive menus etc.)
> > +         and can ease debugging related issues.
> > +
> > +endmenu
> > +
> > +menu "EFI bootmanager"
> > +
> > +config EFI_BOOTMGR
> > +       bool "UEFI Boot Manager"
> >         default y
> > -       depends on RISCV
> >         help
> > -         The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> > -         to the next boot stage. It should be enabled as it is meant to
> > -         replace the transfer via the device-tree. The latter is not
> > -         possible on systems using ACPI.
> > +         Select this option if you want to select the UEFI binary to be booted
> > +         via UEFI variables Boot####, BootOrder, and BootNext. You should also
> > +         normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
> >
> >  config EFI_HTTP_BOOT
> >         bool "EFI HTTP Boot support"
> > @@ -514,5 +538,11 @@ config EFI_HTTP_BOOT
> >         help
> >           Enabling this option adds EFI HTTP Boot support. It allows to
> >           directly boot from network.
> > +endmenu
> >
> >  endif
> > +
> > +source "lib/efi/Kconfig"
>
> While you might have already discussed the issue, it looks weird to me that lib/efi/Kconfig
> is contained in lib/efi_loader/Kconfig.

No, we haven't but that's just naming no? We can easily rename that

Thanks
/Ilias
>
> -Takahiro AKASHI
>
> > +
> > +endmenu
> > +
> > --
> > 2.45.2
