Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889B0C78853
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 14:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB9288901;
	Fri, 20 Sep 2024 16:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OWWssEsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7CF889C3; Fri, 20 Sep 2024 16:29:26 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F558865D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 16:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a9b049251eso143970385a.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726842562; x=1727447362; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G7kt/SA0e9W+68EK6xdjCAH5rZCESjecgKHq9D9/KxY=;
 b=OWWssEsHcr7v0AgvBlFpJ6l5ky5qv4lmJkKT7pXJ+/c2+ju2mgpiJbufJ0pVd0qnUx
 yiy9qWUuKthQYYUyFY1FZ81Y3UtNvBanoGYmojHwJuOcVxWZvJ/crRH7oG34Nl+X2EVk
 iEjnw302b2dRjU8MfBk8VO3NZdZCbOv/kDJrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726842562; x=1727447362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7kt/SA0e9W+68EK6xdjCAH5rZCESjecgKHq9D9/KxY=;
 b=UQCKN7DcLNS4VETBO/16hrS/GRwG7aufNmplFF5+cs61L3/Nv+yLruc1ZcZlonebC5
 yxo3UWq35UsNv5A8dYghmGx/fG1yWPrmswBaksRpS7ICSvQFqPay88QBra+sew/y0GaO
 gZTx9bxczt8n3yx3gGntXLUauuUvI4QUs5GUkmgnYaTmAHSkkFlgviKV353faCGHJTDf
 npDBJoqYJrPy2c9f1SJH4ZbXEItqEueMHYpsAd9VweUSaJMMXDY4on9dg+RzVkuPyTEM
 KBEHNkM/o2NlXrJHuLIebU8VC4/Ft6iKCTPs0q7BWSSzZRMDyDe2nATRD4/uLqREBobh
 L0HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt1Tr5Hd8imAeEF4/fzt5pKlP5NC0Rh84SKcSOXWgCBGX9ljlm7FbRvoxJ0ChsY9NbQKPjjmg=@lists.denx.de
X-Gm-Message-State: AOJu0YxRdP1EdisRIAUFw2SAcL1kp396GNql7kW7+vY4YkBwq/r9m39q
 PI3fNmN7Pg4L6IQBqUk8mT846lW/n+VIWxB9gElBJV0nIps8X7aM/Mz9lXJaCGI=
X-Google-Smtp-Source: AGHT+IElifaplebCHQ1GzxAwmZoxErl1UGqajT6WixqTu7sRkgaC36JwQrSPHYevo0UlUZNhtH4SDA==
X-Received: by 2002:a05:620a:28cd:b0:7ac:b197:9e3f with SMTP id
 af79cd13be357-7acb8211081mr428122385a.51.1726842562331; 
 Fri, 20 Sep 2024 07:29:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb07e1f93sm183905585a.6.2024.09.20.07.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 07:29:21 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:29:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, jagan@amarulasolutions.com, git@amd.com
Subject: Re: [PATCH v13 0/8] spi-nor: Add parallel and stacked memories support
Message-ID: <20240920142918.GZ4252@bill-the-cat>
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
 <9ab7d67e-1e6a-4176-b448-7724b0ce7615@amd.com>
 <20240919220545.GV4252@bill-the-cat>
 <f35c7002-0312-4ce6-82df-c91635898a39@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2Btq0RsVBUwWcs1G"
Content-Disposition: inline
In-Reply-To: <f35c7002-0312-4ce6-82df-c91635898a39@amd.com>
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


--2Btq0RsVBUwWcs1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 09:34:54AM +0200, Michal Simek wrote:
>=20
>=20
> On 9/20/24 00:05, Tom Rini wrote:
> > On Wed, Sep 18, 2024 at 01:18:10PM +0200, Michal Simek wrote:
> > > Hi Tom,
> > >=20
> > > On 9/5/24 05:21, Venkatesh Yadav Abbarapu wrote:
> > > > This series adds support for Xilinx qspi parallel and
> > > > stacked memeories.
> > > >=20
> > > > In parallel mode, the current implementation assumes that a maximum
> > > > of two flashes are connected. The QSPI controller splits the data
> > > > evenly between both the flashes so, both the flashes that are conne=
cted
> > > > in parallel mode should be identical.
> > > > During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS=
1 in
> > > > nor->flags.
> > > >=20
> > > > In stacked mode the current implementation assumes that a maximum o=
f two
> > > > flashes are connected and both the flashes are of same make but can=
 differ
> > > > in sizes. So, except the sizes all other flash parameters of both t=
he flashes
> > > > are identical.
> > > >=20
> > > > Spi-nor will pass on the appropriate flash select flag to low level=
 driver,
