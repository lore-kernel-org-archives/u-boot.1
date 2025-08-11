Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC20C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 14:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4A3832DA;
	Mon, 11 Aug 2025 16:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NRp8Yprp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51328832FE; Mon, 11 Aug 2025 16:03:49 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BE0832C8
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 16:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8818bf246acso81676139f.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754921026; x=1755525826; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NFTYxEe4mjclFbmsXsp/RWL1zeN9+XYbt2CGS5xGAyw=;
 b=NRp8YprpKSGmooOPcvFDs/LmMYiJToLvKUR6Gpte6CORRzMSDrD50gxCX4SEKEQi34
 O7yrFs8ACqq1WvY2UnuofMjxfOLBJUAarHOVnxE9YkCU7Las7fKhTkTJm4H5zXfx6vgd
 uHFTHHf8UqwGkcjgLONgn4xkAkSSnygR7Rn+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754921026; x=1755525826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFTYxEe4mjclFbmsXsp/RWL1zeN9+XYbt2CGS5xGAyw=;
 b=m479DfcbVWedwEGokjjCu+uTSS7J+yFjJtYNPrunIbNDQs4u4sBUAmWeT1zhcOfM7C
 YwDC1bADJn8KzQL/WuOj5FUQ75Lw+1L/V0Oba11Ag/OvtMe3oDLr+08ZO609ruYgZBd8
 Kn/Dz16P6f/fLXm/IbrBBYdErnqqE6MrgctjcHDvFgLVgEahB43ZFSR66Gs8T0v+nfRu
 OBQi4j3sXIPvok76GRWrpwISzwWR/Cm5dB2Y1l9CLgbvaB7q5goJB2o2wslJMgBKOlN1
 ZTvf7qUQVqsS6YjFkz247xEM1dYAdIw2gHv+fIa0UUgRiS7NL2aGfHikVOSb+ravtbsQ
 NxTg==
X-Gm-Message-State: AOJu0Yw7ou+5elaZPA6AIuvWGicZ/68f1mK/bL1wv7Xlp3oCJ6vwjblf
 yPPvKDC3kqtB4Ad6Hnjk+O11eKSyfvCOyYz9zKbGu8KKlOEVOZezCOjzdpZejAs1IASrsbw4iIK
 vZjxnTLc=
X-Gm-Gg: ASbGncsIEf4jCMSctF0+WFiPdQCu2OOyOTPO2gm+pqNcD1vyQ50YcAqWUInV8q5ruX2
 3XnGiQrbDu/RN2map4wPkouNjH7ICPWGzZZJOwtyp3SwBubKt1Wdz+PKyOmRGQRxir77qOR7boZ
 ok08Kf8jflSBjUwzWItHFjgyW4/60o0yk3S4ZAwrlCoGnLF7JDBL+PzP6V8Dj+vd6kthnbyTD7L
 IOwAn0XRZuxKiBs8VoqatqTVwskGJ35lkJkm/k33V+I+aPH5HAb2YhYDdOGdO3p+vnsMFD4LCP4
 MLR/cb7MjIz/maHp88UDMoQbzXMZmtePLACulQrNvPu5xMsVq2FBuwnxWoEamd3Da0hcOMTF7Jb
 OTB4UJ/gM9a0kuiC0nOYuy9JLhZSpDdTkDEgxfQPNjxGWmkzloXssMD4D
X-Google-Smtp-Source: AGHT+IGILMIP9EzgKSF7B7XfyfZJadRtF4xCZ2bc/2PFxARpTKak6xVrtQMmvcqrzv7wHMx+SJt28w==
X-Received: by 2002:a05:6e02:1646:b0:3e5:42ec:136a with SMTP id
 e9e14a558f8ab-3e542ec1a1bmr128543445ab.1.1754921025676; 
 Mon, 11 Aug 2025 07:03:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e5594c1991sm1872475ab.38.2025.08.11.07.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 07:03:44 -0700 (PDT)
Date: Mon, 11 Aug 2025 08:03:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 5/8] video: anx9804: Only build when needed
Message-ID: <20250811140342.GJ124814@bill-the-cat>
References: <20250806145649.1664724-1-trini@konsulko.com>
 <20250806145649.1664724-5-trini@konsulko.com>
 <20250811143914.61323634@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jcj92upHH+blCn1Y"
Content-Disposition: inline
In-Reply-To: <20250811143914.61323634@donnerap.manchester.arm.com>
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


--jcj92upHH+blCn1Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 02:39:14PM +0100, Andre Przywara wrote:
> On Wed,  6 Aug 2025 08:56:46 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> Hi Tom,
>=20
> > The logic for how to handle this video driver is slightly odd. Only in
> > the case of when CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804 is
> > enabled do we need to have this file built, and otherwise we have a
> > dummy function in use. Correct the logic by only building this file when
> > needed.
>=20
> Mmh, this whole code looks very "2010ish", and would deserve a proper
> (DM) update, but I wonder what this particular patch fixes?

This patch fixes the problem I hit with "allyesconfig" which resulted in
compiling the file and then a function prototype mis-match because,
iirc, the header logic and the Makefile logic were different.

> If anything, I would drop
> CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804, and just use
> CONFIG_VIDEO_LCD_ANX9804 instead everywhere, since both seem to cover the
> same thing, at least with the current code, and the latter looks more san=
e.
>=20
> I am fine with any solution, this seems to affect only this one ancient
> board, (so go ahead with whatever looks good to you), but I would just be
> curious.

There's plenty of time to clean this up differently too, if you're
inclined to make the overall logic nicer. I need to get the large number
of patches I posted already merged before I take another pass at
"allyesconfig" and see what breaks again (I got as far as completing
through drivers/, on the hash I started this on).

--=20
Tom

--jcj92upHH+blCn1Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJn4PgAKCRAr4qD1Cr/k
Cl9RAP9GCzB/ZFIvJKTYKL0U3xZFzs3+zylc+izloFzKfE3JFgD/U2fPLWSt3c94
Nq10Ou0erFP+44ruKds3TCHIuPoyQwk=
=nt0D
-----END PGP SIGNATURE-----

--jcj92upHH+blCn1Y--
