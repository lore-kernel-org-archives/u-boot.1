Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC011C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FFCA80F44;
	Fri, 31 Jan 2025 00:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XTIRxKPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E413280F47; Fri, 31 Jan 2025 00:14:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7969080F42
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738278841;
 bh=jT/9Hmk3GViw62tvjWkgPhF+Ln6Ul4EwMi+MLs9LmUE=;
 b=XTIRxKPjaFZ0TDGqSNB5QEsie5OLTXfcRK0GaKdu/JbSKPqY1tdtnbVdWsmMAS819IG+dnNed
 GNLRVNQzU8HvI22p9BF1EkoTBYwxckgyp+GgG/0TlIsqSVxbmcd8Pk31KOKWEoRw4Zzs8xg6/le
 ZHCPdZggW+y9n6hE9j0wTY9fxNCeSSHQNEI6twnwmYN/p8fnvsMYnyQFzGVI/ocYZhcOKiv01f0
 gwjk2bNFPOV0uFPTiTYeuSvevOPmDT9sDDRjx6Iah23516rolbh1h9xUpNDOGCVdTkLShGOLZit
 jMIUjjkttM5L2SHN9pdut61xjbatJ4t7uqcGbIJQ8vLA==
X-Forward-Email-ID: 679c07ad2d70e7e0588403ff
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <66cdbe3c-4318-4cbd-8430-c3f341b48ee4@kwiboo.se>
Date: Fri, 31 Jan 2025 00:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] ram: rockchip: Add rk3576 ddr driver support
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-16-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241121142731.1202209-16-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Heiko,

On 2024-11-21 15:27, Heiko Stuebner wrote:
> Add ddr driver for rk3576 to get the ram capacity.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/ram/rockchip/Makefile       |  1 +
>  drivers/ram/rockchip/sdram_rk3576.c | 65 +++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 drivers/ram/rockchip/sdram_rk3576.c
> 
> diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
> index 36dc0500dab..442fe73deb6 100644
> --- a/drivers/ram/rockchip/Makefile
> +++ b/drivers/ram/rockchip/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) = sdram_rk3308.o
>  obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.o
>  obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
>  obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
> +obj-$(CONFIG_ROCKCHIP_RK3576) += sdram_rk3576.o
>  obj-$(CONFIG_ROCKCHIP_RK3588) += sdram_rk3588.o
>  obj-$(CONFIG_ROCKCHIP_RV1126) += sdram_rv1126.o sdram_pctl_px30.o
>  obj-$(CONFIG_ROCKCHIP_SDRAM_COMMON) += sdram_common.o
> diff --git a/drivers/ram/rockchip/sdram_rk3576.c b/drivers/ram/rockchip/sdram_rk3576.c
> new file mode 100644
> index 00000000000..fa4187a5860
> --- /dev/null
> +++ b/drivers/ram/rockchip/sdram_rk3576.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <config.h>
> +#include <dm.h>
> +#include <ram.h>
> +#include <syscon.h>
> +#include <asm/arch-rockchip/clock.h>
> +#include <asm/arch-rockchip/grf_rk3576.h>
> +#include <asm/arch-rockchip/sdram.h>
> +
> +struct dram_info {
> +	struct ram_info info;
> +	struct rk3576_pmu1grf *pmugrf;
> +};
> +
> +static int rk3576_dmc_probe(struct udevice *dev)
> +{
> +	struct dram_info *priv = dev_get_priv(dev);
> +
> +	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> +
> +	/*
> +	 * On a 16GB board the DDR ATAG reports:
> +	 * start 0x40000000, size 0x400000000
> +	 * While the size value from the pmugrf below reports
> +	 * pmugrf->osreg2: 0x400000000
> +	 * pmugrf->osreg4:  0x10000000
> +	 * So it seems only osreg2 is responsible for the ram size.
> +	 */
> +	priv->info.base = CFG_SYS_SDRAM_BASE;
> +	priv->info.size =
> +		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg[2]);
> +
> +	return 0;
> +}
> +
> +static int rk3576_dmc_get_info(struct udevice *dev, struct ram_info *info)
> +{
> +	struct dram_info *priv = dev_get_priv(dev);
> +
> +	*info = priv->info;
> +
> +	return 0;
> +}

Both the probe and above get_info can be simplified into something like:

#define PMU1GRF_BASE			0x26026000
#define OS_REG2_REG			0x208

static int rk3576_dmc_get_info(struct udevice *dev, struct ram_info *info)
{
	info->base = CFG_SYS_SDRAM_BASE;
	info->size = rockchip_sdram_size(PMU1GRF_BASE + OS_REG2_REG);

	return 0;
}

With above the grf_rk3576.h could also be dropped/removed.

> +
> +static struct ram_ops rk3576_dmc_ops = {
> +	.get_info = rk3576_dmc_get_info,
> +};
> +
> +static const struct udevice_id rk3576_dmc_ids[] = {
> +	{ .compatible = "rockchip,rk3576-dmc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(dmc_rk3576) = {
> +	.name = "rockchip_rk3576_dmc",
> +	.id = UCLASS_RAM,
> +	.of_match = rk3576_dmc_ids,
> +	.ops = &rk3576_dmc_ops,
> +	.probe = rk3576_dmc_probe,
> +	.priv_auto = sizeof(struct dram_info),

With the probe function removed we can also remove the priv data.

> +};

Regards,
Jonas
