Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F65C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A58807B1;
	Mon, 10 Feb 2025 15:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fpXYZ0t4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D49F80AE1; Mon, 10 Feb 2025 15:43:18 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12748043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f4434b5305so35477307b3.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739198594; x=1739803394; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z9borzkLTvwcFK04ot604sIEKZyHYf0QC903t49w0/c=;
 b=fpXYZ0t4UmGmvQhGxphEgOKRBl5X6NyIvLkyMwFH2WzGyDR5WbdWzstcesPFjhaUvT
 etlGlkLqSFy8xePFN8bZRO7YOqZiBogG3OjYlshM0ZGlcfuqiiwI4lSaj80fbaZSpE3m
 EmJhRFkbm5dHOf8Hf8Y00zO9+FAkZEBBNTGCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739198594; x=1739803394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9borzkLTvwcFK04ot604sIEKZyHYf0QC903t49w0/c=;
 b=PO3kQjDPFLh1t9xiG7AllEPrzV1XwfauTSLoAAGPb8OlluYHutv9SznDytWXBIhhWE
 8c3A40haNg/sjeliu3X4T5JIVDtOwvmEe4GjdGH4KtcPPPi/PJ/ZuSfFXl4TKoWATMrZ
 8er3/7FKdQnHxEbBpqmaU6wAUv9jg5dizAiFYNn3yBhEN4yP+dqhYqQhN3zeKZSsk8sA
 YBlkfVV5tEM+J2JeJRZD/aeuozh02C6OfWLbmob6H1cK7+5Duul/4O4HN/Cm5mlXTCte
 Zl1N7UQJ9Dc0BYroT5yY9tKt6bL1AJHM82WDUxjnobHLnnRG7G/kCdJTiNjSiM+ox4k6
 UitA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0L7nHC90L2SnUhhEX59MMuHi8CVWd+b8qvGjOEl/B4gmTYqWibCHcy7B6ZuIFnKvfL8Rj6VA=@lists.denx.de
X-Gm-Message-State: AOJu0YwvGVC+n4hipA0AeX0kDKiwTRpaTDy8oK5FtSW/a9siSFgyOXeu
 0q/F+/MMDicCb4WU+jpptFXXDRgd3k3Msl+t3uST1PU7phOcldV30ZNo7GydtHM=
X-Gm-Gg: ASbGncuFdDsRj06PkmpB7KkjlayJXa2tOys55dDooIKU4ZZickctrmbU6HPJIEK3yQ0
 7USFziankzwZHtCzaHazCcz2kVauL/OvrDJrryR4loHG32A9Fv2CTIVYphW8X3fQXB4XJEus0xQ
 LqWLRyKXxXQWT2fsTHqyia13/yfPMBFIF9GD47nQHnCObh4e3nXCpVi3AAeOAyb3l5IbHcYSYPR
 vcXMJ2ximyv34YOB4g9W+Yo1ZnRwZoEJ+Bi/UUTwz1oSFX1W2hRB9q02D6wHkn0RULetoiGtnOl
 gG+G7XaFMiJcp3o=
X-Google-Smtp-Source: AGHT+IGqzwSP7OFRTCURIJbST6j0a3I52i59KAYFtl7DVrLQHxwOV+qVlHSoyD9w94f5C9hh1MZrIw==
X-Received: by 2002:a05:690c:7301:b0:6f9:b189:3cc7 with SMTP id
 00721157ae682-6f9b2850dc8mr128409857b3.18.1739198594556; 
 Mon, 10 Feb 2025 06:43:14 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a86csm16683127b3.72.2025.02.10.06.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:43:13 -0800 (PST)
Date: Mon, 10 Feb 2025 08:43:11 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Anurag Dutta <a-dutta@ti.com>, afd@ti.com, u-boot@lists.denx.de,
 a-chavda@ti.com, nm@ti.com
