Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52523C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 12:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9967188155;
	Thu,  9 May 2024 14:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="RNa7ON2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7053D88487; Thu,  9 May 2024 11:13:09 +0200 (CEST)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFD58848C
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 03B8E24010E
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1715245985; bh=OSk6uu6IJEJ3j4ObS/uAY1Nmo6LmtW3GNhgwCbMaVkE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=RNa7ON2E8VSi3SzJyQNkLn6my0cq51fpBxYlEPAeS9X3GDB8p5ouFmRUctsAJPVR7
 wTVp79L49/I0ViYQ+PoA46hyqa1vnkf1oluUJQIIK7MeWn876+pwRLEYmWJV9RVMKr
 RWC2vUR3ALcedHkLiR3TmcSK6Edg5xLCWueeT+yCMDkPSEIGiHnfOF6ttAunaP8GA+
 Q6O6yrDG96Gk6eJmE1OkRNDcuIO83kxJ074KMdR5i03CQbFcGqGgOSXul6m3kk7tNP
 bQhbsn+EmNCNWiFg7fF8XsY7gpEn+TLqDemUCjBqi+CHAzsxdo1lRxbvoMgaQK0NM7
 IUTHeQyQEig5Q==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VZmWb2GHDz6tmv;
 Thu,  9 May 2024 11:12:59 +0200 (CEST)
Message-ID: <583e1123-fa00-981e-ecff-86573ffbff53@posteo.net>
Date: Thu,  9 May 2024 09:12:30 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 60/81] serial: Remove <common.h> and add needed includes
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Anastasiia Lukianenko <vicooodin@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?Q?S=c3=a9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Ye Li <ye.li@nxp.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Weijie Gao <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Jim Liu <jim.t90615@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Yang Xiwen <forbidden405@outlook.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-60-trini@konsulko.com>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240502013138.2383421-60-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 May 2024 14:37:05 +0200
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



On 02.05.24 03:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks ok, tested on FriendlyElec-Board NanoPC-T2 
(s5p4418_nanopi2_defconfig).

Thanks a lot!

> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: This contributor prefers not to receive mails <noreply@example.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> Cc: Anastasiia Lukianenko <vicooodin@gmail.com>
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Maksim Kiselev <bigunclemax@gmail.com>
> Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: "Sébastien Szymanski" <sebastien.szymanski@armadeus.com>
> Cc: Ye Li <ye.li@nxp.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Sam Shih <sam.shih@mediatek.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/serial/altera_jtag_uart.c     | 1 -
>   drivers/serial/altera_uart.c          | 1 -
>   drivers/serial/arm_dcc.c              | 1 -
>   drivers/serial/atmel_usart.c          | 1 -
>   drivers/serial/ns16550.c              | 2 +-
>   drivers/serial/sandbox.c              | 1 -
>   drivers/serial/serial-uclass.c        | 2 +-
>   drivers/serial/serial.c               | 2 +-
>   drivers/serial/serial_ar933x.c        | 1 -
>   drivers/serial/serial_arc.c           | 1 -
>   drivers/serial/serial_bcm283x_mu.c    | 1 -
>   drivers/serial/serial_bcm283x_pl011.c | 1 -
>   drivers/serial/serial_coreboot.c      | 1 -
>   drivers/serial/serial_cortina.c       | 1 -
>   drivers/serial/serial_efi.c           | 1 -
>   drivers/serial/serial_htif.c          | 1 -
>   drivers/serial/serial_intel_mid.c     | 1 -
>   drivers/serial/serial_linflexuart.c   | 1 -
>   drivers/serial/serial_lpuart.c        | 1 -
>   drivers/serial/serial_mcf.c           | 1 -
>   drivers/serial/serial_meson.c         | 1 -
>   drivers/serial/serial_mpc8xx.c        | 1 -
>   drivers/serial/serial_msm.c           | 1 -
>   drivers/serial/serial_msm_geni.c      | 1 -
>   drivers/serial/serial_mtk.c           | 2 +-
>   drivers/serial/serial_mvebu_a3700.c   | 1 -
>   drivers/serial/serial_mxc.c           | 1 -
>   drivers/serial/serial_mxs.c           | 1 -
>   drivers/serial/serial_npcm.c          | 1 -
>   drivers/serial/serial_ns16550.c       | 2 +-
>   drivers/serial/serial_nulldev.c       | 1 -
>   drivers/serial/serial_omap.c          | 2 +-
>   drivers/serial/serial_owl.c           | 1 -
>   drivers/serial/serial_pic32.c         | 1 -
>   drivers/serial/serial_pl01x.c         | 1 -
>   drivers/serial/serial_rockchip.c      | 1 -
>   drivers/serial/serial_s5p4418_pl011.c | 1 -
>   drivers/serial/serial_semihosting.c   | 1 -
>   drivers/serial/serial_sifive.c        | 1 -
>   drivers/serial/serial_sti_asc.c       | 1 -
>   drivers/serial/serial_stm32.c         | 1 -
>   drivers/serial/serial_uniphier.c      | 1 -
>   drivers/serial/serial_xen.c           | 1 -
>   drivers/serial/serial_xuartlite.c     | 1 -
>   drivers/serial/serial_zynq.c          | 1 -
>   drivers/serial/usbtty.c               | 1 -
>   46 files changed, 6 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/serial/altera_jtag_uart.c b/drivers/serial/altera_jtag_uart.c
> index 9e39da7dd246..3f706e1839f2 100644
> --- a/drivers/serial/altera_jtag_uart.c
> +++ b/drivers/serial/altera_jtag_uart.c
> @@ -4,7 +4,6 @@
>    * Scott McNutt <smcnutt@psyent.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <serial.h>
> diff --git a/drivers/serial/altera_uart.c b/drivers/serial/altera_uart.c
> index 35920480841a..3c13ef25bb49 100644
> --- a/drivers/serial/altera_uart.c
> +++ b/drivers/serial/altera_uart.c
> @@ -4,7 +4,6 @@
>    * Scott McNutt <smcnutt@psyent.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <serial.h>
> diff --git a/drivers/serial/arm_dcc.c b/drivers/serial/arm_dcc.c
> index a402a123b6d6..66af136695d0 100644
> --- a/drivers/serial/arm_dcc.c
> +++ b/drivers/serial/arm_dcc.c
> @@ -15,7 +15,6 @@
>    * this file might be covered by the GNU General Public License.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <serial.h>
>   
> diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
> index 9827c006fa88..7e45a80969e8 100644
> --- a/drivers/serial/atmel_usart.c
> +++ b/drivers/serial/atmel_usart.c
> @@ -5,7 +5,6 @@
>    * Modified to support C structur SoC access by
>    * Andreas Bießmann <biessmann@corscience.de>
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> index 6deb1d8ddc56..4963385dc1c1 100644
> --- a/drivers/serial/ns16550.c
> +++ b/drivers/serial/ns16550.c
> @@ -5,7 +5,7 @@
>    */
>   
>   #include <clock_legacy.h>
> -#include <common.h>
> +#include <config.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
> index f6ac3d228526..ec0068e33d34 100644
> --- a/drivers/serial/sandbox.c
> +++ b/drivers/serial/sandbox.c
> @@ -9,7 +9,6 @@
>    * U-Boot.
>    */
>   
> -#include <common.h>
>   #include <console.h>
>   #include <dm.h>
>   #include <os.h>
> diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
> index e4fa3933bc8f..84f02f7ac76a 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -5,7 +5,7 @@
>   
>   #define LOG_CATEGORY UCLASS_SERIAL
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <env_internal.h>
>   #include <errno.h>
> diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
> index 787edd536027..dc4bb06fa992 100644
> --- a/drivers/serial/serial.c
> +++ b/drivers/serial/serial.c
> @@ -4,7 +4,7 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <env_internal.h>
>   #include <hang.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_ar933x.c b/drivers/serial/serial_ar933x.c
> index 4f9163497626..4d92752690fc 100644
> --- a/drivers/serial/serial_ar933x.c
> +++ b/drivers/serial/serial_ar933x.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
>    */
>   
> -#include <common.h>
>   #include <clock_legacy.h>
>   #include <dm.h>
>   #include <div64.h>
> diff --git a/drivers/serial/serial_arc.c b/drivers/serial/serial_arc.c
> index c2fc8a901e25..c0930cf7334a 100644
> --- a/drivers/serial/serial_arc.c
> +++ b/drivers/serial/serial_arc.c
> @@ -7,7 +7,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <serial.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/serial/serial_bcm283x_mu.c b/drivers/serial/serial_bcm283x_mu.c
> index 7585f790d22a..7fa26244b1ca 100644
> --- a/drivers/serial/serial_bcm283x_mu.c
> +++ b/drivers/serial/serial_bcm283x_mu.c
> @@ -14,7 +14,6 @@
>   
>   /* Simple U-Boot driver for the BCM283x mini UART */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <watchdog.h>
> diff --git a/drivers/serial/serial_bcm283x_pl011.c b/drivers/serial/serial_bcm283x_pl011.c
> index 09a9868a38f1..2abc1c4658f3 100644
> --- a/drivers/serial/serial_bcm283x_pl011.c
> +++ b/drivers/serial/serial_bcm283x_pl011.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2018 Alexander Graf <agraf@suse.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/gpio.h>
>   #include <dm/pinctrl.h>
> diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
> index 23066e4d0543..b1f69f6998cf 100644
> --- a/drivers/serial/serial_coreboot.c
> +++ b/drivers/serial/serial_coreboot.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATGEGORY	UCLASS_SERIAL
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <ns16550.h>
> diff --git a/drivers/serial/serial_cortina.c b/drivers/serial/serial_cortina.c
> index 6dc81a775d3f..3ae8fb465848 100644
> --- a/drivers/serial/serial_cortina.c
> +++ b/drivers/serial/serial_cortina.c
> @@ -5,7 +5,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <watchdog.h>
> diff --git a/drivers/serial/serial_efi.c b/drivers/serial/serial_efi.c
> index 0067576389d1..5733eaaf9d41 100644
> --- a/drivers/serial/serial_efi.c
> +++ b/drivers/serial/serial_efi.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <debug_uart.h>
>   #include <dm.h>
>   #include <efi.h>
> diff --git a/drivers/serial/serial_htif.c b/drivers/serial/serial_htif.c
> index 5d2bf0aaeba3..2a93bbbcc9f8 100644
> --- a/drivers/serial/serial_htif.c
> +++ b/drivers/serial/serial_htif.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022 Ventana Micro Systems Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/serial/serial_intel_mid.c b/drivers/serial/serial_intel_mid.c
> index bbf19057c4d1..4b528e452926 100644
> --- a/drivers/serial/serial_intel_mid.c
> +++ b/drivers/serial/serial_intel_mid.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2017 Intel Corporation
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <ns16550.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_linflexuart.c b/drivers/serial/serial_linflexuart.c
> index b449e55a6506..ff66e69b9d7b 100644
> --- a/drivers/serial/serial_linflexuart.c
> +++ b/drivers/serial/serial_linflexuart.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2013-2016 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <watchdog.h>
> diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
> index 3f2be72b8302..a06e6dc2505d 100644
> --- a/drivers/serial/serial_lpuart.c
> +++ b/drivers/serial/serial_lpuart.c
> @@ -4,7 +4,6 @@
>    * Copyright 2013 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <clock_legacy.h>
>   #include <clk.h>
>   #include <dm.h>
> diff --git a/drivers/serial/serial_mcf.c b/drivers/serial/serial_mcf.c
> index bb2afd0d8cd6..76143575fa98 100644
> --- a/drivers/serial/serial_mcf.c
> +++ b/drivers/serial/serial_mcf.c
> @@ -15,7 +15,6 @@
>    * as serial console interface.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/global_data.h>
>   #include <dm/platform_data/serial_coldfire.h>
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index be5f380f8500..bb79b9729579 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/serial/serial_mpc8xx.c b/drivers/serial/serial_mpc8xx.c
> index d82760c7f10a..9ce3fc3d9ec4 100644
> --- a/drivers/serial/serial_mpc8xx.c
> +++ b/drivers/serial/serial_mpc8xx.c
> @@ -4,7 +4,6 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <dm.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index a472e0b36833..757e5eaf974f 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -8,7 +8,6 @@
>    * Based on Linux driver.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 5260474fb9a4..cb6c09fdd09e 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -9,7 +9,6 @@
>   
>   #include <asm/io.h>
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <linux/delay.h>
> diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
> index f146f2b006e8..3f569c68f22a 100644
> --- a/drivers/serial/serial_mtk.c
> +++ b/drivers/serial/serial_mtk.c
> @@ -7,7 +7,7 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
> +#include <config.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/serial/serial_mvebu_a3700.c b/drivers/serial/serial_mvebu_a3700.c
> index b2017c645565..1a0b85e170ab 100644
> --- a/drivers/serial/serial_mvebu_a3700.c
> +++ b/drivers/serial/serial_mvebu_a3700.c
> @@ -4,7 +4,6 @@
>    * Copyright (C) 2021 Pali Rohár <pali@kernel.org>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_mxc.c b/drivers/serial/serial_mxc.c
> index cc85a502726e..c5fd740be4de 100644
> --- a/drivers/serial/serial_mxc.c
> +++ b/drivers/serial/serial_mxc.c
> @@ -3,7 +3,6 @@
>    * (c) 2007 Sascha Hauer <s.hauer@pengutronix.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <watchdog.h>
> diff --git a/drivers/serial/serial_mxs.c b/drivers/serial/serial_mxs.c
> index 3659948b8728..071bd09fef69 100644
> --- a/drivers/serial/serial_mxs.c
> +++ b/drivers/serial/serial_mxs.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright (C) 2023 Marek Vasut <marex@denx.de>
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <malloc.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_npcm.c b/drivers/serial/serial_npcm.c
> index 6bf3a943a2fc..661daf1aefa3 100644
> --- a/drivers/serial/serial_npcm.c
> +++ b/drivers/serial/serial_npcm.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2021 Nuvoton Technology Corp.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_ns16550.c b/drivers/serial/serial_ns16550.c
> index 4014f6820400..577864bc2195 100644
> --- a/drivers/serial/serial_ns16550.c
> +++ b/drivers/serial/serial_ns16550.c
> @@ -4,7 +4,7 @@
>    * Rob Taylor, Flying Pig Systems. robt@flyingpig.com.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <clock_legacy.h>
>   #include <ns16550.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_nulldev.c b/drivers/serial/serial_nulldev.c
> index f3ca7f525591..78a9e0b195fa 100644
> --- a/drivers/serial/serial_nulldev.c
> +++ b/drivers/serial/serial_nulldev.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2015 National Instruments
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <serial.h>
>   
> diff --git a/drivers/serial/serial_omap.c b/drivers/serial/serial_omap.c
> index 49ced8f9fae4..94672655c288 100644
> --- a/drivers/serial/serial_omap.c
> +++ b/drivers/serial/serial_omap.c
> @@ -6,7 +6,7 @@
>    *	Lokesh Vutla <lokeshvutla@ti.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <dt-structs.h>
>   #include <log.h>
> diff --git a/drivers/serial/serial_owl.c b/drivers/serial/serial_owl.c
> index 3b795785f780..8ce8aa32a21e 100644
> --- a/drivers/serial/serial_owl.c
> +++ b/drivers/serial/serial_owl.c
> @@ -6,7 +6,6 @@
>    * Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/serial/serial_pic32.c b/drivers/serial/serial_pic32.c
> index 0a03a9a25497..a49c4139b5ae 100644
> --- a/drivers/serial/serial_pic32.c
> +++ b/drivers/serial/serial_pic32.c
> @@ -3,7 +3,6 @@
>    * (c) 2015 Paul Thacker <paul.thacker@microchip.com>
>    *
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/serial/serial_pl01x.c b/drivers/serial/serial_pl01x.c
> index f04c21e08264..80c35963b8f2 100644
> --- a/drivers/serial/serial_pl01x.c
> +++ b/drivers/serial/serial_pl01x.c
> @@ -10,7 +10,6 @@
>   
>   /* Simple U-Boot driver for the PrimeCell PL010/PL011 UARTs */
>   
> -#include <common.h>
>   #include <asm/global_data.h>
>   /* For get_bus_freq() */
>   #include <clock_legacy.h>
> diff --git a/drivers/serial/serial_rockchip.c b/drivers/serial/serial_rockchip.c
> index f4e9422ed91c..8a15173f238f 100644
> --- a/drivers/serial/serial_rockchip.c
> +++ b/drivers/serial/serial_rockchip.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2015 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <debug_uart.h>
>   #include <dm.h>
>   #include <dt-structs.h>
> diff --git a/drivers/serial/serial_s5p4418_pl011.c b/drivers/serial/serial_s5p4418_pl011.c
> index e4492e662e92..1fb954e80c2a 100644
> --- a/drivers/serial/serial_s5p4418_pl011.c
> +++ b/drivers/serial/serial_s5p4418_pl011.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022  Stefan Bosch <stefan_b@posteo.net>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/arch/clk.h>
>   #include <asm/arch/reset.h>
> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
> index cfa1ec3148c5..56a5ec72428a 100644
> --- a/drivers/serial/serial_semihosting.c
> +++ b/drivers/serial/serial_semihosting.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022 Sean Anderson <sean.anderson@seco.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <malloc.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_sifive.c b/drivers/serial/serial_sifive.c
> index c449f3fd02d9..e47828e4d6ad 100644
> --- a/drivers/serial/serial_sifive.c
> +++ b/drivers/serial/serial_sifive.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2018 Anup Patel <anup@brainfault.org>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <debug_uart.h>
>   #include <dm.h>
> diff --git a/drivers/serial/serial_sti_asc.c b/drivers/serial/serial_sti_asc.c
> index 40381b57b08e..ef68e585dd62 100644
> --- a/drivers/serial/serial_sti_asc.c
> +++ b/drivers/serial/serial_sti_asc.c
> @@ -6,7 +6,6 @@
>    * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_stm32.c b/drivers/serial/serial_stm32.c
> index fb039546a41b..1ee58142b3f8 100644
> --- a/drivers/serial/serial_stm32.c
> +++ b/drivers/serial/serial_stm32.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SERIAL
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/serial/serial_uniphier.c b/drivers/serial/serial_uniphier.c
> index 27e4b92c3997..a566ba7a47d5 100644
> --- a/drivers/serial/serial_uniphier.c
> +++ b/drivers/serial/serial_uniphier.c
> @@ -5,7 +5,6 @@
>    *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/serial/serial_xen.c b/drivers/serial/serial_xen.c
> index ab318b06462b..e05805f63726 100644
> --- a/drivers/serial/serial_xen.c
> +++ b/drivers/serial/serial_xen.c
> @@ -3,7 +3,6 @@
>    * (C) 2018 NXP
>    * (C) 2020 EPAM Systems Inc.
>    */
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <serial.h>
> diff --git a/drivers/serial/serial_xuartlite.c b/drivers/serial/serial_xuartlite.c
> index 35df413321fe..eb234108746d 100644
> --- a/drivers/serial/serial_xuartlite.c
> +++ b/drivers/serial/serial_xuartlite.c
> @@ -8,7 +8,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/serial/serial_zynq.c b/drivers/serial/serial_zynq.c
> index 1847d1f6ecd2..55f13c00ddf6 100644
> --- a/drivers/serial/serial_zynq.c
> +++ b/drivers/serial/serial_zynq.c
> @@ -5,7 +5,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <debug_uart.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/serial/usbtty.c b/drivers/serial/usbtty.c
> index ecb6ba853df7..ae3ac8070d34 100644
> --- a/drivers/serial/usbtty.c
> +++ b/drivers/serial/usbtty.c
> @@ -7,7 +7,6 @@
>    * Bryan O'Donoghue, bodonoghue@codehermit.ie
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <circbuf.h>
>   #include <env.h>
