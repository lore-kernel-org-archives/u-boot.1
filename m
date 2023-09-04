Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697D6C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 20:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753248694A;
	Mon,  4 Sep 2023 22:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TIHA/uyQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A439C86940; Mon,  4 Sep 2023 22:28:02 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE99868BB
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 22:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59205f26e47so16537597b3.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693859275; x=1694464075; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZL/CRfp2uxYHVAW5c6pUPCEaODZSTFMnI/ZeO1wt2c=;
 b=TIHA/uyQxynN2+DcvYq0JjcRle8MRTGCSS9Xpwet3T4l36DNxeSWXBRUuz4b0ZDrmV
 Xb94YJ4sPxneg2GkGwySTXCU0kme4RY6ll2zg4M4GfO2T938JZGpnVY81su8tPSRKKhG
 jo/XUYqE4n+iy6pPIbcggZ65lIFLXJ+mZ6rrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693859275; x=1694464075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZL/CRfp2uxYHVAW5c6pUPCEaODZSTFMnI/ZeO1wt2c=;
 b=hUIh69blvDjZ/dalE1NH/0BO2yr/TJyg1m74vY9JWYnj9SjslIPD5ks25O84c3botm
 Ek1ZaE5514l/aF3IJC9uGSRJCtELHEjF150Loim/hN8npbBvdOiwb/8dN0HmyIE43IsP
 C6Ggu2BFDqLvWGeGYLWiLx4kt9wEVGlaAu9++tZrZRmopgHiGqs25cLUYZFj27+JWMB+
 V8DcdDYi3u7vXgt5IH7K3lI9p4OZOIE14EJbYfrAHyoVtw8QTPC2b5ejeDkoM53CMVwt
 Wr3UE00JZV8H3ncfCw/z384L7IkwuPcTlUjScRt0MhWJmlYdotdq6imlRet0V0iPyeSn
 lnYA==
X-Gm-Message-State: AOJu0Yz2EexgARpMawRxNliY9KeZd1Q3huVF+GkhgqvmhkhUeLZ6GkRB
 HYEpU190h7I3KahxLgkrOncSFg==
X-Google-Smtp-Source: AGHT+IH+7h3lFucJbPSRRqT+uBBVO8VDdWb+F8r3hOonWtx4uUB1EBgqE+uGdSZJ4VRBkwWXbiT9mQ==
X-Received: by 2002:a0d:f6c6:0:b0:577:4005:d885 with SMTP id
 g189-20020a0df6c6000000b005774005d885mr10496195ywf.15.1693859274988; 
 Mon, 04 Sep 2023 13:27:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a0dc003000000b0054f9e7fed7asm2818785ywd.137.2023.09.04.13.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 13:27:54 -0700 (PDT)
Date: Mon, 4 Sep 2023 16:27:52 -0400
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
Message-ID: <20230904202752.GH3101304@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-33-sjg@chromium.org>
 <20230830181459.wtbt3w3qc4ysxwty@pali>
 <20230903203939.v4ylmtnozavxfcut@pali>
 <20230904201514.75tppdy5eqeposfs@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PUptUsTpDUlae44r"
Content-Disposition: inline
In-Reply-To: <20230904201514.75tppdy5eqeposfs@pali>
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


--PUptUsTpDUlae44r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simon has filtered your emails, which I believe he even told you, after
how much you were berating him in a previous thread.  That's why he's
not responding and I'm answering your only relevant to this thread
question so far.  He cc'd you because a file you're listed as maintainer
on was changed.  If you had negative feedback on this change itself,
yes, I'd have gone through and let him know there's something he needs
to look at.  However, you've so far only taken this an in invitation to
once again air all of your grievances.

