Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77ACCF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA48C88A43;
	Wed, 25 Sep 2024 03:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PW7QUeR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BD087705; Wed, 25 Sep 2024 01:44:20 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A310388B08
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 01:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4581ec0e00eso45377671cf.3
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727221452; x=1727826252; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P03mn90oLN4ug+q7R4E64HXeFlP3z7hnM7oy8hVHK7I=;
 b=PW7QUeR6zMn8Dn8sJ6KAO6ePcGw4K33krghtIxJclJ+bGKGo0Fy6zWm6C7zYNJI+qZ
 egjZr/dnoSKZ4ljk+6ADHho2iVvmjKtXv4Ku5TcE3sjW++njcSETifm9thK/xCT+vt0K
 UOAkps6tsyAUgJemVUe11ypriOqDSJpM6j9ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727221452; x=1727826252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P03mn90oLN4ug+q7R4E64HXeFlP3z7hnM7oy8hVHK7I=;
 b=iVkM0Ts185wB4LUBEkN68pt/Fx4ohg9tYix9hM7Zvd2rBEMBltugZKEopx17V3uJZf
 Z+afmZyv1kAWwFvLhf9VSgwCbGFD1knDf0g5Mp0YBYvrf9xoGdD5TXM/TM8/BtqjWtBE
 i3ZzhRZ2QKTjgGZzgShksv/TQhnGWJRxWqDXySLc4/FeFAEeizxlrle7fvRY6gBQ6q5H
 hodch51LHUVbMISwoKMl+J4BN+K8qnqv5UNRO5cGzESw2s9r1xJu497N7IWlEqd8IUMQ
 Jm3nkA9xd+MrFNT8M8C7PSPM35aVSA/IxDiYBCK6xXP6oSjY40Zj6PXDw6HyIUKu+aG2
 dQOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWszC+x/ZJmboT8PnX+6hJbQE142YBSw5DHfj5ydKshFZC18BJhzK7CNgCX40iwqkuPo3PbSM=@lists.denx.de
X-Gm-Message-State: AOJu0YwB6C+ucyM5r6+rMybY+U2PgnwoQLxMAykBK/UEdKgEMH1TZ3zG
 CWTsPtljXEahEDH9EvdhzBl8bLoUIwPDuQXmUWysdXW7L8pBrOA6IkZGPhQUsGI=
X-Google-Smtp-Source: AGHT+IGSAFeMFVNn5GSTRrF0hFNNzmimoS2rcZA438DfRWz3dg2u0UpaXzO4eqppWn2v+qw9nVGnhg==
X-Received: by 2002:a05:622a:1104:b0:453:5f05:2ba3 with SMTP id
 d75a77b69052e-45b5dec7c50mr22656091cf.8.1727221452293; 
 Tue, 24 Sep 2024 16:44:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b526924d7sm11083921cf.87.2024.09.24.16.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 16:44:11 -0700 (PDT)
Date: Tue, 24 Sep 2024 17:44:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
Message-ID: <20240924234406.GX4252@bill-the-cat>
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat>
 <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JT/sMhsqzwoYKDJk"
Content-Disposition: inline
In-Reply-To: <20240920164856.GI4252@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 25 Sep 2024 03:47:06 +0200
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


