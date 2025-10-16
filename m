Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01844CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 11:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F2A83693;
	Thu, 16 Oct 2025 13:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D8A8836A3; Thu, 16 Oct 2025 13:15:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C83FF8367F
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 13:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC6311688;
 Thu, 16 Oct 2025 04:15:02 -0700 (PDT)
Received: from [10.57.4.22] (unknown [10.57.4.22])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC01D3F6A8;
 Thu, 16 Oct 2025 04:15:09 -0700 (PDT)
Message-ID: <b22aed3f-a08c-4211-b6e6-041aeacc3a58@arm.com>
Date: Thu, 16 Oct 2025 12:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v1 1/1] sunxi: extend R528/T113-s3/D1(s) DRAM
 initialisation
To: John Watts <contact@jookia.org>
Cc: Lukas Schmid <lukas.schmid@netcube.li>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250914144411.157826-1-lukas.schmid@netcube.li>
 <aMg9LQ6VlxkNCgbk@titan>
Content-Language: en-US
In-Reply-To: <aMg9LQ6VlxkNCgbk@titan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On Tue, 16 Sep 2025 02:22:05 +1000
John Watts <contact@jookia.org> wrote:

Hi John,

just one part that wasn't commented on yet:

> On Sun, Sep 14, 2025 at 04:44:11PM +0200, Lukas Schmid wrote:
> > Extend the DRAM initialisation code to add support for the T113-S4 aka
> > T113M4020DC0 by checking the SoC's CHIPID.  
> 
> Hi there, I've tested this patch and confirm that it is required to boot my
> T113-S4 from an EmbedSky dev kit. Here is the product:
> http://wiki.armbbs.net/tqwiki/public/docs/TQT113_CORE
> I can confirm this board does not boot without this patch.
> 
> Here's a Tested-by and Reviewed-By:
> 
> Tested-by: John Watts <contact@jookia.org>
> Reviewed-by: John Watts <contact@jookia.org>
> 
> > 
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > ---
> >  drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
> >  drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
> > index a1794032f3b..01d19d5feaa 100644
> > --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> > @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *para)
> >  	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
> >  }
> >  
> > +static u32 sid_read_soc_chipid(void)
> > +{
> > +	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> > +}
> > +  
> 
> mctl_phy_ac_remapping uses readl to read a fuse and labels that as uint32_t,
> maybe this should be uint32_t too?
> The other question I have is how did you figure out this register and mask?
> it documented somewhere? I would love to see a comment or note in the Git
> commit saying where these values came from, even if it's just 'taken from
> sunxi-fel' or 'heard from apritzel'. Having notes like that can really help
> when troubleshooting old code, which hopefully this will be one day.
> 
> I found something that seems to agree from the Tina device tree:
> 		sid@3006000 {
> 			compatible = "allwinner,sun20iw1p1-sid", "allwinner,sunxi-sid";
> 			reg = <0x0 0x03006000 0 0x1000>;
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			chipid {
> 				reg = <0x0 0>;
> 				offset = <0x200>;
> 				size = <0x10>;
> 			};
> 
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
> 
> Same question as previous: Where do these values come from? Could this be
> documented? I can't find these values anywhere else. Noting this down would
> help if someone wants to use them as reference to if they turn out to be wrong.
> Speaking of...
> 
> awboot seems to believe the T113S4 chip ID is 0x6800:
> https://github.com/szemzoa/awboot/blob/main/arch/arm32/mach-t113s4/dram.c#L726
> 
> 				if(chipid == 0x6800){ // 0x6800 is T113-S4 no remap

As András mentioned in another email, he did not test the T113-S4 with 
awboot. So far I have seen two confirmations that 0x7200 works, and no 
negative complaints, so I would like to go with 0x7200. If people run 
into problems with their board later, I am more than happy to add any 
other number to that check.

Cheers,
Andre

> 					cfg = ac_remapping_tables[0];
> 				} else {
> 					cfg = ac_remapping_tables[5];
> 				}
> 
> Perhaps theirs is for the M4030DC0 or something?
> 
> >  /*
> >   * This structure contains a mixture of fixed configuration settings,
> >   * variables that are used at runtime to communicate settings between
> > -- 
> > 2.39.5
> > 
> >   
> 
> John.

