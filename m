Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B629CD0427
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 00:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9361B83D9F;
	Tue,  6 Jan 2026 01:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c3MuFvnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1220083E21; Tue,  6 Jan 2026 01:33:54 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E56C83A7A
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 01:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4510974a8cdso297062b6e.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767659630; x=1768264430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o6AqG3VInewt4CW3df07X+Wl7qS6J/Kpm7/xtBP86u8=;
 b=c3MuFvnKy3E//kpEej2xZszbBnl/1mcCjbjOoi+1ND6/yuLNbYh+TvJ9RuemRY2MDr
 gFA//5QiuTLeHbbp/cUKUgRCeNrhq3ILsCUdQ6fItOFq3Quw75O4P1KKK0iP+F4KeSPQ
 zoHMGzdA9wryIYsgIYpUXnC1USpPvN98B8tWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767659630; x=1768264430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6AqG3VInewt4CW3df07X+Wl7qS6J/Kpm7/xtBP86u8=;
 b=FYidWXaSPMiJp9T9z+m/Qb/cWBU6efOUQguNObI5AUgm/UUgEvjHtDj/UBa+X3NPmg
 bYlqosGye4fYTMUHEOXXO4CYvC8hoDjfBigMos2fx9dulb0czhZ5ghHEzrQCPhvY3fKq
 51HyHIDgc/xiGbFe5hlSkvNbHQnA/rLt2glSx0jguXpb4VQRPgD0DTcWM4aWII7HaAjQ
 4ZiZW7aJmyzekrOw4ksVNTrNFx+Z8h2zoOozLutQ+vl7RkzAcolEsLzLAqg12oFdfOE8
 rgvH+/ayhDN9IcGoAl4SUYwHo6akowcaM5yvl9BjMaCR0OoUiikXxt/BAotEypB3ec1B
 18YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH64uaAEJ504zfWbPfzrKsGRQehiTUJqyWRb8d4Zld1yz9dze3dSQVd1uRh4qf78Wz0OKEg/o=@lists.denx.de
X-Gm-Message-State: AOJu0Yzj5vtJ7nzHDeHY39jgNGJ8q4hug92BQ7HgRXCTxiB+ZiBotlpD
 I3cuY0egEjk6HA1g75IftykDFSR5afkuArXNyD8GylWY368FbQG9T57++SBpeoSha0Q=
X-Gm-Gg: AY/fxX7PPCI8i2ZonAl9JQ3OAEnN1J9w7cl6fxY3I0hwHbaWnWCR/yrNgaS/u8zlRYC
 5ypP+Mw3kutKEAnAqdKQU7/aDhBimcwst7sj5fEAdsmSW+8Qrl1aS/oSAPvoAlcpHm0SQDrFLae
 Vi85X9WDj7F1L/f3Q3yItpan0SZEKY8hvPbE57SpnFbxBcb4oqywsZVA2+PwOIuD7cRaSDu5DGP
 jUMHxTiK+bsWzA5CdxYerbX1ba6nSJ7eBxMJymqo89O1AH1DssMHMUGKeW34H9lXE8yyEtBoka8
 6MjmD7lAqViTsu8QFbW1pogCryXrTKcMaPcQgR5dwRFqyd1h4hjwMl4FTJ+3c19sxLFAaWAHDvF
 qDyQY/YAtyejiBpXWicT3NvLMmNxgTn5jnSjmDSSfNGnrF/wPQkdEKxbPeoJRUt7nBOMw7XZt2b
 t/rHutIHFjoGb1xoESGf3EaW5wlvexqcnwL4/YLPWpnr1mjWvnuIAtaFFd/ykogZssj+w3fKFV9
 +8s/tvAHlEHjrCgtzSw1w0GOTzf5InWpWFek8I=
X-Google-Smtp-Source: AGHT+IGT0+auM23D9DWL8EIUS6AsrC42wRa40ZlqQh5r6PB33C19JdYK9kVhOvRVlAh3Pp05EJXTGA==
X-Received: by 2002:a05:6808:2013:b0:450:b9b0:11bc with SMTP id
 5614622812f47-45a5b124936mr776768b6e.32.1767659630152; 
 Mon, 05 Jan 2026 16:33:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e2e903dsm238632b6e.20.2026.01.05.16.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 16:33:49 -0800 (PST)
