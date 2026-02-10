Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2598FEB26F6
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 17:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF9183A47;
	Tue, 10 Feb 2026 18:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aN7DDA9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F68383A5A; Tue, 10 Feb 2026 18:51:25 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09BCC8367F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 18:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45f171cb842so52084b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 09:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770745882; x=1771350682; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LRDntqSgnxZHu811+5Umi91E09MYsWw3QDYRBfkCEF0=;
 b=aN7DDA9u69b2m05cAj31wCgLX4/HQXHUBvFdC2/MqA8CtBMm4qU2wR1h2NEDS/jaJq
 LO/VII2ffkX5hIzKsR90zPoskwTa4UPgvaA3rH3ISNHMtwspY0VM7EBC5xGkU5dniday
 0CKY+ZSZqSBhCsHegYO9b0pGKjEnv5K3Sp+Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770745882; x=1771350682;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRDntqSgnxZHu811+5Umi91E09MYsWw3QDYRBfkCEF0=;
 b=QR5vMmJUk/fRtypo5S1XQGS4XZbSczcB7SY0R/d+wMr9yvtVB641up1Ig+KdVSsLXP
 XCJVEULUwZqPgKVzQnt8d+H3C6KZ6HumtB2r264wGHK5w8MLYN1FBzbySwC74nWJsXZH
 nv2vII4pNDvgOijSd6Cc3Qy7nIYjHWoXfPwHzQKMcJ4ISv4571nR+f/mT7TnP4RpFoAj
 jiuiJBkUW3Cjpdo5DG6sK65H1Wt2Zdf/6fA4ziP9KGkYj6X1tNHHgh6BndQ3i1d7qJ0+
 fzaGm8TPsIVOP0o6W45h7Gp19QYklWQo7s5+H7/F7uUO5i4FpXNpLdTv3k+MdKhbOgBC
 pAgA==
X-Gm-Message-State: AOJu0Yyo/Y3ZsXMok3wTry/pAYMoW/hjyJcjvhiO7ruixthQIHi+rlYi
 pMEjHkG3a/WnV/UDtY+I4I1o5rllfBXeUuudJLkcogKxeluyTEZ8yW8BuMUltAe3QkaSyV7i3BA
 HlnXBkzs=
X-Gm-Gg: AZuq6aJ1wvCFzIZC4jC5YnDe+EE/wHlfehTvpxs6QkBSpuv9VemFagiJ0CMafvAy2Zz
 9yhDn1+ScoMDSjsJ9N3YVdHWxTerForXqzS18ZYNSgpm3vWlu88lGEdj72oAvLgCIsbGf5M6MTG
 dFxV3+P+xFK2CFSex+C60WXDNClp/muTcVDccszsXo7+YZR1DtfZiqyfHLr4v71XrH50rCBLkWr
 gE/h5r8vypn/ew47+hpd2geDd7bTxemOlbRA+0pOoYFdfwNg3SbPw55gHodPvXTZmcSg72hMbBK
 VDW898Lw+ZNKpdDEepJ1Xc43P63Pyy0dU7GcCUh3Geve9pS+mbuNZm9Hcmu/G9xozAd4lArgRHK
 3e4JsW16rqw7g1PceVONU5ZFAYTFoSepDZv1PtjH19DRwIUgDoS4lvt4cuNq3hFB02IwL3rAqo9
 5iX5Hey8p+GkYkMpGjXPpWBcMIdO4Ou9VCc0xELN4E2p+xWTNXFfxAeUEq/JhzE7osSOg37lTNy
 wt2qiTrvR9LEW8HvKuGrGq0B4EirXlGO5/vx81UfPYM3lrv3FU=
X-Received: by 2002:a05:6808:bc2:b0:450:826e:5df1 with SMTP id
 5614622812f47-46352ae43d2mr1464600b6e.19.1770745881786; 
 Tue, 10 Feb 2026 09:51:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462feb4fac7sm8603932b6e.15.2026.02.10.09.51.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 09:51:21 -0800 (PST)
Date: Tue, 10 Feb 2026 11:51:19 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [ANN] Updating next to v6.19-dts
Message-ID: <20260210175119.GA2728096@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="coNDJZdr+gWSQTBZ"
Content-Disposition: inline
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


--coNDJZdr+gWSQTBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I'm planning to update the next branch to use the v6.19-dts tag shortly.
Assuming nothing fails to build/run in CI, this will be going in to the
next branch today or tomorrow.

--=20
Tom

--coNDJZdr+gWSQTBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYtwEAAKCRAr4qD1Cr/k
Cs/LAQDJy/ckTNzdfY0ynd18wqDCyVEsI6YJlBmbDuEiatlmnAD/R26xHClKhO0P
CX0kcTWocy/NAYx7ADpzrgCXibUKHA4=
=5I35
-----END PGP SIGNATURE-----

--coNDJZdr+gWSQTBZ--
