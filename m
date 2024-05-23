Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3052C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712418852E;
	Thu, 23 May 2024 18:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Hm74alAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C658811D; Thu, 23 May 2024 18:14:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C11F18852E
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 18:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716480878; x=1717085678; i=xypron.glpk@gmx.de;
 bh=y6issJF1edyG1aNASpWcR0i2PquwfX2XRFjirESNaAM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Hm74alAMAsuOX3UB/NTO0m2AY+6W5+iY194jNA5fsF19fgTtVumeszE4uOqhbKnP
 XMavzosy7A7NsxFqAvq5fYPKcTYiaeiFpW/Wi4uo3ISHHQiK1Ef8IGymS1DS5Huid
 LmEMN5wZwVMxVfFB5G4uE/PJF71Gq8kbWvjuv2pTYrkJGnomNfU6jI8xjnkHMS2GE
 RUQTiK/TD3vZKv8lVvinAiKHApYnXIaQWFmhMMSaQ1CSm+SAMBm/rywsFrKmLw8po
 ytAulfu49+vBAN/eZw8UQr7dGz4EIwEc+06f5WT5YLuDFV4LrcuT1Ps/me0wOnLOw
 DKoJ1qUz95tGNSKlTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQIv-1suluD2KpT-00pfxk; Thu, 23
 May 2024 18:14:38 +0200
Message-ID: <304f9e83-45eb-4f8e-98f3-2658aac5c20b@gmx.de>
Date: Thu, 23 May 2024 18:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] efi: LoongArch: Define LoongArch bits everywhere
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-15-1407e0b69678@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240522-loongarch-v1-15-1407e0b69678@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5EnywXak/+1ej1+QdrjU7Omm21MbDiz5lPsLVwN5BNXvcfLYFqn
 HDSN8yfIKd3rr6CxsX9EK/daYscKKzyvDD0sOrcLSXftsKkHMacTy7nTJM+f9b2EstLA4GZ
 viYTiRF360XwkUiLFNQI3/FsgdRDIpB+j/mTAjH/CdZXZTx6Tz6X8drQTdfr87ExbpQJtAw
 qHkTuMc+m0DwQI+mf+C0w==
UI-OutboundReport: notjunk:1;M01:P0:DeAJU6buc9o=;vqHvRMWm/vdz5oFkmsfvYAUdTY+
 5i7uPWfLWjSr03BOU3gbTvu4cFJLhWqqojchB3cFAw6WWY+XTN+NiyweSARw8Op7wkW2dgeIf
 NxxbgDJtIKpf/UXtJtcXONqyTOIhaUj2PwJLMuQtmRqtv3lSgO7XI5jQqq6GCDGfDnz70oZiI
 w6D58JyqYb82QO9NfTxeiyHa3LnaibPz8rpT1v6rHZyekcniRiuq2I0e9b3As+LXK7XnnpBGl
 5NAUKxmooIsACaHehRf0ENIC2x77Q75Uyb9MtDKTvi9B2EnTvsGOn2caZByGMcckhlrDAbhL9
 MsUoAvgTKl01cGyPp/igSZ5T7FR7Q62VeOSU+08hTyX9w7z4mzTTLq6gHN8W1rZEwY3yoWbzN
 O508fFXkmeDiWpU2Hzc4XNeMdzdfpDTMcSPZxBwPhWAAtjc1wO2T3L+b2FfRsqWrXFa3PGscH
 Q4zC9/76r+O+AOe25OjXc5+h4v1fJt+uU0LT8PEGG9x50gLeF/AZbGTziQYmWNA4T1pnwBd20
 3VePT3tqy+zP/gxr9W5RpmMibEMvCcD01DHySxI5LRVlUJi+FsYn8/BDNwaogUuPFOh3c8KNA
 1HS7zeqBRHdQPdUwYTWu6Ujct2jRU3Yp+djfp6aAo59wo648KPBPDaDlSZSWKg9nU215og0+e
 cbmWSuWxRnrduYv5kbx1MWrqA+SVl65YrdkCvVxgwQA12UlPa3gSJb3mTTQFCvg7GJmpv0Knb
 68DlHfCCihBf8Hmw7oKro4B0vp7WouTeeSydCpBZ8gQjqmHpA/MlCCFkIFZiE+DizM9+2Vn/f
 BK4p/0G/s4c/hMTYNUneSf8Fn4XFQuDZ45sYVSjys3gU4=
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

On 22.05.24 17:34, Jiaxun Yang wrote:
> They are all coming from UEFI spec, Microsoft PE sepc,

%s/PE sepc/PE-COFF specification/

