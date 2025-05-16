Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12A9C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2726882AAA;
	Fri, 16 May 2025 18:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MXUig6wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D5E82ABA; Fri, 16 May 2025 18:20:54 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E358006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5fbf52aad74so6444848a12.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747412452; x=1748017252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sXMTdv0bJPoshdbAWnXtC0xGqLtlkoOyHLZIG4hpxsM=;
 b=MXUig6wPpqSO9yNUCxS3VnfgIMYSNowBDQ4gZ7OL8VSS1JuvQmUnzb6iAXlAytYM81
 1yrqnPmnkiZcIi9ZGyiugWDnhu8l2K5/bUFQfV/89+BnbkdvbkvEhqC26cGf4hrngSAG
 BSHe2rKY9SO7HjvHfqV2DFaAtItzd1o9LMi4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747412452; x=1748017252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXMTdv0bJPoshdbAWnXtC0xGqLtlkoOyHLZIG4hpxsM=;
 b=dul6yuAoj0sOhQxqZd4nlUIYWlkXvDnv13bXqnrt+FHE28gI2uC5P+vsIbp8BNRSDF
 TwhxSrQlLmjU15EkamP+TkgAmGdOVeB2vMQUIKX17Cyoa+96duMdQajGTYfM2CsG4CML
 TXQkzPGWpVSV8g3/aSTd467nVP8KRrK3IElWb669a3xWavUNHbhTOF+cxrD+b+ZgqU/g
 bmaW8F2JrZO8aPsZ5PCFf+R3Zi+SZdRlY+s2/0QKlS7z4wGgOaHzL1weC9Az3CxUvBYv
 MOyIlVmYrS16fL5O6r3ivkY37qlzZpRDojzy3xtjezEzFPZNk9xaEMpKzm9k9qelDeKO
 N9pw==
X-Gm-Message-State: AOJu0YxgZaNT8TdE5SOcXN1ILpP28YYvZbHuSFHafR5cLvxqRikTxev2
 +bkQQmZPWe48CfRGRajoD4xBpJuaxb+74aurtURnReR5DY19OG7p3Z9l/G+L4mwaPeNuCERrt7s
 WSsi71iR98KfdRJw2Y0bv7QZb1Rbu+/TEQtTe1URKyhcHXXnMw70TDADq84Funw==
X-Gm-Gg: ASbGncurG5p5BPZOAdi3QTKsgSY0wdir5zRRX4yy2oRjQBv7QmGCjeQ8kw7hkBY8Id+
 02IeOa89Hl6VQoWp+ZJnhOCHr0Cpc4WvZPfYALK+pGlf6o9r+Ij3jappI0MxB+oz9M9+Drc5bND
 6hp1otCRPOW5MCy9zx6KjnPMLed+XdfvUm1Q==
X-Google-Smtp-Source: AGHT+IHf9Xu2sayOx7RqVlkKE1LZq4RG3oHpHpqYdZBX/3XRosFIn6frwEXwoj0lyYefrYhbnKNtL0kd0kFSGP2VkO8=
X-Received: by 2002:a17:906:f5a8:b0:ad2:2547:b0ae with SMTP id
 a640c23a62f3a-ad50f7be127mr695416166b.20.1747412452230; Fri, 16 May 2025
 09:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250516125053.25457-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250516125053.25457-1-ant.v.moryakov@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 May 2025 18:20:39 +0200
X-Gm-Features: AX0GCFuUOHgqLwlFTQBTosRQGtPq3r1sKEc_x3RkD7iFvFQubkHXT51PKp65HAE
Message-ID: <CAFLszTg03voPKR3Ojv_H5CvV2u8X4y9XqXL9Vh33_LRwFPz5pA@mail.gmail.com>
Subject: Re: [PATCH] drivers: spi: fix deref ater null.might in spi-uclass.c
To: ant.v.moryakov@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 16 May 2025 at 14:51, <ant.v.moryakov@gmail.com> wrote:
>
> From: Anton Moryakov <ant.v.moryakov@gmail.com>
>
> The static analyzer (Svace) reported
> After having been compared to a NULL value at spi-uclass.c:465,
> pointer 'dev' is passed as 1st parameter in call to function 'dev_get_flags'
> at spi-uclass.c:469, where it is dereferenced at device.h:240.
>
> Correct explained:
> 1. Added dev && !device_active(dev) check before calling device_active()
> 2. Added explicit if (!dev) check with ret = -ENODEV setting
> 3. Protected logging in error block with if(dev) check
>
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  drivers/spi/spi-uclass.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> index d6049753740..52b79223f96 100644
> --- a/drivers/spi/spi-uclass.c
> +++ b/drivers/spi/spi-uclass.c
> @@ -345,7 +345,7 @@ int spi_get_bus_and_cs(int busnum, int cs, struct udevice **busp,
>                 return ret;
>         }
>
> -       if (!device_active(dev)) {
> +       if (dev && !device_active(dev)) {
>                 struct spi_slave *slave;
>
>                 ret = device_probe(dev);
> @@ -355,6 +355,11 @@ int spi_get_bus_and_cs(int busnum, int cs, struct udevice **busp,
>                 slave->dev = dev;
>         }
>
> +       if (!dev) {
> +               ret = -ENODEV;
> +               goto err;
> +       }
> +
>         slave = dev_get_parent_priv(dev);
>         bus_data = dev_get_uclass_priv(bus);
>
> @@ -373,8 +378,11 @@ int spi_get_bus_and_cs(int busnum, int cs, struct udevice **busp,
>         return 0;
>
>  err:
> -       log_debug("%s: Error path, device '%s'\n", __func__, dev->name);
> -
> +       if(dev)
> +               log_debug("%s: Error path, device '%s'\n", __func__, dev->name);
> +       else
> +               log_debug("%s: Error path, NULL device\n", __func__);
> +
>         return ret;
>  }
>
> --
> 2.30.2
>

You are not allowed to pass NULL as dev to driver model functions. So
the bug here is in the SPI code.

There is a code-size cost to checking arguments and we tend to be
reluctant to pay it in U-Boot, where code size is often critical.

We do have assert() but it is fairly intrusive and people seldom
enable it. If you have a better way, please suggest it!

Regards,
Simon
