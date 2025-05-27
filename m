Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E3BC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 15:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133AA830E4;
	Tue, 27 May 2025 17:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lUSew16S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E942D830EA; Tue, 27 May 2025 17:52:12 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FD482FAB
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 17:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6066c02cd92so1562022eaf.2
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748361128; x=1748965928; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LU2hKMF5M09H2bhV93T5PgRzJu/YX2Irv3vhMgMcmrM=;
 b=lUSew16Syq9hn41KYLsDhbsfv52Ad4laugVkCdKeMQF3XPFBp/CbfP5j/bxtmFC2ve
 lDrBPwZfrZ8CzI/n6Wr41nKc1j63/4dFlaYSZxfAPShM3OZJY3LvWcXFdytkTF/hxeSc
 UuUznRvdUK3iKuinLg1AYbq+tTicfOkSx1Cuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748361128; x=1748965928;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LU2hKMF5M09H2bhV93T5PgRzJu/YX2Irv3vhMgMcmrM=;
 b=C76Wk6yLY3hSnibSjZXKffWMHtSl8RogYoKJpXbG22wotmbfdp27kPiZBb+Z36xJmp
 /DKMcmPrxJHLIsZhZ4G91gkFFL5zxGYv09MG2qHHqJ9JfiqcK53BgVA2IzxUPi/j7NBs
 sldpxq2E0Jayc6cEIlmqukuDbjkLEVd4LHVGHGQG80bj3mVcNkFaZfRa7VjAtAXzHMi/
 moV6RPf6r4Rr7lK775KVoVsdZrqwYzKaXu27+MxCqmZKgZ/hf+oC/fq6Kk3b2izuUKNo
 IB7o8/7GJ6cHMS7AsRxVFFiVsozgEssYic3CNXd4gIDE3nuyFxe93mRUOI89Isn7xLxn
 jFVw==
X-Gm-Message-State: AOJu0Yx4EXVNycNJVq796OWS8AlJO+rEsGCvrx/rcHLP6R4lV7JguZt0
 1BWvZg0bfvNv/FqyzD6tyDCSpl6A3YtPmqXmGtRL4BGz8tB+K/XrlMTPrWqmLEtcjN/lZR5EQf2
 DNPNRKkA=
X-Gm-Gg: ASbGnctVWTkS4zLpXIdQvmeMye4D/w6MJVJ3NN7ey9P9FExZMEEZJ0eMZmT2XCsob/W
 ERUCLNcEk4WTNN1IeARX4RUmkCTzMzBjpd9HEUebflWqx9YwvSbey/2/pO0LvTN4HGmqOpD02Jk
 qnB98ncNaArmP/zLDzZuK7ze3TamRIZwIIIgAxcnv/C6sGLQg0P4rOACjGatLoa/Bum6LTA0qwN
 2eDcOp+TdpXS/rhNc/WYZy1dazhrHths/0CnuWf8MbGSi6CeNGizJ7r59VjYdJ4yk4XjQa4cKiY
 JZNDwDPaTFTWwOETMAzzOyBrDHMDpN5YrG+gMu9q8TDDa1PTmeg1VL0xSEznRH5wA2MW5WgvDF4
 sND1DVV2DOIMT
X-Google-Smtp-Source: AGHT+IEc7TC2dWl0Rcr1mY72Tk53fbz9nv55goviOjjm2OT6CZwff2BzsxzIM5DSU4TQOILA9MnqPg==
X-Received: by 2002:a05:6820:1e18:b0:602:7078:df55 with SMTP id
 006d021491bc7-60b9fb1d5d7mr7181304eaf.5.1748361128245; 
 Tue, 27 May 2025 08:52:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f1e132sm4878118eaf.6.2025.05.27.08.52.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:52:07 -0700 (PDT)
Date: Tue, 27 May 2025 09:52:05 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Merging v6.15-dts to next
Message-ID: <20250527155205.GJ100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mc+EHqRANZQLRfrh"
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


--mc+EHqRANZQLRfrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

With the Linux kernel release of v6.15 over the weekend, and v6.15-dts
now being tagged in the devicetree-rebasing repository I'm merging that
to the next branch now and expect to push it later today.

--=20
Tom

--mc+EHqRANZQLRfrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg136EACgkQFHw5/5Y0
tywjTAwAlslxA/U51/o/l6RJov/S6qXDa1okBdE77Tr1NJMrRbzaRj0l3nCsTP8y
8ve7+Db1Yt7Lng8lC88nMPNr+d4STYesvW/lPBka338MpLEo9/3Mze7gfHn7te/o
Rz/ppJO7rI9EHTbLkwG84T1tX2W5btiBhCDJLhtNFYEHGTjumhwKrMKSgQVqCPyt
03n0qyxPjjUcp5M361ywwBTy38qzBUYqa3ej35OQSp61EplbJhgyFY3rX5okDF/d
VTiYlJX3jQfq3FfP24+HVl/w5/LdATdc7njaB36qYnb91iJfVUU0UYkUCzrK3vtP
K27Dg8l3yb3oOHMcHNoPutWM6f4X9p+rlLPbA5p+I/FTq7cd4SHtLHCxM2vLAHsN
x2zdSD3nu5xtTAI88Yx1zJaMswyKnBWM+K7REbq0w/tbQUxC+olJ33Id/QiNuLpt
xtb3+/bdVcV9Gf5oBhWJLnnVW3+jICIa2n/Xfh+zzEO/jyeJhQhkCqHpSJIvwBDi
5Jtl9606
=9x4p
-----END PGP SIGNATURE-----

--mc+EHqRANZQLRfrh--
