Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3109C0218C
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A86E80763;
	Thu, 23 Jan 2025 15:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TiW6IB2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA3980711; Thu, 23 Jan 2025 15:33:09 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8294B80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6ea711805so121246785a.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737642786; x=1738247586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I3o8IW89T4GaV0KZN2V12XD+wODxnPFvGWecpJS7y4o=;
 b=TiW6IB2/egy6BsGBkwuHwGppm58vTFJ5udacGZ2cqI/VwQH20COUPS5kkpkfuj4sMG
 +SGlUXPncnuhU+CXsJj9veOyM2gwkZ2qF5PtQxT5NSBX2PUX2608VRX6YvtEqfuX+Wr9
 3SPQIHqSUu80djJYg4CXA1h6AtDY1QjNDGgEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737642786; x=1738247586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3o8IW89T4GaV0KZN2V12XD+wODxnPFvGWecpJS7y4o=;
 b=ieqciKiBFK654s7is2rMZa23HHta0AeirYp6BJAQtSr6B2SYJoWiSVOdJKJ2hJwH8l
 xxUikcMviTp0gmBvCXuViPeOXyFTfnIign1LDdp8dyXF+9VmBM+Ri4LRw7hwpvgpg3Dr
 DG7DbkkytckWmCmZslN6moj+NBPRB9zL7LXlNWqbB6Z7A/Gf5DyUlfHTdh5lycp7ajqe
 lYU9esSRSC9cR88rFRP4TOIYAb5jygmGvgrQFv/mDig3sErfhJbmRWrACmJIfT1OXgmN
 ynYN37qkyrtufgUH1LvejjqMCOxQ9bO5bDheccQu+hU6raotUfk3cPmcgzxXG1HF+fXe
 dDBA==
X-Gm-Message-State: AOJu0Yw+0pn27B0JkcF9LzWFYLi2cLjAn0IZJ9RnOIBqe5ht2yExjwW/
 S8hCJdkfyi9n2+iCXiYE6MPnssMWD0dBIJfW+H+I9+DtW/JkDWgYTOPTa0ULCiY=
X-Gm-Gg: ASbGnctbjU/eBzKjzPc8g60JMhqG7LMFetsnUlqZvKhLqxhD/RfKLwSkV3kdJpGCG4u
 b/DdsOfNWZuTEhYNLAAKKAsr5r68I06LSRnncOyQHRBayu1JgsRBC7WGHsYd3I/bPTpP9eA4pmM
 +KnQCIy0dgvfU4QzscFRQD43uUPkkuJylfQetC7xk9kzhmklOLj+0YGhWJY23uFEAX33P3dse+m
 Pn2/pRkPGI//CoZzR/fI1PoPxBWfHRgB447Xbzxu1yO7K4GUBcTJ1/6eMxthQu6YIHrP6AIH0Cu
 Ny2Q
X-Google-Smtp-Source: AGHT+IHl0mNez8oh/Y1uvtbqDQRAwvT/V812DISidDZM5Ze7U0s6EtaKySZ7QAUF0ROLg+BgZZ/lIQ==
X-Received: by 2002:a05:620a:424d:b0:7b6:d252:b4e4 with SMTP id
 af79cd13be357-7be63253dfdmr4465356385a.53.1737642786306; 
 Thu, 23 Jan 2025 06:33:06 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be7497e48bsm525501585a.16.2025.01.23.06.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:33:05 -0800 (PST)
Date: Thu, 23 Jan 2025 08:33:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3] led: add function naming option from linux
Message-ID: <20250123143302.GI60249@bill-the-cat>
References: <20250123114906.80724-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="seOQYDRVqiyk4eMB"
Content-Disposition: inline
In-Reply-To: <20250123114906.80724-1-hs@denx.de>
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


--seOQYDRVqiyk4eMB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:49:06PM +0100, Heiko Schocher wrote:

> in linux we have the option to create the name of a led
> optionally through the following properties:
>=20
> - function
> - color
> - function-enumerator
>=20
> This patch adds support for parsing this properties if there
> is no label property.
>=20
> To be as close as possible to linux import the following files
> from it:
>=20
> include/dt-bindings/leds/common.h
> include/linux/uapi/linux/uleds.h
[snip]
> ---
> as we introduce a new element in struct led_uc_priv, may we should add
> this functionality through a new Kconfig option? (Which also would make
> this optional and save some bytes for boards who do not need this...)
[snip]
>  arch/sandbox/dts/test.dts                | 37 ++++++++++++-
>  doc/device-tree-bindings/leds/common.txt | 28 ++++++++++
>  drivers/led/led-uclass.c                 | 70 ++++++++++++++++++++++--
>  include/led.h                            |  6 ++
>  test/dm/led.c                            | 22 +++++++-
>  test/dm/ofnode.c                         |  2 +-
>  6 files changed, 158 insertions(+), 7 deletions(-)

Getting things out of order slightly, sorry. The commit message should
be updated a bit more still since we aren't copying files in. And we
should delete doc/device-tree-bindings/leds/common.txt in a pre-patch
because we have that from upstream now. As for size, how much is the
growth? You can use tools/qconfig.py -b, and then -f LED to find some
platforms to size compare before/after, and if you've not used buildman
for size checking before I've put my script up over at
https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/trini/u-bo=
ot-size-test.sh?ref_type=3Dheads
now for easier sharing.

--=20
Tom

--seOQYDRVqiyk4eMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSUx4ACgkQFHw5/5Y0
tyxRjwv6A/TF/xwS6yYrXjcn/4+TEbnmkD24xW84Al0ysmxZOYCyHk1gMUEMroEN
KhRzvOk0lKciLE8hL+tdYEwWCpoBUL3Q/3IDrVbK3whQoD8VyDIzygsX9BwZyfhP
TSrGNjXVmUKReG23k1ZpDgUF3pfgDpATQcAjrsEN6dXnbfj7ydd8Z0nlAV0tAj4t
EnZjxAxjBqq5mcLZbaEmDxcA5PNeRbgQucdOBPaUxXqqWAkcZLy/7ySMURNNFjNP
201hQScMvMpdSjkC5KkbUEjZQpruN7BHUvsosZXg/HaS692wE78PBN23/IATRjNF
nBgiCcVABX6UdRSNxOwJON6/bsiBpoiCcKqxeYtH7ZMFcVvqkzy3Wyrn1l+95cYJ
bTKlBlloNAl374Wun3gRz/TbpDdDISjyMGjmSWVdVB4iPKLYzK4PJ7AlUnWlniQs
DS3ld4MFQ5v2P4XKqXsK98ayEqXQ7q+Pt16DzW8kPdszTR6czXKUGONAJPI+T9CY
N2x9i6Gk
=bhlM
-----END PGP SIGNATURE-----

--seOQYDRVqiyk4eMB--
