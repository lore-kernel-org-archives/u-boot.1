Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9323C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E48C81E6C;
	Wed,  2 Apr 2025 21:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NHJS+PHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A4481F0B; Wed,  2 Apr 2025 21:57:03 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3148035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2b2b6019a74so60708fac.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743623820; x=1744228620; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jSGhemrpR8ENtgFLqW4RaZ/KwCNLY809qU1NZ7T3ilY=;
 b=NHJS+PHVSzMPZohY7IteGGwN2vX2jjmabBek6/hRuKc5YSPibGc4bDle+UGn6VbeRH
 CkKULprAMbUlqqSV3C+1A7let/0/TA9sBK6ZX256dgA3+4VeRKGj6Dl0O5cRdI9VTLrH
 So0tqBTz0mbuM27fLEUVecUgs4bxuaavqp00E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743623820; x=1744228620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSGhemrpR8ENtgFLqW4RaZ/KwCNLY809qU1NZ7T3ilY=;
 b=X9NyjTLJrS2+lo0ye1G2pFyGEaM7+W4dPskEYGrRkZQGJg2eol5BirHBO1BNiKgc5p
 WeeSSM4GR83I6kStlE3GCyWRKzddwgs9Y9ZnJQvyA33eLolQyhmJHcCKdYOFbxTe/L5w
 EanptNT2jbwYsNjsSEPo9KNDSMb92Lc92eXc6nqJMdvcOo8GfrlXKWxRW7PqyawEjh8V
 KtV2u/KfWirkU2T2ROUySyo4xr3y/LPOOrWd2xfj1ORUJcZKfNpPQijGv83M2tRH7OPf
 7hapQKP0vsDpK1rxgaZZ1tfzU0FQJoQou7ZA4txD17lLrDlHQ99yyPuQ+EtUVO0mmhRX
 pUJQ==
X-Gm-Message-State: AOJu0Ywi9ORw+YqnbM/DPok4JD++MpovxWMDvuozzA9nAnm5L5nsOG6g
 CzJg+cxi+/F/sOnEQdvEcBCZUhxQWjsllZM0dwrYVEwbLa+9dGowlrRb8Zq3hLk=
X-Gm-Gg: ASbGncvYLRrFRriH3ZccDMbo20/AqdBbG3UcWCfZTjCbbAvVjUgvR/ZNh2RcMnR3JMY
 hSKB0D84/i9/zCF90n4rK0wfex7WRHCHHb+rBVTLgI3LDGeDGhFpXXrTexmQ+tLCCNwjxQ1iHeI
 d/rX4+/Ta30g3DWhJTMGYCStF4M44gbZOv/jlX55tYJ14stRdg0SNbznFBd9LhiRRbDn4SZHzNG
 45dnJFmvMMzOxu/qd/FVBJ8FAbVeG6+zsejnj5UlMOr2YLQDcLLiWvZRy/GFG+Dsh9HNx7THfd8
 ecBple0QdoEhFTSu03MF1VSRH1s/G4CYcRVYXinyklnnLi4aLT0vd7JVR33sIMzo5oF/dIyDmsn
 IANjJEw==
X-Google-Smtp-Source: AGHT+IF2zva7e5PjdSfU/idD6GjpBvouwd7/u3ZGD3aUt/kZ4rtzqyKDEah6aCf01bZ5BlOR8Njy1A==
X-Received: by 2002:a05:6870:2e0e:b0:296:bbc8:4a82 with SMTP id
 586e51a60fabf-2cbcf755648mr12137468fac.27.1743623819813; 
 Wed, 02 Apr 2025 12:56:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a497b2dsm2926465fac.19.2025.04.02.12.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 12:56:58 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:56:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>
Subject: Re: [PATCH v5 40/46] boot: Support IO UARTs for earlycon and console
Message-ID: <20250402195656.GC5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-41-sjg@chromium.org>
 <20250402142858.GT5495@bill-the-cat>
 <CAFLszTiCgq6XqK7mVY9YWD6bjod3bWPtp_s2k7_WVgn8gVf5QQ@mail.gmail.com>
 <20250402195033.GB5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="arAhl1ReOqvEeKND"
