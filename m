Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E107FC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFA982063;
	Fri, 25 Apr 2025 16:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RUh/STLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB128212B; Fri, 25 Apr 2025 16:37:59 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0125481F6B
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so657196a34.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745591876; x=1746196676; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FELKzPZGn8K3eNXJpehfb6uMdKef97+paosXsd0SpxU=;
 b=RUh/STLej4f+sGRS+6qYUUSMJhSE8nU9TZgCmL7xw/fEKb56n4jctB1OaoK+zrdxEs
 anrkYb5yYi3HPrC4fYeVLy92ybqxUPrDk+kkotHSiXoE6Lrh/+RXYJuK8rMWAnB3TVJO
 TzmDGkzd4sEMzcVXgO7m5b9uWsRovwv23VtLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745591876; x=1746196676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FELKzPZGn8K3eNXJpehfb6uMdKef97+paosXsd0SpxU=;
 b=PFAzaxCZiSIWvNhZvG4ZWAxT2Bpfmg+wokTWxw5nR5lqAj8UDH+YC+eYdPu3X5hBrM
 TIbtHdvvcOqEB5cANeTECsmGYz4SDeaOoV40cCkxzxiRX210i5kB09AAoyZai8DdjQ97
 qBf70wF+ayIh51Dc0TKCa4dH3pzarfHQ6q8P/1SUnTQh+vTrIpEf7WjqGkGOs/PuSTnI
 yNOaFRtlbbTvoBONbsAgAxR7ZNrqcVF/tTo7UJdc772NQTA3J6irSpA0/dWaJSFr9IHC
 z+7c+xyGNaugnsi4+JtwauSDHns8CNjGNvqYhUxEXWNVl4V4YSlTOUy+p++uVvNsk3Pa
 by/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCEujFE56a3xX5k04U6ISio0YRdEvRcgBcrYSmNjs+L6abNMix9RybQGaof0KocE/xtO30+8E=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0LT/9H++wwVPoe1QX6gKkocfTaMtCN6hs7T3Wrw8lm8i2UfQ5
 WkFXzKfDHZb58I96KLbw8vfpnOvQkPx1/M91SY48qLWQG7RNVlHlheWCrHcBoGs=
X-Gm-Gg: ASbGncvA3HDedL2GB4ZUykTQ8XAOpOU3twNh7mkzQlEKwbG/DWL3x2e0p62ByLKIPjT
 bG3s/NeLYzB+CHgwcAfrOYt0mbMsWYRmwVOrTYMgl6Q66fV0EPI6GIhXYh80AMB5ceuiq9SJHUE
 FT/odCkJacN1jJmylyxgNxJJncKISMHELn7hEjqxUOWMhD4P/IbBoTD0IBuVOGYygXT16cInbDW
 6DAmnpY3AV2Q41NR06ILI9O/4A3vbFGdwibUC9joZB7OBHYO+4DyrnDYk5fo8zM4W0hPQnYxMdV
 AZh0GRel+fUWGCt1M6N36aIdT51MfKqJpiAxSNs0gh8tc9LSQP4aSvvt33p8rHWe1GI4NELtABl
 fA3Cfb9DXBWHW
X-Google-Smtp-Source: AGHT+IGFjxLo6XUXRIz+PBg5xS8ib32g633e2ASDAy/gjiJ8DslcA1deKJ+yi8qnt0o24ZQW+jCW6w==
X-Received: by 2002:a05:6830:3919:b0:727:345d:3b72 with SMTP id
 46e09a7af769-7305c7c43b7mr1523562a34.16.1745591875530; 
 Fri, 25 Apr 2025 07:37:55 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f1a2bcdsm693719a34.19.2025.04.25.07.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 07:37:54 -0700 (PDT)
Date: Fri, 25 Apr 2025 08:37:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250425143752.GU5495@bill-the-cat>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
 <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JqjOt1Cst6pAJoWH"
Content-Disposition: inline
In-Reply-To: <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
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


