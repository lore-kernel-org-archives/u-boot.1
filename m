Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED745C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1318B80657;
	Tue, 14 Jan 2025 08:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FFF80658; Tue, 14 Jan 2025 08:12:38 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5828A80619
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Tue, 14 Jan 2025 07:12:27 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Huan Zhou <me@per1cycle.org>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH v2] riscv: spacemit: k1: probe dram size during boot phase.
Message-ID: <20250114071227-GYA17216@gentoo>
References: <20250114-get-dram-size-v2-1-aba5a281ea28@per1cycle.org>
 <20250114051313.4t25kkjldygjzrg2@per1cycle.per1cycle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114051313.4t25kkjldygjzrg2@per1cycle.per1cycle>
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

Hi Huan

On 13:13 Tue 14 Jan     , Huan Zhou wrote:
> sry for the delay, i was setting my homelab these day.
> 
> On Tue, Jan 14, 2025 at 01:10:42PM +0800, Huan Zhou wrote:
> > 
> > 
> these content is from the cover letter and imo should be ignore during patch step.
still wrong, at least tags will be lost

IMO, it would be better to have some commit message

> > ---
> > This patch introduce improvement for get dram size on bananapi BPI-F3,
the patch for k1 SoC, it should be board agnostic        ~~~~~~~~~~~~~~~~
> > retrieving the dram size dynamically.
> > Have tested on bananapi Licheepi LPI3A 8G[1].
> > 
> > Links:
> > [1] https://gist.github.com/per1cycle/e4eab66ebb6f83fe5118e823367fce28 .
> > 
> > Changes in v2:
> > - Fix bracker and return type in map_format_size() function.
> > - Add test log in the cover letter..
> > - Link to v1: https://lore.kernel.org/r/20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org
> > 
..
> > Signed-off-by: Huan Zhou <me@per1cycle.org>
> > Tested-by: Marcel Ziswiler <marcel@ziswiler.com> # BPI-F3 16G
here lost
> > ---
> >  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> > index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..4140440255fa1b3dbae521c58c6809445499a463 100644
> > --- a/arch/riscv/cpu/k1/dram.c
> > +++ b/arch/riscv/cpu/k1/dram.c
> > @@ -4,17 +4,53 @@
> >   */
> >  
> >  #include <asm/global_data.h>
> > +#include <asm/io.h>
> >  #include <config.h>
> > +#include <bitfield.h>
> >  #include <fdt_support.h>
> >  #include <linux/sizes.h>
> >  
> > +#define DDR_BASE 0xC0000000
> >  DECLARE_GLOBAL_DATA_PTR;
> >  
> > +static inline phys_size_t map_format_size(u32 val)
I don't think it's necessary to use inline, it's not that short
so personally I would drop it

> > +{
> > +	u32 tmp;
> > +
> > +	if (!(val & 0x1))
> > +		return 0;
> > +
> > +	tmp = bitfield_extract(val, 16, 5);
> > +	switch (tmp) {
> > +	case 0xd:
> > +		return 512;
> > +	case 0xe:
> > +		return 1024;
> > +	case 0xf:
> > +		return 2048;
> > +	case 0x10:
> > +		return 4096;
> > +	case 0x11:
> > +		return 8192;
> > +	default:
> > +		pr_info("Invalid DRAM density %x\n", val);
> > +		return 0;
> > +	}
> > +}
> > +
> > +phys_size_t ddr_get_density(void)
> > +{
> > +	phys_size_t cs0_size = map_format_size(readl((void *)DDR_BASE + 0x200));
> > +	phys_size_t cs1_size = map_format_size(readl((void *)DDR_BASE + 0x208));
> > +	phys_size_t ddr_size = cs0_size + cs1_size;
> > +
> > +	return ddr_size;
> > +}
> > +
> >  int dram_init(void)
> >  {
> >  	gd->ram_base = CFG_SYS_SDRAM_BASE;
> > -	/* TODO get ram size from ddr controller */
> > -	gd->ram_size = SZ_4G;
> > +	gd->ram_size = ddr_get_density() * SZ_1M;
> >  	return 0;
> >  }
> >  
> > 
> > ---
> > base-commit: 19fc0b7f7d907119a13e9c207991899f0817f8fc
> > change-id: 20250108-get-dram-size-65cf59a15201
> > 
> > Best regards,
> > -- 
> > Huan Zhou <me@per1cycle.org>
> > 
with above fixed, then

Reviewed-by: Yixun Lan <dlan@gentoo.org>
-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
