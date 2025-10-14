Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642F1CCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 22:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D61880107;
	Wed, 15 Oct 2025 00:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TtVoPR/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A62807B1; Wed, 15 Oct 2025 00:03:59 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FAB800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 00:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c111bf9f38so1043491a34.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760479436; x=1761084236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qNI/wj3Jyq+dK0Z4gcwwBWz/Kp3Wm/3AMHgwpsOu56Y=;
 b=TtVoPR/phis2hTd5L49OhkYC1s/L+y2D46s8Jv0/mh8C1g1LT8/3GnrUX7BnqeuyWm
 u33FcWm4woOr/OEWQwkM3doWiZMzWnGcdlRNEBiQdbAwzxk953Irkn2SFtCEgGf6Ch7I
 tGGEfRD6HP6F0H1P3QpDk6Ey7HpREsL5+ab+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760479436; x=1761084236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNI/wj3Jyq+dK0Z4gcwwBWz/Kp3Wm/3AMHgwpsOu56Y=;
 b=bD8/AUttjVicSBur9jGyHYlwwOSTCEPucYfzIG1uFYyyzPcasUHnDIJuK//7Z92Ul0
 /66ELEu5PvZjDejhyT4vaiewggyi6OGXXCYrGoc/UoWBbTFxtJUU6FE6vuiH0FWCB55f
 8P/qIsSsid8eKGOVPasNoPsomu2kB/czLzSuJekwhbrhoTyfX5xGeu2wL8J99MaZLeeu
 vXCMrTlX4JjhOGJm3Io/HAqv8wBiy/UMonexuXuFkEpwj4rQA5h79A6nxuwl/rWqVcbr
 3CDErs+j59VIV0Kd9uJ8Wl9kcE26fN9la6m61gqovUSbLkSXGL0PX7IuGpQmr9S4JzV0
 yfSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+lzY9xSqxQyOlzaqtXdf3RNp9mhpL+wY22r2MHdFh9Bzz+XYW9+BDgnf3GB7oVuMecfZrFI0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy12sBMNEMTk6NYGbCfpwhB1RBGKcVMDeG01v7vVqhg4+71mJ5p
 zMpUeEXMi6szDATiQV+2h9bn8E2c9svDqXSzj1ekKwB6ffUQqURGTYbG6Mu7QXw+B30=
X-Gm-Gg: ASbGncvC43O40H6LwvZeCD3VrLYuXJ9y8i2wVT0jpPFkPvA/w4ql+z05HLYEUqjoElX
 MIRIx2WoYvQXICW5I8xAGjhKK/slSRiqOgMucu6NCXLx7BTTcUgSL/fxAZUwy3t8lwv0Y4nBekl
 u26QzvqtqD7f4gB3Vi+MCClCYfmZIxryCcdahgXhldNYb0mGZSg4uWNXLc2CAfaVptwARLuVF/Y
 6J3Ley/ZARBCNlkFPlZ8DImjZCTi3x6RSCLVmvH8VY3zXx0rGE6KaepLUyxjFD4VU7lAQHo6Lb8
 foeohtYDolJ0GDxM5/Rif4ghKjNy1CL5Ev8WYdco1+o2nTNJEzIiGJDJ+EHebAoHxUDGiUfe115
 cZ5ZHM9gs20SvOUoM05mx8sESlpDIhdzVXHE4n+4qSx0U/nla8N4ipkbUrCx+aW2FQyzpzq40Hc
 yC9YCiuJujE3Eq1+U=
X-Google-Smtp-Source: AGHT+IF9NN/aMrpGZhtpTRrEjj4CsrneKqr4LoYbyv05SK2H44vca3qC1HTTZRwrBjhqkUHgZ4W0CA==
X-Received: by 2002:a05:6808:180a:b0:43f:9caf:6455 with SMTP id
 5614622812f47-4417b43fa6amr10746171b6e.33.1760479436034; 
 Tue, 14 Oct 2025 15:03:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-441d26237dfsm2055064b6e.22.2025.10.14.15.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 15:03:54 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:03:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
Message-ID: <20251014220352.GA338016@bill-the-cat>
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VXWR6yGG6Z/COIaE"
Content-Disposition: inline
In-Reply-To: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
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


--VXWR6yGG6Z/COIaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 06:54:17PM +0800, Yang Xiwen wrote:

> Currently U-Boot clk framework mandates the sequence of registering clks
> to begin from root, and then its children. This is an addtional
> requirement that doesn't exist in Linux kernel, which makes clk driver
> porting more difficult.
>=20
> Let's handle this entirely in clk framework and give driver the freedom
> to register clocks in any order.
>=20
> This is done by assigning the parent "lazily". It will cache the parent
> name in the core clk struct and try to refresh it when clk consumers
> call clk_get_parent(). It's transparent to clk consumers as long as they
> only use APIs provided by clk framework.
>=20
> I've ran `ut dm clk*` and verified these commits does not break any
> existing testcases. Though no new testcase is added because I think
> existing testcases already test the logic very well.

Sorry for the very late review. When I build this on say
rock-4c-plus-rk3399 this is the size growth I see:
            rock-4c-plus-rk3399: all +228 spl/u-boot-spl:all +500 spl/u-boo=
t-spl:text +500 text +228 tpl/u-boot-tpl:all +552 tpl/u-boot-tpl:text +552
               u-boot: add: 1/0, grow: 1/0 bytes: 228/0 (228)
                 function                                   old     new   d=
elta
                 device_reparent                              -     120    =
+120
                 clk_get_parent                              56     164    =
+108
               spl-u-boot-spl: add: 4/0, grow: 1/0 bytes: 500/0 (500)
                 function                                   old     new   d=
elta
                 uclass_find_device_by_namelen                -     172    =
+172
                 device_reparent                              -     120    =
+120
                 clk_get_parent                              56     144    =
 +88
                 uclass_find_device_by_name                   -      68    =
 +68
                 uclass_get_device_by_name                    -      52    =
 +52
               tpl-u-boot-tpl: add: 5/0, grow: 1/0 bytes: 552/0 (552)
                 function                                   old     new   d=
elta
                 uclass_find_device_by_namelen                -     172    =
+172
                 device_reparent                              -     120    =
+120
                 clk_get_parent                              56     144    =
 +88
                 uclass_find_device_by_name                   -      68    =
 +68
                 uclass_get_device_by_name                    -      52    =
 +52
                 strncmp                                      -      52    =
 +52

(using buildman's 'bloat' features to report size change). I'm fine with
the growth in U-Boot itself, but that's just too much in SPL and TPL and
we need to figure out if we can avoid that somehow.

--=20
Tom

--VXWR6yGG6Z/COIaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO7IwQAKCRAr4qD1Cr/k
CkkPAQCX7Z46UkH5b25tMjYULzg0jARieHu7D5wODM6LsCKKLwEArF+hswUFMZGt
H0+yXT1EnFF/ckF2BSyGevY8xWsXhAA=
=2hxD
-----END PGP SIGNATURE-----

--VXWR6yGG6Z/COIaE--
