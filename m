Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97E6C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335FA88348;
	Wed,  5 Jun 2024 13:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HM01VeeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4360C88286; Wed,  5 Jun 2024 13:17:38 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D4188356
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eaa794eb9fso54479121fa.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717586255; x=1718191055;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RFb+UvYrnLL+/Kytjr0ZGL6h4g0swe5C5uwwPerzCQs=;
 b=HM01VeeEw2Bvqr5KQMGFCOGtuU7CtaRGizlwHH1MLz5HAYhXNb4QGZdesRnS4Ji0Vt
 LTbEkUvjs0NEP2nMsqJ5CPVvkmk7kMjYtFowwc6MTevvtGXcbVu9rq1v9G1EzkyLkBL9
 Cq7QenWqTbUxKs4rSZZGhLyMJpH7YGsLZPYowYPq/FuP2pGgfoOBL95oVTq5XGaOif81
 8iKJaviWQ91K/M+W5tKwOisVylVQGGFMdyqm9KJKM6hK7dp9rs6OinYOiq4IH14I669Q
 nLzYOUgtbsEm4MqwZOT+uYKxY5c+m0ycnUfXCcqmbuuD6dzMDbH0UyGhhNG4ACrgU5un
 HNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586255; x=1718191055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFb+UvYrnLL+/Kytjr0ZGL6h4g0swe5C5uwwPerzCQs=;
 b=PtWkhNG1YmBg7yUPasV3OmXaQCA1v8lcoTfEaHs2BFYI8dbDQEHRMq8og9ZNyJDx92
 Y/uIgJFACycMCNZ2id4TETOkjpOXGBNu0HfGMa0pgSv56n28+UpP06NVN2wklIq60Pww
 DTQ4KIZ/kjJu9/psICpSheTxo+k2Np9erOO5hT0NivKbJTxqTIVhaTGdizFVEqOMYRCq
 CITzzQlth+s0/YBNx7PsOSpdcO5mEBGmR4b3bJ9T14Qvc+oFZ9sndgD6kT0huAXoZQ/l
 MZA7a5qHYUZtaJF6Qq1eVV1PHC6vtcUT2iFyncir90S62I9qjUBrpCsFrX7LBf1N9bSX
 4LdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCDKErDoM+HqGbSXFfB9S+1MHSE0InzxPUYzhkgG5TOV7o3RoOFU6a0QZ1VWt7XyLUCHa3TYiP2cQFffTwnCLo6lQXIw==
X-Gm-Message-State: AOJu0YyFw35L9Hy55TUJ2BIR2IMaKJFraaMirRG182wxKEYKT+b3rm1j
 ACl1van7BM1+n1pNNk9f7+WmtDTIzpWdi/ldUCk3qSjD3SP8fOBdnkyrVqKKvVs=
X-Google-Smtp-Source: AGHT+IFSfzwncX+mMQ5tidUi8vXGSEG0lXuBOH2g3UvN6sF3diCEcnSmSvDWZcAjbw0NZp4trmL1Rg==
X-Received: by 2002:a2e:b607:0:b0:2ea:8ae5:92c with SMTP id
 38308e7fff4ca-2eac7a7089cmr10825141fa.47.1717586255458; 
 Wed, 05 Jun 2024 04:17:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:37b7:f611:56e3:c116?
 ([2a05:6e02:10a5:e010:37b7:f611:56e3:c116])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215814f106sm17948025e9.45.2024.06.05.04.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 04:17:35 -0700 (PDT)
Message-ID: <643ba1c5-8dd2-4c97-b588-59a484e694de@baylibre.com>
Date: Wed, 5 Jun 2024 13:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bootstd: Fix a handful of doc typos in bootmeth
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-1-821683a95aaf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240604-bootmeth-typos-v2-1-821683a95aaf@baylibre.com>
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

Hi,


Le 04/06/2024 à 17:15, Mattijs Korpershoek a écrit :
> Fix some trivial typos found by browsing the code.
> Done with flyspell.
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   include/bootmeth.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/bootmeth.h b/include/bootmeth.h
> index 0fc36104ece0..529c4d813d82 100644
> --- a/include/bootmeth.h
> +++ b/include/bootmeth.h
> @@ -40,7 +40,7 @@ struct bootmeth_ops {
>   	/**
>   	 * get_state_desc() - get detailed state information
>   	 *
> -	 * Prodecues a textual description of the state of the bootmeth. This
> +	 * Produces a textual description of the state of the bootmeth. This
>   	 * can include newline characters if it extends to multiple lines. It
>   	 * must be a nul-terminated string.
>   	 *
> @@ -138,7 +138,7 @@ struct bootmeth_ops {
>   	 * @dev:	Bootmethod device to boot
>   	 * @bflow:	Bootflow to boot
>   	 * Return: does not return on success, since it should boot the
> -	 *	Operating Systemn. Returns -EFAULT if that fails, -ENOTSUPP if
> +	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
>   	 *	trying method resulted in finding out that is not actually
>   	 *	supported for this boot and should not be tried again unless
>   	 *	something changes, other -ve on other error
> @@ -151,7 +151,7 @@ struct bootmeth_ops {
>   /**
>    * bootmeth_get_state_desc() - get detailed state information
>    *
> - * Prodecues a textual description of the state of the bootmeth. This
> + * Produces a textual description of the state of the bootmeth. This
>    * can include newline characters if it extends to multiple lines. It
>    * must be a nul-terminated string.
>    *
> @@ -244,7 +244,7 @@ int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
>    * @dev:	Bootmethod device to use
>    * @bflow:	Bootflow to read
>    * Return: does not return on success, since it should boot the
> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>    *	other error
>    */
>   int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
> @@ -255,7 +255,7 @@ int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
>    * @dev:	Bootmethod device to boot
>    * @bflow:	Bootflow to boot
>    * Return: does not return on success, since it should boot the
> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>    *	other error
>    */
>   int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
> @@ -264,7 +264,7 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
>    * bootmeth_setup_iter_order() - Set up the ordering of bootmeths to scan
>    *
>    * This sets up the ordering information in @iter, based on the selected
> - * ordering of the bootmethds in bootstd_priv->bootmeth_order. If there is no
> + * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there is no
>    * ordering there, then all bootmethods are added
>    *
>    * @iter: Iterator to update with the order
>
Reviewed-by: Guillaume La Roque<glaroque@baylibre.com>

Guillaume