On Mon, Sep 04, 2023 at 10:15:14PM +0200, Pali Roh=E1r wrote:
> Simon, could you react here? Because Tom is complaining again that I'm
> not responding to this email. But this is again total nonsense from Tom
> as I have asked you to react 2 times, which provides that I'm not the
> one who does not response here.
>=20
> On Sunday 03 September 2023 22:39:39 Pali Roh=E1r wrote:
> > I still have not received any reply from you.
> >=20
> > On Wednesday 30 August 2023 20:14:59 Pali Roh=E1r wrote:
> > > Simon, why you are contacting me? You have wrote to me that you would
> > > ignore my reviews here, so what you want now? Could you please explain
> > > what you are trying to achieve? I'm not going to review this or any
> > > other your changes.
> > >=20
> > > On Wednesday 30 August 2023 12:05:03 Simon Glass wrote:
> > > > The PCI helpers read only the base address for a PCI region. In som=
e cases
> > > > the size is needed as well, e.g. to pass along to a driver which ne=
eds to
> > > > know the size of its register area.
> > > >=20
> > > > Update the functions to allow the size to be returned. For serial, =
record
> > > > the information and provided it with the serial_info() call.
> > > >=20
> > > > A limitation still exists in that the size is not available when OF=
_LIVE
> > > > is enabled, so take account of that in the tests.
> > > >=20
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >=20
> > > >  arch/sandbox/dts/test.dts   |  6 +++---
> > > >  drivers/core/fdtaddr.c      |  6 +++---
> > > >  drivers/core/ofnode.c       | 11 ++++++++---
> > > >  drivers/core/read.c         |  6 ++++--
> > > >  drivers/core/util.c         |  2 +-
> > > >  drivers/pci/pci-uclass.c    |  2 +-
> > > >  drivers/pci/pci_mvebu.c     |  3 ++-
> > > >  drivers/pci/pci_tegra.c     |  2 +-
> > > >  drivers/pci/pcie_mediatek.c |  4 ++--
> > > >  drivers/serial/ns16550.c    | 15 ++++++++++-----
> > > >  include/dm/fdtaddr.h        |  3 ++-
> > > >  include/dm/ofnode.h         |  4 +++-
> > > >  include/dm/read.h           |  8 +++++---
> > > >  include/ns16550.h           |  4 +++-
> > > >  include/serial.h            |  2 ++
> > > >  test/dm/pci.c               | 14 ++++++++++----
> > > >  16 files changed, 60 insertions(+), 32 deletions(-)
> > > >=20
> > > > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > > > index a413cbe4989..961e8895a49 100644
> > > > --- a/arch/sandbox/dts/test.dts
> > > > +++ b/arch/sandbox/dts/test.dts
> > > > @@ -1087,8 +1087,8 @@
> > > >  		pci@1,0 {
> > > >  			compatible =3D "pci-generic";
> > > >  			/* reg 0 is at 0x14, using FDT_PCI_SPACE_MEM32 */
> > > > -			reg =3D <0x02000814 0 0 0 0
> > > > -			       0x01000810 0 0 0 0>;
> > > > +			reg =3D <0x02000814 0 0 0x80 0
> > > > +			       0x01000810 0 0 0xc0 0>;
> > > >  			sandbox,emul =3D <&swap_case_emul0_1>;
> > > >  		};
> > > >  		p2sb-pci@2,0 {
> > > > @@ -1115,7 +1115,7 @@
> > > >  		pci@1f,0 {
> > > >  			compatible =3D "pci-generic";
> > > >  			/* reg 0 is at 0x10, using FDT_PCI_SPACE_IO */
> > > > -			reg =3D <0x0100f810 0 0 0 0>;
> > > > +			reg =3D <0x0100f810 0 0 0x100 0>;
> > > >  			sandbox,emul =3D <&swap_case_emul0_1f>;
> > > >  		};
> > > >  	};
> > > > diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
> > > > index 546db675aaf..b79d138c419 100644
> > > > --- a/drivers/core/fdtaddr.c
> > > > +++ b/drivers/core/fdtaddr.c
> > > > @@ -215,7 +215,7 @@ void *devfdt_map_physmem(const struct udevice *=
dev, unsigned long size)
> > > >  	return map_physmem(addr, size, MAP_NOCACHE);
> > > >  }
> > > > =20
> > > > -fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev)
> > > > +fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size=
_t *sizep)
> > > >  {
> > > >  	ulong addr;
> > > > =20
> > > > @@ -226,12 +226,12 @@ fdt_addr_t devfdt_get_addr_pci(const struct u=
device *dev)
> > > >  		int ret;
> > > > =20
> > > >  		ret =3D ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_MEM3=
2,
> > > > -					   "reg", &pci_addr);
> > > > +					   "reg", &pci_addr, sizep);
> > > >  		if (ret) {
> > > >  			/* try if there is any i/o-mapped register */
> > > >  			ret =3D ofnode_read_pci_addr(dev_ofnode(dev),
> > > >  						   FDT_PCI_SPACE_IO, "reg",
> > > > -						   &pci_addr);
> > > > +						   &pci_addr, sizep);
> > > >  			if (ret)
> > > >  				return FDT_ADDR_T_NONE;
> > > >  		}
> > > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > > index 2ef4114cb6f..c9cec456f43 100644
> > > > --- a/drivers/core/ofnode.c
> > > > +++ b/drivers/core/ofnode.c
> > > > @@ -1270,7 +1270,8 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnod=
e node, const char *propname,
> > > >  }
> > > > =20
> > > >  int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
> > > > -			 const char *propname, struct fdt_pci_addr *addr)
> > > > +			 const char *propname, struct fdt_pci_addr *addr,
> > > > +			 fdt_size_t *size)
> > > >  {
> > > >  	const fdt32_t *cell;
> > > >  	int len;
> > > > @@ -1298,14 +1299,18 @@ int ofnode_read_pci_addr(ofnode node, enum =
fdt_pci_space type,
> > > >  			      (ulong)fdt32_to_cpu(cell[1]),
> > > >  			      (ulong)fdt32_to_cpu(cell[2]));
> > > >  			if ((fdt32_to_cpu(*cell) & type) =3D=3D type) {
> > > > +				const unaligned_fdt64_t *ptr;
> > > > +
> > > >  				addr->phys_hi =3D fdt32_to_cpu(cell[0]);
> > > >  				addr->phys_mid =3D fdt32_to_cpu(cell[1]);
> > > >  				addr->phys_lo =3D fdt32_to_cpu(cell[2]);
> > > > +				ptr =3D (const unaligned_fdt64_t *)(cell + 3);
> > > > +				if (size)
> > > > +					*size =3D fdt64_to_cpu(*ptr);
> > > >  				break;
> > > >  			}
> > > > =20
> > > > -			cell +=3D (FDT_PCI_ADDR_CELLS +
> > > > -				 FDT_PCI_SIZE_CELLS);
> > > > +			cell +=3D FDT_PCI_ADDR_CELLS + FDT_PCI_SIZE_CELLS;
> > > >  		}
> > > > =20
> > > >  		if (i =3D=3D num) {
> > > > diff --git a/drivers/core/read.c b/drivers/core/read.c
> > > > index 49066b59cda..419013451f0 100644
> > > > --- a/drivers/core/read.c
> > > > +++ b/drivers/core/read.c
> > > > @@ -405,13 +405,15 @@ int dev_read_alias_highest_id(const char *ste=
m)
> > > >  	return fdtdec_get_alias_highest_id(gd->fdt_blob, stem);
> > > >  }
> > > > =20
> > > > -fdt_addr_t dev_read_addr_pci(const struct udevice *dev)
> > > > +fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t=
 *sizep)
