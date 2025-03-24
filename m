Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45FCC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 23:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC075809D0;
	Tue, 25 Mar 2025 00:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="od4h0EuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A03B80EEF; Tue, 25 Mar 2025 00:05:18 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE2DE808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZM7td5BXLz9sbs;
 Tue, 25 Mar 2025 00:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742857513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcZnVGywOWYyOlZzPS41xOf78m+lCBTXAPcdW0Biut0=;
 b=od4h0EuGoibmE+Qm8jcTetL1DTCPMZVF/Hb6IW2R6UrXg6p6G28LPcjKNrc0NqHIHKy5e0
 VcsN7huTzykCUp65K4S1kCLjRkB7L8ku+cP1rflOTn3+iHcSRKDzrb6LT7xO3PU/LeyKx+
 ETjK5YR9pJc92kI9JyGlnud87kZ6JMd8R1FTana3I+0fSWVcMCOmtv95leHeR6X1Gn95ZL
 hDCF17osGZARsK9JnS9iLb/vzWPOBzQIrObBsdR9aeWezjKfEVMLUxak+QZoqCg3w2uvAb
 9Ava+1bZCOb3cDJ/ltCdIyoN3GG7PFtQKCgY+DTZqU+bP6F47PmNug9z2XI6Vw==
Message-ID: <64d123de-b1b3-4dcf-ba98-91ef5ecb6067@mailbox.org>
Date: Tue, 25 Mar 2025 00:05:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Geert Uytterhoeven <geert+renesas@glider.be>
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
 <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
 <b812bb48-8534-4164-a5ed-19764c38656c@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b812bb48-8534-4164-a5ed-19764c38656c@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 30f1ff06f674e1683c6
X-MBO-RS-META: zffuiaf7qg6d41zbbo51nox6iz7yxa1j
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

On 3/24/25 11:12 AM, Paul Barker wrote:
> On 24/03/2025 01:11, Marek Vasut wrote:
>> On 3/19/25 1:03 PM, Paul Barker wrote:
>>
>> [...]
>>
>>> +++ b/drivers/net/Kconfig
>>> @@ -864,7 +864,7 @@ config RENESAS_RAVB
>>>    	select PHY_ETHERNET_ID
>>>    	help
>>>    	  This driver implements support for the Ethernet AVB block in
>>> -	  Renesas M3 and H3 SoCs.
>>> +	  several Renesas R-Car and RZ SoCs.
>>
>> RZ/G instead of RZ , right ?
> 
> This will also be used for RZ/V2L.

Ahh, thank you for clarifying.

[...]

>>> +static void ravb_mac_init_rzg2l(struct udevice *dev)
>>> +{
>>> +	struct ravb_priv *eth = dev_get_priv(dev);
>>> +
>>> +	setbits_32(eth->iobase + RAVB_REG_ECMR,
>>> +		   ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
>>> +		   ECMR_TE | ECMR_RE | ECMR_RZPF |
>>> +		   (eth->phydev->duplex ? ECMR_DM : 0));
>>
>> Can you configure the ECMR extras in ravb_config() just before
>> writel(mask, eth->iobase + RAVB_REG_ECMR); based on some private data
>> flag, like '.is_rzg2l' , instead ?
> 
> ravb_config() has been split into ravb_config_rcar() &
> ravb_config_rzg2l() by this patch series. So there is no longer a common
> write to RAVB_REG_ECMR.
> 
>>
>>> +}
>>> +
>>>    /* AVB-DMAC init function */
>>>    static int ravb_dmac_init(struct udevice *dev)
>>>    {
>>> @@ -459,6 +481,14 @@ static void ravb_dmac_init_rcar(struct udevice *dev)
>>>    	writel(mode, eth->iobase + RAVB_REG_APSR);
>>>    }
>>>    
>>> +static void ravb_dmac_init_rzg2l(struct udevice *dev)
>>> +{
>>> +	struct ravb_priv *eth = dev_get_priv(dev);
>>> +
>>> +	/* Set Max Frame Length (RTC) */
>>> +	writel(0x7ffc0000 | RFLR_RFL_MIN, eth->iobase + RAVB_REG_RTC);
>>
>> I assume this register is actually RZ/G2L specific ?
> 
> This register also exists on RZ/G2{H,M,N,E}, but in the Linux kernel
> ravb driver it is only modified for RZ/G2L.

Is this deliberate or is that a bug ?

+CC Geert.

>>> +}
>>> +
>>>    static int ravb_config(struct udevice *dev)
>>>    {
>>>    	struct ravb_device_ops *device_ops =
>>> @@ -501,6 +531,22 @@ static void ravb_config_rcar(struct udevice *dev)
>>>    	writel(mask, eth->iobase + RAVB_REG_ECMR);
>>>    }
>>>    
>>> +static void ravb_config_rzg2l(struct udevice *dev)
>>> +{
>>> +	struct ravb_priv *eth = dev_get_priv(dev);
>>> +	struct phy_device *phy = eth->phydev;
>>> +
>>> +	writel(CSR0_TPE | CSR0_RPE, eth->iobase + RAVB_REG_CSR0);
>>> +
>>> +	/* Set the transfer speed */
>>> +	if (phy->speed == 10)
>>> +		writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);
>>
>> Since this patch adds .has_reset flag, wouldn't it be possible to add
>> another flag called something like .has_10 flag and simply do:
>>
>> if (eth->has_10 && phy->speed == 10)
>>     writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);
>>
>> ?
> 
> The layout of RAVB_REG_GECMR differs between RZ/G2L and RZ/G2{H,M,N,E},
> so we can't use the same constants for all platforms. We also need the
> additional write to RAVB_REG_CSR0 for RZ/G2L so it's worth having the
> ravb_config_rzg2l() function instead of a couple of flags.
Ah, thank you for clarifying. This register layout bit is what I was 
missing. The CSR0 part could have been isolated in some if (..), but the 
register layout is a bit more unpleasant to deal with.
