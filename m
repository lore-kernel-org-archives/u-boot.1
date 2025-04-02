Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C608C3601B
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6CBE81F69;
	Wed,  2 Apr 2025 21:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LUcpa51y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2724681F69; Wed,  2 Apr 2025 21:19:25 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A3381E6C
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so19895566b.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621562; x=1744226362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PRmee0+289w4+8OpI0lgCz6KUA9zqsHPmfEeYPhXs9Q=;
 b=LUcpa51y46JJp9B3GIYTB5ZA6TSxpQb2JFjIwXtzHrW3VGjRHodXiMhaqo8Nrds9AY
 dPk/Y/k10LD7/Pn9PkTQdMzcllReCFzWV23iJEMbjhCp6hQauLf3iEz4xrrJ70e4elKS
 CIfGQpOD6AfWhrgIkd9BYo3qD6wxWoMT9vNvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621562; x=1744226362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PRmee0+289w4+8OpI0lgCz6KUA9zqsHPmfEeYPhXs9Q=;
 b=QtHxASCjv1E2TVsdchmyG9q1mZUZKqq7tABf1l3b7AVw0d8Vo02V2teZItcO/oLbj1
 d4S37QucwJbS3PgXuovcPfOQbGu9aguJvwVcT6FeiEf3ljQO6DuQmuzHERdO2o1IwFhr
 5kA4T7rZ3P2e8Wx5+x8i2nDtCjjJSxfCp07rXJtK/gzJkHYaZjLv3Ze4JDxOZ7HxK6Xq
 M2W0Z6M2MD45AvUxmAbaiQyQlqkgs2Brmr+vF7l7UQ01GRpd67KHKZjhdxbD0jykKn69
 /Npr8o6CT0vFPQq++BIhqNHX3+yB/OyOrxRPLAEmDumBq2AuqxyqaIdc5abWMf+CcXYX
 LRDQ==
X-Gm-Message-State: AOJu0YzxWZOMpxDVtzY4+kC3V5OOoHwf7nI4z1plZmvoBunRV9tFEP2i
 qd2emRDyVqVQGi9LXdXNrlTBBoqjMAEZJcN7/Ol4OtDo+BpHE6f7Sj+smGd46u5TsBgrmZ8Mdqv
 zqjqdprppDmzANX2Bz00QXAJIaPygRiDyRSvR
X-Gm-Gg: ASbGnctXeF/xd7b59f7EEoJTeIFvYCAy7+EVMihHxVeTsJAOGTilWKN1zG/IrJPuOf8
 +ENWWsl4VcHQ1Eom6qCQ/TkuT6YNTJIML0tTuxYciMActLHw+E9v9ep8d4YPmV1rccAA5uOamzC
 CqopE8PrHMUa4+A4q/EXTB6grAh5+h
X-Google-Smtp-Source: AGHT+IF25b0yEWqwzs/euXJe4An4M2eubxlE5SXeMOmOZnqy7v4ndkOdGVi/qnCtcEW8E6dflhUGrVpqZrxIrLcuQ7k=
X-Received: by 2002:a17:906:7955:b0:ab7:6606:a8b9 with SMTP id
 a640c23a62f3a-ac738b4ae92mr1698359466b.42.1743621562272; Wed, 02 Apr 2025
 12:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250401212821.1363793-1-sjg@chromium.org>
 <CAC_iWjJLe6VF+gze3gCe_WTLON+5Xe7Kx3v3BgTCJ2KkX56f7A@mail.gmail.com>
In-Reply-To: <CAC_iWjJLe6VF+gze3gCe_WTLON+5Xe7Kx3v3BgTCJ2KkX56f7A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:19:07 +1300
X-Gm-Features: AQ5f1JoeuSg2Uu0T1vNgMdKaQQ8aAGK1Iv-VFxbC76QkrbWI9X4TvSWtZ_YoNPA
Message-ID: <CAFLszTjEdUi+sA6hB83bgFWEiE25_UfqmMnb=nALahgQUX1-+g@mail.gmail.com>
Subject: Re: [PATCH] tpm: cr50: Support opening the TPM multiple times
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

HI Ilias,

On Wed, 2 Apr 2025 at 19:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 2 Apr 2025 at 00:28, Simon Glass <sjg@chromium.org> wrote:
> >
> > The tpm_auto_start() function is used in tests and assumes that it can
> > open the TPM even if it is already open and a locality claimed. The cr50
> > driver does not use the common TPM2 TIS code so lacks a check for the
> > is_open field of struct tpm_chip and in fact it doesn't use that struct.
> >
> > Add an equivalent check to cr50_i2c_open().
> >
> > This fixes tpm_auto_start() on coral.
>
> Mind if I change this on the commit. it doesn't fix tpm_auto_start()
> it fixes *all* init on that TPM because tpm init && tpminit hangs as
> well
>
> Other than that
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

OK thanks, yes please go ahead.

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  drivers/tpm/cr50_i2c.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
> > index 08ec179346e..5b2d5ccb146 100644
> > --- a/drivers/tpm/cr50_i2c.c
> > +++ b/drivers/tpm/cr50_i2c.c
> > @@ -737,9 +737,13 @@ static int cr50_i2c_report_state(struct udevice *dev, char *str, int str_max)
> >
> >  static int cr50_i2c_open(struct udevice *dev)
> >  {
> > +       struct cr50_priv *priv = dev_get_priv(dev);
> >         char buf[80];
> >         int ret;
> >
> > +       if (priv->locality != -1)
> > +               return -EBUSY;
> > +
> >         ret = process_reset(dev);
> >         if (ret)
> >                 return log_msg_ret("reset", ret);
> > --
> > 2.43.0
> >
> > base-commit: e0695b08a71e167bf5ce83ae25acfdebca554b8d
> > branch: tpm

Regards,
Simon