--JqjOt1Cst6pAJoWH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 08:35:52AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> > > Hi Martin,
> > >
> > > On Thu, 24 Apr 2025 at 06:43, Martin Schwan <M.Schwan@phytec.de> wrot=
e:
> > > >
> > > > Hi Simon,
> > > >
> > > > thanks for the review and sorry for my delayed reply.
> > > >
> > > > On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > > > > Hi Martin,
> > > > >
> > > > > On Wed, 29 Jan 2025 at 07:25, Martin Schwan <m.schwan@phytec.de>
> > > > > wrote:
> > > > > >
> > > > > > Add a bootmeth driver which supports booting A/B system with RA=
UC
> > > > > > as
> > > > > > their update client.
> > > > > >
> > > > > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > > > > ---
> > > > > >  boot/Kconfig         |  11 ++
> > > > > >  boot/Makefile        |   1 +
> > > > > >  boot/bootmeth_rauc.c | 408
> > > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 420 insertions(+)
> > > > >
> > > > > This looks fine to me. Just some nits below.
> > > > >
> > >
> > > [..]
> > >
> > > > > > +
> > > > > > +       partitions =3D env_get("rauc_partitions");
> > > > > > +       if (!partitions)
> > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > +       partitions_list =3D str_to_list(partitions);
> > > > > > +
> > > > > > +       slots =3D env_get("rauc_slots");
> > > > > > +       if (!slots)
> > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > +       slots_list =3D str_to_list(slots);
> > > > > > +
> > > > > > +       boot_order =3D env_get("BOOT_ORDER");
> > > > >
> > > > > Environment variables should be in lower case.
> > > >
> > > > Unfortunately, we are bound to the naming RAUC uses for these
> > > > environment variables, which is upper case. See
> > > > https://rauc.readthedocs.io/en/latest/integration.html#set-up-u-boo=
t-boot-script-for-rauc
> > >
> > > Can't you change it, since you are introducing new support here?
> > >
> > > If not, then you could perhaps set the env variables to lowercase when
> > > you find uppercase variables? I suppose that would require updating
> > > the client to do the same thing too?
> > >
> > > It would be very confusing for a user to have upper-case variables for
> > > some things.
> >
> > Simon, this is an unreasonable request. This is how RAUC has been
> > working and deployed for years and years. It would be a nightmare trying
> > to handle migration of existing deployments for an aesthetic change.
>=20
> Yes, I figured. Perhaps it could support lower case in future? This is
> the first I have seen on RAUC in U-Boot, although I do see this file
> which has both lower and upper case:
>=20
> include/env/phytec/rauc.env

I don't think there's any need to complicate RAUC support here (nor
in the future Mender nor swupdate nor any other long standing OTA
mechanism that might be more easily integrated via bootstd than
environment patching).

--=20
Tom

--JqjOt1Cst6pAJoWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgLnjwACgkQFHw5/5Y0
tyxXRAwAkzXD9pZoK6//CDETwWBd6oQy745TqOeB3wagom/PvOF+kuNPQNmQw2qu
LapVjLpe75xXdXchL5jnO+gSwF2fNU8SjJbP7OmsqcogIUdYaxqdToKDvSTg5FAw
m5+jfgVYXHwDbQRCAynQ1zLXLbt1JRPynTB4NMsUUKMr0ly+W75qK/GRiQxohIlj
fHZ/gdqAVXWK/UYV8tLFMRYekF0vwe8TvoX/f+JrYOHCm3PrRXGqUZrVaFhLEjTY
PO2zKD0VLESikvlIJZalfwDRI1eoy6CK++PBxVWLcGVdNvg41Gdqs9sR3uit3AQY
C/5nuVlk7YRpoM/ZeiUeT7rxRJ/NZujwl6VVbMdJaifTj4gAEY+sJw1YifFkQjRQ
2mcQt5bzRDZ8w9q1Wfww8cKOzFypxgLnNABsfhp9BU+VvNY1lBqpcX06/kcwOz9c
+Ak1s4HFKuQW5loceX0VxqHQDV332AY6pa120pj5pSC21rLD+7uf+HwYXITaEroh
HiPDJryo
=TXbh
-----END PGP SIGNATURE-----

--JqjOt1Cst6pAJoWH--
