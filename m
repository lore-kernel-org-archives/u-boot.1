Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202F6C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49CEF84A04;
	Thu,  2 Jul 2026 15:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mnXCrx7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3071D84A06; Thu,  2 Jul 2026 15:59:27 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87418469D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7eb5a9f02e8so315513a34.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783000763; x=1783605563; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wr0OwQamgfDeSU+4bfbOL+EEVR47oFSwEL4eJ7Gc2Is=;
 b=mnXCrx7bLfdg50t8WfQYDwLHogQqTkg0EK/jZqepPrkmdql6Gj/tIt6teOj9qAWpFg
 V8RpRUGPWlt1GyVX5FPnt5othSY7iQzbLKVsjeYyzeWqFsJBj4s2MPTYDTu0o7vI0AAa
 s6zD1lhmkX+i3M0HT4kGeFhdQo9d8V/Eym914=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000763; x=1783605563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wr0OwQamgfDeSU+4bfbOL+EEVR47oFSwEL4eJ7Gc2Is=;
 b=U06RnBUFuZHHdsJIokb77vYrxDxxW6xoEILo84y/2iqfCy3ATrDPquZj8QDsF79zVF
 7WfHNP/BSjKR4nxC3TOyqU8R5vVm0iSBO9HWMyPLS6y0OJI42/t4MUOxyUGKbTov5TrZ
 pyVolErxePt38r16pIVnkRA22FoSujmACgZ2oTMmhriLxspyGo2ds5JSAkLXpSUywm1C
 +xNWKIKY8Qh+54oHiuPK1hyo2dpvDeRQIILqDT1MMS6xUfKCzswZcGB+9IMKPTCnA6b5
 4E/l4wgt9V7zlbHABfula/BHeIbzo6rIlvS7P6ntRSbN8qs9IQY+aCaNnvvZW1SjDsrF
 YWTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PSNs1y/yOOALGBTy78Q20KBK8wTHvrFFDeb2dN/UutDqKRnJ+ctBrNmzGym7ckdKvGGqT7+c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqv+7KPaJqAYXMDg4nzjWoVtz3BSdR8C2Df2BllFymGMuabc7R
 i4jz8lWXY24nhPAPJbFMEk88lOBqNKvVXmcb4QUulkPdn8HPZk9GSC5gWD4cwYFJ7Eg=
X-Gm-Gg: AfdE7cmr9JrqGJtC6S+PRe8YLXyGr4pU8L+fpL08F9whJnznzdKbeokwVYQhAFIkutk
 tyb1X4OQt2AqjXvblbgf7zNKTg94culvAQf05NEeU87W0hGCzycxveNWKAfPsm0sa2T49vU1V2U
 ecD0o2jDZapVPVhFeFDNuc7aOHFd52hNNiqtFzpsaTAtgKbDEvYzdEkMLfh9TY9qzoDIFLbFRAg
 YqDh6MoBBGo+fmwrq5wHKUZlUp387Ef6YXcc8zbM7FJ7aYUTOva9jQZSkU9hbDA4e8VITniscag
 yK4AwKNbG4GvBHwLNnUtqQ3aqvHg9DFYNU5TCDtpcYoGKx2BJgG5//KRuzus6i/j+7LZRwWF/rd
 ZS0DpOocjs0Ntyhac0oLeea9XzjAJdhbi0sc5mJBVha84X3BsgCPb93QvYSqNAphIMIweDZkI9d
 P+VJ6q7REdvPTvCzF/lFm/kE5sIM6G/bizxjwX4B2LFUxSf0VSNhbDY3ulN2d8ShjUl4Ca0g0rc
 hZ2LL7AP3P58i9uX5t5o6qzd99TBAg9CKWFPg==
X-Received: by 2002:a05:6830:258b:b0:7e9:ea18:d1e3 with SMTP id
 46e09a7af769-7eb4ccbff6emr3379658a34.29.1783000763325; 
 Thu, 02 Jul 2026 06:59:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb545515casm2438539a34.27.2026.07.02.06.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:59:22 -0700 (PDT)
Date: Thu, 2 Jul 2026 07:59:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: mikhail.kshevetskiy@iopsys.eu,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: Re: [PATCH v14 02/18] bitfield: Add less-checking __FIELD_{GET,PREP}()
Message-ID: <20260702135918.GW749385@bill-the-cat>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTg4ZuiEdQkfTZcomtcWxSN+f1CKvE+Hikk+EHWghPaKYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yGnqVlow7h2atNF7"
Content-Disposition: inline
In-Reply-To: <CAFLszTg4ZuiEdQkfTZcomtcWxSN+f1CKvE+Hikk+EHWghPaKYg@mail.gmail.com>
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


--yGnqVlow7h2atNF7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 11:53:05AM +0100, Simon Glass wrote:
> Hi Mikhail,
>=20
> On 2026-07-02T05:57:27, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
> > bitfield: Add less-checking __FIELD_{GET,PREP}()
> >
> > The BUILD_BUG_ON_MSG() check against '~0ull' works only with "unsigned
> > (long) long" _mask types.  For constant masks, that condition is usually
> > met, as GENMASK() yields an UL value.  The few places where the
> > constant mask is stored in an intermediate variable were fixed by
> > changing the variable type to u64 (see e.g. [1] and [2]).
> >
> > However, for non-constant masks, smaller unsigned types should be valid,
> > too, but currently lead to "result of comparison of constant
> > 18446744073709551615 with expression of type ... is always
> > false"-warnings with clang and W=3D1.
> >
> > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > used in the fully non-const variants later.
> >
> > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> >     HWM_FIELD_PREP()")
> > [...]
> >
> > include/linux/bitfield.h | 36 ++++++++++++++++++++++++++++--------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
>=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Please can you add your own Signed-off-by at the end of the chain?
>=20
> It's a bit confusing that you seem to refer to Linux commit hashes in
> the commit. So maybe this should have a Cherry-picked-from: line
> indicating it came from Linux?

We don't use Cherry-picked-from (does anything?), we just mention what
the upstream commit was.

--=20
Tom

--yGnqVlow7h2atNF7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakZusgAKCRAr4qD1Cr/k
Co2HAQClRdURvxJcSwvi8Mqd5Rwnpk50JuyabRNNq+KJzATUEwEAqLZEqGcuD7gS
N9StW7b1sQW+CnD3gw7ZLl0XwznQqwg=
=W3Na
-----END PGP SIGNATURE-----

--yGnqVlow7h2atNF7--
