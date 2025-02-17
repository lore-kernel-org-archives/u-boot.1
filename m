Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB9C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 17:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D16B80843;
	Mon, 17 Feb 2025 18:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dP5MM0VM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF3C80BA8; Mon, 17 Feb 2025 18:48:12 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902D58083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 18:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fc0026eb79so8573384a91.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739814489; x=1740419289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y33Czhbt4kU9Li05hy6XrCdRB2GMOGQH7bWgLPsRYtQ=;
 b=dP5MM0VMHVHJj+KiKbuKJd6Um+JmGUheKPyZbADcgIrpVhDnM2Dvs+O9CDI7nOAzL1
 uNuoYFK7BbCcLjGn8qoEjfboCwjjxRpHPSgadQb6mLjwlw4gsvV/QuYPmi97ZPHptW/0
 w+NaILVnwtGDoltFILwQU7d9ygJwohrOVnIMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814489; x=1740419289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y33Czhbt4kU9Li05hy6XrCdRB2GMOGQH7bWgLPsRYtQ=;
 b=fMpJIPmbzHjpprBc37xHlYK00HaKJHfAyDnHXssprp/8EsHopN9jY5OJgOFFBmnqT8
 e/CtXPi2v3Hu3b0awKd9lig6zibV/fQk/Il2PyCGs99GRSl1hly9qpk1i62IfoaFID3l
 PxLdH1HeQiyYn2Gr51RHFCI/Rt63WHJ7CcOBTrLanD5g57xdNwZmc9/XVcO4iZAAlYYh
 0JZ+SaR+biYGlk2bnkTuYHOMolCIRp/42HNhomN8bCZUL258jU5TMCAX2ks3sgGgE/+s
 QXVU7x3OQOL8PJWOAWfRn1tM+GyQGQZSp/VH9WzySOlTzow8OkorGeML80KEaSNXxSze
 A6kA==
X-Gm-Message-State: AOJu0YzrD7SlrbThFrlctauzhnOTl55j/bD3I1HhTV9kUx6JO3UGxa1I
 MEE6v+to+GjszR/pllgZLkQUzyJK3hvPJ3PW5WB46bQ/BJMf/ECTjblYjNBLi08=
X-Gm-Gg: ASbGncvBtU8HW2ErTVUkJK7rEC76spKhV3VnTNbTmaoRwtpyUMvzdyKCzAdJD6TJ9ei
 YMIS8VfcH6ir4ZoeQN2x/iz2GUuI6zZxwMvhcua7nDDFMOfCuDDvy5oTncf1J5cset4dFPuYzPU
 BTT2wowwTlCWtOHWnCfUTjY0PE4bOgKSY7wfHX0XeobgGqtLT5ZEL1NEtAbG8gncrTNNUMGfdFa
 smU0WWUPnW+qnBSMoBmbAADoCTiloQn6F9a+G4op2u4icXf0akP699ZrlxVomVFWFWjceuHhYNP
 ivTbauZXpemKCg==
X-Google-Smtp-Source: AGHT+IEvWh5fknajCskKZRIqJZv7xa63TdXfhs3qtjDOUizo8xTl+Te0cqgEbCTuTn22SqxTe70ECA==
X-Received: by 2002:a17:90b:3ec5:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-2fc40f22cefmr18869335a91.17.1739814489055; 
 Mon, 17 Feb 2025 09:48:09 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab01bcsm10501764a91.45.2025.02.17.09.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 09:48:08 -0800 (PST)
Date: Mon, 17 Feb 2025 11:48:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
Message-ID: <20250217174805.GQ1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rArccnOWt9stI/PJ"
Content-Disposition: inline
In-Reply-To: <20250216204421.3560012-27-sjg@chromium.org>
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


--rArccnOWt9stI/PJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:

> Some test can only be run by a particular board in a lab, e.g. because
> they are loaded with an OS image used by the test. Add a way to specify
> this in tests.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Add new patch to allow tests to be filtered by role
>=20
>  test/py/conftest.py | 22 ++++++++++++++++++++++
>  test/py/pytest.ini  |  1 +
>  2 files changed, 23 insertions(+)

This seems duplicative of the existing functionality we have, all
hardware tests can only be run on platforms which configure what the
test requires, in the boardenv file.

--=20
Tom

--rArccnOWt9stI/PJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezdlUACgkQFHw5/5Y0
tyyNvgv/TsgLOJJsVSg8ttsZajIOkRXH5rTBgzdcGvOXVAsDz6/fLNrCSr306g9c
/IZwYpTuo82XIXmJUOQvDB2SjC+H5cb90AmtHMonIp36f2Z2NdbE5XMLwkEkveDE
o2Xa16mPYSR+2EXKEv2xKWHPlWrZCfsEvK+q8cPlLBtLD3tx3G0ygrNeLtEqJs2t
YV8ylvmrzPAdayr6f/Mmww5R/q4gBGKFgvzOiKyTOY9rtFwU7e9kQmZUILEUUbsV
oj8inxEvnx1uUDx2PsTW8uT8wKwI3jKOqHi0Ewb0qQoDMGIO/Agk/OQiN6LNTEb6
GEmzT/7eEvT9id9b2YMRfOkgDvqioTncqgCRHqRzQH9fYBsbbeYlsCygffgEe/yV
cRGxXjlYQpghFBRuACRujtFwgkOp5NvBEq+fAPZDStmHcdd1TGXAC/gB1uscFKjB
PATjBf50Xnx3VtMvAqbmcMyk3+g0Zf5T8vYV432Vhv8H+GMip2621RmutX7rzXch
DIIjnEVG
=kbFF
-----END PGP SIGNATURE-----

--rArccnOWt9stI/PJ--
