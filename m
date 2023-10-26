Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F1EC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 11:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 978C6875BD;
	Thu, 26 Oct 2023 13:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tT4Dlqft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C4E875BD; Thu, 26 Oct 2023 13:01:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F504875B0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 13:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698318102; x=1698922902; i=xypron.glpk@gmx.de;
 bh=vf7YJkJ0VvV40G+CDvt9BVFcEW83MWqr5UAn0Mwow0Q=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=tT4DlqftROYs/mCyA2+zXsI4EKmNQ6CicYUnHtnMggRrR4Ww39CCNVxnEcIaXYXs
 I9xMwfJ2BMWsgCS0JR3Uzot2hjouMDRkbyjCGT4r7TsjG9uZV5Q49oFnWxgrgjygx
 FkA8OqD0G8+UgqcPuwhUUggdFoPtOvBxtTD8wPKELOhZ7uE3LDpNNX9J1R5hzsORa
 iXPZubtPFYdBjQxS76B/JkVsKvgdxD7r17hVj8YcVjIogVz4FLQ2GFRNkxwaFeRYF
 u03DIScv6cHPEHGG8IE2mGO+nCg3kGWOmstysfHHSIGZn3sOFuCP6fOw7aeATdzgO
 995kiezQxgltHCH/yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhlf-1qo1NB0tPz-00Ajnn; Thu, 26
 Oct 2023 13:01:42 +0200
Message-ID: <b6110e38-5a44-4fcf-8ae1-ad77f1b66390@gmx.de>
Date: Thu, 26 Oct 2023 13:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/13] cmd: bootefi: unfold do_bootefi_image()
Content-Language: en-US, de-DE
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: jbx6244@gmail.com, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-2-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231026053052.622453-2-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x/Y4L74Mb4jfdz4Iy/IfX/U7L/pAxLjwuTy8vqvJEtPc0AA265B
 d+/wc+26xVK2XY/0ibwWOh8/im27EFLOcBnwbNndRjM3iH/fMniqelDWwNUgwws5uJYvY5r
 nVCCQF2wz+Bqu6Uqv4WPqZRZLTcWhVzHnphEGDlqxQmUpVIp2VbnuZ3vu8+ly7X09eLI82C
 CqXrx8QZEOJE7SqKb0qTg==
