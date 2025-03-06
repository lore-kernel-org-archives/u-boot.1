Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C57C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32FDB80F9E;
	Thu,  6 Mar 2025 15:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aZNkZ082";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8ED81420; Thu,  6 Mar 2025 15:05:27 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6209580756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e60b75f87aaso526249276.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741269924; x=1741874724; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u7GXzucT9d+396kun5D45y3if84+qw3/gjbkugDucpE=;
 b=aZNkZ082yuZiD7eMYUcdB+zPIFxV38K0UvQrWa0agkIZJefAH5Wlhr5Mwxb37QZmE6
 fn8e6BQrGhPI2qjecH2/7E6LvH8T6YhZbW9yuOa0j9eYT/EOEK0c7zLz8PAfZ3G5rlrg
 +trA5S6CrEhO1FpaqSGJI3veQQ6NU2y7OxPPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269924; x=1741874724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7GXzucT9d+396kun5D45y3if84+qw3/gjbkugDucpE=;
 b=qGp8kB4EgT9dFZZCySgysS0OjwfaAbfOyAxih2zUNmWOruidIKzm/YRMv8423ifBaO
 5CkpDkDQERK6DBhYkGxKlPdELpdyXP9DAoNM1pxDuGNvMIbUy5fvyV4zq3vSA8KbkS2i
 7y1HybdQWKEL01ULDByDBFszMerQy9Dvhr+S5NBx3ml4PyJseM44uoq1PH1fFci19EtA
 soldAL8IqkQ+oOca2Nf/+x5fLk+f65elbbNcjlNgF+6KyhDQId/rc7RoLjvERxYzi5Rf
 2m8li+wgmsyGUOTSwgBOFaRndIxK66AksSsx+A3jESm0OrSivRgdD8cnTR+zusqnHprP
 vadA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOaA4llIiII8vZfmD1CKXjI7An0Wc7GuEwFLfwI7ydI+/UyX4yx13ARNVviLfspUy03c6slOs=@lists.denx.de
X-Gm-Message-State: AOJu0YwCN14nY0Pmr2yWLB5O6SiKh0Wjhx4YI4S+9JS18P/9pR8gGimW
 nvVXJ4o2wu2qiPV5BQPG4eu4wU3nnq0CMwdaQu+370kCpz+jxMflnYlzlSET8lY=
X-Gm-Gg: ASbGncvTdf7i2A0deKdFOslXzhRyogy1Pmlz1B2OgIXoy8S3PMoJSGDtYxVeFIhwR93
 qWV2BXceWYygYzS8P957b+7eOU6uG0qGUWoFXXwX8OzLAf3sBXJVNqWq5HeS2dAnYXzqsuFuXuz
 R6rSxLv5eqOa/vADigMQK3EILfEF1xhcv4W5ouFa4AygQovXkX/OzJfrFuvcbcpvhkvyxBtIMlh
 3ZSjMP10GEZYyNjFrHP6Qd8J+0FpSTh23dHqExCrN0PKkalzjIWfwIf2WbqqzPYSIGG8eDM8cQ0
 XTDstTXi/w7TiL8yPdjHBlkT3ys2DtlDMlFHj/z3jdgCTA==
X-Google-Smtp-Source: AGHT+IHhVqgrV2cRxfZRif/WH8X0roTQ+jDehbszXOcxTJ4+Dwgx7CL9LHJdlYOz6R6l9TROplT+Ow==
X-Received: by 2002:a05:6902:2881:b0:e59:dbac:d993 with SMTP id
 3f1490d57ef6-e611e1b7f6dmr9315629276.17.1741269924145; 
 Thu, 06 Mar 2025 06:05:24 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b8e8fa5sm324509276.44.2025.03.06.06.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:05:23 -0800 (PST)
Date: Thu, 6 Mar 2025 08:05:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
Message-ID: <20250306140520.GY2640854@bill-the-cat>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAOMZO5BTCir859QDcR9XEDTnc4JnMHdCSLXTe94Z9z_FY5bwbg@mail.gmail.com>
 <20250305181703.GW2640854@bill-the-cat>
 <CAOMZO5D_WeB+iv3YzVeBbfL3o1Wr250aM3+phGe7i9Luus9uzQ@mail.gmail.com>
 <87pliutj96.fsf@bootlin.com>
 <CAOMZO5CGm4zsdR26weQY9_8yztPvjvSdUs-MUPokbCgkYzDrHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HKSTucmcR5yC/p3B"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CGm4zsdR26weQY9_8yztPvjvSdUs-MUPokbCgkYzDrHg@mail.gmail.com>
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


--HKSTucmcR5yC/p3B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 10:00:11AM -0300, Fabio Estevam wrote:
> Hi Miquel,
>=20
> On Thu, Mar 6, 2025 at 9:51=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
>=20
> > Why not just waiting for someone to tackle this issue with the CI? The
> > handoff test is failing, there is nothing that can go through any tree
> > at the moment, no? It is not just blocking this series in particular, I
> > guess?
>=20
> Without your series, the sandbox_spl test.py passes:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1050165

Yes, but it's not a problem with Miquel's (or Svyatoslav's) code. It's
just that the code there is tickling some underlying issue.

--=20
Tom

--HKSTucmcR5yC/p3B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJq6AACgkQFHw5/5Y0
tyxuBwwArSlXdtOwR/khneVuZx6p4m0kCUdjYeinj7Zdc5NcmMgAtGbB0b1sAZQs
ai0elPI2KBa5eD7u7ykLSrEiQHR0vUcZw8ufkm+AGbADe6628u2XFJGFruQDt13d
TlxCTasyqSVGJ0p/zbkVDWzuU7+e7g5xF6gqUfBXaUYPn+1blwZBP7KKgh1h3U9K
FmgyaEy+wvwVqUyTHMGkd+glYuix8AfC1+U7bgDnjk8RdFllD3QGBP97+azLvDxK
sPSs4ipwDIUFbyT8lU5kUEFPTWMhCS1YzRAyFdXwxmglYUFYY7PkQJb1yR/qNqm5
lBmiDmO3aQMZzjJntdrAsv0iG5Pcg9SkZRdCRaugGkuQB9v54rHt+7l2sATEjBpK
eLU+DUqOToPn/9jqo23g3dnP3NnFZ5TFw1b77MxLeCV/K163OxFlB0jk+Xt3eeFY
solr79VYMyQKiDlt30Zx++rf6K0kODSLQ+MP7d96h5Qghy7FYLIsqB8FhmuDTZnf
XAdkYl50
=eeKZ
-----END PGP SIGNATURE-----

--HKSTucmcR5yC/p3B--
