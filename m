Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E87D6ED3F
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7486389751;
	Thu, 21 Nov 2024 15:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vPDZ65GT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7CC989752; Thu, 21 Nov 2024 15:05:58 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECAD896EA
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso831377b3a.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732197954; x=1732802754; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=isPbaOmpiiFsPy3/u6XVwKGZ22EbK308nVl4XNIvogg=;
 b=vPDZ65GT9CGxQVmeoHXi5vrooImIhjd8Xbpke9u9mkpm+asJgNBuQoJBlwpsDrxeq/
 bDpXIt3u/1NrgmQMT0AErgjyqNbh3rwUAkOvthnKdlfOqFvUt0A6SRq2iUgOP8wcm/r3
 ojrUKqIXhMsxW4faWthKTDzs8Oe/T6/8wF2NOvHbivPW7IAXyZj3WPo9tckYTm9b6Ab7
 49wkZqATkQEa/tmk2tM11MUAEGq4VaymNU+phNbTMZIlASUdzLsYTOD0eyIzKehy1pKm
 p1JLI+yc2OILbycu6F0aQVBFzfCOdQCEKgr8LO7TVd85cwLpq/UDEOyoHTO8Q3LnGmOT
 XDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732197954; x=1732802754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isPbaOmpiiFsPy3/u6XVwKGZ22EbK308nVl4XNIvogg=;
 b=P+oZrZdBskR9Pa6jhr7KeW7So8GcTNFbVTmloKbKYPUb2bBALtIkOhZzQiVyWEqy4M
 NYp68szXy9qoBDNVO0JzcDYWswHhj3EdQ4mnvnx/9yyyV20bD7OzShAoDYxd81pG5oo1
 bstCJD5awtQwRkee84NYVwxX3Wj7XrrsjitqqX7oaU6wiehPxCqJymc8yItYrDwn4Ium
 opeG1KG6givar5y9GmuQT0uhsLICUgPVDZ4C/1aoQchOA3xCpCWiM74X9NNe+Qni+DeR
 olsBF+JjvWOkmXznzRGPU7kJFStFX5RtOYRkv1WZnKDj3vAinrDcnqENe0WU52FtxZ4y
 thaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtAgRSkT+V4StzgOTBukhIRJvEFeNBW8TSmpiTT+Q9J6h6oRWcWPN008aYz2SMtWCDWwgwd8=@lists.denx.de
X-Gm-Message-State: AOJu0YztE621TqZe7jEcYIJzMShS6iJDNeM1OipHp3rVPwdf1+NrmYCo
 ftJcN5VSv6oPRnzHEgYRk1uUyv6+sV63o70+dlqsa2vhFr0VmGxpyX3BijkW+AJrBvWTp95xpn0
 OYQEXzgoqlAXWTEjwVdpaxo8qIzMG6aR8FRisdg==
X-Gm-Gg: ASbGncskuO75+zDR8pOSCByPHEtKTKBzvGCBt8iwlyEP2WfzwnRry6ZNlds1Jo6f3Xm
 YgV9zlxEu7t4xC4GCHzN+YA9bcqNF0A==
X-Google-Smtp-Source: AGHT+IFLcqZqRM6WsV0OMU0pIJz7o61XSyOjSJSDbuH/1VtGc5mKqPolsNa0LBY7a2SLgnUPIsBzKy/VBgKHcBG4ZPg=
X-Received: by 2002:a17:903:2381:b0:212:4d01:d43a with SMTP id
 d9443c01a7336-2127036033cmr74605245ad.48.1732197954193; Thu, 21 Nov 2024
 06:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
 <b4bbd3db-c099-44d0-b532-99070865d55c@gmx.de>
 <20241121140155.GI3600562@bill-the-cat>
In-Reply-To: <20241121140155.GI3600562@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Nov 2024 16:05:18 +0200
Message-ID: <CAC_iWjJKv4Z4ibnbxm3phKnHbKeZq5fSe6Dis4c8k-ywohN6Zg@mail.gmail.com>
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Anton.Antonov@arm.com, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 u-boot@lists.denx.de, E Shattow <lucent@gmail.com>
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

