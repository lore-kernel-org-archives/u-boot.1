Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE07D6ED34
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 13:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13218959B;
	Thu, 21 Nov 2024 14:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="my6EZnPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8166589426; Thu, 21 Nov 2024 14:54:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049AA8933F
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732197235; x=1732802035; i=xypron.glpk@gmx.de;
 bh=L57UNy+qBlDxP9cts7rtuylVIY2yDsU68FoXpTfN1tY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=my6EZnPy9DMW/8XQ0BuDnMlkqpkRy/N2lVbGUAgG+oh+e401tZt2rO99QpAd75xK
 moFpl0+eOSi4kp+KgU1yYAz3oQLclNiEFvwCGmixX7tiAT1/VcRfRbRt7REb30xnB
 ddvIB3CCJ0XTJ+UDu/evmMsOC/OOU5NLoYFBypkaaa1TJFIi2wh3v9rA9YFzvOvIX
 DGTgJ6YVYY7kBkALOmSnpRwHaVj+fmDRCDj8V6kAntGpKWg1t4OcBXPzjCl1xB6DT
 X7L3snCO01OQgMJ+LnSekMjSM8eA7OrVGKBNOEEprGVBJY83ckL0F9Nko6irYo97B
 UuepKdwaqV4zq1K2kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1taCtH01FA-00nvNj; Thu, 21
 Nov 2024 14:53:55 +0100
Message-ID: <b4bbd3db-c099-44d0-b532-99070865d55c@gmx.de>
Date: Thu, 21 Nov 2024 14:53:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anton.Antonov@arm.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.denx.de, E Shattow <lucent@gmail.com>
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AZQsQjgRpW9AeR8e8ivrcd9wb+mnbaoWMfn7YsKYSdG7uRBrfgD
 K8QwtCTCTT5d6pJd2CHeXb3eFpvyqXGmalCwJNM/+5wo95mbpOFY0KbeItaAHw4ru/0NZXu
 KOfW4a3L/NzDW1Pmlo1J8pZWxX5h3IbLlg43x98qOhg19vkcn7RAb6YINn5cBUpU5Kibdxd
 nIPqQ6Z/MCsZGMLSIw2sA==
UI-OutboundReport: notjunk:1;M01:P0:U/VXro51JRk=;OgAFIoed6fVKFV/PXPQegEO3s2y
 CqU1ycHviLq2f5ZZ6Wi65w9gnUH3Q1yyyjvwC7c5yWDTDRSxe17bmjIzXOIzyiSrcwLD4ftjV
 hYpGoZ/vDhl8xqyu49Vd30OqmKD+pLXTfVCeR12YOLUqDGdkoMw57TGEg84SKl6Q5CtLOW4Rw
 I9LG3Y3qcT6z/SiefnRlkL3uli+/4wgFqJ+7eAekNZxHW+dRFkQGNOrVPa29Fsm6xny7HP8JZ
 gFHrGWYEOq71v6gLYfOKPemytEyVSIgoJqqd3IMPUvmSFTyezkfPtzJbLqlqK+4dFXVKlwQbY
 n0R5qix/Px1vJpXhV36JYit27nmlQbaat0rlrv4UM2kf/Ggi3QTvpSYpYTdskBGB2lSwLkdc2
 /wMMrlkvsyvpHfR3YMJj+DQ13S1QXpXyGJzY5Jx8eSu14eEdNv6NwzGfidPCR31GeSe0EZZtb
 vwZffsCeOkgjAftfpUNws2Q4VsCq5sN/bSN0o6jaaKOn9ZfFAQVH7edx8l7vUPWMMn8vk+YBH
 Iqc9khFOXgsp9BMsGjmUuTawvd0oGRfANue5VAmLcamYBgnYwzfSYtm/fdOaYqpDLNIfWPW1n
 1TtnqgHQu6WOFPyrmVBuW600xadBjZWcxf0gL5wIAB+vYMV3wYCCE7qMw+Wi5CzjOY/HjD3Ih
 LYrtQfQoK7YW38u2VrCmQ/uhnX+pXKD0eqcaUHS8cmDwVwQedTV8o7Y7kLQnD6aLTBeuvfXPa
 LlLvo27tkLfZPq0dJLD6ZcmzARl5svUfw6RxPQtCAbuzZpo1fO2EbaEjr6+/FS/7lxRdXCoYW
 NvkR2HrKYgIororUAtGRBSqRivltj1cdIPpto9KuwKMubM0ksRaTd/H/xD+a7zB088xVUfzvv
 7+BiTsevZM6Lb7MOF93pLHpEt85i6TWQ5tEPYzLIhW9tETpJxIca3PpLb
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

