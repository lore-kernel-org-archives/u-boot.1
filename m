Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67669C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 22:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0ADA606F1;
	Thu, 27 Aug 2026 22:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuPYoHcxG0rl; Thu, 27 Aug 2026 22:06:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787868365;
	bh=GSdN1WF8q0JowaAJ9utIC6iA8eP3D+cXIkgeDkojJEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mIAjXaNsRzS+liN05fnGxiRwd1LJZNa+UWJ4X5g35DRVKRDf/4GcMKjmu+m8+v3F/
	 GlxpR6HomAw32l1dnrsMQ4UF9AMXXB1a1rWQJyYO239MVQehIJnC182jEl7hH88zVI
	 CgyBD5Zl8mO90/x9Kdlb+5DL9d2S04sD3NBYhYTUUVcITHa1iD901io95/lg4aWKVr
	 LtdXQ7L6SRtML4JHg6TsUkiLKgr/eYzxUzvF4oexACEnYbey3lJOUREJ+y0d5I1EVy
	 BDwMWhUv7EG+CCPuTdOAKJXeUc37RMkc3XneSjfQqXmX9CJC43jrq2gSUVag555v8T
	 OQjWPhQXwaI8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 171A2607A0;
	Thu, 27 Aug 2026 22:06:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 875E875
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 22:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 795334080A
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 22:06:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2fC0V5yj2ss for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 22:06:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bE115dK8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A265B40809
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 22:06:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 278DD42A4A;
 Thu, 27 Aug 2026 22:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4761F00A3A;
 Thu, 27 Aug 2026 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787868361;
 bh=GSdN1WF8q0JowaAJ9utIC6iA8eP3D+cXIkgeDkojJEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bE115dK815D8yR20fIEBsTchmktpunOOxMLg1TrbLcOfhiBGqRlP66H6OyUq3ckQs
 +zNOZ/2wXiI12O/xi2SE/B6an295IEC9XTWAOGpZOmlYVQQOVp7IWbTuLPAdzswKrA
 hIHImzJodVhkzBq6EbJTbaSq7RFBzGUIJhz5JxOduFPoYroIowrikG6RmQLdVp66EN
 Xl3R1tufEpiNcnJMLQB+a28QvEQV0sixhFJ02Q43kiSeZ1NzCBXwSYrrpVokiMCBM9
 rEcOYPsPMvyYhJlqIsrfNZ1Z7b6A+5cNT3ykN/l6B9RkdIIxU2158qC3VYwFZHdvfd
 tkBvNecTmtoqQ==
Date: Thu, 27 Aug 2026 22:05:58 +0000
From: Yixun Lan <dlan@kernel.org>
To: Bo Gan <ganboing@gmail.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] pinctrl: spacemit: k3: add K3 pin support
Message-ID: <20260827220558-GKG631715@kernel.org>
References: <20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org>
 <20260820-01-k3-pinctrl-support-v1-2-b54a2450c895@kernel.org>
 <bca35d47-5cae-4f2b-a03c-f18e310e7361@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bca35d47-5cae-4f2b-a03c-f18e310e7361@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Bo,

