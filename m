Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C13E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9450980435;
	Fri, 20 Dec 2024 21:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UvDgIm5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968EC8048D; Fri, 20 Dec 2024 21:48:49 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088658042A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46772a0f8fbso20892261cf.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734727726; x=1735332526; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TZGatE3nu9CLbYBY2EjNzUH/x7YSHeMwLDeMx4JmCUg=;
 b=UvDgIm5/d2ifPZrn2G+nNxdL4KTVK/A78aNDSvVTpNzWZP8buRtmNcgREVNaHeq/di
 H9JEJq7p1QATuDaTtRRyS8otTG/V6SQgUFkplnCukNJSSL6lbJdyNlfFrvBkeMw+aNGa
 R3jcWn/sDnBlT32Sf8Fe/Kl4OsY6+MYcMhOYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734727726; x=1735332526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZGatE3nu9CLbYBY2EjNzUH/x7YSHeMwLDeMx4JmCUg=;
 b=usceFd2iPqNoep9rlfHSp8l/eGJRybpAOXWnOfaKAvgqX4v40u4js77JmrvEZgB50d
 pilqgLiz9VYItbPpV/y7GtWoU+cmH33SfDwfCbHgtmrNJ+T+avOo7bzJCI+WWpu+OlRP
 RbO4pVkS+rR6WYdIliBzULewiOVj/fx/ordMEiyAVag/T1g7NuR6zi/5IzwxzublPxY4
 L7brjgF4modVhW6UQ5guQTokX+VEHkOE3n78CtWwC9AKPJhwtGoPec5wadIfjDHZbbiS
 meLpFINdsQt2vSfVuZwqahP4TVmUOoxMEY6gcQJEBzNo73Yn/jk5EwKqC+wrsXVsK79T
 vckw==
X-Gm-Message-State: AOJu0YzPmpbb3KnZ44sAaifuT6G17pJmbSxBupatxhnSD0bKqqwK6fdo
 vbFBBMP76/b1WhVtpizAlhOL5xx+lJsZcT80Hlz9akvUlbAPdw6KOixLmxTbGw4=
X-Gm-Gg: ASbGncvozVCO9nuTcHd7EmlYBR4cGd39hxFafvVwAcPOom69LB4l3SsTMVHr8xOu4kz
 vCzpF8sSLYje53QDpzP0Y8IjaozAgbSVZNu/Squ1h4khLdyJ0dqCrh7LqFeaFWi8hO9u7/jBoof
 wA2qxe9YMHaeAab08i655xashkGSltkHNDDEQK74ttJbw4B5zkleMiZYXXZJ6A8jlkpCm3RgK8F
 a3ZCWcIlsnpNt0ZYJHQ8qJNWYFSlRHTvSyYQMWuPm+lM2PvtfR7vD50
X-Google-Smtp-Source: AGHT+IEzN3U6rvNp5f3BA8zJJN6VLYPnRs6xaBoMoFNpzDtuqKXePNto33D8gM0ZOOX4TKcnuPhA9g==
X-Received: by 2002:a05:622a:30f:b0:467:88fb:4298 with SMTP id
 d75a77b69052e-46a4a9bce09mr67424981cf.52.1734727725748; 
 Fri, 20 Dec 2024 12:48:45 -0800 (PST)
Received: from bill-the-cat ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb336a9sm20232771cf.80.2024.12.20.12.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 12:48:44 -0800 (PST)
Date: Fri, 20 Dec 2024 14:48:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 4/5] pxe_utils: Support a backup for localboot
Message-ID: <20241220204840.GM1505244@bill-the-cat>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
 <20241220145609.GD1505244@bill-the-cat>
 <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
 <20241220172348.GJ1505244@bill-the-cat>
 <CAFLszTjMWU7f_Db+qp6hFecx=mv+54ojX+zSZcrV-2CxT5dcxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oPn/2YJC2aQVB85m"
Content-Disposition: inline
In-Reply-To: <CAFLszTjMWU7f_Db+qp6hFecx=mv+54ojX+zSZcrV-2CxT5dcxw@mail.gmail.com>
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


--oPn/2YJC2aQVB85m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 10:37:34AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Dec 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 20, 2024 at 10:18:17AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 20 Dec 2024 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:
> > > >
> > > > > The current localboot implementation assumes that a 'localcmd'
> > > > > environment variable is provided, with the instructions to follow=
=2E This
> > > > > may not be included, so provide a fallback in that case.
> > > > >
> > > > > Add a test image and test as well.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > This is a pretty niche feature, I had to dig around a bit to see how
> > > > it's specified elsewhere (not really) and how it's used. And I think
> > > > that based on how it's used, making up a bootcmd when localcmd is
> > > > undefined is the wrong approach. It's the hook for "run what I defi=
ned
> > > > in the environment", so if not set erroring back out seems appropri=
ate.
> > >
> > > Yes, but unfortunately it seems to be used and we should support it.
> > > The problem with scripts is that we don't know the boot device, etc,
> > > so it needs to be integrated into PXE. I did consider putting
> > > something in bootstd, but we only find out that it is requesting a
> > > localboot when actually running the extlinux bootmeth, so this is what
> > > I came up with.
> > >
> > > It will be interesting to see if any other cases come up.
> >
> > It would be helpful at this point I think if you can point to how the
> > code for handling this case (the LOCALBOOT keyword followed by an
> > integer) in other projects so that we can be compliant with what's
> > expected, even if it's poorly documented.
>=20
> Yes, it seems very hard to find anything at all.
>=20
> The implementation in syslinux uses the BIOS to jump to a boot sector:
>=20
> https://repo.or.cz/syslinux.git/blob/HEAD:/core/bios/localboot.c
>=20
> I'm really not sure how it is supposed to work with a filesystem.
>=20
> [1] is a usage of it for rpi

Yes, I did some searching on extlinux.conf and localboot and got a few
hits on people using localcmd for when they need to run their own
special thing, for various reasons, for example:
https://stackoverflow.com/questions/54258960/applying-fdt-overlay-with-u-bo=
ot-using-extlinux-conf

> But other than that, even Gemini doesn't seems to have much idea.

I'm only half surprised it didn't make something up for it.

--=20
Tom

--oPn/2YJC2aQVB85m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdl2CgACgkQFHw5/5Y0
tyw2OgwAtVK3kHGG2a6E8IECXSMeaX7X2uVsnrbVEEIPDgTh/1sgETjcrTNeMdpQ
oD2e+LArEimkWK/bseW7LjV53pPB+FFarr59hQ09TwYrxiVl4dzaAxZvj4Bd8lXj
vumQ2eefoan2JPitgThDioiTDmv3/RwLcHidFDZmzEkRQQr9FVEpy1xlXn3Sn3m+
HSAGViSTRhlpEEVIawSwYmiK3CtfwInTW1mdjy5Wvqutn/7p0eEzRqCq9siglRn/
TYbseV8stWa4keFVWSCLorsAjLr3Wgk0GokohINFoF4Kns8rEW3mypDgCJWXsDQG
QPCI7zVGY4gmI9QTQxuc1UXrPeitGxCvUWKK/0Ncdn1too78btB2tc4rGhqp2n8E
Y35aQHd9SwJ9JUbEkKKSWuQ7JAHHPZRzo2q6JVoureGW62IsR8Z2R2BpEuqCopLu
EZ0SLTzhOaEHvIUPotHi3ktYdglFQmsrk/b2l+b5gLyDokK5E9NXRcnIb3Mf7cju
UbxjWkDg
=4nsH
-----END PGP SIGNATURE-----

--oPn/2YJC2aQVB85m--
