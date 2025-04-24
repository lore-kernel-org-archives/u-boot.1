Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390A3C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702B180194;
	Thu, 24 Apr 2025 20:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZvtrpVXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DD4803CC; Thu, 24 Apr 2025 20:49:29 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4648B80079
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3feaedb4d2cso946246b6e.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745520566; x=1746125366; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hsaorh4JQROF89AjQMh5SGxMXYF/jrfpgIHaj1rEvSk=;
 b=ZvtrpVXbu4qK0yhu/wCPZLEnsT5eIFRth+Mz5s8fiCut7dqieW6yD8/M/vihee4wrO
 mqPSdK6TElbGLvTwfqhE84d84q5NAaBefnMChw/8A+f+kPoVnM+4iG1KZQGwHwYL9MXv
 /Nepse5Zg7BE3BH/GSCNBruXr+0NXANyD0v88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745520566; x=1746125366;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsaorh4JQROF89AjQMh5SGxMXYF/jrfpgIHaj1rEvSk=;
 b=Gf7HbfUhoU57FdJ/Fnh9uROeYfXDPtRMNG7Sa3wOf2hmcY/ukBum3z+Y8Og/H+9WZ6
 PgcTMx9NoXdlzZAEOTAwNI5LvcUT9EvgmJfWIUGp07p1CbzSUoTfvYLn49iVufJyK6S5
 TmIk87RQqqMjwpPzzDBggQU3ZCsmdB7hATYt1jP4ZU0t76Q6mUD2WoxB0DFa01lUZJYx
 HpETtxTv5vNNAWNsxvylU0EIsU1vxAy/AOto3QDw5VGgiKfp4P0K6ZK4OUu1beZwwHEp
 gmh7lL+OhMZMW2T/cMv2Ya6Zn1/oWdbC7JylzN3wmTbGamWTiPW/4QXXcZve5rFOyclX
 Bxrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsHV4mOahsdggeHE6y9w6K14RosRcvwtoGtEAGZo4bDwJwlNHtCx7TrW4zIGF+kZvoTiDHqN4=@lists.denx.de
X-Gm-Message-State: AOJu0YyTLY0Y3l4bXps4yMIWR63ulPJZeB3axOzXkBV8GASEmk0Jb3EC
 w2yDD8QkMvmdJxrhIDmcts/w+CWztxZUqFiuKqg7olQgCLVvQZavdowEdOMz2Vo=
X-Gm-Gg: ASbGnctL/jwNewVLvaz27WqY+WLfzoKBVrWRxuHCOfOMLpN/hrbI3Fv/W2jLH5s0Xwg
 xzNulOMsTv7J+wct2rsKCCiiMd8Yzb0mKi6pGSVN6eqL84zq6OabgWJ4FDpHWwWhGNHTs4A9E4i
 tCUB2IPOVwk6VVuH7iu3/mhs+I0hJQK3uDF8kiB2BhYLkJjhBbpQQhm/lkLBKlF+vmgLP5dcJ7b
 Ush3Z/bv72vF6rs1IHwUczGsZU/H/kbVLwtqhY/Fu06l11660FHobbPj692IoDZgde42nFDv/jA
 L8rpQtIwb3gTczZo1hLSjWPoWK+Zpwxgou7w08tkDswITfCQ8p8iaqYsQRjctnt5l5ogSVPBKat
 91g==
X-Google-Smtp-Source: AGHT+IHoxWfb9DH0jitZc4xREpCMzRSXDWQznraOeY/I+A64zYNszXZawOMxOyvTT2VUTQ95d5ZcRw==
X-Received: by 2002:a05:6808:3998:b0:401:e610:3c62 with SMTP id
 5614622812f47-401f11ae206mr387487b6e.19.1745520566009; 
 Thu, 24 Apr 2025 11:49:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401ec97174fsm359682b6e.33.2025.04.24.11.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:49:25 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:49:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250424184923.GM5495@bill-the-cat>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DnkkyieSKEY1RzEN"
Content-Disposition: inline
In-Reply-To: <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
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


--DnkkyieSKEY1RzEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> Hi Martin,
>=20
> On Thu, 24 Apr 2025 at 06:43, Martin Schwan <M.Schwan@phytec.de> wrote:
> >
> > Hi Simon,
> >
> > thanks for the review and sorry for my delayed reply.
> >
> > On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > > Hi Martin,
> > >
> > > On Wed, 29 Jan 2025 at 07:25, Martin Schwan <m.schwan@phytec.de>
> > > wrote:
> > > >
> > > > Add a bootmeth driver which supports booting A/B system with RAUC
> > > > as
> > > > their update client.
> > > >
> > > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > > ---
> > > >  boot/Kconfig         |  11 ++
> > > >  boot/Makefile        |   1 +
> > > >  boot/bootmeth_rauc.c | 408
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 420 insertions(+)
> > >
> > > This looks fine to me. Just some nits below.
> > >
>=20
> [..]
>=20
> > > > +
> > > > +       partitions =3D env_get("rauc_partitions");
> > > > +       if (!partitions)
> > > > +               return log_msg_ret("env", -ENOENT);
> > > > +       partitions_list =3D str_to_list(partitions);
> > > > +
> > > > +       slots =3D env_get("rauc_slots");
> > > > +       if (!slots)
> > > > +               return log_msg_ret("env", -ENOENT);
> > > > +       slots_list =3D str_to_list(slots);
> > > > +
> > > > +       boot_order =3D env_get("BOOT_ORDER");
> > >
> > > Environment variables should be in lower case.
> >
> > Unfortunately, we are bound to the naming RAUC uses for these
> > environment variables, which is upper case. See
> > https://rauc.readthedocs.io/en/latest/integration.html#set-up-u-boot-bo=
ot-script-for-rauc
>=20
> Can't you change it, since you are introducing new support here?
>=20
> If not, then you could perhaps set the env variables to lowercase when
> you find uppercase variables? I suppose that would require updating
> the client to do the same thing too?
>=20
> It would be very confusing for a user to have upper-case variables for
> some things.

Simon, this is an unreasonable request. This is how RAUC has been
working and deployed for years and years. It would be a nightmare trying
to handle migration of existing deployments for an aesthetic change.

--=20
Tom

--DnkkyieSKEY1RzEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKh68ACgkQFHw5/5Y0
tyxM9Qv/bLzXP4uW3JlcMB2MfHrSPbg8A6/TV4HbnaEkK1sOv2eKdeN451JKaj6T
/EUJ+zE4NTAa3yrpp6XfS8LZIq9l93sboSVe/x851Ly2Ry/K2OXomfis+S/LWu+B
tSVCOhq1MQk5pKUFWvK1rLhKZFxlLxxyBfIozioXzgwN6GVZz1R7V0swgienNvpn
+8UhHv1wuiKOC8ohhFa4FTMRQaY+aWtXysheeaNx8HIELRa8xSne8ilS66kSi6Ya
G4A35VDyUt6y/BdcA4rzl3Ssn/Owz+xLFWqscZtyNMo1xPPq8aJeIyicZBK1I2FE
dXlZx0qifIFUaXGNF65rED+L/JHu9qkL91Ql9cBH/y1zTddtW8lVXF/vghA6qyfj
3XYbAuwovp2jq5JdgA4LppUgYz5ePLu9mHg4VlaQ73PpPSctqwpMm5LdIJqFtxCb
Eyt/NgtozB991wELG1uGD2IY+YzPNUWb6KmeNajEHGajMLx5rA5fAgh2WFZb2UXp
IjHWpr/M
=dQFT
-----END PGP SIGNATURE-----

--DnkkyieSKEY1RzEN--
