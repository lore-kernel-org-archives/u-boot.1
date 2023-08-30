Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF7DC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E57A86529;
	Wed, 30 Aug 2023 20:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b6yLBFL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CE386525; Wed, 30 Aug 2023 20:18:00 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90ECE86554
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5925e580f12so824487b3.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693419473; x=1694024273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qbgr5KsSI15LTE6h1UmWlenUzjzkiuhBhcB9qxuWUOg=;
 b=b6yLBFL9uVCQAx91lm67oM7R9OkLpUTihExp5y1JQQuHRWzdDMJalwsVmyHXJ4uD2b
 F19JRXJi2kutVayA0qC/MIOPxa/7J2thnEvO++rcjSi4HdEKbCpGEYrsaq8Le+NvAPje
 oVJl2tzZqiIsTb65kSF/92kgIRWdeeUvfqskE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693419473; x=1694024273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbgr5KsSI15LTE6h1UmWlenUzjzkiuhBhcB9qxuWUOg=;
 b=k3GoKzAhBeJgtsLrv+q/Nrb40PbI+CNVDUflPtjVsBCC5/Oqzmt11jeA5pL4Ff3NuC
 nMr3mIprqrI+SyKUThtluB2o2PrcOVTc3XbV1L+qBe6KBfb8LfQFjrbGs388bXMLDiFt
 tSIS+vUCv1rEyAru2Qtzra4iHCnQaEzZfpeNN2PNUKsGWLjhBsyqg+axLDBq8wqwRDDY
 BcREfu1HBjXlDyYJtGxl5NnsjKYBt9LNAgjr//EDPbDh3ChfvXGU7iR4kZvVs5z0Eqfz
 tjuPNSoyEpBCeyViNIsiIWi/53YMLqabVK8//SEYEg0OridYPDBzezm3Gyg4uPBwSgjJ
 pbIw==
X-Gm-Message-State: AOJu0YweHExTlUAZVF8VEPtciFP7yFDa0OrxX8eZX2mywhg83Oh1/xSo
 4uKMvhVIe4zAaA+N3TqPE9lrjw==
X-Google-Smtp-Source: AGHT+IH+VTUywnAQJtM462g8lK0b9FqQM/hyX2Zq2wmIvXWketAEBy2t6WfkUJ4SyEOzNbA9yjewiA==
X-Received: by 2002:a0d:d694:0:b0:58c:676c:b3ef with SMTP id
 y142-20020a0dd694000000b0058c676cb3efmr3146379ywd.6.1693419473100; 
 Wed, 30 Aug 2023 11:17:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a81a551000000b00586b5b6347csm3364162ywg.109.2023.08.30.11.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:17:52 -0700 (PDT)
Date: Wed, 30 Aug 2023 14:17:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <sr@denx.de>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH 32/32] pci: serial: Support reading PCI-register size
 with base
Message-ID: <20230830181750.GD3101304@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-33-sjg@chromium.org>
 <20230830181459.wtbt3w3qc4ysxwty@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wWSPGOes74Cc2iqp"
Content-Disposition: inline
In-Reply-To: <20230830181459.wtbt3w3qc4ysxwty@pali>
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


--wWSPGOes74Cc2iqp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pali,

You are specifically listed as a maintainer for drivers/pci/pci_mvebu.c
and that is changed by this patch.

