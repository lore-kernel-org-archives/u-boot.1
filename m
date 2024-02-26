Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D79C54E41
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 14:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E949887ED7;
	Mon, 26 Feb 2024 15:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708957243;
	bh=CJg3yh9q2v9UCslSSDUhI1dNGFYOcL2WDxDyFV2au+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErTRZQOwearJyZFGFCqw40c9kQhr1Oo3EIMMTIvrLzJsRHr/z+LGzPO67yZQ9xJKd
	 mL/YWLGyy76wpJ86FxB9JDP7sJtlLLBVhTUYBlb0MdFHWBmdi6CTiVeIBA/Owj2Jlv
	 eIHptyBi5pPRIpS5cCFsqzvIzQOk1tiiOE3OiPRJY+WQMfNzsf97fy4iqu8kgUV4JH
	 Je0TJnfaK+cRIocnyjM6rZMfC3xOVZ0aplxJg2Xqtua1L4R0R2PbHPiJpMAzFDYQKV
	 Db8X7icCP7wewH469btkz7kRzLQ4DR5Lqx86rs8ptqowhQXU0dza7bCk8mN8JyTPDk
	 6mveM5QEl6IFQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4938787E40;
 Mon, 26 Feb 2024 15:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708957242;
 bh=CJg3yh9q2v9UCslSSDUhI1dNGFYOcL2WDxDyFV2au+M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ir+3pBrPFv2G3JfK2u8/UfTtTsMRaWvO2RMXsEhdAdAyJyD7xBuSqNWyjgWpo1AwP
 uJaAjNJEaOiT/mwjpOFfFx8L/SIY7kj2h1fVFrHwJ6jms6PPqBZGPk8JTCjYCtJ68l
 kOveZAD6yjIrf2PC0727ftZjBdtUfR+vAr0/+2nSB7+8kjdq2xZR7JrcpnZY/MTxZ8
 ww/dWbysDLcNwzfLNlp1fwggFYF3jzhd7LZSXcrh00xxyXSigUtY7H3XiVeHlAJXnb
 TY0YTGt6zxvuQ9Lwdpak25cs+O9Ivc1WIuHW1m6rB6fgPHBbaOG525AF5G4buQq/Sf
 tSfaPJ4oMng6Q==
Message-ID: <a50ec92a-29ce-47d5-8827-dcabd300d71d@denx.de>
Date: Mon, 26 Feb 2024 15:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] imx8mp: power-domain: Expose high performance PLL
 clock
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, festevam@denx.de, andrejs.cainikovs@toradex.com,
 sjg@chromium.org, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-5-sumit.garg@linaro.org>
 <8c36eac1-2b6b-4810-b4c9-1b8912bfe81e@denx.de>
 <CAFA6WYO2n-QG7TvSnKyk5O0Pzwcn0jd4iCeLbebbsVZiOq2fdQ@mail.gmail.com>
 <6aee8c88-f333-4dcc-aba2-cb37d60b5697@denx.de>
 <CAFA6WYN6_QL-NHHNSSCQF8+HQppK8=qwpEjmOvGpiTfjTR+cHg@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYN6_QL-NHHNSSCQF8+HQppK8=qwpEjmOvGpiTfjTR+cHg@mail.gmail.com>
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

On 2/26/24 2:43 PM, Sumit Garg wrote:
> On Mon, 26 Feb 2024 at 18:31, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/26/24 1:39 PM, Sumit Garg wrote:
>>> On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 2/26/24 9:04 AM, Sumit Garg wrote:
>>>>> Expose the high performance PLL as a regular Linux clock, so the
>>>>> PCIe PHY can use it when there is no external refclock provided.
>>>>>
>>>>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
>>>>> drivers/pmdomain/imx/imx8mp-blk-ctrl.c
>>>>
>>>> Commit ID, please, see previous comments in this series.
>>>>
>>>> [...]
>>>>
>>>>> +static int hsio_pll_clk_enable(struct clk *clk)
>>>>> +{
>>>>> +     void *base = (void *)dev_get_driver_data(clk->dev);
>>>>> +     u32 val;
>>>>> +     int ret;
>>>>> +
>>>>> +     /* Setup HSIO PLL */
>>>>> +     clrsetbits_le32(base + GPR_REG2,
>>>>> +                     P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
>>>>> +                     FIELD_PREP(P_PLL_MASK, 12) |
>>>>> +                     FIELD_PREP(M_PLL_MASK, 800) |
>>>>> +                     FIELD_PREP(S_PLL_MASK, 4));
>>>>
>>>> These magic numbers 12, 800, 4 could use explanation (why these
>>>> numbers?) and a dedicated macro .
>>>>
>>>
>>> I can't find any information in TRM as to how HSIO PLL computation is
>>> done. However, I can extend the comment above to say that this
>>> configuration leads to a 100 MHz PHY clock as per
>>> clk_hsio_pll_recalc_rate() in Linux kernel driver.
>>
>> Try the CCM section 5.1.5.4.4 SSCG and Fractional PLLs I think,
> 
> That section also does mention following:
> 
> "The ARM PLL, GPU PLL, VPU PLL, DRAM PLL, Audio PLL1/2, and Video PLL1 are
> fractional PLLs. The frequency on these can be tuned to be very
> accurate to meet audio
> and video interface requirements."
> 
> without any mention of HSIO PLL.
> 
>> this is
>> likely PLL14xxx from Samsung, so

See ^

>> f_out = f_in * M / P * 2^S
>>
>> I think f_in is something like 24 MHz, so 24 * 800 / 12 * 16 = 100 MHz
>>
>> P - predivider
>> S - subdivider (output divider)
>> M - multiplier
> 
> IMO, we shouldn't document something based on our analysis but rather
> it should be based on facts.

Frankly, all the PLLs in the MX8M are very much similar, so either wait 
for someone from NXP to confirm this, or try and find some statement in 
the MX8MPRM .

>>>>> +static int hsio_pll_clk_disable(struct clk *clk)
>>>>> +{
>>>>> +     void *base = (void *)dev_get_driver_data(clk->dev);
>>>>> +
>>>>> +     clrbits_le32(base + GPR_REG3, PLL_CKE);
>>>>> +     clrbits_le32(base + GPR_REG3, PLL_RST);
>>>>
>>>> Can you clear both at once, or do they have to be cleared in sequence ?
>>>
>>> I generally follow the reverse sequence of how the configuration is
>>> done during hsio_pll_clk_enable(). These bits have seperate functions
>>> related to clock and reset. So I would prefer to keep them as they
>>> are.
>>
>> Linux does this in drivers/pmdomain/imx/imx8mp-blk-ctrl.c :
>>
>> 120 static void clk_hsio_pll_unprepare(struct clk_hw *hw)
>> 121 {
>> 122         struct clk_hsio_pll *clk = to_clk_hsio_pll(hw);
>> 123
>> 124         regmap_update_bits(clk->regmap, GPR_REG3, PLL_RST | PLL_CKE, 0);
>> 125 }
>>
> 
> And just above it:
> 
> static int clk_hsio_pll_prepare(struct clk_hw *hw)
> {
> ...
>          /* de-assert PLL reset */
>          regmap_update_bits(clk->regmap, GPR_REG3, PLL_RST, PLL_RST);
> 
>          /* enable PLL */
>          regmap_update_bits(clk->regmap, GPR_REG3, PLL_CKE, PLL_CKE);
> ...
> }
> 
> That's an anti-pattern in the Linux kernel driver which we shouldn't
> copy, right?

This is the enable part which is done in sequence, the part I quoted is 
the disable part.
