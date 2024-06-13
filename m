Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5873FC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 18:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18AE88910;
	Thu, 13 Jun 2024 20:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="haKEl4LI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE48F8890E; Thu, 13 Jun 2024 20:44:46 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2CD88918
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 20:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35f0f4746c2so1035014f8f.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718304284; x=1718909084;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJ5b0uOEvP+sXmGqme3MYeaWa8PdO43NwGp7colXyw8=;
 b=haKEl4LInS5kVZPeza0iQeGo1WxSpUiqJZJV9fRpWn4dU3qN1K/QfswoLf3twxbMTE
 flm88lc9a7dU8GHPrxVDwdbE0JI6ncHemX4b7aD3GkC0ODkKAwGM5uxGmGoQv683l8Ed
 1su7vtzDFmLwyieZ3JMVTFotN46lAxq6XUN7W84hWHNDZJXylI5kkxJc76f5LjClNbyc
 9Fn0B+J0kSkgzSDhZKNQ/3xF6vagiarbHc5/RVvjmYA+0pkM8L3iZB6rSs6/0BCC3NC9
 lVlRWJ/zlIY40cUn+nc0hUJ3/W0qmRxDKu3anoQkswaZOiGfSg8MkQy1yI1k/m+r/aRF
 4mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718304284; x=1718909084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJ5b0uOEvP+sXmGqme3MYeaWa8PdO43NwGp7colXyw8=;
 b=PawUHvVh38yhw/rC9fs41zqOZly+AbWWl7uiSXqGvSH9XNW2AgfMKlqdmPudvr0mB+
 N0p7malfQP4TvuO1lGSS6HDjC+NdcGTCc83rcwGjqnhMFCLqECPs0vqUk1YT0+EY62wp
 Dj37QpAH/d53Bwd02EkJdkZjPclJIC7SGrnZUdlcToozXzpYw0I0pXsGRKs+YT1WER4z
 sDFeh+dLEJ/MKWzNpzdT/bYnLCEg/8PQut2k70gGFkQ+VmD7ouqrxMk8nIlzIEtTMgWw
 G0GSAf1Kq5hrQurjWie9QZyu0lWo663A3FpebRgp7dZTEdFZsymg3E4JVzMXFmVJf7Kk
 iUvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcIVNyGpRlf9xX8koQddhDvFYmnT/u5+/S6dvk8YXnqi+jnVGq8SFrm+eWrOXRD5THvCJLfDw6CqAmq0ibhWqqlXIcZQ==
X-Gm-Message-State: AOJu0YwZqBM7o9DiMO5XBsAAJSb9p3QI5N4hoNoVJVNbDlujYH9Skeit
 vvDLLB5Bjh1QzH2HJ2IuF4bujiF8XHwsFbTUCQF19TFZmwz38khe3iCc7UeRIJ0=
X-Google-Smtp-Source: AGHT+IFr3AMe+A7yabzQsqijIrt6CyUUAAb+U/5qj6XcW53Sf9VGwXxXHZrjbRDxm6MQpJVAHOsOpw==
X-Received: by 2002:a05:6000:128d:b0:35f:2a43:3b11 with SMTP id
 ffacd0b85a97d-3607a78432cmr423563f8f.67.1718304284500; 
 Thu, 13 Jun 2024 11:44:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:c6c5:f5c5:a789:215?
 ([2a05:6e02:10a5:e010:c6c5:f5c5:a789:215])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2303sm2464224f8f.87.2024.06.13.11.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 11:44:44 -0700 (PDT)
Message-ID: <e83e47da-9a80-465f-becd-d23fccecdf3f@baylibre.com>
Date: Thu, 13 Jun 2024 20:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] bootstd: Add bootflow_iter_check_mmc() helper
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <20240613-bootmeth-android-v2-2-397f6e66eb29@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-2-397f6e66eb29@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 13/06/2024 à 12:13, Mattijs Korpershoek a écrit :
> Some bootflows might be able to only boot from MMC devices.
>
> Add a helper function these bootflows can use.
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   boot/bootflow.c    | 12 ++++++++++++
>   include/bootflow.h |  9 +++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 9aa3179c3881..59d77d2385f4 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -575,6 +575,18 @@ int bootflow_iter_check_blk(const struct bootflow_iter *iter)
>   	return -ENOTSUPP;
>   }
>   
> +int bootflow_iter_check_mmc(const struct bootflow_iter *iter)
> +{
> +	const struct udevice *media = dev_get_parent(iter->dev);
> +	enum uclass_id id = device_get_uclass_id(media);
> +
> +	log_debug("uclass %d: %s\n", id, uclass_get_name(id));
> +	if (id == UCLASS_MMC)
> +		return 0;
> +
> +	return -ENOTSUPP;
> +}
> +
>   int bootflow_iter_check_sf(const struct bootflow_iter *iter)
>   {
>   	const struct udevice *media = dev_get_parent(iter->dev);
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 080ee8501225..6058ddd89b16 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -407,6 +407,15 @@ void bootflow_remove(struct bootflow *bflow);
>    */
>   int bootflow_iter_check_blk(const struct bootflow_iter *iter);
>   
> +/**
> + * bootflow_iter_check_mmc() - Check that a bootflow uses a MMC device
> + *
> + * This checks the bootdev in the bootflow to make sure it uses a mmc device
> + *
> + * Return: 0 if OK, -ENOTSUPP if some other device is used (e.g. ethernet)
> + */
> +int bootflow_iter_check_mmc(const struct bootflow_iter *iter);
> +
>   /**
>    * bootflow_iter_check_sf() - Check that a bootflow uses SPI FLASH
>    *
>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

