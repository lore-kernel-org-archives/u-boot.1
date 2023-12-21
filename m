Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24659C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 12:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72612877E5;
	Thu, 21 Dec 2023 13:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qe1zvb/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B0A8783B; Thu, 21 Dec 2023 13:45:32 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850DE876AE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e3901c2e2so963548e87.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 04:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703162730; x=1703767530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VETZ2ZXELThgiGrWTHw8PY2cqM2+NyllToj9Wokgvhg=;
 b=Qe1zvb/bfBhRK+cOjTY1ND3Aj+7D0sj/+7GGqHEdov45cGjmKG8OCs11c1kanbaC0y
 h+c6teyueRZ8bi82L/6LGVf4pzwCocSHYwR+ptog3GIusNsp2y8cfOhH5p3ff9vqob/H
 yKrfsOg59CVF0J+Vqamx1YMQNnafQgE1VsLgqaTsq/G1hhAL2qXrWOCuW4iTFzV1+kcb
 qoM44XVDWcIh6OpTGL3XAunzPESyyJnsf1/7xcsOsJNMdGkyiUuuSECCckaqXuEvFcFi
 iI1oT+PO8x+C9sk961vKhGZhHZye9sUlzOsCdHR+c4AwQVilQX6/gYp77xlUnx2ZT0B7
 QYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703162730; x=1703767530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VETZ2ZXELThgiGrWTHw8PY2cqM2+NyllToj9Wokgvhg=;
 b=tpqVMKWl6GlKGr+GeXZSyvGTQgkDCZxLNBsd7G3tEEEIju8PczOsmdQALvvRHiZJfK
 UbjCLuYTcNmBFSNP4Q6A6R0ckP/LmTgHusmC9Q5JYLMlfkaY/n+PoymiRn6NxqdwD+3Y
 +Iyt2S/Z03vUC96rz8blJc/bkw1FHQuj6vbEYzZNzg/FViq2af+B518aAjqmtuULPBqB
 wzEyOOUS6thc/zFdfa6uqgIYIJFAjoi2p1S5aXEUpgr6yA8eK7pfbxpqhyVJhbpGP4+1
 kTlBw2osRMk3aZhSShgKt9dg+9iPsErTt/t1QmHenv5IWRTkEEoQFFpsDzBIY/wiU09Y
 6bmQ==
X-Gm-Message-State: AOJu0YyUh3xHSjEUNcEdEdvJIlWydMPfuc/jWwOI2on2Kat6T7BPM0I7
 AtO/LN0klK10exGChGOP3hVDKg==
X-Google-Smtp-Source: AGHT+IGSFl8CFHk4KIndVhm/scikVNPbKjgZtJXGDqrFTJpI9zfxG9PV2kA0+t0DMDtsL0vzeUxF0A==
X-Received: by 2002:ac2:5201:0:b0:50e:5b95:948 with SMTP id
 a1-20020ac25201000000b0050e5b950948mr508123lfl.103.1703162729760; 
 Thu, 21 Dec 2023 04:45:29 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a17090728c600b00a23577b265csm923304ejc.173.2023.12.21.04.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 04:45:29 -0800 (PST)
Date: Thu, 21 Dec 2023 14:45:27 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2] efi_loader: fix iteration of FMP protocols
Message-ID: <ZYQzZ3xJApKdcOm4@hera>
References: <20231218095742.376839-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218095742.376839-1-masahisa.kojima@linaro.org>
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

On Mon, Dec 18, 2023 at 06:57:41PM +0900, Masahisa Kojima wrote:
> If one of the FMP protocols fails when calling GetImageInfo(),
> populating the ESRT ends up with failure and other FMP protocols
> are not added to the ESRT. We should still add all other FMP
> protocols to the ESRT.
>
> With this commit, iteration of all FMP protocols continues
> even though one of the FMP protocols fails.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
> Note that this patch addresses the following issue.
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/3
>
> changes in v2
> - add error handling when num_entries is 0 after calling fmp->get_image_info()
>
>  lib/efi_loader/efi_esrt.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
> index 7f46d651e6..1f629a6023 100644
> --- a/lib/efi_loader/efi_esrt.c
> +++ b/lib/efi_loader/efi_esrt.c
> @@ -365,7 +365,7 @@ efi_status_t efi_esrt_populate(void)
>  		if (ret != EFI_SUCCESS) {
>  			EFI_PRINT("ESRT Unable to find FMP handle (%u)\n",
>  				  idx);
> -			goto out;
> +			continue;
>  		}
>  		fmp = handler->protocol_interface;
>
> @@ -380,15 +380,14 @@ efi_status_t efi_esrt_populate(void)
>  			 * fmp->get_image_info to return BUFFER_TO_SMALL.
>  			 */
>  			EFI_PRINT("ESRT erroneous FMP implementation\n");
> -			ret = EFI_INVALID_PARAMETER;
> -			goto out;
> +			continue;
>  		}
>
>  		ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, info_size,
>  					(void **)&img_info);
>  		if (ret != EFI_SUCCESS) {
>  			EFI_PRINT("ESRT failed to allocate memory for image info\n");
> -			goto out;
> +			continue;
>  		}
>
>  		/*
> @@ -406,7 +405,7 @@ efi_status_t efi_esrt_populate(void)
>  		if (ret != EFI_SUCCESS) {
>  			EFI_PRINT("ESRT failed to obtain image info from FMP\n");
>  			efi_free_pool(img_info);
> -			goto out;
> +			continue;
>  		}
>
>  		num_entries += desc_count;
> @@ -414,6 +413,13 @@ efi_status_t efi_esrt_populate(void)
>  		efi_free_pool(img_info);
>  	}
>
> +	/* error occurs in fmp->get_image_info() if num_entries is 0 here */
> +	if (!num_entries) {
> +		EFI_PRINT("Error occurs, num_entries should not be 0\n");
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
>  	EFI_PRINT("ESRT create table with %u entries\n", num_entries);
>  	/*
>  	 * Allocate an ESRT with the sufficient number of entries to accommodate
> @@ -437,7 +443,7 @@ efi_status_t efi_esrt_populate(void)
>  		if (ret != EFI_SUCCESS) {
>  			EFI_PRINT("ESRT unable to find FMP handle (%u)\n",
>  				  idx);
> -			break;
> +			continue;
>  		}
>  		fmp = handler->protocol_interface;
>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
For the SynQuacer
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