On Wed, Aug 30, 2023 at 08:14:59PM +0200, Pali Roh=E1r wrote:
> Simon, why you are contacting me? You have wrote to me that you would
> ignore my reviews here, so what you want now? Could you please explain
> what you are trying to achieve? I'm not going to review this or any
> other your changes.
>=20
> On Wednesday 30 August 2023 12:05:03 Simon Glass wrote:
> > The PCI helpers read only the base address for a PCI region. In some ca=
ses
> > the size is needed as well, e.g. to pass along to a driver which needs =
to
> > know the size of its register area.
> >=20
> > Update the functions to allow the size to be returned. For serial, reco=
rd
> > the information and provided it with the serial_info() call.
> >=20
> > A limitation still exists in that the size is not available when OF_LIVE
> > is enabled, so take account of that in the tests.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> >  arch/sandbox/dts/test.dts   |  6 +++---
> >  drivers/core/fdtaddr.c      |  6 +++---
> >  drivers/core/ofnode.c       | 11 ++++++++---
> >  drivers/core/read.c         |  6 ++++--
> >  drivers/core/util.c         |  2 +-
> >  drivers/pci/pci-uclass.c    |  2 +-
> >  drivers/pci/pci_mvebu.c     |  3 ++-
> >  drivers/pci/pci_tegra.c     |  2 +-
> >  drivers/pci/pcie_mediatek.c |  4 ++--
> >  drivers/serial/ns16550.c    | 15 ++++++++++-----
> >  include/dm/fdtaddr.h        |  3 ++-
> >  include/dm/ofnode.h         |  4 +++-
> >  include/dm/read.h           |  8 +++++---
> >  include/ns16550.h           |  4 +++-
> >  include/serial.h            |  2 ++
> >  test/dm/pci.c               | 14 ++++++++++----
> >  16 files changed, 60 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > index a413cbe4989..961e8895a49 100644
> > --- a/arch/sandbox/dts/test.dts
> > +++ b/arch/sandbox/dts/test.dts
> > @@ -1087,8 +1087,8 @@
> >  		pci@1,0 {
> >  			compatible =3D "pci-generic";
> >  			/* reg 0 is at 0x14, using FDT_PCI_SPACE_MEM32 */
> > -			reg =3D <0x02000814 0 0 0 0
> > -			       0x01000810 0 0 0 0>;
> > +			reg =3D <0x02000814 0 0 0x80 0
> > +			       0x01000810 0 0 0xc0 0>;
> >  			sandbox,emul =3D <&swap_case_emul0_1>;
> >  		};
> >  		p2sb-pci@2,0 {
> > @@ -1115,7 +1115,7 @@
> >  		pci@1f,0 {
> >  			compatible =3D "pci-generic";
> >  			/* reg 0 is at 0x10, using FDT_PCI_SPACE_IO */
> > -			reg =3D <0x0100f810 0 0 0 0>;
> > +			reg =3D <0x0100f810 0 0 0x100 0>;
> >  			sandbox,emul =3D <&swap_case_emul0_1f>;
> >  		};
> >  	};
> > diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
> > index 546db675aaf..b79d138c419 100644
> > --- a/drivers/core/fdtaddr.c
> > +++ b/drivers/core/fdtaddr.c
> > @@ -215,7 +215,7 @@ void *devfdt_map_physmem(const struct udevice *dev,=
 unsigned long size)