--JT/sMhsqzwoYKDJk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 10:48:56AM -0600, Tom Rini wrote:
> On Fri, Sep 20, 2024 at 07:40:35PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 16 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 19:28 =
Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 11, 2024 at 07:00:56PM -0600, Simon Glass wrote:
> > > > Hi Marek,
> > > >
> > > > On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
> > > > >
> > > > > On 6/28/24 9:32 AM, Simon Glass wrote:
> > > > > > Hi Marek,
> > > > >
> > > > > Hi,
> > > > >
> > > > > [...]
> > > > >
> > > > > >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct ud=
evice *dev)
> > > > > >>>>                                                   -ENODATA);
> > > > > >>>>           uc_pdata->max_uA =3D dev_read_u32_default(dev, "re=
gulator-max-microamp",
> > > > > >>>>                                                   -ENODATA);
> > > > > >>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulato=
r-always-on");
> > > > > >>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-=
boot-on");
> > > > > >>>>           uc_pdata->ramp_delay =3D dev_read_u32_default(dev,=
 "regulator-ramp-delay",
> > > > > >>>>                                                       0);
> > > > > >>>>           uc_pdata->force_off =3D dev_read_bool(dev, "regula=
tor-force-boot-off");
> > > > > >>>> --
> > > > > >>>> 2.43.0
> > > > > >>>>
> > > > > >>>
> > > > > >>> This is reading a lot of DT stuff very early, which may be sl=
ow. It is
> > > > > >>> also reading from the DT in the bind() step which we sometime=
s have to
> > > > > >>> do, but try to avoid.
> > > > > >>
> > > > > >> Actually, it is reading only the bare minimum very early in bi=
nd, the
> > > > > >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> > > > > >
> > > > > > Yes, I see that. Also it is inevitable that these properties ne=
ed to
> > > > > > be read before probe(), since they control whether to probe().
> > > > > >
> > > > > >>
> > > > > >>> Also this seems to happen in SPL and again pre-reloc and agai=
n in
> > > > > >>> U-Boot post-reloc?
> > > > > >>
> > > > > >> What does, the uclass post_bind ?
> > > > > >
> > > > > > I mean that this code will be called in SPL (if the regulators =
are in
> > > > > > the DT there), U-Boot pre-reloc and post-reloc, each time turni=
ng on
> > > > > > the regulators. We need a way to control that, don't we?
> > > > >
> > > > > I would assume that if those regulators are turned on once in the
> > > > > earliest stage , turning them on again in the follow up stage wou=
ld be a
> > > > > noop ? This is the point of regulator-*-on, to keep the regulator=
s on.
> > > >
> > > > No, there is sometimes a particular sequence needed.
> > > >
> > > > >
> > > > > >>> Should we have a step in the init sequence where we set up the
> > > > > >>> regulators, by calling regulators_enable_boot_on() ?
> > > > > >>
> > > > > >> Let's not do this , the entire point of this series is to get =
rid of
> > > > > >> those functions and do the regulator configuration the same wa=
y LED
> > > > > >> subsystem does it -- by probing always-on/boot-on regulators a=
nd
> > > > > >> configuring them correctly on probe.
> > > > > >>
> > > > > >> To me regulators_enable_boot_on() and the like was always an
> > > > > >> inconsistently applied workaround for missing DM_FLAG_PROBE_AF=
TER_BIND ,
> > > > > >> which is now implemented, so such workarounds can be removed.
> > > > > >
> > > > > > That patch seemed to slip under the radar, sent and applied on =
the
> > > > > > same day! We really need to add a test for it, BTW.
> > > > >
> > > > > Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was tha=
t it
> > > > > took a while to get in.
> > > >
> > > > [1]
> > > >
> > > > >
> > > > > > My concern is that this might cause us ordering problems. We pe=
rhaps
> > > > > > want the regulators to be done first. If drivers are probed whi=
ch use
> > > > > > regulators, then presumably they will enable them. Consider thi=
s:
> > > > > >
> > > > > > - LED driver auto-probes
> > > > > >     - probes I2C bus 2
> > > > > >     - probes LDO1 which is autoset so turns on
> > > > > > - LDO1 probes, but is already running
> > > > > > - LDO2 probes, which is autoset so turns on
> > > > > >
> > > > > > So long as it is OK to enable the regulators in any order, then=
 this
> > > > > > seems fine. But is it? How do we handle the case where are part=
icular
> > > > > > sequence is needed?
> > > > >
> > > > > Did we finally arrive at the point where we need -EPROBE_DEFER al=
ike
> > > > > mechanism ?
> > > >
> > > > Nope. But I am concerned that this patch is leading us there. bind()
> > > > really needs to be as clean as possible. It is one of the design
> > > > elements of driver model which Linux should adopt.
> > > >
> > > > There is always a race to be the first to init something, move the
> > > > init earlier, etc... I don't see any general need to init the
> > > > regulators right at the start. It should be done in a separate
> > > > function and be optional. I am happy to send a patch if you like.
> > >
> > > Since we're currently stuck on the point where Marek has patches that
> > > fix a real problem, and Svyatoslav has a problem with them, but isn't
> > > currently able to debug it, yes, please put forward your patch that
> > > might address both sets of problems so we can all figure out how to
> > > resolve the problems, thanks!
> >=20
> > With patches from Marek there is no i2c chip probe of PMIC, while
> > without i2c chip probe is called (probe_chip function). How this is
> > even possible?
>=20
> Yes, it's very puzzling. Do you have the ability to get some debug
> console type information out so you can sprinkle in some prints and
> figure it out?

So, here's my plan. Marek posted
https://patchwork.ozlabs.org/project/uboot/patch/20240924220905.514122-1-ma=
rex@denx.de/
which is a work-around, so that v2024.10 can work. I'm going to take
that for master tomorrow. I'm also going to take _this_ series to -next
tomorrow, as this is the best approach we currently have to solving the
overall problem. The Tegra platforms that are now very oddly broken need
to get debugged to see where their problem is, and if there's an
entirely alternate approach, Simon can post patches for that instead on
top of next.

--=20
Tom

--JT/sMhsqzwoYKDJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbzTsIACgkQFHw5/5Y0
tyzDhgv2LJ+bMV4zsPkePu4u+aBk1VuRHfL7pr/t8xQ3gfvPQzwyVWLn9rnBN0al
h1xtcFmw1Bw1WuxU53m08b8Rb9xFzjr/Dd2+mWFMx/07s1w+MQownm7AmwVGAre/
29Hor5HwDyd0MBIM8vCq7KI3xoAiTdei1wZQRPcK2fENfkasSY5LUuOC0fznRIZK
ZKFB9zgDp+43rMocm38caXuW2GTds7nNkr0o+uHVore0Teinb75bCKgFvdichQ+2
s2+rK6w8+XGYnpnIzaddAsoVR7HpCT44MlkX+KLV4RPlSTqrpE2LMNIbJUpK5SWx
hRXixBu6zepyweaWhPPHcuFIDWRYMx4eYNrRVupa2Dzo3YdodE+f2hXZcAu9KLtX
+vt1b4V+kWt7TUBLBUMMLJq3jFrbP4XVgqqKxpYQSYJwKdNz1h06B0G6s80esQ5p
cFbESD3Q7S8yT8V/AUWAVY/HthGSPN1qi/TrsTe5ydeLNCkMhQA6ZYPjgrhXNHyd
JYR1DIw=
=PgjZ
-----END PGP SIGNATURE-----

--JT/sMhsqzwoYKDJk--
