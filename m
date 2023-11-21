Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE177C5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 03:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D554A871E7;
	Tue, 21 Nov 2023 04:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="njLxYLWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD9F87574; Tue, 21 Nov 2023 04:31:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A7886F34
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 04:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700537501; x=1701142301; i=xypron.glpk@gmx.de;
 bh=xuvwGxJwpcIdIPhOaO2PYQ3BEY2JGJ1X+ucssHrylWU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=njLxYLWR+oOeMR5TfbxSD6fOySQc1OzgCa+JJncd9fA1LtEp9VBdStaHjNSc17H8
 aJxdblYlHVSR34vsKaE1oecG+396p2bFeD4Wu4rPxb1uSQM5MR5XtXj29XbzujxkC
 r6uFareB4V5jYgj/BNbyxWsmoC5i2rFzOzexx7gJgRpemRm9eH8eVGc06k/GuI2tP
 LQcuAFBms6V13rqHgx3UIJOK5UsDoq2GxiU3xCKO9pi9V1P/00fqfutxfW+zevSq5
 L/5rUlK1UzuPV8YA+5U+feZf6BUsZoaqvSxBc/7u3EkWCxAM/jXpDwFgwu0hXX+/Z
 mB5smqdsnxRCfHJUxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1rLyvJ1d0m-00s4DC; Tue, 21
 Nov 2023 04:31:41 +0100
Message-ID: <26ddf551-dc01-4873-956d-322bb95ca981@gmx.de>
Date: Tue, 21 Nov 2023 04:31:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] cmd: bootefi: re-organize do_bootefi()
Content-Language: en-US
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-3-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121012950.156539-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FKtCbu99P6x6pj6AmSIsh2UFNsX8B6fdwPzapzN8PKl0zL8wlh7
 OyCp6E11K9T5j6g5CfWFBJSip2CV3sttv77Cc86DXWb4BafSQT8apYBSq/zPp+UlvF5CAl8
 phbILfN8blwb+NS+Hm4UWvsgxM2IDlLkpdaOzVNBnS9z6sdCXE3pXeBaGEQ24hFLgF90pT/
 dbX7mNaeRVCuOYuhjqA5w==
UI-OutboundReport: notjunk:1;M01:P0:wLjUdv7dZAQ=;dFoIXpuxswOAjfEjZOxc8Y0wiBm
 xt8U7ketQ1cSQf7M8OZcM+xcbzOs6hLRNr9Keym8AkpdPM3ZCiFr7wBEPl3t1wv7VVqxMKSzB
 nbDI3PIlv1fUsOcDbpBl/zKqa73uV2ZtZq2R3HiZCUStXnbRpndVL1SUbh1Za5fCBvAtIqF8P
 8WfRhrhe0dypLbYJVRaGd/oqivEsbps8JG+4fqmwgMVuegI0oQ990shoJEf0YXZJ+pfAp1mwH
 tmAhmF+AcebOtfRfpT4nXP5p08XHkZy9phcmFGQL486nj1Da2Qij6eq+1H5jDkbem7bm3N3y2
 ZSW34vdXMy809lErSs1GOZMPfeOtLgSI0z0LKvmC85WeDtBedMgFDSKnX5YdwgCyOpzmXWrPQ
 uBlyqt4UOJ9FBpAOxtk7OBMr8938M1dqA8BWfwn34PF02/a5gnq9/+PmdF9/dO4nnauQJwAO9
 ySW6GPetYCaJsd4IA2/1tPrhfnfg6/64h+TDqicNPWaME9eI8CgKmc3npcna/scDDDnMyQmXo
 tU2/HD3hEn6QSiM7rYfNUIlBLLovaRraVMJVScpY67J3mQIrH5L93AN9Zz93BVAkQiR8VoSRJ
 WG1VAKwsfcm+JeUtOUg/gfZYLyAFqGf6rauEFwXS/1h+zTJ3peUTCJSpXMF/QYwhJ8qB/3/IU
 17wdYNsYIzQmg9ZpNYksqk/2FKG4l4RzsZytX0HCyYLwVs0cqtTYiSggI6s+faBe+svZf6lxw
 q8JVzEcQ93CMqDPSRwS/MWPzm5mMzEx6qUNtdA44Bdhbz4zvxMVIh3J9pS+TNOodtyhOFU/8C
 RaG74gSydJecrn4R1iCgTKkicEIopthMAmItmMDICOZ33LBw0cDCtrKlPrtdCAAMOu3CdZ3FE
 LOcqE0oB8tobZ8iU0FuONI9EJy2offx+VMIr0pLDg2iFLVZZzxgoiORggHDOHX/S0USROLdAM
 LqcG3rRvJYxW0u+iwlSixmb0oL4=
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

Why should booting a known binary depend on the boot manager?

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

Why do we have this dependency?
EFI_LOADER cannot be selected for SYS_CPU=3Darmv7m.

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


https://docs.u-boot.org/en/latest/develop/commands.html
suggests to use U_BOOT_CMD_MKENT() to define sub-commands.

> +		/* Initialize EFI drivers */
> +		ret =3D efi_init_obj_list();

We should not duplicate this call for each sub-command.

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

These lines could be moved into do_efibootmgr.

Should we move the translations of the return codes into efi_install_fdt?

Best regards

Heinrich

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