> > > > and it will select pass all the data to that particular flash.
> > > >=20
> > > > Write operation in parallel mode are performed in page size * 2 chu=
nks as
> > > > each write operation results in writing both the flashes. For doubl=
ing the
> > > > address space each operation is performed at addr/2 flash offset, w=
here addr
> > > > is the address specified by the user.
> > > >=20
> > > > Similarly for read and erase operations it will read from both flas=
hes, so
> > > > size and offset are divided by 2 and send to flash.
> > > >=20
> > > > Changes in v2:
> > > > - Fixed the compilation issues.
> > > > Changes in v3:
> > > > - Fixed the CI issues.
> > > > Changes in v4:
> > > > - Removed the dio,dummy_bytes variables from zynq_qspi driver.
> > > > - Fix the compilation issue by including the DM_SPI config.
> > > > Changes in v5:
> > > > - Fixed the issue reported by buildman.
> > > > Changes in v6:
> > > > - Fixed the issues reported while running the sandbox test cases.
> > > > Changes in v7:
> > > > - Fixed the issues reported while running these da850evm_defconfig,
> > > >     imx28_xea_defconfig configs.
> > > > - Fixed the issue when DM_SPI config is disabled.
> > > > - Fixed the issue while running the sandbox_noinst_defconfig with s=
pl
> > > >     ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
> > > >      jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
> > > >      jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
> > > >      ### ERROR ### Please RESET the board ### Changes in v8:
> > > > - Fixed the compilation issue with imx28_xea_defconfig.
> > > > - Fixed the SPL size issue with the axm and taurus defconfigs.
> > > > - Rebased the patches on top of next branch.
> > > > Changes in v9:
> > > > - Updated the commit log why SPL_FIT is being enabled.
> > > > Changes in v10:
> > > > - Added the new config SPI_ADVANCE to fix the issue while enabling =
imx28_xea_defconfig.
> > > > Changes in v11:
> > > > - Removed the unused variable, corrected the type of variable and r=
eplaced memcpy with memmove.
> > > > Changes in v12:
> > > > - Fixed the compilation issue with mx6sabresd defconfig, as the bin=
ary size got exceeded.
> > > > Changes in v13:
> > > > - Fixed the compilation issue for imx28 by making bisectable.
> > > > - Disable the config SPI_ADVANCE by default.
> > > > - Rearranged the patch series order.
> > > >=20
> > > > Ashok Reddy Soma (2):
> > > >     mtd: spi-nor: Add parallel memories support for read_sr and rea=
d_fsr
> > > >     mtd: spi-nor: Add parallel and stacked memories support in read=
_bar
> > > >       and write_bar
> > > >=20
> > > > Venkatesh Yadav Abbarapu (6):
> > > >     config: mx6sabresd: Default don't enable the flash lock
> > > >     mtd: spi-nor: Add parallel and stacked memories support
> > > >     spi: spi-uclass: Read chipselect and restrict capabilities
> > > >     config: xilinx: Enable the SPI_ADVANCE config option
> > > >     spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
> > > >     spi: zynq_qspi: Add parallel memories support in QSPI driver
> > > >=20
> > > >    configs/mx6sabresd_defconfig             |   1 +
> > > >    configs/xilinx_versal_net_virt_defconfig |   1 +
> > > >    configs/xilinx_versal_virt_defconfig     |   1 +
> > > >    configs/xilinx_zynq_virt_defconfig       |   1 +
> > > >    configs/xilinx_zynqmp_virt_defconfig     |   1 +
> > > >    drivers/mtd/spi/sandbox.c                |   2 +-
> > > >    drivers/mtd/spi/spi-nor-core.c           | 400 +++++++++++++++++=
+++---
> > > >    drivers/spi/Kconfig                      |   6 +
> > > >    drivers/spi/altera_spi.c                 |   4 +-
> > > >    drivers/spi/atcspi200_spi.c              |   2 +-
> > > >    drivers/spi/ath79_spi.c                  |   2 +-
> > > >    drivers/spi/atmel_spi.c                  |   6 +-
> > > >    drivers/spi/bcm63xx_hsspi.c              |  42 +--
> > > >    drivers/spi/bcm63xx_spi.c                |   6 +-
> > > >    drivers/spi/bcmbca_hsspi.c               |  34 +-
> > > >    drivers/spi/cf_spi.c                     |   6 +-
> > > >    drivers/spi/davinci_spi.c                |   8 +-
> > > >    drivers/spi/fsl_dspi.c                   |  18 +-
> > > >    drivers/spi/fsl_espi.c                   |   4 +-
> > > >    drivers/spi/fsl_qspi.c                   |   4 +-
> > > >    drivers/spi/gxp_spi.c                    |   2 +-
> > > >    drivers/spi/mpc8xx_spi.c                 |   4 +-
> > > >    drivers/spi/mpc8xxx_spi.c                |  10 +-
> > > >    drivers/spi/mscc_bb_spi.c                |   4 +-
> > > >    drivers/spi/mxc_spi.c                    |   6 +-
> > > >    drivers/spi/npcm_fiu_spi.c               |  14 +-
> > > >    drivers/spi/nxp_fspi.c                   |   2 +-
> > > >    drivers/spi/octeon_spi.c                 |   2 +-
> > > >    drivers/spi/omap3_spi.c                  |   4 +-
> > > >    drivers/spi/pic32_spi.c                  |   2 +-
> > > >    drivers/spi/rk_spi.c                     |   4 +-
> > > >    drivers/spi/rockchip_sfc.c               |   2 +-
> > > >    drivers/spi/spi-aspeed-smc.c             |  28 +-
> > > >    drivers/spi/spi-mxic.c                   |   6 +-
> > > >    drivers/spi/spi-qup.c                    |   4 +-
> > > >    drivers/spi/spi-sifive.c                 |   6 +-
> > > >    drivers/spi/spi-sn-f-ospi.c              |   2 +-
> > > >    drivers/spi/spi-sunxi.c                  |   6 +-
> > > >    drivers/spi/spi-synquacer.c              |   4 +-
> > > >    drivers/spi/spi-uclass.c                 |  34 +-
> > > >    drivers/spi/stm32_qspi.c                 |   2 +-
> > > >    drivers/spi/stm32_spi.c                  |   4 +-
> > > >    drivers/spi/ti_qspi.c                    |  14 +-
> > > >    drivers/spi/xilinx_spi.c                 |   6 +-
> > > >    drivers/spi/zynq_qspi.c                  | 121 ++++++-
> > > >    drivers/spi/zynq_spi.c                   |   6 +-
> > > >    drivers/spi/zynqmp_gqspi.c               | 141 +++++++-
> > > >    include/linux/mtd/spi-nor.h              |  12 +
> > > >    include/spi.h                            |  23 +-
> > > >    lib/acpi/acpi_device.c                   |   2 +-
> > > >    50 files changed, 795 insertions(+), 231 deletions(-)
> > > >=20
> > >=20
> > > Acked-by: Michal Simek <michal.simek@amd.com>
> > >=20
> > > Any comment about this series?
> > > It is around for a while.
> > > I pushed it to CI sometime ago and nothing has been reported.
> > > FYI: https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pip=
elines/22232
> > >=20
> > > Tom: If there is any other comment can you please merge this to next =
to get
> > > more testing on other HW?
> >=20
> > Fair point, and sorry for the delay on my own feedback here. The problem
> > I see right now, and iot2050 is the platform in front of me in my logs,
> > is that SPL is growing by 1344 bytes from this. Full U-Boot is as well,
> > but that's a little more tolerable, if we can't avoid it. But we need to
> > try and avoid that in SPL.
>=20
> I played with it and pretty much some save can be saved if we use some ifs
> and one trick. I c&p it below. Especially the last one is something to
> discuss if it is acceptable solution. The aim is to get conditions to if =
(0)
> and get rid of that code by compiler itself.

