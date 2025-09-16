Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF849CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EC780325;
	Tue, 16 Sep 2025 16:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F80C83071; Tue, 16 Sep 2025 16:06:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9BEB3800D7
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 16:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E4F512FC;
 Tue, 16 Sep 2025 07:06:33 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B315E3F673;
 Tue, 16 Sep 2025 07:06:40 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:06:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev, John Watts
 <contact@jookia.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 u-boot@lists.denx.de, =?UTF-8?B?QW5kcsOhcyBTemVtesWR?=
 <szemzo.andras@gmail.com>
Subject: Re: [PATCH v2] sunxi: extend R528/T113-s3/D1(s) DRAM initialisation
Message-ID: <20250916150601.1dc82d5f@donnerap>
References: <20250915192036.323741-1-lukas.schmid@netcube.li>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 16 Sep 2025 01:40:26 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

Hi Lukas,

please remember to wait for a bit before sending out a v2, to give other
people time to respond, to the patch itself and also the comments to that.
Given the current U-Boot development state, this is October material, so
there is no real rush.

> On Mon, 15 Sep 2025 21:20:35 +0200
> Lukas Schmid <lukas.schmid@netcube.li> wrote:
> 
> > Extend the DRAM initialisation code to add support for the T113-S4 aka
> > T113M4020DC0 by checking the SoC's CHIPID.
> > 
> > The list of Chip-IDs came from
> > https://github.com/ua1arn/hftrx/blob/25d8cb9e4cfe1d7d0e4a2f641025c88a9ec5e758/inc/clocks.h#L250

I am not sure a random github repo is necessarily a good reference. What's
more important here is our observation that the -s4 chips we have seen use
that identifier, which is different from the -s3 ones.
I wonder if we should include the 0x6800 identifier, since it's apparently
used out there in the wild for some -s4 batches, too?

> > And the chipid register address was something I heard through apritzel
> > altough it seems that, according to Jookia, the Tina Device Tree seems
> > to agree:
> > 
> > sid@3006000 {
> > 	compatible = "allwinner,sun20iw1p1-sid", "allwinner,sunxi-sid";
> > 	reg = <0x0 0x03006000 0 0x1000>;
> > 	#address-cells = <1>;
> > 	#size-cells = <1>;
> > 
> > 	chipid {
> > 		reg = <0x0 0>;
> > 		offset = <0x200>;
> > 		size = <0x10>;
> > 	};
> > 	...
> > };  
> 

I understand you did this after John's comment, but I am replying here since
it's the newest version of the patch: that's a lot of words for something
that has been widely known for almost a decade now: "The first word of the
SID carries some batch/package information." So I don't think that
deserves some lengthy paragraph, and I would like to avoid proliferating
unreviewed and undocumented BSP DT snippets.

So I think the wording should be more along the line of "certain batches
or packages, identifiable by the SID chip ID, require a different
remapping table".

Cheers,
Andre

> 
> > 
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > Tested-by: John Watts <contact@jookia.org>
> > Reviewed-by: John Watts <contact@jookia.org>
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > Changes in v2:
> >   - Use uint32_t instead of u32 for sid_read_soc_chipid return type
> >   - Add descriptive comment about source of Chip-ID list and register
> > 
> >  drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
> >  drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
> > index a1794032f3b..381eeb87e2e 100644
> > --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> > @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *para)
> >  	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
> >  }
> >  
> > +static uint32_t sid_read_soc_chipid(void)
> > +{
> > +	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> > +}
> > +
> >  static void dram_voltage_set(const dram_para_t *para)
> >  {
> >  	int vol;
> > @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
> >  
> >  	fuse = (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
> >  	debug("DDR efuse: 0x%x\n", fuse);
> > +	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
> >  
> >  	if (para->dram_type == SUNXI_DRAM_TYPE_DDR2) {
> >  		if (fuse == 15)
> > @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
> >  			switch (fuse) {
> >  			case 8: cfg = ac_remapping_tables[2]; break;
> >  			case 9: cfg = ac_remapping_tables[3]; break;
> > -			case 10: cfg = ac_remapping_tables[5]; break;
> > +			case 10:
> > +				if (sid_read_soc_chipid() == SUNXI_CHIPID_T113M4020DC0)
> > +					cfg = ac_remapping_tables[0];
> > +				else
> > +					cfg = ac_remapping_tables[5];
> > +				break;
> >  			case 11: cfg = ac_remapping_tables[4]; break;
> >  			default:
> >  			case 12: cfg = ac_remapping_tables[1]; break;
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h b/drivers/ram/sunxi/dram_sun20i_d1.h
> > index 91383f6cf10..7bd8f67a77a 100644
> > --- a/drivers/ram/sunxi/dram_sun20i_d1.h
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
> > @@ -19,6 +19,13 @@ enum sunxi_dram_type {
> >  	SUNXI_DRAM_TYPE_LPDDR3 = 7,
> >  };
> >  
> > +enum sunxi_soc_chipid {
> > +	SUNXI_CHIPID_F133A = 0x5C00,
> > +	SUNXI_CHIPID_D1S = 0x5E00,
> > +	SUNXI_CHIPID_T113S3 = 0x6000,
> > +	SUNXI_CHIPID_T113M4020DC0 = 0x7200,
> > +};
> > +
> >  /*
> >   * This structure contains a mixture of fixed configuration settings,
> >   * variables that are used at runtime to communicate settings between  
> 

