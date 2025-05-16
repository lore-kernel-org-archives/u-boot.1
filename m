Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F5DC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 19:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF0382A8B;
	Fri, 16 May 2025 21:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GEXU5YAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C0082AE2; Fri, 16 May 2025 21:18:43 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95BD8059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 21:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-606477d77easo1746072eaf.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747423120; x=1748027920; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SRQBnwp0yfa8aoEtXAd4nTIydPHKUbBek/4rjBehNqA=;
 b=GEXU5YAEs4v4BiYK8GNP/8tF7kz97ZIg5JI1k+x9gppcXHYb1Z309kp9bl+LbUR+EV
 BERk1Np4H/hIwK8s4PYd5EUMlcnrwNACLHZPVLaZJCu+oWYuJtrakFO4WelNppmJ0K60
 4hZ0AQy1eVo6EiDZ+agNkPnGtSB3TFt8E49MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747423120; x=1748027920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRQBnwp0yfa8aoEtXAd4nTIydPHKUbBek/4rjBehNqA=;
 b=nEqvxH+ZKYVlfwbKEtAxA4XnZkRD9X81cacSlQ1lHrgI/RgZTqEQFqI9/umy7PI+3f
 NgzkTsVjECHDZEmDJv715jImPA9wz5hJebVmkzNvznoKuixU487kuaPzVUM+3ZLuqoLw
 U49K0dOEDaAAueQ9TRoN3orWCEmQfhNX4i9s/pQ9TMnpIS5Xi2x8A1YTOUxG+Ne9d6Fi
 UpkucEuUWd+n1wsb65cCu58G+58S4B1d8VbxStL7VR1jMRn29dlupquLFnorCZET/eUF
 nZ8qu4eJJAXbonHMsVh25m6YLUDRKMRdzXAlirtumJRXgM4379Z9qD5sr0foLsIMSFp6
 fm4g==
X-Gm-Message-State: AOJu0YwhF25d3H8M020WCkHlO2E4HDchaYZR42Fj9wx8rGaAVroYRduT
 8eDKIW4FlaDFqkWbDdBkJaRmZPYz/ssgtLoi8Qw8kPFF+HOLDKRIKfOpSifG7iOCAlWmu31Lfmy
 3bjIDydY=
X-Gm-Gg: ASbGncuSEXfUnXoDKZxlVIeJpAWs8ha1fsKtfrVHEX7J3cpwqJk/yOMLotsVDrq8WsT
 YI8KDDuTLoNRiEqL06LdoIOTfgXBbjRxW1yQQFPFs0NQTJta70kE3THRoeipEt/uSGCsuDcwzsH
 ZF30xCjGm6JHCJUMZQoyxF9E3Cr1OFzComc5atG7hC9ID/aFCOc3puqF8slRyLbr10Y7soo7Ok7
 fT7UC0sy4BhjwM7sR4z31Uc9bj9Tzb1sRsCd/5vZIoa30PGebxsC8yiFUw1LEirEnFnauXEw0BW
 EHcpwOkVfzkLt1D82zoxCqPew9uHCTR+1Bxce5SLgfxX45T6p37AS0Ov+GCrZphsE+J3MqWifVZ
 QEvuzZfpReUCX
X-Google-Smtp-Source: AGHT+IGMfwdafL/CytVpdSyuzJLMFyCN6oOLBawkWGJ+vgQF/cHHmr/+5eue/m1zYY8kLVKpOl+lHw==
X-Received: by 2002:a05:6820:3087:b0:604:ac85:abe2 with SMTP id
 006d021491bc7-609ea192c9cmr6038274eaf.3.1747423120468; 
 Fri, 16 May 2025 12:18:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f3f1c1sm500402eaf.12.2025.05.16.12.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 12:18:39 -0700 (PDT)
Date: Fri, 16 May 2025 13:18:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20250516191837.GN100073@bill-the-cat>
References: <f5f977a1-34fe-4e2a-a604-0f0695f3bc7b@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4KHmamB33XEpFkTJ"
Content-Disposition: inline
In-Reply-To: <f5f977a1-34fe-4e2a-a604-0f0695f3bc7b@denx.de>
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


--4KHmamB33XEpFkTJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 06:42:11PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next batch of mostly cyclic patches from Rasmus:
>=20

Oh, and can you please update the .git/config here like you did for the
marvell PR? b4 doesn't like the git@ syntax so I had to do this manually
:)

Applied to u-boot/master, thanks!

--=20
Tom

--4KHmamB33XEpFkTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgnj40ACgkQFHw5/5Y0
tyzbVQwAtsdcV4kWW6icIb66zx/SXZtElQiBbt3fvjgWSfXMRQujFez+e2A8CODk
CGiJZKB2fYngD1s8X899Zux/QYBusat+FY+AETGTcDCKJDYpBAxzL0CLsUIPXXTs
0I5xiEs0LRowCA0q4w2lvCUsh6mSxKlovoP68QXfpo+8EOqhBT/ISJ+zGb7byTWV
6BOYnOI1yEZ7CSC05gqsODQzZDVy03O2UrkXdq65t54D0WVkHvGnYOqny2bdhlRF
Bv+RouZpLchQsUl0JlX5gMgdqOxKIG8ksGO3FLIOEmHsmryc0pRNb94afIdDOHF5
nCyUc5UFMIr5adaz73FNriVWjzpXhAGHz2OAglAD2Qtx6tSbqigfeSzGjsbQYWnO
fDyAN4vuItDUBdPoxZ0Qitw+HcSIioYhMSt9BdIcsKYwpJ5BICIzKuMnxrLDLUvf
oW1lpfE659xiFqoCeFcO4M/yOu1qEYpGWG5h57sYVrWGY0P5OV3L2sMO4J2wiAtY
WDajxOq5
=LCPx
-----END PGP SIGNATURE-----

--4KHmamB33XEpFkTJ--
