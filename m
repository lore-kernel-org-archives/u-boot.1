Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385CEC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA88875F3;
	Thu,  9 Nov 2023 22:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="plkUeo7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B52787169; Thu,  9 Nov 2023 22:24:29 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BAEF875F3
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35942cb9ef4so5295445ab.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699565065; x=1700169865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9E6fdil06rd0xbdTHgRQgXrt42McdpySwsguy3lIl20=;
 b=plkUeo7BqPZxfVTZmbMmgcvhyNsU/FT1rle0YVjqsKM7TETkl63ixV5WF155pooxr0
 6zGs2nodbyesxObBOnJjhEAdbiLh9mKIi0yMbcI47RcO66kRQZrQKZfR/vf1ptiAHMx3
 LWSeqEW5W6SOeRr3FCpCZ0UqpFRjf0mbO8EKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565065; x=1700169865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9E6fdil06rd0xbdTHgRQgXrt42McdpySwsguy3lIl20=;
 b=WyxaYi6ELt17V4sM47+xbqY/vTWJ9ZPnXqdC94DXt5laJ9FEbpc+KEplRvRTNG6n0l
 TSNcXSJ291RbmqIzNUXgs9OJ5+MRHAkZsnzKWzikzeqiacKyqdBBXuRbMpTXelLxqD+f
 x640kHkbvzwP2ha3X7C9E9HSoSyLaX5YHbnRxodSyPh8FMIyA1TTsS/1zgGcMhDi6UdY
 3f526wN01vonnLo0Igfl5lfEynroyNoqsOud8U7Af/+7WXaOtmHOCRkAj11R28E2J1ce
 xjtC94gf1ROtIEAABp17uJOJxuHt/NW9XiGOIhilHdd5MXxqBX7Wv2lm3VT02XncsmhI
 PJ2A==
X-Gm-Message-State: AOJu0YwJ8jtxGYVXElOZdVbIL6vVNdhid5CVDNZDPot7QwAaNpH96v7C
 4R2PS3xJJehNQiUgEcHOOFRhZg==
X-Google-Smtp-Source: AGHT+IGLdb1iQ20kYddHZbkw/dJ7Bl4P0IvgxJDJCe3jesMdlzUf/3+yFmTj59TARAriqiaWFcUC6w==
X-Received: by 2002:a05:6e02:1b85:b0:359:5389:c0ea with SMTP id
 h5-20020a056e021b8500b003595389c0eamr6838478ili.1.1699565065382; 
 Thu, 09 Nov 2023 13:24:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a921e02000000b0034f1bb427dbsm4698364ile.60.2023.11.09.13.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:24:24 -0800 (PST)
Date: Thu, 9 Nov 2023 16:24:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 2/6] env: migrate env_get_default to call
 env_get_default_into
Message-ID: <20231109212421.GL6601@bill-the-cat>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-2-cb493bfdeffd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y57iz2aNFSVlTM5b"
Content-Disposition: inline
In-Reply-To: <20231108-env_default_theobroma-v1-2-cb493bfdeffd@theobroma-systems.com>
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


--Y57iz2aNFSVlTM5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:20:31PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> Since both functions share a similar goal and env_get_default_into can
> do what env_get_default wants to do with specific arguments, let's make
> env_get_default call env_get_default_into so as to avoid code
> duplication.
>=20
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Y57iz2aNFSVlTM5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNTgUACgkQFHw5/5Y0
tyzHxgv/b/DbVGdiXpAeChgUBLmB+eum3KyWLZuaoi6/RPTy4unNF1AiIZJSAzGy
0OPg31PF1bybw5Xmw3rHUn4Lik/82SMGxVps6jCcZhrJt/hrMbaOcYjYR3Vom5RA
BXhJPVGFdt0+Fu01rZh4gvWeV4BPpW0e+nTY7Cbzkwec+5EXGguCf10q2D9Agl8K
dU6XXfuLyLGEdep9Sj+M6cCG0++IuYL5/FTcIUfMn/UnxmqfwBsXZ0f4wRTdXL+R
NzvNPKX2Vb7K0r6qKXWKDM4/3gDwda0aM3uoMfx82hHd5HALN9mIVY6u4ePXxhUG
q19t0sJuaD2/3OfUpNKH6toSaEP54BhfsxSokOFZYlmHDnkka4Gl3Zbtn/xSATHR
NsgXJvMLjzc/Dxj99yfFLUbuswCUFa2+sWfronrXJkir8wR1KgxUmITxRXCN3Eel
YHMFzwd4TDCq9jJT9TIxnwxIdVu5fz70D3zKrb7MGjUKxPZb2/1tLlFAzkdyaCjY
9IRK2XSI
=lHuW
-----END PGP SIGNATURE-----

--Y57iz2aNFSVlTM5b--
