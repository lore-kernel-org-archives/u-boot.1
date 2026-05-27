Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4936CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 15:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B388470E;
	Wed, 27 May 2026 17:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DtWSkUCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731598470E; Wed, 27 May 2026 17:05:07 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67EF6844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 17:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e4de538f83so6648206a34.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779894302; x=1780499102; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zq5E18LnsMwYbN+jIZm8CcLoD8EQblFUM5LVPwlzWsk=;
 b=DtWSkUCLZyq9FYPmfYeBWWycaSDbHLDq4IfXnWBdl8l3krfudEcku3Ke22JzcMxmDC
 /nNmDb/HXI9B7zLpAsuNqFW4Bs6AtwnkoO2m7lyKqkVwF+N1HmzIaAujxoPdO+Y2RZ/o
 2HYN7eYzsvDh0q8dtS0Vtl9pTOYP7xmka6d/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779894302; x=1780499102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zq5E18LnsMwYbN+jIZm8CcLoD8EQblFUM5LVPwlzWsk=;
 b=Eqxy/OU/VOIBf2oK7oFyq7KjuIfzhFqckGxT8j0Ckyhnmi4aDjm3BR7+sRLB5hzRH0
 yMFYEyjSQe4sZg2vNmtGJGnI6pqNbCHWtODMFDubfCCZgcbt665qQygITmvak06AK9UX
 ZHxM/InSUsDG71wKZ+AWh7Ho2P4zcoxOxKftdsem7fH89MykRaozSSVFD8AKkhR8/Sda
 d6Q+Xgv/Mg1H/QbAQauiVY04ybrSIVw3BgeFhWnr8tOze35+ZfsShSNdB5az2pSGtMXL
 syfyjQ6W3Sm240ZJu+4KnqFJPJYOAA+B1ln4tTzb0MfaY3Vl7AUPqQtFEulYA5MrhNxs
 qxqA==
X-Gm-Message-State: AOJu0YyJ37g4X/68QnCcL9Qrxg8AJsblyH1gYiavIeABP7OtYNnm05Q9
 66v77osTFbiPaHu6LqO5IyQikH+DuLTzabtBFt935naeifDc7xDKZbkgQwz6iRuDAtE=
X-Gm-Gg: Acq92OGvkSV3tGt2czU6802NysX1zEOwx2iK96PHQxfMrgnpk8M5q790NoLB1RoI/wZ
 n4R103ROsu7lw3Q84SU4ZqJnG01Q3Ov65hHc7TFYmi5tLwGRcCgzE5iFsaOT9rLH77JvAnVVivD
 ndYgpLjajbebEGLTtvkY8i96CUoBiUOSdfZbe06BxEDwB9prk5FIVnLQDe0Q62FO5FJe83M5tz/
 sWTUlbUPtFonDYXn44Y+Nm5cIDR1Ma5eLXMWbv7aly+QP9jONU/Rgn0dWh+lIfC7l06HGG+aR+q
 3SO6xXDisUpkv+MDtKd1rDt7DHHRhfVZ0gxPkGUImF4+Ot1bACZ+qXSAxFRZvbfTF2MVFy4tpPb
 QXrx6vi3jlNxAAAF12+aTMA991kGPW0/GiQJ08XAwJWT5duqmU4PcAwgZ+V8hdQ8cZtCiPftHco
 qk+FG+Iibp1PBu+M6A5cXXOjKooOiI12nNyC8f9SgEypqIOPs/eFQiIB24BnHA9p10Z5MpZ4WXF
 U+vcyoAasmEvcukfXuXzBH2wco3jI2lod0zSSuETTnA9A==
X-Received: by 2002:a05:6830:6618:b0:7dc:e37b:b5d2 with SMTP id
 46e09a7af769-7e5feec2ac6mr14088105a34.8.1779894302511; 
 Wed, 27 May 2026 08:05:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459f67sm11658818a34.3.2026.05.27.08.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:05:01 -0700 (PDT)
Date: Wed, 27 May 2026 09:04:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v1] thermal: qoriq: add Layerscape on-die TMU
Message-ID: <20260527150459.GG1858239@bill-the-cat>
References: <20260527134744.511819-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zHoMh0vXvCvBulXh"
Content-Disposition: inline
In-Reply-To: <20260527134744.511819-1-vjardin@free.fr>
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


--zHoMh0vXvCvBulXh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 03:46:45PM +0200, Vincent Jardin wrote:
> Add the support for lx2160 and other layerscape for:
>   =3D> temperature list
>      | cluster67-thermal   | qoriq_thermal | tmu@1f80000
>      | ddr1-cluster5-...   | qoriq_thermal | tmu@1f80000
>      ...
>=20
>   =3D> temperature get cluster67-thermal
>      cluster67-thermal: 56000 mC
>=20
> It is designed as a generic UCLASS_THERMAL driver for the
> QorIQ/Layerscape on-die Thermal Monitoring Unit (TMU).
>=20
> It is similar to the "regs_v1" variant already implemented in
> drivers/thermal/imx_tmu.c, but the i.MX driver depends
> on <asm/arch/clock.h>, is_imx8m*() arch helpers, and OCOTP fuse
> reads that do not exist on Layerscape.
>=20
> Rather than #ifdef the QorIQ bits, this driver is a clean Layerscape
> counterpart binding the standard "fsl,qoriq-tmu" compatible used by
> the Linux qoriq_thermal driver and by the existing fsl-ls10{28,88}a
> DTSIs too!

Are there parts of the other driver that could be split out to a new
file/header and shared? Or are the i.MX portions too deeply embedded and
cannot be easily abstracted? Thanks!

--=20
Tom

--zHoMh0vXvCvBulXh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahcIFwAKCRAr4qD1Cr/k
CpF/AQD7EYtxJF9QplYaKW0ZmQkXeGWD/OJ11JzDxTm5fGGWmQD/VsIpcEOeXMAS
MljeAlHpHM31SqejKEr/XaqbCRF7Igo=
=Tp3h
-----END PGP SIGNATURE-----

--zHoMh0vXvCvBulXh--
