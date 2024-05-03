Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D98C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F31881C4;
	Sat,  4 May 2024 00:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DxelA5iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB497881B8; Sat,  4 May 2024 00:21:06 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3A4881A6
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c6f6c5bc37so61002b6e.1
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774863; x=1715379663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aNul76BUqGU44TViHBdK4H8xd9QX0qXkxpqc1NP5SDs=;
 b=DxelA5iG74tvSOzARHwsj6Xli5/7gFcPlOb2uiRqfIoBrMl0iS1uRsXK7+JKn/ffjm
 tGP9TGTtwCJ44hujIP/Bp+HtKTJ2oYc/wv1+jzemXCX3zT6NPTQclroQZrFUDQRZdgp7
 zy8vXLy1UV4618+bThoWHT4ZMhHXPDpUuKWyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774863; x=1715379663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNul76BUqGU44TViHBdK4H8xd9QX0qXkxpqc1NP5SDs=;
 b=nMNF76+b8tR1og6DPLZ/ikTE0XqyjG2xWgMte+7GXn3M5isy3eJ2/hJO5mr8IG6lfJ
 2zzGp7pJIUXW2aGoOgwtDmwxzYbrjGz0jjndmxwQZ6+bIeUTR0F7JTp/5WQ4677QSx8U
 8bGFrfOafuLlWGvgU3WYOwfRK6FX92ib7rUXTWme2Ub15Ho4TSVDcOXDfw1FeSqqTUhp
 lHsgUZTsBoLzTslgxXIu3X/DXl63ckBHUyol0fCS/W6rxjFxxAPo9ZrpgyXA/ioCh8HN
 d1oS8WYiT23vxnwZ0ZyFRlPt3B9oFGVVdpQorCt5QMnrk5J2URaZGzA1Eq1zsnpXl+T1
 O7wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA42YiDi/cAZSo0b792B7IT8VeTAUe1GVPgLIbNu7y9fi4jrgwEaUrsyo2JY6PE6WgBkW9zBM5zXVZsb/QYrNXHlMcWg==
X-Gm-Message-State: AOJu0YzprjgkyWgKBPYY6CZMW+17UwkDh4V6+BF7BxbMoKWUjvaYZ0Yi
 YEclls5ujIUxzRuhhIGovWjz/4sEKB8Z2Z6HpgsDHsqvvm+ERFR02Q8MRxry+2o=
X-Google-Smtp-Source: AGHT+IFo74CPidXRl2qbJysnyg7kQUJu9XEXjXknKDa5th1pmeAzuNK0hcZT3q1qEFvGKKN4/M8LPA==
X-Received: by 2002:a05:6808:d4c:b0:3c7:ef1:483e with SMTP id
 w12-20020a0568080d4c00b003c70ef1483emr5095276oik.39.1714774863435; 
 Fri, 03 May 2024 15:21:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 fy5-20020a05622a5a0500b00437a6e5b3fdsm2000552qtb.66.2024.05.03.15.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:02 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] tools: typo arguemnts
Message-ID: <20240503222100.GC2568172@bill-the-cat>
References: <20240419113746.73110-1-heinrich.schuchardt@canonical.com>
 <20240419113746.73110-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A0iBIgrlyo1kDBQD"
Content-Disposition: inline
In-Reply-To: <20240419113746.73110-2-heinrich.schuchardt@canonical.com>
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


--A0iBIgrlyo1kDBQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 01:37:46PM +0200, Heinrich Schuchardt wrote:

> %s/arguemnts/arguemnts/
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--A0iBIgrlyo1kDBQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y0wACgkQFHw5/5Y0
tyzh6wv+KaKPWKzgfY4nyR3E53MGdY7SDiQ78cMN99eDE0JW8IIc0MdIuQSnC1L2
ohnx9j5RSK+bjDAnn2ZaFGE26G9cffky39fxtDw1qTk/VjIkXfG96oDshvFlD7qI
HXg8uofwngCITmtfmH+Brrcpgb631ZNbrBJr2stmk9/Iz9BvwiFbz4RFMMDIV+eA
aSPU5eDg2DeRq9N0dOmrzVCkU/YwA/jkK7Cas4iDlLiOl3vAxoNEHaMYRADn/vDf
/kAB2QMNSecY4LRRGdmojMi1VZBFAlvOyLWD3aqJ5K1B4Tf4R0GGVPZofss6qwkv
x+lH7guiF2618XTFGfE1y7fjqlTD6ejsL+ZKR0fiki3iRbv6GSJsJRoG5wZv+jFJ
9g8KJI15ZLdP79xJVxiSB1ggfunjfpWZ53fIdcxXRuNAISdTjEPd0s3XUMoy+5Dj
BREPxFCt+i1aQ1UbywnGffTCX+gAkQOupmAbgZr55Ph6mqTlTp1zIojzKz3ITFml
PHJEGpL7
=8wiV
-----END PGP SIGNATURE-----

--A0iBIgrlyo1kDBQD--
