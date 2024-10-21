Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5374FD17123
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B529888E8A;
	Mon, 21 Oct 2024 20:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V74Rkv4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCA888EA7; Mon, 21 Oct 2024 20:21:27 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD6F88E8A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-460ad0440ddso29926081cf.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729534884; x=1730139684; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ntIzIBWOqGNlE3vetd58BhSO27RpaetG+XLXAesn1AU=;
 b=V74Rkv4B59nDG6BdIeXkeLKGOrfwKKSe2baf0ZnlnKLURWA7QUd3/jV7iNgFoyhLZF
 15+SQ8Rd4Z/yynNikxw6GNZtMFV/LsW0WfqsN7wvooUN7f50m+HHk6BZj/v85wsxwERL
 xwgsbbJj8l3tUQiHZDkiGPsT+W5kaGpof4lOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729534884; x=1730139684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntIzIBWOqGNlE3vetd58BhSO27RpaetG+XLXAesn1AU=;
 b=M/Txt9Gyd3PxPPXsVeWt9oOOmQTe3R9BLC8jbfgx0Ry/h/vWR2gHGIzrWKrJMfaTha
 9K1xT7xpQOUzHHJ5x/mGfz+Q//utiRmu6RzII20Vdizl+bEzLesbH/IwDhY+oLQneIBy
 pTENOeSkv0bc2oI/e5N3iwch+fBtfoJVxk1Pz9bdAU3ca5BDwNzEw58Xeuvq+l9Se/6m
 lS63eE8DGEMvtpYK4dWjRsSHjg7dG0HKbmFgHGAwc5XQtKmGLtYMvOLDsxSH1tPTynXh
 0y4q91BuTqeeTLavCA2/sPQce7KkPGlg5VMfobgX5GEg7k5auIhLoR+Nr1u186aUcMht
 CtBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWedKPC8YSDskacgsAs+O8+a5OQSUbP6ExosJNPBPxOCdMk7qiF3vcHJZSVUYTbs56JELED/aU=@lists.denx.de
X-Gm-Message-State: AOJu0YwC6Eg7m8LxeFN8Y1QnbickmUQfPRmRtV1pz9jlegn7TrI9bYbm
 NjFcctgVXykdE+R4JYLZkV2R0Mfmgbanon6gIezEpnVb4ykenyl06l8IWbsWN64=
X-Google-Smtp-Source: AGHT+IFvY+4NqjuyyZCypDCXyERJxZnCcywHx4bD6H5HeOSHlS8gEVXYnJBGC8UFWCrUcHrXXcveLw==
X-Received: by 2002:a05:622a:2443:b0:460:a6f8:8588 with SMTP id
 d75a77b69052e-460aedfe6b0mr212535831cf.50.1729534884049; 
 Mon, 21 Oct 2024 11:21:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3dae6f5sm20347181cf.92.2024.10.21.11.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 11:21:23 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:21:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Artur Rojek <artur@conclusive.pl>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 3/3] common: Move autoprobe out to board init
Message-ID: <20241021182119.GS4959@bill-the-cat>
References: <20241021155133.29557-1-sjg@chromium.org>
 <20241021155133.29557-4-sjg@chromium.org>
 <81b0a377-6669-46c6-9da8-c83d9758587e@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oAMWXN2eFLAFRkqU"
Content-Disposition: inline
In-Reply-To: <81b0a377-6669-46c6-9da8-c83d9758587e@kwiboo.se>
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


--oAMWXN2eFLAFRkqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 06:10:09PM +0200, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2024-10-21 17:51, Simon Glass wrote:
> > Rather than doing autoprobe within the driver model code, move it out to
> > the board-init code. This makes it clear that it is a separate step from
> > binding devices.
>=20
> It could probably be good to mention that after this patch the events
> EVT_DM_POST_INIT_R/F will happen before autoprobe instead of after.

And in updating some part of doc/develop/driver-model/ and referencing
the discussion on the list, in the commit message with some Link: lines.

And I mention the last one because I fear this is related to the
regulator changes from Marek and it would be good to hear from him that
this series doesn't break his devices, for example.

--=20
Tom

--oAMWXN2eFLAFRkqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWm58ACgkQFHw5/5Y0
tyzI8gv+KbB/h9YmiUTk6nrtR7pzOguEN2n50Tt3VI62pLDgIANVyJdwtFz2ZgUy
ftnCmTCg1IC5KxlU4H/c4OngRtkKeQ2tNaOlTDAKTkMUOw5tkErLCCMmCrxA9K1Z
5RpLn6xv5FTusLG3x7Ac+NOPUYIODfxhpeTLMm9IZSrHhLo+P3EaDpPA0j6aMU9e
QMaM6pkaRSRfWWeayXRx0S1556x593wIqyivbjHsGksmIStoqtdnthB2FQegUbB+
B4wTmBDNm9xEwiEEo1fqZhI6v9vSBI10gINgiTXIOOg6joxqfaW1QAY/DFOHmSme
9UsDWMVci4LDgQSa2vh1qssG1gJv+ypuacq0dCSOd0GTBZ5F69y5V/LBCD0LwyQL
pwRQJrS+Ov6k1Dy9wYYOc17O6oXN0fOca84eG8hcwBUAc2jP983xlLEqARijCdau
MKsAA7jrxLLowK+Npp845L2INk24N7PCez2/Yj4IuyKFFEHlOUIyTKuuYqrKKpgl
WPpXmhmN
=o/52
-----END PGP SIGNATURE-----

--oAMWXN2eFLAFRkqU--
