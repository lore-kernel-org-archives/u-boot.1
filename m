Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D3CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 09:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2694360709;
	Wed,  7 Oct 2026 09:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8a7562l4gutT; Wed,  7 Oct 2026 09:15:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 567BC606BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791364547;
	b=FWG6Vgpmf4uhdCaA4ce2oTIy3JzGPHLDye7Fhtd9bwIKvT5lHMejrPv98SFFeimN6wlP
	 IbpbKs+l1QwYHGzmpNltjlSIE4xb6ARSt2+GHkvsAPy2WMtm/tqGK4DR15BhkIqYCGQNY
	 NP5tHgQVTDuF4W7dOc0x7prBS9f1+c0SKcUk35BQ9IxIbvDaANfRama0ahPTew0DzKcHu
	 9M4ZJpi91VPUp2FtJniZztlLV0egujm7QJwVYLo/S7P96+NQoHW/xV5LBcHPuPbDOMaZS
	 0M8nVUTZ1Uve2JlJAPTklkcZJZu6hBsb5phh+MpJPlcDJyGNlarUiGufg66PjxJnp/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791364547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RW2nP+PJ6N4YvZnYdwD905WhrhHw/n89xyUiKXV0S0E=;
	b=VZu6UYOEGfZsNy6A/xhM6tKfytjWeRvax9754fDif4VsdNVClaLbtL7KUINEGZ3aACoq
	 ENgqby4Y4iwLeVYsxKDyQ7Sz2gHZdywSD0KbMj7viwcE28Oo9L+SBn9lmrIne0bigEnZ6
	 smvSIb1Q8/nlWC3RVlizKjy8kSSlcdE7uaTFoVItnw87oqU0dseE5tDx6GByK9KhEnAyx
	 xd76F/KtjAUV7l6UuP//RTlt2QN+DY5ixDeSf9kOmf0iY4xhhb9M02FR8BYRze7VerK19
	 l3NHofmfXfwwYo+KYLBkMGF14fSpWLpAHw0pfnwsbaJYT5YrcO/xCMaS9yWCa9+UOdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791364547;
	bh=RW2nP+PJ6N4YvZnYdwD905WhrhHw/n89xyUiKXV0S0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZVtKa30RN9V72k7Ysh78BJ4xdWPoha+khJL5mHX4H440ONacgQu0vLq9UW9UD2j3
	 7w32gUNpgKPj/vxHPhYWl1UPILe4TAkfgWQ2evY6PKfwsHYye59E8wAWuszDpFHdF4
	 BfecXXLxXGogMzHdQCnYmKYQmy0dut/q0LjVaqAE1vZVPrJf6mN72/L0tkazoFXDow
	 xv08lxtpNZgS9JIKHRgr9A61cV800Ky4hukltBcI0PmIKn52FfqSO40SKh7bQsS8Dv
	 DB3ObGImvls6dLT/i5MC86foMzX6e2RWiB27zvXfOCiHiH3+YzeXAknfxVDybv2CrQ
	 lXtuqe6JHGbMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 567BC606BA;
	Wed,  7 Oct 2026 09:15:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0737E75
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECD0980906
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbgEUDotgYEi for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 09:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3DC43808C1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791364339;
 b=BEEmBdcNxsCTgcr2KzL1Xx8dDj0+xQ4MIDkSrySZxEFGtOTNX7eii3PTwj5IwbySk2+n
 z+dC1ivMfi5MLpoVbCqnI+c5LoWP1prp22xOLxyPFe2brIXv43if1xLjjuC9jtRUhlwTF
 JmJ7gkRs3MH+DH/+OuL08EAaxLZcG0Wl1SdBjz2nxYuPRjN00CBlP08toYCGv+m1wPkK8
 dhHBHZIeFxrOGHm1JTKeg4sRylJQkeWb3bpfbZ40qKp245pA3Plemi0unF3HUZ34PbRn8
 VT9Y8Ci7tmaSfVj6yIjuDzeE1O2HosAB8QpO4JzwwAeQRy34/Fcbklv1uqtu+Zc+NWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791364339;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=RW2nP+PJ6N4YvZnYdwD905WhrhHw/n89xyUiKXV0S0E=;
 b=SWq6jBlfUk7L3/Y2trfTj9wUMFGg9n5QHfybeDdUUHCRvH9jQ9YdloICI3ByjzhClPJs
 DQp0wkWRPJcY8nADs+oo2B4tDaCxSymgP6WgA9vqdQh4dz0tj286nR0C/AFZg3EoByvYZ
 iKDoWLz5K0cFiui7J5VpCAe0aJd2j2vEXSyQSMwL1DfM6bGvnik2fsjp5lFZbq0h2sFTh
 ogEzybl5GOMdSQ0Xfba7sw7tKM1O1Ji6dgjadw0xnS/hm604TvrQGoIXAG2ViXeQPQhMa
 0t6lmm/Co/csTPlbXBqxQnmFRJjvlegSNEtFqWiBxnZQtkGQetvxsbeY59hvTDc8IuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=NR4tjYoe; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=NR4tjYoe
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DC43808C1
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791364326;
 bh=RW2nP+PJ6N4YvZnYdwD905WhrhHw/n89xyUiKXV0S0E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NR4tjYoeD9F9P5g/26pe1IJwSFVDhAwjUTz6aVXYdbKm3rWc6EIh8uc3FctV7OEe9
 GtgQArTxxyegWzA/fwrZOdvHlqWLC5l3w++CFWDY9WaSr+UUCxgDrTkHL+cO3Ro4gU
 NbweIW4wR3GmJ9iTdMQJFc06Evj4N+nR8me7frmxtgep+a2OHnqkPZUEtJh98LeWHd
 Wje/ER07wXs7OHLa0ki2iozO+/wGjiZI8u78GxUxdgpqXfPza79uyMzntPGKAOEOJ9
 bJunp9LDI6Edw+RcC/XIsfYi5nGg4Wv0QiknZAI4hG7Q9LLoNm+r8nPHKhruPUU4gs
 L/I/+qrYez9TQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 76C5DB22012F;
 Wed,  7 Oct 2026 11:12:05 +0200 (CEST)
