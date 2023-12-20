Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BFEC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F07087849;
	Wed, 20 Dec 2023 22:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cl89APPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C1787849; Wed, 20 Dec 2023 22:01:38 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44748784B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dbd73620c82so101147276.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106094; x=1703710894; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cNRFsMyQd6WoOw8DKtPHfsfkn/WRkoVx2pAzSHty7yg=;
 b=cl89APPkwyP1HjS6MYgdBwE6cQu+ghTaFNDMHTkGsoMu7z4AXN1BvdgIPO4ajiqsTl
 LjH3yHaVaT6hsmbvTvG5ZcrbaznMeeJD2IQv5eXd2iPt9TNG/LnGUtZj6HQUu/VYzVnV
 qwwXTavYa21ipcnoGOFZAuGf3mvkI0dp2mDWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106094; x=1703710894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNRFsMyQd6WoOw8DKtPHfsfkn/WRkoVx2pAzSHty7yg=;
 b=JxWRxbnkUP4tmFKuT5LoUbUA5Wn1T/DcgYx1WPITb3L75J1mZb0HFf/GCBfoGr3r/l
 lWeS4Sff5GqJUwMcTKgK6Hb/2GZNumrrQpDkjtIVkgBwzLp0maXvu5KyPic5VpbkSQSj
 e3dFjWdZ4OKTxYkgNdolrC4VQSJT835VjRPFXb0qdbkaWoeDGcvcN8HPC64UrDi5u5Rp
 mlFZ9UmflVOlvSQeMOKV4K8kO1o5WN6mHI1k//Pd30qoT+Lhh3jodi1VvnKNTANnvV6B
 B0drjyRwx/fvqWSHAVnKY/ycV63UnnlBghvneltQkcLPYlvMltQlu3KwruW0WznwoInO
 i3qA==
X-Gm-Message-State: AOJu0YwjQeLWO5y6gf2GLtOmkKSNeURiyZrMutvesUyO8KuBbqeRIpv0
 XHR5zCBn2eE001yw7ZS+92hffXk6w0sULUpAfPU=
X-Google-Smtp-Source: AGHT+IE/EPYuxWKCShM2RP++K5/bkifOQTVX+tuZLUV7UMJvRgcs2UrVRjG8pFbxnJ+ZZ1TO8d3X6g==
X-Received: by 2002:a25:d0d5:0:b0:dbd:9abd:f2ea with SMTP id
 h204-20020a25d0d5000000b00dbd9abdf2eamr306600ybg.35.1703106094306; 
 Wed, 20 Dec 2023 13:01:34 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a258241000000b00d8679407796sm216461ybn.48.2023.12.20.13.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:01:33 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-next-20231220
Message-ID: <20231220210132.GS2513409@bill-the-cat>
References: <20231220182119.1444897-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uz66lWgxnFdCwuKH"
Content-Disposition: inline
In-Reply-To: <20231220182119.1444897-1-festevam@gmail.com>
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


--uz66lWgxnFdCwuKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:21:19PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull this u-boot-imx material targetted for 'next', thanks.
>=20
> The following changes since commit f7655af980dc376783bbdac833e450a86e3255=
f4:
>=20
>   Merge tag 'u-boot-amlogic-next-20231220' of https://source.denx.de/u-bo=
ot/custodians/u-boot-amlogic into next (2023-12-20 08:34:12 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20231220
>=20
> for you to fetch changes up to 8a72d193cf15cf0d6936886db4b2dd75956fb4d8:
>=20
>   colibri-imx8x: configure usb hub to bypass mode (2023-12-20 15:04:46 -0=
300)
>=20
> u-boot-imx-next-20231220

Applied to u-boot/next, thanks!

--=20
Tom

--uz66lWgxnFdCwuKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDViwACgkQFHw5/5Y0
tywV3gv/alYDc+d0nVXfzVtnat7LnvF3F8a6ChN+DmWfP7alCRP51fMZfCpXQZjv
ajEnSJPd27iWRhu/fR+6+2eYLHnXfHuqCNnLxYRHtpmrXUReMcVBlOc/7qdQjK/N
nsCIySjwjD4xEXa0ebTQzU7bokdGf0f7ygokodxU9TcRlUcBZ1UwIopHhwtrBh91
iVL66lX9UnZ6FLXOGQs13oUgqK2OMpxx2RKcEMz8QvG4wJ79JRpgJfpb+MgKVc4y
BDbXOvMTFFhm57y4XMGKJ/9cvL7B8S6sW4M04hceHEnLtO0BnVioJjb8mVYPmroW
5g0lhNeIqQFtrt3wqOI24pk9lYKhKpWcztDH2V4cyZlZfVpxr6oJJGqCSTfVvkfv
f4Ae22aT/9YQvUz90vceJFXa0z5uv1/88sjKM6N1G0dGfhMKFKtjzSDpVu64GGB5
53Edy9hjXnWLoJ2dZCGq5Yk5QFOBl3Fr6TWbfUoa7UjH+oeGB8Tu/Dl6wFsMvZsT
rIV441pZ
=70lE
-----END PGP SIGNATURE-----

--uz66lWgxnFdCwuKH--
