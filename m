Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE82CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEEB838DD;
	Mon,  3 Nov 2025 14:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SskFkde3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582AA83700; Mon,  3 Nov 2025 04:27:27 +0100 (CET)
Received: from mail-m93158.xmail.ntesmail.com (mail-m93158.xmail.ntesmail.com
 [103.126.93.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E6D983642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 04:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chaoyi.chen@rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 281f0f5dd;
 Mon, 3 Nov 2025 11:27:18 +0800 (GMT+08:00)
Message-ID: <08c523fa-a501-4d50-85f5-7ac13f3c9247@rock-chips.com>
Date: Mon, 3 Nov 2025 11:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] video: rockchip: Add bridge support for VOP
To: WeiHao Li <cn.liweihao@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 ag.dev.uboot@gmail.com, muratdemirtaseu@outlook.com,
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
 <20250814131237.8135-5-cn.liweihao@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20250814131237.8135-5-cn.liweihao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a47c140e403abkunm69d2f19d97e1c5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgZSFYZTU1MHUkfHU5MSk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=SskFkde3+BPyqMG+B9adVPUD/dd+TQaGCB9B8va7tbYSS1HP8LG0HcS8dKPEPYNxQPOfzFCBjil1uyIy1vQZ4k6dpom6AfhzORe3c+02C7cRh1EoHs6HUp1ateWDDVWekIIl95WcEA+bI7fcj3SuJkaxpusKGE6jeryTM0rNwMI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=idSdhof/S3ImLSTV+be+9PLjn1ew4cOaX2y2tK69XP0=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

Hi WeiHao,

On 8/14/2025 9:12 PM, WeiHao Li wrote:
> Rockchip VOP driver only support UCLASS_DISPLAY for now, It can't work
> if SOC use dw-mipi with inno-dphy like RK3368.
>
> This patch try to add UCLASS_VIDEO_BRIDGE support to let it support
> dw-mipi-dsi-rockchip driver, will support SOC use dw-mipi with inno-dphy.
>
> This patch basic same as muratdemirtas's github repository, just adjust
> some code style.
>
> Link: https://github.com/muratdemirtas/rockchip-rk3399-uboot-mipi-dsi
>
> Signed-off-by: muratdemirtas <muratdemirtaseu@outlook.com>
> Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>

The rk_vop.c should implement code related to the VOP controller.  And anything related to panel/backlight should not appear here.

Please refer to rk3288_mipi.c or rk3399_mipi.c.  You can implement a UCLASS_DISPLAY device to access the UCLASS_VIDEO_BRIDGE device.


> ---
>   drivers/video/rockchip/rk_vop.c | 92 +++++++++++++++++++++++++--------
>   1 file changed, 71 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
> index 17dfe62c9..71786da77 100644
> --- a/drivers/video/rockchip/rk_vop.c
> +++ b/drivers/video/rockchip/rk_vop.c
> @@ -14,6 +14,8 @@
>   #include <reset.h>
>   #include <syscon.h>
>   #include <video.h>
> +#include <video_bridge.h>
> +#include <panel.h>
>   #include <asm/global_data.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> @@ -257,6 +259,8 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
>   	ofnode remote;
>   	const char *compat;
>   	struct reset_ctl dclk_rst;
> +	struct udevice *bridge;
> +	struct udevice *panel;
>   
>   	debug("%s(%s, 0x%lx, %s)\n", __func__,
>   	      dev_read_name(dev), fbbase, ofnode_get_name(ep_node));
> @@ -298,6 +302,10 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
>   			return -EINVAL;
>   		}
>   
> +		uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote, &bridge);
> +		if (bridge)
> +			break;
> +
>   		uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &disp);
>   		if (disp)
>   			break;
> @@ -326,27 +334,60 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
>   	}
>   	debug("vop_id=%d\n", vop_id);
>   
> -	disp_uc_plat = dev_get_uclass_plat(disp);
> -	debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
> -	if (display_in_use(disp)) {
> -		debug("   - device in use\n");
> -		return -EBUSY;
> -	}
> +	if (bridge) {
> +		/* video bridge detected, probe it */
> +		ret = device_probe(bridge);
> +		if (ret) {
> +			debug("%s: device '%s' bridge won't probe (ret=%d)\n",
> +			      __func__, dev->name, ret);
> +			return ret;
> +		}
>   
> -	disp_uc_plat->source_id = remote_vop_id;
> -	disp_uc_plat->src_dev = dev;
> +		/* Attach the DSI controller and the display to the bridge. */
> +		ret = video_bridge_attach(bridge);
> +		if (ret) {
> +			debug("Failed to attach video bridge: %d\n", ret);
> +			return ret;
> +		}
>   
> -	ret = device_probe(disp);
> -	if (ret) {
> -		debug("%s: device '%s' display won't probe (ret=%d)\n",
> -		      __func__, dev->name, ret);
> -		return ret;
> -	}
> +		/*
> +		 * Get the panel device
> +		 * TODO: Maybe fetch it from the bridge private data.
> +		 */
> +		ret = uclass_first_device_err(UCLASS_PANEL, &panel);
> +		if (ret) {
> +			debug("Panel device error: %d\n", ret);
> +			return ret;
> +		}
>   
> -	ret = display_read_timing(disp, &timing);
> -	if (ret) {
> -		debug("%s: Failed to read timings\n", __func__);
> -		return ret;
> +		ret = panel_get_display_timing(panel, &timing);
> +		if (ret) {
> +			debug("%s: Failed to read timings\n", __func__);
> +			return ret;
> +		}
> +	} else {
> +		disp_uc_plat = dev_get_uclass_plat(disp);
> +		debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
> +		if (display_in_use(disp)) {
> +			debug("   - device in use\n");
> +			return -EBUSY;
> +		}
> +
> +		disp_uc_plat->source_id = remote_vop_id;
> +		disp_uc_plat->src_dev = dev;
> +
> +		ret = device_probe(disp);
> +		if (ret) {
> +			debug("%s: device '%s' display won't probe (ret=%d)\n",
> +			      __func__, dev->name, ret);
> +			return ret;
> +		}
> +
> +		ret = display_read_timing(disp, &timing);
> +		if (ret) {
> +			debug("%s: Failed to read timings\n", __func__);
> +			return ret;
> +		}
>   	}
>   
>   	ret = clk_get_by_index(dev, 1, &clk);
> @@ -383,9 +424,18 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
>   
>   	rkvop_enable(dev, fbbase, 1 << l2bpp, &timing, &dclk_rst);
>   
> -	ret = display_enable(disp, 1 << l2bpp, &timing);
> -	if (ret)
> -		return ret;
> +	if (bridge) {
> +		/* Attach the DSI controller and the display to the bridge. */
> +		ret = video_bridge_set_backlight(bridge, 80);
> +		if (ret) {
> +			printf("Failed to start the video bridge: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = display_enable(disp, 1 << l2bpp, &timing);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	uc_priv->xsize = timing.hactive.typ;
>   	uc_priv->ysize = timing.vactive.typ;

-- 
Best,
Chaoyi

