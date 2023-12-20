Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0416C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 20:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4598687827;
	Wed, 20 Dec 2023 21:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LjHIJ9BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C343D8783A; Wed, 20 Dec 2023 21:05:35 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D208781C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 21:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5e7bb1e0db8so961217b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703102732; x=1703707532; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2T7U5rPEPkshv36FDAvIoqwlfIGHFRLTVq9rpfQLSqk=;
 b=LjHIJ9BOCN6jGj63ZS3nfBeNmmXH4iRJA8x6/LB22AKA1YJHenUEKo7I7klJI/U+Kg
 jTqVlkoEiFxfhdR8mzCi+/viOWCFnFZVcN1CPG3cVHveOZviNUbGAb8JO7DyOkkmQxth
 GPy76dlG4q/3KVCZcj6768NOkKZWVhKTvHIpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703102732; x=1703707532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2T7U5rPEPkshv36FDAvIoqwlfIGHFRLTVq9rpfQLSqk=;
 b=IPhYzPkSBr8aTHUbYoYuKtnPKyKgtagbseCYGu3vDMtWHHcstYOJnvElFuGohCHJ2a
 Z7wKfEJs9HudN+B4Aaf6yTkH96oCcFWMXgXLqUkG7CyNgv5n6VaoTUEBnkvs43DIJiPM
 YceCk6vlnXUCgAF+5at2szti2W+JfxXaDmpnHJhKBmGTaeMgYIfEcgKZDDVF/4qKOg3S
 ZHRpEjK8GbZmBU8ngedkgQgwvpO1bf2Mou3Q2UH6GAWMAr5vHdhXV4PNFMXcgvG6rqyp
 p8rLvE+fECOXsfAlTe4gxOUQqO15jcvKI366+U/7APRwz4BheZc1ctrZJQLSB8Wz6eVO
 L2IQ==
X-Gm-Message-State: AOJu0YykyoH18tqhPlx8bs0dkIxUGYrSmj+ZZHRdJLS0wnCcaznL+hLw
 vwgcX2YMF8x1Jj7XX40qKTuMdA==
X-Google-Smtp-Source: AGHT+IHjGzYDR0z4NfcvpNgsJehdjDLJdqTv+v1AR1pc+WBMuTl2hzfCbJ2ZhApvP2uEiXHvaBOWcg==
X-Received: by 2002:a0d:f404:0:b0:5e8:545:e0cf with SMTP id
 d4-20020a0df404000000b005e80545e0cfmr323230ywf.100.1703102732120; 
 Wed, 20 Dec 2023 12:05:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a81a20d000000b005a7d46770f2sm186468ywg.83.2023.12.20.12.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 12:05:31 -0800 (PST)
Date: Wed, 20 Dec 2023 15:05:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 sean.anderson@seco.com, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
Message-ID: <20231220200529.GQ2513409@bill-the-cat>
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
 <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
 <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
 <CALeDE9Moypi85cM8H2z+7nxZPVvJzj5DWWej0Qvdebpdp1qR1A@mail.gmail.com>
 <CAPnjgZ0o7QENx3yFEx2SNpm0A7Li_qqvTeUmdDXNaCVuEA++Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tx4Y/jOn3D7N/FE6"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0o7QENx3yFEx2SNpm0A7Li_qqvTeUmdDXNaCVuEA++Jg@mail.gmail.com>
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


--tx4Y/jOn3D7N/FE6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:32:26AM -0700, Simon Glass wrote:
> Hi Peter,
>=20
> On Tue, 19 Dec 2023 at 13:40, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Mon, Dec 18, 2023 at 3:02=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 6 Dec 2023 at 04:36, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > [...]
> > > >
> > > > >
> > > > >>
> > > > >> >                 str =3D "Unknown";
> > > > >> >
> > > > >> >         for (;;) {
> > > > >> > @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbio=
s_ctx *ctx, const char *prop,
> > > > >> >                 const char *str;
> > > > >> >
> > > > >> >                 str =3D ofnode_read_string(ctx->node, prop);
> > > > >> > -               if (str)
> > > > >> > -                       return smbios_add_string(ctx, str);
> > > > >> > +               return smbios_add_string(ctx, str);
> > > > >> >         }
> > > > >> >
> > > > >> >         return 0;
> > > > >> > @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *curre=
nt, int handle,
> > > > >> >         t->vendor =3D smbios_add_string(ctx, "U-Boot");
> > > > >> >
> > > > >> >         t->bios_ver =3D smbios_add_prop(ctx, "version");
> > > > >> > -       if (!t->bios_ver)
> > > > >> > +       if (!strcmp(ctx->last_str, "Unknown"))
> > > > >>
> > > > >> That is really ugly...checking the ctx value looking for a side =
effect.
> > > > >>
> > > > >> Can you not have smbios_add_prop() continue to return NULL in th=
is case?
> > > > >
> > > > >
> > > > > Hmm I don't know, but I wonder why I am not just checking t->bios=
_ver for Unknown.
> > > > > I'll have a look and change it
> > > >
> > > > Ok, this can't be changed as easily.  smbios_add_prop() will not
> > > > return NULL in any case. It returns an integer. With the cleanup, it
> > > > will always writes 'Uknown' and not return 0 anymore.
> > > > I can add that default value you suggested but the ctx->last_str is
> > > > still used on the next line anyway.
> > >
> > > Would you mind if I tried to create a version of the patch which does
> > > the same thing but with less code, and perhaps a test? It might be
> > > easier to discuss it then. I can't claim to understand all the
> > > different code paths at this point.
> > >
> > > My main concern is that with so many code paths it will be hard even
> > > to refactor the code in the future, since it will become
> > > 'load-bearing' and anyone might turn up and say it breaks their board
> > > because different information is provided.
> >
> > I don't buy this argument at all, sorry.
>=20
> OK.
>=20
> >
> > > Overall, so long as the information isn't used for anything important
> > > in userspace, and we find a way to report SMBIOS to Linux without EFI,
> >
> > No, you can't tie random requirements to improving the SMBIOS support.
> > We *already* report SMBIOS to Linux, reporting SMBIOS to Linux without
> > EFI is changing things that will need different or extra standards,
> > that could take years.
> >
> > You are arbitrarily adding extra requirements just to suite yourself,
> > please STOP trying to hold things like this hostage.
>=20
> Isn't that what is happening with Linux and ffi? My understanding is
> that there is no way to pass SMBIOS to Linux without EFI. Is that
> correct? I know some people at their wit's end about that.
>=20
> You may know that I have tried for years to get bindings upstream to
> Linux....right now there is a reserved-memory binding which has been
> held up for longer than I can remember, because of EFI. How about a
> little give and take?