Message-ID: <5fa4e2df-d0c5-4404-a29d-eded3cb72eb3@freeshell.de>
Date: Wed, 7 Oct 2026 02:12:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pinctrl: spacemit: k3: add K3 pin support
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Junhui Liu
 <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>
References: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
 <20260923-01-k3-pinctrl-support-v2-2-e76a917ee252@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260923-01-k3-pinctrl-support-v2-2-e76a917ee252@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/23/26 06:06, Yixun Lan wrote:
> Based on upstream Linux:
>   7412311c4655 ("pinctrl: spacemit: k3: add initial pin support")
>   3f20bdf71518 ("pinctrl: spacemit: k3: adjust drive strength and schmitter trigger")
> 
> K3 uses a different pin-to-register mapping than K1, so add a
> K3-specific pin_to_reg path and pin/IO power-domain tables. Drive
> strength expands to 4 bits with larger mA tables, and the shared
> pinctrl data gains per-SoC drive_mask and drive-strength tables so
> K1 and K3 can live in the same driver.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  drivers/pinctrl/spacemit/Kconfig      |   4 +-
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 291 ++++++++++++++++++++++++++++++----
>  2 files changed, 259 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
> index 6aab89e160c..87cba336923 100644
> --- a/drivers/pinctrl/spacemit/Kconfig
> +++ b/drivers/pinctrl/spacemit/Kconfig
> @@ -1,8 +1,8 @@
>  config PINCTRL_SPACEMIT_K1
> -	bool "Spacemit K1 SoC pinctrl driver"
> +	bool "Spacemit K1/K3 SoC pinctrl driver"
>  	depends on PINCTRL_GENERIC && DM
>  	help
> -	  Supports pin multiplexing control on Spacemit K1 SoCs.
> +	  Supports pin multiplexing control on Spacemit K1 and K3 SoCs.
>  
>  	  The driver is controlled by a device tree node which contains both
>  	  the GPIO definitions and pin control functions for each available
> diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
> index ff0fa3a4b18..002878862dc 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
> @@ -30,8 +30,10 @@
>  #define PAD_EDGE_CLEAR		BIT(6)
>  #define PAD_SLEW_RATE		GENMASK(12, 11)
>  #define PAD_SLEW_RATE_EN	BIT(7)
> -#define PAD_SCHMITT		GENMASK(9, 8)
> -#define PAD_DRIVE		GENMASK(12, 10)
> +#define PAD_SCHMITT_K1		GENMASK(9, 8)
> +#define PAD_DRIVE_K1		GENMASK(12, 10)
> +#define PAD_SCHMITT_K3		BIT(8)
> +#define PAD_DRIVE_K3		GENMASK(12, 9)
>  #define PAD_PULLDOWN		BIT(13)
>  #define PAD_PULLUP		BIT(14)
>  #define PAD_PULL_EN		BIT(15)
> @@ -43,6 +45,11 @@
>  #define IO_PWR_DOMAIN_MMC_Kx	0x1c
>  #define IO_PWR_DOMAIN_QSPI_K1	0x20
>  
> +#define IO_PWR_DOMAIN_GPIO1_K3  0x04
> +#define IO_PWR_DOMAIN_GPIO5_K3  0x10
> +#define IO_PWR_DOMAIN_GPIO4_K3  0x20
> +#define IO_PWR_DOMAIN_QSPI_K3   0x2c
> +
>  #define IO_PWR_DOMAIN_V18EN	BIT(2)
>  
>  #define APBC_ASFAR		0x50
> @@ -68,6 +75,12 @@ struct spacemit_pin_io {
>  	unsigned int	reserved : 8;
>  };
>  
> +struct spacemit_pin_drv_strength {
> +	unsigned int	val : 8;
> +	unsigned int	ma : 16;
> +	unsigned int	reserved : 8;
> +};
> +
>  struct spacemit_pinctrl_data {
>  	struct spacemit_pin_io *io_pins;
>  	int nr_io_pins;
> @@ -78,6 +91,12 @@ struct spacemit_pinctrl_data {
>  	int (*get_functions)(struct udevice *dev);
>  	int (*get_io_type)(struct udevice *dev, unsigned int pin);
>  	unsigned int (*pin_to_io_pd_offset)(unsigned int pin);
> +
> +	u32 drive_mask;
> +	struct spacemit_pin_drv_strength *ds_1v8_tbl;
> +	int ds_1v8_tbl_num;
> +	struct spacemit_pin_drv_strength *ds_3v3_tbl;
> +	int ds_3v3_tbl_num;
>  };
>  
>  struct spacemit_pinctrl_priv {
> @@ -92,12 +111,6 @@ struct spacemit_pin_mux_config {
>  	u32				config;
>  };
>  
> -struct spacemit_pin_drv_strength {
> -	unsigned int	val : 8;
> -	unsigned int	ma : 16;
> -	unsigned int	reserved : 8;
> -};
> -
>  static char pin_name[PINNAME_SIZE];
>  
>  /* External: IO voltage via external source, can be 1.8V or 3.3V */
> @@ -280,35 +293,17 @@ static inline u32 spacemit_get_ds_ma(struct spacemit_pin_drv_strength *tbl,
>  	return 0;
>  }
>  
> -static inline u8 spacemit_get_drive_strength(enum spacemit_pin_io_type type,
> +static inline u8 spacemit_get_drive_strength(struct spacemit_pinctrl_data *data,
> +					     enum spacemit_pin_io_type type,
>  					     u32 ma)
>  {
>  	switch (type) {
>  	case IO_TYPE_1V8:
> -		return spacemit_get_ds_value(spacemit_ds_1v8_tbl,
> -					     ARRAY_SIZE(spacemit_ds_1v8_tbl),
> -					     ma);
> -	case IO_TYPE_3V3:
> -		return spacemit_get_ds_value(spacemit_ds_3v3_tbl,
> -					     ARRAY_SIZE(spacemit_ds_3v3_tbl),
> -					     ma);
> -	default:
> -		return 0;
> -	}
> -}
> -
> -static inline u32 spacemit_get_drive_strength_ma(enum spacemit_pin_io_type type,
> -						 u32 value)
> -{
> -	switch (type) {
> -	case IO_TYPE_1V8:
> -		return spacemit_get_ds_ma(spacemit_ds_1v8_tbl,
> -					  ARRAY_SIZE(spacemit_ds_1v8_tbl),
> -					  value & 0x6);
> +		return spacemit_get_ds_value(data->ds_1v8_tbl,
> +					     data->ds_1v8_tbl_num, ma);
>  	case IO_TYPE_3V3:
> -		return spacemit_get_ds_ma(spacemit_ds_3v3_tbl,
> -					  ARRAY_SIZE(spacemit_ds_3v3_tbl),
> -					  value);
> +		return spacemit_get_ds_value(data->ds_3v3_tbl,
> +					     data->ds_3v3_tbl_num, ma);
>  	default:
>  		return 0;
>  	}
> @@ -552,8 +547,9 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  			dev_err(dev, "Invalid IO type (%d)\n", io_type);
>  			return -EINVAL;
>  		}
> -		ds = spacemit_get_drive_strength(io_type, argument);
> -		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
> +		ds = spacemit_get_drive_strength(data, io_type, argument);
> +		clrsetbits_le32(addr, data->drive_mask,
> +				field_prep(data->drive_mask, ds));
>  		break;
>  	case PIN_CONFIG_POWER_SOURCE:
>  		return spacemit_set_pin_power_source(dev, pin_selector, argument);
> @@ -707,12 +703,239 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
>  	.get_functions	= k1_get_functions,
>  	.get_io_type	= k1_get_io_type,
>  	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
> +	.drive_mask	= PAD_DRIVE_K1,
> +	.ds_1v8_tbl	= spacemit_ds_1v8_tbl,
> +	.ds_1v8_tbl_num	= ARRAY_SIZE(spacemit_ds_1v8_tbl),
> +	.ds_3v3_tbl	= spacemit_ds_3v3_tbl,
> +	.ds_3v3_tbl_num	= ARRAY_SIZE(spacemit_ds_3v3_tbl),
> +};
> +
> +static struct spacemit_pin_io k3_io_pins[] = {
> +	{ 0, IO_TYPE_EXTERNAL, 0, },
> +	{ 1, IO_TYPE_EXTERNAL, 0, },
> +	{ 2, IO_TYPE_EXTERNAL, 0, },
> +	{ 3, IO_TYPE_EXTERNAL, 0, },
> +	{ 4, IO_TYPE_EXTERNAL, 0, },
> +	{ 5, IO_TYPE_EXTERNAL, 0, },
> +	{ 6, IO_TYPE_EXTERNAL, 0, },
> +	{ 7, IO_TYPE_EXTERNAL, 0, },
> +	{ 8, IO_TYPE_EXTERNAL, 0, },
> +	{ 9, IO_TYPE_EXTERNAL, 0, },
> +	{ 10, IO_TYPE_EXTERNAL, 0, },
> +	{ 11, IO_TYPE_EXTERNAL, 0, },
> +	{ 12, IO_TYPE_EXTERNAL, 0, },
> +	{ 13, IO_TYPE_EXTERNAL, 0, },
> +	{ 14, IO_TYPE_EXTERNAL, 0, },
> +	{ 15, IO_TYPE_EXTERNAL, 0, },
> +	{ 16, IO_TYPE_EXTERNAL, 0, },
> +	{ 17, IO_TYPE_EXTERNAL, 0, },
> +	{ 18, IO_TYPE_EXTERNAL, 0, },
> +	{ 19, IO_TYPE_EXTERNAL, 0, },
> +	{ 20, IO_TYPE_EXTERNAL, 0, },
> +	{ 21, IO_TYPE_EXTERNAL, 0, },
> +	{ 22, IO_TYPE_EXTERNAL, 0, },
> +	{ 23, IO_TYPE_EXTERNAL, 0, },
> +	{ 24, IO_TYPE_EXTERNAL, 0, },
> +	{ 25, IO_TYPE_EXTERNAL, 0, },
> +	{ 26, IO_TYPE_EXTERNAL, 0, },
> +	{ 27, IO_TYPE_EXTERNAL, 0, },
> +	{ 28, IO_TYPE_EXTERNAL, 0, },
> +	{ 29, IO_TYPE_EXTERNAL, 0, },
> +	{ 30, IO_TYPE_EXTERNAL, 0, },
> +	{ 31, IO_TYPE_EXTERNAL, 0, },
> +	{ 32, IO_TYPE_EXTERNAL, 0, },
> +	{ 33, IO_TYPE_EXTERNAL, 0, },
> +	{ 34, IO_TYPE_EXTERNAL, 0, },
> +	{ 35, IO_TYPE_EXTERNAL, 0, },
> +	{ 36, IO_TYPE_EXTERNAL, 0, },
> +	{ 37, IO_TYPE_EXTERNAL, 0, },
> +	{ 38, IO_TYPE_EXTERNAL, 0, },
> +	{ 39, IO_TYPE_EXTERNAL, 0, },
> +	{ 40, IO_TYPE_EXTERNAL, 0, },
> +	{ 41, IO_TYPE_EXTERNAL, 0, },
> +	{ 76, IO_TYPE_EXTERNAL, 0, },
> +	{ 77, IO_TYPE_EXTERNAL, 0, },
> +	{ 78, IO_TYPE_EXTERNAL, 0, },
> +	{ 79, IO_TYPE_EXTERNAL, 0, },
> +	{ 80, IO_TYPE_EXTERNAL, 0, },
> +	{ 81, IO_TYPE_EXTERNAL, 0, },
> +	{ 82, IO_TYPE_EXTERNAL, 0, },
> +	{ 83, IO_TYPE_EXTERNAL, 0, },
> +	{ 84, IO_TYPE_EXTERNAL, 0, },
> +	{ 85, IO_TYPE_EXTERNAL, 0, },
> +	{ 86, IO_TYPE_EXTERNAL, 0, },
> +	{ 87, IO_TYPE_EXTERNAL, 0, },
> +	{ 88, IO_TYPE_EXTERNAL, 0, },
> +	{ 89, IO_TYPE_EXTERNAL, 0, },
> +	{ 90, IO_TYPE_EXTERNAL, 0, },
> +	{ 91, IO_TYPE_EXTERNAL, 0, },
> +	{ 92, IO_TYPE_EXTERNAL, 0, },
> +	{ 93, IO_TYPE_EXTERNAL, 0, },
> +	{ 94, IO_TYPE_EXTERNAL, 0, },
> +	{ 95, IO_TYPE_EXTERNAL, 0, },
> +	{ 96, IO_TYPE_EXTERNAL, 0, },
> +	{ 97, IO_TYPE_EXTERNAL, 0, },
> +	{ 98, IO_TYPE_EXTERNAL, 0, },
> +	{ 99, IO_TYPE_EXTERNAL, 0, },
> +	{ 100, IO_TYPE_EXTERNAL, 0, },
> +	{ 101, IO_TYPE_EXTERNAL, 0, },
> +	{ 102, IO_TYPE_EXTERNAL, 0, },
> +	{ 103, IO_TYPE_EXTERNAL, 0, },
> +	{ 104, IO_TYPE_EXTERNAL, 0, },
> +	{ 105, IO_TYPE_EXTERNAL, 0, },
> +	{ 106, IO_TYPE_EXTERNAL, 0, },
> +	{ 107, IO_TYPE_EXTERNAL, 0, },
> +	{ 108, IO_TYPE_EXTERNAL, 0, },
> +	{ 109, IO_TYPE_EXTERNAL, 0, },
> +	{ 110, IO_TYPE_EXTERNAL, 0, },
> +	{ 111, IO_TYPE_EXTERNAL, 0, },
> +	{ 112, IO_TYPE_EXTERNAL, 0, },
> +	{ 113, IO_TYPE_EXTERNAL, 0, },
> +	{ 114, IO_TYPE_EXTERNAL, 0, },
> +	{ 115, IO_TYPE_EXTERNAL, 0, },
> +	{ 116, IO_TYPE_EXTERNAL, 0, },
> +	{ 117, IO_TYPE_EXTERNAL, 0, },
> +	{ 118, IO_TYPE_EXTERNAL, 0, },
> +	{ 119, IO_TYPE_EXTERNAL, 0, },
> +	{ 120, IO_TYPE_EXTERNAL, 0, },
> +	{ 121, IO_TYPE_EXTERNAL, 0, },
> +	{ 122, IO_TYPE_EXTERNAL, 0, },
> +	{ 123, IO_TYPE_EXTERNAL, 0, },
> +	{ 124, IO_TYPE_EXTERNAL, 0, },
> +	{ 125, IO_TYPE_EXTERNAL, 0, },
> +	{ 126, IO_TYPE_EXTERNAL, 0, },
> +	{ 127, IO_TYPE_EXTERNAL, 0, },
> +	{ 132, IO_TYPE_EXTERNAL, 0, },
> +	{ 133, IO_TYPE_EXTERNAL, 0, },
> +	{ 134, IO_TYPE_EXTERNAL, 0, },
> +	{ 135, IO_TYPE_EXTERNAL, 0, },
> +	{ 136, IO_TYPE_EXTERNAL, 0, },
> +	{ 137, IO_TYPE_EXTERNAL, 0, },
> +	{ 138, IO_TYPE_EXTERNAL, 0, },
> +	{ 139, IO_TYPE_EXTERNAL, 0, },
> +	{ 140, IO_TYPE_EXTERNAL, 0, },
> +	{ 141, IO_TYPE_EXTERNAL, 0, },
> +	{ 142, IO_TYPE_EXTERNAL, 0, },
> +	{ 143, IO_TYPE_EXTERNAL, 0, },
> +	{ 144, IO_TYPE_EXTERNAL, 0, },
> +};
> +
> +static inline int k3_get_pins(struct udevice *dev)
> +{
> +	return 153;
> +}
> +
> +static inline int k3_get_functions(struct udevice *dev)
> +{
> +	return 7;
> +}
> +
> +static void __iomem *k3_pin_to_reg(struct udevice *dev, unsigned int pin)
> +{
> +	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
> +	unsigned int offset = pin > 130 ? (pin + 2) : pin;
> +
> +	if (pin > 152) {
> +		dev_err(dev, "Invalid pin (%u)\n", pin);
> +		return NULL;
> +	}
> +	return priv->regs + (offset << 2);
> +}
> +
> +static int k3_get_gpio_mux(struct udevice *dev, unsigned int selector)
> +{
> +	if (selector > 152) {
> +		dev_err(dev, "Invalid pin (%u)\n", selector);
> +		return -EINVAL;
> +	}
> +	/* SD/MMC1, QSPI, PMIC/JTAG use gpiofunc 1 per Linux pin data */
> +	if (selector >= 132)
> +		return 1;
> +	return 0;
> +}
> +
> +static int k3_get_io_type(struct udevice *dev, unsigned int selector)
> +{
> +	if (selector <= 41)
> +		return IO_TYPE_EXTERNAL;
> +	if (selector <= 75)
> +		return IO_TYPE_1V8;
> +	if (selector <= 127)
> +		return IO_TYPE_EXTERNAL;
> +	if (selector <= 131)
> +		return IO_TYPE_1V8;
> +	if (selector <= 144)
> +		return IO_TYPE_EXTERNAL;
> +	if (selector <= 152)
> +		return IO_TYPE_1V8;
> +	return -EINVAL;
> +}
> +
> +static unsigned int spacemit_k3_pin_to_io_pd_offset(unsigned int pin)
> +{
> +	unsigned int offset = 0;
> +
> +	switch (pin) {
> +	case 0 ... 20:
> +		offset = IO_PWR_DOMAIN_GPIO1_K3;
> +		break;
> +	case 21 ... 41:
> +		offset = IO_PWR_DOMAIN_GPIO2_Kx;
> +		break;
> +	case 76 ... 98:
> +		offset = IO_PWR_DOMAIN_GPIO4_K3;
> +		break;
> +	case 99 ... 127:
> +		offset = IO_PWR_DOMAIN_GPIO5_K3;
> +		break;
> +	case 132 ... 137:
> +		offset = IO_PWR_DOMAIN_MMC_Kx;
> +		break;
> +	case 138 ... 144:
> +		offset = IO_PWR_DOMAIN_QSPI_K3;
> +		break;
> +	}
> +
> +	return offset;
> +}
> +
> +static struct spacemit_pin_drv_strength spacemit_k3_ds_1v8_tbl[16] = {
> +	{ 0,  2 }, { 1,  4 }, { 2,  6 }, { 3,  7 },
> +	{ 4,  9 }, { 5, 11 }, { 6, 13 }, { 7, 14 },
> +	{ 8, 21 }, { 9, 23 }, { 10, 25 }, { 11, 26 },
> +	{ 12, 28 }, { 13, 30 }, { 14, 31 }, { 15, 33 },
> +};
> +
> +static struct spacemit_pin_drv_strength spacemit_k3_ds_3v3_tbl[16] = {
> +	{ 0,  3 }, { 1,  5 }, { 2,  7 }, { 3,  9 },
> +	{ 4, 11 }, { 5, 13 }, { 6, 15 }, { 7, 17 },
> +	{ 8, 25 }, { 9, 27 }, { 10, 29 }, { 11, 31 },
> +	{ 12, 33 }, { 13, 35 }, { 14, 37 }, { 15, 38 },
> +};
> +
> +static const struct spacemit_pinctrl_data k3_pinctrl_data = {
> +	.io_pins	= k3_io_pins,
> +	.nr_io_pins	= ARRAY_SIZE(k3_io_pins),
> +	.pin_to_reg	= k3_pin_to_reg,
> +	.get_gpio_mux	= k3_get_gpio_mux,
> +	.get_pins	= k3_get_pins,
> +	.get_functions	= k3_get_functions,
> +	.get_io_type	= k3_get_io_type,
> +	.pin_to_io_pd_offset = spacemit_k3_pin_to_io_pd_offset,
> +	.drive_mask	= PAD_DRIVE_K3,
> +	.ds_1v8_tbl	= spacemit_k3_ds_1v8_tbl,
> +	.ds_1v8_tbl_num	= ARRAY_SIZE(spacemit_k3_ds_1v8_tbl),
> +	.ds_3v3_tbl	= spacemit_k3_ds_3v3_tbl,
> +	.ds_3v3_tbl_num	= ARRAY_SIZE(spacemit_k3_ds_3v3_tbl),
>  };
>  
>  static const struct udevice_id spacemit_pinctrl_ids[] = {
>  	{
>  		.compatible = "spacemit,k1-pinctrl",
>  		.data = (uintptr_t)&k1_pinctrl_data,
> +	}, {
> +		.compatible = "spacemit,k3-pinctrl",
> +		.data = (uintptr_t)&k3_pinctrl_data,
>  	}, { /* sentinel */ }
>  };
>  
> 

Acked-by: E Shattow <e@freeshell.de>
