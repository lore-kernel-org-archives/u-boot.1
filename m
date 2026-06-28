Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58662C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 17:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C9084931;
	Sun, 28 Jun 2026 19:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="WcjCjpNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06C483FEE; Sun, 28 Jun 2026 19:54:27 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886E284105
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 19:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 65fe4983-731a-11f1-8f53-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 65fe4983-731a-11f1-8f53-005056992ed3;
 Sun, 28 Jun 2026 19:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=VplsACYtvTJL5eMIH65DHY3YjZWyYEkdVL19CMYw2i8=;
 b=WcjCjpNwSwYn4AfQgsqQPodF4TNCYBrY89OTktm2qKtPrzkQCSOfCNCljDHX1ncTr0tRMueeQUeJF
 GzsNgzN3vWAownl7SlSRrflQvqvF0jqQ+nN3Y4+R0XNoBbwHAqZrHgcPHgv4dBkXj8ImFEqDSGAQiR
 IrUmFT2WXTS5gf3U9GVKHlZjAVnGl7v+OvcJk9Zb2A7VtzbO1Yq/snVw4PmsVWvlWuAyFsKDmbNF0v
 jeYqVGrL6b3El5/lyjQvdGUy86PkD0fCtOi0qCHmoTlP9PgJNNquDa6mpn+3mSjV2s8kQqJXt+9gUc
 eM2QF31ktOLbEYGJFK9l1VzQi68pixg==
X-KPN-MID: 33|OYvfOUjAT0YlYk1ZsaYDhpCtsgNtcAhmMLTd919Vgv4Zw4oEt1ZdkPU0y5phtd4
 pwfS4R0QA7WV9dhs6JX8P/Ry/8/qx1PrpgNu1c2nRYzQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cDgQEslzK/95UjSqitmtAugWKox+TawofJTsFy2b1x4v/ZV/50vT+Bad5EWw2XU
 YJWYV6xYZNSh0wxxYWV8hNA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6569d88b-731a-11f1-8dc4-00505699d6e5;
 Sun, 28 Jun 2026 19:54:24 +0200 (CEST)
Date: Sun, 28 Jun 2026 19:54:23 +0200
Message-Id: <87ik72k0ts.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Yureka <yureka@cyberchaos.dev>
Cc: j@jannau.net, u-boot@lists.denx.de, trini@konsulko.com,
 jh80.chung@samsung.com, peng.fan@nxp.com,
 kettenis@openbsd.org, neil.armstrong@linaro.org,
 sjg@chromium.org, kory.maincent@bootlin.com, me@ziyao.cc,
 visitorckw@gmail.com, alif.zakuan.yuslaimi@altera.com,
 jerome.forissier@arm.com, raymond.mao@riscstar.com,
 quentin.schulz@cherry.de, stefan.roese@mailbox.org,
 philip.molloy@analog.com, tien.fong.chee@altera.com,
 sumit.garg@oss.qualcomm.com, msp@baylibre.com,
 aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, marek.vasut@mailbox.org,
 yureka@cyberchaos.dev
In-Reply-To: <20260628-apple-pmp-report-v1-1-67b39539d879@cyberchaos.dev>
 (message from Yureka on Sun, 28 Jun 2026 18:11:13 +0200)
Subject: Re: [PATCH] power: domain: Add Apple PMP reporting driver
References: <20260628-apple-pmp-report-v1-1-67b39539d879@cyberchaos.dev>
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

> From: Yureka <yureka@cyberchaos.dev>
> Date: Sun, 28 Jun 2026 18:11:13 +0200
> 
> The Power Management Processor (PMP) is a coprocessor found on certain
> Apple SoCs.
> 
> This is a dummy driver which allows for devices bound to a PMGR domain
> through a PMP reporting domain to be powered on.
> Powering on the PMP itself is not necessary during boot.
> 
> Tested on M3 Max (T6034) with the nvme device tree node using one of
> the PMP reporting power domains.

The device tree bindings for these PMP device have not yet been
upstreamed.  Can we do that first?

