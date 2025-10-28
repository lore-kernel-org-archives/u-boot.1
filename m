Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B559CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B88982E34;
	Tue, 28 Oct 2025 17:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rTcOzCtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447FE83623; Tue, 28 Oct 2025 17:01:42 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1782380422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-44db46b5f22so1519984b6e.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761667298; x=1762272098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kIvhAiUVjzYsvgu0Jfi2K+BnGkawoKxr0Csws8AtA+c=;
 b=rTcOzCtdNwYbXqmYttMnMTmU7dJs0hMPDkI9KbYqKR7iprFpcwvOxze0xLPR35zEUc
 LczjxbNu2QguCne0jjsIut1uQwBbyK4RvUT7h1n7bu7qQyV1ecSfz9bvtjirO1PwAnsH
 y1VkATkcAxS9gl+mb7SYddFuTSFMxD5DFw7MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761667298; x=1762272098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIvhAiUVjzYsvgu0Jfi2K+BnGkawoKxr0Csws8AtA+c=;
 b=dbMiWN0LXW1qgFtc28me+x1V4Jy+aRY7bbNovThWxz7stzusMQUnoLghAs6VCEpSUs
 PQuogIt1CLQ1wB1BunPawo/vYliY8b9qscUBJ6HSP2rzsqEz3lqOmqTn9v7OrJWpwi7P
 y3y/nF4+bzvCUp1X34lwzf2OzvsEjz/HDeTmi/uicOdC6DQT2icP19NaK6aWI3JjwFaX
 DkHtAqyUpeqCFzh3kfKWOM8RSlNUxnCtHClTCOmc0MHY8GUYMrX8N1lSG+/PFN0DprbA
 uY/D77U6Kei0Qrn9DEkhrvXyHi0IHLIi9O/TNe8Px2XKiENv39Ld3BKamBcMVA4ANRxE
 o39Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6YjdWd1GozFSaV7a0IitCdoYjWRudg+nhs3uUPqj2h37xWVCnVp2suO5L07rGpuvsX17grgY=@lists.denx.de
X-Gm-Message-State: AOJu0YxqoLDjP7uDOiuUYYEinGGySFa6t+ynnCupjJuFr6QGIo7R+m2C
 awJpfajauGP5jqTj7nc9j3vcVTkLpWSD+1csgsuj8k9OM26j+FukIoayC5fAAe2lAnS19j52oQo
 lwGrHoK1ENYxN
X-Gm-Gg: ASbGnctGWnMADWWutBAH9PSiBp2Xa2qWXas3mFwdHvviBM9A/8x3JWN4HkRaRke8+H6
 SOapm9VbaMkhJkCpdn0mPS78JmOaMPrQO+Jdma+rZPnmjsmCn82pnw/5xBoUhJOiLIxHMhG7mjM
 0ybaVd6LTmqTxVPylyqL7sLtoyjKygOSXZnTlI0FtE/tDC33DdsblX5B0e2qH8tPTOOa3sEC2hQ
 q0v9veezLtTAi85ONkuAGwlgrDFf74d5H6Y0aGZeK34AJ1nTxvZgfMFpO7AiR7TgkbrYzZa2bnp
 81iuIp16qiGyowtvXkWM7e/u9dfiS3ZgYaVVWF8yOB8O7FEBk+dziHLmcmf85/Y4TSxXnK/ZP0F
 uRKId5YhwH0DpEEKC6vbhQLWPN5jGx44zUxNSluhB5AUIYuB/JrfajCP31G4d26p+TdG+Jdf3UM
 3vhGfG+yISi5HG0T6JLqe4dT4gsjK3YAhhQd8Kwa8=
X-Google-Smtp-Source: AGHT+IG88mBksPdTVn8ryc5brSZ8zq3w1H8EEfDtQUzxBkvjinWWyS4aMhW+waR/4mK9HJMq2IbG6g==
X-Received: by 2002:a05:6808:2516:b0:43f:7287:a5ca with SMTP id
 5614622812f47-44f6bb052fcmr1487730b6e.43.1761667296962; 
 Tue, 28 Oct 2025 09:01:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e93e0esm2668683b6e.17.2025.10.28.09.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:01:36 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:01:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
