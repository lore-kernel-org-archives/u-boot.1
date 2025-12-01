Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA1ED116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 14:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D490A83B5E;
	Mon,  1 Dec 2025 15:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FMlzpQTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B749E83B63; Mon,  1 Dec 2025 15:41:57 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB4D83B5B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 15:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4511f736011so2337679b6e.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 06:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764600114; x=1765204914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y5vbZ3XnLISH8undUnW0AV13sORoLnbIWBbMmmd0Hcc=;
 b=FMlzpQTtQ2i7UR4/q6uy8iW/JjFr50GIufvvJHmEG9/mWycRTHoZRvNulQWkTbLmLP
 WfZo8YefwPKjkFIW2zQkyFSrO0DdrZcfPpyyp/xNySV45hjQxMAsN4QpbKcSMxRvgJ49
 dNORjBgRHB2zQ6ahiUv55pQqVozWAGze1K2JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764600114; x=1765204914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5vbZ3XnLISH8undUnW0AV13sORoLnbIWBbMmmd0Hcc=;
 b=qyz0jghahH22oXlJEeAsOV4uiukJizLyR3z2b+el6BIFGQaF5DdW+oZs0rxnZD/tu2
 uO+OnV4gGVkMd8Rs6FV/y8XZRkQkBi3eUMGqkFhN7oSLnT0CTU34vMeUyJn2fHEIaI4P
 c7oKIhHZyH46v2n0RHf86gP3DIkPn1hbB3FV1tx1RqPnB901Ttgjott/zPxsyvxKGeDt
 QYQntkp4FS+6u8Na9ZPEFXszRqfs1Jm2f1pMR/TEEQ4OfNNKXg9qmg8m06Lps8E6d0xZ
 s3pKAeunNZxkkgJW3sojVuefBFh18sSsAKuE5/A9cY9K7YBri9UdKl6CNnhWCc+GrNWO
 K0Dg==
X-Gm-Message-State: AOJu0YwmzLLlOHIx13uQLe2Q1mgVSiAtCluilGt0pnQQ+dtYu5fYnMpz
 u9YkCiQgu1wNu76RYzgkeHDkwIkfTQblEOLDbuMsqXKU0u8qc0kz9TQtwzEU20jyqMI=
X-Gm-Gg: ASbGncuMuuQF6P6byAfDtZxecCxO5wI0q9zp7M/bRvx2nv5dVAwZBxHf8l9xTX0TX40
 4LBUeMB/uQzQ2VE2QmjmWWiUnAYtAc0Sb9e6C4UFPJhx1btsczSCgbzSVgMZicqo4sJqPxYYcls
 K8Y3MBT1GiGCHyyWthUatV3w2HDhJNMV8Khq3WCLLSGkcyKEDGqoUoMBYpOvQ7LJ/9zGbBk2y8+
 JAqGdCNkRexkxA6IVjS2deyYhwCAq51s3QZvhbZ5z0P/yDNLW34az1Y5KjgoqZL1IprNJJeqJeg
 nu5s+bM9kIIKWKKjL7uTD3HVegJKp0qyMl6N9aKxBDWL2druKfqdb6nXHr/ncfDB5V/SK9Z9C0y
 vF65KhXpcx8OkxHf9qMMq5FGfg2DKeSE8Gc2qNI5M8GNT/0VrJPJ/K3I3Y6OlwGG8S6Ugmx3L8H
 5enmdMLLy0WkhTf+Yj3iaIm1D/i02abnY+xAG5UAdzVhoUUYf75Q==
X-Google-Smtp-Source: AGHT+IEUqPbe7ihu5EukXKOHgXutTxJ5nQ8dzBdo1x6Y7dw2ZjmWMcw40f46rmUw/D9pDYr99VzkOg==
X-Received: by 2002:a05:6808:3c46:b0:450:cfe8:28aa with SMTP id
 5614622812f47-45112b65f08mr17191048b6e.28.1764600114111; 
 Mon, 01 Dec 2025 06:41:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45317112a7asm3633621b6e.21.2025.12.01.06.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 06:41:53 -0800 (PST)
Date: Mon, 1 Dec 2025 08:41:51 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, peng.fan@nxp.com, alice.guo@nxp.com,
 sjg@chromium.org, davidzangcs@gmail.com
Subject: Re: [PATCH v1 1/2] imx8ulp_evk: Move environment variables to .env
 file
Message-ID: <20251201144151.GD303283@bill-the-cat>
References: <20251201105657.1968244-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X0fYpnrn2vPYdg6q"
Content-Disposition: inline
In-Reply-To: <20251201105657.1968244-1-alice.guo@oss.nxp.com>
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


--X0fYpnrn2vPYdg6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 06:56:56PM +0800, alice.guo@oss.nxp.com wrote:

> From: Alice Guo <alice.guo@nxp.com>
>=20
> Add board-specific environment variables to imx8ulp_evk.env for better
> maintainability.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
[snip]
> +fdt_high=3D0xffffffffffffffff

NAK. I just the other week sent out 40+ patches removing that setting
=66rom other platforms and you weren't even setting it before.

--=20
Tom

--X0fYpnrn2vPYdg6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS2pLgAKCRAr4qD1Cr/k
CiQ+APwLyx8mlcF0sV8pQV0YOWcliwG0pgRw/kgvNU1zOuKUSwEA5xPtEX1LiAbF
Oy947E3cQsKtsvxH8Q8NdKshsFhU7Ag=
=2G0X
-----END PGP SIGNATURE-----

--X0fYpnrn2vPYdg6q--
