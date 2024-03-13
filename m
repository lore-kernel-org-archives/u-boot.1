Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98108C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 18:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D2787EAD;
	Wed, 13 Mar 2024 19:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GOByazLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0AD287E9B; Wed, 13 Mar 2024 19:22:46 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A73387E9A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 19:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-413e61525c2so1030565e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710354163; x=1710958963; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v920XM3r3hBUFXu/N/siR1vnleG4ZSEcaSO9Awb20o8=;
 b=GOByazLWtCWXVQXO0SWnO+9fOH88/zxsvITFFTbFMu+4nMXgiZnWg9frQN3m1kM+IN
 N64AlTMJRAdbQhxDk+jdWRi9dGbuaRpHJE5TGL0gwR8E771NmQpdolFHRVwQ1pSmnnU+
 91E3NhvlXncs1sVbzjXAoY3Id/fjg8qWKeVyE2I8GPom7u4XJl1ROImMD/X41nGdHqh6
 49KW/LMLgM3BSmhVc1GVhQr3CF2aVYmUnmOn3YLIrVQ/4R87TTQDvncDIhuSVo5n9XLt
 oV5EgQT6h3fjUYxQ4Bm9t3NiSjtU2O96R7BjOeHG8V81VOTv67Iv0PGGoPVkIFLRgygR
 Lz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710354163; x=1710958963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v920XM3r3hBUFXu/N/siR1vnleG4ZSEcaSO9Awb20o8=;
 b=GjLlX1VOl2wNhPUV6FpY+kyvA1VFeGyM6q9ChU+q1ASPY0TKY96xhz6dMb6tZqcQZ6
 jYTbcFCdPe4nDZRseEiBGmgCQFeU165cKpWnA9wi8efvpmSBmdbknQ6AWRqy+3LwDJo1
 2KOjB8EcVvELk7x+AGOf3HhEvdH9o+D/T8xrBPzayApmO4IkG3wWPpP/Fmet/KBvms9S
 qR9H36Oq4rh9MIUzM0K13rCixQ1ThRQ3ld+WP5n5/TEq5lFL0Gmh5Yg9SzJUD4DJf/aI
 0Pp6V2WyoFLjy1EBySb2DiI7RF6GyTktl9IBps5TO8atdT7Bw471B5qDK/k2cLK9mBuX
 ewwA==
X-Gm-Message-State: AOJu0YySVq9Kufsyrcp9TedFVvL5G/x/SMxR06n8xGH8TLXEcuxPGNbY
 /jYkFYqnfeJZX2SHwAiO5qJQgpDFUtGTg3vtgwPgRUjomJez3ujmCGVMkGDDsuw=
X-Google-Smtp-Source: AGHT+IGsoKOxD2BsAdrzIWpB8u3A2DYhf18THCVLzpQAZ4SHF7+0+aNv/v4j9N1sDLfkDbTGVF0zNQ==
X-Received: by 2002:a05:600c:5489:b0:413:335a:aed1 with SMTP id
 iv9-20020a05600c548900b00413335aaed1mr558289wmb.23.1710354163339; 
 Wed, 13 Mar 2024 11:22:43 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a05600c34c300b00413eac2e806sm2416006wmq.29.2024.03.13.11.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 11:22:42 -0700 (PDT)
Message-ID: <975bfe22-58b3-46b9-899b-f212b49d8664@linaro.org>
Date: Wed, 13 Mar 2024 18:22:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
 <ee020a2c-4f84-4fae-97a0-f12f3157d3ad@denx.de>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <ee020a2c-4f84-4fae-97a0-f12f3157d3ad@denx.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Marek,

