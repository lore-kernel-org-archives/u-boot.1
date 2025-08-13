Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F39CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 17:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F14B836A4;
	Wed, 13 Aug 2025 19:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="euvUTUVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A26836A6; Wed, 13 Aug 2025 19:13:11 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9046D836A4
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 19:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-435de6dfcefso61324b6e.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755105187; x=1755709987; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G/WgLHIE+/WZ7rQ8jPFapNkb4FePc73NVwSr3F4OeHA=;
 b=euvUTUVTPQ3SJGClsw1hbMRtQbDKZ0PaDkQXjy6EAX+t8skj2jBE/2r/AEEx+tmdI4
 Jl/F8w4+rJpI57GqPomjBQ+2uTVbQkm2C+LAnuYfjajEa2mP5RXBo66GTo/+b4kDHGAe
 N1B66xKPgg1oSwtW7afTrdM16SGrDGlzhizTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755105187; x=1755709987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/WgLHIE+/WZ7rQ8jPFapNkb4FePc73NVwSr3F4OeHA=;
 b=Xg+W+kISRw6VcDx5CogdmKpxwf26w5/Zzsop4ZNJhxq+r+jR3sHDZTmcp1DHGDLqUw
 vBfjpJ+z4Nj7NIPa/XneT6sUNpCLsl0FXbwejFkVJFc1Lb5nKqRA9Xze70AroiGC++S4
 QbxoaT0yUa2VgNhJqYiameTZ0eLHpqj+Z2TyQlItB1asgs/lrxV0s1JgBGV5RyzJVMDl
 xmERGuu3Q/L66kYo+quPucolYdsPG0ckpxHKotn94HUZqnQ2AfzgSrIeHFo9/iBMXg64
 j3RB4fHBkZbBodAlJf6e+RhNQOriqOrhEZHox/8SVETAStn9RJHyWsxKPJUdGFzKf8iY
 w8gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXQVPoFx9mir+O4i3ZG60hWxvnmNjP0dc2eIl6zaezCIZ3nDbWlF8aXHQ0Cv666zJW/OG5pAc=@lists.denx.de
X-Gm-Message-State: AOJu0YzapiWZj6X0Nn6+jVQKNbcaNsOiq1kbHr4M8EP4UaBTGm6j77un
 eo1BUVouy4LFRGxFal0kzOIBwbFs13VhoZVpVwX10p0MmGnqEWZOHIkBnkAgMYj/BIM=
X-Gm-Gg: ASbGncuBLH/D8lGHtLNDPRDjAEXoSxJpW+PdVpfh2mU0xwFI/gSBfh2fi4u8iSv4fzT
 a5ruX8p7IL0wOZXRsJGNAHJQiOq0TC6ZDfijDohNIV67OqD7mhVXIx9gfjDNEK1oXaNKLGHAk9h
 u3yE7ChQl4FvpH/oWoorrUOzwL1AlrZaFBxheT0fKVCZYZ4pu5jyyicHQ843s3jPe4rmFTAOkuy
 kRvFgRkyAH/lWTth7uUo36kDiLG4uHKCExw3a8BQ0aS2wgE5v4MDpwseWMmkrJPOC6C+CO8yNk7
 cWUlV4Bw7j7qPxJdtFLPznwEIpjhyWz0xUkMIUznrYFJ/Q5r/5vshoFHXTtuZo41kVQjKbWWWiE
 Sg+IYVYIjN5yWg/nOSfrV3jbhcEQJqTdo/ZsuQ6uV5WAd5CsiJOAKTyE0
X-Google-Smtp-Source: AGHT+IEimZjGrzJWXH9Ey07Yf5py7yhR7xR6x0qHqBnpT7ZgYOWFD9wwlD2goKLIn9wrBwAMGwJN7Q==
X-Received: by 2002:a05:6808:15a4:b0:40b:fe6:569c with SMTP id
 5614622812f47-435d429b2ebmr2559648b6e.33.1755105187210; 
 Wed, 13 Aug 2025 10:13:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ce7289a2sm745532b6e.9.2025.08.13.10.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 10:13:06 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:13:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v1 0/2] lwip: add Kconfig to decode and print ICMP
 unreachable messages
Message-ID: <20250813171304.GD124814@bill-the-cat>
References: <20250806085959.2130339-1-jerome.forissier@linaro.org>
 <CALeDE9NsfBRyfOdxr8S0iRSj5kdSwyKVr-pfroJCdjqT0hbmvA@mail.gmail.com>
 <5f3e997a-f070-417f-a09a-90e1bf7774cb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kIX7zTg8ZKeIDQkz"
Content-Disposition: inline
In-Reply-To: <5f3e997a-f070-417f-a09a-90e1bf7774cb@linaro.org>
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


--kIX7zTg8ZKeIDQkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 09:49:29AM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/11/25 17:56, Peter Robinson wrote:
> > Hi Jerome,
> >=20
> >> When using commands based on UDP such as tftp or sntp, if the server is
> >> not reachable or the service is not started on the expected port then
> >> the command ultimately times out. However it often happens that the se=
rver
> >> or a router sends back an ICMP Destination Unreachable message. That c=
an
> >> help troubleshooting. Therefore, add support to the lwIP stack and to
> >=20
> > Has the patch for adding support to the lwIP stack been sent upstream
> > for review? Please reference the upstream patch for this.
>=20
> Yes, see https://github.com/lwip-tcpip/lwip/pull/73. I will add a link to
> the commit description.
> =20
> > Also related, what is the status of other out of tree patches to upstre=
am LWIP?
>=20
> At the moment we have:
>=20
> - 5634ecc88e9 ("net: lwip: tftp: bind to TFTP port only when in server mo=
de")
> Submitted upstream as https://savannah.nongnu.org/patch/?10480 and
> https://github.com/lwip-tcpip/lwip/pull/61.
> Status: MERGED (https://github.com/lwip-tcpip/lwip/commit/b1edb7780f5f)
>=20
> - 27d7ccda94f ("net: lwip: tftp: add support of blksize option to client")
> further modified by 10917df17f2 ("net: lwip: tftp: fix find_option()")
> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/62
> Status: PENDING
>=20
> - f69f7aef26f ("lwip: tls: enforce checking of server certificates based =
on
> CA availability")
> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/63
> Status: PENDING
>=20
> - Part of 9349fc2e9c76 ("net, net-lwip: wget: suppress console output when
> called by EFI")
> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/66
> Status: PENDING
>=20
> - Patch 1/2 in this series ("lwip: icmp: allow reporting ICMP detination
> unreachable")
> Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/73
> Status: PENDING
>=20
> FYI we do track this information internally here at Linaro. I could as we=
ll
> store it in a public location if it makes more sense.

If it's not too much trouble, filing issues in gitlab in the u-boot-net
repository (I just enabled issue tracking there) would be good so it's
visible to all? Thanks.

--=20
Tom

--kIX7zTg8ZKeIDQkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJzHnwAKCRAr4qD1Cr/k
CkqSAP9Z1hvrxQyNv7UqxcMDuDC8CLN4+VL6J+8L7aKjymadHAD+IC2NlCF8a91W
cku4R0lAQa8nT7bjlcnCSae4q1ZpewI=
=PRjf
-----END PGP SIGNATURE-----

--kIX7zTg8ZKeIDQkz--
