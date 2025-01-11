Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F44E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678D380619;
	Sat, 11 Jan 2025 01:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QuqI8Cws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2078680050; Sat, 11 Jan 2025 01:57:26 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06771801CE
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b700c13edaso146319485a.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736557042; x=1737161842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9jooCcwmxSv28DAnaByevaFyNyu2C/kNbvxust9TV7E=;
 b=QuqI8CwsYF/4Hx6p7fvKwhAjxSAqC16p5KbUatlmanspYDMqS1qH9fMbc6Y6pAO4Tw
 pZOH49LE9hY2AYHsAlk9kj1g0PK0oEFjzCzpq3CgUen6OaY3ohUZR6WA2VZSo41qlt60
 +V/PAy/pKaSfYdrfqwu9ig4R/U6YwwWE19lnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736557042; x=1737161842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jooCcwmxSv28DAnaByevaFyNyu2C/kNbvxust9TV7E=;
 b=hUrUNdT++LE27nlFHzcp4p+aHuyxy4n6g8BY/4Rnu/ybhbMyteTjOcwNCthcGsRYA4
 rOdYSRG/ZT4MC0AMDvmHOo0Mgstc/7+cs9miMsJB/o8Ih/5MFtQK3CT0QiVn3WKIzQFD
 vbMMlBD1rx5CSb/UBzGpYb2d1FmiYD9KPwBqvzhSmmpJv1BiXSQoz23wkrQjMEvzulL9
 XI9G+fqmVzqdcLfMtwSxMceTTj0lXUCvx1jWfcB+BFlTNczMNeRreF7PS5t/H7u9K5jl
 eIM7RUb2aM6mDICKIhhGFpeGZVEgWYmIpP/UfFs21Y3yWbqpK7f48P27cKWDRQOwbmJJ
 zz/A==
X-Gm-Message-State: AOJu0Yz7k16o4gYCDutbIUyzo1nCWcmaPpU3fwBRDB4NGw++fDS1aRlC
 6uRHwp0Zvct1IuUkIMq1EO+ZB/Qudsh3NNDnCqurR5fFX8R6CZXsKAySWOvvBk3zrRI78bpgMcN
 E
X-Gm-Gg: ASbGncvojLj2uyKh/qpXz89UROYj6h3BiGFzPDx/83YrKVPxIfY0jjMz/GEtGSmiPkt
 nVEZYDOVB2eIGZuSRGZG8ckyNV4t8rCccZVjfN07DaKQ0wykV8AHQGGF31RBd/MfTPttVSnlE8P
 I/O93VS8tWKk7djXa0EOw9LBOw4/XQdhX+wIeJ3WlJXwroF9LyQ8Sy9qCULDYFYVCu7mzOddoWX
 NbHa/+oxdcHomfJ8a40noT3GExj7kFolG/Ww+Kgnc6E1lig2fySF+8=
X-Google-Smtp-Source: AGHT+IFrxSxUQ0KblywmqBNvmuuw73DKUUywfle7y3NONibrU+oosEkUFXLBvvhLk3b0Zt+8w2v0Jg==
X-Received: by 2002:a05:620a:1a83:b0:7b6:6ee8:6c03 with SMTP id
 af79cd13be357-7bcd97aecd0mr1902210785a.58.1736557041846; 
 Fri, 10 Jan 2025 16:57:21 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3515f88sm228580185a.104.2025.01.10.16.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:57:20 -0800 (PST)
Date: Fri, 10 Jan 2025 18:57:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20250110
Message-ID: <20250111005717.GR3476@bill-the-cat>
References: <20250110100856.1567840-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vaoJv2vw6Ems5KRl"
Content-Disposition: inline
In-Reply-To: <20250110100856.1567840-1-kever.yang@rock-chips.com>
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


--vaoJv2vw6Ems5KRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 06:08:56PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add boards:
> 	rk3566: FriendlyARM NanoPi R3S
> 	rk3588s: Radxa ROCK 5C,
> 	rk3588: Khadas Edge2
> - Migrate to OF_UPSTREAM:
> 	rk3066a/rk3188;
> 	rk3288: tinker, miqi, firefly;
> - Migrate to TPL: rk3399 kevin and bob;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/24129
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 38a371110308ebeb277e20531a7b698b7981bb=
fa:
>=20
>   Merge tag 'tpm-master-07012025' of https://source.denx.de/u-boot/custod=
ians/u-boot-tpm (2025-01-09 11:11:27 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20250110
>=20
> for you to fetch changes up to 34df868161e470e5de04db059daa90f12e824693:
>=20
>   rockchip: rk3308: Implement checkboard() to print SoC variant (2025-01-=
10 15:17:26 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--vaoJv2vw6Ems5KRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBwe0ACgkQFHw5/5Y0
tyxK3wv/WsUTYyY7s9ybFwg4F9Clcxsn4U3UvANNLXoR8l7zbp2O3f46PUk8kAWS
qKVReMku2kKiDjxsB/GnVfR02apW2t1NhN12Y+PQzoioX4Obf479mSRjnAajabJ9
td10B8p8qR+MrXiZGdBPdwh1WEbnfdwU/EQINGrp9A6vWLW0vbmBzYZeTGbZ1n88
f49W9RLXJxmh3bvJs9Y4byqcmv/fz/dFVjlBo7mlRf6SdcxWeqYR91GPy/8JyjFD
grfm+UqcmnJriWtdEerkPvpgoaN5AXkOBYV/0GRTHDpXTCdm6z7OTifepp1T11Nt
Y6PU8Ji3tj5UWQ6kBzuPHaqMwAYw9HrCypf3YKw4XgZvOuheWhy2pI6UEiUczJ5I
0eL1Za2QDdHtKQ/XvSE3FopXbmcVjOer0okAvFQNtfUPKE5nKLUqrvwXzsFjAAWN
7+4dGrUpbdud5PVQ/ZwqhdEJax6r0GXUwkMUN+vead5n1VikjFTroAS5CLzTsYQI
sfi3CzFE
=qlkY
-----END PGP SIGNATURE-----

--vaoJv2vw6Ems5KRl--
