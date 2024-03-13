Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55504C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B930C87B82;
	Wed, 13 Mar 2024 11:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hlTm/e4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C151187D9D; Wed, 13 Mar 2024 11:30:20 +0100 (CET)
Received: from mail-m12738.qiye.163.com (mail-m12738.qiye.163.com
 [115.236.127.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF210875FA
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 11:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=hlTm/e4+w8sWWsvdbR5y1Kb1y9QH0qCQqX4LuZHVvWOakhOdLJI6UtBOxKqV0+31u0zW+UXCjqLmY3fX/HV5SFfIRZhh8VH6NwW5CvnRuRQ/lOoc5HKzEPQcKeWl8q+H4Me9qCTcusa0nrh06qToKFW9OOR0WRuCmZM1Jg8VLHA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Yg1b21+5PlYALgpfdFlrMPfq/o91pu/vpYmq+a6y7QE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A441D900429;
 Wed, 13 Mar 2024 18:30:03 +0800 (CST)
Message-ID: <21a38ad5-b9ec-4133-b800-d91a6171cffb@rock-chips.com>
Date: Wed, 13 Mar 2024 18:30:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] rockchip: spi: rk_spi: do not write bytes when
 in read-only mode
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-1-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-1-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxOH1ZIGE5KHh1DHR9NH0lVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e375cac9603a9kunma441d900429
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Qzo*CjMXFikoLz0#SD8f
 IVYKCUlVSlVKTEpLSElOQ0tPTUlOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTk9MNwY+
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


On 2024/3/4 19:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The read-only mode is currently supported but only for 16b-aligned
> buffers. For unaligned buffers, the last byte will be read in RW mode
> right now, which isn't what is desired. Instead, let's put the
> controller back into RO mode for that last byte and skip any write in
> the xfer loop.
>
> This is required for 3-wire SPI mode where PICO/POCI lanes are shorted
> on HW level. This incidentally the recommended design for RK806 PMIC for
> RK3588 products.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/spi/rk_spi.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
> index 7de943356ad..c8694fdff95 100644
> --- a/drivers/spi/rk_spi.c
> +++ b/drivers/spi/rk_spi.c
> @@ -453,8 +453,17 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   	 * case of read-only transfers by using the full 16bits of each
>   	 * FIFO element.
>   	 */
> -	if (!out)
> +	if (!out) {
>   		ret = rockchip_spi_16bit_reader(dev, &in, &len);
> +		/*
> +		 * If "in" isn't 16b-aligned, we need to send the last byte
> +		 * ourselves. We however need to have the controller in RO mode
> +		 * which differs from the default.
> +		 */
> +		clrsetbits_le32(&regs->ctrlr0,
> +				TMOD_MASK << TMOD_SHIFT,
> +				TMOD_RO << TMOD_SHIFT);
> +	}
>   
>   	/* This is the original 8bit reader/writer code */
>   	while (len > 0) {
> @@ -465,12 +474,13 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   		rkspi_enable_chip(regs, true);
>   
>   		toread = todo;
> -		towrite = todo;
> +		/* Only write if we have something to write */
> +		towrite = out ? todo : 0;
>   		while (toread || towrite) {
>   			u32 status = readl(&regs->sr);
>   
>   			if (towrite && !(status & SR_TF_FULL)) {
> -				writel(out ? *out++ : 0, regs->txdr);
> +				writel(*out++, regs->txdr);
>   				towrite--;
>   			}
>   			if (toread && !(status & SR_RF_EMPT)) {
> @@ -501,6 +511,10 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   		spi_cs_deactivate(dev, slave_plat->cs);
>   
>   	rkspi_enable_chip(regs, false);
> +	if (!out)
> +		clrsetbits_le32(&regs->ctrlr0,
> +				TMOD_MASK << TMOD_SHIFT,
> +				TMOD_TR << TMOD_SHIFT);
>   
>   	return ret;
>   }
>
