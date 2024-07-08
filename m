Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE48C3DA41
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 17:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE0CC887FF;
	Mon,  8 Jul 2024 19:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YDPvORD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD9F887FA; Mon,  8 Jul 2024 19:41:51 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A668587919
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 19:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so3897044a34.3
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720460507; x=1721065307; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jVh59gwFKdegYVleEokrL8pzQcZoYpru36SThTybcNc=;
 b=YDPvORD5KqRU5oqNwJw6hrwFQQze6KDi23/XROpMvNfD/1L7Rs9oSMP5GcXK9qGbiz
 xQ4oYH5su+DY9Wq8cB9zh5C6y/AQ/WW76vj0cqhQ2XB/xTNED6dGcsMmiypo0QmfLxnz
 micwcTtWKBAeEDKHoyMSmHaHK2HUB1jeU+XTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460507; x=1721065307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVh59gwFKdegYVleEokrL8pzQcZoYpru36SThTybcNc=;
 b=iEv/3PrwULoHXsxSx8bHvyd/2l3t/YvdkIk+9Vny5wRu9E2LkbKklgzvTT5sXigU1n
 0sRnwhXTd3fL+4orJVp3Bxptzxo0CJLvOoIaa8K99xqQQH4GAIxkDa7RuvSh+7KnLdYS
 6ds0htVLR0PCH/GkV3vZKCV3O6e6r3+MfQGMFNzbPRQ7gshx5z32oPKdUVGa9DnvvjUm
 3g+yx+rKeSxNeUY2vA2ZbKuUNIERnHksNccibCeK9lmcLImuDohO2gggTDvd48broTPu
 2p51KrEPxfwMLeijjktMsJvXlfRqlAeSat54o6o3KmtZ6uru4lN3YGdKJi+A0IbGi38V
 WCKg==
X-Gm-Message-State: AOJu0Yzy2qgIniTOrq6H0aWSF1cOpxTCMuzLi8QHqK9sjJAHbgtrFNs6
 KF6Pm60Lpk5N62Ev+c1xTLJcwibwvOQRJK2tVjU5RG6V8C8g94/zAaXBjEYc3Bc=
X-Google-Smtp-Source: AGHT+IFQC1XXOhwsEUKfBu2JnmHXmq7z35B7IhksNsxfzkphDMOUx/XRQutFYzh+0rpeh4gikm7d4g==
X-Received: by 2002:a9d:74cc:0:b0:703:5c2b:9024 with SMTP id
 46e09a7af769-70375a0546cmr170615a34.16.1720460507313; 
 Mon, 08 Jul 2024 10:41:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374fc0931sm74302a34.59.2024.07.08.10.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:41:46 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:41:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/next-clk-sync
Message-ID: <20240708174145.GI38804@bill-the-cat>
References: <20240706154608.63504-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c9n+DzUJLh1+mzM7"
Content-Disposition: inline
In-Reply-To: <20240706154608.63504-1-marek.vasut+renesas@mailbox.org>
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


--c9n+DzUJLh1+mzM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2024 at 05:45:22PM +0200, Marek Vasut wrote:

> This is for master branch .
>=20
> The following changes since commit 1ebd659cf020843fd8e8ef90d85a66941cbab6=
ec:
>=20
>   Merge tag 'u-boot-dfu-20240606' of https://source.denx.de/u-boot/custod=
ians/u-boot-dfu (2024-06-06 08:24:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next-clk-sync
>=20
> for you to fetch changes up to 3c4ee884b73c8c21a1afcefef7d44d6a96fe9bf2:
>=20
>   pinctrl: renesas: Synchronize R-Car R8A779G0 V4H PFC tables with Linux =
6.9.3 (2024-07-06 14:47:13 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--c9n+DzUJLh1+mzM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMJNUACgkQFHw5/5Y0
tyx/0Av/YA1kYuhCgJiTkg/FZ4k7JZOAv/o39NQaARqmnt7wnDdf/j/lXJ1uplqp
aRHGdjstbeN8sdo5OU9eD4iMyCog5ytjt/GGeuO+e/LSx4luFMrPg0IEZ7Tn3MAz
/JU7S454wFfYnm962KjXhlLanjIRtSZ/FecZ82A4p1XAcj4zFYmwBXWsXEs3S9UX
VE+dS+DdxrT79+ljPfgFwBDgXsF45/sAbVS1841i5q8aefiAMtHM8uB0549fyhW0
LqkpJ2S6AOx/GD30sEZdUg+YdfbqsZB0n1ab3x/IdpWvLY1TJePxfuYj84ukT20q
nu+bUK0e9W1IvGCaW+9KFlJ7mDT8mbiy880Os1hrO3qQWgtUm7qiVLGsCxAIKV6X
VS9b4XzTt7teEDXoWVQytB3En6NK3tS0pvdRRqZGwizHV01RppqIZbVwu9RqVyD0
9KJ3tllQMeRBT9QmXB7A7oCg1oW+/sCtDzgPXgPrWD1y8vmaVSiTklU7hR79/xwS
uYPmZxXs
=G8u6
-----END PGP SIGNATURE-----

--c9n+DzUJLh1+mzM7--
