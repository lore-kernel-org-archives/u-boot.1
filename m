Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970D6C25B4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 02:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288A388440;
	Wed,  8 May 2024 04:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715133766;
	bh=viNhSCoHnGvhXldNBtydA8C9tPEEHEiLIZaW8gNFM/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZRwnTyUgdurnP5Z+STLHy1NaMGeS8goS2tfcbNXNNOoMvGQNE1izZvzQftrnJMA5X
	 w1ONkpsHxrbED3CWMp5nRhr2oWd2003CVe+rIC31ScLxKX5n7JfpvaBshO9kFzQrau
	 N56Xue8ENuYRzkc1iNaLX9F1TsQsILA83lB+YkPNkNjJgMic+rGvHC5M1lbHRI6UJZ
	 fIAG6Y5jZCkVyeoUwPdyCUivxh2HgrgmkL/0ILOVGaZBDJOIoAXQc99P9OXHWRvtJV
	 mHKi+W5vwyvf0zwyRUGw5rbpXFsfklC6M/jpsKBHp9lCR96NbalzVhKNHg/XqhibQx
	 xvNL5a8I4hV7A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D6DCF8842E;
 Wed,  8 May 2024 04:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715133764;
 bh=viNhSCoHnGvhXldNBtydA8C9tPEEHEiLIZaW8gNFM/w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rcjkmRdhcxLAC6aaXxDN293juOx9vsg5ynAmuqUFyedgjPOieoCRBogkpsguYqUw7
 waGoLRHjbTFwxvhX8Hq9l2EPWngAR9AAaA3UZXg2SNyY42PO5+7fiP0jZD4hmrlMRk
 hvU1Z1yAsXiFjhYQe7zBsxrTqgYy0haq+Y9Vwsib2ne1rcEsbvI9WCLCI9x+OsyFv8
 7YRBgCUbb5ba3t45NqT182HFpdUiqTlkcnjHUeIBa5qbitb4WjWYsccmrcDXOuMhGk
 ydpGZGf1nAMIW5ZTPjAXAgOZDDqakYgwf09PlQ5qIq70+8BiYI3skmm9yHw1qEYZBU
 T5akj9s1aL3hQ==
Message-ID: <761a57cc-1074-4167-9eaa-2bdb6fe88799@denx.de>
Date: Wed, 8 May 2024 03:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY
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
 <20240504150358.19600-4-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240504150358.19600-4-minda.chen@starfivetech.com>
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

Fix up the copyrights to year 2024 globally please.

[...]

> +static int phy_usb3_mode_set(struct jh7110_pcie_phy *data)
> +{

Can this phy_usb3_mode_set and phy_pcie_mode_set be unified into single 
function with parameter to select usb3/pcie mode instead ?

> +	if (!data->stg_syscon || !data->sys_syscon) {
> +		dev_err(data->phy->dev, "doesn't support usb3 mode\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
> +			   PCIE_PHY_MODE_MASK, PCIE_PHY_MODE);
> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
> +			   PCIE_USB3_BUS_WIDTH_MASK, 0);
> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
> +			   PCIE_USB3_PHY_ENABLE, PCIE_USB3_PHY_ENABLE);
> +
> +	/* Connect usb 3.0 phy mode */
> +	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
> +			   USB_PDRSTN_SPLIT, 0);
> +
> +	/* Configuare spread-spectrum mode: down-spread-spectrum */
> +	writel(PCIE_USB3_PHY_ENABLE, data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
> +
> +	return 0;
> +}

[...]

> +int jh7110_pcie_phy_probe(struct udevice *dev)
> +{
> +	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
> +	int rc;
> +
> +	phy->regs = dev_read_addr_ptr(dev);
> +

Drop extra newline here.

> +	if (!phy->regs)
> +		return -EINVAL;

[...]
