Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42C6C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 15:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 254B288757;
	Tue,  7 May 2024 17:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FcIPtdXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D86F8872F; Tue,  7 May 2024 17:48:44 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F7A88794
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 17:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4df36a7a6f3so915522e0c.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715096920; x=1715701720; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+J6zW+JnnMQRQz6f+yH7DZ11KZzPvuGbDyktuiRGHSE=;
 b=FcIPtdXtS2MFNmGgaThn3eqF3nAv3oE2KMhWfQJXmYsNAUS71P8Boa0VPSa96zbkAw
 s8X9Bz++wKE+ULUUldELN/v6TCNsdzmXnc3IfP/LcvOHpdMcX48R/lWkEeVgl3oE4sWw
 9L34rWKd8/j2fmjStOTmra76vioQpaCKxAKjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715096920; x=1715701720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+J6zW+JnnMQRQz6f+yH7DZ11KZzPvuGbDyktuiRGHSE=;
 b=bvFcNGsWDAVoFYbJ285PaRnAgfGzF2vqzEpPGrSqePxJkAnKDGoU7IJz8hAsEWMSyo
 GPHr9nANea9zlmZSriWSbZVnLucUdE+DKq4NBqfRc0Aoelg+NuztLVRG308/tdeoMbw9
 /PQzN2A9LdKKlHg+OWgC7xNgyTJ5mbpOfSOl9Ohjnq7YTyzzZm0uyuav346MFB+cB6BY
 OK4mkrYZQPDEgtnl9tFaGOQno/82KJg45Ykoj4fCuDLoragrJadjz0xnGikDW4YHXab6
 UQfL+onH5aCiXL4hsVxalnkyVB1MXEZmyNEV2f8Pa5S1CeHJJkBnU/P0K/oL3Jji6RmA
 MW9Q==
X-Gm-Message-State: AOJu0YxeyRCO7dtZbcYd8UARMBG59rd/8jbDRbvjPAJhEF042K1p5G8f
 zkj7bfb9g8wpx4eu6iEvL7Rreieq6LwK3DZ8CQBwxlpm+667Dk4JQaAW0iyFchs=
X-Google-Smtp-Source: AGHT+IGo/l/vgKjb4eVD30Iurabb421LL2E78RZNztnCu4rmILcRnflCXP0WCTlcjR+QZwxUO2wgJg==
X-Received: by 2002:a05:6122:179b:b0:4d8:7d49:18fe with SMTP id
 71dfb90a1353d-4df587ea7a8mr2920946e0c.4.1715096919765; 
 Tue, 07 May 2024 08:48:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a1ff203000000b004da6fe03e52sm1494101vkh.44.2024.05.07.08.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 08:48:38 -0700 (PDT)
Date: Tue, 7 May 2024 09:48:36 -0600
From: Tom Rini <trini@konsulko.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Simek, Michal" <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
Message-ID: <20240507154836.GV2568172@bill-the-cat>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
 <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MaXoJorSLg65DlAf"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
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


--MaXoJorSLg65DlAf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 04:15:14AM +0000, Abbarapu, Venkatesh wrote:

> + Tom Rini
>=20
> Do you have any comments for this series?

Seems likely fine. Jagan, do you have time to put this in a PR for
-next? Thanks.

>=20
> Thanks
> Venkatesh
>=20
> > -----Original Message-----
> > From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > Sent: Monday, March 4, 2024 8:41 AM
> > To: u-boot@lists.denx.de
> > Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
> > git (AMD-Xilinx) <git@amd.com>
> > Subject: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories sup=
port
> >=20
> > This series adds support for Xilinx qspi parallel and stacked memeories.
> >=20
> > In parallel mode, the current implementation assumes that a maximum of
> > two flashes are connected. The QSPI controller splits the data evenly b=
etween
> > both the flashes so, both the flashes that are connected in parallel mo=
de
> > should be identical.
> > During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> > nor->flags.
> >=20
> > In stacked mode the current implementation assumes that a maximum of two
> > flashes are connected and both the flashes are of same make but can dif=
fer in
> > sizes. So, except the sizes all other flash parameters of both the flas=
hes are
> > identical.
> >=20
> > Spi-nor will pass on the appropriate flash select flag to low level dri=
ver, and it
> > will select pass all the data to that particular flash.
> >=20
> > Write operation in parallel mode are performed in page size * 2 chunks =
as
> > each write operation results in writing both the flashes. For doubling =
the
> > address space each operation is performed at addr/2 flash offset, where=
 addr
> > is the address specified by the user.
> >=20
> > Similarly for read and erase operations it will read from both flashes,=
 so size
