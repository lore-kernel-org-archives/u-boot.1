Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BEDC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2293880CA;
	Wed, 21 Feb 2024 11:42:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708512180;
	bh=5c8N9o5zQIoGB5Fi50pyxFC7wDIX3ug53/uiTRPLn08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQzAX2nnBOyAz9MnlvMESMvNCeeIChglDhce42MslXC1qjn7Y3fv2a1HIegVun1tU
	 mcCx82biYA58EfdojKzJmWPFA7SwNf8dzZ1Z54t7QMq6QaK2PDlW5DhT6IYB8R3aBg
	 DBsOczNBh2TjCv46W0VvOo6qg62371VAIDiTAxQ1gFGXut7B1A0qme0K8kyWwuPrMK
	 V9J/YvPDQuG4CXjABdZn3WyY2jze/4ziE5yk5mIPu1grz15jl1Eis0qyqPT5TcAFUS
	 2befQ1bZYwiLTDl2cuKwb1W3xm48ByI+mcUBlqbmyPtcV2gUbw09figcMlTSv3PQLU
	 7G0O9xrzJHfbA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3622587E30;
 Wed, 21 Feb 2024 11:40:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708512038;
 bh=5c8N9o5zQIoGB5Fi50pyxFC7wDIX3ug53/uiTRPLn08=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mNFzLDULEdld3SliesPYsnNB5gIkbe19M32Eey79NYvkF6Xpugeu5CQ0b3RzHSfqs
 VpUOUgM5dyQbdr992NnW6xAefVzoyvvwhXTvtuXF5ST4vyTGr/vdPmT+bhnc4+x06f
 1bZ/TBaGgW7Vnt7If1bUtpRTIBlxAw0ayG+bjhtjHnN0D5f95xsuD61MXsdwK7RdXS
 fwATUrrpdFHkTLSHALU4PILHdW6DIO97b4+PivAd8m+ihct8q2m0NPcEfNr/DWc4/T
 o4WD6WkLbnQbkmgQOCPUsuXbSsRylGPffaR2laP6FqHR8MK1srdT+CxGo+M50KlFOP
 mEU5bQQl9nS4A==
Message-ID: <6ad07fa9-0f48-49cb-8760-7b48a3314771@denx.de>
Date: Wed, 21 Feb 2024 10:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] imx8mp: power-domain: Add PCIe support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-4-sumit.garg@linaro.org>
 <d3bd5acf-ad1e-4a99-b7fc-84fbddf33880@denx.de>
 <CAFA6WYP8ks2hsjUSq51T1E7k7bkyDi+AvYeGJu=maNMJgqrQVA@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYP8ks2hsjUSq51T1E7k7bkyDi+AvYeGJu=maNMJgqrQVA@mail.gmail.com>
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

On 2/21/24 07:01, Sumit Garg wrote:
> On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/20/24 14:10, Sumit Garg wrote:
>>> Pre-requisite to enable PCIe support on iMX8MP SoC.
>>
>> This commit message is useless, write a proper one.
>>
> 
> How about the following?
> 
>      Add support for GPCv2 power domains and clock handling
>      for PCIe and PCIe PHY. It is required to enable PCIe support
>      on the iMX8MP SoC.

The second sentence is redundant.

>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>> ---
>>>    drivers/power/domain/imx8mp-hsiomix.c | 50 +++++++++++++++++++++++++--
>>>    1 file changed, 48 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
>>> index e2d772c5ec7..62145e0261b 100644
>>> --- a/drivers/power/domain/imx8mp-hsiomix.c
>>> +++ b/drivers/power/domain/imx8mp-hsiomix.c
>>> @@ -16,14 +16,19 @@
>>>    #define GPR_REG0            0x0
>>>    #define  PCIE_CLOCK_MODULE_EN       BIT(0)
>>>    #define  USB_CLOCK_MODULE_EN        BIT(1)
>>> +#define  PCIE_PHY_APB_RST    BIT(4)
>>> +#define  PCIE_PHY_INIT_RST   BIT(5)
>>>
>>>    struct imx8mp_hsiomix_priv {
>>>        void __iomem *base;
>>>        struct clk clk_usb;
>>> +     struct clk clk_pcie;
>>>        struct power_domain pd_bus;
>>>        struct power_domain pd_usb;
>>> +     struct power_domain pd_pcie;
>>>        struct power_domain pd_usb_phy1;
>>>        struct power_domain pd_usb_phy2;
>>> +     struct power_domain pd_pcie_phy;
>>>    };
>>>
>>>    static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>>> @@ -43,6 +48,10 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>>>                domain = &priv->pd_usb_phy1;
>>>        } else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2) {
>>>                domain = &priv->pd_usb_phy2;
>>> +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
>>> +             domain = &priv->pd_pcie;
>>> +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
>>> +             domain = &priv->pd_pcie_phy;
>>>        } else {
>>>                ret = -EINVAL;
>>>                goto err_pd;
>>> @@ -54,14 +63,25 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>>>
>>>        ret = clk_enable(&priv->clk_usb);
>>>        if (ret)
>>> -             goto err_clk;
>>> +             goto err_clk_usb;
>>> +
>>> +     ret = clk_enable(&priv->clk_pcie);
>>> +     if (ret)
>>> +             goto err_clk_pcie;
>>
>> Does this mean that when USB power domains get enabled, PCIe clock are
>> also enabled ? Why ?
>>
>> What if the PCIe clock enable fails, do USB clock remain enabled ?
> 
> Let me gate them behind corresponding power domain IDs.
> 
>>
>>>        if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
>>>                setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
>>> +     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
>>> +             setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
>>> +     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
>>> +             setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
>>> +                                                 PCIE_PHY_INIT_RST);
>>
>> Shouldn't the reset bits be cleared here ?
>>
> 
> Although I can't find their reference in the TRM, as per Linux commit
> [1], setting the reset bit is actually deassertion of PCIe PHY reset.
> You can think of it like an active low signal.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5506018d3dec41e6678efb92b836586e9ee1d628

Please add this ^ comment into the code.
