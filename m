Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAD5C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6618A87773;
	Wed, 29 Nov 2023 18:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rgKWzIPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F1AB87766; Wed, 29 Nov 2023 18:41:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B94ED8772E
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1701279709; x=1701884509; i=xypron.glpk@gmx.de;
 bh=4UK9qEAPIIKo562YmsoP8R1pA+/kDF9H0NtDUaU6/Us=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=rgKWzIPZ6TPz/LnYj50tJ/SnTR/TnbSYLfhnRQ+GJPUrFTJ5GnGG18uI9O4jmKJk
 3fn9pr5+itYkaouuehUNzHD/DZdJyuTeZIn2Usy3OXuYas+LQi6GOztZjtRy4y25S
 c3CsVmr3CBbI9L0PoIL9SLGJMy7+gMXn6EKJxn+mLQbeRKH+TlyUGmGSjTG23UvaX
 XmHKeT/ODbdiuCYO+iNJ+BhlQz3QZdDe291h2gPOE/OMa0jey+XkoLbqe4u6QD7r7
 lo3MD4a9uEvSV8/5dK/j4MTxFScmO72yRtbqDtQE3eli7UfL1zQxWZCfqWHN19P/z
 cTUnRqZ6XSa+YK5J3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1rRziW0QUT-00tQBW; Wed, 29
 Nov 2023 18:41:49 +0100
Message-ID: <ded6b874-48bc-408a-97b9-c43a6a59098b@gmx.de>
Date: Wed, 29 Nov 2023 18:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] efi_var_file: refactor to move buffer functions
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231124113552.112243-1-i@shantur.com>
 <20231124113552.112243-2-i@shantur.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231124113552.112243-2-i@shantur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VkHcNBOsIO/IvCafEd637V2T7wCkfkm2DFdJtMYNJEjVYbgN2qS
 +ZE1veUCV8vaheTlK3a7qGARg2dlXvrJsUhEWshZgIZxXRh+ST4HDCyM/+xn/YwQn61KmqH
 xHdIVihqqPswZfVhFHxd+jclAv9VGNWwC6dN5Ty4NOm/8QWvU3aOshS2RI7s+J2DAm1k+/q
 oYsHUNhgitN93GmjLjH9A==
UI-OutboundReport: notjunk:1;M01:P0:iir57F/cSE0=;tX7KYJHdpF0a4CYg7MQdX4rUdVG
 aIn6p27X35qakEiwp/Gsdi/JpFK0HXwJAurXQte7njAcOHr044Dv49nf+2fh+n0gvIDBLtRUj
 Yq4hJ0OBjfeYIjCWXrzOhgcxdCBgMMqmQFGFU3ysVbrJCVdOsKBxRe3UOqfNdsqWXABt2ONlQ
 aH+jxIE8VmfkMcW0lAX+wcghjdjjZeqOr52qG4tQ5Z5+MhvD1iZLfGqbrgTlMW0koMEYkQEaH
 E/bWFH/pZoNLrZEZ5Lno0IMnazBdqYQRuFoVBtmEbiqg1I9PDaGv2MX5rrAvvjrYQXBgQWB+M
 dpAV1ukvfATPfxaengHfE0bp7uMSQP48wdO+eF0vOg9nbeKyfBWksan6bjgZ4uxHJpFZpqttP
 UFM9tMdLXWNC03fJ4JubpKUN+rL0R+7UzbAth2SY3xGSD7Gfprd0S02F9FnxjVLTvmDsQgC47
 E8iHlV+4nkyhVhWEpMH0iz7sysPDmQ6Qb0KvzfXIFa8lWiuybxVGeVCRKmq6iWO6GhBqRZwvL
 yJzLpy4pR3FigZ9Q248xgDBiXJcrljPT2JHmSAvwme/MraaxpFhEfAr5XGMSbhUp0Nl2GTKIx
 BWqSXp+0xI/zGeyHEypXNK8wP/4aldbn5ghXfHPn9yh9/z8PCCk4rWvc55VM1roUBHrMM69M7
 MzlMnXXluFetl/gfgiAk5OxvcLMRMjXYGJW6XmzCONR8TrvrcyLykU/tRtLeTxQ7BDFwZ+rx0
 gTepRM5pTfL4qM5/fjKx6BGKXKUK5L0U0WJtj4lTGPx94f7tJ9RJznxGjBTSOJYHf8c63CCpl
 A/PoTrCHyVP+piUHrMkTu3t+RZvIzBHmP0UPNtRlDA419lat3hhaDUqv67vf42SOUAn2vnPwv
 /LQ9no4oE5jMAFv6VcdY/y/Bw9eEkgxLbrizGrmsR+cc0QYlkzCFM8Wge7s6nE8GbeluzLX3I
 f1py5S6N8lcm0jbUQNDcnoZXSL8=
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

