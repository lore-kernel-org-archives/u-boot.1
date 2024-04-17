Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A09C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 14:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1274882E2;
	Wed, 17 Apr 2024 16:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="ShWnQ3bv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D728F87842; Wed, 17 Apr 2024 16:58:49 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61702882AC
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 16:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57030fa7381so3477035a12.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713365926; x=1713970726; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9fwv2NmPsPhwmEKrgMnebA5ieLkyevqjTixSA9NBQc=;
 b=ShWnQ3bvD3r4+uvR05dZL+iH9kRXgnUmTvA8DaIqZt7wXECaR3TlS0ggZ3SppkL4Lw
 i34Noa4wb6G25wE4rKGBpQ5W5ZC18zmdCgsxisKK8eFusphgfc8ICiP94H60vCOPgVVf
 Q8MGV413dT6ISk7QrmFleoBlt04KZPdSINq6QYuc0trIJRDp/WLzH+ArzGp58nRoVhIV
 eDoPzU85zsR68urmmqFS5A5eDXMSlleesldVqVUgKa9h1KXji3WS+4wLiPOZNrBOSRj5
 bQRhBUCrRzlVuxgd3BRJJadkyqZiGklkegI05fhZLWBGZEkfWnjI49T18jzcLkpyR3Eg
 1x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713365926; x=1713970726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9fwv2NmPsPhwmEKrgMnebA5ieLkyevqjTixSA9NBQc=;
 b=FFyEDuBFOV1alJQ+kVfTKgXbdYUKdxuAr44t2QWdRbPt8XPWIbUYsSmSQ2pg0NPDZi
 bH1rPpgTY7ldeItOeNEnoCIFqpQBdAmlwR6Z022n4U7P5zBfFS8jVlK8NjLaSjhTYan7
 kSgCB9MD310XW36pGAVgMML1NiNgkxK3ygQ6ycaI9ymngoYvDIeYXFVoZpsEe9JCauNX
 ko/2n2B2io254qOlZkSN6lplS4gfctVGTpQWL7Hb4GsZ2dMATTwk+I5pI1q5s0i1O4RI
 ljdo5SIqPUnx04LBEgYn/kE7d3z373pmbjzsBS0bHNhDf2goUkrf9OEyeiB48sZs7FeK
 LdwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW+9DrJ21oPzlPxOKx558hdqlOFUMjFHsfCadqFvmnr7c2njsFcevTZ+zEI9nOepBqy8HReycy6BI88C385ZBeNiig6A==
X-Gm-Message-State: AOJu0YzHKSKSvUUy7t7xSXbpdBEI3pqKDmqYJPrHhXDJbbjddNSHN7K6
 uwOca1DwtObExAupPm232dyXW01l3IcsCy/7Buu5Wp5g8FP8lik525FvYz0ZWZaE8A3QVlLEm+3
 3ClH/KG5y0BIMwLdyzy2oJOxdblKdEauGCsOX4A==
X-Google-Smtp-Source: AGHT+IFAvKAt++/1NCwfb+7cPZVKPpLum3+SNbUKMSphXsni5jTWrXWJ5aRe7h9Mt+JK8CpH9Ambz9yM1dQvOr9TNpc=
X-Received: by 2002:a17:906:eb43:b0:a52:6d2b:e8f7 with SMTP id
 mc3-20020a170906eb4300b00a526d2be8f7mr5057856ejb.12.1713365925520; Wed, 17
 Apr 2024 07:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240327221205.1871317-1-tharvey@gateworks.com>
 <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
 <20240408092320.086ea1f1@xps-13>
 <CAC_iWj+DwGznVGX9BK0MRfdYaf0-XpqKNOQheJzJ340cV_-jGg@mail.gmail.com>
 <20240417084842.46da2ce6@xps-13>
 <CAC_iWjKnuJoOtC6N1vk91kwRwgA+iEVESdnxfvYRKx7GEPA3uQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKnuJoOtC6N1vk91kwRwgA+iEVESdnxfvYRKx7GEPA3uQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 17 Apr 2024 07:58:33 -0700