> or IANA websites.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   boot/bootmeth_efi.c                               | 2 ++
>   include/asm-generic/pe.h                          | 2 ++
>   include/config_distro_bootcmd.h                   | 5 +++++
>   include/efi_default_filename.h                    | 2 ++
>   lib/efi_loader/efi_image_loader.c                 | 7 +++++++
>   lib/efi_loader/efi_runtime.c                      | 4 ++++
>   lib/efi_selftest/efi_selftest_miniapp_exception.c | 2 ++
>   7 files changed, 24 insertions(+)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index aebc5207fc01..b0207dac49c5 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -41,6 +41,8 @@ static int get_efi_pxe_arch(void)
>   		return 0x19;
>   	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
>   		return 0x1b;
> +	else if (IS_ENABLED(CONFIG_ARCH_LA64))
> +		return 0x27;
>   	else if (IS_ENABLED(CONFIG_SANDBOX))
>   		return 0;	/* not used */
>
> diff --git a/include/asm-generic/pe.h b/include/asm-generic/pe.h
> index cd5b6ad62bf0..fb93f2621715 100644
> --- a/include/asm-generic/pe.h
> +++ b/include/asm-generic/pe.h
> @@ -38,6 +38,8 @@
>   #define IMAGE_FILE_MACHINE_ARM64		0xaa64
>   #define IMAGE_FILE_MACHINE_RISCV32		0x5032
>   #define IMAGE_FILE_MACHINE_RISCV64		0x5064
> +#define IMAGE_FILE_MACHINE_LOONGARCH32	0x6232
> +#define IMAGE_FILE_MACHINE_LOONGARCH64	0x6264
>
>   /* Header magic constants */
>   #define IMAGE_NT_OPTIONAL_HDR32_MAGIC		0x010b
> diff --git a/include/config_distro_bootcmd.h b/include/config_distro_boo=
tcmd.h
> index 2a136b96a6d9..f8c3a4bb70ae 100644
> --- a/include/config_distro_bootcmd.h
> +++ b/include/config_distro_bootcmd.h
> @@ -118,6 +118,8 @@
>   #define BOOTEFI_NAME "bootriscv32.efi"
>   #elif defined(CONFIG_ARCH_RV64I)
>   #define BOOTEFI_NAME "bootriscv64.efi"
> +#elif defined(CONFIG_ARCH_LA64)
> +#define BOOTEFI_NAME "bootloongarch64.efi"
>   #endif
>   #endif
>
> @@ -366,6 +368,9 @@
>   #elif defined(CONFIG_ARCH_RV64I) || ((defined(__riscv) && __riscv_xlen=
 =3D=3D 64))
>   #define BOOTENV_EFI_PXE_ARCH "0x1b"
>   #define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00027:UNDI:003000"
> +#elif defined(CONFIG_ARCH_LA64) || defined(__loongarch64)

Looking at
https://loongson.github.io/LoongArch-Documentation/LoongArch-toolchain-con=
ventions-EN.html:

There the following symbols are mentioned:

__loongarch__
__loongarch_grlen


Table 15.
C/C++ Built-in Macros Provided for Compatibility with Historical Code
marks __loongarch64 as deprecated.

> +#define BOOTENV_EFI_PXE_ARCH "0x27"
> +#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00039:UNDI:003000"

Where are the 32bit defines?

Cf.
https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml

0x00 0x25 	LoongArch 32-bit UEFI
0x00 0x26 	LoongArch 32-bit UEFI boot from http
0x00 0x27 	LoongArch 64-bit UEFI
0x00 0x28 	LoongArch 64-bit UEFI boot from http

>   #elif defined(CONFIG_SANDBOX)
>   # error "sandbox EFI support is only supported on ARM and x86"
>   #else
> diff --git a/include/efi_default_filename.h b/include/efi_default_filena=
me.h
> index 77932984b557..fac25039fd31 100644
> --- a/include/efi_default_filename.h
> +++ b/include/efi_default_filename.h
> @@ -47,6 +47,8 @@
>   #define BOOTEFI_NAME "BOOTRISCV32.EFI"
>   #elif defined(CONFIG_ARCH_RV64I)
>   #define BOOTEFI_NAME "BOOTRISCV64.EFI"
> +#elif defined(CONFIG_ARCH_LA64)
> +#define BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
>   #else
>   #error Unsupported UEFI architecture
>   #endif
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index 604243603289..cb0619f27e8a 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -50,6 +50,13 @@ static int machines[] =3D {
>   #if defined(__riscv) && (__riscv_xlen =3D=3D 64)
>   	IMAGE_FILE_MACHINE_RISCV64,
>   #endif
> +
> +#if defined(__loongarch64)

marks __loongarch64 is deprecated.

> +	IMAGE_FILE_MACHINE_LOONGARCH64,
> +#endif
> +#if defined(__loongarch32)

ditto

> +	IMAGE_FILE_MACHINE_LOONGARCH32,
> +#endif
>   	0 };
>
>   /**
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 011bcd04836d..45bdf45b5812 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -76,6 +76,10 @@ struct dyn_sym {
>   #else
>   #error unknown riscv target
>   #endif
> +#elif defined(__loongarch__)
> +#define R_RELATIVE	R_LARCH_RELATIVE
> +#define R_MASK		0xffffffffULL
> +#define IS_RELA		1
>   #else
>   #error Need to add relocation awareness
>   #endif
> diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi=
_selftest/efi_selftest_miniapp_exception.c
> index f668cdac4ab2..1e500a5ccc35 100644
> --- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
> +++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> @@ -35,6 +35,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>   	asm volatile (".word 0xffffffff\n");
>   #elif defined(CONFIG_X86)
>   	asm volatile (".word 0xffff\n");
> +#elif defined(CONFIG_LOONGARCH)
> +	asm volatile ("break 0xf\n");

Can we use an undefined instruction here as for the other architectures,
please.

Best regards

Heinrich

>   #elif defined(CONFIG_SANDBOX)
>   #if (HOST_ARCH =3D=3D HOST_ARCH_ARM || HOST_ARCH =3D=3D HOST_ARCH_AARC=
H64)
>   	asm volatile (".word 0xe7f7defb\n");
>

