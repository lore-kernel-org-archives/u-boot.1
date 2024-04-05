Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F61CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4DE86DEE;
	Fri,  5 Apr 2024 08:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tPzucFD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C0E87D59; Fri,  5 Apr 2024 08:28:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD9580245
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712298481; x=1712903281; i=xypron.glpk@gmx.de;
 bh=7KL1VLY8LHaI0Zl9BK1GFBxh6HsyeSWgdj/q2z+ub5Q=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=tPzucFD1LtbEkVBOFpxmOSP4VA4FRzpqOzGucdPdBExb0zYcqwJCYEU6w926WGeL
 3xoPTLRoZt0OpaXBg+18pODiVdq1kl43ogxTV23u9tXEW3iKDTJpAD8tw0wDnCfKK
 raiTj0n8L9Qhu8kJi/AeJJ8yziZAbqmHN/zJiphO40SVWXYF8lD3R2xP8LS2ryvQ7
 pTt1gNZSlTFsI9GabQHfzt5OxZdjqg8hivSa5BIhap79f035OCOXGPnAJqLnQ23/W
 SxOnjZ4LO0sK+04Ues3cBwRlSwb8Vq5jgW71bJ2gsVJdIHZYtfOkVQb0WqnyuVZn2
 yv8/FUagMvEkUgNUwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1sp9oo19Fj-012nMw; Fri, 05
 Apr 2024 08:28:01 +0200
Message-ID: <eb1c51e3-17e0-4c76-a703-da18a85a1ba7@gmx.de>
Date: Fri, 5 Apr 2024 08:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: move efi_var_collect to common functions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ilias Apalodimas <apalos@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
References: <20240404074819.52156-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240404074819.52156-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ozfHq9MeRHkdIh8v75VViXDAL3KvKnZdCYFFUSFsTo6ryxD2qiE
 VbaWv4GECn+vG3am+mIly0MT90fMrLQGJnLbVjWtduaUmHt3ZXOX+Q1RppLtonMH+FHXInH
 wcW0BaQY0el3zzNm3GoG+qYeHL9knYxkFk5cUqC/rU680nGwmT37zZ4k5SVNH8bh0zP3N5D
 FAqh8uGME5dsKtSFpiNjQ==
UI-OutboundReport: notjunk:1;M01:P0:QFEXKYTj5oo=;XcqFbdXJxVZ0HZttJoluRpYHseu
 sbh2kkWm1hRKwi0g5Ng/E6pOt1NZ+pBb9AvvDjPDrOLgZquf1v/9+nfYEa9uugq4qzOggO5q/
 VVv7cqPysGnUH8OYb+O7bnke0FaOzBbTV5KjKWbA0nb0LGneRIM7rqjvvScDn2DExT4cepV5g
 ot2dSnqj/JebPCpOXwF1qPe8a2loyHFqpoKccQ6o4nsIK5pIr3uUtqwhnUF6QyZj7V+e6tEZG
 lOQpMWmAwebWnYlXolvBeTo5NO4CbD7cwOVZEqt0rOrgbMC4kHwmbmDKbu3PVKG1tXuTge0xk
 iUcrpPjIaBbN7/V+eswNrfMKlofedHN15xWHjiQRAU8h4YvI/W/XtRjcrfc4Q1CR4SuOvqvev
 MtbK+lf8xlW77xYXJ/NtSlLJ0hi9Tz/zZlWTX0/vuVyj5W0ID6Lg6C/EJi5vsmXe6MspNUlZY
 R+wkumqS5Ip8ztZVNphENYbaB7XZmaAL7wD5/+0BO3bhWwjyMoOMevRdirUKrtfBWrwZ0BN7T
 0Ez+2Gib4KCjuYT2rV1i1U55wFbpO57Uamgstp2fZDdsE8xzuLGaPr4haFesI0ZvHPSi0Doum
 wH1Xcp2MrRgX9YP6Z70Z30uf2SX8eXrGQ0A0Wq2BYlhFYrXzDurr/78caKAVeM2b4GTwQuwyB
 ij7qPybwUAJX7WB/Q/mDW3fOBtdrVLkvCzQl0t1Sr90lRjRfYWGGqbqxBIunIN8/jZAp5dGZ6
 36BLyMKRTwlPbHscsQWuvSCQL1G7cy1yT/JEK6SpBgoX55mkMkc9Q0EiRK+q/s2tnvo9xOwTo
 aD/9wqgsGwodQ7rqfmFb0xDz6waS2h+FJutlDOzO4Vkc8=
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