> Signed-off-by: Yureka <yureka@cyberchaos.dev>
> ---
>  MAINTAINERS                             |  1 +
>  drivers/power/domain/Kconfig            | 13 ++++++++++
>  drivers/power/domain/Makefile           |  1 +
>  drivers/power/domain/apple-pmp-report.c | 45 +++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 571af196465..ec0c2abd9c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -148,6 +148,7 @@ F:	drivers/pci/pcie_apple.c
>  F:	drivers/phy/phy-apple-atc.c
>  F:	drivers/pinctrl/pinctrl-apple.c
>  F:	drivers/power/domain/apple-pmgr.c
> +F:	drivers/power/domain/apple-pmp-report.c
>  F:	drivers/spi/apple_spi.c
>  F:	drivers/watchdog/apple_wdt.c
>  F:	include/configs/apple.h
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 4112b777371..06112d33660 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -18,6 +18,19 @@ config APPLE_PMGR_POWER_DOMAIN
>  	  This driver is needed to power on parts of the SoC that have
>  	  not been powered on by previous boot stages.
>  
> +config APPLE_PMP_REPORT_POWER_DOMAIN
> +	bool "Enable the Apple PMP reporting power domain driver"
> +	depends on POWER_DOMAIN
> +	default y if ARCH_APPLE
> +	help
> +	  Enable support for reporting power states to the Apple Power
> +	  Management Processor (PMP).
> +
> +	  This is a dummy driver since the PMP is entirely optional and
> +	  enabling is not necessary during boot. However, it allows for
> +	  devices bound to a PMGR domain through a PMP reporting domain to be
> +	  powered on.
> +
>  config AGILEX5_PMGR_POWER_DOMAIN
>  	bool "Enable the Agilex5 PMGR power domain driver"
>  	depends on SPL_POWER_DOMAIN && ARCH_SOCFPGA_SOC64
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
> index 110153d5cf8..3e9711aa430 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) += power-domain-uclass.o
>  obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
> +obj-$(CONFIG_APPLE_PMP_REPORT_POWER_DOMAIN) += apple-pmp-report.o
>  obj-$(CONFIG_AGILEX5_PMGR_POWER_DOMAIN) += altr-pmgr-agilex5.o
>  obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
>  obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
> diff --git a/drivers/power/domain/apple-pmp-report.c b/drivers/power/domain/apple-pmp-report.c
> new file mode 100644
> index 00000000000..89fd81a7bd8
> --- /dev/null
> +++ b/drivers/power/domain/apple-pmp-report.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Yureka <yureka@cyberchaos.dev>
> + */
> +
> +#include <dm.h>
> +#include <power-domain-uclass.h>
> +
> +static const struct udevice_id apple_pmp_report_ids[] = {
> +	{ .compatible = "apple,t6000-pmp-v2-report" },
> +	{ .compatible = "apple,t6020-pmp-v2-report" },
> +	{ .compatible = "apple,t6030-pmp-v2-report" },
> +	{ .compatible = "apple,t8112-pmp-v2-report" },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(apple_pmp_report) = {
> +	.name = "apple_pmp_report",
> +	.id = UCLASS_NOP,
> +	.of_match = apple_pmp_report_ids,
> +	.bind = dm_scan_fdt_dev,
> +};
> +
> +static int apple_pmp_report_entry_of_xlate(struct power_domain *power_domain,
> +					   struct ofnode_phandle_args *args)
> +{
> +	return 0;
> +}
> +
> +static const struct udevice_id apple_pmp_report_entry_ids[] = {
> +	{ .compatible = "apple,t6000-pmp-v2-report-entry" },
> +	{ .compatible = "apple-pmp-report-entry" },
> +	{ /* sentinel */ }
> +};
> +
> +struct power_domain_ops apple_pmp_report_entry_ops = {
> +	.of_xlate = apple_pmp_report_entry_of_xlate,
> +};
> +
> +U_BOOT_DRIVER(apple_pmp_report_entry) = {
> +	.name = "apple_pmp_report_entry",
> +	.id = UCLASS_POWER_DOMAIN,
> +	.of_match = apple_pmp_report_entry_ids,
> +	.ops = &apple_pmp_report_entry_ops,
> +};
> 
> ---
> base-commit: 6902fb4c17faa375003124c451c2550deab5463d
> change-id: 20260628-apple-pmp-report-4d9dec73e3f2
> 
> Best regards,
> --  
> Yureka <yureka@cyberchaos.dev>
> 
> 
