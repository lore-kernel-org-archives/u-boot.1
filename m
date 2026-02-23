Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A66EA4FCF
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 15:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136E383935;
	Mon, 23 Feb 2026 16:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPtAdFSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7137783BC9; Mon, 23 Feb 2026 16:24:41 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A035780077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 16:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4094b31a037so2696708fac.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771860276; x=1772465076; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GiGVUpC2vuJ9jIkvUmHEe0dN7bwWBJVH9wUn9VsiNx4=;
 b=BPtAdFSca8siv9HvaLumpNdYewnXvz7wYgt9rN7EmgzyabAHdkHo6+QP/q4EKfMccw
 4R1D8IXOoI8kiUVo5nHszLT/WZCiQAxKA6xJsPg4QdAQfZTZ7D6a0G2fHluxnbhYpsS0
 mOqO+tPyQZSdePdiTAK7uPXetOmVxOyGEw2PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771860276; x=1772465076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GiGVUpC2vuJ9jIkvUmHEe0dN7bwWBJVH9wUn9VsiNx4=;
 b=LQ8CNJdhocwZPM9t00XOq9ZZjYGLgttHUU3TdgDbDgOv16X/xMcOPvJ+1ayngPElQG
 W+l5ibXpKxG0gQF/2vPaev9j1ArX7Agcno3EO0D0HgHmI65yTKCs4v6eexDj5kG7mRMn
 AI/G2q78EKEv0UhpBYxRXQPkXjvxBKl1jPPEl38YuaXWZrikL4wFTy0VSPK8InerbWiA
 IhvunQlDWjcnTZ4BosrHzQPbaADAo47Sf1nuUP/R3LRsH0RVE8hZx+gS6HKWBY5wS7zO
 6NsEOHFTMQfwmCqGz4iH/zB7WBIkX7rj0BaxzFN4L7kyi5l/mP//XPvQBBid47QdB1Ol
 tSjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTns0pClIvJhsypyg92N0K5DwNUOEKDDwowWX0PKcTHf5Ot6aD0jj0AgSznp9ieGI8hVUbRko=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8nM9PRV1MHEy87MwMNc+JOHgQ1/n5GVy0C5CMjaLtl7aOmWgw
 ok3TYMDDxtqvO6W8j4cwrKuWS0qr6QhH3bTiPFzfTSZ8dcVDAyExFNwvQDD8IRDNJRg=
X-Gm-Gg: ATEYQzzCqFYh18ZlzL5ypLVwk+ZPP1WKTY3Wdndpd9oD/2PDfo+z0B9g8vtZ2Imh7SK
 69W1qG3y/UjUuS1gp18uyyORbGVZlm19WNA+jW9SWjOi/0cNkvB5spIwIahjDYFLAPqCreInfgy
 Iv4CUuDvxOllJCwlMv+Q7AOU3YixCzSpRX/5iXxIUDHflAzgRRDP+/T2o9ny1bncVnRSMgWg26O
 y8cuDkh+QooEhrOrT8J5aliPdzvieBHL15r82DJZH0WMtXUETyN95oZrHOhoCfo/VLyT/qjqPU1
 Ib4SpLvopgoSjZysbLHspXg5Z8xS7x6knfGD2VSOYeZyIgES5FSeBirRtdiYcHTDYU7zGSGZIg6
 wd7n80LknFQLZoD6YX1L4tmKmXCJZwDzx86i3Nk9TfgbIxZNGh9wBRLPpucf+5AAMQ2mbYXvb01
 KmBV+jgHmaMfNMj5s5Wu5mGDT4j1pmEoEdNW0nxSUo+ANxNCsS+DL786wNgoR5/D5Uv/iI/0vXi
 R2DYFM6Tz52nqqFLTDSXkxjL5ZJgszCbJVnaawOJj4EOnrhoAk=
X-Received: by 2002:a05:6870:a116:b0:3f5:5af:c9de with SMTP id
 586e51a60fabf-4157b178c57mr4518418fac.51.1771860276128; 
 Mon, 23 Feb 2026 07:24:36 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157ca3df7fsm8097473fac.0.2026.02.23.07.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 07:24:35 -0800 (PST)
Date: Mon, 23 Feb 2026 09:24:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: vigneshr@ti.com, u-boot@lists.denx.de, a-dutta@ti.com
Subject: Re: [PATCH 2/2] arm: dts: k3-am64-evm: Add "bootph-all"
Message-ID: <20260223152432.GC3233182@bill-the-cat>
References: <20260223061906.1794872-1-s-k6@ti.com>
 <20260223061906.1794872-3-s-k6@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zU4YLQWV+tReXK4b"
Content-Disposition: inline
In-Reply-To: <20260223061906.1794872-3-s-k6@ti.com>
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


--zU4YLQWV+tReXK4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 11:49:06AM +0530, Santhosh Kumar K wrote:
> Add 'bootph-all' for 'main-bcdma' node to pass it to the FDT in early
> stage to allow the BCDMA channel 0 to be allocated for OSPI NOR reads.
>=20
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am64=
2-evm-u-boot.dtsi
> index 6469f43fca81..5048432ef8ca 100644
> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> @@ -42,6 +42,7 @@
>  	      <0x00 0x484c2000 0x00 0x2000>;
>  	reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
>  		    "cfg", "tchan", "rchan";
> +	bootph-all;
>  };

What's the status on upstreaming that whole node right there? Thanks.

--=20
Tom

--zU4YLQWV+tReXK4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZxxJgAKCRAr4qD1Cr/k
CrAOAP9VZmnrmpGLzMaepVKAhEQRO1KvMxhXh2Ruz9ccjbZqCQEA7n/KzJa6laa9
E6/HquFg9q8aEuRewypjC+YJ7+qteQ0=
=aG90
-----END PGP SIGNATURE-----

--zU4YLQWV+tReXK4b--
