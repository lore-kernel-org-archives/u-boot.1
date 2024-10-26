Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E54FD0C604
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 22:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F0188F92;
	Sun, 27 Oct 2024 00:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NsFwGs0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEE988FBB; Sun, 27 Oct 2024 00:33:58 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C9D88D94
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 00:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so23644456d6.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729982023; x=1730586823; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UtYU5vvSfweOO1iiqyKevwfOlnZOcjRI3hMzOHUPD5o=;
 b=NsFwGs0P+yfvIFeecnnDkFLTsa6Idf5nns//XlBdZJ7yQaGkUnQYX3A0yLrIbnu1qA
 Jq1Oh6GjfA2iJDe3KKw6gC/Ds1CzQSamOf7L7aF3/MemEtcnyhWj60+D+QvMMDe2x9IN
 afRR+eMQkjzuCsWFcK93aAsHfsx1BEL8go/i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729982023; x=1730586823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtYU5vvSfweOO1iiqyKevwfOlnZOcjRI3hMzOHUPD5o=;
 b=KGFtE4v2lnn/CUb6jnU4XWhQcL428/paRqsqZW9fzX00aulYEcN0iurESJEc1mYyto
 qCs6as2igzvUDtDwlW5ebEuic/rCioASdydn0dSX6emeB0R5pvIJTGk89CylpRr9Cdhg
 uDkKVqAWw+/lG/6Fgb7us6Mxd4xETTm18RSb0XAXdb3J4CffgKYfBfw8Z6ij52/QVpky
 bGUoI0316g7hQmx39tCxa+5BdmkdGztzPtsZ2y5QeHsoZKlzGtfzKFKLFmyuL3tKhol6
 FvytqlW6cdaYTiQc4DE7e+DPOEPT7h49Vb+iCCOy0gL6bpANeBkEEZJ2AmnxlqKweC9I
 Q22w==
X-Gm-Message-State: AOJu0YzkiJ+/XogF4f63Y/qyuGIkCvDyYW6IaD3x+r7F9VfdNp/ZULWY
 OuGLUbN1AINaLM1KmGGUbjT1GZlTkr3dqQMjaSdTElfwKN+hqXx+qvALPpWJcRGKE44rOn5v7Su
 /23I=
X-Google-Smtp-Source: AGHT+IFgIYbqaLRNkA7xULYIiSqiqM7ppSx/Zjgm5lUBHMUgSnWBLDSD8WoCk2GttrPBxxK+sNo+2A==
X-Received: by 2002:a05:6214:2c13:b0:6cb:f87f:f073 with SMTP id
 6a1803df08f44-6d18568dd5amr82053846d6.6.1729982023517; 
 Sat, 26 Oct 2024 15:33:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798a84absm19119756d6.39.2024.10.26.15.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 15:33:42 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:33:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20241026
Message-ID: <20241026223339.GH4959@bill-the-cat>
References: <20241026091356.608645-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q5pv/46FKFiFeiXM"
Content-Disposition: inline
In-Reply-To: <20241026091356.608645-1-kever.yang@rock-chips.com>
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


--Q5pv/46FKFiFeiXM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 05:13:56PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the update for rockchip platform:
> - New boards:
> 	rk3566: Hardkernel ODROID-M1S
> 	rk3588s: Hardkernel ODROID-M2
> 	rk3588: NanoPC-T6 LTS
> - Migrate to use USB_DWC3_GENERIC for rk3328
> - Other board level config and dts update
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22993
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 08ae12be8509daf3d1c5a148b8a50c0ffb6457=
c2:
>=20
>   Mark a few functions static inline (2024-10-24 11:21:48 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20241026
>=20
> for you to fetch changes up to 7cec3e701940064b2cfc0cf8b80ff24c391c55ec:
>=20
>   rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS (2024-10-26 1=
0:46:48 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Q5pv/46FKFiFeiXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcdbkAACgkQFHw5/5Y0
tyyYAwwApYh53VTLk/iNq+ZZDYTN1xUQlw/LF9zREaBZoUDPSetwG25xJVhu40DG
f7Bwk04h0yZcdEpl8nDiqcVsH7459PQWjfA17oPe2t7jQn3GhGvl/VNFnMHXtyUc
jgqlNumKI67WFyv1zcHLXx23XjGf3+7/CcnddnC0JEATbs7aNjuCxLQIVwN/Wis+
FaPmO6xjuVLbXbh8Qr6Bt8Of0RHIBHnuPXbmd+omeDtxQo+u7ZJrYCnyASWe02M4
fzPEclpB6xnSqWN68An5ur8CJy6n1sKAgrv/ctScBoUAko/zs/au7YfG8K0BbuRk
ucq7RloM+TP0HCjPyf6AMdU9D76hH7e0a4zq5ZSlk1eFh6I9n65pRMY1KGDs5nco
eG0ikEvsVcKqpjHjwTHymoj7aggZwqyx8vgiQKcCRY218PXLeQFrnSBnjw+tvPSs
qHfzoW1Kl9B96rJKACETX/REJePkLMZo/DRh28frlyciJO5Fx6PYXQ95n76yfr2m
qnXQfN78
=jlXW
-----END PGP SIGNATURE-----

--Q5pv/46FKFiFeiXM--
