Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69FFC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 17:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B8884A29;
	Sun, 19 Jul 2026 19:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="HL80Y8KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D1984A3A; Sun, 19 Jul 2026 19:46:46 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE598494B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 19:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784483199; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RX6tZH91H9aNPHYILoFJMTH0QJOi0jHfvTk/rkaK7b4d/9MpqEXeezEeSkXxNgEWd4nBN0Omlvw46b2JALXWOZRLUTDp/PbX0gD9eWiU2ASOdNQJSbf0CSvtkPOLZbwtvud+uNxlt7bMAXbwZOjS9ZWXLG65vzdqGDPs1UUufcY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784483199;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pcnmgwJAAYWNK/zYydgueDdtilp6kobvCRChA1OnZAo=; 
 b=DHOnPtZ+xvm2WgyK1WfY+wqYSMWiBAE2LbYVRm92XW4m3RcXdT7l98gankZ6w4gE5Tw6rZRg/KUKShz4DfFVpAYODcKGNwFMDUub6r1Ao04ARZVqyq0ScajB67K2m1TYIL2l9Y7+O8x3DdzDJIfPNxTcME4GBoHRmAJ0CE5IIw8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784483199; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=pcnmgwJAAYWNK/zYydgueDdtilp6kobvCRChA1OnZAo=;
 b=HL80Y8KWRhbwKgCg1iGoMlXM8MOLLt0HqVOoJ0shkzmbzEjCLH3988f9hkbZUUy7
 L7d3kJcsQ9SGVjnVoxFwuWl2tXEGxIlX7/SmXo8c1XwG2y9Nizklb/Na9qS/p/ys+Py
 ifhj8sxK9mrg6DFxmzLooDbpLxLHiHlGGpW6bNYU=
Received: by mx.zohomail.com with SMTPS id 1784483197093869.438094453078;
 Sun, 19 Jul 2026 10:46:37 -0700 (PDT)
Date: Sun, 19 Jul 2026 17:46:24 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v4 04/10] mmc: k1: add sdhci platform driver
Message-ID: <al0NcAmLqTlIShq7@pie>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-4-dbd01185f911@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-m4-v4-4-dbd01185f911@riscstar.com>
X-ZohoMailClient: External
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

On Tue, Jul 07, 2026 at 11:21:45PM +0800, Eric Chung wrote:
> Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> implements the necessary platform-specific operations for the SDHCI
> controller, enabling MMC/SD card functionality on K1-based platforms.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v4:
> - Add bulk release operations on reset and clock.
> v3:
> - Enable CMD23 in capability.
> v2:
> - Enable ADMA mode support.
> - Use CMD23 for multi-block read/write.
> - Move ASR/AIB register into pinctrl driver.
> - Correct pinctrl state from "fast" to "uhs".
> - Migrate tuning support from the spacemit linux driver.
> ---
>  drivers/mmc/Kconfig          |   7 +
>  drivers/mmc/Makefile         |   1 +
>  drivers/mmc/spacemit_sdhci.c | 685 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 693 insertions(+)

...

> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> new file mode 100644
> index 00000000000..1c7dd3a5870
> --- /dev/null
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -0,0 +1,685 @@

...

> +#define SPACEMIT_SDHC_RX_CFG_REG        0x118
> +#define  SDHC_RX_SDCLK_SEL0_MASK        GENMASK(1, 0)
> +#define  SDHC_RX_SDCLK_SEL1_MASK        GENMASK(3, 2)
> +#define  SDHC_RX_SDCLK_SEL1             FIELD_PREP(SDHC_RX_SDCLK_SEL1_MASK, 1)

Space and TABs are both used in definitions of macros in this file,
please choose a consistent style.

...

> +static int spacemit_sdhci_set_vqmmc_voltage(struct mmc *mmc, int voltage)
> +{
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> +	int ret;
> +
> +	if (!mmc->vqmmc_supply)
> +		return 0;
> +
> +	ret = regulator_set_value(mmc->vqmmc_supply, voltage);
> +	if (ret) {
> +		log_err("failed to set vqmmc voltage to %d.%dV\n",
> +			voltage / 1000000, (voltage / 100000) % 10);
> +		return ret;
> +	}
> +	ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
> +	if (ret) {
> +		log_err("failed to enable vqmmc supply\n");
> +		return ret;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +static void spacemit_sdhci_set_voltage(struct sdhci_host *host)
> +{
> +	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
> +		struct mmc *mmc = host->mmc;
> +		u32 ctrl;
> +
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		switch (mmc->signal_voltage) {
> +		case MMC_SIGNAL_VOLTAGE_330:
> +		case MMC_SIGNAL_VOLTAGE_180: {
> +			bool to_180 = mmc->signal_voltage ==
> +				      MMC_SIGNAL_VOLTAGE_180;
> +			bool ok;
> +			int voltage_mv = to_180 ? 1800000 : 3300000;
> +
> +			if (spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_mv))
> +				return;
> +			if (!IS_SD(mmc))
> +				return;
> +			if (to_180)
> +				ctrl |= SDHCI_CTRL_VDD_180;
> +			else
> +				ctrl &= ~SDHCI_CTRL_VDD_180;
> +			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +			mdelay(5);
> +
> +			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
> +			if (ok)
> +				return;
> +
> +			log_err("%d.%dV regulator output not stable\n",
> +				voltage_mv / 1000000,
> +				(voltage_mv / 100000) % 10);
> +			break;
> +		}
> +		default:
> +			/* No signal voltage switch required */
> +			return;
> +		}
> +	}

It seems the only difference between spacemit_sdhci_set_voltage() and
sdhci_set_voltage() is that the earlier doesn't disable vqmmc before
changing its voltage, is this really necessary, since I don't see
similar behavior in the kernel MMC driver? And if it is, please point
the difference out in comment, and explain why if possible.

> +}

