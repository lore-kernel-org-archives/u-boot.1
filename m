Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD326C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 19:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49FD9889BD;
	Mon, 22 Apr 2024 21:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gdKuPzZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E577C889BC; Mon, 22 Apr 2024 21:36:10 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E24A889BB
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 21:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-790745f0fabso81633085a.0
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713814567; x=1714419367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DF/I6quatRoc3ag0yaUOIEgEeEu6NMjECCT6xBETE5U=;
 b=gdKuPzZMbEBRDKjVUg8LFsMyo15AHd/b9Df+UKfYr3y2HgohvYW121iA3fLwDIaiRk
 Wlpz+Ymq4qPUEzBhBmvHWxb3alaKywpoGW86Vz+DX7Rgrm4EFbpW1ZM5cTHSQ1spoHA3
 G6EUGNaZG4bEaegNskRHRB/ehHUTt2zgHiUz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713814567; x=1714419367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DF/I6quatRoc3ag0yaUOIEgEeEu6NMjECCT6xBETE5U=;
 b=YHEE86Q7Nyio9SS3UyBmils+urUawzNddHPgUutaI2LSF/ITlMd6+/Skb+My3MCiLa
 HBKLFUV65WMBKKNtnk/4JXqiFPH4Bu7hH2lrdQIYcqJ99RgRNj6OVEDsN+Mx6Qt/AbJx
 Ydu98xgH+gEdsVykZ9o+M0Rb87jmyaq+HH5+Qq61uG2BVLEdiHE/VtdiGSv2YQJD//3j
 kFlnjbMf2/uEG7UgdV+U675sGpJ0+K7ZOxjh14tkyFu+VtIQF81eYkyZIw9VRtwx+2QK
 bdDIthyyqMur8JYxIDSZE0CjzmRwcMBkAExe6DUULqh1lrsCSO7NJh+tnjyTRF6l44hT
 chBg==
X-Gm-Message-State: AOJu0YwZvoBfxU7rskuMQC2oP0A5jW3nGl2IqnaybcKsx7YOziyznQ61
 v48meEvyYZV3xLQW3hmi5ONmYuKAJRKyAeRIUF4avi+0jxPQJ0xs4RphirymrAM=
X-Google-Smtp-Source: AGHT+IGi2bLPK+imHcsb+ZRw/yqq6XzBaKYtO8+c5Q2s30wosf3S6gA9F7+JiNUtfeK9XojzPnSCGw==
X-Received: by 2002:a05:620a:13d7:b0:78e:d2e7:3e9e with SMTP id
 g23-20020a05620a13d700b0078ed2e73e9emr12818086qkl.68.1713814567423; 
 Mon, 22 Apr 2024 12:36:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 t26-20020a05620a035a00b0078f04e04842sm4520931qkm.132.2024.04.22.12.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 12:36:06 -0700 (PDT)
Date: Mon, 22 Apr 2024 13:36:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: Pull request: u-boot-sunxi/master for v2024.07
Message-ID: <20240422193604.GW1054907@bill-the-cat>
References: <20240422162249.2479071-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WDRV1FOWGBTEcE9f"
Content-Disposition: inline
In-Reply-To: <20240422162249.2479071-1-andre.przywara@arm.com>
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


--WDRV1FOWGBTEcE9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 05:22:49PM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> as per the usual late ;-) please pull the sunxi/master branch, containing
> some 2024.07 changes for Allwinner. Not many and nothing really exciting
> this time: there are more patches in fly, but they are not ready yet.
> I will also send some DT updates and new board defconfig files later, once
> they have seen the list. I am aware of the USB rebasing repo efforts,
> but would like to see how this plays out, also we have one compatibility
> issue that I painstakingly work around in the U-Boot tree for the last th=
ree
> years or so. So for now I stick to the previous approach.
>=20
> So now just some easy changes: support for USB peripheral mode on the
> Allwinner F1C100s, T113-s3 SPI boot support, and some SPL cleanup patches.
>=20
> The branch passed the gitlab CI run, and brief boot testing on some boards
> didn't turn up any issues.
>=20
> Please pull!
>=20
> Cheers,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit c08685289171e68afd4bae2eb2e279cdc49a40=
7d:
>=20
>   Merge tag 'u-boot-imx-master-20240420' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-04-20 15:16:17 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to 192c5c9e51c1ef100c3d027d253ffad26ff75a68:
>=20
>   sunxi: sun9i: make more clock functions SPL only (2024-04-22 01:12:26 +=
0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--WDRV1FOWGBTEcE9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYmvCEACgkQFHw5/5Y0
tyw37gv7B5nLpp2WPfUwWL0eb9wrRNjio+xj27GUSGBCxIaPKel2Tvde+VCNHEQY
BWT/wiq4EpOHkxQjrQp1LjpwTBoUfWwqalW47oxxtRl6UAxVVwUgYO9l0R3yN79I
9664nxwSmu1zcgwkVT/I4ZYq3npZkD3z0WtLKjNy18UN4QxUddzTlN/kN/kSi2zl
XAiC6wM+nrkilIO5IXmf9222dhCa3l9nqQxGw5JtyTZv5kPOA8LF05jZVlhTcHGV
FIv5XZEURHBBrIdkDSulPgyQL/iLcFdsqtRIPT4Ll1ucWsxGJUrEwWbdolIzAzc4
cHLwMVH5FvghhDfkFeLfBCB1QeN8ZvCGu3Oe7oHTHmvBmUR3x+MJvCQn8gRx89Ae
5b4y08C/PdzKuv3FkLZ/JWzVSywlfbCSGwK/fGkW8AzmOSK7jADLid/1O34k4s9I
9yMKkwqKacgaRBCLXaRKSWyl0lQbAdQYCDKAAtuDu+GaIOicuxT5mmT3A7r5++4S
UmjtfhIt
=Pifb
-----END PGP SIGNATURE-----

--WDRV1FOWGBTEcE9f--
