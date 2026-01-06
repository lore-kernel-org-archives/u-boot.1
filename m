Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F02CEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 23:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D4A83C4B;
	Wed,  7 Jan 2026 00:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="D60xePgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED55383C62; Wed,  7 Jan 2026 00:32:14 +0100 (CET)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [IPv6:2001:41d0:203:375::bb])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F4583C08
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 00:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
Message-ID: <70d036ee-e61b-44bb-9160-697e4d3f75e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767742332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1U6OQ+AAbOyjABZne3cS1osLVZAZpL1GGgRniSva4b0=;
 b=D60xePgDHAvmiymQqXTA3gE1wpXanElHFUVCj8UEa7+nFwbJiXGFIHH1E2Fe7kt2pFan+W
 SvR0pAS6brmX18XmXRvvTWoOPXYa934eKoQ0P0MfR49A+Lbo/sKKthPNP/b31R7dPRrCan
 hRnL1eHy15jOeKzq62z+7Vkn/2NrOao=
Date: Tue, 6 Jan 2026 18:32:06 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: Add power sequencing driver for PCI slots
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260106223409.748335-1-sean.anderson@linux.dev>
 <bafc0b79-9126-4cdc-92d1-dd6fe2f884ac@mailbox.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <bafc0b79-9126-4cdc-92d1-dd6fe2f884ac@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 1/6/26 18:14, Marek Vasut wrote:
> On 1/6/26 11:34 PM, Sean Anderson wrote:
>> Extend the PCI bridge driver to enable resources associated with PCI
>> slots like clocks, power rails, and resets. This is modeled off of the
>> PCI power control subsystem in Linux. The traditional compatible for PCI
>> slots in U-Boot is pci-bridge, but Linux uses the more-systematic
>> pciclass,0604 so add that as an option.
> 
> Oh, nice :)
> 
>> +static int __maybe_unused pci_bridge_probe(struct udevice *dev)
>> +{
>> +    struct clk clk;
>> +    struct gpio_desc perst;
>> +
>> +    if (!clk_get_by_index(dev, 0, &clk)) {
>> +        int ret = clk_enable(&clk);
>> +
>> +        if (ret)
>> +            return log_msg_ret("clk", ret);
> 
> Should we use dev_err() instead ?

I thought we weren't supposed to log by default in device drivers to reduce text size?

>> +        /* Delay for T_PERST-CLK (100 us for all slot types) */
>> +        udelay(100);
>> +    }
>> +
>> +    if (!gpio_request_by_name(dev, "reset-gpios", 0, &perst, 0)) {
> 
> Invert conditional, reduce indent.

OK

>> +        unsigned long delay = 0;
>> +        int ret;
>> +
>> +        /*
>> +         * If PERST is inactive, the following call to dm_gpio_clrset_flags
>> +         * will be the first time we assert it and we will need to
>> +         * delay for T_PERST.
>> +         */
>> +        if (dm_gpio_get_value(&perst) != 1)
>> +            delay = 100;
>> +
>> +        ret = dm_gpio_clrset_flags(&perst, GPIOD_MASK_DIR,
>> +                       GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>> +        if (ret)
>> +            return log_msg_ret("set", ret);
>> +        mdelay(delay);
> 
> Maybe set a flag and avoid calling mdelay() altogether ?

OK

--Sean

>> +        ret = dm_gpio_set_value(&perst, 0);
>> +        if (ret)
>> +            return log_msg_ret("clr", ret);
>> +
>> +        /*
>> +         * PCIe section 6.6.1:
>> +         * > ... software must wait a minimum of 100 ms before sending a
>> +         * > Configuration Request to the device immediately below that
>> +         * > Port.
>> +         */
>> +        mdelay(100);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   U_BOOT_DRIVER(pci_bridge_drv) = {
>>       .name        = "pci_bridge_drv",
>>       .id        = UCLASS_PCI,
>>       .of_match    = pci_bridge_ids,
>> +#if CONFIG_IS_ENABLED(PCI_PWRCTRL_SLOT)
>> +    .probe        = pci_bridge_probe,
> 
> .probe = CONFIG_IS_ENABLED(PCI_PWRCTRL_SLOT, pci_bridge_probe, NULL),
> 
> Thanks !

