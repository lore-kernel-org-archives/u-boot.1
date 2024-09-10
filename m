Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4C9ECE57A
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 13:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1815889066;
	Tue, 10 Sep 2024 15:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Nj9e1wj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC16B89062; Tue, 10 Sep 2024 15:50:34 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89A189066
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bbffe38e6so42675655e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725976229; x=1726581029; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NgCHZUJvShDv8VbGAUPrXjKEaza28LTsg5xDkkIXSVc=;
 b=Nj9e1wj7RVLgODJuYhufo3EqVYw77C0O+vHLHevdDD6t4QNUv+apSvW1hfz5hvMOLf
 Y3aVOXEVCCZbVlR5SAR5yka3bq0lW6GEP4bPeV/ROPckqW45nVakBzG9QfwAiaoBndeC
 uaaVO6EK9ZLyapnjxEOZpKS3YR+tB5mbCryp9MDe7nAaNIj0ZsFn8yoPFXapj5qFAwib
 cnXK+uks0Ysu1Ru8s6yFYyVyY8XeqOusHIeA6ZhSWRMvp6V+0G18AHtqPe18CSk+Jd2f
 lU7+YlEImlOSGwB3HMgASMyus7uIDcnura22XCAZBMnr92yOvJRbe9D6hTKVJDcR0jwN
 z7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725976229; x=1726581029;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgCHZUJvShDv8VbGAUPrXjKEaza28LTsg5xDkkIXSVc=;
 b=SEAZ+IefVcVLL5sqzytGcf3hjms3Jz/W+nNjm/a02tPx2kKIf1EukuDmKnyYBzW5Lb
 h/1e22bX86iQ02iF5JhEdmDXR9uohC9Uw7tlLicAD+1NqmapSGt388SYSL7IdqKBmoa3
 6mzNu60jiRUPl3sW8DdPVhs0GcFFreMve1buvovDaGG8nbAMaJAfFK8ixukXydcLDMeS
 1squGjQwV/woSNmg/PBC8ZfoO25H75896ztS+UA9W/oqG/gZekaR7rIMLG5Gsh3zTJEq
 h617oqdmdCmWZsxm4Mz4HMS1wqZApJmCQnjlbLXJTwG3qAk4PJtJV7fUdYHxksBv0Kdd
 QjLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp31tHr7J+JWLZNRpQO+PV8H550zti1cI/UvSvDDehSnZbWtGqT3m14Q+7af9wB9AxsaXzTpE=@lists.denx.de
X-Gm-Message-State: AOJu0YwuQ7tih0unz3oOTB1mPzH9Mi+mx2BrYS4VCHw1QabqqR1NApUw
 hbVoxY/j6xpwUR7vLop7Rvlhh41jrUeFGEyZEBrwLhkzXt9Ah1eNAtiqfS7MR8w=
X-Google-Smtp-Source: AGHT+IGVKyror0ZmeuBxbnEA7EOU3eS0cYz3r5UERDCtEuqrEK/29ddfGRK9wqyMaqR6hjZlC21xNA==
X-Received: by 2002:a05:600c:468e:b0:42c:a8cb:6a96 with SMTP id
 5b1f17b1804b1-42cadb68de6mr80736485e9.31.1725976228457; 
 Tue, 10 Sep 2024 06:50:28 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caf33e9b2sm113944785e9.14.2024.09.10.06.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 06:50:28 -0700 (PDT)
Message-ID: <11d30053-5c17-47d9-9f68-a23ce828d8b4@suse.com>
Date: Tue, 10 Sep 2024 15:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, pbrobinson@gmail.com
Cc: sughosh.ganu@linaro.org, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 10/09/2024 08:39, Ilias Apalodimas wrote:
> Since RPI works well using EFI and has no size limitations with regards
> to U-Boot, add the needed structures and Kconfig options needed to
> enable capsule updates
> ---
>   board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
>   configs/rpi_4_defconfig     |  2 ++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9f8..1f342eee12b2 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -63,6 +63,28 @@ struct msg_get_clock_rate {
>   	u32 end_tag;
>   };
>   
> +struct efi_fw_image fw_images[] = {
> +	{
> +		.fw_name = u"RPI_UBOOT",
> +		.image_index = 1,
> +	},
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +	.dfu_string = "mmc 0=u-boot.bin fat 0 1",
> +	.num_images = ARRAY_SIZE(fw_images),
> +	.images = fw_images,
> +};
> +
> +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +		env_set("dfu_alt_info", update_info.dfu_string);
> +}
> +#endif
> +
> +
>   #ifdef CONFIG_ARM64
>   #define DTB_DIR "broadcom/"
>   #else
> diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> index f5fb322aa8fc..c70414e6fcaf 100644
> --- a/configs/rpi_4_defconfig
> +++ b/configs/rpi_4_defconfig
> @@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
>   CONFIG_VIDEO_BCM2835=y
>   CONFIG_CONSOLE_SCROLL_LINES=10
>   CONFIG_PHYS_TO_BUS=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Would you mind to enable this in all corresponding configs.

That would be at least: rpi_3_b_plus_defconfig, rpi_3_defconfig, 
rpi_arm64_defconfig.

Thanks,
Matthias
