Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A47AE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584F5800DF;
	Wed,  8 Jan 2025 18:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d8i28b61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6399F8036B; Wed,  8 Jan 2025 18:32:03 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483148006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467a8d2d7f1so137918981cf.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736357516; x=1736962316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t67ey+dlGgcr1vPFM8Ge/va+hwyhqcoWfo6MlSUaHGs=;
 b=d8i28b61fgAyamMGe2kNJRD7J5Pwnq6fpZO5HgvND0CfvodRlbTcaY+2qFUXR5NxmP
 3xPOapFVZ3BxCPPU41dpRLbjGLoGxJy82ibk95cP3KbGkYXPVkS0SlwsyoCceIlKc+Hr
 GAu2xeLCgfIXAB1g8VoouYB8w2q3YcvH9dyAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736357516; x=1736962316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t67ey+dlGgcr1vPFM8Ge/va+hwyhqcoWfo6MlSUaHGs=;
 b=N5111y6wbmt5+ZWowNafEaTIvt1gMy6kD7rQNvBrzZW1zrWCoUG8md3gHFxmxillHw
 Yr9WLsfc4N/1qnchnny9KMemZAkR+3eTwuw5CkQFgjSlj2q7cTSq6kZygzo1B90iyTOe
 LLIGsb7MNTyFyPNLEiCgIah8Clymgg3nnUDV5k+LpW+MQPf2ZFwp931qZkHL13C19D6m
 hhtVOm5hB1pL/NMzcT9UIyj7XdXRfNufLD7a/LSAXw/FG33U4Xg0fPIMFRgi19IIV5n0
 OaZ5Wj1yF0elyKOhxp64ia2TYnE+UHsFgsb8lU/yQCcellrYyHePA2wvqTu71mQYuv3a
 houg==
X-Gm-Message-State: AOJu0YzxqP+5htU9np9Ukw4vJ+UJyY8gmwU2VUnq+Y9a+TgBfWLEyRtU
 zAzonXggX5ps6E5lFYXYvqTsZi0+dUiOFSCqNKIjJnvCwL1mD4Xh0GM82zUeZQQ=
X-Gm-Gg: ASbGncu/fR0C5ozONyDjcYSrUhTFRSYDaZfhUBOCBI+tJa0vVlYBjYaOyASg6IM/IoO
 iRkp0uTFpbi3aTy67Jr17s1JKyj48dASWLvJ2g9Y3FcGVQoeCkeZDBMCVapZ6K6uPxVGcxu8iwa
 Ta/hDEhlrSnlss2m7aM34g9jKoledEbzAFEjGBZRk0yEWjdVPyuYSqw3U4gqX2b/jQdUSbW2/O+
 9X/tvfdF5nmhiJHYDlVa3XUZuRW23HEAkOZab9seI+S2XZVD/jFNz4=
X-Google-Smtp-Source: AGHT+IF3lIqgEKPhcHCezyXs7yhKFZe4Thm4qRzuWBWhjMf7cUuuv9XbhjqGA/1Rub/2Nm7AZEb0Kw==
X-Received: by 2002:a05:6214:3111:b0:6d4:2910:7f13 with SMTP id
 6a1803df08f44-6df9b286032mr58742536d6.32.1736357516116; 
 Wed, 08 Jan 2025 09:31:56 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181a7c1fsm195623996d6.72.2025.01.08.09.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 09:31:55 -0800 (PST)
Date: Wed, 8 Jan 2025 11:31:51 -0600
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
Message-ID: <20250108173151.GL3476@bill-the-cat>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
 <20241220145609.GD1505244@bill-the-cat>
 <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
 <20241220172348.GJ1505244@bill-the-cat>
 <CAFLszTjMWU7f_Db+qp6hFecx=mv+54ojX+zSZcrV-2CxT5dcxw@mail.gmail.com>
 <20241220204840.GM1505244@bill-the-cat>
 <CAFLszThNrYMZtiPRewdvY-ip6XmHKdLFbQ5OHZLTsULpiJZKsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZfSA+qa0kr09bc6E"
Content-Disposition: inline
In-Reply-To: <CAFLszThNrYMZtiPRewdvY-ip6XmHKdLFbQ5OHZLTsULpiJZKsw@mail.gmail.com>
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


