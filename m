Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81324C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0762878C9;
	Thu, 25 Jan 2024 17:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a08cjhdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 490478785A; Thu, 25 Jan 2024 17:15:11 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BB787C0A
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-595b208a050so4044981eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199303; x=1706804103; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/81WSf5lI5owCqBYumgqLnSFFSlhnk1KvdzVInSt1ys=;
 b=a08cjhdceXc/yD4SsaBTveQ4zgmrm8/uGThDGJYkWKtW9S5YY96W3GxMOdCc+rC/Ar
 aKE68+z0zrEQCyFQx3VV0TIr+SAlMLmXmhsjYiF9FlFQo65sH1CsTH1vPYzgmzgw4xI6
 OcW+SKBV3UYo/0Hvh5xroy6tB0Vnru4GPNkro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199303; x=1706804103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/81WSf5lI5owCqBYumgqLnSFFSlhnk1KvdzVInSt1ys=;
 b=als8t+PltynPBELGKcQfrjoow3Nme8vtR8ARaOd6jLRippnX+2MCP+MfU6n0wmS+aq
 7RLwcRanCs42Xv/3f5XxZSqHwjgDq2jTGczYQmj6L7/CnY0KX0cuZLhjqI6Zt9IhXO1u
 HtNi6e9yNcZI4pQqhZhZs0UXhqFQWeItIep5xUxrKRl/Yl46TUm7GPqx1Bf2IAVDRCjH
 1bSNvy3y2hGpbGrmdpq2o7x3qh43Hy8gD+92ag/qBy8W4IcQ9XOOlkDZexagrXgwTnly
 jCCrM95R17dCXLzoh+QRU3yH9DY9H3vdAnHVr0EkCsZKKGhNZum/ar3+rOB6iDiHC43i
 F9QA==
X-Gm-Message-State: AOJu0YyyMKVTNSedzmKiVp0cCrt1mTh1Uj7efuKs9Z/+z2ImZlrHrZ9X
 UlhDTbUNrcSRJxJTC3FsRnAc1t14BSJh/Pixp8WqIfLeLnKDm3CD6pFq2PW6rh8=
X-Google-Smtp-Source: AGHT+IFP29tB++aLc8WHEtmT6MQI70yM1iaIXKHdxojCd5o7qS6GC2l5/Gu9c3kgfCdWl4CpGiT2aw==
X-Received: by 2002:a05:6358:15cb:b0:176:51d2:802 with SMTP id
 t11-20020a05635815cb00b0017651d20802mr1714275rwh.1.1706199303197; 
 Thu, 25 Jan 2024 08:15:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 u141-20020a0deb93000000b005ff56b2b690sm755638ywe.137.2024.01.25.08.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:15:02 -0800 (PST)
Date: Thu, 25 Jan 2024 11:15:01 -0500
From: Tom Rini <trini@konsulko.com>
To: forbidden405@outlook.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] reset: reset-hisilicon: also handle #reset-cells = <2>
Message-ID: <20240125161501.GX3652023@bill-the-cat>
References: <20240119-rst-v1-1-894c88985f5a@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dlElkC3tYt1eQ58Y"
Content-Disposition: inline
In-Reply-To: <20240119-rst-v1-1-894c88985f5a@outlook.com>
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


--dlElkC3tYt1eQ58Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:49:17PM +0800, Yang Xiwen via B4 Relay wrote:

> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> It's also valid to have #reset-cells =3D <2> while the third arg defaults
> to ASSERT_SET.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Applied to u-boot/master, thanks!

--=20
Tom

--dlElkC3tYt1eQ58Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiQUACgkQFHw5/5Y0
tyzN9QwAnLf8LC1rB49j/S3GmXe1VKOp6AW1hUF5cURzyACYzBlIYN4MqFbHZ4mX
ZcMxQNA0+dytIFQVXfDfnl3ayNtKoTjHOl7xM9jzuqXsFxVm8JlRtmO7M72I3uSD
zIdGbianv8MDP7BGqfb0PPOyRL1HW+JMYdnPeZZDg9fAZvufFNObZL0W0B1kL7s8
uSU0gPGTU7dVySt1IwWSN77qPIgi6NPFqRud1mQV3d8YoGr40Is5RyBIYuam9qbA
ey/dZysBYVvjEFaDaDHHsKFGImCumXZaZ1a3Ugdlv5F+vvsxDEywivK34bFfjgN1
0LeDQ/pVsmH0czpG1FmSm7+sir5C3DO8wFmDyS85TLUjb12si/lFOgZtnQL0bVLp
u6uN6ul/sZ5dFg8zhfEDkFwiRfDpbmOCfpBQ9R3ESPylbI/d2DCpz9bbTHRxaHuP
PGvThXG2hol3SGErsfToNFDDrTd1Cu2hk77AFNeqqndUew/oTa/HVMSqg9jmYwld
/Xckrg40
=W7r/
-----END PGP SIGNATURE-----

--dlElkC3tYt1eQ58Y--
