Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C616C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 13:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AFC7870DF;
	Thu,  9 Nov 2023 14:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="R+miJIlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C98870E1; Thu,  9 Nov 2023 14:57:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF9087075
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 14:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699538253; x=1700143053; i=xypron.glpk@gmx.de;
 bh=lmmxTe/zGhW8Y3173NDUAymUECtvWWFS+HkG/4rokxU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=R+miJIlpcSNTWgfD4qA3oMK76j+4/GPGt8bejigC8K+T54filBaJ4RVXhhuBBXtp
 9Bpo5BdunL9zC8+jsjoDB6UDpfl7J98I7VIQk0BtpW3/TOg7EUqgm8P9G8RzGAE4S
 vcJ070QxiUMrhOWsoOFq2vbGRTqUMRgoiinyvxd5RqjfKYQsOHVTHEdj7snrnptXj
 8D24cFSAnirzDpXTcMHC7cFJ91uD9iDwNLwe1c/o1sIu9QaG3mPfjj0jQMisnkQwd
 p7AO3RgWsGqPDMRNNEqfXBugFKjhT7/xzIPmZrW7YDElxgHquVMTmgzmhYptw8Yo2
 N3tXaU2kQVqDyX06AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.5.50] ([4.28.11.157]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1rdCVj3IIF-00glSs; Thu, 09
 Nov 2023 14:57:33 +0100
Message-ID: <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
Date: Thu, 9 Nov 2023 05:57:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Fix UEFI variable error handling
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231109125541.10845-1-o451686892@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231109125541.10845-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uwEPF1ncYsbKQudZ/RG7BD2IMNAyqtVa1ahX+Df2suln5Utucu/
 XmE4PMwh/P6ERnY+iGS8ZcaaOezbbtEAb/cMmnddbUwDAUBeHpzMvU2ZnZ583RaEHoiWcKY
 M5KTDCSddRXYzF0QtIK1PQi0bGZO28bIcwnkTnfVCNiN7ysyEyBJ9EVuRSxTO47ANsL0XQ4
 Y+Ovd5mVEmphJlkqmZzKg==
UI-OutboundReport: notjunk:1;M01:P0:XGfwrlkl/lY=;50xrxKd+hPfsBadSvHfLTltTR5V
 7/8NexAmKJbZy1vTMN+d/GUe9aE7bra4Mh/9Knh+9bcz/x3E2SjokLiUD5s1+GH9w+mS4x3lC
 ueuk1ca1OQqrc7JUIhsqlU5Vrc8TGM1CyAGAG+QlaTBs/6c69lBcTePz1cqipeZhaN6Irb6xp
 3uHjF1C4CJtvmDbITDNBJdADlmIgfGFkPOBZpnRKzeiYjfSKjGoZ2K9n0NnYFRHfjEq9HgklQ
 eFHOGK8p7HCOowtab8EYGgbPv2IYvDR2RL/kNNhmj8o3vzhNmdypOqueJkFzt4RhwyLgWVM03
 FnpD0aBtIXkrFY4+bSgffMezNauyN5nTZd0FUUNQGZXJazC2LJ0cWHkVa43/3p50uXL0LzAyB
 w+ydb/jNDcspGUmliooLeh9N6dyYkezpedlBe00EF/6/0mOHoFI57pxCcYKAHaeK4jRXHkcl2
 NY+XbawFMYflgwoMc+ZnFHE2mGMLzKFkgJ7pixU3zhIQh8Ht+t7T/QR1/MuB4WkziQLbEF8Hb
 XLSWqCKLWswg8XXfpMNcFm8008lfIc9A7mHv7BDPqzCdIaYexSW0B92pod7VsU1xZufScF9Oo
 4H+T/xC8PcsxAlhILlsgcBAe/3UB3j1PAav5ySwpYAhx8gfr57dv2RmDmgoT091//7X1zMWFD
 jMZvPGDr9W3msXq1XUKDv5Tk23rPDX5Me+Eq/z3qre27V2SnqNiGBweGX0Sq0lTBkUM44K7JG
 V5YGh3B+5yvO3SDNX/ATWTdTuOdhI3k1853DmTKtnTBALvYA07bzflN+WzZ2AdRS8DSM9wut5
 OE33MWZg8etqkKTKHbBS9qMAK79nlvpJTgqDcNIrgap5yDvMwQqWAyqr2rND/7oZv2cb2X6QT
 TjuLsTSSOLKa0gBrsAJk/HOS8aSeP3Ay1yVok9pIuRHm0GO5MgiQ1mSfNivCNlpouSW3CpPn+
 41tWlg==
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

On 11/9/23 04:55, Weizhao Ouyang wrote:
> Correct some UEFI variable error handing code paths.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   lib/efi_loader/efi_var_file.c | 1 +
>   lib/efi_loader/efi_variable.c | 8 ++++----
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file=
.c
> index 62e071bd83..dbb9b1f3fc 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -236,6 +236,7 @@ efi_status_t efi_var_from_file(void)
>   		log_err("Invalid EFI variables file\n");
>   error:
>   	free(buf);
> +	return ret;

Hello Weizhao,

thank you for looking into the error handling.

U-Boot's UEFI variables can either be stored in file ubootefi.var in the
ESP or in the RPMB (Replay Protected Memory Block) partition of the
eMMC. The suggested changes are about handling of errors when reading or
writing the file ubootefi.var. Security relevant variables (PK, KEK, db,
dbx) are never read from file.

On first boot a file ubootefi.var will not exist. It has to be created
by U-Boot. If efi_var_from_file() would return an error if the file does
not exist or is corrupted, we would never be able to boot such a system.
This is why deliberately we return EFI_SUCCESS here. What is missing in
the code is a comment explaining the design decision.

>   #endif
>   	return EFI_SUCCESS;
>   }
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index be95ed44e6..13966297c6 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -350,17 +350,17 @@ efi_status_t efi_set_variable_int(const u16 *varia=
ble_name,
>
>   	if (var_type =3D=3D EFI_AUTH_VAR_PK)
>   		ret =3D efi_init_secure_state();
> -	else
> -		ret =3D EFI_SUCCESS;

The two lines are unreachable code and should be removed.

> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;

These new lines should only be reached if var_type =3D=3D EFI_AUTH_VAR_PK.

I am not sure what Would be the right error handling if
efi_init_secure_state() fails:

* Do we have to set PK to the old value?
* Should we still persist PK to ubootefi.var?

However we decide we should describe our decisions in a code comment.

>
>   	/*
>   	 * Write non-volatile EFI variables to file
>   	 * TODO: check if a value change has occured to avoid superfluous wri=
tes
>   	 */
>   	if (attributes & EFI_VARIABLE_NON_VOLATILE)
> -		efi_var_to_file();
> +		ret =3D efi_var_to_file();

The discussion here should focus on the treatment of errors in the
file-system.

The following error cases come to my mind:

* ESP partition is missing
* ESP FAT file system is corrupted
* There is no space on the ESP.
* The medium (e.g. SD card) is in write only mode

The current code gives priority to enable booting in all adverse
situations. Do you think this is a bad choice?

@Ilias: Please, chime in.

Best regards

Heinrich

>
> -	return EFI_SUCCESS;
> +	return ret;
>   }
>
>   efi_status_t efi_query_variable_info_int(u32 attributes,

