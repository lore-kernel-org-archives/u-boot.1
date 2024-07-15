Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA7CC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 23:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29836885E7;
	Tue, 16 Jul 2024 01:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aPN5vayC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3E7888A7; Tue, 16 Jul 2024 01:31:46 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CAD88216
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-65f9e25fffaso25164197b3.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721086303; x=1721691103; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zytChzUSZ8zJvlHb0zwqGy+a8v8qThHsM9dFwW/Mg0Q=;
 b=aPN5vayCwlQ8p83Exxb8d0TXEtWGnFxQhkiIs+RdTy3AITtYIvobHS9IpnGeGYtJVn
 nJf8jAdlisvnBonK2PcZ47yowpdD1cCsxLt1CcXWNej+bqqXV9B5X6kbbqy+c/yClW8L
 0qZVszb5p+MQo5EQG40cjTuwCfW2OvS9VafJfsLN845q9mSiVPLfynF3YaA0KHMqP9+I
 ET9YhJS1EABpeQO/LOj/Egu2WJbZkQdBy8SJ49eVb2oTQftVzbL1KRHBw6gz7E2xD8rv
 bU5mwJXE3qzYbZYh61hdqY596DBeb7OyTQcyEdeoAijJpO/WA+k7+XF87HHinTSHdRzu
 2Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721086303; x=1721691103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zytChzUSZ8zJvlHb0zwqGy+a8v8qThHsM9dFwW/Mg0Q=;
 b=FRgtq8By+1RXHHxbRUTE8ZdqQSCe2Qq6yk5sIgU7V11BBFVsBWVQ3/eklUlCG+aM3A
 qAt40Ej30i2/hJCSrILIq5e2+UC080OAGNVYOvR6mgsJq8K19/6/BTs7XO8IEXMO/r2F
 XY1+jMWCvxBKazeC6ZzWeb0gK2cAC1V/Aa+iBYMeivxuYgw3UjpwabTRDKlUcKXgyHd+
 hNyIMAtkNRS9BDc8dw9pTZPk40KoX420OD2B2oZ8A+VSRpKKTVPs5RslWPfpa+XY31Hi
 TLpZnoiF73Op4HS4H0cC2MMBFqRMhWgVGVmB2XhEg/nVgzCOTPJaZC3Ipiy/a9bCR2HT
 9ovg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfM/cBlZVu1QHGjw5H9Hc31XWFVZaumnfZ92N3MUZSGQT7sGzTwbZocM4LrgaOfplBfZZUdu9OUQ4JIV86RBAgkWBmJg==
X-Gm-Message-State: AOJu0YzLJJy2n1CbBF6Mwr+wqLJn85ON3e9RV2pFOOTASvMDwG8BFXc7
 BXBXRcQ4bOVe/8qLRRpiLmJQdtYFNCp+/JkXhiUKNe180T/PqBkCvScV+TOuH8L+B4szAmidh4/
 qs72zjA6ZQ9DFXqBss8KXFXdtQX9FABWaKA6ZXA==
X-Google-Smtp-Source: AGHT+IHJOKtaBWpE0xzx2KMuTqMXpQuELjsAk16IXW2kjU6JRu7GE5TSKmrBbDlE36SWHzKVwM6usCNXoxXt3345sbc=
X-Received: by 2002:a0d:de04:0:b0:64a:90fe:9108 with SMTP id
 00721157ae682-66380c110d6mr5943187b3.30.1721086302098; Mon, 15 Jul 2024
 16:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240712234304.9675-1-semen.protsenko@linaro.org>
 <20240712234304.9675-5-semen.protsenko@linaro.org>
 <CAFLszTgDFB6ivRdPfV9PnKgke+5TRwmpveicb-a2vOr-H-VPbg@mail.gmail.com>
In-Reply-To: <CAFLszTgDFB6ivRdPfV9PnKgke+5TRwmpveicb-a2vOr-H-VPbg@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 15 Jul 2024 18:31:31 -0500
Message-ID: <CAPLW+4noPcfRXcUx++Yjf0O0wbxCZsKJw0DiWWGzodC-8i-_Mg@mail.gmail.com>
Subject: Re: [PATCH 4/5] rng: Add Exynos TRNG driver
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jul 13, 2024 at 10:13=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Sam,
>

Hi Simon,

Thank you for the review!

> On Sat, 13 Jul 2024 at 00:44, Sam Protsenko <semen.protsenko@linaro.org> =
wrote:
> > +config RNG_EXYNOS
> > +       bool "Samsung Exynos True Random Number Generator support"
> > +       depends on DM_RNG
> > +       help
> > +         Enable support for True Random Number Generator (TRNG)
> > +         available in Exynos SoCs.
>
> Can you mention the needed firmware here?
>

Will do in v2.

> > +
> > +struct exynos_trng_variant {
>
> please add comments
>

Will do in v2.

> > +       bool smc;
> > +       int (*init)(struct udevice *dev);
> > +       void (*exit)(struct udevice *dev);
> > +       int (*read)(struct udevice *dev, void *data, size_t len);
> > +};
> > +
> > +struct exynos_trng {
>
> The convention is to add a _priv suffix
>

Will add in v2.

> > +static int exynos_trng_init_smc(struct udevice *dev)
> > +{
> > +       struct arm_smccc_res res;
> > +       int ret =3D 0;
> > +
> > +       arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_INIT, 0, 0, 0, 0, 0, 0, &re=
s);
> > +       if (res.a0 !=3D HWRNG_RET_OK) {
> > +               dev_err(dev, "SMC command for TRNG init failed (%d)\n",
> > +                       (int)res.a0);
> > +               ret =3D -EIO;
> > +       }
> > +       if ((int)res.a0 =3D=3D -1)
> > +               dev_info(dev, "Make sure LDFW is loaded\n");
>
> return error here?
>

It's already done above: (res.a0 !=3D HWRNG_RET_OK) condition includes
-1 case. This line is basically only to help user figure out what
might be wrong.

> > +static int exynos_trng_of_to_plat(struct udevice *dev)
> > +{
> > +       struct exynos_trng *trng =3D dev_get_priv(dev);
> > +
> > +       trng->data =3D (struct exynos_trng_variant *)dev_get_driver_dat=
a(dev);
> > +       if (!trng->data->smc) {
> > +               trng->base =3D dev_read_addr_ptr(dev);
> > +               if (!trng->base)
> > +                       return -ENODEV;
>
> That has a special meaning in U-Boot (i.e. that there is no device).
> Devicetree problems should return -EINVAL
>

Will fix in v2.

> > +       }
> > +
> > +       trng->clk =3D devm_clk_get(dev, "secss");
> > +       if (IS_ERR(trng->clk))
> > +               return -ENODEV;
>
> Should return the actual error
>

Will fix in v2.

> > +
> > +       trng->pclk =3D devm_clk_get_optional(dev, "pclk");
> > +       if (IS_ERR(trng->pclk))
> > +               return -ENODEV;
>
> same here
>

Will fix in v2.

> > +
> > +       return 0;
> > +}
> > +
> > +static int exynos_trng_probe(struct udevice *dev)
> > +{
> > +       struct exynos_trng *trng =3D dev_get_priv(dev);
> > +       int err;
>
> s/err/ret/
>

Will fix in v2.

[snip]

>
> Regards,
> Simon
