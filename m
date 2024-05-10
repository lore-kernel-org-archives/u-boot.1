Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D31C10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 01:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A998812F;
	Fri, 10 May 2024 03:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hzU/W6CV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5B288845; Fri, 10 May 2024 02:42:25 +0200 (CEST)
Received: from mail-m6011.netease.com (mail-m6011.netease.com [210.79.60.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C538804F
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=hzU/W6CVfqAnWH3hDqjgh7m1Xd01voks//yLnsicwPTgilvJbkdVgpR4nu9H96tvADMpcZI8eFkO6bwt9I+wsBfcnnyx47lRKIX23Kjwp1XLIkikl61rM5zh/cYkaEPkZfbuhbm6m5PGK0PxRHd/xhB5+njsxWdQjf4KqQ3xusg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=4Z4agmN3NQpZEoohjbcmBT74uK12AsIIFJGgfdV1LP8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id F0480900180;
 Fri, 10 May 2024 08:40:55 +0800 (CST)
Message-ID: <e35eabc1-a043-478a-93eb-3d32c23a8206@rock-chips.com>
Date: Fri, 10 May 2024 08:40:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/81] misc: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Mario Six <mario.six@gdsys.cc>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Michael Walle
 <michael@walle.cc>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, =?UTF-8?B?TWljaGHFgiBCYXJuYcWb?=
 <barnas@google.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Milan_P=2E_Stani=C4=87?=
 <mps@arvanta.net>, Neha Malcom Francis <n-francis@ti.com>,
 Nishanth Menon <nm@ti.com>, Marek Vasut <marex@denx.de>,
 Michel Alex <Alex.Michel@wiedemann-group.com>, Stefano Babic
 <sbabic@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Clement Faure <clement.faure@nxp.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Ye Li <ye.li@nxp.com>, Jim Liu <jim.t90615@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tim Lunn
 <tim@feathertop.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-41-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-41-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IYTlYZTx9OH0pDHhgeT0lVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff22ee503a9kunmf0480900180
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6Lyo6DTNWPgIaTjU2IxgX
 IkxPCzxVSlVKTEpOSEtKTU5DQk5NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITk9IQjcG
X-Mailman-Approved-At: Fri, 10 May 2024 03:06:23 +0200
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


On 2024/5/2 09:30, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
> Cc: "Michał Barnaś" <barnas@google.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: "Milan P. Stanić" <mps@arvanta.net>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Michel Alex <Alex.Michel@wiedemann-group.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
> Cc: Clement Faure <clement.faure@nxp.com>
> Cc: Mathieu Othacehe <othacehe@gnu.org>
> Cc: Ye Li <ye.li@nxp.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tim Lunn <tim@feathertop.org>
> Cc: "Marek Behún" <kabel@kernel.org>
> Cc: Stefan Roese <sr@denx.de>
> ---
>   drivers/misc/altera_sysid.c      | 1 -
>   drivers/misc/atsha204a-i2c.c     | 1 -
>   drivers/misc/cbmem_console.c     | 2 +-
>   drivers/misc/cros_ec.c           | 2 +-
>   drivers/misc/cros_ec_i2c.c       | 1 -
>   drivers/misc/cros_ec_lpc.c       | 2 +-
>   drivers/misc/cros_ec_sandbox.c   | 2 +-
>   drivers/misc/cros_ec_spi.c       | 2 +-
>   drivers/misc/ds4510.c            | 1 -
>   drivers/misc/esm_pmic.c          | 1 -
>   drivers/misc/fs_loader.c         | 1 -
>   drivers/misc/fsl_devdis.c        | 2 +-
>   drivers/misc/fsl_ifc.c           | 2 +-
>   drivers/misc/fsl_iim.c           | 1 -
>   drivers/misc/fsl_portals.c       | 2 +-
>   drivers/misc/fsl_sec_mon.c       | 2 +-
>   drivers/misc/gdsys_ioep.c        | 1 -
>   drivers/misc/gdsys_rxaui_ctrl.c  | 1 -
>   drivers/misc/gdsys_soc.c         | 1 -
>   drivers/misc/gpio_led.c          | 1 -
>   drivers/misc/i2c_eeprom.c        | 1 -
>   drivers/misc/i2c_eeprom_emul.c   | 1 -
>   drivers/misc/ihs_fpga.c          | 1 -
>   drivers/misc/imx8/fuse.c         | 1 -
>   drivers/misc/imx8/scu.c          | 1 -
>   drivers/misc/imx8/scu_api.c      | 1 -
>   drivers/misc/imx_ele/ele_api.c   | 1 -
>   drivers/misc/imx_ele/ele_mu.c    | 1 -
>   drivers/misc/imx_ele/fuse.c      | 1 -
>   drivers/misc/irq-uclass.c        | 1 -
>   drivers/misc/irq_sandbox.c       | 1 -
>   drivers/misc/irq_sandbox_test.c  | 1 -
>   drivers/misc/jz4780_efuse.c      | 1 -
>   drivers/misc/k3_avs.c            | 1 -
>   drivers/misc/k3_esm.c            | 1 -
>   drivers/misc/ls2_sfp.c           | 1 -
>   drivers/misc/microchip_flexcom.c | 1 -
>   drivers/misc/misc-uclass.c       | 1 -
>   drivers/misc/misc_sandbox.c      | 1 -
>   drivers/misc/mpc83xx_serdes.c    | 1 -
>   drivers/misc/mxc_ocotp.c         | 1 -
>   drivers/misc/mxs_ocotp.c         | 1 -
>   drivers/misc/npcm_host_intf.c    | 1 -
>   drivers/misc/npcm_otp.c          | 1 -
>   drivers/misc/nuvoton_nct6102d.c  | 1 -
>   drivers/misc/nvmem.c             | 1 -
>   drivers/misc/p2sb-uclass.c       | 1 -
>   drivers/misc/p2sb_emul.c         | 1 -
>   drivers/misc/p2sb_sandbox.c      | 1 -
>   drivers/misc/pca9551_led.c       | 1 -
>   drivers/misc/pwrseq-uclass.c     | 1 -
>   drivers/misc/qfw.c               | 1 -
>   drivers/misc/rockchip-efuse.c    | 1 -
>   drivers/misc/rockchip-otp.c      | 1 -
>   drivers/misc/sandbox_adder.c     | 1 -
>   drivers/misc/sifive-otp.c        | 1 -
>   drivers/misc/sl28cpld.c          | 1 -
>   drivers/misc/smsc_lpc47m.c       | 1 -
>   drivers/misc/smsc_sio1007.c      | 1 -
>   drivers/misc/spltest_sandbox.c   | 1 -
>   drivers/misc/status_led.c        | 2 +-
>   drivers/misc/stm32_rcc.c         | 1 -
>   drivers/misc/stm32mp_fuse.c      | 1 -
>   drivers/misc/swap_case.c         | 1 -
>   drivers/misc/syscon_sandbox.c    | 1 -
>   drivers/misc/tegra186_bpmp.c     | 1 -
>   drivers/misc/tegra_car.c         | 1 -
>   drivers/misc/test_drv.c          | 1 -
>   drivers/misc/turris_omnia_mcu.c  | 1 -
>   drivers/misc/usb251xb.c          | 1 -
>   drivers/misc/vexpress_config.c   | 1 -
>   drivers/misc/winbond_w83627.c    | 1 -
>   72 files changed, 10 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/misc/altera_sysid.c b/drivers/misc/altera_sysid.c
> index 878df12771c8..21e64fa3e6fe 100644
> --- a/drivers/misc/altera_sysid.c
> +++ b/drivers/misc/altera_sysid.c
> @@ -4,7 +4,6 @@
>    * Scott McNutt <smcnutt@psyent.com>
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/misc/atsha204a-i2c.c b/drivers/misc/atsha204a-i2c.c
> index 707daa90bdba..3b9046da880c 100644
> --- a/drivers/misc/atsha204a-i2c.c
> +++ b/drivers/misc/atsha204a-i2c.c
> @@ -10,7 +10,6 @@
>    * published by the Free Software Foundation.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <errno.h>
> diff --git a/drivers/misc/cbmem_console.c b/drivers/misc/cbmem_console.c
> index ba3a599c4a51..8220addd579b 100644
> --- a/drivers/misc/cbmem_console.c
> +++ b/drivers/misc/cbmem_console.c
> @@ -3,8 +3,8 @@
>    * Copyright (C) 2011 The ChromiumOS Authors.  All rights reserved.
>    */
>   
> -#include <common.h>
>   #include <console.h>
> +#include <linux/string.h>
>   #include <asm/cb_sysinfo.h>
>   
>   void cbmemc_putc(struct stdio_dev *dev, char data)
> diff --git a/drivers/misc/cros_ec.c b/drivers/misc/cros_ec.c
> index 9c1e6a5e3e70..fabe4964a334 100644
> --- a/drivers/misc/cros_ec.c
> +++ b/drivers/misc/cros_ec.c
> @@ -15,7 +15,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CROS_EC
>   
> -#include <common.h>
>   #include <command.h>
>   #include <dm.h>
>   #include <i2c.h>
> @@ -24,6 +23,7 @@
>   #include <log.h>
>   #include <malloc.h>
>   #include <spi.h>
> +#include <time.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
>   #include <asm/io.h>
> diff --git a/drivers/misc/cros_ec_i2c.c b/drivers/misc/cros_ec_i2c.c
> index a1b78a3045dd..5516aa8b3ffd 100644
> --- a/drivers/misc/cros_ec_i2c.c
> +++ b/drivers/misc/cros_ec_i2c.c
> @@ -12,7 +12,6 @@
>    * KBC.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <cros_ec.h>
> diff --git a/drivers/misc/cros_ec_lpc.c b/drivers/misc/cros_ec_lpc.c
> index 1a8a81349c3a..e2a3226362a9 100644
> --- a/drivers/misc/cros_ec_lpc.c
> +++ b/drivers/misc/cros_ec_lpc.c
> @@ -12,11 +12,11 @@
>    * KBC.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <command.h>
>   #include <cros_ec.h>
>   #include <log.h>
> +#include <time.h>
>   #include <asm/io.h>
>   
>   #ifdef DEBUG_TRACE
> diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
> index 1201535f4af4..1cad51d474de 100644
> --- a/drivers/misc/cros_ec_sandbox.c
> +++ b/drivers/misc/cros_ec_sandbox.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_CROS_EC
>   
> -#include <common.h>
>   #include <cros_ec.h>
>   #include <dm.h>
>   #include <ec_commands.h>
> @@ -17,6 +16,7 @@
>   #include <os.h>
>   #include <u-boot/sha256.h>
>   #include <spi.h>
> +#include <time.h>
>   #include <asm/malloc.h>
>   #include <asm/state.h>
>   #include <asm/sdl.h>
> diff --git a/drivers/misc/cros_ec_spi.c b/drivers/misc/cros_ec_spi.c
> index 591ff30df89b..e86791c03a73 100644
> --- a/drivers/misc/cros_ec_spi.c
> +++ b/drivers/misc/cros_ec_spi.c
> @@ -12,12 +12,12 @@
>    * KBC.
>    */
>   
> -#include <common.h>
>   #include <cros_ec.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
>   #include <spi.h>
> +#include <time.h>
>   
>   int cros_ec_spi_packet(struct udevice *udev, int out_bytes, int in_bytes)
>   {
> diff --git a/drivers/misc/ds4510.c b/drivers/misc/ds4510.c
> index 9340596f2c63..302015e27938 100644
> --- a/drivers/misc/ds4510.c
> +++ b/drivers/misc/ds4510.c
> @@ -8,7 +8,6 @@
>    * and 4 programmable non-volatile GPIO pins.
>    */
>   
> -#include <common.h>
>   #include <i2c.h>
>   #include <command.h>
>   #include <linux/delay.h>
> diff --git a/drivers/misc/esm_pmic.c b/drivers/misc/esm_pmic.c
> index a518f750611a..1963c8664a54 100644
> --- a/drivers/misc/esm_pmic.c
> +++ b/drivers/misc/esm_pmic.c
> @@ -7,7 +7,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <power/pmic.h>
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 1ffc199ba1e4..66803f4b9975 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_FS_FIRMWARE_LOADER
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <errno.h>
> diff --git a/drivers/misc/fsl_devdis.c b/drivers/misc/fsl_devdis.c
> index 179053a298af..2c3d23480762 100644
> --- a/drivers/misc/fsl_devdis.c
> +++ b/drivers/misc/fsl_devdis.c
> @@ -3,7 +3,7 @@
>    * Copyright 2015 Freescale Semiconductor, Inc.
>    * Author: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <asm/io.h>
>   #include <asm/arch-ls102xa/immap_ls102xa.h>
>   #include <asm/arch-ls102xa/config.h>
> diff --git a/drivers/misc/fsl_ifc.c b/drivers/misc/fsl_ifc.c
> index f165b8c36ba4..93f41da0f974 100644
> --- a/drivers/misc/fsl_ifc.c
> +++ b/drivers/misc/fsl_ifc.c
> @@ -4,7 +4,7 @@
>    * Author: Dipen Dudhat <dipen.dudhat@freescale.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <fsl_ifc.h>
>   #include <part.h>
>   
> diff --git a/drivers/misc/fsl_iim.c b/drivers/misc/fsl_iim.c
> index 85cc3c26b2ef..65468a68dbdf 100644
> --- a/drivers/misc/fsl_iim.c
> +++ b/drivers/misc/fsl_iim.c
> @@ -8,7 +8,6 @@
>    * Martha Marx <mmarx@silicontkx.com>
>    */
>   
> -#include <common.h>
>   #include <fuse.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
> diff --git a/drivers/misc/fsl_portals.c b/drivers/misc/fsl_portals.c
> index 6b831281e96f..e7c0df78b6b6 100644
> --- a/drivers/misc/fsl_portals.c
> +++ b/drivers/misc/fsl_portals.c
> @@ -4,7 +4,7 @@
>    * Copyright 2017 NXP
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <log.h>
>   #include <linux/libfdt.h>
>   #include <fdt_support.h>
> diff --git a/drivers/misc/fsl_sec_mon.c b/drivers/misc/fsl_sec_mon.c
> index 3597ee22242c..7518089e1e3e 100644
> --- a/drivers/misc/fsl_sec_mon.c
> +++ b/drivers/misc/fsl_sec_mon.c
> @@ -3,7 +3,7 @@
>    * Copyright 2015 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <fsl_sec_mon.h>
>   #include <linux/delay.h>
>   
> diff --git a/drivers/misc/gdsys_ioep.c b/drivers/misc/gdsys_ioep.c
> index 145cfa23c6c5..d4916a277b84 100644
> --- a/drivers/misc/gdsys_ioep.c
> +++ b/drivers/misc/gdsys_ioep.c
> @@ -11,7 +11,6 @@
>    * SPDX-License-Identifier:	GPL-2.0+
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <misc.h>
> diff --git a/drivers/misc/gdsys_rxaui_ctrl.c b/drivers/misc/gdsys_rxaui_ctrl.c
> index 8f5cbe420f87..d4cd63ca9f89 100644
> --- a/drivers/misc/gdsys_rxaui_ctrl.c
> +++ b/drivers/misc/gdsys_rxaui_ctrl.c
> @@ -7,7 +7,6 @@
>    * Mario Six,  Guntermann & Drunck GmbH, mario.six@gdsys.cc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <regmap.h>
>   #include <misc.h>
> diff --git a/drivers/misc/gdsys_soc.c b/drivers/misc/gdsys_soc.c
> index 27e7dc483276..0adbb8df3c2c 100644
> --- a/drivers/misc/gdsys_soc.c
> +++ b/drivers/misc/gdsys_soc.c
> @@ -4,7 +4,6 @@
>    * Mario Six,  Guntermann & Drunck GmbH, mario.six@gdsys.cc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <dm/lists.h>
> diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
> index 30679f80cf15..e63689967a7a 100644
> --- a/drivers/misc/gpio_led.c
> +++ b/drivers/misc/gpio_led.c
> @@ -5,7 +5,6 @@
>    * Licensed under the GPL-2 or later.
>    */
>   
> -#include <common.h>
>   #include <status_led.h>
>   #include <asm/gpio.h>
>   
> diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
> index 9cb375a99ab8..10f0173d8050 100644
> --- a/drivers/misc/i2c_eeprom.c
> +++ b/drivers/misc/i2c_eeprom.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2C_EEPROM
>   
> -#include <common.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/kernel.h>
> diff --git a/drivers/misc/i2c_eeprom_emul.c b/drivers/misc/i2c_eeprom_emul.c
> index 6f32087ede56..3ad2e047ee3e 100644
> --- a/drivers/misc/i2c_eeprom_emul.c
> +++ b/drivers/misc/i2c_eeprom_emul.c
> @@ -5,7 +5,6 @@
>    * Copyright (c) 2014 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/misc/ihs_fpga.c b/drivers/misc/ihs_fpga.c
> index a0fece985d85..fe196b608198 100644
> --- a/drivers/misc/ihs_fpga.c
> +++ b/drivers/misc/ihs_fpga.c
> @@ -9,7 +9,6 @@
>    * Dirk Eibach,  Guntermann & Drunck GmbH, eibach@gdsys.de
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <regmap.h>
> diff --git a/drivers/misc/imx8/fuse.c b/drivers/misc/imx8/fuse.c
> index b81f73f283f4..90d251a44058 100644
> --- a/drivers/misc/imx8/fuse.c
> +++ b/drivers/misc/imx8/fuse.c
> @@ -3,7 +3,6 @@
>    * Copyright 2019 NXP
>    */
>   
> -#include <common.h>
>   #include <console.h>
>   #include <errno.h>
>   #include <fuse.h>
> diff --git a/drivers/misc/imx8/scu.c b/drivers/misc/imx8/scu.c
> index 798800aa7583..bbd7e24200bd 100644
> --- a/drivers/misc/imx8/scu.c
> +++ b/drivers/misc/imx8/scu.c
> @@ -5,7 +5,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
> index 6e2c678e614f..591d71b096a8 100644
> --- a/drivers/misc/imx8/scu_api.c
> +++ b/drivers/misc/imx8/scu_api.c
> @@ -5,7 +5,6 @@
>    * Peng Fan <peng.fan@nxp.com>
>    */
>   
> -#include <common.h>
>   #include <hang.h>
>   #include <malloc.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
> index e0ec22c7abf9..3745504637b3 100644
> --- a/drivers/misc/imx_ele/ele_api.c
> +++ b/drivers/misc/imx_ele/ele_api.c
> @@ -4,7 +4,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <hang.h>
>   #include <malloc.h>
>   #include <asm/io.h>
> diff --git a/drivers/misc/imx_ele/ele_mu.c b/drivers/misc/imx_ele/ele_mu.c
> index 053cdcf0fe07..0cf81f33ba5e 100644
> --- a/drivers/misc/imx_ele/ele_mu.c
> +++ b/drivers/misc/imx_ele/ele_mu.c
> @@ -3,7 +3,6 @@
>    * Copyright 2020-2022 NXP
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <dm/lists.h>
> diff --git a/drivers/misc/imx_ele/fuse.c b/drivers/misc/imx_ele/fuse.c
> index 4e4dcb42cdd9..d12539c8aac0 100644
> --- a/drivers/misc/imx_ele/fuse.c
> +++ b/drivers/misc/imx_ele/fuse.c
> @@ -3,7 +3,6 @@
>    * Copyright 2020 NXP
>    */
>   
> -#include <common.h>
>   #include <console.h>
>   #include <errno.h>
>   #include <fuse.h>
> diff --git a/drivers/misc/irq-uclass.c b/drivers/misc/irq-uclass.c
> index 7b79ed2df466..79eb7c200dc2 100644
> --- a/drivers/misc/irq-uclass.c
> +++ b/drivers/misc/irq-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_IRQ
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dt-structs.h>
>   #include <irq.h>
> diff --git a/drivers/misc/irq_sandbox.c b/drivers/misc/irq_sandbox.c
> index 8b5573fcaddd..5d176f63b5cf 100644
> --- a/drivers/misc/irq_sandbox.c
> +++ b/drivers/misc/irq_sandbox.c
> @@ -5,7 +5,6 @@
>    * Copyright 2019 Google LLC
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <irq.h>
>   #include <acpi/acpi_device.h>
> diff --git a/drivers/misc/irq_sandbox_test.c b/drivers/misc/irq_sandbox_test.c
> index 95c45c24edb8..3669b863bec1 100644
> --- a/drivers/misc/irq_sandbox_test.c
> +++ b/drivers/misc/irq_sandbox_test.c
> @@ -5,7 +5,6 @@
>    * Copyright 2021 Google LLC
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <irq.h>
>   #include <asm/irq.h>
> diff --git a/drivers/misc/jz4780_efuse.c b/drivers/misc/jz4780_efuse.c
> index 1fba3271db61..5c92de26ec5f 100644
> --- a/drivers/misc/jz4780_efuse.c
> +++ b/drivers/misc/jz4780_efuse.c
> @@ -6,7 +6,6 @@
>    * Author: Alex Smith <alex.smith@imgtec.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/unaligned.h>
>   #include <errno.h>
> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> index 0d29eff1ac08..87471cc3b16a 100644
> --- a/drivers/misc/k3_avs.c
> +++ b/drivers/misc/k3_avs.c
> @@ -7,7 +7,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <asm/io.h>
> diff --git a/drivers/misc/k3_esm.c b/drivers/misc/k3_esm.c
> index f6ac18bdc757..fa3d65656220 100644
> --- a/drivers/misc/k3_esm.c
> +++ b/drivers/misc/k3_esm.c
> @@ -7,7 +7,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <asm/io.h>
> diff --git a/drivers/misc/ls2_sfp.c b/drivers/misc/ls2_sfp.c
> index 5351c7ed34fd..8cb6e999bed1 100644
> --- a/drivers/misc/ls2_sfp.c
> +++ b/drivers/misc/ls2_sfp.c
> @@ -12,7 +12,6 @@
>    */
>   
>   #define LOG_CATEGORY UCLASS_MISC
> -#include <common.h>
>   #include <clk.h>
>   #include <fuse.h>
>   #include <misc.h>
> diff --git a/drivers/misc/microchip_flexcom.c b/drivers/misc/microchip_flexcom.c
> index e0a6f2d38801..c5ddecac7551 100644
> --- a/drivers/misc/microchip_flexcom.c
> +++ b/drivers/misc/microchip_flexcom.c
> @@ -4,7 +4,6 @@
>    * Author: Eugen Hristev <eugen.hristev@microchip.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/misc/misc-uclass.c b/drivers/misc/misc-uclass.c
> index cfe9d562fa0d..1389e146b612 100644
> --- a/drivers/misc/misc-uclass.c
> +++ b/drivers/misc/misc-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_MISC
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <misc.h>
> diff --git a/drivers/misc/misc_sandbox.c b/drivers/misc/misc_sandbox.c
> index 31cde2dbac07..2473419df2a3 100644
> --- a/drivers/misc/misc_sandbox.c
> +++ b/drivers/misc/misc_sandbox.c
> @@ -4,7 +4,6 @@
>    * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <misc.h>
>   
> diff --git a/drivers/misc/mpc83xx_serdes.c b/drivers/misc/mpc83xx_serdes.c
> index 93c87e998c4f..cf9aa9b35b33 100644
> --- a/drivers/misc/mpc83xx_serdes.c
> +++ b/drivers/misc/mpc83xx_serdes.c
> @@ -9,7 +9,6 @@
>    * Copyright (C) 2008 MontaVista Software, Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <mapmem.h>
> diff --git a/drivers/misc/mxc_ocotp.c b/drivers/misc/mxc_ocotp.c
> index 8ee18f29d9be..d1674caa138c 100644
> --- a/drivers/misc/mxc_ocotp.c
> +++ b/drivers/misc/mxc_ocotp.c
> @@ -11,7 +11,6 @@
>    * Copyright (C) 2011 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <fuse.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
> diff --git a/drivers/misc/mxs_ocotp.c b/drivers/misc/mxs_ocotp.c
> index facc720c8ef2..6432c62dac34 100644
> --- a/drivers/misc/mxs_ocotp.c
> +++ b/drivers/misc/mxs_ocotp.c
> @@ -11,7 +11,6 @@
>    *       etc.) which would make common driver an ifdef nightmare :-(
>    */
>   
> -#include <common.h>
>   #include <fuse.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
> diff --git a/drivers/misc/npcm_host_intf.c b/drivers/misc/npcm_host_intf.c
> index 79f57f57d89c..58bab888c3c8 100644
> --- a/drivers/misc/npcm_host_intf.c
> +++ b/drivers/misc/npcm_host_intf.c
> @@ -4,7 +4,6 @@
>    * Copyright (c) 2022 Nuvoton Technology Corp.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <regmap.h>
>   #include <syscon.h>
> diff --git a/drivers/misc/npcm_otp.c b/drivers/misc/npcm_otp.c
> index 08029724c040..adb6135291dc 100644
> --- a/drivers/misc/npcm_otp.c
> +++ b/drivers/misc/npcm_otp.c
> @@ -4,7 +4,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fuse.h>
> diff --git a/drivers/misc/nuvoton_nct6102d.c b/drivers/misc/nuvoton_nct6102d.c
> index daf5019d0170..a3ca037d25f7 100644
> --- a/drivers/misc/nuvoton_nct6102d.c
> +++ b/drivers/misc/nuvoton_nct6102d.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <nuvoton_nct6102d.h>
>   #include <asm/io.h>
>   #include <asm/pnp_def.h>
> diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
> index 5a2bd1f9f72c..d0cb0a35b816 100644
> --- a/drivers/misc/nvmem.c
> +++ b/drivers/misc/nvmem.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022 Sean Anderson <sean.anderson@seco.com>
>    */
>   
> -#include <common.h>
>   #include <i2c_eeprom.h>
>   #include <linker_lists.h>
>   #include <misc.h>
> diff --git a/drivers/misc/p2sb-uclass.c b/drivers/misc/p2sb-uclass.c
> index f24857a1515e..016c80733782 100644
> --- a/drivers/misc/p2sb-uclass.c
> +++ b/drivers/misc/p2sb-uclass.c
> @@ -8,7 +8,6 @@
>   
>   #define LOG_CATEGORY UCLASS_P2SB
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/misc/p2sb_emul.c b/drivers/misc/p2sb_emul.c
> index 51f87161d5b7..3dac6bd82e30 100644
> --- a/drivers/misc/p2sb_emul.c
> +++ b/drivers/misc/p2sb_emul.c
> @@ -8,7 +8,6 @@
>   
>   #define LOG_CATEGORY UCLASS_MISC
>   
> -#include <common.h>
>   #include <axi.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/misc/p2sb_sandbox.c b/drivers/misc/p2sb_sandbox.c
> index d80bca22a6b2..9f3cd14958b8 100644
> --- a/drivers/misc/p2sb_sandbox.c
> +++ b/drivers/misc/p2sb_sandbox.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_P2SB
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <p2sb.h>
> diff --git a/drivers/misc/pca9551_led.c b/drivers/misc/pca9551_led.c
> index cdc4390f8155..040d0d5cf48c 100644
> --- a/drivers/misc/pca9551_led.c
> +++ b/drivers/misc/pca9551_led.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2015 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <i2c.h>
>   #include <status_led.h>
> diff --git a/drivers/misc/pwrseq-uclass.c b/drivers/misc/pwrseq-uclass.c
> index a0f24e1bf3a9..bddc3c336857 100644
> --- a/drivers/misc/pwrseq-uclass.c
> +++ b/drivers/misc/pwrseq-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_PWRSEQ
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <pwrseq.h>
>   
> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
> index db98619fdf53..0e002ac25f48 100644
> --- a/drivers/misc/qfw.c
> +++ b/drivers/misc/qfw.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_QFW
>   
> -#include <common.h>
>   #include <acpi/acpi_table.h>
>   #include <bootdev.h>
>   #include <bootflow.h>
> diff --git a/drivers/misc/rockchip-efuse.c b/drivers/misc/rockchip-efuse.c
> index 2f96b79ea407..c7430147718a 100644
> --- a/drivers/misc/rockchip-efuse.c
> +++ b/drivers/misc/rockchip-efuse.c
> @@ -6,7 +6,6 @@
>    * Written by Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <command.h>
>   #include <display_options.h>
> diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
> index 4f757083a1b6..2123c31038fc 100644
> --- a/drivers/misc/rockchip-otp.c
> +++ b/drivers/misc/rockchip-otp.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <command.h>
>   #include <display_options.h>
> diff --git a/drivers/misc/sandbox_adder.c b/drivers/misc/sandbox_adder.c
> index 3ea33e46e9f2..de1c63575820 100644
> --- a/drivers/misc/sandbox_adder.c
> +++ b/drivers/misc/sandbox_adder.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_MISC
>   
> -#include <common.h>
>   #include <axi.h>
>   #include <dm.h>
>   #include <misc.h>
> diff --git a/drivers/misc/sifive-otp.c b/drivers/misc/sifive-otp.c
> index a624a358802c..7fbcd3799e52 100644
> --- a/drivers/misc/sifive-otp.c
> +++ b/drivers/misc/sifive-otp.c
> @@ -17,7 +17,6 @@
>    * Right now first 1KiB is used to store only serial number.
>    */
>   
> -#include <common.h>
>   #include <dm/device.h>
>   #include <dm/read.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/misc/sl28cpld.c b/drivers/misc/sl28cpld.c
> index 01ef1c6178fc..1c61b005af3a 100644
> --- a/drivers/misc/sl28cpld.c
> +++ b/drivers/misc/sl28cpld.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2021 Michael Walle <michael@walle.cc>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   
> diff --git a/drivers/misc/smsc_lpc47m.c b/drivers/misc/smsc_lpc47m.c
> index bda064f1365b..1b15907b0933 100644
> --- a/drivers/misc/smsc_lpc47m.c
> +++ b/drivers/misc/smsc_lpc47m.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/pnp_def.h>
>   
> diff --git a/drivers/misc/smsc_sio1007.c b/drivers/misc/smsc_sio1007.c
> index 3b7b1c8bcf2a..6d99aa61d91d 100644
> --- a/drivers/misc/smsc_sio1007.c
> +++ b/drivers/misc/smsc_sio1007.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <errno.h>
>   #include <smsc_sio1007.h>
> diff --git a/drivers/misc/spltest_sandbox.c b/drivers/misc/spltest_sandbox.c
> index 6b9701a06aee..3011a2292713 100644
> --- a/drivers/misc/spltest_sandbox.c
> +++ b/drivers/misc/spltest_sandbox.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dt-structs.h>
>   
> diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
> index a6e9c03a02ec..3b1baa4f840b 100644
> --- a/drivers/misc/status_led.c
> +++ b/drivers/misc/status_led.c
> @@ -4,8 +4,8 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
>   #include <status_led.h>
> +#include <linux/types.h>
>   
>   /*
>    * The purpose of this code is to signal the operational status of a
> diff --git a/drivers/misc/stm32_rcc.c b/drivers/misc/stm32_rcc.c
> index c1e5428a6b81..0dd827e1dd0e 100644
> --- a/drivers/misc/stm32_rcc.c
> +++ b/drivers/misc/stm32_rcc.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_NOP
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <misc.h>
> diff --git a/drivers/misc/stm32mp_fuse.c b/drivers/misc/stm32mp_fuse.c
> index 9fd6c367dc61..34be6c28c192 100644
> --- a/drivers/misc/stm32mp_fuse.c
> +++ b/drivers/misc/stm32mp_fuse.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <fuse.h>
>   #include <misc.h>
> diff --git a/drivers/misc/swap_case.c b/drivers/misc/swap_case.c
> index ee5c12bd0a42..d4a5620c62c1 100644
> --- a/drivers/misc/swap_case.c
> +++ b/drivers/misc/swap_case.c
> @@ -6,7 +6,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/misc/syscon_sandbox.c b/drivers/misc/syscon_sandbox.c
> index d5cef188d742..6adb4154c25b 100644
> --- a/drivers/misc/syscon_sandbox.c
> +++ b/drivers/misc/syscon_sandbox.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <syscon.h>
> diff --git a/drivers/misc/tegra186_bpmp.c b/drivers/misc/tegra186_bpmp.c
> index fecac9c4d902..a1585b818677 100644
> --- a/drivers/misc/tegra186_bpmp.c
> +++ b/drivers/misc/tegra186_bpmp.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/misc/tegra_car.c b/drivers/misc/tegra_car.c
> index 0ddbb3c619b2..497ec18564cc 100644
> --- a/drivers/misc/tegra_car.c
> +++ b/drivers/misc/tegra_car.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <dm/lists.h>
> diff --git a/drivers/misc/test_drv.c b/drivers/misc/test_drv.c
> index 927618256f0a..9b1e357a1397 100644
> --- a/drivers/misc/test_drv.c
> +++ b/drivers/misc/test_drv.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2014 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/test.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/misc/turris_omnia_mcu.c b/drivers/misc/turris_omnia_mcu.c
> index 6b2f17c0002d..be77acbd1652 100644
> --- a/drivers/misc/turris_omnia_mcu.c
> +++ b/drivers/misc/turris_omnia_mcu.c
> @@ -4,7 +4,6 @@
>    * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
>    */
>   
> -#include <common.h>
>   #include <console.h>
>   #include <dm.h>
>   #include <dm/lists.h>
> diff --git a/drivers/misc/usb251xb.c b/drivers/misc/usb251xb.c
> index 92e92ba5e624..daba2c2d6835 100644
> --- a/drivers/misc/usb251xb.c
> +++ b/drivers/misc/usb251xb.c
> @@ -10,7 +10,6 @@
>    * https://patchwork.kernel.org/patch/9257715/
>    */
>   
> -#include <common.h>
>   #include <asm/gpio.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/misc/vexpress_config.c b/drivers/misc/vexpress_config.c
> index 99aad1412ae7..e7655ceff74c 100644
> --- a/drivers/misc/vexpress_config.c
> +++ b/drivers/misc/vexpress_config.c
> @@ -4,7 +4,6 @@
>    * Author: Liviu Dudau <liviu.dudau@foss.arm.com>
>    *
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <malloc.h>
>   #include <dm/read.h>
> diff --git a/drivers/misc/winbond_w83627.c b/drivers/misc/winbond_w83627.c
> index 3838b3f74f40..87b9043e65c4 100644
> --- a/drivers/misc/winbond_w83627.c
> +++ b/drivers/misc/winbond_w83627.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/pnp_def.h>
>   
