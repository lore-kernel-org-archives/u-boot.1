Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82222CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 12:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A30836D1;
	Mon,  3 Nov 2025 13:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wx3DGfiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648F9838AE; Mon,  3 Nov 2025 13:36:23 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F2D8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 13:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so35366305e9.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762173380; x=1762778180; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0pdMZ1LD/bo3hjhDP7esza6QdvawapfA0uSGaihot/U=;
 b=wx3DGfiALYTe7NAKrTLcQKyhXXP4eFAxlpnoGaU8KfK6ll44s3nhBUeVaVFiv0tqba
 popi04zWzBMQCPPKZwXQMp3botaJGSqLNf/LuASJPiXU/m/Dphhds63PZgIw4CbWq+nI
 dA+7UdGsKqDh4nSFjw5/lSehjGEswOirl//5yrVfQpgIIkcrwPCKFqll0SOIGj8S7lRi
 XawVgKv3kaK2lSWkZs1CWhqx/UF0hW4nmV91toFnQz4KqaF89Q9dRLQkNCXP7aB8V4MD
 kCoNCadSr9SsZC752ISOk2ew1U7LVBi2yjYr35MpHu8lV/M/AJDhLHq/VbQ74TsS0Xdg
 ENcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762173380; x=1762778180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0pdMZ1LD/bo3hjhDP7esza6QdvawapfA0uSGaihot/U=;
 b=pjWXbojl/azRk3FGbqEnaRGkerN9QN0+Abb7UXOJlRsPuomKAQdYj2nPvhTt5i4cXd
 LpxkyGd10qCV6vChjBLEhUabErbz3pXtwRzLTbrZaVbbnjWLv3TlD6QoH28ikiQQ0kJq
 +NXSMUZd4Vj+lHgTpupKd8EUcNkOfZhAHDhkFg4OGmgnIEC2rXkzw7SjSHnm2Kx8b0mf
 c68OAzkqu4LpLP+WydJZJ11uspw+3LY1jluqinyB1sltdMZ4/scYqha393c0c8KYeKLA
 5Cb6D823CucsIPzJEz+GRjBEsS3lQ+URzdTujnheec12mV6TBIiL91c1iwCb0J9bpC+E
 EEZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOD6Wm+yX7zjLnD/pKWQ4XTwx579MpjnmQkht2dJAUvW4MoBa5FvnhO8p5F+MXdJaIMiNsV8c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4q1N5ksc8KU3A4f/tUc6aSL7vUZpEj3MMtHZL6vqd0k26weNy
 Dlh5UtcwVDkT5ARxhwkfzEWsqQFXVV9f4BS9d1nNg09J4nv9e2DKxo8iL0oBTGMsIfg=
X-Gm-Gg: ASbGnct+o7CTnPO4ZwDXTBRa+xwZOUfZtEIdMQ3Wb26G6o/tieMkfIFrGPwxTGRSj9O
 EFvZZirlRWVLAJNQmgbVLQuX567lsUS+Al8kF6HTp/FhM4nWfXIUA7vdGvgk9hVH/OBQY9QJYyi
 reYf5Yicdznvin6Wv/nKiTYOegXuG/WGc3ieCglVHf1fNwhgcerT1LZNhGyOMz3LGIQjgvSEWAf
 YORdC1RvM8ejFO/9NvvwUM9Mp6q1fK/KErAm+SWh7nghGlO37sT+HKWDyqN+1VEWmKDiIRVbB0/
 Jo/fuhp9GSkRoju63qT3DTHRvTEVQSyiPTo91Gslog6PT8Sq2O69RhuulFdztEP1Yo2DqLQGDTc
 foh623ZfzumAUQ0F6moof3MCVuT78caQT5fNFQttYswyvgdHk3FSeu3l0GpRCMhpAnbaVCk+g0m
 Pp6VZDg5oMMmCLPwwRwTUQrXdlYbYAV9nYIZK9kMPIwcFIPQrXHnuNO2JxLFkSmg==
X-Google-Smtp-Source: AGHT+IFw86RVQpiL/2X57qGBkq+VAZ7oNfGThg1e/FNYP/1LUKJ2jeOyb2gzHKDJIPG6fj7LRHULZg==
X-Received: by 2002:a05:600c:8208:b0:477:19af:31bc with SMTP id
 5b1f17b1804b1-477307c3805mr103020085e9.12.1762173380006; 
 Mon, 03 Nov 2025 04:36:20 -0800 (PST)
Received: from [172.18.195.54] (ip-185-104-138-158.ptr.icomera.net.
 [185.104.138.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2ff79bsm152681165e9.6.2025.11.03.04.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 04:36:18 -0800 (PST)
Message-ID: <69cf689a-f3ed-48f7-98a1-36b87d4cf933@linaro.org>
Date: Mon, 3 Nov 2025 13:36:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] power-domain: Add QCOM RPMH Power Domain Driver
 Support
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
 <20251027113312.3815169-3-aswinm@qti.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251027113312.3815169-3-aswinm@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Aswin,

On 10/27/25 12:33, Aswin Murugan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Added support for Qualcomm RPMH power domain driver, responsible
> for managing power domains on Qualcomm SoCs. This is a port of
> the Linux RPMHPD driver [1] and sa8775p related changes. The
> power domain driver currently has support to power on and off
> MMCX power domain of sa8775p; support for other soc entries power
> domains are stubbed, in future, the required soc support can be
> added.
> 
> [1]:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
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
> ---
>   drivers/power/domain/Kconfig       |   8 +
>   drivers/power/domain/Makefile      |   1 +
>   drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
>   3 files changed, 287 insertions(+)
>   create mode 100644 drivers/power/domain/qcom-rpmhpd.c
> 
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 0ad885c9e8b..48e841c638e 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -90,6 +90,14 @@ config MESON_SECURE_POWER_DOMAIN
>   	  Enable support for manipulating Amlogic Meson Secure power domains.
>   	  Support for Amlogic A1 series.
>   
> +config QCOM_POWER_DOMAIN

This is a bit too broad of a name I think, how about 
QCOM_RPMH_POWER_DOMAIN ? Since there are other Qualcomm platforms with 
different power domains and this is just for RPMh.

(more comments below)

> +	bool "Enable the QCOM RPMH Power domain driver"
> +	depends on POWER_DOMAIN && ARCH_SNAPDRAGON
> +	help
> +	  Generic RPMH power domain implementation for QCOM devices.
> +	  The RPMH power domain driver is responsible for managing power
> +	  domains on Qualcomm SoCs.
> +
>   config SANDBOX_POWER_DOMAIN
>   	bool "Enable the sandbox power domain test driver"
>   	depends on POWER_DOMAIN && SANDBOX
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
> index 8e03f620437..1c2c64b0964 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
>   obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
>   obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
>   obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
> +obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
> diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
> new file mode 100644
> index 00000000000..14e93f87005
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
> +	int i, ret;
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

ret will be unitialised here when num_pds is 0.

Also, you mention in the changelog that the stubbed platforms are 
handled with a warning but I don't see where that gets printed?

Kind regards,
Casey (she/they)

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

