Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CA2CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 15:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31C68399D;
	Thu, 14 Aug 2025 17:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fx6E9kH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91318399C; Thu, 14 Aug 2025 17:36:23 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A76B8399C
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 17:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-88432dc61d8so86134939f.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755185780; x=1755790580; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MmcXF26asIsjPv6OTF0jEeEup9mNkE+EKpvSgQ7kjJM=;
 b=fx6E9kH5ldiFzgV4WKDWYndoDJiXjuV2oHAgfGVZ3HihLpqciLudgmxQkQF+EsDdp3
 0pzVY7QPfjzpgVtfMm6up1Kv/q1Jm7q9zkb23oupXVONCFRG28rpx7t8bcDg5Y03DIk5
 AC3k/PY5GtCzudjQhUV7Qrfk+MTkeSolhdt2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755185780; x=1755790580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmcXF26asIsjPv6OTF0jEeEup9mNkE+EKpvSgQ7kjJM=;
 b=LWbrro4GJjMrGAx5cCUchIQbQMJy/QjWbKTGmLSVTVnak3VgH/QsV5sEhQj4V70qPS
 5PWkt/mzA8CHD9fY4vYDjyVNsZhMJRstOz5q3RTmaidAzUotgHfzfc1DOuJr3KS6sXLN
 9jdfxLPKroEZHqyyT86nwVRmBFVmU/1sw+2TktKFZTD+tEKLUdESavA4JA/exoy/qeRs
 o3wGWSwGRkYUhevYgRujPFoJKV3AGXaBhl2RVlvZ4oZKwuDhNb5y7H8MTeNTrngcbNZK
 GLIVsprZhRTNFdH45vczEjwntbtjE/DF4P/aIQus4M4ROFGNZVKYZW1BG6SlsRpA6Xk2
 MMUg==
X-Gm-Message-State: AOJu0Yy6gxliDddrZ4C+v4JtBaGwP72cuUPSNyr1HSdLTAiyfr5Nq/OF
 cNeaPbK1YLfWMiCp25M6vVAnyS4grHuvolNFTYJB3NVzxwlZW6S2IJ7C/gK2Ipz7ny8=
X-Gm-Gg: ASbGncskoWl0mgx2IH2+oKAsG3oZHV6exnDbuesg2Uq+G9xrBF+jmUM0wl404hqiPt6
 KIs91Fa50DotXN9YPmV+2rgiPFNYx/ctaHZZa6TEOCobApyNfMLdYpK4RcfjWXlRczU72Q3Oq1c
 sbQijT8nZe3Az+26qc9scIz2r00T9w3aiZXdNcfgRcV2iw1hS9pcLoXkPi75vcxxlcedpH1AHFi
 s5MhevKMMTcCCyU1OPCU8yoxybdnv49Z8Q49TGB/kLJkZtfE1qaqLDejkusWQfROg6LO5rxJkRv
 dbg8Rh3pPFiyhVQEBTqLn/eLtM1vrjK20XYOd70vd9W2y3wOqnHSaPp994Oa4LJsQBiIjzn2L1C
 4BlmEQSNN0PWFOQXMfqEFCSU5k9wETdcNxLoPeLJf4mbSHNIUw1DhlZxA
X-Google-Smtp-Source: AGHT+IF0CpL83r6sISftQn6J5GpR8bAp/d9pStkJ5i5E4yL+eusDdaSQ+iMjj3RNFm63ILXEQmVj/g==
X-Received: by 2002:a05:6602:2cc9:b0:881:7e0c:7a79 with SMTP id
 ca18e2360f4ac-88433c4a0b0mr678273539f.2.1755185780055; 
 Thu, 14 Aug 2025 08:36:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-883f198d551sm529534039f.19.2025.08.14.08.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 08:36:19 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:36:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, praneeth@ti.com
Subject: Re: [PATCH v1] remoteproc: k3: update compatible for am654 syscon
Message-ID: <20250814153617.GK124814@bill-the-cat>
References: <20250814152145.2853307-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MRsWtjv+Q9cbdnoc"
Content-Disposition: inline
In-Reply-To: <20250814152145.2853307-1-anshuld@ti.com>
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


--MRsWtjv+Q9cbdnoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 08:51:43PM +0530, Anshul Dalal wrote:
> The existing compatible name for U-Boot's k3 system controller driver
> i.e "ti,am625-system-controller" has been added to linux[1] device-tree.
> This compatible in kernel is meant for configuring the Control Module
> registers (CTRL_MMR0).
>=20
> However in U-Boot, the matching driver was being used to load the system
> firmware on the secure M-cores by the R5 SPL and therefore must be
> updated to a different compatible to avoid conflicts.
>=20
> Therefore, this patch renames all references of the compatible to
> "ti,am654-tisci-rproc-r5". The "-r5" is appended so as to avoid any
> future conflicts since r5 specific compatibles should only be useful for
> U-Boot.
>=20
> [1]: 5959618631fe ("dt-bindings: mfd: ti,j721e-system-controller: Add com=
patible string for AM654")
>      https://lore.kernel.org/r/20250421214620.3770172-2-afd@ti.com
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/dts/k3-am62-r5-lp-sk.dts                            | 2 +-
>  arch/arm/dts/k3-am625-r5-beagleplay.dts                      | 2 +-
>  arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts                 | 2 +-
>  arch/arm/dts/k3-am625-r5-sk.dts                              | 2 +-
>  arch/arm/dts/k3-am625-verdin-r5.dts                          | 2 +-
>  arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts                | 2 +-
>  arch/arm/dts/k3-am62a7-r5-sk.dts                             | 2 +-
>  arch/arm/dts/k3-am62p5-r5-sk.dts                             | 2 +-
>  arch/arm/dts/k3-am62p5-verdin-r5.dts                         | 2 +-
>  arch/arm/dts/k3-am642-r5-evm.dts                             | 2 +-
>  arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts                 | 2 +-
>  arch/arm/dts/k3-am642-r5-sk.dts                              | 2 +-
>  arch/arm/dts/k3-am654-r5-base-board.dts                      | 2 +-
>  arch/arm/dts/k3-am67a-r5-beagley-ai.dts                      | 2 +-
>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts               | 2 +-
>  arch/arm/dts/k3-j721e-r5.dtsi                                | 2 +-
>  arch/arm/dts/k3-j721s2-r5.dtsi                               | 2 +-
>  arch/arm/dts/k3-j722s-r5-evm.dts                             | 2 +-
>  arch/arm/dts/k3-j784s4-r5.dtsi                               | 2 +-
>  doc/device-tree-bindings/power/ti,sci-pm-domain.txt          | 2 +-
>  doc/device-tree-bindings/remoteproc/k3-system-controller.txt | 4 ++--
>  doc/device-tree-bindings/reset/ti,sci-reset.txt              | 2 +-

Lets get the r5 bindings upstream too, to avoid future problems. Yes,
we'll need to take something like this patch prior to v6.17-dts I assume
as well, but lets start fixing both problems please, thanks.

--=20
Tom

--MRsWtjv+Q9cbdnoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ4CbQAKCRAr4qD1Cr/k
CpB4AP9Nj6BuI2ze1ykycnhcDRf7xGycT1TxqZlvGOarlW4dZQD/cYE9ulX28X18
C224qt54iVSrhUpSwso2zmIDSpvBNAY=
=gPJR
-----END PGP SIGNATURE-----

--MRsWtjv+Q9cbdnoc--
