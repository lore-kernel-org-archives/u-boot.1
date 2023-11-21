Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C5C5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 03:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658F187593;
	Tue, 21 Nov 2023 04:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NXUfGLAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775F687596; Tue, 21 Nov 2023 04:38:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853428758F
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 04:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700537893; x=1701142693; i=xypron.glpk@gmx.de;
 bh=q54dYYgEFbd9BTa2tJcc9T1fG8CdXajQYlw+dGrirW4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=NXUfGLAH4SasFmu71AHq6JWUwu7zn7Ouz4CFwQO/Y8FFEV5437W4MrxYQKzLp7qf
 PemvmK0+SMeqzKwMxxNhTAY5UL+bJYlBXruwGYT6cBfyx2XYMu/wnfDMuKHfcAGaQ
 yzQy3NVajwNJ2Q5XGSB59sUlxkcmiH6pcUuvMn+04VUf+QRA6Bx5+bdA/w+UjTzso
 XcwIOX4xj9fthVHmAibeNUS2jBwWvFx9hwBo9IVyUZmSRexHg0Hki/qQS49JncUAc
 2FY3BpoQXCYyorjUOIjhhzlQQwJZ3SRfZ6btIm//NHvCQ3AzLcam1s0SzsCoWtcKU
 1Y8JZ8atX/1ZCnZcxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1rhtej0WPc-00nkG6; Tue, 21
 Nov 2023 04:38:13 +0100
Message-ID: <fffc514b-a986-482c-a468-6d52598a046e@gmx.de>
Date: Tue, 21 Nov 2023 04:38:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] cmd: bootefi: carve out EFI boot manager
 interface
Content-Language: en-US
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-4-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121012950.156539-4-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tk6NjbXiubm4MW7eoQ130jtV6fQZBw3IC75KU4bM61UShXNZ9q+
 yFS/cO5SvsdE9jqjAE0EB0BifU6a36MWqMi9uz+eRyDls+yEiPadPuap6gN7w+1A83NzR/s
 RT4Eu3gMpoNZFb23u3sxc7xJtm5NEhfJhYTpiAYdUl/pXOC8CxQ7G5b1vV+sEycm5XQjXjZ
 HYo6DDZsG6lXh8bsBnJgg==
UI-OutboundReport: notjunk:1;M01:P0:qY6oAxKBLvg=;sUk96ssJF1RW2nr1ATJZCME1mgd
 obGohcXvQp2ODWIwocPPBXHeZzNYH54Wqod4WumqUS5Fe11lJ9WzHvkSeqTzWnmGwqlx6SMy5
 yewh3k40bb7BUklQD6bvsrua685rNnBTLC/4NTU0JJJveuuT8hrCkoIXaF0QgWSefQTf8ac9H
 SfaVYT9T3AtUaB/a/OOryBB1IAkJwi9z5VJ0B12Ac+mtzSYGKSEb6prMblBx0BSuF54wGJShH
 V/kuZgJrIm3Fv2IA6xJEj6nPmx4qugb8AOCoWJrtm2/PT6B3ROmMmQkOItWnKlyHJy1G1Ubsf
 /WixXjgTA7+uz3idVxoCLbttcO/R/hruD/sQfnr0zQiwIEIBctvoP/yWO+zTvCweGWoxLpZOq
 Cr+j8MHc/3oq9DXNrWlQziCGSq0Txa3DWk+0xhdeZfHV5zH9C5DemRHcanPM/cC3VsnVZ8+D8
 QoIyl4+HnzmQyeT9Obz9jGn57GmUzYQVh7iBFPkmV5JzH4GNt2eQrWGnEQGx6WvPfd0LdRKKa
 ImclaTZTKQvgLRQuQShF24RBr5smrDdzQZmC/LOKaUhfUfgzulX1VvGddRnn0hPvkRs18nm/2
 8QfQ0uf23Jhn42xTkkBR7qtzN8vXleBcUV206A00VIqAAaIMbiFfQjf4+QIfCzo9HL68LRW4t
 DILxVwJi1ihVFG4W+pMWmTyhdx08blQkMXWld7kWj3shBAYk8ZmC9ThLzqcP15FRsLWZCvwsA
 dEdeEy2nCBnWskuI9h/DRYJ1R+UnFAEDl+XJI/W/mFaqi82LwrbC7ZjCEzWjBp1MUp+Bh+ugC
 GttUfcCFiRn3lclnsgpSo8e0Ma9yPfff993SdWx/qMMHk5QolR/sABIPT6hQWD2WGDw3WRKV0
 giqfLYvEYJm4lg9V6JeSSEJE5zZIf7JF5U14KsNAp6DDvRAVyjOB7s9xW9bFPidzYmYiOZUvw
 mbLEAL3aDKky+/pL3r+AocFJve8=
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
> Carve EFI boot manager related code out of do_bootefi_image() in order
> to move boot manager specific code into library directory in the later
> commit.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   cmd/bootefi.c | 43 ++++++++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index e9e5ab67a1f5..87910c42333a 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -413,28 +413,40 @@ out:
>   }
>
>   /**
> - * do_efibootmgr() - execute EFI boot manager
> + * efi_bootmgr_run() - execute EFI boot manager
> + * fdt:	Flat device tree
> + *
> + * Invoke EFI boot manager and execute a binary depending on
> + * boot options. If @fdt is not NULL, it will be passed to
> + * the executed binary.

How about the fallback to the control device-tree?
How about booting with ACPI?

Best regards

Heinrich

>    *
>    * Return:	status code
>    */
> -static int do_efibootmgr(void)
> +static efi_status_t efi_bootmgr_run(void *fdt)
>   {
>   	efi_handle_t handle;
> -	efi_status_t ret;
>   	void *load_options;
> +	efi_status_t ret;
>
> -	ret =3D efi_bootmgr_load(&handle, &load_options);
> +	/* Initialize EFI drivers */
> +	ret =3D efi_init_obj_list();
>   	if (ret !=3D EFI_SUCCESS) {
> -		log_notice("EFI boot manager: Cannot load any image\n");
> +		log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> +			ret & ~EFI_ERROR_MASK);
>   		return CMD_RET_FAILURE;
>   	}
>
> -	ret =3D do_bootefi_exec(handle, load_options);
> -
> +	ret =3D efi_install_fdt(fdt);
>   	if (ret !=3D EFI_SUCCESS)
> -		return CMD_RET_FAILURE;
> +		return ret;
>
> -	return CMD_RET_SUCCESS;
> +	ret =3D efi_bootmgr_load(&handle, &load_options);
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_notice("EFI boot manager: Cannot load any image\n");
> +		return ret;
> +	}
> +
> +	return do_bootefi_exec(handle, load_options);
>   }
>
>   /**
> @@ -624,21 +636,14 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>
>   	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
>   	    !strcmp(argv[1], "bootmgr")) {
> -		/* Initialize EFI drivers */
> -		ret =3D efi_init_obj_list();
> -		if (ret !=3D EFI_SUCCESS) {
> -			log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> -				ret & ~EFI_ERROR_MASK);
> -			return CMD_RET_FAILURE;
> -		}
> +		ret =3D efi_bootmgr_run(fdt);
>
> -		ret =3D efi_install_fdt(fdt);
>   		if (ret =3D=3D EFI_INVALID_PARAMETER)
>   			return CMD_RET_USAGE;
> -		else if (ret !=3D EFI_SUCCESS)
> +		else if (ret)
>   			return CMD_RET_FAILURE;
>
> -		return do_efibootmgr();
> +		return CMD_RET_SUCCESS;
>   	}
>
>   	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&

