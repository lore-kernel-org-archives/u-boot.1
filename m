Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58545C369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E05820E2;
	Wed, 23 Apr 2025 16:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JmznxkK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9188D80F03; Wed, 23 Apr 2025 13:55:43 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34EC8059D
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 13:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so6835828f8f.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745409340; x=1746014140; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lqIcabe56xJIgGuPglKjFMP3emZolTgCziiSFFKPn5E=;
 b=JmznxkK5Yp5DjomcxYdc/STtKQ1U5Zg+GWhd5MX35Ls/3N3hSFxk8jqQNMiFQp11r1
 eLVFps/oRgty9G6oYMXWSd6I/Kmx/yNEAcV9W4Zf4NQ0z3kBkQDNqwoWLFBsUIVdCKrf
 M8VuoIKi5s1iO58ZfP+VIHYL45GzaHqnoAy3Il3REi0x/kHMlj82lWxxQ5CCyKiSSmTu
 TRZytPzBLdOpEbprGN+swO5zCUOJoGioticTd/O0LpUxj5O9ux1UkIImgrpCxEWIGoWT
 ouh23KC+kbAuKEBCG2yIJDH2XEZ72cKAc/w2lxVR85O9yPkUZBxHkcjwgppj3uH9hKPB
 7CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745409340; x=1746014140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lqIcabe56xJIgGuPglKjFMP3emZolTgCziiSFFKPn5E=;
 b=b/44U7X43wOdJrl7cEX+ZCa7Fic/iUUcmT8kfLK4pgm0gifTYZSlJhgouS4c6qpDdw
 2cGkIsIOfiLMQuuSndnLOkdxKM+R0UA0RCc/n9O9oMFmFuC89mm5eVmFljcoM2tblLxF
 eEJ0WJ2OJZn1HMdMEZXBCdwL69VGu9rugOnDHRihb4+TwGvDIXBjHNPP+23+EmC0M8iW
 4Ow9ctc8bUrUgR3HkqU0gXfmTyZMOjyVvnHpZmHZFn4K4Al9w3jLR03ZwfPdBSvXPRUf
 BpUsgB8tr7MyCg+drPSfNDYGZ+u7HQnvDtd2gLlOofGHqpLaqemQxwiTG1WyDwRup2Ps
 Ilpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsMUa4E8GnWepRlxUTOme5RNt/aTS1GLd+Ccsnje5aZW4K8ofV1bwtuRGuj2Gi8YrKCO1ZmPQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2JMmlGKfOQmzyg9nvCtLmF4CL+ncu+mwa10U+f6ryH9VkKbgw
 0zs/SpxYRBbCLpJ3KkqxylnQwGowazqn9zp2x5gD7vooBmJj5PUrhNENOwsGfbk=
X-Gm-Gg: ASbGncuZFlj+ci0Fn/8p+VlaAK3mwUGSLLaNqpQMgOHujbUoWZmCwb19eg3cn6Zq2S4
 J1Z2kFS6RSF5CYfA9uEePzsfhwwj6eiwPCJHozHpDq3P7qXuAEReULNJS9TrGEcIoz0UX5jMP1F
 BrxrUPJiIWbaX82mOWz7S7DxhccHFKIInSzGQU3FGlA18W6hNrXWa4XrWmLmnVAyB7cGtLD2s7Z
 FPNdJuvhfACPQQ4zsf+vyjStL+ApWotx47qyA5xHdN4oZ2XmRPDQSl1tQjIcIv70wFhoc5wAs42
 5SJBK+FzSRFHQgTfIHJhC5qenbjqOfptanYQZpblckBKm5pBCmDEFaYRoOcYqcwZM1VAjVc=
X-Google-Smtp-Source: AGHT+IEUPltu9jKUFwGn66lqrWkiKyC2v4KokA7tFiQzckvDgyfOVVtzhr/stm4SWu1qRqWvvL72GA==
X-Received: by 2002:a05:6000:4308:b0:390:f6aa:4e7c with SMTP id
 ffacd0b85a97d-39efba5e837mr15151362f8f.28.1745409340115; 
 Wed, 23 Apr 2025 04:55:40 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092db2bd5sm23318795e9.26.2025.04.23.04.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:55:39 -0700 (PDT)
