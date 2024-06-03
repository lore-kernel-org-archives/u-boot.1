Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78894C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 17:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9E88835E;
	Mon,  3 Jun 2024 19:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uCXvozAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1848787EB4; Mon,  3 Jun 2024 19:42:22 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B296883AC
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 19:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b97a071c92so2143472eaf.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717436538; x=1718041338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h1sUbeWxIOONqgTZ+BnmZ4KmZsMQujiUp8ae1QjU+Rw=;
 b=uCXvozAaQUJzpHEAapvbUtAIdJcVouZp7T0T/BoEeMr+4GSDIwfeavoRSSGPhhi5W6
 6N+oOjlbO7ciWEefbrmib16+AO63KKVolB5+wLD1Cwdgy3DBM40qCB3PYf7whjO87A1j
 q6AECX4fn0BaOPd//dzvN3bbKWyzZUbNGeydA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717436538; x=1718041338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1sUbeWxIOONqgTZ+BnmZ4KmZsMQujiUp8ae1QjU+Rw=;
 b=WTNzcDx7R4vKCU8npk4Tkj7x+kfWiInVj+SMgwWGrC/2WFjYqBmZyLEigerxmki4ZT
 1NOCIG0L+cOrDhhN8viguXji6s48a4JIJIakP73KHp5vyWsyZhaQCd/D7TbkQub26LfQ
 NeGy6exT9tL06m/4TginYm5vLr2/tPIqTJr2V+mHvzZUaPagJuGPRenaaiYlSiZRrzSN
 NOWMm4Emg2QzCVFs6fVHnbxwoixP+C4pFHOkeSpaXz0gTBUZdaxQCVEe+bNUQjTddKov
 U65IUSPcPDpjze6w7GxBqDT+sx6iNRjY76yYpFSHCX4G4smWp0LcgbTDwuYOVzzu9lbG
 b8iQ==
X-Gm-Message-State: AOJu0YyZ0+Urv2umtWeDpaBAwb7fdyzp1Wb4Uxf7tgUyW0in0L6nHVhp
 gMCRKD5zdoeAGLniXfKXi1sezvTom0SHC3nvogfz+u3IP3bpI/2AdYhe4ILIVTA=
X-Google-Smtp-Source: AGHT+IF1CnbRlO0Fk+PHqx/L/khF7aT8HxDFTAl9YtSAGhuCGyXh35GQ6fKRp5o0E8eGxvWKOab89Q==
X-Received: by 2002:a05:6820:1aca:b0:5b8:75ce:1787 with SMTP id
 006d021491bc7-5ba05cb1125mr10352536eaf.6.1717436538138; 
 Mon, 03 Jun 2024 10:42:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba0034a107sm1581386eaf.2.2024.06.03.10.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:42:17 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:42:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20240603174215.GD68077@bill-the-cat>
References: <CGME20240603060854epcas1p207233f59828c47f31e941894634b9af7@epcas1p2.samsung.com>
 <166001dab57c$83114450$8933ccf0$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UUbYJdA97JBrqmCv"
Content-Disposition: inline
In-Reply-To: <166001dab57c$83114450$8933ccf0$@samsung.com>
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


--UUbYJdA97JBrqmCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 03:08:53PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit 46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd=
9a:
>=20
>   Merge tag 'tpm-master-27052024' of
> https://source.denx.de/u-boot/custodians/u-boot-tpm (2024-05-27 08:56:02
> -0600)
>=20
> are available in the git repository at:
>=20
>   46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd9a=20
>=20
> for you to fetch changes up to 7045c4dd04648fd2ba1806b75e139d941db0d6c5:
>=20
>   arm: exynos: Map iRAM APM area for Exynos850 SoC (2024-05-28 11:54:07
> +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--UUbYJdA97JBrqmCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeAHcACgkQFHw5/5Y0
tyw7hgwAnQaOYoeAj+dJlK7W/muoLeXaZv8X2a6NvA+s6FgnZoebav+KdvHUoXh0
YXVGEwXCDTIk82tYMaB9Sue1KLDltSuzZU4rXPUQQ6KwGHsLYG+62TzCyhEaps97
fZSPanU8AIYqibfmRLWI0n5tTBV2o1+Kpfm54GV/zm4rc8Ow17JChXup36UFqdtw
1XrpUFb/7JqyM9m0QdC5kpeJVQG+A80aw7DyOonf7fHWGPQodU89KUCRMK6OTPkc
YF8YbHcO+nWwIZ8NTewwE/zcQmF96eEy8JQYWzvvrgHxlCsJFQ6/6GVT03epULht
rTm/DTg/bxaxdhozTY7uaSPVK4Bf3rejhRVx5PFEH0V5wjbBcHzxWXCmAefmSbvj
VhSGLsBGTObpLxCDRhEO3Yx2wVMRWK6ZCzaP9GpVs+mSG7gJQL3RWSSmKNJ3ObJR
6NMbrTItXJXrx2jWEMQLDGS5bjHVfVRNdqZeOYCJP8JPmReem+k9xNyUokg6AxMM
smPE2tja
=7JOu
-----END PGP SIGNATURE-----

--UUbYJdA97JBrqmCv--
