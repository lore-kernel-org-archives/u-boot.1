Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2162AC71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 15:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7607A82CBC;
	Fri, 20 Jun 2025 17:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B3ZNYi7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDB682CF8; Fri, 20 Jun 2025 17:28:34 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0FC80E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 17:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4067b7d7e52so458659b6e.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750433311; x=1751038111; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SqqYjTCCNhTRdYU4jlOrobDgIdzphtaJrFc4/9AfucE=;
 b=B3ZNYi7HhY/vl1FDCtZ+wT3c7GiT1IBSOoZDwYonIsIBy+l9p9XrcFuu57LUNG8ld+
 g85SAOa764t4QnytFUo2Iwq5BPRDtWpbIp7VlqXBBC6VR11L1+zqlO/gR+GBkgYB2PNU
 6i+35fo084+MyR+C+3oxa/5E/w3eytGZSzuic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750433311; x=1751038111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqqYjTCCNhTRdYU4jlOrobDgIdzphtaJrFc4/9AfucE=;
 b=VZOZpyOlMGnuOyQjdRfbbGSTJTDFLA1kRn4jPFTCtI2s1AZ8RGZjvUXpW9kjW22+9I
 pRICtvA2QeCFO9k4E84YPpK1MS4RK2MKVFBe0XmTxSida9Y1rbaZg+N5Kt27LObE+NPU
 GKWqC7fAlbauA0+rtcbKJPcpMEz1mTLBpRmE2v0o/+pUlP9bwIn1t+Jl5Glpn7wsa/+1
 /6UOjtLjEn5YscVupzztB43gimMedLFKsrhmQJOQN4jX0edwVY2Uudwa0fz3F2pRCXJg
 blrAdstuKayTdlwaHGa2craLDZJFXjF3Bz9SsDUyrfzIpu6ubDqduE2aHlrRRKSi1SmM
 j5hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpTCrPw3YXdhhtKKBt7E5do2c0Oi8rc5Mg4DBKrx5AJYvuQ/5XQ3PMsCtPL5i1/lhDu1Fd7Zo=@lists.denx.de
X-Gm-Message-State: AOJu0YwXVaW2YlOdWv4zYPVWUoUN+6Xpe7uXy+REOxYiV6327/KcSq7L
 RIktoqW4tKWNg95kxVDP5eHyr5gZEhtPZiJTV9ad8Gk6X6lQTotWxo3u9Ch4GS/dLIM=
X-Gm-Gg: ASbGncsXtigXtKX/a3llbkA1pGnsnW3477sKuzbkYBF1lZiZizYgWpdzqcfW4KtY08x
 rQAUWlErqLIt8/HJ5hMGYqxP7Uop72WkH9u2ilVwlhGGnTLh+/lGxwTbYyGlQiaNYgZP5BnCZaY
 8euaThmWxhwlBW9uf/GY+o42akbmqeSXqknY7V4xZ/DbQDGM0Ka69lDDRHlX9NAknCG4v4iEzXC
 IjgxdsLYzCj/1aaxKK327wKi1Z466EV/IYGAnfR7f3S70kfyKuP2yEqoD0wzZcZhx7LhJqKQOiX
 S8h/7NQj8goTaJXcwGl3sEehApGnVvMh5TYe3XM3DlW6MEzitThicjohXZ7SGaRSBM/VOw4wKAp
 kYWsEAKzt2ogiWgULn0oCP5Q=
X-Google-Smtp-Source: AGHT+IG7gUFwNSJowU1j521+qyD9phWsG/slAK+qxMMrHmvPN1voWhJhzVMztQjcUA8IDfL1eCi8PA==
X-Received: by 2002:a05:6808:13d1:b0:40a:557e:cd8 with SMTP id
 5614622812f47-40ac7139c70mr2453071b6e.33.1750433311348; 
 Fri, 20 Jun 2025 08:28:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6d1916asm326733b6e.40.2025.06.20.08.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 08:28:30 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:28:27 -0600
From: Tom Rini <trini@konsulko.com>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Wolfgang Wegner <w.wegner@astro-kom.de>,
 Thomas Weber <weber@corscience.de>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Phil Sutter <phil@nwl.cc>, Siddarth Gore <gores@marvell.com>,
 Luka Perkov <luka@openwrt.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Heiko Schocher <hs@denx.de>,
 Evgeni Dobrev <evgeni@studio-punkt.com>, Stefan Roese <sr@denx.de>,
 Ilko Iliev <iliev@ronetix.at>, Dave Purdy <david.c.purdy@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
Message-ID: <20250620152827.GK216500@bill-the-cat>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
 <CAJaLiFyw5jba5g=8h6R_aB26wqJvdN9eLvu3T6FJBBpm4LkzhA@mail.gmail.com>
 <20241114203349.GM3600562@bill-the-cat>
 <BYAPR01MB3830F2025F69E0F1ABE93CAF807CA@BYAPR01MB3830.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+NgCpnW2wQO5M6Nt"
Content-Disposition: inline
In-Reply-To: <BYAPR01MB3830F2025F69E0F1ABE93CAF807CA@BYAPR01MB3830.prod.exchangelabs.com>
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


--+NgCpnW2wQO5M6Nt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 02:23:26PM +0000, zdi-disclosures@trendmicro.com wr=
ote:

> Hi,
> Can you confirm if any fix was made for this vulnerability?

There's still just 4 likely rarely used platforms which enable JFFS2 and
so we've not had any interest in looking at the relevant code.

--=20
Tom

--+NgCpnW2wQO5M6Nt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhVfhcACgkQFHw5/5Y0
tyzAJAv/RSelXqY5wIWBShad8yvGwyuW2ymq4uhdWHbpPwc3kvFhYYsmleGVgdLC
m//bQGnQyCgIpgUVL5aToWrtZa6iCaew5jyIRKQM1KNLTU/K2ua6hawj7upAhZVd
oBXZcPlGdD/42y9LcmfjZQI8otFTJnBR1oz7nZxBNLZggYTDGMEQLI37m+flj6Zy
KGU48AuidzyY017BDTdlTmya8CqMc50ad+5pypKA4mi8D+cF1mBYriyekC9k4dGG
eOxoXL+eOOr6mUPPxsJh3mxHkm6kvgTKyMSrpe1QJR0T3h8uUOullpulPunjMhQ9
cmsQyFQzI4Y9fD5luHZUpY6JpBYCN8L5DfKCyN1PFqJA2Xd3E1JN2qM18Y2iLhPJ
F0qpE2rC/gi8kyKYLXHe2M38bR/CaD03j34qIhu5swcBr0TL4gl2L5X2UVUS8qEK
KmCsNLLY7Db59fzseZQ04X61OLPkC0vpn6mRQX4B1t4mv5wxnpMH1O4PT7NhQ8qd
h2//bPSl
=6wVl
-----END PGP SIGNATURE-----

--+NgCpnW2wQO5M6Nt--