Content-Disposition: inline
In-Reply-To: <20250402195033.GB5495@bill-the-cat>
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


--arAhl1ReOqvEeKND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 01:50:33PM -0600, Tom Rini wrote:
> On Thu, Apr 03, 2025 at 08:22:44AM +1300, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Thu, 3 Apr 2025 at 03:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Mar 15, 2025 at 02:26:00PM +0000, Simon Glass wrote:
> > > > Update the string to take account of UARTs which are connected on I=
/O
> > > > ports, as on x86.
> > > >
> > > > Fix a typo in an error message in the same command, while we are he=
re.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v3)
> > > >
> > > > Changes in v3:
> > > > - Add new patch to support IO UARTs for earlycon and console
> > > >
> > > >  boot/bootflow.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > index 58a1afa7a75..4054a966af8 100644
> > > > --- a/boot/bootflow.c
> > > > +++ b/boot/bootflow.c
> > > > @@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflo=
w, const char *arg)
> > > >       *buf =3D '\0';
> > > >       if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_CHIP_=
16550_COMPATIBLE) {
> > > >               snprintf(buf, sizeof(buf),
> > > > -                      "uart8250,mmio32,%#lx,%dn8", info.addr,
> > > > -                      info.baudrate);
> > > > +                      "uart8250,%s,%#lx,%dn8",
> > > > +                      info.addr_space =3D=3D SERIAL_ADDRESS_SPACE_=
IO ? "io" :
> > > > +                      "mmio", info.addr, info.baudrate);
> > > >       } else if (!strcmp("earlycon", arg) && info.type =3D=3D SERIA=
L_CHIP_PL01X) {
> > > >               snprintf(buf, sizeof(buf),
> > > >                        "pl011,mmio32,%#lx,%dn8", info.addr,
> > >
> > > I suppose we're well past the point where we can delete
> > > bootflow_cmdline_auto() itself because that's just going to lead us to
> > > trouble down the line (5 years from now when the kernel adopts a new
> > > preferred way to pass this info) and grows every platform by some amo=
unt
> > > of space every time we add something new here.
> >=20
> > Well firstly, why would you want to delete this command? It is very
> > useful to be able to change the cmdline.
> >=20
> > This command is only available with BOOTSTD_FULL, which is less than
> > 10% of boards.
>=20
> Because it's automatic non-obvious stuff. We should not be modifying the
> command line at all. Is it even documented that we're doing this?

To be clearer, the more I review your changes, the more I see a blurred
line that I do not this is good between "I found this handy while
doing something" and "This is a good generic design / feature".

That it can be annoying at times to add the debug uart information is
not a new unique problem. It's something that's generally normally
solved. I assume you hit this on x86 where it's more annoying than most.
But a generic feature it should not have been.

--=20
Tom

--arAhl1ReOqvEeKND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftlogACgkQFHw5/5Y0
tyznqwv/SKQwEu88rr5fYqX9jUX/RkhoI188Tcp+g9r34+UeTO3L3HIfJS4rDuZq
1pqCtQb7kF1ZkrUHAZK3bwC6s0mqOeY+l1mFsrdOYVhahwkKgGxSSrGOhRIAYcu+
D5HLbR+Oqbb17/vg8To5kPyaHgdOAjOO1/XGW1yRIkGdc/EOIU44Q79VxSWt3WN/
Ue+ZeynM+tZrnLzLCi65/InmsqYsEtm1IaZl6pHa17D+JlAl3rStjjsp4Dxo5JZ6
RCm8N6OBCJFihwWdssa8ZQ78xfaubluDpheZh7QgjcYKtYd+2IbnRlPXgNHRAa+i
1GD1btyu5JateeY2T7L4dDpoXdNAyhV1upASOJgAuJjI2Dx/o1GOvphE/DWrn9zk
60FAgUlLSQa4OMRaUF8/fFEjAZP9kiGrT1ens9clNWDaEtVRiCAoeiZuPJ389C1K
Da4F5wIeLqXnBPBHDsb125vERSD7+lVdTUpJygV3rIWwTeX0DoQpz5qiGGnwRFjf
ZVrUqX+h
=YZqa
-----END PGP SIGNATURE-----

--arAhl1ReOqvEeKND--
