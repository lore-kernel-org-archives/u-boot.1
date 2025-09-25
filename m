Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C44CAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 862FF80107;
	Thu, 25 Sep 2025 16:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KSENmhNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C708206E; Thu, 25 Sep 2025 16:08:10 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2338004F
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-62184a28eaaso193720eaf.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758809285; x=1759414085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/p0mSM527Ccw/h/olingUGX3e57H9ldLZ2+UjJ/Aqyk=;
 b=KSENmhNflPipqA0dH+njjvmUploGJ/t/zjIOCLEnXAmuIG5JNfB0+lA0HbfhMa2bJV
 K27mqvvbLa3tWtF0QlRUz4SQXl0jrWKHxGIxR0oITdiSSWa3h9z3l4TJzlS6n4JYB5mQ
 PED9SgSxzAMxMPhwHTHnulwOPQHtnsktC3cK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758809285; x=1759414085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/p0mSM527Ccw/h/olingUGX3e57H9ldLZ2+UjJ/Aqyk=;
 b=UliNBbgm3YXQDPrpA/JprUgtkTeg8nshZnPdRRRXX4hPYgtnGDOpwEoQOAUtqX6/8t
 xanyKb6DH07TEmwcvO1UURT4UCzkmZ8jlXOBvciOwY+eahgzZbrdf19qj2Y+NjmzduYV
 LGsRAomQeZ7XHvqk2obmUXixamebEdMSRkZJZymQMdWXqnqk9mCZ5gMGLwf4J2vBGJHz
 xJS4ee63b+M6tLB96EUadZKz8mCMz+ojPQgxBEeja23b4U6D+3urwL9bICPooYPGnku5
 Rda0lVHTkj+aFCr53IRqlzTIVA0mj94b/4sgRx7Jd6vfO+QUztuoV285hkhhmTvx1tvT
 ny7w==
X-Gm-Message-State: AOJu0YwE7DzRm3motq0IaPqUIchnH5WUujFtOWzw4NYAtA+Sz48AixLn
 1YKWQQ0FiRg53fjulNuO+CdBiB0HSxY+5UvbHcjpAcQwtP1K8a38oehKsIKSvJN0dew=
X-Gm-Gg: ASbGncvrHxqnY1UogAtPA+Ck/FLCbXXoTXsNoihWPJDVd5H9sTK7AudA/gh1No+FjcO
 02cedAhIkofP9uGUddUl5mKepr2Je79mgiuu4JcByJ/vztiIuIerr2718FXSWEHFqcwfin9qJtO
 qiuLK80kxbaJkxStESrnkyFmXZuPnNsrylae86mBNCvlDf0OCH1r9Jd/F0ywTahk4P8q9cNulcr
 ZB7lvkH3FH1ZL8AEy0s1GI8wQjrl0yYhHmaCMLDSxzSSQ3IES28ALTD70AxEnUyKhIDYyy9zj/+
 cQqwvbAM596kcua1g0iAmvcX5Y8yXDFMWAud6nKdmR6ME1iG69KmSA4os2aigFB4YG0U21okDUd
 A1LxGFi34ppcNb21qbsmZY5Ym5rW2d9tRUOvr/FyuRCxNCJMuCkLbp+Gg
X-Google-Smtp-Source: AGHT+IHnnOQfsuRnG3c0Ay9Uxxf28frruqMfmIB/J/xDFcJFUnEuUsSv7B4g4makewE0q31ph6qctw==
X-Received: by 2002:a4a:bc9a:0:b0:63d:bc20:a63b with SMTP id
 006d021491bc7-63dbc20b6f7mr111398eaf.0.1758809285594; 
 Thu, 25 Sep 2025 07:08:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b1ff15ba8sm197471eaf.8.2025.09.25.07.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 07:08:04 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:08:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Carlos =?iso-8859-1?Q?L=F3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] Revert "tools: mkimage: detect overlapping load regions
 in FIT configurations"
Message-ID: <20250925140802.GL197373@bill-the-cat>
References: <20250925134212.59709-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9x+JXlufhpqlc/+R"
Content-Disposition: inline
In-Reply-To: <20250925134212.59709-1-marek.vasut+renesas@mailbox.org>
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


--9x+JXlufhpqlc/+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 03:41:43PM +0200, Marek Vasut wrote:

> This reverts commit 588094f2c8ec9a4f7d2dcda11ffae8db8462149c.
>=20
> This introduces warnings on valid fitImages which do not set load
> address for fdt-1 DT node. This is valid, because DT can be loaded
> to suitable location as determined by the fitImage loader.
>=20
> Warning: not able to get `load` of node 'fdt-1'
>=20
> Furthermore, do not add C++ style comments into C code.
>=20
> Either send a fix or apply this revert.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sorry you hit this during the window before I reverted the series.

--=20
Tom

--9x+JXlufhpqlc/+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNVMvgAKCRAr4qD1Cr/k
CgCVAP4h6+lEbgDp4epTGrop1NnB/TcDeoHMqRoQw7yFEKExsgEA5hyiDVQjRasF
habf2ym38pZThMuFIhvrLEG5HTHaXwc=
=ocC+
-----END PGP SIGNATURE-----

--9x+JXlufhpqlc/+R--
