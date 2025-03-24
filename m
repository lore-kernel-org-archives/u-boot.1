Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909DCC28B30
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 01:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5C081E47;
	Mon, 24 Mar 2025 02:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mM126Ndy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gAswop9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682C181EC5; Mon, 24 Mar 2025 02:15:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4956681E3E
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 02:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZLZqN71Nfz9scX;
 Mon, 24 Mar 2025 02:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742778929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2Zb/NlCEAvSqquVbPHnCJnjx9mIYUvQW72ckl8e+Z8=;
 b=mM126Ndy7OXf2mI3A74RaYG/SG2vS9wReDzAg1aJHTpFfBhaUHwRLJbrdigs4JeeTO0TbG
 Nn4CDFznyZjftg3ZPKcMOY1RAy5dh/y+NdF5SMYKIOH3CyVAGvmGFRY7c0QX93Efu30P4e
 AkwMOWMUEyH2C8xOozlIHYCvuCQTMdQOTw7Lswhmb0ly0CahiAHi1WZmM55bkNyBcVBWMC
 Rw6so2f3XAcbngVvXNn61PMNHrEk0UAUuzYKmAHz+N1e3Wl4t0nBxnxgwknAOP+F8rlUSO
 f2BANhjIi4hcXmZfOB+vpVyHyC+3tLM4JDjz5uCLkQu9yUgfHpzdquMG/xfMIA==
Message-ID: <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742778927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2Zb/NlCEAvSqquVbPHnCJnjx9mIYUvQW72ckl8e+Z8=;
 b=gAswop9Gg2dPIc+PNgUL9zomoNVpSSrOpgKXfawjd5DArfazDVNzm4D9awSOvqc2lDGQcm
 /q/Lb3t9A4eS83vpQGMZQ5jEFtvNGoAcOuHXM9aGickH3mpW3PkloHJy1PFFIn7vuVlbjQ
 zzQpEUo2gSMZppBkJpZPSTfkdiiNxVqJdAokBJmBYSxiWNBPHkCQFS/PRdOfogjhdCLU4Z
 OlTDVHyteziiX/C/J9vn4svpD0Pa3U1v+MA8LxI1BPT+YwQLBTBLy0MH/pPX5O1GUbwG2c
 PJHgjkJGol9eTug5GIeQpK3iOg024dMRDpHhzxxNqrV+WGJ4hA0DIOJR5LiPrg==
Date: Mon, 24 Mar 2025 02:11:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kshmicxa7d3n7qj464xdhuygtotbn85z
X-MBO-RS-ID: 90559e4b495dcdf6f48
X-Rspamd-Queue-Id: 4ZLZqN71Nfz9scX
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

On 3/19/25 1:03 PM, Paul Barker wrote:

[...]

> +++ b/drivers/net/Kconfig
> @@ -864,7 +864,7 @@ config RENESAS_RAVB
>   	select PHY_ETHERNET_ID
>   	help
>   	  This driver implements support for the Ethernet AVB block in
> -	  Renesas M3 and H3 SoCs.
> +	  several Renesas R-Car and RZ SoCs.

RZ/G instead of RZ , right ?

