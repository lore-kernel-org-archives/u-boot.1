Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D311C54E4A
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB97288013;
	Tue,  5 Mar 2024 00:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qgTvHM+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE3588006; Tue,  5 Mar 2024 00:44:49 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB09087D7E
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7882a0bcf82so67833485a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595884; x=1710200684; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Txx4HuJ7LC8E06Hjv+jeDWg48QiTN//eztqxVLiThdM=;
 b=qgTvHM+Y8UHjR5OKaOtoy3k8FI2TPDF39YB42Qd4nqCbiQbhmMhtDNg64HN7BrkRCN
 6kE7sWcOUqvmUhExdoQLHJkQ3EMDDro6BQJO1Izzd/LdLkfweSOIPm+Dpf1qhvRVc5/t
 isOesbC/vBXcNGGviV0BuctWogKKZF3AWXb8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595884; x=1710200684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Txx4HuJ7LC8E06Hjv+jeDWg48QiTN//eztqxVLiThdM=;
 b=KaoGtwGqRrtUaj8ZBOquu7Xe3GRmAS3EHgmtY7rLEbUk3RLrk0AvrzdPIX/LkHiuv2
 IBEhUQotl1QND2+qG6m+opkn++q7fpEvjDHffsqMMqdK2GGCt+eDrPcHhwAkUJjz5ee8
 t9yQJXJLhYV0uPiWLpHemOLnMqn8kezsHV/Xc5OuWj8Dfv9TnOt1zv6acvy2Og28TeK1
 benhOad9xlJCmLET9w2ohFHW7G/EyWhMRBjSQ62JMXjHKYoN6CO/9wW7fXsJ8mSE40Cf
 8X3V+m0zM06wXkVRedA3IeGUnBhkGMHN6/WQzNkPeG7rxte7uRhupFiK0HOFok7URqy7
 TRNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBdntfoLiKiMWqC6JGFbfaSx5KYV6IuWa6pJwoRotm74nLltOW2ggq5xVNYJ+TNBpqgYDOcQD09HCm/IpKZIZBKGskmg==
X-Gm-Message-State: AOJu0YxRRK58hcuHfj4Enf+H+4eFDCqgkrTfJQV+G2hViuTlG9F9frTp
 Wc0+TCN/Nm7mGM4k5itQRR23RE9fu38KmqFFzVCaHkRGy7QXP3JM2F0Sf1ONTEU=
X-Google-Smtp-Source: AGHT+IGaQcE5Vdo5aS4jLTqiOEbgABgKi2flSR5RuOZ7jrFNPGgWXcteiDn/4j1zXAePlJ8SRGXJ4g==
X-Received: by 2002:a05:620a:880b:b0:787:caee:4309 with SMTP id
 qj11-20020a05620a880b00b00787caee4309mr319870qkn.31.1709595884449; 
 Mon, 04 Mar 2024 15:44:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 g28-20020a05620a13dc00b00787d6814c10sm4850799qkl.13.2024.03.04.15.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:43 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Apurva Nandan <a-nandan@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Tianling Shen <cnsztl@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Bhavya Kapoor <b-kapoor@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH v10 00/15] Introduce initial TI's J784S4 and AM69 support
Message-ID: <20240304234440.GX1523872@bill-the-cat>
References: <20240223202153.3756094-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0SUzh+Exun6TvpJE"
Content-Disposition: inline
In-Reply-To: <20240223202153.3756094-1-a-nandan@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 05 Mar 2024 00:45:53 +0100
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


--0SUzh+Exun6TvpJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 01:51:38AM +0530, Apurva Nandan wrote:

