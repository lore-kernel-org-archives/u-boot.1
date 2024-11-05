Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8810D2C13D
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C881891AF;
	Tue,  5 Nov 2024 16:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cRT/4+ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC6E8913F; Tue,  5 Nov 2024 16:39:48 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2936891BC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b15eadee87so399891685a.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730821184; x=1731425984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8DCjkEDe8zQiOIxdclMUFPXJi1kKHBaVuFM1MupZktQ=;
 b=cRT/4+edT7jGMYbRo/KflltwLaeSTEWzEgdzy+R+ee/dxaNfO4c0wwBgW4W3Z0Nc95
 p4yk2phsmyVsEE6ugYir1x1fpOSuqI+byI717DF5OKeIB0C8ivAIugSyor6OW90t1dg8
 HjLR1F4Zf6iSK1li7KontJuL7GhPLp6k9K9es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821184; x=1731425984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DCjkEDe8zQiOIxdclMUFPXJi1kKHBaVuFM1MupZktQ=;
 b=WfrSa28oV41HtvFR+KdrFrT7wYu5l3yKjPK6v5uPbGXcfuBIq2dtCDVuOK0dvlgMCN
 g/q480qqSzqAtmAbiWrmWlRZxTsBtEArZJXPjZYcMXNdDvtKZu2ZQDqkLYNOjz7xx8w8
 WEzjqynOhCqHxF83yF/Vq53eSLpBLyvlP3GR9kK7gAzMQXNM+nVmtf12+l5Fgyu1dANe
 DLPQ2tIU6/dd8JxnluEItLPtBdZNZPf5LuwsIBGfgHZPOuc+9k2VY0Yq/eZnHr8KcKsT
 iCaT6vk3YA1uZjduaQu+eHUmR2YZ3oShSCkUyw4RC/HstR9weouHfI0dTdXXLSfd59b9
 32HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZnUSVvIIuXHgZ/V0cbJn0bHHy8L7T0HDbd9XNHlqe8IIUDnlsHWSVG/rSmAbIoGU74mKcw4k=@lists.denx.de
X-Gm-Message-State: AOJu0YxzcoO9cVYsK0ePlNuR5mkza4z0QwC2n4BoHziegdco2nLrqrnv
 kPVuEF7wwXX9BtWg2ZBQP5H3J57lg03R63qEvnbXKEEi2umy+gfz22xRSmS42M0=
X-Google-Smtp-Source: AGHT+IEbx8GWPodugmzxKVLx+9q6km2Mcj5U+LtBNH2hscqywUg/e8eg2FRAH4yRIeVxRkJKK3hK+Q==
X-Received: by 2002:a05:620a:25cc:b0:7a7:dd3a:a699 with SMTP id
 af79cd13be357-7b2f24c54c3mr2932355385a.11.1730821183513; 
 Tue, 05 Nov 2024 07:39:43 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a9babfsm535307085a.125.2024.11.05.07.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:39:42 -0800 (PST)
Date: Tue, 5 Nov 2024 09:39:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 01/19] bootstd: Move bootflow-adding to bootstd
Message-ID: <20241105153939.GG3600562@bill-the-cat>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <20241104175110.1048449-2-sjg@chromium.org>
 <d2822624-f9a0-4bc6-a911-861c7b2ac88e@gmx.de>
 <CAFLszTg6=FOJa0-=ywoNEkhSSSSoCE2mtHCQyTiWYqvZmQFRCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vYuPUIDTrcxU99KJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTg6=FOJa0-=ywoNEkhSSSSoCE2mtHCQyTiWYqvZmQFRCg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--vYuPUIDTrcxU99KJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 4 Nov 2024 at 15:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > On 11/4/24 18:50, Simon Glass wrote:
