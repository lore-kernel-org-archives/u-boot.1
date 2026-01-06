Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A17CDC196
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A880283F7D;
	Tue,  6 Jan 2026 14:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WCOZ58pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E0A83F20; Tue,  6 Jan 2026 10:34:53 +0100 (CET)
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com
 [220.197.32.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B53883A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 10:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shawn.lin@rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2fab6577c;
 Tue, 6 Jan 2026 17:34:43 +0800 (GMT+08:00)
Message-ID: <87de9598-bc44-4ea6-9eb7-a4246a7aa5a4@rock-chips.com>
Date: Tue, 6 Jan 2026 17:34:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Elaine Zhang <zhangqing@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH v2 2/3] ufs: rockchip: Add device reset support
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
 <20260105-rk3576-ufs-v2-2-caba979a0d6b@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260105-rk3576-ufs-v2-2-caba979a0d6b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b92a89ee509cekunm848dc3181673359
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgYSlYfGE0fQkJDSB5MGk5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=WCOZ58pt+Rngx4aomd+OCTqMcKJWHB/21IrxwGu0YtzpHsve55zESDn1ihPCR4IN5hFy9LZhj8+EdOD+6oqGwZPFPEjFgYY6rUt6CqcTwyFyI6g3aSspK51PnYORZ0WiySRIU36VJK75g84JnKPUnI2ceKDSGeS4fLdnTuXAWQI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=eXKY89NDK+o5jpBUD6nInu/IeQMTuCuN0DPzhuZng9Q=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Tue, 06 Jan 2026 14:02:03 +0100
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

在 2026/01/05 星期一 23:05, Alexey Charkov 写道:
> Wire up the GPIO line which Rockchip RK3576 UFS controller uses to reset
> the connected UFS device.
> 
> This seems necessary at least for some UFS modules and fixes the following
> error while enumerating UFS storage:
> 
> ufshcd-rockchip ufshc@2a2d0000: ufshcd_link_startup: Device not present
> ufshcd-rockchip ufshc@2a2d0000: link startup failed -6
> ufshcd-rockchip ufshc@2a2d0000: ufshcd_pltfrm_init() failed -6
> 

LGTM, thanks.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: 76465ce21ee4 ("ufs: rockchip: Add initial support")
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   drivers/ufs/Kconfig        |  1 +
>   drivers/ufs/ufs-rockchip.c | 25 +++++++++++++++++++++++++
>   drivers/ufs/ufs-rockchip.h |  1 +
>   3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 6c75bb2a0790..30b0c87798e1 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
>   config UFS_ROCKCHIP
>   	bool "Rockchip specific hooks to UFS controller platform driver"
>   	depends on UFS
> +	select DM_GPIO
>   	help
>   	  This selects the Rockchip specific additions to UFSHCD platform driver.
>   
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> index 0384244387da..48444705fb29 100644
> --- a/drivers/ufs/ufs-rockchip.c
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
>    */
>   
> +#include <asm/gpio.h>
>   #include <asm/io.h>
>   #include <clk.h>
>   #include <dm.h>
> @@ -153,11 +154,34 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
>   		return err;
>   	}
>   
> +	err = gpio_request_by_name(dev, "reset-gpios", 0, &host->device_reset,
> +				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +	if (err) {
> +		dev_err(dev, "Warning: cannot get reset GPIO\n");
> +		return err;
> +	}
> +
>   	host->hba = hba;
>   
>   	return 0;
>   }
>   
> +static int ufs_rockchip_device_reset(struct ufs_hba *hba)
> +{
> +	struct ufs_rockchip_host *host = dev_get_priv(hba->dev);
> +
> +	if (!dm_gpio_is_valid(&host->device_reset))
> +		return 0;
> +
> +	dm_gpio_set_value(&host->device_reset, true);
> +	udelay(20);
> +
> +	dm_gpio_set_value(&host->device_reset, false);
> +	udelay(20);
> +
> +	return 0;
> +}
> +
>   static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
>   {
>   	int ret = 0;
> @@ -175,6 +199,7 @@ static struct ufs_hba_ops ufs_hba_rk3576_vops = {
>   	.init = ufs_rockchip_rk3576_init,
>   	.phy_initialization = ufs_rockchip_rk3576_phy_init,
>   	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
> +	.device_reset = ufs_rockchip_device_reset,
>   };
>   
>   static const struct udevice_id ufs_rockchip_of_match[] = {
> diff --git a/drivers/ufs/ufs-rockchip.h b/drivers/ufs/ufs-rockchip.h
> index 3dcb80f57020..50c2539da78a 100644
> --- a/drivers/ufs/ufs-rockchip.h
> +++ b/drivers/ufs/ufs-rockchip.h
> @@ -72,6 +72,7 @@ struct ufs_rockchip_host {
>   	void __iomem *ufs_sys_ctrl;
>   	void __iomem *mphy_base;
>   	struct reset_ctl_bulk rsts;
> +	struct gpio_desc device_reset;
>   	struct clk ref_out_clk;
>   	uint64_t caps;
>   	uint32_t phy_config_mode;
> 

