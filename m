Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40673C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F9C800D7;
	Mon,  3 Feb 2025 21:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DwLiR6XW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8645D80269; Mon,  3 Feb 2025 21:08:29 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61244805D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso442573785a.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613305; x=1739218105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ExaTsGuCpOuu3PW9dX/IX73qmoKd1+bqneHZDAyzco4=;
 b=DwLiR6XWiVTT0kqyFrJawZK6q0MZ2jzX2PGa4xXVThmD5+cXDgNabov2MhOZfKXLiB
 1DLMs5ecRqybCvaV5X8xnwOsGvWNvS+34XZGqtiSIdWeQw+MKbz67PrYIIAa5bPu4poD
 48s7Eiyr74jNavJMOogLhtORFGfP+bQIBMCb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613305; x=1739218105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExaTsGuCpOuu3PW9dX/IX73qmoKd1+bqneHZDAyzco4=;
 b=TKTrD9CAu8jfkoEmCgjPyDCBgSjJ+zO6XujNt+UsEC80MPUBx+Q0v7d1lq23bRpqhZ
 oych2b1hX1rxag4UHf+FXI46DgOt3m7Ds084VgKwyTVTk1zRUkRvhKeoE5h77letrKe3
 zcGWMVPNPJxjD1sqU5WisPh1KG9tNkMiQ9nyzjXEHTPW4lC5qSeAC6cCb6TSXQRw+YLh
 nrJDOyVhuNob4VRuVco06kTAFC+NbwDdBR6pcchN8yo+bfxhNF9ScDLpBTu6MU2D6DRL
 7Jv+mTs7smUBNt1js8JhGk+NR/d4YSj8APCBf61JB55zFt9GgWIu9F1QY0OkKXkT8ANi
 quFg==
X-Gm-Message-State: AOJu0YzeylQmGdDYLRb7LWxiBnow2JaXy9x3djN867rIJq8nK6vIZ97v
 pUf0gI8OzACNAh0rWioMOSX7R0TOJ6Wqvj3qWG9mcYu80HmLuxi1KuKqwWgljIs=
X-Gm-Gg: ASbGncv4vTToje02dKaWHUlIjFD68w0vSc8KormUVthgjol6hq3+sNQXfxWn+hsHlRZ
 QjcHPAsoQVMcXeZQ2znHR75YoAHE2igLeRGuFTulscHK8Lstogf2qVCE8CUTm4HjVMLfy/ACmGe
 +hE1g0bTEbmi2Ngo9U3IG1s38RwpWwD7TFNfXsM63/QmJKQzo19wEh4B4ix6CYFywId3qdqWOmy
 OBghZIFS9wF8lfA3D+I78FT0YK3RR7RcNBZutIBraQ7BwNrS0ikr4T/XVzBtXZeH5fDRYxyyWj3
 +5ozXZWp1fSSyaY=
X-Google-Smtp-Source: AGHT+IEOfyChazN5XxhxCOUl1qiacRCiUbn7a1Xb9nGlWBC1NRKSFL0zcreu3CrK7H0aTJ8AoVxlUw==
X-Received: by 2002:a05:620a:439a:b0:7b6:de65:9ee7 with SMTP id
 af79cd13be357-7bffcd73642mr3611554885a.43.1738613305316; 
 Mon, 03 Feb 2025 12:08:25 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8bbefesm567567285a.7.2025.02.03.12.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:08:24 -0800 (PST)
Date: Mon, 3 Feb 2025 14:08:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH 08/32] efi: Rename app and payload to include x86
Message-ID: <20250203200821.GD1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zpcn3w2+0MS1sg8x"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-9-sjg@chromium.org>
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


--Zpcn3w2+0MS1sg8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:01AM -0700, Simon Glass wrote:

> Since we plan to support the EFI app and payload on ARM too, rename the
> x86 target.
>=20
> Adjust the Kconfig rules to allow non-x86 builds to be added.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Zpcn3w2+0MS1sg8x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIjUACgkQFHw5/5Y0
tyyOMQv/ckD5DEk0h/O6LBhdjW7R7FPYyyaz674Tor+oFbLwoRvEgeuqetnJV6Ll
1cjv5lw2a0OuFJOuI+IMd9hhw386BNx1SuQv1vtUT/b+NuZiqahVaV/tLVfMq6Qy
ePUxjyGoTwOhfhBLggC6vGhGIs0Dpz9mB2p/7D8XvrVdAslNKTW3bUezIo4eJl4n
bPexE6UnFOUD0m3jA9hXPaYFt61lj55Gt39uFfehiVyIlw/Z5b2QynwnYJlONT+h
UlHNqC3KuZ3JEnjMhBVYZCnyM0cpQg71D5SGVZDIaQ03jNiycOuq9bj7ZgZfO4dI
Ke/TLOqyDcj5X6pEuPSwDnS1Powxr0R1NxBJ4sTxq7AeIddPtFXeS7ZSU8tMeEv6
Jop+tgUuI1BQiSA1dYhk27gh6+pdTbaUOCZat2Fl+O9xU+7jTffZi91lSGbj2h+N
EG5J0jv7jBvwwvvaYPKGF5ZMPzFNsOXNx0Xx49Fi7F0knP936SVZ2pQ8rEgP+x22
Tukq0U/E
=Tjym
-----END PGP SIGNATURE-----

--Zpcn3w2+0MS1sg8x--
