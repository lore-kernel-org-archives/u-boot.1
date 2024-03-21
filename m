Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766CDC6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678CF88139;
	Thu, 21 Mar 2024 20:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711048639;
	bh=TyhUO2P1ZqkpLD12V5i7NHwR+Xq79ClMmlHkTxhCN6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u4qQY28bxlhJ5TNvQ0LDWngsBy6oZxZ0wH5WYGb6/mktgNLrpco7/a0w31sDdOHIE
	 F28JcCjMBSnRtdbH0zV22pVLGzsn2Udx1g6bWVSoTPhwLnNhJ/QmIPz6PPDGAp0nz2
	 H1wAsmvwlPtWwyl7SczmyMRmdg4iuNr0P5x1WbcEA/C57a150gbO7vU8GAT6X5HmEv
	 X6nl5fMqVYhMscLf8zOlF4OMXtVS7m8zzQQnRZPTN6d57dzLAbN3r59f5Wg64qzp0h
	 NCp8hB/5f5LJsA5WytgXZ7twF1Cie/QJqLJWHcIbevj//4RmD8XEo9NERvpbxiPqTi
	 I8oQ4uzyL/pRA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C602D88120;
 Thu, 21 Mar 2024 20:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711048637;
 bh=TyhUO2P1ZqkpLD12V5i7NHwR+Xq79ClMmlHkTxhCN6s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JsFdO86PmvWxdueGexjTf7UZxatbbCq3Pwv4Y/auciHYtGI6x9eJxn6Rdy1ww+t/h
 kBpZsLPienVueQXAsyclY8/GKNc30cyTUbz1DXG6EwIuAAm2SBallGGCdV8f0y8Nxt
 jQQpQPIEIC16bPjc0XWzJcJrFrI0D/XxJl4yM5JIehBavOXMBmEn6dn7uNjh75Pdsl
 MCH0PNeEIewagM987s+Q5NMVaVjtiusW7/PBsPklxxgMX6mm3w6pAia0/lU/Ha2d+j
 sUgX92I69JzTpZOrreAtaJbd2BMKCuPH7cHnZVcFEZOEE4T20JuyJm92Cwg2R8uOo2
 LyA33IMFGicdg==
Message-ID: <f29a07bc-9f9b-466f-bc69-f5cf67e949d5@denx.de>
Date: Thu, 21 Mar 2024 17:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com,
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org,
 festevam@denx.de, andrejs.cainikovs@toradex.com, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-8-sumit.garg@linaro.org>
 <48de4f52-aa8a-414a-9094-ccfee70d55f8@denx.de>
 <CAFA6WYNM_Fg=F3k5fR7Be-xmy1pkcVxhU2sAbe0z4WMqV_8TDA@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYNM_Fg=F3k5fR7Be-xmy1pkcVxhU2sAbe0z4WMqV_8TDA@mail.gmail.com>
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

On 3/21/24 1:40 PM, Sumit Garg wrote:
> On Thu, 14 Mar 2024 at 09:46, Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/12/24 8:03 AM, Sumit Garg wrote:
>>> Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
>>> PHY initialization moved to this standalone PHY driver.
>>>
>>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
>>> drivers/phy/freescale/phy-fsl-imx8m-pcie.c. Use last Linux kernel driver
>>> reference commit 7559e7572c03 ("phy: Explicitly include correct DT
>>> includes").
>>
>> [...]
>>
>>> +static int imx8_pcie_phy_probe(struct udevice *dev)
>>> +{
>>> +     struct imx8_pcie_phy *imx8_phy = dev_get_priv(dev);
>>> +     ofnode gpr;
>>> +     int ret = 0;
>>> +
>>> +     imx8_phy->drvdata = (void *)dev_get_driver_data(dev);
>>> +     imx8_phy->base = dev_read_addr(dev);
>>> +     if (!imx8_phy->base)
>>> +             return -EINVAL;
>>> +
>>> +     /* get PHY refclk pad mode */
>>> +     dev_read_u32(dev, "fsl,refclk-pad-mode", &imx8_phy->refclk_pad_mode);
>>> +
>>> +     imx8_phy->tx_deemph_gen1 = dev_read_u32_default(dev,
>>> +                                                     "fsl,tx-deemph-gen1",
>>> +                                                     0);
>>> +     imx8_phy->tx_deemph_gen2 = dev_read_u32_default(dev,
>>> +                                                     "fsl,tx-deemph-gen2",
>>> +                                                     0);
>>> +     imx8_phy->clkreq_unused = dev_read_bool(dev, "fsl,clkreq-unsupported");
>>> +
>>> +     /* Grab GPR config register range */
>>> +     gpr = ofnode_by_compatible(ofnode_null(), imx8_phy->drvdata->gpr);
>>> +     if (ofnode_equal(gpr, ofnode_null())) {
>>> +             dev_err(dev, "unable to find GPR node\n");
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     imx8_phy->iomuxc_gpr = syscon_node_to_regmap(gpr);
>>> +     if (IS_ERR(imx8_phy->iomuxc_gpr)) {
>>> +             dev_err(dev, "unable to find iomuxc registers\n");
>>> +             return PTR_ERR(imx8_phy->iomuxc_gpr);
>>> +     }
>>
>> syscon_regmap_lookup_by_compatible() should simplify these two steps ^ .
>>
> 
> After a close look, that API isn't supported by U-Boot yet. So I will
> keep the existing implementation with your review tag. I hope that's
> fine with you.

Oh, uh, I had a local patch from previous round of PCIe experiments, I 
just sent it out, you are on CC. Can you do a follow up fix once this 
series V4 is in ?
