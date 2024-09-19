Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBEDCF3973
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 22:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A118921F;
	Fri, 20 Sep 2024 00:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TcNyx69X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C26892DF; Fri, 20 Sep 2024 00:05:53 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0229E891B2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so7830966d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726783550; x=1727388350; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IrDvbgeUCkqwEFQb2TD7mq3U+aNSiobQJQnWWN3dhWc=;
 b=TcNyx69XjDMwXrfrxmgoy5nFIkizA08VMsDPMHt0ZQJ+sIXBo4CccEM2hC9rnOjPF4
 ZLr3mMarCra7tOHtQ61M/F30kOd6qSRGqu5wWr4M3laZ6JotxF/4wkoYj/ix5oD78VST
 DL2uMhm890RrZ0BkM7OSCTsvOslFcKzmLzFPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726783550; x=1727388350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrDvbgeUCkqwEFQb2TD7mq3U+aNSiobQJQnWWN3dhWc=;
 b=hUdD3vzGgZA5eykxjny3+l//nXbtym+hQ9hURGePQSzm4cel8FpXzvVk2kZhOxuAZa
 Gdg6Jv+PCoQ9r6pvUDS3UogUnhdWOh+7O6KjykhhqdZyNhK3j7mqhnUfosUdmCnU4Npf
 pqREA3+/WctbgLEMahyXOWp5102NPybsWuJ2in/6lz1+D8qtQJZynXZ3dVp9g5p79DJQ
 pP9O+CyQzpIzvCs6vRG5urRVxPAlHDNj+d71fsCQt6sEwpBtOpOU8pmMUpi1waQ0HfFp
 ARCw+fji2FyLBhH8BQPy6FMbkkOtg7ZioUFj7NBZm03VMysnfsLpIfQ0/2rgcs5S9B9y
 2bNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOFwMpX0vrt5AGtRBi9RYqrOlbs3jm5e1bGmKmMfl2Sx6EBkuyBit4pH3gO/bl0FpjRmxccpI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn2BjaKM/rx8p18GoQykrC3RQu0ZHJlpshAgJrwGCI/RdeA2XI
 2ZVuOlOFJIMX1nvbNONk9YLGrxtl9bL8VleOqhXY2tIZlmwkV9ht2UWscTO7ElQ=
X-Google-Smtp-Source: AGHT+IH8GqB58CX4jJcu+vnHxfSAeC6a3QSzYA1t2418y45ysM0OTpj7Im7EWA1k03s/HEouvsyWKQ==
X-Received: by 2002:a05:6214:2b85:b0:6c5:8601:fdf7 with SMTP id
 6a1803df08f44-6c7bd57b0e0mr5849106d6.41.1726783549683; 
 Thu, 19 Sep 2024 15:05:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e557d56sm11299996d6.96.2024.09.19.15.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 15:05:48 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:05:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, jagan@amarulasolutions.com, git@amd.com
Subject: Re: [PATCH v13 0/8] spi-nor: Add parallel and stacked memories support
Message-ID: <20240919220545.GV4252@bill-the-cat>
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
 <9ab7d67e-1e6a-4176-b448-7724b0ce7615@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dzEzL8qlpKI3Znj8"
Content-Disposition: inline
In-Reply-To: <9ab7d67e-1e6a-4176-b448-7724b0ce7615@amd.com>
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


--dzEzL8qlpKI3Znj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 01:18:10PM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> On 9/5/24 05:21, Venkatesh Yadav Abbarapu wrote:
> > This series adds support for Xilinx qspi parallel and
> > stacked memeories.
> >=20
> > In parallel mode, the current implementation assumes that a maximum
> > of two flashes are connected. The QSPI controller splits the data
> > evenly between both the flashes so, both the flashes that are connected
> > in parallel mode should be identical.
> > During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> > nor->flags.
> >=20
> > In stacked mode the current implementation assumes that a maximum of two
> > flashes are connected and both the flashes are of same make but can dif=
fer
> > in sizes. So, except the sizes all other flash parameters of both the f=
lashes
> > are identical.
> >=20
> > Spi-nor will pass on the appropriate flash select flag to low level dri=
ver,
> > and it will select pass all the data to that particular flash.
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
 so
