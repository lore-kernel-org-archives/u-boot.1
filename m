Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09B4C30659
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 07:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDBA88569;
	Fri, 28 Jun 2024 09:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WPYQqPmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E521987E3F; Fri, 28 Jun 2024 09:33:02 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C559C88155
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-446427c5923so10818331cf.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719559979; x=1720164779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fHW1pB505bbh8EDBL3B6Yqdxvzjezq9sgL5LICAk/AY=;
 b=WPYQqPmJi4mNJC1kJBl3EurJF4r+brIjV9pRRcnQLrfTJ5g1JSgNhL0uxZF2cRApwy
 TxZRGR3k/go6Zi+xnDzQ3u/Fs5DB9zIq5TgELe25LTkCtTxADlFHvXpWXxG84DbSKird
 wp7lnbluLWIzgffT0QIQ2L/OGB/ZC5y0W+3+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719559979; x=1720164779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fHW1pB505bbh8EDBL3B6Yqdxvzjezq9sgL5LICAk/AY=;
 b=rbqfkGA4IuzarYh+OoLzfOWVAUnfDPOWsgUPZ0grHUfbgUko12lLxAKr9D6Baa16A/
 m3AROUjfDOw+G424N0889spy5nkX3AlobwoxSWVUVspVi7wNi8Q/CmB2u/rMofYOk+6Z
 HYK9sUPY2fSGgqzNabnX5kF0lmA3fFU+Q8yEsBhAaZCslA5qY4tmgChHvjOWmNvZrD8U
 H9Omob/NvQZDWH/LA/RpN6S7Q8++te2sg1VNnQ/xbI10MS9ixIDmrZfZsUUqiFXxEJc3
 lPF5ufw2VtLKYlyxBD0u/FCVClSigGvVWypMLgLA0opFsxv0njNR5o2Mpl+MJJ2Cqvc3
 3g/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbWWmG39NDCACAbnp3kPc3HHeh0bvsXBh9rYAO/Nw0vxrVogx3ekxw+nmdidO3eWnriaLxClC7IIivT3X8/ix+UjAQ3w==
X-Gm-Message-State: AOJu0Yw+wO3IotVluYOsimeHa1fNb9lVdd7PzTPzNjf1XvvnkUdiT2vd
 LDolTKodiKVFE4k8M7DWFX2bkYPbTWg9wz/uGXXkceb/oGMWRuKRiv5h6MKOO1z6KrmfHVA7fpb
 hWvKzZP6A6fYhiLLD1qu+7ObFQ3uFXrmv5uH1
X-Google-Smtp-Source: AGHT+IGS/x39pro7knVpAeWZjcBqlJjZjAuaPx7nXnUDQq+bAO6JR5yzAPb9tQiE/r+33kBoQBP6Qi62/RYk0wM+vsY=
X-Received: by 2002:a05:6214:3014:b0:6b5:7e74:185 with SMTP id
 6a1803df08f44-6b5a545e34dmr10804616d6.30.1719559979669; Fri, 28 Jun 2024
 00:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627113546.100333-3-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627113546.100333-3-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:32:48 +0100
Message-ID: <CAFLszThTEQ1YCR4pxO2NmydDZN38aCqCXwNyJ4BLQ1npAveGTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: mmc: fix driver rebinding in the case of dtb
 reloading
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Chanho Park <chanho61.park@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

Hi Mikhail,

On Thu, 27 Jun 2024 at 12:35, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Rebinding of the mmc driver causes reregistration of block device.
> Thus second mmc device appears and the first becomes broken.
>
> Fix an issue by using already registered block device instead of
> registering a new one.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mmc/mmc-uclass.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 24170c59ecc..403d20dad53 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -420,11 +420,17 @@ int mmc_bind(struct udevice *dev, struct mmc *mmc, const struct mmc_config *cfg)
>         /* Use the fixed index with aliases node's index */
>         debug("%s: alias devnum=%d\n", __func__, dev_seq(dev));
>
> -       ret = blk_create_devicef(dev, "mmc_blk", "blk", UCLASS_MMC,
> -                                dev_seq(dev), DEFAULT_BLKSZ, 0, &bdev);
> -       if (ret) {
> -               debug("Cannot create block device\n");
> -               return ret;
> +#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
> +       device_find_first_child_by_uclass(dev, UCLASS_BLK, &bdev);
> +       if (!bdev)
> +#endif
> +       {
> +               ret = blk_create_devicef(dev, "mmc_blk", "blk", UCLASS_MMC,
> +                                        dev_seq(dev), DEFAULT_BLKSZ, 0, &bdev);
> +               if (ret) {
> +                       debug("Cannot create block device\n");
> +                       return ret;
> +               }
>         }
>         bdesc = dev_get_uclass_plat(bdev);
>         mmc->cfg = cfg;
> --
> 2.43.0
>

There is a mmc_unbind() function which is supposed to handle unbinding
the mmc block device Can you got into a little more detail as to what
is going wrong?

Regards,
Simon
