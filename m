Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C043EC27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95AD87686;
	Wed, 22 Nov 2023 21:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p9ZIPEd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02088765E; Wed, 22 Nov 2023 21:49:55 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3029887677
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5cccd2d4c4dso1754937b3.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686191; x=1701290991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wq4fT/rEKtlNURKBF3ih14728zGIl2ayVMjTT2GW72I=;
 b=p9ZIPEd0tVxosZ35Wft8j4lZZr0f2Ot2lAkRIapbd6UjfuEqspEei/xwuJIwm8m/jq
 gx0PzWOq+aGXzdE0ZsGwNefwBhlnMORPnd8mXsspWMCWlYTD3bVHRWv3nB2FyudUtz8N
 RmHtdfy80LZk55GwAl+seXS1o1RasyofLhZGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686191; x=1701290991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wq4fT/rEKtlNURKBF3ih14728zGIl2ayVMjTT2GW72I=;
 b=pBWmhCV5k6As7IKolTzdAMm7r//Hbt/kpSJD/pwO3oopUYMI+fBN4104e3zPudz99w
 3cLjaklVeEo4iw7LdpuGCYX+1uCZKykfTtNFhfw0sl8kfIDDLOuKxeQ882Lg6cIw6Mp7
 ESVKRDBnsmSQt0A4nWaS219TpQHFE5vyd/PdaZoTFLTmOEX0sE7VR4Hw28YOAUzsjwA+
 y+g9GoWyP4LxWANMWTQtALwA5/0z+8z3ajl4xP+2H/K2j8oOiGpCrrbG3u7wY2qbmHvk
 JlXrFxbb7nGEI5CYrOohRj3Pl+TTwmgAD0+TJySfAZx8MmKkBA1Rfize4tEgKErD2wbD
 VH6w==
X-Gm-Message-State: AOJu0YzsxXEVi54IDiuGSyWNqTDX7+B4wh/6XjT7qj7ydt9/lDymz3YJ
 VCcrnaYmmRdaJYBEApYzElIhPw==
X-Google-Smtp-Source: AGHT+IHw292LyTn7XnH6dobTyFHoe09u4VPkShAQcP5wHJSkL82eJZpItMY/+VyUx4zFnG4Mw2/Mog==
X-Received: by 2002:a0d:f584:0:b0:5a8:1d2e:e3e4 with SMTP id
 e126-20020a0df584000000b005a81d2ee3e4mr3485073ywf.35.1700686190954; 
 Wed, 22 Nov 2023 12:49:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a814915000000b005ca06611c2esm91018ywa.21.2023.11.22.12.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:50 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/8] arm: mach-k3: am62a: Add main_timer0 id to the dev
 list
Message-ID: <20231122204948.GH2513409@bill-the-cat>
References: <20231113145149.1926732-1-nm@ti.com>
 <20231113145149.1926732-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kXiANNaOQn/UyDak"
Content-Disposition: inline
In-Reply-To: <20231113145149.1926732-2-nm@ti.com>
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


--kXiANNaOQn/UyDak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 08:51:42AM -0600, Nishanth Menon wrote:

> main_timer0 is used by u-boot as the tick-timer. Add it to the soc
> devices list so it an be enabled via the k3 power controller.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--kXiANNaOQn/UyDak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaWwACgkQFHw5/5Y0
tyxSfwv+IL1/LVsrBBpP+tURpIQl9wfSWUoYa0JOcY/piCFlGx08dOvN2/eeOEe6
6Xb3k1RRTRfXb43eqs+XbxfuTAyncYNoCkBLhtxw4aBco2kbQ2K9axeOWmtYRWbp
8FviIhGifZ50z2Q7GYcBFhhCvY4E0weQU9d4ZGDxP67s7OFcXjixHRGuU3TbeXJk
b9zOG1bMsUVgJuwJ3Vb+sLM7TTv3LP0oSrxkAoZtncw9mGMNpDhnUwKt9L5/v2el
h+3wOR0lAkzrbI0xVTurgqMVEmIYX2SoSM0acAgEeQsV78tRc/wrFp0ASEWVTilZ
aDM6kEkN61tvdMDteFp1fzAyfKbKa0FAOmAJo5+rNowR0AjMpyk76+9mJUWGqJt/
y3gaLl0kZ0ZFDX8Uuy1uC0dGpAH3pFhKNsGJ7D3OPmdY8A1rTVEvPFUDdxkRPqkM
D5LJ9wRccR9iRwxtePbgifXiuvx7ZGuhU2SUk5z9+DJ/uHRhlXz/r5Org+LWHepP
QCe4szuV
=mvEt
-----END PGP SIGNATURE-----

--kXiANNaOQn/UyDak--
