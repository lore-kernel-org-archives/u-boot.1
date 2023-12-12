Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83AEC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 22:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADD68760D;
	Tue, 12 Dec 2023 23:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kUbrXP6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB9B876CC; Tue, 12 Dec 2023 23:53:55 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFB887495
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 23:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dbcae1e53bcso2092848276.3
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702421631; x=1703026431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DWHl0Pa5hZzgKqHT41pZhFvoeLP2Xmhmn0TG3gYy2Zc=;
 b=kUbrXP6bVGZQdSLFw5FEw2Pu+74VZFGVsyHGk5r5uXZ/j9p3KF2u/R6U5n8/kDruzG
 EIx8Dugz6GU+6pYJpV1/svC5Uo4sybCsmcZ9s9QppR1sMIf2JzgohQBrhGD3sZE3Y3b/
 spv3hvz3iveCDxCAEZH1hfO2GHvb6tU3H6iBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702421631; x=1703026431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWHl0Pa5hZzgKqHT41pZhFvoeLP2Xmhmn0TG3gYy2Zc=;
 b=maOC+6MME3E+Cum41DJOSH1UKUpEKGM4bkeB6b3gqGchVkGEX0y3TXvm7R5i8B4dN4
 5E8wEGYmca4SEdcOwmy8LjFXOKsYJCnCWYlzJJjftEFiHc4ppOaCP/UHwFwycIYUDX7V
 /19mdz0+w2uUmMxoKZ2vnjhL5EfuBI37ChQbDvTeFXhqsRc3mjvVOIOk3YEG74dK6za1
 eCBYYFaLjimhKfBykY2/+U/KkiDgiHssbU5S6lGHIaH4AdiN+jqA92bnhSN/frc4pHqQ
 Op2x2GVksB3jm1Xjo+OutX43ilCHDeNjfVGOq8H8EjtIXItBvR5slE33iGucamroMs3I
 Jg8w==
X-Gm-Message-State: AOJu0YwmQ0dxThBgPZdYjYz/zeA6osMajFxQ/JDtZFTQKLYvwHpBApWE
 YMm7r9Jgw5vFK/iE8gNlUe2iPw==
X-Google-Smtp-Source: AGHT+IE/aO/OW+KDtbAFPbDSs1OHwBdZA15iyJG4IrB3UJHmMIZh1RuNo3H58RXFRrYORSDKk5lbdA==
X-Received: by 2002:a05:6902:1a43:b0:db9:52de:b43f with SMTP id
 cy3-20020a0569021a4300b00db952deb43fmr5320493ybb.26.1702421631695; 
 Tue, 12 Dec 2023 14:53:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 p135-20020a25d88d000000b00dbccd3a2d02sm94427ybg.55.2023.12.12.14.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 14:53:51 -0800 (PST)
Date: Tue, 12 Dec 2023 17:53:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de
Subject: Re: Pull request: please pull u-boot-imx-20231212
Message-ID: <20231212225349.GD2513409@bill-the-cat>
References: <20231212162046.744484-1-festevam@gmail.com>
 <CAOMZO5A+4xuXeOP2ezgHAG8bgHj0mUFvskEEOXzntFt4y8YKrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NS3XX/+FFh3kSag/"
Content-Disposition: inline
In-Reply-To: <CAOMZO5A+4xuXeOP2ezgHAG8bgHj0mUFvskEEOXzntFt4y8YKrQ@mail.gmail.com>
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


--NS3XX/+FFh3kSag/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 01:44:14PM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Tue, Dec 12, 2023 at 1:20=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
>=20
> > From: Andrejs Cainikovs (1):
> >       apalis-imx8: add USBH_EN gpio hog
>=20
> This one did not apply cleanly, and I messed up the From: line (it
> contains a double From:)
>=20
> Could you please fix it while applying?

Yes, I fixed that up.

--=20
Tom

--NS3XX/+FFh3kSag/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV45H0ACgkQFHw5/5Y0
tyymvAv/cH1krTVakRAV8dRKjUJbfK7Lc79pS/p91NBEkON52v5hbFObYsh/iNzM
EyfSALZzUReszAz/DNVfI2mhTrhO2mVRvqPdnKIvaUgy4GYpkVi7GcVK4DQisvhV
+/nk7VTYDnYAZ7bjLMJ1xTAlxTUCIYOyfnHTJEzwpLszy0PsnUrZapc99RAjAx+7
DFJMMfh0vuZe752W/GHpBjy/X6lcHvI6No+TvDyB45sdu3XH62DUjQ2PZXTlP/ak
1GuXfUA7HF2SA59Ous3Xfrc4EmU93yckDCkbXoQrnWf0MaPUwC2SrlVtmrd4iMBx
Xzo7ePqwF/OILMhYR0Rnjh7qFsFVyPWNoziB2CtpHveGsZY2jw9tXWeU7DAHcp6b
tEVnvujKtDMB9DmC0MtEkp+kB1JYrXa0wYx7CxTV/NQ+/NxXuVJxl0efsOY25sPj
cmD5dkOxyDbbNhb3LG0XrKRzR1gb9XZ19zOWCLz9egt15V5OWlwu5z+ScIhWdTx2
jXlo6KTp
=VS4g
-----END PGP SIGNATURE-----

--NS3XX/+FFh3kSag/--