You aren't actually saying that since some patches are being held up by
"but what about EFI?" you're trying to hold this up as retaliation with
"but what about without EFI?". Right? And aside, I can point you at
other people that got fed up with trying to make ARM+(EFI+ACPI) work
because the feedback was "but what about DT?".

> > > it is OK to enable this feature (with a new Kconfig so it can be
> > > disabled). But there is already authoritative info in the DT, so this
> >
> > There is two types of information in DT, the smbios "entries" in DT
> > are not standardised in the dtschema and in most cases they're
> > unnecessarily replicating data ALREADY in DT which is being produced
> > automatically with these patches, making it zero effort for vendors to
> > produce.
> >
> > > transformation into SMBIOS really should just be used for user
> > > display, etc., not for anything which affects operation of the device.
> >
> > Well SMBIOS tables are used for a number of different things already
> > in the kernel.
> >
> > > Do you agree? If you do, how to ensure that? Perhaps a special string
> > > in the table like 'GENERATED'?
> >
> > Nope, I do not agree, at all.
>=20
> OK, well there it is.
>=20
> Anyway, as I said, I am happy for this to go in with a Kconfig
> controlling it (so it can be enabled/disabled). Then SoCs that don't
> want to go to the bother of adding authoritative info can just enable
> this Kconfig.
>=20
> I would very much like to see some signal that it is not
> authoritative. That should not be a big imposition.

Lets try a different track here. We've had 3 years now of the
u-boot,sysinfo-smbios binding now. And there's been 14 ARM platforms
that tried to fill it out. With Ilias' series, now there's a much larger
chance that someone will see values populated and want to update them,
rather than "Unknown" and assume there's no way to have them populated.

> For my own interest, I would like to understand what actually uses it
> as I suspect it is just for display. The two programs I managed to
> find both handle devicetree and don't need SMBIOS.

Please re-read the examples where people have already explained where
they're used, today.

--=20
Tom

--tx4Y/jOn3D7N/FE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDSQYACgkQFHw5/5Y0
tyz10wv+OwRGSwVb/hI4obaZApjJRgsKt1ajv0TOe89h49UTxjZtV1eRgPsCk+Km
sG/6HFKe1Uzi3k/HKfa64wfN0w/NhFJQy4Xwq1glSBNT8Pp3vDh1V+uFk+fDHrL/
FXqo0pCIt25fNMzfoN76cQApVFp8CeTGhHXer5lPxLP6eB72xFF713vjseCDqYLT
L12BCjsoWQ/hvtgSZw5swbkdel7QTrz4M01DcQef3hVn3Z/L8uxxwfnFuG6w/2xu
AKj3DNA5QRXJ21zWWqJ8sItm4IjK3ElEh0ikZ7RhmWBHxxxDMXw1cBrJPncqu0Yf
v1bPtbE4g319tW1LrkUOj8EppzNeWf/Uv10JyIy/KDe89tMGaTHasID1xUeLol/Z
PomUWZ7hn71xmrPdoqYx5ul4HIn8v4vqEs9NuvckS+q7flM/8DfLQh+xME5fX7L3
n1MOVR1IobtSyxdAeK/chH/dWzcfUkJm4wBzz2++0PU1FfouszNQC95sgCArh0LT
eEoGDPkD
=EhuH
-----END PGP SIGNATURE-----

--tx4Y/jOn3D7N/FE6--
