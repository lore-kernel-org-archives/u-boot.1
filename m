Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A01C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5121A88049;
	Wed, 21 Feb 2024 11:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708512189;
	bh=NOa/N9lSi8sR7m/gPx0SUaIiaYAVgp45nOfbT1tnVJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WI4V7SWgJ5W+j7XoXDhkvEjq8oItt94YcCQsKBQS3HviWApNRF3InUciuWQuWVvYe
	 E6CfYjmU1QPSDodApXl6yvkO70tm3DyHPKrPdQoQ8isWPrmPLZ3o5Orw1XFHQKi+pG
	 n2DswRphVTcjtaYiop2xhYKtf/LVbfuTk03xhWv2tRnswEa+SKZf7XqwZVAGM5JyOi
	 oCEws7OZo7ftCyiboN8ZYxuoxLLuWJ27EuKeyUM/DcQSI0bCJxlp3kDPmKo8STbH0H
	 DMUFEVYpcB86UALcA9I11P21Cibu8v7PVXUFx2o5DL0IVhS+VcBir5DYyxDACJ3PuK
	 aN5DB56lnKHpA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A75B88806D;
 Wed, 21 Feb 2024 11:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708512054;
 bh=NOa/N9lSi8sR7m/gPx0SUaIiaYAVgp45nOfbT1tnVJ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nQy7k0upK6XPPM1zd0rCQpHOyD8mdWTaDwr1FsPRj6jjg+FvXGXqoiXs6UPIJK4SD
 FQJ5yEcimfF9v1zivnmyREiDN+RceCh1APY8hJlTxvTkK2MygO3HkyjTsed9odcDlM
 ExVnMq1MO6EgTxNHxJlWf3p6n7QLFDnWrW7TWQEyp2P86mNc6UMAwRuWX/CzfEn/NY
 O9gpmm3qlQI3gg6x180XjsO/mDkVNHjWjLwHV1d+boR/NzHv9Q9KDWFpE0ORLbPCKp
 +Ev0ngSuae5wTZxiYld9Zlh6B3+3fUFD800ot+MmBv8c+bNqOKzrvzskuoqp41UTsq
 ulba9UC275kOQ==
Message-ID: <f4013fee-be33-4f14-8aea-9d1d64a81695@denx.de>
Date: Wed, 21 Feb 2024 10:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] imx8mp: power-domain: Expose high performance PLL
 clock
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-5-sumit.garg@linaro.org>
 <947bbd39-451b-4ce0-86dc-47d95db2885d@denx.de>
 <CAFA6WYPzNoZBxpX-ywwHsycX1jjKP7s4Kx_y7F8CnnZnr3nT3Q@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYPzNoZBxpX-ywwHsycX1jjKP7s4Kx_y7F8CnnZnr3nT3Q@mail.gmail.com>
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

On 2/21/24 07:14, Sumit Garg wrote:
> On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/20/24 14:10, Sumit Garg wrote:
>>> PCIe PHY can use it when there is no external refclock provided.
>>
>> Commit message needs to be fixed.
> 
> How about the following?
> 
>      Expose high performance PLL clock, so the PCIe PHY can
>      use it when there is no external refclock provided.

If this code is imported from Linux
2cbee26e5d59 ("soc: imx: imx8mp-blk-ctrl: expose high performance PLL 
clock")
then just include that reference too .

[...]

>>> @@ -69,16 +127,23 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>>>        if (ret)
>>>                goto err_clk_pcie;
>>>
>>> -     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
>>> +     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
>>>                setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
>>> -     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
>>> +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
>>>                setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
>>> -     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
>>> +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
>>>                setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
>>>                                                    PCIE_PHY_INIT_RST);
>>>
>>> +             ret = hsio_pll_enable(dev);
>>
>> Is this how Linux handles this PLL ?
>>
>> Seems like this should be either syscon or clock driver .
> 
> It isn't similar to what Linux does but I can't find suitable
> infrastructure in U-Boot to expose it as a regular clock. Are there
> any APIs available similar to devm_of_clk_add_hw_provider() in Linux?

Have a look at the very end of:

drivers/clk/renesas/clk-rcar-gen3.c

that registers clock and reset drivers for the same IP at the same 
address. In this case, you would register power domain and clock drivers 
instead .
