Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F8CC4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 22:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4711387209;
	Sat, 25 Nov 2023 23:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zg6OkICy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A276F8708D; Sat, 25 Nov 2023 23:38:20 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A2B187209
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 23:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6d64c1155a8so2047767a34.2
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 14:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700951897; x=1701556697; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rDKUzqYoWv80J8k6GDrvg3mBMXCfTLzBmZAGijxTAn0=;
 b=Zg6OkICy004ENxy6mW2QcFzmtTE9WaOJiPXEdxoOFkQaaBgn4ooPZ7amW2FLa1E8Te
 dLydw7/jxhpIUYODLA0EYJ2EbjbaL9aC17rPj5jnl/kFRhgZvhbx/hlWD5N9AygneEpQ
 ch3I7AYa+fZczJNfB5MJ3FD9jW4E0a2zABOoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700951897; x=1701556697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDKUzqYoWv80J8k6GDrvg3mBMXCfTLzBmZAGijxTAn0=;
 b=th22Rmgfok7A0nm2In1N0N8XBAM69n93lKXMGlK1Y5GeEUUsHwNYBnDCEQ0+TdntPQ
 B5tWXvzik0CiixUN/63md28TgUubOxT5glw6Zucq41imQDKseNojsXumUoKf6tL7szTk
 4sXlZrcp/3R0six6uIjt9OFp9Lm71JnU0nZIRngXahD1o9e73Om6ozE7pAJ+xtgcLxCz
 HMT4eIK2ekz1ddqg/dCxIjna6Daofaf1iQ4StxihsNlFxcZFOhWIXcCh2ZC/2PQBjGGK
 w/+UD8Le/upBQ1ajQ5jylgymduVqcvyKNOqTd9W3mUVx3H/m2QRVn+Z4te9HeKay4vGl
 L2sQ==
X-Gm-Message-State: AOJu0YyroksjNdQdSSaKEPVD/Bk9nC9GhdrltUdGmbDxLHhJzzKwwE/L
 Vf2ej1EqtY41rlz0Q4GLc4vFZA==
X-Google-Smtp-Source: AGHT+IGMhCr5zG7PbG+Twg+ZLJ97tcofTMqUuFSq0i/gM89Hl2JulNpaXY+ouWMU9zpL/5s3Q0EZ8g==
X-Received: by 2002:a9d:69c4:0:b0:6c6:3ea5:cdbe with SMTP id
 v4-20020a9d69c4000000b006c63ea5cdbemr8205194oto.18.1700951897228; 
 Sat, 25 Nov 2023 14:38:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-18aa-0515-8718-e379.res6.spectrum.com.
 [2603:6081:7b00:6400:18aa:515:8718:e379])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a0562140acc00b0067a1a8e35aesm1748024qvi.97.2023.11.25.14.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Nov 2023 14:38:16 -0800 (PST)
Date: Sat, 25 Nov 2023 17:38:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] arm: dts: npcm845-evb: fix/add node and aliases
Message-ID: <20231125223814.GX2513409@bill-the-cat>
References: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
 <20231114085159.3739887-2-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KitD34KORRPbtVUP"
Content-Disposition: inline
In-Reply-To: <20231114085159.3739887-2-JJLIU0@nuvoton.com>
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


--KitD34KORRPbtVUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 04:51:56PM +0800, Jim Liu wrote:

> Modify spi and usb aliases name.
> Add dt-binding for usb phy define and fix usb phy reset error.
> Add tpm/otpee and host_intf node.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--KitD34KORRPbtVUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVid1YACgkQFHw5/5Y0
tywxtwv8CqKIOHEtT8qIwh/0hlco2hxX4Y/kXs5JJ7nm9IVc1OsCFhv9FrgFm15d
DqQ/+VVlRBawBadvfcf4YxHX3r6zO3fdMlYgkGHZ+AlUtv5vw2Rdnp+ebApXafVD
j/76/iJTNjnE1/KZ/pvqwnnYANceC/WZ6Witd10XUsb0GT6a1ZS+hfkqPHe0wFrC
iAvC5RGEavM1JJc3nmY2czVzy+whxEGzklEinOG5mHsRJZz+8YYm+eTGxuagcN5l
YrjAdvMKpfVaUXGoivQGkmVs/extB6BG//9vzQJ027aNnSoRG79pVzoKN6I4CI59
4xW57+ZYOa+L/kKLEmh1ncW4gEKY5MnwA4whrB93T6jXxI3w5TrX4NhxrvgfU6jy
ElV6LRr58LoevHZ55D570Bg5O6f+mIJs4IqJrC/UlqAYfNKGJn/cn0dzThl7h7v1
120hqsMy9c96wKpPTkyczsne0mWzzdAfA6Bsr1l/Qs0w0WJTcj7FOXWP1319sY7p
N8iiVuFI
=wREI
-----END PGP SIGNATURE-----

--KitD34KORRPbtVUP--
