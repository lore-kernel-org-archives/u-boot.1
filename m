Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99A8C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 12:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA8A887D4;
	Tue, 23 Jul 2024 14:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bghKv1XP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3FF887D3; Tue, 23 Jul 2024 14:47:28 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A168B887CD
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-66c7aeac627so24411657b3.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721738840; x=1722343640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DBPnPJIFMSj5Or7gMVTFCchtSCd4YO+b+xIjuMJdXfQ=;
 b=bghKv1XPF9Dvc5VRW0utY60IztVAGeEpE5jubc3K4XY4m/C8W8z32lDrq42ufEmBy7
 MViwtPUFV/Y5AopkF0vw/4+cf6wZQFSmeCCK7wFqUT+8Si5XWL7+LtYoBRmGDzshR7ra
 dlfk0uBFjY+6yrXEp4n7YSnjSIWAsUbGwv6eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721738840; x=1722343640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DBPnPJIFMSj5Or7gMVTFCchtSCd4YO+b+xIjuMJdXfQ=;
 b=QqHGqJIS/XHQVmjdEcHOb1NBUGrFWOITj1F7ujYGpYkwXCwMHkCb9BkBALGBwIvW2K
 msWd8WWkQApZTtgBVqTUa96y05fUeIindmbTCMDCYr8FUPmN+YVjDAfS5t8AE1whCYPj
 yesKFFiicZARKAooY2FQhJeZhiHvudihsSAK+EC3sAMLo8JHxx4b/5HXd0TmxAEYznEr
 IzJlDV5egVpTR40oE1AXKHO7KY5R+6wXJvKtyQ5pKRnHBLjVsMjZ7q8pd2Ar8Qf0OvHR
 DbJvlP6+lnUf/7Q+OuWcHITHIKLdf6Z96M4tT3xjX4dG0Oqz61YMEDz7fSl0eRRYp9Bu
 4h1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKVBAxVGrA6fVYmK/cMyD7noCl+r+xfMBGc3lFILM//5jY2VmfwecxZTurFw5q4v/l4lDHXW5CyMR6uT38N7mEmRoreQ==
X-Gm-Message-State: AOJu0YxMkwo8MffrS+BV3ON8k870pjtpaZLZN7aB5Vg25dH4BryiT/IM
 PXaJJtt3nNNGLpsLHqTcXI8V7tfBM8yVjVlnfqrbM70x2mWgTzMdYwaoTV6pU1ZR77rmOtLHs2L
 ryAJVXUb2Ui3QdopBxhcCU7eWXiWGOL38MNCA
X-Google-Smtp-Source: AGHT+IEvZXz0iA3PKxBE4rvj9WSfuyn2oSzgsgedT4r7e9RG8mpi3oNRMfXng5BIiuc+9CjV6fEaG7lcaZpaoXwhG80=
X-Received: by 2002:a05:690c:67c7:b0:650:9e71:bde7 with SMTP id
 00721157ae682-66a69452135mr142034397b3.26.1721738840398; Tue, 23 Jul 2024
 05:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
 <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
 <CAFLszTgX8Tfn=qC_ZBMR2M+iwFAOLKQhGQg8w42F1saAmZq4Eg@mail.gmail.com>
 <CAC_iWjJR=wXX-kv5cmzE38gOCX8FYduX7xhtmm_QHe911GXaPA@mail.gmail.com>
In-Reply-To: <CAC_iWjJR=wXX-kv5cmzE38gOCX8FYduX7xhtmm_QHe911GXaPA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jul 2024 13:47:09 +0100
Message-ID: <CAFLszTgpy8o37ZKYZaNKBt42ihXNWHzH3FNW1g5tLLuwnTeR+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Ilias

On Mon, 22 Jul 2024 at 08:35, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all
>
> On Sun, 21 Jul 2024 at 13:08, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, 15 Jul 2024 at 12:23, <lukas.funke-oss@weidmueller.com> wrote:
> > >
> > > From: Lukas Funke <lukas.funke@weidmueller.com>
> > >
> > > tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
> > > initialized in tpm_tis_init(). However, the init-function is called
> > > *after* tpm_tis_wait_init() introducing an uninitalized field access.
> > >
> > > This commit switches both routines.
> > >
> > > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> > > ---
> > >
> > >  drivers/tpm/tpm2_tis_spi.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > > index b0fe97ab1d0..5a4dbfd3ccb 100644
> > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > @@ -256,17 +256,17 @@ static int tpm_tis_spi_probe(struct udevice *dev)
> > >         /* Ensure a minimum amount of time elapsed since reset of the TPM */
> > >         mdelay(drv_data->time_before_first_cmd_ms);
> > >
> > > +       tpm_tis_ops_register(dev, &phy_ops);
> > > +       ret = tpm_tis_init(dev);
> > > +       if (ret)
> > > +               goto err;
> > > +
> > >         ret = tpm_tis_wait_init(dev, chip->locality);
> > >         if (ret) {
> > >                 log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
> > >                 return ret;
> > >         }
> > >
> > > -       tpm_tis_ops_register(dev, &phy_ops);
> > > -       ret = tpm_tis_init(dev);
> > > -       if (ret)
> > > -               goto err;
> > > -
> > >         priv->pcr_count = drv_data->pcr_count;
> > >         priv->pcr_select_min = drv_data->pcr_select_min;
> > >         priv->version = TPM_V2;
> > > --
> > > 2.30.2
> > >
> >
> > This needs a Fixes tag for a5c30c26b28 (HEAD) tpm: Use the new API on
> > tpm2 spi driver
> >
>
> Yes please we need a fixes tag
>
> > The old code set up the timeouts first, then did the wait_init.
> > Presumably the point of wait_init is to wait before doing the init, so
> > we should try to keep that behaviour, unless it is actually wrong.
> >
> > So my thought would be to move the setup of the required timeout into
> > tpm_tis_ops_register(), instead.
>
> tpm_tis_ops_register() is setting up the bus accesses and I'd prefer
> to keep it that way.
> Since this is a static function, we can fold it in tpm_tis_init(),
> which makes more sense

Since this is used by i2c and SPI we need to make sure that both work.

I believe the way it used to be, some initial values were set for the
timeouts. The naming is somewhat confusing I suppose.

Regards,
Simon