On 24.11.23 12:35, Shantur Rathore wrote:
> Currently efi_var_file.c has functions to store/read
> EFI variables to/from memory buffer. These functions
> can be used with other EFI variable stores so move
> them out to efi_var_common.c

The moved functions relate to filling the memory buffer of variables.
Wouldn't lib/efi_loader/efi_var_mem.c be more appropriate as target file?

Best regards

Heinrich

>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>
> (no changes since v1)
>
>   include/efi_variable.h          |   5 ++
>   lib/efi_loader/Makefile         |   2 +-
>   lib/efi_loader/efi_var_common.c | 109 ++++++++++++++++++++++++++++
>   lib/efi_loader/efi_var_file.c   | 121 --------------------------------
>   lib/efi_loader/efi_variable.c   |   8 ++-
>   5 files changed, 122 insertions(+), 123 deletions(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 805e6c5f1e..bd0a31fc3e 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -161,6 +161,11 @@ efi_status_t efi_var_to_file(void);
>   efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp=
, loff_t *lenp,
>   					    u32 check_attr_mask);
>
> +/* GUID used by Shim to store the MOK database */
> +#define SHIM_LOCK_GUID \
> +	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> +		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> +
>   /**
>    * efi_var_restore() - restore EFI variables from buffer
>    *
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 8d31fc61c6..33b1910249 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -66,7 +66,7 @@ obj-y +=3D efi_string.o
>   obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) +=3D efi_unicode_collati=
on.o
>   obj-y +=3D efi_var_common.o
>   obj-y +=3D efi_var_mem.o
> -obj-y +=3D efi_var_file.o
> +obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) +=3D efi_var_file.o
>   ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>   obj-y +=3D efi_variable_tee.o
>   else
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_co=
mmon.c
> index ad50bffd2b..7509c30b5a 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -10,6 +10,7 @@
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <stdlib.h>
> +#include <u-boot/crc.h>
>
>   enum efi_secure_mode {
>   	EFI_MODE_SETUP,
> @@ -40,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[]=
 =3D {
>
>   static bool efi_secure_boot;
>   static enum efi_secure_mode efi_secure_mode;
> +static const efi_guid_t shim_lock_guid =3D SHIM_LOCK_GUID;
>
>   /**
>    * efi_efi_get_variable() - retrieve value of a UEFI variable
> @@ -417,3 +419,110 @@ void *efi_get_var(const u16 *name, const efi_guid_=
t *vendor, efi_uintn_t *size)
>
>   	return buf;
>   }
> +
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
> +efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> +{
> +	struct efi_var_entry *var, *last_var;
> +	u16 *data;
> +	efi_status_t ret;
> +
> +	if (buf->reserved || buf->magic !=3D EFI_VAR_FILE_MAGIC ||
> +	    buf->crc32 !=3D crc32(0, (u8 *)buf->var,
> +				buf->length - sizeof(struct efi_var_file))) {
> +		log_err("Invalid EFI variables file\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	last_var =3D (struct efi_var_entry *)((u8 *)buf + buf->length);
> +	for (var =3D buf->var; var < last_var;
> +	     var =3D (struct efi_var_entry *)
> +		   ALIGN((uintptr_t)data + var->length, 8)) {
> +
> +		data =3D var->name + u16_strlen(var->name) + 1;
> +
> +		/*
> +		 * Secure boot related and volatile variables shall only be
> +		 * restored from U-Boot's preseed.
> +		 */
> +		if (!safe &&
> +		    (efi_auth_var_get_type(var->name, &var->guid) !=3D
> +		     EFI_AUTH_VAR_NONE ||
> +		     !guidcmp(&var->guid, &shim_lock_guid) ||
> +		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> +			continue;
> +		if (!var->length)
> +			continue;
> +		if (efi_var_mem_find(&var->guid, var->name, NULL))
> +			continue;
> +		ret =3D efi_var_mem_ins(var->name, &var->guid, var->attr,
> +				      var->length, data, 0, NULL,
> +				      var->time);
> +		if (ret !=3D EFI_SUCCESS)
> +			log_err("Failed to set EFI variable %ls\n", var->name);
> +	}
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file=
.c
> index d7dba05071..166501a355 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -15,17 +15,9 @@
>   #include <mapmem.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
> -#include <u-boot/crc.h>
>
>   #define PART_STR_LEN 10
>
> -/* GUID used by Shim to store the MOK database */
> -#define SHIM_LOCK_GUID \
> -	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> -		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> -
> -static const efi_guid_t shim_lock_guid =3D SHIM_LOCK_GUID;
> -
>   /**
>    * efi_set_blk_dev_to_system_partition() - select EFI system partition
>    *
> @@ -53,70 +45,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to=
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
> @@ -126,7 +54,6 @@ efi_status_t __maybe_unused efi_var_collect(struct ef=
i_var_file **bufp, loff_t *
>    */
>   efi_status_t efi_var_to_file(void)
>   {
> -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>   	efi_status_t ret;
>   	struct efi_var_file *buf;
>   	loff_t len;
> @@ -150,52 +77,6 @@ error:
>   		log_err("Failed to persist EFI variables\n");
>   	free(buf);
>   	return ret;
> -#else
> -	return EFI_SUCCESS;
> -#endif
> -}
> -
> -efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> -{
> -	struct efi_var_entry *var, *last_var;
> -	u16 *data;
> -	efi_status_t ret;
> -
> -	if (buf->reserved || buf->magic !=3D EFI_VAR_FILE_MAGIC ||
> -	    buf->crc32 !=3D crc32(0, (u8 *)buf->var,
> -				buf->length - sizeof(struct efi_var_file))) {
> -		log_err("Invalid EFI variables file\n");
> -		return EFI_INVALID_PARAMETER;
> -	}
> -
> -	last_var =3D (struct efi_var_entry *)((u8 *)buf + buf->length);
> -	for (var =3D buf->var; var < last_var;
> -	     var =3D (struct efi_var_entry *)
> -		   ALIGN((uintptr_t)data + var->length, 8)) {
> -
> -		data =3D var->name + u16_strlen(var->name) + 1;
> -
> -		/*
> -		 * Secure boot related and volatile variables shall only be
> -		 * restored from U-Boot's preseed.
> -		 */
> -		if (!safe &&
> -		    (efi_auth_var_get_type(var->name, &var->guid) !=3D
> -		     EFI_AUTH_VAR_NONE ||
> -		     !guidcmp(&var->guid, &shim_lock_guid) ||
> -		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> -			continue;
> -		if (!var->length)
> -			continue;
> -		if (efi_var_mem_find(&var->guid, var->name, NULL))
> -			continue;
> -		ret =3D efi_var_mem_ins(var->name, &var->guid, var->attr,
> -				      var->length, data, 0, NULL,
> -				      var->time);
> -		if (ret !=3D EFI_SUCCESS)
> -			log_err("Failed to set EFI variable %ls\n", var->name);
> -	}
> -	return EFI_SUCCESS;
>   }
>
>   /**
> @@ -214,7 +95,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf=
, bool safe)
>    */
>   efi_status_t efi_var_from_file(void)
>   {
> -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>   	struct efi_var_file *buf;
>   	loff_t len;
>   	efi_status_t ret;
> @@ -239,6 +119,5 @@ efi_status_t efi_var_from_file(void)
>   		log_err("Invalid EFI variables file\n");
>   error:
>   	free(buf);
> -#endif
>   	return EFI_SUCCESS;
>   }
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index be95ed44e6..adc5ac6a80 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -357,8 +357,11 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
>   	 * Write non-volatile EFI variables to file
>   	 * TODO: check if a value change has occured to avoid superfluous wri=
tes
>   	 */
> -	if (attributes & EFI_VARIABLE_NON_VOLATILE)
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> +	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>   		efi_var_to_file();
> +	}
> +#endif
>
>   	return EFI_SUCCESS;
>   }
> @@ -466,9 +469,12 @@ efi_status_t efi_init_variables(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
>   	ret =3D efi_var_from_file();
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
> +#endif
> +
>   	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
>   		ret =3D efi_var_restore((struct efi_var_file *)
>   				      __efi_var_file_begin, true);

