Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC94EE0211
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 22:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CBD86D80;
	Thu, 14 Sep 2023 00:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sqQtg3lz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59EF886D43; Thu, 14 Sep 2023 00:04:11 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D6886D28
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 00:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58dfe2d5b9aso5034017b3.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694642647; x=1695247447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/KxfRz+7QkvwEhWzjX62jcPgvGNwqtelFSfgKOKNco=;
 b=sqQtg3lzsWwxTQWqYoBEI85Umh1/4g6UvQi7rchW/LV6HiVDEvRGW3LUcqhCs6c1y1
 Ak7CQG1ytm18DAuOXLYOyON6SSu8wC56ywTHJ4tRBaYO+p5PzbR9EAXZORlyNZvc4p25
 jLvmrWtZjfml/UsDrQftMYhKOU9x9c7vvk59w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694642647; x=1695247447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/KxfRz+7QkvwEhWzjX62jcPgvGNwqtelFSfgKOKNco=;
 b=Videh+9igZpbaV8tefOIvDU9j1LBNJEfz7nf5oWTAl8VNjZK8clKnehpCZ73ly6Dn7
 q6Nucy+i8QG5Qa8Lc0G1eY8+P+if87lsCE8D5A8Zqz1u5kw1S2BbYEh6U6VLCes1Lee9
 7Q9fsUxsW8FSWEPaJZVr5Cbc5uz497cFI2vwE8paTXHiRyk35a+Iez3ZloUOmz9Kbjyy
 V822nGrCyADCsPtTql2poLLlkke5eScr5MXwUwnFT17I+0d+Vi6DlFwkOAdHP6uW6pmx
 i0QQoPKO5MBO8H0zCmdRwzcn4ZfaQT6hT+McAASFPNTjKEmQy1ZoOLIODc43exzkfFYF
 w2QQ==
X-Gm-Message-State: AOJu0YzoTneOetxlSQtJmeZyxlnLbXuEmiJDTLlhFUUWjnXaYETCORoV
 sIiHwxh5edPde9XUMpeWO1RXxw==
X-Google-Smtp-Source: AGHT+IGD3UN6yZ3jDLuuLUPVR7e3i0Bek7+sgBqEDKDc0QPqO0VyI+0TKA/kcGEQvokTxq3ez7RJ2w==
X-Received: by 2002:a81:4803:0:b0:59b:5255:4882 with SMTP id
 v3-20020a814803000000b0059b52554882mr3739ywa.20.1694642647605; 
 Wed, 13 Sep 2023 15:04:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a81a112000000b0058451c12076sm8634ywg.14.2023.09.13.15.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:04:07 -0700 (PDT)
Date: Wed, 13 Sep 2023 18:04:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2] net: phy: broadcom: add support for BCM54210E
Message-ID: <20230913220405.GT305624@bill-the-cat>
References: <20230805141008.25550-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m/DGJCMaQC9EcsYD"
Content-Disposition: inline
In-Reply-To: <20230805141008.25550-1-marex@denx.de>
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


--m/DGJCMaQC9EcsYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 05, 2023 at 04:10:08PM +0200, Marek Vasut wrote:

> It's Broadcom PHY simply described as single-port
> RGMII 10/100/1000BASE-T PHY. It requires disabling
> delay skew and GTXCLK bits.
>=20
> BCM54210E support ported from Linux kernel commit
> 0fc9ae1076697 ("net: phy: broadcom: add support for BCM54210E")
> AUX/SHD/bcm54xx_config_clock_delay update ported from Linux 6.5-rc4 commit
> 28e219aea0b9e ("net: phy: broadcom: drop brcm_phy_setbits() and use phy_s=
et_bits() instead")
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Applied to u-boot/next, thanks!

--=20
Tom

--m/DGJCMaQC9EcsYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCMdUACgkQFHw5/5Y0
tyyN9wv/W+cd4AYkw+tOLoyoKBIwLmlet7n5GeBNxo2v+1Fs4bjywHDGbxFLLMrA
rGw6zzNEyLlPflqzIlifnfQnZdHjPnXcZgNDNfKtal/Mvq9Hfcg9T0G0xwQ2F+Fz
9O+wpvc3UXokwnqrajKE9Ld/jYLlW5bC9ZYPctKlRqouv4vMqzimCQJJmnq1bMUV
ZRLwP+Q0rEJuo0BtyuOZs/6eWbAjwaV4qXRHavPMvTjdjo4aCY6sWWIeGKhAdOiG
ps8vJiRKQyiGZrFN9WKWXUx3CwswG6H8n/DzCI/t8ZDmquv/PSJnZJ1VbbZ3ElKS
6rffjaCUsTstFb71d3VrblUeGUn0BGdoAiOa5/2Y9Xjpx5J59iVK+Mic0wk92XoN
ZutRyDIkpUVSWtNFb5WwbRj462bEt41x/jIMQGNIuKap6qeHJTXCjmbIi28Yej+T
d4rCmc9XFNZhQ77maFJlhbhRPAmdcBLzHTQhyPPTwt0Pd9REAcJ6+9pLX1BWqLFB
yP+vaolo
=9NO6
-----END PGP SIGNATURE-----

--m/DGJCMaQC9EcsYD--
