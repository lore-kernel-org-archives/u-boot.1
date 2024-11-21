Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE91D6ED3B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD44A89603;
	Thu, 21 Nov 2024 15:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kW47k7h4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E6F896D6; Thu, 21 Nov 2024 15:02:03 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130CA894AC
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b13ff3141aso56737985a.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732197720; x=1732802520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NawUxipSCNDFBdZehAJCtzLtjw5zqae2w0gJOXwzz3g=;
 b=kW47k7h43vwubAB0lpuEXKXfBXopblJZ2NbDwq5drGYiLOKaIZIhX/dEYhVz46MCQm
 r1GEK3VvAQJzidD3Vr0MB15WzttUd18EEySb48Mpv4losLjKtDR/9ukU51+t59N9P3oW
 thI7xrDkpDDnqdYwHsBCBm8Z7uCt/+uMOCENQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732197720; x=1732802520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NawUxipSCNDFBdZehAJCtzLtjw5zqae2w0gJOXwzz3g=;
 b=KuAOEl9TIPdu9LWlNmxlaMXunx/hRsHV9f3n8DQWPCfU1UDn8N/PZ/dj2PYV+hDMKG
 HK4+Db9s1Bv5ZApAyJcjJvH4ZTZRuWQNtWlISXHmucBQBGCxnoGKQcXHBQ0uibVpyRqR
 x3YRH8RQ4Rm/j02GlfrtPak2gMLIpwNXfsFuikLsmDIPhDHb2siHzsIfW5S52zQw3kxb
 JL3iCwbItgbatGsu6K1ohDpE9bQNnWRUwlI7neHaVg9X5VH6hVihYU9DktLHuV9sxT5B
 Rvpttq/R136pC76PCfa4KaTQwBpQJAw7rh/1OBvvqKI+ndbq4/0TTpoyZfnfDJiIso0m
 ZEyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt9FNzOBinfQ3/mLD0mVjxXu8EQVGte8ni2D1sO9rXzaC9p5RNxLOCNgA1cTuMwP0knqUDbpU=@lists.denx.de
X-Gm-Message-State: AOJu0YyFeFNqEbwVW3DF15vTbykeZcYUN46twVWsZA6XkTlGvP3cAOMS
 HNguc2pxOlLLout2oT72rPp34cxkwmrA0wGdbVSIS5DW/+8qR+WpmixZsH2PprE=
X-Gm-Gg: ASbGncsC+Y7+0AbgJpP9345on2rLiUKWYdL5J8je3FPPUM2ADMZXZ2KXpJ5ixvGu+qx
 6WJyZJOQGNIJs++k7xnSMJ84jATlSYZbFAiealOZ0s7IzgdsrBWlEX3bDxyM9K1PRm5oanltrUs
 KEBDq0zwemryD6O/62oLpNagqZxTnnXl+2f0G2Hw3OwyMaaYTNTwzx7MaEZZJdsMuxVFroKBkv7
 gl/9CgSwXvnhjq3eOMqsPZub+ptg+dR9JxOHxFH/U/nEs90Xg==
X-Google-Smtp-Source: AGHT+IEgU68v/Z9/ptQ60lO9QYS1e4azL/AMVzNEi/QOLn9uIzXmsJ2VtI8wcz4DE+uyPhlu0rX9/g==
X-Received: by 2002:a05:620a:394c:b0:7b1:54bf:7185 with SMTP id
 af79cd13be357-7b42eeb4417mr761359085a.38.1732197719621; 
 Thu, 21 Nov 2024 06:01:59 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b485251000sm211513085a.126.2024.11.21.06.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 06:01:58 -0800 (PST)
Date: Thu, 21 Nov 2024 08:01:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anton.Antonov@arm.com,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.denx.de, E Shattow <lucent@gmail.com>
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
Message-ID: <20241121140155.GI3600562@bill-the-cat>
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
 <b4bbd3db-c099-44d0-b532-99070865d55c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nvWOMe6toTyg/FOm"
