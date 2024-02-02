Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C494C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 09:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37D9874B1;
	Fri,  2 Feb 2024 10:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gHDvG5f7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E9987073; Fri,  2 Feb 2024 10:16:22 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0A1874B1
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51134caba39so812858e87.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706865378; x=1707470178;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AlMwKvbYf08l/MZKX1SG6ltloBZr3TnPufGAqRBpj8w=;
 b=gHDvG5f7AK4sEGjazytQPfdYfydnXQ7a7kcWXRmANsn+/Kbi11KMq44V+wanIMn+pz
 NAv+nCcPyvmnKZeOnsi9Rgu2buUAxAcHbo+3GM+YXyQLKn7lSecHoLwKzhRRHPFQsDdL
 TVtvQf0HxKnPcXmq567V15uYQlbnlsOP3R1bouJtjOKR8KS1N6hQUJ3m81x8cc0aiKS4
 RWE+ca6IE+XpLPU1sSTwh9GzXxQMq9cnUaxUbCc/1k+bzgCtdeap4p3BmBahPWEGeQMI
 9TXLub/lQP7HcQnWLuIsl2i98yPtxvxbkRrdCHSuzLHTHAsRYrRc8X8za8ow5g5f5NWp
 0cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706865378; x=1707470178;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AlMwKvbYf08l/MZKX1SG6ltloBZr3TnPufGAqRBpj8w=;
 b=d/ykyloRnqqwMFCn2Vway9tMFQE4/HRexO7Iqy/x27u1he4pycPnVM+X+FbCii5QKe
 AVK7oqgwyQvgS11o08U9Lb40nSKNpHvusPT1MXcoHOwbh+XPlfDquAaGuAOP9Z3Va2KA
 l6i+TqPWqxlnvWJ8Las+Q6v12LzswJs35qVDEGPjHua6Wv9oUHymVoSWBPLVeal/NRdt
 k4OTqhEL3cVdBYAxbu05sY/0Qqe8yqkrg34r6OjV7GRpp2z7r9gv8aHcsIio7Eebze69
 6odUdq0umtahJJwDuGbbzv70w3wZEP14mv54MXFt9Jv2uvcbDx8ZNNWDvpdPXFBxx5YW
 lBfg==
X-Gm-Message-State: AOJu0YxJYKg+qiUGXbu+paWmfgnD5BrqZnXWxzwZPEvbwEmtl8arMB9s
 DVjGAgCKvzA7fxKfbd+pHmhcw9AT7l/EWitN1VALGmvwGG9chv722EoGGEV8Jww=
X-Google-Smtp-Source: AGHT+IGM9jZmElhJU1zNwnX4wwU+e1iqEUhrtj1JtyyuJpdKENBL57aM3CQLv/wvk0oA7pxed4VW8g==
X-Received: by 2002:a05:6512:3b81:b0:50e:7b9c:3ed5 with SMTP id
 g1-20020a0565123b8100b0050e7b9c3ed5mr4723836lfv.50.1706865377512; 
 Fri, 02 Feb 2024 01:16:17 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWd3P+ftlA1e0FENXGwL3s0RYsz4d8hnEFcsvqRPEUadGm90FzAA48gMKx32/UB+ikfYOXrDo7tZlPcyaYHHAUKZyDpj3sTsXQRZFQYenYpcIhUt5U7s3Fq2CCDyPr/MjFEJops0sWAIqDfDQqKG+kDnm9pILvVCDykMoa0Eog7RmeiX+AyCbqgmXlXkpbfCcDIgw==
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a05600c314800b0040efc845cb6sm6900047wmo.7.2024.02.02.01.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:16:17 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
In-Reply-To: <5aadc369-d21b-4810-9482-07d74f92aebf@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
 <87h6ismstc.fsf@baylibre.com>
 <5aadc369-d21b-4810-9482-07d74f92aebf@linaro.org>
Date: Fri, 02 Feb 2024 10:16:16 +0100
Message-ID: <87cytf4467.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

