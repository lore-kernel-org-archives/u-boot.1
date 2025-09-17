Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2287CA0EE8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 11:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B173833F5;
	Wed, 17 Sep 2025 13:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s725XQnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75E28349B; Wed, 17 Sep 2025 13:29:10 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7E8833ED
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 13:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3e957ca53d1so3431317f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758108546; x=1758713346; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tRGw3P8ZkvmvywoEDqWcqBPJ7vz2rX+uJ9ZzIS3anH8=;
 b=s725XQnMi8Ubf5MWJVZ1vdn6kTrTBl7+RukUOEtu+TLRIX8aIUGGoieGYRhGkfFk4z
 4MT+NQGyL2XiTU9cMs3mF1Tk68auKSaO8TLdIEQMuM08Ez2Hyk29uAtvmsPU5g/PfYIO
 N032+vE06BAocg1dQOaN6OFfSdZUOZDXdhMI7epLb8v7hF5ENJFxdNf/umXCWyypKnUB
 4JxTL7s9AiKrBe9rwrqDY2aa5UCqIHDYNxmFhg8BOiAMj+6xut1USh5YPTu3yQ8dft7I
 05Fj6nMAmbkMbY4jC+b8k/DMJC70eMHe6TrzmNmlO4fHj1SAnVcg4OgsriCs8RVP1bgO
 geYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758108546; x=1758713346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tRGw3P8ZkvmvywoEDqWcqBPJ7vz2rX+uJ9ZzIS3anH8=;
 b=j/nLYwtA8PieRQFnSrRJWYuKEYW7LKPbRk3ir1huMdN2H86Ne4CRpzHGI9hrH4QK1a
 oZn7pDoLyD4FYn6TjqtmsgNB0xBIF37RR5T1sXY8v2/FXucta6nmXQYh/zM1AluKErbF
 cez3p4a9UwajSq6iXxqzYMfjm/TqvjzguLgLLMqwu7WATc9xIhq6COe+w4y2rhelnqcx
 nwAJ5B8j3u5UuRrVN3Ilju/qxI+LQpTQPLSVB2imB0hcUkPyioFNLUABdkFrwBniKvR+
 qFoTQokLJkvOw5nkshGzRmDJnuMpLuju6UmQHyZeb0beWeWtImt0mz3BT2Tm132H2Qv7
 38yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEL1WKvKdDczrDiQf0EDiKBb99XjlRTsGd5ehuiKnbFBWMDov7Ge83+5PwuiK1yU9FHdRmykk=@lists.denx.de
X-Gm-Message-State: AOJu0YznzoyefTnpfkjF/GUTOqaEcOXBsJU0IPGtOnuWOR9seQNMw+I5
 LKAD1KHS4+vgZC9s+bpnyKMJSe7RDbHL5Ep6O91occ0pkVJFNznPVcbVukafUw7Syas=
X-Gm-Gg: ASbGncspfULOqZnrtovbAdxVfgkFIPQGJbwT/5pCDpW6joz2wNnOCEvLfnd1z5O+lDd
 nfDvPEsUzSLdHh3RQLPyFd99mGoz6o5V7dZ5ktFOcjUR3orrre/HLYDWq3lQkOiNF3tbWz1Crp4
 WrwnmvTROxbKEK6KaPqw+0DZY5MhDwyaE5jTrxHJd8sMJiYts/6xF3Jep/MsKxwvLroWyQPSy2L
 6AWUGHDbk348Iaw1ZK3Elq0mRtxTAKiEo3M2oTBB8jeTmyDXkFLKsXsuFNTCqUDBOxPOVpEYaOT
 8gY7/4GzH5GuqnMwGcFkJzXp8O1OlZDfyBcZkSA9DgjkAAfr5UhS2I2BuQsZ5mQxYIoLxCwNMul
 duEJcwVK9QrcazNB1HpRAJBcNlj6e+lPkX8QFJHfOerCSj8aupAERqnH8zDzgB0aqNMbt44q0TA
 ==