UI-OutboundReport: notjunk:1;M01:P0:X9RNNJKWrVY=;bsvlVjMdCnXfy0R9XCVOBfchdeT
 UlEUcM3GW0VTu5rKHCX7fxJfJM19T3qPPuZpiJLJ4GO7YNlcINRzwaHTJA3F25WwlJ1q1wwMw
 DGGIfs1HHGGlhgJxKzacvoqoOh3RCgT1+NVPMcBg2+KVDJqfqC+n6Yg85D9R1jLVlN4I58JBV
 WiqLJCOli2ar/TBQdKM6wJEAgQ+TFDMATlyzyVNhsWDQK9aur3tIT0p/y+91ds7YZ3Q7+iEJW
 dWRV3J5BYojeHD84dcUSDnqVp9iz34Ep0I1nvlhAJbRTpchzkSjqZSLKAjij0/z2dIx/WLNK4
 HlqGiGDY1miZ2YDpQRjIU8C83WFPeef6luNhgileAGS6k+eMBPvvXLC6EJIGVX683g1HfTpiy
 qLS+Jei1PCtkqSR8j9hGHyBUqBXRBR1zxCBPdp1aCjNIDkh5nAu3gU5cCsjUMkvscdjVNw6jK
 D9EC10UNIw1+N7YLXX93kJ32K/qO84HIruUdLnBe2XVdiBt5OZq3l2iyO7NTgFHwB7dxziQIm
 wCHPFHeaVUTB3Du5oHxQiCUjqaf9mblG/dktImVF+ssPkNYZ8QJl1v/eFnsKq9WDvM2AEW2a9
 Edu/LrXfQRke/SWvD/QG3SglfByyfisFJnDSB4Kf7ZdnzvsnjA1Yu8h9HSyE60DWVfL9ho0+r
 ZehgfIKIWMMXnBgpEs8iU7SBavh363iXbpkCfxHYGWeJytrdD5T4pzAFBlBXsJe1x4WLk/A4n
 Eohjt8FW1ci99FqxrLqKxmSxpPYPHSpYiGSfJYMMBVCIyFDC+If8Mn5VKegEp4gCwnzxf/JRS
 3ChevNeCQwZyVGZ2Mmhv/SIasS5D1i5Lx7hOABqsKhhQZqcqlrn78t4t6TMd8X0rhGXRvuIL+
 +0XKR69sjvUp8BtxB5tJpfQo57Se9sXZQhwB77Bi1aWBEVsNj4W9/cdDTWS0MBzCi1K+WFQpX
 fOBJmJZZ4JPegcQw57Kvo7Wt6hg=
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
> Unfold do_bootefi_image() into do_bootefi() for the sake of the succeedi=
ng
> refactor work.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   cmd/bootefi.c | 101 ++++++++++++++++++--------------------------------
>   1 file changed, 37 insertions(+), 64 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 20e5c94a33a4..1b28bf5a318d 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -425,58 +425,6 @@ static int do_efibootmgr(void)
>   	return CMD_RET_SUCCESS;
>   }
>
> -/**
> - * do_bootefi_image() - execute EFI binary
> - *
> - * Set up memory image for the binary to be loaded, prepare device path=
, and
> - * then call do_bootefi_exec() to execute it.
> - *
> - * @image_opt:	string with image start address
> - * @size_opt:	string with image size or NULL
> - * Return:	status code
> - */
> -static int do_bootefi_image(const char *image_opt, const char *size_opt=
)
> -{
> -	void *image_buf;
> -	unsigned long addr, size;
> -	efi_status_t ret;
> -
> -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> -	if (!strcmp(image_opt, "hello")) {
> -		image_buf =3D __efi_helloworld_begin;
> -		size =3D __efi_helloworld_end - __efi_helloworld_begin;
> -		efi_clear_bootdev();
> -	} else
> -#endif
> -	{
> -		addr =3D strtoul(image_opt, NULL, 16);
> -		/* Check that a numeric value was passed */
> -		if (!addr)
> -			return CMD_RET_USAGE;
> -		image_buf =3D map_sysmem(addr, 0);
> -
> -		if (size_opt) {
> -			size =3D strtoul(size_opt, NULL, 16);
> -			if (!size)
> -				return CMD_RET_USAGE;
> -			efi_clear_bootdev();
> -		} else {
> -			if (image_buf !=3D image_addr) {
> -				log_err("No UEFI binary known at %s\n",
> -					image_opt);
> -				return CMD_RET_FAILURE;
> -			}
> -			size =3D image_size;
> -		}
> -	}
> -	ret =3D efi_run_image(image_buf, size);
> -
> -	if (ret !=3D EFI_SUCCESS)
> -		return CMD_RET_FAILURE;
> -
> -	return CMD_RET_SUCCESS;
> -}
> -
>   /**
>    * efi_run_image() - run loaded UEFI image
>    *
> @@ -648,8 +596,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>   		      char *const argv[])
>   {
>   	efi_status_t ret;
> -	char *img_addr, *img_size, *str_copy, *pos;
> -	void *fdt;
> +	char *p;
> +	void *fdt, *image_buf;
> +	unsigned long addr, size;
>
>   	if (argc < 2)
>   		return CMD_RET_USAGE;
> @@ -684,18 +633,42 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>   	if (!strcmp(argv[1], "selftest"))
>   		return do_efi_selftest();
>   #endif
> -	str_copy =3D strdup(argv[1]);
> -	if (!str_copy) {
> -		log_err("Out of memory\n");
> -		return CMD_RET_FAILURE;
> +
> +#ifdef CONFIG_CMD_BOOTEFI_HELLO

I would prefer a normal if and let the linker sort it out.

Otherwise looks good to me.

Best regards

Heinrich

> +	if (!strcmp(argv[1], "hello")) {
> +		image_buf =3D __efi_helloworld_begin;
> +		size =3D __efi_helloworld_end - __efi_helloworld_begin;
> +		efi_clear_bootdev();
> +	} else
> +#endif
> +	{
> +		addr =3D strtoul(argv[1], NULL, 16);
> +		/* Check that a numeric value was passed */
> +		if (!addr)
> +			return CMD_RET_USAGE;
> +		image_buf =3D map_sysmem(addr, 0);
> +
> +		p  =3D strchr(argv[1], ':');
> +		if (p) {
> +			size =3D strtoul(++p, NULL, 16);
> +			if (!size)
> +				return CMD_RET_USAGE;
> +			efi_clear_bootdev();
> +		} else {
> +			if (image_buf !=3D image_addr) {
> +				log_err("No UEFI binary known at %s\n",
> +					argv[1]);
> +				return CMD_RET_FAILURE;
> +			}
> +			size =3D image_size;
> +		}
>   	}
> -	pos =3D str_copy;
> -	img_addr =3D strsep(&pos, ":");
> -	img_size =3D strsep(&pos, ":");
> -	ret =3D do_bootefi_image(img_addr, img_size);
> -	free(str_copy);
> +	ret =3D efi_run_image(image_buf, size);
>
> -	return ret;
> +	if (ret !=3D EFI_SUCCESS)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
>   }
>
>   U_BOOT_LONGHELP(bootefi,