On Thu, Feb 01, 2024 at 14:24, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> On 01/02/2024 09:34, Mattijs Korpershoek wrote:
>> Hi Caleb,
>> 
>> Thank you for the patch.
>> 
>> On mer., janv. 31, 2024 at 14:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>> 
>>> The Qualcomm specific dwc3 wrapper isn't hugely complicated, implemented
>>> the missing initialisation for host and gadget mode.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>  drivers/usb/dwc3/dwc3-generic.c | 99 ++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 98 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>> index 48da621ba966..1119cdecd26d 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -419,6 +419,99 @@ struct dwc3_glue_ops ti_ops = {
>>>  	.glue_configure = dwc3_ti_glue_configure,
>>>  };
>>>  
>>> +/* USB QSCRATCH Hardware registers */
>>> +#define QSCRATCH_HS_PHY_CTRL 0x10
>>> +#define UTMI_OTG_VBUS_VALID BIT(20)
>>> +#define SW_SESSVLD_SEL BIT(28)
>>> +
>>> +#define QSCRATCH_SS_PHY_CTRL 0x30
>>> +#define LANE0_PWR_PRESENT BIT(24)
>>> +
>>> +#define QSCRATCH_GENERAL_CFG 0x08
>>> +#define PIPE_UTMI_CLK_SEL BIT(0)
>>> +#define PIPE3_PHYSTATUS_SW BIT(3)
>>> +#define PIPE_UTMI_CLK_DIS BIT(8)
>>> +
>>> +#define PWR_EVNT_IRQ_STAT_REG 0x58
>>> +#define PWR_EVNT_LPM_IN_L2_MASK BIT(4)
>>> +#define PWR_EVNT_LPM_OUT_L2_MASK BIT(5)
>>> +
>>> +#define SDM845_QSCRATCH_BASE_OFFSET 0xf8800
>>> +#define SDM845_QSCRATCH_SIZE 0x400
>>> +#define SDM845_DWC3_CORE_SIZE 0xcd00
>>> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>> +{
>>> +	u32 reg;
>>> +
>>> +	reg = readl(base + offset);
>>> +	reg |= val;
>>> +	writel(reg, base + offset);
>> 
>> Why can't we use the setbits() macro here?
>> see: arch/arm/include/asm/io.h
>
> setbits doesn't give us the same cache coherency guarantees I think(?)
> the readl/writel macros include wmb() calls.

Indeed, I did not pay attention to that difference.

>
> That said, I won't pretend to really know what I'm talking about here,
> possible setbits() would be suitable, do you have any idea?

I am sorry, I don't know.

It's fine to keep it as is.

>> 
>>> +
>>> +	/* ensure that above write is through */
>>> +	readl(base + offset);
>>> +}
>>> +
>>> +static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
>>> +{
>>> +	u32 reg;
>>> +
>>> +	reg = readl(base + offset);
>>> +	reg &= ~val;
>>> +	writel(reg, base + offset);
>> 
>> Same question for clrbits()
>> 
>>> +
>>> +	/* ensure that above write is through */
>>> +	readl(base + offset);
>>> +}
>>> +
>
> [snip]
>
>>> +	if (device_is_compatible(dev, "qcom,dwc3")) {
>>> +		reset_assert_bulk(&glue->resets);
>> 
>> Any reason for not doing error handling on reset_assert_bulk() like it's
>> done below ?
>
> Well, the Qualcomm reset driver will never return an error, and if it
> did, the assert failing (presumably because it's already asserted) is
> not necessarily an error we'd need to care about - it's only an error if
> we can't deassert the reset.
>
> So I think this is fine.

Ok, agreed.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>> 
>>> +		udelay(500);
>>> +	}
>>>  	ret = reset_deassert_bulk(&glue->resets);
>>>  	if (ret) {
>>>  		reset_release_bulk(&glue->resets);
>>> @@ -623,7 +720,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>>>  	{ .compatible = "rockchip,rk3399-dwc3" },
>>>  	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>>>  	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>>> -	{ .compatible = "qcom,dwc3" },
>>> +	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
>>>  	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>>>  	{ .compatible = "fsl,imx8mq-dwc3" },
>>>  	{ .compatible = "intel,tangier-dwc3" },
>>>
>>> -- 
>>> 2.43.0
>
> -- 
> // Caleb (they/them)