Message-ID: <CAJ+vNU3LdoyjA5petfYtXexG=BBAduUcJfLavwgT6QiOtD9O4Q@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: display warning if using gpio reset with TPM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Wed, Apr 17, 2024 at 12:01=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 17 Apr 2024 at 09:48, Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
> >
> > Hi Ilias,
> >
> > ilias.apalodimas@linaro.org wrote on Wed, 17 Apr 2024 08:40:14 +0300:
> >
> > > Hi Miquel
> > >
> > > On Mon, 8 Apr 2024 at 10:23, Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
> > > >
> > > > Hello,
> > > >
> > > > ilias.apalodimas@linaro.org wrote on Thu, 28 Mar 2024 09:08:37 +020=
0:
> > > >
> > > > > Thanks Tim
> > > > >
> > > > > On Thu, 28 Mar 2024 at 00:12, Tim Harvey <tharvey@gateworks.com> =
wrote:
> > > > > >
> > > > > > Instead of displaying what looks like an error message if a
> > > > > > gpio-reset dt prop is missing for a TPM display a warning that
> > > > > > having a gpio reset on a TPM should not be used for a secure pr=
oduction
> > > > > > device.
> > > > > >
> > > > > > TCG TIS spec [1] says:
> > > > > > "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to th=
e
> > > > > > platform CPU Reset signal such that it complies with the requir=
ements
> > > > > > specified in section 1.2.7 HOST Platform Reset in the PC Client
> > > > > > Implementation Specification for Conventional BIOS."
> > > > > >
> > > > > > The reasoning is that you should not be able to toggle a GPIO a=
nd reset
> > > > > > the TPM without resetting the CPU as well because if an attacke=
r can
> > > > > > break into your OS via an OS level security flaw they can then =
reset the
> > > > > > TPM via GPIO and replay the measurements required to unseal key=
s
> > > > > > that you have otherwise protected.
> > > > > >
> > > > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC=
ClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> > > > > >
> > > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > > ---
> > > > > > v2: change the message to a warning and update commit desc/log
> > > > > > ---
> > > > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_=
spi.c
> > > > > > index de9cf8f21e07..c9c83f6f0fc8 100644
> > > > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevi=
ce *dev)
> > > > > >                         /* legacy reset */
> > > > > >                         ret =3D gpio_request_by_name(dev, "gpio=
-reset", 0,
> > > > > >                                                    &reset_gpio,=
 GPIOD_IS_OUT);
> > > > > > -                       if (ret) {
> > > > > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > > > > -                                   "%s: missing reset GPIO\n",=
 __func__);
> > > > > > +                       if (ret)
> > > > > >                                 goto init;
> > > > > > -                       }
> > > > > >                         log(LOGC_NONE, LOGL_NOTICE,
> > > > > >                             "%s: gpio-reset is deprecated\n", _=
_func__);
> > > > > >                 }
> > > > > > +               log(LOGC_NONE, LOGL_WARNING,
> > > > > > +                   "%s: TPM gpio reset should not be used on s=
ecure production devices\n",
> > > > > > +                   dev->name);
> > > > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > > > >                 mdelay(1);
> > > > > >                 dm_gpio_set_value(&reset_gpio, 0);
> > > >
> > > > The current logic expects a reset gpio and bails out if it cannot g=
et
> > > > it with a (questionable) goto statement.
> > > >
> > > > You want to invert that logic, and expect no gpio, but only if ther=
e is
> > > > one you want to warn.
> > > >
> > > > This is perfectly fine but the logic here must be clarified. I'd go=
 for:
> > > >
> > > > ret =3D gpio_request()
> > > > if (ret) {
> > > >         ret =3D gpio_request()
> > > >         if (!ret)
> > > >                 warn(deprecated)
> > > > }
> > > >
> > > > if (!ret) {
> > > >         warn(dangerous)
> > > >         toggle_value()
> > > > }
> > > >
> > > > I would ideally replace the 'if (ret)' clauses with 'if (!reset_gpi=
o)'
> > > > which would make the checks even clearer.
> > >
> > > Fair enough. But the code with the proposed change has no functional
> > > problems right?
> >
> > No, this is functionally right, but the code is not clear like that.
> >
> > > If so I'll send a PR to Tom as is and rework it as suggested later
> >
> > Well, that's not how contribution work usually. Is there an emergency
> > in getting this merged?
>
> Not really, it's a print message. But I don't currently have time to
> pick this up.
> Tim, would you mind reworking it as Miquel suggested?
>

I'm just catching up after being out of the office for a couple of
weeks - I'll rework it and submit another revision as soon as I have
some time.

Best Regards,

Tim
