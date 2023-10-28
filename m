Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301A8C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A9087B89;
	Sat, 28 Oct 2023 15:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RN7sIxQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C55878E3; Sat, 28 Oct 2023 15:27:03 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8AB7878E3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789aed0e46so222833185a.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499620; x=1699104420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y9tmzwo7QQO7OYjzQSflPH5VyHX4qJojN7AFvXMpGqM=;
 b=RN7sIxQMI3dM+1Xk8ZzJE3dLHF+4vQwRQfds5XT0b/tW8wmeoNGi2D2JnpxnFDX4Ff
 5/H/yYIQ4aOLFkYIsgR69FXC11cgC4qkY+smvNsT4bkVSB8pPr3fTPwFMMz9/C+35+kL
 gVUE1TMehzU7yOiYACcLqR0rfLtkDchJlxAYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499620; x=1699104420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9tmzwo7QQO7OYjzQSflPH5VyHX4qJojN7AFvXMpGqM=;
 b=orbZ1wHUBD5+BcUXi4L/3RdywHO8dEIcsi1nm5D5y5bZaTjF2+5wGvdmJtplJM8zdC
 VWFHsGyHyPiTX4j4xbcEa7vYJH2Nj/vJTkG9NAifM+MKoCRGa+rXU2sIjk2wOzVg+l/H
 nt3ZuqeLGtThRHCw207mnruuGIlB8lQteF4psQSYr42oYAhUmI+pQ6Idbmh46aBeOO6E
 k0wVrFdbYtSQBguW+s2dWpb1UVHtDqrmxKrPq5K1i1whGNdy6Qy53zF4vkeO38I0MofH
 Ycf3HzRBZPs/sQ3PYL7DBsk2oLMiHnKDKY2flokaVSXDp7WpSA6Y4JDe5utUZ7C5oik3
 oRtQ==
X-Gm-Message-State: AOJu0Yx1wev57rbATbX+kkeB+leV5MDmm6UKULm2a72daK6q7qmUnxk0
 Md0IwtD0VK0MxCXmhAxExT7zVQ==
X-Google-Smtp-Source: AGHT+IHaKCwbMIPU5TOAaspeZBIV9Pshm3MtpGcWqo7PiCti/E34YxoeCkihRldSRITyAXvpfAcm+Q==
X-Received: by 2002:a05:620a:4892:b0:778:9072:e45a with SMTP id
 ea18-20020a05620a489200b007789072e45amr4480101qkb.74.1698499620547; 
 Sat, 28 Oct 2023 06:27:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a05620a102100b007726002d69esm1548907qkk.10.2023.10.28.06.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:26:59 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:26:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH] board: siemens: iot2050: Fix M.2 detection
Message-ID: <20231028132658.GI496310@bill-the-cat>
References: <31bb24cb-2d84-4524-bb25-263f8fbe16ab@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qbRYZt0yRqZudKrN"
Content-Disposition: inline
In-Reply-To: <31bb24cb-2d84-4524-bb25-263f8fbe16ab@siemens.com>
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


--qbRYZt0yRqZudKrN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 07:20:14AM +0200, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> The "simpler" the logic, the higher the probability to not test and get
> things wrong, again: The absence of a "-PG2" suffix is not sufficient to
> derive that we are on PG1. There is also "IOT2050-ADVANCED-M2".
>=20
> Finally fix that by exactly matching against the two PG1 device names.
>=20
> While changing this, we can also drop the not really needed check for
> !board_is_sr1 in board_is_m2 and call the boards by their names
> ("board_is_pg1").
>=20
> Reported-and-tested-by: Bao Cheng Su <baocheng.su@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to u-boot/master, thanks!

--=20
Tom

--qbRYZt0yRqZudKrN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DCIACgkQFHw5/5Y0
tyxxKAwAgNo2TCj8xH7KYWigHOcJr3eZ40tKUjy74uyjErrq9/j6nuiaiADkJfd+
KfTpxqEvh6zjd7jEj2wcWkcM/Qkq0qwqnPrfldH84diIiAiaFHS4P21QYZLHL2Gf
elAVkjifHqUwOzVxdZRL1+/JN31Qpb9TVlzqSC/9mwzbQJzRtWiERCCSgovq8qXI
H6h2ChhqW3w1AF0fJOu5rgnHF0auyBQCWXBmHhoybZyiHc8zqUbFv/6KgP4x3K/G
kOVuZJyCIxTC9F3+l5QU/9RdFXsyYZWQ7W/w9Dn+Tw6q3BZJM5Jai70n77Ily0Sl
527RFpE4h42JhGBWURAmmTzxkbs99rxtTVOUkoRtTm2BZWfAdRyZJ/VDjA2Xmsn2
wj32lQA1r4jaRMnWNIj4ZiM3JKub5PkHE2M4ILAeLNfBObP7QgXNdeSjl0fcCxzK
amdPW0vNSMfVkptWS/D9hGbqnbS0fSimCp8P+3WBwAwC6bKhAXccgfLOxc/PGkxO
XdDnUcEU
=cHaU
-----END PGP SIGNATURE-----

--qbRYZt0yRqZudKrN--
