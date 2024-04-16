Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B07C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 16:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE47288403;
	Tue, 16 Apr 2024 18:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WGnHnT70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B982988422; Tue, 16 Apr 2024 18:06:02 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EDA87F39
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 18:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78edc49861aso191269485a.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713283557; x=1713888357; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RAJYNnv38pEZ1QXBajFFurA+GmC6tOEOjUiyahvhleE=;
 b=WGnHnT70GeGS8UmsguWQC3sEWyzNMJOFWkgjjiIP22yZzeAzqtgTHaLWOE+iK2quEJ
 GLcHW8ZcyZiLhPccb1itXN/i+ByTy4bnm/S9nsL4qntBMPtW+i0/dNEUb5vQ4yEDXZZQ
 6UuAmyGE+Twd5kRQMxSa8gnydjDUUAgmp0MDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713283557; x=1713888357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAJYNnv38pEZ1QXBajFFurA+GmC6tOEOjUiyahvhleE=;
 b=FTiPKLT8HQ5Sy2SNHN1MZBrz0xnBSuPnY/iI+6fTK+ch4DD9V4VY7nQ2OWjU0TrAgv
 GIDbKopWeC29jsb+4qBoU38+1eQolnEJQWH/We7qvsIbY5nrKQZ8pQdOwMOleWt1bMH+
 liMNqwMopobwdOJ9ZrmVITLTgUumdFnsDDNnXCn41BD4qoYV/RQUSkKrxgrdb5iacMVc
 v+Tpn4tWlrAic19rtsPomOWQ8nGC5BW6HCn++xrpoNdJFwdtCRo1YCCouYPUFFNUt81f
 rZGf5mz0VKyG+w2+/KfyOY6GUazaFHbTZCqFjpW0YhVRzETh/qVfbXegyWLs9/PkJrKi
 1s/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcFsji6V7e30ykfqMMGG6qmslUa31PlI08xlEkhpQzUrt7XKQunJSEXZxstEqNwwUDyctpxRUvKI+o0r63T3ugizlJNQ==
X-Gm-Message-State: AOJu0YzQprZ23fGHJCIIxS8XeIexN285SqqfIis0TFVsNGFAVxcDwf5b
 lGt8XptboJOjLcBVjzw5m6q4qJJgQQQr9qpPs7MgerPAFm/oFTyRnH9Lcnl8RKg=
X-Google-Smtp-Source: AGHT+IG6WGiEgWiInfxX2cSIg8s+mJ6KQcfjs8YB5LYZP8jWCZ21hV3y8EVUSsvQl4rXwYwXLNbJEw==
X-Received: by 2002:a05:620a:3bcd:b0:78d:766a:d695 with SMTP id
 yf13-20020a05620a3bcd00b0078d766ad695mr13319202qkn.77.1713283556446; 
 Tue, 16 Apr 2024 09:05:56 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 t7-20020a05620a034700b0078ef13a3d9csm1412977qkm.39.2024.04.16.09.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 09:05:55 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:05:52 +0200
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] event: add an event for livetree fixups
Message-ID: <20240416160552.GM1054907@bill-the-cat>
References: <20240412190542.1576801-1-caleb.connolly@linaro.org>
 <20240412194510.GY2493117@bill-the-cat>
 <ec590ee3-ee25-4a19-bfdf-606ca6fd55cf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SouyyLEJfayfmIev"
Content-Disposition: inline
In-Reply-To: <ec590ee3-ee25-4a19-bfdf-606ca6fd55cf@linaro.org>
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


--SouyyLEJfayfmIev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:45:29AM +0100, Caleb Connolly wrote:
>=20
>=20
> On 12/04/2024 20:45, Tom Rini wrote:
> > On Fri, Apr 12, 2024 at 08:04:02PM +0100, Caleb Connolly wrote:
> >=20
> >> Introduce a new EVT_OF_LIVE event to allow for the livetree to be
> >> modified before dm_init_and_scan(). Boards can perform fixups here to
> >> handle incompatibilities between U-Boot drivers and upstream DT.
> >>
> >> This will be used by Qualcomm platforms in future patches to enable
> >> setting the dr_mode property if the board doesn't provide one. This ha=
s to be
> >> set before dm_init_and_scan() is called as this property effects the b=
inding of
> >> drivers.
> >=20
> > This doesn't quite explain why the answer isn't "fix the device tree
> > source" and instead "perform a live fixup". Thanks.
>=20
> Hi Tom,
>=20
> I think the specifics here that make this difficult is that on some
> Qualcomm boards there is only one USB controller, which can be muxed
> either to a type-c port or to a USB hub via a DIP switch (the state of
> which cannot easily be read out).
>=20
> The DT should therefore either not set dr_mode or set it to OTG. This is
> what Linux expects (and it can do proper role detection).
>=20
> The dwc3 driver in U-Boot currently doesn't have the ability to
> dynamically mode switch, this is something I'd like to add (as it would
> let us easily flash these boards from U-Boot as well as boot from USB or
> ethernet), but in the mean time the only way to get these boards into
> host mode (which is the preferred default) is to modify the DT in a way
> that breaks Linux.
>=20
> Hence the proposal in this patch.
>=20
> If this is ok for you then I'll re-send with this additional context in
> the commit description.

So this seems even more special cased than what I was thinking it was.
Would it really be so hard to just add a dummy driver for a few
compatibles in this case? I prefer having two or three real users of a
use case before designing the abstraction for it. Thanks.

--=20
Tom

--SouyyLEJfayfmIev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYeodkACgkQFHw5/5Y0
tyxNMAv/VcJjJb8IkoEzVi7GdzVXkSRAUaga0Ca02cnHWrGJcmLEw2U81nylFw1F
7EUKkuRADggES24uQbzOMinCeYHzcuvbA9lHxv8Erun2oGZSDu4BmAZamA6FPHFm
xaKiwWKDjLmHSZVjGj9Rhk4TNrt9eyt1TTj1bm3bhiOI7sf5cenK33GYqROFVqMC
M/v/w0sqzDmq2LtN3YRaUkRVGm1HCxdYrvxucGQ2tV3Ag1dHstbypU8PQlb4npRx
rsaBpIRkt2kgxZQRjMnY/G9IJvFOkKWxoHAE4ZtYgYYVVRkm0YmQH8hOlU3vIHN4
Ox8uQ6e3QMlif2e5dWWY6nSq/9aEJGedVaBKBCWYMPmTlUAIcYX6/atJiePI/Zxb
PQRXZEusDUpbSNNOyLi724/Q8AfEpyhs7WNC7lepmnpu1+JUUUM/JJ2KYYrGKjMb
fxZGMs/vhTnXiDA2GIsCrJDjiXMO+qltDO+h7Tz59BhSXO+Np/W42JwHlMvcCvXa
MlftqQZ9
=2rvJ
-----END PGP SIGNATURE-----

--SouyyLEJfayfmIev--
