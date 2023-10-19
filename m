Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB33CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 18:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F8E871BE;
	Thu, 19 Oct 2023 20:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="WqQTBQn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B53538745A; Thu, 19 Oct 2023 20:55:45 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC588719D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 20:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=B7tUy+zBQCK2Cftn1mIcPlvRq4TS3t8NpTjyvcTHcpU=; b=WqQTBQn26hOgSNZ4TiGCAEvlaJ
 muZUDbzvm5MTx/QPGK6qwmkbr97psWIh50pn7l97wR0Gzmbbs3V0jWGY+rxbO+GiQR1uzl+eNb1ML
 DriPCZBjblUn9FqhM5tHFybQmACPIWLLAsV5wfbgp3S2P/cQmjmtT93OHldzPHd1uMqY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45360
 helo=pettiford) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qtYBG-0007gw-Tg; Thu, 19 Oct 2023 14:55:40 -0400
Date: Thu, 19 Oct 2023 14:55:37 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam
 <festevam@denx.de>
Message-Id: <20231019145537.3eefeec4236f2e4a3449c9ea@hugovil.com>
In-Reply-To: <20231019170441.1610453-1-festevam@gmail.com>
References: <20231019170441.1610453-1-festevam@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH] imx8mp_evk: Simplify FEC initialization
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

On Thu, 19 Oct 2023 14:04:41 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
> 
> With DM enabled, there is no need for board code to initialize
> the FEC interface.
> 
> The RTL8211FDI Ethernet PHYs have 25MHz oscillator, so there is no
> need to enable the RGMII TX clk output.
> 
> Also, there is no need for describing the deprecated phy-reset properties
> in u-boot.dtsi.
> 
> Remove all these uneeded pieces.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  arch/arm/dts/imx8mp-evk-u-boot.dtsi     |  8 --------
>  board/freescale/imx8mp_evk/imx8mp_evk.c | 26 +------------------------
>  2 files changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> index 43f13a9c22f7..db6bc6a11883 100644
> --- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> @@ -150,11 +150,3 @@
>  	reset-delay-us = <15000>;
>  	reset-post-delay-us = <100000>;
>  };
> -
> -&fec {
> -	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
> -	phy-reset-duration = <15>;
> -	phy-reset-post-delay = <100>;
> -};
> -
> -
> diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
> index a24b8c1d8608..2c2b8383c8dc 100644
> --- a/board/freescale/imx8mp_evk/imx8mp_evk.c
> +++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
> @@ -20,33 +20,9 @@
>  
>  DECLARE_GLOBAL_DATA_PTR;

Hi Fabio,
there is probably some #includes that are no longer necessary after
this change... maybe remove them as well, or in another cleanup patch?

Hugo.


> -static void setup_fec(void)
> -{
> -	struct iomuxc_gpr_base_regs *gpr =
> -		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
> -
> -	/* Enable RGMII TX clk output */
> -	setbits_le32(&gpr->gpr[1], BIT(22));
> -}
> -
> -#if CONFIG_IS_ENABLED(NET)
> -int board_phy_config(struct phy_device *phydev)
> -{
> -	if (phydev->drv->config)
> -		phydev->drv->config(phydev);
> -	return 0;
> -}
> -#endif
> -
>  int board_init(void)
>  {
> -	int ret = 0;
> -
> -	if (IS_ENABLED(CONFIG_FEC_MXC)) {
> -		setup_fec();
> -	}
> -
> -	return ret;
> +	return 0;
>  }
>  
>  int board_late_init(void)
> -- 
> 2.34.1
> 
