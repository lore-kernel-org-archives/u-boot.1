Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76818C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 21:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED49D84779;
	Fri,  8 Aug 2025 23:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WdNDenyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F10884790; Fri,  8 Aug 2025 23:41:41 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F53584514
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 23:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4b070b3b7adso44806751cf.3
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754689228; x=1755294028; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmpVr6pVPVGZ/5JzXjux6kUiO39iZiYA2HbjiZna1gY=;
 b=WdNDenytE8+whbffZdMKKmOTroBzrP8xNFAbOzQG6fDYeXQJtw5OSjuYt8PZFiaW7b
 ebFYjHtxk0tU8PO6KsIY5Y9Ax9VzgqbLTXKb0TnfU/SHMqqyko+uxwkY+Zq9H/C83cNn
 U3k5IUKzIU5jp9RrNNx0ziXkVv4l7PCDe8BjjGkzDngxSSDeaLPZ/aIbfZq0SlEX4PMY
 J+XtYcKeTsXZpQuBd2jARUQtFUmAxy6Vx9vpZB+umyfehPyaRFvqT1jDjfPTgo71TrT1
 fpOxtezzxtw4808LhprPz7b6KIoVoH6dmox+0rgE/p0BgiwBJQubYLOUJrnxrPgYlNmZ
 p+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754689228; x=1755294028;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lmpVr6pVPVGZ/5JzXjux6kUiO39iZiYA2HbjiZna1gY=;
 b=WcyAucARpaWekPt2kOdw7cDBt6M0++DzJj1eLCG/0R0UPjjSz6IpQCGc+erAJ9lRqk
 hB8pnGb6dLNJb394jN8aycmeGjg+zjo2AboQIjAYbAj8qSIHO6jGszmyMOf9qCiMvlpV
 tQYiNEpZnJaOfGV0eojg7Y6+1yTa1e3s7r2xCVlrg3x4h6yYgJ1ocbfBug6b3zAnkhMN
 a4LsDXMGv5uRzRb1vtDW2cNCc8ROoOvEuLJRDpX4EFH8N+UdVNFme1+yxZ8Xk1Qie6rt
 rWYiJKtvbaAez6sPjpV/scu4AsMzqsiHAj6MNfwSJWi0NA/4V8aXMJHvNQd6etdyfM1f
 UG8Q==
X-Gm-Message-State: AOJu0YxHg9NKG4OlM4ufVK/wkoepWoQZBn/ZbN/jAdnGx4hUToGV6PGh
 NbawqngOjva5VamfCFSrUOsI5EQ7IhRZ5VRErSFH1i2DF15UClk4KQrjE4ZICBE6c8chz+zj+yL
 iIeN4
X-Gm-Gg: ASbGnctEiltScCb6Fr7z8J+pgxCD6xD8VVk+6lMXQ8l7iN4tJkqM+vnFmNWnPkUB3aV
 wyaAP2NmDrLz7+BRMzvLtHN73BrTQj02UALYZcwjB7I2n9ZvCpzyoPSwOIPlos9ReFGvn2aUXxo
 2jUmjrxuIQtAm2BeM8nJnEQGkvGJveQlP0v7+lF2UlFlCuyD4arhBgUIMCToK9lJr66Ytlhy/SI
 V+DckzC5/XiSIQLHs/XTBZ0hPsMEWflYyjiWH0s2JHIJxAeth4nkbYGSZb26bYkmZYpo0D5KEh/
 bkGASqNhatvPGGpvEzpKTa/Nz8BVnKoYy4aEgij5rGfEONUT5kpcGv8yNUHals2K4P3i1OJy+9A
 UqQ/rA3grY1wz1CcjE/47O+MocYYLU+Wf804PVm7d/dZTGSk2d7t4uRmAuyVJ33livWeC3HkV2Y
 Y2EM66vvDnNwMKBQ==
X-Google-Smtp-Source: AGHT+IGFVevNo6oz+oy6V1B3wxbSQOJKabyuSzHD+RKyi49zL/Wu/x6Gzh1NL5xMae5CiyVR2potAw==
X-Received: by 2002:ac8:5701:0:b0:4b0:658e:bd88 with SMTP id
 d75a77b69052e-4b0aec6135cmr88503261cf.7.1754689227933; 
 Fri, 08 Aug 2025 14:40:27 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4af1bc47cd9sm82441551cf.13.2025.08.08.14.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 14:40:27 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 19966F40066;
 Fri,  8 Aug 2025 17:40:27 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Fri, 08 Aug 2025 17:40:27 -0400
