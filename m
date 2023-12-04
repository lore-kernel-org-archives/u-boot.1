Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE51C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 13:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81F386F5E;
	Mon,  4 Dec 2023 14:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701695751;
	bh=kdGhJqZsT+16mqTbb0kNJWilfsB2j7cHXdGWiol7i8s=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G5crOK4YImvizCgvjD4kLd6vYfSqX27+geKgWjIt3vb6VT3mVu+f+ERy0sSeCyuQo
	 zxvsowt8pVdWs8yulEmu12UZOiyV63gO5vxms6wSwVFuejj7sP8D/71lSLpi5h9Xx4
	 LKTojbVZecsyqrANvVR+oT+B4m/HB8Pi3u8FaNQOJzZDll7JDD6nz9K7naxQVDJ16z
	 GBZQy2SLN9UtTaKBt2YLbns1Vug8Eb7Fc1cKacynHuga+OZ9ZeDR1Ju1akOpXfFa7z
	 oozwkygLrw1gshktcvVi5qK+5B8Y3sHQE/8tZGtfQAHZn8XUw3NmKNG9CI335SwPoF
	 NlrotfWr5NJ9w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8753986F6F; Mon,  4 Dec 2023 14:15:50 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C5C86EF1
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 14:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SkPLB1Vs9z9sSc;
 Mon,  4 Dec 2023 14:15:46 +0100 (CET)
Message-ID: <026596fc-2eb0-4934-8053-a6627d0b4cef@denx.de>
Date: Mon, 4 Dec 2023 14:15:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>, u-boot@lists.denx.de
References: <20231105231318.992857-1-chanho61.park@samsung.com>
 <CGME20231105231340epcas2p3622ab40737b5c1974435caa88e6a87b2@epcas2p3.samsung.com>
 <20231105231318.992857-3-chanho61.park@samsung.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231105231318.992857-3-chanho61.park@samsung.com>
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