Message-ID: <20251028160133.GF6688@bill-the-cat>
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
 <20251014220352.GA338016@bill-the-cat>
 <SEYPR02MB5557BC90C2AFE76428B73A3696FDA@SEYPR02MB5557.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FRMwCyo2B76Togrf"
Content-Disposition: inline
In-Reply-To: <SEYPR02MB5557BC90C2AFE76428B73A3696FDA@SEYPR02MB5557.apcprd02.prod.outlook.com>
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


--FRMwCyo2B76Togrf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:49:43PM +0800, Yang Xiwen wrote:
> On 10/15/2025 6:03 AM, Tom Rini wrote:
> > On Sat, Jun 21, 2025 at 06:54:17PM +0800, Yang Xiwen wrote:
> >=20
> > > Currently U-Boot clk framework mandates the sequence of registering c=
lks
> > > to begin from root, and then its children. This is an addtional
> > > requirement that doesn't exist in Linux kernel, which makes clk driver
> > > porting more difficult.
> > >=20
> > > Let's handle this entirely in clk framework and give driver the freed=
om
> > > to register clocks in any order.
> > >=20
> > > This is done by assigning the parent "lazily". It will cache the pare=
nt
> > > name in the core clk struct and try to refresh it when clk consumers
> > > call clk_get_parent(). It's transparent to clk consumers as long as t=
hey
> > > only use APIs provided by clk framework.
> > >=20
> > > I've ran `ut dm clk*` and verified these commits does not break any
> > > existing testcases. Though no new testcase is added because I think
> > > existing testcases already test the logic very well.
> > Sorry for the very late review. When I build this on say
> > rock-4c-plus-rk3399 this is the size growth I see:
> >              rock-4c-plus-rk3399: all +228 spl/u-boot-spl:all +500 spl/=
u-boot-spl:text +500 text +228 tpl/u-boot-tpl:all +552 tpl/u-boot-tpl:text =
+552
> >                 u-boot: add: 1/0, grow: 1/0 bytes: 228/0 (228)
> >                   function                                   old     ne=
w   delta
> >                   device_reparent                              -     12=
0    +120
> >                   clk_get_parent                              56     16=
4    +108
> >                 spl-u-boot-spl: add: 4/0, grow: 1/0 bytes: 500/0 (500)
> >                   function                                   old     ne=
w   delta
> >                   uclass_find_device_by_namelen                -     17=
2    +172
> >                   device_reparent                              -     12=
0    +120
> >                   clk_get_parent                              56     14=
4     +88
> >                   uclass_find_device_by_name                   -      6=
8     +68
> >                   uclass_get_device_by_name                    -      5=
2     +52
> >                 tpl-u-boot-tpl: add: 5/0, grow: 1/0 bytes: 552/0 (552)
> >                   function                                   old     ne=
w   delta
> >                   uclass_find_device_by_namelen                -     17=
2    +172
> >                   device_reparent                              -     12=
0    +120
> >                   clk_get_parent                              56     14=
4     +88
> >                   uclass_find_device_by_name                   -      6=
8     +68
> >                   uclass_get_device_by_name                    -      5=
2     +52
> >                   strncmp                                      -      5=
2     +52
> >=20
> > (using buildman's 'bloat' features to report size change). I'm fine with
> > the growth in U-Boot itself, but that's just too much in SPL and TPL and
> > we need to figure out if we can avoid that somehow.
> >=20
> I'll make this feature optional for=A0 SPL/TPL, but would still like it t=
o be
> always enabled for U-Boot itself.

Sounds reasonable, thanks!

--=20
Tom

--FRMwCyo2B76Togrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQDo2gAKCRAr4qD1Cr/k
CinoAP9RyLKoVBNDj/+plnp0YJBYKnDFS5pQh07EI9mhG5Lp9wD/SyfjP93yPnil
U8bYAvHI1sIs4WxIozJGMA7Ot6SkpA0=
=wCOv
-----END PGP SIGNATURE-----

--FRMwCyo2B76Togrf--
