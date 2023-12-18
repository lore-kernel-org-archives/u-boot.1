Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA197C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 16:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB8A871CC;
	Mon, 18 Dec 2023 17:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GzncyNwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD966871A7; Mon, 18 Dec 2023 17:59:36 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B6A871CC
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 17:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67f2a5d8a05so18997036d6.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702918771; x=1703523571; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UfVgNwY8IJbkbfGeMzPB8NJFkdimbuLoLCkRiwfkqBc=;
 b=GzncyNwAkxdeKf/XQQSPJQJtPgbkBOALRP1cNMbi+lDCpt2H8qpkwnZ79nq/ouROVd
 91GljIYWQi3ulxMe37Jxl3b+bMlbpfisuRZ9YJ3oz8XI+U8N7H3+qf6owYw6zSF9AJZW
 IN4fECipc9xWUkAHdO6mTW0xFcskHQWoQbriA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702918771; x=1703523571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfVgNwY8IJbkbfGeMzPB8NJFkdimbuLoLCkRiwfkqBc=;
 b=LtwfX/6PSHfiJxFjjcvMvDF9+SwEmH6x+Mj3w5hIilLF7YGvixg8VO3+5zMbslm9QE
 nzS3dAvtLh7nTnfF4Rk0Bzmgo1Ed4TvHsfWzi8EbNLs2uU+B5O/2e1VeBjnuRqj1f2F/
 Sa3+VfuGl1d2G/wN/fqDcfJGEQwEj01NfG8O7tQxOWJcdwiKJw4kOnjsfSoyRz4n9FiV
 0xoLu1QBEoW5uZPOrI8I3dBOFKxwexmIGtrfAqT93jGFrHqhh94wR/Mwj4zFsa4jBAly
 vTHCTohbKkv89ZWJxRehSFuoFP/0dUMbGi0ACCbfJ0PtfmTuHwnDXBZ4+ZC7SjYtLVAW
 Qt3Q==
X-Gm-Message-State: AOJu0Yzyudx7SU19cnCiIUrs7ZEA5cYsZeP7GDg9tR9qyYntczePMYR3
 nouBQ1G//7mYtvucs3CIGOF1JH5PufjlXY9wcw4=
X-Google-Smtp-Source: AGHT+IGvvK3wnNeTWcAKPaaxPcyIEOdPNx/jV8Ip90yONFQ9NXSe3JIo4z1dogejPL8ZM/AzixBi0Q==
X-Received: by 2002:a0c:e706:0:b0:67a:bff7:5eae with SMTP id
 d6-20020a0ce706000000b0067abff75eaemr14727468qvn.18.1702918770810; 
 Mon, 18 Dec 2023 08:59:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a72b-a3fc-ffa6-9927.res6.spectrum.com.
 [2603:6081:7b00:6400:a72b:a3fc:ffa6:9927])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a0cec8d000000b0067f319b1b21sm1992550qvo.24.2023.12.18.08.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 08:59:30 -0800 (PST)
Date: Mon, 18 Dec 2023 11:59:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-ID: <20231218165928.GK2513409@bill-the-cat>
References: <ZYAwj034fNBg1HOk@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ry36iXdCESCJIdTo"
Content-Disposition: inline
In-Reply-To: <ZYAwj034fNBg1HOk@swlinux02>
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


--ry36iXdCESCJIdTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 07:44:15PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit fdefb4e194c65777fa11479119adaa71651f41=
d4:
>=20
>   Merge tag 'efi-next-20231217' of https://source.denx.de/u-boot/custodia=
ns/u-boot-efi into next (2023-12-17 09:11:06 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>=20
> for you to fetch changes up to 44a792c99498f5a9d3526019779d66585978c491:
>=20
>   riscv: sifive: unmatched: migrate to text environment (2023-12-18 11:09=
:01 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/18996

Applied to u-boot/next, thanks!

--=20
Tom

--ry36iXdCESCJIdTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAenAACgkQFHw5/5Y0
tyzZjAwAgYrL7bQgRrUcvcdiRIeNt9h953Xi31ko6UT/PPq40KRRYW5xDAAmOuuj
7Yp0M4ll7CjFdxjp3WcoCUTr5axyH3FIqoHLOj994xBePikRt19b3gGPBaoBT6et
e+kndZJta0HwQ6wlqCAW1dHYr+C0j4ZBB2msLnEMlgGpcgAfgzPKsMyN46soQAwY
eGVtan3SqVPuooAkglq+ZUcPyQeIgxfnUgxB6MQotw6K/0oPFGfzH0P4iCuqe+PA
rTDp6kDxkOuQOJcKWHGcVJUXnHsHafd5IjUJLw8veYzpUmvuq6cwvJT+Fd6TsK9+
rILlYeJDUQw2Qg/tG+UlNZqf1WdkqZUGooP5u8Blx2PUAvLcpPiK7DvhaF9Y2pg6
mxfr6Tnw2olXtRqJwKPNhwMrKNmnaz4184PyCWbFnOmnYqMazRha3wUXIryLp9CT
whkqFDawjQXK42NQCsYJeS2Un5Zido8gy8qeThmLSDstk6rJ5p9VGy6zD0LZUoda
UmEsnVkl
=W1RV
-----END PGP SIGNATURE-----

--ry36iXdCESCJIdTo--
