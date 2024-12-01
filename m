Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197EAD49788
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3AB88954B;
	Sun,  1 Dec 2024 19:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K7V+6I75";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xvt8B0L9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EBE89515; Sun,  1 Dec 2024 19:51:29 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E4288DFE
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 19:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y1bbw2jygz9t0M;
 Sun,  1 Dec 2024 19:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PU39ca/lpnNRbNUEC0KOFbUFqmVgM3Y2Q+kGSMXNcj4=;
 b=K7V+6I75aSq6T0TDIAOngvdXdbXOOIoa3vR36BkRfgHL6DDeEo4Lh5OeAYj75MeBDU5Q/7
 gRgUAVpB0RnIl62SkQsdjASQg02wj4cM2C/T6f1LiJbyJBKUhqf8Kj6QXbQgeGpl40SfnC
 JTw7jWd/dLB0XP5g6VTx7+wPFVYxBQFeU5qDt2CtLFfJubvmVmo0/Y6xq4pntMVouA+Ar6
 ibzAy3l0u58R9LSl0wMdCjmDq1flYbtqN2MV4HfSW0VDsYfwQzD35J6aiRTeGGf7R3V5+i
 DUMd1J8CCL5KO7bjxkKPBY+5R93marIYhN7JSH+OUEV+gBkHOgGMaCvNoSXg1w==
Message-ID: <8dd0b366-6e6b-4e6a-87d2-5a8d204c7732@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PU39ca/lpnNRbNUEC0KOFbUFqmVgM3Y2Q+kGSMXNcj4=;
 b=xvt8B0L9thAWrFPCeIN5fcais98gXxK2Jh7luSrnXMGuIWfkP6pNuNWVK7HO+0llATTctf
 yJ9LRIzu24tLpaiwuQscEB0uh2/zv8MPiZ5Otvai9zZArM2MfqeHTZcDebtWvm4GGMB+1i
 IpalAjZjBo5IjYV3ixgj+PvYER0d+4ZyREXvHbFPXF6PobYAcT+Pk4O0DOczysAC6UpI7R
 k5k/J5PJLSuWPG/zarqayYSsFgKjESOgXedN8ZYyym/ElD1bvpwijCPrKTJGzTPrFFy1JK
 B8PUtMwbNJcFb4tUAPxWBzeXbvOcyYMJrOaMlPFzdC0HU5+x5zv+BpisgG19mA==
Date: Sun, 1 Dec 2024 19:50:18 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] pinctrl: rzg2l: Support Ethernet TXC output enable
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
References: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
 <20241120094830.71-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241120094830.71-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4ae04271b97f3de25bb
X-MBO-RS-META: 9s7rugjuxy7r54wc71tie3wubwi3soix
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

On 11/20/24 10:48 AM, Paul Barker wrote:
> On the RZ/G2L SoC family, the direction of the Ethernet TXC/TX_CLK
> signal is selectable to support an Ethernet PHY operating in either MII
> or RGMII mode. By default, the signal is configured as an input and MII
> mode is supported. The ETH_MODE register can be modified to configure
> this signal as an output to support RGMII mode.
> 
> As this signal is be default an input, and can optionally be switched to
> an output, it maps neatly onto an `output-enable` property in the device
> tree.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> Changes v1->v2:
>    - Split out of series adding RZ/G2L Ethernet support [1]
> 
> [1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/
> 
>   drivers/pinctrl/renesas/rzg2l-pfc.c | 31 +++++++++++++++++++++++++++--
>   include/renesas/rzg2l-pfc.h         |  2 ++
>   2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
> index 0098e2d52d57..af371bd0ff1e 100644
> --- a/drivers/pinctrl/renesas/rzg2l-pfc.c
> +++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
> @@ -180,7 +180,7 @@ static const u32 r9a07g044_gpio_configs[] = {
>   	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
>   	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
>   	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
> -	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0) | PIN_CFG_OEN),
>   	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
>   	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
>   	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> @@ -189,7 +189,7 @@ static const u32 r9a07g044_gpio_configs[] = {
>   	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
>   	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
>   	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> -	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1) | PIN_CFG_OEN),
>   	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
>   	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
>   	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> @@ -449,6 +449,32 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>   		break;
>   	}
>   
> +	case PIN_CONFIG_OUTPUT_ENABLE: {
> +		u8 ch;
> +
> +		if (!(cfg & PIN_CFG_OEN)) {
> +			dev_err(dev, "pin does not support OEN\n");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * We can determine which Ethernet interface we're dealing with from
> +		 * the caps.
> +		 */
> +		if (cfg & PIN_CFG_IO_VMC_ETH0)
> +			ch = 0;
> +		else /* PIN_CFG_IO_VMC_ETH1 */
> +			ch = 1;
> +
> +		dev_dbg(dev, "set ETH%u TXC OEN=%u\n", ch, argument);
> +		if (argument)
> +			clrbits_8(data->base + ETH_MODE, BIT(ch));
> +		else
> +			setbits_8(data->base + ETH_MODE, BIT(ch));
> +
> +		break;
> +	}
> +
>   	default:
>   		dev_err(dev, "Invalid pinconf parameter\n");
>   		return -EOPNOTSUPP;
> @@ -542,6 +568,7 @@ static int rzg2l_get_pin_muxing(struct udevice *dev, unsigned int selector,
>   
>   static const struct pinconf_param rzg2l_pinconf_params[] = {
>   	{ "input-enable",	PIN_CONFIG_INPUT_ENABLE,	1 },
> +	{ "output-enable",	PIN_CONFIG_OUTPUT_ENABLE,	1 },
>   	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	3300 /* mV */ },
>   };
>   
> diff --git a/include/renesas/rzg2l-pfc.h b/include/renesas/rzg2l-pfc.h
> index d1015b1d2ac1..36fa8da8e2e4 100644
> --- a/include/renesas/rzg2l-pfc.h
> +++ b/include/renesas/rzg2l-pfc.h
> @@ -22,6 +22,7 @@
>   #define PIN_CFG_FILONOFF		BIT(10)
>   #define PIN_CFG_FILNUM			BIT(11)
>   #define PIN_CFG_FILCLKSEL		BIT(12)
> +#define PIN_CFG_OEN			BIT(13)
>   
>   #define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
>   					 PIN_CFG_SR | \
> @@ -79,6 +80,7 @@
>   #define SD_CH(n)		(0x3000 + (n) * 4)
>   #define ETH_POC(ch)		(0x300c + (ch) * 4)
>   #define QSPI			0x3008
> +#define ETH_MODE		(0x3018)
Parenthesis unnecessary around the 0x3018 , I can fix it while applying?

In any case, with that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
