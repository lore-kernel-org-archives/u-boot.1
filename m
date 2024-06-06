Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C90C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05277885AE;
	Thu,  6 Jun 2024 10:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fTGDqFpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F1B88468; Thu,  6 Jun 2024 10:15:46 +0200 (CEST)
Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com
 [101.71.155.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991798844E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fTGDqFpGkK0cx1YpxuPpQxFAgide4oHS3p5yizt/QDDmJ/dOrtVFTe19qNL1mL8LEaCf0w1pZp8/SvGMTRkBzGANdOB2TeCNzk79yyR1Z4KXf6v+hrOw02BUCEcbBh16aaPxPS4NfbKO00SuxUYChjGjlhy4UzGLBE/WwewCLn4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=fJz6fXPX38kaLCDHPgG9ReeJlDqtnKJdpEbCrIJ/zXg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id CBF62900229;
 Thu,  6 Jun 2024 16:15:21 +0800 (CST)
Message-ID: <2af5badc-c758-4e89-81a1-e1f34b2461b6@rock-chips.com>
Date: Thu, 6 Jun 2024 16:15:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH next v2 5/6] power: rk8xx: properly print all supported
 PMICs name
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
 <20240605-misc-tsd-v2-5-12479432c90f@cherry.de>
Content-Language: en-US
In-Reply-To: <20240605-misc-tsd-v2-5-12479432c90f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0YQlYZTkpLHhgYHUIdTUtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec9de71603a9kunmcbf62900229
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phg6GDo6NDMCKDVMLkg2C04h
 Fw8wC0JVSlVKTEpMTU1KTElJQk9IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITU9CNwY+
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


On 2024/6/5 23:56, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The ID of the PMIC is stored in the 2 16b registers but the only part
> that matters right now is the 3 MSB, which make the 3 digits (in hex) of
> the part number.
>
> Right now, only RK808 was properly displayed, with this all currently
> supported PMICs should display the proper part number.
>
> Additionally, when the PMIC variant is not found, print that value
> instead of the masked unshifted value as all PMICs we support for now
> have their LSB ignored to represent the actual part number.
>
> Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
> Ringneck).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/pmic/rk8xx.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 12ff26a0855..4d07e630579 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -277,10 +277,9 @@ static int rk8xx_probe(struct udevice *dev)
>   		return ret;
>   
>   	priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
> -	show_variant = priv->variant;
> +	show_variant = bitfield_extract_by_mask(priv->variant, RK8XX_ID_MSK);
>   	switch (priv->variant) {
>   	case RK808_ID:
> -		show_variant = 0x808;	/* RK808 hardware ID is 0 */
>   		break;
>   	case RK805_ID:
>   	case RK816_ID:
> @@ -311,7 +310,7 @@ static int rk8xx_probe(struct udevice *dev)
>   		init_data_num = ARRAY_SIZE(rk806_init_reg);
>   		break;
>   	default:
> -		printf("Unknown PMIC: RK%x!!\n", priv->variant);
> +		printf("Unknown PMIC: RK%x!!\n", show_variant);
>   		return -EINVAL;
>   	}
>   
>
