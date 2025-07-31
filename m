Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A489C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D063835D8;
	Thu, 31 Jul 2025 23:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ClWrrpuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F30830C0; Thu, 31 Jul 2025 23:39:13 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6E783938
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 23:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7e278d8345aso75061685a.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997946; x=1754602746; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugbJorW+ag9JuLCtbLV8wT0N9srdHJ30qkyV0+NvLq8=;
 b=ClWrrpuc23W4IFt2OS2JEecsyE8C3Ep7sk1mxTQ/8+bVDlqrIeIwt51gV8qi8Cc9mG
 EwnT3F1j3wrAjNKM+4jLarCv/ow74WTCWly/mUJ9/F3IxXG0nimRZsZN3SGSBFx03xFu
 vAL8u7d3GwwEZvEqmUl9IdkQRobKt+QHJF03XqSmUuBf58QnrDJQJ6lIynA05kf7Y72i
 EGMjLpe7iRLL4BsQY7ymwP26Q/QXYXDuESX3TvUh1inzOaPe+S/x6j8QQjZZ0tV1C/AU
 ZTzKc392nDMwxyh1RFaRWHS73FyxE/HaQ04JvLeCIJRktdGTzhiLkywDM1Qp2XECt4uF
 q5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997946; x=1754602746;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ugbJorW+ag9JuLCtbLV8wT0N9srdHJ30qkyV0+NvLq8=;
 b=ILK4GlaZV1PsTr/DqS11mJUYgv0qETZKNiIVESIqt7MtiHrVDPfg1H92IvIh1OoIKB
 nNB0L8iteggqgQl5FvCfZ7bw5m8LJW21SV4fi+kaGjAh6kOD/iZjAMDbmMv4LV9ldgyZ
 wt28sCh65TFdjNuqrTFceZ0+XkD4BaMZByPZRfONmCUeL+vYQxmiLZM55822V3oWPpwE
 bhiGJmuK4ZOWqOCtb95ViM4QCRRXT2HIjhKGusxaEsZFhtJiErNt3BACNO9Y8risbP4w
 ln2WG8CFndajx5AB9s3Z8qfJJiCC7qwTSIF+MdDKyrIjWk2RM/vEAySd3FCOmpm6QA49
 EtEA==
X-Gm-Message-State: AOJu0YxtPl6hUcxQRZLoPEAVPLSZcHj6n60Wi4xPuS23wY89N+hvCAPx
 gNplO520uS/kCNamAcFyQPeviAdIkH8K8hrMmj9TMzMup6XLz9Lhk+B1oAWtrtlkNs0=
X-Gm-Gg: ASbGnctb2UKfo8x4lxVBgsz7sJRXAiN9LXSMopd+/nZoDdOyEJlfMOyuoL4stiIV8nK
 MS9q2o42uSfDF7F+HlAaV3cpdqWwvYdHNJ3HYAjH6f9FzD3Xlx6075drjFknwsHU1C6qd/8wwjS
 CvSeGItfpZYnH5gsvEFhHIDpvqeQjIrrwIfPIKbDd2Eic35kSHOH4ghluGTx0K6vqHPkKaANc+c
 rmOt+QKVofhHNGw+7xvv6/Ee3hpAVBZm9utlwD63wXx9tfPLBF2NCF7vRr5b65m8BlHAyjTODPk
 GumWcE93dh+58qVH4s/jeSv8woqkLVBQjdAm9JsiNd8R7kE++Eilg7R76pnnx/CvnM5JcwVsVJR
 vvNn3mJv+2Zh84p7etA3lObEmB3aFuBogJAPvWSx3FS86VPKJhOhXdztNMXxncaawaqO99P8xJ2
 R39nqE3OIqDURtqSkhg3169bB1
X-Google-Smtp-Source: AGHT+IFmzxl4uj8vk5Hk/7Hnp3GanzGuG5EoZer16eD0MeFeLOv1Z20HX2KI025W34RJ9r6hsiZY9g==
X-Received: by 2002:a05:620a:371f:b0:7e3:33e9:9d36 with SMTP id
 af79cd13be357-7e68acdd88dmr28006285a.50.1753997946189; 
 Thu, 31 Jul 2025 14:39:06 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f754983sm138724285a.72.2025.07.31.14.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 14:39:05 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 53B06F40067;
 Thu, 31 Jul 2025 17:39:05 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Thu, 31 Jul 2025 17:39:05 -0400
X-ME-Sender: <xms:eeKLaK8LQu-2oFMkgUBU5uq6EpMBkjlBEps8kLO2ZNMsoEPZ1cXffg>
 <xme:eeKLaKtP6ARJRlTG6ks8v71puES4CKe850Xpxy8ZaMoxebqYRavjSsLKMvFZN6Drj
 yDWqa0MJ1ngM6sHqa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduleduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfgrvhhi
 vghrucfvihgrfdcuoehjrghvihgvrhdrthhirgeslhhinhgrrhhordhorhhgqeenucggtf
 frrghtthgvrhhnpefhfeetvdfhgfeifeeuudefudeuvdfhueehteeftddvkeehtdetveei
 gfekhedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrvhhivghrodhmvghsmhhtphgr
 uhhthhhpvghrshhonhgrlhhithihqdduhedvkeekleehkeefqdefudefieegvdeliedqjh
 grvhhivghrrdhtihgrpeeplhhinhgrrhhordhorhhgsehjvghtmhdrmhgvpdhnsggprhgt
 phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeighihprhhonhdrgh
 hlphhksehgmhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtgho
 mhdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorh
 hgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthht
 ohepnhdqfhhrrghntghishesthhirdgtohhm
