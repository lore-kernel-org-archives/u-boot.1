Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45ACC19F4F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 16:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47730883D9;
	Fri, 26 Apr 2024 18:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m/YyjcQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B4B88505; Fri, 26 Apr 2024 18:01:06 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C54884FD
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 18:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69943ef42b2so14697186d6.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714147261; x=1714752061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cIuv3e9AYWVQv234kbcb/d1IM/LM+FJSV/HHHsZsnE8=;
 b=m/YyjcQeXKdnOMq7UKDlClGzSPa7vncGyjVgneoIGlLOOiW2rSblxp18kNO54Xxe3u
 i6jmubCT2rMYIEmwjFORA0PQfzKg9OSGT01gMQ1JBan87m70RGQA8h9PBk7F+6GeJB4j
 ximOXaqmwPioyIgKCMmBQAlVtfYD7SMZu+M4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714147261; x=1714752061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIuv3e9AYWVQv234kbcb/d1IM/LM+FJSV/HHHsZsnE8=;
 b=R7km6l/b6SNj58N1WzJZK903llIPQ+lRXi6Kn6JGEzlfB4XMp6OugbvbTh+bQUWDTE
 n6wJkFluNFNuit7JjwEgPq59YvOrriXlD8iJMKw68vjVtNspFfM7cFLURW9r02sCggQ4
 yfQZjZTXPe88MK+Uh+w4cPOF8MBl9wBUfZpOhlRd+fk0h+d/WJidTEqGeO8nzmikvrFl
 3GDfO/uuxrirMFFum+lV0sEHq8pdl3y74Qdwq7Oaj/L4VQffE1oTvRtqo2TCf++F67sS
 cbUhGuJHbUF+OhyHpUORsKs2rkOmDIOY2YibyBCU68ntTYzOFm77sa68K7FE2yhNieRA
 ZtKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUxfT4Eer4xsXi8bRXDTOAf5mJEh9+lQ20XKxQAlkxt7+uslVzysjDbZP5VT39h4qQheRsVLvQzYyQj+ouREVliGOurQ==
X-Gm-Message-State: AOJu0YwUVAEfiu3Y8Qy+MInQA5t1ryz05XJVlw1JCMs7J5qzvDW+26oQ
 fLFr8rmRLzPrfV1oKiQPkNgOOXo/at1mxapdQsWH423LrzJJWrEEWzGeahQfbe8=
X-Google-Smtp-Source: AGHT+IFylg4TXGt30AJk+9qcLqBfStSttrc84Tx3FpCjsTRyEgaCwknSwizd8TiIQ/zDQZADEqIJ5A==
X-Received: by 2002:a05:6214:1107:b0:6a0:aa2d:eac1 with SMTP id
 e7-20020a056214110700b006a0aa2deac1mr2562076qvs.52.1714147260484; 
 Fri, 26 Apr 2024 09:01:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a0ce152000000b0069b4d64ab0bsm7987389qvl.138.2024.04.26.09.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 09:00:59 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:00:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: Re: [PATCH 2/2] imx: hab: Use nxp_imx8mcst etype for i.MX8M
 flash.bin signing
Message-ID: <20240426160055.GN1054907@bill-the-cat>
References: <20240425230721.497441-1-marex@denx.de>
 <20240425230721.497441-2-marex@denx.de>
 <CAJ+vNU34Zrn8znALzZqsDnkWifhVbz3D4D_hyNurKzH0cn30Lw@mail.gmail.com>
 <20240426155113.GH1054907@bill-the-cat>
 <CAJ+vNU3QHGxwLsYbNouV0x9G0qLnufDSHEUC5OLzT-zxE7dCiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rh1WcsG4+NT7Ht/s"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3QHGxwLsYbNouV0x9G0qLnufDSHEUC5OLzT-zxE7dCiQ@mail.gmail.com>
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


--Rh1WcsG4+NT7Ht/s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 08:56:29AM -0700, Tim Harvey wrote:
> On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Apr 26, 2024 at 08:30:23AM -0700, Tim Harvey wrote:
> > > On Thu, Apr 25, 2024 at 4:07=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> > > >
> > > > Update documentation and use nxp_imx8mcst binman etype for signing
> > > > of flash.bin instead of previous horrible shell scripting.
> > >
> > > Hi Marek,
> > >
> > > To be completely fair we are just replacing a shell script and
> > > template file with a python script
> > > (tools/binman/etype/nxp_imx8mcst.py) which also creates the template
> > > file.
> > >
> > > I could care less about shell vs python but do put huge value in the
> > > idea of making signing easier and doing so without modification of
> > > U-Boot code. The current implementation requires a couple of things to
> > > be enabled in defconfig which can be done with a seperate
> > > 'out-of-tree' defconfig but this new proposed implementation requires
> > > changing a u-boot.dtsi which is a tracked file.
> >
> > A counter-point is that with using binman for signing we start
> > eliminating differences between different semiconductors on how to get
> > something signed.
>=20
> Hi Tom,
>=20
> I agree... I'm a huge fan of binman. I just don't want to replace
> current constructs that use env and/or config items on a clean code
> directory with replacements that require code diffs to do the same.
>=20
> I'm simply wanting to wrap binman sections with Kconfig items. Is
> there a way to use environment variables within binman sections (ie to
> wrap sections or override filenames)?

I'm honestly not sure if everyone is happy just yet with how integration
and support for production use cases of signing features is integrated
with binman just yet.

--=20
Tom

--Rh1WcsG4+NT7Ht/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYrz7cACgkQFHw5/5Y0
tyzMsQv9FwZaXLtkhgL15kQ+mmhfR3hi+E+7n712qgt3ZFhfuK268sA9Kmjdjwbc
l1sStZimafpCLUE9QDxyPKv34EbM53HSiBeXVAGJdyf7Mt5ER1f/I4W+kBIuQ4L1
YhF8m7Jz6Icq3cPin3BTPQbwRSeDqjKl/0Lmy1CzFAadATVs4Zls9LqY/l7Teimp
QE0qJn39PbABSyNr0JIlnRrCQIDNdt1VbLZdek5DdPktralgYBWw7xKoDfOYlKe4
aav1tUq3jd/T15VF/EP+YxO13dvsxJO9LFP04bTwSo7NLcM4EqULshK0zwqtL/ez
9/FrlrkdU0UX1neYHTo1x1IGFT//T5PySDl5jbN0fAjuo/z2pDlL4AmeFTtPg9mq
2q4tfX7OAyvSQOaYOqvntuxOUXbOXUR4fIIiuPUtPh5+Uy9giA1+X01CMo3g2lPY
cGL+vSY/KbRoa2V1XYlj9A2o18GnlADzUl+qkpz+DIbJyzdU7RbNFyiXIsqR20Rj
8DcrAOt+
=HFHN
-----END PGP SIGNATURE-----

--Rh1WcsG4+NT7Ht/s--
