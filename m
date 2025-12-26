Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEF9E8FDA0
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 09:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FB7842B6;
	Fri, 26 Dec 2025 10:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S6CZAcu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8932842C7; Fri, 26 Dec 2025 10:47:07 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F3B84205
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 10:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9424260054;
 Fri, 26 Dec 2025 09:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B79C4CEF7;
 Fri, 26 Dec 2025 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766742423;
 bh=NQ3m12klpvMdZV8Zuf0jcjAB7b5+7NN6/yxA4kC5SI8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S6CZAcu/qXSm7rR5AadlkIp0YAxaKkjnV7I7erfrFdKERqHrBnlwZdw+B0cFXJ5AB
 AlT+aiZSkZM3ypsikpGyWEv9ogqAWzu6gyr+VSQiU1xCWK1xo2M4h60AsDbGG9iq8G
 ZcBw2qyqAgged41ZZ5JAu5hRNOP67s4VDIYesEz9V8rqGTYpiDkil4mu46TzgAzcto
 pflgfh07/Ct7lWg94Cq2GT4nISsEECHkV5rByWx3TEl18foUs2xMXtXzI6HdcP7exl
 6qF8yaG/03v/5PWLP/hlV7V0DcQWv0NoTFLbKe3lMl/stRYzBXxo/kZo6kc8Jprp0J
 L+wOazuOBUUGw==
Date: Fri, 26 Dec 2025 15:16:51 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, jh80.chung@samsung.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/4] power-domain: Add QCOM RPMH Power Domain Driver
 Support
Message-ID: <aU5Zi7yVPWOiv_B5@sumit-xelite>
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
 <20251222114823.2146775-2-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222114823.2146775-2-aswin.murugan@oss.qualcomm.com>
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

Hi Aswin,

Thanks for the driver port.

On Mon, Dec 22, 2025 at 05:18:20PM +0530, Aswin Murugan wrote:
> Added support for Qualcomm RPMH power domain driver, responsible
> for managing power domains on Qualcomm SoCs. This is a port of
> the Linux RPMHPD driver [1] and sa8775p related changes.

> The
> power domain driver currently has support to power on and off
> MMCX power domain of sa8775p;

IIUC, the MMCX power domain relates to multimedia use-cases. Do you have
any such use-case for that in U-Boot? IOW, I don't see a user of the
RPMh functionality you are trying to add in this patch-set.

If it's just meant for now to not have live DT fixups then having just
the stubbed power domains will be sufficient.

-Sumit

