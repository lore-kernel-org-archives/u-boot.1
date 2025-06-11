Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA01C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 07:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4448D82B20;
	Wed, 11 Jun 2025 09:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1749627022;
	bh=6OeiqPnHfrsTcyO9d1VRp9C/ffLE+TQ4i1wsCik2zho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DD28D4Dopa3JsF7ZoV4PwSK1/tDX+eZqfcW4EHt9xfADCFxW5h5SuZ0xHJb6Qv/mZ
	 IaYJxqvLq+vol3VnAoa1ch/ooXlN9VxE2ya2/g2G9owmFmdVxzhLyuP5NQBphptped
	 2k2SwkaWa+F6eNZgudcroQ1BNX4JOut0hEp48cieV0WOp7Y2bJ1mcSqF6aBH/8chmv
	 PSRz5gwt49Kv3+3zzK7lhNjfxQsOkrq8LZzdMN4FYl6ikd3LQs35lMma1uL1LKPVSd
	 hlxM9jhj+44NXr5Lt0062YI1QErIfxcxPIVVyQfJSYg5584de8Vc4OQ0rg1KK7N5Fu
	 NqWt0fvrWoI1A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E3D582B63; Wed, 11 Jun 2025 09:30:21 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A7582A4B
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 09:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4bHHPQ3Mtqz9tNm;
 Wed, 11 Jun 2025 09:30:18 +0200 (CEST)
Message-ID: <61cf38f6-c70e-416f-aa98-6b84926d12a1@denx.de>
Date: Wed, 11 Jun 2025 09:30:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] renesas: Renesas R-Car Gen4 watchdog driver
To: smelamud@redhat.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250611-us-renesas-watchdog-v4-0-24f1da3e0dc9@redhat.com>
 <20250611-us-renesas-watchdog-v4-2-24f1da3e0dc9@redhat.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250611-us-renesas-watchdog-v4-2-24f1da3e0dc9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bHHPQ3Mtqz9tNm
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

