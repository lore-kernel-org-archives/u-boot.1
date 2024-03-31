Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A391CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 12:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179A187971;
	Sun, 31 Mar 2024 14:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YicJLRaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CCB187ED0; Sun, 31 Mar 2024 14:59:46 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B342F87666
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 14:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-430c03bfcf4so18910031cf.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711889982; x=1712494782; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3zJHlruDfgdXOghYMbLvUYyW7ByYMDU2fcdVnqhvGX8=;
 b=YicJLRaCp/S0VmCGBg1oNLGYr8V/Fz2AW5mHnvJfJl5gcjExldw3cLMJK7Z2T27/x7
 WxJw8hohn9+hNRp/mFM8RHMGrmzsAuIJjw09wHOuBEMfzUQyNitDNclcTrD7B+AQVG9F
 lJU5FTTdsaILDOjejGS3IwV0w24FN2WqPccWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711889982; x=1712494782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zJHlruDfgdXOghYMbLvUYyW7ByYMDU2fcdVnqhvGX8=;
 b=tlRV6aw8mtSB2HU+8onspMEuaeo94PJu7Vx1YAQOVQdgoGEnCHXfq9Whu9RfrqS7Bx
 Zx5IbUqDEwcaay3QTjaGCi7htE0akM8xfMvSl1daQOFUA+iHLAGOd4S57/rKllEaUSIo
 nff7Q4UwgSOzwTk9vDRGJuzQ5CLiRrnuGQKisKC/6kXAEhAbxNEtw+LHuyY/pSBK0UxT
 KmJatTSiVQ8E2CcWp/hCKU8ZzNy/QIDzhvt2X4o/LUBr1UMTPJ4Uy8Gk99lF3sZEQnHJ
 PE1QTtaYKS86FYGDh9BJ05puHWFLpCo/YicH9rhZ0gOjQYhmYOkVDutH2yB3iSQVlMZC
 5yuA==
X-Gm-Message-State: AOJu0YyZ7xM/JWdip4+PY+HvRDvGovQS7N4TGJdoPH2ADst82d6Czjzh
 Z1qbTHjmyT7GkBTrgqjVDodrsSPagKOQrnKxsBodEM4mlI/qJAhave+8enI+bz0=
X-Google-Smtp-Source: AGHT+IG19z+L8a2lajZZVDnEgxyK/aZKbUpQ0EeBY7nTb7BCx0BvOmOM3F4wcBAqeEHjvsEr6p+VOg==
X-Received: by 2002:a05:622a:34b:b0:432:ebb2:2ea3 with SMTP id
 r11-20020a05622a034b00b00432ebb22ea3mr1550374qtw.28.1711889982498; 
 Sun, 31 Mar 2024 05:59:42 -0700 (PDT)
Received: from oliver.lan
 (2603-6081-7b00-3174-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3174::1005]) by smtp.gmail.com with ESMTPSA id
 w27-20020a05622a191b00b00431662b2309sm3529948qtc.62.2024.03.31.05.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 05:59:40 -0700 (PDT)
Date: Sun, 31 Mar 2024 08:59:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240330
Message-ID: <20240331125937.GA2168937@oliver.lan>
References: <20240330194031.2790982-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BoQAI/j6XGyf5NGt"
Content-Disposition: inline
In-Reply-To: <20240330194031.2790982-1-festevam@gmail.com>
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


--BoQAI/j6XGyf5NGt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 04:40:31PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull this material for next from u-boot-imx, thanks.
>=20
> The following changes since commit 6e2228fb052b68c84688d5baff06e2ebc787a4=
a5:
>=20
>   Merge patch series "Clean up arm linker scripts" (2024-03-29 10:39:38 -=
0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240330
>=20
> for you to fetch changes up to f21b3e2cd954634d405fb522198d099879f3f1e7:
>=20
>   config: xea: Add limits for SPL and u-boot proper sizes (2024-03-30 15:=
12:22 -0300)
>=20
> u-boot-imx-next-20240330

Applied to u-boot/next, thanks!

--=20
Tom

--BoQAI/j6XGyf5NGt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYJXjUACgkQFHw5/5Y0
tyzpTwv+KPyCfjPO81c3IXyeQE/+0EzMj64MR/SjVG2baeVq1uMfcd8N3NcSiq11
gi+qGoTFAFuqTybfOa+5dQNYknY7/B7ndWDWGnA/f/h/iIBBcpVCB9STeAjUkbB6
yAo6XYfzqzmGTBoPGBhZOAzf50khYJPMnU70zekBuAsf1PpVABKqZ26vy976+iK0
IAyBKVK2aK4A9Caoq61ZQ5lJruhUTT3FJOUFHBNCQ977/8Hw4MexLvlFijcxIDY4
BGa43vOBgGopAey/usakM2dLINVaopnhzWIJiERkwG9WHaeaGbgoVJwfEJ3W4bMT
jbSkaxBjyDn1sLPrQZWflGNMNr1IgXj8zbKNj8OclwAIekdWVh2rs//PbVaGnb5N
AeVpcMcfXELihOrM5hQGxmG7Zf966U6R7jGnsJWr1+3yO9L50QCXI8quVAwDRuk4
B2xhbXUAdWSxHNmFg/HDl0ScMvchXl13J5y/HeGITz3Hjf+IZUQ80WgTCuXqlIgJ
szi8apK1
=g4Jn
-----END PGP SIGNATURE-----

--BoQAI/j6XGyf5NGt--