> >  	return map_physmem(addr, size, MAP_NOCACHE);
> >  }
> > =20
> > -fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev)
> > +fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size_t *=
sizep)
> >  {
> >  	ulong addr;
> > =20
> > @@ -226,12 +226,12 @@ fdt_addr_t devfdt_get_addr_pci(const struct udevi=
ce *dev)
> >  		int ret;
> > =20
> >  		ret =3D ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_MEM32,
> > -					   "reg", &pci_addr);
> > +					   "reg", &pci_addr, sizep);
> >  		if (ret) {
> >  			/* try if there is any i/o-mapped register */
> >  			ret =3D ofnode_read_pci_addr(dev_ofnode(dev),
> >  						   FDT_PCI_SPACE_IO, "reg",
> > -						   &pci_addr);
> > +						   &pci_addr, sizep);
> >  			if (ret)
> >  				return FDT_ADDR_T_NONE;
> >  		}
> > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > index 2ef4114cb6f..c9cec456f43 100644
> > --- a/drivers/core/ofnode.c
> > +++ b/drivers/core/ofnode.c
> > @@ -1270,7 +1270,8 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnode no=
de, const char *propname,
> >  }
> > =20
> >  int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
> > -			 const char *propname, struct fdt_pci_addr *addr)
> > +			 const char *propname, struct fdt_pci_addr *addr,
> > +			 fdt_size_t *size)
> >  {
> >  	const fdt32_t *cell;
> >  	int len;
> > @@ -1298,14 +1299,18 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_=
pci_space type,
> >  			      (ulong)fdt32_to_cpu(cell[1]),
> >  			      (ulong)fdt32_to_cpu(cell[2]));
> >  			if ((fdt32_to_cpu(*cell) & type) =3D=3D type) {
> > +				const unaligned_fdt64_t *ptr;
> > +
> >  				addr->phys_hi =3D fdt32_to_cpu(cell[0]);
> >  				addr->phys_mid =3D fdt32_to_cpu(cell[1]);
> >  				addr->phys_lo =3D fdt32_to_cpu(cell[2]);
> > +				ptr =3D (const unaligned_fdt64_t *)(cell + 3);
> > +				if (size)
> > +					*size =3D fdt64_to_cpu(*ptr);
> >  				break;
> >  			}
> > =20
> > -			cell +=3D (FDT_PCI_ADDR_CELLS +
> > -				 FDT_PCI_SIZE_CELLS);
> > +			cell +=3D FDT_PCI_ADDR_CELLS + FDT_PCI_SIZE_CELLS;
> >  		}
> > =20
> >  		if (i =3D=3D num) {
> > diff --git a/drivers/core/read.c b/drivers/core/read.c
> > index 49066b59cda..419013451f0 100644
> > --- a/drivers/core/read.c
> > +++ b/drivers/core/read.c
> > @@ -405,13 +405,15 @@ int dev_read_alias_highest_id(const char *stem)
> >  	return fdtdec_get_alias_highest_id(gd->fdt_blob, stem);
> >  }
> > =20
> > -fdt_addr_t dev_read_addr_pci(const struct udevice *dev)
> > +fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t *si=
zep)
> >  {
> >  	ulong addr;
> > =20
> >  	addr =3D dev_read_addr(dev);
> > +	if (sizep)
> > +		*sizep =3D 0;
> >  	if (addr =3D=3D FDT_ADDR_T_NONE && !of_live_active())
> > -		addr =3D devfdt_get_addr_pci(dev);
> > +		addr =3D devfdt_get_addr_pci(dev, sizep);
> > =20
> >  	return addr;
> >  }
> > diff --git a/drivers/core/util.c b/drivers/core/util.c
> > index aa60fdd15bc..81497df85ff 100644
> > --- a/drivers/core/util.c
> > +++ b/drivers/core/util.c
> > @@ -30,7 +30,7 @@ int pci_get_devfn(struct udevice *dev)
> > =20
> >  	/* Extract the devfn from fdt_pci_addr */
> >  	ret =3D ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFIG,
> > -				   "reg", &addr);
> > +				   "reg", &addr, NULL);
> >  	if (ret) {
> >  		if (ret !=3D -ENOENT)
> >  			return -EINVAL;
> > diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> > index 0adcdceb1d3..c670f8754e8 100644
> > --- a/drivers/pci/pci-uclass.c
> > +++ b/drivers/pci/pci-uclass.c
> > @@ -122,7 +122,7 @@ static void pci_dev_find_ofnode(struct udevice *bus=
, phys_addr_t bdf,
> > =20
> >  	dev_for_each_subnode(node, bus) {
> >  		ret =3D ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg",
> > -					   &addr);
> > +					   &addr, NULL);
> >  		if (ret)
> >  			continue;
> > =20
> > diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
> > index 93a7508d8a2..25878bde534 100644
> > --- a/drivers/pci/pci_mvebu.c
> > +++ b/drivers/pci/pci_mvebu.c
> > @@ -640,7 +640,8 @@ static int mvebu_pcie_port_parse_dt(ofnode node, of=
node parent, struct mvebu_pci
> >  		pcie->is_x4 =3D true;
> > =20
> >  	/* devfn is in bits [15:8], see PCI_DEV usage */
> > -	ret =3D ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &pci_=
addr);
> > +	ret =3D ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &pci_=
addr,
> > +				   NULL);
> >  	if (ret < 0) {
> >  		printf("%s: property \"reg\" is invalid\n", pcie->name);
> >  		goto err;
> > diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
> > index 29d54117e93..ae90bd2fbf1 100644
> > --- a/drivers/pci/pci_tegra.c
> > +++ b/drivers/pci/pci_tegra.c
> > @@ -461,7 +461,7 @@ static int tegra_pcie_parse_port_info(ofnode node, =
uint *index, uint *lanes)
> > =20
> >  	*lanes =3D err;
> > =20
> > -	err =3D ofnode_read_pci_addr(node, 0, "reg", &addr);
> > +	err =3D ofnode_read_pci_addr(node, 0, "reg", &addr, NULL);
> >  	if (err < 0) {
> >  		pr_err("failed to parse \"reg\" property\n");
> >  		return err;
> > diff --git a/drivers/pci/pcie_mediatek.c b/drivers/pci/pcie_mediatek.c
> > index c6e30e24622..e59ebd13ad0 100644
> > --- a/drivers/pci/pcie_mediatek.c
> > +++ b/drivers/pci/pcie_mediatek.c
> > @@ -660,7 +660,7 @@ static int mtk_pcie_probe(struct udevice *dev)
> >  		if (!ofnode_is_enabled(subnode))
> >  			continue;
> > =20
> > -		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr);
> > +		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
> >  		if (err)
> >  			return err;
> > =20
> > @@ -699,7 +699,7 @@ static int mtk_pcie_probe_v2(struct udevice *dev)
> >  		if (!ofnode_is_enabled(subnode))
> >  			continue;
> > =20
> > -		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr);
> > +		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
> >  		if (err)
> >  			return err;
> > =20
> > diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> > index eab9537fbae..a349e5e132a 100644
> > --- a/drivers/serial/ns16550.c
> > +++ b/drivers/serial/ns16550.c
> > @@ -479,6 +479,7 @@ static int ns16550_serial_getinfo(struct udevice *d=
ev,
> >  	info->addr_space =3D SERIAL_ADDRESS_SPACE_MEMORY;
> >  #endif
> >  	info->addr =3D plat->base;
> > +	info->size =3D plat->size;
> >  	info->reg_width =3D plat->reg_width;
> >  	info->reg_shift =3D plat->reg_shift;
> >  	info->reg_offset =3D plat->reg_offset;
> > @@ -487,7 +488,8 @@ static int ns16550_serial_getinfo(struct udevice *d=
ev,
> >  	return 0;
> >  }
> > =20
> > -static int ns16550_serial_assign_base(struct ns16550_plat *plat, fdt_a=
ddr_t base)
> > +static int ns16550_serial_assign_base(struct ns16550_plat *plat,
> > +				      fdt_addr_t base, fdt_size_t size)
> >  {
> >  	if (base =3D=3D FDT_ADDR_T_NONE)
> >  		return -EINVAL;
> > @@ -497,6 +499,7 @@ static int ns16550_serial_assign_base(struct ns1655=
0_plat *plat, fdt_addr_t base
> >  #else
> >  	plat->base =3D (unsigned long)map_physmem(base, 0, MAP_NOCACHE);
> >  #endif
> > +	plat->size =3D size;
> > =20
> >  	return 0;
> >  }
> > @@ -507,6 +510,7 @@ int ns16550_serial_probe(struct udevice *dev)
> >  	struct ns16550 *const com_port =3D dev_get_priv(dev);
> >  	struct reset_ctl_bulk reset_bulk;
> >  	fdt_addr_t addr;
> > +	fdt_addr_t size;
> >  	int ret;
> > =20
> >  	/*
> > @@ -514,8 +518,8 @@ int ns16550_serial_probe(struct udevice *dev)
> >  	 * or via a PCI bridge, assign plat->base before probing hardware.
> >  	 */
> >  	if (device_is_on_pci_bus(dev)) {
> > -		addr =3D devfdt_get_addr_pci(dev);
> > -		ret =3D ns16550_serial_assign_base(plat, addr);
> > +		addr =3D devfdt_get_addr_pci(dev, &size);
> > +		ret =3D ns16550_serial_assign_base(plat, addr, size);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -543,11 +547,12 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
> >  	struct ns16550_plat *plat =3D dev_get_plat(dev);
> >  	const u32 port_type =3D dev_get_driver_data(dev);
> >  	fdt_addr_t addr;
> > +	fdt_size_t size;
> >  	struct clk clk;
> >  	int err;
> > =20
> > -	addr =3D dev_read_addr(dev);
> > -	err =3D ns16550_serial_assign_base(plat, addr);
> > +	addr =3D dev_read_addr_size(dev, &size);
> > +	err =3D ns16550_serial_assign_base(plat, addr, size);
> >  	if (err && !device_is_on_pci_bus(dev))
> >  		return err;
> > =20
> > diff --git a/include/dm/fdtaddr.h b/include/dm/fdtaddr.h
> > index dcdc19137cc..6d2fa8f1044 100644
> > --- a/include/dm/fdtaddr.h
> > +++ b/include/dm/fdtaddr.h
> > @@ -168,8 +168,9 @@ fdt_addr_t devfdt_get_addr_size_name(const struct u=
device *dev,
> >   * devfdt_get_addr_pci() - Read an address and handle PCI address tran=
slation
> >   *
> >   * @dev: Device to read from
> > + * @sizep: If non-NULL, returns size of address space
> >   * Return: address or FDT_ADDR_T_NONE if not found
> >   */
> > -fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev);
> > +fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size_t *=
sizep);
> > =20
> >  #endif
> > diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> > index 726d8f82ddf..97cad971611 100644
> > --- a/include/dm/ofnode.h
> > +++ b/include/dm/ofnode.h
> > @@ -1152,13 +1152,15 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnode =
node, const char *propname,
> >   * @type:	pci address type (FDT_PCI_SPACE_xxx)
> >   * @propname:	name of property to find
> >   * @addr:	returns pci address in the form of fdt_pci_addr
> > + * @size:	if non-null, returns register-space size
> >   * Return:
> >   * 0 if ok, -ENOENT if the property did not exist, -EINVAL if the
> >   * format of the property was invalid, -ENXIO if the requested
> >   * address type was not found
> >   */
> >  int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
> > -			 const char *propname, struct fdt_pci_addr *addr);
> > +			 const char *propname, struct fdt_pci_addr *addr,
> > +			 fdt_size_t *size);
> > =20
> >  /**
> >   * ofnode_read_pci_vendev() - look up PCI vendor and device id
> > diff --git a/include/dm/read.h b/include/dm/read.h
> > index c2615f72f40..3c2eea6f0c4 100644
> > --- a/include/dm/read.h
> > +++ b/include/dm/read.h
> > @@ -346,9 +346,10 @@ void *dev_read_addr_ptr(const struct udevice *dev);
> >   *    fdtdec_get_addr() and friends.
> >   *
> >   * @dev: Device to read from
> > + * @sizep: If non-NULL, returns size of address space found
> >   * Return: address or FDT_ADDR_T_NONE if not found
> >   */
> > -fdt_addr_t dev_read_addr_pci(const struct udevice *dev);
> > +fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t *si=
zep);
> > =20
> >  /**
> >   * dev_remap_addr() - Get the reg property of a device as a
> > @@ -996,9 +997,10 @@ static inline void *dev_read_addr_ptr(const struct=
 udevice *dev)
> >  	return devfdt_get_addr_ptr(dev);
> >  }
> > =20
> > -static inline fdt_addr_t dev_read_addr_pci(const struct udevice *dev)
> > +static inline fdt_addr_t dev_read_addr_pci(const struct udevice *dev,
> > +					   fdt_size_t *sizep)
> >  {
> > -	return devfdt_get_addr_pci(dev);
> > +	return devfdt_get_addr_pci(dev, sizep);
> >  }
> > =20
> >  static inline void *dev_remap_addr(const struct udevice *dev)
> > diff --git a/include/ns16550.h b/include/ns16550.h
> > index e7e68663d03..7f481300083 100644
> > --- a/include/ns16550.h
> > +++ b/include/ns16550.h
> > @@ -58,6 +58,7 @@ enum ns16550_flags {
> >   * struct ns16550_plat - information about a NS16550 port
> >   *
> >   * @base:		Base register address
> > + * @size:		Size of register area in bytes
> >   * @reg_width:		IO accesses size of registers (in bytes, 1 or 4)
> >   * @reg_shift:		Shift size of registers (0=3Dbyte, 1=3D16bit, 2=3D32bi=
t...)
> >   * @reg_offset:		Offset to start of registers (normally 0)
> > @@ -67,7 +68,8 @@ enum ns16550_flags {
> >   * @bdf:		PCI slot/function (pci_dev_t)
> >   */
> >  struct ns16550_plat {
> > -	unsigned long base;
> > +	ulong base;
> > +	ulong size;
> >  	int reg_width;
> >  	int reg_shift;
> >  	int reg_offset;
> > diff --git a/include/serial.h b/include/serial.h
> > index 42bdf3759c0..205889d28be 100644
> > --- a/include/serial.h
> > +++ b/include/serial.h
> > @@ -137,6 +137,7 @@ enum adr_space_type {
> >   * @type:	type of the UART chip
> >   * @addr_space:	address space to access the registers
> >   * @addr:	physical address of the registers
> > + * @size:	size of the register area in bytes
> >   * @reg_width:	size (in bytes) of the IO accesses to the registers
> >   * @reg_offset:	offset to apply to the @addr from the start of the reg=
isters
> >   * @reg_shift:	quantity to shift the register offsets by
> > @@ -147,6 +148,7 @@ struct serial_device_info {
> >  	enum serial_chip_type type;
> >  	enum adr_space_type addr_space;
> >  	ulong addr;
> > +	ulong size;
> >  	u8 reg_width;
> >  	u8 reg_offset;
> >  	u8 reg_shift;
> > diff --git a/test/dm/pci.c b/test/dm/pci.c
> > index 70a736cfdb8..8c5e7da9e62 100644
> > --- a/test/dm/pci.c
> > +++ b/test/dm/pci.c
> > @@ -301,10 +301,12 @@ static int dm_test_pci_addr_flat(struct unit_test=
_state *uts)
> >  {
> >  	struct udevice *swap1f, *swap1;
> >  	ulong io_addr, mem_addr;
> > +	fdt_addr_t size;
> > =20
> >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
> >  	io_addr =3D dm_pci_read_bar32(swap1f, 0);
> > -	ut_asserteq(io_addr, dev_read_addr_pci(swap1f));
> > +	ut_asserteq(io_addr, dev_read_addr_pci(swap1f, &size));
> > +	ut_asserteq(0, size);
> > =20
> >  	/*
> >  	 * This device has both I/O and MEM spaces but the MEM space appears
> > @@ -312,7 +314,8 @@ static int dm_test_pci_addr_flat(struct unit_test_s=
tate *uts)
> >  	 */
> >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
> >  	mem_addr =3D dm_pci_read_bar32(swap1, 1);
> > -	ut_asserteq(mem_addr, dev_read_addr_pci(swap1));
> > +	ut_asserteq(mem_addr, dev_read_addr_pci(swap1, &size));
> > +	ut_asserteq(0, size);
> > =20
> >  	return 0;
> >  }
> > @@ -329,12 +332,15 @@ DM_TEST(dm_test_pci_addr_flat, UT_TESTF_SCAN_PDAT=
A | UT_TESTF_SCAN_FDT |
> >  static int dm_test_pci_addr_live(struct unit_test_state *uts)
> >  {
> >  	struct udevice *swap1f, *swap1;
> > +	fdt_size_t size;
> > =20
> >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
> > -	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f));
> > +	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f, &size));
> > +	ut_asserteq(0, size);
> > =20
> >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
> > -	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1));
> > +	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1, &size));
> > +	ut_asserteq(0, size);
> > =20
> >  	return 0;
> >  }
> > --=20
> > 2.42.0.rc2.253.gd59a3bf2b4-goog
> >=20

