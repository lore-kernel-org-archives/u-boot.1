Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95BAC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 21:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93051805C5;
	Wed, 22 Jan 2025 22:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bdufkHWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 229AD805C5; Wed, 22 Jan 2025 22:57:08 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F107B80326
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6c3629816so11774785a.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737583025; x=1738187825; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hIX6RnRttbaOAWTqYcRBmXGpWOa/eGIMyAUctA/P31g=;
 b=bdufkHWj3lS02Yb3Hl/S2wizrzlwN9LP22It2Si8sYlBDT+F30YjqMhmcgZIWB+yx/
 G2x2RF44g5ZiSiHahTMxV1GRg/CYzrQvkQvB4sz/GybXNRu//yMm8FO2d4j7mbqboRsl
 KjXXeyZ/NGAmOnSzGfdWVPZc0W3MkurvY17xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737583025; x=1738187825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIX6RnRttbaOAWTqYcRBmXGpWOa/eGIMyAUctA/P31g=;
 b=vBl1FjmOpi7h/3kIuSHMrROSRTFI4MNwItndfKySA17jZxdYrretvgqE19JIDm1HJ7
 AuUnXDQXzdHWdLiuAIsj0iHg8nMCUBRPX/UxNqmpXCiEWj5Cs1pVh+SQ7hrhAs1/NryK
 MwuW7nhvgY7vBuTzxgTklgv6N+fkdHSPOkxKHXtDbvYra2Es7VxT+MtDwd2LxgifKVR/
 jvmZDkgGozSLfYyVH8MIuQvWzSTpmSBP4s1ihpFIL9mGk9yzp6IVLeE5XnRqQ1bDgnMt
 Uvw0d6hC2dQBGK2g41ux7uTC6ek1UgFhLrshOhKjoog2NOrItTRbYkinN7v9u0eltrsw
 8lGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ZbxO1W2zvRnsS55YDE2Dq8VWgysAZvqzPkhN7WogRvqWLc+RKF4X2bfSQYnjYiNRn187W8w=@lists.denx.de
X-Gm-Message-State: AOJu0YzPe1AjO4o9/GRbEI8ZG7FoggiGjMCc3sGCAmDje6ikbp1tGBjI
 u7CH3d6JRcLgUE8uzAGg8iMD3iKceHVTpU8e7JemYmedfJuwb6WEmrJK8BHv6vw=
X-Gm-Gg: ASbGnctM+cvQDtdpThwgsguIXO26FDWlxtZGgSrxBKvlHcLjVy2AaAp7JFaM36W1XqL
 XFSPOKWzZpSAe9cJ3wF7oDxXgA/DbVvDiwWhu/7ewdiJfwcJWOpqMhT7VNBOYaJfCrtDGllMYmo
 7MVGIIdf5cNZJBgeGoQMqBdsKtPKgwMq0DGUsZ0AUuHzdIpRV7cDNARJITysjtzKZiHBygtpr40
 RK2xWN2dstIYvn5ZFwak8EEsfZ70RYvYXjBak9oTC+T/xlLO+qJC4IxzSsuXEFn+Os2+A==
X-Google-Smtp-Source: AGHT+IEaliC5cz5nHh+XiY3wUoGQE8HNegX3sDWZLwJHaLpPVolnjGYQCku3hQwhfjUSPuADU74sBg==
X-Received: by 2002:a05:620a:1a02:b0:7b6:deab:d485 with SMTP id
 af79cd13be357-7be631f6a2amr2605240885a.16.1737583024892; 
 Wed, 22 Jan 2025 13:57:04 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614ef1b2sm696357385a.106.2025.01.22.13.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:57:03 -0800 (PST)
Date: Wed, 22 Jan 2025 15:57:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>,
 J =?iso-8859-1?Q?=2E_Neusch=E4fer?= <j.ne@posteo.net>,
 u-boot@lists.denx.de, u-boot-qcom@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-next
Message-ID: <20250122215700.GD60249@bill-the-cat>
References: <20250122162407.1870390-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XiW5UZk9WqaHvWtS"
Content-Disposition: inline
In-Reply-To: <20250122162407.1870390-1-caleb.connolly@linaro.org>
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


--XiW5UZk9WqaHvWtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 05:17:45PM +0100, Caleb Connolly wrote:

> Hi Tom,
>=20
> The highlights are:
>=20
> * Fixed boot regression due to broken memory parsing
> * Enable HW RNG and KASLR on all platforms
> * Add support for Snapdragon X1 Elite hardware (clk/pinctrl)
> * Add support for QCS9100 ride automotive development platform (clk/ufs)
> * Add support for PCIe on SM8550, SM8650 and X1E
> * Implement software debounce for PMIC buttons
>=20
> Additionally, some minor improvements to "ufetch" have been pulled in:
>=20
> * Show CPU architecture (arm/mips/etc)
> * Make CONFIG_BLK optional
> * Fix 32-bit support
>=20
> The following changes since commit 82d262ae162d859d3b0bbcd40a9464e890b009=
da:
>=20
>   Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)" (2025-0=
1-21 09:29:05 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD
>=20
> for you to fetch changes up to 599a1f9076d34c29d3683e0f833706478d62d9e0:
>=20
>   MAINTAINERS: maintain qcs9100_defconfig (2025-01-22 17:14:24 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--XiW5UZk9WqaHvWtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeRaawACgkQFHw5/5Y0
tyw61gwAuSvlDNZoWpf1heCjXweXNPJ/sCz8AkUUjalsqq+v/mT8ABXACB1xnzWU
OMcm/v7V7Ouq6RY4zYy0wBCSTrBdEVG4R1aa/SVLGGdIQApaeehjw0CQfWCnFNlt
rtBRKZD0HjIq19sHebuyFnoJ0etSYib/wezDKilUr/w3MvrVw5/zjHVWqYU4dLq2
VV+GPRhdth9eYX+GcoI9n0vfRwZnoznxomDxiBo8DfOxrxaJaffcqKPSnIfOJP3H
/ShVxYBFKI/GtoruDew0nP9KbuDSTAl5AFnC5EzMgxXox0aFOqTZ1rev5kOXmS+X
12YRfAsMj65LgSnvt4LhqaLxwb8qlvJH+ZZtxciLNSh2JEWYLEcZCB7Bf5glnaT+
+2PtBZEylhwktYngQdzl4IDe7n0bVQSmi+ZI+SOk39gkOPSrkv/r4xEZzIINJllx
gjwdzy6Wd71y8UfEl4DvE4v6trENM5aKcNZE0GhC8At/hRwaplZozWGmCPp1Aseb
uyJGrASc
=sNqZ
-----END PGP SIGNATURE-----

--XiW5UZk9WqaHvWtS--
