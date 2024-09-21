Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09156CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 17:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EAB88B23;
	Sat, 21 Sep 2024 19:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2HXJ7Ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9EC188AB6; Sat, 21 Sep 2024 19:49:09 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3E488AB2
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 19:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a9acc6f22dso297047085a.0
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726940946; x=1727545746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PDcMVcyAANDE/fsYVaLHbhnVBdAWiJhZZ1oUCe+Hxvg=;
 b=I2HXJ7ExQWfoHeDyhDarNMQXMnUfpfFa5/NgbQ+ynCQX3G3C3M9FoB7cHYiSjjNMJL
 rjGZ2h7tBf4ndF0Z+x+lLStK+9Ydi6gGEjxzLtQOm4W6vQsJOsXXQ4ytGwX0bS21ftQT
 8vlzIdRqEfv8A4Kaq9fg7/yvsy1gU3Za9M+JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726940946; x=1727545746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDcMVcyAANDE/fsYVaLHbhnVBdAWiJhZZ1oUCe+Hxvg=;
 b=S0py6S4vfhDgMaK23l7HzqliM2mpeqATwAUkcoAR1ZVSwInw+9a8l0VV9+u+HB7VMv
 WEJj+iGaw7Qf4X1CzsxmC7wp9O0QJRxXJz+HImOJVSDN8HFFuKSB0M2WI24mxuQbPXiA
 ck8qrjbfcUNbh2N/XGU1CVwDbA83cPKk1yaO5vwvpOy0D1i/YEfQ/XhsftPINIczJkBl
 sQ1W/1KyHp/vLRoWKCcHlaNioRi8ZTKKxPgb+SCvUWo1yyK0UR679AK7bOcj5MFXZVJR
 WBbQ3Mx/F2kRngfJ6NvZnOhpbz/ITswD6RpP5YTWTe27hpCS107ybM3MLif76wEuqDlQ
 UehA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUzhvXNBPeINRuvewRFLWpWbzWAY0KX6ldu/32CQ6ThMwHio39/tTsusVWFlsLjK0i40cYSXo=@lists.denx.de
X-Gm-Message-State: AOJu0YxIV29swPXdSe0F+2dTjfOfws7VG9iDq26LThFhr+yVZFyK08RO
 HC0QYfRWKmo7O9MQjGTG+ONdIEtOkvLktdQADVJxUb0nnxiTdyRN1aHcsOSaIZs=
X-Google-Smtp-Source: AGHT+IFuf+GWtdE1CQ11nVopSNkCc/Iom5/mrdBwt5e8ZB8cL63yP7fyVTqV1QHXIDgAqzIec5hzvg==
X-Received: by 2002:a05:620a:2945:b0:7a9:bafd:635b with SMTP id
 af79cd13be357-7acb821f64bmr1006448385a.60.1726940946475; 
 Sat, 21 Sep 2024 10:49:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb08d9552sm310040485a.120.2024.09.21.10.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 10:49:05 -0700 (PDT)
Date: Sat, 21 Sep 2024 11:49:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
Message-ID: <20240921174902.GM4252@bill-the-cat>
References: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
 <87wmjli59e.fsf@prevas.dk> <20240909143236.GB4252@bill-the-cat>
 <87ikv3j1ik.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CzUVkt1mqbpW34/f"
Content-Disposition: inline
In-Reply-To: <87ikv3j1ik.fsf@prevas.dk>
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


