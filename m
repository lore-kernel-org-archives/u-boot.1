Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD916C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 16:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261EE88578;
	Sat, 20 Jul 2024 18:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JNEYTMu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EADA887B9; Sat, 20 Jul 2024 18:02:50 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164B288578
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 18:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79f178e6225so163867085a.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721491367; x=1722096167; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ouBiQuX5lkYf/VCfSX+3hnTUTAMHHRUXdwXil6+SkSw=;
 b=JNEYTMu2wqU5Sw6eLLbinueXZOrSM1jzpokoa1B2F+K+TsOsehyLUJ/SokxUKL6eGi
 iNr63dTq/GkPoXY/On94zOOrrrwDMzVEAR5wiLxbxyZNBhAEuxb3cdOrISJifpfNXmkK
 6pmwZeiqUIlgUOo1FpCXPLhNMdcah/b/fZoa1C99B9JlRnRXJOhKgrFbhnia/cmSQlbD
 TUuoXKz5eeAMZgKVflkkfUw8RhiSm48QfhLtXpwW3dvHO0/gdBILxvATyqwzdQaLcoaf
 P+5E3QxW/cMVDNK4tPtbfBIXF41hnh2QbPXlER2y1KqRWXZxblj8LXrKOTp10+aGuGP1
 O4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721491367; x=1722096167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ouBiQuX5lkYf/VCfSX+3hnTUTAMHHRUXdwXil6+SkSw=;
 b=dtzIsYySbT6Ei9xuYay4SO6K1Kd44xVz6L6RclF4iM16a3XlRxPxGzcm+6YO61f201
 Tp0+ubWzUP8ZYVMlG1JQL8rw72RasguxyJYzhBseozk2ZMGXWvbmtlZC+yq7GjX64ss0
 TS2khPoJ9rqzE+/RXhI15C1TAnkL7os8C3ZkhsOd1P8jz3VIERZI9cDdo9XIfVzAAEkD
 ocgh+LUdhdf2D8oDby1lckkRE9Wnt6tMQY+o5x+WeiFodERxaw6HlYv6RWR7LVUsklqJ
 jYpdQFwyF280QQFAJNkNeudZ4bVtnLDj9dwh1ehoenLJyuQh/s3mGVDYDYYYtpGx7LVV
 sBHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQySAzNqtRPSKTBM724MY+VwnKuhCENy90WnMcnheJ8aN5JtcacCiKlJEv3VMSJgFLl+DOtEw5jguNHA2+0mhuIdPEPw==
X-Gm-Message-State: AOJu0YzduUQzxOc6EdSXwGbICfVwgdhsJXp7W5hwb2Vi76nFB9H0AWYs
 znvRjJEqJhnDufr21kxY2hdl2pxdfV5YZiu91yeILXwWUP8u/z2tMrYwZQ==
X-Google-Smtp-Source: AGHT+IFtS8ltdzBrLbyFAIqyrRRDR35qpFDRCS+/6CWGcFpGU030yLIdj+htDD3h/HwmFOzNw8+ZKg==
X-Received: by 2002:a05:620a:bd3:b0:79f:197d:fe8b with SMTP id
 af79cd13be357-7a1a6680174mr204180285a.67.1721491366858; 
 Sat, 20 Jul 2024 09:02:46 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19905ec73sm194432585a.78.2024.07.20.09.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 09:02:46 -0700 (PDT)
Message-ID: <80a1960d-1822-7ed7-8a81-64d351e495bf@gmail.com>
Date: Sat, 20 Jul 2024 12:02:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/14] spl: mmc: Adjust args of spl_mmc_find_device()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-11-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-11-sjg@chromium.org>
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

On 7/20/24 02:17, Simon Glass wrote:
> At present spl_mmc_load() is the only caller of this function, passing
> it a boot_device, an index into the available MMC devices. Pass the
> device number instead, since it is known by the caller and simplifies
> the code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/spl/spl_mmc.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 70e376c0ed8..3cb4b698f7f 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -58,7 +58,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>   	return 0;
>   }
>   
> -static int spl_mmc_get_device_index(u32 boot_device)
> +static int spl_mmc_get_device_index(int boot_device)

This should remain a u32 (or more properly a "uint"...)

>   {
>   	switch (boot_device) {
>   	case BOOT_DEVICE_MMC1:
> @@ -73,13 +73,9 @@ static int spl_mmc_get_device_index(u32 boot_device)
>   	return -ENODEV;
>   }
>   
> -static int spl_mmc_find_device(struct mmc **mmcp, u32 boot_device)
> +static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>   {
> -	int ret, mmc_dev;
> -
> -	mmc_dev = spl_mmc_get_device_index(boot_device);
> -	if (mmc_dev < 0)
> -		return mmc_dev;
> +	int ret;
>   
>   #if CONFIG_IS_ENABLED(DM_MMC)
>   	ret = mmc_init_device(mmc_dev);
> @@ -349,7 +345,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>   	/* Perform peripheral init only once for an mmc device */
>   	mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
>   	if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
> -		ret = spl_mmc_find_device(&mmc, bootdev->boot_device);
> +		ret = spl_mmc_find_device(&mmc, mmc_dev);
>   		if (ret)
>   			return ret;
>   

Aside from the above,

Reviewed-by: Sean Anderson <seanga2@gmail.com>