On Thu, 21 Nov 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 21, 2024 at 02:53:53PM +0100, Heinrich Schuchardt wrote:
> > On 30.08.24 13:45, Ilias Apalodimas wrote:
> > > The EFI_LOADER and EFI config options are randomly scattered under lib/
> > > making it cumbersome to navigate and enable options, unless you really
> > > know what you are doing. On top of that the existing options are in
> > > random order instead of a logical one.
> > >
> > > So let's move things around a bit and move them under boot/. Present a
> > > generic UEFI entry where people can select Capsules, Protocols,
> > > Services,  and an option to compile U-Boot as an EFI for X86
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > > Changes since v1:
> > > - Move the EFI Loader under boot/ instead of having it on the main menu
> > > - Fold in the U-Boot as an EFI app option under the new EFI menu
> > >   boot/Kconfig           |   2 +
> > >   lib/Kconfig            |   2 -
> > >   lib/efi/Kconfig        |   5 +
> > >   lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++------------------
> > >   4 files changed, 124 insertions(+), 89 deletions(-)
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 940389d4882f..a1477eb8c7e1 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -1,5 +1,7 @@
> > >   menu "Boot options"
> > >
> > > +source "lib/efi_loader/Kconfig"
> > > +
> > >   menu "Boot images"
> > >
> > >   config ANDROID_BOOT_IMAGE
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 2059219a1207..06b4e9a73135 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
> > >     help
> > >       A simple parser for SMBIOS data.
> > >
> > > -source "lib/efi/Kconfig"
> > > -source "lib/efi_loader/Kconfig"
> > >   source "lib/optee/Kconfig"
> > >
> > >   config TEST_FDTDEC
> > > diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
> > > index c2b9bb73f718..81ed3e66b34d 100644
> > > --- a/lib/efi/Kconfig
> > > +++ b/lib/efi/Kconfig
> > > @@ -1,3 +1,6 @@
> > > +menu "U-Boot as UEFI application"
> > > +   depends on X86
> > > +
> > >   config EFI
> > >     bool "Support running U-Boot from EFI"
> > >     depends on X86
> > > @@ -72,3 +75,5 @@ config EFI_RAM_SIZE
> > >       use. U-Boot allocates this from EFI on start-up (along with a few
> > >       other smaller amounts) and it can never be increased after that.
> > >       It is used as the RAM size in with U-Boot.
> > > +
> > > +endmenu
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 6ffefa9103ff..0756be61d688 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -1,3 +1,5 @@
> > > +menu "UEFI Support"
> > > +
> > >   config EFI_LOADER
> > >     bool "Support running UEFI applications"
> > >     depends on OF_LIBFDT && ( \
> > > @@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
> > >       You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
> > >       command to do that.
> > >
> > > -config EFI_BOOTMGR
> > > -   bool "UEFI Boot Manager"
> > > +config EFI_SECURE_BOOT
> > > +   bool "Enable EFI secure boot support"
> > > +   depends on EFI_LOADER && FIT_SIGNATURE
> > > +   select HASH
> > > +   select SHA256
> > > +   select RSA
> > > +   select RSA_VERIFY_WITH_PKEY
> > > +   select IMAGE_SIGN_INFO
> > > +   select ASYMMETRIC_KEY_TYPE
> > > +   select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > +   select X509_CERTIFICATE_PARSER
> > > +   select PKCS7_MESSAGE_PARSER
> > > +   select PKCS7_VERIFY
> > > +   select MSCODE_PARSER
> > > +   select EFI_SIGNATURE_SUPPORT
> > > +   help
> > > +     Select this option to enable EFI secure boot support.
> > > +     Once SecureBoot mode is enforced, any EFI binary can run only if
> > > +     it is signed with a trusted key. To do that, you need to install,
> > > +     at least, PK, KEK and db.
> > > +
> > > +config EFI_SIGNATURE_SUPPORT
> > > +   bool
> > > +
> > > +menu "UEFI services"
> > > +
> > > +config EFI_GET_TIME
> > > +   bool "GetTime() runtime service"
> > > +   depends on DM_RTC
> > >     default y
> > >     help
> > > -     Select this option if you want to select the UEFI binary to be booted
> > > -     via UEFI variables Boot####, BootOrder, and BootNext. You should also
> > > -     normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
> > > +     Provide the GetTime() runtime service at boottime. This service
> > > +     can be used by an EFI application to read the real time clock.
> > > +
> > > +config EFI_SET_TIME
> > > +   bool "SetTime() runtime service"
> > > +   depends on EFI_GET_TIME
> > > +   default y if ARCH_QEMU || SANDBOX
> > > +   help
> > > +     Provide the SetTime() runtime service at boottime. This service
> > > +     can be used by an EFI application to adjust the real time clock.
> > > +
> > > +config EFI_HAVE_RUNTIME_RESET
> > > +   # bool "Reset runtime service is available"
> > > +   bool
> > > +   default y
> > > +   depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> > > +              SANDBOX || SYSRESET_SBI || SYSRESET_X86
> > > +
> > > +endmenu
> > > +
> > > +menu "UEFI Variables"
> > >
> > >   choice
> > >     prompt "Store for non-volatile UEFI variables"
> > > @@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
> > >
> > >       Minimum 4096, default 131072
> > >
> > > -config EFI_GET_TIME
> > > -   bool "GetTime() runtime service"
> > > -   depends on DM_RTC
> > > -   default y
> > > +config EFI_PLATFORM_LANG_CODES
> > > +   string "Language codes supported by firmware"
> > > +   default "en-US"
> > >     help
> > > -     Provide the GetTime() runtime service at boottime. This service
> > > -     can be used by an EFI application to read the real time clock.
> > > +     This value is used to initialize the PlatformLangCodes variable. Its
> > > +     value is a semicolon (;) separated list of language codes in native
> > > +     RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> > > +     to initialize the PlatformLang variable.
> > >
> > > -config EFI_SET_TIME
> > > -   bool "SetTime() runtime service"
> > > -   depends on EFI_GET_TIME
> > > -   default y if ARCH_QEMU || SANDBOX
> > > -   help
> > > -     Provide the SetTime() runtime service at boottime. This service
> > > -     can be used by an EFI application to adjust the real time clock.
> > > +endmenu
> > >
> > > -config EFI_SCROLL_ON_CLEAR_SCREEN
> > > -   bool "Avoid overwriting previous output on clear screen"
> > > -   help
> > > -     Instead of erasing the screen content when the console screen should
> > > -     be cleared, emit blank new lines so that previous output is scrolled
> > > -     out of sight rather than overwritten. On serial consoles this allows
> > > -     to capture complete boot logs (except for interactive menus etc.)
> > > -     and can ease debugging related issues.
> > > +menu "Capsule support"
> > >
> > >   config EFI_HAVE_CAPSULE_SUPPORT
> > >     bool
> > > @@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
> > >       embedded in the platform's device tree and used for capsule
> > >       authentication at the time of capsule update.
> > >
> > > +endmenu
> > > +
> > > +menu "UEFI protocol support"
> > > +
> > >   config EFI_DEVICE_PATH_TO_TEXT
> > >     bool "Device path to text protocol"
> > >     default y
> > > @@ -362,39 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
> > >
> > >   endif
> > >
> > > -config EFI_LOADER_BOUNCE_BUFFER
> > > -   bool "EFI Applications use bounce buffers for DMA operations"
> > > -   help
> > > -     Some hardware does not support DMA to full 64bit addresses. For this
> > > -     hardware we can create a bounce buffer so that payloads don't have to
> > > -     worry about platform details.
> > > -
> > > -config EFI_PLATFORM_LANG_CODES
> > > -   string "Language codes supported by firmware"
> > > -   default "en-US"
> > > -   help
> > > -     This value is used to initialize the PlatformLangCodes variable. Its
> > > -     value is a semicolon (;) separated list of language codes in native
> > > -     RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> > > -     to initialize the PlatformLang variable.
> > > -
> > > -config EFI_HAVE_RUNTIME_RESET
> > > -   # bool "Reset runtime service is available"
> > > -   bool
> > > -   default y
> > > -   depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> > > -              SANDBOX || SYSRESET_SBI || SYSRESET_X86
> > > -
> > > -config EFI_GRUB_ARM32_WORKAROUND
> > > -   bool "Workaround for GRUB on 32bit ARM"
> > > -   default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > > -   default y
> > > -   depends on ARM && !ARM64
> > > -   help
> > > -     GRUB prior to version 2.04 requires U-Boot to disable caches. This
> > > -     workaround currently is also needed on systems with caches that
> > > -     cannot be managed via CP15.
> > > -
> > >   config EFI_RNG_PROTOCOL
> > >     bool "EFI_RNG_PROTOCOL support"
> > >     depends on DM_RNG
> > > @@ -447,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
> > >       installed and Linux 5.7+ will ignore any initrd=<ramdisk> command line
> > >       argument.
> > >
> > > -config EFI_SECURE_BOOT
> > > -   bool "Enable EFI secure boot support"
> > > -   depends on EFI_LOADER && FIT_SIGNATURE
> > > -   select HASH
> > > -   select SHA256
> > > -   select RSA
> > > -   select RSA_VERIFY_WITH_PKEY
> > > -   select IMAGE_SIGN_INFO
> > > -   select ASYMMETRIC_KEY_TYPE
> > > -   select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > -   select X509_CERTIFICATE_PARSER
> > > -   select PKCS7_MESSAGE_PARSER
> > > -   select PKCS7_VERIFY
> > > -   select MSCODE_PARSER
> > > -   select EFI_SIGNATURE_SUPPORT
> > > +config EFI_RISCV_BOOT_PROTOCOL
> > > +   bool "RISCV_EFI_BOOT_PROTOCOL support"
> > > +   default y
> > > +   depends on RISCV
> > >     help
> > > -     Select this option to enable EFI secure boot support.
> > > -     Once SecureBoot mode is enforced, any EFI binary can run only if
> > > -     it is signed with a trusted key. To do that, you need to install,
> > > -     at least, PK, KEK and db.
> > > +     The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> > > +     to the next boot stage. It should be enabled as it is meant to
> > > +     replace the transfer via the device-tree. The latter is not
> > > +     possible on systems using ACPI.
> > >
> > > -config EFI_SIGNATURE_SUPPORT
> > > -   bool
> > > +endmenu
> > > +
> > > +menu "Misc options"
> > > +config EFI_LOADER_BOUNCE_BUFFER
> > > +   bool "EFI Applications use bounce buffers for DMA operations"
> > > +   depends on ARM64
> >
> > Hello Ilias,
> >
> > your merged patch revoked
> >
> > dcd1b63b7072 ("efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
> > architectures")
> >
> > which we need to fix problems on JH7110 boards with more than 4 GiB.
> >
> > We need to add the revoked patch again.
> >
>
> Can we do that as a "today" solution, and make EFI_LOADER_BOUNCE_BUFFER
> disappear and just be enabled by BOUNCE_BUFFER for v2025.04 please?

Sure I'll send the patch in a bit

Thanks
/Ilias
>
> --
> Tom
