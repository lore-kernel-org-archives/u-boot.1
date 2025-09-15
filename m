Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3E8CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 16:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E90830CA;
	Mon, 15 Sep 2025 18:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="Mk5xLy5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1877983106; Mon, 15 Sep 2025 18:26:16 +0200 (CEST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C865282AE1
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 18:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
Date: Tue, 16 Sep 2025 02:22:05 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1757953571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oSkft1a8dG1BCyFqdbwn1tbmBSg8ath9Da5hoDFDg7o=;
 b=Mk5xLy5qCicX+yBYJdjRcPLDNr/beedh5qhHJWeO0AuAeB8YEpMYSnoV0TY6cFAXSkne4J
 2MZ9SFtHJLojV+8X7xhdyuQjkt3+V3qvmrGMW9heAdeWeD9f/RGvwFt7KhJm8xOUvEBEI+
 ByPAtbfUU6HYrAXv3Z/TErIeeUeMUyk1aF0G6+STZmDsUmfg5Xz9ZMjBURadrkx7WA8FN2
 TzE/cc0/LYgi6zUR4UealeAJE83F8CpSXp24OiYEBCFmftAU4fG5X9n0CdexEWXP7WBrxz
 hOZhnwByOuYO6Z/4yWD/QKSDhG0gnz+E1P6lKrsWyV3jXfoXSeoktTCfem6n4w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] sunxi: extend R528/T113-s3/D1(s) DRAM
 initialisation
Message-ID: <aMg9LQ6VlxkNCgbk@titan>
References: <20250914144411.157826-1-lukas.schmid@netcube.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914144411.157826-1-lukas.schmid@netcube.li>
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

On Sun, Sep 14, 2025 at 04:44:11PM +0200, Lukas Schmid wrote:
> Extend the DRAM initialisation code to add support for the T113-S4 aka
> T113M4020DC0 by checking the SoC's CHIPID.

Hi there, I've tested this patch and confirm that it is required to boot my
T113-S4 from an EmbedSky dev kit. Here is the product:
http://wiki.armbbs.net/tqwiki/public/docs/TQT113_CORE
I can confirm this board does not boot without this patch.

Here's a Tested-by and Reviewed-By:

Tested-by: John Watts <contact@jookia.org>
Reviewed-by: John Watts <contact@jookia.org>

That said there are some things I would like to see improved in this patch.

> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>  drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
>  drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
> index a1794032f3b..01d19d5feaa 100644
> --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *para)
>  	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
>  }
>  
> +static u32 sid_read_soc_chipid(void)
> +{
> +	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> +}
> +

mctl_phy_ac_remapping uses readl to read a fuse and labels that as uint32_t,
maybe this should be uint32_t too?

The other question I have is how did you figure out this register and mask? Is
it documented somewhere? I would love to see a comment or note in the Git
commit saying where these values came from, even if it's just 'taken from
sunxi-fel' or 'heard from apritzel'. Having notes like that can really help
when troubleshooting old code, which hopefully this will be one day.

I found something that seems to agree from the Tina device tree:

		sid@3006000 {
			compatible = "allwinner,sun20iw1p1-sid", "allwinner,sunxi-sid";
			reg = <0x0 0x03006000 0 0x1000>;
			#address-cells = <1>;
			#size-cells = <1>;

			chipid {
				reg = <0x0 0>;
				offset = <0x200>;
				size = <0x10>;
			};

>  static void dram_voltage_set(const dram_para_t *para)
>  {
>  	int vol;
> @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
>  
>  	fuse = (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
>  	debug("DDR efuse: 0x%x\n", fuse);
> +	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
>  
>  	if (para->dram_type == SUNXI_DRAM_TYPE_DDR2) {
>  		if (fuse == 15)
> @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
>  			switch (fuse) {
>  			case 8: cfg = ac_remapping_tables[2]; break;
>  			case 9: cfg = ac_remapping_tables[3]; break;
> -			case 10: cfg = ac_remapping_tables[5]; break;
> +			case 10:
> +				if (sid_read_soc_chipid() == SUNXI_CHIPID_T113M4020DC0)
> +					cfg = ac_remapping_tables[0];
> +				else
> +					cfg = ac_remapping_tables[5];
> +				break;
>  			case 11: cfg = ac_remapping_tables[4]; break;
>  			default:
>  			case 12: cfg = ac_remapping_tables[1]; break;
> diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h b/drivers/ram/sunxi/dram_sun20i_d1.h
> index 91383f6cf10..7bd8f67a77a 100644
> --- a/drivers/ram/sunxi/dram_sun20i_d1.h
> +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
> @@ -19,6 +19,13 @@ enum sunxi_dram_type {
>  	SUNXI_DRAM_TYPE_LPDDR3 = 7,
>  };
>  
> +enum sunxi_soc_chipid {
> +	SUNXI_CHIPID_F133A = 0x5C00,
> +	SUNXI_CHIPID_D1S = 0x5E00,
> +	SUNXI_CHIPID_T113S3 = 0x6000,
> +	SUNXI_CHIPID_T113M4020DC0 = 0x7200,
> +};
> +

Same question as previous: Where do these values come from? Could this be
documented? I can't find these values anywhere else. Noting this down would
help if someone wants to use them as reference to if they turn out to be wrong.
Speaking of...

awboot seems to believe the T113S4 chip ID is 0x6800:
https://github.com/szemzoa/awboot/blob/main/arch/arm32/mach-t113s4/dram.c#L726

				if(chipid == 0x6800){ // 0x6800 is T113-S4 no remap
					cfg = ac_remapping_tables[0];
				} else {
					cfg = ac_remapping_tables[5];
				}

Perhaps theirs is for the M4030DC0 or something?

>  /*
>   * This structure contains a mixture of fixed configuration settings,
>   * variables that are used at runtime to communicate settings between
> -- 
> 2.39.5
> 
> 

John.
