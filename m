Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AB4EA718B
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 05:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B68C083015;
	Sun, 19 Apr 2026 07:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TWC2aCJi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pNLH+578";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEAFB839D9; Sun, 19 Apr 2026 07:17:55 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FD882BF2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fyxhc1MPgz9tlR;
 Sun, 19 Apr 2026 07:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776575872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dxUkJomyEPnLnwbf2N0IIeG9A/2ZHu5ahiYPtydLNE=;
 b=TWC2aCJiuqIr1VIU99xsdnigUaEeXs5PizN6l/CMaXBar9z447JPf4tZJjYXFYkj3qcaKu
 AaJiOxTxiC1nyHteV36LUM2QKb8md1AF/ltevnO5OqqnphjpSLESp3h46nXAjUe/jcFFvd
 pg8p+nU58FzgRxl99hQZvWjL7YjS88PkoXGeVj/mQxW3M/CV9O99BAA+zG/Bj8bqLLH9Gq
 nNVVXT1ghL1CBwrie1awgh5ebrPi0DVukD7rpkwWOefQq6n4ElKE1UqV0ZGeGS+eVLS22Z
 2VnTi0/EHoJfeS/b3aSDEbQuK0L1+qnKoXi94ScTMkn+rcX8vbUtIUzlyF/4GA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pNLH+578;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
Message-ID: <782eeae7-0f54-4e5d-8199-7d66b6f4fd05@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776575870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dxUkJomyEPnLnwbf2N0IIeG9A/2ZHu5ahiYPtydLNE=;
 b=pNLH+578aZuX/mc/LRRb00n4zCoGs4YKd7neSlBZojuMCT79nw8SlKEgYxboZr80f9pN7/
 MYzU3k7+ShmfRI0vVNNW3vwASQbEHJU1C9PZqq/rcJyKlhZCZ2MSsCVGZrfCsLUHdvVgB0
 RwGS1OIBInqoiA6XUdrV+XXOFqlXZ3LtMsv8DKpzSmDQtay8xXk5pCexGUx4nBh1956W0v
 1cHZgIeGpwMHqDlJv7+0fCIPaqvMrF8e2kQSlGXtnVWhV8N6WOKNpz3F0Vpx7ihcMk4gtG
 d29aIrrPGTVZaZzc3182SZ8Lx9GKpcB5HiuO7/Iyg5RVz+uB77kQAS5a1PnwKQ==
Date: Sun, 19 Apr 2026 07:17:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: Add Renesas R-Car Gen5 window watchdog driver
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260415220213.449146-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260415220213.449146-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3a7a63d29f41380a1c9
X-MBO-RS-META: ryzw839y1a15xo5x48k1yky81ywd3ir8
X-Rspamd-Queue-Id: 4fyxhc1MPgz9tlR
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

Hi Marek,

On 4/16/26 00:01, Marek Vasut wrote:
> Add support of Renesas R-Car Gen5 window watchdog timer. Timeout
> configuration is derived from CONFIG_WATCHDOG_TIMEOUT_MSECS, which
> is more accurate than the 1-second granularity 'timeout' passed to
> .start callback.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/watchdog/Kconfig        |   6 ++
>   drivers/watchdog/Makefile       |   1 +
>   drivers/watchdog/renesas_wwdt.c | 147 ++++++++++++++++++++++++++++++++
>   3 files changed, 154 insertions(+)
>   create mode 100644 drivers/watchdog/renesas_wwdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 416d29d256a..7fdfb7add45 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -356,6 +356,12 @@ config WDT_RENESAS
>   	help
>   	  Enables Renesas SoC R8A779F0 watchdog timer support.
>   
> +config WDT_RENESAS_WWDT
> +	bool "Renesas window watchdog timer support"
> +	depends on WDT
> +	help
> +	  Enables Renesas window watchdog timer support.
> +
>   config WDT_SANDBOX
>   	bool "Enable Watchdog Timer support for Sandbox"
>   	depends on SANDBOX && WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 02e2674f8af..84faefdb4c2 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_WDT_NPCM) += npcm_wdt.o
>   obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
>   obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
>   obj-$(CONFIG_WDT_RENESAS) += renesas_wdt.o
> +obj-$(CONFIG_WDT_RENESAS_WWDT) += renesas_wwdt.o
>   obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
>   obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
>   obj-$(CONFIG_WDT_SIEMENS_PMIC) += siemens_pmic_wdt.o
> diff --git a/drivers/watchdog/renesas_wwdt.c b/drivers/watchdog/renesas_wwdt.c
> new file mode 100644
> index 00000000000..3e76ccc415d
> --- /dev/null
> +++ b/drivers/watchdog/renesas_wwdt.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Marek Vasut <marek.vasut+renesas@mailbox.org>
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm/device_compat.h>
> +#include <dm.h>
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +#include <wdt.h>
> +
> +#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> +
> +#define RSIP_CTL_BASE		0x5fffd000
> +#define RSIP_CTL_CFG4		(RSIP_CTL_BASE + 0xb0)

