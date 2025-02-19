Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB04C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E170D807C4;
	Wed, 19 Feb 2025 14:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VUkevHdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D526280EBD; Wed, 19 Feb 2025 14:41:57 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D69801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 14:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220e83d65e5so110365675ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 05:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739972514; x=1740577314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EjNyyDvolwfTaPJ9CCWW1i1rFeGrfSfffKmAw9fdpfo=;
 b=VUkevHdzYfWweKapPpnjJaXUI7I4zry79ZW4Bg/K33xRV+e5/pJKd8RXlB++5XIsVn
 P0I2YDRHE9lt6LZYtY/I0wbVqrioDqtEA19ICufZjkJm4gJiX6J8LUGR3BbvEV7La+S0
 h/vrHJTBB7o/+xNzDm80Q0dpVvGlm2iJtwj1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739972514; x=1740577314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjNyyDvolwfTaPJ9CCWW1i1rFeGrfSfffKmAw9fdpfo=;
 b=pU3KpFaQ7qyqgP95yOggRwjJtJOpP6YSUp9l2VdQUBJmuYguXu6f1KY5rcVZzTfFtc
 9WVonqieWAfsvfEcZZZHWSFxYkz4SYSnczDCmAQ/nOKQ9F+91mCBuOzFsXNjh2SFGG4r
 RUIy9QfSuCRqJmpEJNvU+Y3K9w2BEi5W4gZIvlcA9WoF5hTmBO44tKBjg3p0aKglVtuh
 bbB5sODbZxOiGc3bxthNqelv64v7kFYN+Bz8gdKLPDiK8HrDO+A4WHwfNX/Oc4xw2XxX
 gdvgfLFLYlx6+yKlbs+V6K9TYIgQ6lA/swTblgqOP/KUAeaRnU9N7Y95EwVWkX7fM/65
 FHtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDvuiVLrFZNZMdYY2hO32DBbRk9JhKBm92xzFjzX5++dcbDFWSyETCExbbFtKZiTJbDljuIc8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw72Tft/1+pgFDuyiRTKFpS/P/R6tFaDIoxb1PclvR5i2VeAtpK
 UXAAJmdg4o+8Y604wItVQ8SWwEuok7CfeIi+IRZULp3E4OhNmm05u6tgZzBA54Q=
X-Gm-Gg: ASbGnctXxU8E3mbrGp26OBKD/brECE+VDGGcJ+vp9CRYRYuW8JfidvpWnZgNyF0jqQv
 iHVRqiVkF6FQoLsVZnOYGoR0HoAqB4ANqjatSajd07NluUfqJ8TKDLu6bUrReMcjoRn5OPZdhdS
 rcWv26JLlJD3EUyTbo+lAih2nrJ2gwO9yipytI2tHZWwJ3l4DK34vcNUjk9nlcvvjLFmh1hnfpm
 jpQEaTJKyl44gWb3yzY44sMrnUtDy4RrNdxYcVs4Mue6vfiDPkl0aQSItAeDuezcfbMxZOXjLyg
 AC2fRBytIEAS3g==
X-Google-Smtp-Source: AGHT+IH0S9QSPhnbv9cwBVrd4ApzbonQpYEpI+CXKuureqbBwsqdxW444/7Iy1VJGK9H0r1vV7bR/A==
X-Received: by 2002:a17:903:187:b0:216:4883:fb43 with SMTP id
 d9443c01a7336-221711a709cmr58583475ad.32.1739972514051; 
 Wed, 19 Feb 2025 05:41:54 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545c791sm103790705ad.117.2025.02.19.05.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 05:41:53 -0800 (PST)
Date: Wed, 19 Feb 2025 07:41:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: francesco.dolcini@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, Stefan Eichenberger <eichest@gmail.com>,
 u-boot@lists.denx.de, Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] board: verdin-am62: add dram_init_banksize
Message-ID: <20250219134150.GT1233568@bill-the-cat>
References: <20250210072834.9135-1-eichest@gmail.com>
 <173993068966.1662848.15295577849807842145.b4-ty@konsulko.com>
 <20250219092546.GA16446@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3PX5WnSocdUuUq0r"
Content-Disposition: inline
In-Reply-To: <20250219092546.GA16446@francesco-nb>
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


--3PX5WnSocdUuUq0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:25:46AM +0100, Francesco Dolcini wrote:
> Hello Tom,
>=20
> On Tue, Feb 18, 2025 at 08:04:49PM -0600, Tom Rini wrote:
> > On Mon, 10 Feb 2025 08:27:47 +0100, Stefan Eichenberger wrote:
> >=20
> > > Add the dram_init_banksize function to the board file to properly set
> > > DRAM memory sizes during boot.
> > >=20
> > > The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
> > > common location and Fixup DDR size when ECC is enabled") relocated the
> > > dram_init_banksize function from architecture specific initialization=
 to
> > > the TI board initialization code. As a result, boards relying on the
> > > previous setup now require this function to be defined within their
> > > board file to handle DRAM sizing correctly.
> > >=20
> > > [...]
> >=20
> > Applied to u-boot/next, thanks!
>=20
> This fix is needed in master, without it verdin-am62 is not booting at
> all, can you pick it also in master?
>=20
> We should have been more explicit on this, next time we'll do better.

Yes, I'll take care of it, thanks for explaining.

--=20
Tom

--3PX5WnSocdUuUq0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme135sACgkQFHw5/5Y0
tywj+Av8DSoDRRRxKxyhLgG1Bop/GoAmAzs70pXDEntBGLeAD5Jn42dDtvM4lTxP
Z3x0jA1YZ4/P2L7bZHQaClRzW82ELx7Cij30O2rXaLphUIyA0KvZjHWNQINTclJz
VoE0QEwuPnlyrJBBkVdTpxJpn+l3k5MrHy1iOLRteGcNjWGOmKQmlvteR1NzCZg3
tXr5NLgdmKqRjyUjMvGCt/7XjwbgS3hN1tY1a81fS1GpvzIwMkqeyoUtzdbnu9V8
Ny9iXYwS8uF0mw40qPfjg38VduTGoDAXqiH8pZlK9uann5QNx05DavziNPSHT5PD
X6ff2PHnc+t61FFI9HLERxNiku+Sq5pH4uWehsXZXb9XARn7nyrPqCcEVnX9gU6z
14IuQdqnWkZpTBiBB4Kit140LJRe2/xlT4to+HUZ3X6VIhyEdjLSTG5ADcLsL+bS
KMrXrtf2zTt667z183/t13CxwWbsQvWuiNbgv5LkUg29IWJvA607rNwgSRlR078m
YRc7G6Li
=jeUP
-----END PGP SIGNATURE-----

--3PX5WnSocdUuUq0r--
