Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BC5C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C15387BF2;
	Thu,  1 Feb 2024 15:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G+bzCkqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C65287BF2; Thu,  1 Feb 2024 15:24:08 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372FD87C13
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40eac352733so8909305e9.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706797444; x=1707402244; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QWIayTaIJvR4/T9Mp1GWnPWBdK9ivFYb9tqZodlNkrU=;
 b=G+bzCkqF4Yyci94lVzUCEDYJVfthVjImNhCkQZQC8Oa+agcnDKR23V+eKh9bNly3Bo
 7GjqHBb6NLd/cUtiFxaSzvyZNp4MLoyp6ch4wC3Tl4m/n6Rah7o/Tuy1zG3q8ZeCXfTz
 GRrIn0katcrAPp6rhXSAJq1LUArBAvmznqpy5UjMJ5zKC/XhpULacVWmM+XZfAuiSTc7
 s9rQ/LdOsIx+XqZch4ia9w+3bHFNdbGvXOGhzxDBRfrNPeK/3ykh4rpIZ4vq5b1WN4Cs
 3ZSw+l2fqqVZGL1RMPUSPPn2Eb87ZmQiqRchhS+RIb2A5PQThjuaMd9znDX5u9rf2y7s
 HHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706797444; x=1707402244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QWIayTaIJvR4/T9Mp1GWnPWBdK9ivFYb9tqZodlNkrU=;
 b=NaUqhXkMdIQ+JG+BrzMdUrKzrKRnjGPSXALA/JkNzENBnpTLtsaK8PanPZt79Effsq
 PFL3vMPgrjqPIbx23xjwwrFLu9KeQnAh/ytpOfyFzXA3t/G5+6+lv/8MsN/1yiAMYWOk
 iWRpGgRUWqu6lXzq9D7Aeuzx2+eckxMW+kSBVXbD0b0koqI0MQtp50NQYYNw3P7SY0kQ
 U3HcVnpAAVEGrr12/hNmS15JTA1ISLZoI6yWH/BRYddcE2jR3T++gexmF5N2Be/Jr6qf
 /e91HVUGiDCnxyvtv9P5IrGSLXMdVWjt9oeFvhiJQsMTbceZc0K9/0XHLMxdg/em5M18
 RKIw==
X-Gm-Message-State: AOJu0YyYOlIrLxGygpusk4I8UlOxK8hY2kHhCHL7kDZhHvLWJya5md1r
 RN5TQIII8hNBXSkD48FMonHEMm4aECvIrewBrJl9FPKyem/M3xd6eSJw80hENKY=
X-Google-Smtp-Source: AGHT+IGE3lx7Qsk57ukaqFqq0ICEInBPE1bq7YrcarkTfgiM59t465FaztZquyWKEoS8+B8k44FecQ==
X-Received: by 2002:a05:600c:35c4:b0:40e:f67e:a4e2 with SMTP id
 r4-20020a05600c35c400b0040ef67ea4e2mr3737522wmq.39.1706797444616; 
 Thu, 01 Feb 2024 06:24:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWTQfU7vq1hIl4iK4j4c31n9A03doj4L7tlRbTzIJ0D9L1vMrF5dHl9D0STa0w5nSfO83FP1h+CtzFEwWQjcWd5cfaSP+tRMMV3rJGuT8Bm3E4AKoW8xycTYnwCmiXlotWKlpwaVUTUgSzmYDDKB2vL3oi84jIbsONPwpGzFU1UHIZaB4tMVIocBbTz4F8UZNHKtQ==
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a05600c154600b0040fa661ee82sm4630987wmg.44.2024.02.01.06.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 06:24:04 -0800 (PST)
Message-ID: <5aadc369-d21b-4810-9482-07d74f92aebf@linaro.org>
Date: Thu, 1 Feb 2024 14:24:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
 <87h6ismstc.fsf@baylibre.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87h6ismstc.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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



On 01/02/2024 09:34, Mattijs Korpershoek wrote:
> Hi Caleb,
> 
> Thank you for the patch.
> 
> On mer., janv. 31, 2024 at 14:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> The Qualcomm specific dwc3 wrapper isn't hugely complicated, implemented
>> the missing initialisation for host and gadget mode.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/usb/dwc3/dwc3-generic.c | 99 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 98 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>> index 48da621ba966..1119cdecd26d 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -419,6 +419,99 @@ struct dwc3_glue_ops ti_ops = {
>>  	.glue_configure = dwc3_ti_glue_configure,
>>  };
>>  
>> +/* USB QSCRATCH Hardware registers */
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
>> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>> +{
>> +	u32 reg;
>> +
>> +	reg = readl(base + offset);
>> +	reg |= val;
>> +	writel(reg, base + offset);
> 
> Why can't we use the setbits() macro here?
> see: arch/arm/include/asm/io.h

setbits doesn't give us the same cache coherency guarantees I think(?)
the readl/writel macros include wmb() calls.

That said, I won't pretend to really know what I'm talking about here,
possible setbits() would be suitable, do you have any idea?
> 
>> +
>> +	/* ensure that above write is through */
>> +	readl(base + offset);
>> +}
>> +
>> +static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
>> +{
>> +	u32 reg;
>> +
>> +	reg = readl(base + offset);
>> +	reg &= ~val;
>> +	writel(reg, base + offset);
> 
> Same question for clrbits()
> 
>> +
>> +	/* ensure that above write is through */
>> +	readl(base + offset);
>> +}
>> +

[snip]

>> +	if (device_is_compatible(dev, "qcom,dwc3")) {
>> +		reset_assert_bulk(&glue->resets);
> 
> Any reason for not doing error handling on reset_assert_bulk() like it's
> done below ?

Well, the Qualcomm reset driver will never return an error, and if it
did, the assert failing (presumably because it's already asserted) is
not necessarily an error we'd need to care about - it's only an error if
we can't deassert the reset.

So I think this is fine.
> 
>> +		udelay(500);
>> +	}
>>  	ret = reset_deassert_bulk(&glue->resets);
>>  	if (ret) {
>>  		reset_release_bulk(&glue->resets);
>> @@ -623,7 +720,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>>  	{ .compatible = "rockchip,rk3399-dwc3" },
>>  	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>>  	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>> -	{ .compatible = "qcom,dwc3" },
>> +	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
>>  	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>>  	{ .compatible = "fsl,imx8mq-dwc3" },
>>  	{ .compatible = "intel,tangier-dwc3" },
>>
>> -- 
>> 2.43.0

-- 
// Caleb (they/them)
