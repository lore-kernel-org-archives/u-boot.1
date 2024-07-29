Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E26C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 11:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B1B887BE;
	Mon, 29 Jul 2024 13:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03BBA887CD; Mon, 29 Jul 2024 13:04:52 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92FC788365
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 13:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WXb9F1YDJzbLD;
 Mon, 29 Jul 2024 13:04:49 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4WXb9D0kQGzDqR; Mon, 29 Jul 2024 13:04:48 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 29 Jul 2024 13:04:23 +0200
Subject: [PATCH] rockchip: configs: puma-rk3399: disable VIDEO support that
 breaks Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-puma-no-video-v1-1-3b92072642a4@cherry.de>
X-B4-Tracking: v=1; b=H4sIADZ3p2YC/x3MQQqAIBBA0avIrBtwTIq6SrSQnGoWaShJEN09a
 fkW/z+QOQlnGNUDiYtkiaGCGgXL7sLGKL4ajDZW92bA8zochohFPEds/cBEbulIW6jNmXiV+/9
 N8/t+lSZipl8AAAA=
To: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 linux-rockchip@lists.infradead.org, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

RK3399 Puma has support for driving multiple displays at the same time,
the most notable scenario being HDMI+DSI since there exists a devkit
with both DSI display and HDMI output.

While HDMI seems to work fine in U-Boot, as the U-Boot logo is shown
whenever the EFI bootmeth is used, it messes up DSI in HDMI+DSI setup in
the Linux kernel. There are some ways to work around this bug but no
known appropriate fix for now, so let's rather not trigger this bug.

Since there isn't any client of ours that seems to be using this
feature, let's disable it for now. Users can re-enable this feature in
the event they have HDMI-only products.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
@linux-rockchip: you've been added to this as it's an issue in the Linux
kernel but that gets triggered from U-Boot. This is a patch for U-Boot
but I wanted it to be available in linux-rockchip archives :)

We recently ported Puma from 2022.10 to 2024.07 in our vendor tree but
discovered that this broke the DSI display on our devkit whenever an
HDMI display would be connected at boot.

While VIDEO has been enabled for a few years already on Puma, something
actually started to make use of it in the "normal" boot process (it
seems to be the EFI bootmeth?). While it seems to work okay-ish as the
U-Boot logo is shown properly, it is followed by artefacts whenever the
kernel is taking over in the boot flow. Additionally, whenever one boots
with HDMI connected and has a secondary DSI display, DSI is now broken
in the Linux kernel until I unplug HDMI.

A bit of debugging later, it seems we have a different clock for the
DCLK of the VOP used for DSI. GPLL is used whenever no HDMI is plugged
in, otherwise VPLL is used. The rate of the frac clock is also
different, with 59756KHz when it doesn't work and 59400KHz when it does.

I discovered that the frac clock doesn't try to set the rate of its
parent, the div clock, so tried the following:

"""
 diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
 index 4f1a5782c2308..fd5d11b9e12ed 100644
 --- a/drivers/clk/rockchip/clk-rk3399.c
 +++ b/drivers/clk/rockchip/clk-rk3399.c
 @@ -1166,7 +1166,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
  			RK3399_CLKSEL_CON(49), 8, 2, MFLAGS, 0, 8, DFLAGS,
  			RK3399_CLKGATE_CON(10), 12, GFLAGS),
  
 -	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP0_FRAC, "dclk_vop0_frac", "dclk_vop0_div", 0,
 +	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP0_FRAC, "dclk_vop0_frac", "dclk_vop0_div", CLK_SET_RATE_PARENT,
  			RK3399_CLKSEL_CON(106), 0,
  			&rk3399_dclk_vop0_fracmux),
  
 @@ -1196,7 +1196,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
  			RK3399_CLKSEL_CON(50), 8, 2, MFLAGS, 0, 8, DFLAGS,
  			RK3399_CLKGATE_CON(10), 13, GFLAGS),
  
 -	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP1_FRAC, "dclk_vop1_frac", "dclk_vop1_div", 0,
 +	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP1_FRAC, "dclk_vop1_frac", "dclk_vop1_div", CLK_SET_RATE_PARENT,
  			RK3399_CLKSEL_CON(107), 0,
  			&rk3399_dclk_vop1_fracmux),
"""

which made it work! But... the rate of the frac (but not the div!) is
the same as well as the parent of div clock (still VPLL), so this
smelled fishy, something like a timing issue.

I therefore tried to reorder the probing of HDMI and DSI with:

"""
 diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
 index 6492f3caf0174..482b9a169653e 100644
 --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
 +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
 @@ -524,10 +524,10 @@ static int __init rockchip_drm_init(void)
  	ADD_ROCKCHIP_SUB_DRIVER(rockchip_dp_driver,
  				CONFIG_ROCKCHIP_ANALOGIX_DP);
  	ADD_ROCKCHIP_SUB_DRIVER(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
 -	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
 -				CONFIG_ROCKCHIP_DW_HDMI);
  	ADD_ROCKCHIP_SUB_DRIVER(dw_mipi_dsi_rockchip_driver,
  				CONFIG_ROCKCHIP_DW_MIPI_DSI);
 +	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
 +				CONFIG_ROCKCHIP_DW_HDMI);
  	ADD_ROCKCHIP_SUB_DRIVER(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
  	ADD_ROCKCHIP_SUB_DRIVER(rk3066_hdmi_driver,
  				CONFIG_ROCKCHIP_RK3066_HDMI);
"""

this worked too!

Then, I tried something else, applying
https://lore.kernel.org/all/20240615170417.3134517-14-jonas@kwiboo.se/

... which also made it work! But re-ordering the probe order like above,
broke it again. So not perfect...

It does seem that HDMI may need to be on VOPB in multidisplay scenarios?
I honestly do not have any idea of what's going on here and I am not
aware of any of our users using video in U-Boot, so we'll just be
disabling it for now until some of our users request it in a
multi-display context. Basically sweeping the dirt under the rug until
someone lifts it.
---
 configs/puma-rk3399_defconfig | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 9e5499a1fec..ccc7f355dbd 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
+CONFIG_CONSOLE_MUX=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x38000
@@ -40,7 +41,6 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
@@ -102,12 +102,4 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
-CONFIG_VIDEO=y
-# CONFIG_VIDEO_BPP8 is not set
-CONFIG_DISPLAY=y
-CONFIG_VIDEO_ROCKCHIP=y
-CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_BMP_16BPP=y
-CONFIG_BMP_24BPP=y
-CONFIG_BMP_32BPP=y
 CONFIG_ERRNO_STR=y

---
base-commit: 9366640449ac3ef702b624e2f6f7604754a9082b
change-id: 20240729-puma-no-video-3d9e11ac6104

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