On 06/02/2024 20:36, Marek Vasut wrote:
> On 1/31/24 15:57, Caleb Connolly wrote:
>> The Qualcomm specific dwc3 wrapper isn't hugely complicated, implemented
>> the missing initialisation for host and gadget mode.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 99
>> ++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 98 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c
>> b/drivers/usb/dwc3/dwc3-generic.c
>> index 48da621ba966..1119cdecd26d 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -419,6 +419,99 @@ struct dwc3_glue_ops ti_ops = {
>>       .glue_configure = dwc3_ti_glue_configure,
>>   };
>>   +/* USB QSCRATCH Hardware registers */
>> +#define QSCRATCH_HS_PHY_CTRL 0x10
>> +#define UTMI_OTG_VBUS_VALID BIT(20)
>> +#define SW_SESSVLD_SEL BIT(28)
>> +
>> +#define QSCRATCH_SS_PHY_CTRL 0x30
>> +#define LANE0_PWR_PRESENT BIT(24)
>> +
>> +#define QSCRATCH_GENERAL_CFG 0x08
>> +#define PIPE_UTMI_CLK_SEL BIT(0)
>> +#define PIPE3_PHYSTATUS_SW BIT(3)
>> +#define PIPE_UTMI_CLK_DIS BIT(8)
>> +
>> +#define PWR_EVNT_IRQ_STAT_REG 0x58
>> +#define PWR_EVNT_LPM_IN_L2_MASK BIT(4)
>> +#define PWR_EVNT_LPM_OUT_L2_MASK BIT(5)
>> +
>> +#define SDM845_QSCRATCH_BASE_OFFSET 0xf8800
>> +#define SDM845_QSCRATCH_SIZE 0x400
>> +#define SDM845_DWC3_CORE_SIZE 0xcd00
> 
> Newline here please
> 
>> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset,
>> u32 val)
>> +{
>> +    u32 reg;
>> +
>> +    reg = readl(base + offset);
>> +    reg |= val;
>> +    writel(reg, base + offset);
> 
> Use setbits_le32() .
> 
>> +    /* ensure that above write is through */
>> +    readl(base + offset);
> 
> Is this needed ?

I honestly don't know, this is copied from the Linux driver and it seems
to be very defensively written. I doubt it's strictly necessary.
> 
>> +}
>> +
>> +static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset,
>> u32 val)
>> +{
>> +    u32 reg;
>> +
>> +    reg = readl(base + offset);
>> +    reg &= ~val;
>> +    writel(reg, base + offset);
> 
> clrbits_le32()
> 
>> +    /* ensure that above write is through */
>> +    readl(base + offset);
>> +}
>> +
>> +static void dwc3_qcom_vbus_override_enable(void __iomem
>> *qscratch_base, bool enable)
>> +{
>> +    if (enable) {
>> +        dwc3_qcom_setbits(qscratch_base, QSCRATCH_SS_PHY_CTRL,
>> +                  LANE0_PWR_PRESENT);
>> +        dwc3_qcom_setbits(qscratch_base, QSCRATCH_HS_PHY_CTRL,
>> +                  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
>> +    } else {
>> +        dwc3_qcom_clrbits(qscratch_base, QSCRATCH_SS_PHY_CTRL,
>> +                  LANE0_PWR_PRESENT);
>> +        dwc3_qcom_clrbits(qscratch_base, QSCRATCH_HS_PHY_CTRL,
>> +                  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
>> +    }
>> +}
>> +
>> +/* For controllers running without superspeed PHYs */
>> +static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
>> +{
>> +    /* Configure dwc3 to use UTMI clock as PIPE clock not present */
>> +    dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
>> +              PIPE_UTMI_CLK_DIS);
>> +
>> +    udelay(500);
> 
> Isn't there some possibility to poll for completion instead of fixed
> delay ? If so, use wait_for_bit or some such .

Not that I'm aware of, no. I think this hardware just has a blanket
"writes take X bus cycles to complete" rule or something. It's totally
possible that this code was originally written this way to work around
some issues on an FPGA prototype or something. Everything seems to still
work if I remove the delays so I'll drop them...
> 
>> +    dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
>> +              PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
>> +
>> +    udelay(500);
>> +
>> +    dwc3_qcom_clrbits(qscratch_base, QSCRATCH_GENERAL_CFG,
>> +              PIPE_UTMI_CLK_DIS);
>> +}
>> +
>> +static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
>> +                     enum usb_dr_mode mode)
>> +{
>> +    void __iomem *qscratch_base = (void __iomem *)dev_read_addr(dev);
> 
> Can this be NULL ? If yes, add check for != NULL .
Will do.
> 
>> +    if (dev_read_bool(dev, "qcom,select-utmi-as-pipe-clk"))
>> +        dwc3_qcom_select_utmi_clk(qscratch_base);
>> +
>> +    if (mode != USB_DR_MODE_HOST)
>> +        dwc3_qcom_vbus_override_enable(qscratch_base, true);
>> +}
>> +
>> +struct dwc3_glue_ops qcom_ops = {
>> +    .glue_configure = dwc3_qcom_glue_configure,
>> +};
>> +
>>   static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
>>   {
>>       *node = dev_ofnode(dev);
>> @@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice *dev,
>>       else if (ret)
>>           return ret;
>>   +    if (device_is_compatible(dev, "qcom,dwc3")) {
>> +        reset_assert_bulk(&glue->resets);
>> +        udelay(500);
> 
> Why this delay here ?

According to the docs, the reset should be asserted for at least 6 sleep
clock cycles, that's ~200us on sdm845, but it can vary by platform.

> 
> [...]

-- 
// Caleb (they/them)
