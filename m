Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5797C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 07:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCE7880A5;
	Mon, 22 Jul 2024 09:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JE3JXtYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EE688204; Mon, 22 Jul 2024 09:35:37 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DC98800C
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 09:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70d265e5278so296250b3a.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721633734; x=1722238534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=34AlKJBUAqgwwWW+z+tkH5nQxaWFzgIdFYHRMh4GkNw=;
 b=JE3JXtYuzlT75fAN+tTUli1E6PZ+nuwyM6gMORpAaS6Oftq21bM9EzdhqsyACGDW3A
 xLiW9xlFoo3F5ihTPt3FgUohv8DkPse5FKrm1ycOTE2uA85wW5yU9AtNS36ORoS70gJC
 lJcIVYQsnlhuHz2lsz4FvIcslTXtJWISkrHa5IovnJeobcdgOWiYwSDHqUpBbWUj1/k6
 2zaZ55KROXYtw3ADDUeA3lMy0SB8aMW/KGjMBnU+h4+SvJqaIRhZUOgKk8bqu8I6oWyP
 wda52Ho3DtbTs9k4TlDBSgEPeXBNFl1X40y4OvD6X1yjjmqm7ZtQuAmIg0Qbeyw1IOkF
 auvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721633734; x=1722238534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=34AlKJBUAqgwwWW+z+tkH5nQxaWFzgIdFYHRMh4GkNw=;
 b=wtobPN/xDNqorSqex1lSsLgLoOCyv5Yzy98FtdwsRIo2hdtJtDjBknRSx+kovxMZEf
 SfBIUdMcix2VyE9M76+lbx6mmQ9iDgbb6Jccf5FE0DeiWE+vbIRdDZ0LEI2FbZuItgqg
 zL7G/D5V2AFheeNUdZ1zGYB2abWYPAXYJnNp7mH83vyMV7b1Xl3DIAZ1FST1m6EubRhj
 2jbDMUsqbiMryzc7oGGXHUyX6KE3BMFTbAcJsH6OZCan2x1Nc4zvTrf9ecwZJ2tNBttA
 4yF42WjTSsppTZm2F8c67GqQp0X4nMKFeWPrqpp0v3rgQ+p7QHgOepshj+wh090ArBHY
 MJ4g==
X-Gm-Message-State: AOJu0YxzzwcrOLRJ+WzbhAuJ3eYQzNc7qFE9ldu2/HOdu5ztb0o54knH
 uTEKa/psU5rhSXUJinjIxGC+UNHkfu7wyCS/MtxeMQgbxawhAbQsxy6htQKY7krz0qRPsqgoMOq
 pw+wqSwsuSGuqJl20lZxwb75QxPlcqSfASk33CQ==
X-Google-Smtp-Source: AGHT+IHEKHao/rAtl05xfwYQaPS2kSraJtAiUDXHgIWv38hn4JidQjJ2DTVfOlDATT7k/2LAqm6pINSrqkB7UjxEgYk=
X-Received: by 2002:a05:6a00:1acd:b0:70b:349a:efd7 with SMTP id
 d2e1a72fcca58-70d086dcfc3mr5307427b3a.14.1721633733585; Mon, 22 Jul 2024
 00:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
 <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
 <CAFLszTgX8Tfn=qC_ZBMR2M+iwFAOLKQhGQg8w42F1saAmZq4Eg@mail.gmail.com>
In-Reply-To: <CAFLszTgX8Tfn=qC_ZBMR2M+iwFAOLKQhGQg8w42F1saAmZq4Eg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 10:34:57 +0300
Message-ID: <CAC_iWjJR=wXX-kv5cmzE38gOCX8FYduX7xhtmm_QHe911GXaPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
To: Simon Glass <sjg@chromium.org>, lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi all

On Sun, 21 Jul 2024 at 13:08, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Mon, 15 Jul 2024 at 12:23, <lukas.funke-oss@weidmueller.com> wrote:
> >
> > From: Lukas Funke <lukas.funke@weidmueller.com>
> >
> > tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
> > initialized in tpm_tis_init(). However, the init-function is called
> > *after* tpm_tis_wait_init() introducing an uninitalized field access.
> >
> > This commit switches both routines.
> >
> > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> > ---
> >
> >  drivers/tpm/tpm2_tis_spi.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > index b0fe97ab1d0..5a4dbfd3ccb 100644
> > --- a/drivers/tpm/tpm2_tis_spi.c
> > +++ b/drivers/tpm/tpm2_tis_spi.c
> > @@ -256,17 +256,17 @@ static int tpm_tis_spi_probe(struct udevice *dev)
> >         /* Ensure a minimum amount of time elapsed since reset of the TPM */
> >         mdelay(drv_data->time_before_first_cmd_ms);
> >
> > +       tpm_tis_ops_register(dev, &phy_ops);
> > +       ret = tpm_tis_init(dev);
> > +       if (ret)
> > +               goto err;
> > +
> >         ret = tpm_tis_wait_init(dev, chip->locality);
> >         if (ret) {
> >                 log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
> >                 return ret;
> >         }
> >
> > -       tpm_tis_ops_register(dev, &phy_ops);
> > -       ret = tpm_tis_init(dev);
> > -       if (ret)
> > -               goto err;
> > -
> >         priv->pcr_count = drv_data->pcr_count;
> >         priv->pcr_select_min = drv_data->pcr_select_min;
> >         priv->version = TPM_V2;
> > --
> > 2.30.2
> >
>
> This needs a Fixes tag for a5c30c26b28 (HEAD) tpm: Use the new API on
> tpm2 spi driver
>

Yes please we need a fixes tag

> The old code set up the timeouts first, then did the wait_init.
> Presumably the point of wait_init is to wait before doing the init, so
> we should try to keep that behaviour, unless it is actually wrong.
>
> So my thought would be to move the setup of the required timeout into
> tpm_tis_ops_register(), instead.

tpm_tis_ops_register() is setting up the bus accesses and I'd prefer
to keep it that way.
Since this is a static function, we can fold it in tpm_tis_init(),
which makes more sense

Thanks
/Ilias
>
> Regards,
> Simon
