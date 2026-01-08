Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D88ED1488A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 01:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7933183A26;
	Thu,  8 Jan 2026 02:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LdT3YdDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9510283A2D; Thu,  8 Jan 2026 02:51:24 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7247B839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 02:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e8819eda8bso1004992fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 17:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767837081; x=1768441881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xl83A0AghRn0grhXtgVNTxfUS5ogSYDmsayrctQiL0o=;
 b=LdT3YdDT7DHueTMm39iM4mo6XKabezo+S1eUSmFsXL1c+G+vWio/tknwjiVgEO11Hf
 wWDEfyjTvcUsBoqr4MYXEt+caS+aMHxZ2kCPcyftb4jE/g3OrhsyVr/FX/KrQD9cmv9j
 O3XU+gUKvWl2sX932CKzo6Aqa5cQoQqdasZeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767837081; x=1768441881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xl83A0AghRn0grhXtgVNTxfUS5ogSYDmsayrctQiL0o=;
 b=e3YivZdFl/mcwtu/MSFR8VvscN2niKRG4eAx3VD8QtCn04hSw2/PL6z6dUE0XpbIHS
 wX3bYnl2SD+TCxi26OT4y5KSqEC4qaZiwZm2cMOk4B/X+kHiyhYHQePui3B8o9sHxqnP
 yUSmKtCSzdhzUTDU3oyIa0RU1JRuQZvzjs6UfHwg1eYPJFbrYUTMXMjtR7k6UdTQ+u5D
 xYdp55ZBwUGr+5X6UrQMyY/VgqDqzpcodGNmfVoSR2XDrk0zB14PRqsJKcoUIxe9g7ok
 8QYl8QgI/nfTMYxOA/wrfYxO0RQ89LbnxTnd08lA3581S94cNgbGLRIjq8Ng6bEyDxIv
 t/7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4mgyK0NPOxO2lJlniR8GmGSq31lFTNjBJGBkO8fMPRPdXpseIHSr0Ge5O4PhEgGVX1+hYIM4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1e55OleMSWfOfVxhlPzrT7HlDiav5Tr2EOWXYAcdxt+whqObW
 8Yx2mSxRICFIazAY/ZbDjWsCMUbBcQTm17dwUdocDRhSsNHPjO7k7hON6T642JDbhgI=
X-Gm-Gg: AY/fxX5136W08hYpXzMQO319YwlcjgriGVSjlTvI0nguYPLT3NDfjn9f6a96Bj1TDxT
 vmn+ACPn5VxM0Pz3YvPqQ1Qh67TXvtpOHK8NjZsHYFoThWURrNW/ew/fAhcLmvpeaIocRHnhnzl
 xKuT9rBnS/qDTZl80YXc7rI2T5q8lOia3VJw/wL2n6eoVrjfU/W/TFepC4bqz1pHZWlR405pLr9
 COWspKXoELkc0xPmz4YxPL15o1TsWLqdX2OsVA+DQLM6Hs9ozBMgG3b1HLX0tuOBlfYZKW5H1M6
 +UWlsAVHAUIAjkBB4AIc/VTtRRMsdQpjn91Vt9RzGsXi67S3rAnoDQFr7uOQ/BefhD/LTdhci+A
 sT0b0Hf/FnJ3ZrqZNNG9yl4U6h1uUkNQ2dLoFrHYxgEhe3OpGRPZp1M4OL90J2So4UE7RibN9Es
 hGt+OWHr7d1ElHTUDiiL39QefwfFhNQRQbyUAHvKxB7QmO3Zigy3SRUquUthwbqVI/xeQD1iQRJ
 3ZBwS7xNDvJ+ET6Y4p5Ms2yiv+VSUwaTKgkFes=
X-Google-Smtp-Source: AGHT+IGHH1YN/pvFGFw1ppH12jet+WZFc7rwUt+A63EH1ccGhPR+jJKglUo+rtqFwPw2IUrgn9Cy9g==
X-Received: by 2002:a05:6871:e00c:b0:3e8:8e56:671e with SMTP id
 586e51a60fabf-3ffc0badc45mr2048170fac.54.1767837080928; 
 Wed, 07 Jan 2026 17:51:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50721a6sm4305248fac.10.2026.01.07.17.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 17:51:19 -0800 (PST)
Date: Wed, 7 Jan 2026 19:51:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Stefano Babic <sbabic@nabladev.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Heiko Schocher <hs@nabladev.com>, Alexander Dahl <ada@thorsis.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
Message-ID: <20260108015114.GP3416603@bill-the-cat>
References: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
 <20251226-xspi-v1-1-4bb116750dba@nxp.com>
 <20251226145748.GD710860@bill-the-cat>
 <CAOMZO5DxdMTcFjrNi10dCQ2Fwjj7VRipFE3Ns2LRKNRor5Vi-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UvBS3Sx9qW87tZq9"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DxdMTcFjrNi10dCQ2Fwjj7VRipFE3Ns2LRKNRor5Vi-w@mail.gmail.com>
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


--UvBS3Sx9qW87tZq9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2026 at 10:31:56PM -0300, Fabio Estevam wrote:
> Hi Alice,
>=20
> On Fri, Dec 26, 2025 at 11:57=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > > +config NXP_XSPI
> > > +     bool "NXP XSPI driver"
> > > +     depends on SPI_MEM
> > > +     help
> > > +       Enable the NXP External SPI (XSPI) driver. This driver can be=
 used to
> > > +       access the SPI NOR/NAND flash on platforms embedding this NXP=
 IP core.
> >
> > Does this driver build on sandbox? If yes, great, if not, this needs
> > more specific "depends on" logic.
>=20
> Please address Tom's question so we can move forward with this series.

Especially now that CI runs "allyesconfig".

--=20
Tom

--UvBS3Sx9qW87tZq9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV8NjwAKCRAr4qD1Cr/k
Cj+gAP0VWNpdsG9PI4Uns4Pdha5MVt5Rs7/19MtoXHHWjMIR0AD/e7TuV+MEWzBO
P4xQscZpI56Y0/JeH48RQEhfHBjnoAU=
=kk4G
-----END PGP SIGNATURE-----

--UvBS3Sx9qW87tZq9--