X-Google-Smtp-Source: AGHT+IGJ9uRIXPEHRIWDo1bMfhWhJPT2DLkHSlKjMrvQhCNzBvokHD0p6tUrkzj+yGm8z6nQowaIdw==
X-Received: by 2002:adf:ea85:0:b0:3ec:ea72:ad53 with SMTP id
 ffacd0b85a97d-3ecea72b05fmr211250f8f.33.1758108546039; 
 Wed, 17 Sep 2025 04:29:06 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e318.dip0.t-ipconnect.de. [91.41.227.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ecdd4d15ecsm3478370f8f.11.2025.09.17.04.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:29:05 -0700 (PDT)
Message-ID: <8d546075-9ef4-45e9-a251-de7926c9feb6@linaro.org>
Date: Wed, 17 Sep 2025 13:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] pinctrl: qcom: add SM7150 pinctrl driver
Content-Language: en-US
To: Jens Reidel <adrian@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Luca Weiss <luca@lucaweiss.eu>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250831004602.699953-1-adrian@mainlining.org>
 <20250831004602.699953-3-adrian@mainlining.org>
 <0343bb3c-f13f-4cc9-a972-e9fae200f476@linaro.org>
 <b6e82030-303d-4f10-933d-7267da3b8558@mainlining.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <b6e82030-303d-4f10-933d-7267da3b8558@mainlining.org>
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



