Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05291C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 14:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844E1880FB;
	Thu, 13 Jun 2024 16:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rtmnt1d/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FDA88315; Thu, 13 Jun 2024 16:16:39 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD7C87F51
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 16:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-421bb51d81aso8904625e9.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718288197; x=1718892997;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GS7Pz0EbMIb1fmph2zbR9gjS5HtvYIUFHJZRznf+ixY=;
 b=rtmnt1d/YFkSqj2Nthfb9/jVJcHsW2TYuFERoVuqK65rBuCuz8zneysNAVdqkrxvtH
 xKfpDxwQknLK0xMTGT2yReE1DNP7MsZLVWrgi4QbIi4LpoD77oAAWiya+a/m6ki0/8RS
 o2Tvq33AcuzTA3oYxXt1kZ3ZS4xwVAqMXrV81SsL4xLPunptDd/4eD5jX15iqeGWx5L7
 73hIB7d3uSjFaxqRiHoVd9QlDjSD6sO2Ip+BXD4mG/o5luYPfeUDeVNFU+CrqsCTz36O
 7gIBBk80FqZfF2MGXw4yFI3Z50nHyNg6GfI8JYjIvmqVi83v8wv9ewMqJVyO93UkXEIH
 kR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718288197; x=1718892997;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GS7Pz0EbMIb1fmph2zbR9gjS5HtvYIUFHJZRznf+ixY=;
 b=Bp8GBoyXLsrpNYGLC7j1s1t6EC2TbJoVwAvtgKUGprmgZpDvoSDZY0vVxJM4rq0dkg
 1kg85tTtN2AKEgsHyT3GvouzXSdbMNLO9VQIgr+qDStVZouPLjDokRyeIQsta2Ou9gOD
 /9zrFcq4G1qRpJLUk0Q7NMs4QzvOM44Va0iJEcfMGZ3jX96D9xc5cytzKeGczWMpt+Cj
 l6JfC1ev2FTt887FaHPb0Lh9FPJ992nbOMNSL9jCavR+yYrCjsdsIwncVP9eP+Gdam5c
 KDm9tfoIQIa1DHI8FJbCHKE2wmHiLger+ZVOPPRiBIf9QC4n3KPsDfnOj9iD/DLU546X
 uS8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwTmvsK/FR/es1jpNnpbVsR+GmyXTArdvH/7XqLfuepBzlvI/2SMIDYq0KzRl1TicDSysvbnJVagTYnG6zdKpR9yG0aw==
X-Gm-Message-State: AOJu0Yz9fZE2aqrzA5AT5kE80SQFCilyPBIBcZVdwTwGYRzNKthMY8Kb
 GAxpLx+FlMtQhtenN7t/2CzUWrDmG7KbcYnuocarfjAX4XesHaco9l1ngKC1ic8=
X-Google-Smtp-Source: AGHT+IFWKglXqPjn9T90yli1su2DtlE71ewM1oL22+I26EPkMqk5EhAdhiTXBgw5CcjP27c6ff0Dxg==
X-Received: by 2002:a05:600c:1c0a:b0:421:cf6e:f8ba with SMTP id
 5b1f17b1804b1-422861ae885mr42082515e9.3.1718288197059; 
 Thu, 13 Jun 2024 07:16:37 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6127d78sm27264605e9.25.2024.06.13.07.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 07:16:36 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Dmitrii Merkurev <dimorinny@google.com>, Roman
 Stratiienko <r.stratiienko@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 2/5] bootstd: Add bootflow_iter_check_mmc() helper
In-Reply-To: <20240613-bootmeth-android-v2-2-397f6e66eb29@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
Date: Thu, 13 Jun 2024 16:16:35 +0200
Message-ID: <87o785lygs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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


On Thu 13 Jun 2024 at 16:15, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Some bootflows might be able to only boot from MMC devices.
> 
> Add a helper function these bootflows can use.
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootflow.c    | 12 ++++++++++++
>  include/bootflow.h |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 9aa3179c3881..59d77d2385f4 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -575,6 +575,18 @@ int bootflow_iter_check_blk(const struct bootflow_iter *iter)
>  	return -ENOTSUPP;
>  }
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
>  int bootflow_iter_check_sf(const struct bootflow_iter *iter)
>  {
>  	const struct udevice *media = dev_get_parent(iter->dev);
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 080ee8501225..6058ddd89b16 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -407,6 +407,15 @@ void bootflow_remove(struct bootflow *bflow);
>   */
>  int bootflow_iter_check_blk(const struct bootflow_iter *iter);
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
>  /**
>   * bootflow_iter_check_sf() - Check that a bootflow uses SPI FLASH
>   *
> 
> -- 
> 2.45.2
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
