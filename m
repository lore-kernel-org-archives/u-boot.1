Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58DDC54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9E687EF5;
	Mon, 26 Feb 2024 14:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708952494;
	bh=PbPZzkCWDoEUsgQ2TaJD6HmFNp7M4HO7mAKxCLvIXaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SePIKpcKFUt9cl91Uq7gjaOmuBDAcf2DmN0/tO6gCOer8Ad3CGvnKrpWKdGW7Beaq
	 8T3i82QGXHMOmlWTADvrgK1Py+QYJl5wtyGMmCp00Q7cYAfR/CQOxYzjRYCXGbCWQT
	 9q4scqvZycz7WNwL9CF+W3jXHbJQ+izKzHi1Rw66xY5y3QZPNFZ67Wd1nD8rUKkwTO
	 brUe0kuYTYMDpd0BV2seFXneeRoAE4SDgNaZUfBzUh53FrDXOlAgB0rEZJ4Q4uq5aP
	 kcjSNUjUPOFCyHreoY77vaGPpLCSxiE/ZNwRelY7oGiuRz2yYNkWv580/Xr96wJ/ob
	 tveMo0fv3xiCw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E6D9887EEA;
 Mon, 26 Feb 2024 14:01:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708952493;
 bh=PbPZzkCWDoEUsgQ2TaJD6HmFNp7M4HO7mAKxCLvIXaA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Hmq9gFQHVTUlC4VHgg5raRWx3T+hKpTK1UjYch7nRdhy5etjiwOBOTOz/iUMWb/nj
 Tc3J5VHl5uiE9jTQnM0TLBcnb4sZ/+KXZoJLxIfbknfbhAbxyAbOJXXazOiWbCjM1A
 wEBX6xZMJYH/GA+H8IqNvKeq7uVJCanwawavgavuHN6pSrn2h9xgG96+aH3x6Wza6N
 ExJrckUlUiUrglLGEME9IcWzqvufjxzp8uWpzf67iqAWrBD/729I/qw6tPdnFJkbfX
 lrZkBojRB0PYr9yFLKUanNUFGTlSHlhPyIfLmD11W15n8PA+NurXwf6XVRR087+jSK
 R+iX8bY/dO5/Q==
Message-ID: <6aee8c88-f333-4dcc-aba2-cb37d60b5697@denx.de>
Date: Mon, 26 Feb 2024 14:01:31 +0100
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYO2n-QG7TvSnKyk5O0Pzwcn0jd4iCeLbebbsVZiOq2fdQ@mail.gmail.com>
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

On 2/26/24 1:39 PM, Sumit Garg wrote:
> On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/26/24 9:04 AM, Sumit Garg wrote:
>>> Expose the high performance PLL as a regular Linux clock, so the
>>> PCIe PHY can use it when there is no external refclock provided.
>>>
>>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
>>> drivers/pmdomain/imx/imx8mp-blk-ctrl.c
>>
>> Commit ID, please, see previous comments in this series.
>>
>> [...]
>>
>>> +static int hsio_pll_clk_enable(struct clk *clk)
>>> +{
>>> +     void *base = (void *)dev_get_driver_data(clk->dev);
>>> +     u32 val;
>>> +     int ret;
>>> +
>>> +     /* Setup HSIO PLL */
>>> +     clrsetbits_le32(base + GPR_REG2,
>>> +                     P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
>>> +                     FIELD_PREP(P_PLL_MASK, 12) |
>>> +                     FIELD_PREP(M_PLL_MASK, 800) |
>>> +                     FIELD_PREP(S_PLL_MASK, 4));
>>
>> These magic numbers 12, 800, 4 could use explanation (why these
>> numbers?) and a dedicated macro .
>>
> 
> I can't find any information in TRM as to how HSIO PLL computation is
> done. However, I can extend the comment above to say that this
> configuration leads to a 100 MHz PHY clock as per
> clk_hsio_pll_recalc_rate() in Linux kernel driver.

Try the CCM section 5.1.5.4.4 SSCG and Fractional PLLs I think, this is 
likely PLL14xxx from Samsung, so

f_out = f_in * M / P * 2^S

I think f_in is something like 24 MHz, so 24 * 800 / 12 * 16 = 100 MHz

P - predivider
S - subdivider (output divider)
M - multiplier

>>> +     /* de-assert PLL reset */
>>> +     setbits_le32(base + GPR_REG3, PLL_RST);
>>> +
>>> +     /* enable PLL */
>>> +     setbits_le32(base + GPR_REG3, PLL_CKE);
>>> +
>>> +     /* Check if PLL is locked */
>>> +     ret = readl_poll_sleep_timeout(base + GPR_REG1, val,
>>> +                                    val & PLL_LOCK, 10, 100000);
>>> +     if (ret)
>>> +             dev_err(clk->dev, "failed to lock HSIO PLL\n");
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int hsio_pll_clk_disable(struct clk *clk)
>>> +{
>>> +     void *base = (void *)dev_get_driver_data(clk->dev);
>>> +
>>> +     clrbits_le32(base + GPR_REG3, PLL_CKE);
>>> +     clrbits_le32(base + GPR_REG3, PLL_RST);
>>
>> Can you clear both at once, or do they have to be cleared in sequence ?
> 
> I generally follow the reverse sequence of how the configuration is
> done during hsio_pll_clk_enable(). These bits have seperate functions
> related to clock and reset. So I would prefer to keep them as they
> are.

Linux does this in drivers/pmdomain/imx/imx8mp-blk-ctrl.c :

120 static void clk_hsio_pll_unprepare(struct clk_hw *hw)
121 {
122         struct clk_hsio_pll *clk = to_clk_hsio_pll(hw);
123
124         regmap_update_bits(clk->regmap, GPR_REG3, PLL_RST | PLL_CKE, 0);
125 }

[...]
