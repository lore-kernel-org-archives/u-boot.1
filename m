Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23A9E92706
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD5386D19;
	Thu,  5 Oct 2023 16:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ECbtmzsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D8F86D1D; Thu,  5 Oct 2023 16:49:28 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCCB86D04
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a24b03e22eso12272467b3.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517362; x=1697122162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8ny3kR4W2Wrl90+p04CKxavJZDIMHp5da8h/mYqKwvc=;
 b=ECbtmzsSFBp720ohpwhYDQ5xJ3wr1yLdqMVHYa/1fWp0ZxTyvW6oWMK9Zu+jHAi5J8
 Mcr8b5pSSJoXSRqxdyMJl4BOpMhVahehcCNIk9G63FL0dHnmclwVP7Whu3k8E+wGJJPS
 nUbSLDdeEMQ3tZpy/cbORpnqbtrzqdu8sBZj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517362; x=1697122162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ny3kR4W2Wrl90+p04CKxavJZDIMHp5da8h/mYqKwvc=;
 b=f/eRakx8iEwrW0tFsfgLff/z7Xq6Y8yZaekHP9ONQubnl1D85OPZMndT0Dtw+vawvE
 qilzmKY8cBx2BSnwGZ1aaiVj7QVkoC+z8n7QxFPvSJF0gsD6hM0x2HT1vcePWdenEKrr
 Y7zpZcJ55FETTaPpBlrr8AFDuPstJS+3dvjyGwJ/sJwHyWJyBb1xMrakBQvaDtXjrzyj
 OmDKMgMafoiaJyYc/5Ztm57CKdoRFqFejkAtfM94YY6GOo6ypzQAPwhFqCNO+byQAk9H
 /kn7LTjKhFz65e1TvEK0Ct/3YpofZ3xZcEdfN2d1ILZJss4niqNhanuLEONeie+mBE27
 mvqw==
X-Gm-Message-State: AOJu0Yyo4E/hQVMt2AlLM19WLvNHdYZQhtiU2d8VT5Y1QgjSaFTdE6Zh
 YaB+6L0P5+mdCSNfS90V+0emlw==
X-Google-Smtp-Source: AGHT+IE7neGHWTVL/Dn1Il8nLvTZ+/laD1lxvTpPkmxDDgZAK6XVN02cc0SFKKcSaQTNv8cfSSZi7w==
X-Received: by 2002:a0d:d906:0:b0:59f:6e6b:882 with SMTP id
 b6-20020a0dd906000000b0059f6e6b0882mr5969005ywe.0.1696517361993; 
 Thu, 05 Oct 2023 07:49:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 o203-20020a8173d4000000b005a237c85821sm551245ywc.110.2023.10.05.07.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:49:21 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:49:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org,
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix boot
Message-ID: <20231005144919.GL8465@bill-the-cat>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
 <20231004121546.uvvqcbewyt5s6kdx@extrude>
 <2f55c3f5-7867-4db1-a0cb-7bc6f78ba044@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L1Tq7QzyffHqIqOR"
Content-Disposition: inline
In-Reply-To: <2f55c3f5-7867-4db1-a0cb-7bc6f78ba044@siemens.com>
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


--L1Tq7QzyffHqIqOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 06:18:08AM +0200, Jan Kiszka wrote:
> On 04.10.23 14:15, Nishanth Menon wrote:
> > On 22:26-20231003, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Since commit [1] A53 u-boot proper is broken. This is because nodes
> >> marked as 'bootph-pre-ram' are not available at u-boot proper before
> >> relocation.
> >>
> >> To fix this we mark all nodes as 'bootph-all'.
> >>
> >> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-r=
eloc after relocation")
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>
> >> This may overshoot, but at least the board boots again. Could it be th=
at=20
> >> [1] broke even more boards?
> >=20
> > Jan: https://lore.kernel.org/all/b1c62a7d-a90e-4212-8972-9b622e147975@k=
ernel.org/
> >=20
> > I got boot without r5-beagleplay.dts modified. and it is in line with
> > the changes in linux-next commit 944adefc7f88 ("arm64: dts: ti:
> > k3-am625-beagleplay: Add boot phase tags marking")
> >=20
>=20
> Yeah, no problem, missed that.
>=20
> Meanwhile, I can fix our IOT2050 because I was unfortunatenly right:
> more havoc in sight. Did anyone tried to look at the fallouts
> systematically already? Is it only affecting the TI family?

Well, I'm pretty confused right now.  The visible breakage has been
traced back to a commit that was in -next and is fine on my J721E EVM
and is fine on my AM65x EVM.  I can't figure out where my Beagleplay
ended up, so I can't check that one as easily.  But given how the
breakage is described, mine too should be failing.  But they aren't.  In
both cases, I have the GP versions of the chips, and am booting the
unsigned files.

--=20
Tom

--L1Tq7QzyffHqIqOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezO8ACgkQFHw5/5Y0
tyxOigv/TLx9ejAJUxPyGb9Vjxe3RNNHu1fQyISCiejBdvgQ7qzog7UDT1xxMLUv
IDYavH5jZ8YPb/TXNWAR3rZP+WYZq+cZ4W+p7W+9ejkkJLiuBA3/EP8ykUqZJF3X
4/KCvJz+431VXZNuF/gXu8dEaX6j7bm0egAm9ia4QssvrL5gjpLyUNxbWPeNoAnt
d1DFYitIJjtVNTnOVUGqRlXkmnyd4MrRPlh7HLO654nTPQwgDq1bw8oUocsIsFR8
IkAQ4Q6Ikvf5RJ85cKLFEIlEvFtAKgs42VRHXmSQ8PsVbkKpusEox8OZxblBmJzX
KGRfHSZ8FCttgizMpCM/3uhnoSE6mB6zUzziq1dGalGHanJ+uIKWAcvQuFZlc7Qk
2cqF4LcVKKxyNCmXDDn2c36YGSALPwt50gSkkh/0rqF9PcSoGR+AqsKvnnsqCprY
COy8OzQKYZXQYNJieeK08gbPkdhXsLAoEwYjyZMmeSgLY0ctuliWgQZzEY4GIjBO
UVN1Ltc1
=XdXw
-----END PGP SIGNATURE-----

--L1Tq7QzyffHqIqOR--
