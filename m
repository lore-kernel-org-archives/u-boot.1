Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AC1C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 23:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F4D82CBB;
	Fri, 20 Jun 2025 01:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ETR3bta4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F21A82CDF; Fri, 20 Jun 2025 01:06:48 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457D180C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4067ac8f6cdso938346b6e.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750374404; x=1750979204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q7uKaDGxmto4p80MnbvvELSMYgPJbWP6cg7YIklJWUo=;
 b=ETR3bta46+KSrP9eD5w6OGge+nJbEqM7427XbSFhSH6T1J4h5wHHDGz0EqFNWFbm3i
 m1ln6D/GitxqiHKPUVUU4ON0doMynjE9XsFO/zXvyahEaz/NiSp42iNjXGiBWrfNBVU8
 V6BQlNZZoj9myV430UkdyZVKhEViVtmMWUknw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750374404; x=1750979204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7uKaDGxmto4p80MnbvvELSMYgPJbWP6cg7YIklJWUo=;
 b=MahkbAZW/9+V7nIUGNR19xyQO5jqPe1pdW90tfAfQuzxIO2JaheCP746JKcZk8gEhS
 TGCt+VXmDecK64fpdbH6PRBGrg/w5rc0rKIkJBbMSuOJepMHh+dLAFPfLvg66cRzZLfM
 ArUP7yG/zgIIroCIlSjMKAwmy90Z8y41k08zhzfQUs0ibQTv/xvC24r6RAXUmKips4sn
 sIqpYKB/oXeebcxZ7GISPZJrqqRRyqu/joKbfeq730pRfb1T8/03/kr8ypU1fMwFbfnF
 zUlyqnRXLQC/NbCR3I1xsDyd5mMpSAF1zgVC41tEZGl9LFadekVHHcztUA4DpMCXtSgQ
 Jg+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE+kC/0ANh+vU03d1P0uyFEWDqFgCbLTpab6uJVLUvLtxgB12WO8Vg99pzAwFjG+6lnd7c2Tw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8m4uj3oT8jZ97cxhAUtu51xhJfEd//2YPexk0pBeVyoDvzlVs
 xVV4a6ijzjLZEBML7bj+CM0zgsuT0jSDDZ/FuLvUH7Lcfgmyvq27fLM0SBZaFxD+OGs=
X-Gm-Gg: ASbGncu62gDkdN5z9uz2+RmId2QLVMYhZawcVz43bKeWWsVZ/OSbFmqDX2Hxiv0ImCV
 cEDWH8+VjM7x0xrxUxa2q2EeyK5ZYBimb7N1efY4BYhT2asy07e1hXGyHzGtTNXET1vGGA4wLZK
 gouIjWx1uI+/AHzsL4EKBtc39e2xIA17eYWy/5Utb2VqaxalRW6bGVbG7ZQH4UU1PJT9Y4NufqE
 3yitn3vJ7sDRGhHgJyzuu/g0xLV4y3+DnbwRspfX3kK0TqQ8L8WpEMKsoV77oEZ4zYCi4Rms8ux
 SdkyEXKZjwAX01YtZ1R7Zkl21p0dJpmjQug1tgQuTxiBWvUwsK2pR0xyRW7qcTTQGQu3jPARaYU
 sAhca9yEylQVHZCiQ34rklwE=
X-Google-Smtp-Source: AGHT+IFaJA6/mQ/RBF1PWTpjyutauX6/s5aW+DK5olD0jw0K+PMMprIJDSrvyWDpyt6coxXT+Sat3w==
X-Received: by 2002:a05:6808:1205:b0:400:b3a8:2cb8 with SMTP id
 5614622812f47-40ac70a106dmr399637b6e.25.1750374403898; 
 Thu, 19 Jun 2025 16:06:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6cf37e0sm84628b6e.30.2025.06.19.16.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 16:06:42 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:06:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
