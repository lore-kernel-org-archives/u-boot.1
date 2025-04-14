Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46311C369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 07:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A187E81F45;
	Mon, 14 Apr 2025 09:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="US4qUQ1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC8581F7E; Mon, 14 Apr 2025 09:25:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E196281F44
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 09:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so26755885e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744615500; x=1745220300; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BVZu4E6P28Jp388f4cuTUdgiNRIYtl+tRD2gEThfj2w=;
 b=US4qUQ1rPa4LuSi0ONlIwaAJf2A1yRFGhV+oexWYOCeXSNWjSd9ut6F9dcJP2SF8/l
 QatAyADzXDZrTWf1Cw00pUEDk0zD6Gs12kq6y8T+oQyWjXvqvwQ+G5jAuOhIIWLYoITq
 FzKVbqVpD46w8vUSw+xN64Nyc6iZXG8ad/vxCmhip3t302EeSoHEwMnyFsWM67Y+Xagy
 qAxQpBCfLsNyfs+8wRmKvsvEkkhqd+SK0B1MCu6KX1Fx1YsblGMgaq0tzcV3FYiMYd+H
 5xTtB6vyIx4MmqUN1sCKk4SSqn3Dn8TBo9cmROPgSNPOm6yqFxwy34AbAjeeBmdi3cBc
 yFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744615500; x=1745220300;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BVZu4E6P28Jp388f4cuTUdgiNRIYtl+tRD2gEThfj2w=;
 b=mHvEp+DuyWMIS+1DetmXY9lITq1+GpX4y2Y45g67Da7PxWlrAuZ7mRUs9xMmZKOURB
 yBsu+RddG4sCSpFESNaadIrgTE4qquY0yq6WhBfzR4AY/bVFJh2LIcGTZYX5LFlev/JV
 vNHDOm3dG7/l1J29+zwWrXsDcp2Sq6wKVdZ0BZXvKq/7xyOESh9gsZgJ/N6MXi2BauTG
 OaSSM+6rapwVrahg2N5P95VLoCMy2vjl7giuWqy3kps0rwJIYRwOqw6TZCsPKCboAUXK
 wffC63FoTGu0x6/ES6+W6CH87/uc4PA7dto6zzaCvY2z4WV3a3zcVHo6LQ+2BZ1cP757
 BNhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7cubuPrqutAj0FNTaGo0plKidI6AnPTNWRNlFSRmd4Jd/29ROleF0YbRUsD4ccSQndm/h868=@lists.denx.de
X-Gm-Message-State: AOJu0YyV/K4yOk/2Mb3v9J4m9MWaI+Y2MdsfXIP5hTs+FdOZZMacO1un
 2QUNT7kr65bjNrP2PUpJrEbnYFgAPtXj+8isX/N+AJj+p7LTEf1cTFOKlWr0SPk=
X-Gm-Gg: ASbGnctIhD/eRScZcm1dJDWkdS160xRwBNv0059atXNnCIvnWGrVk21v3toPA1sJ9QK
 gFfKJGMwO4vCubD6QNUZfUdnegaeUZiGtH6ZjdFAvCJ1Tekv06NOy/eYXFiQnBAFJblIT6xMqU+
 55D4hqPxTJbueMf4TKgx++h62+L84PjSqkCk9rarfgbDGTePeAphQL6j42ni52in2K52lTdaY7/
 sAE1iqut3ywRNdO7eAPNnlA7obqaA3yjHpBXdf7z++gG2e3kgRdSczS8sAeF+Ayw18pv+T98jff
 Z/ZtlCGj5qMQx3mgh+1t9i69LhWRg+7u6JX1+P/nN8ZwJ3Yn7efx1c2lh24pJ2W7MlNOMKjyngO
 1pyathdEQ4IojAD0xFQ==
X-Google-Smtp-Source: AGHT+IGaM57OBxfa+KgukZWGljA9JeiHoQrgcQmMH1cez3umtb1zIL8Ww+4E9Hy1fCK0n2AEsy/7aA==
X-Received: by 2002:a05:600c:a15:b0:43c:e8ca:5140 with SMTP id
 5b1f17b1804b1-43f3a9aa646mr90296065e9.23.1744615500243; 
 Mon, 14 Apr 2025 00:25:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bf8a:3473:5c13:9743?
 ([2a01:e0a:3d9:2080:bf8a:3473:5c13:9743])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2338d7d8sm173216205e9.4.2025.04.14.00.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 00:24:59 -0700 (PDT)
Message-ID: <af42fc39-2283-4eb6-8844-085b72356e11@linaro.org>
Date: Mon, 14 Apr 2025 09:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] watchdog: qcom: introduce qcom-wdt driver
To: Paul Sajna <hello@paulsajna.com>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250413-b4-qcom-wdt-v1-1-db42cb93dff8@paulsajna.com>
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
In-Reply-To: <20250413-b4-qcom-wdt-v1-1-db42cb93dff8@paulsajna.com>
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

Hi,

