Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A735C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 08:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE6582145;
	Mon, 28 Apr 2025 10:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZCELRwUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9351382155; Mon, 28 Apr 2025 10:36:15 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190F080EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4B9C2A4A531;
 Mon, 28 Apr 2025 08:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB02CC4CEE4;
 Mon, 28 Apr 2025 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745829371;
 bh=gSV0APKx4cKwDVc7FuluiUTOp77stBM2jasz9vTv6dw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZCELRwUnDCJBwUbixxssPgcKwa3ZgCf4wCGw21re9WIR+upTXhmJSxre5+r5fEZqC
 EteBB0HhgEEytsUpcB467AzAMmNi5+3XTuFp0/E6DWVd0bdUY6cIpFzNLtL06nYiZx
 YXw9k0SFYGNiQisXwakgIu2cPHJ8f5PA/U2ZFToF34Px4DaYXZ7L+3FdE0yHCPVeve
 cWiA37qpunjshmH/X+FAL0pWhgicWZZi1XvLGoaoX9Nvgu6uBw6gUrlGRImtBzwvuF
 0lZi3u5PIWVKLk1oOGUjTZ1Z9ZjLAe2SirfEERX22o9xTHFrJhywJI5Z+BynM0EKXd
 0Nx07X3mTF7zA==
Date: Mon, 28 Apr 2025 14:06:04 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 me@samcday.com, marex@denx.de, robert.marko@sartura.hr,
 seashell11234455@gmail.com, ycliang@andestech.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/3] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <aA899AN_E1dURnWs@sumit-X1>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-3-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410120208.4142087-3-quic_varada@quicinc.com>
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

On Thu, Apr 10, 2025 at 05:32:07PM +0530, Varadarajan Narayanan wrote:
> Add SYSRESET_EDL to sysreset_t and handle the different SYSRESET_xxx
> requests in sysreset_qcom-psci.c.

Kindly add ellborative commit message as to what problem you are trying
to address here and what is actually EDL mode? Is it specific to Qcom
platforms or does any other silicon vendor supports similar method?

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/sysreset/Kconfig              |  5 +++
>  drivers/sysreset/Makefile             |  1 +
>  drivers/sysreset/sysreset-uclass.c    |  7 ++--
>  drivers/sysreset/sysreset_qcom-psci.c | 47 +++++++++++++++++++++++++++
>  include/sysreset.h                    |  2 ++
>  5 files changed, 60 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> 
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 121194e4418..a6a1e57b603 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -240,6 +240,11 @@ config SYSRESET_RAA215300
>  	help
>  	  Add support for the system reboot via the Renesas RAA215300 PMIC.
>  
> +config SYSRESET_QCOM_PSCI
> +	bool "Support sysreset for Qualcomm SoCs via PSCI"
> +	help
> +	  Add support for the system reboot on Qualcomm SoCs via PSCI.

Ellaborate here to mention support for poweroff and EDL mode.

> +
>  config SYSRESET_QCOM_PSHOLD
>  	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
>  	depends on ARCH_IPQ40XX
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index 796fc9effa5..12dbad5254a 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -29,5 +29,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>  obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
>  obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
>  obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
> +obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
>  obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
>  obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index 536ac727142..d06c0a6908a 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -125,8 +125,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	if (argc > 2)
>  		return CMD_RET_USAGE;
>  
> -	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> -		reset_type = SYSRESET_WARM;
> +	if (argc == 2) {
> +		if (argv[1][0] == '-' && argv[1][1] == 'w')
> +			reset_type = SYSRESET_WARM;
> +		else if (!strncmp("edl", argv[1], 3))

Try to follow existing pattern "reset -w" like "reset -edl".

> +			reset_type = SYSRESET_EDL;
>  	}
>  
>  	printf("resetting ...\n");
> diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
> new file mode 100644
> index 00000000000..3afb79e2d2e
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_qcom-psci.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>

Forgot to append copyright here?

> + */
> +
> +#include <dm.h>
> +#include <sysreset.h>
> +#include <asm/system.h>
> +#include <linux/errno.h>
> +#include <linux/psci.h>
> +
> +__weak int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)

Why is it declared weak?

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int qcom_psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
> +{
> +	switch (type) {
> +	case SYSRESET_WARM:
> +	case SYSRESET_COLD:
> +		psci_sys_reset(type);
> +		break;
> +	case SYSRESET_POWER_OFF:
> +		psci_sys_poweroff();
> +		break;
> +	case SYSRESET_EDL:
> +		psci_system_reset2(0, 1);
> +		break;
> +	default:
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	return -EINPROGRESS;
> +}
> +
> +static struct sysreset_ops qcom_psci_sysreset_ops = {
> +	.request = qcom_psci_sysreset_request,
> +	.get_status = qcom_psci_sysreset_get_status,
> +};
> +
> +U_BOOT_DRIVER(qcom_psci_sysreset) = {
> +	.name = "qcom_psci-sysreset",
> +	.id = UCLASS_SYSRESET,
> +	.ops = &qcom_psci_sysreset_ops,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/include/sysreset.h b/include/sysreset.h
> index ff20abdeed3..8bda9703cd9 100644
> --- a/include/sysreset.h
> +++ b/include/sysreset.h
> @@ -21,6 +21,8 @@ enum sysreset_t {
>  	SYSRESET_POWER,
>  	/** @SYSRESET_POWER_OFF: turn off power */
>  	SYSRESET_POWER_OFF,
> +	/** @SYSRESET_EDL: reset and boot into Emergency DownLoader */

Is it Qcom specific then add proper comments here?

-Sumit

> +	SYSRESET_EDL,
>  	/** @SYSRESET_COUNT: number of available reset types */
>  	SYSRESET_COUNT,
>  };
> -- 
> 2.34.1
> 
