Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70329C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 21:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996A38653E;
	Wed, 30 Aug 2023 23:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RmGBUijj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77DF8653E; Wed, 30 Aug 2023 23:13:24 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FDE286541
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 23:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 096EDB8211C;
 Wed, 30 Aug 2023 21:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E791C433C8;
 Wed, 30 Aug 2023 21:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693429999;
 bh=7pEENj6YYFaceISkyXtGb0NmGrVjEZ1Jx/CnuTDht0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RmGBUijj49Ov91oFBSFZpSb/a6OiD48jlwiuQUkJOmytp4xhoVF/1jCg5tKsHIgTa
 tMa2cuWpBWXrcYAHd6nJNsRuPwuzDSWZV11+PoeKYTvyIpc3JBaaS8rRlW5VxrABEW
 kFHQiaQLNTejZpaYL4rDSKB3ijbG0dnfGutpqwjjkQr9nsb+3AVmvYxkpHPAi/5ksM
 6JPzWhs3bjpykBjnaKck1yCRme/BEkyUC4CxtcF+Aa0KgmWX/UncXH3joPxLWk3qYE
 OH+iKnLVCzVSdLcugDjJF3HKgJuzXCWSBYCZkxn+3+pp8iMctM+heDGqgoGtFt3/eS
 A96unZLwhnEpg==
Received: by pali.im (Postfix)
 id C068F85A; Wed, 30 Aug 2023 23:13:16 +0200 (CEST)
Date: Wed, 30 Aug 2023 23:13:16 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Tom Rini <trini@konsulko.com>
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
Message-ID: <20230830211316.5ywrzq6gmxzvdl4o@pali>
References: <20230830180524.315916-33-sjg@chromium.org>
 <20230830181459.wtbt3w3qc4ysxwty@pali>
 <20230830181750.GD3101304@bill-the-cat>
 <20230830183913.mpj6achf3prjoanb@pali>
 <20230830190422.GE3101304@bill-the-cat>
 <20230830191036.hecw3vyabdsczxrb@pali>
 <20230830194157.GF3101304@bill-the-cat>
 <20230830194409.a7acogmn54gajmk6@pali>
 <20230830205145.t75fkjhnc7kjux3z@pali>
 <20230830210842.GG3101304@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830210842.GG3101304@bill-the-cat>
User-Agent: NeoMutt/20180716
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

Seems that you completely miss the point of the argument, then the only
option for such people is to repeat them. Or have I repeat you again
that you have not answered the first question, why you are asking for
review from somebody who you are ignoring and not taking into account?
You do not want to answer this question, right? So you rather change a
topic and talking about something totally different.