On 13/04/2025 12:12, Paul Sajna wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Some Qualcomm device vendors decide to turn the watchdog on in the
> bootloader, resulting in the device being reset if it isn't petted every
> ~30 seconds. Introduce a driver to disable the watchdog and prevent this
> annoying behaviour.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Paul Sajna <hello@paulsajna.com>
> Tested-by: Paul Sajna <hello@paulsajna.com>
> ---
> This patch introduces a simple watchdog driver for Qualcomm devices.
> 
> Some devices, including one I have been spending a lot of time with,
> the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
> seconds if the watchdog is not serviced.
> 
> I have tested this patch from Caleb Connolly that is over a year old and has
> not yet been upstreamed, and it is very useful to me. I can hardly use
> u-boot on this device without it. I have received Caleb's permission to
> work on upstreaming this patch.
> 
> This is my first contribution to U-Boot, and I am unfamiliar with
> mailing list workflows, so please be patient :)
> ---
>   configs/qcom_defconfig      |   2 +
>   drivers/watchdog/Kconfig    |   7 ++++
>   drivers/watchdog/Makefile   |   1 +
>   drivers/watchdog/qcom-wdt.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 110 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..0232f6d51c552bd06c8ba72b71edb5cb72fe0706 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -144,3 +144,5 @@ CONFIG_VIDEO_FONT_16X32=y
>   CONFIG_SYS_WHITE_ON_BLACK=y
>   CONFIG_NO_FB_CLEAR=y
>   CONFIG_VIDEO_SIMPLE=y
> +CONFIG_WDT_QCOM=y
> +CONFIG_WDT=y
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bb67f5035231df9f6ce01adb08d074855393143..808f4e578e28e7812f93b393a7f7d95d9501cdd4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -335,6 +335,13 @@ config WDT_K3_RTI_FW_FILE
>   
>   endif
>   
> +config WDT_QCOM
> +	bool "Qualcomm watchdog timer support"
> +	depends on WDT && ARCH_SNAPDRAGON
> +	help
> +	  Select this to enable Qualcomm watchdog timer, which can be found on
> +	  some Qualcomm chips.
> +
>   config WDT_SANDBOX
>   	bool "Enable Watchdog Timer support for Sandbox"
>   	depends on SANDBOX && WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index e6bd4c587af6133c405dde6dbada8050debc781c..5eaabd4aba58c815de4165f901aecfba0e0da255 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -54,3 +54,4 @@ obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>   obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
>   obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
>   obj-$(CONFIG_WDT_ADI) += adi_wdt.o
> +obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a7ce31ef811c717fd16700aa7d984a000763a93e
> --- /dev/null
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) Linaro Ltd. 2024
> + *
> + * Authors:
> + *   Caleb Connolly <caleb.connolly@linaro.org>
> + *
> + * Derived from linux/drivers/watchdog/qcom-wdt.c
> + */
> +
> +#include <dm.h>
> +#include <wdt.h>
> +
> +#include <asm/io.h>
> +
> +enum wdt_reg {
> +	WDT_RST,
> +	WDT_EN,
> +	WDT_STS,
> +	WDT_BARK_TIME,
> +	WDT_BITE_TIME,
> +};
> +
> +struct qcom_wdt_match_data {
> +	const u32 *offset;
> +};
> +
> +struct qcom_wdt {
> +	void __iomem *base;
> +	const u32 *layout;
> +};
> +
> +static const u32 reg_offset_data_kpss[] = {
> +	[WDT_RST] = 0x4,
> +	[WDT_EN] = 0x8,
> +	[WDT_STS] = 0xC,
> +	[WDT_BARK_TIME] = 0x10,
> +	[WDT_BITE_TIME] = 0x14,
> +};
> +
> +static const struct qcom_wdt_match_data match_data_kpss = {
> +	.offset = reg_offset_data_kpss,
> +};
> +
> +static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
> +{
> +	return wdt->base + wdt->layout[reg];
> +}
> +
> +int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	/* unimplemented */
> +	return 0;
> +}
> +
> +int qcom_wdt_stop(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	if (readl(wdt_addr(wdt, WDT_EN))) {
> +		printf("Failed to disable Qualcomm watchdog!\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_wdt_probe(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +	struct qcom_wdt_match_data *data = (void *)dev_get_driver_data(dev);
> +	int ret;
> +
> +	wdt->base = dev_read_addr_ptr(dev);
> +	wdt->layout = data->offset;
> +
> +	ret = qcom_wdt_stop(dev);

Fine but perhaps just add a simple code into qcom_wdt_start() and add
a reset callback to allow people to actually use the wdog from u-boot
with CONFIG_WATCHDOG_AUTOSTART and/or u-boot,autostart.

No need to implement set_timeout, we can use the bootloader value.

> +
> +	return ret;
> +}
> +
> +static const struct wdt_ops qcom_wdt_ops = {
> +	.stop = qcom_wdt_stop,

You forgot qcom_wdt_start()

> +};
> +
> +static const struct udevice_id qcom_wdt_ids[] = {
> +	{ .compatible = "qcom,kpss-wdt", .data = (ulong)&match_data_kpss },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(qcom_wdt) = {
> +	.name = "qcom_wdt",
> +	.id = UCLASS_WDT,
> +	.of_match = qcom_wdt_ids,
> +	.ops = &qcom_wdt_ops,
> +	.probe = qcom_wdt_probe,
> +	.priv_auto = sizeof(struct qcom_wdt),
> +};
> 
> ---
> base-commit: f3563fc30356c8079527b90e532407050dff7c7b
> change-id: 20250413-b4-qcom-wdt-e7b913fc375e
> 
> Best regards,


