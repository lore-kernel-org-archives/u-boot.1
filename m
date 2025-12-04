Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B9CD2A551
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 21:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F8683869;
	Thu,  4 Dec 2025 22:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FUE7KA1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 842BC838A0; Thu,  4 Dec 2025 22:41:21 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC9B808AF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 22:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-657a6028fbbso694615eaf.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 13:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764884477; x=1765489277; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ImAipvZcuMku2504ieuU3f2v6+sQZDH8D4UV5tJc+XA=;
 b=FUE7KA1mzLwyqSTc/W+ClySkkaNs0AX0cpGD8Zk0ZUfGHr4+i78AMRftAH3NeYqnLA
 QShPUFimRy675XzGHZGU7q1+vru117F7Mgji1ETw1MndkEdq0peLrhtWPA29BIqvkt0c
 BSVanL3G6u/dyDF/pnYW9QNeIiAS5LPiGMR3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764884477; x=1765489277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImAipvZcuMku2504ieuU3f2v6+sQZDH8D4UV5tJc+XA=;
 b=ln1ZGo2varGLkWpDC11LT3StsCli4r4ARkvyFJ40qkTwWvv4r5X/pI9mmElPWSHc0p
 dFbZDDdzcYiHJq8lMi9vS+YUDS9zmhrT/wBvCVjOWLWkEqn0wuhgxnsoyzHDW7waq+jG
 PEkqEI3ftOOD6VMb6Y/bRhjB7VwKEO5uhOeApEBW1MIXXvGeq49DyGHY5IG6Bkz7N/HB
 Q6A/rOYzys7rftyTf+fn7crYewRjokuDkYacJ+7EI1bo7VPl7LkskUHaTy57JHftPMyy
 GQiVgSSXfeevlqYwE1+RWmo76CSot1CmgHliaBp/FiXLrcltQmvVNtMXfMZ/eOStLNNJ
 ubxA==
X-Gm-Message-State: AOJu0YzeCyL1IcZzXuwOCWN4SRCIU0jeVxUbLDWvZwDUh27uvBKCXsLd
 vkz+GUO40Wx3JFjUibXiKc9T9MIVcLo1WW+DMfEdFSlNu2wYep8/glArngP5ssFYPYo=
X-Gm-Gg: ASbGnctHgEcX7rpJk4kQAFzqDfifeP8aofYbkWFnZN3mOKKG6Rf238vxdDpvbcxCngd
 lkTgyTxJAsKn9PncaSYZwR39z0vR98dnGMvFmPNK96wl43Qg15HZhqm0CIMnQePv0LETBsom3jW
 wFwIWDoNdxqebjcvNcZkQzDtfQm3RJhuRnhSYKPQHl2fu2IL+owb5ir6NGfMaDv/BIjmzJQJox0
 i/h1Gh3Z972MHReog8W0MyqueaaXd/6+Vi3hs29AON/sDvtL7TcHJ77Zb4fHAUl7Sa8W0WD0+t2
 /i977nwQJT6Gj2yRobW4iZjoTPosB50+4Te1RxCKWlw20vIFyEXTqEIkugR5dwXOgERyb3yip0h
 HwLv7ONnlWlmdkClTe532MtpObFer0HK4RCLdzqE7SufkU029odmlRKZaZxX5X7aEtJ5YmwFQTg
 R8QjYFxE6q4jwJSUm7ncVwwJLMngTTGONMDx4cmBfV49qiBq6iIBWt6urZn/YF
X-Google-Smtp-Source: AGHT+IFplKCuGFtP5lRnXpnxE0CwNJLc/Lsm75xXIGdiBmd6t/WxBpLl+SKkPnb19GZvukEUS60VhA==
X-Received: by 2002:a05:6820:229a:b0:657:60b8:b07c with SMTP id
 006d021491bc7-6597b9f66a5mr2259798eaf.2.1764884477586; 
 Thu, 04 Dec 2025 13:41:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef0c7c1sm1236782eaf.12.2025.12.04.13.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 13:41:17 -0800 (PST)
Date: Thu, 4 Dec 2025 15:41:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: toradex: add aquila am69 support
Message-ID: <20251204214115.GF303283@bill-the-cat>
References: <20251107082427.7480-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zdJdh9+xf2+K7YBo"
Content-Disposition: inline
In-Reply-To: <20251107082427.7480-1-francesco@dolcini.it>
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


--zdJdh9+xf2+K7YBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 08:24:26AM +0000, Francesco Dolcini wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
> Add initial support for the Toradex Aquila AM69 module.
>=20
> The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7
> family and is designed for high-end embedded computing, featuring up to
> 32GB of LPDDR4 and 256GB eMMC storage, extensive multimedia support (3x
> Quad CSI, 2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet
> interfaces (1x 1G, 4x 2.5G SGMII, 1x 10G), USB 3.2 Host/DRD support, and
> a Wi-Fi 7/BT 5.3 module, alongside an RX8130 RTC, I2C EEPROM and
> Temperature Sensor, and optional TPM 2.0 module.
>=20
> Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am=
69
> Link: https://www.toradex.com/products/carrier-board/aquila-development-b=
oard-kit
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Co-developed-by: Parth Pancholi <parth.pancholi@toradex.com>
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Co-developed-by: Franz Schnyder <franz.schnyder@toradex.com>
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

While I am glad to see docs in the initial patch, please fix:
https://source.denx.de/u-boot/u-boot/-/jobs/1323274#L236
as those lead to CI failing, thanks.

--=20
Tom

--zdJdh9+xf2+K7YBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTH/9wAKCRAr4qD1Cr/k
CvZjAP9ylu5ynvlpkAONpdyofjpTy2PalLdSq4EW1MlYeRgVjwD2JAqvgS97kpNh
PBZ6Mw16BuefHGW6SvdAy5E0l0+8CA==
=x+6Z
-----END PGP SIGNATURE-----

--zdJdh9+xf2+K7YBo--
