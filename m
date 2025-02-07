Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84C0C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA17980C6F;
	Fri,  7 Feb 2025 19:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T2Pjq0qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A968082A; Fri,  7 Feb 2025 19:33:39 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B195780821
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6e4487fce51so4294586d6.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738953215; x=1739558015; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HpOG8tKhOctaaN7kGOv7Zx46OwUDIQ54cHugrbTeFgU=;
 b=T2Pjq0qbaluKwo0mPlODpKDk139uxUe0ggktPBE+9lwkhk/xOk/k9S5sSEUY5iWvkg
 +4aDf9QiOqBdX3C/4EbAJKUFd6GhlFtt8DRqBZNoFZlr0R4ztJB/GbqJ9UVeF38C27qX
 6ngWMCRWM0b6CWQ0dxZ9kA1kfKAb2As8TRvxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953215; x=1739558015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpOG8tKhOctaaN7kGOv7Zx46OwUDIQ54cHugrbTeFgU=;
 b=eaBP+aGHey/rsaVnh6kX0mItkBN120vz/fXkEYecfA5u//J/yI+Qi2Rt5zGDCLPRpd
 Q0bWQQ57yh7yfZvwqQGGFGOWk0zfJpx5GMDP9fmSATvuzaM0YIZUwUiqXH9ZB6p8t9mb
 XlbbCGEEhkgIaD0HNBYYz5U7eIAJEOrsz6YJZi4kU2i0P7/5dP0BJ+n0m4J4dNAMwjrO
 TGsjVZbDOcCHT12zyk/1UM/lxos59w/HPJjNb7IkpLVmiG+XfJ5EXzE6ght7i519ruKs
 8J28BPXq5Knxsk3CmJZCpCwX/zLjWxtgxL6o8UbWVVTh77nE9hxuZRaF+XVasNWD8kIL
 RlRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQH2Zeiyhlm+fzHpq9HB1watQRxf97vh/OB7EyqDuurUGH/n/2qof6r+TEMmFHoXahAV6Fpc=@lists.denx.de
X-Gm-Message-State: AOJu0YwSX69Wuixh0asPD+gjascWrsQxCVai5cRTRLjfEt3J3LDyN6ZT
 Gv6+kSoLu/+cw1GdmGChC85s01bMVpAwneRkpivC7m65YB9T1o7jsTvATHh6Wqo=
X-Gm-Gg: ASbGncu1+JdfFmjMezg0RP+j8m9o7pIW43SVTxoUBBrXjqt5mVYgAZVLDKy6dVBvUqa
 wbGrvPzi8+0Yf3wp30nqRSr67Kr2QUN9H6LIUxzd7hi+Nkw1p+Vybenm4qj4DAf/Tcay4RNXu2I
 zBiDNZQl9KLEhkX9Amg+51szVBp+7m+yzDUJS2qLfTtLpaFqoT93FHxOEzkRFm4ooYcPD98kAUv
 TyL/m0kC75L0y8DXK8A1EiWn/l32m1sxxufIFrvxsI9JvTWtTbVXiCsI3CDeyUHdnAxSPp++IAo
 5dIH+73FW/14Xyo=
X-Google-Smtp-Source: AGHT+IHclzk/Dz5INDFl8+U4uMt6SchzCyOYe7DWLBVp1Vt/8nHZvgAJtWUjpXFsskamkzGWgG4KIw==
X-Received: by 2002:a05:6214:2125:b0:6d8:aba8:8380 with SMTP id
 6a1803df08f44-6e4456fcb6cmr58666606d6.42.1738953215209; 
 Fri, 07 Feb 2025 10:33:35 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e43bad5a7bsm19461736d6.119.2025.02.07.10.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:33:34 -0800 (PST)
