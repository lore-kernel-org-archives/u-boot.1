Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02009C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4380488A3E;
	Tue, 27 Aug 2024 20:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c0dGWmQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08BCA889CA; Tue, 27 Aug 2024 20:35:47 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02C688A5D
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf6ea1d34aso31383036d6.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783743; x=1725388543; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ceh/sKyCt9o3Zugr+Geij/hdiLZekd2stQKDxckgFL0=;
 b=c0dGWmQLIIibc6pQP1oQvQ2mltchq7k4YZvt4l6TPfR0xLdu7Y0ayEm2mJEe4lLvmc
 YwjjEY7bWXl49g8Jp8Cs8CzJxSa2RP9uyVEI6/G2D00LZWUP50eEZWFRfc3Okcl2wnzE
 aJUWCQvNGBgaCPYCnflA34vxecY9369bekjJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783743; x=1725388543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ceh/sKyCt9o3Zugr+Geij/hdiLZekd2stQKDxckgFL0=;
 b=bA0iw0hQlW6yablU6ksmpfaLpNa3MbGOnrhU1iglCyea/f2pVl1HN19kLYXJ7ATA+o
 0bgoLyOF3uqE1sPPHRz112Jc+rGAovcRy5kbrq4wRlnSiFcs+mE1Ds/2CmSQQrBthl4O
 DjVFNBYeDIRdPhhzbpCXZrGCARWOWMIZnDygApRHae8sgv/O+RTvbUV2G5KqZdRXielE
 QfGHNnGyjVMRN+0xPhgtsr+CYrq8ooXTSxyeS2kjfNyuCfeQUYJ7opdksTdOqDCwnQVy
 7P/7K87FuHqCxAarUs8xS1V2FLIsAoLBa9zn5VzmX7hs7ZGlqfNE43lrP1vyihu78l8F
 0Y1Q==
X-Gm-Message-State: AOJu0YzQns5VN4b91G7RPtgUURwHu1ss+1Yc0o/SDHeYKe6Txmoa5h0o
 Byxk7Joa3rz1DNZlXyv45iG2d7vNusgRWWJmgX+yAN/8Tmk6yOHtqUgJUX8bD0SBs20HciZhfXw
 h
X-Google-Smtp-Source: AGHT+IF+zCo+cffkltpuiuqIsl+7NhqcKVnqDLpMupMzq3QPyFfpGpnNsnQfJviHVo/Bmih+RcJNkA==
X-Received: by 2002:a0c:ea8d:0:b0:6c1:6ec9:605d with SMTP id
 6a1803df08f44-6c16ec96164mr125877566d6.15.1724783743461; 
 Tue, 27 Aug 2024 11:35:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d6adsm58151826d6.27.2024.08.27.11.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:42 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:35:40 -0600
From: Tom Rini <trini@konsulko.com>
To: "Derald D. Woods" <woods.technical@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] omap3: omap3evm: Migrate to OF_UPSTREAM
Message-ID: <20240827183251.GO2479150@bill-the-cat>
References: <20240824214822.35991-1-woods.technical@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I5s4f2CjPAT0xgLi"
Content-Disposition: inline
In-Reply-To: <20240824214822.35991-1-woods.technical@gmail.com>
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


--I5s4f2CjPAT0xgLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 05:48:22PM -0400, Derald D. Woods wrote:

> This commit brings the omap3evm inline with the remaining OMAP3XXX varian=
ts.
>=20
> Signed-off-by: Derald D. Woods <woods.technical@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--I5s4f2CjPAT0xgLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbOHHwACgkQFHw5/5Y0
tyzbAAv/VTdH5D/terv5U7F7Gq/LaBXehCA49MG4gcqInkRt8oGohLX6XOFueauX
/mX5N3Tc40AEiubxk1+xEMQ968eIFzm2jRts+WK4undjvmBdfkc1b/ZCdij5cs2Q
WifOiVE72A6JusEmEzskJgggdDI96POLBLVurVS4tM0wyApzZbiQpWersG2Sm0NS
gqH/JCOEf+phdwjAln/N9wlWkDIORWGu+CPLZw6Huet7BaNxmqv8znmpqbZHZNxw
U8u7b91EoVGlr6AWkCfCXoCwjAwjbXftR3kNHLaCkr7CFgvbfxll+UMkYwZpmzLY
BJl5A1Xw79jTj67ALVJbHdyC9F8gjljSOceGMqlVQeuOjcGTVNfXpsI2tSe5HTKa
zWwMY9IRF10nLb3JG9dyKYNTts+lGVN0RUkSNWWbIb1LZBFqqQFtXQZ/kTHIh+wn
Ps6Iti8zqyggIoispC5GzDBKCGo4Zui7uUawB/AMqTrZ0g1FleSfgg2MM0cXDxWV
vXI14lmP
=aKWE
-----END PGP SIGNATURE-----

--I5s4f2CjPAT0xgLi--
