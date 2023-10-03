Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6DFE7AD4D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B635874B4;
	Tue,  3 Oct 2023 15:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="esj2ZQ52";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TJChQk3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DB4874B1; Tue,  3 Oct 2023 15:41:09 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D321E87458
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S0Jr35d7Gz9sWl;
 Tue,  3 Oct 2023 15:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XiWGZK6IMTzrEKOmcdEQpoUSb5+sTooyWrBar51N0w=;
 b=esj2ZQ52j2Z4cLEW+89qakIarJc5Lpbxax5/y2aElz5M/TAVfliCY9r3vz61T9TJ4AVdaa
 22yr8XCxMgMB8oIXqR/yTvhA2vbIbC7t6pTZh/LhnemOli69pw4hfZhaC+NX/5S5Q2nKVF
 FKxRBK4WZ8VnupPo+m3oK2WvgnPX21OQxf+swHDmEgcd3rtbKuxGFlWo1LgDYl0FkuaWAM
 uW4dF9fY8NM/qqUPy8lncj+0vo5HOhNsiqls4sst4GYkP3WKTxL2ENUtolzfmTDlf1udFf
 JrQ9HlxQkRoSlft4WJGvFVktG7PaPyuu0RGvXNJ87V3p+w9aqQPtUI3nOM3Hyg==
Message-ID: <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XiWGZK6IMTzrEKOmcdEQpoUSb5+sTooyWrBar51N0w=;
 b=TJChQk3VC1AHkkCzcKUcxKlRoqLs9rSXToFeuu1/jYMpu7J6OsfiVNj4jhbQ9CleiQMw2z
 ewjvcE/AYxuPv1c/Flf1/NatwqDlwKo+tqhXPWKN1O93tiWqaz8HTRArjUDo6R2zUmsr9a
 t8MyjIaJ+1Cdf7j4kn3k1lWvLXibDQg3lGF8cJlQOhDgRnRvgqJbr6IELvYQ4rAC1+0uHA
 EnUD0Cpfz+ptqG2khksmNVf7v6LTl1B0O6Re8c8m+P/e88s11PQjayasosgW7hJnSccAqu
 ul1O2EcJt3BpAmCbBQCVI/x6yohYKJ9bhJTKHwZtjTMdaNzrFBlMwuIXE2hqtQ==
Date: Tue, 3 Oct 2023 15:36:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fk1swgcnth84ibm63744d1kqyctzmipc
X-MBO-RS-ID: fef7eb2697b1977b829
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