Date: Fri, 7 Feb 2025 12:33:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
Message-ID: <20250207183331.GC1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
 <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
 <CAEfUkUKoN_xGZ+sGTsdExgVpA54TfYD924VVnu-eQqNVO5tbHA@mail.gmail.com>
 <CAFLszTgLR2RR+fFi6iY3X3=6bQgcyaQhEGDNmWfNubU_GCQUhA@mail.gmail.com>
 <CAEfUkUL1OQwL8h-NJcFW+++ff_6tWAEweNiKaSjJsa-U5yGfvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i/7OXnGNErmi3RCM"
Content-Disposition: inline
In-Reply-To: <CAEfUkUL1OQwL8h-NJcFW+++ff_6tWAEweNiKaSjJsa-U5yGfvA@mail.gmail.com>
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


--i/7OXnGNErmi3RCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 01:26:46PM -0500, Raymond Mao wrote:
> Hi Simon,
>=20
> On Fri, 7 Feb 2025 at 12:51, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Fri, 7 Feb 2025 at 08:10, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 6 Feb 2025 at 19:09, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Thu, 6 Feb 2025 at 15:35, Raymond Mao <raymond.mao@linaro.org> w=
rote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Raymond,
> > > > > >
> > > > > > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.or=
g> wrote:
> > > > > > >
> > > > > > > +CC Ilias,
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > > >
> > > > > > > > The logic of this has become too confusing.
> > > > > > > >
> > > > > > > > The primary issue with the patch is that U-Boot needs to se=
t up a
> > > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subs=
equent
> > > > > > > > phases can then use that bloblist.
> > > > > > > >
> > > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > > >
> > > > > > > > Reverting this commit seems like a better starting point fo=
r getting
> > > > > > > > things working for all use-cases.
> > > > > > > >
> > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c=
3.
> > > > > > > >
> > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV=
_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > >
> > > > > > > If my understanding is correct, you want to add some logic to=
 control
