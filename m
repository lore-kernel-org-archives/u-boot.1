Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B683CCF9EA
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 00:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B637832AD;
	Wed, 29 Oct 2025 01:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n1WiWT1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED89836B4; Wed, 29 Oct 2025 01:00:27 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3713080422
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 01:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3d1e68f7a6cso2348318fac.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761696024; x=1762300824; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qLg0ETsvUU5AoTSLbyFxU0frV3XA/RpmkhfXis59CXE=;
 b=n1WiWT1HNCnIkzv/B7C2DyxtMFPJUBSnMIlu2AKPhoSpo14j8juNzDKB4LLlxvz9B8
 4r3SMAya9fH7qMJBBcUiCQLnING+JC+AlA6eJABueHraUMiaTtQawuc0xFZSM6/GQvCL
 0YQF3kQ2Uvn8i8lc6z3UkTZXC4Q5PuueqbdoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761696024; x=1762300824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLg0ETsvUU5AoTSLbyFxU0frV3XA/RpmkhfXis59CXE=;
 b=js0o3tsgQRKy7Gex2dzyGxv5ht1aDKshos60VhbfA4YH2A5vORsJL3xPRxscdSwld5
 wWs6Rhi+KMKEJ1XoeTsIo0h/ZzG8rUrzSBkAXgQHRRJMne2cIpOsyS8b6suHMnRmrhgp
 m/OMPrjAbXP+gXBKqUOVEEeygye9EzrSawhZdT1a+yVAF+3X+qvcF69VRgitqnY2tFpI
 GJgsy6S3/3iKFDt3rRmkHJ7PW14VxUoznnJLzi/xCSwovUGPNaYDDFAFwRVp6pw3bg5m
 C7ihlGsrCfLyRalXLS5xmGhqhg1QSIo/Qgv9mipiC47+EGdJXY2QDLEmFTBE41Vau9Q6
 Lc6A==
X-Gm-Message-State: AOJu0YwnfrpO4lZngBc/9CECzfyIVNfp5IRGl5kZKZs0xixHLWLDoRnE
 VV0nULpUjw9bIDBifHqy4jU/ddlTDKn7jIlAkMRVpeoNb0QTi/riJJc3PwJpqTr3sCPsf7hnRxc
 7Y350L5/f6Q==
X-Gm-Gg: ASbGncv5+x3fRyNY8TQ0Gja0wJ+Qq3lPelJgBQ/VeejZg4OrxbBthUEUme3BA/D9BWa
 vmQ1dSC08Pw8UKmjgYWm6rlnhOOLgCTQrmsJMdCpzIzHxukXI+bjxxEaGtn67ghijFj7AEcmexv
 SD5kzzGY7qIDhuiBDG62or9eQI4OlL3gXo8Bsakn3EV7LnmOktKm/N+hY5nV4GsPk8//C+2IbyR
 NEhli8YcQItTqCN70Ayt6Bqef559Ss4Wc0qalk2lTvgIo9CeKqGBCc2zXX+3QvRQYDcCOlKJBqC
 WOklxrEnUEPok0KpdRneBfzz/Kq/KiSB4ne0zIeR/4QwhFI4EiKbQryF+l6dbAg3YT3risUdSWH
 CMl1YhK9yVNbaBv4sVz0hOLdL6cjRwe1lTruL28hRXlcWWzf+tbBGQFPc+tehAXSnwaSRhV2tKT
 SXvqdhNCu2PkYCLu0w/N2ZIs9zvSTi+ubVpx/WX5o=
X-Google-Smtp-Source: AGHT+IEWzctpilLuYlq3GlKteu/UFfD944kSg/7WciIv9dutY1vhYG9xzNmWoZq4E6Xc8NoF/+OOaQ==
X-Received: by 2002:a05:6870:6490:b0:3c9:8689:35d1 with SMTP id
 586e51a60fabf-3d746f050e1mr644220fac.32.1761696023848; 
 Tue, 28 Oct 2025 17:00:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e395c213sm4091704fac.21.2025.10.28.17.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 17:00:22 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:00:21 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/2] spi: Tighten some spi driver dependencies
Message-ID: <20251029000021.GI6688@bill-the-cat>
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-8-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DVtLyjRe1DOMxzGF"
Content-Disposition: inline
In-Reply-To: <20250804215719.1413106-8-trini@konsulko.com>
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


--DVtLyjRe1DOMxzGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2025 at 03:57:17PM -0600, Tom Rini wrote:

> A few spi drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--DVtLyjRe1DOMxzGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQFZEQAKCRAr4qD1Cr/k
Cm/aAQD+XbfJsWq1RMODY1hQlpCuQkeYBi7YoEmqZhgCNrUfEwD/YcBmK88xLHiq
btL5s8+SuRufDR/3N9XvAA2ChIyQxQ4=
=FrIP
-----END PGP SIGNATURE-----

--DVtLyjRe1DOMxzGF--
