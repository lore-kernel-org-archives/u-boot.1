Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B6EC10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D8FA88863;
	Fri, 10 May 2024 02:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WOfTeyow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CACED88853; Fri, 10 May 2024 02:44:54 +0200 (CEST)
Received: from mail-m254115.xmail.ntesmail.com
 (mail-m254115.xmail.ntesmail.com [103.129.254.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8065488864
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WOfTeyow7M51Jtd+4+jPi/nZGawYbLlBbWP0HOutCUsjWFvAqJOagbZtOpa1aE+k/141K6v97dNSpIqaqMUpIdIYAa/WT8n+/nEXpr/TaRrhEz0rcsXgA1mgepIh04fdVfXzQUOaVE0CFj28+yQhj7Ds4hOn8oJdU4nOIMwL4FE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=x0naD86jdaIUyF6PSgsq1xdpnQnq1fyTTHSByoPjJ5Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8929D9001B7;
 Fri, 10 May 2024 08:44:47 +0800 (CST)
Message-ID: <4b5d0c30-a5b7-43c2-b23b-e92196512631@rock-chips.com>
Date: Fri, 10 May 2024 08:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 70/81] timer: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-70-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-70-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkoZS1ZMHU1MSExJGBhJH0JVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff5aea903a9kunm8929d9001b7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mww6Hio4NTNWHAJJNyw5SRAO
 TT5PFEtVSlVKTEpOSEtKQ0NDSUlCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTkJJTjcG
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
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo <ycliang@andestech.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Torsten Duwe <duwe@lst.de>
> Cc: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Cc: Wei Liang Lim <weiliang.lim@starfivetech.com>
> Cc: Alex Bee <knaerzche@gmail.com>
> ---
>   drivers/timer/altera_timer.c       | 1 -
>   drivers/timer/andes_plmt_timer.c   | 1 -
>   drivers/timer/arc_timer.c          | 1 -
>   drivers/timer/arm_global_timer.c   | 2 +-
>   drivers/timer/arm_twd_timer.c      | 1 -
>   drivers/timer/ast_timer.c          | 1 -
>   drivers/timer/atmel_pit_timer.c    | 1 -
>   drivers/timer/atmel_tcb_timer.c    | 1 -
>   drivers/timer/cadence-ttc.c        | 1 -
>   drivers/timer/dw-apb-timer.c       | 1 -
>   drivers/timer/fttmr010_timer.c     | 1 -
>   drivers/timer/imx-gpt-timer.c      | 2 +-
>   drivers/timer/mchp-pit64b-timer.c  | 1 -
>   drivers/timer/mpc83xx_timer.c      | 2 +-
>   drivers/timer/mtk_timer.c          | 1 -
>   drivers/timer/nomadik-mtu-timer.c  | 1 -
>   drivers/timer/npcm-timer.c         | 1 -
>   drivers/timer/omap-timer.c         | 1 -
>   drivers/timer/orion-timer.c        | 2 +-
>   drivers/timer/ostm_timer.c         | 1 -
>   drivers/timer/riscv_aclint_timer.c | 2 +-
>   drivers/timer/riscv_timer.c        | 2 +-
>   drivers/timer/rockchip_timer.c     | 1 -
>   drivers/timer/sandbox_timer.c      | 1 -
>   drivers/timer/sp804_timer.c        | 1 -
>   drivers/timer/starfive-timer.c     | 1 -
>   drivers/timer/stm32_timer.c        | 2 +-
>   drivers/timer/tegra-timer.c        | 1 -
>   drivers/timer/timer-uclass.c       | 1 -
>   drivers/timer/tsc_timer.c          | 1 -
>   drivers/timer/xilinx-timer.c       | 1 -
>   31 files changed, 7 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/timer/altera_timer.c b/drivers/timer/altera_timer.c
> index 040dc65f48aa..ece246c23d2f 100644
> --- a/drivers/timer/altera_timer.c
> +++ b/drivers/timer/altera_timer.c
> @@ -7,7 +7,6 @@
>    * Scott McNutt <smcnutt@psyent.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <timer.h>
> diff --git a/drivers/timer/andes_plmt_timer.c b/drivers/timer/andes_plmt_timer.c
> index 42dd4b623176..20baaf61307a 100644
> --- a/drivers/timer/andes_plmt_timer.c
> +++ b/drivers/timer/andes_plmt_timer.c
> @@ -8,7 +8,6 @@
>    * associated with timer tick.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <timer.h>
>   #include <asm/io.h>
> diff --git a/drivers/timer/arc_timer.c b/drivers/timer/arc_timer.c
> index 497f8a04155f..413bcc32f01b 100644
> --- a/drivers/timer/arc_timer.c
> +++ b/drivers/timer/arc_timer.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Synopsys, Inc. All rights reserved.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <timer.h>
> diff --git a/drivers/timer/arm_global_timer.c b/drivers/timer/arm_global_timer.c
> index 2e50d9fbc580..b8057929f997 100644
> --- a/drivers/timer/arm_global_timer.c
> +++ b/drivers/timer/arm_global_timer.c
> @@ -6,7 +6,7 @@
>    * ARM Cortext A9 global timer driver
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <clk.h>
>   #include <timer.h>
> diff --git a/drivers/timer/arm_twd_timer.c b/drivers/timer/arm_twd_timer.c
> index 40ccd1658749..2b2f35911738 100644
> --- a/drivers/timer/arm_twd_timer.c
> +++ b/drivers/timer/arm_twd_timer.c
> @@ -27,7 +27,6 @@
>    * Alex Zuepke <azu@sysgo.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <timer.h>
> diff --git a/drivers/timer/ast_timer.c b/drivers/timer/ast_timer.c
> index 78adc96cc596..6601cab7b165 100644
> --- a/drivers/timer/ast_timer.c
> +++ b/drivers/timer/ast_timer.c
> @@ -3,7 +3,6 @@
>    * Copyright 2016 Google Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <timer.h>
> diff --git a/drivers/timer/atmel_pit_timer.c b/drivers/timer/atmel_pit_timer.c
> index 5cf46f224ab0..0a367a5a7f4a 100644
> --- a/drivers/timer/atmel_pit_timer.c
> +++ b/drivers/timer/atmel_pit_timer.c
> @@ -4,7 +4,6 @@
>    *		      Wenyou.Yang <wenyou.yang@microchip.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <timer.h>
> diff --git a/drivers/timer/atmel_tcb_timer.c b/drivers/timer/atmel_tcb_timer.c
> index 8c17987c7d74..3a328b2f6c72 100644
> --- a/drivers/timer/atmel_tcb_timer.c
> +++ b/drivers/timer/atmel_tcb_timer.c
> @@ -5,7 +5,6 @@
>    * Author: Clément Léger <clement.leger@bootlin.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <timer.h>
> diff --git a/drivers/timer/cadence-ttc.c b/drivers/timer/cadence-ttc.c
> index 2eff45060ad6..3cffb1bb88db 100644
> --- a/drivers/timer/cadence-ttc.c
> +++ b/drivers/timer/cadence-ttc.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2018 Xilinx, Inc. (Michal Simek)
>    */
>   
> -#include <common.h>
>   #include <bootstage.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/timer/dw-apb-timer.c b/drivers/timer/dw-apb-timer.c
> index 0607f751ca70..77ccb98cb8df 100644
> --- a/drivers/timer/dw-apb-timer.c
> +++ b/drivers/timer/dw-apb-timer.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2018 Marek Vasut <marex@denx.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk.h>
>   #include <dt-structs.h>
> diff --git a/drivers/timer/fttmr010_timer.c b/drivers/timer/fttmr010_timer.c
> index b6289e646109..c41bbfc1d576 100644
> --- a/drivers/timer/fttmr010_timer.c
> +++ b/drivers/timer/fttmr010_timer.c
> @@ -5,7 +5,6 @@
>    *
>    * 23/08/2022 Port to DM
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <timer.h>
> diff --git a/drivers/timer/imx-gpt-timer.c b/drivers/timer/imx-gpt-timer.c
> index 9c3b64ae5b1b..07b9fdb5e18c 100644
> --- a/drivers/timer/imx-gpt-timer.c
> +++ b/drivers/timer/imx-gpt-timer.c
> @@ -4,7 +4,7 @@
>    * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/timer/mchp-pit64b-timer.c b/drivers/timer/mchp-pit64b-timer.c
> index c9806d7eeebd..1a5b2e6a0dc8 100644
> --- a/drivers/timer/mchp-pit64b-timer.c
> +++ b/drivers/timer/mchp-pit64b-timer.c
> @@ -7,7 +7,6 @@
>    * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <timer.h>
> diff --git a/drivers/timer/mpc83xx_timer.c b/drivers/timer/mpc83xx_timer.c
> index 7814cb6a5d61..9da74479aaa6 100644
> --- a/drivers/timer/mpc83xx_timer.c
> +++ b/drivers/timer/mpc83xx_timer.c
> @@ -4,7 +4,7 @@
>    * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <irq_func.h>
> diff --git a/drivers/timer/mtk_timer.c b/drivers/timer/mtk_timer.c
> index 223e63f6c1a2..8216c2898373 100644
> --- a/drivers/timer/mtk_timer.c
> +++ b/drivers/timer/mtk_timer.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <timer.h>
>   #include <asm/io.h>
> diff --git a/drivers/timer/nomadik-mtu-timer.c b/drivers/timer/nomadik-mtu-timer.c
> index 4d24de14ae69..9a05582c0d52 100644
> --- a/drivers/timer/nomadik-mtu-timer.c
> +++ b/drivers/timer/nomadik-mtu-timer.c
> @@ -12,7 +12,6 @@
>    * Copyright (C) 2010 Linus Walleij for ST-Ericsson
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <timer.h>
>   #include <asm/io.h>
> diff --git a/drivers/timer/npcm-timer.c b/drivers/timer/npcm-timer.c
> index 4562a6f2311b..9463fd29ce81 100644
> --- a/drivers/timer/npcm-timer.c
> +++ b/drivers/timer/npcm-timer.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2022 Nuvoton Technology Corp.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <timer.h>
> diff --git a/drivers/timer/omap-timer.c b/drivers/timer/omap-timer.c
> index 9b6d97dae677..fda6356fdba8 100644
> --- a/drivers/timer/omap-timer.c
> +++ b/drivers/timer/omap-timer.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2015, Texas Instruments, Incorporated
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <timer.h>
> diff --git a/drivers/timer/orion-timer.c b/drivers/timer/orion-timer.c
> index 9cab27f2e48b..821b681a2326 100644
> --- a/drivers/timer/orion-timer.c
> +++ b/drivers/timer/orion-timer.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   #include <asm/io.h>
> -#include <common.h>
> +#include <config.h>
>   #include <div64.h>
>   #include <dm/device.h>
>   #include <dm/fdtaddr.h>
> diff --git a/drivers/timer/ostm_timer.c b/drivers/timer/ostm_timer.c
> index 3bf0d4647b58..314f956cdfb7 100644
> --- a/drivers/timer/ostm_timer.c
> +++ b/drivers/timer/ostm_timer.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <clock_legacy.h>
>   #include <malloc.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
> index 73fb87912851..35da1ea2fd2d 100644
> --- a/drivers/timer/riscv_aclint_timer.c
> +++ b/drivers/timer/riscv_aclint_timer.c
> @@ -4,7 +4,7 @@
>    * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <clk.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
> index 169c03dcb5c1..1f4980ceb38f 100644
> --- a/drivers/timer/riscv_timer.c
> +++ b/drivers/timer/riscv_timer.c
> @@ -10,7 +10,7 @@
>    * This driver provides generic timer support for S-mode U-Boot.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/timer/rockchip_timer.c b/drivers/timer/rockchip_timer.c
> index e66c49aa6bbd..96c010f4dcc8 100644
> --- a/drivers/timer/rockchip_timer.c
> +++ b/drivers/timer/rockchip_timer.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2017 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <common.h>
>   #include <bootstage.h>
>   #include <dm.h>
>   #include <init.h>
> diff --git a/drivers/timer/sandbox_timer.c b/drivers/timer/sandbox_timer.c
> index 1da7e0c3a768..e8b54a02965f 100644
> --- a/drivers/timer/sandbox_timer.c
> +++ b/drivers/timer/sandbox_timer.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2015 Thomas Chou <thomas@wytron.com.tw>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <timer.h>
> diff --git a/drivers/timer/sp804_timer.c b/drivers/timer/sp804_timer.c
> index 8fd4afb15a5b..a254e295cbfc 100644
> --- a/drivers/timer/sp804_timer.c
> +++ b/drivers/timer/sp804_timer.c
> @@ -4,7 +4,6 @@
>    * Copyright (C) 2022 Arm Ltd.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <init.h>
> diff --git a/drivers/timer/starfive-timer.c b/drivers/timer/starfive-timer.c
> index 6ac7d7f1d0ee..6b79c8858b55 100644
> --- a/drivers/timer/starfive-timer.c
> +++ b/drivers/timer/starfive-timer.c
> @@ -4,7 +4,6 @@
>    *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <time.h>
> diff --git a/drivers/timer/stm32_timer.c b/drivers/timer/stm32_timer.c
> index 1213a14ef197..1dc21c5c1bed 100644
> --- a/drivers/timer/stm32_timer.c
> +++ b/drivers/timer/stm32_timer.c
> @@ -6,7 +6,7 @@
>   
>   #define LOG_CATEGORY UCLASS_TIMER
>   
> -#include <common.h>
> +#include <config.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/timer/tegra-timer.c b/drivers/timer/tegra-timer.c
> index a867c649c3a8..3545424889d2 100644
> --- a/drivers/timer/tegra-timer.c
> +++ b/drivers/timer/tegra-timer.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022 Svyatoslav Ryhel <clamor95@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <timer.h>
> diff --git a/drivers/timer/timer-uclass.c b/drivers/timer/timer-uclass.c
> index 60ff65529ab3..8305f06d3187 100644
> --- a/drivers/timer/timer-uclass.c
> +++ b/drivers/timer/timer-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_TIMER
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <cpu.h>
>   #include <dm.h>
> diff --git a/drivers/timer/tsc_timer.c b/drivers/timer/tsc_timer.c
> index f86a0b86921c..80c084f380d9 100644
> --- a/drivers/timer/tsc_timer.c
> +++ b/drivers/timer/tsc_timer.c
> @@ -6,7 +6,6 @@
>    * arch/x86/kernel/tsc_msr.c and arch/x86/kernel/tsc.c
>    */
>   
> -#include <common.h>
>   #include <bootstage.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/timer/xilinx-timer.c b/drivers/timer/xilinx-timer.c
> index 172fd9f9296e..54148aa1689b 100644
> --- a/drivers/timer/xilinx-timer.c
> +++ b/drivers/timer/xilinx-timer.c
> @@ -7,7 +7,6 @@
>    * Michal SIMEK <monstr@monstr.eu>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <timer.h>
>   #include <regmap.h>
