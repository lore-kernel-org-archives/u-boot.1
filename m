Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E6C0218C
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0045B80EB7;
	Fri, 24 Jan 2025 16:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732411;
	bh=OGuDtuNFnJcHR+R+C0wCQWv4KSNSsG3O+xc7GEdiI4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cex0Far8C4mFqiFY9kLGn3IBj80PeSUgounRM8ngsEkD/JnxFZRYJ6zk4mo9U05DA
	 wwaOgJj6zcSS5fjv97LFSxKyyJmAeD+snIekV1Hucvhnis2hNa6vrPo8XOXpEVVkUz
	 Fr3kE5gvzigqCim9Xps3MiP9PT1Emxvwj7jZ0jTM3lsztkabKpkGRu5TYpbvodER1r
	 /Ur3kcqIh/2+95VG/UurRhPBEMPmgvzj3+vXytC79R5l/NE4S8rGqaEB8uJB90u4yZ
	 p4h2tKrHNoO0CjST5IvAn+efXGHY1X137vgbeSM1XAajb0UNc/FKggZAxSb0dl28z3
	 mFyEzo5N3y/Ag==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCDC80C99; Fri, 24 Jan 2025 16:26:49 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59CE80AE2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="IViJPoLz"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6AC00108873CC; Fri, 24 Jan 2025 16:26:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGuDtuNFnJcHR+R+C0wCQWv4KSNSsG3O+xc7GEdiI4w=;
 b=IViJPoLz+gWNkHQ82HY/EFzaZMkZJCdeUpa+/NyjPczYpuLN6Bh3BNL1UKIyWQocOGRezl
 VoeNoxCpQF/vn4yxibVxLkraKezamSs0UmInofET+ZR8BK7M4bSkL7A3mHJRbRg8WcL050
 3vVgVP/ZCCOqWgsfLZIIJTzwQ/RNSUxj6nVoIVPCW4CKZUH1I5yGwQtcOkFP6CXbOkXvj2
 XUwdKw5a177ARviEix9NI3/66qT+Zm/2C8tSsWAIbEudU7Xplxguk/AYZGWaLvylS4Hj1M
 j1FxdNhE4VOQ+ACrck/SF4KWTVR4a8GeTn15sHJBpOqQgXguKFtRpRlqqEf41g==
Message-ID: <e80ec970-5742-47ad-87b7-a77eb1e18f61@denx.de>
Date: Fri, 24 Jan 2025 16:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/20] imx9: scmi: add i.MX95 SoC and clock related code
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-12-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-12-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 2:28 PM, Alice Guo wrote:

> +void init_uart_clk(u32 index)
> +{
> +	u32 clock_id;
> +
> +	switch (index) {
> +	case 0:
> +		clock_id = IMX95_CLK_LPUART1;
> +		break;
> +	case 1:
> +		clock_id = IMX95_CLK_LPUART2;
> +		break;
> +	case 2:
> +		clock_id = IMX95_CLK_LPUART3;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* 24MHz */
> +	imx_clk_scmi_enable(clock_id, false);
> +	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
> +	imx_clk_scmi_set_rate(clock_id, 24000000);
> +	imx_clk_scmi_enable(clock_id, true);
> +}

Is this ad-hoc clock management necessary even with DM_CLK ?

> +unsigned int mxc_get_clock(enum mxc_clock clk)
> +{
> +	switch (clk) {
> +	case MXC_ARM_CLK:
> +		return get_arm_core_clk();
> +	case MXC_IPG_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
> +	case MXC_CSPI_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
> +	case MXC_ESDHC_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
> +	case MXC_ESDHC2_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
> +	case MXC_ESDHC3_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
> +	case MXC_UART_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
> +	case MXC_FLEXSPI_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
> +	default:
> +		return -1;
> +	};
> +
> +	return -1;
> +};

Is this ad-hoc clock management necessary even with DM_CLK ?

> diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..23ffe0eed695b67977d441f7ee8830af9c4aabfe
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + *
> + * Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <dm/uclass.h>
> +#include <scmi_agent.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int imx_clk_scmi_enable(u32 clock_id, bool enable)

Is this ad-hoc clock management necessary even with DM_CLK ?

[...]

> +int print_cpuinfo(void)
> +{
> +	u32 cpurev, max_freq;
> +	int minc, maxc;
> +
> +	cpurev = get_cpu_rev();
> +
> +	printf("CPU:   i.MX%s rev%d.%d",
> +		get_imx_type((cpurev & 0x1FF000) >> 12),
> +		(cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
> +
> +	max_freq = get_cpu_speed_grade_hz();
> +	if (!max_freq || max_freq == mxc_get_clock(MXC_ARM_CLK)) {
> +		printf(" at %dMHz\n", mxc_get_clock(MXC_ARM_CLK) / 1000000);
> +	} else {
> +		printf(" %d MHz (running at %d MHz)\n", max_freq / 1000000,
> +		       mxc_get_clock(MXC_ARM_CLK) / 1000000);
> +	}
> +
> +	puts("CPU:   ");
> +	switch (get_cpu_temp_grade(&minc, &maxc)) {
> +	case TEMP_AUTOMOTIVE:
> +		puts("Automotive temperature grade ");
> +		break;
> +	case TEMP_INDUSTRIAL:
> +		puts("Industrial temperature grade ");
> +		break;
> +	case TEMP_EXTCOMMERCIAL:
> +		if (is_imx93())
> +			puts("Extended Industrial temperature grade ");
> +		else
> +			puts("Extended Consumer temperature grade ");
> +		break;
> +	default:
> +		puts("Consumer temperature grade ");
> +		break;
> +	}
> +	printf("(%dC to %dC)", minc, maxc);
> +
> +#if defined(CONFIG_DM_THERMAL)

Use "if (CONFIG_IS_ENABLED(...))" instead of preprocessor "#if ..." 
where possible so compiler can detect bitrot.

[...]

> +int arch_misc_init(void)
> +{
> +	build_info();
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF_BOARD_FIXUP
> +#ifndef CONFIG_SPL_BUILD

Can this ifdeffery be cleaned up ?

> +int board_fix_fdt(void *fdt)
> +{
> +	return 0;
> +}
> +#endif
> +#endif
> +
> +int ft_system_setup(void *blob, struct bd_info *bd)
> +{
> +	return 0;
> +}
> +
> +#if defined(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)

Use if (CONFIG_IS_ENABLED()) or if (IS_ENABLED()) and please fix globally.
