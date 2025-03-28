Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C1DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3614481DCD;
	Fri, 28 Mar 2025 17:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2YlfBSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1459981DCD; Fri, 28 Mar 2025 17:07:42 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6CA8144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2b8e26063e4so1182835fac.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743178058; x=1743782858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HTQjygZ/OVjKOPte1DZiwXwQZM7m7F9CORd7z6vDhRU=;
 b=I2YlfBSpOoHkjBur38Elp1y8H3aeO04AHVWoj71+x16h5Djpv9LnrAeM25nzuAWUgE
 pRlPl95133Hw9xr1E1v80vWmvwhsKoLCiY6ePyI8Ycjwub49j2hD/ziEkPFps8Xm70Jy
 AxVffvEL5LiRd7ZVUEOnxg7FbyRskNcBmyrf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743178058; x=1743782858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTQjygZ/OVjKOPte1DZiwXwQZM7m7F9CORd7z6vDhRU=;
 b=MZcrmIp9DEBXoQqAfvtoGqQiEaF8oPQWKzaeQTbKr+baTDrMxdh7CJhyzkmfm3DeSV
 Zw2/QLmLVdUTr/foTxOrKyKpObEcyX3blBHO9aRu1XhLBr1Yew7tKqyK63eIdQtsQxPw
 5uDq6jfWIwS+mPIqAzf1g3i2l9ETvL2ZwAL/rkdv6d5EZ3kR0W6nEFPRFxENL1ZSItF/
 CcD/epV11NfGqVzEEXYoMpYkIokGQh6+vACZN+jtP/4UtRrFddH7C0gPdOvppAyZSGJH
 yWW44ozFny7kasFV0yHIWuHWotNUaYcLcFHyia+aAONFRh01AMfnRRjzTX6MSsmTBnf2
 /Ylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxiXFa8K0ZkKxLZ2hc33slC/EXOTm+ekxD3VFecvPW7WTFSeVprBHB+u2z6kRYsiYAm07ghNU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa/q0DKR2TOtQ7CFwQn7E+DOKmgGf0aoodE3kicTf7TjSEf4zj
 A6KlFKPMHxwJZZa3IH5tw2AC0onY//Y2M/jo+GM8NzOda+oogDfubyScpbpBtLA=
X-Gm-Gg: ASbGnctmYIypQMVtXFMNUuMi41qSRZGvlfDtk40Gz2p5oPx3nL7Iy8yQlhtpQ6MwzrK
 SDtyhANzKpF29GjXg78VW0lq7bvnCG1Qv6R37kc/BxGngFiniM/0d1OWwtNmSZ9kkTme19ES+jj
 mSy6V7FGoV67WVZaOvR52c0TSHHtO6LYm+7wtjWAZfs0JO2vI8uk478Y7K5MowLri76RX9l1ja5
 EcctuhXxntkUu7xoUxASzkQwjtVG8hKlZCEcjjX4XDTFC66kE5AVHBWG3N4JNixRDRsPqpoPCQq
 dEbpvp4yY4roF3AVBVKYFVdoIyL1+jKLZe3gHVC05uviDNXoY1pFXnahKd+TjLWGU4lHWH3mb8H
 3LbjZcw==
X-Google-Smtp-Source: AGHT+IETaC3gMg9NFoUH9qZcQpScEfQdz5Ic2bT88AnjbNDEyi2n/lWfdrWQu/rom4pgohQ+o8GgMA==
X-Received: by 2002:a05:6870:2198:b0:2c7:326b:bc09 with SMTP id
 586e51a60fabf-2c847efeed7mr5143279fac.1.1743178058455; 
 Fri, 28 Mar 2025 09:07:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a48d7efsm480425fac.14.2025.03.28.09.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:07:37 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:07:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 18/18] [DO NOT MERGE] Makefile: enable switch/case
 fallthrough warnings
Message-ID: <20250328160735.GZ93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-19-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fQ+6SObfONEkoFDY"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-19-andre.przywara@arm.com>
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


--fQ+6SObfONEkoFDY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:13PM +0000, Andre Przywara wrote:

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This does not fully work yet, there is at least the libbz2 code
> left to be handled. But this patch helps to let CI find more
> places where we need annotations.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> C's implicit fallthrough behaviour in switch/case statements can lead to
> subtle bugs. Quite some while ago many compilers introduced warnings in
> those cases, requiring intentional fallthrough's to be annotated.
>=20
> So far we were not enabling that compiler option, so many ambiguities
> and some bugs in the code went unnoticed.
>=20
> With all places that produced warnings fixed or annotated now, we can
> add this compiler option to the build flags, to find new ambiguities
> early, before the code gets merged.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)

For the record, once this is ready to be merged I would like to see us
borrow the CC_IMPLICIT_FALLTHROUGH logic from the linux kernel (which
gets the best flags for gcc or clang) instead, but yes, default to
enabling the check.

--=20
Tom

--fQ+6SObfONEkoFDY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmyUcACgkQFHw5/5Y0
tyxS+Qv+M6mm/IXPqbwmXhWLb6chEB+hKtDezr8SRcp1rdpz8IWiQIUr6OFr9tEf
sMBBOOfCrz+p2ZqBjoeftrUpj6Qemx6Jp/DwV8ahSWEWvc/Fw9A8j3LDhp64Dzki
jJtB9sNrrOVuZuOf1bGxh/WNDbJe0tY7sZQXHrqzG6AHfviuIOd6x4jcD8xvaoLA
2ACPmCvghxWts/i0Of/VktBhF/iCy8ac7tdbrHyZjKe+y0nAimQ2JxAngkh41mmu
/hvBGpxnFb7S/nOLcdxPde7umnqCWav20aTBLS5Qd9Dr+HaPn+gHaWuOOpIQ6P4k
iyOs8Pe4J/bSQuAkc1T/U9SnYgNU4t4+VCOrJB5fmQqsskP+Lvv4ljXfoJNDm6ZP
21Thhies7XsO9Gx9LGGukSlITkgCK5534J3T9U+zsjTTS4XsV1fNYeOJQEWy7mV8
4zw3JarIEw2qGszaObiwEFP6MAAqCxjMCi9FI0sxbcgG0WqoxznAaKfgH2l8bU4Y
So5Npmbg
=W9ke
-----END PGP SIGNATURE-----

--fQ+6SObfONEkoFDY--