On 14:55 Thu 27 Aug     , Bo Gan wrote:
> Hi Yixun,
> 
> On 8/20/26 06:01, Yixun Lan wrote:
> > Based on upstream Linux:
> >    7412311c4655 ("pinctrl: spacemit: k3: add initial pin support")
> >    3f20bdf71518 ("pinctrl: spacemit: k3: adjust drive strength and schmitter trigger")
> > 
> > K3 uses a different pin-to-register mapping than K1, so add a
> > K3-specific pin_to_reg path and pin/IO power-domain tables. Drive
> > strength expands to 4 bits with larger mA tables, and the shared
> > pinctrl data gains per-SoC drive_mask and drive-strength tables so
> > K1 and K3 can live in the same driver.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >   drivers/pinctrl/spacemit/Kconfig      |   4 +-
> >   drivers/pinctrl/spacemit/pinctrl-k1.c | 291 ++++++++++++++++++++++++++++++----
> >   2 files changed, 259 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
> > index 6aab89e160c..87cba336923 100644
> > --- a/drivers/pinctrl/spacemit/Kconfig
> > +++ b/drivers/pinctrl/spacemit/Kconfig
> > @@ -1,8 +1,8 @@
> >   config PINCTRL_SPACEMIT_K1
> > -	bool "Spacemit K1 SoC pinctrl driver"
> > +	bool "Spacemit K1/K3 SoC pinctrl driver"
> >   	depends on PINCTRL_GENERIC && DM
> >   	help
> > -	  Supports pin multiplexing control on Spacemit K1 SoCs.
> > +	  Supports pin multiplexing control on Spacemit K1 and K3 SoCs.
> >   
> >   	  The driver is controlled by a device tree node which contains both
> >   	  the GPIO definitions and pin control functions for each available
> > diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
> > index 469c41c40c8..1eb20fd2956 100644
> > --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> > +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
> > @@ -30,8 +30,10 @@
> >   #define PAD_EDGE_CLEAR		BIT(6)
> >   #define PAD_SLEW_RATE		GENMASK(12, 11)
> >   #define PAD_SLEW_RATE_EN	BIT(7)
> > -#define PAD_SCHMITT		GENMASK(9, 8)
> > -#define PAD_DRIVE		GENMASK(12, 10)
> > +#define PAD_SCHMITT_K1		GENMASK(9, 8)
> > +#define PAD_DRIVE_K1		GENMASK(12, 10)
> > +#define PAD_SCHMITT_K3		BIT(8)
> > +#define PAD_DRIVE_K3		GENMASK(12, 9)
> >   #define PAD_PULLDOWN		BIT(13)
> >   #define PAD_PULLUP		BIT(14)
> >   #define PAD_PULL_EN		BIT(15)
> > @@ -43,6 +45,11 @@
> >   #define IO_PWR_DOMAIN_MMC_Kx	0x1c
> >   #define IO_PWR_DOMAIN_QSPI_K1	0x20
> >   
> > +#define IO_PWR_DOMAIN_GPIO1_K3  0x04
> > +#define IO_PWR_DOMAIN_GPIO5_K3  0x10
> > +#define IO_PWR_DOMAIN_GPIO4_K3  0x20
> > +#define IO_PWR_DOMAIN_QSPI_K3   0x2c
> > +
> >   #define IO_PWR_DOMAIN_V18EN	BIT(2)
> >   
> >   #define APBC_ASFAR		0x50
> > @@ -68,6 +75,12 @@ struct spacemit_pin_io {
> >   	unsigned int	reserved : 8;
> >   };
> >   
> > +struct spacemit_pin_drv_strength {
> > +	unsigned int	val : 8;
> > +	unsigned int	ma : 16;
> > +	unsigned int	reserved : 8;
> > +};
> > +
> >   struct spacemit_pinctrl_data {
> >   	struct spacemit_pin_io *io_pins;
> >   	int nr_io_pins;
> > @@ -78,6 +91,12 @@ struct spacemit_pinctrl_data {
> >   	int (*get_functions)(struct udevice *dev);
> >   	int (*get_io_type)(struct udevice *dev, unsigned int pin);
> >   	unsigned int (*pin_to_io_pd_offset)(unsigned int pin);
> > +
> > +	u32 drive_mask;
> > +	struct spacemit_pin_drv_strength *ds_1v8_tbl;
> > +	int ds_1v8_tbl_num;
> > +	struct spacemit_pin_drv_strength *ds_3v3_tbl;
> > +	int ds_3v3_tbl_num;
> >   };
> >   
> >   struct spacemit_pinctrl_priv {
> > @@ -92,12 +111,6 @@ struct spacemit_pin_mux_config {
> >   	u32				config;
> >   };
> >   
> > -struct spacemit_pin_drv_strength {
> > -	unsigned int	val : 8;
> > -	unsigned int	ma : 16;
> > -	unsigned int	reserved : 8;
> > -};
> > -
> >   static char pin_name[PINNAME_SIZE];
> >   
> >   /* External: IO voltage via external source, can be 1.8V or 3.3V */
> > @@ -280,35 +293,17 @@ static inline u32 spacemit_get_ds_ma(struct spacemit_pin_drv_strength *tbl,
> >   	return 0;
> >   }
> >   
> > -static inline u8 spacemit_get_drive_strength(enum spacemit_pin_io_type type,
> > +static inline u8 spacemit_get_drive_strength(struct spacemit_pinctrl_data *data,
> > +					     enum spacemit_pin_io_type type,
> >   					     u32 ma)
> >   {
> >   	switch (type) {
> >   	case IO_TYPE_1V8:
> > -		return spacemit_get_ds_value(spacemit_ds_1v8_tbl,
> > -					     ARRAY_SIZE(spacemit_ds_1v8_tbl),
> > -					     ma);
> > -	case IO_TYPE_3V3:
> > -		return spacemit_get_ds_value(spacemit_ds_3v3_tbl,
> > -					     ARRAY_SIZE(spacemit_ds_3v3_tbl),
> > -					     ma);
> > -	default:
> > -		return 0;
> > -	}
> > -}
> > -
> > -static inline u32 spacemit_get_drive_strength_ma(enum spacemit_pin_io_type type,
> > -						 u32 value)
> > -{
> > -	switch (type) {
> > -	case IO_TYPE_1V8:
> > -		return spacemit_get_ds_ma(spacemit_ds_1v8_tbl,
> > -					  ARRAY_SIZE(spacemit_ds_1v8_tbl),
> > -					  value & 0x6);
> > +		return spacemit_get_ds_value(data->ds_1v8_tbl,
> > +					     data->ds_1v8_tbl_num, ma);
> >   	case IO_TYPE_3V3:
> > -		return spacemit_get_ds_ma(spacemit_ds_3v3_tbl,
> > -					  ARRAY_SIZE(spacemit_ds_3v3_tbl),
> > -					  value);
> > +		return spacemit_get_ds_value(data->ds_3v3_tbl,
> > +					     data->ds_3v3_tbl_num, ma);
> >   	default:
> >   		return 0;
> >   	}
> > @@ -549,8 +544,9 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
> >   			dev_err(dev, "Invalid IO type (%d)\n", io_type);
> >   			return -EINVAL;
> >   		}
> > -		ds = spacemit_get_drive_strength(io_type, argument);
> > -		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
> > +		ds = spacemit_get_drive_strength(data, io_type, argument);
> > +		clrsetbits_le32(addr, data->drive_mask,
> > +				field_prep(data->drive_mask, ds));
> >   		break;
> >   	case PIN_CONFIG_POWER_SOURCE:
> >   		return spacemit_set_pin_power_source(dev, pin_selector, argument);
> > @@ -704,12 +700,239 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
> >   	.get_functions	= k1_get_functions,
> >   	.get_io_type	= k1_get_io_type,
> >   	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
> > +	.drive_mask	= PAD_DRIVE_K1,
> > +	.ds_1v8_tbl	= spacemit_ds_1v8_tbl,
> > +	.ds_1v8_tbl_num	= ARRAY_SIZE(spacemit_ds_1v8_tbl),
> > +	.ds_3v3_tbl	= spacemit_ds_3v3_tbl,
> > +	.ds_3v3_tbl_num	= ARRAY_SIZE(spacemit_ds_3v3_tbl),
> > +};
> > +
> 
> Can the following table be simplified using static function and switch
> cases? As your other series mentioned, the SPL has very strict size limit,
> so we'd better not define this huge data array.
> 
I think it's possible, will try to implement, and see how much space it
can save.. thanks for the suggestion

> > +static struct spacemit_pin_io k3_io_pins[] = {
> > +	{ 0, IO_TYPE_EXTERNAL, 0, },
> > +	{ 1, IO_TYPE_EXTERNAL, 0, },
..
> 

-- 
Yixun Lan (dlan)