> > > >  {
> > > >  	ulong addr;
> > > > =20
> > > >  	addr =3D dev_read_addr(dev);
> > > > +	if (sizep)
> > > > +		*sizep =3D 0;
> > > >  	if (addr =3D=3D FDT_ADDR_T_NONE && !of_live_active())
> > > > -		addr =3D devfdt_get_addr_pci(dev);
> > > > +		addr =3D devfdt_get_addr_pci(dev, sizep);
> > > > =20
> > > >  	return addr;
> > > >  }
> > > > diff --git a/drivers/core/util.c b/drivers/core/util.c
> > > > index aa60fdd15bc..81497df85ff 100644
> > > > --- a/drivers/core/util.c
> > > > +++ b/drivers/core/util.c
> > > > @@ -30,7 +30,7 @@ int pci_get_devfn(struct udevice *dev)
> > > > =20
> > > >  	/* Extract the devfn from fdt_pci_addr */
> > > >  	ret =3D ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFI=
G,
> > > > -				   "reg", &addr);
> > > > +				   "reg", &addr, NULL);
> > > >  	if (ret) {
> > > >  		if (ret !=3D -ENOENT)
> > > >  			return -EINVAL;
> > > > diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> > > > index 0adcdceb1d3..c670f8754e8 100644
> > > > --- a/drivers/pci/pci-uclass.c
> > > > +++ b/drivers/pci/pci-uclass.c
> > > > @@ -122,7 +122,7 @@ static void pci_dev_find_ofnode(struct udevice =
*bus, phys_addr_t bdf,
> > > > =20
> > > >  	dev_for_each_subnode(node, bus) {
> > > >  		ret =3D ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg",
> > > > -					   &addr);
> > > > +					   &addr, NULL);
> > > >  		if (ret)
> > > >  			continue;
> > > > =20
> > > > diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
> > > > index 93a7508d8a2..25878bde534 100644
> > > > --- a/drivers/pci/pci_mvebu.c
> > > > +++ b/drivers/pci/pci_mvebu.c
> > > > @@ -640,7 +640,8 @@ static int mvebu_pcie_port_parse_dt(ofnode node=
, ofnode parent, struct mvebu_pci
> > > >  		pcie->is_x4 =3D true;
> > > > =20
> > > >  	/* devfn is in bits [15:8], see PCI_DEV usage */
> > > > -	ret =3D ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &=
pci_addr);
> > > > +	ret =3D ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &=
pci_addr,
> > > > +				   NULL);
> > > >  	if (ret < 0) {
> > > >  		printf("%s: property \"reg\" is invalid\n", pcie->name);
> > > >  		goto err;
> > > > diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
> > > > index 29d54117e93..ae90bd2fbf1 100644
> > > > --- a/drivers/pci/pci_tegra.c
> > > > +++ b/drivers/pci/pci_tegra.c
> > > > @@ -461,7 +461,7 @@ static int tegra_pcie_parse_port_info(ofnode no=
de, uint *index, uint *lanes)
> > > > =20
> > > >  	*lanes =3D err;
> > > > =20
> > > > -	err =3D ofnode_read_pci_addr(node, 0, "reg", &addr);
> > > > +	err =3D ofnode_read_pci_addr(node, 0, "reg", &addr, NULL);
> > > >  	if (err < 0) {
> > > >  		pr_err("failed to parse \"reg\" property\n");
> > > >  		return err;
> > > > diff --git a/drivers/pci/pcie_mediatek.c b/drivers/pci/pcie_mediate=
k.c
> > > > index c6e30e24622..e59ebd13ad0 100644
> > > > --- a/drivers/pci/pcie_mediatek.c
> > > > +++ b/drivers/pci/pcie_mediatek.c
> > > > @@ -660,7 +660,7 @@ static int mtk_pcie_probe(struct udevice *dev)
> > > >  		if (!ofnode_is_enabled(subnode))
> > > >  			continue;
> > > > =20
> > > > -		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr);
> > > > +		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
> > > >  		if (err)
> > > >  			return err;
> > > > =20
> > > > @@ -699,7 +699,7 @@ static int mtk_pcie_probe_v2(struct udevice *de=
v)
> > > >  		if (!ofnode_is_enabled(subnode))
> > > >  			continue;
> > > > =20
> > > > -		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr);
> > > > +		err =3D ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
> > > >  		if (err)
> > > >  			return err;
> > > > =20
> > > > diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> > > > index eab9537fbae..a349e5e132a 100644
> > > > --- a/drivers/serial/ns16550.c
> > > > +++ b/drivers/serial/ns16550.c
> > > > @@ -479,6 +479,7 @@ static int ns16550_serial_getinfo(struct udevic=
e *dev,
> > > >  	info->addr_space =3D SERIAL_ADDRESS_SPACE_MEMORY;
> > > >  #endif
> > > >  	info->addr =3D plat->base;
> > > > +	info->size =3D plat->size;
> > > >  	info->reg_width =3D plat->reg_width;
> > > >  	info->reg_shift =3D plat->reg_shift;
> > > >  	info->reg_offset =3D plat->reg_offset;
> > > > @@ -487,7 +488,8 @@ static int ns16550_serial_getinfo(struct udevic=
e *dev,
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > -static int ns16550_serial_assign_base(struct ns16550_plat *plat, f=
dt_addr_t base)
> > > > +static int ns16550_serial_assign_base(struct ns16550_plat *plat,
> > > > +				      fdt_addr_t base, fdt_size_t size)
> > > >  {
> > > >  	if (base =3D=3D FDT_ADDR_T_NONE)
> > > >  		return -EINVAL;
> > > > @@ -497,6 +499,7 @@ static int ns16550_serial_assign_base(struct ns=
16550_plat *plat, fdt_addr_t base
> > > >  #else
> > > >  	plat->base =3D (unsigned long)map_physmem(base, 0, MAP_NOCACHE);
> > > >  #endif
> > > > +	plat->size =3D size;
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > @@ -507,6 +510,7 @@ int ns16550_serial_probe(struct udevice *dev)
> > > >  	struct ns16550 *const com_port =3D dev_get_priv(dev);
> > > >  	struct reset_ctl_bulk reset_bulk;
> > > >  	fdt_addr_t addr;
> > > > +	fdt_addr_t size;
> > > >  	int ret;
> > > > =20
> > > >  	/*
> > > > @@ -514,8 +518,8 @@ int ns16550_serial_probe(struct udevice *dev)
> > > >  	 * or via a PCI bridge, assign plat->base before probing hardware.
> > > >  	 */
> > > >  	if (device_is_on_pci_bus(dev)) {
> > > > -		addr =3D devfdt_get_addr_pci(dev);
> > > > -		ret =3D ns16550_serial_assign_base(plat, addr);
> > > > +		addr =3D devfdt_get_addr_pci(dev, &size);
> > > > +		ret =3D ns16550_serial_assign_base(plat, addr, size);
> > > >  		if (ret)
> > > >  			return ret;
> > > >  	}
> > > > @@ -543,11 +547,12 @@ int ns16550_serial_of_to_plat(struct udevice =
*dev)
> > > >  	struct ns16550_plat *plat =3D dev_get_plat(dev);
> > > >  	const u32 port_type =3D dev_get_driver_data(dev);
> > > >  	fdt_addr_t addr;
> > > > +	fdt_size_t size;
> > > >  	struct clk clk;
> > > >  	int err;
> > > > =20
> > > > -	addr =3D dev_read_addr(dev);
> > > > -	err =3D ns16550_serial_assign_base(plat, addr);
> > > > +	addr =3D dev_read_addr_size(dev, &size);
> > > > +	err =3D ns16550_serial_assign_base(plat, addr, size);
> > > >  	if (err && !device_is_on_pci_bus(dev))
> > > >  		return err;
> > > > =20
> > > > diff --git a/include/dm/fdtaddr.h b/include/dm/fdtaddr.h
> > > > index dcdc19137cc..6d2fa8f1044 100644
> > > > --- a/include/dm/fdtaddr.h
> > > > +++ b/include/dm/fdtaddr.h
> > > > @@ -168,8 +168,9 @@ fdt_addr_t devfdt_get_addr_size_name(const stru=
ct udevice *dev,
> > > >   * devfdt_get_addr_pci() - Read an address and handle PCI address =
translation
> > > >   *
> > > >   * @dev: Device to read from
> > > > + * @sizep: If non-NULL, returns size of address space
> > > >   * Return: address or FDT_ADDR_T_NONE if not found
> > > >   */
> > > > -fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev);
> > > > +fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size=
_t *sizep);
> > > > =20
> > > >  #endif
> > > > diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> > > > index 726d8f82ddf..97cad971611 100644
> > > > --- a/include/dm/ofnode.h
> > > > +++ b/include/dm/ofnode.h
> > > > @@ -1152,13 +1152,15 @@ const uint8_t *ofnode_read_u8_array_ptr(ofn=
ode node, const char *propname,
> > > >   * @type:	pci address type (FDT_PCI_SPACE_xxx)
> > > >   * @propname:	name of property to find
> > > >   * @addr:	returns pci address in the form of fdt_pci_addr
> > > > + * @size:	if non-null, returns register-space size
> > > >   * Return:
> > > >   * 0 if ok, -ENOENT if the property did not exist, -EINVAL if the
> > > >   * format of the property was invalid, -ENXIO if the requested
> > > >   * address type was not found
> > > >   */
> > > >  int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
> > > > -			 const char *propname, struct fdt_pci_addr *addr);
> > > > +			 const char *propname, struct fdt_pci_addr *addr,
> > > > +			 fdt_size_t *size);
> > > > =20
> > > >  /**
> > > >   * ofnode_read_pci_vendev() - look up PCI vendor and device id
> > > > diff --git a/include/dm/read.h b/include/dm/read.h
> > > > index c2615f72f40..3c2eea6f0c4 100644
> > > > --- a/include/dm/read.h
> > > > +++ b/include/dm/read.h
> > > > @@ -346,9 +346,10 @@ void *dev_read_addr_ptr(const struct udevice *=
dev);
> > > >   *    fdtdec_get_addr() and friends.
> > > >   *
> > > >   * @dev: Device to read from
> > > > + * @sizep: If non-NULL, returns size of address space found
> > > >   * Return: address or FDT_ADDR_T_NONE if not found
> > > >   */
> > > > -fdt_addr_t dev_read_addr_pci(const struct udevice *dev);
> > > > +fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t=
 *sizep);
> > > > =20
> > > >  /**
> > > >   * dev_remap_addr() - Get the reg property of a device as a
> > > > @@ -996,9 +997,10 @@ static inline void *dev_read_addr_ptr(const st=
ruct udevice *dev)
> > > >  	return devfdt_get_addr_ptr(dev);
> > > >  }
> > > > =20
> > > > -static inline fdt_addr_t dev_read_addr_pci(const struct udevice *d=
ev)
> > > > +static inline fdt_addr_t dev_read_addr_pci(const struct udevice *d=
ev,
> > > > +					   fdt_size_t *sizep)
> > > >  {
> > > > -	return devfdt_get_addr_pci(dev);
> > > > +	return devfdt_get_addr_pci(dev, sizep);
> > > >  }
> > > > =20
> > > >  static inline void *dev_remap_addr(const struct udevice *dev)
> > > > diff --git a/include/ns16550.h b/include/ns16550.h
> > > > index e7e68663d03..7f481300083 100644
> > > > --- a/include/ns16550.h
> > > > +++ b/include/ns16550.h
> > > > @@ -58,6 +58,7 @@ enum ns16550_flags {
> > > >   * struct ns16550_plat - information about a NS16550 port
> > > >   *
> > > >   * @base:		Base register address
> > > > + * @size:		Size of register area in bytes
> > > >   * @reg_width:		IO accesses size of registers (in bytes, 1 or 4)
> > > >   * @reg_shift:		Shift size of registers (0=3Dbyte, 1=3D16bit, 2=3D=
32bit...)
> > > >   * @reg_offset:		Offset to start of registers (normally 0)
> > > > @@ -67,7 +68,8 @@ enum ns16550_flags {
> > > >   * @bdf:		PCI slot/function (pci_dev_t)
> > > >   */
> > > >  struct ns16550_plat {
> > > > -	unsigned long base;
> > > > +	ulong base;
> > > > +	ulong size;
> > > >  	int reg_width;
> > > >  	int reg_shift;
> > > >  	int reg_offset;
> > > > diff --git a/include/serial.h b/include/serial.h
> > > > index 42bdf3759c0..205889d28be 100644
> > > > --- a/include/serial.h
> > > > +++ b/include/serial.h
> > > > @@ -137,6 +137,7 @@ enum adr_space_type {
> > > >   * @type:	type of the UART chip
> > > >   * @addr_space:	address space to access the registers
> > > >   * @addr:	physical address of the registers
> > > > + * @size:	size of the register area in bytes
> > > >   * @reg_width:	size (in bytes) of the IO accesses to the registers
> > > >   * @reg_offset:	offset to apply to the @addr from the start of the=
 registers
> > > >   * @reg_shift:	quantity to shift the register offsets by
> > > > @@ -147,6 +148,7 @@ struct serial_device_info {
> > > >  	enum serial_chip_type type;
> > > >  	enum adr_space_type addr_space;
> > > >  	ulong addr;
> > > > +	ulong size;
> > > >  	u8 reg_width;
> > > >  	u8 reg_offset;
> > > >  	u8 reg_shift;
> > > > diff --git a/test/dm/pci.c b/test/dm/pci.c
> > > > index 70a736cfdb8..8c5e7da9e62 100644
> > > > --- a/test/dm/pci.c
> > > > +++ b/test/dm/pci.c
> > > > @@ -301,10 +301,12 @@ static int dm_test_pci_addr_flat(struct unit_=
test_state *uts)
> > > >  {
> > > >  	struct udevice *swap1f, *swap1;
> > > >  	ulong io_addr, mem_addr;
> > > > +	fdt_addr_t size;
> > > > =20
> > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
> > > >  	io_addr =3D dm_pci_read_bar32(swap1f, 0);
> > > > -	ut_asserteq(io_addr, dev_read_addr_pci(swap1f));
> > > > +	ut_asserteq(io_addr, dev_read_addr_pci(swap1f, &size));
> > > > +	ut_asserteq(0, size);
> > > > =20
> > > >  	/*
> > > >  	 * This device has both I/O and MEM spaces but the MEM space appe=
ars
> > > > @@ -312,7 +314,8 @@ static int dm_test_pci_addr_flat(struct unit_te=
st_state *uts)
> > > >  	 */
> > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
> > > >  	mem_addr =3D dm_pci_read_bar32(swap1, 1);
> > > > -	ut_asserteq(mem_addr, dev_read_addr_pci(swap1));
> > > > +	ut_asserteq(mem_addr, dev_read_addr_pci(swap1, &size));
> > > > +	ut_asserteq(0, size);
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > @@ -329,12 +332,15 @@ DM_TEST(dm_test_pci_addr_flat, UT_TESTF_SCAN_=
PDATA | UT_TESTF_SCAN_FDT |
> > > >  static int dm_test_pci_addr_live(struct unit_test_state *uts)
> > > >  {
> > > >  	struct udevice *swap1f, *swap1;
> > > > +	fdt_size_t size;
> > > > =20
> > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
> > > > -	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f));
> > > > +	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f, &size));
> > > > +	ut_asserteq(0, size);
> > > > =20
> > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
> > > > -	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1));
> > > > +	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1, &size));
> > > > +	ut_asserteq(0, size);
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > --=20
> > > > 2.42.0.rc2.253.gd59a3bf2b4-goog
> > > >=20

