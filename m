Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B035AD116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3299C8456C;
	Fri, 28 Nov 2025 15:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rF45D58l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FCE8456C; Fri, 28 Nov 2025 15:11:12 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BDC384565
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3f0cbfae787so1333205fac.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764339069; x=1764943869; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fNqA4qzOdwK1ZCrQ+x4vOdym5ZHOfK6row//nEymub0=;
 b=rF45D58lhKV8z4TbkvaZce3bwjiOd1zKwvsJ3CmGX8U8moXjzdx4GQjmwK6gMIpDSR
 wIp623/t8CNeMOgK35uOfUi6sRv4hqnJ/7qDewLDUQCf5j4KUdd2rdI8qEPwoxTeyqNM
 PmcgIZRSrgVsoqk/DOc1fx26xAnL89i+QBxrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764339069; x=1764943869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNqA4qzOdwK1ZCrQ+x4vOdym5ZHOfK6row//nEymub0=;
 b=nAq5jIwwcuzRTFNVi3RMzMt1EltyGCexuQlp9c1RKc6diPQbpKtVtVUnMiFFlGNxrG
 k9bX1gfOpSmUrS8bq0FCbqwnuJHRrA1LdlIzrKHVHpp9JQZopEJMqVPC2isLPbyr6fT7
 e9CcVUN59i/t+b6wxjFR5xeLXd/1bEaLL4/rS+0RtXU9shi6X4BlqFaWufQ5byz0mJ9k
 iXR250PKIQr9jM+cpfqGI7zp2oS2LgDQtgP5en1zyf6ZNBIzsu8Yvma241wDWUuoxyqu
 8OCYE85kQQXsGM2esJ8wnDFmWn86fJ4zekz1/NogVviWNCAsI8f/BY16ujuh5LTmLCy+
 /j8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyjVg3keESKOCVDkEqRfh4CsAA5UFDMIxoItTRDEOMvUOPUFQCYyn+s8l6nxV9TO66hsPQq74=@lists.denx.de
X-Gm-Message-State: AOJu0YwtNmwo/nUGoLMk3w25ZQIIiFko24FSD8cKqYMz/2CBVrnJACI+
 rQsNon1yM4Z8rRnRZN6bWAfg88uP4n3kX1W6eBVDV5ziKQOyb3bI1tC1DswNUoOii8Q=
X-Gm-Gg: ASbGncv7OTN48yZ7t1u2U0SIxYhgs+AoCKEl7VMDFnUnhI8UIudvJZHFRmoBm7/PBFY
 ibUi8Ir6lbhP1NrrhoyyOU3fO6uuLr0OYD3s3jvd52QShnu8Vm/z4nEIZ40VablENsXT6XRBAav
 GHu7hnzMpMoUkPLcd5dUct+AhvKfpdMy5WUAkLr+/JRAVfqgmiDYTyHPr1QOAbqSDT9+oN8TwRl
 eRn7b6mE5yE6p40bOqrADwnjIF6a/1v6v4lAkTOjR9X5vwxb53nHDxe3GboKYa5xZ93gSiqfdgW
 Gc4b4ew4dZlRn/9q+R5Hxqd7XEZNb+FOLKqoahV+hpCaOViKrtfZOwsb7yStE0fiWS3gNam2AEf
 cT3csUEkbDR1ljKfxvXiyV5gWpCEhHEfA8wAvskhX8FFzR4UifOrGsD3ewYChuviMOFqgFCO9YU
 tDMttIRw1GVfte8StQXUklkAt8nQcVfaab31yhIhhqUJ3vFZHBFtyUypbLjVXU
X-Google-Smtp-Source: AGHT+IF60WGh6sI9AwAHhrHfk0WL7is9WX0X1OMUy9amFQ0YrBGfvuRDZ3KqeE8SfXw+nbueNfxcUg==
X-Received: by 2002:a05:6871:2e88:b0:3d4:8741:edd3 with SMTP id
 586e51a60fabf-3ecbe326813mr11501252fac.20.1764339068762; 
 Fri, 28 Nov 2025 06:11:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd029507sm1783264fac.17.2025.11.28.06.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 06:11:07 -0800 (PST)
Date: Fri, 28 Nov 2025 08:11:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, nm@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] configs: am571x_hs_evm_defconfig: Reserve EMIF
 memory used by PPA
Message-ID: <20251128141105.GZ2125796@bill-the-cat>
References: <20251128064353.1295063-1-b-padhi@ti.com>
 <20251128064353.1295063-2-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NyvxjMRHO847HyW1"
Content-Disposition: inline
In-Reply-To: <20251128064353.1295063-2-b-padhi@ti.com>
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


--NyvxjMRHO847HyW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 12:13:52PM +0530, Beleswar Padhi wrote:

> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
> top 0x2500000 is used by PPA and is firewalled. This results in an
> exception and the boot fails.
>=20
> Introduce a new defconfig for AM571x HS platforms and set
> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 0x2600000 memory (aligned to
> 2MB as per page size for ARM32) for the same.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  configs/am571x_hs_evm_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 configs/am571x_hs_evm_defconfig

Missing MAINTAINERS update as well to catch this.

--=20
Tom

--NyvxjMRHO847HyW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSmteQAKCRAr4qD1Cr/k
CpsSAQCECGwEqEjff5JHz0anP8Pr/9rX+leG4sVhGMFw0GuK9gEAxKFqFnLw0O+j
WxANmQRR8kh1qjrXgQR5xDOC2IgTSQQ=
=UzuW
-----END PGP SIGNATURE-----

--NyvxjMRHO847HyW1--