On 4/4/24 09:48, Ilias Apalodimas wrote:
> From: Ilias Apalodimas <apalos@gmail.com>
>
> efi_var_collect() was initially placed in efi_var_file.c, since back
> then we only supported efi variables stored in a file. Since then we
> support variables stored in an RPMB as well and use that function to
> collect variables that should be present at runtime.

Thanks for cleaning this up.

In the CONFIG_EFI_MM_COMM_TEE=3Dy case we seem not to need efi_var_file.c
anymore. Can we add this diff:

=2D-- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -72,11 +72,11 @@ obj-y +=3D efi_string.o
  obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) +=3D efi_unicode_collation=
.o
  obj-y +=3D efi_var_common.o
  obj-y +=3D efi_var_mem.o
-obj-y +=3D efi_var_file.o
  ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
  obj-y +=3D efi_variable_tee.o
  else
  obj-y +=3D efi_variable.o
+obj-y +=3D efi_var_file.o
  obj-$(CONFIG_EFI_VARIABLES_PRESEED) +=3D efi_var_seed.o
  endif
  obj-y +=3D efi_watchdog.o

Another comment below.

>
> So let's move it around in efi_var_common.c which makes more sense
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ilias Apalodimas <apalos@gmail.com>
> ---
>   lib/efi_loader/efi_var_common.c | 76 +++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_var_file.c   | 64 ---------------------------
>   2 files changed, 76 insertions(+), 64 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_co=
mmon.c
> index 16b2c3d48828..07b9603d49f3 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -9,6 +9,7 @@
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <stdlib.h>
> +#include <u-boot/crc.h>
>
>   enum efi_secure_mode {
>   	EFI_MODE_SETUP,
> @@ -416,3 +417,78 @@ void *efi_get_var(const u16 *name, const efi_guid_t=
 *vendor, efi_uintn_t *size)
>
>   	return buf;
>   }
> +
> +/**
> + * efi_var_collect() - Copy EFI variables mstching attributes mask
> + *
> + * @bufp:	buffer containing variable collection
> + * @lenp:	buffer length
> + * @attr_mask:	mask of matched attributes
> + *
> + * Return:	Status code
> + */
> +efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp,=
 loff_t *lenp,
> +					    u32 check_attr_mask)
> +{
> +	size_t len =3D EFI_VAR_BUF_SIZE;
> +	struct efi_var_file *buf;
> +	struct efi_var_entry *var, *old_var;
> +	size_t old_var_name_length =3D 2;
> +
> +	*bufp =3D NULL; /* Avoid double free() */
> +	buf =3D calloc(1, len);
> +	if (!buf)
> +		return EFI_OUT_OF_RESOURCES;
> +	var =3D buf->var;
> +	old_var =3D var;
> +	for (;;) {
> +		efi_uintn_t data_length, var_name_length;
> +		u8 *data;
> +		efi_status_t ret;
> +
> +		if ((uintptr_t)buf + len <=3D
> +		    (uintptr_t)var->name + old_var_name_length)
> +			return EFI_BUFFER_TOO_SMALL;
> +
> +		var_name_length =3D (uintptr_t)buf + len - (uintptr_t)var->name;
> +		memcpy(var->name, old_var->name, old_var_name_length);
> +		guidcpy(&var->guid, &old_var->guid);
> +		ret =3D efi_get_next_variable_name_int(
> +				&var_name_length, var->name, &var->guid);
> +		if (ret =3D=3D EFI_NOT_FOUND)
> +			break;
> +		if (ret !=3D EFI_SUCCESS) {
> +			free(buf);
> +			return ret;
> +		}
> +		old_var_name_length =3D var_name_length;
> +		old_var =3D var;
> +
> +		data =3D (u8 *)var->name + old_var_name_length;
> +		data_length =3D (uintptr_t)buf + len - (uintptr_t)data;
> +		ret =3D efi_get_variable_int(var->name, &var->guid,
> +					   &var->attr, &data_length, data,
> +					   &var->time);
> +		if (ret !=3D EFI_SUCCESS) {
> +			free(buf);
> +			return ret;
> +		}
> +		if ((var->attr & check_attr_mask) =3D=3D check_attr_mask) {
> +			var->length =3D data_length;
> +			var =3D (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length,=
 8);
> +		}
> +	}
> +
> +	buf->reserved =3D 0;
> +	buf->magic =3D EFI_VAR_FILE_MAGIC;
> +	len =3D (uintptr_t)var - (uintptr_t)buf;
> +	buf->crc32 =3D crc32(0, (u8 *)buf->var,
> +			   len - sizeof(struct efi_var_file));
> +	buf->length =3D len;
> +	*bufp =3D buf;
> +	*lenp =3D len;
> +
> +	return EFI_SUCCESS;
> +}
> +
> +

