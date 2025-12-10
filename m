Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D675D3C526
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 14:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D059A836C8;
	Wed, 10 Dec 2025 15:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tHzLQkh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB1A83A26; Wed, 10 Dec 2025 15:34:31 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6381E8367F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so6238763a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765377268; x=1765982068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7xsn/5rC2LZZG0UzSSIavi2x+mkej8Cah1HH2nYoQcE=;
 b=tHzLQkh/reKx2It45tAZwpOFxqT7Z1/ZCJ9RQxqEXOIyMUCJMnJnpFBb7ye4Ab+Ej4
 jiLexcY6MfgPlkXcynmExtdYb2ACf8wrC/A57Ke1VOdZvf2CFfpBQVzB2B6Sd2HDPGeP
 ANQMEV+GJPmk8sGXAbMBtxT1OLycOMkh1Bil0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765377268; x=1765982068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xsn/5rC2LZZG0UzSSIavi2x+mkej8Cah1HH2nYoQcE=;
 b=VuVaH7R/ZaJoV8bTj4Bg6RospwlxMOktkyxam8XXcgOBTXV+xyytkPmvCGYALXK0KD
 RFETvA3ic1b0s3XVT+oFXvZtijDXcGo6tyHUWOh9m0Bbktyx+IN9+UsYIgaRKcnIdulp
 ETay7a0TpbQjaZE9OiK8cuv1eZcetbPuMLmjiS6aUeOpcLcZI2f4UZqXw+v3oJ+mS1MT
 VyNceEIx2HN966H3glD1W9hDpWjysHme34px6tk2Mf7tGf0eciQwfBBffkVEPotxVFi4
 QHEWF0ZUJegL5pIkyY/mkFvX7Mw3J8cvN2ybebuayeSvFESZXlSqrXQ5vcKy2xLmbFnC
 3gdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkJPZRJ8k6dbULY3MwsPjU677KwDF/r8V4J2C85Vhuicpoh1EOqmHHkf9OCQvqMXwrihwHHPw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0MAuyGkAJFgv2vb8DQ2N/M4z4cJ+1VnpybjbFF1kv9jnGajKJ
 aSPL0PTevz27ALWerJAocuVPiBHxgOPZa2xvJVabUR6vuuXFGhPsrPiDSAXowOUAeJQ+/ZA+isr
 03gKCgnc=
X-Gm-Gg: ASbGncumv+ojuelaXtiGElOdPL8hn1fkwWZJh8UJ6xWAoDPKrvmbhZC+arfErU+EVYg
 xJHenvD0QDnzuBcKoCXapukjuQzgjD6j8/xfFwS6p5HZeoJGxXXek2w803W76/2TEqKsqPaLzwE
 kbm5p55EZkuYGj1mTS7dKAgr6RQ9lifZYVXw4W6FiAE67Ly02km1YaL9+YiHAp53MQS/ZEhz1d4
 fodWqLXX9STjSCagq7kX/9lLgMuWuQu+y9ZNIvSTSLHsoUt3iRUl36Q/aZcJVMmdZW98O8mC1cb
 pjoct9fdB8AV0qdfYUFcByazdFNhg/XoU7g4mlymW6KCd864+TpFAdvUiFr0y9otWKW/k8yGSwi
 egyWzoPfHOQCvqh/+KX+Y5dC/ZT9hZSC+NMXcYhLivDSlmDzGDessCVJuEaJVbT5lrNjR+Wyaac
 9cIBlVivKxbXxyH3T5+vIm4+MlCjdA+PHVLEoX1jIX4B/236Xwyg==
X-Google-Smtp-Source: AGHT+IHZzqkh9l3ZxbNz5phmXgiFMrGZZmAnOakdOh/HRwqInNqIvVft4xRKl0ODjE4CB8ojmG/A3A==
X-Received: by 2002:a05:6830:3110:b0:7c7:586c:846c with SMTP id
 46e09a7af769-7cacebd7201mr1945222a34.19.1765377268119; 
 Wed, 10 Dec 2025 06:34:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91d475sm14780788a34.7.2025.12.10.06.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:34:27 -0800 (PST)
Date: Wed, 10 Dec 2025 08:34:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stephen Warren <swarren@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [U-BOOT TESTHOOKS][PATCH 1/1] py/travis-ci: add
 u_boot_boardenv_qemu_riscv64_smode_(acpi_)na.py
Message-ID: <20251210143425.GG303283@bill-the-cat>
References: <20251209230318.416872-1-heinrich.schuchardt@canonical.com>
 <20251209230707.GD303283@bill-the-cat>
 <8094db06-cd0e-4372-bf55-efd6407d2e9f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dtouYqZ2Cb3/yq+s"
Content-Disposition: inline
In-Reply-To: <8094db06-cd0e-4372-bf55-efd6407d2e9f@canonical.com>
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


--dtouYqZ2Cb3/yq+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:58:45AM +0100, Heinrich Schuchardt wrote:
> On 12/10/25 00:07, Tom Rini wrote:
> > On Wed, Dec 10, 2025 at 12:03:18AM +0100, Heinrich Schuchardt wrote:
> > > Add missing boardenv files for
> > >=20
> > > * qemu-riscv64_smode_defconfig
> > > * qemu-riscv64_smode_acpi_defconfig
> > >=20
> > > to enable network testing.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   .../u_boot_boardenv_qemu_riscv64_smode_acpi_na.py      | 10 +++++++=
+++
> > >   py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py  | 10 +++++++=
+++
> > >   2 files changed, 20 insertions(+)
> > >   create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_=
acpi_na.py
> > >   create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_=
na.py
> >=20
> > These are identical yes? So they can be symlinks. Probably to
> > u_boot_boardenv_qemu_riscv64_na.py ? I forget if the file
> > "py/travis-ci/u_boot_boardenv_qemu_riscv64.py" would be read by all
> > iterations of qemu_riscv64.
> >=20
>=20
> Hello Tom,
>=20
> My understanding is that the files are per boards. I am always irritated =
by
> the _na suffixes. Maybe we can get rid of these. Or at least we should
> document these.

Yes. I recall seeing in the code a month or two back that we have some
fall-back logic so that for the conf files, we can omit the _na suffix.
I don't recall if the python import portion has similar logic however.

> I remember you being very hesitant about symlinks in git repos because th=
ey
> are not supported on all file-systems to which a user might check out at =
git
> repo (e.g. on Windows).

Ah, I had forgotten that myself, but, we have several symlinks in the
main repository itself now, so I think it's become a moot point.
Especially for trade-offs in reducing duplication.

--=20
Tom

--dtouYqZ2Cb3/yq+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTmE8QAKCRAr4qD1Cr/k
Cv+5AP9ghwvjBJjIwIP96qjyPzIKoqj3n47bVl1uJCeaD1AihwEA/0z4pSNvmXmo
NHZElaRTvgvr9qiEZPfGKFNbxl1UKAA=
=wSLO
-----END PGP SIGNATURE-----

--dtouYqZ2Cb3/yq+s--