On 11.06.25 02:25, Shmuel Leib Melamud via B4 Relay wrote:
> From: Shmuel Leib Melamud <smelamud@redhat.com>
> 
> Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
> 8184.0s are supported (CKS1 register is not involved). The watchdog
> uses the clock of type CLK_TYPE_GEN4_MDSEL.
> 
> The timeout is set in
> dts/upstream/src/arm64/renesas/r8a779f0-spider-cpu.dtsi section &rwdt.
> 
> This driver is based on upstream linux commit:
> e70140ba0d2b("Get rid of 'remove_new' relic from platform driver struct")
> 
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/watchdog/Kconfig       |   8 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/renesas_wdt.c | 189 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 198 insertions(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bb67f5035231df9f6ce01adb08d074855393143..a0f2948335f9c3b74b7823f039e578ff4030e97c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -335,6 +335,14 @@ config WDT_K3_RTI_FW_FILE
>   
>   endif
>   
> +config WDT_RENESAS
> +	bool "Renesas watchdog timer support"
> +	depends on WDT && R8A779F0
> +	select CLK
> +	select CLK_RENESAS
> +	help
> +	  Enables Renesas SoC R8A779F0 watchdog timer support.
> +
>   config WDT_SANDBOX
>   	bool "Enable Watchdog Timer support for Sandbox"
>   	depends on SANDBOX && WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index e6bd4c587af6133c405dde6dbada8050debc781c..c4467d6e126d0c3e119bf8014b302e5b1432f541 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_WDT_MTK) += mtk_wdt.o
>   obj-$(CONFIG_WDT_NPCM) += npcm_wdt.o
>   obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
>   obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
> +obj-$(CONFIG_WDT_RENESAS) += renesas_wdt.o
>   obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
>   obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
>   obj-$(CONFIG_WDT_SIEMENS_PMIC) += siemens_pmic_wdt.o
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..046e11915b923a661a9ee1d0a586826a1d5068f8
> --- /dev/null
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2025 Red Hat, Inc., Shmuel Leib Melamud <smelamud@redhat.com>
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <wdt.h>
> +
> +#define usleep_range(a, b) udelay((a))
> +
> +struct rwdt {
> +	u32 cnt;
> +	u32 csra;
> +	u32 csrb;
> +};
> +
> +#define RWTCSRA_WOVF	BIT(4)
> +#define RWTCSRA_WRFLG	BIT(5)
> +#define RWTCSRA_TME		BIT(7)
> +
> +#define CSR_MASK	0xA5A5A500
> +#define CNT_MASK	0x5A5A0000
> +
> +#define MAX_CNT_VALUE   65536
> +/*
> + * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
> + * divider (12 bits). d is only a factor to fully utilize the WDT counter and
> + * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
> + */
> +#define MUL_BY_CLKS_PER_SEC(p, d) \
> +	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
> +
> +/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
> +#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
> +
> +static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
> +
> +struct rwdt_priv {
> +	struct rwdt __iomem *wdt;
> +	unsigned long clk_rate;
> +	u8 cks;
> +	struct clk clk;
> +};
> +
> +static void rwdt_wait_cycles(struct rwdt_priv *priv, unsigned int cycles)
> +{
> +	unsigned int delay;
> +
> +	delay = DIV_ROUND_UP(cycles * 1000000, priv->clk_rate);
> +
> +	usleep_range(delay, 2 * delay);
> +}
> +
> +static int rwdt_start(struct udevice *dev, u64 timeout, ulong flags)
> +{
> +	struct rwdt_priv *priv = dev_get_priv(dev);
> +	u64 max_timeout;
> +	u8 val;
> +
> +	max_timeout = DIV_BY_CLKS_PER_SEC(priv, MAX_CNT_VALUE);
> +	timeout = min(max_timeout, timeout / 1000);
> +
> +	/* Stop the timer before we modify any register */
> +	val = readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> +	writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> +	/* Delay 2 cycles before setting watchdog counter */
> +	rwdt_wait_cycles(priv, 2);
> +
> +	while (readb_relaxed(&priv->wdt->csra) & RWTCSRA_WRFLG)
> +		cpu_relax();
> +
> +	writel_relaxed((MAX_CNT_VALUE - MUL_BY_CLKS_PER_SEC(priv, timeout))
> +		       | CNT_MASK, &priv->wdt->cnt);
> +
> +	writel_relaxed(priv->cks | RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
> +
> +	return 0;
> +}
> +
> +static int rwdt_stop(struct udevice *dev)
> +{
> +	struct rwdt_priv *priv = dev_get_priv(dev);
> +
> +	writel_relaxed(priv->cks | CSR_MASK, &priv->wdt->csra);
> +
> +	return 0;
> +}
> +
> +static int rwdt_reset(struct udevice *dev)
> +{
> +	struct rwdt_priv *priv = dev_get_priv(dev);
> +	u8 val;
> +
> +	/* Stop the timer before we modify any register */
> +	val = readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> +	writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> +	/* Delay 2 cycles before setting watchdog counter */
> +	rwdt_wait_cycles(priv, 2);
> +
> +	writel_relaxed(0xffff | CNT_MASK, &priv->wdt->cnt);
> +	/* smallest divider to reboot soon */
> +	writel_relaxed(0 | CSR_MASK, &priv->wdt->csra);
> +
> +	readb_poll_timeout(&priv->wdt->csra, val, !(val & RWTCSRA_WRFLG), 100);
> +
> +	writel_relaxed(RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
> +
> +	/* wait 2 cycles, so watchdog will trigger */
> +	rwdt_wait_cycles(priv, 2);
> +
> +	return 0;
> +}
> +
> +static int rwdt_probe(struct udevice *dev)
> +{
> +	struct rwdt_priv *priv = dev_get_priv(dev);
> +	unsigned long clks_per_sec;
> +	int ret, i;
> +
> +	priv->wdt = dev_remap_addr(dev);
> +	if (!priv->wdt)
> +		return -EINVAL;
> +
> +	ret = clk_get_by_index(dev, 0, &priv->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_enable(&priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	priv->clk_rate = clk_get_rate(&priv->clk);
> +	if (!priv->clk_rate) {
> +		ret = -ENOENT;
> +		goto err_clk_disable;
> +	}
> +
> +	/*
> +	 * Find the largest possible divider that allows clock rate
> +	 * (clks_per_sec) to stay within 16 bits. In this case, we can still
> +	 * measure the smallest timeout (1s) and make the largest allowed
> +	 * timeout as large as possible.
> +	 */
> +	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
> +		clks_per_sec = priv->clk_rate / clk_divs[i];
> +		if (clks_per_sec && clks_per_sec < 65536) {
> +			priv->cks = i;
> +			break;
> +		}
> +	}
> +
> +	/* can't find a suitable clock divider */
> +	if (i < 0) {
> +		ret = -ERANGE;
> +		goto err_clk_disable;
> +	}
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable(&priv->clk);
> +
> +	return ret;
> +}
> +
> +static const struct wdt_ops rwdt_ops = {
> +	.start = rwdt_start,
> +	.reset = rwdt_reset,
> +	.stop = rwdt_stop,
> +};
> +
> +static const struct udevice_id rwdt_ids[] = {
> +	{ .compatible = "renesas,rcar-gen2-wdt" },
> +	{ .compatible = "renesas,rcar-gen3-wdt" },
> +	{ .compatible = "renesas,rcar-gen4-wdt" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(wdt_renesas) = {
> +	.name = "wdt_renesas",
> +	.id = UCLASS_WDT,
> +	.of_match = rwdt_ids,
> +	.ops = &rwdt_ops,
> +	.probe	= rwdt_probe,
> +	.priv_auto = sizeof(struct rwdt_priv),
> +};
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

