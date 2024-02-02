Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3E9C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB0987C4F;
	Fri,  2 Feb 2024 17:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UXdJn5dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFE687C5B; Fri,  2 Feb 2024 17:29:00 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12EA87C35
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412GSqbi011677;
 Fri, 2 Feb 2024 10:28:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706891332;
 bh=fUTZiQX5J3HMwKUJGP0Je6c5k6gHJmPkNyN6PsmXZ8Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=UXdJn5dyrFCSyJCV5fXa02Dn1r1zbcZ/j+x5wOmwD+Tuzwkk7dO+YisHhR5aIZLqc
 fhbFp7LQfCPZd9KtQZBYi2tdngm8GJ+NcY83lTQrErxAA5ByhSjhvhhHSJOfVM/spG
 uUF9Yp42n/92iP/6XmzIEEXqd0g+Qwg67z9VIK6c=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412GSq7D034689
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 Feb 2024 10:28:52 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 10:28:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 10:28:51 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412GSqE2118982;
 Fri, 2 Feb 2024 10:28:52 -0600
Date: Fri, 2 Feb 2024 10:28:51 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, UBoot Mailing List
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 10/13] arm: dts: introduce am62p5 uboot dts files
Message-ID: <20240202162851.r7qdc4nbxexwoooe@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240201030634.1120963-16-bb@ti.com>
 <20240201030634.1120963-27-bb@ti.com>
 <f5dc14c5-1537-4bd6-aec2-cf7f3da20a36@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <f5dc14c5-1537-4bd6-aec2-cf7f3da20a36@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Andrew!

On February  2, 2024 thus sayeth Andrew Davis:
> On 1/31/24 9:06 PM, Bryan Brattlof wrote:
> > Include the uboot device tree files needed to boot the board.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >   arch/arm/dts/Makefile                      |    2 +
> >   arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi | 2800 ++++++++++++++++++++
> >   arch/arm/dts/k3-am62p-sk-binman.dtsi       |  173 ++
> >   arch/arm/dts/k3-am62p5-r5-sk.dts           |  101 +
> >   arch/arm/dts/k3-am62p5-sk-u-boot.dtsi      |   49 +
> >   arch/arm/mach-k3/Makefile                  |    1 +
> >   arch/arm/mach-k3/am62p5_init.c             |    4 +-
> >   dts/arch/arm64/ti                          |    1 +
> >   8 files changed, 3129 insertions(+), 2 deletions(-)
> >   create mode 100644 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
> >   create mode 100644 arch/arm/dts/k3-am62p-sk-binman.dtsi
> >   create mode 100644 arch/arm/dts/k3-am62p5-r5-sk.dts
> >   create mode 100644 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> >   create mode 120000 dts/arch/arm64/ti
> > 

...

> > diff --git a/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi 
> > b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
> > new file mode 100644
> > index 0000000000000..f66435201530f
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
> > @@ -0,0 +1,2800 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * This file was generated with the
> > + * AM62Px SysConfig DDR Subsystem Register Configuration Tool v0.10.02
> > + * Thu Jan 25 2024 10:43:46 GMT-0600 (Central Standard Time)
> > + * DDR Type: LPDDR4
> > + * F0 = 50MHz    F1 = NA     F2 = 1600MHz
> > + * Density (per channel): 16Gb
> > + * Number of Ranks: 2
> > + */
> > +
> > +#define DDRSS_PLL_FHS_CNT 5
> > +#define DDRSS_PLL_FREQUENCY_1 800000000
> > +#define DDRSS_PLL_FREQUENCY_2 800000000
> > +#define DDRSS_SDRAM_IDX 17
> > +#define DDRSS_REGION_IDX 17
> > +
> > +#define DDRSS_CTL_0_DATA 0x00000B00
> > +#define DDRSS_CTL_1_DATA 0x00000000
> > +#define DDRSS_CTL_2_DATA 0x00000000
> > +#define DDRSS_CTL_3_DATA 0x00000000
> > +#define DDRSS_CTL_4_DATA 0x00000000
> > +#define DDRSS_CTL_5_DATA 0x00000000
> 
> I wonder if it would be better to generate this file
> during build..
> 

Yeah we can save a lot of space by removing tons of these registers 
writing 0x0 to the reserved ranges... The section for the different PHYs 
is particularly aggravating.

I told Simon and Marex last year I'd get to it once I find some free 
cycles and then I went and had a son ;) but it's still in the backlog 

> 
> > +&main_bcdma {
> > +	reg = <0x00 0x485c0100 0x00 0x100>,
> > +	      <0x00 0x4c000000 0x00 0x20000>,
> > +	      <0x00 0x4a820000 0x00 0x20000>,
> > +	      <0x00 0x4aa40000 0x00 0x20000>,
> > +	      <0x00 0x4bc00000 0x00 0x100000>,
> > +	      <0x00 0x48600000 0x00 0x8000>,
> > +	      <0x00 0x484a4000 0x00 0x2000>,
> > +	      <0x00 0x484c2000 0x00 0x2000>;
> > +	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
> > +		    "ringrt", "cfg", "tchan", "rchan";
> > +};
> > +
> 
> Do we still need these? Thought they got fixed kernel side already.

Ah you're right I missed that i'll remove this in v2

> 
> > +&main_pktdma {
> > +	reg = <0x00 0x485c0000 0x00 0x100>,
> > +	      <0x00 0x4a800000 0x00 0x20000>,
> > +	      <0x00 0x4aa00000 0x00 0x40000>,
> > +	      <0x00 0x4b800000 0x00 0x400000>,
> > +	      <0x00 0x485e0000 0x00 0x20000>,
> > +	      <0x00 0x484a0000 0x00 0x4000>,
> > +	      <0x00 0x484c0000 0x00 0x2000>,
> > +	      <0x00 0x48430000 0x00 0x4000>;
> > +	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
> > +		    "cfg", "tchan", "rchan", "rflow";
> > +};
> > diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> > index 42161376469e2..820b313a83c23 100644
> > --- a/arch/arm/mach-k3/Makefile
> > +++ b/arch/arm/mach-k3/Makefile
> > @@ -20,5 +20,6 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
> >   obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
> >   obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
> >   obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
> > +obj-$(CONFIG_SOC_K3_AM62P5) += am62p5_init.o
> >   endif
> >   obj-y += common.o security.o
> > diff --git a/arch/arm/mach-k3/am62p5_init.c b/arch/arm/mach-k3/am62p5_init.c
> > index 5b6795cc7d246..9ff877d5d26e8 100644
> > --- a/arch/arm/mach-k3/am62p5_init.c
> > +++ b/arch/arm/mach-k3/am62p5_init.c
> > @@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
> >   	 * through a SYSFW PM-init step and will need a re-init in some way
> >   	 * due to changing module clock frequencies.
> >   	 */
> > -	if (IS_ENABLED(CONFIG_K3_EARLY_CONS))
> > +	if (IS_ENABLED(CONFIG_K3_EARLY_CONS)) {
> 
> Looks like fixes for a previous patch that didn't get squashed.
>

haha Oops good catch.. I'll fixup this properly


Thanks for the review Andrew
~Bryan