Subject: Re: [PATCH 0/2] Remove "saveenv" functionality from am57xx evms
Message-ID: <20250210144311.GE1233568@bill-the-cat>
References: <20250208043938.52832-1-a-dutta@ti.com>
 <20250209172049.GP1233568@bill-the-cat>
 <79dd46c0-c084-48e4-8b7f-79892389ea6e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YRvxt3RryxZGxN9Y"
Content-Disposition: inline
In-Reply-To: <79dd46c0-c084-48e4-8b7f-79892389ea6e@ti.com>
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


--YRvxt3RryxZGxN9Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 09:55:22AM +0530, Kumar, Udit wrote:
> Hi Tom
>=20
> On 2/9/2025 10:50 PM, Tom Rini wrote:
> > On Sat, Feb 08, 2025 at 10:09:36AM +0530, Anurag Dutta wrote:
> >=20
> > > Previously saved environment introduce discrepancies and may lead to
> > > incompatibilities without default settings. This series removes the s=
aved
> > > environment functionality on am57xx evms so that the default configur=
ation
> > > is always loaded
> > >=20
> > > Test result: https://gist.github.com/anuragdutta731/b253ddb0a5538ab65=
88a3535d7bbecf7
> > >=20
> > > Anurag Dutta (2):
> > >    configs: am57xx_hs: Remove saved environments
> > >    configs: am57xx: Remove saved environments
> > >=20
> > >   configs/am57xx_evm_defconfig    | 4 +---
> > >   configs/am57xx_hs_evm_defconfig | 4 +---
> > >   2 files changed, 2 insertions(+), 6 deletions(-)
> > I'm not sure what this is intended to solve. A persistent environment
> > can be reset to the defaults with "env default -f -a" and telling users
> > to do this when needed when upgrading is a long standing practice.
>=20
> There are few inconsistencies in development flow with saved env.
>=20
> There we revert already for k3 platforms.=A0 Please see
>=20
> https://github.com/u-boot/u-boot/commit/a5e8678e0a32f85ad012aea7641e9534a=
da5c0fe

I did miss that one at the time, yeah. I do think this is the wrong
direction because custom designs tend to copy the ref platform and
making each of them pick the right long term likely to not be
overwritten location seems like more work than reminding developers to
run "env default -f -a" when modifying the environment, or even just
locally switching to ENV_IS_NOWHERE. I'm not nak'ing it but I would
encourage everyone to re-think all of the use cases here and make sure
that yes, really, this is the best option.

--=20
Tom

--YRvxt3RryxZGxN9Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqEH8ACgkQFHw5/5Y0
tywUEQv+IIeR9qFK2+9DHlzjxZ4NysQ6B/XQpWRESddZ9KGbCoq7/3aHzJ6cXeQy
7lXLwFVLUlUQpYzaxbl1KsT7JYzYcA9R6a7exPrP9/gpb13T/Zy4+W44Luqp9eg9
IyqQTySDz+0SfoPhqfHNRXIfxNOgNFaAXByR9kVa382LlYOnz18H9CQKq6En+E/w
UK8US9qn0dNU8B6DmHILubAobSh6LSnT26AfKnmSvYz/Y9/wZ2L+QzQgP7dsL0dH
yNYolYQ2BbYSfdqV4aqDpWJjwvqGEAMTF6p0APuGaPJhKoycXk2vOJeBhxEJBcCC
dRMkgcOTLY9isJrLI1R07c6+QlEWK+ylTSyqtsSU2EnanJOIVvP7QsQKJcqo8smF
MhmJUw0MmDiXRaBchXYO8MUJ6AL4sduxsWENBT1tmspn1oaR9Ydd/vnuAnKF4kqe
zTGOF276wCIoexM2FuHJaoA4TzhH5pG4DACRKEytfcob5j3jNMoKV7tiHjH/7J6S
SZlzN1fQ
=gs4i
-----END PGP SIGNATURE-----

--YRvxt3RryxZGxN9Y--