> > > > > > > when the U-Boot should or should not get the bloblist from the
> > > > > > > existing register argument.
> > > > > > > But xferlist_from_boot_arg() should be called when a valid re=
gister
> > > > > > > argument is there, I didn't see this in your patch.
> > > > > > > Maybe you plan to do this with other patch series, but simply
> > > > > > > reverting this results in a breaking of handoff policy and the
> > > > > > > firmware handoff won't work.
> > > > > >
> > > > > > Yes, I certainly did not want to revert it, but the current cod=
e is
> > > > > > too hard to understand and I did not look at it at the time it =
went
> > > > > > in. I've had three tries at working with what you have here, bu=
t each
> > > > > > turns to spaghetti.
> > > > > >
> > > > >
> > > > > Still not very clear on what concerns you have and what is the wa=
y you
> > > > > want to go.
> > > > > The logic is straight forward, when U-Boot has a previous loader =
and
> > > > > the registers pass in valid arguments - It indicates handoff shou=
ld be
> > > > > done using the transfer list.
> > > > > Other kconfig options decide whether to use the passed in address
> > > > > directly or copy to a predefined address.
> > > > > But in either way, xferlist_from_boot_arg() is doing the right th=
ing
> > > > > to get the transfer list from the register if it exists and is va=
lid.
> > > > > I don't see a reason for removing it.
> > > >
> > > > Here is the initial code:
> > > > >>>>
> > > > bool from_addr =3D fixed && !xpl_is_first_phase();
> > > > /*
> > > > * If U-Boot is in the first phase that an arch custom routine should
> > > > * install the bloblist passed from previous loader to this fixed
> > > > * address.
> > > > */
> > > > bool from_boot_arg =3D fixed && xpl_is_first_phase();
> > > >
> > > > if (xpl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLO=
BLIST))
> > > >    from_addr =3D false;
> > > > <<<<
> > > >
> > > > and by the way, that is my tree. In -next it is even worse:
> > > > >>>>
> > > > /*
> > > > * If U-Boot is not in the first phase, an existing bloblist must be
> > > > * at a fixed address.
> > > > */
> > > > bool from_addr =3D fixed && !xpl_is_first_phase();
> > > > /*
> > > > * If U-Boot is in the first phase that an arch custom routine should
> > > > * install the bloblist passed from previous loader to this fixed
> > > > * address.
> > > > */
> > > > bool from_boot_arg =3D fixed && xpl_is_first_phase();
> > > >
> > > > if (xpl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLO=
BLIST))
> > > > from_addr =3D false;
> > > > if (fixed)
> > > > addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > > >       CONFIG_BLOBLIST_ADDR);
> > > > size =3D CONFIG_BLOBLIST_SIZE;
> > > >
> > > > if (from_boot_arg)
> > > > ret =3D xferlist_from_boot_arg(addr, size);
> > > > else if (from_addr)
> > > > ret =3D bloblist_check(addr, size);
> > > > <<<<
> > > >
> > > > I want to update it so that TPL creates a bloblist and passes it
> > > > through the following phases, ending up at U-Boot.
> > > >
> > > > To my mind, if CONFIG_IS_ENABLED(BLOBLIST), then we should check the
> > > > registers and always accept standard passage. If not, we should
> > > > either:
> > > > - create a bloblist (if this *is* the first phase with
> > > > CONFIG_IS_ENABLED(BLOBLIST))
> > > > - use an existing bloblistl, which must exist (if not)
> > > >
> > >
> > > To my mind, first we should check whether there is a valid transfer
> > > list passed in, which is done by xferlist_from_boot_arg().
> > > If it does, and BLOBLIST is selected, then use the transfer list as b=
loblist.
> > > And we do need a new kconfig (e.g. FIRMWARE_HANDOFF_MANDATORY) to
> > > determine whether fw handoff is mandatory.
> > >
> > > See below pseudo code:
> > > ```
> > > if (!xferlist_from_boot_arg()) {
> > >     /* a valid transfer list exists */
> > >     if (!CONFIG_IS_ENABLED(BLOBLIST))
> > >         return ERROR;
> > >
> > >     /* use the transfer list as a bloblist */
> > >     [...]
> > > } else if (CONFIG_IS_ENABLED(FIRMWARE_HANDOFF_MANDATORY)) {
> > >     /* no valid transfer list passed in, but the arm spec is mandator=
y */
> > >     return ERROR;
> > > } else {
> > >     /* arm spec is not in use at all, create or use a static bloblist=
 */
> > >     [...]
> > > }
> > > ```
> > >
> >
> > Yes, that sounds good to me. Please go ahead.
>=20
> @Tom Rini @Ilias Apalodimas What's your idea? If all of you feel good
> I will post a patch for it.

I think it's a step in the right direction, thanks.

--=20
Tom

--i/7OXnGNErmi3RCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmemUfsACgkQFHw5/5Y0
tyyyNwv/YBOHr84ujMlUv9iR8Gx3jDsCJpFpzjCs7kpj1zKPlx0iJzRCaURQj20o
a4BtsdHx/R6kPrH38VdDdAIF1DgFp1CVcs9/IacXCKriSoPM4ixRHx0vXa4arOPv
Def3ynO7+vx/sdoG2XUu6VCBNF++COPqrpF1lhay4N7f6n2RPdydIapti55fVXT+
QytoqpWCj6pDILpuwXo9pHFjcQzbnd8SKZMVHfPUdIn81pZF5RmbaWL4qFwoOqE9
3ZyOLz80Y9QEuHySo/H2uCl3vGalyoJycmerrruHwkzvbjdfnLF25Ry8cZ9StcMC
FECxnIXANKrNIHlUWAb9kiHmWDjWlQaahOyEBMX7Eqt/v0yn9YMzXfIoRHH7RZmg
qb9n3wy2OHXs5RyFFQlG/vDgP5kvw8Lyyc4iaGoOgHVWslGylVQr6d72oMPChbBc
HoJjNBLHntochj3C286WhLB36FP3q6Qu/2EypnG2YtgsEXTzXtUTZ02LJUX4Qijg
ur4ftUQG
=43nS
-----END PGP SIGNATURE-----

--i/7OXnGNErmi3RCM--