X-ME-Sender: <xms:ym6WaLVo1aRqXsyLPCNKxDosbFqUNIa_qx9llvnPFNRJfuO8CYvX6A>
 <xme:ym6WaDlPwq-IoY4b-atbVEU6coQV_Ibi7zj1_SFWYe6W740beKYlfYV0R9S7SmYeq
 E3huv4Xp0tRzb7we0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfgrvhhi
 vghrucfvihgrfdcuoehjrghvihgvrhdrthhirgeslhhinhgrrhhordhorhhgqeenucggtf
 frrghtthgvrhhnpefhfeetvdfhgfeifeeuudefudeuvdfhueehteeftddvkeehtdetveei
 gfekhedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrvhhivghrodhmvghsmhhtphgr
 uhhthhhpvghrshhonhgrlhhithihqdduhedvkeekleehkeefqdefudefieegvdeliedqjh
 grvhhivghrrdhtihgrpeeplhhinhgrrhhordhorhhgsehjvghtmhdrmhgvpdhnsggprhgt
 phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeighihprhhonhdrgh
 hlphhksehgmhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtgho
 mhdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorh
 hgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:y26WaEe6hv9bR8HBxiP_SPD58xU7uwUjTjMoHTRn_h-DZexOK1ypuQ>
 <xmx:y26WaPpPbtAeWr5uP0Vtyh_1BEbcZlzv9zt76qMghWNBW2MeLCO4OA>
 <xmx:y26WaFH34K9OxQkJHKm7O-FP9naSBPHWSvGHJzvmWpwUsGz2K9wdjg>
 <xmx:y26WaPsmk8XdjrMQzyQMwZaknCbpn3sWWFU-uGAfFZXoiIV8UJaXGg>
 <xmx:y26WaHUBPgmrCvecKHa_C_4_2293NqdcjtrF1tUjpojJc1an1jvgn9mM>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id E2CC21EA0066; Fri,  8 Aug 2025 17:40:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T72233b445c28976f
Date: Fri, 08 Aug 2025 15:40:06 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Message-Id: <d7b5821c-1df0-44f0-97ff-4721055118f4@app.fastmail.com>
In-Reply-To: <bd9f40ef-d644-4d1b-b21d-b17cfa74d2ca@gmx.de>
References: <20250805162158.117876-1-javier.tia@linaro.org>
 <bd9f40ef-d644-4d1b-b21d-b17cfa74d2ca@gmx.de>
Subject: Re: [PATCH] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Fri, Aug 8, 2025, at 12:50 AM, Heinrich Schuchardt wrote:
> On 05.08.25 18:21, Javier Tia wrote:
>> Refines the disk image detection mechanism in the EFI boot manager.
>> Instead of relying on file extensions, the updated code uses the
>> partition driver lookup function to determine if a downloaded file is=
 a
>> valid disk image.
>>=20
>> The change enhances the robustness of the boot manager by providing a
>> more accurate disk image detection. It also improves error handling by
>> adding a cleanup function for temporary block devices.
>>=20
>> The partition driver lookup function is also made public to enable its
>> use in the EFI boot manager. The function documentation is updated
>> accordingly.
>>=20
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> ---
>>   disk/part.c                  |  3 +-
>>   include/part.h               | 18 +++++++++++
>>   lib/efi_loader/efi_bootmgr.c | 59 ++++++++++++++++++++++++++++++---=
---
>>   3 files changed, 70 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/disk/part.c b/disk/part.c
>> index 66e2b3a7219..adc24976624 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int=
 part_type)
