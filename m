Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6795E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EAF8021A;
	Fri, 20 Dec 2024 15:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mSK+H6iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A23D80077; Fri, 20 Dec 2024 15:45:01 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA75B80243
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d92e457230so19676486d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734705898; x=1735310698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m9psogdddcBrDyqAdqArY3lDLBVGvJ4g14+DpVnRRmA=;
 b=mSK+H6iGFQX4lK/YVo7zkWKohFY+ElZ+g3YHz5yB99UsOlaIE2veuSxMfx3Dpz14TC
 pD/xc5FOm71MM0rzeYXrEIihBdMzEsOgM5rBTMUKNMAc+gvAuwYYTDdZCnlXN1FFOqyg
 nU8dl6+EaRfRLqwCPg0mHaKMJQQg3P75iGhVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705898; x=1735310698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9psogdddcBrDyqAdqArY3lDLBVGvJ4g14+DpVnRRmA=;
 b=VMbILVUu9rSNKU2PMEswldsMQ0UEgUbkKUJQcepMvFKj2f44HR7Me9NrRKLg4eSI7j
 7uorMy3tGnwaYrE2ljlDemBp8OtKLiHUd9PY3LQ49xrInQ6OAz4na3ngYXqI1klsp/Pe
 +3RHtMmX0H/p3a/b6zqR3NsQoXXsOU/3DKegE4/PSdrB/CiB56mNk2ICqrtt8jDf5r6x
 4gnQu6RLU3CrIXze8+dCuT6sskE/pjufQmWZ1xwgeVoBOVC6RkrPXebmnabR+6/VHp2O
 j6JAwmntJIefPZ9CJfLUAuf3uH+mYHMzbj0L+oa23V9BuxBpo+7RYdu+QD9a7pWhq7Uj
 pFdw==
X-Gm-Message-State: AOJu0Yz00xSN9UZU4xL3k2v7hyf47ICRlUFeQb9/p/gzaOoEVQhy6B+J
 fiEdyhkHbs+MtO6gW8aaFmwGdoGf0A3VvWDu7Etpz9yesmUANMXIik/GfHCkkrBW1hYdjSKitJq
 OEWI=
X-Gm-Gg: ASbGnctLRN+NMZbpUAcuapPbvtpGFWJXPHs7XTge/9WVvCj477ua4HOjLSVkoA+Pd9x
 1mcrTwQ4AE5pXfkekuxgSjp6v/zGh/Lyr/P4MrQEocQRIEOIASjPxGrxbFWE2IoDUS3A3spXTL2
 30xLoc8mGu/hQxbKlbhdw1idH4wqveChPQYsmJNdFEFj3OjW1Vp0blFgy5+UM8I8NMqa2fPbmsz
 dkj9nLABGSwGoYLFjyas6scIiY26ef/8jziIVLZvXnX2UvOd22Q5MIi
X-Google-Smtp-Source: AGHT+IHNv432Nfr2WGf0s/AJGBvDB3QsgsjoGRrAxwPu4EiX4Wm5FZxrPgTCHxzfVW/FxbngQR3JxQ==
X-Received: by 2002:a05:6214:1d21:b0:6d1:9e72:596a with SMTP id
 6a1803df08f44-6dd2339dcc5mr41870046d6.37.1734705897861; 
 Fri, 20 Dec 2024 06:44:57 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18e3c3ffsm16687666d6.13.2024.12.20.06.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:44:57 -0800 (PST)
Date: Fri, 20 Dec 2024 08:44:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 5/5] pxe_utils: Support the SAY command
Message-ID: <20241220144453.GB1505244@bill-the-cat>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E+dOCW2Cfb/uvqeQ"
Content-Disposition: inline
In-Reply-To: <20241220040120.3245610-6-sjg@chromium.org>
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


--E+dOCW2Cfb/uvqeQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 09:01:20PM -0700, Simon Glass wrote:

> This shows a message for the user. Implement it to keep the user
> informed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Where does the SAY command come from? This is in neither
https://systemd.io/BOOT_LOADER_SPECIFICATION/ (which redirects and is
limited) nor https://wiki.syslinux.org/wiki/index.php?title=3DPXELINUX
(which is where http://syslinux.zytor.com/wiki/index.php/Doc/pxelinux
redirects to now).

--=20
Tom

--E+dOCW2Cfb/uvqeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlgt0ACgkQFHw5/5Y0
tyyOywv8CrmiX7muMi1GJwj9lj1sECMScx0nLyaZLeh2EqZFuwC22FJBTdmq4+Hq
e9ImaBg8nCgHEsvpE5Oh3G8QqXuQVDOEq9KUFJ3koG1lmnV4sdyCsOSaj6OmvM+z
8YMHGOgIihMO2TMrJ++puPwoFCBKGC4G+RZycIwtYIGDMJt3IQmwncnixoCDpH/J
Stmgb133NxwCw24slP36vNMcBCFWgBuh7X4vwWn+nmikLFvA8lukP5U5r/ojo8QY
sQAzD1UeDHTpEC9J+Teoi9oi7ceYxG3w+8e7x2nGfPs9rVitJtMkTiKsmScw3CuF
+39j+uXEqq1CcqkkPVY0T+kroz26+fVfGpd+L+0gWOrAuUWWM0ihXRKIx2qYI6KP
/5ee/2O0nmPWMGGcqiEZnv6NtUjNYpKa0PuJddf8e3eOp9rcwZIYeRCyKBUV6ZSg
9XtXWEb0qiAvD5bbzCkkK9stOawpWFcuONJ61P8kFgVSKoAnMj/i7ndiyLeGeWd0
YVflIZhJ
=g5r2
-----END PGP SIGNATURE-----

--E+dOCW2Cfb/uvqeQ--
