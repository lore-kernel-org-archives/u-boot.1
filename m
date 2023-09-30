Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47958E77377
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 15:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CA587067;
	Sat, 30 Sep 2023 17:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GFZgO8AV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6A48706C; Sat, 30 Sep 2023 17:48:35 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DFB87064
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 17:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59bf1dde73fso189230847b3.3
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696088911; x=1696693711; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0dnNvJO05r3aA5xKupP3pv+7jNQY3kIk5xhHmMdqev0=;
 b=GFZgO8AVM3CBMpheJi4Oj2ibcla//uSDpkY2FbJdRZ0nEVhoHucaYG9u29rYq0UtNM
 DXqm9CGUzjykkkKAnNxa+GTGCYBWwQvdIpzwm2JnaWS+HvJH56NwFH3kPsaMShovhaqw
 i16VWrzQDbJnmLWciKNj1N+iEyuzV5zgwtFd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696088911; x=1696693711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dnNvJO05r3aA5xKupP3pv+7jNQY3kIk5xhHmMdqev0=;
 b=vAzr2w3dEgleCQeEoPkAoewKj5MJFHbOj9uaoI4lI+Vu+OJNVGirK88KU93Ogc1gNP
 gZkQ/BEE/qaCYOU5KVADqlRgahvoSp81d8LmiDC40Vf8F0FxcvCYIfbrqzGuhWPYgXDL
 C3SBg1Twz+bNMMATuHMzm75515vTUzUwnMtE82wzQoKNXvx00JuW3PHyiTRP20tf6xI8
 KQaS2zG8oxHJaREAVbQr3CMCgrr2HIFtDl9XmEnt8zejeMa8AtbNTxmkuJAoSoszkyp7
 IpTRv9WRz8+2caFPXkE86G0uBfTvHwKCMdVstFUwnvX2iWvU2s+Bi3iV+xQfqmYkRBKc
 PKug==
X-Gm-Message-State: AOJu0YzUoHaL2dtpfnb7u10DuHvKs7v3j4cUezI20gluz0k1/MLubOmG
 +BmZmVgLo3+txFk1FXFP05aQPw==
X-Google-Smtp-Source: AGHT+IHJFZSHZANUJi/e7R1og62kN4KjkTw6YY6/P/5tzgtDAmlga0ltF9oNgU6t5YP7Tibl+KpyCg==
X-Received: by 2002:a0d:ef43:0:b0:595:be7:a38 with SMTP id
 y64-20020a0def43000000b005950be70a38mr7027519ywe.49.1696088911447; 
 Sat, 30 Sep 2023 08:48:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-018d-5d59-64ed-f6e8.res6.spectrum.com.
 [2603:6081:7b00:6400:18d:5d59:64ed:f6e8])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a0dd402000000b005a442e68a48sm111045ywd.29.2023.09.30.08.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 08:48:30 -0700 (PDT)
Date: Sat, 30 Sep 2023 11:48:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: "u-bootlists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Re: github dependabot alert on py / pytest
Message-ID: <20230930154829.GR305624@bill-the-cat>
References: <trinity-bf8ba9b5-b264-497a-b0b2-6af0ff5c1a7f-1696079610910@3c-app-gmx-bs36>
 <20230930144405.GQ305624@bill-the-cat>
 <trinity-ce745599-ef46-4436-8705-96569cf217d7-1696087906150@3c-app-gmx-bs36>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p3Vv8cApnwwyHhqL"
Content-Disposition: inline
In-Reply-To: <trinity-ce745599-ef46-4436-8705-96569cf217d7-1696087906150@3c-app-gmx-bs36>
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


--p3Vv8cApnwwyHhqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 05:31:46PM +0200, Frank Wunderlich wrote:
>=20
> > Gesendet: Samstag, 30. September 2023 um 16:44 Uhr
> > Von: "Tom Rini" <trini@konsulko.com>
> > An: "Frank Wunderlich" <frank-w@public-files.de>
> > Cc: "u-bootlists.denx.de" <u-boot@lists.denx.de>
> > Betreff: Re: github dependabot alert on py / pytest
> >
> > On Sat, Sep 30, 2023 at 03:13:30PM +0200, Frank Wunderlich wrote:
> > > Hi,
> > >
> > > dependabot reports a high security issue
> > >
> > > https://github.com/frank-w/u-boot/security/dependabot/1
> > >
> > > it seems it is not yet fixed in master and next as there py is still =
in and pytest=3D=3D6.2.5
> > >
> > > I have not yet seen any topics for this...are you aware of this? I kn=
ow tests are run in
> > > isolated environment through gitlab-pipeline, but maybe this can have=
 still a risk.
