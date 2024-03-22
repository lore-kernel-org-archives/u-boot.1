Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DB5C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 16:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3BCB88013;
	Fri, 22 Mar 2024 17:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711125055;
	bh=gLgVNfkCtROXIkiymN/hse1gNEmhJ4lGmBDc463+Gmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYGlGTizLsDwfYhKJhlEvbAgRnay28QmemPdTMYKkwGM+ss7Xz/HSd6XCJyw9MrKy
	 eQTeVVwJ5WyX5JGwHq4nVBKER/LLcWkVjI6raco9DgqOg2GYWr5wfhN8VOSy1b7ZOd
	 LvKWlbeFVN2fx3GHbu3sNwNMs6TaRKgPNNNJlTcwJ2fpChLH2nX2J6KakXsK4DhMa3
	 EM3wHEtHSkfHJysAxPjA6FlTCFSteNN0ibvZiCZmw3ah6MblBuyZ4fpQqN4/NmSgon
	 c3VZZYp541p01f2JAjOOgj+MOK/P+cxZSMK3gMmOzwpzUu5EUFr4dKe+nBrP3W4yT3
	 L6O/Wok7MAymg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B39CE87BE0;
 Fri, 22 Mar 2024 17:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711125053;
 bh=gLgVNfkCtROXIkiymN/hse1gNEmhJ4lGmBDc463+Gmk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jcI5mCi8CYkaqSLngB6u+s+cDN5Oas2r+uVp1iGHKQ2ekFnGWAh+HBG8wM2EbmJjP
 p5BGuY7nxMetNhfTIFWz7AHTtFKIg+C5HFMvo8xJ0frvF3z4rHhEzuGKaW50hTcV00
 5hbdMtafh0AaXENKFLBlsf2V2RbYjl9MkfXJ+2Na4SGVtW2JeKfy6Wrn+Sk9RTA3zH
 TauytWM8TV5GPNmTVKDivlMUDexforMN8lXraRrrahqpHyW7bWTLpAXzAld5p0Ul5B
 TwiDeSGBP1z0LgOQAmxd7e62Q8MB3+L+r2STC6+C0eqVIrsELbiglSN/KDbXvkKxx6
 5U3b8PV6Ir0PQ==
Message-ID: <7238a792-8096-411a-854e-c40fdfaeaede@denx.de>
Date: Fri, 22 Mar 2024 17:30:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
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
 <f29a07bc-9f9b-466f-bc69-f5cf67e949d5@denx.de>
 <CAFA6WYPGi9CCbAOsidqLiNiR4Rtv07cx6A0bfkwWkWxz=FeR4Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYPGi9CCbAOsidqLiNiR4Rtv07cx6A0bfkwWkWxz=FeR4Q@mail.gmail.com>
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

On 3/22/24 5:36 AM, Sumit Garg wrote:
> On Fri, 22 Mar 2024 at 00:47, Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/21/24 1:40 PM, Sumit Garg wrote:
>>> On Thu, 14 Mar 2024 at 09:46, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 3/12/24 8:03 AM, Sumit Garg wrote:
>>>>> Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
>>>>> PHY initialization moved to this standalone PHY driver.
>>>>>
>>>>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
>>>>> drivers/phy/freescale/phy-fsl-imx8m-pcie.c. Use last Linux kernel driver
>>>>> reference commit 7559e7572c03 ("phy: Explicitly include correct DT
>>>>> includes").
>>>>
>>>> [...]
>>>>
>>>>> +static int imx8_pcie_phy_probe(struct udevice *dev)
>>>>> +{
>>>>> +     struct imx8_pcie_phy *imx8_phy = dev_get_priv(dev);
>>>>> +     ofnode gpr;
>>>>> +     int ret = 0;
>>>>> +
>>>>> +     imx8_phy->drvdata = (void *)dev_get_driver_data(dev);
>>>>> +     imx8_phy->base = dev_read_addr(dev);
>>>>> +     if (!imx8_phy->base)
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     /* get PHY refclk pad mode */
>>>>> +     dev_read_u32(dev, "fsl,refclk-pad-mode", &imx8_phy->refclk_pad_mode);
>>>>> +
>>>>> +     imx8_phy->tx_deemph_gen1 = dev_read_u32_default(dev,
>>>>> +                                                     "fsl,tx-deemph-gen1",
>>>>> +                                                     0);
>>>>> +     imx8_phy->tx_deemph_gen2 = dev_read_u32_default(dev,
>>>>> +                                                     "fsl,tx-deemph-gen2",
>>>>> +                                                     0);
>>>>> +     imx8_phy->clkreq_unused = dev_read_bool(dev, "fsl,clkreq-unsupported");
>>>>> +
>>>>> +     /* Grab GPR config register range */
>>>>> +     gpr = ofnode_by_compatible(ofnode_null(), imx8_phy->drvdata->gpr);
>>>>> +     if (ofnode_equal(gpr, ofnode_null())) {
>>>>> +             dev_err(dev, "unable to find GPR node\n");
>>>>> +             return -ENODEV;
>>>>> +     }
>>>>> +
>>>>> +     imx8_phy->iomuxc_gpr = syscon_node_to_regmap(gpr);
>>>>> +     if (IS_ERR(imx8_phy->iomuxc_gpr)) {
>>>>> +             dev_err(dev, "unable to find iomuxc registers\n");
>>>>> +             return PTR_ERR(imx8_phy->iomuxc_gpr);
>>>>> +     }
>>>>
>>>> syscon_regmap_lookup_by_compatible() should simplify these two steps ^ .
>>>>
>>>
>>> After a close look, that API isn't supported by U-Boot yet. So I will
>>> keep the existing implementation with your review tag. I hope that's
>>> fine with you.
>>
>> Oh, uh, I had a local patch from previous round of PCIe experiments, I
>> just sent it out, you are on CC. Can you do a follow up fix once this
>> series V4 is in ?
> 
> Sure I can do that as a followup once your patch is merged.

Follow up, yes please. Let's not stuff this series with more stuff 
anymore, so it can go in.
