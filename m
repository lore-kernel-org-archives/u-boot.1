Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D40D3B9A4
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 23:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A18E83C93;
	Wed, 10 Dec 2025 00:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kv74D4rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF9183C94; Wed, 10 Dec 2025 00:07:14 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7EA83B8B
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 00:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-450c65f3510so3189766b6e.2
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765321630; x=1765926430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b+vnWJdnfQ4HEm9I8I+/+WzQN1RfUglbRuW+EwZBlZ8=;
 b=kv74D4rkgTFk8uhRjy78zNeasx4XZVjr53L+zENwQeXa9HxUq8eRD1XIfRviYOufDn
 JFs4UbOUslbDByKLIKCXAxjirW7WJTn52wDWGh1CGBsEKMkydxo2UXKmXyA3SGMgtRkV
 ldWz+EDYMF4Ov24IniAwM9g70NEFjejGZWzLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765321630; x=1765926430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+vnWJdnfQ4HEm9I8I+/+WzQN1RfUglbRuW+EwZBlZ8=;
 b=NfqSXC9mJUufphK4BCFezmVzXjK5cVXKBdLPJVi+AalwjA3YM7mWU3kUWg2TIq//nZ
 KK3Ap0IsvcpQsB7FjRuLNMy4oMbQ4Z9W91Rspipa5mGlCzRqWSlikTYuqKBamQBpd0S9
 d2K8F2IVXcNrLeESq4Inbl1xYwlc9N/yy/akjv9xj6zvW79PCWnPb0L27VISVfqQj5xR
 jF8KbBL8YDSCZ+bb4at7zKph+EqPXE9YsnPasbtLJU7V8H3c4Et+Wd8ZO3UIQAWU+dGh
 wVCOnHaGxKlePDosEm2rrN1RbamMnu5oDMpgeaWg+KRuUUk5ek0MvjSNelZItQV3Utwn
 qgSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVScnvgX9OIOPRzdAAM/BZfHRc0iRmILjbN9mHhuOHg/NqCi5JeaISU1KS3xrLnD4ytZw7iqhg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2jmklyWST7qjqLQ+ub+18HX0p1TJQ0GXmJw97qqLTUj2IN9tn
 XLDDO4tV7bMkxSI5Knz04IQeQY3cIt9p+sQYHcnYm7hVECc6AlF/rxnjzkN4U3DTGvYYoumVL3H
 AinMEUI0=
X-Gm-Gg: ASbGncsC30mjUoGoxidjMqRDyRmLURw+TmkgHQkgaJOrKd9g2xTEpG/eCnUtsC3+l6r
 shnI/Q+/hOIuG7cjXm00jJHlU3zsW+gt+MoebM8oPjPVLvnT6LGIXchCISxWBNn+f6e2Xsrz8dP
 pf7JLqz6mvskpbXYNbjmE+irGKvq7Pr8oS8u2aPwIFOmlW7S8c/OPEVaZ/zC1kBDLAIB0/vwz+U
 CP/yar1aqJ4uNC4LS/9FK2qOAb7nClFSTM646wGCanoC9usZjMUKIatJIEbguHDnkb7GrviYWm1
 DEYWHk1wRM2ahD9ipLvwhuUx5q4QDlbt8fPmwfkhV8+eG5vvc91I12Q70BgYyPQjJLArC1PcKvJ
 df5vO5XSqsL80tC39bT9QVRXUdbMmllziFCHDv7AL5kUxJ/BDKkwwNJyQC6sOWkWfMFg2VE1lcH
 YEqIVotM0s8RSXLnnPTu7u9bqwax24ughxwaCo+9QDud9UOnDO4w==
X-Google-Smtp-Source: AGHT+IHOsid4IgXRFncZmPOld7b+XCaBmdWZIw+ronCykAWpFzSkb4nYQ4EgPsMDTHt6xOa3lhraCw==
X-Received: by 2002:a05:6808:2388:b0:450:d9ce:7d71 with SMTP id
 5614622812f47-455867214ccmr375614b6e.46.1765321629925; 
 Tue, 09 Dec 2025 15:07:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95ac84f1dsm13077784a34.19.2025.12.09.15.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 15:07:09 -0800 (PST)
Date: Tue, 9 Dec 2025 17:07:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stephen Warren <swarren@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [U-BOOT TESTHOOKS][PATCH 1/1] py/travis-ci: add
 u_boot_boardenv_qemu_riscv64_smode_(acpi_)na.py
Message-ID: <20251209230707.GD303283@bill-the-cat>
References: <20251209230318.416872-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RiGGi8oyYgfBh/1B"
Content-Disposition: inline
In-Reply-To: <20251209230318.416872-1-heinrich.schuchardt@canonical.com>
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


--RiGGi8oyYgfBh/1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 12:03:18AM +0100, Heinrich Schuchardt wrote:
> Add missing boardenv files for
>=20
> * qemu-riscv64_smode_defconfig
> * qemu-riscv64_smode_acpi_defconfig
>=20
> to enable network testing.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .../u_boot_boardenv_qemu_riscv64_smode_acpi_na.py      | 10 ++++++++++
>  py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py  | 10 ++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_=
na.py
>  create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py

These are identical yes? So they can be symlinks. Probably to
u_boot_boardenv_qemu_riscv64_na.py ? I forget if the file
"py/travis-ci/u_boot_boardenv_qemu_riscv64.py" would be read by all
iterations of qemu_riscv64.

--=20
Tom

--RiGGi8oyYgfBh/1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTirmAAKCRAr4qD1Cr/k
CuxHAP4t3dDR7J7z1wNC2oVOg2dZpyhae0q/Bz4h7C1z8ZbgOwD+Lbf47/7iLw6d
chImXlJS16fRlvvzZ1HDWXBbVU3HQQY=
=sDsi
-----END PGP SIGNATURE-----

--RiGGi8oyYgfBh/1B--