> > > This relates to more than just the bootdev, since there is a global l=
ist
> > > of bootflows. Move the function to the bootstd file and rename it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >   boot/bootdev-uclass.c | 25 -------------------------
> > >   boot/bootstd-uclass.c | 25 +++++++++++++++++++++++++
> > >   cmd/bootflow.c        |  2 +-
> > >   include/bootdev.h     | 15 ---------------
> > >   include/bootstd.h     | 17 +++++++++++++++++
> > >   5 files changed, 43 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> > > index 64ec4fde493..eddbf60600c 100644
> > > --- a/boot/bootdev-uclass.c
> > > +++ b/boot/bootdev-uclass.c
> > > @@ -32,31 +32,6 @@ enum {
> > >       BOOT_TARGETS_MAX_LEN    =3D 100,
> > >   };
> > >
> > > -int bootdev_add_bootflow(struct bootflow *bflow)
> > > -{
> > > -     struct bootstd_priv *std;
> > > -     struct bootflow *new;
> > > -     int ret;
> > > -
> > > -     ret =3D bootstd_get_priv(&std);
> > > -     if (ret)
> > > -             return ret;
> > > -
> > > -     new =3D malloc(sizeof(*bflow));
> > > -     if (!new)
> > > -             return log_msg_ret("bflow", -ENOMEM);
> > > -     memcpy(new, bflow, sizeof(*bflow));
> > > -
> > > -     list_add_tail(&new->glob_node, &std->glob_head);
> > > -     if (bflow->dev) {
> > > -             struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(bfl=
ow->dev);
> > > -
> > > -             list_add_tail(&new->bm_node, &ucp->bootflow_head);
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> > > -
> > >   int bootdev_first_bootflow(struct udevice *dev, struct bootflow **b=
flowp)
> > >   {
> > >       struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> > > diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> > > index fdb8d69e320..bf6e49ad97a 100644
> > > --- a/boot/bootstd-uclass.c
> > > +++ b/boot/bootstd-uclass.c
> > > @@ -61,6 +61,31 @@ void bootstd_clear_glob(void)
> > >       bootstd_clear_glob_(std);
> > >   }
> > >
> > > +int bootstd_add_bootflow(struct bootflow *bflow)
> > > +{
> > > +     struct bootstd_priv *std;
> > > +     struct bootflow *new;
> > > +     int ret;
> > > +
> > > +     ret =3D bootstd_get_priv(&std);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     new =3D malloc(sizeof(*bflow));
> > > +     if (!new)
> > > +             return log_msg_ret("bflow", -ENOMEM);
> > > +     memcpy(new, bflow, sizeof(*bflow));
> > > +
> > > +     list_add_tail(&new->glob_node, &std->glob_head);
> > > +     if (bflow->dev) {
> > > +             struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(bfl=
ow->dev);
> > > +
> > > +             list_add_tail(&new->bm_node, &ucp->bootflow_head);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >   static int bootstd_remove(struct udevice *dev)
> > >   {
> > >       struct bootstd_priv *priv =3D dev_get_priv(dev);
> > > diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> > > index f67948d7368..8962464bbf8 100644
> > > --- a/cmd/bootflow.c
> > > +++ b/cmd/bootflow.c
> > > @@ -207,7 +207,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp=
, int flag, int argc,
> > >               bflow.err =3D ret;
> > >               if (!ret)
> > >                       num_valid++;
> > > -             ret =3D bootdev_add_bootflow(&bflow);
> > > +             ret =3D bootstd_add_bootflow(&bflow);
> > >               if (ret) {
> > >                       printf("Out of memory\n");
> > >                       return CMD_RET_FAILURE;
> > > diff --git a/include/bootdev.h b/include/bootdev.h
> > > index ad4af0d1310..8db198dd56b 100644
> > > --- a/include/bootdev.h
> > > +++ b/include/bootdev.h
> > > @@ -195,21 +195,6 @@ void bootdev_list(bool probe);
> > >    */
> > >   void bootdev_clear_bootflows(struct udevice *dev);
> > >
> > > -/**
> > > - * bootdev_add_bootflow() - Add a bootflow to the bootdev's list
> > > - *
> > > - * All fields in @bflow must be set up. Note that @bflow->dev is use=
d to add the
> > > - * bootflow to that device.
> > > - *
> > > - * @dev: Bootdev device to add to
> > > - * @bflow: Bootflow to add. Note that fields within bflow must be al=
located
> > > - *   since this function takes over ownership of these. This functio=
ns makes
> > > - *   a copy of @bflow itself (without allocating its fields again), =
so the
> > > - *   caller must dispose of the memory used by the @bflow pointer it=
self
> > > - * Return: 0 if OK, -ENOMEM if out of memory
> > > - */
> > > -int bootdev_add_bootflow(struct bootflow *bflow);
> > > -
> > >   /**
> > >    * bootdev_first_bootflow() - Get the first bootflow from a bootdev
> > >    *
> > > diff --git a/include/bootstd.h b/include/bootstd.h
> > > index ac756e98d84..3fc93a4ec2e 100644
> > > --- a/include/bootstd.h
> > > +++ b/include/bootstd.h
> > > @@ -105,4 +105,21 @@ void bootstd_clear_glob(void);
> > >    */
> > >   int bootstd_prog_boot(void);
> > >
> > > +/**
> > > + * bootstd_add_bootflow() - Add a bootflow to the bootdev's and glob=
al list
> > > + *
> > > + * All fields in @bflow must be set up. Note that @bflow->dev is use=
d to add the
> > > + * bootflow to that device.
> > > + *
> > > + * The bootflow is also added to the global list of all bootflows
> > > + *
> > > + * @dev: Bootdev device to add to
> >
> > This parameter does not exist.
> >
> > > + * @bflow: Bootflow to add. Note that fields within bflow must be al=
located
> > > + *   since this function takes over ownership of these. This functio=
ns makes
> > > + *   a copy of @bflow itself (without allocating its fields again), =
so the
> > > + *   caller must dispose of the memory used by the @bflow pointer it=
self
> >
> > Please, add the headers to the API documentation and fix the numerous
> > documentation issues like:
> >
> > ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_0_NONE' not
> > described in enum 'bootdev_prio_t'
> > ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_1_PRE_SCAN' not
> > described in enum 'bootdev_prio_t'
> > ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_COUNT' not
> > described in enum 'bootdev_prio_t'
> > ./include/bootdev.h:57: warning: Excess enum value 'BOOTDEVP_6_PRE_SCAN'
> > description in 'bootdev_prio_t'
> > ./include/bootdev.h:118: warning: Function parameter or member
> > 'bootflow_head' not described in 'bootdev_uc_plat'
> > ./include/bootdev.h:118: warning: Function parameter or member 'prio'
> > not described in 'bootdev_uc_plat'
> > ./include/bootdev.h:412: warning: Function parameter or member 'blk' not
> > described in 'bootdev_setup_for_sibling_blk'
> > ./include/bootdev.h:412: warning: Excess function parameter 'parent'
> > description in 'bootdev_setup_for_sibling_blk'
>=20
> I don't mind doing that in a follow-up once this series is in, but it
> is out-of-scope here.

I think that's flipping the priorities. Documenting what all of this is
supposed to be doing will help explain to the rest of us what you're
intending to do and why it's a good idea and so forth.

--=20
Tom

--vYuPUIDTrcxU99KJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqPDgACgkQFHw5/5Y0
tyyY4Av/ad+XR1fT3wQdTw6S90vQhCP6HpMRlsORJl2UIGJWlqag4cWrBqe84fDK
88c2COZ2bolih9dkhTgDXCip0R6l+kwC/hYrey6KCBX75BHoTsBnzBRohummJ2Cp
dCmCkws/xZgkJBPnLx/jj8ULkHnV1+/3a8qohRa84/022+xRICvmgL9t8MjA2k3L
4IZ0wvKJlWfOr6rSY+SdHEMkx5020sl9Gbw2UH5AKq3uRjEzaWxSdJr2CDwr/pVH
j9d664qQ50rvWLO7jUuOTDd1JtI33I0aNq23co7QwBJFBgUDp1LGNO1b8Hfax08W
ij27lGXQkvdRn4BPc8g+eiL7z2PP/fXY5QoSgjxIwJ3IpIr+RWanweGLG/orQN3H
5xumoqdnCzLu2Y1HqlqmpaAHCO8EwnlZEkdoHIrjNRhZOW+DmP49/vUih6KB5ZQh
onNkT0V9VFcAeF2XtYkHWNLUbZySH8oSirYuNAb8gg1IYOV4lqGGmjOd2zGKpMCs
7L5++qim
=NJyo
-----END PGP SIGNATURE-----

--vYuPUIDTrcxU99KJ--
