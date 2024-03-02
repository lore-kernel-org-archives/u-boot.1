Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29709C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 23:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D9CD87ED2;
	Sun,  3 Mar 2024 00:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pa53iLCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8790287ECA; Sun,  3 Mar 2024 00:48:07 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EEBD87ED2
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 00:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5a1206ba5cbso298162eaf.0
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 15:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709423284; x=1710028084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EQGuYN/O2zAeT1gLGyn2zEmgbHwrOGOJ10FQR5PTag4=;
 b=Pa53iLCMcQ8DThUiu3FyVXCiFlM970dvlpOVBbGHeai0jiECpR/grtrRy01DD7tsE4
 Xfc8Sf3TCGV1zTxTbraijgA73fnLcvC6DaDDuheIe9whfO0P3HaywlOmwNIBC7QkIINR
 5x+313g8MXld5apnXuvT07ANe5lqGe4CE/msQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709423284; x=1710028084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQGuYN/O2zAeT1gLGyn2zEmgbHwrOGOJ10FQR5PTag4=;
 b=WTCWj669CtXXmqUR928OkECOVNpfCVUlpiU7dXSvy33I8edKY1Fnpo51ob5G/5q+6y
 yTbgJ28O/+S0iNqG+vfklI8YGCPXciDO+sHR29A5oPU11ryFZ0XcbymBX55jBvRivgoq
 VO5O6j43g/io3oE0Srupp2M2yiagPTfiQflEWwsi155P1yiBIgOJjR/MpcigUeUfPl+K
 iJdTNw3fmoVrqoArr621ZU0D8gXxkEnYYzXEdbg0Cbsrpg7KZlvHl0jQoy9oM/sGGQj7
 RMDYAY1bX8SB3JtDsbLANEQRip5V2tCXJOX/RrV7hN3kjrRtxv6vApP2OjltE1M7X7uU
 rGQg==
X-Gm-Message-State: AOJu0YzTSnEMPvmQxZiP4F5j0mc5Fo4NlkGdpnY+9tidaozqFsH+TCGn
 21rw/zmDuHhQ+yjQcpU3UhGawMxtEsGa0qIjy6miLKcu3krPZXBCm2OSV9iFluy+5NfQ6LpXGlD
 F
X-Google-Smtp-Source: AGHT+IElaPBv1kzvCG7LkcSC4dd4jNYIzed6y1HGYbg/oB0tJtcSed3XOE/G027I5ZU4bTpDb+9zJQ==
X-Received: by 2002:a05:6358:998b:b0:178:f895:5978 with SMTP id
 j11-20020a056358998b00b00178f8955978mr8353171rwb.10.1709423283640; 
 Sat, 02 Mar 2024 15:48:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 dw19-20020a0562140a1300b0068fcaa599f6sm3419037qvb.67.2024.03.02.15.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 15:48:03 -0800 (PST)
Date: Sat, 2 Mar 2024 18:48:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master-riic
Message-ID: <20240302234801.GB1523872@bill-the-cat>
References: <20240302165311.27487-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VvUYnm38e6VBpVRJ"
Content-Disposition: inline
In-Reply-To: <20240302165311.27487-1-marek.vasut+renesas@mailbox.org>
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


--VvUYnm38e6VBpVRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 05:52:43PM +0100, Marek Vasut wrote:

> The following changes since commit abd4fb5ac13215733569925a06991e0a182ede=
14:
>=20
>   Merge patch series "Dockerfile: Build coreboot from source" (2024-02-27=
 16:28:57 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-riic
>=20
> for you to fetch changes up to 3787ee1d2d782cabe604a79c95785276ccd03177:
>=20
>   board: rzg2l: Support reset via Renesas RAA215300 PMIC (2024-02-28 18:4=
2:27 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--VvUYnm38e6VBpVRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXjuqgACgkQFHw5/5Y0
tyz+NAv/epWtSBq01Hdzi3jIsHBjjRizlxZJlBL2hRZqbh1khAxZY3oMK53Ykg/j
OHBsAyUzSKhbKwGlKErHJuUazhtYunlfhWXDAJpPND9BsqdFUp21wbtplojiMD0y
BrVOEzI4okCWqSL33LBgvirx9GuJR0WgUPei8M+NrdzdbmUlmHE1BlE8s0/jpLQ9
T49Jyx5Cq8fDHxa9GC9/zoHSktB7q/q3TfewGk1fkl2vOjfNrYeC4yKygHA/q1Y0
Labk6U4oIyc73yLWbNwT7syHNA1hN7xU5ZbrOdVcj4eVBdvVZ8ky3uIDRjXA51Cp
sRIILWaOJRmfYF91dtH99MkXN0hbks9xBKZrlNifuI7pMMj/9O0sS7klte+4xyDd
F0w9yF8QJ9xKSnOQwBKpPrrEqAuRiKqiF7ka/kBQKYni0objt0XwrRMNgvn9B3v9
humh3vzo+FbXlEY2TNC7IWL7LsdwbcIwpRItMGmntb+upKFxkIRpeXpwCXvlcN0r
yl4lnCIK
=QpVl
-----END PGP SIGNATURE-----

--VvUYnm38e6VBpVRJ--
