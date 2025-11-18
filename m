Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC31ACED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2D683D52;
	Tue, 18 Nov 2025 14:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MoLXKsj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A78283D5D; Tue, 18 Nov 2025 14:57:37 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2AC283D39
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 14:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4500a6fb71aso2099614b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763474254; x=1764079054; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eAA6IiwhqSCICPanKo3REYL3svY/E2/8BhIXV51pOew=;
 b=MoLXKsj1iNrPnlUEGLvxQshWIqc0r6iJsRB756OKpkvr2TcsgBYAnzbcWfdAScH3Kq
 lWierZVVkoW1lJcaif6CDmFPz33Xmmccjgu1+0lQeAvfKljEKBoZ4+9X/1uRk5JuHFKi
 rXimR9yrJyPZzzRdTKYULDNrr6V4+DvM0TFhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763474254; x=1764079054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eAA6IiwhqSCICPanKo3REYL3svY/E2/8BhIXV51pOew=;
 b=BuEp4MninFU2vclXbnpdNUSNcYCFG2e/dyGobPN663hVC2s/O3f0qWN3HForrLKHO3
 QYRDbNU1LVKiV+jx3QhOo3UD8V4TcbdIR43xWDUhuQFIlPdfZleBMePRjT52MCWSbD12
 OlDNbFi0ObnepxZfeLDkAUUm2TN2WO86UpPBkgYKpcIOMwJfJXfBSuCCs/kCNKtGN1Ad
 lCWv9WRGV8yXbUT4Pfu/Z281jbnKwzm149Cq90GfeUJyNmVhggw5MjkDwj5K60nfJAL9
 z2ouc7LdpAu7zBPITjHny52Yn1/vnLGqkHnsIfYxBshx1wf8kAHAYpsPb2LyTzQ3WeNa
 426g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRn16Ok4nv6tQwaX/Zmew9sq2RcJPYsMJztXlcL080r1TI2PZTlAIGzlY0UEyFitpT7U7K3/U=@lists.denx.de
X-Gm-Message-State: AOJu0YyEmAFRlwFL+C43ZBmRJwAOms3qjUTaCselpR8U9oVKEOPqcqaa
 bogEsw5CjkGtp9L3RV4DTiVhEW+ZXWA8YVscKEyM3lGC/HOvcHoJC+gtYh2+nq/y5Tw=
X-Gm-Gg: ASbGnctJ36ncivq48Bh28i7Tbo9pG8njlgIWCVpm8p4F2d3+GP2l9NyRiwkfKbHum4M
 uZ4sH/zsRFA5qaEXze6RkBdH11L6ktOCvPeWimkeroZvwm4DlSE3Bv3SjLYCrVeHGhANv8ognio
 SgHQ17KZmqZN8QhlRGx5tqwUF+tAoREw11gUvJL/woZ+QHvAQn3WfCHLyHP659FK3I5i5kneX8+
 FoqtHGd/uMeF7qC77dU2PqrobtovAdEUZ/iUIKn5MFIrj1qZBbRo5ClXhtoZjH9hWTjJx4S39rk
 faK9G5GVlXfH44Z0FrW42UOP1OPLEWxHx9+XzORB0ixNce60+z3IY6U2V7YpF4LVxwuQlTPiZXz
 PAaD0cp7NfVjivAtrLRurt5hfN7V6Sr5DW5Q73wV1d708Efpcgy7wcTqtGHsE/vQYccgNh7ja34
 BDBtHQfzXDe0QsQkeZbZ5p3MJITPW+JpDp3GIE4kKzHltU3MJ8Y8WqwI2d4rU+
X-Google-Smtp-Source: AGHT+IF+qEb9WiBczHKfW86PoUtIqvNeL3UGpzFBvPZBDyI2aJgwx2Tnn0pG/FeCgKc767+LeoyqYw==
X-Received: by 2002:a05:6808:5294:b0:44f:e512:4ca2 with SMTP id
 5614622812f47-45097587d04mr7347085b6e.40.1763474253667; 
 Tue, 18 Nov 2025 05:57:33 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450d5ffdc84sm1278107b6e.19.2025.11.18.05.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 05:57:32 -0800 (PST)
Date: Tue, 18 Nov 2025 07:57:30 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Duje Mihanovic <duje@dujemihanovic.xyz>, Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>
Subject: Re: [PATCH 01/15] board: ti: am335x: Fix DM_TPS65910 condition
Message-ID: <20251118135730.GO2125796@bill-the-cat>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-1-91ce13c661e2@baylibre.com>
 <GV2PR05MB1194108EEB54378B8A1FDC16783D6A@GV2PR05MB11941.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0BKAsObl030E1xUr"
Content-Disposition: inline
In-Reply-To: <GV2PR05MB1194108EEB54378B8A1FDC16783D6A@GV2PR05MB11941.eurprd05.prod.outlook.com>
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


--0BKAsObl030E1xUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:09:36AM +0000, Maarten Brock wrote:
> > From: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > scale_vcores_generic() calls functions implemented in tps65910.c, not
> > tps65910_dm.c. Change guard from CONFIG_DM_PMIC_TPS65910 to
> > CONFIG_SPL_POWER_TPS65910.
> >=20
> > Fixes: 0b9ff0851592 ("board: ti: am335x: Do not call disabled PMIC func=
tions")
> > Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > ---
> >  board/ti/am335x/board.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
> > index
> > 712818ec23562fad85febf6616aea3cea1a3a9ea..90e37a8d91330365bb5f27c37
> > 1be7b9749de9fde 100644
> > --- a/board/ti/am335x/board.c
> > +++ b/board/ti/am335x/board.c
> > @@ -429,7 +429,7 @@ void scale_vcores_generic(int freq)
> >  {
> >  	int sil_rev, mpu_vdd;
> >=20
> > -	if (!IS_ENABLED(CONFIG_DM_PMIC_TPS65910))
> > +	if (!IS_ENABLED(CONFIG_SPL_POWER_TPS65910))
> >  		return;
> >=20
> >  	/*
> >=20
> > --
> > 2.51.0
>=20
> Acked-by: Maarten Brock <maarten.brock@sttls.nl>

Thanks. Can you please split this out on its own (since I see Kory has
feedback on this series as well) as it's a standalone regression fix.

--=20
Tom

--0BKAsObl030E1xUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRx7RgAKCRAr4qD1Cr/k
Cmv8APkB3dqLNFypRfx1mr70S42xbx3LWMrgt0QI8FSearlUmwD+KBoRKygXmR28
wTNYYQY6lEFeIy9Qeunhi9KVj9EAbQs=
=+TAZ
-----END PGP SIGNATURE-----

--0BKAsObl030E1xUr--