> Hello Everyone!
>=20
> This series will introduce basic support (SD and UART) support for Texas
> Instruments J784S4 EVM.
>=20
> The J784S4 SoC device tree patches are taken from kernel patch submissions
> and will be updated as they are accepted and merged to the kernel tree.
> All other patches are specific to SPL and u-boot and do not have
> dependency on other trees. Appreciate a review for acceptance to u-boot
> tree.
>=20
> Here are some of the salient features of the J784S4 automotive grade
> application processor:
>=20
> The J784S4 SoC belongs to the K3 Multicore SoC architecture
> platform, providing advanced system integration in automotive,
> ADAS and industrial applications requiring AI at the network edge.
> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> raising performance and integration while providing interfaces,
> memory architecture and compute performance for multi-sensor, high
> concurrency applications.
>=20
> Some highlights of this SoC are:
> * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F =
MCUs,
>   4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) =
for
>   deep learning and CNN.
> * 3D GPU: Automotive grade IMG BXS-4-64 MC1
> * Vision Processing Accelerator (VPAC) with image signal processor and De=
pth
>   and Motion Processing Accelerator (DMPAC)
> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and one
>   DPI interface.
> * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
>   support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role
>   device subsystems, Up to 20 MCANs, among other peripherals.
>=20
> See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
> for further details: http://www.ti.com/lit/zip/spruj52
>=20
> In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It
> supports the following interfaces:
> * 32 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x2 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>   UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances
>=20
> Schematics: https://www.ti.com/lit/zip/sprr458
>=20
> AM69 SD mode bootlog: https://gist.githubusercontent.com/apurvanandan1997=
/1b2c55d0204ff0f5a47ebbc196a97e99/raw/
> J784S4 SD mode bootlog: https://gist.githubusercontent.com/apurvanandan19=
97/5e2ef85ee4322798d22b57a60dc917db/raw/
> eMMC UDA moode bootlog: https://gist.githubusercontent.com/apurvanandan19=
97/3cffada252d50a8aa0c00a91f1f2f856/raw/
>=20
> Note: This series is dependent on the following series for OF_UPSTREAM su=
pport
> https://lore.kernel.org/all/20240222093607.3085545-1-sumit.garg@linaro.or=
g/
>=20
> And, '[PATCH 01/15] Makefile: remove hardcoded device tree source directo=
ry' has been
> cherry-picked from PATCH 11 of https://lore.kernel.org/all/20240201030634=
=2E1120963-16-bb@ti.com/ by Bryan Brattlof
>=20
> Changes in v10:
> 1) Fixed build failure due to missing OF_UPSTREAM in a72 defconfigs
> 2) Updated paths of board dtbs in binman.dtsi, CONFIG_OF_LIST and CONFIG_=
DEFAULT_DEVICE_TREE

For the series, applied to u-boot/next, thanks!

--=20
Tom

--0SUzh+Exun6TvpJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXOgACgkQFHw5/5Y0
tyxQmQwAi160PsgCtmbFKpgC4FgOw1fJcXLi82pAAY04mk/P/GXrl5Vlp5uJ0QgN
bJi0CGEy3EDUs5hDXckkM2kVlbdWQPrrMMpVcZj/19XlTjjB4++BigQpfpmJcfXj
moR2qDJdjsNgyuEqPlr3d62LiWvrKKGB4N/uL6Mqj3mek1PPvQ7/bDIl4Raznv6f
DKK54rpVVJHetY6EcgNH+dJk0yqjSwRF/TXWSWs6taD2gR2DdQXRZy5qnvpriQHJ
uhqzwYwq67qA82rarF4ZO9zudqGRZydU33bE6uvykz0kgD69BYsPtoiOGv2IY4vy
x2CWuK4iCJscr4vSYSmAzHnpHwYB+oZz5snOMluOQl5UD9MV47eZlC52BlAJcoJe
z+KP+aGpMIeKKcH788M3DxibW62vNyC9D99ibdE1HkKvPtdhBHXOl/BDRcftZsbX
hDUX91/GUwPOQMPCKDLXciU846zhyGk5tBvTg03iNF1N2vTnfFb4gL+0REphhR7u
Sz99Z9u+
=6rN7
-----END PGP SIGNATURE-----

--0SUzh+Exun6TvpJE--