This produces a warning

.git/rebase-apply/patch:95: new blank line at EOF.

Could you, please, remove the blank lines at the end of the file.

Best regards

Heinrich

> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file=
.c
> index 532b6b40eefe..413e1794e88c 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -52,70 +52,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to=
_system_partition(void)
>   	return EFI_SUCCESS;
>   }
>
> -efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp,=
 loff_t *lenp,
> -					    u32 check_attr_mask)
> -{
> -	size_t len =3D EFI_VAR_BUF_SIZE;
> -	struct efi_var_file *buf;
> -	struct efi_var_entry *var, *old_var;
> -	size_t old_var_name_length =3D 2;
> -
> -	*bufp =3D NULL; /* Avoid double free() */
> -	buf =3D calloc(1, len);
> -	if (!buf)
> -		return EFI_OUT_OF_RESOURCES;
> -	var =3D buf->var;
> -	old_var =3D var;
> -	for (;;) {
> -		efi_uintn_t data_length, var_name_length;
> -		u8 *data;
> -		efi_status_t ret;
> -
> -		if ((uintptr_t)buf + len <=3D
> -		    (uintptr_t)var->name + old_var_name_length)
> -			return EFI_BUFFER_TOO_SMALL;
> -
> -		var_name_length =3D (uintptr_t)buf + len - (uintptr_t)var->name;
> -		memcpy(var->name, old_var->name, old_var_name_length);
> -		guidcpy(&var->guid, &old_var->guid);
> -		ret =3D efi_get_next_variable_name_int(
> -				&var_name_length, var->name, &var->guid);
> -		if (ret =3D=3D EFI_NOT_FOUND)
> -			break;
> -		if (ret !=3D EFI_SUCCESS) {
> -			free(buf);
> -			return ret;
> -		}
> -		old_var_name_length =3D var_name_length;
> -		old_var =3D var;
> -
> -		data =3D (u8 *)var->name + old_var_name_length;
> -		data_length =3D (uintptr_t)buf + len - (uintptr_t)data;
> -		ret =3D efi_get_variable_int(var->name, &var->guid,
> -					   &var->attr, &data_length, data,
> -					   &var->time);
> -		if (ret !=3D EFI_SUCCESS) {
> -			free(buf);
> -			return ret;
> -		}
> -		if ((var->attr & check_attr_mask) =3D=3D check_attr_mask) {
> -			var->length =3D data_length;
> -			var =3D (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length,=
 8);
> -		}
> -	}
> -
> -	buf->reserved =3D 0;
> -	buf->magic =3D EFI_VAR_FILE_MAGIC;
> -	len =3D (uintptr_t)var - (uintptr_t)buf;
> -	buf->crc32 =3D crc32(0, (u8 *)buf->var,
> -			   len - sizeof(struct efi_var_file));
> -	buf->length =3D len;
> -	*bufp =3D buf;
> -	*lenp =3D len;
> -
> -	return EFI_SUCCESS;
> -}
> -
>   /**
>    * efi_var_to_file() - save non-volatile variables as file
>    *

