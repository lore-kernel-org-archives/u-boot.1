Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F69C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4489F8819A;
	Thu, 28 Mar 2024 16:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YS/hXd7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503C88819F; Thu, 28 Mar 2024 16:09:06 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554E18819C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78a66ba49dcso67179485a.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638543; x=1712243343; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0ecnMdTLnW/FN0AQTXeDH2QW0tMci06+sF4pfOAZ5p4=;
 b=YS/hXd7D3jxAl8fRWxCZ+Q2koyQROZAygYjtQpHPCjRbLsdK/ezLdsuGODEkv1fEil
 EuQ5AsPRkBPWGTHR9reH4ieIM68DmCR4VBATDQmyIOLMVW4Bc70jHbA5AlcQ492TAVLU
 72JJhLFQeIBire38o+L5Zw99xLVDkWpSYWk/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638543; x=1712243343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ecnMdTLnW/FN0AQTXeDH2QW0tMci06+sF4pfOAZ5p4=;
 b=Ft4K86BoY85EK2p3pXPnVuwJUXZ0O6klPqPNioosYsZfDK3vOrE+xdgSINEWMJ/E9F
 eW3xaTV4BMARfODvBoZCqNlETsvXCGFcd2T6PR98i9PCG8Xw1Xl8gR21o5Rz45LtAFq1
 2Iop5EUOTIBX9IgR80sQyGJVJETohXuty+buAw6cVT7M9Xh4m/Z1Q0s5V66n8wVayKvj
 sn0UmHf1BVyC/TmVQsc97G7w9NPG9IaSi9ndAMHruFtx3IFAGnFoCSjG+qeIdgy9l4gW
 X0v8qYApIzwWQ7TE5DoCJMu9TEE252yeahuCwT3GLoU7Ta9MbaUcxD71MV+jYq09EgAY
 nqMw==
X-Gm-Message-State: AOJu0YyXQJ7w7gWr83/2V4arO3nJe8E4j0WcBjHJ34/rzo4QlbQFivTH
 NbLyHOCoHE2VE34SC7bayDIzkzVH1+tu8cXfobWuaLIK1jszLY3lWgD0s6W9+c9X+gO8sklC40b
 Z
X-Google-Smtp-Source: AGHT+IHN5H9ocg0soODG0JcnT7lvantj67vGnB9CA88eqMpAzWzVafgyyXw/kkzUl5Rvw2zdzhEgdg==
X-Received: by 2002:a05:620a:b09:b0:78a:69ab:e833 with SMTP id
 t9-20020a05620a0b0900b0078a69abe833mr2776392qkg.3.1711638543263; 
 Thu, 28 Mar 2024 08:09:03 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 bm11-20020a05620a198b00b0078bc227fce1sm254729qkb.0.2024.03.28.08.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:02 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3] net: phy: Factor out PHY GPIO reset code
Message-ID: <20240328150900.GV3442575@bill-the-cat>
References: <20240318145720.7990-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IM+ycHS6TrXLDPbP"
Content-Disposition: inline
In-Reply-To: <20240318145720.7990-1-marek.vasut+renesas@mailbox.org>
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


--IM+ycHS6TrXLDPbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 03:57:01PM +0100, Marek Vasut wrote:

> Pull the PHY GPIO reset code into separate function, since
> this is and will be reused multiple times. Set up default
> reset assert and deassert timing to generous 20ms and 1ms
> for maximum compatibility in case those DT properties are
> missing.
>=20
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--IM+ycHS6TrXLDPbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiAwACgkQFHw5/5Y0
tywa7Av/d+1/L+3LfEmcMWEBuyD3wR9QgMi5ueikfu9pQ2uUniaFS9w+UpTFhbzH
WsUGLAVqGieyPpNz+dLE32ECkNh2qTVaH60VRU251IaY66fP/F1+Uggx3HSTA/GU
CBpHnE7xWYbXz8Bcrmwe2rOBVugme1lHM5aP3pfJ+2FdPUjd0Y3ECZw3b2PqQ4EI
eva2t3xFD7A/c1OyW4FDdEsaE/pARHRWNYZI+2REjy9glGh5eDNEDBBuARp6+x3k
XuLCHv2q/gDJv/rpEwl0eWI4KgYonYL/qCjgJn2QDPHfbEDe24wPAPfO6jMGaRcg
anvfVfGAHVdSqRPl5g4rSSANq7MoBXPVlbrJFQVyLyA1nfDx7cTMaOYhIGX0ZMzx
XegwEk69bqZskv4c9kMAuv9STQeQ5/9ZYnjcvUrfT9fHQ/IqJPv27zK9GoaogwFL
FenV1nXUVWA4l3OdKqAdGAWiMEOtMQPKf+cnTasnjEsIXnEeRTOzHuU7IfyLfiOe
G/AlWpsw
=3NY8
-----END PGP SIGNATURE-----

--IM+ycHS6TrXLDPbP--
