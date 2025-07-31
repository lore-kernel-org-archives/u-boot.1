Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96153C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2813883946;
	Thu, 31 Jul 2025 23:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uMu5O5UQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F10083948; Thu, 31 Jul 2025 23:40:33 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150ED835D8
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 23:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4abd3627e7eso10669161cf.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998029; x=1754602829; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSGdwXQJhYZoi+51RuIJazFqyqL4ZGY5Khx6wiS4ZFY=;
 b=uMu5O5UQqTxa2gXJxWLnhq2H5xJl1bgCfOIQ8cNrwAxgOqECDMfId3dGhGk464UuL5
 xv0Cgxb7nb+lnXQTNRmYw1O7E9oNvWj3CNLJCRi+AGMhU0ao2zzyo8lhx0Qp4vyOmdm0
 6OkEHjcgZMcA0r4eYW18ok0Hk07fsZknPqHb4CvHJCjY8ov3AuPYxiUpdBfqxQyjtqzV
 pemB8undrfd7eOUdyPOqHiwmQHEljcQU/vfZBldvfz72w/Wa+0EHP+mRdTtekwgwzQHp
 7zYGr3OAeazbdHTS19fTl8CA/lrKReA1cGcFUoB9olRhG+A8ydoOwE0zENt46ArD/Fz5
 15iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998029; x=1754602829;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tSGdwXQJhYZoi+51RuIJazFqyqL4ZGY5Khx6wiS4ZFY=;
 b=tsgMWLpiWQwtES9FWpRvizd/mM0XYmDPwlIgjFOwxH1pfKfdnAyvwXgsPShnNkeGpF
 5veGDLSLQt98uG3P1XdtyY6dgG4KLdmKMnK2YJtPGcAafVc8xlOeK1v7T/s35o0QuCVC
 D1Gx5JBz1ZBtkl/3PNgQJiRaCZnVSfKCRkvrRjD63NsyZTIgovQmECVRoYevUxAs/43r
 W/lUHFcakpvAcuGcbB6mjCsR3njeWOHQW1WQbE8eOFFA2/CE3l9OkggzVKXPB9sQaMC6
 MTkFo3f7IQBgmhefboCmRYipniNcEAiGucXqu7wZqSt6k6qZ6zjrNTeJKUagVXSr6PAo
 IaUg==
X-Gm-Message-State: AOJu0YxTNlSi3T0+B08xmJ5x71mh4Go+pvj/0NYV1Zwhs3p+gmxL2SPM
 RPPBRveSpKyykfrRUA2L6KhJPx68U4onbQcBSYCyeDGVy9I2clZbhwSj106414du2anrXUkC9S2
 jVenG
X-Gm-Gg: ASbGnctu2llbf76lTjxkfVzAecbgVGKqfQFAsPnFKhEa6x/u5NAY/7D1h3kgrpZ7TR8
 n8ec4ekaW+YvSqNFUlsWOtwKzbVvngWwMo5Q4oeQAVFaqtpw9Q/p3sIc1rrX5eIHOTdGzKixR9+
 fyTwoH5nfVTVLST94gU0GYL2ekYtYaNZr8Kguftq7C7zlud3rFFcBr3+wOJvWr1qUV1894bMMuu
 jW6cnZbLIBlD6vn60Hk7vqO4re5QeED/TiS5GYAYtddrOR3VJ3uvN8/TjqrANhdCklauwGr9fUX
 z4cNyzcsXHnHIMYApPShxt455wA4jvKctkVOS+8e+Fw51PRy/tS5aqdoi5LFLG8Fki7H3Ln8tON
 /vbMxs63xuMmOIjoKg01jgbAZPZqVVllGJ72RiLpCn0ug3E00HgWLb4+xVa50x+0d3J/MLUycfu
 FSxOXczaR/1RwKRQ==
X-Google-Smtp-Source: AGHT+IEcad936JPLChXsYaLCqDXTSRUqg5Yk+G7jAAJyO4asQztxhFwaNroost8UauO/vOrzKfz1xQ==
X-Received: by 2002:a05:622a:110f:b0:4ae:f6eb:fb9a with SMTP id
 d75a77b69052e-4af00931750mr3280161cf.49.1753998028630; 
 Thu, 31 Jul 2025 14:40:28 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4aeeebdcfb7sm13426281cf.13.2025.07.31.14.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 14:40:28 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id F1D41F40067;
 Thu, 31 Jul 2025 17:40:27 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Thu, 31 Jul 2025 17:40:27 -0400
