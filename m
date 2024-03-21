Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D5CC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 05:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA8387D08;
	Thu, 21 Mar 2024 06:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710999364;
	bh=Cu1rweN1MmeShuiM3EfC9xk1wBv3czCjhKLDG/cr6mw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bo7qlIMljx2jUFJCuQoJKEFPL0vHjU1QESyzgBxAYvxZSz9BrUF8h7q/sOM7wszc5
	 AQ11ERirodp/n2ESEFPIzNhN1R4ded45TBq76NVHGFU5oVutnPhmAk8T0Rgc0D2XPg
	 aZQqLqrfl8YkBHJ0qt/xnAL1RmyaHtYCoiq76lS4HC/RJiE6nrBE/Txx9IauiplVS3
	 N5q7B21OMQUWbVVDyRo2H+3tsK4sCo0TmB+Yp7kDVvt/8V7/wouT8rWLwRTBumoC3D
	 aq9I0Yg25grZP4q6sg/IRVlyROROROV1HhJwya/e/jVh/yXW2eNIjkyoeKqxqiX0Vg
	 l1fc0bZ0Bs/Ng==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D8CFE87DF1;
 Thu, 21 Mar 2024 06:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710999361;
 bh=Cu1rweN1MmeShuiM3EfC9xk1wBv3czCjhKLDG/cr6mw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jlazcrqfPfUw19Nn0atAgHt0PB5ci6GVnRuEMN0Kafdyz9JzI49ify977pgILFrRa
 gYWecUdLWzXW4apus/NqkS79IV3gIy6avLlYRG2MvXTXLbINNKPp66r+knFhFEiDjr
 FozeHeDhcW9lVF2pVzgKF2T1SRCKZmg5zc3BWCUwG6dBtrAnyArhsGxGh7IO5pBUb/
 r/DrgbxQ18cDv28M13dm2IsVXpnyxXq0i0C9Tmn0+QDgO/68E8rqiG77JoTZcBxp2R
 KleaRNk01OlCkFUjxS7QW6PT8+vCYFxGkGKzmgNK609ypThrZ2dhzMXdhRXMh/nJR8
 bmVMJ9JFm9iaQ==
Message-ID: <8221c539-51b9-4ead-8cce-834c93230282@denx.de>
Date: Thu, 21 Mar 2024 06:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
 <ee020a2c-4f84-4fae-97a0-f12f3157d3ad@denx.de>
 <975bfe22-58b3-46b9-899b-f212b49d8664@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <975bfe22-58b3-46b9-899b-f212b49d8664@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/13/24 7:22 PM, Caleb Connolly wrote:

[...]

>>> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset,
>>> u32 val)
>>> +{
>>> +    u32 reg;
>>> +
>>> +    reg = readl(base + offset);
>>> +    reg |= val;
>>> +    writel(reg, base + offset);
>>
>> Use setbits_le32() .
>>
>>> +    /* ensure that above write is through */
>>> +    readl(base + offset);
>>
>> Is this needed ?
> 
> I honestly don't know, this is copied from the Linux driver and it seems
> to be very defensively written. I doubt it's strictly necessary.

Does git log indicate anything ?

I suspect this is some sort of barrier .

[...]

>>> +/* For controllers running without superspeed PHYs */
>>> +static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
>>> +{
>>> +    /* Configure dwc3 to use UTMI clock as PIPE clock not present */
>>> +    dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
>>> +              PIPE_UTMI_CLK_DIS);
>>> +
>>> +    udelay(500);
>>
>> Isn't there some possibility to poll for completion instead of fixed
>> delay ? If so, use wait_for_bit or some such .
> 
> Not that I'm aware of, no. I think this hardware just has a blanket
> "writes take X bus cycles to complete" rule or something. It's totally
> possible that this code was originally written this way to work around
> some issues on an FPGA prototype or something. Everything seems to still
> work if I remove the delays so I'll drop them...

Could you possibly ask someone ?

[...]

>>>    static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
>>>    {
>>>        *node = dev_ofnode(dev);
>>> @@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice *dev,
>>>        else if (ret)
>>>            return ret;
>>>    +    if (device_is_compatible(dev, "qcom,dwc3")) {
>>> +        reset_assert_bulk(&glue->resets);
>>> +        udelay(500);
>>
>> Why this delay here ?
> 
> According to the docs, the reset should be asserted for at least 6 sleep
> clock cycles, that's ~200us on sdm845, but it can vary by platform.

A comment in the code would be nice.

Sorry for the abysmal delay in replies.

btw. the new version of this series is still OK to go in, unless you 
want to fill in the comments. They can also go in in separate follow up 
patch.
