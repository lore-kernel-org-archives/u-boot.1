Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B573C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E28842D0;
	Wed, 15 Nov 2023 11:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jLprAZ/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3498686F18; Wed, 15 Nov 2023 11:15:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B976381F54
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700043311; x=1700648111; i=xypron.glpk@gmx.de;
 bh=t+1ElfXLuDzUrYWZF9jbwgo8KnZPWCfm21Q+pqcQZ50=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jLprAZ/dCmn/ugXJc2mlA266tZvO09UcNc4lljyUvheU0XlBmWKt/MmKdtZCvMtj
 +pdUmuXpl3U/yhLmQ5GB/exSYjuHxoS0eSjotkWKlxGNBf9CJPGSN0fxqufpQ0+97
 hz32SiucfCkfhPoPB1CWRL8BDspUWA/uwg51SZyRXh0JM9PVpbciwUWxd00xy0K4N
 yDkhwZ4BFZv+W5QJ5TMqnJNj42zqrcrMOVCuUh8LXJ7meyR3iT1K9jChiFRjCpEQ0
 sOZLrYNkXncxtLAMPiR6sFeGTHNBpLWaCVD3wGlA8OerK9r+1RPTPQuFHLbWI/DJm
 x3gpNE8E8vuT8zqA7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1r0ywB1M3E-006bf9; Wed, 15
 Nov 2023 11:15:11 +0100
Message-ID: <d852fadd-9217-4718-a750-fb82dc586bd3@gmx.de>
Date: Wed, 15 Nov 2023 11:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] efi_loader: Fix UEFI variable error handling
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231113161031.138304-1-o451686892@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231113161031.138304-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3xl85+35eGpZdvH2AuJwORqO3ApGD95K7r1zjzQevLs1xLc+R9
 wjZ0FqKWjQC5MFaxYHeLsDGtb1dTABzRb00PG0SCP9t3D4jvf4gv8EygpG6cL6HmpBoPnSO
 tGI84VK2wSf4ug/nhKAA/PMcc+wcS9JUPkb5iQkPvxjxlCyKHZzU1lqKghPLAZSwN2QTUpB
 TAy7S3ls/LW0gO7hUnSAQ==
UI-OutboundReport: notjunk:1;M01:P0:wQ4knIv6mkY=;ucHVlZuLM8uT3r4kEVhVFmm8Daq
 98KgMDL2yB6rJUZpsrNDWiTDcRPkql/Gl5PNn8jCrzl3snmcjTCbjsR9cMIRzoPRetFaFwneP
 4Itxwp0UShE8IEjSEF0rHUjfbk8eI62rPREU3GXSweY2TK6bhhZRBVfm+whsa4Hw7GP6/X6O+
 5RRLMIbu/x2dhgX1nkUCwniMAHO4RmVVsd9rLjV8kH0zzwvk19tYNnYJDuDvgkWEAb/m4XLHW
 8U/LPjwcnf+aWVTn4Hhn3/iR3iOyYQo3gVe+mkI+yHxHh67RcwLO73w/xqZ2RNZ9DK7NQ7Aw/
 UFMtHAG+EjRJnERxnYBPwKS2iECotxFMQHnjt0XYkdg+bZFDHjkxfDQz0YHUa8oX7CQwfoAYM
 MaVZgkpjXts7o00ELbUyNJRYtK/IKF/on0EYUZl9RlnLNHEVw82o+Ug4lvUblVPIgU7BzlCyJ
 Ku9xK63ELr7cZYMiyTJrlvOy4P8w7XC1u3wfepK1XLBv7a9huCcyetOVGY/Hxc2CUrVFbCz1M
 8zWmaPQaoy/lK0DOtrhuCULSyT+oMvKpQ/VymvA4/tg0fudiHNrkLfscd74tB6B0k3ay4cnIm
 WgRzgarTojcokq4cEhyXjSYqW4M86KrH9OOHl9fwOZSZXzDrWq8hTgjo6tmvkQnGnqBBLCGUD
 LJG3jCyNrLIY/TAVVHShJ1snm01s0imiZjVRCaF7pdJa64H0P8N2stFQ6027NvqV1VTVL7UZ8
 BJk0tXS/Ead7mievYF5C4a6DyO2gzU77DvddIJB6PIJA11eK86AVFQxQUx6xiAzS4kzsgMvsj
 Xn3AyU1svEEOxwwjqL6MRkyXva6lJhJjygR/ZgEIIOfSY4LTGeWR/OClbC6Uj4uTyf2VVhXhw
 vjI/XuBfSiqnMQDowVjM7haC1f0ZK8LK9MpAgqtoTPiRT5zUpmyqrNDB4DSWlXOc+bEFDbebE
 j3qLnA==
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

On 11/13/23 17:10, Weizhao Ouyang wrote:
> Try to catch error the earlier way.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   lib/efi_loader/efi_var_file.c | 4 +++-
>   lib/efi_loader/efi_variable.c | 2 --
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file=
.c
> index 62e071bd83..fe1c462f17 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -192,8 +192,10 @@ efi_status_t efi_var_restore(struct efi_var_file *b=
uf, bool safe)
>   		ret =3D efi_var_mem_ins(var->name, &var->guid, var->attr,
>   				      var->length, data, 0, NULL,
>   				      var->time);
> -		if (ret !=3D EFI_SUCCESS)
> +		if (ret !=3D EFI_SUCCESS) {
>   			log_err("Failed to set EFI variable %ls\n", var->name);
> +			return ret;

This change implies that if a failure occurs, initialization of the EFI
sub-system fails and you will not be able to boot via EFI.

Such a failure will occur if ubootefi.var contains more variables than
fit into the memory buffer.

Please, describe why you want to disable U-Boot's EFI sub-system in this
case.

> +		}
>   	}
>   	return EFI_SUCCESS;
>   }
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index be95ed44e6..2b2ca8c090 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -350,8 +350,6 @@ efi_status_t efi_set_variable_int(const u16 *variabl=
e_name,
>
>   	if (var_type =3D=3D EFI_AUTH_VAR_PK)
>   		ret =3D efi_init_secure_state();
> -	else
> -		ret =3D EFI_SUCCESS;

This change is ok.

Best regards

Heinrich

>
>   	/*
>   	 * Write non-volatile EFI variables to file