> > and offset are divided by 2 and send to flash.
> >=20
> > Changes in v2:
> > - Fixed the compilation issues.
> > Changes in v3:
> > - Fixed the CI issues.
> > Changes in v4:
> > - Removed the dio,dummy_bytes variables from zynq_qspi driver.
> > - Fix the compilation issue by including the DM_SPI config.
> > Changes in v5:
> > - Fixed the issue reported by buildman.
> > Changes in v6:
> > - Fixed the issues reported while running the sandbox test cases.
> > Changes in v7:
> > - Fixed the issues reported while running these da850evm_defconfig,
> >   imx28_xea_defconfig configs.
> > - Fixed the issue when DM_SPI config is disabled.
> > - Fixed the issue while running the sandbox_noinst_defconfig with spl
> >   ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
> >    jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
> >    jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
> >    ### ERROR ### Please RESET the board ### Changes in v8:
> > - Fixed the compilation issue with imx28_xea_defconfig.
> > - Fixed the SPL size issue with the axm and taurus defconfigs.
> > - Rebased the patches on top of next branch.
> > Changes in v9:
> > - Updated the commit log why SPL_FIT is being enabled.
> > Changes in v10:
> > - Added the new config SPI_ADVANCE to fix the issue while enabling
> > imx28_xea_defconfig.
> > Changes in v11:
> > - Removed the unused variable, corrected the type of variable and repla=
ced
> > memcpy with memmove.
> >=20
> > Ashok Reddy Soma (4):
> >   mtd: spi-nor: Add parallel and stacked memories support
> >   mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
> >   mtd: spi-nor: Add parallel and stacked memories support in read_bar
> >     and write_bar
> >   spi: spi-uclass: Read chipselect and restrict capabilities
> >=20
> > Venkatesh Yadav Abbarapu (4):
> >   spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
> >   spi: zynq_qspi: Add parallel memories support in QSPI driver
> >   spi: Add the spi advance options for non SPL
> >   config: xea: Enable the SPI_ADVANCE config option
> >=20
> >  configs/imx28_xea_defconfig    |   1 +
> >  drivers/mtd/spi/sandbox.c      |   2 +-
> >  drivers/mtd/spi/spi-nor-core.c | 399 ++++++++++++++++++++++++++++-----
> >  drivers/spi/Kconfig            |   7 +
> >  drivers/spi/altera_spi.c       |   4 +-
> >  drivers/spi/atcspi200_spi.c    |   2 +-
> >  drivers/spi/ath79_spi.c        |   2 +-
> >  drivers/spi/atmel_spi.c        |   6 +-
> >  drivers/spi/bcm63xx_hsspi.c    |  42 ++--
> >  drivers/spi/bcm63xx_spi.c      |   6 +-
> >  drivers/spi/bcmbca_hsspi.c     |  34 +--
> >  drivers/spi/cf_spi.c           |   6 +-
> >  drivers/spi/davinci_spi.c      |   8 +-
> >  drivers/spi/fsl_dspi.c         |  18 +-
> >  drivers/spi/fsl_espi.c         |   4 +-
> >  drivers/spi/fsl_qspi.c         |   4 +-
> >  drivers/spi/gxp_spi.c          |   2 +-
> >  drivers/spi/mpc8xx_spi.c       |   4 +-
> >  drivers/spi/mpc8xxx_spi.c      |  10 +-
> >  drivers/spi/mscc_bb_spi.c      |   4 +-
> >  drivers/spi/mxc_spi.c          |   6 +-
> >  drivers/spi/npcm_fiu_spi.c     |  14 +-
> >  drivers/spi/nxp_fspi.c         |   2 +-
> >  drivers/spi/octeon_spi.c       |   2 +-
> >  drivers/spi/omap3_spi.c        |   4 +-
> >  drivers/spi/pic32_spi.c        |   2 +-
> >  drivers/spi/rk_spi.c           |   4 +-
> >  drivers/spi/rockchip_sfc.c     |   2 +-
> >  drivers/spi/spi-aspeed-smc.c   |  28 +--
> >  drivers/spi/spi-mxic.c         |   6 +-
> >  drivers/spi/spi-qup.c          |   4 +-
> >  drivers/spi/spi-sifive.c       |   6 +-
> >  drivers/spi/spi-sn-f-ospi.c    |   2 +-
> >  drivers/spi/spi-sunxi.c        |   6 +-
> >  drivers/spi/spi-synquacer.c    |   4 +-
> >  drivers/spi/spi-uclass.c       |  34 ++-
> >  drivers/spi/stm32_qspi.c       |   2 +-
> >  drivers/spi/stm32_spi.c        |   4 +-
> >  drivers/spi/ti_qspi.c          |  14 +-
> >  drivers/spi/xilinx_spi.c       |   6 +-
> >  drivers/spi/zynq_qspi.c        | 119 ++++++++--
> >  drivers/spi/zynq_spi.c         |   6 +-
> >  drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
> >  include/linux/mtd/spi-nor.h    |  12 +
> >  include/spi.h                  |  23 +-
> >  lib/acpi/acpi_device.c         |   2 +-
> >  46 files changed, 792 insertions(+), 228 deletions(-)
> >=20
> > --
> > 2.17.1
>=20

--=20
Tom

--MaXoJorSLg65DlAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6TUkACgkQFHw5/5Y0
tywjLQwAk7abGaMmDkQuB8rHov1wwIQ1voeipb6ir5LbROcN97qY3pwVwWV4KuNX
OaCXzGzRUBCXSj5H3Oqq8DEDjQKPYNAhvhtZho/HEqYtBg7wRHBiLIBZGTkpKu8G
kudzhQMy2jlBLt4X608Gp0qweFBJIkbGFLbaPJ0FyN9SwWoNMB1lSNL3dbBjY/xt
qwnvrg5MuudwJPhfazMq/Yx33bxFpnYwl/BD1oxrJXu8B2nwf8yIPM2mU4PhToFG
kCyajBhCLu3G9HJWSc0+ov4X0fOIqPVTJsedMUNV7ebHs8qpYQObBVpHV8AmhAWX
HSJSdYhixGTTFpCVQi00MrMWnL2qZ1qR9ziLPmrAVW6VwXIbejtCmbu9wHFxCroe
TRrm4t+EZ9sF/0lN8esaoHlfm1Ao4a/OAH+ISedb5cbY9rJdbEF9VHuRlrqq6EHa
x8JXPHThAt8qdU8cU8TxoSzsUhM56AY50CG4idRaiRxp126fUIgm0RYOurVTU8Cf
joxmr1Rt
=Fooa
-----END PGP SIGNATURE-----

--MaXoJorSLg65DlAf--
