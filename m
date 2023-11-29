Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B4C10DAA
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 14:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF64F8701C;
	Wed, 29 Nov 2023 15:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="owKebTtp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AF6870FF; Wed, 29 Nov 2023 15:24:42 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F09E86F38
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 15:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5cfc3a48ab2so37029527b3.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701267878; x=1701872678; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HgqbJHFefPmUNb9l57V9tGPlA2WAlZ5h5Rvm+iofMi4=;
 b=owKebTtpNN/g3SZNpRjH788/HF+Hy4YjnU9VToTh8jPWLcq7LFL+AKJoIeAk/00PXq
 Xvrmt443T1LlHCyB6eiCqRLE2/N+rtAwzCWGM3r+h2zwyPetXbVpzHAp/zvKDoMj6MI2
 G/FDmlRouaDZRBaGMiw18QntIOSktFp+4SsWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701267878; x=1701872678;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HgqbJHFefPmUNb9l57V9tGPlA2WAlZ5h5Rvm+iofMi4=;
 b=Z2K6YeAomxr3WIbiJusbma2JvX48XJT/eis6ZbcaNHtrXTC3Ku1jpZ5VpE9QIiNCWl
 ItnC6BXTQiNyGSQRvVSh9oGeN0wVZNRYFjLdHVFTgayvPhEnZaV4hCs8DDtVKjaMv0lo
 LUMUuK+daE6S+qZ98vppaPgIGXR1+nAj2HU16DDiKrhk2Div42TCehdPkAoBu3Z1cYhB
 WJNYpzOWugcaQB640sTH/FxKjo7eXaM5hPj1Tp5DHH1Js8ERxo5+ySvsVz5EtX588FA2
 LGzcUc54ZN9iL19hexWpOexxqi0svL079F5FDZWzIqQRUt3DRkVzvjC9PJYbvJh00TUN
 M9jg==
X-Gm-Message-State: AOJu0YwjgSjZ3UynTvlPKAAZWYWAop6fho7o6vqBMrv49yUKpdFIvEdH
 nOkn9BDDWGU6yLUiHFzd9cebSU9IPuWJr6izSm+wIA==
X-Google-Smtp-Source: AGHT+IGIaTEtG3GSuhqIG7JyPzIO+VTKbKQlF7YPFlL/ZOURl8j0qaoETrjv2M5PvZc22z/8wkgHZA==
X-Received: by 2002:a05:690c:c18:b0:5cf:9ee8:87dd with SMTP id
 cl24-20020a05690c0c1800b005cf9ee887ddmr13065859ywb.1.1701267877869; 
 Wed, 29 Nov 2023 06:24:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 h125-20020a815383000000b005a7f676f305sm4518642ywb.106.2023.11.29.06.24.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 06:24:37 -0800 (PST)
Date: Wed, 29 Nov 2023 09:24:35 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Intermitten Azure CI failures
Message-ID: <20231129142435.GE2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gnDpd3iLKX8xqKc5"
Content-Disposition: inline
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


--gnDpd3iLKX8xqKc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

If you see a failure in CI that looks like the one in:
filenamehttps://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D7436&v=
iew=3Dlogs&j=3D6ebe5bb0-481f-5026-b4e6-2d4192a94e80&t=3D66c5926e-2461-580f-=
927d-c0d0a6120549&l=3D524
Which is:
"FAT: illegal filename (.)" being printed instead of "Unable to write",
just hit the re-run job until it passes. I guess Azure changed something
under the hood that's causing something to go wrong somewhere else as
it's neither consistently failing nor is the test itself failing (we
continue to not write an illegal file).

--=20
Tom

--gnDpd3iLKX8xqKc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnSaAACgkQFHw5/5Y0
tyzsHgwAlKh8IqMQ8nNbovpCQOSSNsXKCbDhu829NY552A5P6G+FXyaxoM825bsI
8TiXBW7t+KRYYGjE5pZfSlrMmRsvswoh56SpMexj4P9vDdsVdx5O5nj26HzrANvq
5xwQ+ufGjx64EO0wFhjIhXfjpgI0Sz/vbko2WZEGqHqCOOb00QKRMsb7APJJkLQh
S4PfoZjhBUzV4xyOS+0Tvmzv0/+B0qQIuJ/WXHittJI06z2MyrhUIbanynWUIE1e
ge9WujXyUQ7g5niVQ3ZMdpxjGqpWq1gpZe/psgY4Hc0df8s12fB02uUmEnki9wgT
gN/Eaz++pxTbmEJzTfCcaoGVT4Sfah5Zp5dNrX3rf2qA+ckkrJErQbzYwM+tBWKP
UCGzuwBa7qx/k9L1BSp06DODPg11GPdI6Hov5DEflAkHGBhIBA2YhGN/tNIpj9+9
IEpAL4cuJDM7VRRXzwMmDdibV44dGFfi1j98IZAwDIxZrsBfiQ8cNSbqPMy6pcXo
R3JC/Vrj
=xs6r
-----END PGP SIGNATURE-----

--gnDpd3iLKX8xqKc5--
