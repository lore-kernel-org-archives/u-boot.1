Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F7CE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6099480601;
	Wed,  8 Jan 2025 18:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZMFbJTvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A14F80600; Wed,  8 Jan 2025 18:15:20 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752DC8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d92e457230so615936d6.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736356516; x=1736961316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cj5m5GUhf0nVCG6ALOzlT5Vj2LprgxZFPbbwBpWLQQ8=;
 b=ZMFbJTvFEjfvA3Q16N2kfXbSM8rF4MpN9GzcjjfIeurxa5Hev+2s+vPbNsiOb5dEbo
 fx2I9l/pHeO5ns2+l5yc8rSPq3o3b+TXyQUIhcKswbCyMJgeKQJId4Sop4osg6ipTWDw
 W84TsOBY1bTqLA3mDNbRwRsYTflxjLNIeWzJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736356516; x=1736961316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cj5m5GUhf0nVCG6ALOzlT5Vj2LprgxZFPbbwBpWLQQ8=;
 b=JmwLz0kFWOgoTCkXIdDvkta3tyP5QWvVkEQKNYDHlMoRkXiTSDL02K08WWpqwyw/7m
 9OziizSnn3HUKVYNBwrT5tm2gPo7A3KTnFbhOoLe+A0K32CoBBqCrbL7mXL/6aCmuTn0
 EpbdAtzjWleJFdAiEoryj7T0IJhd+KnA7ubjqfyGezBpjAPPnAkvd4WtSsCnYENe7z5v
 ozUijFnHckWaL4etI1jjCqhSYY8BiwkYXisexdM1oZrnE6KGOxEDfsWhcxOsXxBeaXCM
 OXzg4N4o7pswl+zzqdt4Oumar6grNSkbwmABw7aLcKR7FAZCyQC/IlIdHQMcprEKBgGo
 a8MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYkidJ93Qa5xzgxad0kfvPr6lO6/jqMLHv8dAjEQ1ngeiHrpiNcKhEqMZGbJ6my1Jh7hYAQ00=@lists.denx.de
X-Gm-Message-State: AOJu0YyhzmmG94LuXz0yT5S9Ef87ABzYWXW0G4UW8fDGTVEz1BSAr+zm
 By9dd1uC/z9ogz5TO2CFra1sjvkgzyiAoDz9VARJSmMNRepOwD4AmXQvNKScGWs=
X-Gm-Gg: ASbGncsEIbiYvVal/Eo8DM+fIDwYw+QztVt8OOhp9k0kSzhMVVcT9BLsdH5v1/Kq9FA
 0uoGfHb8S/3H/3WGG4H5g/M5zjzIqRtpSs8i43E8+e0yuDs1V4g3t7HxCbVoR86ksUX8KFvfsKr
 UsnBBz5OfQFjunvG/nxsHq+V7YQpKhdVUReQyIHqo0kpCykuhqaNBr4eIRe410u1w9xL6zKQ2Ek
 DvdTaQdE5iswUetL5LqQOF1VvXGtWzw9oT7fTZIybg5ek8J882vCCo=
X-Google-Smtp-Source: AGHT+IFzw7spAR/wN1INco+nlw6ydCeBsVC30RNkuprXLkdCHCCoJCxQa1ARyQXktR3qwvArb4sK1A==
X-Received: by 2002:ad4:5f0d:0:b0:6dd:d317:e0aa with SMTP id
 6a1803df08f44-6df9b1f6c82mr56375866d6.8.1736356516280; 
 Wed, 08 Jan 2025 09:15:16 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea9d0sm192385806d6.7.2025.01.08.09.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 09:15:14 -0800 (PST)
Date: Wed, 8 Jan 2025 11:15:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yixun Lan <dlan@gentoo.org>, Huan Zhou <me@per1cycle.org>,
 u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH] riscv: spacemit: k1: probe dram size during boot phase.
Message-ID: <20250108171510.GK3476@bill-the-cat>
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
 <20250108111105-GYA3276837@gentoo>
 <34F2FA88-E868-45C0-B73B-98BADEF49263@gmx.de>
 <2f6d95b7-da47-4a6c-a566-b73db825410b@stanley.mountain>
 <CAFLszTg4e8M01fScjjzhKvbG7AzgbTiZ3RgnzTvZN4-WZafPLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GJq9GMY/Q//KqyO4"
Content-Disposition: inline
In-Reply-To: <CAFLszTg4e8M01fScjjzhKvbG7AzgbTiZ3RgnzTvZN4-WZafPLA@mail.gmail.com>
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


