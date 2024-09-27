Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B3CEBF69
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 03:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732698902A;
	Fri, 27 Sep 2024 05:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="unzNPuWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC98B8902D; Fri, 27 Sep 2024 05:31:34 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD3BB88FE0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-45816db2939so11019751cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 20:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727407891; x=1728012691; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IhIvSMXsU2WLfW11eQqbeCaTXJ2NxguVcbkWcdLqsb8=;
 b=unzNPuWk4164p551l4ozUdbQfNLJrDaq88mBjJn+KRs/RxVe/xWx1+DRW381WLJwfD
 AQpztJmCIM6Gj8/8L0gXru3x6SWtSK0qHcNWi4cBZhYuTNITT0bipi0mXN4dj+wwn2h0
 4ZLkD5LkBmR0Bh2yeZKXBwmXNG4m1RWOIcsTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727407891; x=1728012691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhIvSMXsU2WLfW11eQqbeCaTXJ2NxguVcbkWcdLqsb8=;
 b=G+Nn+NoAhFBKBpnRc78OULeppwltS8pd0i1q2pNTrFoTVga5uIrdM5OFP1jedkOdv6
 cwOAadx5ACaK2X+iw4Sf5fPHFZH5t6mSZwdThJhvdhR2QQltC/TGEQ/7Qsp4GcJwWy9U
 cWp5kXtVwJ0LzvtnaR8CgE9VbHu11AYpRwDM/cd1G3P0d64lXTxmfNHVzo475TCgviKb
 DNd1SQ7TqQyPmFRrE8gEBLjQ6W/cg1WITV24m71HZK/1RGgq1BpcXG9LSCZ7vtyrYzHX
 ajX1/rSOcHreAPq0GMXZ4U2rEDWkoBaHoiRT+QPo5JgzI7+F+3TEjsu3Wc2LRGxEgwhd
 8AOQ==
X-Gm-Message-State: AOJu0YykSPnJgqDaa560ro2Nm1Jt/a61X9bLnXLHppEL7z+8QGOjIofW
 TIkPV/psN7rGNQEA5zhkBZEDxS2r8ELH4Ob66j60Xt5x/WPXm6EsVD5NlJnVD1w=
X-Google-Smtp-Source: AGHT+IEdEQe2jGe4ufVDeDVl6cuDXF6v1inqiM440l6mCILGcDnZOjf8/uQ95dTp3sd1/+dSVTU/OQ==
X-Received: by 2002:a05:622a:20b:b0:456:8019:affc with SMTP id
 d75a77b69052e-45c9f1bcc18mr27921241cf.2.1727407891365; 
 Thu, 26 Sep 2024 20:31:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28d001sm4480191cf.6.2024.09.26.20.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 20:31:30 -0700 (PDT)
Date: Thu, 26 Sep 2024 21:31:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 35/36] configs: Add RPI4 ACPI defconfig
Message-ID: <20240927033127.GS4252@bill-the-cat>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-36-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MYf/nPKaPCMC9gsp"
Content-Disposition: inline
In-Reply-To: <20240926080021.148031-36-patrick.rudolph@9elements.com>
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


--MYf/nPKaPCMC9gsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 09:59:23AM +0200, Patrick Rudolph wrote:

> Allows to build the RPi4 with ACPI enabled.
>=20
> TEST: - Boots on qemu-system-aarch64 -machine raspi4b
>       - Boots on real hardware with arm_64bit=3D1 in config.txt
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
> Changelog v4:
> - Enable BLOBLISTS
> Changelog v5:
> - Enable OF_BOARD
> ---
>  configs/rpi_4_acpi_defconfig | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 configs/rpi_4_acpi_defconfig

This is supposed to be "rpi_4_defconfig" with acpi, yes? If so can we
please model it on say configs/am62x_lpsk_a53_defconfig and yes, you
need that additional CONFIG_ARM=3Dy and then ARCH/TARGET stuff so that
buildman will also build the platform correctly, not just "make".
Thanks!

--=20
Tom

--MYf/nPKaPCMC9gsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb2JwsACgkQFHw5/5Y0
tywXiQwAuv9LfYtRWy5k+bwUP7JJgqQr3P6Zrsj665XaFEcAx0IqJukCw7X+Umwd
C2s3vmgwAptU0gpvenDGubR6PkCM5SRdy2wcJbWTBrnv7fQ2ndLRJL80a60gAX4K
darWvb+bfcWeZ/vKUmdTCBhRmbF+3jP1gxuYksT0GI4Q+fSoXrG1L8NLOGOmU0fU
iRomyIbSAHhlM2VuZAUbun5eYg+gYtZy3OE7m22v7S97GOAS5KdwPJEQNV9biV2i
auuByfguLKw5aVGSDWI/O5d/n8akB6R0qwrof3FgE0qm/MIvhPWxQwvtfDkqmyE1
VGVnBqDcYP5NMcLUL0sU3wpVaYJ0S35BULQUaPv3MkbQjswgVzorwUrrk74rca6i
2RUTZInk6eJ5WK2IaVDU5nkHQn2DOZ5ZgnT9+Vb+f+/drLUMk6HzrLhRRmLL+tGj
S6Nmxl2uKB2KpLtZhjwd8TDDZlXRd8ZWHv/my09Vwu6XXHwgxIe/AL8QjlxOz7zv
0mM3GiH0
=y8j7
-----END PGP SIGNATURE-----

--MYf/nPKaPCMC9gsp--
