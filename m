Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C23BF46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4F78405F;
	Mon,  6 Apr 2026 18:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JHglrazW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB2B840AA; Mon,  6 Apr 2026 18:14:11 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E468352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 18:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-67c22b05346so2331954eaf.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775492048; x=1776096848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g+UpvezSIAVmG6VTXXzv/corE9EvDQzLRNbpeBLxhfc=;
 b=JHglrazW/cHnonucCEOhNVMqc0v0uf7lEuna7VEwGCRm7ZYbAmeFR4f7l35JXDNonC
 Ng/Rj4axCcD1dVlyYT6bYXNyn7VCOPDkI0OjSHQMfwrxABAaaMlmoOqrrRK49doyIUHE
 TT10FLxIOl/Z7RdPr/Q0sLFPmJoDiwzhEYfXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775492048; x=1776096848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+UpvezSIAVmG6VTXXzv/corE9EvDQzLRNbpeBLxhfc=;
 b=bcy+dIgP9P2+2GWyl5qd3uHt8o20FHztlhmQgKBnZ4ZJRye38ul2hPu463v0aqR6Yh
 G8dShBzhVyX5DarV4UGhA15WEeCdDD7FNEERA0+k4kTQsRygnZrL6oZuq3c94a0OKb2X
 u8BkiqknCLCjd9pAoYxEr7yb9cik4TzHkDrlkD9MvVDbfA1l5JFNXPy4agw0K2rwmptn
 PBceuH6s/8OFltQ/lnO0pkU52tYnPK42B8j/mVMlgLofWjNrCXfW7tsSD2q9HBzE2Cvh
 +dq3XuL7YNZ1jRHYCpzrQzaHE9cSSfm4Gp8WIiHTRRC6HUBxwwnS2uXHRzkRS+pQXTD3
 gn/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuGKNJEV6V/LBF8F+/PX/+XJ4ZGX05EtivueXHTRHwjznl9XDfb2T4PYzM5HcT3TeauCCEWTc=@lists.denx.de
X-Gm-Message-State: AOJu0YwjyNESKFw4/HVOmkeausJEZjB8SnNqWXhdFHkto2RA8snB7qU5
 H15MDrd1wKtl3qp1GNcbkBKRGaJvxJretF8mCvHi8F/NPemWedHQtg5b9tuVn5TpkQ4=
X-Gm-Gg: AeBDieuPtjYpQmCnpytXzVI/Y53SxEWZBgzs8SYm3UtwTfjMdrdBwTiFhrKSKWmI8w5
 i2BuQ3Ebu/ELe30JYYz5CFPQJSLXkUNFgNBFbPk5aa+hqDoRkaflsNZR0NNztpRLLFfdSgklCt8
 tiRcdaDIiATSx2uUVgHF8Q6VgHlrHzitYcmRpkUaOlrZ8Nxz3BiYyo3kn4PdVJfiao4vgm0+FHq
 ig+PZ3T3PV630URcqXG6FvxHmuqko9X+fEOMRVLorkgqenQGIIL9xsW1VimmYVS4mbb0zXqUSak
 KjMqXJZO3rnUmdhDQdH7gBjZ6ML/HU87RO4wTs4z2uO340zAXBGGoM/SICQUfccjQXmDl15uJAb
 RuOwzQIhBJNnJuiy/ykWZZyT0RUq1yyjTdkM8jPLmrZAR2vkXpn6BRExCwyGY91QLl9A8VcQHiQ
 QKaJzdFmIZVxoM1pgf/+SDHBK3UpuGzOXIsJn/Pc0XlgtB3Btvs+RLfvwtEvtTeGyesTq835Jvt
 p//JuQTL3W/urCwoTIAJf7v/J9rI9eK9O6Iybuv0TH/1gq1