--GJq9GMY/Q//KqyO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2025 at 10:03:08AM -0700, Simon Glass wrote:
> Hi Dan,
>=20
> On Wed, 8 Jan 2025 at 05:37, Dan Carpenter <dan.carpenter@linaro.org> wro=
te:
> >
> > On Wed, Jan 08, 2025 at 12:21:18PM +0100, Heinrich Schuchardt wrote:
> > > Am 8. Januar 2025 12:11:05 MEZ schrieb Yixun Lan <dlan@gentoo.org>:
> > > >Hi Huan:
> > > >
> > > >On 16:49 Wed 08 Jan     , Huan Zhou wrote:
> > > >>
> > > >>
> > > >..
> > > >> ---
> > > >remove above "---"? otherwise following commit message will be
> > > >dropped during patch application..
> > > >
> > > >> This patch introduce improvement for get dram size on bananapi BPI=
-F3,
> > > >> retrieving the dram size dynamically.
> > > >> Have tested on bananapi BPIF3 4G and jupiter 8G.
> > > >>
> > > >> Signed-off-by: Huan Zhou <me@per1cycle.org>
> > > >> ---
> > > >>  arch/riscv/cpu/k1/dram.c | 40 +++++++++++++++++++++++++++++++++++=
+++--
> > > >>  1 file changed, 38 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> > > >> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f747=
7d62c0776bcb51e623db47 100644
> > > >> --- a/arch/riscv/cpu/k1/dram.c
> > > >> +++ b/arch/riscv/cpu/k1/dram.c
> > > >> @@ -4,17 +4,53 @@
> > > >>   */
> > > >>
> > > >>  #include <asm/global_data.h>
> > > >> +#include <asm/io.h>
> > > >>  #include <config.h>
> > > >> +#include <bitfield.h>
> > > >>  #include <fdt_support.h>
> > > >>  #include <linux/sizes.h>
> > > >>
> > > >> +#define DDR_BASE 0xC0000000
> > > >>  DECLARE_GLOBAL_DATA_PTR;
> > > >>
> > > >> +static inline u32 map_format_size(u32 val)
> > > >> +{
> > > >> +  u32 tmp;
> > > >> +
> > > >> +  if (val & 0x1 =3D=3D 0)
> > > >please add brackets explicitly, something like
> > > >     if ((val & 0x1) =3D=3D 0)
> > >
> > > We tend to avoid =3D=3D 0 in U-Boot
> > >
> > > if (val & BIT(0))
> > >
> >
> > That's reversed.
> >
> >         if (!(val & BIT(0)) {
> >
> > I have really complicated rules about when to use ! vs =3D=3D 0.
> > https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/
>=20
> I  mostly agree with that and it provides some motivation for the
> conventions which have built up over the years in Linux/U-Boot/etc.
>=20
> If you want to send a patch:
>=20
> $ git grep 'if (ret !=3D EFI_SUCCESS)' |wc
>     864    4841   51380
>=20
> I think the only place I would differ is with strcmp(), where I've got
> used to 0 meaning success, like in much other code.

To be clear here, we have ~900 examples of EFI_SUCCESS and ~250 examples
of other FOO_SUCCESS type tests. And if we're going to make some sort of
change here, we should (a) document it and (b) fix it everywhere.

And at the risk of confusing your intentions Simon, Dan has a well
deserved reputation in the Linux kernel for fixing what I would call "C
is trickier than you think, even if you're been doing it for decades"
bugs so just changing EFI code would be silly.

--=20
Tom

--GJq9GMY/Q//KqyO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+spYACgkQFHw5/5Y0
tyxcZQv/Q7c822+SCihxJuArvSsLhHG9/CY+l+exAE3ir29EKQT1dN0Ywk2AOJWY
0aExi4DK9CXOYHgNxuwLwUqO2nciF771ped98nIjbml36rIeuid5VlpNItxYss5p
iiNU14vJQCR0L0rB7W59EGQ1qJuVs/MCTx2LTHiQFClXk3lz6S5g6h9jGn1cqZ41
OoVsmhyQT2Y0Ouc6hY1XHwJ1Jq7L37jQCRFJBrY8pHd4M+jNZeCuwT0Ff2VoH9yx
YDPXvAjchGsbHmp6q9ZnqwgS8kXMswiKYjyGY7wW++hL8EwKrq+XjE6EhDeYAYd3
Gi4wosyx084MEF9e7joNO0d0OCIBVEnoZFECM8jbx5PjEZ0NDY6b5leCd+fBx2iz
euiPcqQh7IGseJ+zwYK3xPVJ6S08wAHYG9BrgmVodzk0RehaB1bF+GHjs72QvNAq
pfV6ntPSylmBYBK2SVNLjuu1JKd+NS/Fe27SQ0+L6/TMsglMoaEE9G8kAbNIChVK
suD7/BuV
=W1k3
-----END PGP SIGNATURE-----

--GJq9GMY/Q//KqyO4--