Content-Disposition: inline
In-Reply-To: <b4bbd3db-c099-44d0-b532-99070865d55c@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--nvWOMe6toTyg/FOm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 02:53:53PM +0100, Heinrich Schuchardt wrote:
> On 30.08.24 13:45, Ilias Apalodimas wrote:
> > The EFI_LOADER and EFI config options are randomly scattered under lib/
> > making it cumbersome to navigate and enable options, unless you really
> > know what you are doing. On top of that the existing options are in
> > random order instead of a logical one.
> >=20
> > So let's move things around a bit and move them under boot/. Present a
> > generic UEFI entry where people can select Capsules, Protocols,
> > Services,  and an option to compile U-Boot as an EFI for X86
> >=20
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since v1:
> > - Move the EFI Loader under boot/ instead of having it on the main menu
> > - Fold in the U-Boot as an EFI app option under the new EFI menu
> >   boot/Kconfig           |   2 +
> >   lib/Kconfig            |   2 -
> >   lib/efi/Kconfig        |   5 +
> >   lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++------------------
> >   4 files changed, 124 insertions(+), 89 deletions(-)
> >=20
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 940389d4882f..a1477eb8c7e1 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -1,5 +1,7 @@
> >   menu "Boot options"
> >=20
> > +source "lib/efi_loader/Kconfig"
> > +
> >   menu "Boot images"
> >=20
> >   config ANDROID_BOOT_IMAGE
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 2059219a1207..06b4e9a73135 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
> >   	help
> >   	  A simple parser for SMBIOS data.
> >=20
> > -source "lib/efi/Kconfig"
> > -source "lib/efi_loader/Kconfig"
> >   source "lib/optee/Kconfig"
> >=20
> >   config TEST_FDTDEC
> > diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
> > index c2b9bb73f718..81ed3e66b34d 100644
> > --- a/lib/efi/Kconfig
> > +++ b/lib/efi/Kconfig
> > @@ -1,3 +1,6 @@
> > +menu "U-Boot as UEFI application"
> > +	depends on X86
> > +
> >   config EFI
> >   	bool "Support running U-Boot from EFI"
> >   	depends on X86
> > @@ -72,3 +75,5 @@ config EFI_RAM_SIZE
> >   	  use. U-Boot allocates this from EFI on start-up (along with a few
> >   	  other smaller amounts) and it can never be increased after that.
> >   	  It is used as the RAM size in with U-Boot.
> > +
> > +endmenu
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 6ffefa9103ff..0756be61d688 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -1,3 +1,5 @@
> > +menu "UEFI Support"
> > +
> >   config EFI_LOADER
> >   	bool "Support running UEFI applications"
> >   	depends on OF_LIBFDT && ( \
> > @@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
> >   	  You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
> >   	  command to do that.
> >=20
> > -config EFI_BOOTMGR
> > -	bool "UEFI Boot Manager"
> > +config EFI_SECURE_BOOT
> > +	bool "Enable EFI secure boot support"
> > +	depends on EFI_LOADER && FIT_SIGNATURE
> > +	select HASH
> > +	select SHA256
> > +	select RSA
> > +	select RSA_VERIFY_WITH_PKEY
> > +	select IMAGE_SIGN_INFO
> > +	select ASYMMETRIC_KEY_TYPE
> > +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +	select X509_CERTIFICATE_PARSER
> > +	select PKCS7_MESSAGE_PARSER
> > +	select PKCS7_VERIFY
> > +	select MSCODE_PARSER
> > +	select EFI_SIGNATURE_SUPPORT
> > +	help
> > +	  Select this option to enable EFI secure boot support.
> > +	  Once SecureBoot mode is enforced, any EFI binary can run only if
> > +	  it is signed with a trusted key. To do that, you need to install,
> > +	  at least, PK, KEK and db.
> > +
> > +config EFI_SIGNATURE_SUPPORT
> > +	bool
> > +
> > +menu "UEFI services"
> > +
> > +config EFI_GET_TIME
> > +	bool "GetTime() runtime service"
> > +	depends on DM_RTC
> >   	default y
> >   	help
> > -	  Select this option if you want to select the UEFI binary to be boot=
ed
> > -	  via UEFI variables Boot####, BootOrder, and BootNext. You should al=
so
> > -	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is availabl=
e.
> > +	  Provide the GetTime() runtime service at boottime. This service
> > +	  can be used by an EFI application to read the real time clock.
> > +
> > +config EFI_SET_TIME
> > +	bool "SetTime() runtime service"
> > +	depends on EFI_GET_TIME
> > +	default y if ARCH_QEMU || SANDBOX
> > +	help
> > +	  Provide the SetTime() runtime service at boottime. This service
> > +	  can be used by an EFI application to adjust the real time clock.
> > +
> > +config EFI_HAVE_RUNTIME_RESET
> > +	# bool "Reset runtime service is available"
> > +	bool
> > +	default y
> > +	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> > +		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
> > +
> > +endmenu
> > +
> > +menu "UEFI Variables"
> >=20
> >   choice
> >   	prompt "Store for non-volatile UEFI variables"
> > @@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
> >=20
> >   	  Minimum 4096, default 131072
> >=20
> > -config EFI_GET_TIME
> > -	bool "GetTime() runtime service"
> > -	depends on DM_RTC
> > -	default y
> > +config EFI_PLATFORM_LANG_CODES
> > +	string "Language codes supported by firmware"
> > +	default "en-US"
> >   	help
> > -	  Provide the GetTime() runtime service at boottime. This service
> > -	  can be used by an EFI application to read the real time clock.
> > +	  This value is used to initialize the PlatformLangCodes variable. Its
> > +	  value is a semicolon (;) separated list of language codes in native
> > +	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> > +	  to initialize the PlatformLang variable.
> >=20
> > -config EFI_SET_TIME
> > -	bool "SetTime() runtime service"
> > -	depends on EFI_GET_TIME
> > -	default y if ARCH_QEMU || SANDBOX
> > -	help
> > -	  Provide the SetTime() runtime service at boottime. This service
> > -	  can be used by an EFI application to adjust the real time clock.
> > +endmenu
> >=20
> > -config EFI_SCROLL_ON_CLEAR_SCREEN
> > -	bool "Avoid overwriting previous output on clear screen"
> > -	help
> > -	  Instead of erasing the screen content when the console screen should
> > -	  be cleared, emit blank new lines so that previous output is scrolled
> > -	  out of sight rather than overwritten. On serial consoles this allows
> > -	  to capture complete boot logs (except for interactive menus etc.)
> > -	  and can ease debugging related issues.
> > +menu "Capsule support"
> >=20
> >   config EFI_HAVE_CAPSULE_SUPPORT
> >   	bool
> > @@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
> >   	  embedded in the platform's device tree and used for capsule
> >   	  authentication at the time of capsule update.
> >=20
> > +endmenu
> > +
> > +menu "UEFI protocol support"
> > +
> >   config EFI_DEVICE_PATH_TO_TEXT
> >   	bool "Device path to text protocol"
> >   	default y
> > @@ -362,39 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
> >=20
> >   endif
> >=20
> > -config EFI_LOADER_BOUNCE_BUFFER
> > -	bool "EFI Applications use bounce buffers for DMA operations"
> > -	help
> > -	  Some hardware does not support DMA to full 64bit addresses. For this
> > -	  hardware we can create a bounce buffer so that payloads don't have =
to
> > -	  worry about platform details.
> > -
> > -config EFI_PLATFORM_LANG_CODES
> > -	string "Language codes supported by firmware"
> > -	default "en-US"
> > -	help
> > -	  This value is used to initialize the PlatformLangCodes variable. Its
> > -	  value is a semicolon (;) separated list of language codes in native
> > -	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> > -	  to initialize the PlatformLang variable.
> > -
> > -config EFI_HAVE_RUNTIME_RESET
> > -	# bool "Reset runtime service is available"
> > -	bool
> > -	default y
> > -	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> > -		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
> > -
> > -config EFI_GRUB_ARM32_WORKAROUND
> > -	bool "Workaround for GRUB on 32bit ARM"
> > -	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > -	default y
> > -	depends on ARM && !ARM64
> > -	help
> > -	  GRUB prior to version 2.04 requires U-Boot to disable caches. This
> > -	  workaround currently is also needed on systems with caches that
> > -	  cannot be managed via CP15.
> > -
> >   config EFI_RNG_PROTOCOL
> >   	bool "EFI_RNG_PROTOCOL support"
> >   	depends on DM_RNG
> > @@ -447,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
> >   	  installed and Linux 5.7+ will ignore any initrd=3D<ramdisk> comman=
d line
> >   	  argument.
> >=20
> > -config EFI_SECURE_BOOT
> > -	bool "Enable EFI secure boot support"
> > -	depends on EFI_LOADER && FIT_SIGNATURE
> > -	select HASH
> > -	select SHA256
> > -	select RSA
> > -	select RSA_VERIFY_WITH_PKEY
> > -	select IMAGE_SIGN_INFO
> > -	select ASYMMETRIC_KEY_TYPE
> > -	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > -	select X509_CERTIFICATE_PARSER
> > -	select PKCS7_MESSAGE_PARSER
> > -	select PKCS7_VERIFY
> > -	select MSCODE_PARSER
> > -	select EFI_SIGNATURE_SUPPORT
> > +config EFI_RISCV_BOOT_PROTOCOL
> > +	bool "RISCV_EFI_BOOT_PROTOCOL support"
> > +	default y
> > +	depends on RISCV
> >   	help
> > -	  Select this option to enable EFI secure boot support.
> > -	  Once SecureBoot mode is enforced, any EFI binary can run only if
> > -	  it is signed with a trusted key. To do that, you need to install,
> > -	  at least, PK, KEK and db.
> > +	  The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> > +	  to the next boot stage. It should be enabled as it is meant to
> > +	  replace the transfer via the device-tree. The latter is not
> > +	  possible on systems using ACPI.
> >=20
> > -config EFI_SIGNATURE_SUPPORT
> > -	bool
> > +endmenu
> > +
> > +menu "Misc options"
> > +config EFI_LOADER_BOUNCE_BUFFER
> > +	bool "EFI Applications use bounce buffers for DMA operations"
> > +	depends on ARM64
>=20
> Hello Ilias,
>=20
> your merged patch revoked
>=20
> dcd1b63b7072 ("efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
> architectures")
>=20
> which we need to fix problems on JH7110 boards with more than 4 GiB.
>=20
> We need to add the revoked patch again.
>=20

Can we do that as a "today" solution, and make EFI_LOADER_BOUNCE_BUFFER
disappear and just be enabled by BOUNCE_BUFFER for v2025.04 please?

--=20
Tom

--nvWOMe6toTyg/FOm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc/PU8ACgkQFHw5/5Y0
tyzPvgv/V3zjBH+aRhOZTxaDVV6qNJ8X+IPZjCUzS6FNfDaUodqI6/KKVMDgbEX0
mDfjm2OndPrfDDyLHGoxXcOThmJsAKrK6NwKOoDMRJSRErZsD8SRA1MP0jYlx4+4
Yv5Fq8tsln0weCZydGdo6CqRHT9JwEA75AHB7F5LwdrSftvuUNS95YotAWyo/ruy
249HKBXnDZlJuTUI91BqWogD2OKghAbyZCcXzb+mAHmOaxN9PSLl2MT3c7h3e7+/
xjcKXJtKlAmtYDCR2Ltjt/3IFA6pLZFBzBitCxit2pMoYNqKp4iXofBDV+0Rxhby
/2PXYlaDS2uc6ELs8UzRk/lKDqQIw0C54Fkft0rEOn+PMhLbiWlWm5oaqdr2mwBN
K+OQx4PbS5Tt5ViX2ENPwUMzXB8OTyQ0oByvkVPBNRqhaBqmpGwwLjMZKKzxkNwF
30KtXAChZVu94W5WwajANfIWS0gcLXXAU9aiTLszDjj7T1gABUaPjb195X/9R8O2
C7Fs/LFR
=tuXy
-----END PGP SIGNATURE-----

--nvWOMe6toTyg/FOm--
