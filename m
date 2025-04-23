Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF94C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 07:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E590E80EE5;
	Wed, 23 Apr 2025 09:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SL8knNIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D4380F03; Wed, 23 Apr 2025 09:31:30 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1684E80BA8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 09:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so29276505e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745393487; x=1745998287; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BVLvS8BrUNK53ymjN9fzFohjYebq4XvIeoOmTvmODkw=;
 b=SL8knNIy0RrBz3lV6YJRkZVxKRkqk+fwR1lvIGJQSqzcSeEg3MEFcnYl6C85LUHbk7
 +7GsqcpDG06O4bNC98GLO2gkGmaR3jB4USQGHCZvPbMmCmNvpbv2AQe42Gq10RWT6xZR
 6J+2LdxTojhPVZFUTKQEoYvixV1ngmIAIGC3o1jU308gi9GxGEcpypb+d3LmKfnXHGkT
 z365aBd/LVy72N9If223y/90IUZ7Xl2glEzPNdubbD/bdhmOesBSk37d5SXLMFqsInOY
 m1guhSgPQpGXGGdUUsWc14KWszvG/9/XQKKpP6JU8Hbao49j/1IwVPDj9I4XdRS982KH
 EdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745393487; x=1745998287;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BVLvS8BrUNK53ymjN9fzFohjYebq4XvIeoOmTvmODkw=;
 b=AEGjQ0pQsV2CWfdg2AhsXVVpw+VIuolBiYPFRy29VLEGELvxdhtPRELREuCWme0uD6
 kkJ8mS9zoiX/3I9+vsiMSMWOnjTOjPJ91CtRSwu5UlbXKJObYrzGJZVGhOvG3RP0WI+f
 ibSnXYglPF+eWpHkf87+LVC7Nqino3lIs0fxUenADxvxDAZpYxks1vcajPy1yNIB3hGd
 lpwQDBaGjoCJckGW9a6he2RiZqYyMgU2kPmaeb2yQIc066VWK5hLqql8mK0N/wiNSfDW
 bqRBeb0fsCibnf1zEOcIrbN3w+O9ypMDZpL2NwQRZsOU5eESN7IfmojjkuC81OLNyrHX
 LPWQ==
X-Gm-Message-State: AOJu0YxQMprlqeU/IgVFZ/6XJ59w8AUsLbxzlK6pL0usrmxsDbfHrZHQ
 kR0LU0HW/kC6YdsZueVyurHXp/fpjQxVAb568z/9uYpCjVYPz19SDq2PhtslHb4=
X-Gm-Gg: ASbGncs1OmQgfFWTqBosG8J7h0y4ygox7yODglFzNVhHhwTX+nJYOZsk++E0LznNlwj
 C3g3T9JlIOF6/wDzUj/jnx3hj4Cc71ZUtGDntN+RlvKfaOKOAqeoqjO7yMnhQkJBMuryJN2n1JK
 HWIgAk8a7JBygnK1thfPaA7iY0RsanX6RyeUBMy9pZ4E7ulWoyD1uTmUOwaFeB1C9bYA4hC9EjR
 CoRSoxpZK1JPFr8T49A6LCLKNEAk5UNKcF3pKd7UuGdTSeFItjyDXBaAbBOcpigXroFQlbUsK7i
 omqpX6qz4898MM0HetEr+jLDVf/7l5gEoMy0gbVUMS/4M3dexjKH99tsAYE3swbpSY6mqNNGakp
 Zk5IHL9SEcJjp03kz/w==
