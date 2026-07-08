Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22061C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 827E68496E;
	Wed,  8 Jul 2026 19:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="djcUeDCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D912E849BA; Wed,  8 Jul 2026 19:18:16 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C328843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a378a2cfdfso114841eaf.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783531093; x=1784135893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xr2mQ8EPB+GR9fNwwfnlDSgOseozOW349K8jrsIGcyI=;
 b=djcUeDCb/RvGFF9VoA6NehJuAXqA1USIzoe2zrYQ6qmSynuUqed5Zu+5juy2cRjPel
 6ddCQ5bbtTcOeFXJ7A8X8Wl/eUNHO/skM3y5w+pD4CfXzcp+VBb+rLYMBlNJBH8VKYCe
 Wthg0X6SfJ+Q5cBbRpOoz+NkStGyaloQgZ8YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783531093; x=1784135893;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xr2mQ8EPB+GR9fNwwfnlDSgOseozOW349K8jrsIGcyI=;
 b=B7kLZPeeXBm1tE/pnaYuQy7GV4dAaE7jk7lEI8PFsjyN8afMgeF+qo4YmLolIbJSeF
 04SvupRlYsIupRW670gK7+bBeLnwJgZUuD8IKGMoxCW7sMdfS+mTTR8KjAoaiUO5W8D1
 e+ABEMJ3ocpigXGyXKuRAARAnZc2wp9h4utFQnMRO4VngQMqZNhw07LFVNqbwIQBKQJO
 immieQgwPPhc0dVh6fpLimXop6EfpU6/NHHLJ3gx7eSnhQaQ/h1ndaPddqlZ7VwX+Vmx
 03dv1Bj9/1q82/ZGuVh63MbLosnL4VyiinZ/VJK2SuEi5DtRWNW7CPngstDusVOFmIk4
 1OTg==
X-Gm-Message-State: AOJu0YzGNkvVIIP017VZrlHCF6FuJR5+wZRHxjdsxx9HukA8zXjY2T/t
 RGwXcxhDJVIZkYLPFOAl2Z97pYaz5xL8coby6zUjoXtdPHL+GpgDTwIs15Lcp64n6Zk=
X-Gm-Gg: AfdE7clM1drJxZ2w/ytZ7MhwdKrskqnIy/dNwGP2N+rTh22BU7ndjiw+hVBkeHYsBqI
 XSzyoA5CA/9Yw72RIbpUscedHaUJAO2NN2IfE6vT38eDnxu0Xd9CuNNr4RqJu8gIm569vu45vo/
 VvXKzydPP2UiY6btIozwB9sDAkl4Y9chTn3rw1vofJs7ygbyK8dYoEtjHuI5Sf3eE5L2qkUOO0p
 mADub+aWPvJw3+DQPzUlbJLEAMO6kOgmZoDp1b3Pn0t6N4JAMFd0C1nAESWcFOdmHEf6GxJPTEs
 Hf41udgxRZuPHsaSBbJn1/TduCo8I5OQJfTS++hWwDUdkPjF1Px63Qzo+1uvJsLpDlDlPMPS8ik
 g/yB63TTh8M20qqTIRNUwgdHN7DN097Y6ob/oFh3HPjtnxQIaLH5cjxCpV00ofbL6JA7SBsgtIQ
 s5wvLJIdDg2iBtml0ktscpy+4v1t2Oigs38GhmIgIBhfCdjeH8P2lfqXJKlJXf/+Yr8ajolVHHE
 TM7yj4vCP2R3ma/UUdMKnLmUk1p8oVKlzopI2C/CU0z7CUr
X-Received: by 2002:a05:6820:4cc1:b0:6a1:5847:3dda with SMTP id
 006d021491bc7-6a36db7002fmr2141538eaf.48.1783531090323; 
 Wed, 08 Jul 2026 10:18:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb67156csm17586274fac.18.2026.07.08.10.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:18:09 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:18:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>,
 Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH 1/4] bootstd: add a firmware-owned devicetree source
Message-ID: <20260708171806.GZ749385@bill-the-cat>
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M1JwnvrvjBnlvGR9"
Content-Disposition: inline
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
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


--M1JwnvrvjBnlvGR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 05:06:42PM +0200, Carlo Caione wrote:

> Platforms following EBBR / Arm SystemReady IR keep the devicetree on
> a firmware-owned partition, updated independently of the operating
> system, rather than shipping it in the OS image or on the EFI System
> Partition. U-Boot has no generic way to source the devicetree from such
> a partition, so vendors carry out-of-tree machinery for it.
>=20
> Add a bootstd helper, firmware_fdt_load(), that assembles the OS
> devicetree from a FIT manifest carried on that partition: the FIT images
> hold the base DTB and its overlays, and each FIT configuration names one
> bootable combination through its 'fdt' property.
>=20
> The partition is described in the control devicetree: the bootstd node
> carries a 'firmware-fdt-source' phandle to a source node, a child of
> the media device owning the partition, which identifies it by GPT type
> UUID and/or name. The 'boot_dtb' environment variable may pin an A/B
> partition number.
>=20
> The error semantics are fail closed: -ENOENT strictly means "no source
> configured" (the only case where callers may fall back to their normal
> devicetree); once a source is configured, any assembly failure is
> fatal, and downstream -ENOENT codes (missing manifest, missing FIT
> configuration) are remapped so a missing or bad firmware devicetree is
> never silently replaced by an unverified one. Manifest images carrying
> a 'load' property are rejected so a misbuilt manifest cannot overwrite
> arbitrary memory.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  MAINTAINERS                               |   3 +
>  boot/Kconfig                              |  23 ++
>  boot/Makefile                             |   1 +
>  boot/firmware_fdt.c                       | 382 ++++++++++++++++++++++++=
++++++
>  doc/develop/bootstd/firmware_fdt.rst      |  94 ++++++++
>  doc/develop/bootstd/index.rst             |   1 +
>  doc/device-tree-bindings/firmware-fdt.txt | 149 ++++++++++++

I think I wasn't clear enough on the RFC, sorry. We need to get this
binding approved over in https://github.com/devicetree-org/dt-schema/
and I strongly suspect that barebox would be able to make use of this
too, so a u-boot prefix would be inappropriate.

--=20
Tom

--M1JwnvrvjBnlvGR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6GTgAKCRAr4qD1Cr/k
CiQqAP4+TI6rsBqH7fF7dcEDsnemL2FXjhAxOUiQ3+r79ISbBQD+NoUZFo+l8HJk
l4/t/cZuSjQVOImlayZKM0u6s9SSYQw=
=b4dJ
-----END PGP SIGNATURE-----

--M1JwnvrvjBnlvGR9--
