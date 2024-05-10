Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93719C25B74
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C028885E;
	Fri, 10 May 2024 02:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LJ2sTopm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD9788853; Fri, 10 May 2024 02:44:44 +0200 (CEST)
Received: from mail-m25495.xmail.ntesmail.com (mail-m25495.xmail.ntesmail.com
 [103.129.254.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8A088860
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LJ2sTopmEwxNKE/MY8yLwOUBYjenqVdGNCbuzxBjs05NCQune7jq1TisBKbp84xd3gQe6/O/pXJyop7OXBhd918lXUdTtU8jpnS3TH6SmlXhQf/32vFoM5H8abAU/jQioKErsp49FULTTm5/AJuGqINCepO+vJ2HzzMKwSqz/uc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=CWIkNnN/v6p4g1SsnBfKM4kxKHeCMhdW/dBgmVwv5Z0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 3476490018C;
 Fri, 10 May 2024 08:44:38 +0800 (CST)
Message-ID: <00394c4d-e30b-4431-b1ad-9acf34e22c1b@rock-chips.com>
Date: Fri, 10 May 2024 08:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 68/81] sysreset: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-68-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-68-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlDSFZCSB8dTU9NTx9DTk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff58a2903a9kunm3476490018c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6Iio6ETNKTQI#GS02SQ85
 ETBPChVVSlVKTEpOSEtKQ0xDTENIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSkNPTzcG
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


On 2024/5/2 09:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo <ycliang@andestech.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Tien Fong Chee <tien.fong.chee@intel.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
>   drivers/sysreset/poweroff_gpio.c          | 1 -
>   drivers/sysreset/sysreset-ti-sci.c        | 1 -
>   drivers/sysreset/sysreset-uclass.c        | 1 -
>   drivers/sysreset/sysreset_ast.c           | 1 -
>   drivers/sysreset/sysreset_at91.c          | 1 -
>   drivers/sysreset/sysreset_gpio.c          | 1 -
>   drivers/sysreset/sysreset_microblaze.c    | 1 -
>   drivers/sysreset/sysreset_mpc83xx.c       | 1 -
>   drivers/sysreset/sysreset_octeon.c        | 1 -
>   drivers/sysreset/sysreset_psci.c          | 1 -
>   drivers/sysreset/sysreset_resetctl.c      | 1 -
>   drivers/sysreset/sysreset_rockchip.c      | 1 -
>   drivers/sysreset/sysreset_sandbox.c       | 1 -
>   drivers/sysreset/sysreset_sbi.c           | 1 -
>   drivers/sysreset/sysreset_socfpga.c       | 1 -
>   drivers/sysreset/sysreset_socfpga_soc64.c | 1 -
>   drivers/sysreset/sysreset_sti.c           | 1 -
>   drivers/sysreset/sysreset_syscon.c        | 1 -
>   drivers/sysreset/sysreset_watchdog.c      | 1 -
>   drivers/sysreset/sysreset_x86.c           | 1 -
>   drivers/sysreset/sysreset_xtfpga.c        | 2 +-
>   21 files changed, 1 insertion(+), 21 deletions(-)
>
> diff --git a/drivers/sysreset/poweroff_gpio.c b/drivers/sysreset/poweroff_gpio.c
> index ad04e4b1a85e..d9220024f470 100644
> --- a/drivers/sysreset/poweroff_gpio.c
> +++ b/drivers/sysreset/poweroff_gpio.c
> @@ -11,7 +11,6 @@
>    * Copyright (C) 2012 Jamie Lentin
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/sysreset/sysreset-ti-sci.c b/drivers/sysreset/sysreset-ti-sci.c
> index 0de132633a8d..451fc5de7357 100644
> --- a/drivers/sysreset/sysreset-ti-sci.c
> +++ b/drivers/sysreset/sysreset-ti-sci.c
> @@ -6,7 +6,6 @@
>    *	Andreas Dannenberg <dannenberg@ti.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index 6151b5fe03e4..0abb4042e0f2 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SYSRESET
>   
> -#include <common.h>
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/sysreset/sysreset_ast.c b/drivers/sysreset/sysreset_ast.c
> index 92fad96871bd..ef09440bbeff 100644
> --- a/drivers/sysreset/sysreset_ast.c
> +++ b/drivers/sysreset/sysreset_ast.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2016 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/sysreset/sysreset_at91.c b/drivers/sysreset/sysreset_at91.c
> index fc85f31ebf01..457042c7aae9 100644
> --- a/drivers/sysreset/sysreset_at91.c
> +++ b/drivers/sysreset/sysreset_at91.c
> @@ -7,7 +7,6 @@
>   #include <asm/io.h>
>   #include <asm/arch/at91_rstc.h>
>   #include <clk.h>
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/sysreset/sysreset_gpio.c b/drivers/sysreset/sysreset_gpio.c
> index de42b5935424..47018844a51a 100644
> --- a/drivers/sysreset/sysreset_gpio.c
> +++ b/drivers/sysreset/sysreset_gpio.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2018 Xilinx, Inc. - Michal Simek
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/sysreset/sysreset_microblaze.c b/drivers/sysreset/sysreset_microblaze.c
> index 83a7f77ac41f..b81d82f046bd 100644
> --- a/drivers/sysreset/sysreset_microblaze.c
> +++ b/drivers/sysreset/sysreset_microblaze.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2018 Xilinx, Inc. - Michal Simek
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
> diff --git a/drivers/sysreset/sysreset_mpc83xx.c b/drivers/sysreset/sysreset_mpc83xx.c
> index ca48328f7b58..dca49299f777 100644
> --- a/drivers/sysreset/sysreset_mpc83xx.c
> +++ b/drivers/sysreset/sysreset_mpc83xx.c
> @@ -4,7 +4,6 @@
>    * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/sysreset/sysreset_octeon.c b/drivers/sysreset/sysreset_octeon.c
> index ebdea6ab66ed..c16223720e5a 100644
> --- a/drivers/sysreset/sysreset_octeon.c
> +++ b/drivers/sysreset/sysreset_octeon.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
> diff --git a/drivers/sysreset/sysreset_psci.c b/drivers/sysreset/sysreset_psci.c
> index aa09d0b88271..89b4f2dcaec4 100644
> --- a/drivers/sysreset/sysreset_psci.c
> +++ b/drivers/sysreset/sysreset_psci.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <sysreset.h>
>   #include <linux/errno.h>
> diff --git a/drivers/sysreset/sysreset_resetctl.c b/drivers/sysreset/sysreset_resetctl.c
> index 25bd5c9a7ff2..fbe3999b9605 100644
> --- a/drivers/sysreset/sysreset_resetctl.c
> +++ b/drivers/sysreset/sysreset_resetctl.c
> @@ -5,7 +5,6 @@
>    * Author:  Weijie Gao <weijie.gao@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
> index f353f9b4c79d..00308f9a33b7 100644
> --- a/drivers/sysreset/sysreset_rockchip.c
> +++ b/drivers/sysreset/sysreset_rockchip.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2017 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
> diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
> index c12eda81d03e..93179f90bbb8 100644
> --- a/drivers/sysreset/sysreset_sandbox.c
> +++ b/drivers/sysreset/sysreset_sandbox.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
> diff --git a/drivers/sysreset/sysreset_sbi.c b/drivers/sysreset/sysreset_sbi.c
> index 5e8090d62bfc..458191206b2c 100644
> --- a/drivers/sysreset/sysreset_sbi.c
> +++ b/drivers/sysreset/sysreset_sbi.c
> @@ -3,7 +3,6 @@
>    * Copyright 2021, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/sysreset/sysreset_socfpga.c b/drivers/sysreset/sysreset_socfpga.c
> index 9b62dd5eab09..a07b0f4fd553 100644
> --- a/drivers/sysreset/sysreset_socfpga.c
> +++ b/drivers/sysreset/sysreset_socfpga.c
> @@ -4,7 +4,6 @@
>    * Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
> diff --git a/drivers/sysreset/sysreset_socfpga_soc64.c b/drivers/sysreset/sysreset_socfpga_soc64.c
> index 9837aadf64b6..6f44792abb00 100644
> --- a/drivers/sysreset/sysreset_socfpga_soc64.c
> +++ b/drivers/sysreset/sysreset_socfpga_soc64.c
> @@ -4,7 +4,6 @@
>    * Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
> diff --git a/drivers/sysreset/sysreset_sti.c b/drivers/sysreset/sysreset_sti.c
> index edd90aab061d..110b7e23afa1 100644
> --- a/drivers/sysreset/sysreset_sti.c
> +++ b/drivers/sysreset/sysreset_sti.c
> @@ -4,7 +4,6 @@
>    * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <regmap.h>
>   #include <syscon.h>
> diff --git a/drivers/sysreset/sysreset_syscon.c b/drivers/sysreset/sysreset_syscon.c
> index e468dac0e902..57144fa1e3bb 100644
> --- a/drivers/sysreset/sysreset_syscon.c
> +++ b/drivers/sysreset/sysreset_syscon.c
> @@ -7,7 +7,6 @@
>    *	Author: Feng Kan <fkan@apm.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <regmap.h>
> diff --git a/drivers/sysreset/sysreset_watchdog.c b/drivers/sysreset/sysreset_watchdog.c
> index 6db5aa75b541..49c061e08803 100644
> --- a/drivers/sysreset/sysreset_watchdog.c
> +++ b/drivers/sysreset/sysreset_watchdog.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device-internal.h>
>   #include <errno.h>
> diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> index dc772b5ff9e3..c2f28c65280f 100644
> --- a/drivers/sysreset/sysreset_x86.c
> +++ b/drivers/sysreset/sysreset_x86.c
> @@ -5,7 +5,6 @@
>    * Generic reset driver for x86 processor
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <efi_loader.h>
>   #include <pch.h>
> diff --git a/drivers/sysreset/sysreset_xtfpga.c b/drivers/sysreset/sysreset_xtfpga.c
> index 84fbc79016a0..ab71ea11a0b2 100644
> --- a/drivers/sysreset/sysreset_xtfpga.c
> +++ b/drivers/sysreset/sysreset_xtfpga.c
> @@ -5,7 +5,7 @@
>    * (C) Copyright 2016 Cadence Design Systems Inc.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <sysreset.h>
