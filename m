Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840FCC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32818892F;
	Fri,  9 Aug 2024 10:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PwJ6i1K0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193048895D; Fri,  9 Aug 2024 10:28:29 +0200 (CEST)
Received: from mail-m12762.qiye.163.com (mail-m12762.qiye.163.com
 [115.236.127.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E496088606
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=PwJ6i1K0ykO87PFBsRYYZSG2W2+eo+lZRqu6j/KnlzKHotrkKXH9oC4PpN1Jz0X+GvRfCdvsOmEst0YLjK6oQTCUBahebPrZi5vJBc5YKx92G1T+L8DL3ofxRA7FGf1UsDmW2SzleaSRD4dE/aX7wyEeQTeoa8MQDTtlwhxgOP4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=kY5cYwA8+zz+vL59w6fapwwj2J6jYciFjV/pmeQJ1ts=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5104B90053A;
 Fri,  9 Aug 2024 16:28:08 +0800 (CST)
Message-ID: <1ca74830-69ee-4ab6-a5cf-6a2639d14c9c@rock-chips.com>
Date: Fri, 9 Aug 2024 16:28:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: configs: puma-rk3399: disable VIDEO support
 that breaks Linux
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240729-puma-no-video-v1-1-3b92072642a4@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240729-puma-no-video-v1-1-3b92072642a4@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkxMVktMTE9OSBkZQklDS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1
 VLWQY+
X-HM-Tid: 0a913640996103a9kunm5104b90053a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBA6HSo5PDIzCw9WHkowQjkY
 ShgaCQNVSlVKTElISkJJS0NCTklMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUNLTUo3Bg++
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


On 2024/7/29 19:04, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> RK3399 Puma has support for driving multiple displays at the same time,
> the most notable scenario being HDMI+DSI since there exists a devkit
> with both DSI display and HDMI output.
>
> While HDMI seems to work fine in U-Boot, as the U-Boot logo is shown
> whenever the EFI bootmeth is used, it messes up DSI in HDMI+DSI setup in
> the Linux kernel. There are some ways to work around this bug but no
> known appropriate fix for now, so let's rather not trigger this bug.
>
> Since there isn't any client of ours that seems to be using this
> feature, let's disable it for now. Users can re-enable this feature in
> the event they have HDMI-only products.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> @linux-rockchip: you've been added to this as it's an issue in the Linux
> kernel but that gets triggered from U-Boot. This is a patch for U-Boot
> but I wanted it to be available in linux-rockchip archives :)
>
> We recently ported Puma from 2022.10 to 2024.07 in our vendor tree but
> discovered that this broke the DSI display on our devkit whenever an
> HDMI display would be connected at boot.
>
> While VIDEO has been enabled for a few years already on Puma, something
> actually started to make use of it in the "normal" boot process (it
> seems to be the EFI bootmeth?). While it seems to work okay-ish as the
> U-Boot logo is shown properly, it is followed by artefacts whenever the
> kernel is taking over in the boot flow. Additionally, whenever one boots
> with HDMI connected and has a secondary DSI display, DSI is now broken
> in the Linux kernel until I unplug HDMI.
>
> A bit of debugging later, it seems we have a different clock for the
> DCLK of the VOP used for DSI. GPLL is used whenever no HDMI is plugged
> in, otherwise VPLL is used. The rate of the frac clock is also
> different, with 59756KHz when it doesn't work and 59400KHz when it does.
>
> I discovered that the frac clock doesn't try to set the rate of its
> parent, the div clock, so tried the following:
>
> """
>   diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
>   index 4f1a5782c2308..fd5d11b9e12ed 100644
>   --- a/drivers/clk/rockchip/clk-rk3399.c
>   +++ b/drivers/clk/rockchip/clk-rk3399.c
>   @@ -1166,7 +1166,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>    			RK3399_CLKSEL_CON(49), 8, 2, MFLAGS, 0, 8, DFLAGS,
>    			RK3399_CLKGATE_CON(10), 12, GFLAGS),
>    
>   -	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP0_FRAC, "dclk_vop0_frac", "dclk_vop0_div", 0,
>   +	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP0_FRAC, "dclk_vop0_frac", "dclk_vop0_div", CLK_SET_RATE_PARENT,
>    			RK3399_CLKSEL_CON(106), 0,
>    			&rk3399_dclk_vop0_fracmux),
>    
>   @@ -1196,7 +1196,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>    			RK3399_CLKSEL_CON(50), 8, 2, MFLAGS, 0, 8, DFLAGS,
>    			RK3399_CLKGATE_CON(10), 13, GFLAGS),
>    
>   -	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP1_FRAC, "dclk_vop1_frac", "dclk_vop1_div", 0,
>   +	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP1_FRAC, "dclk_vop1_frac", "dclk_vop1_div", CLK_SET_RATE_PARENT,
>    			RK3399_CLKSEL_CON(107), 0,
>    			&rk3399_dclk_vop1_fracmux),
> """
>
> which made it work! But... the rate of the frac (but not the div!) is
> the same as well as the parent of div clock (still VPLL), so this
> smelled fishy, something like a timing issue.
>
> I therefore tried to reorder the probing of HDMI and DSI with:
>
> """
>   diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>   index 6492f3caf0174..482b9a169653e 100644
>   --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>   +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>   @@ -524,10 +524,10 @@ static int __init rockchip_drm_init(void)
>    	ADD_ROCKCHIP_SUB_DRIVER(rockchip_dp_driver,
>    				CONFIG_ROCKCHIP_ANALOGIX_DP);
>    	ADD_ROCKCHIP_SUB_DRIVER(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
>   -	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
>   -				CONFIG_ROCKCHIP_DW_HDMI);
>    	ADD_ROCKCHIP_SUB_DRIVER(dw_mipi_dsi_rockchip_driver,
>    				CONFIG_ROCKCHIP_DW_MIPI_DSI);
>   +	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
>   +				CONFIG_ROCKCHIP_DW_HDMI);
>    	ADD_ROCKCHIP_SUB_DRIVER(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
>    	ADD_ROCKCHIP_SUB_DRIVER(rk3066_hdmi_driver,
>    				CONFIG_ROCKCHIP_RK3066_HDMI);
> """
>
> this worked too!
>
> Then, I tried something else, applying
> https://lore.kernel.org/all/20240615170417.3134517-14-jonas@kwiboo.se/
>
> ... which also made it work! But re-ordering the probe order like above,
> broke it again. So not perfect...
>
> It does seem that HDMI may need to be on VOPB in multidisplay scenarios?
> I honestly do not have any idea of what's going on here and I am not
> aware of any of our users using video in U-Boot, so we'll just be
> disabling it for now until some of our users request it in a
> multi-display context. Basically sweeping the dirt under the rug until
> someone lifts it.
> ---
>   configs/puma-rk3399_defconfig | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 9e5499a1fec..ccc7f355dbd 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -19,6 +19,7 @@ CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
> +CONFIG_CONSOLE_MUX=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
>   CONFIG_SPL_PAD_TO=0x38000
> @@ -40,7 +41,6 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_BMP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
>   CONFIG_CMD_PMIC=y
> @@ -102,12 +102,4 @@ CONFIG_USB_ETHER_ASIX88179=y
>   CONFIG_USB_ETHER_MCS7830=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
> -CONFIG_VIDEO=y
> -# CONFIG_VIDEO_BPP8 is not set
> -CONFIG_DISPLAY=y
> -CONFIG_VIDEO_ROCKCHIP=y
> -CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_BMP_16BPP=y
> -CONFIG_BMP_24BPP=y
> -CONFIG_BMP_32BPP=y
>   CONFIG_ERRNO_STR=y
>
> ---
> base-commit: 9366640449ac3ef702b624e2f6f7604754a9082b
> change-id: 20240729-puma-no-video-3d9e11ac6104
>
> Best regards,
