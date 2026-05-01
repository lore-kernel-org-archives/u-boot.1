Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE2EFF8864
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 08:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6303B80F0E;
	Fri,  1 May 2026 10:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AlkikkTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD1381E18; Fri,  1 May 2026 10:23:42 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECC2803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 10:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777623814; x=1778228614; i=xypron.glpk@gmx.de;
 bh=JmU9e5mzRqITjOj2sAtxlaitlC1vnM1xbIJ2YlH+cXs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AlkikkTyVe71067WzfFJmWszQV7tj9VKL3hDqsmX83cOyr0YJrjZHfJqpbQON8k/
 Q5R+0uPW50Z2lIsVy7zF+lupMCfF7KEIxphtUe9ARLzR/g9FzuE+QSiitpTh9SN7G
 Pd2P6iEbdrzIhsDzzmwxXtSttCsxA8RtgBIxPkFEfqzXSEhbmgpLm8rofHRVGQPui
 5eXWtkxcinIvfGpFCpGTbFfSpJwr26Aba07kSvPNCfj1MAWOamF0B7saPMDiULS1e
 nGp6VBMQkzsPM7TiAZ4+bOWM5va2CROXSYFXmMM0qRjKtwwe2vIkdPhaBJDb+k51Y
 FYduuFnYE7gxjyKZhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1vxV130YeR-00WEO8; Fri, 01
 May 2026 10:23:34 +0200
Message-ID: <3443228d-66d6-4908-a619-d57f590b8880@gmx.de>
Date: Fri, 1 May 2026 10:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: expand disk device names with drive details
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: git@amd.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, michal.simek@amd.com, u-boot@lists.denx.de
References: <20260420072935.3024696-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260420072935.3024696-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0At2IGlFdDQndlLxnw+pzWjS/RkGiwGT88dXvxHvMknihwMrLk7
 /ykm9FlAJOTOAT53NsEHGzY0mS3xOjL8doM5+591YLmTKrFfK8LgAVBHrrBntfJ20jw5cKS
 t9SuroVi0O2vcAGu8oHM7ft0OBzHsnkLbwkkDwzPTHHcT/ODpXjf3LkCyMkRt6cgl4iGGev
 IxDYXUB8i8jXrjP7y46rA==
UI-OutboundReport: notjunk:1;M01:P0:cnRhhAxNFTQ=;hLgxzKxLuY9YJr3k2Itr5O7mYia
 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
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

On 4/20/26 09:28, Padmarao Begari wrote:
> Increase the boot menu device name buffer so we can append extra
> metadata. Append the disk capacity and trimmed vendor/product strings
> to the device name so users can differentiate drives in the EFI boot
> menu. Also tighten the parameter validation and pull in linux/string.h
> for strl* helpers.
>=20
> For example, the U-Boot boot menu now shows entries such as:
>=20
>      usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
>      usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
>      scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)

Adding a descriptive text looks like a good idea to me. I am just not=20
sure if with the patch we are showing the relevant information.

nvme 0 (953 GiB, SKHynix_HFS001TEM4X169N)
nvme 1 (953 GiB, SKHynix_HFS001TEM4X169N)
nvme 2 (953 GiB, SKHynix_HFS001TEM4X169N)

I would not know if these are 3 namespaces on the same drive or=20
different drives.

EDK II MdeModulePkg/Library/UefiBootManagerLib/BmBootDescription.c,=20
BmGetNvmeDescription() sends ADMIN_IDENTIFY command to the NVME=20
controller to get the model and serial number.

The EDK II description for NVMe namespaces contains:

* model
* serial number
* namespace ID

This information is sufficient to identify what the boot entry relates to.

Another example:

host 0 (64 MiB, U-Boot hostfile)
host 1 (64 MiB, U-Boot hostfile)

Wouldn't the user need the mounted file here?

>=20
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   include/efi_loader.h      |  2 +-
>   lib/efi_loader/efi_disk.c | 86 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 85 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3a4d502631c..b6065cfdab7 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -290,7 +290,7 @@ const char *__efi_nesting_dec(void);
>   #endif
>  =20
>   /* max bootmenu title size for volume selection */
> -#define BOOTMENU_DEVICE_NAME_MAX 16
> +#define BOOTMENU_DEVICE_NAME_MAX 128

If your terminal is only 80 characters wide and you print 128 character=20
strings, they will overflow into the next line. This should be avoided.

Some displays may even have less than 80 characters per line.

Please, check the usage in the boot menu and the eficonfig command.