> support for other soc entries power
> domains are stubbed, in future, the required soc support can be
> added.
> 
> [1]:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v7:
> - No changes to this patch in v7
> 
> v6:
> - Initialized ret with 0 in rpmhpd_probe()
> 
> v5:
> - Changed the first argument passed to rpmh_write as pd->dev
> - Added (ulong) casting in rpmhpd_match_table to address the warning.
> 
> v4:
> - Added all SoC entries from the Linux driver and stubbed it
> - Removed "qcom_rpmhpd" driver
> - Removed unused members in struct rpmhpd
> 
> v3:
> - No changes to this patch in v3
> 
> v2:
> - Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN Kconfig
> - In qcom-rpmhpd driver, the un-supported power domains are handled with warning
>   in rpmhpd_power_on() & rpmhpd_power_off()
> ---
>  drivers/power/domain/Kconfig       |   8 +
>  drivers/power/domain/Makefile      |   1 +
>  drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/power/domain/qcom-rpmhpd.c
> 
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 0ad885c9e8b..48e841c638e 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -90,6 +90,14 @@ config MESON_SECURE_POWER_DOMAIN
>  	  Enable support for manipulating Amlogic Meson Secure power domains.
>  	  Support for Amlogic A1 series.
>  
> +config QCOM_POWER_DOMAIN
> +	bool "Enable the QCOM RPMH Power domain driver"
> +	depends on POWER_DOMAIN && ARCH_SNAPDRAGON
> +	help
> +	  Generic RPMH power domain implementation for QCOM devices.
> +	  The RPMH power domain driver is responsible for managing power
> +	  domains on Qualcomm SoCs.
> +
>  config SANDBOX_POWER_DOMAIN
>  	bool "Enable the sandbox power domain test driver"
>  	depends on POWER_DOMAIN && SANDBOX
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
> index 8e03f620437..1c2c64b0964 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
>  obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
>  obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
>  obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
> +obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
> diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
> new file mode 100644
> index 00000000000..f51bc9a4bbb
> --- /dev/null
> +++ b/drivers/power/domain/qcom-rpmhpd.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> +
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <power-domain.h>
> +#include <asm/io.h>
> +#include <linux/errno.h>
> +
> +#include <power-domain-uclass.h>
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dm/device_compat.h>
> +
> +#define RPMH_ARC_MAX_LEVELS	16
> +
> +/**
> + * struct rpmhpd - top level RPMh power domain resource data structure
> + * @dev:                rpmh power domain controller device
> + * @pd:                 generic_pm_domain corresponding to the power domain
> + * @parent:             generic_pm_domain corresponding to the parent's power domain
> + * @enable_corner:      lowest non-zero corner
> + * @level:              An array of level (vlvl) to corner (hlvl) mappings
> + *                      derived from cmd-db
> + * @level_count:        Number of levels supported by the power domain. max
> + *                      being 16 (0 - 15)
> + * @enabled:            true if the power domain is enabled
> + * @res_name:           Resource name used for cmd-db lookup
> + * @addr:               Resource address as looped up using resource name from
> + * @skip_retention_level: Indicate that retention level should not be used for the power domain
> + */
> +struct rpmhpd {
> +	struct udevice	*dev;
> +	struct power_domain pd;
> +	struct power_domain *parent;
> +	unsigned int	enable_corner;
> +	u32		level[RPMH_ARC_MAX_LEVELS];
> +	size_t		level_count;
> +	bool		enabled;
> +	const char	*res_name;
> +	u32		addr;
> +	bool		skip_retention_level;
> +};
> +
> +struct rpmhpd_desc {
> +	struct rpmhpd **rpmhpds;
> +	size_t num_pds;
> +};
> +
> +/* RPMH powerdomains */
> +static struct rpmhpd mmcx_ao;
> +static struct rpmhpd mmcx = {
> +	.res_name = "mmcx.lvl",
> +};
> +
> +static struct rpmhpd mmcx_ao = {
> +	.res_name = "mmcx.lvl",
> +};
> +
> +/* SA8775P RPMH power domains */
> +static struct rpmhpd *sa8775p_rpmhpds[] = {
> +	[SA8775P_MMCX] = &mmcx,
> +	[SA8775P_MMCX_AO] = &mmcx_ao,
> +};
> +
> +static const struct rpmhpd_desc sa8775p_desc = {
> +	.rpmhpds = sa8775p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
> +};
> +
> +/* stub RPMH power domains mapped for unsupported platforms */
> +static struct rpmhpd *stub_rpmhpds[] = {};
> +
> +static const struct rpmhpd_desc stub_desc = {
> +	.rpmhpds = stub_rpmhpds,
> +	.num_pds = ARRAY_SIZE(stub_rpmhpds),
> +};
> +
> +static const struct udevice_id rpmhpd_match_table[] = {
> +	{ .compatible = "qcom,sa8775p-rpmhpd", .data = (ulong)&sa8775p_desc },
> +	{ .compatible = "qcom,qcs615-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,qcs8300-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,qdu1000-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sa8155p-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sa8540p-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sar2130p-rpmhpd", .data = (ulong)&stub_desc},
> +	{ .compatible = "qcom,sc7180-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sc7280-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sc8180x-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sdm670-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sdm845-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sdx55-rpmhpd", .data = (ulong)&stub_desc},
> +	{ .compatible = "qcom,sdx65-rpmhpd", .data = (ulong)&stub_desc},
> +	{ .compatible = "qcom,sdx75-rpmhpd", .data = (ulong)&stub_desc},
> +	{ .compatible = "qcom,sm4450-rpmhpd", .data = (ulong)&stub_desc},
> +	{ .compatible = "qcom,sm6350-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm7150-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm8150-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm8250-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm8350-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm8450-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm8550-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm8650-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,sm8750-rpmhpd", .data = (ulong)&stub_desc },
> +	{ .compatible = "qcom,x1e80100-rpmhpd", .data = (ulong)&stub_desc },
> +	{ }
> +};
> +
> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
> +			      unsigned int corner, bool sync)
> +{
> +	struct tcs_cmd cmd = {
> +		.addr = pd->addr,
> +		.data = corner,
> +	};
> +
> +	return rpmh_write(pd->dev, state, &cmd, 1);
> +}
> +
> +static int rpmhpd_power_on(struct power_domain *pd)
> +{
> +	int ret;
> +	unsigned int corner;
> +	struct rpmhpd **rpmhpds;
> +	const struct rpmhpd_desc *desc;
> +	struct rpmhpd *curr_rpmhpd;
> +
> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	rpmhpds = desc->rpmhpds;
> +	curr_rpmhpd = rpmhpds[pd->id];
> +
> +	/* Do nothing for undefined power domains */
> +	if (!curr_rpmhpd) {
> +		log_warning("Power domain id (%ld) not supported\n",
> +			    pd->id);
> +		return 0;
> +	}
> +
> +	corner = curr_rpmhpd->enable_corner;
> +
> +	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
> +				 false);
> +	if (!ret)
> +		curr_rpmhpd->enabled = true;
> +
> +	return ret;
> +}
> +
> +static int rpmhpd_power_off(struct power_domain *pd)
> +{
> +	int ret;
> +	unsigned int corner;
> +	struct rpmhpd **rpmhpds;
> +	const struct rpmhpd_desc *desc;
> +	struct rpmhpd *curr_rpmhpd;
> +
> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	rpmhpds = desc->rpmhpds;
> +	curr_rpmhpd = rpmhpds[pd->id];
> +
> +	/* Do nothing for undefined power domains */
> +	if (!curr_rpmhpd) {
> +		log_warning("Power domain id (%ld) not supported\n",
> +			    pd->id);
> +		return 0;
> +	}
> +
> +	corner = 0;
> +
> +	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
> +				 false);
> +	if (!ret)
> +		curr_rpmhpd->enabled = false;
> +
> +	return ret;
> +}
> +
> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
> +{
> +	int i;
> +	const u16 *buf;
> +
> +	buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	/* 2 bytes used for each command DB aux data entry */
> +	rpmhpd->level_count >>= 1;
> +
> +	if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < rpmhpd->level_count; i++) {
> +		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
> +			continue;
> +
> +		rpmhpd->level[i] = buf[i];
> +
> +		/* Remember the first corner with non-zero level */
> +		if (!rpmhpd->level[rpmhpd->enable_corner] && rpmhpd->level[i])
> +			rpmhpd->enable_corner = i;
> +
> +		/*
> +		 * The AUX data may be zero padded. These 0 valued entries at
> +		 * the end of the map must be ignored.
> +		 */
> +		if (i > 0 && rpmhpd->level[i] == 0) {
> +			rpmhpd->level_count = i;
> +			break;
> +		}
> +		debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
> +		      rpmhpd->level[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rpmhpd_probe(struct udevice *dev)
> +{
> +	int i, ret = 0;
> +	struct rpmhpd **rpmhpds;
> +	struct rpmhpd *priv;
> +	const struct rpmhpd_desc *desc;
> +
> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	rpmhpds = desc->rpmhpds;
> +
> +	for (i = 0; i < desc->num_pds; i++) {
> +		if (!rpmhpds[i])
> +			continue;
> +
> +		priv = rpmhpds[i];
> +		priv->dev = dev;
> +		priv->addr = cmd_db_read_addr(priv->res_name);
> +		if (!priv->addr) {
> +			dev_err(dev, "Could not find RPMh address for resource %s\n",
> +				priv->res_name);
> +			return -ENODEV;
> +		}
> +
> +		ret = cmd_db_read_slave_id(priv->res_name);
> +		if (ret != CMD_DB_HW_ARC) {
> +			dev_err(dev, "RPMh slave ID mismatch\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = rpmhpd_update_level_mapping(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct power_domain_ops qcom_rpmhpd_power_ops = {
> +	.on = rpmhpd_power_on,
> +	.off = rpmhpd_power_off,
> +};
> +
> +U_BOOT_DRIVER(qcom_rpmhpd_drv) = {
> +	.name = "qcom_rpmhpd_drv",
> +	.id = UCLASS_POWER_DOMAIN,
> +	.of_match = rpmhpd_match_table,
> +	.probe = rpmhpd_probe,
> +	.ops = &qcom_rpmhpd_power_ops,
> +};
> -- 
> 2.34.1
> 
