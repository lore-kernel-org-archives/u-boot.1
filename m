Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F65C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B48888A5;
	Wed, 24 Jul 2024 16:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="IQy+MAEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D5688805; Wed, 24 Jul 2024 15:20:18 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1428889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef2cce8c08so40255421fa.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721827214; x=1722432014;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfV9wF3taFL2WOO67QdKnDCBon1SfwWbG0zt3bnwCFM=;
 b=IQy+MAEeK3/A8iijzv0DYaB23VZNkkDWxTJBGSvo8NvyRj+MpFPsQ2txM+4+xYw2Yk
 Rihh3ftNpgK4J9B+XhuqeXNppST3TWwq+rerExWF5UaDLrVD1SxxaPJzLqX0ANCY3OAB
 xayMC19H98ddjbvOMUIRM/jclIFlnoTaqVdGcPRngQpLeLgC5sg0nbSmPIdJCpatuRI/
 ksw5qvI1acpimhUYvqu+5wK63aARW8kVSq3+ufAVsdQDjjqL9F9fAzGjg6sQWZZJlCnL
 wZCdvOwYne7AK5HbfZ9fOKs57+AOzjlZWz4Cv2UxDKzf8MIrP2fJXJ6C0PnmT0319aR1
 f4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721827214; x=1722432014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfV9wF3taFL2WOO67QdKnDCBon1SfwWbG0zt3bnwCFM=;
 b=Er/p7lslsBWHXc5tkIYcq805th6aebIsDVM3Wre47z2F2USRABbTeo2KYZ6Q0PB/UA
 rHBEjUfkVojWeLsX60KohbJBGLFWgnRPk711qvqVahAUyggfje+/7QetnmIpGbIFISBN
 D8y08gSfbJxkXumtO/gayEFWifZ4dfMqHj4Ys6rywmPqpnJakguVwJvPMof+dMGeRPsv
 o0//I9PuXRih9lGNnZC4DjaeqQ+2AepBFPiKqJnp98Dh8qCKLcHeMx13Z4nQaP0W0FLk
 ftpy2e7CBe8VELMQ1PooFQ3dsc/pGlRm2rSbCVY/bZEGHwqO5KbADqxLxX9RhO7Sfns/
 Y2tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOHVEcJFPDPhXfslIgG2Abp0avOAYxc+K4tjEKQyW+xWTe4AprjGnrOxA2lbntD/2roWqPux7Ck0VAvVV487GoMMopeA==
X-Gm-Message-State: AOJu0YwDi6+iGwC/JhXqddypjkNRyPdn4Sg1S/uTpOUNZ/Y6G+2CtzSn
 Ma0mS+4TCs2JSbPTHNlF+NuD0RVY5XN9Jg52A5q53GNPdj/W3pXhTEMi/aeSBTfBEwHD+rwKkME
 GErpP0ZBKpHGKHzWszadcxKFlpibkLmomDeZ0HA==
X-Google-Smtp-Source: AGHT+IHinU5VoERoSRbVxUcSBYbjXfbTViot9a50faN3SMv/YuFm9kaGJWAs3vtmPrw3kKtSAy9oyLsvSgoEfuhubyU=
X-Received: by 2002:a2e:9214:0:b0:2ef:2c20:e061 with SMTP id
 38308e7fff4ca-2ef2c20e213mr67341531fa.22.1721827213613; Wed, 24 Jul 2024
 06:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-8-zli@ogga.fr> <87wmlb3we8.fsf@baylibre.com>
In-Reply-To: <87wmlb3we8.fsf@baylibre.com>
From: admin LI <admin@hifiphile.com>
Date: Wed, 24 Jul 2024 15:20:02 +0200
Message-ID: <CA+Gyqeai78mjHHVXAQh-ALOqCRrxEd0O4gT1YfUNLgaUKGj4pg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] usb: gadget: atmel: Add DM_USB_GADGET support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 24 Jul 2024 16:19:16 +0200
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

Hi Mattijs,

On Wed, Jul 24, 2024 at 12:12=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Checkpatch complains here:
>
> checkpatch.pl: 164: WARNING: From:/Signed-off-by: email address mismatch:=
 'From: Zixun LI <admin@hifiphile.com>' !=3D 'Signed-off-by: Zixun LI <zli@=
ogga.fr>'
>
> Please make sure that the commiter matches the Signed-off-by.
> This can be done with git commit --reset-author or --author=3D"name <emai=
l>"
>

Will fix all Signed-off-by in v4.

>
> Here we change both:
> 1. pr_err() to log_err()
> 2. fix paramter -> parameter
>
> 2. should be done in patch 3/7 instead of here.
>
> With the above fixed:
>

Will fix in v4.

> Agreed, 'function' is more appropriate wording.
> Zixun, if you need to respin a v4 please consider using 'function'.
> Otherwise I can fix it up while applying !

Will fix in v4.

> > +static int usba_udc_probe(struct udevice *dev)
> > +{
> > +     struct usba_priv_data *priv =3D dev_get_priv(dev);
> > +     struct usba_udc *udc =3D &priv->udc;
> > +     int ret;
> > +
> > +     ret =3D usba_udc_clk_init(dev, &priv->clks);
> > +     if (ret)
> > +             return ret;
> > +
> > +     udc->fifo =3D (void __iomem *)dev_remap_addr_index(dev, FIFO_IOME=
M_ID);
> > +     if (!udc->fifo)
>
> I think that at this points &priv->clks are valid and enabled.
> Therefore, we should disable/release them (as being done in the remove)
>
> > +             return -EINVAL;
> > +
> > +     udc->regs =3D (void __iomem *)dev_remap_addr_index(dev, CTRL_IOME=
M_ID);
> > +     if (!udc->regs)
>
> Same here

Good catch, I copied the dwc2 driver who has the same issue, will fix in v4=
.

Also spotted udc->usba_ep allocated in usba_udc_pdata() is not freed.

I'll change probe() and remove() functions as follow:

static int usba_udc_probe(struct udevice *dev)
{
    struct usba_priv_data *priv =3D dev_get_priv(dev);
    struct usba_udc *udc =3D &priv->udc;
    int ret;

    udc->fifo =3D (void __iomem *)dev_remap_addr_index(dev, FIFO_IOMEM_ID);
    if (!udc->fifo)
        return -EINVAL;

    udc->regs =3D (void __iomem *)dev_remap_addr_index(dev, CTRL_IOMEM_ID);
    if (!udc->regs)
        return -EINVAL;

    ret =3D usba_udc_clk_init(dev, &priv->clks);
    if (ret)
        return ret;

    udc->usba_ep =3D usba_udc_pdata(&pdata, udc);

    udc->gadget.ops =3D &usba_udc_ops;
    udc->gadget.speed =3D USB_SPEED_HIGH,
    udc->gadget.is_dualspeed =3D 1,
    udc->gadget.name =3D "atmel_usba_udc",

    ret =3D usb_add_gadget_udc((struct device *)dev, &udc->gadget);
    if (ret)
        goto err;

    return 0;
err:
    free(priv->udc.usba_ep);

    clk_release_bulk(&priv->clks);

    return ret;
}

static int usba_udc_remove(struct udevice *dev)
{
    struct usba_priv_data *priv =3D dev_get_priv(dev);

    usb_del_gadget_udc(&priv->udc.gadget);

    free(priv->udc.usba_ep);

    clk_release_bulk(&priv->clks);

    return dm_scan_fdt_dev(dev);
}
