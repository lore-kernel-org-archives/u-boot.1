Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAB6C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 02:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA8AD88433;
	Wed,  8 May 2024 04:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715133764;
	bh=D5F0AtmhEKLCh9xMXcLfiRD4aNrKtL9aKvuVfnXMtME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZE3CZeBWz0Wx3XMb+cnU4B9LWSE0brormSZaadx0phv2vNhH9fDgBgAK7DtL2ycCF
	 nrkeFQvMsQ48dgjVxOz/PQg4G3m+LnEXl1Y3Vv47Sd0Us+PpKhs8L2/W9DP13xYziA
	 M7MnR5nO2T/bqt2LgEDSe2hIYLRPukk59I4HDxbUyrTTLEbLZXILTbL0mDpfiBMAfq
	 8vpdt3gs6HdtOnhiWmDzu1LFpsO4rgpwAxBIU4GPAXRKioMzhphwSVQBUO2QQszDFb
	 OwUIo00VYNNdcEMPjBxtcLCQxoPwZOv2mTPKnQYR0naA7S5BzXMrcmYqtkOnXIFjg0
	 kwRhdEG84Fvgg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CA47D882C8;
 Wed,  8 May 2024 04:02:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715133763;
 bh=D5F0AtmhEKLCh9xMXcLfiRD4aNrKtL9aKvuVfnXMtME=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=koVJ3qYRFsegLcQD56lmvgfIY9xceXWj57+MADoBX1qnKXYyQyqj6qD8Lec7mmN4Y
 JKyL4XE3M0mFD3SGvHL3L1diISeHiCZbKfZFlLAJ3FFUE4zF+fhBQvfPaxSkyuKako
 Jlg7SQa/0SCbm3yILmRlOLVKUtY55tK9VxlSPXCnyWdA6+eOKIhQQkfJzmKH/iyRUB
 Fef+ZKtmi/hbqMDK1U2T8p7sTZji8968hlhmN9kyP06Jzwze+r323T01yke6ouoRcW
 2xJJBNwhAhxQQUxyJgGKeQCtjVu2CjSiNkwXU9cbO72L0ddQYObjLKVwCPEiEPOVKo
 7BbNdgMMwqN8w==
Message-ID: <7ec6dc4c-f729-440a-86fa-43504cd5f478@denx.de>
Date: Wed, 8 May 2024 03:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] phy: starfive: Add Starfive JH7110 USB 2.0 PHY
 driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <20240504150358.19600-3-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240504150358.19600-3-minda.chen@starfivetech.com>
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

On 5/4/24 5:03 PM, Minda Chen wrote:

[...]

> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> new file mode 100644
> index 0000000000..a405a75e34
> --- /dev/null
> +++ b/drivers/phy/starfive/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2023 Starfive

2024 instead of 2023, please fix globally.

> +#
> +
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_USB2)	+= phy-jh7110-usb2.o
> diff --git a/drivers/phy/starfive/phy-jh7110-usb2.c b/drivers/phy/starfive/phy-jh7110-usb2.c
> new file mode 100644
> index 0000000000..ffbd96d721
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-usb2.c

[...]

> +static void usb2_set_ls_keepalive(struct jh7110_usb2_phy *phy, bool set)
> +{
> +	unsigned int val;
> +
> +	/* Host mode enable the LS speed keep-alive signal */
> +	val = readl(phy->regs + USB_LS_KEEPALIVE_OFF);
> +	if (set)
> +		val |= USB_LS_KEEPALIVE_ENABLE;
> +	else
> +		val &= ~USB_LS_KEEPALIVE_ENABLE;
> +
> +	writel(val, phy->regs + USB_LS_KEEPALIVE_OFF);

This is clrsetbits_le32(), use it.

> +}
> +
> +static int usb2_phy_set_mode(struct phy *_phy,
> +			     enum phy_mode mode, int submode)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_DEVICE:
> +	case PHY_MODE_USB_OTG:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (mode != phy->mode) {

Reduce indent this way:

if (mode == phy->mode)
   return 0;

... do mode switch stuff ...
return 0;

> +		dev_dbg(dev, "Changing phy to %d\n", mode);
> +		phy->mode = mode;
> +		usb2_set_ls_keepalive(phy, (mode != PHY_MODE_USB_DEVICE));
> +	}
> +
> +	return 0;
> +}
> +
> +static int jh7110_usb2_phy_init(struct phy *_phy)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(phy->app_125m);

return clk_prepare_...(); is just fine

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int jh7110_usb2_phy_exit(struct phy *_phy)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +
> +	clk_disable_unprepare(phy->app_125m);
> +
> +	return 0;
> +}
> +
> +struct phy_ops jh7110_usb2_phy_ops = {
> +	.init     = jh7110_usb2_phy_init,
> +	.exit     = jh7110_usb2_phy_exit,
> +	.set_mode = usb2_phy_set_mode,
> +};
> +
> +int jh7110_usb2_phy_probe(struct udevice *dev)
> +{
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +
> +	phy->regs = dev_read_addr_ptr(dev);
> +

Drop extra newline.

> +	if (!phy->regs)
> +		return -EINVAL;

[...]
