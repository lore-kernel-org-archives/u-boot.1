Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA17C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C5BE878E3;
	Sat, 28 Oct 2023 15:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EPRbKkyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B2C87BB9; Sat, 28 Oct 2023 15:27:18 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5537887BD0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4197fa36b6aso20614481cf.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499635; x=1699104435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SMyQTFT7gJvPtzYBYLa6GkL/b8UCjwLn45BMYBVJgXY=;
 b=EPRbKkytKAJ6Zsk7d4YaknM/Hqejmj6VXbfkYJkbQHN7leMK9YgkIcVa58WEjMnLvW
 cNp8uKiZcJimGNkAKaaMiEDB9BdGHyEMSSnvKw0Rqkw5XjUQAit3TRfy8mTtoHVjiRRl
 T6Y0ArBfiIIPbWe90VVd98fbqyPqETowNuZLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499635; x=1699104435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMyQTFT7gJvPtzYBYLa6GkL/b8UCjwLn45BMYBVJgXY=;
 b=aSHlBTM4XtfV6Gyd7N5Xz6R2vaSdt+Cb5MK0DX3NGgJy8km6G9cm4oxcyLqN9z/Ohf
 2f2JC4qoRS7nXq0LPkEaLYDLMCXVG4RfZ+DSmg/z0BnwrMZHB2U/fkSdX1Os1lyyTYa8
 zzuiT99loy0+VkxvmLJJE2JdSo5jPHfie4/Ar0XqfJrKQcRQ2pAuZ79dpoGgZXUxdxrQ
 yHw9WKizkxJ0iF+HUD8h/mLgT5oFdUJR6brL+W1CVB296nvd5V6w26Ax5O4aUAlU/58s
 J7XFYNudV1npTvkKUTeNoBAQmPlI1nMiLWfpWhjxIDxvCL9Rnm0kDhL4U4iP0CuEGmFB
 vUCA==
X-Gm-Message-State: AOJu0YyN2eEZKQlakurdHslAlgaSh0D6ALC3p2lNIRxa0XaM74ZS3nM9
 GVgfQh+SAgR1uAXwKP598x4VMklegx2OjP0EnibfXA==
X-Google-Smtp-Source: AGHT+IE3U+sgyOU45yw9U1gqqFFiIhdBXBMDTk1JDTKJnlDhT10hNuCYxKIUUYKbXB+3ZnPFeNPNVw==
X-Received: by 2002:ac8:5c96:0:b0:41c:bf98:dab1 with SMTP id
 r22-20020ac85c96000000b0041cbf98dab1mr6370980qta.13.1698499634911; 
 Sat, 28 Oct 2023 06:27:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 w19-20020ac87e93000000b004198f248e8dsm1602661qtj.76.2023.10.28.06.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:27:14 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:27:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1] board: toradex: verdin-imx8mp: enable usb device and
 fastboot support
Message-ID: <20231028132712.GL496310@bill-the-cat>
References: <20230828213803.454303-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bMq+r7gU1NVgNb78"
Content-Disposition: inline
In-Reply-To: <20230828213803.454303-1-marcel@ziswiler.com>
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


--bMq+r7gU1NVgNb78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 11:38:02PM +0200, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Enable USB device and fastboot support which may be used to load the
> Toradex Easy Installer FIT image.
>=20
> While at it also enable USB mass storage aka UMS support.
>=20
> Note that the i.MX 8M Plus recovery mode support is based on the USB
> boot stage of the BOOTROM and does NOT require USB SDP SPL aka serial
> downloader support.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--bMq+r7gU1NVgNb78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DDAACgkQFHw5/5Y0
tywXngwAmCY80C4qMdwEdQKIhjatvxwMCqVTSJZ9HX9WJlVSNnMkSEZTl8NwaCWo
30MIUsDIOxljuCqY5VziaC5P45zZFVPgqOPXGHkrAB9E65lrbMBe2yS9yIJQSEpk
ghh2b4SrH/OfI3KkJGa4a3r5CYo/Rv5kEr7zOczeTf1zBwOwijh79yT/Khodps8l
haO/uk6OAuiwZgkmT0WCA9yIUjzBi5Zg2fRp1QkRhe+f1xa27+zdNvNqB2QB4Ztu
BfbJ9nlAoSwHlilloVcUsV/N6G1kVM74OqJtu3PE8F/drPnEAg7OVoJmGIlCyvwS
oFXqN5aMyb8sAbRGxWcLYoDWqPrrZ3r3S4J6eTEcMsB5cYEFBekmGqa9pxAj24FL
Ww4N9tVLVP7Oor6UP8E5c6nTBAeEbu9Yf/5opjlHQufANNbIkB3MrZUV5tUbyorz
UEmG8s87zCMruEYn6Vt8QwPk0SHz/n+wSWFHH8NnN4TyotMPYd4rV7HJFjOxS2cn
PM2U1h6c
=tzUw
-----END PGP SIGNATURE-----

--bMq+r7gU1NVgNb78--
