Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E9DC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 21:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0829788BD2;
	Wed, 21 Aug 2024 23:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724276626;
	bh=9haksfXLMmyx1R3Ir3dMOItRfPQmNZQpzHf4sx7SOdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PcPX7cx8MqnXGyeXbjVokyb7+2Wv/Ijm7J21Z76oPB0+T9ARJF3Jf5xkbhlAkYm5e
	 4eYC8CcJtlf1FbBs59TsKtd4dljlWefazrgGAeHcGMgyR2x4II6Y7EVTFMAfpETwjg
	 vPmQwuUbcudUwf3KVlab5h7eBWgvOgf3Vv/KUQp0IZXA7hi2pOEXjnV5AWdko5YlQw
	 W5Yu1WcGKqcxa1lV1N81tx3t5G8UhWlAvHSD80yQN+r+lkKaHvzJ1WZNLkPU7b1ZWi
	 1RUnfV7iSZfvnyQ9YYes623Sf2RdSlHOHXBZzPqjYWgGTKa2+Q/8MoKMEEQ8wIzSQL
	 1SaX3fZa4AaRA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2D8218785E;
 Wed, 21 Aug 2024 23:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724276624;
 bh=9haksfXLMmyx1R3Ir3dMOItRfPQmNZQpzHf4sx7SOdE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hUgpZ7XSxq2uX2p7uyD1vIlVttk9G/JdizRSPqmifWo+uPjQGnHZKG0P3832Ck8EH
 qd1iM5W4Kw3SELaqgMuSHS1EY1uLJF4rJCvShjHoKtaOJg2Kk3u0u6i+hEsRNzvUmN
 sQG6nUzoh8Sayx7PPz5YLadMdJ3i2sk6raUH3eLxrcakt79B5O7DAqtKrua1kLDgpn
 GRQ13+OiY/AiJBh+sYFu84UhUXR652h7SkK3p1uirNFT4Zeh+mNyWp8FY1yT6f5ADJ
 Fq2OXWc2/7B0ZkRvAQQFFBWZzZEfI9e/008LezWBg/9swbH3+Z5smh6BdJU1Ijao4Z
 XB1n1AYOe8uVA==
Message-ID: <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
Date: Wed, 21 Aug 2024 23:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
References: <20240821212218.2092540-1-admin@hifiphile.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240821212218.2092540-1-admin@hifiphile.com>
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

On 8/21/24 11:22 PM, Zixun LI wrote:
> usb_gadget_register_driver() called by probe will initialize the USB
> controller which enters ready to connect state with pull-up resistor
> enabled.
> 
>>From the host's point of view, a device is ready to be enumerated.
> However, since dm_usb_gadget_handle_interrupts() is only called when
> ethernet function is started, at this stage USB events are not managed,
> host's enumeration attempts will fail and resulting error like:
>      usb 1-1: new high-speed USB device number 50 using xhci_hcd
>      usb 1-1: device descriptor read/64, error -110
>      usb 1-1: device descriptor read/64, error -110
>      usb usb1-port1: attempt power cycle
> 
> Disable USB pullup to prevent unwanted enumeration attempt.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>   drivers/usb/gadget/ether.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
> index 7973927e8a..c864beeaa7 100644
> --- a/drivers/usb/gadget/ether.c
> +++ b/drivers/usb/gadget/ether.c
> @@ -2459,6 +2459,8 @@ static int usb_eth_probe(struct udevice *dev)
>   {
>   	struct ether_priv *priv = dev_get_priv(dev);
>   	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eth_dev *ethdev = &priv->ethdev;
> +	int ret;
> 
>   	priv->netdev = dev;
>   	l_priv = priv;
> @@ -2499,7 +2501,14 @@ static int usb_eth_probe(struct udevice *dev)
>   	priv->eth_driver.disconnect	= eth_disconnect;
>   	priv->eth_driver.suspend	= eth_suspend;
>   	priv->eth_driver.resume		= eth_resume;
> -	return usb_gadget_register_driver(&priv->eth_driver);
> +
> +	ret = usb_gadget_register_driver(&priv->eth_driver);

Wouldn't it be better if usb_gadget_register_driver() started in 
disconnected state right away ?
