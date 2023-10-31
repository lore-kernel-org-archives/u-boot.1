Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0538C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 09:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C2387B41;
	Tue, 31 Oct 2023 10:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1KnGIwzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609C287B4B; Tue, 31 Oct 2023 10:34:14 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6306987B3E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c5629fdbf8so74974931fa.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698744847; x=1699349647;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4e8OiZ08C+/j5TcIVicz0JVQGjFn8nhVL9d7waZSlMI=;
 b=1KnGIwzGvjJBElIe2utUUw+3SM597VJXfr6UDG01Tgn/TreXUJtM/d8TSGt77EhT09
 PI7gKHsdtujrNxmD5L6A0U1olAkJ88fSkUhxi9Hp/mwnOI5gNKG66lN01JvBSG+5tgKZ
 6K7XbxkIP4Y4BHZc3k7mXXpn3sNBAN057RuDygLeRabyKuJB5KeoQCF+SsTPS/7zjl5E
 1F8y6IO7w+3ZzK9VTKKYU6sPbkVerv04XDzyuV/bJbbprUrCrZEtbbauEiMSJaDQ6BQ2
 PSw0yBsZCyYZp0koBhdzrUCC3x+8Ccyk5ND+3MrAs9d/KA+RVeFfK1a/DY/WeCDhNsng
 6hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698744847; x=1699349647;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4e8OiZ08C+/j5TcIVicz0JVQGjFn8nhVL9d7waZSlMI=;
 b=dczE3hZD59sxDYWTmtI8/sH8cO9w/Az6xO+m9Z9aP4y0jfe39pGIc8XG3tPl1BPue/
 YzO/ywHS5xHWcm1Nqmw9+UrzwWBhXJ0wd4yhmaxMkCHJ/8csI3mTzf3M53pbk2y7QWql
 8YOFGeDDpICJuBrPwj5PWLF+L8EbbMPU9DNyrS+fURj0cpNC9STDnsKnN0ew30u3WZLa
 5cUDKMv3JEu3UIx53jKMa2It2GNxoRYvNQdVYSFsD6sC71Y2uCGnprInao3+sf3sjMdC
 VINs13OmVKL0dIjbbapDecf3Niu6CO+j4B5vpi7cSYglmb5BB2vvgvfBy1qac/eqotde
 eF0Q==
X-Gm-Message-State: AOJu0Yz/8n5rqoIPIkXmZ+RwRPJxDeivK6x9aUBshr09/ccECgLx4mNJ
 nIbcCo0qEDW7f6OL6IkwBu1gAA==
X-Google-Smtp-Source: AGHT+IG/YOLwoYgECngu2H1MmYDuLtpOf+DmJZ2TUx4ZnLoYibujGORO6jSZdjgP9B689f6WSxYDRA==
X-Received: by 2002:a2e:2a85:0:b0:2bf:b106:6296 with SMTP id
 q127-20020a2e2a85000000b002bfb1066296mr8811639ljq.4.1698744846929; 
 Tue, 31 Oct 2023 02:34:06 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c4e9100b00405c7591b09sm1208523wmq.35.2023.10.31.02.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 02:34:06 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] dfu: mmc: Add support for exposing whole mmc device
In-Reply-To: <20231029223740.284149-1-marex@denx.de>
References: <20231029223740.284149-1-marex@denx.de>
Date: Tue, 31 Oct 2023 10:34:05 +0100
Message-ID: <8734xrcf02.fsf@baylibre.com>
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

On dim., oct. 29, 2023 at 23:37, Marek Vasut <marex@denx.de> wrote:

> Add support for exposing the whole mmc device by setting the 'size'
> parameter to 0. This can be useful in case it is not clear what the
> total device size is up front. Update the documentation accordingly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/usage/dfu.rst     |  5 +++++
>  drivers/dfu/dfu_mmc.c | 10 ++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
> index 68cacbbef66..8845a71df36 100644
> --- a/doc/usage/dfu.rst
> +++ b/doc/usage/dfu.rst
> @@ -121,6 +121,11 @@ mmc
>  
>      with
>  
> +    offset
> +        is the offset in the device (hexadecimal without "0x")
> +    size
> +        is the size of the access area (hexadecimal without "0x")
> +        or 0 which means whole device
>      partid
>          being the GPT or DOS partition index,
>      num
> diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
> index cdb3c18b01d..12c54e90ef7 100644
> --- a/drivers/dfu/dfu_mmc.c
> +++ b/drivers/dfu/dfu_mmc.c
> @@ -386,6 +386,16 @@ int dfu_fill_entity_mmc(struct dfu_entity *dfu, char *devstr, char **argv, int a
>  		dfu->data.mmc.lba_size		= third_arg;
>  		dfu->data.mmc.lba_blk_size	= mmc->read_bl_len;
>  
> +		/*
> +		 * In case the size is zero (i.e. mmc raw 0x10 0),
> +		 * assume the user intends to use whole device.
> +		 */
> +		if (third_arg == 0) {
> +			struct blk_desc *blk_dev = mmc_get_blk_desc(mmc);
> +
> +			dfu->data.mmc.lba_size = blk_dev->lba;
> +		}
> +
>  		/*
>  		 * Check for an extra entry at dfu_alt_info env variable
>  		 * specifying the mmc HW defined partition number
> -- 
> 2.42.0
