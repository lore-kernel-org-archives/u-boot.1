Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A55BC282DE
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 18:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427FD8083E;
	Wed,  5 Mar 2025 19:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HXyUYnOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492E48083E; Wed,  5 Mar 2025 19:08:17 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E402807D9
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 19:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so1064790276.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741198094; x=1741802894; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ElE52HekjWnfPR6Hf/dnnzFdCyIJdZLOctAz+ta+5n0=;
 b=HXyUYnOqrW7uhy26H54BlVSPcegMnRD/DSV+BqYK2W3Mu7dZFWWDmF8ptETL2LdiXW
 TOgumqucmFrSf2trljQiUD29HIr+/j/qe4GvgFuKZzSsdY7NJG2Mxh3DfyGz1gz3Tl3f
 KNu6FUPmJJjZ7bgLzMH/uoT81x2ywF50L88Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741198094; x=1741802894;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ElE52HekjWnfPR6Hf/dnnzFdCyIJdZLOctAz+ta+5n0=;
 b=WiS4Yuc0cigJpnbjKODZmhYx79fVGQODgRzBupfrTlzvXspWnERL6q8TT1d4u08ZDy
 ejP/l/XuEE/phO+Hhf/GxKBL1Bsb64Wi7SjO5WZg3bpqN8alQRzgKUrRNCLhFhNvoPZg
 DIsMUKDmLggo8e9qY4CmobK7Seg94Y+mK//DRrKvjOueSK1hmjyC1ifJ3BLp7+q5orje
 sTj3GqwT5GmM3jQVgeHtxgfg8DTsTAgOAEOKNf4C+YyXpx5Nc1xk4bZmzZT0vCzpspOE
 HjHj1RtzKmnIcptj5RAy9XbI80HdGW3WASITwi1PcD5BWdiIPeeWXPhsLz4pT/Mic+3R
 uC2g==
X-Gm-Message-State: AOJu0Ywvl9xUAkZ50D0h139PRPP5vuHKrX26hesUxtM9GwW6ROyl8fBP
 2PfELMiR7POO6TIoHewlDwfsGf8ZU0r6pAZv5BaRLoSPPOwFexrli4HoTFPYRSiquJ7ePPcpPeH
 k3Uo=
X-Gm-Gg: ASbGncuCvWTaydlKbzj7HFSHDjCROK/ONZELka6tCikUim3XhPVX3i3AemjINckyunH
 rl8XP/wVRDsSoBwQCHGtWw1iqXk9IX2nsDOdxhZQEgBqYwSi/fHDf4C62N81s0YJe/YCwj/NR4m
 G59DuIZ6rpwgDtlJ7qfxzaTfdHYsbP8VIRsx0BlFh5tSw+ouHPLQqOHcVAQUnvqMrs8gOU7u45z
 kFWZu9Sk4dnqt6Re0BViQEJVi3j3eqrtr4ZNpPiLPs5ge46psDuKfy4vl295qSZ3aK+JtEVbojL
 JdYmpRxTudU8BrGA7rueYA2D/aetSMotpmFQFyKtAXiL8Q==
X-Google-Smtp-Source: AGHT+IGa3dw/NyZL/4q413bl1thqrU3xTeAEoIpQLJACIZRHgQXw/8PkOKQO/QS2tkjprTl/URUfMw==
X-Received: by 2002:a05:6902:1ac6:b0:e5b:4651:b5c6 with SMTP id
 3f1490d57ef6-e6347bb4505mr344844276.23.1741198093807; 
 Wed, 05 Mar 2025 10:08:13 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a3346fsm4516990276.15.2025.03.05.10.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 10:08:13 -0800 (PST)
Date: Wed, 5 Mar 2025 12:08:10 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Subject: Problems with test_net_pxe_get test
Message-ID: <20250305180810.GV2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JclsST8BvcuL9UKJ"
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


--JclsST8BvcuL9UKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Love,

I've been trying to setup and use the test_net_pxe_get test now and I've
found a few problems.

- An easy one is that we call test_net_setup_static after verifying the
  network is up, which I believe is a legacy of when reviewing the test
  initially and not removing the line.
- A harder one is that we can't enable both test_net_pxe_get and
  test_net_pxe_boot because the latter means that we do have the UUID
  file existing and so we don't hit the ipaddr case.
- A final one, and maybe showing a bug in U-Boot somewhere is that we
  don't have a match on "Config file 'default.boot' found" but instead
  on "Config file '<NULL>' found" if we are running in an environment
  where test_net_pxe_boot isn't otherwise set up to run.

--=20
Tom

--JclsST8BvcuL9UKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIkwcACgkQFHw5/5Y0
tyzUIQv8DpcABX+ONcopSBymzYcBTbvFe4vbduPSIbMprkV5q3sCpDWZAB3KtPO5
lA2mZ7cTdEb/tjyaIHULoApSQHugUGU8ElY8GvpvWPoSCyVr5b2MMkH4C/I5XVW4
SovSx9LHRam7c6N4xl2tqIjL+M5sCHQ2ACETkjn15bdVHT0NeOP2/d25AHjorEIK
U+B6uzC+kj6zWZYrFw6IB3pcXpZIk/4z3oajPWeMNPYRbXERAny9wZ266bscTWGC
ci/zhDgGkgP6elNvxPymyUL4CRt26vyDJVp4cX3UrKumi/De0X8VUyik0f5xwn8Q
iZh4FD46uI+eCNh86DqldS0bAbD0zqam2vKCdNzS2mTvGOD3+nPpRFS9d/p5M7Gr
J/FXscmh635VW5SdShd3pbes/8NQcgPxSzvyG0bWB+1TgDgBtC3ODlfL/RXbSoCo
GaREbo/lW6xOT1BjLhGI+1oA6lBjyg94t6ZHKnT646MrfDX/OT1Hc2C82rcdQSoR
fE6lEWBj
=r+vh
-----END PGP SIGNATURE-----

--JclsST8BvcuL9UKJ--
