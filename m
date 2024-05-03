Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5A1C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69990884E6;
	Sat,  4 May 2024 00:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="duMbiruQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4639881C8; Sat,  4 May 2024 00:20:54 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E56881A1
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78ef9ce897bso6461885a.0
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774850; x=1715379650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UuMyIQ+PhdtZzrHSUis3C2vN1q9nJo0xEccP5gmjQak=;
 b=duMbiruQwD63dhIDt28xXtmfvLxHa/CtRaLJyvXBzFauBHbcqAH40G/ChEuRbX2syU
 PNq9bVsvLNAXYSaqQU80tOZrOpDHQ6+dgunb0XJSRUALw2Tp+Qx4QTFmA2qU1YcCO1/Q
 TEhHj9Ok2JDO2mCELxd+yOo7z29QTVA2V0PAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774850; x=1715379650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuMyIQ+PhdtZzrHSUis3C2vN1q9nJo0xEccP5gmjQak=;
 b=Djcwh/LSNcSqDPvgU3IlrAhq9Q5ZB7DcG3wgdYxPeEWpsUNueynhTCr/hK+FaJNjiD
 WoN4ejH1yXVL52jE7eJKS+a5OeqNPCeulOo/T6l38ja5CctzrWK6tV0VckUQFvogjNkt
 1YI2kjTFfVPgvUop+SAaVKoUsZOzDu3EkpgbyAa5+E95lEDz5BNEHKBGt5pnyY5PIU08
 wSTVSXcRXaNA73zhEOVgB/OflZHrIgOlbDg/woMngqaeAD+HEEFwYviifYhppFEz6qiN
 VeuAvDJ2zUXykNa2j6MhohcSnrm9TCEtqXVBQ7IMW6V3LoL+I0qdQdRMRjDRyPTJp8Sy
 4NwQ==
X-Gm-Message-State: AOJu0YwxXrAOvSCcIZ2V4nwp2uMZaSgO2zajoDQwnvHTyGC3oPWMlh6v
 fZXChMKQskw7jpQzyRxtmupGJCCGsmybOk6NGtF5ito74vy65O+cFNU3AdkIrdU=
X-Google-Smtp-Source: AGHT+IHxChlUF/VpHExtI4TXVRfet+DFDxMalHnNerd+zbXE+sgTKOEHkBnZv3ZZd2Hh2z7QBLGAJw==
X-Received: by 2002:a05:620a:56c1:b0:78e:d2a8:b4de with SMTP id
 wh1-20020a05620a56c100b0078ed2a8b4demr3801849qkn.20.1714774850451; 
 Fri, 03 May 2024 15:20:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 wx56-20020a05620a5a7800b00790629248d4sm1588219qkn.110.2024.05.03.15.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:20:49 -0700 (PDT)
Date: Fri, 3 May 2024 16:20:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <greg.malysa@timesys.com>
Cc: u-boot@lists.denx.de, Matthew McClintock <Matthew.Mcclintock@analog.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Rick Chen <rick@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: Re: [PATCH v2 0/4] arm: Add Analog Devices SC5xx Machine Type
Message-ID: <20240503222042.GA2568172@bill-the-cat>
References: <20240425000515.21896-1-greg.malysa@timesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cGQnkO1b8RgbQWGP"
Content-Disposition: inline
In-Reply-To: <20240425000515.21896-1-greg.malysa@timesys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 04 May 2024 00:22:10 +0200
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


--cGQnkO1b8RgbQWGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 08:03:59PM -0400, Greg Malysa wrote:

> This series adds support for the ADI SC5xx machine type and includes two
> core drivers that are required for being able to boot any board--a UART
> driver, the gptimer driver which is used as a clock reference (CNTVCNT
> is not supported on the armv7 sc5xx SoCs) and the clock tree driver. Our
> corresponding Linux support relies on u-boot configuring the clocks
> correctly before booting, so it is not possible to boot any board
> without the CGU/CDU configuration happening here. There are also no
> board files, device trees, or defconfigs included here, but some common
> definitions that will be used to build board files currently are. The
> sc5xx SoCs themselves include many armv7 families (sc57x, sc58x, and
> sc594) all using an ARM Cortex-A5, and one armv8 family (sc598) indended
> to be a drop-in replacement for the SC594 in terms of peripherals, with
> a Cortex-A55 instead.
>=20
> Some of the configuration code in dmcinit and clkinit is quite scary and
> causes a lot of checkpatch violations. It is modified from code
> initially provided by ADI, but it has not been fully rewritten. There's
> a question of how important it is to clean up this code--it has some
> quality violations, but it has been in use (including in production) for
> over two years and is known to work for performing the low level SoC
> initialization, while a rewrite might introduce timing or sequence bugs
> that could take a significant amount of time to detect in the future.

I gave the series a cursory look, and CI is also happy. I will put this
in to the -next branch sometime soon after it opens, thanks.

--=20
Tom

--cGQnkO1b8RgbQWGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Yy8ACgkQFHw5/5Y0
tywtIAv+NuIzqnRLCud1MPFD9xGvMtm+dPGmvsevK/oUR+lKP2bIBYfC2Vd8uQgP
SCOGSMfBFtSRo/D+h6ce+mBx9EB9rtX20ELe+R6wx/q60rs6werzQpM8BsPJGBua
7sWtvFIXeG57YR7IOXbCgnYW1L3DHKX06yJPNqkFx/XfE9adWUimb2qNMdl+b+QS
ycg3/yBykFrQo4isSk8Wf8hwiG14q+6X7PTomMv7tRHQaD8iWsDrxX0RppTVtCaQ
FX8fSAPi/Bd845asfy971KC5Xa7BK0rLtwIMf5rqKGZGRHWn5B5VvsA8ww0E3tQg
DrsSTvlDa0MbJv2sbP+Zs/mRkvlCHWE8NGMX0YMZVEuqF2kq2Otob8DkJwR07L11
ShUykSLbSjoiyMBNCUhQcGGY1ecmgXBzFHK1NdxdyvxK60ze0MHZzbHRJdEJ6eVj
T21NHCVJPCUgMvyHYJLFcKbEBUhhw1y893Iwbd9m0rRH2n6DxeA2CdOYZdY/kx3I
wJmzOhJH
=H5Xc
-----END PGP SIGNATURE-----

--cGQnkO1b8RgbQWGP--
