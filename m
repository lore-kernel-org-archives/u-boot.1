Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5FACAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 20:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C2182C84;
	Mon, 15 Sep 2025 22:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="so4LRRwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8221A8344E; Mon, 15 Sep 2025 22:38:34 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E1781E13
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 22:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-331503fdc51so895236fac.0
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757968711; x=1758573511; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fn1MW8CjA3NgNCXCNduTR0ACoc3OLRM9xA0i64VEngQ=;
 b=so4LRRwlHkd4jr60sX3dXFqbiGEfov8fIe6mUt03uuysl+8a1XPYU5Wh+9YMXV++4A
 hb5R0st4aUOuwFcUnxDXxZ3wYC75mykOqZ65p+Z8XhjzPwHeag3V9nZ+GyI+oMeb5e33
 uHdVUAk+4YMRbmQECwxtNHh674uZkMdE4HumU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757968711; x=1758573511;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fn1MW8CjA3NgNCXCNduTR0ACoc3OLRM9xA0i64VEngQ=;
 b=ZWCW0IR//dXXPI4f/nG8U3yyvDHpg2i1QT43tRUm0fvj1TLb+13x6x2kYw2MRamw+R
 nFawIp24k7vOkgkXNuTvIey43ulk7iWvNKiG/za7UshiT1on6GldmJMjW+WSTVbnmgt8
 imhvMJ2zt1GeYJ+FNZp56xnkcQoRFHDzh3xVHnnDgZgWlRrjUiS1qtLS22BqNS1+CJMd
 T04lPDxdpS34teMjnjwWbXWqycczBkRJV8zhPar4HTFTh58maI5tcgOtmXY4rG3ljxA0
 uxEqtqZh8BT4nri0x5EKgVflOmJ2+Na2YU2pjdubD8fqzfmUgIxiNExd++MDNhciuPEU
 UWEw==
X-Gm-Message-State: AOJu0YxkmdG0wWNxGn8QJN+QBhErfDZmzirT1N2EnSzq3bShqXSCQbcK
 eO1kBpAEmUxzMzWfyyeuFb2SpCn6PMcr3Hl0jRVDd5tlj+76D76ZLjSz+OR6HILjs8zl9YVvLJ6
 1bqF2X7c=
X-Gm-Gg: ASbGncv4CEWXximn0xt8sLLUvKjgsCV8ht2VcXfytpJpv4KGSgLnBXbJDBUqDT2fEtI
 GMI5bp/fRV0UkyrUGSaXth6jrIZ3+1TSpmDjF/vzDJ+MkRjaEkrhDBRcHPlB2izBNMWc0e7Uaw8
 VOlty6oF4xropbattebSw+OKJK9CCig0VbAG5a57mbzxOYuYQrEEZvTDulT6gOxG9Ls2MYibn96
 1OwMSOYBFS+yaItr6mgiKtQDB9uwiRf6h+tDiXStkIkHAmdpkWXGam/yoBDsBxhqLqi6z9s8q2z
 WJiR3ehp1JAKEDlE5UPqt5VwykXAd376s+oGhN4FzMWtP1yEna2IjyDbqC8A59A9LlUYqVFBWxX
 u75Vx1ZtOxuCOPPR3h72ud19r1WjByMqM2xGZmyqx425BQMWuJbvRGSi2e2TAspCyKtw=
X-Google-Smtp-Source: AGHT+IEkI3lS/6txcpcSoYn2gYcKlgg6gwYJheg5hePV9EfHFQ305dpRHe6OdfvqdHFAO+gZlvzsvA==
X-Received: by 2002:a05:6808:13c2:b0:43d:2218:5e3b with SMTP id
 5614622812f47-43d22186b32mr3010308b6e.4.1757968711019; 
 Mon, 15 Sep 2025 13:38:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b7d83b68sm1291310eaf.26.2025.09.15.13.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 13:38:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:38:27 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dave Purdy <david.c.purdy@gmail.com>,
 Ion Agorria <ion@agorria.com>, Jason Cooper <u-boot@lakedaemon.net>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Luka Perkov <luka@openwrt.org>, Luka Perkov <luka.perkov@sartura.hr>,
 Michael Walle <michael@walle.cc>, Peter Geis <pgwipeout@gmail.com>,
 Phil Sutter <phil@nwl.cc>, Stefan Roese <sr@denx.de>,
 Stephan Gerhold <stephan@gerhold.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: Continued need for ATAGS-based booting?
Message-ID: <20250915203827.GN124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JXwGFPJYnyN6HgtC"
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


--JXwGFPJYnyN6HgtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As part of working on cleaning up documentation, I ended up seeing just
how few boards still enable support for ATAGS-based OS booting. In fact,
the list is:
brcp150 brcp170 brcp1_1r brcp1_1r_switch brcp1_2r brsmarc2 chagall
dockstar dreamplug ds109 ds116 ds414 endeavoru goflexhome grouper
icnova-a20-swac iconnect ideapad-yoga-11 lschlv2 lsxhl mocha mot n1
n2350 nsa310s nsa325 openrd_base openrd_client openrd_ultimate ouya
picasso pogo_e02 pogo_v4 qc750 sheevaplug star stemmy surface-2
surface-rt tegratab tf701t transformer_t20 transformer_t30 x3_t30

And my question is, for you board maintainers, do you still need to
actively support booting such old Linux kernels? Or can we disable this
support and then possibly be able to remove the underlying code as well.
Thanks!

--=20
Tom

--JXwGFPJYnyN6HgtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMh5PwAKCRAr4qD1Cr/k
CnBuAP9SfaquGWL1rN1BkQHtjx5ZhFpuwMlFymob79VC7dTPqgD/a+f0MXQVhmin
3q3EiTbpzG8vC14GwoBppwiv0Cb2wgY=
=933n
-----END PGP SIGNATURE-----

--JXwGFPJYnyN6HgtC--