Hmmm, hardcoded address here...

> +#define RSIP_CTL_CFG4_OPWDEN	BIT(3)
> +#define RSIP_CTL_CFG4_OPWDVAC	BIT(5)
> +
> +#define WDTA0_ACT_CODE		0xac
> +#define WDTA0WDTE		0x0
> +#define WDTA0EVAC		0x4
> +#define WDTA0REF		0x8
> +#define WDTA0MD			0xc
> +#define WDTA0MD_OVF_MASK	GENMASK(6, 4)
> +#define WDTA0MD_OVF(n)		field_prep(WDTA0MD_OVF_MASK, (n))
> +#define WDTA0MD_NWIE		BIT(3)
> +#define WDTA0MD_NERM		BIT(2)
> +#define WDTA0MD_NVS_MASK	GENMASK(1, 0)
> +#define WDTA0MD_NVS_75P		FIELD_PREP(WDTA0MD_NVS_MASK, 3)
> +
> +struct wwdt_priv {
> +	void __iomem *base;
> +	unsigned int timeout;
> +};
> +
> +/**
> + * wwdt_reset() - Reset or ping Window WDT
> + * @dev: Watchdog device
> + */
> +static int wwdt_reset(struct udevice *dev)
> +{
> +	struct wwdt_priv *priv = dev_get_priv(dev);
> +	const u32 cfg = readl(RSIP_CTL_CFG4);

...and used here.

> +	u32 rv;
> +
> +	/* WDT disabled, do nothing. */
> +	if (!(cfg & RSIP_CTL_CFG4_OPWDEN))
> +		return 0;
> +
> +	/* WDT with variable activation code */
> +	if (cfg & RSIP_CTL_CFG4_OPWDVAC) {
> +		rv = readb(priv->base + WDTA0REF);
> +		rv = WDTA0_ACT_CODE - rv;
> +		writeb(rv, priv->base + WDTA0EVAC);

And here the base address from the device-tree. Is this a complete
different address space / controller which is hardcoded? Can't you
get this via DT?

Thanks,
Stefan

> +	} else {
> +		writeb(WDTA0_ACT_CODE, priv->base + WDTA0WDTE);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * wwdt_start() - Start Window WDT
> + * @dev: Watchdog device
> + * @timeout: Watchdog timeout (not used)
> + * @flags: Flags (not used)
> + */
> +static int wwdt_start(struct udevice *dev, u64 timeout, ulong flags)
> +{
> +	struct wwdt_priv *priv = dev_get_priv(dev);
> +
> +	clrsetbits_8(priv->base + WDTA0MD,
> +		     WDTA0MD_OVF_MASK | WDTA0MD_NWIE |
> +		     WDTA0MD_NERM | WDTA0MD_NVS_MASK,
> +		     WDTA0MD_OVF(priv->timeout) | WDTA0MD_NWIE |
> +		     WDTA0MD_NVS_75P);
> +
> +	wwdt_reset(dev);
> +
> +	return 0;
> +}
> +
> +/**
> + * wwdt_probe() - Initialize Window WDT hardware
> + * @dev: Watchdog device
> + */
> +static int wwdt_probe(struct udevice *dev)
> +{
> +	struct wwdt_priv *priv = dev_get_priv(dev);
> +	unsigned long rate;
> +	struct clk *clk;
> +	int ret;
> +
> +	priv->base = dev_remap_addr(dev);
> +	if (!priv->base)
> +		return -EINVAL;
> +
> +	clk = devm_clk_get(dev, "cnt");
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		dev_err(dev, "Failed to get counter clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_enable(clk);
> +	if (ret)
> +		return ret;
> +
> +	rate = clk_get_rate(clk);
> +	if (!rate) {
> +		clk_disable(clk);
> +		return -ENOENT;
> +	}
> +
> +	/*
> +	 * Interval time is in "2^9..2^16 / clk_wdt" range. WDTA0OVFx is
> +	 * in 0..7 range. The code below does the WDTA0OVFx calculation
> +	 * from "interval_time = (1 << N) / clk_wdt" by caculating the N.
> +	 * The N rounded down is MSbit of (interval_time * clk_wdt). The
> +	 * result is then clamped to fit into the N in 9..16 range, and
> +	 * decremented by 9 to fit into WDTA0OVFx in 0..7 range .
> +	 */
> +	priv->timeout = clamp(fls(CONFIG_WATCHDOG_TIMEOUT_MSECS * rate) - 1, 9, 16) - 9;
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops wwdt_ops = {
> +	.start = wwdt_start,
> +	.reset = wwdt_reset,
> +};
> +
> +static const struct udevice_id wwdt_ids[] = {
> +	{ .compatible = "renesas,rcar-gen5-wwdt" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(wwdt_renesas) = {
> +	.name = "wwdt_renesas",
> +	.id = UCLASS_WDT,
> +	.of_match = wwdt_ids,
> +	.ops = &wwdt_ops,
> +	.probe	= wwdt_probe,
> +	.priv_auto = sizeof(struct wwdt_priv),
> +};

