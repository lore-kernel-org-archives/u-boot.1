Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7CCC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 12:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B63D87759;
	Sun, 17 Dec 2023 13:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eXnSazQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6781A87759; Sun, 17 Dec 2023 13:00:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF96F87705
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 13:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702814431; x=1703419231; i=xypron.glpk@gmx.de;
 bh=32qKWTilDepez/28Hh1ImQTlbY4micdttPvqY7m3l4s=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=eXnSazQkAOPd6ktZQu4JI21ArpcokeRTiJYYSWya0B1iE4+6VuJxDlBVbGI5cSgU
 UuIwb+eU28RtJEEelQZgsPVLGEkys+7jEGw8VtzbUzkWL6cw7QX/vsK1uDuaDELxX
 rsyHEYc+KDH/kec/UqXJeS5PXZjbraomxoZWu2E/e1nOB/fTCMdCTDb1iYwQgF1PZ
 bsW38SBADrCZ8vNl0Q6KA+KWvuUvZp1GqBj+Yxmc1bKJpFXavJ8VoKW20k4JQtcLj
 PgPgb67Cuyjs3qRit1yYmhkU4km5QCf7PPPyh8zmt2D3/32Cs7/LKTHlyWC+g2gEP
 Awlz0RkALtaDwantxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv2xU-1rWE750jnk-00r0qL; Sun, 17
 Dec 2023 13:00:31 +0100
Message-ID: <a41187cd-02de-4594-b822-ccc23d00f33c@gmx.de>
Date: Sun, 17 Dec 2023 13:00:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] cmd: bootefi: re-organize do_bootefi()
Content-Language: en-US, de-DE
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-3-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121012950.156539-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MlOFeEbexQu+k6Nv3iBb5C2GU4WCF+zpPu/AWHd90hwFjpIkR97
 Kfwu7XM7ECipEHbWRTP9brnOuaBvJXF2bP0zh5lCLPtp4ByiwyvhU5OVu6pw01Qhn3sbKDe
 XkwivnVHkMjf8LgDQpCgcYZGxZIIN01bnBuggietQA7ZPUqdJaJZdZZlvgNDBa3dDAaMmBw
 5i/PXFSYxZZBGnrkX0WiQ==
UI-OutboundReport: notjunk:1;M01:P0:7mUVqtsQHO0=;hvJyzI+9whP8aXELKJPkvaeopIN
 BDIDfLoC5a3CNUV1AwclL/5dMwwhasXjjMY49IT0Oe2SDgXwYNzzZFRPyFZqtU6aqOjnZKyWN
 mIABV3CjouRtpLTBZYTnUFMJZpXiCUYEi4FRh/cvax80PRISZ5X0uHyigWV7T+mbqM1nr5y6T
 5P1t0WCIXwiTdmyHaLIp8T4dGRQrF+xzMt1zYDDHXk7yzEqf/isAaz7noN+gX8K2C2skcr6T6
 WGwrqMCCAygGMUYu9RbklHPqZ7GRQiFsdr27W0/4gG1Dx1oM/mGZkeCe1/DJmTGAKCxL2Aamu
 6OsFZPslfxvLZ/llRolPqcSHiSoCLl3AdVDvw4IFc0EvbTmlYBRPaQOyuK3odcduAd5FSa7ED
 RZRmmslo28raJalAshKR+LwjJFlzqZ4gWkOmSMUEvpwb7gOhkqB+Wng/nUgztH+CLoPxu5B7v
 DxRBcImePsTEws664S43wVXGpG6slB2sj/ZspIfPcFCAVXu1O3oIn8j34k0qhbVeuqyf9PGQl
 6MrsfJVSiXQUFRt8f7UVW88YtboGIqrftET4QQBjSBsPAMeDRof07ENdk42sZKOJgWYIDEVH7
 NHkv1FNoQW46waFUTeD32ei+zCDF7VR9f9n8MV6Jh/FgNfULfJrau6iCMVcuJR4CJfLLjpp4V
 zLAuNDR/Nerv7CJroNj77dcYuaZykYjA2ZSXVZMtNXQUuIwAeRnGoLOkkyhz3cFPHfZJLSjef
 9aquGeqmBQiyVTkEnAdfT1X0gCe9/Zojn1cxaBhmAkpMadzrPAgWSnPAb2xpn5aMEOoc1j678
 uw8Kl89Lvv1EjG0pkMqw1ZiJ4TnSy3yMzNIT9s26qigaGEg914bGYnOg/n32CWDWY60xFlG+F
 i9om8ixmF/QDVqVh22hDogGYuFaD2J4440SM0xTC71+NoSfQLBTXKtlGCGnE9qLyK6gL/vxw7
 +F01VBKnDjOQTyGvtsaWkYShk6I=
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

On 11/21/23 02:29, AKASHI Takahiro wrote:
> Replicate some code and re-organize do_bootefi() into three cases, which
> will be carved out as independent functions in the next two commits.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   cmd/Kconfig          | 15 ++++++--
>   cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
>   include/efi_loader.h |  2 --
>   3 files changed, 69 insertions(+), 30 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 6f636155e5b6..4cf9a210c4a1 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -362,9 +362,19 @@ config CMD_BOOTEFI
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
> +	  other U-Boot commands or external methods and then run it.
> +
>   config CMD_BOOTEFI_BOOTMGR
>   	bool "UEFI Boot Manager command"
> -	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> +	depends on BOOTEFI_BOOTMGR
>   	default y
>   	help
>   	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
> @@ -373,7 +383,7 @@ config CMD_BOOTEFI_BOOTMGR
>
>   config CMD_BOOTEFI_HELLO_COMPILE
>   	bool "Compile a standard EFI hello world binary for testing"
> -	depends on CMD_BOOTEFI && !CPU_V7M
> +	depends on !CPU_V7M

CMD_BOOTEFI_HELLO_COMPILE makes no sense without a command to run the
hello command. The CPU_V7M dependency is not needed as described in

[PATCH 1/1] cmd: CONFIG_CMD_BOOTEFI_HELLO_COMPILE dependencies
https://lore.kernel.org/u-boot/20231217114457.70128-1-heinrich.schuchardt@=
canonical.com/T/#u

Best regards

Heinrich

>   	default y
>   	help
>   	  This compiles a standard EFI hello world application with U-Boot so
> @@ -395,6 +405,7 @@ config CMD_BOOTEFI_HELLO
>   	  up EFI support on a new architecture.
>
>   source lib/efi_selftest/Kconfig
> +endif
>
>   config CMD_BOOTMENU
>   	bool "bootmenu"
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 190ccba260e0..e9e5ab67a1f5 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -503,7 +503,6 @@ out:
>   	return (ret !=3D EFI_SUCCESS) ? ret : ret2;
>   }
>
> -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
>   static efi_status_t bootefi_run_prepare(const char *load_options_path,
>   		struct efi_device_path *device_path,
>   		struct efi_device_path *image_path,
> @@ -593,7 +592,6 @@ static int do_efi_selftest(void)
>
>   	return ret !=3D EFI_SUCCESS;
>   }
> -#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
>
>   /**
>    * do_bootefi() - execute `bootefi` command
> @@ -615,14 +613,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int fl=
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
> @@ -631,29 +621,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int f=
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
> @@ -675,6 +690,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int fl=
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
> index 664dae28f882..44436d346286 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -879,14 +879,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
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

