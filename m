Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E655E668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646578975E;
	Sun, 24 Nov 2024 20:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YteOFOZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D5C8958E; Sun, 24 Nov 2024 20:06:10 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6585389574
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d419832bf5so33352746d6.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732475167; x=1733079967; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+lpRxvK4M8RZ6IdvzV6M15pkWJ7CpsmGnEp/SfYbJCI=;
 b=YteOFOZ7uc3uYwhddEz1HvwfQRppxjrgPDAcTXjzTRPMeGSUmispnjbYWVqmrTqvyT
 zXMK2LzrNdAKJDH1m03Y2i14OyofyOl5yP9XXqO7mvOjviSKJUuKRrH2C+FsfPIkf2+a
 7My2YaPnB9C83YFwQ7tadL3+j+OEoITDynYNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475167; x=1733079967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lpRxvK4M8RZ6IdvzV6M15pkWJ7CpsmGnEp/SfYbJCI=;
 b=HiC11ogFJvV1yMZgcVjmfqxtiktvGmizQmY/OrI/8FOSFcHxM9fWSg3L+Kj+icCksV
 W8oo3Cst0VgpTylFJJgntWNeBTSGOAVeUEG30J7XJsvMv27x4/Zr97jCf1k8Ka1Xb9gx
 cBe19c+wKLV+AbPvQcblkLJze+ox44d0IKzm+OtN9KGoM1SCfeTZFePMkILTWfCnnWYU
 bi0fRVK6/gkfEh/GoRdQB6h1iBOKe1VmHUP9Og7h5CXJs+8bpPGAUNqnq3dYZBcKz/fB
 sdE7wjysP7laBaOb2lUBVb/AObS2JMabhZO26Eu7XxtmeGrnydmhIv84S1hNC6gOJVGh
 jj8w==
X-Gm-Message-State: AOJu0YwSfzMCANkNcvHuudLWk39i5mJPxvzs+RYzXZuoRp//FAOxeC07
 4c9YY1sB59Iw07XqkUl2iBifq181aDADMR4YL6vSZ9hnh1g23xbS3RyTTdm9JcW6ITnQ0z8cjXt
 vMNs=
X-Gm-Gg: ASbGncu9Car7pQk9aV3mOUS/54Kr5cBD57LTZwofNzph9lAFF9ig0jEOo8v64rGyURk
 puMoOo11AuHWhFg05wvAlfSZlaX8BzwgwlmFwQzbi99UfVecU6eAJU9N8jCVJXAfFQTkHV8suBl
 znUduc5b2NUvBTmkW8gAzEUG8vyX2NUPKba0NI+JmxcEyp+KcRatNUhcP07h5uR7yA1i+LHXv7M
 4663/snwHaoT3W8QZCuUX9qiorOjUC6uBavb0eziVLepgkidQ==
X-Google-Smtp-Source: AGHT+IEfsjdtSg92+NNzs2nlIt6oj0VAzYbhLAwuc5+0zhmVtHn5JUxgf1QAPap6fuwT/9XLrob2Tw==
X-Received: by 2002:ad4:5c63:0:b0:6d4:d7a:89f7 with SMTP id
 6a1803df08f44-6d4514b6256mr165580786d6.44.1732475167327; 
 Sun, 24 Nov 2024 11:06:07 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451a83769sm34380746d6.14.2024.11.24.11.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:06:06 -0800 (PST)
Date: Sun, 24 Nov 2024 13:06:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [MASTER] Pull request efi-2025-01-rc3
Message-ID: <20241124190603.GG3600562@bill-the-cat>
References: <ce72d064-807a-47a6-abb8-e9110c63b739@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8Gqj0WQvTbcqU1CU"
Content-Disposition: inline
In-Reply-To: <ce72d064-807a-47a6-abb8-e9110c63b739@gmx.de>
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


--8Gqj0WQvTbcqU1CU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 04:34:16PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941=
c7:
>=20
>   Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-01-rc3
>=20
> for you to fetch changes up to 967d57ab592ce1bcab0785f8483b1b43c2d881aa:
>=20
>   lmb: Correctly unmap and free memory on errors (2024-11-24 15:25:03
> +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23529
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--8Gqj0WQvTbcqU1CU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdDeRsACgkQFHw5/5Y0
tyxUygv/S0YSekUGmIGfMlCj/o1slQ5PYEUh0ApcpEr9hj+bLtSSdGfijPZuqz0/
y/Ux4+yMvZacM2wW0+o70nQ9SPQxSY9HOE8Mq1P7gdKWZdKrx87Q31GqWi5KU/dg
YY2sqa13tc58loAbyeNUlFw8nmVMVSObH7Lj6Lvkr+AdiwwLDMERnhpzQtc4vPsR
ArWUzwCrB61OZAiYz2c7D/CBFvMB//Zg8nHgd47OrccvCOgX5hO7MFSDrKDIMcFX
SKx6BIpvuzbmg4+DdnzCSKONgpBmjJ0A4qgQMnoHAJWqfzS6CBxNlWe3pQJfHxoa
pizzMMgY3O0xUk88PmojHLuFmX6ZW8/fOPMxoGMdXTaY1muJmuN8psp9jHt8Pa2Y
kYmhkVwJVQ3cjVezlhK1jmwBcdyB8OprukOr2ezF9ih/41JipcksMH7/3QGJmsdn
ua0YwUNkh17x5lYdERSagh2X+Fsel+5C98Qg6N1JoiK71VEF6w9LiFmlGyBRp/gT
Cz5xAjf3
=Bv86
-----END PGP SIGNATURE-----

--8Gqj0WQvTbcqU1CU--