X-Google-Smtp-Source: AGHT+IFe0yQOJyW6QhlHfOg7UQgVMbLP2jGu26x74PcvC21V8ypsqiOXxp2JFUMYlNnC2kq6t+DqvA==
X-Received: by 2002:a05:600c:1554:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-4406ab676abmr138679075e9.1.1745393486254; 
 Wed, 23 Apr 2025 00:31:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2835:c2f4:c226:77dd?
 ([2a01:e0a:3d9:2080:2835:c2f4:c226:77dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2d558sm15438265e9.17.2025.04.23.00.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 00:31:25 -0700 (PDT)
Message-ID: <e3911465-412b-4149-a6c8-9441462c8a17@linaro.org>
Date: Wed, 23 Apr 2025 09:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] watchdog: qcom: introduce qcom-wdt driver
To: Sumit Garg <sumit.garg@kernel.org>, Paul Sajna <hello@paulsajna.com>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
 <aAiQfnEwgwBQbznn@sumit-X1>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <aAiQfnEwgwBQbznn@sumit-X1>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 23/04/2025 09:02, Sumit Garg wrote:
> On Wed, Apr 23, 2025 at 02:19:39AM +0000, Paul Sajna wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>>
>> Some Qualcomm device vendors decide to turn the watchdog on in the
>> bootloader, resulting in the device being reset if it isn't petted every
>> ~30 seconds. Introduce a driver to keep the watchdog happy and prevent this
>> annoying behaviour.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Paul Sajna <hello@paulsajna.com>
>> Co-authored-by: Paul Sajna <hello@paulsajna.com>
>> Tested-by: Paul Sajna <hello@paulsajna.com>
>> ---
>> This patch introduces a simple watchdog driver for Qualcomm devices.
>>
>> Some devices, including one I have been spending a lot of time with,
>> the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
>> seconds if the watchdog is not serviced.
>>
>> I have tested this patch from Casey Connolly that is over a year old and has
>> not yet been upstreamed, and it is very useful to me. I can hardly use
>> u-boot on this device without it. I have received Casey's permission to
>> work on upstreaming this patch.
>>
>> This is my first contribution to U-Boot, and I am unfamiliar with
>> mailing list workflows, so please be patient :)
>> ---
>> Changes in v3:
>> - Squash commit 1 and 2
>> - remove duplicated line of code
>> - Link to v2: https://lore.kernel.org/r/20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com
>>
>> Changes in v2:
>> - Add watchdog start
>> - Add watchdog reset
>> - Remove stop from the probe function
>> - Use dev_err instead of printf
>> - Update Casey's name
>> - Add myself as an author
>> -
>> - Link to v1: https://lore.kernel.org/r/20250413-b4-qcom-wdt-v1-1-db42cb93dff8@paulsajna.com
>> ---
>>   configs/qcom_defconfig      |   2 +
>>   drivers/watchdog/Kconfig    |   7 +++
>>   drivers/watchdog/Makefile   |   1 +
>>   drivers/watchdog/qcom-wdt.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 127 insertions(+)
>>
> 
> Looks reasonable to me, FWIW:
> 
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> -Sumit
> 
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..0232f6d51c552bd06c8ba72b71edb5cb72fe0706 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -144,3 +144,5 @@ CONFIG_VIDEO_FONT_16X32=y
>>   CONFIG_SYS_WHITE_ON_BLACK=y
>>   CONFIG_NO_FB_CLEAR=y
>>   CONFIG_VIDEO_SIMPLE=y
>> +CONFIG_WDT_QCOM=y
>> +CONFIG_WDT=y
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 1bb67f5035231df9f6ce01adb08d074855393143..808f4e578e28e7812f93b393a7f7d95d9501cdd4 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -335,6 +335,13 @@ config WDT_K3_RTI_FW_FILE
>>   
>>   endif
>>   
>> +config WDT_QCOM
>> +	bool "Qualcomm watchdog timer support"
>> +	depends on WDT && ARCH_SNAPDRAGON
>> +	help
>> +	  Select this to enable Qualcomm watchdog timer, which can be found on
>> +	  some Qualcomm chips.
>> +
>>   config WDT_SANDBOX
>>   	bool "Enable Watchdog Timer support for Sandbox"
>>   	depends on SANDBOX && WDT
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index e6bd4c587af6133c405dde6dbada8050debc781c..5eaabd4aba58c815de4165f901aecfba0e0da255 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -54,3 +54,4 @@ obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>>   obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
>>   obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
>>   obj-$(CONFIG_WDT_ADI) += adi_wdt.o
>> +obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
>> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..3601ba93774730f78574b2fd74b8c513e7ce22e1
>> --- /dev/null
>> +++ b/drivers/watchdog/qcom-wdt.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>> + * Copyright (c) Linaro Ltd. 2024
>> + *
>> + * Authors:
>> + *   Casey Connolly <casey.connolly@linaro.org>
>> + *   Paul Sajna <hello@paulsajna.com>
>> + *
>> + * Derived from linux/drivers/watchdog/qcom-wdt.c
>> + */
>> +
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <wdt.h>
>> +
>> +#include <asm/io.h>
>> +
>> +enum wdt_reg {
>> +	WDT_RST,
>> +	WDT_EN,
>> +	WDT_STS,
>> +	WDT_BARK_TIME,
>> +	WDT_BITE_TIME,
>> +};
>> +
>> +struct qcom_wdt_match_data {
>> +	const u32 *offset;
>> +};
>> +
>> +struct qcom_wdt {
>> +	void __iomem *base;
>> +	const u32 *layout;
>> +};
>> +
>> +static const u32 reg_offset_data_kpss[] = {
>> +	[WDT_RST] = 0x4,
>> +	[WDT_EN] = 0x8,
>> +	[WDT_STS] = 0xC,
>> +	[WDT_BARK_TIME] = 0x10,
>> +	[WDT_BITE_TIME] = 0x14,
>> +};
>> +
>> +static const struct qcom_wdt_match_data match_data_kpss = {
>> +	.offset = reg_offset_data_kpss,
>> +};
>> +
>> +static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
>> +{
>> +	return wdt->base + wdt->layout[reg];
>> +}
>> +
>> +int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>> +{
>> +	struct qcom_wdt *wdt = dev_get_priv(dev);
>> +
>> +	writel(0, wdt_addr(wdt, WDT_EN));
>> +	writel(1, wdt_addr(wdt, WDT_RST));
>> +	writel(1, wdt_addr(wdt, WDT_EN));
>> +	if (readl(wdt_addr(wdt, WDT_EN)) != 1) {
>> +		dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
>> +		return -EIO;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int qcom_wdt_stop(struct udevice *dev)
>> +{
>> +	struct qcom_wdt *wdt = dev_get_priv(dev);
>> +
>> +	writel(0, wdt_addr(wdt, WDT_EN));
>> +	if (readl(wdt_addr(wdt, WDT_EN))) {
>> +		dev_err(dev, "Failed to disable Qualcomm watchdog!\n");
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int qcom_wdt_reset(struct udevice *dev)
>> +{
>> +	struct qcom_wdt *wdt = dev_get_priv(dev);
>> +
>> +	writel(1, wdt_addr(wdt, WDT_RST));
>> +	return 0;
>> +}
>> +
>> +static int qcom_wdt_probe(struct udevice *dev)
>> +{
>> +	struct qcom_wdt *wdt = dev_get_priv(dev);
>> +	struct qcom_wdt_match_data *data = (void *)dev_get_driver_data(dev);
>> +
>> +	wdt->base = dev_read_addr_ptr(dev);
>> +	wdt->layout = data->offset;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct wdt_ops qcom_wdt_ops = {
>> +	.start = qcom_wdt_start,
>> +	.stop = qcom_wdt_stop,
>> +	.reset = qcom_wdt_reset,
>> +};
>> +
>> +static const struct udevice_id qcom_wdt_ids[] = {
>> +	{ .compatible = "qcom,kpss-wdt", .data = (ulong)&match_data_kpss },
>> +	{}
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_wdt) = {
>> +	.name = "qcom_wdt",
>> +	.id = UCLASS_WDT,
>> +	.of_match = qcom_wdt_ids,
>> +	.ops = &qcom_wdt_ops,
>> +	.probe = qcom_wdt_probe,
>> +	.priv_auto = sizeof(struct qcom_wdt),
>> +};
>>
>> ---
>> base-commit: 0eebdd17888005751cd77cf3794c5292d36f481a
>> change-id: 20250413-b4-qcom-wdt-e7b913fc375e
>>
>> Best regards,
>> -- 
>> Paul Sajna <hello@paulsajna.com>
>>
>>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