> > size and offset are divided by 2 and send to flash.
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
> >    imx28_xea_defconfig configs.
> > - Fixed the issue when DM_SPI config is disabled.
> > - Fixed the issue while running the sandbox_noinst_defconfig with spl
> >    ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
> >     jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
> >     jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
> >     ### ERROR ### Please RESET the board ### Changes in v8:
> > - Fixed the compilation issue with imx28_xea_defconfig.
> > - Fixed the SPL size issue with the axm and taurus defconfigs.
> > - Rebased the patches on top of next branch.
> > Changes in v9:
> > - Updated the commit log why SPL_FIT is being enabled.
> > Changes in v10:
> > - Added the new config SPI_ADVANCE to fix the issue while enabling imx2=
8_xea_defconfig.
> > Changes in v11:
> > - Removed the unused variable, corrected the type of variable and repla=
ced memcpy with memmove.
> > Changes in v12:
> > - Fixed the compilation issue with mx6sabresd defconfig, as the binary =
size got exceeded.
> > Changes in v13:
> > - Fixed the compilation issue for imx28 by making bisectable.
> > - Disable the config SPI_ADVANCE by default.
> > - Rearranged the patch series order.
> >=20
> > Ashok Reddy Soma (2):
> >    mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
> >    mtd: spi-nor: Add parallel and stacked memories support in read_bar
> >      and write_bar
> >=20
> > Venkatesh Yadav Abbarapu (6):
> >    config: mx6sabresd: Default don't enable the flash lock
> >    mtd: spi-nor: Add parallel and stacked memories support
> >    spi: spi-uclass: Read chipselect and restrict capabilities
> >    config: xilinx: Enable the SPI_ADVANCE config option
> >    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
> >    spi: zynq_qspi: Add parallel memories support in QSPI driver
> >=20
> >   configs/mx6sabresd_defconfig             |   1 +
> >   configs/xilinx_versal_net_virt_defconfig |   1 +
> >   configs/xilinx_versal_virt_defconfig     |   1 +
> >   configs/xilinx_zynq_virt_defconfig       |   1 +
> >   configs/xilinx_zynqmp_virt_defconfig     |   1 +
> >   drivers/mtd/spi/sandbox.c                |   2 +-
> >   drivers/mtd/spi/spi-nor-core.c           | 400 ++++++++++++++++++++---
> >   drivers/spi/Kconfig                      |   6 +
> >   drivers/spi/altera_spi.c                 |   4 +-
> >   drivers/spi/atcspi200_spi.c              |   2 +-
> >   drivers/spi/ath79_spi.c                  |   2 +-
> >   drivers/spi/atmel_spi.c                  |   6 +-
> >   drivers/spi/bcm63xx_hsspi.c              |  42 +--
> >   drivers/spi/bcm63xx_spi.c                |   6 +-
> >   drivers/spi/bcmbca_hsspi.c               |  34 +-
> >   drivers/spi/cf_spi.c                     |   6 +-
> >   drivers/spi/davinci_spi.c                |   8 +-
> >   drivers/spi/fsl_dspi.c                   |  18 +-
> >   drivers/spi/fsl_espi.c                   |   4 +-
> >   drivers/spi/fsl_qspi.c                   |   4 +-
> >   drivers/spi/gxp_spi.c                    |   2 +-
> >   drivers/spi/mpc8xx_spi.c                 |   4 +-
> >   drivers/spi/mpc8xxx_spi.c                |  10 +-
> >   drivers/spi/mscc_bb_spi.c                |   4 +-
> >   drivers/spi/mxc_spi.c                    |   6 +-
> >   drivers/spi/npcm_fiu_spi.c               |  14 +-
> >   drivers/spi/nxp_fspi.c                   |   2 +-
> >   drivers/spi/octeon_spi.c                 |   2 +-
> >   drivers/spi/omap3_spi.c                  |   4 +-
> >   drivers/spi/pic32_spi.c                  |   2 +-
> >   drivers/spi/rk_spi.c                     |   4 +-
> >   drivers/spi/rockchip_sfc.c               |   2 +-
> >   drivers/spi/spi-aspeed-smc.c             |  28 +-
> >   drivers/spi/spi-mxic.c                   |   6 +-
> >   drivers/spi/spi-qup.c                    |   4 +-
> >   drivers/spi/spi-sifive.c                 |   6 +-
> >   drivers/spi/spi-sn-f-ospi.c              |   2 +-
> >   drivers/spi/spi-sunxi.c                  |   6 +-
> >   drivers/spi/spi-synquacer.c              |   4 +-
> >   drivers/spi/spi-uclass.c                 |  34 +-
> >   drivers/spi/stm32_qspi.c                 |   2 +-
> >   drivers/spi/stm32_spi.c                  |   4 +-
> >   drivers/spi/ti_qspi.c                    |  14 +-
> >   drivers/spi/xilinx_spi.c                 |   6 +-
> >   drivers/spi/zynq_qspi.c                  | 121 ++++++-
> >   drivers/spi/zynq_spi.c                   |   6 +-
> >   drivers/spi/zynqmp_gqspi.c               | 141 +++++++-
> >   include/linux/mtd/spi-nor.h              |  12 +
> >   include/spi.h                            |  23 +-
> >   lib/acpi/acpi_device.c                   |   2 +-
> >   50 files changed, 795 insertions(+), 231 deletions(-)
> >=20
>=20
> Acked-by: Michal Simek <michal.simek@amd.com>
>=20
> Any comment about this series?
> It is around for a while.
> I pushed it to CI sometime ago and nothing has been reported.
> FYI: https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelin=
es/22232
>=20
> Tom: If there is any other comment can you please merge this to next to g=
et
> more testing on other HW?