--=20
Tom

--wWSPGOes74Cc2iqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvh8oACgkQFHw5/5Y0
tyxtNQwAk9hM51vXkQKtKgWQyC4yuSYnmCRrqcpXSrJcPBQdQtVZn3ig8KAJpGna
L5P7gp7CaAkuIdv7Gklv4llD5RW+ujgnkf/+5US7a48UmpwQRgS9MqgUJWpdPBok
N8Y3DE/rKJIhE3oXPjTFq3149a6qeVWsO4+YdzxW/Bgn+0CttQixRe756aZ0vELk
a85d2PyX45iT2861JiMlF8mUwi2pfYKaYAptFIr2/JkMpmW9jI+buHUExY6Dakzv
dcixtHCbY8rOjC8w97GH0jJCPPm8WoqDUdbISGzZYbwpN23YwYgM0QBonjSCVgzj
2wpJRJyuylBBHStD7voDCN9f1Zk72BWGvJNLMqZyBOGVQ/14mDwDYjA6ifGDDlMb
ZeWx84jomrzWTKjFD2MZq8q4kkn0F1IkKOLHeG3iw6FaRJjAC3ivcaEhmuzXLf4X
YqgkSFuIu0yh9ANGCRfTxp4VxmVwcKxywI5P+Zip2RAUuuhnRaEcxbiCs5Xs3lPK
DLQDUNwQ
=q3Lv
-----END PGP SIGNATURE-----

--wWSPGOes74Cc2iqp--