...

> +static int spacemit_sdhci_wait_dat0(struct udevice *dev, int state,
> +				    int timeout_us)
> +{
> +	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +	struct sdhci_host *host = mmc->priv;
> +	unsigned long timeout = timer_get_us() + timeout_us;
> +	u32 tmp;
> +
> +	/*
> +	 * readx_poll_timeout is unsuitable because sdhci_readl accepts
> +	 * two arguments
> +	 */

But read_poll_timeout() accepts op with arbitrary number of arguments,
could it be used?

> +	do {
> +		tmp = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +		if (!!(tmp & SDHCI_DATA_0_LVL_MASK) == !!state) {
> +			if (spacemit_sdhci_is_voltage_switch_cmd(host))
> +				spacemit_sdhci_set_clk_gate(host, 1);
> +			return 0;
> +		}
> +	} while (!timeout_us || !time_after(timer_get_us(), timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
> +{

...

> +	/* Set pinctrl state */
> +	if (IS_ENABLED(CONFIG_PINCTRL)) {
> +		if (mmc->clock >= 200000000)
> +			pinctrl_select_state(mmc->dev, "uhs");
> +		else
> +			pinctrl_select_state(mmc->dev, "default");

Shouldn't pinctrl setting be switched based on mode (whether it's
UHS or not) instead of clock frequency, as what has been done in the
kernel side?

In v1 of this series, the spacemit_sdhci_set_aib_mmc1_io() is also
called with the selected signal voltage, so I think voltage switching
logic is incorrect here.

...

> +#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
> +static int spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
> +{
> +	u32 reg;
> +	int i;
> +
> +	/* Configure DLL predly, fulldly, and vreg */
> +	spacemit_sdhci_clrsetbits(host, SDHC_DLL_PREDLY_NUM |
> +				  SDHC_DLL_FULLDLY_RANGE |
> +				  SDHC_DLL_VREG_CTRL,
> +				  FIELD_PREP(SDHC_DLL_PREDLY_NUM, 1) |
> +				  FIELD_PREP(SDHC_DLL_FULLDLY_RANGE, 1) |
> +				  FIELD_PREP(SDHC_DLL_VREG_CTRL, 1),
> +				  SPACEMIT_SDHC_PHY_DLLCFG);
> +
> +	reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG1);
> +	reg |= FIELD_PREP(SDHC_DLL_REG1_CTRL, 0x92);

What does 0x92 mean here? Please define it as a macro with meaningful
name if possible, like SPACEMIT_SDHC_PHY_DLLCFG's case.

> +	sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG1);

...

> +	/* Wait for DLL lock */
> +	i = 0;
> +	while (i++ < 100) {
> +		if (sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLSTS) & SDHC_DLL_LOCK_STATE)
> +			break;
> +		udelay(10);
> +	}
> +	if (i == 100) {
> +		log_err("%s: phy dll lock timeout\n", host->name);
> +		return -ETIMEDOUT;
> +	}

Please use read*_poll_timeout() family to replace the loop and the
following check.

> +
> +	return 0;
> +}

...

> +static int spacemit_sdhci_probe(struct udevice *dev)
> +{

...

> +	/* Set quirks */

I think it's obvious, and there's no need to comment it, but

> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
> +		host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD;
> +	else
> +		host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD |
> +				SDHCI_QUIRK_32BIT_DMA_ADDR;

Why SDHCI_QUIRK_32BIT_DMA_ADDR is only enabled in SPL build? Even it
isn't used by any code, it shouldn't hurt to set the flag, which is
less confusing.

...

> +static const struct udevice_id spacemit_sdhci_ids[] = {
> +	{
> +		.compatible = "spacemit,k1-sdhci",
> +		.data = 0,

Uninitialized fields of static variables are automatically zeroed in C,
so please remove this assignment.

> +	}, {
> +	}
> +};

Regards,
Yao Zi
