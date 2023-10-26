Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB32C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 10:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF45A8750E;
	Thu, 26 Oct 2023 12:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FKnSImon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A9687545; Thu, 26 Oct 2023 12:43:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5500874D8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 12:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698317034; x=1698921834; i=xypron.glpk@gmx.de;
 bh=1g0UZBR4Z1qZX98p/UcZmDNEtL1yf1yJjfeQ8KudtGk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=FKnSImonGjm1D+HmDgUXdx0UY5axVBw5LMcV9ZNYZU45ft5/5EH0Ta6DJ2Xv17vv
 yPzrxc5aKD+dNm/idkDvRarDeB/8UmWb2RWD6Wd8BZc+fiBGoc5uT0jlEpFhY17mU
 bP+KPX28zsNKgCX85jY4Fqj2dtmqw7WrdRcwoCRecOkjFYYZauszaLZAUyniPfQr5
 8ez45xvPibXlQmK2SR1BW/yWPu7suDW6ccPfqhTOMPOYr1byoiGIbib/kIpx+bMOm
 Whxj92PqtiBW/dlO7PA4OhAEHP9S5enjIr8iiP8l9HL56L31NdhE9HF2xTBiTbMFB
 TkqqAMsEfbhQrDlIsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1rXDJR1QAl-017FK2; Thu, 26
 Oct 2023 12:43:54 +0200
Message-ID: <f9ce4a74-6bb7-4b72-97a4-0a605c4389cf@gmx.de>
Date: Thu, 26 Oct 2023 12:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/13] cmd: bootefi: re-organize do_bootefi_image()
Content-Language: en-US, de-DE
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: jbx6244@gmail.com, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-3-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231026053052.622453-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q2+G5EaL8xsYBlGUsW1cg6y0YmUgEne6RN83ReO/p1pO+21U0Qc
 6CWXakmyiyeBj61bSpoVXj25OUk0iWdJRryDGq+ScqB++AqlDIv4MIV49Bq6QyHIJsgAbmt
 aThpL7YTxFP5AUFQP3C81tsExnecEHUXidLFAThmzzFoNhZ/aPso+YrFt4RR5OPlOiq4h+S
 ZK/AxhI/fICy7jjQCGPuA==
UI-OutboundReport: notjunk:1;M01:P0:tqkzXVZHb3M=;63UGsZRy9MfqV7wIPto1goeuGfW
 3zKBWe37gl1MEp4bzLgMm6s8Wclv1l5YO5+fp9wV8f6RdgkU1fNhV9owkiAagvlEnF+FNq1Vz
 WxkK7hai8l00M9uYbW6S3leZH0xXU3OWWdrAqlcbMibpiTLkHRDpRw4ki8VMHiiGosJ+6VTBP
 h+VAGrl6TDzwvKiGSkhff2NojNzASPzLNDm5tZzGq46FMM9Aoi9hThV2BaYftsrew4Wjkaeaw
 82WiV4YzJKePhsyIETY/+j4Hbrrg1C87cjjYPo/lEQj3W9XS9IYEja/mRQCJv+krF9cLp/saJ
 f7CXbqzE1RysJlrz92Sq42WTvg1uUpkx4nd3AUDxzQ0hh2sWbwiCLXIElDbFpstAevj8PzVMC
 Hc02oiCFzueJ9OHV8MNCQkmF9mmfv/nsyPtC7xJcgkGeVm3F91dTyEsRnFLKtXxcOEbDSUjW3
 o+6QulmJlyVeKZq/AfAB9ATOky/0fZPy/K7FvZR4pQD/EKi4SNdNOtfqGopdmHeOlQBcvHj7Q
 l+da1Xx/lU1D583UHa3uZ87Jk44ZOUWv3meccN/BZA8H4P+Fz2z25xWTDWYqsHsoI+LkscVC6
 agiaEnSOYgMwQwvBS0PF7p6BWx+jeWNVg6b1JaIuYVlMmSM1h5WKvd9GAVkLNXQfj8fnqvf44
 QltgGv2l/UFrE8/i0nUQvt9QWIBwhaLYn9B9jLyU0KIhV0KoY6X0Aojx8j82RBQ3BgeIGnZKn
 U+cPQZOo6iSI+QqVEGFCY4rxKus9qYo3mcLkac9szWsyaaUUmicb7Km3B6rzDvd9dnCiKd6jJ
 zAMje+NKxHPpocOwXVxNx1YXFcyTO6AERx9X+RCtgxjRgf/R7olDxN9kWyfaSQyuw+yAsZ4Sq
 Eoegtq2mzbjSObPAbBmFbbPglEBZN5qrhCPHqtF6+YI9HLTgDEvf3+RNrCfy9ngMPNW/3lkvg
 iiPQa5+iXrkta3eu86J8sRBkSmE=
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