X-ME-Sender: <xms:y-KLaJV4_TmExuj8ZXpshjXad0jXv8zdCWUTBRfdfB9muX8_6NobaA>
 <xme:y-KLaJlRlBIAf1AHVY77PNWkhHWff4_YGUYwCXWLiw94TlSI3odjRXpBcdM7bG9hQ
 Tt0T8xLVVzRtMeeJDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:y-KLaCf87dFW5y2fJLf5mqnyzgqREvjVlzGvlWkdfY5LEgm05OkS0Q>
 <xmx:y-KLaFqcFCZLVy-OPzQwTklF8Bmt3kFLovyq-NJ5h3yf9A_xVYOeyg>
 <xmx:y-KLaDG8zTip5bZhs_Gb1hnOGY8R1M6XtzksvMf32o9lkJ_znZODuw>
 <xmx:y-KLaFs6xIkP-JQ4vQ9w7OklEoPyFEoSy4YN1ifQPhAfOAL1byEZfg>
 <xmx:y-KLaFWBC8a2gIYJ7imiKfA9IpPHArmiGFU25vjlHwlAo9fcOfgGyfjK>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id C9C591EA0068; Thu, 31 Jul 2025 17:40:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AQY6sa-VJDp3
Date: Thu, 31 Jul 2025 15:40:07 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Message-Id: <a67d755e-bc50-426e-a570-9ff8da84f78b@app.fastmail.com>
In-Reply-To: <d151f1a5-40de-4084-9a0d-e2727d65e97c@gmx.de>
References: <20250730224942.755510-1-javier.tia@linaro.org>
 <d151f1a5-40de-4084-9a0d-e2727d65e97c@gmx.de>
Subject: Re: [PATCH] disk: efi_loader: Add function to detect disk image type
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

On Thu, Jul 31, 2025, at 8:05 AM, Heinrich Schuchardt wrote:
> On 31.07.25 00:49, Javier Tia wrote:
>> This commit introduces a new function, detect_disk_image_type(), which
>> checks if a buffer contains a disk image. This function is used to
>> detect disk images based on their headers, rather than relying on file
>> extensions.
>>=20
>> The function checks for ISO 9660, DOS MBR, and GPT protective MBR
>> signatures. It returns 1 if a disk image is detected, and 0 otherwise.
>>=20
>> This function is then used in the efi_bootmgr.c file to determine if a
>> downloaded file is a PE-COFF image or a disk image. This change
>> improves the reliability of disk image detection, as it no longer
>> relies on file extensions, which can be easily changed or omitted.
>>=20
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>
> It would be easier to use efi_check_pe() to identify if the downloaded=20
> file is a PE-COFF image. Otherwise try booting it as a disk image.
>
> You could use part_driver_lookup_type() to determine the partition typ=
e.

I have addressed your comments in the next patch: https://lore.kernel.or=
g/u-boot/20250731213547.654823-1-javier.tia@linaro.org/T/#u.

Thanks.

