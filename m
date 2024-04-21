Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CADFC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641D488310;
	Sun, 21 Apr 2024 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713732338;
	bh=ZCcx2GMx3fgMQUnXqMFpP3uV9EAIapNG2KNDcpl2SKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kb1z+IkhLSo7EkFQo0AAfViYuWi1IPfsjhXa5B0ZN4eSw7pQpAGGPEOP8Rk/+abuJ
	 Dy2PxzKJ5hmVAvUMT2MY1N30BbX1Opm3TVq8Rr/KzKitrxiOI8Jnh3IOqmjgFd5Wuv
	 5ZIsyUBxU8XP1hO7FzLqhan2S70+59EG9pTtfYGx+/Jr715DsWV8SmaL38cH2w+MHY
	 AI9a13r/HAVubv4qdXEBpOGIJGyxGk1Nenn9eE26vcWNI+HGQxDCqxFi79eLkYpNdn
	 hcd1rSOAiJYlvn27m9qjiVAFJXj+DlKJKjDhSyfSkRs0LysjaM2a0sHhijruHoB2PA
	 p4E4uMyu0hkjg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 38E49880A1;
 Sun, 21 Apr 2024 22:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713732333;
 bh=ZCcx2GMx3fgMQUnXqMFpP3uV9EAIapNG2KNDcpl2SKI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qGw0wB8uOxwxI3Bdys8KFAKU/gehQEkUNvC1dJFucA0S8y4OE7/nTztIwesW4CxdC
 stavbith0PjihNtS/x89ziLL4Gcp7hT8mQvfGQF0+LnYlJtKkuitKdW8Hlk3VwJAsr
 dUQBvLeB+86YSfK6NMJ0M9EFUsjgzsDkgGfqP54phfB9z0vysy9uZz8T5eTkYB06wM
 LsbCT+ZAOhuWiAiio5CCS7z0vR0XmUeiMqpv84ga7Fvs0Dtc45gE8gtYBS1zWGsxLU
 QdUCTrnHC2LpILkKoHnDGOuLL5Mtl6WhJ7H7u+UVtGID5EGQE64myB/EeMd8YPDqDY
 Fgih6xnpSfQ6A==
Message-ID: <7e3063b5-cb03-436d-b780-c05edbd95010@denx.de>
Date: Sun, 21 Apr 2024 22:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2: update reset method for host and device mode
To: Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>,
 Tom Rini <trini@konsulko.com>
References: <20240328131811.94559-1-seashell11234455@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240328131811.94559-1-seashell11234455@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/28/24 2:14 PM, Kongyang Liu wrote:

[...]

> @@ -464,12 +464,26 @@ static void reconfig_usbd(struct dwc2_udc *dev)
>   {
>   	/* 2. Soft-reset OTG Core and then unreset again. */
>   	int i;
> -	unsigned int uTemp = writel(CORE_SOFT_RESET, &reg->grstctl);
> +	unsigned int uTemp;
>   	uint32_t dflt_gusbcfg;
>   	uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
>   	u32 max_hw_ep;
>   	int pdata_hw_ep;
>   

Drop this newline

> +	u32 snpsid, greset;
> +
> +	snpsid = readl(&reg->gsnpsid);
> +	writel(CORE_SOFT_RESET, &reg->grstctl);
> +	if ((snpsid & SNPSID_VER_MASK) < (SNPSID_VER_420a & SNPSID_VER_MASK)) {

Can you use FIELD_GET()/FIELD_PREP() for this ?

> +		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET, false, 1000, false);
> +	} else {
> +		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET_DONE, true, 1000, false);
> +		greset = readl(&reg->grstctl);
> +		greset &= ~CORE_SOFT_RESET;
> +		greset |= CORE_SOFT_RESET_DONE;
> +		writel(greset, &reg->grstctl);

clrsetbits_le32()

[...]

> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index 637eb2dd06..1baeff96ee 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -159,6 +159,7 @@ static void dwc_otg_core_reset(struct udevice *dev,
>   			       struct dwc2_core_regs *regs)
>   {
>   	int ret;
> +	u32 snpsid, greset;
>   
>   	/* Wait for AHB master IDLE state. */
>   	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_AHBIDLE,
> @@ -167,9 +168,20 @@ static void dwc_otg_core_reset(struct udevice *dev,
>   		dev_info(dev, "%s: Timeout!\n", __func__);
>   
>   	/* Core Soft Reset */
> +	snpsid = readl(&regs->gsnpsid);
>   	writel(DWC2_GRSTCTL_CSFTRST, &regs->grstctl);
> -	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
> -				false, 1000, false);
> +	if ((snpsid & DWC2_SNPSID_VER_MASK) < (DWC2_SNPSID_DEVID_VER_420a & DWC2_SNPSID_VER_MASK)) {
> +		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
> +					false, 1000, false);
> +	} else {
> +		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_GSFTRST_DONE,
> +					true, 1000, false);
> +		greset = readl(&regs->grstctl);
> +		greset &= ~DWC2_GRSTCTL_CSFTRST;
> +		greset |= DWC2_GRSTCTL_GSFTRST_DONE;
> +		writel(greset, &regs->grstctl);

Same comments as above.

Maybe this should be pulled into dedicated function to avoid duplication?

> +	}
> +
>   	if (ret)
>   		dev_info(dev, "%s: Timeout!\n", __func__);
>   
> @@ -1180,7 +1192,8 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
>   		 snpsid >> 12 & 0xf, snpsid & 0xfff);
>   
>   	if ((snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_2xx &&
> -	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx) {
> +		(snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx &&
> +	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_4xx) {

Try FIELD_GET/FIELD_PREP
