Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D52AC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 22:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F99885F5;
	Fri, 12 Jul 2024 00:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XxE+cbSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B8388680; Fri, 12 Jul 2024 00:46:27 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D132885F4
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 00:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5c46c8b0defso755859eaf.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 15:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720737983; x=1721342783; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gJ0x9kPpex63VKeghEJsI4TRGAg/RZNCTSi3llZ+0Ro=;
 b=XxE+cbSvGIsNP5obf5CY5u/L7BzntIXvj4M6jdtb/dAY0vrySB93+DDatD+J1T13Wk
 QL8nGtkkJy35efUIHFsGINmyJLmF5PrchQDlW/QgE1VEGaxAG+o/8itVxE+EdW7F/vnx
 pUuYihOdEXu5DVj2tFgBDmBPcimR/9elHL0tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737983; x=1721342783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJ0x9kPpex63VKeghEJsI4TRGAg/RZNCTSi3llZ+0Ro=;
 b=HlstQZyl1dj+/dHEVwAYmnJ4GAH+WKwXreSctoW9Fj4GYkHEmzX+b2UICWpCwZY/V4
 W3jWUatKuRe3QEpUBNlEcYUoX1Nm5jbr5Mr/PRBtZrL3yiLdoTbaSNV3PuAy8wzfbblN
 FWaZWKNwCiVczzrF4BjXmOpXlWRxZ+u8GNLC/9aQyz/bihTF2Y/E/r20mWMlgCHOR+ZZ
 C7H7U1X9q9ULTSzh+lNgAH5K3OArejxOOA0zlELG6DAgCkgCrcY3jY001Zn3GxPCNM7K
 +ZhiCQWPfUZfQ9stTMIeRy0Dk19HVgBcn5BuQ8vReGSvWBWG+K4K2vhj83qEJ3DRzfXL
 g2Ug==
X-Gm-Message-State: AOJu0YxzMoF13nB7/wQ842pHNOTbDwLW9Oeq+E3JvY3/nzVOB5CDFcS0
 qeH4+O9PyEBmcJQqqRlpdbU3Ehpl2iZsHR26oBibQjh1t32QSDYfkvGAp5wbM9s=
X-Google-Smtp-Source: AGHT+IHtxvDKsnfNfL8yv8p/C05ofUtpP4uTbYHRKuEIMJIdW1v1SgJWWn76kwlXoUqAI87cZPxPXQ==
X-Received: by 2002:a05:6820:f01:b0:5c4:27f0:ae with SMTP id
 006d021491bc7-5cce3e1dc4amr389796eaf.1.1720737983097; 
 Thu, 11 Jul 2024 15:46:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c7b57ebd35sm601616eaf.17.2024.07.11.15.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:46:22 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:46:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Phil Sutter <phil@nwl.cc>
Subject: Re: env: CONFIG_DEFAULT_ENV_FILE and CFG_EXTRA_ENV_SETTINGS
Message-ID: <20240711224620.GP38804@bill-the-cat>
References: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WB0CnbnqPvgL6oq0"
Content-Disposition: inline
In-Reply-To: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
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


--WB0CnbnqPvgL6oq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 01:31:34PM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> I'm trying to move some envs from a board header file to the default
> env file. I recall that the envs in CONFIG_DEFAULT_ENV_FILE are
> appended to the envs in CFG_EXTRA_ENV_SETTINGS. As you mentioned here
> before:
>=20
> https://lore.kernel.org/all/20220810170439.GJ1146598@bill-the-cat/
>=20
> But it looks like envs in CFG_EXTRA_ENV_SETTINGS are completely
> erased, and then the envs are populated with what's in
> CONFIG_DEFAULT_ENV_FILE.
>=20
> Did I understand the usage correctly?

Can you please post your I assume non-functioning-correctly patch? For
example, dragonboard410c has both=20
board/qualcomm/dragonboard410c/dragonboard410c.env and sets "#define
CFG_EXTRA_ENV_SETTINGS BOOTENV" in=20
include/configs/dragonboard410c.h

--=20
Tom

--WB0CnbnqPvgL6oq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaQYLkACgkQFHw5/5Y0
tyxFQQv/VoNWUBS+ef0xWkqqH6JttzgiDknscyrCvfqlbWOhG6GiIAVXcSbnD9z8
O6ga7xKkW16tioANPhdRqwuInGyE4L2/g/sGMU14VtXQEbXh+JhZ2HDTOn1NWNb3
I1bHF4v2eMkiE2mC6tVAlp6eH33ZKEHhH8B/p3fethe6KLqI5Cq7/n9NCm3k+Sxz
MAen6yKQKuHQUOJrL3sRB8cE0c7aym729Jnxrzli9Yif6To5dA2gJ0J/mHFHQ3bm
DMLBv9U4LdDrZk5TLymTvxfsQdu1d0EdlUJQaV4dMcoplb6GRcPS+jPjY7D5F0oq
JhtZbvqtAf8qGzE08SE8LfKbKRFnpp1ZpIsua6EUiBz56wLmh2vFM8ORFac0qrAz
9TQHnGKTjJaIGQW92hgkZbCbF7yu4bZFXwM6822g91u0rlUBAMfN6ls6UFEUh+DH
nAWQsmgB07luU5LOTLYzh7C6R5sE4B19mO3m28lrYHTwfSrxbHKRSj+nBNbYpbAl
Ly0U9+Qt
=IjmQ
-----END PGP SIGNATURE-----

--WB0CnbnqPvgL6oq0--