> Best regards
>
> Heinrich
>
>> ---
>>   disk/part.c                  | 46 +++++++++++++++++++++++++++++++++=
+++
>>   include/part.h               |  9 +++++++
>>   lib/efi_loader/efi_bootmgr.c | 29 ++++++++++-------------
>>   3 files changed, 68 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/disk/part.c b/disk/part.c
>> index 66e2b3a7219..9d9483b216c 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -855,3 +855,49 @@ int part_get_bootable(struct blk_desc *desc)
>>  =20
>>   	return 0;
>>   }
>> +
>> +/**
>> +* detect_disk_image_type() - Detect if buffer contains a disk image
>> +*
>> +* @buffer:  Buffer containing potential disk image data
>> +* @size:    Size of the buffer
>> +* Return:   1 if disk image detected, 0 otherwise
>> +*/
>> +int detect_disk_image_type(void *buffer, size_t size)
>> +{
>> +	unsigned char *buf =3D (unsigned char *)buffer;
>> +
>> +	/* Need at least 512 bytes for basic checks */
>> +	if (!buffer || size < 512)
>> +		return 0;
>> +
>> +#if IS_ENABLED(CONFIG_ISO_PARTITION)
>> +	/* Check for ISO 9660 signature "CD001" at offset 0x8001 */
>> +	if (size > 0x8005) {
>> +		if (buf[0x8001] =3D=3D 'C' && buf[0x8002] =3D=3D 'D' &&
>> +		    buf[0x8003] =3D=3D '0' && buf[0x8004] =3D=3D '0' &&
>> +		    buf[0x8005] =3D=3D '1') {
>> +			return 1;
>> +		}
>> +	}
>> +#endif
>> +
>> +#if IS_ENABLED(CONFIG_DOS_PARTITION)
>> +	/* Check for DOS MBR signature 0x55AA at offset 0x1FE */
>> +	if (buf[0x1FE] =3D=3D 0x55 && buf[0x1FF] =3D=3D 0xAA) {
>> +		return 1;
>> +	}
>> +#endif
>> +
>> +#if IS_ENABLED(CONFIG_EFI_PARTITION)
>> +	/* Check for GPT protective MBR */
>> +	if (buf[0x1FE] =3D=3D 0x55 && buf[0x1FF] =3D=3D 0xAA) {
>> +		/* Check if partition type is 0xEE (GPT protective) */
>> +		if (buf[0x1C2] =3D=3D 0xEE) {
>> +			return 1;
>> +		}
>> +	}
>> +#endif
>> +
>> +	return 0;
>> +}
>> diff --git a/include/part.h b/include/part.h
>> index b772fb34c8a..39c04e0c8f7 100644
>> --- a/include/part.h
>> +++ b/include/part.h
>> @@ -727,6 +727,15 @@ int part_get_type_by_name(const char *name);
>>    */
>>   int part_get_bootable(struct blk_desc *desc);
>>  =20
>> +/**
>> + * detect_disk_image_type() - Detect if buffer contains a disk image
>> + *
>> + * @buffer: Buffer containing potential disk image data
>> + * @size:   Size of the buffer
>> + * Return:  1 if disk image detected, 0 otherwise
>> + */
>> +int detect_disk_image_type(void *buffer, size_t size);
>> +
>>   #else
>>   static inline int part_driver_get_count(void)
>>   { return 0; }
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmg=
r.c
>> index 662993fb809..da63ad41b40 100644
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
>> +	/* cleanup for image file */
>>   	if (ctx->ramdisk_blk_dev) {
>>   		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>>   					 EFI_CONVENTIONAL_MEMORY);
>> @@ -466,7 +467,6 @@ static efi_status_t try_load_from_uri_path(struct=
 efi_device_path_uri *uridp,
>>   {
>>   	char *s;
>>   	int err;
>> -	int uri_len;
>>   	efi_status_t ret;
>>   	void *source_buffer;
>>   	efi_uintn_t source_size;
>> @@ -516,21 +516,10 @@ static efi_status_t try_load_from_uri_path(stru=
ct efi_device_path_uri *uridp,
>>   	image_size =3D ALIGN(image_size, SZ_2M);
>>  =20
>>   	/*
>> -	 * If the file extension is ".iso" or ".img", mount it and try to l=
oad
>> -	 * the default file.
>> -	 * If the file is PE-COFF image, load the downloaded file.
>> +	 * Check if the downloaded file is a PE-COFF image or a disk image.
>> +	 * Use header-based detection instead of file extensions.
>>   	 */
>> -	uri_len =3D strlen(uridp->uri);
>> -	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
>> -	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
>> -		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
>> -					   &loaded_dp, &blk);
>> -		if (ret !=3D EFI_SUCCESS)
>> -			goto err;
>> -
>> -		source_buffer =3D NULL;
>> -		source_size =3D 0;
>> -	} else if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D=
 EFI_SUCCESS) {
>> +	if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D EFI_S=
UCCESS) {
>>   		/*
>>   		 * loaded_dp must exist until efi application returns,
>>   		 * will be freed in return_to_efibootmgr event callback.
>> @@ -544,6 +533,14 @@ static efi_status_t try_load_from_uri_path(struc=
t efi_device_path_uri *uridp,
>>  =20
>>   		source_buffer =3D (void *)image_addr;
>>   		source_size =3D image_size;
>> +	} else if (detect_disk_image_type((void *)image_addr, image_size)) {
>> +		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
>> +					   &loaded_dp, &blk);
>> +		if (ret !=3D EFI_SUCCESS)
>> +			goto err;
>> +
>> +		source_buffer =3D NULL;
>> +		source_size =3D 0;
>>   	} else {
>>   		log_err("Error: file type is not supported\n");
>>   		ret =3D EFI_UNSUPPORTED;

--=20
=C2=BB Javier Tia =E2=9C=8D