On 30.08.24 13:45, Ilias Apalodimas wrote:
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
>   boot/Kconfig           |   2 +
>   lib/Kconfig            |   2 -
>   lib/efi/Kconfig        |   5 +
>   lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++------------------
>   4 files changed, 124 insertions(+), 89 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 940389d4882f..a1477eb8c7e1 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1,5 +1,7 @@
>   menu "Boot options"
>
> +source "lib/efi_loader/Kconfig"
> +
>   menu "Boot images"
>
>   config ANDROID_BOOT_IMAGE
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 2059219a1207..06b4e9a73135 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
>   	help
>   	  A simple parser for SMBIOS data.
>
> -source "lib/efi/Kconfig"
> -source "lib/efi_loader/Kconfig"
>   source "lib/optee/Kconfig"
>
>   config TEST_FDTDEC
> diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
> index c2b9bb73f718..81ed3e66b34d 100644
> --- a/lib/efi/Kconfig
> +++ b/lib/efi/Kconfig
> @@ -1,3 +1,6 @@
> +menu "U-Boot as UEFI application"
> +	depends on X86
> +
>   config EFI
>   	bool "Support running U-Boot from EFI"
>   	depends on X86
> @@ -72,3 +75,5 @@ config EFI_RAM_SIZE
>   	  use. U-Boot allocates this from EFI on start-up (along with a few
>   	  other smaller amounts) and it can never be increased after that.
>   	  It is used as the RAM size in with U-Boot.
> +
> +endmenu
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 6ffefa9103ff..0756be61d688 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -1,3 +1,5 @@
> +menu "UEFI Support"
> +
>   config EFI_LOADER
>   	bool "Support running UEFI applications"
>   	depends on OF_LIBFDT && ( \
> @@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
>   	  You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
>   	  command to do that.
>
> -config EFI_BOOTMGR
> -	bool "UEFI Boot Manager"
> +config EFI_SECURE_BOOT
> +	bool "Enable EFI secure boot support"
> +	depends on EFI_LOADER && FIT_SIGNATURE
> +	select HASH
> +	select SHA256
> +	select RSA
> +	select RSA_VERIFY_WITH_PKEY
> +	select IMAGE_SIGN_INFO
> +	select ASYMMETRIC_KEY_TYPE
> +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +	select X509_CERTIFICATE_PARSER
> +	select PKCS7_MESSAGE_PARSER
> +	select PKCS7_VERIFY
> +	select MSCODE_PARSER
> +	select EFI_SIGNATURE_SUPPORT
> +	help
> +	  Select this option to enable EFI secure boot support.
> +	  Once SecureBoot mode is enforced, any EFI binary can run only if
> +	  it is signed with a trusted key. To do that, you need to install,
> +	  at least, PK, KEK and db.
> +
> +config EFI_SIGNATURE_SUPPORT
> +	bool
> +
> +menu "UEFI services"
> +
> +config EFI_GET_TIME
> +	bool "GetTime() runtime service"
> +	depends on DM_RTC
>   	default y
>   	help
> -	  Select this option if you want to select the UEFI binary to be boote=
d
> -	  via UEFI variables Boot####, BootOrder, and BootNext. You should als=
o
> -	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available=
.
> +	  Provide the GetTime() runtime service at boottime. This service
> +	  can be used by an EFI application to read the real time clock.
> +
> +config EFI_SET_TIME
> +	bool "SetTime() runtime service"
> +	depends on EFI_GET_TIME
> +	default y if ARCH_QEMU || SANDBOX
> +	help
> +	  Provide the SetTime() runtime service at boottime. This service
> +	  can be used by an EFI application to adjust the real time clock.
> +
> +config EFI_HAVE_RUNTIME_RESET
> +	# bool "Reset runtime service is available"
> +	bool
> +	default y
> +	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> +		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
> +
> +endmenu
> +
> +menu "UEFI Variables"
>
>   choice
>   	prompt "Store for non-volatile UEFI variables"
> @@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
>
>   	  Minimum 4096, default 131072
>
> -config EFI_GET_TIME
> -	bool "GetTime() runtime service"
> -	depends on DM_RTC
> -	default y
> +config EFI_PLATFORM_LANG_CODES
> +	string "Language codes supported by firmware"
> +	default "en-US"
>   	help
> -	  Provide the GetTime() runtime service at boottime. This service
> -	  can be used by an EFI application to read the real time clock.
> +	  This value is used to initialize the PlatformLangCodes variable. Its
> +	  value is a semicolon (;) separated list of language codes in native
> +	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> +	  to initialize the PlatformLang variable.
>
> -config EFI_SET_TIME
> -	bool "SetTime() runtime service"
> -	depends on EFI_GET_TIME
> -	default y if ARCH_QEMU || SANDBOX
> -	help
> -	  Provide the SetTime() runtime service at boottime. This service
> -	  can be used by an EFI application to adjust the real time clock.
> +endmenu
>
> -config EFI_SCROLL_ON_CLEAR_SCREEN
> -	bool "Avoid overwriting previous output on clear screen"
> -	help
> -	  Instead of erasing the screen content when the console screen should
> -	  be cleared, emit blank new lines so that previous output is scrolled
> -	  out of sight rather than overwritten. On serial consoles this allows
> -	  to capture complete boot logs (except for interactive menus etc.)
> -	  and can ease debugging related issues.
> +menu "Capsule support"
>
>   config EFI_HAVE_CAPSULE_SUPPORT
>   	bool
> @@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
>   	  embedded in the platform's device tree and used for capsule
>   	  authentication at the time of capsule update.
>
> +endmenu
> +
> +menu "UEFI protocol support"
> +
>   config EFI_DEVICE_PATH_TO_TEXT
>   	bool "Device path to text protocol"
>   	default y
> @@ -362,39 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
>
>   endif
>
> -config EFI_LOADER_BOUNCE_BUFFER
> -	bool "EFI Applications use bounce buffers for DMA operations"
> -	help
> -	  Some hardware does not support DMA to full 64bit addresses. For this
> -	  hardware we can create a bounce buffer so that payloads don't have t=
o
> -	  worry about platform details.
> -
> -config EFI_PLATFORM_LANG_CODES
> -	string "Language codes supported by firmware"
> -	default "en-US"
> -	help
> -	  This value is used to initialize the PlatformLangCodes variable. Its
> -	  value is a semicolon (;) separated list of language codes in native
> -	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is used
> -	  to initialize the PlatformLang variable.
> -
> -config EFI_HAVE_RUNTIME_RESET
> -	# bool "Reset runtime service is available"
> -	bool
> -	default y
> -	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> -		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
> -
> -config EFI_GRUB_ARM32_WORKAROUND
> -	bool "Workaround for GRUB on 32bit ARM"
> -	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> -	default y
> -	depends on ARM && !ARM64
> -	help
> -	  GRUB prior to version 2.04 requires U-Boot to disable caches. This
> -	  workaround currently is also needed on systems with caches that
> -	  cannot be managed via CP15.
> -
>   config EFI_RNG_PROTOCOL
>   	bool "EFI_RNG_PROTOCOL support"
>   	depends on DM_RNG
> @@ -447,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
>   	  installed and Linux 5.7+ will ignore any initrd=3D<ramdisk> command=
 line
>   	  argument.
>
> -config EFI_SECURE_BOOT
> -	bool "Enable EFI secure boot support"
> -	depends on EFI_LOADER && FIT_SIGNATURE
> -	select HASH
> -	select SHA256
> -	select RSA
> -	select RSA_VERIFY_WITH_PKEY
> -	select IMAGE_SIGN_INFO
> -	select ASYMMETRIC_KEY_TYPE
> -	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> -	select X509_CERTIFICATE_PARSER
> -	select PKCS7_MESSAGE_PARSER
> -	select PKCS7_VERIFY
> -	select MSCODE_PARSER
> -	select EFI_SIGNATURE_SUPPORT
> +config EFI_RISCV_BOOT_PROTOCOL
> +	bool "RISCV_EFI_BOOT_PROTOCOL support"
> +	default y
> +	depends on RISCV
>   	help
> -	  Select this option to enable EFI secure boot support.
> -	  Once SecureBoot mode is enforced, any EFI binary can run only if
> -	  it is signed with a trusted key. To do that, you need to install,
> -	  at least, PK, KEK and db.
> +	  The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> +	  to the next boot stage. It should be enabled as it is meant to
> +	  replace the transfer via the device-tree. The latter is not
> +	  possible on systems using ACPI.
>
> -config EFI_SIGNATURE_SUPPORT
> -	bool
> +endmenu
> +
> +menu "Misc options"
> +config EFI_LOADER_BOUNCE_BUFFER
> +	bool "EFI Applications use bounce buffers for DMA operations"
> +	depends on ARM64

Hello Ilias,

your merged patch revoked

dcd1b63b7072 ("efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
architectures")

which we need to fix problems on JH7110 boards with more than 4 GiB.

We need to add the revoked patch again.

Best regards

Heinrich


> +	help
> +	  Some hardware does not support DMA to full 64bit addresses. For this
> +	  hardware we can create a bounce buffer so that payloads don't have t=
o
> +	  worry about platform details.
> +
> +config EFI_GRUB_ARM32_WORKAROUND
> +	bool "Workaround for GRUB on 32bit ARM"
> +	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> +	default y
> +	depends on ARM && !ARM64
> +	help
> +	  GRUB prior to version 2.04 requires U-Boot to disable caches. This
> +	  workaround currently is also needed on systems with caches that
> +	  cannot be managed via CP15.
>
>   config EFI_ESRT
>   	bool "Enable the UEFI ESRT generation"
> @@ -496,15 +509,26 @@ config EFI_EBBR_2_1_CONFORMANCE
>   	help
>   	  Enabling this option adds the EBBRv2.1 conformance entry to the ECP=
T UEFI table.
>
> -config EFI_RISCV_BOOT_PROTOCOL
> -	bool "RISCV_EFI_BOOT_PROTOCOL support"
> +config EFI_SCROLL_ON_CLEAR_SCREEN
> +	bool "Avoid overwriting previous output on clear screen"
> +	help
> +	  Instead of erasing the screen content when the console screen should
> +	  be cleared, emit blank new lines so that previous output is scrolled
> +	  out of sight rather than overwritten. On serial consoles this allows
> +	  to capture complete boot logs (except for interactive menus etc.)
> +	  and can ease debugging related issues.
> +
> +endmenu
> +
> +menu "EFI bootmanager"
> +
> +config EFI_BOOTMGR
> +	bool "UEFI Boot Manager"
>   	default y
> -	depends on RISCV
>   	help
> -	  The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
> -	  to the next boot stage. It should be enabled as it is meant to
> -	  replace the transfer via the device-tree. The latter is not
> -	  possible on systems using ACPI.
> +	  Select this option if you want to select the UEFI binary to be boote=
d
> +	  via UEFI variables Boot####, BootOrder, and BootNext. You should als=
o
> +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available=
.
>
>   config EFI_HTTP_BOOT
>   	bool "EFI HTTP Boot support"
> @@ -514,5 +538,11 @@ config EFI_HTTP_BOOT
>   	help
>   	  Enabling this option adds EFI HTTP Boot support. It allows to
>   	  directly boot from network.
> +endmenu
>
>   endif
> +
> +source "lib/efi/Kconfig"
> +
> +endmenu
> +
> --
> 2.45.2
>