>  =20
>   /* Key identifying current memory map */
>   extern efi_uintn_t efi_memory_map_key;
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f8a57539ec6..e0b613065d5 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -19,6 +19,8 @@
>   #include <log.h>
>   #include <part.h>
>   #include <malloc.h>
> +#include <linux/sizes.h>
> +#include <linux/string.h>
>  =20
>   struct efi_system_partition efi_system_partition =3D {
>   	.uclass_id =3D UCLASS_INVALID,
> @@ -813,9 +815,87 @@ int efi_disk_remove(void *ctx, struct event *event)
>  =20
>   }
>  =20
> +#define EFI_DISK_SIZE_TENTHS		10
> +#define EFI_DISK_CAPACITY_STR_MAX	sizeof("17179869183.9 GiB")
> +#define EFI_DISK_DETAIL_MAX		(BLK_VEN_SIZE + BLK_PRD_SIZE + \
> +					 EFI_DISK_CAPACITY_STR_MAX + \
> +					 sizeof(" (, )"))
> +
> +/**
> + * efi_disk_append_detail() - append capacity and vendor info to a devi=
ce label
> + *
> + * Appends a " (size, vendor product)" suffix to @buf when the block
> + * descriptor carries readable capacity or identification strings.
> + *
> + * @desc:	block device descriptor
> + * @buf:	label buffer to append to (already contains base name)
> + * @size:	total size of @buf in bytes
> + */
> +static void efi_disk_append_detail(const struct blk_desc *desc,
> +				   char *buf, int size)
> +{
> +	u64 capacity =3D (u64)desc->lba * desc->blksz;
> +	char capacity_str[EFI_DISK_CAPACITY_STR_MAX];
> +	char vendor_buf[BLK_VEN_SIZE + 1];
> +	char product_buf[BLK_PRD_SIZE + 1];
> +	char detail[EFI_DISK_DETAIL_MAX];
> +	char *vendor, *product;
> +
> +	capacity_str[0] =3D '\0';
> +
> +	if (capacity >=3D SZ_1G) {

Please, consider using print_size(capacity, "").

Best regards

Heinrich

> +		u64 gib =3D capacity / SZ_1G;
> +		u64 tenths =3D ((capacity % SZ_1G) * EFI_DISK_SIZE_TENTHS) /
> +			     SZ_1G;
> +
> +		if (tenths)
> +			snprintf(capacity_str, sizeof(capacity_str),
> +				 "%llu.%u GiB", gib,
> +				 (unsigned int)tenths);
> +		else
> +			snprintf(capacity_str, sizeof(capacity_str),
> +				 "%llu GiB", gib);
> +	} else if (capacity >=3D SZ_1M) {
> +		snprintf(capacity_str, sizeof(capacity_str), "%llu MiB",
> +			 capacity / SZ_1M);
> +	} else if (capacity >=3D SZ_1K) {
> +		snprintf(capacity_str, sizeof(capacity_str), "%llu KiB",
> +			 capacity / SZ_1K);
> +	} else if (capacity) {
> +		snprintf(capacity_str, sizeof(capacity_str), "%llu B", capacity);
> +	}
> +
> +	strlcpy(vendor_buf, desc->vendor, sizeof(vendor_buf));
> +	strlcpy(product_buf, desc->product, sizeof(product_buf));
> +	vendor =3D strim(vendor_buf);
> +	product =3D strim(product_buf);
> +
> +	if (!capacity_str[0] && !vendor[0] && !product[0])
> +		return;
> +
> +	detail[0] =3D '\0';
> +	strlcat(detail, " (", sizeof(detail));
> +	if (capacity_str[0]) {
> +		strlcat(detail, capacity_str, sizeof(detail));
> +		if (vendor[0] || product[0])
> +			strlcat(detail, ", ", sizeof(detail));
> +	}
> +	strlcat(detail, vendor, sizeof(detail));
> +	if (vendor[0] && product[0])
> +		strlcat(detail, " ", sizeof(detail));
> +	strlcat(detail, product, sizeof(detail));
> +	strlcat(detail, ")", sizeof(detail));
> +
> +	strlcat(buf, detail, size);
> +}
> +
>   /**
>    * efi_disk_get_device_name() - get U-Boot device name associated with=
 EFI handle
>    *
> + * Fills @buf with a human-readable label such as "mmc 0 (7.5 GiB, SanD=
isk
> + * AJTD4R)". Capacity and trimmed vendor/product strings are appended w=
hen
> + * available.
> + *
>    * @handle:	pointer to the EFI handle
>    * @buf:	pointer to the buffer to store the string
>    * @size:	size of buffer
> @@ -833,7 +913,7 @@ efi_status_t efi_disk_get_device_name(const efi_hand=
le_t handle, char *buf, int
>   	bool is_partition =3D false;
>   	struct disk_part *part_data;
>  =20
> -	if (!handle || !buf || !size)
> +	if (!handle || !buf || size <=3D 0)
>   		return EFI_INVALID_PARAMETER;
>  =20
>   	dev =3D handle->dev;
> @@ -858,9 +938,11 @@ efi_status_t efi_disk_get_device_name(const efi_han=
dle_t handle, char *buf, int
>   		count =3D snprintf(buf, size, "%s %d", if_typename, diskid);
>   	}
>  =20
> -	if (count < 0 || (count + 1) > size)
> +	if (count < 0 || count >=3D size)
>   		return EFI_INVALID_PARAMETER;
>  =20
> +	efi_disk_append_detail(desc, buf, size);
> +
>   	return EFI_SUCCESS;
>   }
>  =20