On 9/20/23 14:42, Paul Barker wrote:
> The Renesas RZ/G2L SMARC Evaluation Board Kit consists of the RZ/G2L
> System-on-Module (SOM) based on the R9A07G044L2 SoC, and a common SMARC
> carrier board.
> 
> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
> devicetree blob to the bootloader as an argument in the same was
> previous R-Car gen3/gen4 SoCs. This blob contains a compatible string
> which can be used to identify the particular SoC we are running on and
> this is used to select the appropriate device tree to load.
> 
> The configuration renesas_rzg2l_smarc_defconfig is added to support
> building for this target. In the future this defconfig will be extended
> to support other SoCs and evaluation boards from the RZ/G2L family.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Kconfig.rzg2l   | 14 +++++
>   board/renesas/rzg2l/Kconfig           | 18 +++++++
>   board/renesas/rzg2l/MAINTAINERS       |  6 +++
>   board/renesas/rzg2l/Makefile          |  4 ++
>   board/renesas/rzg2l/rzg2l.c           | 76 +++++++++++++++++++++++++++
>   configs/renesas_rzg2l_smarc_defconfig | 52 ++++++++++++++++++
>   include/configs/rzg2l-smarc.h         | 14 +++++
>   7 files changed, 184 insertions(+)
>   create mode 100644 board/renesas/rzg2l/Kconfig
>   create mode 100644 board/renesas/rzg2l/MAINTAINERS
>   create mode 100644 board/renesas/rzg2l/Makefile
>   create mode 100644 board/renesas/rzg2l/rzg2l.c
>   create mode 100644 configs/renesas_rzg2l_smarc_defconfig
>   create mode 100644 include/configs/rzg2l-smarc.h
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
> index 7d268e8c366a..1fe49e323300 100644
> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
> @@ -9,6 +9,20 @@ config R9A07G044L
>   	help
>   	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
>   
> +choice
> +	prompt "Renesas RZ/G2L Family Board selection"
> +	default TARGET_RZG2L_SMARC_EVK
> +
> +config TARGET_RZG2L_SMARC_EVK
> +	bool "Renesas RZ/G2L SMARC EVK"
> +	imply R9A07G044L
> +	help
> +	  Enable support for the RZ/G2L SMARC evaluation board.
> +
> +source "board/renesas/rzg2l/Kconfig"
> +
> +endchoice
> +
>   config MULTI_DTB_FIT_UNCOMPRESS_SZ
>   	default 0x80000 if TARGET_RZG2L_SMARC_EVK
>   
> diff --git a/board/renesas/rzg2l/Kconfig b/board/renesas/rzg2l/Kconfig
> new file mode 100644
> index 000000000000..1335fc7ae806
> --- /dev/null
> +++ b/board/renesas/rzg2l/Kconfig
> @@ -0,0 +1,18 @@
> +# Copyright (C) 2023 Renesas Electronics Corporation
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +if TARGET_RZG2L_SMARC_EVK
> +
> +config SYS_SOC
> +	default "rmobile"
> +
> +config SYS_BOARD
> +	default "rzg2l"
> +
> +config SYS_VENDOR
> +	default "renesas"
> +
> +config SYS_CONFIG_NAME
> +	default "rzg2l-smarc"
> +
> +endif
> diff --git a/board/renesas/rzg2l/MAINTAINERS b/board/renesas/rzg2l/MAINTAINERS
> new file mode 100644
> index 000000000000..0a51391c1fc9
> --- /dev/null
> +++ b/board/renesas/rzg2l/MAINTAINERS
> @@ -0,0 +1,6 @@
> +RENESAS RZG2L BOARD FAMILY
> +M:	Paul Barker <paul.barker.ct@bp.renesas.com>
> +S:	Supported
> +F:	arch/arm/dts/rz-smarc-common.dtsi

I suspect there should be more files here, right ?
You likely want to be CCed on things like rzg2l clock, scif, and so on.

> +N:	rzg2l
> +N:	r9a07g044
> diff --git a/board/renesas/rzg2l/Makefile b/board/renesas/rzg2l/Makefile
> new file mode 100644
> index 000000000000..466935fc8158
> --- /dev/null
> +++ b/board/renesas/rzg2l/Makefile
> @@ -0,0 +1,4 @@
> +# Copyright (C) 2023 Renesas Electronics Corporation
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y	:= rzg2l.o

> diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
> new file mode 100644
> index 000000000000..2b1bb3546c26
> --- /dev/null
> +++ b/board/renesas/rzg2l/rzg2l.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RZ/G2L board support.
> + * Copyright (C) 2023 Renesas Electronics Corporation
> + */
> +
> +#include <common.h>
> +#include <fdtdec.h>
> +#include <linux/libfdt.h>
> +
> +#if IS_ENABLED(CONFIG_MULTI_DTB_FIT)
> +/* If the firmware passed a device tree, use it for board identification. */
> +extern u64 rcar_atf_boot_args[];
> +
> +static bool is_rzg2l_board(const char *board_name)
> +{
> +	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
> +
> +	return fdt_node_check_compatible(atf_fdt_blob, 0, board_name) == 0;
> +}
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
> +
> +	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
> +		return -1;
> +
> +	if (is_rzg2l_board("renesas,r9a07g044l2"))
> +		return strcmp(name, "r9a07g044l2-smarc");
> +
> +	return -1;
> +}
> +#endif
> +
> +static void apply_atf_overlay(void *fdt_blob)
> +{
> +	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
> +
> +	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
> +		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
> +}
> +
> +int fdtdec_board_setup(const void *fdt_blob)
> +{
> +	apply_atf_overlay((void *)fdt_blob);
> +
> +	return 0;
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	return 0;

Are all these stub functions really needed or can they be removed 
(possibly also with removal of unnecessary config options) ?

> +}
> +
> +int __weak board_init(void)
> +{
> +	return 0;
> +}
> +
> +int dram_init(void)
> +{
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	fdtdec_setup_memory_banksize();

This and the one function above can likely go into arch/mach-rmobile/

> +	return 0;
> +}
> +
> +void __weak reset_cpu(void)
> +{

Is this platform missing a way to reset the system ?
Please fix.

[...]