X-ME-Proxy: <xmx:eeKLaCfIU572zUzUMahm5dpYoSVyBvpyFi4jW17lIltDEyv5HmWPyA>
 <xmx:eeKLaJX_iDrd6ckw9kO7v7d_t6yP6VeDYcp52HbcEFXffLnvzN7aqg>
 <xmx:eeKLaCgKTdl2vfkqySJjZIKHt-VakRRLhAq11R7z9Y0tNElrpX5aQQ>
 <xmx:eeKLaA-LBiAXi0F6kGiv3xfz_DsELFOLywoHSZnsc3z0VWo4DtFylg>
 <xmx:eeKLaMbw_a6dSypefyYJd4po1dEGRocf-1CcvFk1ni4hqwt7sj1CkTAt>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 20EBA1EA0066; Thu, 31 Jul 2025 17:39:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AQY6sa-VJDp3
Date: Thu, 31 Jul 2025 15:38:44 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Neha Malcom Francis" <n-francis@ti.com>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Message-Id: <754a0288-77a7-4527-9d33-6e3058109a4c@app.fastmail.com>
In-Reply-To: <7195b4ed-541e-4886-8958-b81e5bbeb2cd@ti.com>
References: <20250730224942.755510-1-javier.tia@linaro.org>
 <7195b4ed-541e-4886-8958-b81e5bbeb2cd@ti.com>
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

Hi Neha,

On Thu, Jul 31, 2025, at 1:13 AM, Neha Malcom Francis wrote:
> Hi Javier
>
> On 31/07/25 04:19, Javier Tia wrote:
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
>> ---
>>  disk/part.c                  | 46 ++++++++++++++++++++++++++++++++++=
++
>>  include/part.h               |  9 +++++++
>>  lib/efi_loader/efi_bootmgr.c | 29 ++++++++++-------------
>>  3 files changed, 68 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/disk/part.c b/disk/part.c
>> index 66e2b3a7219..9d9483b216c 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -855,3 +855,49 @@ int part_get_bootable(struct blk_desc *desc)
>> =20
>>  	return 0;
>>  }
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
>>   */
>>  int part_get_bootable(struct blk_desc *desc);
>> =20
>> +/**
>> + * detect_disk_image_type() - Detect if buffer contains a disk image
>> + *
>> + * @buffer: Buffer containing potential disk image data
>> + * @size:   Size of the buffer
>> + * Return:  1 if disk image detected, 0 otherwise
>> + */
>> +int detect_disk_image_type(void *buffer, size_t size);
>> +
>>  #else
>>  static inline int part_driver_get_count(void)
>>  { return 0; }
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmg=
r.c
>> index 662993fb809..da63ad41b40 100644
>> --- a/lib/efi_loader/efi_bootmgr.c
>> +++ b/lib/efi_loader/efi_bootmgr.c
>> @@ -17,6 +17,7 @@
>>  #include <log.h>
>>  #include <malloc.h>
>>  #include <net.h>
>> +#include <part.h>
>>  #include <efi_loader.h>
>>  #include <efi_variable.h>
>>  #include <asm/unaligned.h>
>> @@ -407,7 +408,7 @@ static efi_status_t efi_bootmgr_release_uridp(str=
uct uridp_context *ctx)
>>  	if (!ctx)
>>  		return ret;
>> =20
>> -	/* cleanup for iso or img image */
>> +	/* cleanup for image file */
>>  	if (ctx->ramdisk_blk_dev) {
>>  		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>>  					 EFI_CONVENTIONAL_MEMORY);
>> @@ -466,7 +467,6 @@ static efi_status_t try_load_from_uri_path(struct=
 efi_device_path_uri *uridp,
>>  {
>>  	char *s;
>>  	int err;
>> -	int uri_len;
>>  	efi_status_t ret;
>>  	void *source_buffer;
>>  	efi_uintn_t source_size;
>> @@ -516,21 +516,10 @@ static efi_status_t try_load_from_uri_path(stru=
ct efi_device_path_uri *uridp,
>>  	image_size =3D ALIGN(image_size, SZ_2M);
>> =20
>>  	/*
>> -	 * If the file extension is ".iso" or ".img", mount it and try to l=
oad
>> -	 * the default file.
>> -	 * If the file is PE-COFF image, load the downloaded file.
>> +	 * Check if the downloaded file is a PE-COFF image or a disk image.
>> +	 * Use header-based detection instead of file extensions.
>>  	 */
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
>>  		/*
>>  		 * loaded_dp must exist until efi application returns,
>>  		 * will be freed in return_to_efibootmgr event callback.
>
> I haven't done much on EFI loading, but was intrigued. Is there any
> reason why you've also changed the ordering? It probably doesn't matte=
r;
> but I assume a disk image is more common than a PE-COFF image, at least
> in U-Boot? Or is it not?

Thank you for pointing it out.=20

No reason at all. I just went with the flow, and I didn't think on that.=
 I have addressed that in another patch: https://lore.kernel.org/u-boot/=
20250731213547.654823-1-javier.tia@linaro.org/T/#u.=20

>> @@ -544,6 +533,14 @@ static efi_status_t try_load_from_uri_path(struc=
t efi_device_path_uri *uridp,
>> =20
>>  		source_buffer =3D (void *)image_addr;
>>  		source_size =3D image_size;
>> +	} else if (detect_disk_image_type((void *)image_addr, image_size)) {
>> +		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
>> +					   &loaded_dp, &blk);
>> +		if (ret !=3D EFI_SUCCESS)
>> +			goto err;
>> +
>> +		source_buffer =3D NULL;
>> +		source_size =3D 0;
>>  	} else {
>>  		log_err("Error: file type is not supported\n");
>>  		ret =3D EFI_UNSUPPORTED;
>
> --=20
> Thanking You
> Neha Malcom Francis

--=20
=C2=BB Javier Tia =E2=9C=8D