On Wednesday 30 August 2023 17:08:42 Tom Rini wrote:
> I don't think it's worth re-hashing the same arguments over and over.
> There is no "my persons", there is the public community.  If you no
> longer wish to participate, I can remove you from the maintainers
> entries you're listed in.  But please stop with the long arguments
> unrelated to the patches at hand when there's a dozen people and other
> lists on CC.
> 
> On Wed, Aug 30, 2023 at 10:51:45PM +0200, Pali Rohár wrote:
> > So lets recap what you and your persons have done in last 6 months:
> > 
> > * Ignored my changes
> > * Ignored my reviews
> > * Ignored my regression reports
> > * Ignored my reminders
> > 
> > And now you complaining that I'm not going to do another review? Then
> > you should be the first who step down there as incompetent person. I was
> > interesting in developing there for a very long time (10+ years I was
> > active there?).
> > 
> > I think I have already wrote many times that I would not do any new
> > stuff here for you until you start processing existing reports. Seems
> > that you have been ignoring these my warnings. And when I starting
> > applying my statements, you are not happy with it? You should have been
> > thinking about it year ago.
> > 
> > On Wednesday 30 August 2023 21:44:09 Pali Rohár wrote:
> > > And you too. That was at the time when you and your people were
> > > interested in reviews from others.
> > > 
> > > On Wednesday 30 August 2023 15:41:57 Tom Rini wrote:
> > > > Then you should probably remove yourself from the places you've listed
> > > > yourself as an interested maintainer, thanks.
> > > > 
> > > > On Wed, Aug 30, 2023 at 09:10:36PM +0200, Pali Rohár wrote:
> > > > > You have already decided, what is the point? You are not taking any my
> > > > > objections into account, so stop writing to me and to others these your
> > > > > stupids bullshits. I'm not an idiot who is interesting for them.
> > > > > 
> > > > > On Wednesday 30 August 2023 15:04:22 Tom Rini wrote:
> > > > > > You're a listed maintainer for a file being changed. If you objected to
> > > > > > the changes, your objection would matter.  If you don't object, you can
> > > > > > just ignore it, or review it, whatever you like.  You need to decide
> > > > > > what you want to do about code you're volunteering to maintain.
> > > > > > 
> > > > > > On Wed, Aug 30, 2023 at 08:39:13PM +0200, Pali Rohár wrote:
> > > > > > > And what? How it is related to the statements that my reviews would also
> > > > > > > ignored? And what you want from me now?
> > > > > > > 
> > > > > > > On Wednesday 30 August 2023 14:17:50 Tom Rini wrote:
> > > > > > > > Pali,
> > > > > > > > 
> > > > > > > > You are specifically listed as a maintainer for drivers/pci/pci_mvebu.c
> > > > > > > > and that is changed by this patch.
> > > > > > > > 
> > > > > > > > On Wed, Aug 30, 2023 at 08:14:59PM +0200, Pali Rohár wrote:
> > > > > > > > > Simon, why you are contacting me? You have wrote to me that you would
> > > > > > > > > ignore my reviews here, so what you want now? Could you please explain
> > > > > > > > > what you are trying to achieve? I'm not going to review this or any
> > > > > > > > > other your changes.
> > > > > > > > > 
> > > > > > > > > On Wednesday 30 August 2023 12:05:03 Simon Glass wrote:
> > > > > > > > > > The PCI helpers read only the base address for a PCI region. In some cases
> > > > > > > > > > the size is needed as well, e.g. to pass along to a driver which needs to
> > > > > > > > > > know the size of its register area.
> > > > > > > > > > 
> > > > > > > > > > Update the functions to allow the size to be returned. For serial, record
> > > > > > > > > > the information and provided it with the serial_info() call.
> > > > > > > > > > 
> > > > > > > > > > A limitation still exists in that the size is not available when OF_LIVE
> > > > > > > > > > is enabled, so take account of that in the tests.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > > 
> > > > > > > > > >  arch/sandbox/dts/test.dts   |  6 +++---
> > > > > > > > > >  drivers/core/fdtaddr.c      |  6 +++---
> > > > > > > > > >  drivers/core/ofnode.c       | 11 ++++++++---
> > > > > > > > > >  drivers/core/read.c         |  6 ++++--
> > > > > > > > > >  drivers/core/util.c         |  2 +-
> > > > > > > > > >  drivers/pci/pci-uclass.c    |  2 +-
> > > > > > > > > >  drivers/pci/pci_mvebu.c     |  3 ++-
> > > > > > > > > >  drivers/pci/pci_tegra.c     |  2 +-
> > > > > > > > > >  drivers/pci/pcie_mediatek.c |  4 ++--
> > > > > > > > > >  drivers/serial/ns16550.c    | 15 ++++++++++-----
> > > > > > > > > >  include/dm/fdtaddr.h        |  3 ++-
> > > > > > > > > >  include/dm/ofnode.h         |  4 +++-
> > > > > > > > > >  include/dm/read.h           |  8 +++++---
> > > > > > > > > >  include/ns16550.h           |  4 +++-
> > > > > > > > > >  include/serial.h            |  2 ++
> > > > > > > > > >  test/dm/pci.c               | 14 ++++++++++----
> > > > > > > > > >  16 files changed, 60 insertions(+), 32 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > > > > > > > > > index a413cbe4989..961e8895a49 100644
> > > > > > > > > > --- a/arch/sandbox/dts/test.dts
> > > > > > > > > > +++ b/arch/sandbox/dts/test.dts
> > > > > > > > > > @@ -1087,8 +1087,8 @@
> > > > > > > > > >  		pci@1,0 {
> > > > > > > > > >  			compatible = "pci-generic";
> > > > > > > > > >  			/* reg 0 is at 0x14, using FDT_PCI_SPACE_MEM32 */
> > > > > > > > > > -			reg = <0x02000814 0 0 0 0
> > > > > > > > > > -			       0x01000810 0 0 0 0>;
> > > > > > > > > > +			reg = <0x02000814 0 0 0x80 0
> > > > > > > > > > +			       0x01000810 0 0 0xc0 0>;
> > > > > > > > > >  			sandbox,emul = <&swap_case_emul0_1>;
> > > > > > > > > >  		};
> > > > > > > > > >  		p2sb-pci@2,0 {
> > > > > > > > > > @@ -1115,7 +1115,7 @@
> > > > > > > > > >  		pci@1f,0 {
> > > > > > > > > >  			compatible = "pci-generic";
> > > > > > > > > >  			/* reg 0 is at 0x10, using FDT_PCI_SPACE_IO */
> > > > > > > > > > -			reg = <0x0100f810 0 0 0 0>;
> > > > > > > > > > +			reg = <0x0100f810 0 0 0x100 0>;
> > > > > > > > > >  			sandbox,emul = <&swap_case_emul0_1f>;
> > > > > > > > > >  		};
> > > > > > > > > >  	};
> > > > > > > > > > diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
> > > > > > > > > > index 546db675aaf..b79d138c419 100644
> > > > > > > > > > --- a/drivers/core/fdtaddr.c
> > > > > > > > > > +++ b/drivers/core/fdtaddr.c
> > > > > > > > > > @@ -215,7 +215,7 @@ void *devfdt_map_physmem(const struct udevice *dev, unsigned long size)
> > > > > > > > > >  	return map_physmem(addr, size, MAP_NOCACHE);
> > > > > > > > > >  }
> > > > > > > > > >  
> > > > > > > > > > -fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev)
> > > > > > > > > > +fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size_t *sizep)
> > > > > > > > > >  {
> > > > > > > > > >  	ulong addr;
> > > > > > > > > >  
> > > > > > > > > > @@ -226,12 +226,12 @@ fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev)
> > > > > > > > > >  		int ret;
> > > > > > > > > >  
> > > > > > > > > >  		ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_MEM32,
> > > > > > > > > > -					   "reg", &pci_addr);
> > > > > > > > > > +					   "reg", &pci_addr, sizep);
> > > > > > > > > >  		if (ret) {
> > > > > > > > > >  			/* try if there is any i/o-mapped register */
> > > > > > > > > >  			ret = ofnode_read_pci_addr(dev_ofnode(dev),
> > > > > > > > > >  						   FDT_PCI_SPACE_IO, "reg",
> > > > > > > > > > -						   &pci_addr);
> > > > > > > > > > +						   &pci_addr, sizep);
> > > > > > > > > >  			if (ret)
> > > > > > > > > >  				return FDT_ADDR_T_NONE;
> > > > > > > > > >  		}
> > > > > > > > > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > > > > > > > > index 2ef4114cb6f..c9cec456f43 100644
> > > > > > > > > > --- a/drivers/core/ofnode.c
> > > > > > > > > > +++ b/drivers/core/ofnode.c
> > > > > > > > > > @@ -1270,7 +1270,8 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnode node, const char *propname,
> > > > > > > > > >  }
> > > > > > > > > >  
> > > > > > > > > >  int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
> > > > > > > > > > -			 const char *propname, struct fdt_pci_addr *addr)
> > > > > > > > > > +			 const char *propname, struct fdt_pci_addr *addr,
> > > > > > > > > > +			 fdt_size_t *size)
> > > > > > > > > >  {
> > > > > > > > > >  	const fdt32_t *cell;
> > > > > > > > > >  	int len;
> > > > > > > > > > @@ -1298,14 +1299,18 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
> > > > > > > > > >  			      (ulong)fdt32_to_cpu(cell[1]),
> > > > > > > > > >  			      (ulong)fdt32_to_cpu(cell[2]));
> > > > > > > > > >  			if ((fdt32_to_cpu(*cell) & type) == type) {
> > > > > > > > > > +				const unaligned_fdt64_t *ptr;
> > > > > > > > > > +
> > > > > > > > > >  				addr->phys_hi = fdt32_to_cpu(cell[0]);
> > > > > > > > > >  				addr->phys_mid = fdt32_to_cpu(cell[1]);
> > > > > > > > > >  				addr->phys_lo = fdt32_to_cpu(cell[2]);
> > > > > > > > > > +				ptr = (const unaligned_fdt64_t *)(cell + 3);
> > > > > > > > > > +				if (size)
> > > > > > > > > > +					*size = fdt64_to_cpu(*ptr);
> > > > > > > > > >  				break;
> > > > > > > > > >  			}
> > > > > > > > > >  
> > > > > > > > > > -			cell += (FDT_PCI_ADDR_CELLS +
> > > > > > > > > > -				 FDT_PCI_SIZE_CELLS);
> > > > > > > > > > +			cell += FDT_PCI_ADDR_CELLS + FDT_PCI_SIZE_CELLS;
> > > > > > > > > >  		}
> > > > > > > > > >  
> > > > > > > > > >  		if (i == num) {
> > > > > > > > > > diff --git a/drivers/core/read.c b/drivers/core/read.c
> > > > > > > > > > index 49066b59cda..419013451f0 100644
> > > > > > > > > > --- a/drivers/core/read.c
> > > > > > > > > > +++ b/drivers/core/read.c
> > > > > > > > > > @@ -405,13 +405,15 @@ int dev_read_alias_highest_id(const char *stem)
> > > > > > > > > >  	return fdtdec_get_alias_highest_id(gd->fdt_blob, stem);
> > > > > > > > > >  }
> > > > > > > > > >  
> > > > > > > > > > -fdt_addr_t dev_read_addr_pci(const struct udevice *dev)
> > > > > > > > > > +fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t *sizep)
> > > > > > > > > >  {
> > > > > > > > > >  	ulong addr;
> > > > > > > > > >  
> > > > > > > > > >  	addr = dev_read_addr(dev);
> > > > > > > > > > +	if (sizep)
> > > > > > > > > > +		*sizep = 0;
> > > > > > > > > >  	if (addr == FDT_ADDR_T_NONE && !of_live_active())
> > > > > > > > > > -		addr = devfdt_get_addr_pci(dev);
> > > > > > > > > > +		addr = devfdt_get_addr_pci(dev, sizep);
> > > > > > > > > >  
> > > > > > > > > >  	return addr;
> > > > > > > > > >  }
> > > > > > > > > > diff --git a/drivers/core/util.c b/drivers/core/util.c
> > > > > > > > > > index aa60fdd15bc..81497df85ff 100644
> > > > > > > > > > --- a/drivers/core/util.c
> > > > > > > > > > +++ b/drivers/core/util.c
> > > > > > > > > > @@ -30,7 +30,7 @@ int pci_get_devfn(struct udevice *dev)
> > > > > > > > > >  
> > > > > > > > > >  	/* Extract the devfn from fdt_pci_addr */
> > > > > > > > > >  	ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFIG,
> > > > > > > > > > -				   "reg", &addr);
> > > > > > > > > > +				   "reg", &addr, NULL);
> > > > > > > > > >  	if (ret) {
> > > > > > > > > >  		if (ret != -ENOENT)
> > > > > > > > > >  			return -EINVAL;
> > > > > > > > > > diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> > > > > > > > > > index 0adcdceb1d3..c670f8754e8 100644
> > > > > > > > > > --- a/drivers/pci/pci-uclass.c
> > > > > > > > > > +++ b/drivers/pci/pci-uclass.c
> > > > > > > > > > @@ -122,7 +122,7 @@ static void pci_dev_find_ofnode(struct udevice *bus, phys_addr_t bdf,
> > > > > > > > > >  
> > > > > > > > > >  	dev_for_each_subnode(node, bus) {
> > > > > > > > > >  		ret = ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg",
> > > > > > > > > > -					   &addr);
> > > > > > > > > > +					   &addr, NULL);
> > > > > > > > > >  		if (ret)
> > > > > > > > > >  			continue;
> > > > > > > > > >  
> > > > > > > > > > diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
> > > > > > > > > > index 93a7508d8a2..25878bde534 100644
> > > > > > > > > > --- a/drivers/pci/pci_mvebu.c
> > > > > > > > > > +++ b/drivers/pci/pci_mvebu.c
> > > > > > > > > > @@ -640,7 +640,8 @@ static int mvebu_pcie_port_parse_dt(ofnode node, ofnode parent, struct mvebu_pci
> > > > > > > > > >  		pcie->is_x4 = true;
> > > > > > > > > >  
> > > > > > > > > >  	/* devfn is in bits [15:8], see PCI_DEV usage */
> > > > > > > > > > -	ret = ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &pci_addr);
> > > > > > > > > > +	ret = ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &pci_addr,
> > > > > > > > > > +				   NULL);
> > > > > > > > > >  	if (ret < 0) {
> > > > > > > > > >  		printf("%s: property \"reg\" is invalid\n", pcie->name);
> > > > > > > > > >  		goto err;
> > > > > > > > > > diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
> > > > > > > > > > index 29d54117e93..ae90bd2fbf1 100644
> > > > > > > > > > --- a/drivers/pci/pci_tegra.c
> > > > > > > > > > +++ b/drivers/pci/pci_tegra.c
> > > > > > > > > > @@ -461,7 +461,7 @@ static int tegra_pcie_parse_port_info(ofnode node, uint *index, uint *lanes)
> > > > > > > > > >  
> > > > > > > > > >  	*lanes = err;
> > > > > > > > > >  
> > > > > > > > > > -	err = ofnode_read_pci_addr(node, 0, "reg", &addr);
> > > > > > > > > > +	err = ofnode_read_pci_addr(node, 0, "reg", &addr, NULL);
> > > > > > > > > >  	if (err < 0) {
> > > > > > > > > >  		pr_err("failed to parse \"reg\" property\n");
> > > > > > > > > >  		return err;
> > > > > > > > > > diff --git a/drivers/pci/pcie_mediatek.c b/drivers/pci/pcie_mediatek.c
> > > > > > > > > > index c6e30e24622..e59ebd13ad0 100644
> > > > > > > > > > --- a/drivers/pci/pcie_mediatek.c
> > > > > > > > > > +++ b/drivers/pci/pcie_mediatek.c
> > > > > > > > > > @@ -660,7 +660,7 @@ static int mtk_pcie_probe(struct udevice *dev)
> > > > > > > > > >  		if (!ofnode_is_enabled(subnode))
> > > > > > > > > >  			continue;
> > > > > > > > > >  
> > > > > > > > > > -		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr);
> > > > > > > > > > +		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
> > > > > > > > > >  		if (err)
> > > > > > > > > >  			return err;
> > > > > > > > > >  
> > > > > > > > > > @@ -699,7 +699,7 @@ static int mtk_pcie_probe_v2(struct udevice *dev)
> > > > > > > > > >  		if (!ofnode_is_enabled(subnode))
> > > > > > > > > >  			continue;
> > > > > > > > > >  
> > > > > > > > > > -		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr);
> > > > > > > > > > +		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
> > > > > > > > > >  		if (err)
> > > > > > > > > >  			return err;
> > > > > > > > > >  
> > > > > > > > > > diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> > > > > > > > > > index eab9537fbae..a349e5e132a 100644
> > > > > > > > > > --- a/drivers/serial/ns16550.c
> > > > > > > > > > +++ b/drivers/serial/ns16550.c
> > > > > > > > > > @@ -479,6 +479,7 @@ static int ns16550_serial_getinfo(struct udevice *dev,
> > > > > > > > > >  	info->addr_space = SERIAL_ADDRESS_SPACE_MEMORY;
> > > > > > > > > >  #endif
> > > > > > > > > >  	info->addr = plat->base;
> > > > > > > > > > +	info->size = plat->size;
> > > > > > > > > >  	info->reg_width = plat->reg_width;
> > > > > > > > > >  	info->reg_shift = plat->reg_shift;
> > > > > > > > > >  	info->reg_offset = plat->reg_offset;
> > > > > > > > > > @@ -487,7 +488,8 @@ static int ns16550_serial_getinfo(struct udevice *dev,
> > > > > > > > > >  	return 0;
> > > > > > > > > >  }
> > > > > > > > > >  
> > > > > > > > > > -static int ns16550_serial_assign_base(struct ns16550_plat *plat, fdt_addr_t base)
> > > > > > > > > > +static int ns16550_serial_assign_base(struct ns16550_plat *plat,
> > > > > > > > > > +				      fdt_addr_t base, fdt_size_t size)
> > > > > > > > > >  {
> > > > > > > > > >  	if (base == FDT_ADDR_T_NONE)
> > > > > > > > > >  		return -EINVAL;
> > > > > > > > > > @@ -497,6 +499,7 @@ static int ns16550_serial_assign_base(struct ns16550_plat *plat, fdt_addr_t base
> > > > > > > > > >  #else
> > > > > > > > > >  	plat->base = (unsigned long)map_physmem(base, 0, MAP_NOCACHE);
> > > > > > > > > >  #endif
> > > > > > > > > > +	plat->size = size;
> > > > > > > > > >  
> > > > > > > > > >  	return 0;
> > > > > > > > > >  }
> > > > > > > > > > @@ -507,6 +510,7 @@ int ns16550_serial_probe(struct udevice *dev)
> > > > > > > > > >  	struct ns16550 *const com_port = dev_get_priv(dev);
> > > > > > > > > >  	struct reset_ctl_bulk reset_bulk;
> > > > > > > > > >  	fdt_addr_t addr;
> > > > > > > > > > +	fdt_addr_t size;
> > > > > > > > > >  	int ret;
> > > > > > > > > >  
> > > > > > > > > >  	/*
> > > > > > > > > > @@ -514,8 +518,8 @@ int ns16550_serial_probe(struct udevice *dev)
> > > > > > > > > >  	 * or via a PCI bridge, assign plat->base before probing hardware.
> > > > > > > > > >  	 */
> > > > > > > > > >  	if (device_is_on_pci_bus(dev)) {
> > > > > > > > > > -		addr = devfdt_get_addr_pci(dev);
> > > > > > > > > > -		ret = ns16550_serial_assign_base(plat, addr);
> > > > > > > > > > +		addr = devfdt_get_addr_pci(dev, &size);
> > > > > > > > > > +		ret = ns16550_serial_assign_base(plat, addr, size);
> > > > > > > > > >  		if (ret)
> > > > > > > > > >  			return ret;
> > > > > > > > > >  	}
> > > > > > > > > > @@ -543,11 +547,12 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
> > > > > > > > > >  	struct ns16550_plat *plat = dev_get_plat(dev);
> > > > > > > > > >  	const u32 port_type = dev_get_driver_data(dev);
> > > > > > > > > >  	fdt_addr_t addr;
> > > > > > > > > > +	fdt_size_t size;
> > > > > > > > > >  	struct clk clk;
> > > > > > > > > >  	int err;
> > > > > > > > > >  
> > > > > > > > > > -	addr = dev_read_addr(dev);
> > > > > > > > > > -	err = ns16550_serial_assign_base(plat, addr);
> > > > > > > > > > +	addr = dev_read_addr_size(dev, &size);
> > > > > > > > > > +	err = ns16550_serial_assign_base(plat, addr, size);
> > > > > > > > > >  	if (err && !device_is_on_pci_bus(dev))
> > > > > > > > > >  		return err;
> > > > > > > > > >  
> > > > > > > > > > diff --git a/include/dm/fdtaddr.h b/include/dm/fdtaddr.h
> > > > > > > > > > index dcdc19137cc..6d2fa8f1044 100644
> > > > > > > > > > --- a/include/dm/fdtaddr.h
> > > > > > > > > > +++ b/include/dm/fdtaddr.h
> > > > > > > > > > @@ -168,8 +168,9 @@ fdt_addr_t devfdt_get_addr_size_name(const struct udevice *dev,
> > > > > > > > > >   * devfdt_get_addr_pci() - Read an address and handle PCI address translation
> > > > > > > > > >   *
> > > > > > > > > >   * @dev: Device to read from
> > > > > > > > > > + * @sizep: If non-NULL, returns size of address space
> > > > > > > > > >   * Return: address or FDT_ADDR_T_NONE if not found
> > > > > > > > > >   */
> > > > > > > > > > -fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev);
> > > > > > > > > > +fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size_t *sizep);
> > > > > > > > > >  
> > > > > > > > > >  #endif
> > > > > > > > > > diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> > > > > > > > > > index 726d8f82ddf..97cad971611 100644
> > > > > > > > > > --- a/include/dm/ofnode.h
> > > > > > > > > > +++ b/include/dm/ofnode.h
> > > > > > > > > > @@ -1152,13 +1152,15 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnode node, const char *propname,
> > > > > > > > > >   * @type:	pci address type (FDT_PCI_SPACE_xxx)
> > > > > > > > > >   * @propname:	name of property to find
> > > > > > > > > >   * @addr:	returns pci address in the form of fdt_pci_addr
> > > > > > > > > > + * @size:	if non-null, returns register-space size
> > > > > > > > > >   * Return:
> > > > > > > > > >   * 0 if ok, -ENOENT if the property did not exist, -EINVAL if the
> > > > > > > > > >   * format of the property was invalid, -ENXIO if the requested
> > > > > > > > > >   * address type was not found
> > > > > > > > > >   */
> > > > > > > > > >  int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
> > > > > > > > > > -			 const char *propname, struct fdt_pci_addr *addr);
> > > > > > > > > > +			 const char *propname, struct fdt_pci_addr *addr,
> > > > > > > > > > +			 fdt_size_t *size);
> > > > > > > > > >  
> > > > > > > > > >  /**
> > > > > > > > > >   * ofnode_read_pci_vendev() - look up PCI vendor and device id
> > > > > > > > > > diff --git a/include/dm/read.h b/include/dm/read.h
> > > > > > > > > > index c2615f72f40..3c2eea6f0c4 100644
> > > > > > > > > > --- a/include/dm/read.h
> > > > > > > > > > +++ b/include/dm/read.h
> > > > > > > > > > @@ -346,9 +346,10 @@ void *dev_read_addr_ptr(const struct udevice *dev);
> > > > > > > > > >   *    fdtdec_get_addr() and friends.
> > > > > > > > > >   *
> > > > > > > > > >   * @dev: Device to read from
> > > > > > > > > > + * @sizep: If non-NULL, returns size of address space found
> > > > > > > > > >   * Return: address or FDT_ADDR_T_NONE if not found
> > > > > > > > > >   */
> > > > > > > > > > -fdt_addr_t dev_read_addr_pci(const struct udevice *dev);
> > > > > > > > > > +fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t *sizep);
> > > > > > > > > >  
> > > > > > > > > >  /**
> > > > > > > > > >   * dev_remap_addr() - Get the reg property of a device as a
> > > > > > > > > > @@ -996,9 +997,10 @@ static inline void *dev_read_addr_ptr(const struct udevice *dev)
> > > > > > > > > >  	return devfdt_get_addr_ptr(dev);
> > > > > > > > > >  }
> > > > > > > > > >  
> > > > > > > > > > -static inline fdt_addr_t dev_read_addr_pci(const struct udevice *dev)
> > > > > > > > > > +static inline fdt_addr_t dev_read_addr_pci(const struct udevice *dev,
> > > > > > > > > > +					   fdt_size_t *sizep)
> > > > > > > > > >  {
> > > > > > > > > > -	return devfdt_get_addr_pci(dev);
> > > > > > > > > > +	return devfdt_get_addr_pci(dev, sizep);
> > > > > > > > > >  }
> > > > > > > > > >  
> > > > > > > > > >  static inline void *dev_remap_addr(const struct udevice *dev)
> > > > > > > > > > diff --git a/include/ns16550.h b/include/ns16550.h
> > > > > > > > > > index e7e68663d03..7f481300083 100644
> > > > > > > > > > --- a/include/ns16550.h
> > > > > > > > > > +++ b/include/ns16550.h
> > > > > > > > > > @@ -58,6 +58,7 @@ enum ns16550_flags {
> > > > > > > > > >   * struct ns16550_plat - information about a NS16550 port
> > > > > > > > > >   *
> > > > > > > > > >   * @base:		Base register address
> > > > > > > > > > + * @size:		Size of register area in bytes
> > > > > > > > > >   * @reg_width:		IO accesses size of registers (in bytes, 1 or 4)
> > > > > > > > > >   * @reg_shift:		Shift size of registers (0=byte, 1=16bit, 2=32bit...)
> > > > > > > > > >   * @reg_offset:		Offset to start of registers (normally 0)
> > > > > > > > > > @@ -67,7 +68,8 @@ enum ns16550_flags {
> > > > > > > > > >   * @bdf:		PCI slot/function (pci_dev_t)
> > > > > > > > > >   */
> > > > > > > > > >  struct ns16550_plat {
> > > > > > > > > > -	unsigned long base;
> > > > > > > > > > +	ulong base;
> > > > > > > > > > +	ulong size;
> > > > > > > > > >  	int reg_width;
> > > > > > > > > >  	int reg_shift;
> > > > > > > > > >  	int reg_offset;
> > > > > > > > > > diff --git a/include/serial.h b/include/serial.h
> > > > > > > > > > index 42bdf3759c0..205889d28be 100644
> > > > > > > > > > --- a/include/serial.h
> > > > > > > > > > +++ b/include/serial.h
> > > > > > > > > > @@ -137,6 +137,7 @@ enum adr_space_type {
> > > > > > > > > >   * @type:	type of the UART chip
> > > > > > > > > >   * @addr_space:	address space to access the registers
> > > > > > > > > >   * @addr:	physical address of the registers
> > > > > > > > > > + * @size:	size of the register area in bytes
> > > > > > > > > >   * @reg_width:	size (in bytes) of the IO accesses to the registers
> > > > > > > > > >   * @reg_offset:	offset to apply to the @addr from the start of the registers
> > > > > > > > > >   * @reg_shift:	quantity to shift the register offsets by
> > > > > > > > > > @@ -147,6 +148,7 @@ struct serial_device_info {
> > > > > > > > > >  	enum serial_chip_type type;
> > > > > > > > > >  	enum adr_space_type addr_space;
> > > > > > > > > >  	ulong addr;
> > > > > > > > > > +	ulong size;
> > > > > > > > > >  	u8 reg_width;
> > > > > > > > > >  	u8 reg_offset;
> > > > > > > > > >  	u8 reg_shift;
> > > > > > > > > > diff --git a/test/dm/pci.c b/test/dm/pci.c
> > > > > > > > > > index 70a736cfdb8..8c5e7da9e62 100644
> > > > > > > > > > --- a/test/dm/pci.c
> > > > > > > > > > +++ b/test/dm/pci.c
> > > > > > > > > > @@ -301,10 +301,12 @@ static int dm_test_pci_addr_flat(struct unit_test_state *uts)
> > > > > > > > > >  {
> > > > > > > > > >  	struct udevice *swap1f, *swap1;
> > > > > > > > > >  	ulong io_addr, mem_addr;
> > > > > > > > > > +	fdt_addr_t size;
> > > > > > > > > >  
> > > > > > > > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
> > > > > > > > > >  	io_addr = dm_pci_read_bar32(swap1f, 0);
> > > > > > > > > > -	ut_asserteq(io_addr, dev_read_addr_pci(swap1f));
> > > > > > > > > > +	ut_asserteq(io_addr, dev_read_addr_pci(swap1f, &size));
> > > > > > > > > > +	ut_asserteq(0, size);
> > > > > > > > > >  
> > > > > > > > > >  	/*
> > > > > > > > > >  	 * This device has both I/O and MEM spaces but the MEM space appears
> > > > > > > > > > @@ -312,7 +314,8 @@ static int dm_test_pci_addr_flat(struct unit_test_state *uts)
> > > > > > > > > >  	 */
> > > > > > > > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
> > > > > > > > > >  	mem_addr = dm_pci_read_bar32(swap1, 1);
> > > > > > > > > > -	ut_asserteq(mem_addr, dev_read_addr_pci(swap1));
> > > > > > > > > > +	ut_asserteq(mem_addr, dev_read_addr_pci(swap1, &size));
> > > > > > > > > > +	ut_asserteq(0, size);
> > > > > > > > > >  
> > > > > > > > > >  	return 0;
> > > > > > > > > >  }
> > > > > > > > > > @@ -329,12 +332,15 @@ DM_TEST(dm_test_pci_addr_flat, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT |
> > > > > > > > > >  static int dm_test_pci_addr_live(struct unit_test_state *uts)
> > > > > > > > > >  {
> > > > > > > > > >  	struct udevice *swap1f, *swap1;
> > > > > > > > > > +	fdt_size_t size;
> > > > > > > > > >  
> > > > > > > > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
> > > > > > > > > > -	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f));
> > > > > > > > > > +	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f, &size));
> > > > > > > > > > +	ut_asserteq(0, size);
> > > > > > > > > >  
> > > > > > > > > >  	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
> > > > > > > > > > -	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1));
> > > > > > > > > > +	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1, &size));
> > > > > > > > > > +	ut_asserteq(0, size);
> > > > > > > > > >  
> > > > > > > > > >  	return 0;
> > > > > > > > > >  }
> > > > > > > > > > -- 
> > > > > > > > > > 2.42.0.rc2.253.gd59a3bf2b4-goog
> > > > > > > > > > 
> > > > > > > > 
> > > > > > > > -- 
> > > > > > > > Tom
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > -- 
> > > > > > Tom
> > > > > 
> > > > > 
> > > > 
> > > > -- 
> > > > Tom
> > > 
> > > 
> 
> -- 
> Tom


