Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1514CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 14:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280DA835A2;
	Wed, 17 Sep 2025 16:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JAT346ZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F1BB835B3; Wed, 17 Sep 2025 16:00:44 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42238354B
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 16:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-331e80c3985so3849229fac.3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758117640; x=1758722440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/H9GBNtZXXGZkN01z8PAIWouv+gOSbl6AXIQL4Pelrk=;
 b=JAT346ZT3JsMj/bcW0VhOKFq3d9jPZO4n9NT/YJkUC3h/95CrkIyUPLL06XXuPJhEu
 b3wWHbsk+wTX5PIPKzKHVuY9Q5uZy5HXgDapc3gxY/YHbyCaq9H06dCifzOxoj2GbU1t
 +JEzpqerqNwCsXnd4zDsyTg+N2n1Yd/kAMQkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758117640; x=1758722440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/H9GBNtZXXGZkN01z8PAIWouv+gOSbl6AXIQL4Pelrk=;
 b=FBySyvcexkCnx4v1TD1JH6h/sB3NuYySOYdXo36Z6B9npGDROB4d/z01yRyqjt/8xH
 /6dDBEQ+zlv7g3tIvXbmdWpQ/926kWD6Vgm5JDqzctqLyO/uyRgkzviWiebLhZ83UWCY
 hfeiMSVnGArvUW1Io4QxNC1il/PqSchJrfddI+CLal8l6hIJ4MLQqiSMGPFzf1cPKxDK
 +yOfbYv0Sj7+KeKR/UzsyUazsKYryBLx3xw3I+A1BshioIQnwCMCL5/TJT4KToqmqimO
 OZgA1l3joygVdQ0F/6dOU1uKZQTtDHpPkKhjU4FC0T7Re9Sgth4pytChwEwcoJADCAR8
 1nGw==
X-Gm-Message-State: AOJu0Yx1rkw20X0ZK6htXqMqmFgBouIxRIv20hfsIFLhU58anQrTI4/k
 Y4e2gpPpYgjXkqmPoV7n8eFVd/0QybGZiz/shhS7/FwD1fmipCRAXYJVJB17JpPIF04=
X-Gm-Gg: ASbGncu2Gih/pIJqqDt67AQ9QnNH7wDLW5wGkU2HynS3moH4bOP0qv08A2K7sGc4kIV
 kPIiwB+zbJRsesxFQmlARlooVtLD6j414urD9Spo6OQpfh35tka/Ats+q2+dBYDahEn+y4TO/EN
 kMtJrRy7o7OBOQuWBo77BW0OslMhpUK8kaa0AohjPeG03tsav6PL736f4zz8YehDDB8foAHXwpw
 a1blbpH1wtBKRapoWTeDRaTdQ5ZWh3vNn1n4bVHFxe0rSeBIgaenReJOwnr+t2G67mjuE1Ti7T9
 nCusUj9dF+g/jA3PpwRRqD82N7bYgcWauXCaZ8LGtxzPJycfqOWCuK/edFzcrNDA8xfzejo5mUF
 x4rYoD0VqaNTCEr5Kbp0PjnlP3T/CPqLGpXGbPqkfl67WtxaXSuYjfwDExZLXd5wkx5w=
X-Google-Smtp-Source: AGHT+IEixpRWTGFPiZNpVvVm2VZE5T/t7Kk7FGiG2+Tqq/lzdsrmE9UDDfPcBNMpNuj2o8w2y3GOLw==
X-Received: by 2002:a05:6870:a50b:b0:30c:9385:bf11 with SMTP id
 586e51a60fabf-335bd28fefcmr1226808fac.3.1758117640094; 
 Wed, 17 Sep 2025 07:00:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75249298644sm5229137a34.6.2025.09.17.07.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 07:00:39 -0700 (PDT)
Date: Wed, 17 Sep 2025 08:00:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: Re: [PATCH] doc: memory: Restore missing diagram
Message-ID: <20250917140037.GI124814@bill-the-cat>
References: <20250910154039.1942458-1-trini@konsulko.com>
 <DCV3MTQELBJA.1LWFIXMOFBHAC@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rh1U5zy/yrTVniC9"
Content-Disposition: inline
In-Reply-To: <DCV3MTQELBJA.1LWFIXMOFBHAC@ti.com>
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


--rh1U5zy/yrTVniC9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 06:41:01PM +0530, Anshul Dalal wrote:
> On Wed Sep 10, 2025 at 9:10 PM IST, Tom Rini wrote:
> > From: Neha Malcom Francis <n-francis@ti.com>
> >
> > When applying the patch that became commit a2d881f5bcd3 ("doc: memory:
> > Add documentation for system RAM") one of the diagrams was missed.
> > Re-add this missing file.
> >
> > Reported-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> > Fixes: a2d881f5bcd3 doc: memory: Add documentation for system RAM
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > [trini: Take Neha's original svg and re-apply it]
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Are we sure a2d881f5bcd3, is the correct SHA for the commit? On my local
> tree as well as github[1] it is 284ef1bbcefc.
>=20
> [1]: https://github.com/u-boot/u-boot/commit/284ef1bbcefcf3180592ed48f522=
c79618099bd6

Maybe we list both, it was a problematic set of changes unfortunately.

--=20
Tom

--rh1U5zy/yrTVniC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMq/AgAKCRAr4qD1Cr/k
CkquAQDDYmmVAQC+1x8gehj+LSjoOF+Dhbz3PcOA5MbxoVUMdQD5ATN8nAAdPvyW
H1zRjBVVG7GleYdpR53+hydEo634twU=
=vn4p
-----END PGP SIGNATURE-----

--rh1U5zy/yrTVniC9--
