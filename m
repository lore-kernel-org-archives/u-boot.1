Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10D7C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 17:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CD48863E;
	Sat, 13 Jul 2024 19:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720893381;
	bh=O7yvsCcBjgIp/Qhz/U31iCoNuTVHXEsrZTagNj1Zf9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+UclrBqhBfNeiEhDKjd8t4kbr5wzq8WEVv62pugRMbKyVngow6rXnsYLoxnbfwCy
	 tIC+oUlKswafYThl8m9vmYaHhEekk5GeFLEVOhrGy2d89637dYc9uY2VQOxT8QET1T
	 m/iAuudrcbpYS8T7VU5AiRPzkLyun5tnVKxTOAXNXb6z6D21/UZhpUbRu6W+lVXaHE
	 jpjGjG5n7a7m6kuSt1smm0bNU97Zk6sypVa/UvQjY+H/F+AkrzlWUUCi3cklzpxpjk
	 BjadDJxExNkB8YRd6dsp7CbvJADNaM/6qZibY0D/4MY1He3i0esFKn0jm7BZ5a7iPY
	 4xnv7DWmYmdsA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0BCA1884C3;
 Sat, 13 Jul 2024 19:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720893380;
 bh=O7yvsCcBjgIp/Qhz/U31iCoNuTVHXEsrZTagNj1Zf9w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eZI2rmUivX1azQvJu/Vx86Aug3yX2GA0a0HXocedAFBd5jvRsYNadCNWBRiQ/Wc0A
 M8hDz9Ufxjcp9tlfG8Xv9/t+aFpVDSfRHJx309cyHOjKwbhSdWmrkMC+Ih38pLLhhi
 M2Yug1930T8w6kpTPsnTGIWgaq3WAK+WiKqy7tQaZjQVOkYOv6kS+OO2j+Ht4mkoY/
 Qz/VcM2f6AmkVR6L280XwO+MzT2+LTNIl35cWYsNyuHkbDxpNebxdkiL7WEMzEVKVr
 wnhyYHq+tc4Btd7AhbiTItFl7aSGN9rR9Tz0bi6eSJulHPUqTvnV3JPvQgxmWgq/kS
 0oqaNLCeKq5oA==
Message-ID: <9bc4c8f5-e551-4252-ac7c-3cbae634e40a@denx.de>
Date: Sat, 13 Jul 2024 17:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 5/5] net: dwc_eth_qos: Add glue driver for Intel
 MAC
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com,
 philipp.tomsich@vrull.eu, rfried.dev@gmail.com, seanga2@gmail.com,
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com,
 sjg@chromium.org, sumit.garg@linaro.org, trini@konsulko.com,
 xypron.glpk@gmx.de
References: <20240624083450.90297-1-pro@denx.de>
 <20240624083450.90297-6-pro@denx.de>
 <fe77cc22-a256-49ce-b03a-55d9bad5103b@denx.de> <ZpEt9H08z9d9RNZk@eryximachos>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZpEt9H08z9d9RNZk@eryximachos>
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

On 7/12/24 3:21 PM, Philip Oberfichtner wrote:
> Hi Marek,

Hi,

>>> +static int __serdes_powerup(struct udevice *dev)
>>> +{
>>> +	/* Based on linux/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c */
>>> +
>>> +	const unsigned char phyad = INTEL_MGBE_ADHOC_ADDR;
>>> +	struct eqos_priv *eqos = dev_get_priv(dev);
>>> +	unsigned short data;
>>> +	int ret;
>>> +	bool is_pse;
>>> +
>>> +	/* Set the serdes rate and the PCLK rate */
>>> +	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
>>> +
>>> +	data &= ~SERDES_RATE_MASK;
>>> +	data &= ~SERDES_PCLK_MASK;
>>> +
>>> +	if (__serdes_link_mode_2500(dev))
>>> +		data |= SERDES_RATE_PCIE_GEN2 << SERDES_RATE_PCIE_SHIFT |
>>> +			SERDES_PCLK_37p5MHZ << SERDES_PCLK_SHIFT;
>>> +	else
>>> +		data |= SERDES_RATE_PCIE_GEN1 << SERDES_RATE_PCIE_SHIFT |
>>> +			SERDES_PCLK_70MHZ << SERDES_PCLK_SHIFT;
>>> +
>>> +	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
>>> +
>>> +	/* assert clk_req */
>>> +	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
>>> +	data |= SERDES_PLL_CLK;
>>> +	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
>>
>> Could this use phy_modify() ?
>>
> 
> 
> I do agree using the phy_read()-API all over the place would be nice.
> But I currently cannot do so, as I do not have a struct phy_device.
> I am not accessing an actual PHY here, but a MAC-internal submodule.

Oh ok, then miiphy_write() is fine. Thanks for clarifying.
