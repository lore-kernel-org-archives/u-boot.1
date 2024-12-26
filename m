Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D52E7718E
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 15:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30437803B7;
	Thu, 26 Dec 2024 16:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jNeGQFlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93204803CA; Thu, 26 Dec 2024 16:17:46 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F4C8036D
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 16:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dcf63155b0so30274536d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 07:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735226263; x=1735831063; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DU22uhYb9jq6FlA6F++BueIt+vO5HdC59u8tqgCT7ro=;
 b=jNeGQFlvsZ6RKHXOm5ViwRyHKjeyas5lEbM0wNocP6B8gRTfl0gwpSCWWAjNAxo8Xd
 Iyo/DV/X1c0iw4rRluZta2vqYPpRRrlFrwpQ/CteIUS0XgevH/aXrdZFXiuMJJkTHRoA
 rg9V6vH2cR9wmGbvgLWWdbrJN0XmlB3rGDX/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735226263; x=1735831063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DU22uhYb9jq6FlA6F++BueIt+vO5HdC59u8tqgCT7ro=;
 b=m0HJJKYMIjvsRr5e8NHkZz9eCqc+ThEuhOOLhxLHArbL5eeFLVBLHZ4Zrnvse7VIfx
 C3yU7fFWGSUARFMZglh2vvbdWDQdnDR/3Lj3neohzata3Se7tGo4z9mkEE98ostCPpNP
 Njkv8vHYNVqz1tw8H0H5ldbXH/XFlTth8U2gKJVgIpxxQSKYyuv1jxjP6qYXhMlXqjpQ
 mQUL1t8ZEGpQH8rSAuJ7nc2AMiEGqq6QY6xqVN9BK92FIx/m1y3B+YPrkdanOGm/uRWE
 jeQ6t6OBBTRgP4DPaeEcYOMrfDJsQk+OoZ3Tvg++G6vDJdATz+dxgeO3MPn31ZahKjN2
 37OA==
X-Gm-Message-State: AOJu0YxQQDDmvQ+2Av3CTr5lGo8qre1IFt1cktDNhy2U/TyFrBvIqg58
 edEGzYITx3Ghs3ApGK+2OL1m/eJTWdxMtTRLfJ7WIQdlRw8csC+/83i/HI7mlUE=
X-Gm-Gg: ASbGncuWrcOVUR5zQjmw1UK4kuxYMRel8jaMuqET9Rnl1PFHJJpzMPc4UcoeRw5nHVJ
 u5UqsOureAnKC7RLu/5llyI7jsHI5yH4r+drVZBdwwDpj4/5l4sL/fw3FcUxdx+YJT9W3LvdmEu
 KjPIzNSum/jRkNfw7/azs4LTefr24y+9xqcGJuRZGpWeoM8C37QD2c+iaBrtfE6+Nvvzy36/6Jg
 I+IuE2jjOhINPATBSMPkcJ/Rs2PiMxZdTBzUJ8uUsU7zBmtO+oeqgx3Xg==
X-Google-Smtp-Source: AGHT+IF2ToWNIKv9P3Ufe9AZ9+CTT+odnXoHV5D92OmaX5BiT+8xJfS3H3f0pDNtrti4mT1OHGTwug==
X-Received: by 2002:ad4:5c68:0:b0:6d4:586:6285 with SMTP id
 6a1803df08f44-6dd23328c2amr319087736d6.11.1735226263231; 
 Thu, 26 Dec 2024 07:17:43 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18e3c3ffsm69939136d6.13.2024.12.26.07.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 07:17:42 -0800 (PST)
Date: Thu, 26 Dec 2024 09:17:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: DT subtree sync for v6.12
Message-ID: <20241226151739.GZ1505244@bill-the-cat>
References: <CAFA6WYMvXXi19tjxhi-N4D3-tbVkbJQeUHwzuC5FME6vzPir=Q@mail.gmail.com>
 <20241224180758.GW1505244@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wJy9wT/0WC9FAy49"
Content-Disposition: inline
In-Reply-To: <20241224180758.GW1505244@bill-the-cat>
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


--wJy9wT/0WC9FAy49
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 12:07:58PM -0600, Tom Rini wrote:
> On Tue, Dec 24, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
>=20
> > Hi Tom,
> >=20
> > Do you plan to perform DT subtree sync for v6.12 which seems to be due
> > for some time now?
>=20
> Yes, thanks, I'll see how that goes shortly.

The only problem with this is that it looks like there were two device
tree renames that we care about:
rename from dts/upstream/src/arm64/freescale/imx8mp-venice-gw7905-2x.dts
rename to dts/upstream/src/arm64/freescale/imx8mp-venice-gw75xx-2x.dts
and
rename from dts/upstream/src/arm64/freescale/imx8mm-venice-gw7905-0x.dts
rename to dts/upstream/src/arm64/freescale/imx8mm-venice-gw75xx-0x.dts
and I updated the two defconfigs (imx8mm_venice_defconfig and
imx8mp_venice_defconfig) to use the new names, but I'm also CC'ing Tim
in case this is wrong now.

--=20
Tom

--wJy9wT/0WC9FAy49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdtc5MACgkQFHw5/5Y0
tyzv5QwAqsVqip1VN5NUF7pq84jEK2oxx8sB+BLtg0Ip/CMVW/WUtjal3oiqYkFa
v9cRapxs9omsxAN5QVCCJq3HREY26Aa5CUdGlAiuAy1CQTiaeVYBE1366j0T7cIj
7hHXHDcSEFGNNYnQp9xbXbaaAO3hY4NSqcyY3a4sHnIBtJiXuuJHtaIgNv3rPHmU
5CsJspITDDXX6UJE+9M1xqUsoOdebF/r1ALXJ+nXZhsZc3I4hcDAELV4+C+zXap+
qVw14DAlBqAZMLasZ1wjqvALOSNToVP08eDIJNfasbi63QR8Ku4zSPtwwkYOhxhJ
AhpdT4OKN5dUCHSyThpWKC4Ptq3K/QtEKaELzK6VLg1FXXXTTQsmscTIVFsD4Vqi
Rs7+uQqE8msPjYWhT1lGz0af3PfpYJE0rERQBD+/onC9QkZCPbfpIk2vUvgn3JLU
riN+nvflr7Pp4Ec8xAXETuVPOJf8vhl5c489sjrdP6SlC6wsv4hntQoreSJ9aaEN
WynrJsoh
=k7D3
-----END PGP SIGNATURE-----

--wJy9wT/0WC9FAy49--
