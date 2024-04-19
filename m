Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BD9C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 09:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65479886FB;
	Fri, 19 Apr 2024 11:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dciJAQE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A318388702; Fri, 19 Apr 2024 11:49:50 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9EB888526
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 11:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a51beae2f13so207138166b.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713520188; x=1714124988; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RgUg3j3oZehtoHsKhtAQr1vJDKmrt+oJG5EumMd+nKc=;
 b=dciJAQE5ws39zaQ8+fojsn7GVd0NeRoHC1S0xciI+D+NCDHCKj+z9XwP5kKhXDTEpY
 JUzJPfvAsEQmWCEanID9MylQhpqiR3fS4fMNvu+hEAe3N3SitkzNPSTyFHLqQVKqNCoJ
 Y3dGrbrJNdiN7pkGA6h3o0ZtdvjGCFKw4iJAK/bkKvoDuoog3FMW92j4paBbjnShL2Wl
 p+r88jXTTb8Tf3vhULgMr52eSs6EfonZcMXaG8MWpz2H6Llnk860L5OXHB6Uu8nRikDK
 tQrpfg23/kCzH+4afjVOvA771xCRnPr/uPh4sh84DFpvk0bEh7Fzvu+x4yAJvKblXb2m
 V+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713520188; x=1714124988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgUg3j3oZehtoHsKhtAQr1vJDKmrt+oJG5EumMd+nKc=;
 b=NTgGqRy4+ajHPPX6a9zgjA3sZtSZ7mT4QOV8mWz02JFtCLO8R5/XrCCzP0UkBp/uTO
 4ILPP8qNqBVDDVNzNTTTvGyIZBlnI8YJ2s1BmFKPb3LYYtyXZ0uMiOSqitfgeloBTgft
 w61/S5cn7UGsJAokudwvgXIiYhnJSTEGETtfhNFxGHMucUmfVtTqReNeJa2yyufel59I
 wXC5fyd25OUhY6lSqu/uFHZtCVQ/lFDhCtivvYHpW3IYK1qd+yqs4ksr25qryrk6/Ifg
 5z9scw6A2PklvfNtjNhfzZppEk48Wao4tWphBzJziKHQrLkvX7VFYcBnwXfar3c5Tcrl
 0/yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXioF2C9iWdq7Q9GdDVLDC4Lp5jV0l8Axu86NxXpjvfCzkkqG8e6hVpDpt1fGKZyfb3GvB4WfnWh6fgrUADV3gsZoiKeg==
X-Gm-Message-State: AOJu0Yy78WDcVPizu/O5uOw3+0cH0F8LfPUWEnFzSi6tvnbFWzN8UPNr
 6eF6TB0KTGkn7nELwvxdQJI+EXdwOtLhva+b4C7k8Q5IiIz+yj4wfl2xjHr5QQM=
X-Google-Smtp-Source: AGHT+IGoZz64asvMjiji7R20voYS12+RsS5Qagl4DTZIhvtOCjILL7HHFXB9BT1NbIbTl5yORtFI+A==
X-Received: by 2002:a17:906:2b47:b0:a52:26fc:3203 with SMTP id
 b7-20020a1709062b4700b00a5226fc3203mr1074401ejg.27.1713520188076; 
 Fri, 19 Apr 2024 02:49:48 -0700 (PDT)
Received: from hera (ppp176092141112.access.hol.gr. [176.92.141.112])
 by smtp.gmail.com with ESMTPSA id
 oz20-20020a170906cd1400b00a522f6fea95sm1982711ejb.223.2024.04.19.02.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 02:49:47 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:49:45 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] efi_loader: change the error message when storing EFI
 variables
Message-ID: <ZiI-ObOgxMWreq_V@hera>
References: <20240419094546.12653-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419094546.12653-1-ilias.apalodimas@linaro.org>
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

Heinrich

Please ignore this, I missed that we already report that in
efi_set_blk_dev_to_system_partition()

Apologies for the noise
/Ilias
On Fri, Apr 19, 2024 at 12:45:45PM +0300, Ilias Apalodimas wrote:
> When we try to store EFI variables on a file, we need to use an ESP.
> if an ESP is not found, variables will change in memory, but U-Boot
> won't be able to restore them across reboots.
>
> Adjust the error message so users can understand what's going on
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - print different messages if ESP is missing or write to file failed
>
>  lib/efi_loader/efi_var_file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index 413e1794e88c..d5d347d50f8d 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -73,16 +73,20 @@ efi_status_t efi_var_to_file(void)
>  		goto error;
>
>  	ret = efi_set_blk_dev_to_system_partition();
> -	if (ret != EFI_SUCCESS)
> +	if (ret != EFI_SUCCESS) {
> +		log_err("ESP not found.");
>  		goto error;
> +	}
>
>  	r = fs_write(EFI_VAR_FILE_NAME, map_to_sysmem(buf), 0, len, &actlen);
> -	if (r || len != actlen)
> +	if (r || len != actlen) {
> +		log_err("Failed to store variables.");
>  		ret = EFI_DEVICE_ERROR;
> +	}
>
>  error:
>  	if (ret != EFI_SUCCESS)
> -		log_err("Failed to persist EFI variables\n");
> +		log_err(" UEFI variables won't persist reboot\n");
>  	free(buf);
>  	return ret;
>  #else
> --
> 2.43.0
>
