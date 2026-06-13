Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ACFCD8CA8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 06:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077D78056B;
	Sat, 13 Jun 2026 08:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="oMhx19IR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7A28063E; Sat, 13 Jun 2026 08:44:08 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648028005D
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 08:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1781333036; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WZoAb58lGNpAXq+4xfeo7OyZ43RDuNQbm/OXLlBOSpQ3WaucruaN03cXzFzNSVP1jgRa4LzmgbC6dLVhjs0fNxd5SyryYgJnw6L1CWSblwsyChjDU85EWatzTfRgwI2GfYBHdoVrzKMfw8nJQMFZVLwXUa3j1NZzHgXmgG2QRoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781333036;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/SkO83+05GHUTNjO++ct6VUWSKsYUH4OaERPedNyaFk=; 
 b=klqvUqhhicwVEbHnQS3UVB26CVd9nIIEaw4ByqWl0YpnTtjriF6R54Tg0r5GGnDp2RYqiEGMOI8RZ1ljJHD5PI9ShANrm3LOPvmThO7AZUJfXYwm9zplsPmxTcpxt/oveWV4gqWhm+4FNwJ2rZIJsvN7hqsVqLKoIJQhuZBOplc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781333036; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=/SkO83+05GHUTNjO++ct6VUWSKsYUH4OaERPedNyaFk=;
 b=oMhx19IRNqqdeGGVQelAmvtaEsIPZe9emUJPS6UjqOK6UCsmOnB5yvayRffj1lFI
 AnKaR6669lNRGGeRKUi8eoL53tn0TRwOAsniyYeX7DkLVoIpbkdcmoH/O9RXjavykA3
 1AiQct1ZBPyj9fBdtM8yqPvfhyaXkC97+bVpqy4I=
Received: by mx.zohomail.com with SMTPS id 1781333028777316.9664112704513;
 Fri, 12 Jun 2026 23:43:48 -0700 (PDT)
Date: Sat, 13 Jun 2026 06:43:31 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, xypron.glpk@gmx.de, randolph@andestech.com,
 dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de,
 samuel@sholland.org, Guodong Xu <guodong@riscstar.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 2/8] mmc: k1: add sdhci platform driver
Message-ID: <aiz8E_EFaSj9q-Fl@pie>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-3-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612201901.73657-3-raymondmaoca@gmail.com>
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

On Fri, Jun 12, 2026 at 04:18:55PM -0400, Raymond Mao wrote:
> From: Guodong Xu <guodong@riscstar.com>
> 
> Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> implements the necessary platform-specific operations for the SDHCI
> controller, enabling MMC/SD card functionality on K1-based platforms.

Is there any reason not to re-use Linux-side K1 MMC driver,
sdhci-of-k1.c, and its companion ABI? Since Linux commit e9cb83c10071
(mmc: sdhci-of-k1: add comprehensive SDR tuning support, 2026-05-11)
it is now capable of operating on SD cards, too.

> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  drivers/mmc/Kconfig          |   7 +
>  drivers/mmc/Makefile         |   1 +
>  drivers/mmc/spacemit_sdhci.c | 934 +++++++++++++++++++++++++++++++++++
>  3 files changed, 942 insertions(+)
>  create mode 100644 drivers/mmc/spacemit_sdhci.c

...

> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> new file mode 100644
> index 00000000000..392ca389fa9
> --- /dev/null
> +++ b/drivers/mmc/spacemit_sdhci.c

...

> +static void spacemit_sdhci_set_aib_mmc1_io(struct sdhci_host *host, int voltage)
> +{
> +	struct mmc *mmc = host->mmc;
> +	struct spacemit_sdhci_plat *plat = dev_get_plat(mmc->dev);
> +	void __iomem *aib_mmc1_io, *apbc_asfar, *apbc_assar;
> +	u32 reg;
> +
> +	if (!plat->aib_mmc1_io_reg || !plat->apbc_asfar_reg ||
> +	    !plat->apbc_assar_reg)
> +		return;
> +
> +	aib_mmc1_io = map_sysmem((uintptr_t)plat->aib_mmc1_io_reg,
> +				 sizeof(u32));
> +	apbc_asfar = map_sysmem((uintptr_t)plat->apbc_asfar_reg,
> +				sizeof(u32));
> +	apbc_assar = map_sysmem((uintptr_t)plat->apbc_assar_reg,
> +				sizeof(u32));

AFAIK aib_mmc1_io region is related to pinctrl settings, and shouldn't
be handled by the MMC driver directly. Quoting my own reply[1] to the
series adding SD support to sdhci-of-k1.c in Linux side,

> Also, the pin controller on K1 SoC seems to have some undocumented
> registers to select the IO voltage of SD pins, which should be
> adjusted when switching IO voltage.
>
> I think these pins should be implemented in the pinctrl driver, then
> you could create two pinctrl states, one for 1.8v operation, one for
> 3.3v, and switch between them through pinctrl_lookup_state() when
> changing IO voltage.

This idea is later confirmed by SpacemiT guy's series[2],

> On K1, IO domain power control registers determine whether a GPIO bank
> operates at 1.8V or 3.3V. These registers default to 3.3V operation,
> which may lead to functional failures when GPIO banks are externally
> supplied with 1.8V but internally remain configured for 3.3V.
>
> The IO power domain registers are implemented as secure registers and
> require an explicit unlock sequence via the AIB Secure Access Register
> (ASAR), located in the APBC register space.

Thus I think you should move the logic to pinctrl driver instead, like
what has been done in the Linux upstream driver.

> +	writel(AKEY_ASFAR, apbc_asfar);
> +	writel(AKEY_ASSAR, apbc_assar);
> +	reg = readl(aib_mmc1_io);
> +
> +	switch (voltage) {
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		reg |= MMC1_IO_V18EN;
> +		break;
> +	default:
> +		reg &= ~MMC1_IO_V18EN;
> +		break;
> +	}
> +	writel(AKEY_ASFAR, apbc_asfar);
> +	writel(AKEY_ASSAR, apbc_assar);
> +	writel(reg, aib_mmc1_io);
> +}

...

> +static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
> +{

...

> +	/* Set pinctrl state */
> +	if (IS_ENABLED(CONFIG_PINCTRL)) {
> +		if (mmc->clock >= 200000000)
> +			pinctrl_select_state(mmc->dev, "fast");
> +		else
> +			pinctrl_select_state(mmc->dev, "default");
> +	}

This doesn't match Linux side ABI, where when card operates in UHS mode,
pinctrl state "uhs" is selected.

Regards,
Yao Zi

[1]: https://lore.kernel.org/linux-riscv/aUDwDkd8k_4gD1yc@pie/
[2]: https://lore.kernel.org/linux-riscv/20260108-kx-pinctrl-aib-io-pwr-domain-v2-0-6bcb46146e53@linux.spacemit.com