Message-ID: <20250619230640.GF216500@bill-the-cat>
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
 <20250619212714.GD216500@bill-the-cat>
 <CAJaLiFwQCT7LLw2rr9p+hviojYgrw166RCsdOOutRKDvye7icQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7KD4aGyM0NqKE0L/"
Content-Disposition: inline
In-Reply-To: <CAJaLiFwQCT7LLw2rr9p+hviojYgrw166RCsdOOutRKDvye7icQ@mail.gmail.com>
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


--7KD4aGyM0NqKE0L/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 04:04:00PM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> On Thu, Jun 19, 2025 at 2:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Jun 19, 2025 at 01:37:53PM -0700, Tony Dinh wrote:
> > > Hi Jerome,
> > >
> > > While fixing some ext4 file system problems on 2025.07-rc4, I ran into
> > > a problem booting a few Kirkwood boards. kwboot loaded the u-boot
> > > image,
> > > and then u-boot execution was frozen without anything going to the
> > > serial console. I did a bisect and found the commit that caused it.
> > >
> > > https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02=
b8a75c1940
> > >
> > > When I tried to reverse this commit, I had a build error like this
> > > "{standard input}:24246: Error: selected processor does not support
> > > `mrc p15,1,r3,c15,c1,0' in Thumb mode"
> > >
> > > Currently, the only way to boot Kirkwood boards is to disable either
> > > CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
> > >
> > > I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
> > > know if I can help with testing to troubleshoot this regression.
> >
> > I wonder if the right answer is that CONFIG_SYS_THUMB_BUILD should be
> > off? A quick look around and this (and sheevaplug) are ARM926EJ-S which
> > is Thumb-1 not Thumb-2 and it looks like the kernel for example only
> > supports building itself with thumb2 on armv7/v7m. I know that this was
> > working, so we should dig more too, but I'm not sure what the best
> > answer here is.
>=20
> I recalled we added support for Thumb-1 from way back and a few people
> have helped porting more changes from the Linux kernel.
>=20
> U-boot has grown larger and larger over the years, especially with
> bootstd enabled (I know you have been watching closely for size
> growth). Built without CONFIG_SYS_THUMB_BUILD, the sheevaplug board is
> about 107K over the CONFIG_BOARD_SIZE_LIMIT of 512K. And it would be
> an unpleasant surprise to see size growth for other downstream
> projects still supporting Kirkwood SoCs.

Even with LTO enabled we would still be over limit? Oh no... That said,
I think we'll have something to try tomorrow to fix the regression.

--=20
Tom

--7KD4aGyM0NqKE0L/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUl/wACgkQFHw5/5Y0
tyzmRAv7BuMGv2A5wZyuocYcNTKbnnA+DgzNsJy+9+aq24NP4G+xS80eBH7LEhRR
IpNwCs6ZPt8BqtJw3rP7ZT8jjWjIKd4FxpErVzt3UXPd2rGu7HssYq93DkcC0GFX
BwnVTisKqmKkG9nidLwIM1SiMAgAU6wpv7dxp+ofIruULbL7SETjTNMJWBeWHZ52
5g2yBX5TXLLHIW6yd0HDeLZ8U0ikKACElhVm8H0gj9IhyAVrrYCcoF1bakeBgSlP
TBsgSE8RCfEP4Af8uBOPgRQKWEXn0VfwzDw2z1wX4ljK6v/ywC5uqZXiDi+nK5e1
vrmuitiRj8OGnoRNxlfOg9HJE5FUGv/g2oSV+vvgXyWYD4woqWP94uYhrTTwOhZ7
aqUZ4IfKoFrU97BgFhW/WdZEqqtbEI/vMNRilexJ2L+rE9WMNtQkOfVj1VWjNKY1
H+POwrOJpzUUdVXgbyaQJWidqxiObQNjcjjQK9qlDvjuUHnxE51adCqjahZigIo4
0Galw5Es
=jA4Y
-----END PGP SIGNATURE-----

--7KD4aGyM0NqKE0L/--
