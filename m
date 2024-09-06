Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A30CE7AA5
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 01:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0948C8882C;
	Fri,  6 Sep 2024 03:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qGykoqeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F74886F9; Fri,  6 Sep 2024 03:09:37 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544EB8882C
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 03:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e164caa76e4so1655201276.1
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725584974; x=1726189774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ne9lr8hfEFMbdYcIOl8IELUeCvXvXTCGmWuknLYsiZg=;
 b=qGykoqeQRll6p1py8EritsQ39VuswjEL9IKuiis7sMHC67qTn/YmSmGmvTJBh4piTj
 hfwNEN1Pk4DYXUM888GAQ0G4ojL26ZM640lsyGzcYn0NCVeQFLOIL3D9Sm9FzaZpzc1O
 Q1dLQs/BMyC0K3l+0zY1H5ctVXuIdM9K3Xru0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725584974; x=1726189774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ne9lr8hfEFMbdYcIOl8IELUeCvXvXTCGmWuknLYsiZg=;
 b=FCGtgG54IqAeHO/C4W+YouI2iPoIDCEIk4TgsEqPbGJH0Vl6GaM/nWmShYzLF/WMb0
 oDzxS/LNt20HXi9R6iJUDTQyfENhdxImErj+VroA5Ja45wXKcpiKkPIXmBaY2b22/p6V
 zlILmJ1clwi4MYuiTehICbT+51uKX8b1I7YGAmMkVcJSZcYHUxTrPfArIkf/gHJzzMKS
 D6y9p4aBB1ecJrc58bNnuBeGrSi9AAmHFDpTE/E9oed8+JlGYHjWqPSAcfeNsprExYXa
 WyhB2+5vJ8nzojVkbFs9YfGmY9KiInU6PAgU7uuoO9h1enCTqx6POE3ihl2XWNkHWel8
 tu4g==
X-Gm-Message-State: AOJu0Yy+IqtKI+LuFhDmGRs2cWKpaVGRmm1GUeF+oZkB3/JVYXktKvi+
 BAE1KcM05iIuOSYq6aWzNZUJYyITm3gkZZMFX7zWAy3sACEUHkF/VtzhZYiz7q4=
X-Google-Smtp-Source: AGHT+IEBZ2Xm8jv58dcCxOD7P/gKJ+Fk3KiL3uBmuVpAUDZ1+nexSoP5C6ISi55v3wiRZy82mh/sGQ==
X-Received: by 2002:a05:690c:dc5:b0:65f:d27d:3f6a with SMTP id
 00721157ae682-6db44d61d1dmr11006537b3.7.1725584974166; 
 Thu, 05 Sep 2024 18:09:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef3a9cdsm125167985a.33.2024.09.05.18.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 18:09:33 -0700 (PDT)
Date: Thu, 5 Sep 2024 19:09:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
Cc: u-boot@lists.denx.de, jh80.chung@samsung.com,
 cheehong.ang@starfivetech.com, Alex Soo <yuklin.soo@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
Subject: Re: [PATCH v2] mmc: sdhci-cadence: Add support for Cadence sdmmc v6
Message-ID: <20240906010930.GG2479150@bill-the-cat>
References: <20231128063859.615-1-kuanlim.lee@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l39XXTLk9YDaNXlG"
Content-Disposition: inline
In-Reply-To: <20231128063859.615-1-kuanlim.lee@starfivetech.com>
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


--l39XXTLk9YDaNXlG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:38:30PM +0800, Kuan Lim Lee wrote:

> Cadence SDMMC v6 controller has a lot of changes on initialize
> compared to v4 controller. PHY is needed by v6 controller.
>=20
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Co-developed-by: Alex Soo <yuklin.soo@starfivetech.com>
> Signed-off-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to u-boot/next, thanks!

--=20
Tom

--l39XXTLk9YDaNXlG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbaVkMACgkQFHw5/5Y0
tywq2Av8CzegWO/H5cA6Wq24sSQNAMmD+6bEOcVrYxFeisLzB93kyXt7kHh+GG0O
NAa5kgwSia9XqWxdpsSAC6NHQC34NazVsfQLrQbTnZ2+TT4+tYRJLzZ73HN4mttZ
AoY1TqeoQsYwceJEKlYijKCKQqQiKUjz4Xf0ONPNRWXpqUTc0fOtq4lCElvIROGP
VHvn4VT7EfhOkgjxvAINHFWSJHmz5Cl5N1tXj/xIfvityBCFhfsUWnIe02mn7VaC
sKTyC0sBLPf1GE9+UxXTnJq0575ylp695CmxKb+uASdrcHHmVyKfZEa8tonHJY9L
8Jwmroq9suzCBp1/ebPC4/BNmV+PTf1fIs7qqG6xRzXhCtnnnu3etL+KDT0C5X6j
MClPStBYVHFiArPT/PZvF0+XjqO7ycAsbRJ2BdCemg8Ha4O4W/LxHv89dujQgvmE
4HAb1nG4yfciHy8beiPnzhbG3slBjaC0w3uJalV33krDiQhl9QsvMWKgR9ouYpGJ
oBtvxjNo
=7/R2
-----END PGP SIGNATURE-----

--l39XXTLk9YDaNXlG--
