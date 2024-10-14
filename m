Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA72D18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56528891B0;
	Mon, 14 Oct 2024 23:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D4GkrHHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF386891B0; Mon, 14 Oct 2024 23:07:19 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E98089205
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7afcf96affaso242545285a.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728940032; x=1729544832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EbDt+rJLuI9gDwf4lqKyU5ikaQ4rDT0g6Mp0Zn9O2TY=;
 b=D4GkrHHjChOrlU5tGxna9GqaIIFnnEL5EiJrcUPUFHI4N6ElJ1wezA6ERYZbrqg0Sq
 1OyUHxaLLHFRmlz5Q90TWSE6FTCg1/xqkMzJEyakWoh0SsfqxUUUiyWH878uKL6xr1lH
 Mh1ph6thdRPMIMSabEijYavSn357YSd4NFwg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728940032; x=1729544832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbDt+rJLuI9gDwf4lqKyU5ikaQ4rDT0g6Mp0Zn9O2TY=;
 b=sVK1heDDzYO0DYMaerOe5R7J1glNBf0npwO00iolbafmrAqXjqxJlwgsbaepoOeCJP
 F1j1BBW5rLmKBrheKqTb7I7W75cloSbHzTXg3OooMDV4VU8V1hZQxeFyNiGRZD9xhLpC
 vosPR8tdLq4lcH0TzhoRk7vq29o2pNxzIuzxZ3bLRj8Lg12iZ/9eFNzD0d6vwkpg0Lh6
 Ie+lF68zWTQnIKh1RLlz3bxJ4kxjbMj1EW5AA8Cn6HvcJzlCQK85HWJIR10YqDNzwyeh
 4TT3cWOV0oPTimaXConIcj4FXLzTGNH1wYQ+qjpmUoXrLGZPHx7ehvWkvhgIkKT1EYII
 Zg6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWixA1CnpsVJPv+Z3NMP9H+m9hZYA63UUxZA4TZi3+GwA1tvyxmdAnNmLa4wAZ6ok0jajjitVQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8v8gykWJs/K6NSPIszYcMzNGJH0cFuYTVjikreFHOnYy70Ywv
 wIfZC1FJzVjZXsQcjD3GzCcwmrWX116pYx/AOl5XtIT1SFmZWeHg6/I83zYbwWo=
X-Google-Smtp-Source: AGHT+IEfWNjhtZmofv8KVkKFgf1RqiONGIFQG9kVzWIpp81oVyyEvVOvhPcIaIR37q/D0ivhmVZVuw==
X-Received: by 2002:a05:620a:4406:b0:7a9:bf33:c17a with SMTP id
 af79cd13be357-7b11a37a25bmr2391945785a.33.1728940031975; 
 Mon, 14 Oct 2024 14:07:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1149893c6sm451197485a.130.2024.10.14.14.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:07:10 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:07:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
Message-ID: <20241014210707.GW53053@bill-the-cat>
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
 <20241009223907.GN14210@bill-the-cat>
 <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
 <CAFLszThoXsWuPu=b+FT0wuURR1rxTE6RWZhUhET9mHbQ+j63ZA@mail.gmail.com>
 <CAC_iWjKKqsJh7yUv-kRe5WiGA02c4YU4Yj83UXVXjki+CO9X1Q@mail.gmail.com>
 <CAFLszTi_CqDY2+RMRo+hJLsCtn6vQHHoeBvT8g-czL7OQAXw0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PdlC3SXrIGV3Dn4n"
Content-Disposition: inline
In-Reply-To: <CAFLszTi_CqDY2+RMRo+hJLsCtn6vQHHoeBvT8g-czL7OQAXw0g@mail.gmail.com>
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


--PdlC3SXrIGV3Dn4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 01:13:25PM -0600, Simon Glass wrote:
> Hi Ilias,
>=20
> On Thu, 10 Oct 2024 at 09:27, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> >
> > On Thu, 10 Oct 2024 at 18:10, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, 10 Oct 2024 at 06:02, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Thu, 10 Oct 2024 at 01:39, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > We already have a mem info command, which is pretty useless. =
Can't we
> > > > > > > reuse that ?
> > > > > >
> > > > > > I am not too keen on using that as 'info' is pretty vague. We c=
ould
> > > > > > perhaps create a 'mem' command with 'info' as one subcommand an=
d 'map'
> > > > > > as another?
> > > > >
> > > > > Are we talking about "meminfo" which literally only prints gd->ra=
m_size?
> > > > > If so, I don't think it's worth worrying about enhancing that.
> > > >
> > > > Yes, that's the one
> > >
> > > So, you mean to just delete that command and make it show the memory
> > > map instead? Or show the memory size at the top, before the memory
> > > map?
> >
> > I meant the latter, but if you and Tom agree that we should leave it
> > as is, I don't mind adding a new command. I assume that the list above
> > is non exhaustive, so in the future we could expand it with lmb
> > reservations etc?
>=20
> I sent v2 with that done. The lmb reservations aren't that useful as
> there are no names attached.

I disagree with names being needed to be useful in this dump.

--=20
Tom

--PdlC3SXrIGV3Dn4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNh/sACgkQFHw5/5Y0
tyxdFwv/Sl3rxBVleDVLbKMJKDVc1KZTupaItj4HvHnYs+rMA8PPFjqI1qk/A1z0
pSl/67xUBlXsbw2fcB2+JlFs0wGgJ9excZQTOnbgwUmd/EQ1+TBmk3gQpHjXoSyu
j6wXPVd0eIJTxjhwpDuFz0MftsW5BAQLRnEgWy82m4N0gmS4A1H60MAaAm9+WwHt
dAddTaPp2HojXc4k4K94MI9+IVkNL9sADO1vo/ku4JGTXha8U/HtlV2+VJmPhEB9
JbA/TTCcAqZpLQr6QtRkOPI2+YkaNaUBiY4+0FQlRv0EQvGycPrVDCN3/mF1DldM
/5QjW0nKAxxbNOwL4WO5fPau7HO5dQOXNC+rYbiHex8PGzsIkvFFiz88u7aW1ELh
pueUUG7sKOYfPblFyJA0UBpD7Xa7yrItqW/OOeAnKaPGtxr877vXYaQ3tjeKsUJW
rUzgEJtXlAS6MXDGREEXeXFhEJqEaDi5GVZkmysVEB3HlolFVGEIZvpveDhBfW/b
z3xqaoKF
=fs5p
-----END PGP SIGNATURE-----

--PdlC3SXrIGV3Dn4n--
