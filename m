Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F833D637B3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A925D83979;
	Tue, 16 Dec 2025 22:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uClDqp2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC36839FA; Tue, 16 Dec 2025 22:55:21 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE1E8334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 22:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7caf5314847so2137017a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765922117; x=1766526917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wDdHGBc92wabx7z2jFFQlz9MLuLpi5iYG8E1ltDEdEs=;
 b=uClDqp2qSYwWJZEM1vUlQuDBI1u6pmo2v0vaUpNnAMiCaejA32b/xsRXoKT7HmJAvU
 O+TRXuuM3rY3KmeljvovtDurkYeKMphUCG+nEYCMSTatLTw0YlqTQtqCQm2cZz+LF5N/
 MMzz7y0Zgm48tJKP6lTuYMGwOKt8cRRDo64s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922117; x=1766526917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDdHGBc92wabx7z2jFFQlz9MLuLpi5iYG8E1ltDEdEs=;
 b=p33s2bETkTkunoLzBXan9jwiMUMUTBoEuF+x0LOgSk7Tf7y1lfkBE/VPlO3HLLmj6n
 /jpk6HeacVn2e/ofQZPiO+dsk2T7qz3rnk3ZVaHvaHPRkrM72Lta4Z8EyyzxJAatEHIW
 hrRxRBUaYaPHdmxbly09u0u5N3pCN/jFByBS1WTFDnTpF8wDXxM1wDlXhsK1fWed3JhF
 f/1LdgKNL6OpZhFiGOV+VS5TGbmuX63CUY3HLsiihu1UHWH0zog32rePyf4LyBoXhU7C
 vRhh6GlgT4UwJLtw86kLl6itwYuEHigLr2dN+ZYAMDoSvg3VqlywEF6ZcX0uk8n+GYNl
 dY5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz6u+8x6R2dFhktG3+WbQLNSj2F/GfuHK3Q5o3TGjIDBiP5oJoDDBwHIWWTSYhFKC1Ey+xx00=@lists.denx.de
X-Gm-Message-State: AOJu0YxyWzQrkaWUeOarnChfZBNMad26Pn76uQcyWpxmBQS31WpJMVJW
 6dhsyT953KmAL4JdOXbJzombE8TszktIcamRmi4PCsj46O1IGKmTy/C198D+Jea3HZ4sg3QKOA3
 nWvSZTC0=
X-Gm-Gg: AY/fxX4poWt4vBGadZwIl8pGf2GNWpMbtrYgLixWD7sVDR9NQXZJ0g0my787jgpiKHy
 G6BjJB0wRhtBKduNQm7DoY5pnVhaTALXGAt7v31I6yHdR7vgXUECKvvSQxBcV/XMKhLRWRmOcT2
 CdeIVC//0/P2AQ3wjHySgjptHmA98+MTUar0xStjsqPjSPHY9aA+++dtjN8adVmntionfwGmMAS
 JnIS3poN7aQvR299qoNLZ8MwmImIUTzgTRNwa7vUnE8Ec0iZ2R8Tp6IT8039mj5UgRFIA8QF50e
 6I0cpyF2RGcx1IOdhJQaL+0TDNbrL1Y1DqsVDiTOpXaV8G75uGsRVsHqB/Rzv3rQiecYHDg9XSc
 GlaXUPEwbAZMx77lEyyDhWbGt0o1IA4P/Jrv5oTVGRSkA7nO9HsGThpIUnXJYaUrqHjcmwJOCFs
 UNLCV7ulc6twli88YOMB/XWtydcitCne+Mr3yWoq4ooCh0DSC6Uw==
X-Google-Smtp-Source: AGHT+IEzVDl+C7+x6jOsNRzCZ8b5OmT7VjMhL1yaz+XnCGqWT+EdAIlCj05I2aXTEdXbphJFbEbI6w==
X-Received: by 2002:a05:6830:211b:b0:7c7:827f:2b6b with SMTP id
 46e09a7af769-7cae839f2eamr10560582a34.38.1765922117013; 
 Tue, 16 Dec 2025 13:55:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb325094sm12824122a34.23.2025.12.16.13.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:55:16 -0800 (PST)
Date: Tue, 16 Dec 2025 15:55:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH v2] board: toradex: add aquila am69 support
Message-ID: <20251216215514.GZ303283@bill-the-cat>
References: <20251205080612.34703-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9vELzVNpBIuOJgBG"
Content-Disposition: inline
In-Reply-To: <20251205080612.34703-1-francesco@dolcini.it>
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


--9vELzVNpBIuOJgBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2025 at 09:06:11AM +0100, Francesco Dolcini wrote:

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

Applied to u-boot/next, thanks!

--=20
Tom

--9vELzVNpBIuOJgBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUHVPwAKCRAr4qD1Cr/k
CiPNAQDd68GYHd8VpABXadyA/Iyxsb+GJI1txPCzYRgD2C8ULwEA0YzxHhf75wBL
1e8wmWPVXloMSq1I0ly/0h0snhJQog8=
=6dtO
-----END PGP SIGNATURE-----

--9vELzVNpBIuOJgBG--