On 09/09/2025 01:32, Jens Reidel wrote:
> On 9/4/25 3:53 PM, Casey Connolly wrote:
>>
>>
>> On 31/08/2025 02:46, Jens Reidel wrote:
>>> From: Danila Tikhonov <danila@jiaxyga.com>
>>>
>>> This SoC features a pinctrl block with north, south, and west tiles
>>> accessible to the AP.
>>>
>>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>>> Co-developed-by: Jens Reidel <adrian@mainlining.org>
>>> Signed-off-by: Jens Reidel <adrian@mainlining.org>
>>> ---
>>>   drivers/pinctrl/qcom/Kconfig          |   7 ++
>>>   drivers/pinctrl/qcom/Makefile         |   1 +
>>>   drivers/pinctrl/qcom/pinctrl-sm7150.c | 142 ++++++++++++++++++++++++++
>>>   3 files changed, 150 insertions(+)
>>>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sm7150.c
>>>
>>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>>> index 21f81b66099..d83ede21c75 100644
>>> --- a/drivers/pinctrl/qcom/Kconfig
>>> +++ b/drivers/pinctrl/qcom/Kconfig
>>> @@ -89,6 +89,13 @@ config PINCTRL_QCOM_SM6115
>>>         Say Y here to enable support for pinctrl on the Snapdragon
>>> SM6115 SoC,
>>>         as well as the associated GPIO driver.
>>>   +config PINCTRL_QCOM_SM7150
>>> +    bool "Qualcomm SM7150 GCC"
>>> +    select PINCTRL_QCOM
>>> +    help
>>> +      Say Y here to enable support for pinctrl on the Snapdragon
>>> SM7150 SoC,
>>> +      as well as the associated GPIO driver.
>>> +
>>>   config PINCTRL_QCOM_SM8150
>>>       bool "Qualcomm SM8150 Pinctrl"
>>>       select PINCTRL_QCOM
>>> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/
>>> Makefile
>>> index 6cb53838e71..73c08a02a3d 100644
>>> --- a/drivers/pinctrl/qcom/Makefile
>>> +++ b/drivers/pinctrl/qcom/Makefile
>>> @@ -15,6 +15,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
>>>   obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
>>>   obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>>>   obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
>>> +obj-$(CONFIG_PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
>>>   obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
>>>   obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
>>>   obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
>>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm7150.c b/drivers/pinctrl/
>>> qcom/pinctrl-sm7150.c
>>> new file mode 100644
>>> index 00000000000..435ba39b1db
>>> --- /dev/null
>>> +++ b/drivers/pinctrl/qcom/pinctrl-sm7150.c
>>> @@ -0,0 +1,142 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Pinctrl driver for Qualcomm SM7150
>>> + *
>>> + * (C) Copyright 2025 Danila Tikhonov <danila@jiaxyga.com>
>>> + * (C) Copyright 2025 Jens Reidel <adrian@mainlining.org>
>>> + *
>>> + * Based on Linux Kernel driver
>>> + */
>>> +
>>> +#include <dm.h>
>>> +
>>> +#include "pinctrl-qcom.h"
>>> +
>>> +#define WEST    0x00000000
>>> +#define NORTH    0x00400000
>>> +#define SOUTH    0x00800000
>>> +
>>> +#define MAX_PIN_NAME_LEN 32
>>> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>>> +
>>> +static const struct pinctrl_function msm_pinctrl_functions[] = {
>>> +    { "qup12", 1 },
>>> +    { "gpio",  0 },
>>> +    { "sdc2_clk", 0 } /* special pin GPIO124 */
>>> +};
>>> +
>>> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)    \
>>> +    {                        \
>>> +        .name = pg_name,            \
>>> +        .ctl_reg = ctl,                \
>>> +        .io_reg = 0,                \
>>> +        .pull_bit = pull,            \
>>> +        .drv_bit = drv,                \
>>> +        .oe_bit = -1,                \
>>> +        .in_bit = -1,                \
>>> +        .out_bit = -1,                \
>>> +    }
>>> +
>>> +#define UFS_RESET(pg_name, offset)            \
>>> +    {                        \
>>> +        .name = pg_name,            \
>>> +        .ctl_reg = offset,            \
>>> +        .io_reg = offset + 0x4,            \
>>> +        .pull_bit = 3,                \
>>> +        .drv_bit = 0,                \
>>> +        .oe_bit = -1,                \
>>> +        .in_bit = -1,                \
>>> +        .out_bit = 0,                \
>>> +    }
>>> +
>>> +static const struct msm_special_pin_data msm_special_pins_data[] = {
>>> +    [0] = UFS_RESET("ufs_reset", 0x9f000),
>>> +    [1] = SDC_QDSD_PINGROUP("sdc1_rclk", WEST + 0x9a000, 15, 0),
>>> +    [2] = SDC_QDSD_PINGROUP("sdc1_clk", WEST + 0x9a000, 13, 6),
>>> +    [3] = SDC_QDSD_PINGROUP("sdc1_cmd", WEST + 0x9a000, 11, 3),
>>> +    [4] = SDC_QDSD_PINGROUP("sdc1_data", WEST + 0x9a000, 9, 0),
>>> +    [5] = SDC_QDSD_PINGROUP("sdc2_clk", SOUTH + 0x98000, 14, 6),
>>> +    [6] = SDC_QDSD_PINGROUP("sdc2_cmd", SOUTH + 0x98000, 11, 3),
>>> +    [7] = SDC_QDSD_PINGROUP("sdc2_data", SOUTH + 0x98000, 9, 0),
>>> +};
>>> +
>>> +static const unsigned int sm7150_pin_offsets[] = {
>>> +    [0] = SOUTH,    [1] = SOUTH,    [2] = SOUTH,    [3] = SOUTH,
>>> +    [4] = NORTH,    [5] = NORTH,    [6] = NORTH,    [7] = NORTH,
>>> +    [8] = NORTH,    [9] = NORTH,    [10] = NORTH,    [11] = NORTH,
>>> +    [12] = SOUTH,    [13] = SOUTH,    [14] = SOUTH,    [15] = SOUTH,
>>> +    [16] = SOUTH,    [17] = SOUTH,    [18] = SOUTH,    [19] = SOUTH,
>>> +    [20] = SOUTH,    [21] = SOUTH,    [22] = SOUTH,    [23] = SOUTH,
>>> +    [24] = SOUTH,    [25] = SOUTH,    [26] = SOUTH,    [27] = SOUTH,
>>> +    [28] = SOUTH,    [29] = NORTH,    [30] = SOUTH,    [31] = WEST,
>>> +    [32] = NORTH,    [33] = NORTH,    [34] = SOUTH,    [35] = SOUTH,
>>> +    [36] = SOUTH,    [37] = SOUTH,    [38] = SOUTH,    [39] = SOUTH,
>>> +    [40] = SOUTH,    [41] = SOUTH,    [42] = NORTH,    [43] = NORTH,
>>> +    [44] = NORTH,    [45] = NORTH,    [46] = NORTH,    [47] = NORTH,
>>> +    [48] = WEST,    [49] = WEST,    [50] = WEST,    [51] = WEST,
>>> +    [52] = WEST,    [53] = WEST,    [54] = WEST,    [55] = WEST,
>>> +    [56] = WEST,    [57] = WEST,    [58] = WEST,    [59] = NORTH,
>>> +    [60] = NORTH,    [61] = NORTH,    [62] = NORTH,    [63] = NORTH,
>>> +    [64] = NORTH,    [65] = NORTH,    [66] = NORTH,    [67] = NORTH,
>>> +    [68] = NORTH,    [69] = NORTH,    [70] = NORTH,    [71] = NORTH,
>>> +    [72] = NORTH,    [73] = NORTH,    [74] = WEST,    [75] = WEST,
>>> +    [76] = WEST,    [77] = WEST,    [78] = WEST,    [79] = WEST,
>>> +    [80] = WEST,    [81] = WEST,    [82] = WEST,    [83] = WEST,
>>> +    [84] = WEST,    [85] = WEST,    [86] = NORTH,    [87] = NORTH,
>>> +    [88] = NORTH,    [89] = NORTH,    [90] = NORTH,    [91] = NORTH,
>>> +    [92] = NORTH,    [93] = NORTH,    [94] = SOUTH,    [95] = WEST,
>>> +    [96] = WEST,    [97] = WEST,    [98] = WEST,    [99] = WEST,
>>> +    [100] = WEST,    [101] = NORTH,    [102] = NORTH,    [103] = NORTH,
>>> +    [104] = WEST,    [105] = NORTH,    [106] = NORTH,    [107] = WEST,
>>> +    [108] = SOUTH,    [109] = SOUTH,    [110] = NORTH,    [111] =
>>> NORTH,
>>> +    [112] = NORTH,    [113] = NORTH,    [114] = NORTH,    [115] =
>>> NORTH,
>>> +    [116] = NORTH,    [117] = NORTH,    [118] = NORTH,
>>> +};
>>> +
>>> +static const char *sm7150_get_function_name(struct udevice *dev,
>>> unsigned int selector)
>>> +{
>>> +    return msm_pinctrl_functions[selector].name;
>>> +}
>>> +
>>> +static const char *sm7150_get_pin_name(struct udevice *dev,
>>> +                       unsigned int selector)
>>> +{
>>> +    if (selector >= 119 && selector <= 126)
>>
>> This should be && select <= 127, since there are 8 special pins.
>> We should really update all the drivers to use ARRAY_LENGTH macros
>> rather than doing all the maths by hand since so many have had errors at
>> this point ahaha
>>
>> Kind regards,
> 
> Are you sure? I think this is correct, since start and end of the
> range are inclusive, so 119-126 are 8 GPIOs in total. The total
> pin count is also 126.

Damn you're totally right! Apologies.

I guess at least I demonstrated my point about these magic numbers being
annoying to count XD

Kind regards,>
> Best regards,
> Jens
> 
>>> +        snprintf(pin_name, MAX_PIN_NAME_LEN,
>>> +             msm_special_pins_data[selector - 119].name);
>>> +    else
>>> +        snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>>> +
>>> +    return pin_name;
>>> +}
>>> +
>>> +static int sm7150_get_function_mux(__maybe_unused unsigned int pin,
>>> unsigned int selector)
>>> +{
>>> +    return msm_pinctrl_functions[selector].val;
>>> +}
>>> +
>>> +static struct msm_pinctrl_data sm7150_data = {
>>> +    .pin_data = {
>>> +        .pin_offsets = sm7150_pin_offsets,
>>> +        .pin_count = 126,
>>> +        .special_pins_start = 119,
>>> +        .special_pins_data = msm_special_pins_data,
>>> +    },
>>> +    .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>>> +    .get_function_name = sm7150_get_function_name,
>>> +    .get_function_mux = sm7150_get_function_mux,
>>> +    .get_pin_name = sm7150_get_pin_name,
>>> +};
>>> +
>>> +static const struct udevice_id msm_pinctrl_ids[] = {
>>> +    { .compatible = "qcom,sm7150-tlmm", .data = (ulong)&sm7150_data },
>>> +    { /* sentinel */ }
>>> +};
>>> +
>>> +U_BOOT_DRIVER(pinctrl_sm7150) = {
>>> +    .name        = "pinctrl_sm7150",
>>> +    .id        = UCLASS_NOP,
>>> +    .of_match    = msm_pinctrl_ids,
>>> +    .ops        = &msm_pinctrl_ops,
>>> +    .bind        = msm_pinctrl_bind,
>>> +};
>>

-- 
// Casey (she/her)

