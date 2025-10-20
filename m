Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8228ECCD1A7
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 18:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1E282E34;
	Mon, 20 Oct 2025 20:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="EJXowC8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F3D831D5; Mon, 20 Oct 2025 20:51:49 +0200 (CEST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [IPv6:2001:41d0:203:375::aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A8B82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 20:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
Date: Tue, 21 Oct 2025 05:51:10 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1760986304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPagEHqm/qqwCIVsdCif1UZjGuCnCtcusNr/3qOn4B0=;
 b=EJXowC8AiBo0essG7Eu19Jm3kUKWmGztW8WZr6Rg969TXfBKl8iOfCWpvoDVWiOcisP28T
 IZw8nuRyTTqaTc9nPANjGYgBbMrGNn2kfWZIueLrgnmKd2jVjgLUAWOXEKjd+UQnBX2KQz
 J+Nf1N4HG7NscZ+mY30zXqYBKl592EKnr58lV2+sGo09qIjMFr7rSmJAAnokLSNL2FbFCn
 v8G7C0fDN2mUAhfl1i4dxE4LSJp4aJ9vLBFjIV6F4wBlTZyfgZbPKdzzVTs22bJUOCEmu7
 kWQsyxfl2OmjeQW0rwpQ55BGzxirc/3/XbGcwDFHsePOdzzWdfXerFuT4Nhg3A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>, Tom Rini <trini@konsulko.com>,
 linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] sunxi: extend R528/T113-s3/D1(s) DRAM initialisation
Message-ID: <aPaEnhPUtrqzYzOe@titan>
References: <20250915192036.323741-1-lukas.schmid@netcube.li>
 <20250917224826.7837663c@minigeek.lan>
 <5396890.31r3eYUQgx@lukas-hpz440workstation>
 <20251020005924.73e41909@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020005924.73e41909@minigeek.lan>
X-Migadu-Flow: FLOW_OUT
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

Hi,