>   
>   config MPC8XX_FEC
>   	bool "Fast Ethernet Controller on MPC8XX"
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index ecf6e05f47eb..86aa5cd5835c 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -31,6 +31,7 @@
>   #define RAVB_REG_CSR		0x00C
>   #define RAVB_REG_APSR		0x08C
>   #define RAVB_REG_RCR		0x090
> +#define RAVB_REG_RTC		0x0B4
>   #define RAVB_REG_TGC		0x300
>   #define RAVB_REG_TCCR		0x304
>   #define RAVB_REG_RIC0		0x360
> @@ -44,6 +45,7 @@
>   #define RAVB_REG_GECMR		0x5b0
>   #define RAVB_REG_MAHR		0x5c0
>   #define RAVB_REG_MALR		0x5c8
> +#define RAVB_REG_CSR0		0x800
>   
>   #define CCC_OPC_CONFIG		BIT(0)
>   #define CCC_OPC_OPERATION	BIT(1)
> @@ -65,14 +67,24 @@
>   #define PIR_MDC			BIT(0)
>   
>   #define ECMR_TRCCM		BIT(26)
> +#define ECMR_RCPT		BIT(25)
>   #define ECMR_RZPF		BIT(20)
>   #define ECMR_PFR		BIT(18)
>   #define ECMR_RXF		BIT(17)
> +#define ECMR_TXF		BIT(16)
>   #define ECMR_RE			BIT(6)
>   #define ECMR_TE			BIT(5)
>   #define ECMR_DM			BIT(1)
> +#define ECMR_PRM		BIT(0)
>   #define ECMR_CHG_DM		(ECMR_TRCCM | ECMR_RZPF | ECMR_PFR | ECMR_RXF)
>   
> +#define CSR0_RPE		BIT(5)
> +#define CSR0_TPE		BIT(4)
> +
> +#define GECMR_SPEED_10M		(0 << 4)
> +#define GECMR_SPEED_100M	(1 << 4)
> +#define GECMR_SPEED_1G		(2 << 4)
> +
>   /* DMA Descriptors */
>   #define RAVB_NUM_BASE_DESC		16
>   #define RAVB_NUM_TX_DESC		8
> @@ -385,6 +397,16 @@ static void ravb_mac_init_rcar(struct udevice *dev)
>   	writel(0, eth->iobase + RAVB_REG_ECSIPR);
>   }
>   
> +static void ravb_mac_init_rzg2l(struct udevice *dev)
> +{
> +	struct ravb_priv *eth = dev_get_priv(dev);
> +
> +	setbits_32(eth->iobase + RAVB_REG_ECMR,
> +		   ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
> +		   ECMR_TE | ECMR_RE | ECMR_RZPF |
> +		   (eth->phydev->duplex ? ECMR_DM : 0));

Can you configure the ECMR extras in ravb_config() just before 
writel(mask, eth->iobase + RAVB_REG_ECMR); based on some private data 
flag, like '.is_rzg2l' , instead ?

> +}
> +
>   /* AVB-DMAC init function */
>   static int ravb_dmac_init(struct udevice *dev)
>   {
> @@ -459,6 +481,14 @@ static void ravb_dmac_init_rcar(struct udevice *dev)
>   	writel(mode, eth->iobase + RAVB_REG_APSR);
>   }
>   
> +static void ravb_dmac_init_rzg2l(struct udevice *dev)
> +{
> +	struct ravb_priv *eth = dev_get_priv(dev);
> +
> +	/* Set Max Frame Length (RTC) */
> +	writel(0x7ffc0000 | RFLR_RFL_MIN, eth->iobase + RAVB_REG_RTC);

I assume this register is actually RZ/G2L specific ?

> +}
> +
>   static int ravb_config(struct udevice *dev)
>   {
>   	struct ravb_device_ops *device_ops =
> @@ -501,6 +531,22 @@ static void ravb_config_rcar(struct udevice *dev)
>   	writel(mask, eth->iobase + RAVB_REG_ECMR);
>   }
>   
> +static void ravb_config_rzg2l(struct udevice *dev)
> +{
> +	struct ravb_priv *eth = dev_get_priv(dev);
> +	struct phy_device *phy = eth->phydev;
> +
> +	writel(CSR0_TPE | CSR0_RPE, eth->iobase + RAVB_REG_CSR0);
> +
> +	/* Set the transfer speed */
> +	if (phy->speed == 10)
> +		writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);

Since this patch adds .has_reset flag, wouldn't it be possible to add 
another flag called something like .has_10 flag and simply do:

if (eth->has_10 && phy->speed == 10)
   writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);

?
