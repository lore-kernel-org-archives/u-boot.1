Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98802CDDE64
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 10:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2437A8926F;
	Wed, 23 Oct 2024 12:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729680784;
	bh=zxxvhVMoigjgweXgya0omVT6Z+7OCJY79A8lKojYfiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0IRnKmmiPL6A3TtpCAlmwSsqiqjSIkGLcv0vSuUZCdRQl8W0Aq6+YwJETkcUWk9qG
	 0loc8oweY5Z/8Y1EaOwDtfpZF87a/zkyqRzUP7yL7wNDXdRum2ztoApIr3NBTipZbt
	 y+zEMDX8VaJdu167SXai/2PUmow4QZlLZWBPZcpRzLkB40DNZNfkuhnzIs8H5S/5xT
	 CgkuIeLoZIEtay7L6C0XIbRssQXYbuPk93Qc9WrKvmDU5PrH8Up8E+z2yt53YBcZq6
	 asZPfquEdRq/4cByITFcBjNpQwr8oBNcAt8vz3DXhqz4roRizbdXFirgNLgdLW+Ve+
	 QmnosCOrtzvEQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77FC892BA; Wed, 23 Oct 2024 12:53:03 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E975A88A9D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 12:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XYQqq67wKz9shL;
 Wed, 23 Oct 2024 12:52:55 +0200 (CEST)
Message-ID: <e88046b4-431b-4553-92a0-4f95a0bc41d4@denx.de>
Date: Wed, 23 Oct 2024 12:52:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drivers: watchdog: Add DaVinci's watchdog support
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241003084255.33478-1-bastien.curutchet@bootlin.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003084255.33478-1-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XYQqq67wKz9shL
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

On 10/3/24 10:42, Bastien Curutchet wrote:
> Add support for the DaVinci's watchdog timer
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Applied to u-boot-watchdog/master

Thanks,
Stefan

