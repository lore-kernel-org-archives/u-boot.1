Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE10C369D3
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 07:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CADC080FA8;
	Wed, 23 Apr 2025 09:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eexhmx1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8A280FDA; Wed, 23 Apr 2025 09:02:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4D5C80EE5
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 09:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7C2CD5C5E82;
 Wed, 23 Apr 2025 07:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762A6C4CEE2;
 Wed, 23 Apr 2025 07:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745391748;
 bh=wrnXoqLBLRP/o3HuRaXWP7JDz1R+CSureYWl2dmeoEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Eexhmx1txp6k/SDmMbvyYxq/Ks6S/31j8sRs6sUOCoFtYcUUgOXcj6Ydq3BdrVrka
 cHKcV2Prb4g2SkTew7PhvbL3MZAA9+pGIHtwvQqkZ5hN0Pv6kMEEpcinxbK7ey5WmW
 N0wrUwF6cXshU3r4x0C6RtYmQUmbB+JbjdjRmrngh4qjL8sdj8U9ePBeDGzQ4Mo1wH
 GX4hTCpN/bpI8DtN6vHS6fHBUgfZhIda4iRHoQ2L3iQtYjAA1RPn8qhpkXyxs2cElx
 eTMIqVGrXrBZowOIim7sm7loDpbLsdjE0t0vw7IDKiyac7GXk8LHO1FiugOnjREMmB
 tkeKH3pDLbWCw==
Date: Wed, 23 Apr 2025 12:32:22 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Paul Sajna <hello@paulsajna.com>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: Re: [PATCH v3] watchdog: qcom: introduce qcom-wdt driver
Message-ID: <aAiQfnEwgwBQbznn@sumit-X1>
References: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
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

On Wed, Apr 23, 2025 at 02:19:39AM +0000, Paul Sajna wrote:
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
>  configs/qcom_defconfig      |   2 +
>  drivers/watchdog/Kconfig    |   7 +++
>  drivers/watchdog/Makefile   |   1 +
>  drivers/watchdog/qcom-wdt.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 127 insertions(+)
>

Looks reasonable to me, FWIW:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..0232f6d51c552bd06c8ba72b71edb5cb72fe0706 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -144,3 +144,5 @@ CONFIG_VIDEO_FONT_16X32=y
>  CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_NO_FB_CLEAR=y
>  CONFIG_VIDEO_SIMPLE=y
> +CONFIG_WDT_QCOM=y
> +CONFIG_WDT=y
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bb67f5035231df9f6ce01adb08d074855393143..808f4e578e28e7812f93b393a7f7d95d9501cdd4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -335,6 +335,13 @@ config WDT_K3_RTI_FW_FILE
>  
>  endif
>  
> +config WDT_QCOM
> +	bool "Qualcomm watchdog timer support"
> +	depends on WDT && ARCH_SNAPDRAGON
> +	help
> +	  Select this to enable Qualcomm watchdog timer, which can be found on
> +	  some Qualcomm chips.
> +
>  config WDT_SANDBOX
>  	bool "Enable Watchdog Timer support for Sandbox"
>  	depends on SANDBOX && WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index e6bd4c587af6133c405dde6dbada8050debc781c..5eaabd4aba58c815de4165f901aecfba0e0da255 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -54,3 +54,4 @@ obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>  obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
>  obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
>  obj-$(CONFIG_WDT_ADI) += adi_wdt.o
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
> -- 
> Paul Sajna <hello@paulsajna.com>
> 
> 