Date: Mon, 5 Jan 2026 18:33:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, mark.kettenis@xs4all.nl
Cc: Eddie Kovsky <ekovsky@redhat.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
Message-ID: <20260106003347.GC3416603@bill-the-cat>
References: <20251027195834.71109-1-ekovsky@redhat.com>
 <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de>
 <aSCsgniomRMN0u1m@daedalus> <87fr9h5swg.fsf@kernel.org>
 <aUmB_fvpK1macga7@daedalus> <87zf6sflkr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/U2DyuRRVzPigdF0"
Content-Disposition: inline
In-Reply-To: <87zf6sflkr.fsf@kernel.org>
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


--/U2DyuRRVzPigdF0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 10:36:04AM +0100, Mattijs Korpershoek wrote:
> On Mon, Dec 22, 2025 at 10:38, Eddie Kovsky <ekovsky@redhat.com> wrote:
>=20
> > On 12/11/25, Mattijs Korpershoek wrote:
> >> Hi Eddie,
> >>=20
> >> Thank you for working on this. It would be really nice if we could bui=
ld
> >> U-Boot on more recent Linux distros without bridge packages such as
> >> openssl-devel-engine.
> >>=20
> >>=20
> >> I also don't linke this double negative.
> >> As you already shared, Linux solved this via:
> >>=20
> >> #if OPENSSL_VERSION_MAJOR >=3D 3
> >>=20
> >> Why can't we have something similar?
> >> See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D558bdc45dfb2669e1741384a0c80be9c82fa052c
> >>=20
> >
> > Hi Mattijs
> >
> > Yes, we could also implement it this way with the extra USE_PKCS11_XXX
> > symbol. Jan's original patch I based my work on does something similar,
> > and I perhaps oversimplified it.
>=20
> In my experience, when porting things from the Linux kernel into U-Boot,
> we try to keep the code as similar as possible. This helps reducing
> maintainance burden.
>=20
> Sometimes, we can't do that. In that case, we should explain why.
>=20
> Do we have a strong reason for *not* reusing OPENSSL_VERSION_MAJOR with
> USE_PKCS11_XXX ?
>=20
> [...]
>=20
> >> >>=20
> >> >
> >> > It's not the prettiest code. But I'm trying to be very conservative
> >> > in making these changes so that no one's workflow is disrupted.
> >> > Developers should be able to build U-Boot with the latest OpenSSL
> >> > without impacting developers who are in environments utilizing the
> >> > Engine API. The goal here is to preserve feature parity between the =
two
> >> > APIs. Adding support for custom Providers is outside the scope of th=
is
> >> > change, but could certainly be added later.
> >>=20
> >> I'd be in favor to drop CONFIG_OPENSSL_NO_DEPRECATED all together and
> >> just use "#if OPENSSL_VERSION_MAJOR >=3D 3".
> >>=20
> >> Tom, or anyone else, is there a particular` reason for gating this in a
> >> Kconfig ?
> >>=20
> >> The oldest Ubuntu version that seems supported (22.04) already has
> >> OpenSSL version 3:
> >>=20
> >> $ podman run -it /bin/bash ubuntu:22.04
> >> root@6dc347676b8a:~# apt update && apt install -y openssl
> >> root@6dc347676b8a:~# openssl version
> >> OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
> >>=20
> >
> > I assumed that we would want this to be an explicit config option, but
> > logically there is no reason that it has to be. I'd be happy to spin up
> > a v3 if there's agreement that the Kconfig isn't needed.
>=20
> Tom, do you have an opinion on this? It seems you are listed as
> maintainer for this (THE REST).

Yes, sorry, I think part of the question here is how it plays out with
LibreSSL and other alternatives to openssl, which ends up being a Mark
question.

--=20
Tom

--/U2DyuRRVzPigdF0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVxYZgAKCRAr4qD1Cr/k
Cq+TAP0TmEjq81tjtyik3alsF4QYI3c/ugoJbeK8Bm2kqD+aYgD9HBEKPl3tg+Lw
l7PK3uCqP0ee/33wBuFNcbNut/x8yg0=
=mFx5
-----END PGP SIGNATURE-----

--/U2DyuRRVzPigdF0--
