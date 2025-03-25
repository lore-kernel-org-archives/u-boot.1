Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A415DC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F428186D;
	Tue, 25 Mar 2025 15:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rCPJ1DEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2DD81951; Tue, 25 Mar 2025 15:51:40 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8338380EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3fa6c54cdb2so4891817b6e.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742914296; x=1743519096; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VuhZ+B5vEGVc97NBu7zSaBiKTGUL0lZOF25OHbANPk4=;
 b=rCPJ1DEfX1BbnUqRAt8EHQtvwRsqvzun8HvTobleI8pM2LaoZOafJVQHwIlchtDEJy
 FSbIUNmIEqz0nxc0x/ffaRD5HV9bl7TUa3HvQMxU13zSMzSk1/zJ8m5mEby3GdnEa4mG
 a+jpH+WSY8n7qONasqK7Zu3K4vRuAdkHwHV8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742914296; x=1743519096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuhZ+B5vEGVc97NBu7zSaBiKTGUL0lZOF25OHbANPk4=;
 b=dL1zvjWAwriHKpOxc9SQW3dzL3h14NjxFu5VGErVzidB9BvHUN0tpaJ91ezxiAdXAh
 ybMis0kQTtOFHMRYYQwaeio1nY2UJDM+EFmd5x+G81vFlP5avglNn+P+j/OGDM9EkzMu
 bC5+ca0tZC8HUzEqKDNwnvU25pm3wY1+h8ZwaJFP8a8sOwmkcpVMeZ7yXCs9AKVIEr/g
 MQzFKnF+Su9vNMAopEu3svWpdvEBBXBUzssu2b8k4Z8xaSxeSLPx/gQ/H7e22FQC8FY6
 E7NOSgXuNZKHAsFby/cz6t6QWYCz2S2Q7m7t9v5Qg6+Kiff/laF2/Rz73g+Jc9kcG2vN
 WiJw==
X-Gm-Message-State: AOJu0YxoTThqcR9BXKZ4TE6MgBaxPrzxRblq3rLRBkoP8CszPNzgS0sO
 3pyYOhGbRlCgQoWcUZyoADfFjtPN59m7sPqijUV7jViTLjY++Y00DhADWUrYh54=
X-Gm-Gg: ASbGnctA/q/+cGuk92kTw9mrEssoxqWiOP7/hMS2cVfraEQ8SzuWmBZELpsmGS2v3eY
 T5jwhLQapQaAFF0E2m9bcIGK1lTv3k5k3wcPHCuC9MJ4pD4A+Za6lmznykJy/F1GuRHVw4o2YXt
 c5vOXQXIPbbH8KX6JEwwUvb5FyyyDy0jw1mzlYxLCxkfqUDe+JcpHy4o7XoD0X7AVuFyNjhQ4pb
 5GWljdWmFJWZF/qnVTMtsiGRPYrH56BvHzL7Ae1To+cowLiwZpfs4XVxTZ6k9Fd/dEQhPJkz4xZ
 Vva4i0+CL7EzhZjWvE6mJiBqc8cho+U4DFvicwaQuek=
X-Google-Smtp-Source: AGHT+IF1Evtglh1RV9eBgGDzaWTTQTRxPqCnEVqVqteNt7dtHMhatahqKjmWkRNkNBnkfj+A6h7ToA==
X-Received: by 2002:a05:6808:7003:b0:3f7:d16c:e283 with SMTP id
 5614622812f47-3febf72361bmr11777844b6e.11.1742914296113; 
 Tue, 25 Mar 2025 07:51:36 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3febf6bd815sm1964613b6e.9.2025.03.25.07.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 07:51:35 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:51:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc5 released
Message-ID: <20250325145132.GG93000@bill-the-cat>
References: <20250325020130.GF93000@bill-the-cat> <87msd9o4f4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BYyz9I596DpDyBEt"
Content-Disposition: inline
In-Reply-To: <87msd9o4f4.fsf@baylibre.com>
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


--BYyz9I596DpDyBEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:17:19AM +0100, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> On lun., mars 24, 2025 at 20:01, Tom Rini <trini@konsulko.com> wrote:
>=20
> > Hey all,
> >
> > So it's release day and I have tagged and pushed things out. This will
> > be merged to -next shortly.
> >
> > One thing to note is that just today a bug was reported due to a missing
> > 'fallthrough;' line and in turn we need to fix that in a number of
> > places and ensure it doesn't return. This will happen between now and
> > the release as I think it's clear enough.
> >
> > While we have been having regular meetings after an -rc release, I have
> > assorted personal appointments this week and need to reschedule for next
> > week instead.
>=20
> The calendar invite on https://www.u-boot.org/ still has an event for
> today (25 march).
>=20
> To avoid any confusion, could you update to Tuesday 1st of April?

Ah right, thanks!

--=20
Tom

--BYyz9I596DpDyBEt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfiwvAACgkQFHw5/5Y0
tywCdAwAuWO73jTtlyM9ie7qo4UnrU7y6SlqC85GJz5F8zqhTCYCIo+JtLxq+bxD
G9BkTKOx+fdwB1SprYvfyhxY+yf0viV+yJ+YtXSXS8XEIgWvmTnf/HH2LlMDn9D9
yqvhthibwAi9ckalqA2RkTppFPmOefUBqElYVbbWAczegiI3wgAOClR1ioPgVVe7
M5/6iuugachgrxOkUGzXrwJ/c+9A13qZbqr6m2dPScWQ6GaUvf60HCLmnf7ewwcZ
/kOYu2JTOFeIKwiCffZdzw0ryfmUrAyaKVkD5pUB2vB4kUHtP+SnCKpPhPn45yh+
EH++P2J9Lk7WNRmozS8orSoo0BP9Le7g/7cvz+YOzagnIebEA7nyBYRixa2CE0Yk
78wVYvTiRS1dPeHbl0XYqIfd/yt379IUAQb91kD0tUZ+1IbPH2ujO+ieA4MuZCno
FXDxTIgVy43mu95odWUvGltg1NI11W/jU9n7doSUEaMcykbB31Vw7NgT/R6IvMgU
uYR1gpZ7
=OsJj
-----END PGP SIGNATURE-----

--BYyz9I596DpDyBEt--