Message-ID: <ff8bdd8e-c206-4bf7-824f-eb482507d53b@linaro.org>
Date: Wed, 23 Apr 2025 13:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] watchdog: qcom: introduce qcom-wdt driver
To: Paul Sajna <hello@paulsajna.com>, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
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

Hi Paul,

Thanks for making it through the process :D LGTM.

Kind regards,

On 4/23/25 04:19, Paul Sajna wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Some Qualcomm device vendors decide to turn the watchdog on in the
> bootloader, resulting in the device being reset if it isn't petted every
> ~30 seconds. Introduce a driver to keep the watchdog happy and prevent this
> annoying behaviour.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Paul Sajna <hello@paulsajna.com>
> Co-authored-by: Paul Sajna <hello@paulsajna.com>
> Tested-by: Paul Sajna <hello@paulsajna.com>
> ---
> This patch introduces a simple watchdog driver for Qualcomm devices.
> 
> Some devices, including one I have been spending a lot of time with,
> the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
> seconds if the watchdog is not serviced.
> 
> I have tested this patch from Casey Connolly that is over a year old and has
> not yet been upstreamed, and it is very useful to me. I can hardly use
> u-boot on this device without it. I have received Casey's permission to
> work on upstreaming this patch.
> 
> This is my first contribution to U-Boot, and I am unfamiliar with
> mailing list workflows, so please be patient :)
> ---
> Changes in v3:
> - Squash commit 1 and 2
> - remove duplicated line of code
> - Link to v2: https://lore.kernel.org/r/20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com
> 
> Changes in v2:
> - Add watchdog start
> - Add watchdog reset
> - Remove stop from the probe function
> - Use dev_err instead of printf
> - Update Casey's name
> - Add myself as an author
> -
> - Link to v1: https://lore.kernel.org/r/20250413-b4-qcom-wdt-v1-1-db42cb93dff8@paulsajna.com
> ---
>   configs/qcom_defconfig      |   2 +
>   drivers/watchdog/Kconfig    |   7 +++
>   drivers/watchdog/Makefile   |   1 +
>   drivers/watchdog/qcom-wdt.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 127 insertions(+)
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
> index 0000000000000000000000000000000000000000..3601ba93774730f78574b2fd74b8c513e7ce22e1
> --- /dev/null
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) Linaro Ltd. 2024
> + *
> + * Authors:
> + *   Casey Connolly <casey.connolly@linaro.org>
> + *   Paul Sajna <hello@paulsajna.com>
> + *
> + * Derived from linux/drivers/watchdog/qcom-wdt.c
> + */
> +
> +#include <dm.h>
> +#include <dm/device_compat.h>
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
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(1, wdt_addr(wdt, WDT_EN));
> +	if (readl(wdt_addr(wdt, WDT_EN)) != 1) {
> +		dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +int qcom_wdt_stop(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	if (readl(wdt_addr(wdt, WDT_EN))) {
> +		dev_err(dev, "Failed to disable Qualcomm watchdog!\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +int qcom_wdt_reset(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	return 0;
> +}
> +
> +static int qcom_wdt_probe(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +	struct qcom_wdt_match_data *data = (void *)dev_get_driver_data(dev);
> +
> +	wdt->base = dev_read_addr_ptr(dev);
> +	wdt->layout = data->offset;
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops qcom_wdt_ops = {
> +	.start = qcom_wdt_start,
> +	.stop = qcom_wdt_stop,
> +	.reset = qcom_wdt_reset,
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
> base-commit: 0eebdd17888005751cd77cf3794c5292d36f481a
> change-id: 20250413-b4-qcom-wdt-e7b913fc375e
> 
> Best regards,

-- 
Casey (she/they)