On 10/26/23 07:30, AKASHI Takahiro wrote:
> Decompose and re-organize do_bootefi_image() into three parts for
> the succeeding refactor work.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   cmd/Kconfig          | 15 ++++++--
>   cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
>   include/efi_loader.h |  2 --
>   3 files changed, 69 insertions(+), 30 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 0eb739203ade..825a41d68aad 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -363,9 +363,19 @@ config CMD_BOOTEFI
>   	help
>   	  Boot an EFI image from memory.
>
> +if CMD_BOOTEFI
> +config CMD_BOOTEFI_BINARY
> +	bool "Allow booting an EFI binary directly"
> +	depends on BOOTEFI_BOOTMGR
> +	default y
> +	help
> +	  Select this option to enable direct execution of binary at 'bootefi'=
.
> +	  This subcommand will allow you to load the UEFI binary using
> +	  other U-Boot commands or external methods and then run isince 2021. =
t.
> +
>   config CMD_BOOTEFI_BOOTMGR

This symbol is in lib/efi_loader/Kconfig:
lib/efi_loader/Kconfig:35:config CMD_BOOTEFI_BOOTMGR

Please, rebase your series on origin/master.

Best regards

Heinrich

>   	bool "UEFI Boot Manager command"
> -	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> +	depends on BOOTEFI_BOOTMGR
>   	default y
>   	help
>   	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
> @@ -374,7 +384,7 @@ config CMD_BOOTEFI_BOOTMGR
>
>   config CMD_BOOTEFI_HELLO_COMPILE
>   	bool "Compile a standard EFI hello world binary for testing"
> -	depends on CMD_BOOTEFI && !CPU_V7M
> +	depends on !CPU_V7M
>   	default y
>   	help
>   	  This compiles a standard EFI hello world application with U-Boot so
> @@ -396,6 +406,7 @@ config CMD_BOOTEFI_HELLO
>   	  up EFI support on a new architecture.
>
>   source lib/efi_selftest/Kconfig
> +endif
>
>   config CMD_BOOTMENU
>   	bool "bootmenu"
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 1b28bf5a318d..ae00bba3b4f0 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -491,7 +491,6 @@ out:
>   	return (ret !=3D EFI_SUCCESS) ? ret : ret2;
>   }
>
> -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
>   static efi_status_t bootefi_run_prepare(const char *load_options_path,
>   		struct efi_device_path *device_path,
>   		struct efi_device_path *image_path,
> @@ -581,7 +580,6 @@ static int do_efi_selftest(void)
>
>   	return ret !=3D EFI_SUCCESS;
>   }
> -#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
>
>   /**
>    * do_bootefi() - execute `bootefi` command
> @@ -603,14 +601,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>   	if (argc < 2)
>   		return CMD_RET_USAGE;
>
> -	/* Initialize EFI drivers */
> -	ret =3D efi_init_obj_list();
> -	if (ret !=3D EFI_SUCCESS) {
> -		log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> -			ret & ~EFI_ERROR_MASK);
> -		return CMD_RET_FAILURE;
> -	}
> -
>   	if (argc > 2) {
>   		uintptr_t fdt_addr;
>
> @@ -619,29 +609,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>   	} else {
>   		fdt =3D EFI_FDT_USE_INTERNAL;
>   	}
> -	ret =3D efi_install_fdt(fdt);
> -	if (ret =3D=3D EFI_INVALID_PARAMETER)
> -		return CMD_RET_USAGE;
> -	else if (ret !=3D EFI_SUCCESS)
> -		return CMD_RET_FAILURE;
>
> -	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> -		if (!strcmp(argv[1], "bootmgr"))
> -			return do_efibootmgr();
> +	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> +	    !strcmp(argv[1], "bootmgr")) {
> +		/* Initialize EFI drivers */
> +		ret =3D efi_init_obj_list();
> +		if (ret !=3D EFI_SUCCESS) {
> +			log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> +				ret & ~EFI_ERROR_MASK);
> +			return CMD_RET_FAILURE;
> +		}
> +
> +		ret =3D efi_install_fdt(fdt);
> +		if (ret =3D=3D EFI_INVALID_PARAMETER)
> +			return CMD_RET_USAGE;
> +		else if (ret !=3D EFI_SUCCESS)
> +			return CMD_RET_FAILURE;
> +
> +		return do_efibootmgr();
>   	}
> -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> -	if (!strcmp(argv[1], "selftest"))
> +
> +	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
> +	    !strcmp(argv[1], "selftest")) {
> +		/* Initialize EFI drivers */
> +		ret =3D efi_init_obj_list();
> +		if (ret !=3D EFI_SUCCESS) {
> +			log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> +				ret & ~EFI_ERROR_MASK);
> +			return CMD_RET_FAILURE;
> +		}
> +
> +		ret =3D efi_install_fdt(fdt);
> +		if (ret =3D=3D EFI_INVALID_PARAMETER)
> +			return CMD_RET_USAGE;
> +		else if (ret !=3D EFI_SUCCESS)
> +			return CMD_RET_FAILURE;
> +
>   		return do_efi_selftest();
> -#endif
> +	}
>
> -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> -	if (!strcmp(argv[1], "hello")) {
> +	if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BINARY))
> +		return CMD_RET_SUCCESS;
> +
> +	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_HELLO) &&
> +	    !strcmp(argv[1], "hello")) {
>   		image_buf =3D __efi_helloworld_begin;
>   		size =3D __efi_helloworld_end - __efi_helloworld_begin;
>   		efi_clear_bootdev();
> -	} else
> -#endif
> -	{
> +	} else {
>   		addr =3D strtoul(argv[1], NULL, 16);
>   		/* Check that a numeric value was passed */
>   		if (!addr)
> @@ -663,6 +678,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>   			size =3D image_size;
>   		}
>   	}
> +
> +	/* Initialize EFI drivers */
> +	ret =3D efi_init_obj_list();
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> +			ret & ~EFI_ERROR_MASK);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret =3D efi_install_fdt(fdt);
> +	if (ret =3D=3D EFI_INVALID_PARAMETER)
> +		return CMD_RET_USAGE;
> +	else if (ret !=3D EFI_SUCCESS)
> +		return CMD_RET_FAILURE;
> +
>   	ret =3D efi_run_image(image_buf, size);
>
>   	if (ret !=3D EFI_SUCCESS)
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f40..48d4999e56a9 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -878,14 +878,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
>
>   efi_status_t __efi_runtime EFIAPI efi_set_time(struct efi_time *time);
>
> -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
>   /*
>    * Entry point for the tests of the EFI API.
>    * It is called by 'bootefi selftest'
>    */
>   efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
>   				 struct efi_system_table *systab);
> -#endif
>
>   efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
>   				     const efi_guid_t *vendor, u32 *attributes,

