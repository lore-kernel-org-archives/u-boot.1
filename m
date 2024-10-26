Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE89D149F9
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 00:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21918841E;
	Sat, 26 Oct 2024 02:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jAbTfLSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 925AD88730; Sat, 26 Oct 2024 02:32:19 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF3488360
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 02:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbcd49b833so14228546d6.3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729902729; x=1730507529; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=frGxxQ6opcDmpUpbgGc3L0Q0Ybig9sYn4kLlMVab7pg=;
 b=jAbTfLSWqBDNyw1sY+Kji+Bc8aZdsXKojM39gUZnK1KmoswCdAd+H2pEBzm51iHQz5
 jB+UMUI5sGTxxuttSuaKpUv9NSG/YL1Ua7yKLH23WAqHGB8QggOg5v3flS+pCKpFIHAI
 kUEDsMmxvXcF45GSun0BdJRsLlqbEQhkSGtSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729902729; x=1730507529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frGxxQ6opcDmpUpbgGc3L0Q0Ybig9sYn4kLlMVab7pg=;
 b=XMC2fEzqjHuCCNL3p1JbEMUJeIV9Mf5s9TO6dt68gL26X0PBG2CCvq4dhd48qR6r6U
 trlMaX/QqkqEoirH76nWixD3/vZoi60HvphGIBP+KzV/lMhqnezki2OnvQsQsuY230qc
 j5zg9pYlKI1v97M2rJNzoOt9Ti05zpp6JfUWmU2dv1vOqdYYLnDaL6OnEJACi/4j5dUg
 k3SIRCrt4ll/zolvMyEb75YcjCg+wo86USWpxp6+NR0igjJrxwzlyhd/obNKsCs9yApT
 Nt8QqmqVlYZmp6JV1/wCorMZ3Yu5rVxuQed3VtDnlL5wVrLQ9G9a6x8rrjl+Abcq0/fY
 mfMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1iFJkEEFCrFv/pS7hRTOqcebMSLB7NZm3/hyHfQ6kof48xu0bLKAH7sXOQC8iIdAnXdRpFF4=@lists.denx.de
X-Gm-Message-State: AOJu0YwV9fVcWsMjZ5lzNbPiNXv1f5WAyqJpMqiq79Xt90+t7AM059mM
 2Bnls7yr36KAqaKSbVKMaqWaIaZKGIvz1Y3ll8cFCuSKlroZepSyYJjIHxNTDX4=
X-Google-Smtp-Source: AGHT+IHtkbFXrf8FLVLO3ZRAV1fkfjaiXCbk03U2BSyoWZaIyey7acn7PWQ+ND032Ge9oxq96i55bg==
X-Received: by 2002:a05:6214:390a:b0:6cb:fa38:47bf with SMTP id
 6a1803df08f44-6d1856f6273mr16646076d6.22.1729902729420; 
 Fri, 25 Oct 2024 17:32:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17991b4d9sm10554196d6.60.2024.10.25.17.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 17:32:08 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:32:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>,
 Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
Message-ID: <20241026003204.GD4959@bill-the-cat>
References: <20241024100145.841964-1-ravi@prevas.dk>
 <58754a24-eb1a-4306-a5de-e990539b1717@denx.de>
 <CAOMZO5DtDDOqmWuQbbDWqAaDzszyFsYud-JRGiwr5zeHiXveqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FSyOYqDjPLUdMP66"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DtDDOqmWuQbbDWqAaDzszyFsYud-JRGiwr5zeHiXveqQ@mail.gmail.com>
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


--FSyOYqDjPLUdMP66
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 09:24:10PM -0300, Fabio Estevam wrote:
> On Thu, Oct 24, 2024 at 8:51=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
> >
> > On 10/24/24 12:01 PM, Rasmus Villemoes wrote:
> > > I enabled IMX_HAB on an imx8mp board, but even though I knew about the
> > > implementation, I forgot that I had to provide a sane value for
> > > SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
> > > implicit requirement, and there's no build-time warning; the default
> > > 0x0 value just ends up being returned from
> > > board_spl_fit_buffer_addr(), obviously resulting in a non-booting
> > > board.
> > >
> > > The existing imx8m* board configs that set a non-zero value currently
> > > all use 0x44000000. The actual value doesn't matter too much, but 0 is
> > > always wrong for imx8m platforms. So just use 0x44000000 as default
> > > for those platforms.
> > >
> > > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>=20
> Applied, thanks.

In that moving to a different default is a tangential cleanup, I'm fine
with this.

--=20
Tom

--FSyOYqDjPLUdMP66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmccOHkACgkQFHw5/5Y0
tyyKDQv/ZrINtzwS87+/e4w91PsDVgVK+PiQ220mkEZHZKJDFRcnpqlxfC+KNTqZ
auP04yT8zW+FT69pt8BpVtIntsGHNsRAY3Sp0jNcBBVFYjGlxk3ZadLwqBhK+B3q
NZPKu9IWVQUWbnU/fMkx/vnFatU0Ai2DDmyQOGhcj9pP4FQUQvVS90ZFzQqntJSi
qb/o+ydDlsZoejMIdcuUU9tnYM5NS4hP5BfB4dub87StufHJIhPU0DHq1yhSDW26
PinHOnSu4LuSbHcII5oXJexVdsLR3wm8/6J6RehDlDteDOilA2H9TnL1vRRAaKrd
/j9ND4kdtaG7ca8KJzs36AUaOF1IFtyvCg4u1oNZhbeyndoKBFOkyOO4j3xBbUtg
nPk5roTjyffGEbRswlIXQ2QW/Hz3xjoiGiTcFC2vrnkoe9gN+z9oNHsIiTfembxm
tqUgue0hA1v1kZMPP7rdPS5qzEJ2mVFIU+td7j34WYCq64iytUWUyG5OZvc30mLZ
vgPbwtmc
=fGHw
-----END PGP SIGNATURE-----

--FSyOYqDjPLUdMP66--