X-Received: by 2002:a05:6820:f036:b0:684:e04a:265e with SMTP id
 006d021491bc7-684e04a28damr3242899eaf.50.1775492047779; 
 Mon, 06 Apr 2026 09:14:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eaf2c7c3sm11593375fac.5.2026.04.06.09.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 09:14:07 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:14:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jonas@kwiboo.se,
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/4] common: move ram_base calculation to independent
 INITCALL()
Message-ID: <20260406161405.GT41863@bill-the-cat>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
 <b4015957-76b8-4531-b694-cae143a65f49@mailbox.org>
 <20260406154105.GQ41863@bill-the-cat>
 <7a190e6d-60db-4087-ae1c-9013dc6706bc@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QbVXbTAhYktKv8t8"
Content-Disposition: inline
In-Reply-To: <7a190e6d-60db-4087-ae1c-9013dc6706bc@mailbox.org>
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


--QbVXbTAhYktKv8t8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2026 at 05:56:41PM +0200, Marek Vasut wrote:
> On 4/6/26 5:41 PM, Tom Rini wrote:
> > On Sun, Apr 05, 2026 at 05:59:52AM +0200, Marek Vasut wrote:
> > > On 4/3/26 11:01 AM, Ilias Apalodimas wrote:
> > > > Currently, ram_base is calculated within setup_dest_addr().
> > > > However, upcoming patches that enable U-Boot relocation to the high=
est
> > > > DRAM bank require ram_base to be initialized earlier.
> > > >=20
> > > > The default dram_init_banksize() definition relies on ram_base
> > > > to calculate the start of the first bank. But following patches
> > > > will move that function to execute immediately before setup_dest_ad=
dr().
> > > >=20
> > > > So let's split the ram_base initialization in its own INITCALL.
> > > >=20
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > >    common/board_f.c | 12 +++++++++---
> > > >    1 file changed, 9 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > index 91c569da9682..7df92281c35a 100644
> > > > --- a/common/board_f.c
> > > > +++ b/common/board_f.c
> > > > @@ -329,6 +329,14 @@ __weak int arch_setup_dest_addr(void)
> > > >    	return 0;
> > > >    }
> > > > +static int setup_ram_base(void)
> > > > +{
> > > > +#ifdef CFG_SYS_SDRAM_BASE
> > > > +	gd->ram_base =3D CFG_SYS_SDRAM_BASE;
> > >=20
> > > Would it make sense to reset the variable to 0 in case CFG_SYS_SDRAM_=
BASE is
> > > not defined ?
> >=20
> > In that gd should be zeroed out do we need to?
> >=20
> > > Or better yet, how about moving CFG_SYS_SDRAM_BASE to Kconfig with de=
fault
> > > value 0 ?
> >=20
> > We don't set default values when a valid value must be provided for a
> > platform to work. It wasn't migrated to Kconfig as it's not really a
> > configurable value, it's something that if we could pull it from the
> > device tree, would be great. A someday middle-ground would be to mimic
> > how Zephyr uses the device tree and get some compile-time constants from
> > the device tree.
> It could still be a Kconfig hex value without description and with default
> value for each platform. That would still be better than the CFG_* remnan=
ts
> and would simplify this code.

I didn't do that migration because it *really* sucks (it depends on the
SoC, every time, some families from the same semi may share for a while,
or they may not). And that's why the CFG_SYS namespace was born. I don't
object to someone else trying to tackle it, which is why I suggested an
alternative too, that I think would solve the more general problem in a
way that won't be so painful moving forward either, but it's orthogonal
to this patch either way.

--=20
Tom

--QbVXbTAhYktKv8t8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPbzAAKCRAr4qD1Cr/k
CqDDAQDxQY4uwAhgWcaSOO7O8xwJI9UYr6cinZBj7/+Lq0z7NAEAnZGNmmoMEtSo
eHBde1OWvP1MUCK9JhoamsGTpb6TWQs=
=BwMA
-----END PGP SIGNATURE-----

--QbVXbTAhYktKv8t8--