>>    * @dev_desc: Device descriptor
>>    * Return: Driver found, or NULL if none
>>    */
>> -static struct part_driver *part_driver_lookup_type(struct blk_desc *=
desc)
>> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>>   {
>>   	struct part_driver *drv =3D
>>   		ll_entry_start(struct part_driver, part_driver);
>> @@ -855,3 +855,4 @@ int part_get_bootable(struct blk_desc *desc)
>>  =20
>>   	return 0;
>>   }
>> +
>> diff --git a/include/part.h b/include/part.h
>> index b772fb34c8a..3fc3186f4c4 100644
>> --- a/include/part.h
>> +++ b/include/part.h
>> @@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
>>    */
>>   int part_get_bootable(struct blk_desc *desc);
>>  =20
>> +/**
>> + * part_driver_lookup_type() - Look up the partition driver for a bl=
k device
>> + *
>> + * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partit=
ion driver
>> + * against the blk device to see if there is a valid partition table=
 acceptable
>> + * to that driver.
>> + *
>> + * If @desc->part_type is already set, it just returns the driver fo=
r that
>> + * type, without testing if the driver can find a valid partition on=
 the
>> + * descriptor.
>> + *
>> + * On success it updates @desc->part_type if set to PART_TYPE_UNKNOW=
N on entry
>> + *
>> + * @desc: Device descriptor
>> + * Return: Driver found, or NULL if none
>> + */
>> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
>> +
>>   #else
>>   static inline int part_driver_get_count(void)
>>   { return 0; }
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmg=
r.c
>> index 662993fb809..7acb4f4e92b 100644
>> --- a/lib/efi_loader/efi_bootmgr.c
>> +++ b/lib/efi_loader/efi_bootmgr.c
>> @@ -17,6 +17,7 @@
>>   #include <log.h>
>>   #include <malloc.h>
>>   #include <net.h>
>> +#include <part.h>
>>   #include <efi_loader.h>
>>   #include <efi_variable.h>
>>   #include <asm/unaligned.h>
>> @@ -407,7 +408,7 @@ static efi_status_t efi_bootmgr_release_uridp(str=
uct uridp_context *ctx)
>>   	if (!ctx)
>>   		return ret;
>>  =20
>> -	/* cleanup for iso or img image */
>> +	/* cleanup for disk image */
>>   	if (ctx->ramdisk_blk_dev) {
>>   		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>>   					 EFI_CONVENTIONAL_MEMORY);
>> @@ -452,6 +453,20 @@ static void EFIAPI efi_bootmgr_http_return(struc=
t efi_event *event,
>>   	EFI_EXIT(ret);
>>   }
>>  =20
>> +/**
>> + * cleanup_temp_blkdev() - Clean up temporary block device
>> + *
>> + * @temp_bdev: temporary block device to clean up
>> + */
>> +static void cleanup_temp_blkdev(struct udevice *temp_bdev)
>> +{
>> +	if (!temp_bdev)
>> +		return;
>> +
>> +	if (blkmap_destroy(temp_bdev->parent))
>> +		log_err("Destroying temporary blkmap failed\n");
>> +}
>> +
>>   /**
>>    * try_load_from_uri_path() - Handle the URI device path
>>    *
>> @@ -466,7 +481,6 @@ static efi_status_t try_load_from_uri_path(struct=
 efi_device_path_uri *uridp,
>>   {
>>   	char *s;
>>   	int err;
>> -	int uri_len;
>>   	efi_status_t ret;
>>   	void *source_buffer;
>>   	efi_uintn_t source_size;
>> @@ -516,13 +530,37 @@ static efi_status_t try_load_from_uri_path(stru=
ct efi_device_path_uri *uridp,
>>   	image_size =3D ALIGN(image_size, SZ_2M);
>>  =20
>>   	/*
>> -	 * If the file extension is ".iso" or ".img", mount it and try to l=
oad
>> -	 * the default file.
>> -	 * If the file is PE-COFF image, load the downloaded file.
>> +	 * Check if the downloaded file is a disk image or PE-COFF image.
>> +	 * Use partition driver lookup for disk image detection.
>>   	 */
>> -	uri_len =3D strlen(uridp->uri);
>> -	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
>> -	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
>> +	struct udevice *temp_bdev;
>> +	struct part_driver *part_drv =3D NULL;
>> +
>> +	/* Create temporary block device from the downloaded image for test=
ing */
>> +	temp_bdev =3D mount_image(lo_label, image_addr, image_size);
>> +	if (!temp_bdev) {
>> +		log_debug("mount_image() failed, will attempt PE-COFF detection\n"=
);
>> +	}
>> +	if (temp_bdev) {
>> +		struct blk_desc *desc =3D dev_get_uclass_plat(temp_bdev);
>> +		if (!desc) {
>> +			/* Clean up temporary device when dev_get_uclass_plat() returns N=
ULL */
>> +			cleanup_temp_blkdev(temp_bdev);
>> +		} else {
>> +			/* Use part_driver_lookup_type for comprehensive partition detect=
ion */
>> +			part_drv =3D part_driver_lookup_type(desc);
>> +
>> +			/*
>> +			 * If it's a disk image with valid partition type,
>> +			 * prepare_loaded_image will create the final block device
>> +			 */
>> +			if (part_drv)
>> +				/* Clean up temporary device, prepare_loaded_image will create a=
 new one */
>> +				cleanup_temp_blkdev(temp_bdev);
>
> Why wouldn't you remove the temporary disk if there is no partition dr=
iver?
>
> Why wouldn't we keep the temporary disk if it is usable instead of=20
> creating a new one?

Thank you for the review. I have addressed your comments at=20
https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@linaro=
.org/#r

Thanks.

> Best regards
>
> Heinrich
>
>> +		}
>> +	}
>> +
>> +	if (part_drv) {
>>   		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
>>   					   &loaded_dp, &blk);
>>   		if (ret !=3D EFI_SUCCESS)
>> @@ -545,7 +583,10 @@ static efi_status_t try_load_from_uri_path(struc=
t efi_device_path_uri *uridp,
>>   		source_buffer =3D (void *)image_addr;
>>   		source_size =3D image_size;
>>   	} else {
>> -		log_err("Error: file type is not supported\n");
>> +		/* Clean up temporary device if it was created but not a valid dis=
k image */
>> +		cleanup_temp_blkdev(temp_bdev);
>> +
>> +		log_err("Error: disk image is not supported\n");
>>   		ret =3D EFI_UNSUPPORTED;
>>   		goto err;
>>   	}

--=20
=C2=BB Javier Tia =E2=9C=8D
