Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427F2CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 16:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90F1801DD;
	Mon, 18 Aug 2025 18:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AeiVjxgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92983803DF; Mon, 18 Aug 2025 18:53:15 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A5DD801BE
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 18:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-74381ff87fdso2475387a34.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755535992; x=1756140792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PYk/fXJEKqyeR7syo/ZhgFsxVvyyb85eHWKtl3p2de4=;
 b=AeiVjxgjdfi0Y1eV+1I5Zz15lTQKM4jJRWkn4pDszIGRRPQp1q5w1apFQqdLgVYG7Q
 IvSTjStRT0FWDLLD7LxhsbkLojn4g1IqSYbHXsQazBNETOGOT/63adOUijN64mD9tIGV
 xsPeckNmpjFPkguvf3VaWYWEooTj+ZhzPAja0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755535992; x=1756140792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYk/fXJEKqyeR7syo/ZhgFsxVvyyb85eHWKtl3p2de4=;
 b=Lk3Z5AHxUvCkkxBSufwSRXBrH2oHk6tACw3CWBgDjfK3t2fR++4ZknTnHDLrmwJ4me
 irCF9hcDjpb2CKBdwQ9Sb/wYdWaA6IvRMydu3+whcg6V5VEt8oQQFFMQ+yCyZuAJgi7D
 LSsvmMp5BJ/jJwTM4jWnSZykQHbXX5xQO3HyO6khIvuLfnk/eYEG/b7NoBPPi+fpwLZR
 6Cr6sxuRA/RA3OU4p1p2Srl7/e3amS5bu7P4kAuI+TjIushGR7y2KrCC1/vFiLdA7uoX
 /gs6EuLKjtn8LTjGVmoAfBiK976m3SKO/gucD/pqzbUNFTNgj1zY1IIUbX9nLJnx+u0B
 O7uw==
X-Gm-Message-State: AOJu0Yw8i9v4x+4nq1WmCPIYpBJ9oyq72WIVRrrgeZThZTxXI0DmeOBp
 y9cNCNrloYo6TBdwPfIR4JNPkn68BbGXiFlKRDY8mWjnIW3bY+7vapHDhRYREfhVrjg=
X-Gm-Gg: ASbGncuoG2xIemPqLWHoPGYZpxYE5NHJEf/CdiEZUIuHRMtvQZSo8Kq5MHwXUfaF+jq
 EUnf5rmACtLVltmWgnUqmuT4YF25En23CzMFx/+yt3duCPNMzWtq3HA82hYrbcQ63TajxPLSPNM
 GFdwYNYYuZ8RGZKLdJhueAyhml2pvUhbdqd9iBhz8wYIvQ2RrobY9dHJPiwQ49XC4HTQbWJCJKt
 54wb87H2PJ9wuAj3/0CAKWjHe31iI30hRiJ5GnSYavgd5/1vSdOQhPn7fgTfc8jyFrBUxcfrm6d
 1ns+48KIlit3M6U1ucox7vRlUR5EzyO3G+VkYxQbfJeXTf0n9FpTe6ujeg5gz8eCdX9fP6NuAnk
 O8kWTlsSga90GfSJT+FM1HP8As0+2h9O+gFy0JOxiOBTHYuPh/9a222RSlOBxGevzyKA=
X-Google-Smtp-Source: AGHT+IFXG/x70K0fbC63IEG0slfUYHWRpQRtMdmEW8wbf/zcAT1DC3n625+FV9y7vv++0EUOZoQEbQ==
X-Received: by 2002:a05:6830:61c8:b0:741:a0e9:58fd with SMTP id
 46e09a7af769-7439239c534mr7853732a34.3.1755535992105; 
 Mon, 18 Aug 2025 09:53:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-743919da9dbsm1925860a34.10.2025.08.18.09.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:53:11 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:53:09 -0600
From: Tom Rini <trini@konsulko.com>
To: alison@she-devel.com
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH] sandbox: fix linker error for SDL build
Message-ID: <20250818165309.GZ124814@bill-the-cat>
References: <20250817234940.3023378-1-alison@she-devel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wP60lWgQkrXGINjU"
Content-Disposition: inline
In-Reply-To: <20250817234940.3023378-1-alison@she-devel.com>
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


--wP60lWgQkrXGINjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 04:49:40PM -0700, alison@she-devel.com wrote:

> From: Alison Chaiken <alison@she-devel.com>
>=20
> The patches fixes the following build failure:
>=20
> $ make sandbox_defconfig
>=20
> $ make nconfig
>=20
> Turn on SANDBOX_SDL.
>=20
> $ make u-boot
>=20
> [ . . . ]
>=20
>   LTO     u-boot
> /usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
>     `dm_test_video_bmp8':
> /home/alison/gitsrc/u-boot/test/dm/video.c:415:(.text+0x16bb): undefined
>     reference to `sandbox_sdl_set_bpp'
> /usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
>     `dm_test_video_bmp32':
> /home/alison/gitsrc/u-boot/test/dm/video.c:507:(.text+0x189c): undefined
>     reference to `sandbox_sdl_set_bpp'
> /usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
>     `dm_test_video_comp_bmp32':
> /home/alison/gitsrc/u-boot/test/dm/video.c:543:(.text+0x1a7d): undefined
>     reference to `sandbox_sdl_set_bpp'
> /usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
>     `dm_test_video_comp_bmp8':
> /home/alison/gitsrc/u-boot/test/dm/video.c:563:(.text+0x1c5e): undefined
>     reference to `sandbox_sdl_set_bpp'
> /usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
>     `dm_test_video_bmp16':
> /home/alison/gitsrc/u-boot/test/dm/video.c:437:(.text+0x1e49): undefined
>     reference to `sandbox_sdl_set_bpp'
> /usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o:
>     /home/alison/gitsrc/u-boot/test/dm/video.c:461: more undefined
>         references to `sandbox_sdl_set_bpp' follow
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:2029: u-boot] Error 1
>=20
> Signed-off-by: Alison Chaiken <alison@she-devel.com>

Ah, good catch. Looking at this in more detail, the tests are driver
dependent, I'll go make up a patch in a moment.

--=20
Tom

--wP60lWgQkrXGINjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKNabQAKCRAr4qD1Cr/k
CiJHAQCBzv1VW42QP2scPVTf1C5c8IDZNcDKMC1E2TxvyU85/AD/Q6xAo88Htu5l
TMm2wipPQudg3YMpgjQnwXIPtYEGnAw=
=iDUL
-----END PGP SIGNATURE-----

--wP60lWgQkrXGINjU--
