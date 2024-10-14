Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDFDD1813C
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B4789026;
	Mon, 14 Oct 2024 20:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728931326;
	bh=O2AiibChCNusrkaip49GJGyJ7+urbWKtMEw+69RQTRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jx4egDXeHSYlCXBwBrWaGgOprHT2KixopLkbjZZ/jyT+i3VjlVIgctltrDclZ38z0
	 +MxkYl14CwBQz+wus9IAatPm7Hqkj7DMivvVVPiERNYm53WFrJv6h8bl1syUUE6HkD
	 Bgyqyd3lddNlT71urD2P0flK4VEOBPp8Jxz2YbG98is/NXY/z8bUBjs1+95WDZneAn
	 NhvAqguCy9rulBhpo+tdXqYJ2+0Gaztdtk3NYEW0sy/93hkP4QM37V+6al6crq8KtU
	 gk9LhnOwlJf7JjEDthujQnZgoiHIoSk6Tp3MiQyWhMVKSrjmALF81Ft4+iedEZeK73
	 Q0rfT0jFCA1ZA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8C5AC88DA0;
 Mon, 14 Oct 2024 20:42:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728931325;
 bh=O2AiibChCNusrkaip49GJGyJ7+urbWKtMEw+69RQTRM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=quQGbGJIE+yBfbxWqzSDOxIjp4rfawoU86XYuu+PCnZmeARTUS4oIUHEaY11Oiyo/
 JYDFUO/U1K3WdkC5WUTphCE3XBWzg+i+MuKgHvh1GlKiWayxZR9ZsHVBTVH7bhgtzc
 hbnimxlC4Ib/7udctrfqal3HCzWOnf/q/cc+XOElCgYRwyU0+9j1stnKyrlInxRuZj
 abf8aq7VbrACCUjOFG4VUeS49IrtArZe6dFt0om8/18+0PBVHGUI9IlrT4Y4XP/4jj
 /XE6Uyr3kZfWZ5HD14J5OvpX5oyqxjG2Dj+OTV1KSU0o/TdbH7oKpvzTEX2yDXm8Ur
 HEeKuj2GpErtw==
Message-ID: <f7c6ecac-44bc-497c-ac0a-c37c48e5c8ac@denx.de>
Date: Mon, 14 Oct 2024 19:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ARM: socfpga: add Enclustra storage switch
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-5-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013143232.2090645-5-l.rubusch@gmail.com>
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

On 10/13/24 4:32 PM, Lothar Rubusch wrote:

[...]

> diff --git a/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c b/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
> new file mode 100644
> index 0000000000..95438c5487
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Enclustra GmbH
> + * <info@enclustra.com>
> + */
> +
> +#include <command.h>
> +#include <env.h>
> +#include <init.h>
> +#include <dm.h>
> +#include <dm/uclass.h>
> +#include <asm-generic/gpio.h>
> +#include <asm/io.h>
> +
> +/* Pin muxing */
> +#define ALTERA_NONE 0
> +#define ALTERA_MMC 1
> +#define ALTERA_QSPI 2
> +#define ALTERA_EMMC 3
> +#define MMC_CLK_DIV 0x9
> +#define QSPI_CLK_DIV 0x384
> +#define ALTERA_PINMUX_OFFS 0xffd07200
> +#define ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE 0xFFD04078
> +
> +static int altera_current_storage = ALTERA_NONE;
> +
> +static const struct udevice_id altera_set_storage_match[] = {
> +	{ .compatible = "encl,altera_set_storage" },

DT bindings indicate the prefix is incorrect:

Documentation/devicetree/bindings/vendor-prefixes.yaml:  "^enclustra,.*":
Documentation/devicetree/bindings/vendor-prefixes.yaml:    description: 
Enclustra GmbH


> +	{ }
> +};
> +
> +U_BOOT_DRIVER(altera_set_storage) = {
> +	.name		= "altera_set_storage",
> +	.id			= UCLASS_MISC,
> +	.of_match	= altera_set_storage_match,
> +};
> +
> +static void enclustra_mercury_aa1_write(const u32 *pinmux_arr, int len)
> +{
> +	u32 i, offset, value;
> +
> +	for (i = 0; i < len; i += 2) {
> +		offset = pinmux_arr[i];
> +		value = pinmux_arr[i + 1];
> +		writel(value, ALTERA_PINMUX_OFFS + offset);
> +	}
> +}
> +
> +static void enclustra_mercury_aa1_set_mux_mmc(void)
> +{
> +	static const u32 pinmux_arr[] = {0x0c, 0x8,	// IO4 connected to SDMMC
> +					 0x10, 0x8,	// IO5
> +					 0x14, 0x8,	// IO6
> +					 0x18, 0x8,	// IO7
> +					 0x1c, 0x8,	// IO8
> +					 0x20, 0x8,	// IO9
> +					 0x24, 0xf,	// IO10 connected to GPIO
> +					 0x28, 0xf,	// IO11
> +					 0x2c, 0xf,	// IO12
> +					 0x30, 0xf,	// IO13
> +					 0x34, 0xf,	// IO14
> +					 0x38, 0xf};	// IO15
> +	enclustra_mercury_aa1_write(pinmux_arr, sizeof(pinmux_arr) / sizeof(u32));

Try ARRAY_SIZE()

[...]

> +static int altera_set_storage_cmd(struct cmd_tbl *cmdtp, int flag,
> +				  int argc, char * const argv[])
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(altera_set_storage), &dev);
> +	if (ret)
> +		return ret;
> +
> +	if (argc != 2)
> +		return CMD_RET_USAGE;
> +
> +	if (!strcmp(argv[1], "MMC") || !strcmp(argv[1], "mmc"))
> +		return altera_set_storage(dev, ALTERA_MMC);
> +	else if (!strcmp(argv[1], "QSPI") || !strcmp(argv[1], "qspi"))
> +		return altera_set_storage(dev, ALTERA_QSPI);
> +	else if (!strcmp(argv[1], "EMMC") || !strcmp(argv[1], "emmc"))

Try strcasecmp()