This is fine, yeah.

> And in connection to platform you mentioned. I tried to enable LTO and it
> looks like is saving a lot of space on this platform. Isn't it something =
to
> consider too?

I wasn't clear, sorry. That was just the only platform in my terminal
with the build log that showed huge numbers of platforms growing in
U-Boot, and growing in SPL, from this series.

--=20
Tom

--2Btq0RsVBUwWcs1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbthroACgkQFHw5/5Y0
tyysGAwAhbAnCj9z03yf7IwYnKKzl8fgHAraI8zdBmrPumTcMTYCKk5nADD9U2cE
eQ2RbyMpn5IsEllwyXECtMZrPeZc8K4psogyr6JbO5XwVMrrHCs8bYgmJZAML+A/
cxie4vjgy5guXnaldkQyL3fg995sB64Do0ZdYIdFyAwCqs08j4oVnm4GKQ38369h
vaknkJbpUKkeBS18OTluzg7jeFqx71fT4halcOyL19JondkILcfHErhNwd4lOnaU
RZaf8yz6WlHczv2qUdRXmpIr6RnhYY6g+bjeetJTxgDfLa7K1Ol6+T6L8r35CYdQ
1w6XAUSPywKoow9RFEfhKSn7DG7qOXIA41JAHxALGqJwRQsFEB7O6v09GtlNN5pw
jXZ6WkuZx9M9pHhHZrbmtK+HXZq6HFGIvcZVCFFXKMLLmWw7JTvMSAc+Qd7afE8K
GHBO7j+KjzHN0iMmOE+CiLAgEp17Xpb/mXF4MFGnw6mM2jCc6E9UyKmtxzBZJL8N
w8Og9xyT
=J93P
-----END PGP SIGNATURE-----

--2Btq0RsVBUwWcs1G--