--CzUVkt1mqbpW34/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:34:11AM +0200, Rasmus Villemoes wrote:
> Tom Rini <trini@konsulko.com> writes:
>=20
> > On Mon, Sep 09, 2024 at 10:46:21AM +0200, Rasmus Villemoes wrote:
> >>=20
> >>=20
> >> Again, just do cyclic_unregister() unconditionally.
> >
> > The challenge here is that Simon asked for all of this as part of
> > feedback for v3. What are your thoughts here, Simon?
>=20
> No, AFAICT he asked for not adding new ifdefs to C code. But if the
> existence of the cyclic member of struct mmc is conditional (whether via
> an ifdef or via the CONFIG_IS_ENABLED(FOO, (), ()) construction), one is
> forced to have ifdefs or that very same CONFIG_IS_ENABLED(FOO, (), ())
> in C code. Which makes the whole thing rather unreadble IMO.
>=20
> Which is why I did the series to convert the cyclic_info to something
> that you embed in your client struct, and which goes away (has size 0)
> when !CYCLIC, but still syntactically exists, so C code can still just
> do &mmc->cyclic and everything works. No ifdefs or nested uses of
> CONFIG_IS_ENABLED() anywhere, and no need to guard the callback function
> or mark it maybe_unused.
>=20
> So I tried fetching this patch, build with and without CYCLIC, then do
> all the simplifications I suggest above, and build again with and
> without cyclic. No build errors or warning as I expected, but, comparing
> the object code does reveal something that I need to ask about.
>=20
> Assuming CONFIG_CYCLIC and unwrapping all the CONFIG_IS_ENABLED stuff,
> mmc_init() does
>=20
>   if (!mmc->cyclic.func)
>      cyclic_register()
>=20
> while mmc_deinit() does
>=20
>   if (mmc->cyclic.func)
>     cyclic_unregister()
>=20
> There are some lifetime issues here that I think are pretty
> non-obvious. mmc_deinit() can get called from the cyclic callback
> itself, but nothing ever clears ->cyclic.func, so can't mmc_deinit()
> also later be called from, say, mmc_blk_remove() ?
>=20
> I also find it a bit odd that cyclic_register() is done regardless of
> whether mmc->has_init got set to 0 or 1 (i.e. whether
> mmc_complete_init() has failed). So can mmc_init() end up returning
> failure, yet still have registered the cyclic function?
>=20
> And what if mmc_init() is succesfully called, later mmc_deinit()
> succesfully called, and then mmc_init() again and finally mmc_deinit()
> once more. The first will set ->cyclic.func via the register call, the
> second will unregister because ->cyclic.func is set, the third will
> _not_ register again because ->cyclic.func is (still) set, and then the
> fourth will crash because ->cyclic.func is set so cyclic_unregister() is
> called on something which is not in the list. But maybe that simply
> can't happen at all because mmc_init() is called at most once? But then
> why the conditional on ->cyclic.func in the first place?

That's all a very good question that I don't think anyone can answer
without going through the cases, unfortunately.

--=20
Tom

--CzUVkt1mqbpW34/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbvBw4ACgkQFHw5/5Y0
tyxpYAwAqoLT9KxZyiSMqYn/kYEKFjdPsX+XLCd4QrwITrRoh3huEJ1LGVBbApcp
eWqnQcjp4iE8qovt8d6lCz/sX2OuLSsnD1fkZf8ZcC1DlWYJcySQl84Gc5JMm7Ao
Dt0itGb9bkYebq4bYEvZXnRm9HM5/fNJzhFz7ht7RRwCX72SWo881xA392g5r/+9
WjZQAD179FFIQwOIdiw6oo/YpOOFf050RJNqmcoG/LSUSZ93MDT8uvwXlqfpqCT+
GfXh42KPekcHUuoiz/Gzqz0I4HtHgbhyXUapVPJiBXBXwNHdO+SDR4FJ/dAxZk1E
bNgcdnlih6u4CpVPdzG8/hKvV8sBCi57walT46WC4M8KEhtzHpZpaicuYMIGkuO/
ofwoBcRzvLhmwDBBIBPlgjmT/PTrCsF9Sd5nka7qoYUac4waCHISGN60UiFHYuZQ
voA8LF2W4FFCOe6WG9aaPg8L+IcXTxZLAa82HekOQ+sts+W9YSaMXwOuLyO4f7lk
vZegM9nn
=+F27
-----END PGP SIGNATURE-----

--CzUVkt1mqbpW34/f--