> >
> > The dependabot requests aren't public.  But I don't see one myself when
> > pushing to GitHub, can you please elaborate on what it's saying we
> > should have updated?
>=20
> it says py-package is affected till 1.11.0 and pytest after 7.2.0 does no=
t have requirement for it...
> so dropping py package and upgrade pytest to at least 7.2.0 should be the=
 right fix
>=20
> i guess you do not use subversion (so basicly no security issue), but may=
be we can fix this by upgrading
> pytest to avoid the alerts in future
>=20
> full report:
>=20
> ReDoS in py library when used with subversion #1
>=20
>=20
> Package: py (pip)
> Affected versions: <=3D 1.11.0
> Patched version: None
>=20
> The py library through 1.11.0 for Python allows remote attackers to condu=
ct a ReDoS (Regular expression Denial of Service) attack via a Subversion r=
epository with crafted info data, because the InfoSvnCommand argument is mi=
shandled.
>=20
> The particular codepath in question is the regular expression at py._path=
=2Esvnurl.InfoSvnCommand.lspattern and is only relevant when dealing with s=
ubversion (svn) projects. Notably the codepath is not used in the popular p=
ytest project. The developers of the pytest package have released version 7=
=2E2.0 which removes their dependency on py. Users of pytest seeing alerts =
relating to this advisory may update to version 7.2.0 of pytest to resolve =
this issue. See https://github.com/pytest-dev/py/issues/287#issuecomment-12=
90407715 (comment) for additional context.
>=20
> Severity
> High
> 7.5 / 10
> CVSS base metrics
> Attack vector
> Network
> Attack complexity
> Low
> Privileges required
> None
> User interaction
> None
> Scope
> Unchanged
> Confidentiality
> None
> Integrity
> None
> Availability
> High
> CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H
> Tags
> Direct dependency
> Weaknesses
> Weakness CWE-1333
> CVE ID
> CVE-2022-42969

Yeah, that's not super important to us and I really wish I knew why it
shows up for you, but not for me on my fork at github.  It would be good
in general to unpin and update our python packages (and re-pin them to
new versions) but that often also requires updating tests a little or
similar, so it's not been a high priority.

--=20
Tom

--p3Vv8cApnwwyHhqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUYQ0cACgkQFHw5/5Y0
tyzoagv9HAB/Lr3g7R8XeMGWiaOTnBRIhSh5z21R3iaShGfWrPyz1q+i+EpjUQtt
z8J/Xbd4LhGn0CbtGAjZOpRFSI9tYJbH73GIRkuYy1j3yCI6VXPkYjqBQ4LbiwDW
O0kwluMa3nmzb55BwE3fj2xBvQNkSrwFREW/PsWd8iHpVzO2L+ESIUinX6pEEiev
yR8ss+Y/yG5j9Z7u5izt1Pw6pUILxO02dpAYb1lSD38abwmNsQbW5DMwxfqVBUbw
zp6+MhlFUs5TRq6r1sxo0sTsHCEFFQJcIxV/pMVD0A13f3wgwbmJVf47CxWsSPQF
Dl4q+FinVtrNMAw2mYMHFBfL0tUFOG4DOdc6cP+ZIhtq1VpWRWglmFjhFd11n5Ba
3ZtLAoQRjovWKhhaIovQVJXweJqcdKH5gwmM3WytBoTGYuxV2YC7nDBVnGqLe0Wu
PbuI+cYciscplcIThW0oCUqQqBuFINhV+C+VT+DalVUk+dYKuhslR8NhujjmMFfp
eH2x3PA/
=GQfW
-----END PGP SIGNATURE-----

--p3Vv8cApnwwyHhqL--