--ZfSA+qa0kr09bc6E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2025 at 10:04:07AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Dec 2024 at 13:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 20, 2024 at 10:37:34AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 20 Dec 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 20, 2024 at 10:18:17AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 20 Dec 2024 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > The current localboot implementation assumes that a 'localcmd'
> > > > > > > environment variable is provided, with the instructions to fo=
llow. This
> > > > > > > may not be included, so provide a fallback in that case.
> > > > > > >
> > > > > > > Add a test image and test as well.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > This is a pretty niche feature, I had to dig around a bit to se=
e how
> > > > > > it's specified elsewhere (not really) and how it's used. And I =
think
> > > > > > that based on how it's used, making up a bootcmd when localcmd =
is
> > > > > > undefined is the wrong approach. It's the hook for "run what I =
defined
> > > > > > in the environment", so if not set erroring back out seems appr=
opriate.
> > > > >
> > > > > Yes, but unfortunately it seems to be used and we should support =
it.
> > > > > The problem with scripts is that we don't know the boot device, e=
tc,
> > > > > so it needs to be integrated into PXE. I did consider putting
> > > > > something in bootstd, but we only find out that it is requesting a
> > > > > localboot when actually running the extlinux bootmeth, so this is=
 what
> > > > > I came up with.
> > > > >
> > > > > It will be interesting to see if any other cases come up.
> > > >
> > > > It would be helpful at this point I think if you can point to how t=
he
> > > > code for handling this case (the LOCALBOOT keyword followed by an
> > > > integer) in other projects so that we can be compliant with what's
> > > > expected, even if it's poorly documented.
> > >
> > > Yes, it seems very hard to find anything at all.
> > >
> > > The implementation in syslinux uses the BIOS to jump to a boot sector:
> > >
> > > https://repo.or.cz/syslinux.git/blob/HEAD:/core/bios/localboot.c
> > >
> > > I'm really not sure how it is supposed to work with a filesystem.
> > >
> > > [1] is a usage of it for rpi
> >
> > Yes, I did some searching on extlinux.conf and localboot and got a few
> > hits on people using localcmd for when they need to run their own
> > special thing, for various reasons, for example:
> > https://stackoverflow.com/questions/54258960/applying-fdt-overlay-with-=
u-boot-using-extlinux-conf
> >
> > > But other than that, even Gemini doesn't seems to have much idea.
> >
> > I'm only half surprised it didn't make something up for it.
>=20
> I've been quite amazed at its capabilities recently. I can mostly get
> good answers to quite complex questions and it is very fast now. I'm
> just waiting for when I can start using it for development.

Oh no, please no. We don't have a policy yet, but no "AI" created code,
please.

> I wonder who maintains the extlinux stuff. Do you have any idea? It
> would be nice to move it into a git tree and generate the spec from
> there.

I would say the syslinux project should be the authority unless they say
otherwise.

--=20
Tom

--ZfSA+qa0kr09bc6E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+toAACgkQFHw5/5Y0
tyz+dAwAjw7VepKlp5Gd33kmb8pU0wty/AtcRggXmYVnJd60mPGk9ja7NLimPAZE
skYgnnAriNQzLdRbwt5TlZWNuzcsWzc9RWX9ENGNt1WcIG8vKMEOyJPO4z/PEQXV
VEu4L2vMJjnWv2QC6hk214k8Z5gNS8XKNUhOANxkzPK7wyltEw/2Yz1rEaicsIcF
gdBOBKT6Er/7Hs/IlzamUA9+hbLPIDAnkwKNx8Fb6P4wA/dT3a5wxGCbWy81tMzU
T3TVI5Axompsgoe9kuF8OXWjXPqPBCILS/IoqGdKx0QO+ScpZHKUqlwzYyfoq5P2
OI6nKf1OYSWMDhlW4dQxssPZe3OT+fum2lD5XNfTG+FLPklacYstNhp1U10n9bUY
7a+f87j/lIftgY5eco+FNZyXQNwrj4w6CnsllZBwc6A9tngNBLC+Sl5ppGlIJXu9
B89XKFg7yFUBs1bIr5NwT3cp7jSu99RfZy1XCAHdAeQeczlaRMR8Q9IVKW7slA4Q
o6JutiTs
=Dkm6
-----END PGP SIGNATURE-----

--ZfSA+qa0kr09bc6E--
