Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F96CC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C075887D2F;
	Fri, 19 Jan 2024 17:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g/0Un8+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83D687D2D; Fri, 19 Jan 2024 17:08:48 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D286F87D28
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ff9ba70977so8630697b3.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680525; x=1706285325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yu4XLBlJXfgsJqhNq5wZr2xwpDY750c5x6LEnmmTNoY=;
 b=g/0Un8+WA7p2rukBnkR1kIA4ctIzxiLC+w4TGeApijzzhiE8oEcPDPjbRx1syoCJ4/
 FrJNxvUnbDfbdHMPJ+q2nNcTKb8Lq2vfogeVkF3tb0PWIzVUFGzVba0A3kEfpixkvdp2
 OAX6o46Dt1c4jKgRR6PkeBsNMofXTLcnXuWtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680525; x=1706285325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yu4XLBlJXfgsJqhNq5wZr2xwpDY750c5x6LEnmmTNoY=;
 b=jAoFRDTSbfuQtBqo5AOf/uKJdBfeqwG8imlG1g7Gtz6fZZxoxS7ojTEGNAKjq/Liv3
 102I+3UwFea64UHSgamM6IG4OfAFCi5HyJISphKOhCb05oGRhaZZ6f2qVscM0Mv7mtab
 NSpA/cXITDp5Gk5QwVUXANvvZ0O4uMv5DQFBb2x7fKEpEkRJKTibW+ZoJm7F5rS5BP+l
 Jv8Rtry0BVxoge4U5bNJ4AF++rtvt5+PaeOQMIlV84/2v9DLGG9QUvyftGJ7HF/0yHoi
 UEZtcyZECdQ3IYv4wylTwtpAlNUtjMWT6KYiXuC3029B7kNdAABFAuSei7+lBlrbYjJD
 1itQ==
X-Gm-Message-State: AOJu0YwIhjkb7N8LxEcjK7uKfg2FSGyyjP5CobZyVNu7e/E6u4bBnVKq
 gw9ApDh3fF8LqzTerNS24PJETqooKlvZmhIFgGMUXysEpHfIdriZUPj4kLU32mI=
X-Google-Smtp-Source: AGHT+IE7hWk4jVfVP8yVQ94qF2/omgYLTTKGQWiidrcZtz2pRWYKPNG9fFo4FEffosnq1KuGhZf7Fw==
X-Received: by 2002:a81:91ca:0:b0:5ff:9c47:a95b with SMTP id
 i193-20020a8191ca000000b005ff9c47a95bmr119673ywg.47.1705680525644; 
 Fri, 19 Jan 2024 08:08:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 m195-20020a0dcacc000000b005ff4da78ec4sm3390232ywd.130.2024.01.19.08.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:45 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, vigneshr@ti.com, bb@ti.com, m-chawdhry@ti.com,
 alpernebiyasak@gmail.com, nm@ti.com, u-boot@lists.denx.de,
 vishalm@ti.com, jonas@kwiboo.se, sughosh.ganu@linaro.org,
 lukas.funke@weidmueller.com, fr0st61te@gmail.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 1/2] board: ti: *-cfg.yaml: Adhere to yamllint rules
Message-ID: <20240119160843.GQ12635@bill-the-cat>
References: <20240105113917.1117945-1-n-francis@ti.com>
 <20240105113917.1117945-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jtomhcq1a1czxTK6"
Content-Disposition: inline
In-Reply-To: <20240105113917.1117945-2-n-francis@ti.com>
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


--jtomhcq1a1czxTK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 05:09:16PM +0530, Neha Malcom Francis wrote:

> Clean up all configuration files to adhere to yamllint rules.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Suggested-by: Nishanth Menon <nm@ti.com>

After fixing more yamllint problems on newly merged platforms,
Applied to u-boot/master, thanks!

--=20
Tom

--jtomhcq1a1czxTK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnosACgkQFHw5/5Y0
tyzleQwAk3drBn4gwASKhWQrLf1tMkUELBPtMFe7ED7dl5lQySbSDXsk7DemiN9M
6Inci//MbfPXc8PYU9hD1VmU8ugqTZFK7cCYXCEgFOmP4qEKoIT69Aty3AY55OHH
m+6q5Nnue2PrZTs/ysWQD2xf1kKD1Zyd+Y1vvUVgY0szcHrfrqTVdoUX6A86rbOS
rGGIleqG+R/pj9SmcaKlgZdSImKj7dR67SYBO2ciMWtBqRQGqqYwJP8NdxQD8Njz
q0C+7LaoFgXNkDJe8tAg1riXpW7lUs0a2KZqgf7Ir5mJwvKLhiv2cA3tLRmgWbJz
gFEJnXOpxZklDZ8iPa69nqIk1SY4tnXcaGRJxMV0Ma4gV8ZJByF3sevzCrwx+S1F
mc93nC1wgO7l+6l7ZVCDCvV1OFY7fSObtA1T13JdTTCBVY1Mm87hzY3JBl6HHicd
yFQzyiqn7t9mbde67HlNkMAYY7lYzXa5Ig7N60M20NIwRu/PmYetSq/g6/6HbMS4
bUqdCa2b
=gzlj
-----END PGP SIGNATURE-----

--jtomhcq1a1czxTK6--
