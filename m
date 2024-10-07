Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C46ECFB458
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56B488CBF;
	Mon,  7 Oct 2024 22:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WzTb7dbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB5B889E1; Mon,  7 Oct 2024 22:02:09 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D7D888B9E
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7ac83a98e5eso426337485a.0
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728331324; x=1728936124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M8UNHNTv612wSf1PJXwfCDiWSKqQ6BtOHWtMHXS4Wp0=;
 b=WzTb7dbXRf/amfT6tGSvIYfJ9dXXn+id0yJ+7+sNqOVTrES80JUd1QS96KtaDl6ynR
 bmcBZRlFTcpIePF2OlYF/hkqkLAHyXy4hdC7mDGtAxIayrhOstx/ThJ69/eaoouDGD4k
 1ALKuxkWj4zWoIQ7jhqn1JBLhjzm6ax5xSChw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728331324; x=1728936124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8UNHNTv612wSf1PJXwfCDiWSKqQ6BtOHWtMHXS4Wp0=;
 b=Td9/Hg+z7ArLBQyU1OmhRh2S15nPq1uIlLsjIxuEecWlFbOvx7WS4MedEBtQL5R5iM
 atgs0I9cHCx+5py8/uT1O1xtekU7KrgoMDPcNMqaxNolkwlUynkU0Dcrj506a1jzFx2i
 eEQg1MSkLeq1/1xgYHiWmALlJOPSm/gRktkMdLCUynaiJ7/j1QBv9Sr9b6ecK5QpbgfO
 zrLyDeORcKmIOtHUdqRvspZSJ9loK67xQsfInKkQXdQj38BcLNdM+iilA667/ugqjJI/
 2QRotSAQgS+uHXvIjWAnMoj+bTWfmozDdheJvprOM7AfOmheaI09doFF8eBVT0Waaajo
 TiQw==
X-Gm-Message-State: AOJu0YwPCtVD00hP++/pyzI99gM4u67LT7cdLdZ267i4WTHm4LZ1wxMi
 sG0o2uGEVFt/qbtgq/ZdAH08SGMm3BOezZitDZSOhakdVO5W1yBqlpcSn3qD4DU=
X-Google-Smtp-Source: AGHT+IEK8jDMn7olUb1h++4pLt+FvGzB1XV4IHJQdxoGVsuDOAiqM6LHXjDd+X2yu8yTdTGqBvBGLw==
X-Received: by 2002:a05:620a:1a92:b0:7a6:6b97:4da2 with SMTP id
 af79cd13be357-7ae85f146f3mr139247985a.11.1728331323922; 
 Mon, 07 Oct 2024 13:02:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da75ed832sm29320141cf.74.2024.10.07.13.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 13:02:02 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:01:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241007200158.GD4737@bill-the-cat>
References: <20241007171505.GC4737@bill-the-cat>
 <642493278.20599.1728325064957.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ceWm+GfkXbINttHi"
Content-Disposition: inline
In-Reply-To: <642493278.20599.1728325064957.JavaMail.zimbra@nod.at>
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


--ceWm+GfkXbINttHi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 08:17:44PM +0200, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Tom Rini" <trini@konsulko.com>
> > An: "u-boot" <u-boot@lists.denx.de>
> > CC: "Simon Glass" <sjg@chromium.org>, "Joao Marcos Costa" <jmcosta944@g=
mail.com>, "Thomas Petazzoni"
> > <thomas.petazzoni@bootlin.com>, "Jerome Forissier" <jerome.forissier@li=
naro.org>, "Sughosh Ganu"
> > <sughosh.ganu@linaro.org>, "Caleb Connolly" <caleb.connolly@linaro.org>=
, "richard" <richard@nod.at>
> > Gesendet: Montag, 7. Oktober 2024 19:15:05
> > Betreff: Fwd: New Defects reported by Coverity Scan for Das U-Boot
>=20
> > Now that I've merged next to master, there's a number of issues to
> > address.
>=20
> AFAICT, all issues in fs/{ext4, squashfs} are not new.
> Looks more like Coverity re-scanned these files because they have been to=
uched
> by my fixes.

Quite likely, yeah.

> Later this week I'll have more time to triage these issues and post fixes.

Thanks!

--=20
Tom

--ceWm+GfkXbINttHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEPjMACgkQFHw5/5Y0
tyx7lAwAk0RRd9xG+mLUN8HEyzCtvVbkLP8RwWlf31Qb7uHwDtwQ3dCFY4Auwgrb
/hZi7BufP8jyeTEegUi+xDQEIhb0F7yhO0V1T4jd+H9pyMlUZEJZjvBlpp7XVe0K
iJqV+5rcswmXaZS/47JKi6hft01yjnit3AbDEZCm6/5s67vy8qkJA8aSGER+VADm
jWaV4KxzYTsFtaJnaYXpJmBy9RowQsa+sVyqXP7d9HMzmtn6qEzprG/uZg6T4aDy
b4eXeTbtDMxpXPgfIQRGlW8mdDTIvYfwyi9e6OquM/03TCtIAjp0fEgrFJLsp4tw
fy5UYz8wWDBYET3mlwRfsBUF1Wb03L9kDIttEUmigkedk+JaXwXIpBvPydvxwtS8
PHB/9esHEyOdqjmOiE07tL28Ai4anL+Je8uzxBbX3zzT7KJ+Ure9rxY92JwELjP4
ErYxwsVxbDjOMTILn8HHmewRNyZLgJ4cBve3HdZ+sPqPO6mxhcm3zxwxzHLzXhZI
Kq/9z9Wm
=1tUx
-----END PGP SIGNATURE-----

--ceWm+GfkXbINttHi--