> ---
>   drivers/watchdog/Kconfig       |   7 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/davinci_wdt.c | 131 +++++++++++++++++++++++++++++++++
>   3 files changed, 139 insertions(+)
>   create mode 100644 drivers/watchdog/davinci_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0c3e991331..a1c50b3f1f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -169,6 +169,13 @@ config WDT_CORTINA
>   	  This driver support all CPU ISAs supported by Cortina
>   	  Access CAxxxx SoCs.
>   
> +config WDT_DAVINCI
> +	bool "DaVinci watchdog timer support"
> +	depends on WDT
> +	help
> +	  Select this to enable the watchdog timer for DaVinci SoCs such as the
> +	  OMAP-L138.
> +
>   config WDT_GPIO
>   	bool "External gpio watchdog support"
>   	depends on WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7b39adcf0f..ad3053998a 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_WDT_BOOKE) += booke_wdt.o
>   obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
>   obj-$(CONFIG_WDT_ORION) += orion_wdt.o
>   obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
> +obj-$(CONFIG_WDT_DAVINCI) += davinci_wdt.o
>   obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
>   obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
>   obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> new file mode 100644
> index 0000000000..fa8d7842e9
> --- /dev/null
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DaVinci Watchdog driver
> + *
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <wdt.h>
> +
> +/* Control Register */
> +#define DAVINCI_WDT_ID			0x00
> +#define DAVINCI_WDT_TIM12		0x10
> +#define DAVINCI_WDT_TIM34		0x14
> +#define DAVINCI_WDT_PRD12		0x18
> +#define DAVINCI_WDT_PRD34		0x1C
> +#define DAVINCI_WDT_TCR			0x20
> +#define DAVINCI_WDT_TGCR		0x24
> +#define DAVINCI_WDT_WDTCR		0x28
> +
> +#define DAVINCI_TCR_CONT_EN		BIT(7)
> +
> +#define DAVINCI_TGCR_PLUSEN		BIT(4)
> +#define DAVINCI_TGCR_WDT_MODE		BIT(3)
> +#define DAVINCI_TGCR_TIM34RS		BIT(1)
> +#define DAVINCI_TGCR_TIM12RS		BIT(0)
> +
> +#define DAVINCI_WDTCR_INVALID_KEY	(0x5555 << 16)
> +#define DAVINCI_WDTCR_WDKEY0		(0xA5C6 << 16)
> +#define DAVINCI_WDTCR_WDKEY1		(0xDA7E << 16)
> +#define DAVINCI_WDTCR_WDFLAG		BIT(15)
> +#define DAVINCI_WDTCR_WDEN		BIT(14)
> +
> +#define DEFAULT_THRESHOLD		0xA03200000
> +
> +struct davinci_wdt_priv {
> +	void __iomem *base;
> +	struct clk *ref_clk;
> +};
> +
> +static int davinci_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	struct davinci_wdt_priv *priv = dev_get_priv(dev);
> +	ulong rate = clk_get_rate(priv->ref_clk);
> +	u64 threshold;
> +
> +	if (!rate)
> +		threshold = DEFAULT_THRESHOLD;
> +	else
> +		threshold = rate * timeout_ms / 1000;
> +
> +	/* Reset control registers */
> +	writel(0, priv->base + DAVINCI_WDT_TCR);
> +	writel(0, priv->base + DAVINCI_WDT_TGCR);
> +
> +	/* Enable watchdog mode and timers */
> +	writel(DAVINCI_TGCR_WDT_MODE | DAVINCI_TGCR_TIM12RS | DAVINCI_TGCR_TIM34RS,
> +	       priv->base + DAVINCI_WDT_TGCR);
> +
> +	/* Reset counters */
> +	writel(0, priv->base + DAVINCI_WDT_TIM12);
> +	writel(0, priv->base + DAVINCI_WDT_TIM34);
> +
> +	/* Set timeout threshold */
> +	writel(threshold & 0xFFFFFFFF, priv->base + DAVINCI_WDT_PRD12);
> +	writel(threshold >> 32, priv->base + DAVINCI_WDT_PRD34);
> +
> +	/* Enable counter */
> +	writel(DAVINCI_TCR_CONT_EN, priv->base + DAVINCI_WDT_TCR);
> +
> +	/* Go to watchdog's active state */
> +	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY0, priv->base + DAVINCI_WDT_WDTCR);
> +	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY1, priv->base + DAVINCI_WDT_WDTCR);
> +
> +	return 0;
> +}
> +
> +static int davinci_wdt_expire_now(struct udevice *dev, ulong flags)
> +{
> +	struct davinci_wdt_priv *priv = dev_get_priv(dev);
> +
> +	writel(DAVINCI_WDTCR_INVALID_KEY, priv->base + DAVINCI_WDT_WDTCR);
> +
> +	return 0;
> +}
> +
> +static int davinci_wdt_restart(struct udevice *dev)
> +{
> +	struct davinci_wdt_priv *priv = dev_get_priv(dev);
> +
> +	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY0, priv->base + DAVINCI_WDT_WDTCR);
> +	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY1, priv->base + DAVINCI_WDT_WDTCR);
> +
> +	return 0;
> +}
> +
> +static int davinci_wdt_probe(struct udevice *dev)
> +{
> +	struct davinci_wdt_priv *priv = dev_get_priv(dev);
> +
> +	priv->base = dev_remap_addr_index(dev, 0);
> +	if (!priv->base)
> +		return -EFAULT;
> +
> +	priv->ref_clk = devm_clk_get(dev, "ref");
> +	if (IS_ERR(priv->ref_clk))
> +		return PTR_ERR(priv->ref_clk);
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops davinci_wdt_ops = {
> +	.start = davinci_wdt_start,
> +	.reset = davinci_wdt_restart,
> +	.expire_now = davinci_wdt_expire_now,
> +};
> +
> +static const struct udevice_id davinci_wdt_ids[] = {
> +	{.compatible = "ti,davinci-wdt"},
> +	{}
> +};
> +
> +U_BOOT_DRIVER(davinci_wdt) = {
> +	.name = "davinci_wdt",
> +	.id = UCLASS_WDT,
> +	.probe = davinci_wdt_probe,
> +	.of_match = davinci_wdt_ids,
> +	.ops = &davinci_wdt_ops,
> +	.priv_auto = sizeof(struct davinci_wdt_priv),
> +};

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