--=20
Tom

--PUptUsTpDUlae44r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT2PcQACgkQFHw5/5Y0
tyygwAv9Hk53g4Uaw5sKu7otOyZrcq8OVmIkB0/hBhTFhkW/MhdEM5zfWUs72/Eo
G6mlDd4BJ8ygb9p44Fq+u1PDwiFCb7zYs/YkOErnhhONtt+iBEvkh2D1bP30noBT
1BrXgS79Z/TJK8fYxF2IshN06NQnEfI/KIEnwo4PkKEQveERKl6BtKk9XgQrhOb9
o88iAPVJENocMorn0m4fPLWtGfJ99dB8r+XYsydhGm9AAgHlSM+VllIPaUbUUD5f
vqvk25mPx8UOssFHPlQvPVZpy5m+L+B0Shyn0hm02eO2vSzbEy+nAdnlUVZc3BtJ
ohAvkJegnGujwenaw46kt3/JGJzGtOVZl4n+4AUiGZMOu2jZYoTMH7fniUTPKb81
6KsvQ2CGimeL+DCiZOqmrsTIZ3PEROGjvqVMn7s8o9kfdQGKFd10IGjbZWxhyTZy
78n8Lrj75eCKoxu11eRGta3hBZbIcH4A72I4O1iq2ijzNM08yisX0M+rIMtG+G9H
7M46eWUC
=n1Ja
-----END PGP SIGNATURE-----

--PUptUsTpDUlae44r--
