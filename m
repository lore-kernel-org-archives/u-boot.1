Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CE9C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C111887FD;
	Wed, 12 Jun 2024 18:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iDn2ifrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03B288812; Wed, 12 Jun 2024 18:00:43 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68373887ED
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d226aff122so2057182b6e.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208040; x=1718812840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLEDoHDYmTDW7Ip8ADo+H339Xa/qBfT+i8ypdKo36ro=;
 b=iDn2ifrlQ6Hx/zf111TUFUPtjM8TtYVzz7VGPMIZT/e+voR25kdl+GomOrt7mLl5hJ
 SQJ8hrf6NBBFDr4hTah7yWW7J2JbtJJYBguyTwf+Z87Sid9GOwhBAXLWTViixS1AmJgI
 NAle/Nv2TnG+Jum2Hpaxu0CzGe08DX39nJeSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208040; x=1718812840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLEDoHDYmTDW7Ip8ADo+H339Xa/qBfT+i8ypdKo36ro=;
 b=Kg2VslXEZm4Jgu3+6I2aL6qMmNMyGCRd3Vkskqxm4DNpiK8jiOQC0sqbomaC/KMIE9
 LFL0U0y6ePwTz2Hz+9tftIjtZxrTO7r4KQC51FI0ZxkuRupzSC+pndTF1fdzp24mNWE+
 AlQb7AK4UxlTlhEGThmRbGEbTh0JrDoC2LjC0S2w300tVoHUng4ufEHg/OxhqqK0Orel
 TYB6I/JIVVcuhTl+rfTqsgA9YnVW8FKyEn7YcIL7YBqd4/cCWhW+62633/ORAi+fV8AB
 uljsWzwdKA6tBXGpldRp0KCiOB+9t5CRSm6WdahvuGozsPqPQ8vwEM8yNKx0v/zBx3zS
 Xf0w==
X-Gm-Message-State: AOJu0YwDRGcG9LHL+orwoLga8mWJ2x2+q7KXoIkyNJ63k32l3NYCopLR
 rEYuuKfYqvIeKJP7fM3oXxmdGtwiOHEWUpP+QJnhKzX+KUHAUEYKrRIKYSzDJVI=
X-Google-Smtp-Source: AGHT+IFWUXtZq9O+HiQ/sFkA0lw7HZruVsxZQGmglCVR4RyRBqkZ7hYjhdT/rnx3gLhVz4lAEBQsew==
X-Received: by 2002:a05:6808:2221:b0:3d2:3e31:6cf1 with SMTP id
 5614622812f47-3d23e31dc12mr2703408b6e.41.1718208039140; 
 Wed, 12 Jun 2024 09:00:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b7183b7sm2347041b6e.40.2024.06.12.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:00:38 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:00:36 -0600
From: Tom Rini <trini@konsulko.com>
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, rui.silva@linaro.org
Subject: Re: [PATCH] arm: dts: corstone1000: enable secondary cores for FVP
Message-ID: <20240612160036.GP68077@bill-the-cat>
References: <20240612100421.47938-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m5bXgjk8FUwlwwgT"
Content-Disposition: inline
In-Reply-To: <20240612100421.47938-1-harsimransingh.tungal@arm.com>
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


--m5bXgjk8FUwlwwgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:04:21AM +0100, harsimransingh.tungal@arm.com wro=
te:
> From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>=20
> Add the secondary cores nodes in the dts file
>=20
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  arch/arm/dts/corstone1000-fvp.dts | 25 +++++++++++++++++++++++++
>  arch/arm/dts/corstone1000.dtsi    |  2 +-
>  2 files changed, 26 insertions(+), 1 deletion(-)

Can we move this to using OF_UPSTREAM instead? Thanks.

--=20
Tom

--m5bXgjk8FUwlwwgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxh4ACgkQFHw5/5Y0
tyy+gwv/X2u/GgXNxBoE9UdQLiDa9M9MEmTB8CkBufGJZs2MzlohPi1gBNfKKbbx
F3qnKQ9MnEbN7YlQuc7hqCojpAAf5KCNba6C/lh6C6xvzYQeElW/2/MUmfSNw7BH
+IfjpoI8I8E17MPd/s6k4eo698l2WR6KBuE4fAbXBtgpaUdwX5ygWKV6N1p2xX5z
EGPV0JS8XlPzG7K1LoMxqFmNFiLgNJkIMEeXn06yq4Uymk7mZPB0n2vQFgxzh9E0
EzQvGpatsBGssPGVwBBauMy47fWXXx8Y3wrCB7GrWlzh9oB0pourBiC74drU1X6w
0r4iVilUMa5cXEdGsdM8saajTsm2faVYNmV93v95Gk/O5CqQOuu1Sdr/w+c0yvVF
cmuNsJaY+ZXG662sCIYuZBaQhCkrBSpz4QparfXwivAtwkZ8WBJWw7dx7uGJstVe
R2tQFk0FF8dIxGORJ0zUDnrPo3x0w1RW29S0EgqrYP+gopSMoTUz5wYuM+lXKHzm
/BMAnkkb
=p3KA
-----END PGP SIGNATURE-----

--m5bXgjk8FUwlwwgT--