Fair point, and sorry for the delay on my own feedback here. The problem
I see right now, and iot2050 is the platform in front of me in my logs,
is that SPL is growing by 1344 bytes from this. Full U-Boot is as well,
but that's a little more tolerable, if we can't avoid it. But we need to
try and avoid that in SPL.

--=20
Tom

--dzEzL8qlpKI3Znj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbsoDIACgkQFHw5/5Y0
tywxMQv+K4R9NBISvgMLXAHT8f7EHJcFtio/H7HJk13JMFAixAIQYldRBkCK14Tc
aZhX0Okea6u+lNy7k+qyVHVFIHNGoUx+kLgAN3t4AYZO+RzF2nhYVupAZr/HX3v5
muIzQxbF3hKDzfHmqdULC/Lg/cVG93mgpsGRXzYdMeOvGFUNpg3W1gOHEW3vrJU+
YT23tXa8JHOpsozcQEQVNCPfpM8lWyb62FdhodUmvtpHvw/U9dRwoiYgPWKO43gk
uGCZsg0lvr6dcEYGHermEEZBTiTghlEI9h4wof9K7B3kkr+l90itVWrhZ/JYcgpZ
twEOdLmnBjrkQMNQbDbnJyyUDx8IDjAlYdSlafbJGGft0QpbBUMwhalyRxdbXqkx
N1ezFLk4BkR1xULI7jhgyeP8yKpGzyCZaBeMyMoHa5E9keMEYfXlMtC3DzZ2cc5Z
q8stlmUlG4K0pyo9X5M9vmyEi9A4lfqqczxLfIeuLm/17/RyHmO/l9KRNgm95AHx
gza2s8hV
=Hz2v
-----END PGP SIGNATURE-----

--dzEzL8qlpKI3Znj8--
