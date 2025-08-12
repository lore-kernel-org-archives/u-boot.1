Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EA4CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 15:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 452438304A;
	Tue, 12 Aug 2025 17:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pHGg5xFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D54382CEA; Tue, 12 Aug 2025 17:30:11 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7373A8304A
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 17:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61b43c84905so3845099eaf.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755012605; x=1755617405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jP4ZpHjhQ6LrtfXx6vrX0ADT0N3fKOOZQE0k1+BW+CQ=;
 b=pHGg5xFWunEMYfT52BWMl1caE2Ps/zlKuc0UXmu3yHSaotOws6+N44X2jFLWlI/j1j
 dsl5neDdoFRJZKiv2Fwtf49d4YfF/iM88sJ4TRPzokLo6nog54NM5lzM1lMuvFplE66H
 IT5PNTl0AYYZ9xgbHibAyNFiIsfFw6kKB6eBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755012605; x=1755617405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jP4ZpHjhQ6LrtfXx6vrX0ADT0N3fKOOZQE0k1+BW+CQ=;
 b=FZcblomCW17JJ7JQaLxm7TpLZqsF1MmcCeGcKOaGxY8Ow1pe89mlDebVsLEOHnXvLB
 pz/xv0SPwiBi9e2bgInHkKeot+7Af4ymGEILnHWvuP/AMkYxPoDd6Bski9b8DtxEFEsH
 AX0TQqJH8z7ZYZ0x2NPBqrvZL45+wUGYl8ILFaOHxi2HmfSETjd6CUU7B0Jdgr83pbLx
 SYxxQMmDVBO90495Wzj+CbfF+8NTzkJyvHA+yPrOJIautkzoCIrtdNd6IACzTroKiKHE
 0KQhi5eeJSPF4gEVkb3vbaW7UEzxW0BK1aAs2OWhVXa7o4tpXswM6wm29cBkxYNclxrs
 sjTQ==
X-Gm-Message-State: AOJu0YyhzNItz+92vA+CvQa6f/59vODpQwGrsOnr3HSW5LMIeeGdxE72
 LzkOA2AnGAjRKX9SqVt8GF24u3gYqyfxB5CpYQRBBj7I3U7LL1O/GNGsatcz5IayeMwX270LlLh
 lnBgopn8=
X-Gm-Gg: ASbGncvBns/ESctX9YT7n6JVbOT9uADv6Wc5SRAF6dd+gVT6Ina64i/0pP06XYr65oq
 zjlwKgHTqqEPA7JMLGMxf8gN8VvXTq8VNHDTBR+PKpVKPEfQuh+wCUWfs087OGar/GknuVyzlDN
 N6V/rDD2ODnMOWxkT/WYTPFmeLUxoobmUGnCPX73lxqcLKkFU4zobnT8y1YJb6du3m/SYhGmMVw
 Yvm5NGB1Srs8mLkEQ2K+ebhX/GGVbsEgpq1cXpJavkV+BklLfcHWOLq4EbK+A0N/dQ4Xw5zwPiu
 xLulzG2kbvv8xSDBgtiAI8uZph06tuF2J+wUVpAqKJ0btfRzRs/KLnHd4nf02rrXDjH/VT9PmHr
 uQ2DbXxD72FmX2SlrQKQjP0I3IhFPM0LB8WRaPf5pT9kk2FUt/8TYmFOf
X-Google-Smtp-Source: AGHT+IEcYjvOU9iE1zc9rTTH8xJTK8STZM8Kt2H8WwHRn2CpC9fCO/fFpX3CqzXUQZOsYr7A1OQyng==
X-Received: by 2002:a05:6808:6808:b0:435:6b6e:9192 with SMTP id
 5614622812f47-435c91b4524mr2556704b6e.26.1755012605027; 
 Tue, 12 Aug 2025 08:30:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30bcbfd87f5sm5452579fac.12.2025.08.12.08.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 08:30:04 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:30:01 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.10-rc2 released
Message-ID: <20250812153001.GU124814@bill-the-cat>
References: <20250811194953.GL124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XvrlPWuUXZ3yvYql"
Content-Disposition: inline
In-Reply-To: <20250811194953.GL124814@bill-the-cat>
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


--XvrlPWuUXZ3yvYql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 01:49:53PM -0600, Tom Rini wrote:

> Hey all,
>=20
> It's release day and I have tagged and pushed things out. As this is
> rc2, the next branch is now open. Moving forward I'm asking that
> custodians ask themselves if changes are best merged for the October
> release, or for the January release. If there are regression fixes that
> people know of or otherwise big changes that should have come in by now,
> please speak up.
>=20
> We're continuing with a community meeting following the release
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> August 12th, 2025. 9am (GMT -06:00)

It was a short meeting again, and only a few people were able to attend.
So I'm going to ask if another day / time would work for more people? Or
are we just in summer vacation mode and this will change again in the
fall?

That said:
- I noted rc2 is out and the next window is open. Things are looking on
  track for the release and I hope for pull requests for the next branch
  soon. Also, Coverity Scan is reporting a number of issues closed as
  the smatch fixes are also fixing those problems in many cases.
- I talked about "allyesconfig" a bit, and I will likely try and push
  this build a bit farther along, going by subdirectories. Andre asked
  what the reason is for doing allyesconfig and I explained that due to
  how we configure the build, it will always be sandbox only, and so the
  goal is to get more code under static analysis. Once it builds with
  what is in tree I hope people will want to get more of their
  architecture specific code (drivers first, most likely) building as
  well.
- Bryan Brattlof asked if there's a more generic mechanism today for
  being able to fire off events (remote proc firmware, memory tests,
  etc) and ensure they complete before moving on in the boot sequence.
  He's looking at prototyping this with UTHREADS currently and I
  suggested talking with NXP and STM32 people at least as they also have
  a number of remote proc stuff and might also have a similar problem
  and maybe solution.

--=20
Tom

--XvrlPWuUXZ3yvYql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtd+QAKCRAr4qD1Cr/k
Cl+/AQDV/XlkiCeA7l0tRLsR5zGe5KJ8+kpwvFCblMOsY5IGAwD+JhReLyZKAx86
xea9ot/Uo5PumGt3AinDAI6Dszvjigc=
=C0cA
-----END PGP SIGNATURE-----

--XvrlPWuUXZ3yvYql--