On 11/6/23 00:13, Chanho Park wrote:
> Add to support StarFive watchdog driver. The driver is imported from
> linux kernel's drivers/watchdog/starfive-wdt.c without jh7100 support
> because there is no support of jh7100 SoC in u-boot yet.
> Howver, this patch has been kept the variant coding style because JH7100
> can be added later and have a consistency with the linux driver.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/watchdog/Kconfig        |   7 +
>   drivers/watchdog/Makefile       |   1 +
>   drivers/watchdog/starfive_wdt.c | 329 ++++++++++++++++++++++++++++++++
>   3 files changed, 337 insertions(+)
>   create mode 100644 drivers/watchdog/starfive_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 07fc4940e918..569726119ca1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -344,6 +344,13 @@ config WDT_STM32MP
>   	  Enable the STM32 watchdog (IWDG) driver. Enable support to
>   	  configure STM32's on-SoC watchdog.
>   
> +config WDT_STARFIVE
> +	bool "StarFive watchdog timer support"
> +	depends on WDT
> +	imply WATCHDOG
> +	help
> +	  Enable support for the watchdog timer of StarFive JH7110 SoC.
> +
>   config WDT_SUNXI
>   	bool "Allwinner sunxi watchdog timer support"
>   	depends on WDT && ARCH_SUNXI
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index eef786f5e74e..5520d3d9ae8a 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
>   obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
>   obj-$(CONFIG_WDT_SL28CPLD) += sl28cpld-wdt.o
>   obj-$(CONFIG_WDT_SP805) += sp805_wdt.o
> +obj-$(CONFIG_WDT_STARFIVE) += starfive_wdt.o
>   obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
>   obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>   obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
> diff --git a/drivers/watchdog/starfive_wdt.c b/drivers/watchdog/starfive_wdt.c
> new file mode 100644
> index 000000000000..ee9ec4cdc3a4
> --- /dev/null
> +++ b/drivers/watchdog/starfive_wdt.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Starfive Watchdog driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <reset.h>
> +#include <wdt.h>
> +#include <linux/iopoll.h>
> +
> +/* JH7110 Watchdog register define */
> +#define STARFIVE_WDT_JH7110_LOAD	0x000
> +#define STARFIVE_WDT_JH7110_VALUE	0x004
> +#define STARFIVE_WDT_JH7110_CONTROL	0x008	/*
> +						 * [0]: reset enable;
> +						 * [1]: interrupt enable && watchdog enable
> +						 * [31:2]: reserved.
> +						 */
> +#define STARFIVE_WDT_JH7110_INTCLR	0x00c	/* clear intterupt and reload the counter */
> +#define STARFIVE_WDT_JH7110_IMS		0x014
> +#define STARFIVE_WDT_JH7110_LOCK	0xc00	/* write 0x1ACCE551 to unlock */
> +
> +/* WDOGCONTROL */
> +#define STARFIVE_WDT_ENABLE			0x1
> +#define STARFIVE_WDT_EN_SHIFT			0
> +#define STARFIVE_WDT_RESET_EN			0x1
> +#define STARFIVE_WDT_JH7110_RST_EN_SHIFT	1
> +
> +/* WDOGLOCK */
> +#define STARFIVE_WDT_JH7110_UNLOCK_KEY		0x1acce551
> +
> +/* WDOGINTCLR */
> +#define STARFIVE_WDT_INTCLR			0x1
> +#define STARFIVE_WDT_JH7100_INTCLR_AVA_SHIFT	1	/* Watchdog can clear interrupt when 0 */
> +
> +#define STARFIVE_WDT_MAXCNT			0xffffffff
> +#define STARFIVE_WDT_DEFAULT_TIME		(15)
> +#define STARFIVE_WDT_DELAY_US			0
> +#define STARFIVE_WDT_TIMEOUT_US			10000
> +
> +/* module parameter */
> +#define STARFIVE_WDT_EARLY_ENA			0
> +
> +struct starfive_wdt_variant {
> +	unsigned int control;		/* Watchdog Control Resgister for reset enable */
> +	unsigned int load;		/* Watchdog Load register */
> +	unsigned int reload;		/* Watchdog Reload Control register */
> +	unsigned int enable;		/* Watchdog Enable Register */
> +	unsigned int value;		/* Watchdog Counter Value Register */
> +	unsigned int int_clr;		/* Watchdog Interrupt Clear Register */
> +	unsigned int unlock;		/* Watchdog Lock Register */
> +	unsigned int int_status;	/* Watchdog Interrupt Status Register */
> +
> +	u32 unlock_key;
> +	char enrst_shift;
> +	char en_shift;
> +	bool intclr_check;		/*  whether need to check it before clearing interrupt */
> +	char intclr_ava_shift;
> +	bool double_timeout;		/* The watchdog need twice timeout to reboot */
> +};
> +
> +struct starfive_wdt_priv {
> +	void __iomem *base;
> +	struct clk *core_clk;
> +	struct clk *apb_clk;
> +	struct reset_ctl_bulk *rst;
> +	const struct starfive_wdt_variant *variant;
> +	unsigned long freq;
> +	u32 count;			/* count of timeout */
> +	u32 reload;			/* restore the count */
> +};
> +
> +/* Register layout and configuration for the JH7110 */
> +static const struct starfive_wdt_variant starfive_wdt_jh7110_variant = {
> +	.control = STARFIVE_WDT_JH7110_CONTROL,
> +	.load = STARFIVE_WDT_JH7110_LOAD,
> +	.enable = STARFIVE_WDT_JH7110_CONTROL,
> +	.value = STARFIVE_WDT_JH7110_VALUE,
> +	.int_clr = STARFIVE_WDT_JH7110_INTCLR,
> +	.unlock = STARFIVE_WDT_JH7110_LOCK,
> +	.unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
> +	.int_status = STARFIVE_WDT_JH7110_IMS,
> +	.enrst_shift = STARFIVE_WDT_JH7110_RST_EN_SHIFT,
> +	.en_shift = STARFIVE_WDT_EN_SHIFT,
> +	.intclr_check = false,
> +	.double_timeout = true,
> +};
> +
> +static int starfive_wdt_enable_clock(struct starfive_wdt_priv *wdt)
> +{
> +	int ret;
> +
> +	ret = clk_enable(wdt->apb_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(wdt->core_clk);
> +	if (ret) {
> +		clk_disable(wdt->apb_clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void starfive_wdt_disable_clock(struct starfive_wdt_priv *wdt)
> +{
> +	clk_disable(wdt->core_clk);
> +	clk_disable(wdt->apb_clk);
> +}
> +
> +/* Write unlock-key to unlock. Write other value to lock. */
> +static void starfive_wdt_unlock(struct starfive_wdt_priv *wdt)
> +{
> +	writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
> +}
> +
> +static void starfive_wdt_lock(struct starfive_wdt_priv *wdt)
> +{
> +	writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
> +}
> +
> +/* enable watchdog interrupt to reset/reboot */
> +static void starfive_wdt_enable_reset(struct starfive_wdt_priv *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->variant->control);
> +	val |= STARFIVE_WDT_RESET_EN << wdt->variant->enrst_shift;
> +	writel(val, wdt->base + wdt->variant->control);
> +}
> +
> +/* waiting interrupt can be free to clear */
> +static int starfive_wdt_wait_int_free(struct starfive_wdt_priv *wdt)
> +{
> +	u32 value;
> +
> +	return readl_poll_timeout(wdt->base + wdt->variant->int_clr, value,
> +				  !(value & BIT(wdt->variant->intclr_ava_shift)),
> +				  STARFIVE_WDT_TIMEOUT_US);
> +}
> +
> +/* clear interrupt signal before initialization or reload */
> +static int starfive_wdt_int_clr(struct starfive_wdt_priv *wdt)
> +{
> +	int ret;
> +
> +	if (wdt->variant->intclr_check) {
> +		ret = starfive_wdt_wait_int_free(wdt);
> +		if (ret)
> +			return ret;
> +	}
> +	writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->variant->int_clr);
> +
> +	return 0;
> +}
> +
> +static inline void starfive_wdt_set_count(struct starfive_wdt_priv *wdt,
> +					  u32 val)
> +{
> +	writel(val, wdt->base + wdt->variant->load);
> +}
> +
> +/* enable watchdog */
> +static inline void starfive_wdt_enable(struct starfive_wdt_priv *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->variant->enable);
> +	val |= STARFIVE_WDT_ENABLE << wdt->variant->en_shift;
> +	writel(val, wdt->base + wdt->variant->enable);
> +}
> +
> +/* disable watchdog */
> +static inline void starfive_wdt_disable(struct starfive_wdt_priv *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->variant->enable);
> +	val &= ~(STARFIVE_WDT_ENABLE << wdt->variant->en_shift);
> +	writel(val, wdt->base + wdt->variant->enable);
> +}
> +
> +static inline void starfive_wdt_set_reload_count(struct starfive_wdt_priv *wdt,
> +						 u32 count)
> +{
> +	starfive_wdt_set_count(wdt, count);
> +
> +	/* 7100 need set any value to reload register and could reload value to counter */
> +	if (wdt->variant->reload)
> +		writel(0x1, wdt->base + wdt->variant->reload);
> +}
> +
> +static int starfive_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	int ret;
> +	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
> +
> +	starfive_wdt_unlock(wdt);
> +	/* disable watchdog, to be safe */
> +	starfive_wdt_disable(wdt);
> +
> +	starfive_wdt_enable_reset(wdt);
> +	ret = starfive_wdt_int_clr(wdt);
> +	if (ret)
> +		goto exit;
> +
> +	wdt->count = (timeout_ms / 1000) * wdt->freq;
> +	if (wdt->variant->double_timeout)
> +		wdt->count /= 2;
> +
> +	starfive_wdt_set_count(wdt, wdt->count);
> +	starfive_wdt_enable(wdt);
> +
> +exit:
> +	starfive_wdt_lock(wdt);
> +	return ret;
> +}
> +
> +static int starfive_wdt_stop(struct udevice *dev)
> +{
> +	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
> +
> +	starfive_wdt_unlock(wdt);
> +	starfive_wdt_disable(wdt);
> +	starfive_wdt_lock(wdt);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_reset(struct udevice *dev)
> +{
> +	int ret;
> +	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
> +
> +	starfive_wdt_unlock(wdt);
> +	ret = starfive_wdt_int_clr(wdt);
> +	if (ret)
> +		goto exit;
> +
> +	starfive_wdt_set_reload_count(wdt, wdt->count);
> +
> +exit:
> +	starfive_wdt_lock(wdt);
> +
> +	return ret;
> +}
> +
> +static const struct wdt_ops starfive_wdt_ops = {
> +	.start = starfive_wdt_start,
> +	.stop = starfive_wdt_stop,
> +	.reset = starfive_wdt_reset,
> +};
> +
> +static int starfive_wdt_probe(struct udevice *dev)
> +{
> +	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = starfive_wdt_enable_clock(wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_deassert_bulk(wdt->rst);
> +	if (ret)
> +		goto err_reset;
> +
> +	wdt->variant = (const struct starfive_wdt_variant *)dev_get_driver_data(dev);
> +
> +	wdt->freq = clk_get_rate(wdt->core_clk);
> +	if (!wdt->freq) {
> +		ret = -EINVAL;
> +		goto err_get_freq;
> +	}
> +
> +	return 0;
> +
> +err_get_freq:
> +	reset_assert_bulk(wdt->rst);
> +err_reset:
> +	starfive_wdt_disable_clock(wdt);
> +
> +	return ret;
> +}
> +
> +static int starfive_wdt_of_to_plat(struct udevice *dev)
> +{
> +	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
> +
> +	wdt->base = (void *)dev_read_addr(dev);
> +	if (!wdt->base)
> +		return -ENODEV;
> +
> +	wdt->apb_clk = devm_clk_get(dev, "apb");
> +	if (IS_ERR(wdt->apb_clk))
> +		return -ENODEV;
> +
> +	wdt->core_clk = devm_clk_get(dev, "core");
> +	if (IS_ERR(wdt->core_clk))
> +		return -ENODEV;
> +
> +	wdt->rst = devm_reset_bulk_get(dev);
> +	if (IS_ERR(wdt->rst))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id starfive_wdt_ids[] = {
> +	{
> +		.compatible = "starfive,jh7110-wdt",
> +		.data = (ulong)&starfive_wdt_jh7110_variant
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +U_BOOT_DRIVER(starfive_wdt) = {
> +	.name = "starfive_wdt",
> +	.id = UCLASS_WDT,
> +	.of_match = starfive_wdt_ids,
> +	.priv_auto = sizeof(struct starfive_wdt_priv),
> +	.probe = starfive_wdt_probe,
> +	.of_to_plat = starfive_wdt_of_to_plat,
> +	.ops = &starfive_wdt_ops,
> +};

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
