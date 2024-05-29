Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9717C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AB388645;
	Wed, 29 May 2024 18:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RCeD5muQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41E988606; Wed, 29 May 2024 18:13:27 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509208803A
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-43fab2fa4ccso11751261cf.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716999204; x=1717604004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RiOSRIPApg8h4sD92n2tzbK05AumOVxG6dZLEZOVUzg=;
 b=RCeD5muQ55ML1Wk2Ru+7yPBf2CG6Xq0n0B3X/hXfUdQ+t9JY+XQnnU+rT1+xu0tbGC
 wXc/uDRtQIde4MfK1C0WFMo9yUay/RslYMo6AqsxSRJ1J6i4K2HNeWx6h+XQZ5ZrnCwE
 7QKQzCP1YebRVmIu4LuHlQY/r5ojKGoX5wXuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716999204; x=1717604004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiOSRIPApg8h4sD92n2tzbK05AumOVxG6dZLEZOVUzg=;
 b=f6D+1DUC0xzXxfBQEZ3RdIRYVYLP4z0USOLEjh9BvrYRMYDcMJ5/Zf9zlPwpWpoS+k
 sa7oYKffowQMuC50LPUvplUboXKBZyrLl2HfB+icTL7r9NL7QRZ+BSqIO3RI+wTblU+d
 k92JCfuLV6H5eKKoTIzsKriQpYMG0/pbEfEhPVNFjWKiBZjUsN4H1Y3H8VEQkP10NOP3
 5iKH+G7Ydyz4sMEi4bhoLI+ysMoTQikd018VHN460UScmWDVf75cNTzi1koriGRuDSAW
 BziLHt6Q0De6mIieAFMDpcdXPNcJpoJQFpK2gfRqfZuwMi0ejqvdX1qSaORgijHcY5mn
 kW3g==
X-Gm-Message-State: AOJu0YyJh1X9cOjfXK0fFhQLQAQhrDvowFxFPUHVi7bX78K2Au4/ytko
 epurs1wyrXsy/CTz7oV/Ly3jRhHLhkT29kibjXNSr9nffm93y4ALJ2M+sB/0d78=
X-Google-Smtp-Source: AGHT+IFEZGtKz4841g1yv/BgkhPw1009eRqBRd7LCfMsAWpMSitl2mDjGzisTRsYt0t79IVbkKJ6XA==
X-Received: by 2002:a05:622a:51:b0:43e:17e6:606f with SMTP id
 d75a77b69052e-43fb0f1ddb4mr180173011cf.67.1716999204055; 
 Wed, 29 May 2024 09:13:24 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fd54f4a5dsm22571931cf.97.2024.05.29.09.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:13:23 -0700 (PDT)
Date: Wed, 29 May 2024 10:13:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Fabio Estevam <festevam@denx.de>, Hai Pham <hai.pham.ud@renesas.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Igor Prusov <IVPrusov@sberdevices.ru>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "Polak, Leszek" <LPolak@arri.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH 0/4] arm64: versal2: Add support for new AMD Versal Gen 2
 SoC
Message-ID: <20240529161316.GP2568172@bill-the-cat>
References: <cover.1716994063.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="88qvoevRhv0Qy4Ms"
Content-Disposition: inline
In-Reply-To: <cover.1716994063.git.michal.simek@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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


--88qvoevRhv0Qy4Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 04:47:57PM +0200, Michal Simek wrote:

> Hi,
>=20
> I am sending patches for adding initial support for new AMD Versal Gen 2
> SoC. If you want to find out more information please take a look at this
> page:
> https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
>=20
> Thanks,
> Michal
>=20
>=20
> Michal Simek (4):
>   arm64: versal2: Add support for AMD Versal Gen 2
>   soc: versal2: Add SoC driver for AMD Versal Gen 2
>   mmc: versal2: Update zynq_sdhci driver to support AMD Versal Gen 2
>   spi: versal2: Enable spi drivers for Versal Gen 2

My only concerns are name-related and not-blocking. First, should we
perhaps instead have arch/arm/mach-versal/{gen2,net}/ (and presumably
gen2-net down the line)? Second, and I see I can't say we should follow
the Linux kernel since there's no versal dts files upstream, should we
still be "xilinx" and not "amd" ? I do see the kernel shoves all the
imx8 (as an example of a modern part) stuff under
arch/arm64/boot/dts/freescale/ and if nothing else we should be
consistent between projects whenever possible. Thanks.

--=20
Tom

--88qvoevRhv0Qy4Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZXVBkACgkQFHw5/5Y0
tyz1jAv/XCMd0LoEJXu5ASWhosKtpEI7mWIdIFCnh45zEtTKyKm0ASrzCtvRrzTZ
oCW5ubOzS9wv8ETpJQTMY42ZbllNig4AqULcewGzv6JPapjBz07ul7dk5k+kOV99
cvsBUKwgknZ4avPCFKz3U06ZsiJHmETMObxz8LdA4cMBxtHxpLDkLbTfSP2VV9ZG
1Fb3rEVD+JK0LTCo2PxsM3YvGTyVUSp2vGSj0RXjFKBOj3kBEglj5FY0D2HIT6St
7JH+2NAltx5E7cg4rmg8MmmhMlwX12lO8gLrSoUD4hKWti6RUjk8WCaCNGnzkDEo
0y8CP6C7sL21pplzVf8KE/DgIRLyFVaZWxHinA+xnzxxIX/fGOhiuR1yPxcaEfm3
lTYQPh6Mc54Q1895jEVDrOWsNSvQUKg5ppKjXF6bkf3Xbl8pMjxFzdFHwpMyeIUF
NawWcBVzq328BFq6C3dOqGd4TkG39maNYcDL9QUUmFpPnKsGCQPMXNbz2/n8F+fV
oRXyZ6oJ
=J5bH
-----END PGP SIGNATURE-----

--88qvoevRhv0Qy4Ms--