I can confirm this code works:

	fuse = (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
	debug("DDR efuse: 0x%x\n", fuse);
	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());

	if (sid_read_soc_chipid() == SUNXI_CHIPID_T113M4020DC0)
		return;

	if (para->dram_type == SUNXI_DRAM_TYPE_DDR2) {
		if (fuse == 15)
			return;
		cfg = ac_remapping_tables[6];
	} else {
		if (config->dram_tpr13 & 0xc0000) {
			cfg = ac_remapping_tables[7];
		} else {
			switch (fuse) {
			case 8: cfg = ac_remapping_tables[2]; break;
			case 9: cfg = ac_remapping_tables[3]; break;
			case 10: cfg = ac_remapping_tables[5]; break;
			case 11: cfg = ac_remapping_tables[4]; break;
			default:
			case 12: cfg = ac_remapping_tables[1]; break;
			case 13:
			case 14: cfg = ac_remapping_tables[0]; break;
			}

John.

On Mon, Oct 20, 2025 at 12:59:52AM +0100, Andre Przywara wrote:
> On Thu, 16 Oct 2025 17:30:41 +0200
> Lukas Schmid <lukas.schmid@netcube.li> wrote:
> 
> Hi Lukas,
> 
> > I finally got some time to look into this patch again.
> > 
> > Dropping out of the DRAM type check earlier sounds like a good move here. I 
> > can definitely do that and also test it on my board. 
> 
> Yes, please do, and send a v3 if that works for you.
>  
> > About the other changes. Is the patch itself in a good state right now (except 
> > the commit message) or would you (or anyone else here for that matter) like to 
> > see something changed?
> > 
> > I'll change/update the commit message to have a smaller footprint regarding 
> > the SID chip ID, and also remove the reference to the "random" git repo.
> 
> What's more important than the sources is some background and some
> description about what the patch does, like this:
> 
> ==================
> The T113-s4 SoC is using the same die as the T113-s3, but comes with
> 256MiB of co-packaged DRAM. Besides the doubled size, the DRAM chip
> seems to be connected slightly differently, which requires to use a
> different pin remapping.
> 
> Extend the DRAM initialisation code to add support for the T113-S4 aka
> T113M4020DC0 by checking the SoC's CHIPID, which is stored in the first
> word of the SID efuses.
> ==================
> 
> So no lengthy dumps or links. You might want to put the link to the
> github repo as a comment before the enum in dram_sun20i_d1.h.
> 
> Thanks,
> Andre
> 
> > 
> > Best regards,
> > Lukas
> 
> > On Mittwoch, 17. September 2025 23:48:26 Mitteleuropäische Sommerzeit Andre 
> > Przywara wrote:
> > > On Mon, 15 Sep 2025 21:20:35 +0200
> > > Lukas Schmid <lukas.schmid@netcube.li> wrote:
> > > 
> > > Hi Lukas, John,
> > > 
> > > so looking at the code again, table 0 is special in that it's all 0's,
> > > which apparently means no remapping, according to some comments.
> > > We already bail out earlier of this function for configurations that do
> > > not require remapping, so can you test whether this works here as well?
> > > Just do the chip ID test early, after the DRAM type check, and before
> > > the fuse is read. And if it's 0x7200, then just return;
> > > 
> > > I think that would look better than the odd fuse special case.
> > > 
> > > Thanks,
> > > Andre
> > >   
> > > > Extend the DRAM initialisation code to add support for the T113-S4 aka
> > > > T113M4020DC0 by checking the SoC's CHIPID.
> > > > 
> > > > The list of Chip-IDs came from
> > > > https://github.com/ua1arn/hftrx/blob/25d8cb9e4cfe1d7d0e4a2f641025c88a9ec5e
> > > > 758/inc/clocks.h#L250
> > > > 
> > > > And the chipid register address was something I heard through apritzel
> > > > altough it seems that, according to Jookia, the Tina Device Tree seems
> > > > to agree:
> > > > 
> > > > sid@3006000 {
> > > > 
> > > > 	compatible = "allwinner,sun20iw1p1-sid", "allwinner,sunxi-sid";
> > > > 	reg = <0x0 0x03006000 0 0x1000>;
> > > > 	#address-cells = <1>;
> > > > 	#size-cells = <1>;
> > > > 	
> > > > 	chipid {
> > > > 	
> > > > 		reg = <0x0 0>;
> > > > 		offset = <0x200>;
> > > > 		size = <0x10>;
> > > > 	
> > > > 	};
> > > > 	...
> > > > 
> > > > };
> > > > 
> > > > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > > > Tested-by: John Watts <contact@jookia.org>
> > > > Reviewed-by: John Watts <contact@jookia.org>
> > > > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > >   - Use uint32_t instead of u32 for sid_read_soc_chipid return type
> > > >   - Add descriptive comment about source of Chip-ID list and register
> > > >  
> > > >  drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
> > > >  drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
> > > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c
> > > > b/drivers/ram/sunxi/dram_sun20i_d1.c index a1794032f3b..381eeb87e2e
> > > > 100644
> > > > --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> > > > +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> > > > @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *para)
> > > > 
> > > >  	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
> > > >  
> > > >  }
> > > > 
> > > > +static uint32_t sid_read_soc_chipid(void)
> > > > +{
> > > > +	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> > > > +}
> > > > +
> > > > 
> > > >  static void dram_voltage_set(const dram_para_t *para)
> > > >  {
> > > >  
> > > >  	int vol;
> > > > 
> > > > @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para_t  
> > > > *para,>   
> > > >  	fuse = (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
> > > >  	debug("DDR efuse: 0x%x\n", fuse);
> > > > 
> > > > +	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
> > > > 
> > > >  	if (para->dram_type == SUNXI_DRAM_TYPE_DDR2) {
> > > >  	
> > > >  		if (fuse == 15)
> > > > 
> > > > @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_para_t  
> > > > *para,>   
> > > >  			switch (fuse) {
> > > >  			case 8: cfg = ac_remapping_tables[2]; break;
> > > >  			case 9: cfg = ac_remapping_tables[3]; break;
> > > > 
> > > > -			case 10: cfg = ac_remapping_tables[5];   
> > break;
> > > > +			case 10:
> > > > +				if (sid_read_soc_chipid() ==   
> > SUNXI_CHIPID_T113M4020DC0)
> > > > +					cfg =   
> > ac_remapping_tables[0];
> > > > +				else
> > > > +					cfg =   
> > ac_remapping_tables[5];
> > > > +				break;
> > > > 
> > > >  			case 11: cfg = ac_remapping_tables[4];   
> > break;
> > > >  			default:
> > > >  			case 12: cfg = ac_remapping_tables[1];   
> > break;
> > > > 
> > > > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h
> > > > b/drivers/ram/sunxi/dram_sun20i_d1.h index 91383f6cf10..7bd8f67a77a
> > > > 100644
> > > > --- a/drivers/ram/sunxi/dram_sun20i_d1.h
> > > > +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
> > > > @@ -19,6 +19,13 @@ enum sunxi_dram_type {
> > > > 
> > > >  	SUNXI_DRAM_TYPE_LPDDR3 = 7,
> > > >  
> > > >  };
> > > > 
> > > > +enum sunxi_soc_chipid {
> > > > +	SUNXI_CHIPID_F133A = 0x5C00,
> > > > +	SUNXI_CHIPID_D1S = 0x5E00,
> > > > +	SUNXI_CHIPID_T113S3 = 0x6000,
> > > > +	SUNXI_CHIPID_T113M4020DC0 = 0x7200,
> > > > +};
> > > > +
> > > > 
> > > >  /*
> > > >  
> > > >   * This structure contains a mixture of fixed configuration settings,
> > > >   * variables that are used at runtime to communicate settings between  
> > 
> 
