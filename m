Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9C5C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 21:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC22E87517;
	Sat,  9 Dec 2023 22:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eFQF3jVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E569B86F67; Sat,  9 Dec 2023 22:21:15 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F5A8760C
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 22:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5d3644ca426so30251877b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 13:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702156872; x=1702761672; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dWYEzt/JC2Z8AthVY0z4aaE5tJR8wjrC4ZyUvou7s0Y=;
 b=eFQF3jVNZgtl+zMzelbSVJgFoNWenrCzWDEPFqFQS4dKhtzT81k2en8/j4eeRPYxbT
 tlVKloPXIxULpvu7cP9VoUr5fw3ZCg0yicEZ/PXa9h2mzdjUqT00YOvpd8w/CjjyfvbU
 8Rc2wPtepJUuKPyqxEGfTFUX4vsgbZd/GAMa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702156872; x=1702761672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWYEzt/JC2Z8AthVY0z4aaE5tJR8wjrC4ZyUvou7s0Y=;
 b=Rh59a604KwNfmN3CggAzVFhLIHv/11vrHtvj2DsePtZ/kbJhzrwzAZc0CkyMRpCFi7
 2LKpE5B/+PAEKQcVzi8zuuy2Ic531WUtjuDHzp0pfM2fc+h7oEm421S/mi9UPW33Bfi/
 fkb61jEp4Tva4fBRGsWwqn8BUzDh5Zyqp/8R+iNOXxsw9CvyxuHC55NuEmeI1+ArlByu
 xnXX2miffqCBpwjgKD1a/GT5wvYPciXKLPuCXUhaInM5+HN66ry0L+AWkA9ZyOT8RVmb
 5glMIbrcEBeL8VKTO8SuqpZPg7kQVBKlja19TL/GlW0KM2l7aEnFtiwHBi5CB4ajse3f
 CfAg==
X-Gm-Message-State: AOJu0Yw0BXDcSi5bK0TJAlR11CmrBGXITslNr4v894cPI/huHqydMZZj
 vMbSPpJejQ1+6EF2DUYmm9E4dw==
X-Google-Smtp-Source: AGHT+IErZtQqDmM3eqB131gFAASHR5BvDLNCxkjRmpgmNhAKDT0YaM0iahqMyPU7IVacjVvDFqjbKg==
X-Received: by 2002:a81:4a84:0:b0:5d7:cfe5:a476 with SMTP id
 x126-20020a814a84000000b005d7cfe5a476mr1586418ywa.74.1702156871723; 
 Sat, 09 Dec 2023 13:21:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 b125-20020a0dc083000000b005d8ef6a1b0fsm1732152ywd.0.2023.12.09.13.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 13:21:11 -0800 (PST)
Date: Sat, 9 Dec 2023 16:21:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Bob McChesney <bob@electricworry.net>,
 Stephen Graf <stephen.graf@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: Add support for zBIT ZB25VQ128
Message-ID: <20231209212109.GL2513409@bill-the-cat>
References: <20231204005954.13201-1-andre.przywara@arm.com>
 <20231204005954.13201-2-andre.przywara@arm.com>
 <20231206162443.7f0692d7@donnerap.manchester.arm.com>
 <20231209203423.GF2513409@bill-the-cat>
 <3c6b3fe41f54a2d2a391d433684e80d9@manjaro.org>
 <20231209204336.GG2513409@bill-the-cat>
 <5f898df3e85bb46df5e3dbaa81525047@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PhclFjmZha0vVzIe"
Content-Disposition: inline
In-Reply-To: <5f898df3e85bb46df5e3dbaa81525047@manjaro.org>
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


--PhclFjmZha0vVzIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 10:02:09PM +0100, Dragan Simic wrote:
> On 2023-12-09 21:43, Tom Rini wrote:
> > On Sat, Dec 09, 2023 at 09:37:28PM +0100, Dragan Simic wrote:
> > > On 2023-12-09 21:34, Tom Rini wrote:
> > > > On Wed, Dec 06, 2023 at 04:24:43PM +0000, Andre Przywara wrote:
> > > > > On Mon,  4 Dec 2023 00:59:52 +0000
> > > > > Andre Przywara <andre.przywara@arm.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > > Add support for the zBIT ZB25VQ128 (128M-bit) SPI NOR flash mem=
ory chip,
> > > > > > as used on the Xunlong Orange Pi Zero 3 board.
> > > > >
> > > > > does anyone have any objections against this patch? I wanted to t=
ake
> > > > > this
> > > > > via the sunxi tree, as this blocks some board support patches.
> > > > >
> > > > > IIUC Linux gave up on adding rather generic entries up for each a=
nd
> > > > > every
> > > > > SPI NOR chip, if there is nothing special about them:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D773bbe1044
> > > > > Should we follow suit here?
> > > >
> > > > And we could then start trimming the table we do have as well, to
> > > > reclaim space?
> > >=20
> > > In general, yes, but we'd also need to consume a bit more space with
> > > the
> > > additional auto-detection logic.
> >=20
> > Maybe part one of the series is backport that logic, part two is remove
> > all the easy to remove tables? Or at least a number of them so the
> > series is a wash and then a targeted series of drop-an-entry and cc the
> > person that added it so they can run-time verify it's still fine?
>=20
> Sounds like a plan to me and I'm willing to work on that.  Though, I think
> we'll inevitably end up with increasing the resulting image sizes a bit, =
but
> that might be an acceptable trade-off for making supporting more SPI chips
> and more new boards much easier in the future.

Yeah, this is where we need to go overall long term if nothing else.

--=20
Tom

--PhclFjmZha0vVzIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV02jsACgkQFHw5/5Y0
tyw3Mwv/ecYW0OWuokbkW8/K58T7E8bbI/aWUEdOK9lW3CfWQPKzaQaSJCHsGqy6
EFXoLOWHQvf9G65o7rebB9hzJ7sUEHAKT4JvdhRbSqH3yv78/JkWdFxs0fEcK9j7
wAmJxLagyQT2RgDzyLsUuAzzTJ83cw+XCwrx6Jmd0ilCtMd++chs7lBkAAYUwxh0
O3ym4E+C1AUovD4pdtvRWr8Wde3zSt9AveOnIpiOztfX8tPtNVs+fYPGtsh5wvTW
8XbvGj8yMAtRKKjFlEdPmS/KbJKfoEgCkMgD76tZHV/0eoMf/cX+kf971/zVJzEx
1WzSmDHxXt7pMTQoRAGCtnWSyeLdPDYOHcVMxU4r1ITVJlqlxi/L9h3syYui+GI3
8ww3pK0CMZuKaNBka40BypClZsYh5bliIu1SaWGSya8EvqpsG0ArzKFy3qqATLgH
8ipQ3lG/Elgcsi46XBIJA5m2sCYlXb8G6y92qtg0E48zaF0CdB5AW8riSSA49yDX
kWQ8IcOE
=lDq2
-----END PGP SIGNATURE-----

--PhclFjmZha0vVzIe--
