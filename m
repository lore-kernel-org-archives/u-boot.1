Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E0DC10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0225083333;
	Fri, 10 May 2024 02:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RToyCSoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A5680E9A; Fri, 10 May 2024 02:45:16 +0200 (CEST)
Received: from mail-m25482.xmail.ntesmail.com (mail-m25482.xmail.ntesmail.com
 [103.129.254.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DD288867
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=RToyCSoFiUDwnQIcZagY9DaubFDjGWFaZ9CXL6bj3+lvQ3s1/rp0d/uGxUrVuuzHVf4x8VKjWNjVyGjn2l+4EBYpFQyRlGBGgUJFthz3i458V1EAIdGcV5c3D9FLG0fQvFl8FgRZAcZi8TOD2/0/GILlUsZF3Jn1v5SoxCC1+Cs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=48v5UC26RNu4CSv+rF8Ak7qdAyhAkBROP1VsYn2iAig=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 31F2A9001C2;
 Fri, 10 May 2024 08:45:08 +0800 (CST)
Message-ID: <27c6ef7e-8c74-4279-8a02-41e8f731e1d5@rock-chips.com>
Date: Fri, 10 May 2024 08:45:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 74/81] video: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-74-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-74-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNDSlZOH0wfSU5DTEhPSh1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff5ff4c03a9kunm31f2a9001c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Cjo5HzMMKgIwNyM6SVEP
 MTJPFA1VSlVKTEpOSEtKQktCS0lLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSU5MSzcG
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
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> ---
>   drivers/video/anx9804.c                         | 1 -
>   drivers/video/atmel_hlcdfb.c                    | 1 -
>   drivers/video/atmel_lcdfb.c                     | 1 -
>   drivers/video/backlight-uclass.c                | 1 -
>   drivers/video/backlight_gpio.c                  | 1 -
>   drivers/video/bcm2835.c                         | 1 -
>   drivers/video/bmp.c                             | 1 -
>   drivers/video/bochs.c                           | 1 -
>   drivers/video/bridge/anx6345.c                  | 1 -
>   drivers/video/bridge/ps862x.c                   | 1 -
>   drivers/video/bridge/ptn3460.c                  | 1 -
>   drivers/video/bridge/ssd2825.c                  | 1 -
>   drivers/video/bridge/video-bridge-uclass.c      | 1 -
>   drivers/video/broadwell_igd.c                   | 2 +-
>   drivers/video/console_normal.c                  | 1 -
>   drivers/video/console_rotate.c                  | 1 -
>   drivers/video/console_truetype.c                | 1 -
>   drivers/video/coreboot.c                        | 1 -
>   drivers/video/display-uclass.c                  | 1 -
>   drivers/video/dsi-host-uclass.c                 | 1 -
>   drivers/video/dw_hdmi.c                         | 3 ++-
>   drivers/video/dw_mipi_dsi.c                     | 1 -
>   drivers/video/efi.c                             | 1 -
>   drivers/video/endeavoru-panel.c                 | 1 -
>   drivers/video/exynos/exynos_dp.c                | 1 -
>   drivers/video/exynos/exynos_dp_lowlevel.c       | 1 -
>   drivers/video/exynos/exynos_fb.c                | 1 -
>   drivers/video/exynos/exynos_mipi_dsi.c          | 1 -
>   drivers/video/exynos/exynos_mipi_dsi_common.c   | 1 -
>   drivers/video/exynos/exynos_mipi_dsi_lowlevel.c | 1 -
>   drivers/video/himax-hx8394.c                    | 1 -
>   drivers/video/hitachi_tx18d42vm_lcd.c           | 1 -
>   drivers/video/hx8238d.c                         | 1 -
>   drivers/video/ihs_video_out.c                   | 1 -
>   drivers/video/imx/ipu_common.c                  | 2 +-
>   drivers/video/imx/ipu_disp.c                    | 1 -
>   drivers/video/imx/mxc_ipuv3_fb.c                | 1 -
>   drivers/video/ivybridge_igd.c                   | 1 -
>   drivers/video/lm3533_backlight.c                | 1 -
>   drivers/video/logicore_dp_tx.c                  | 1 -
>   drivers/video/mali_dp.c                         | 1 -
>   drivers/video/mcde_simple.c                     | 1 -
>   drivers/video/meson/meson_canvas.c              | 1 -
>   drivers/video/meson/meson_dw_hdmi.c             | 1 -
>   drivers/video/meson/meson_plane.c               | 1 -
>   drivers/video/meson/meson_vclk.c                | 1 -
>   drivers/video/meson/meson_venc.c                | 1 -
>   drivers/video/meson/meson_vpu.c                 | 1 -
>   drivers/video/meson/meson_vpu_init.c            | 1 -
>   drivers/video/mipi_dsi.c                        | 1 -
>   drivers/video/mvebu_lcd.c                       | 1 -
>   drivers/video/mxsfb.c                           | 1 -
>   drivers/video/nexell/s5pxx18_dp.c               | 1 -
>   drivers/video/nexell/s5pxx18_dp_hdmi.c          | 1 -
>   drivers/video/nexell/s5pxx18_dp_lvds.c          | 2 +-
>   drivers/video/nexell/s5pxx18_dp_mipi.c          | 1 -
>   drivers/video/nexell/s5pxx18_dp_rgb.c           | 2 +-
>   drivers/video/nexell/soc/s5pxx18_soc_disptop.h  | 1 +
>   drivers/video/nexell_display.c                  | 1 -
>   drivers/video/omap3_dss.c                       | 1 -
>   drivers/video/orisetech_otm8009a.c              | 1 -
>   drivers/video/panel-uclass.c                    | 1 -
>   drivers/video/pwm_backlight.c                   | 1 -
>   drivers/video/raydium-rm68200.c                 | 1 -
>   drivers/video/renesas-r61307.c                  | 1 -
>   drivers/video/renesas-r69328.c                  | 1 -
>   drivers/video/rockchip/dw_mipi_dsi_rockchip.c   | 1 -
>   drivers/video/rockchip/rk3288_hdmi.c            | 1 -
>   drivers/video/rockchip/rk3288_mipi.c            | 1 -
>   drivers/video/rockchip/rk3288_vop.c             | 1 -
>   drivers/video/rockchip/rk3399_hdmi.c            | 1 -
>   drivers/video/rockchip/rk3399_mipi.c            | 1 -
>   drivers/video/rockchip/rk3399_vop.c             | 1 -
>   drivers/video/rockchip/rk_edp.c                 | 1 -
>   drivers/video/rockchip/rk_hdmi.c                | 1 -
>   drivers/video/rockchip/rk_lvds.c                | 1 -
>   drivers/video/rockchip/rk_mipi.c                | 1 -
>   drivers/video/rockchip/rk_vop.c                 | 1 -
>   drivers/video/sandbox_dsi_host.c                | 1 -
>   drivers/video/sandbox_osd.c                     | 1 -
>   drivers/video/sandbox_sdl.c                     | 1 -
>   drivers/video/seps525.c                         | 1 -
>   drivers/video/simple_panel.c                    | 1 -
>   drivers/video/simplefb.c                        | 1 -
>   drivers/video/ssd2828.c                         | 1 -
>   drivers/video/stm32/stm32_dsi.c                 | 1 -
>   drivers/video/stm32/stm32_ltdc.c                | 1 -
>   drivers/video/sunxi/lcdc.c                      | 1 -
>   drivers/video/sunxi/sunxi_de2.c                 | 1 -
>   drivers/video/sunxi/sunxi_display.c             | 2 +-
>   drivers/video/sunxi/sunxi_dw_hdmi.c             | 1 -
>   drivers/video/sunxi/sunxi_lcd.c                 | 1 -
>   drivers/video/sunxi/tve_common.c                | 1 -
>   drivers/video/tda19988.c                        | 1 -
>   drivers/video/tdo-tl070wsh30.c                  | 1 -
>   drivers/video/tegra124/display.c                | 2 +-
>   drivers/video/tegra124/dp.c                     | 2 +-
>   drivers/video/tegra124/sor.c                    | 1 -
>   drivers/video/tegra20/mipi-phy.c                | 1 -
>   drivers/video/tegra20/tegra-dsi.c               | 1 -
>   drivers/video/tegra20/tegra-pwm-backlight.c     | 1 -
>   drivers/video/ti/tilcdc-panel.c                 | 1 -
>   drivers/video/ti/tilcdc.c                       | 1 -
>   drivers/video/tidss/tidss_drv.c                 | 1 -
>   drivers/video/vesa.c                            | 1 -
>   drivers/video/vidconsole-uclass.c               | 1 -
>   drivers/video/video-uclass.c                    | 1 -
>   drivers/video/video_bmp.c                       | 1 -
>   drivers/video/video_osd-uclass.c                | 1 -
>   drivers/video/videomodes.c                      | 1 -
>   drivers/video/zynqmp/zynqmp_dpsub.c             | 1 -
>   111 files changed, 10 insertions(+), 110 deletions(-)
>
> diff --git a/drivers/video/anx9804.c b/drivers/video/anx9804.c
> index 52b5988ba5f2..a149e6f5b95d 100644
> --- a/drivers/video/anx9804.c
> +++ b/drivers/video/anx9804.c
> @@ -9,7 +9,6 @@
>    * interface for driving eDP TFT displays.
>    */
>   
> -#include <common.h>
>   #include <i2c.h>
>   #include <linux/delay.h>
>   #include "anx98xx-edp.h"
> diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.c
> index 652ba1418018..89bc0eeb680a 100644
> --- a/drivers/video/atmel_hlcdfb.c
> +++ b/drivers/video/atmel_hlcdfb.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2012 Atmel Corporation
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 5a7a54ada70e..281c3a1d6632 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2007 Atmel Corporation
>    */
>   
> -#include <common.h>
>   #include <atmel_lcd.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/video/backlight-uclass.c b/drivers/video/backlight-uclass.c
> index c14996d003c0..2a09b2da9106 100644
> --- a/drivers/video/backlight-uclass.c
> +++ b/drivers/video/backlight-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <backlight.h>
>   
> diff --git a/drivers/video/backlight_gpio.c b/drivers/video/backlight_gpio.c
> index eea824ab5e16..b26fa9a8acf1 100644
> --- a/drivers/video/backlight_gpio.c
> +++ b/drivers/video/backlight_gpio.c
> @@ -4,7 +4,6 @@
>    * Author: Patrick Delaunay <patrick.delaunay@foss.st.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <backlight.h>
>   #include <log.h>
> diff --git a/drivers/video/bcm2835.c b/drivers/video/bcm2835.c
> index 63efa762db16..0c81e6066229 100644
> --- a/drivers/video/bcm2835.c
> +++ b/drivers/video/bcm2835.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2012 Stephen Warren
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <video.h>
> diff --git a/drivers/video/bmp.c b/drivers/video/bmp.c
> index bab6fa7265af..291ed36440c8 100644
> --- a/drivers/video/bmp.c
> +++ b/drivers/video/bmp.c
> @@ -8,7 +8,6 @@
>    * BMP handling routines
>    */
>   
> -#include <common.h>
>   #include <bmp_layout.h>
>   #include <command.h>
>   #include <dm.h>
> diff --git a/drivers/video/bochs.c b/drivers/video/bochs.c
> index 022ea38d4cfe..00e673a4db08 100644
> --- a/drivers/video/bochs.c
> +++ b/drivers/video/bochs.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY	UCLASS_VIDEO
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <pci.h>
> diff --git a/drivers/video/bridge/anx6345.c b/drivers/video/bridge/anx6345.c
> index 93fa25f16e31..8cee4c958bd8 100644
> --- a/drivers/video/bridge/anx6345.c
> +++ b/drivers/video/bridge/anx6345.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2017 Vasily Khoruzhick <anarsoul@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/video/bridge/ps862x.c b/drivers/video/bridge/ps862x.c
> index d1d22a6e235c..efd03752281c 100644
> --- a/drivers/video/bridge/ps862x.c
> +++ b/drivers/video/bridge/ps862x.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/video/bridge/ptn3460.c b/drivers/video/bridge/ptn3460.c
> index 4760f04108f7..5851e1ef15e9 100644
> --- a/drivers/video/bridge/ptn3460.c
> +++ b/drivers/video/bridge/ptn3460.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <video_bridge.h>
> diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
> index f0ef3dafb93b..f978021c860e 100644
> --- a/drivers/video/bridge/ssd2825.c
> +++ b/drivers/video/bridge/ssd2825.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2022 Svyatoslav Ryhel <clamor95@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video/bridge/video-bridge-uclass.c
> index f389bc6b1475..2084a2e03ee8 100644
> --- a/drivers/video/bridge/video-bridge-uclass.c
> +++ b/drivers/video/bridge/video-bridge-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_VIDEO_BRIDGE
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <edid.h>
> diff --git a/drivers/video/broadwell_igd.c b/drivers/video/broadwell_igd.c
> index 83b6c908a8db..a26154ab588f 100644
> --- a/drivers/video/broadwell_igd.c
> +++ b/drivers/video/broadwell_igd.c
> @@ -5,12 +5,12 @@
>    * Copyright (C) 2016 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <bios_emul.h>
>   #include <bootstage.h>
>   #include <dm.h>
>   #include <init.h>
>   #include <log.h>
> +#include <time.h>
>   #include <vesa.h>
>   #include <video.h>
>   #include <asm/cpu.h>
> diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
> index 34ef5a522942..6f4194a18147 100644
> --- a/drivers/video/console_normal.c
> +++ b/drivers/video/console_normal.c
> @@ -6,7 +6,6 @@
>    * (C) Copyright 2023 Dzmitry Sankouski <dsankouski@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <charset.h>
>   #include <dm.h>
>   #include <video.h>
> diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
> index e4303dfb364c..dc9698362741 100644
> --- a/drivers/video/console_rotate.c
> +++ b/drivers/video/console_rotate.c
> @@ -6,7 +6,6 @@
>    * (C) Copyright 2023 Dzmitry Sankouski <dsankouski@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <charset.h>
>   #include <dm.h>
>   #include <video.h>
> diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
> index 28665a327575..c435162d3f94 100644
> --- a/drivers/video/console_truetype.c
> +++ b/drivers/video/console_truetype.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <abuf.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/video/coreboot.c b/drivers/video/coreboot.c
> index 5b718ae3e5a5..9aede2626423 100644
> --- a/drivers/video/coreboot.c
> +++ b/drivers/video/coreboot.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <init.h>
>   #include <vesa.h>
> diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclass.c
> index 2da3d1d14e95..61a73e1bc2a6 100644
> --- a/drivers/video/display-uclass.c
> +++ b/drivers/video/display-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_DISPLAY
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <display.h>
>   #include <edid.h>
> diff --git a/drivers/video/dsi-host-uclass.c b/drivers/video/dsi-host-uclass.c
> index 6e5256eb1265..fde275ad7e2e 100644
> --- a/drivers/video/dsi-host-uclass.c
> +++ b/drivers/video/dsi-host-uclass.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_DSI_HOST
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dsi_host.h>
>   
> diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> index c217af97878e..35559cef2298 100644
> --- a/drivers/video/dw_hdmi.c
> +++ b/drivers/video/dw_hdmi.c
> @@ -5,13 +5,14 @@
>    * Copyright 2017 Jernej Skrabec <jernej.skrabec@siol.net>
>    */
>   
> -#include <common.h>
>   #include <fdtdec.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <i2c.h>
>   #include <media_bus_format.h>
> +#include <time.h>
>   #include <linux/delay.h>
> +#include <linux/errno.h>
>   #include "dw_hdmi.h"
>   
>   struct tmds_n_cts {
> diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
> index a7e0784596a9..c74fe678d12a 100644
> --- a/drivers/video/dw_mipi_dsi.c
> +++ b/drivers/video/dw_mipi_dsi.c
> @@ -9,7 +9,6 @@
>    * the Linux Kernel driver drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dsi_host.h>
>   #include <dm.h>
> diff --git a/drivers/video/efi.c b/drivers/video/efi.c
> index 28ac15ff61b9..78d123fad4be 100644
> --- a/drivers/video/efi.c
> +++ b/drivers/video/efi.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY LOGC_EFI
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <efi_api.h>
>   #include <log.h>
> diff --git a/drivers/video/endeavoru-panel.c b/drivers/video/endeavoru-panel.c
> index 1bff641434e1..d4ba4d8b6da6 100644
> --- a/drivers/video/endeavoru-panel.c
> +++ b/drivers/video/endeavoru-panel.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2022 Svyatoslav Ryhel <clamor95@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <panel.h>
> diff --git a/drivers/video/exynos/exynos_dp.c b/drivers/video/exynos/exynos_dp.c
> index 59838da6c926..b0afb2338fb7 100644
> --- a/drivers/video/exynos/exynos_dp.c
> +++ b/drivers/video/exynos/exynos_dp.c
> @@ -5,7 +5,6 @@
>    * Author: Donghwa Lee <dh09.lee@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <display.h>
>   #include <fdtdec.h>
> diff --git a/drivers/video/exynos/exynos_dp_lowlevel.c b/drivers/video/exynos/exynos_dp_lowlevel.c
> index ae500a702804..f007b319b20e 100644
> --- a/drivers/video/exynos/exynos_dp_lowlevel.c
> +++ b/drivers/video/exynos/exynos_dp_lowlevel.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <log.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
> diff --git a/drivers/video/exynos/exynos_fb.c b/drivers/video/exynos/exynos_fb.c
> index 86970a6d5d20..0407a3f51b0d 100644
> --- a/drivers/video/exynos/exynos_fb.c
> +++ b/drivers/video/exynos/exynos_fb.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <display.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index 804fcd0b2484..edeb0a87bbb7 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -6,7 +6,6 @@
>    * Author: Donghwa Lee <dh09.lee@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <fdtdec.h>
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
> index be67cebae7f2..fc2767adc38c 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
> @@ -6,7 +6,6 @@
>    * Author: Donghwa Lee <dh09.lee@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> index 8111acd9a0b5..9f18b5da1026 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> @@ -6,7 +6,6 @@
>    * Author: Donghwa Lee <dh09.lee@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/dsim.h>
>   #include <asm/arch/mipi_dsim.h>
>   #include <asm/arch/power.h>
> diff --git a/drivers/video/himax-hx8394.c b/drivers/video/himax-hx8394.c
> index 63637b4db022..cb7f93e9c997 100644
> --- a/drivers/video/himax-hx8394.c
> +++ b/drivers/video/himax-hx8394.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright (C) 2022 Ondrej Jirman <megi@xff.cz>
>    */
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <mipi_dsi.h>
> diff --git a/drivers/video/hitachi_tx18d42vm_lcd.c b/drivers/video/hitachi_tx18d42vm_lcd.c
> index 95984fe3d3d1..68f7b75eef99 100644
> --- a/drivers/video/hitachi_tx18d42vm_lcd.c
> +++ b/drivers/video/hitachi_tx18d42vm_lcd.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2015 Hans de Goede <hdegoede@redhat.com>
>    */
>   
> -#include <common.h>
>   #include <malloc.h>
>   #include <linux/delay.h>
>   
> diff --git a/drivers/video/hx8238d.c b/drivers/video/hx8238d.c
> index 6ee97cb4ff3a..2491a32810e2 100644
> --- a/drivers/video/hx8238d.c
> +++ b/drivers/video/hx8238d.c
> @@ -12,7 +12,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <panel.h>
>   #include <spi.h>
> diff --git a/drivers/video/ihs_video_out.c b/drivers/video/ihs_video_out.c
> index 73b8f4bd1c9b..bf4d4995c36c 100644
> --- a/drivers/video/ihs_video_out.c
> +++ b/drivers/video/ihs_video_out.c
> @@ -9,7 +9,6 @@
>    * Dirk Eibach, Guntermann & Drunck GmbH, dirk.eibach@gdsys.de
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
> index b0a99c9cd5d9..d582fb8ad9d9 100644
> --- a/drivers/video/imx/ipu_common.c
> +++ b/drivers/video/imx/ipu_common.c
> @@ -11,7 +11,7 @@
>    */
>   
>   /* #define DEBUG */
> -#include <common.h>
> +#include <config.h>
>   #include <log.h>
>   #include <linux/delay.h>
>   #include <linux/types.h>
> diff --git a/drivers/video/imx/ipu_disp.c b/drivers/video/imx/ipu_disp.c
> index 144322e4e26b..aaba7d135a46 100644
> --- a/drivers/video/imx/ipu_disp.c
> +++ b/drivers/video/imx/ipu_disp.c
> @@ -12,7 +12,6 @@
>   
>   /* #define DEBUG */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <linux/delay.h>
>   #include <linux/types.h>
> diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
> index 7e60385bcfa5..039b22086a93 100644
> --- a/drivers/video/imx/mxc_ipuv3_fb.c
> +++ b/drivers/video/imx/mxc_ipuv3_fb.c
> @@ -10,7 +10,6 @@
>    * (C) Copyright 2004-2010 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <part.h>
>   #include <asm/cache.h>
> diff --git a/drivers/video/ivybridge_igd.c b/drivers/video/ivybridge_igd.c
> index c2cc976618a1..ad688640733e 100644
> --- a/drivers/video/ivybridge_igd.c
> +++ b/drivers/video/ivybridge_igd.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <bios_emul.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/video/lm3533_backlight.c b/drivers/video/lm3533_backlight.c
> index 00297a09b7fc..6b51fa0628e4 100644
> --- a/drivers/video/lm3533_backlight.c
> +++ b/drivers/video/lm3533_backlight.c
> @@ -6,7 +6,6 @@
>   #define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
>   
>   #include <backlight.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/video/logicore_dp_tx.c b/drivers/video/logicore_dp_tx.c
> index 624084d38bca..643a77a0f4e1 100644
> --- a/drivers/video/logicore_dp_tx.c
> +++ b/drivers/video/logicore_dp_tx.c
> @@ -9,7 +9,6 @@
>    * Dirk Eibach,  Guntermann & Drunck GmbH, dirk.eibach@gdsys.cc
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/mali_dp.c b/drivers/video/mali_dp.c
> index dbb2f5386171..c89212674624 100644
> --- a/drivers/video/mali_dp.c
> +++ b/drivers/video/mali_dp.c
> @@ -5,7 +5,6 @@
>    *
>    */
>   #define DEBUG
> -#include <common.h>
>   #include <malloc.h>
>   #include <video.h>
>   #include <dm.h>
> diff --git a/drivers/video/mcde_simple.c b/drivers/video/mcde_simple.c
> index 0924ceee3098..2ba5d0de1529 100644
> --- a/drivers/video/mcde_simple.c
> +++ b/drivers/video/mcde_simple.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /* Copyright (C) 2019 Stephan Gerhold */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <video.h>
> diff --git a/drivers/video/meson/meson_canvas.c b/drivers/video/meson/meson_canvas.c
> index eccac2f8f24a..dd4c546222d5 100644
> --- a/drivers/video/meson/meson_canvas.c
> +++ b/drivers/video/meson/meson_canvas.c
> @@ -6,7 +6,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   
> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
> index 259af1b45717..587df7beb9b0 100644
> --- a/drivers/video/meson/meson_dw_hdmi.c
> +++ b/drivers/video/meson/meson_dw_hdmi.c
> @@ -4,7 +4,6 @@
>    * Author: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <edid.h>
> diff --git a/drivers/video/meson/meson_plane.c b/drivers/video/meson/meson_plane.c
> index e3f784ecfe42..899ce22d067e 100644
> --- a/drivers/video/meson/meson_plane.c
> +++ b/drivers/video/meson/meson_plane.c
> @@ -6,7 +6,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <linux/bitfield.h>
> diff --git a/drivers/video/meson/meson_vclk.c b/drivers/video/meson/meson_vclk.c
> index e718a0074ed6..4761ff661e4e 100644
> --- a/drivers/video/meson/meson_vclk.c
> +++ b/drivers/video/meson/meson_vclk.c
> @@ -6,7 +6,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <edid.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/video/meson/meson_venc.c b/drivers/video/meson/meson_venc.c
> index e7366dd2fdea..1bc6aaf73055 100644
> --- a/drivers/video/meson/meson_venc.c
> +++ b/drivers/video/meson/meson_venc.c
> @@ -6,7 +6,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <edid.h>
>   #include <fdtdec.h>
> diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
> index 67d4ce7b3b49..ca627728743b 100644
> --- a/drivers/video/meson/meson_vpu.c
> +++ b/drivers/video/meson/meson_vpu.c
> @@ -6,7 +6,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <efi_loader.h>
> diff --git a/drivers/video/meson/meson_vpu_init.c b/drivers/video/meson/meson_vpu_init.c
> index c9808e1c6317..0e34cefd1002 100644
> --- a/drivers/video/meson/meson_vpu_init.c
> +++ b/drivers/video/meson/meson_vpu_init.c
> @@ -8,7 +8,6 @@
>   
>   #define DEBUG
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/video/mipi_dsi.c b/drivers/video/mipi_dsi.c
> index ecacea1dbebd..dc949c8ae61f 100644
> --- a/drivers/video/mipi_dsi.c
> +++ b/drivers/video/mipi_dsi.c
> @@ -32,7 +32,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/mvebu_lcd.c b/drivers/video/mvebu_lcd.c
> index d3d07e5f8333..3fc5640b71ec 100644
> --- a/drivers/video/mvebu_lcd.c
> +++ b/drivers/video/mvebu_lcd.c
> @@ -5,7 +5,6 @@
>    * Initialization of LCD interface and setup of SPLASH screen image
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <part.h>
>   #include <video.h>
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 515363f6a49b..792d6314d15e 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -4,7 +4,6 @@
>    *
>    * Copyright (C) 2011-2013 Marek Vasut <marex@denx.de>
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <env.h>
> diff --git a/drivers/video/nexell/s5pxx18_dp.c b/drivers/video/nexell/s5pxx18_dp.c
> index 2248f4790575..16a489b88dc2 100644
> --- a/drivers/video/nexell/s5pxx18_dp.c
> +++ b/drivers/video/nexell/s5pxx18_dp.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <errno.h>
>   #include <log.h>
>   #include <asm/arch/reset.h>
> diff --git a/drivers/video/nexell/s5pxx18_dp_hdmi.c b/drivers/video/nexell/s5pxx18_dp_hdmi.c
> index 3f1fb8a5757b..109d9f28bb01 100644
> --- a/drivers/video/nexell/s5pxx18_dp_hdmi.c
> +++ b/drivers/video/nexell/s5pxx18_dp_hdmi.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <errno.h>
>   #include <log.h>
>   
> diff --git a/drivers/video/nexell/s5pxx18_dp_lvds.c b/drivers/video/nexell/s5pxx18_dp_lvds.c
> index f8ea63fdf1b3..5db8d2b73b14 100644
> --- a/drivers/video/nexell/s5pxx18_dp_lvds.c
> +++ b/drivers/video/nexell/s5pxx18_dp_lvds.c
> @@ -6,8 +6,8 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <errno.h>
> +#include <stdio.h>
>   
>   #include <asm/arch/nexell.h>
>   #include <asm/arch/reset.h>
> diff --git a/drivers/video/nexell/s5pxx18_dp_mipi.c b/drivers/video/nexell/s5pxx18_dp_mipi.c
> index 670272b26802..58493a825982 100644
> --- a/drivers/video/nexell/s5pxx18_dp_mipi.c
> +++ b/drivers/video/nexell/s5pxx18_dp_mipi.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <errno.h>
>   
>   #include <asm/arch/nexell.h>
> diff --git a/drivers/video/nexell/s5pxx18_dp_rgb.c b/drivers/video/nexell/s5pxx18_dp_rgb.c
> index 44e8edb02a22..6abb8b5e216b 100644
> --- a/drivers/video/nexell/s5pxx18_dp_rgb.c
> +++ b/drivers/video/nexell/s5pxx18_dp_rgb.c
> @@ -6,8 +6,8 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <errno.h>
> +#include <stdio.h>
>   
>   #include <asm/arch/display.h>
>   
> diff --git a/drivers/video/nexell/soc/s5pxx18_soc_disptop.h b/drivers/video/nexell/soc/s5pxx18_soc_disptop.h
> index c7bf5043e605..4ad353256ebc 100644
> --- a/drivers/video/nexell/soc/s5pxx18_soc_disptop.h
> +++ b/drivers/video/nexell/soc/s5pxx18_soc_disptop.h
> @@ -8,6 +8,7 @@
>   #ifndef _S5PXX18_SOC_DISPTOP_H_
>   #define _S5PXX18_SOC_DISPTOP_H_
>   
> +#include <linux/types.h>
>   #include "s5pxx18_soc_disptype.h"
>   
>   #define NUMBER_OF_DISPTOP_MODULE	1
> diff --git a/drivers/video/nexell_display.c b/drivers/video/nexell_display.c
> index af2698ffca84..7bda33fb16e1 100644
> --- a/drivers/video/nexell_display.c
> +++ b/drivers/video/nexell_display.c
> @@ -8,7 +8,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <command.h>
>   #include <dm.h>
>   #include <mapmem.h>
> diff --git a/drivers/video/omap3_dss.c b/drivers/video/omap3_dss.c
> index 432b16bfbfe7..0b7ce348d5ad 100644
> --- a/drivers/video/omap3_dss.c
> +++ b/drivers/video/omap3_dss.c
> @@ -25,7 +25,6 @@
>    * MA 02111-1307 USA
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/arch/dss.h>
>   
> diff --git a/drivers/video/orisetech_otm8009a.c b/drivers/video/orisetech_otm8009a.c
> index 848f174b6e48..a29e909decc9 100644
> --- a/drivers/video/orisetech_otm8009a.c
> +++ b/drivers/video/orisetech_otm8009a.c
> @@ -7,7 +7,6 @@
>    * This otm8009a panel driver is inspired from the Linux Kernel driver
>    * drivers/gpu/drm/panel/panel-orisetech-otm8009a.c.
>    */
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <mipi_dsi.h>
> diff --git a/drivers/video/panel-uclass.c b/drivers/video/panel-uclass.c
> index 1f7e20e0b506..52a3466dc8c1 100644
> --- a/drivers/video/panel-uclass.c
> +++ b/drivers/video/panel-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_PANEL
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <panel.h>
>   
> diff --git a/drivers/video/pwm_backlight.c b/drivers/video/pwm_backlight.c
> index 1c747d98d7ac..a4576c888cf0 100644
> --- a/drivers/video/pwm_backlight.c
> +++ b/drivers/video/pwm_backlight.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <backlight.h>
>   #include <log.h>
> diff --git a/drivers/video/raydium-rm68200.c b/drivers/video/raydium-rm68200.c
> index f1fce55a2cb2..b8662ca22bf2 100644
> --- a/drivers/video/raydium-rm68200.c
> +++ b/drivers/video/raydium-rm68200.c
> @@ -7,7 +7,6 @@
>    * This rm68200 panel driver is inspired from the Linux Kernel driver
>    * drivers/gpu/drm/panel/panel-raydium-rm68200.c.
>    */
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <mipi_dsi.h>
> diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
> index 3f5859055c98..a3697bce5ee3 100644
> --- a/drivers/video/renesas-r61307.c
> +++ b/drivers/video/renesas-r61307.c
> @@ -5,7 +5,6 @@
>    * Copyright (c) 2022 Svyatoslav Ryhel <clamor95@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <panel.h>
> diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
> index 082f5bc3d0a0..9861c3fef11a 100644
> --- a/drivers/video/renesas-r69328.c
> +++ b/drivers/video/renesas-r69328.c
> @@ -5,7 +5,6 @@
>    * Copyright (c) 2022 Svyatoslav Ryhel <clamor95@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <panel.h>
> diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> index fb784636e877..fa512173510b 100644
> --- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> +++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> @@ -24,7 +24,6 @@
>   #include <dm/lists.h>
>   #include <linux/iopoll.h>
>   
> -#include <common.h>
>   #include <log.h>
>   #include <video.h>
>   #include <dm/device-internal.h>
> diff --git a/drivers/video/rockchip/rk3288_hdmi.c b/drivers/video/rockchip/rk3288_hdmi.c
> index efa87540340b..3d39f31a5ade 100644
> --- a/drivers/video/rockchip/rk3288_hdmi.c
> +++ b/drivers/video/rockchip/rk3288_hdmi.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/rockchip/rk3288_mipi.c b/drivers/video/rockchip/rk3288_mipi.c
> index 9d42119c8261..850fe3107549 100644
> --- a/drivers/video/rockchip/rk3288_mipi.c
> +++ b/drivers/video/rockchip/rk3288_mipi.c
> @@ -4,7 +4,6 @@
>    * Author: Eric Gao <eric.gao@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/rockchip/rk3288_vop.c b/drivers/video/rockchip/rk3288_vop.c
> index a4683852ea0c..282831eaac44 100644
> --- a/drivers/video/rockchip/rk3288_vop.c
> +++ b/drivers/video/rockchip/rk3288_vop.c
> @@ -5,7 +5,6 @@
>    * Copyright 2014 Rockchip Inc.
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <regmap.h>
> diff --git a/drivers/video/rockchip/rk3399_hdmi.c b/drivers/video/rockchip/rk3399_hdmi.c
> index 5f3f5d26886d..c7630ccf5558 100644
> --- a/drivers/video/rockchip/rk3399_hdmi.c
> +++ b/drivers/video/rockchip/rk3399_hdmi.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/rockchip/rk3399_mipi.c b/drivers/video/rockchip/rk3399_mipi.c
> index b62d80866745..57e36eed6a99 100644
> --- a/drivers/video/rockchip/rk3399_mipi.c
> +++ b/drivers/video/rockchip/rk3399_mipi.c
> @@ -4,7 +4,6 @@
>    * Author: Eric Gao <eric.gao@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/rockchip/rk3399_vop.c b/drivers/video/rockchip/rk3399_vop.c
> index cb589c7537e6..17e1601e8144 100644
> --- a/drivers/video/rockchip/rk3399_vop.c
> +++ b/drivers/video/rockchip/rk3399_vop.c
> @@ -5,7 +5,6 @@
>    * Copyright 2014 Rockchip Inc.
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
> index 5f68a610e4ac..eb881ba4b0ef 100644
> --- a/drivers/video/rockchip/rk_edp.c
> +++ b/drivers/video/rockchip/rk_edp.c
> @@ -4,7 +4,6 @@
>    * Copyright 2014 Rockchip Inc.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
> index d31f6a4ff81b..0ac0a3a1ecd0 100644
> --- a/drivers/video/rockchip/rk_hdmi.c
> +++ b/drivers/video/rockchip/rk_hdmi.c
> @@ -5,7 +5,6 @@
>    * Copyright 2014 Rockchip Inc.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/rockchip/rk_lvds.c b/drivers/video/rockchip/rk_lvds.c
> index d0a015e31ee8..c969dae30b69 100644
> --- a/drivers/video/rockchip/rk_lvds.c
> +++ b/drivers/video/rockchip/rk_lvds.c
> @@ -3,7 +3,6 @@
>    * Copyright 2016 Rockchip Inc.
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <edid.h>
> diff --git a/drivers/video/rockchip/rk_mipi.c b/drivers/video/rockchip/rk_mipi.c
> index f14cbc6dbf7f..0a603083ba9a 100644
> --- a/drivers/video/rockchip/rk_mipi.c
> +++ b/drivers/video/rockchip/rk_mipi.c
> @@ -4,7 +4,6 @@
>    * Author: Eric Gao <eric.gao@rock-chips.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
> index acc02e5d7c78..17dfe62c9dae 100644
> --- a/drivers/video/rockchip/rk_vop.c
> +++ b/drivers/video/rockchip/rk_vop.c
> @@ -4,7 +4,6 @@
>    * Copyright 2014 Rockchip Inc.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/sandbox_dsi_host.c b/drivers/video/sandbox_dsi_host.c
> index c84a27ee3be6..7025ac986e3c 100644
> --- a/drivers/video/sandbox_dsi_host.c
> +++ b/drivers/video/sandbox_dsi_host.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <dsi_host.h>
> diff --git a/drivers/video/sandbox_osd.c b/drivers/video/sandbox_osd.c
> index 2a854d3958b7..bedc32b7c80e 100644
> --- a/drivers/video/sandbox_osd.c
> +++ b/drivers/video/sandbox_osd.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2018
>    * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
>    */
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/video/sandbox_sdl.c b/drivers/video/sandbox_sdl.c
> index 9081c7da62e4..69dfa9302735 100644
> --- a/drivers/video/sandbox_sdl.c
> +++ b/drivers/video/sandbox_sdl.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2013 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <log.h>
> diff --git a/drivers/video/seps525.c b/drivers/video/seps525.c
> index 74c8721e1e11..86cd301c4b91 100644
> --- a/drivers/video/seps525.c
> +++ b/drivers/video/seps525.c
> @@ -6,7 +6,6 @@
>    * Copyright (C) 2020 Xilinx Inc.
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
> index 76a30427a59f..b6c5b058b2e9 100644
> --- a/drivers/video/simple_panel.c
> +++ b/drivers/video/simple_panel.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <edid.h>
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 33bb78bc3a3e..cb518b149cb5 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2017 Rob Clark
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <fdt_support.h>
> diff --git a/drivers/video/ssd2828.c b/drivers/video/ssd2828.c
> index 948f5e74d0fe..4334bbd72353 100644
> --- a/drivers/video/ssd2828.c
> +++ b/drivers/video/ssd2828.c
> @@ -9,7 +9,6 @@
>    * interface for driving a MIPI compatible TFT display.
>    */
>   
> -#include <common.h>
>   #include <malloc.h>
>   #include <mipi_display.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/video/stm32/stm32_dsi.c b/drivers/video/stm32/stm32_dsi.c
> index a18c1e027a87..438ed41e8d5f 100644
> --- a/drivers/video/stm32/stm32_dsi.c
> +++ b/drivers/video/stm32/stm32_dsi.c
> @@ -10,7 +10,6 @@
>   
>   #define LOG_CATEGORY UCLASS_VIDEO_BRIDGE
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <dsi_host.h>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index 4f60ba8ebeeb..0a062c8939db 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_VIDEO
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <display.h>
>   #include <dm.h>
> diff --git a/drivers/video/sunxi/lcdc.c b/drivers/video/sunxi/lcdc.c
> index 73033c3b8589..264d775c1256 100644
> --- a/drivers/video/sunxi/lcdc.c
> +++ b/drivers/video/sunxi/lcdc.c
> @@ -7,7 +7,6 @@
>    * (C) Copyright 2017 Jernej Skrabec <jernej.skrabec@siol.net>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <linux/delay.h>
>   
> diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
> index e02d359cd259..154641b9a699 100644
> --- a/drivers/video/sunxi/sunxi_de2.c
> +++ b/drivers/video/sunxi/sunxi_de2.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2017 Jernej Skrabec <jernej.skrabec@siol.net>
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <edid.h>
> diff --git a/drivers/video/sunxi/sunxi_display.c b/drivers/video/sunxi/sunxi_display.c
> index 8da44a1bb6d8..4a6a89ef9d26 100644
> --- a/drivers/video/sunxi/sunxi_display.c
> +++ b/drivers/video/sunxi/sunxi_display.c
> @@ -6,7 +6,7 @@
>    * (C) Copyright 2014-2015 Hans de Goede <hdegoede@redhat.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <cpu_func.h>
> diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
> index a5e8d39e98f8..b9c03ea03864 100644
> --- a/drivers/video/sunxi/sunxi_dw_hdmi.c
> +++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <dw_hdmi.h>
> diff --git a/drivers/video/sunxi/sunxi_lcd.c b/drivers/video/sunxi/sunxi_lcd.c
> index 7a01cc343cac..953233fcd683 100644
> --- a/drivers/video/sunxi/sunxi_lcd.c
> +++ b/drivers/video/sunxi/sunxi_lcd.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2017 Vasily Khoruzhick <anarsoul@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <log.h>
>   #include <video_bridge.h>
> diff --git a/drivers/video/sunxi/tve_common.c b/drivers/video/sunxi/tve_common.c
> index 35251371d14f..7bc2b3b29090 100644
> --- a/drivers/video/sunxi/tve_common.c
> +++ b/drivers/video/sunxi/tve_common.c
> @@ -7,7 +7,6 @@
>    * (C) Copyright 2017 Jernej Skrabec <jernej.skrabec@siol.net>
>    */
>   
> -#include <common.h>
>   
>   #include <asm/arch/tve.h>
>   #include <asm/io.h>
> diff --git a/drivers/video/tda19988.c b/drivers/video/tda19988.c
> index 244874390454..ebc8521c6edd 100644
> --- a/drivers/video/tda19988.c
> +++ b/drivers/video/tda19988.c
> @@ -5,7 +5,6 @@
>    * Based on the Linux driver, (C) 2012 Texas Instruments
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <display.h>
>   #include <i2c.h>
> diff --git a/drivers/video/tdo-tl070wsh30.c b/drivers/video/tdo-tl070wsh30.c
> index 273672db024a..d772958f46ed 100644
> --- a/drivers/video/tdo-tl070wsh30.c
> +++ b/drivers/video/tdo-tl070wsh30.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 BayLibre, SAS
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
> -#include <common.h>
>   #include <backlight.h>
>   #include <dm.h>
>   #include <mipi_dsi.h>
> diff --git a/drivers/video/tegra124/display.c b/drivers/video/tegra124/display.c
> index 9261cc9384a2..abe31e27d84d 100644
> --- a/drivers/video/tegra124/display.c
> +++ b/drivers/video/tegra124/display.c
> @@ -5,7 +5,6 @@
>    * Extracted from Chromium coreboot commit 3f59b13d
>    */
>   
> -#include <common.h>
>   #include <bootstage.h>
>   #include <dm.h>
>   #include <edid.h>
> @@ -14,6 +13,7 @@
>   #include <edid.h>
>   #include <log.h>
>   #include <part.h>
> +#include <time.h>
>   #include <video.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> diff --git a/drivers/video/tegra124/dp.c b/drivers/video/tegra124/dp.c
> index b27b1633bab5..763f7ee39fcd 100644
> --- a/drivers/video/tegra124/dp.c
> +++ b/drivers/video/tegra124/dp.c
> @@ -4,12 +4,12 @@
>    * Copyright 2014 Google Inc.
>    */
>   
> -#include <common.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <div64.h>
>   #include <errno.h>
>   #include <log.h>
> +#include <time.h>
>   #include <video_bridge.h>
>   #include <asm/io.h>
>   #include <asm/arch-tegra/dc.h>
> diff --git a/drivers/video/tegra124/sor.c b/drivers/video/tegra124/sor.c
> index 258685182c7d..1ce5330c6bcf 100644
> --- a/drivers/video/tegra124/sor.c
> +++ b/drivers/video/tegra124/sor.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2011-2013, NVIDIA Corporation.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/video/tegra20/mipi-phy.c b/drivers/video/tegra20/mipi-phy.c
> index c3ebc4074b53..576262e405d6 100644
> --- a/drivers/video/tegra20/mipi-phy.c
> +++ b/drivers/video/tegra20/mipi-phy.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2013 NVIDIA Corporation
>    */
>   
> -#include <common.h>
>   #include <linux/err.h>
>   
>   #include "mipi-phy.h"
> diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
> index 13dae37806f1..35a8e6c176b3 100644
> --- a/drivers/video/tegra20/tegra-dsi.c
> +++ b/drivers/video/tegra20/tegra-dsi.c
> @@ -4,7 +4,6 @@
>    * Copyright (c) 2022 Svyatoslav Ryhel <clamor95@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <misc.h>
> diff --git a/drivers/video/tegra20/tegra-pwm-backlight.c b/drivers/video/tegra20/tegra-pwm-backlight.c
> index 5f93f57fe908..79d8a021a3ac 100644
> --- a/drivers/video/tegra20/tegra-pwm-backlight.c
> +++ b/drivers/video/tegra20/tegra-pwm-backlight.c
> @@ -6,7 +6,6 @@
>   #define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
>   
>   #include <backlight.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/video/ti/tilcdc-panel.c b/drivers/video/ti/tilcdc-panel.c
> index df95086a5151..d40765230600 100644
> --- a/drivers/video/ti/tilcdc-panel.c
> +++ b/drivers/video/ti/tilcdc-panel.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
>    */
>   
> -#include <common.h>
>   #include <backlight.h>
>   #include <clk.h>
>   #include <display.h>
> diff --git a/drivers/video/ti/tilcdc.c b/drivers/video/ti/tilcdc.c
> index 2734754ecde7..493e2f18cd2d 100644
> --- a/drivers/video/ti/tilcdc.c
> +++ b/drivers/video/ti/tilcdc.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
> index 1380c6b69375..865d4bddb7f9 100644
> --- a/drivers/video/tidss/tidss_drv.c
> +++ b/drivers/video/tidss/tidss_drv.c
> @@ -9,7 +9,6 @@
>    * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk.h>
>   #include <log.h>
> diff --git a/drivers/video/vesa.c b/drivers/video/vesa.c
> index 50912c5c8bca..ab756ac8ea12 100644
> --- a/drivers/video/vesa.c
> +++ b/drivers/video/vesa.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <pci.h>
> diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
> index 5d06e51ff236..80e7adf6a1a4 100644
> --- a/drivers/video/vidconsole-uclass.c
> +++ b/drivers/video/vidconsole-uclass.c
> @@ -9,7 +9,6 @@
>   
>   #define LOG_CATEGORY UCLASS_VIDEO_CONSOLE
>   
> -#include <common.h>
>   #include <abuf.h>
>   #include <charset.h>
>   #include <command.h>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index 7b5d1dfbb3bd..ff1382f4a43b 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_VIDEO
>   
> -#include <common.h>
>   #include <bloblist.h>
>   #include <console.h>
>   #include <cpu_func.h>
> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
> index 45f003c8251a..ad512d99a1b9 100644
> --- a/drivers/video/video_bmp.c
> +++ b/drivers/video/video_bmp.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2015 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <bmp_layout.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/video/video_osd-uclass.c b/drivers/video/video_osd-uclass.c
> index 0d3aae4d8272..923686345ff7 100644
> --- a/drivers/video/video_osd-uclass.c
> +++ b/drivers/video/video_osd-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_VIDEO_OSD
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <video_osd.h>
>   
> diff --git a/drivers/video/videomodes.c b/drivers/video/videomodes.c
> index 35955a5df7dd..d86d86798415 100644
> --- a/drivers/video/videomodes.c
> +++ b/drivers/video/videomodes.c
> @@ -55,7 +55,6 @@
>   		      "myvideo" and setting the variable "videomode=myvideo"..
>   ****************************************************************************/
>   
> -#include <common.h>
>   #include <edid.h>
>   #include <env.h>
>   #include <errno.h>
> diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
> index def4dcf6261a..1405b29cb8b9 100644
> --- a/drivers/video/zynqmp/zynqmp_dpsub.c
> +++ b/drivers/video/zynqmp/zynqmp_dpsub.c
> @@ -6,7 +6,6 @@
>    * Xilinx displayport(DP) Tx Subsytem driver
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
