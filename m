Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAED2C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 14:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4146A84A51;
	Tue, 30 Jun 2026 16:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TjOl9gqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B52984AA0; Tue, 30 Jun 2026 16:03:53 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1739984A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 16:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-49190e20a0cso2046616b6e.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782828229; x=1783433029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DRC1al6G1AfZ+0pUVZgWdpqsutpS8cdiUYsGbT/w0Zo=;
 b=TjOl9gqBF/bKC/640tBLmSW/zz9BuPwWZLqzkBfKFGoXFlfBK28Ad1mC0RWET5NxIO
 r0dO2qA1b3YZOeQPXYi+DbU28fiiRhzkwaSOZMNQItux61UMIYCIGpe+tDYUOXm8aM8O
 n1eP9vEjopmeypupTiHq9eSMNaYwZe7g7U/44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782828229; x=1783433029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRC1al6G1AfZ+0pUVZgWdpqsutpS8cdiUYsGbT/w0Zo=;
 b=dYmdkib3nCSyscgTVCVOnZjs2+xg6nPR1nG3BAfLOKC4xSkPmA6R1KFx3PrkAHWJPc
 cH7inwXzwjbYQl3tbgSjyks5LeVx8rWNlt4DYevfayPxf47m8J2U/w+B7efnnrbAhVwM
 IaNZkpp9AjwBolUmsdHjp1jV/SO+Pxel+lSPpdHXyOagZubKcDrQBMPloOe2oIq1fGqI
 KbJJkhdAhdQKp7mvL90dv6iFK+jXGFr0QA7ZNPG0bEQFxDz3U/aXrSjMJoFIlDZoWiqT
 e3yKQME6fJLgvGdYsX65bO/gqydu+XzpmhhrIVUtZSEyDj65rwAw3EkXDsCfpp4FvmHA
 6pbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ROsZgkTho7XeKrAvkvN7SLEPLA0InMnGBMDn5g9lBiUs/Mvy2Y01u2Y2pSNfHq7Qv1QKLV1I=@lists.denx.de
X-Gm-Message-State: AOJu0YxA1/ZA80nLVe65fTqpjRhypg4E8c5G3AHej+erIlsWqsXb1cuy
 fkBPayc3Rpp6sDnJFpyndiBTDmcunHaaOn/LfHL2qg3eFYUO1NKvvXDkkycgHCH2rmE=
X-Gm-Gg: AfdE7cnX7vBgxr6yKKK0t281T9Lla0bLQbSb4ivFDc0yEfNvh1/szyEQ3As1afYevHO
 PweGnsUIdTjKkwbDbXCFfm+lLj7FMvchsaIYpKUl9zTqUhELkfFGhljcdL1iTrsfbze353GO8Xp
 ZpaZjAJ/djjheN4jYK1VsOCUZq2pDd+X0WcPzyVbxXTMvjvojnpqvadGD1l1ebL0plAve93hhtk
 iOSWpHx6SBvrtZNL2AxAo1wlb5YRps8BWqi+1QCD3Rz98jC0K4l76mLzu+DQ8jLL5HMXn4EN0tR
 I/fsmXXYuWTxiZJxRXVQwth4hQRx+8ERATjMhNaq8zpM4J1DKPEZKo6M8+3cQWyvG1+hLeqG6g8
 qy6+O0QK8680/uqPWv5SV+cu2RbqugWC3/2qVUixr8qzlxGdEjRFfqQ6kK2/J+nSUL6NJ8THnTS
 8GaoZfFY2O/iR6QRPTkgyesPLaJ3K1HKB5BJq+KBkHcFERDNGQs9tPNMFs2QhUH0Qu89a7MJGyG
 7BCYKYjJ62rTuQGlNQ+fo6G0GIIp01vETVts2Wx
X-Received: by 2002:a05:6808:4fd2:b0:48a:a666:e735 with SMTP id
 5614622812f47-495eae3b8dbmr3346092b6e.16.1782828229168; 
 Tue, 30 Jun 2026 07:03:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-49354e5256fsm8518612b6e.12.2026.06.30.07.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:03:48 -0700 (PDT)
Date: Tue, 30 Jun 2026 08:03:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH v13 00/12] pinctrl: add support of Airoha SoCs
Message-ID: <20260630140345.GA967385@bill-the-cat>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IV3EsMuwuJF2JmDN"
Content-Disposition: inline
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
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


--IV3EsMuwuJF2JmDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 08:29:36AM +0300, Mikhail Kshevetskiy wrote:

> This patch series add pin controller and gpio driver support for EN7523/
> AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
> gpio driver with Matheus Sampaio Queiroga changes.
>=20
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_en7523/kernel/src/branch/airoha_en=
7523_pinctrl
>=20
> Additionally in the EN7523 case the patches removes existing gpio dts nod=
es
> and replaces them with pinctrl node. It should not be very dangerous, bec=
ause:
>  * No official EN7523 gpio support present in U-Boot
>  * Legacy Linux EN7523 GPIO driver is mostly abandoned
>  * The same driver is planned for upstream linux/openwrt
>=20
> This patchset includes bitfield.h patches created for Linux kernel
> by Geert Uytterhoeven. It suits U-Boot fine. I preserve original author
> and original commit messages. It might be not a best strategy, because
> these patches refers to other linux kernel commits not added to U-Boot.
> Please note me, if there is a better way.
>=20
> The patches were tested on EN7523/AN7581/AN7583 boards.

Unfortunately this series break building on:
zg2_beacon hihope_rzg2 r8a77980_condor r8a77995_draak r8a77970_eagle r8a779=
90_ebisu r8a779
a0_falcon r8a779md_geist r8a779h0_grayhawk r8a779f4_s4sk rcar3_salvator-x r=
8a779g3_sparrowhaw
k r8a779f0_spider rcar3_ulcb r8a77980_v3hsk r8a77970_v3msk r8a779g0_whiteha=
wk silinux_ek874
due to the bitops changes.

--=20
Tom

--IV3EsMuwuJF2JmDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakPMugAKCRAr4qD1Cr/k
Cr/yAQCf5sOlXZUlUPizkO92LitOjx5+tZxLmSmVugsLL+u6yQD8CG3j/68yG2v0
Q2P4phB9wTszQ8enHjG8GgMmYG32VwU=
=rOfM
-----END PGP SIGNATURE-----

--IV3EsMuwuJF2JmDN--
