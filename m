Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AE4C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE758092B;
	Thu,  6 Feb 2025 13:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U3ImH/dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55FC80944; Thu,  6 Feb 2025 13:46:25 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721DC807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso169258266b.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845983; x=1739450783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=czKu0EM0F5fgOxM+HPfVFOgJ6/xmXf/iJ1gb+Ndrthk=;
 b=U3ImH/dm51EsjsHENpos52QdguLzee66eIt19SIKxDcj6mWrXKtR+YsfPynnnKgscR
 V4AzAxx09k0djPAcPhOMnhzyIDYF7nB8GQHGGfI4F2tF5v3BjmM3YA59/V5ESj+2lNx5
 kREMkeMwuuPkGM6aRooIXtEnQAyOjk5rYVC0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845983; x=1739450783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=czKu0EM0F5fgOxM+HPfVFOgJ6/xmXf/iJ1gb+Ndrthk=;
 b=IzWOawIRNA9vmdelE13fKHPTzPQzrJRTN7HHKvNTTvLtoO/sx+CoFGOa1h7INjeAmG
 kHMx6WAnSVgdBBZuWd6bRm4LgRfUw8IAjsOPwwfFk7QCuadZ2HcZABBCCbRe6Ec05nAB
 9w/IPzbFi9Nn8tV7ZJJdVDo/3TGi9FxodD7RS/enqX//e3t3krL0EllWFTIdR3L7RZ2d
 qThXVXR7eYMBEjXu7xMHiXvaJ42b66dlJk2s8V8270TboHxszPCM0zYfPB2iZoC2KDYp
 aYMC06/X3wTYwg8K0sDqYkeNlXvitKee+g2C3Z+rKZMhdc0eagXC9JWPZ5TJda8y83lM
 ER1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa2OEnpFI0yzIGjn9lIGdvB1UhOTM0w0MT4XqdCrPsNipTLQs+0HebG6/N1Oof3Vpn3DusjZY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjko8tiBogOOgjz2yTXY9STggXG/4nCYMjeA/pS54fFYuYoDjt
 T0qLTOkQ/O/cthTDk+D8pbjJJzzJ1p/PQ65YXSgtJOjUSi/3EbsScSnybOJ/6dC+VnYKc9VFR6s
 q1GvBD7LgMff1CD++bC2eNdwpp09rMqnjP0b+
X-Gm-Gg: ASbGncvDEDZhITh55sVpUk36+qzi8eAI2oyzn4qlYT84Fflw0AYuppDWJOxNzx9Ip2C
 11xNem8zV6p4f6oyqPx7CkvNbWsaqLwfGmIhT2r0A4iyDS8K0LkRzHSclcyEPGIFQiIcSOViAIA
 ==
X-Google-Smtp-Source: AGHT+IEQejiCqQlQJ4oESFr3ybVz3XQ/YBzoaTVIpUTSZXpXwjdeZeR8MPZnGQDa+CRlW0ac7Kbt8wXlkw5wKAXfUJI=
X-Received: by 2002:a17:906:6a17:b0:ab6:ef94:6054 with SMTP id
 a640c23a62f3a-ab75e261f96mr633485866b.33.1738845982850; Thu, 06 Feb 2025
 04:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-3-naoki@radxa.com>
 <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
In-Reply-To: <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:46:11 -0700
X-Gm-Features: AWEUYZn3kJuPAiwRgBOsw_KqhJ7mAExPFfcjR0E_AkIWvbmnEUpvw1z_F5kgZXM
Message-ID: <CAFLszTi7EuM36eSrKehuH_fOkbkE0ZX79jkpZAAn7PonS1EgNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rockchip: Fix binman error
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, trini@konsulko.com, jonas@kwiboo.se, 
 dsimic@manjaro.org, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org, 
 ian.roberts@timesys.com, nathan.morrison@timesys.com, greg.malysa@timesys.com, 
 bb@ti.com
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

Hi Quentin,

On Wed, 5 Feb 2025 at 06:00, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Naoki,
>
> On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
> > After adding the below configs, binman produces an error.
> >
> >   CONFIG_SPL_DFU
> >   CONFIG_SPL_ENV_SUPPORT
> >   CONFIG_SPL_USB_DWC3_GENERIC
> >   CONFIG_SPL_USB_GADGET
> >
> > binman: Section '/binman/simple-bin-spi': Symbol '_binman_u_boot_any_prop_size'
> >     in entry '/binman/simple-bin-spi/mkimage/u-boot-spl/u-boot-spl-nodtb': Entry 'u-boot-any' not found in list (u-boot-tpl-nodtb,u-boot-tpl-dtb,u-boot-tpl,u-boot-spl-nodtb,u-boot-spl-dtb,u-boot-spl,mkimage,fit,simple-bin-spi)
> >
> > Add "no-write-symbols;" to u-boot-tpl and u-boot-spl.
> >
>
> I'll be frank with you, I have no clue what's happening :)

I means that simple-bin-spi has a binary inside it, u-boot-spl, which
uses binman_sym_declare(ulong, u_boot_any, size). Most likely it is
the one at the top of common/spl.c

This symbol is filled in (by binman, at build-time) with the size of
the U-Boot binary. If there is no such U-Boot image then it cannot do
this.

There is more information at [1]

>
> But, it seems this only applies to the SPI image (disable
> ROCKCHIP_SPI_IMAGE and it'll built just fine). Why? No clue.
>
> I've never liked how the simple-bin-spi was built because we should be
> reusing artifacts from simple-bin instead of rebuilding stuff. That's
> why you have /binman/simple-bin-spi/mkimage/fit being a blob, because we
> want to reuse the fitImage from /binman/simple-bin/mkimage/fit but we
> didn't do this for the other ones.
>
> Can you try to revert your patch here and use this instead:
>
> """
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi
> b/arch/arm/dts/rk3399-u-boot.dtsi
> index 70f35b6c197..0a5771b706f 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -45,9 +45,15 @@
>                         };
>   #elif defined(CONFIG_TPL)
>                         u-boot-tpl {
> +                               /* sync with /binman/simple-bin/mkimage/u-boot-tpl */
> +                               type = "blob";
> +                               filename = "tpl/u-boot-tpl.bin";
>                         };
>   #endif
>                         u-boot-spl {
> +                               /* sync with /binman/simple-bin/mkimage/u-boot-spl */
> +                               type = "blob";
> +                               filename = "spl/u-boot-spl.bin";
>                         };
>                 };
>                 fit {
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi
> b/arch/arm/dts/rockchip-u-boot.dtsi
> index c8c928c7e50..fea49eb3145 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -187,9 +187,15 @@
>                         };
>   #elif defined(CONFIG_TPL)
>                         u-boot-tpl {
> +                               /* sync with /binman/simple-bin/mkimage/u-boot-tpl */
> +                               type = "blob";
> +                               filename = "tpl/u-boot-tpl.bin";
>                         };
>   #endif
>                         u-boot-spl {
> +                               /* sync with /binman/simple-bin/mkimage/u-boot-spl */
> +                               type = "blob";
> +                               filename = "spl/u-boot-spl.bin";
>                         };
>                 };
> """
>
> This seems to work for me on RK3399 Puma and Rock-Pi-4 builds with the
> symbols you listed enabled. I also believe this should be "better" than
> what we have today.
>
> If that works, I'll send a proper patch for this :)

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/package/binman.html#access-to-binman-entry-offsets-at-run-time-symbols
