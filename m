Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E48CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 20:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C5E86F78;
	Thu, 19 Oct 2023 22:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="RAQnhooB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 168C387471; Thu, 19 Oct 2023 22:37:37 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46D886F6F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 22:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=OO7DNlho2vs/inN7d28Y5X0mN5lQzKxkYQ7vqiLKt3w=; b=RAQnhooBRT7aDnnITK+9TJil0j
 WizpMBwK44ZUWyVoW6ot0fWxVdEbE/6wsTOfnBUECpU2rhHCsSHODqsOD1CB7FjHVwOquyawxkK+V
 t2vl0wBwKeVj5J7dOSW6sB4CWhMtW85PGe70uA8y84p4RDtdpxS4/H9IwjagfrWdb5yc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:33900
 helo=pettiford) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qtZls-0000R2-HQ; Thu, 19 Oct 2023 16:37:33 -0400
Date: Thu, 19 Oct 2023 16:37:32 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam
 <festevam@denx.de>
Message-Id: <20231019163732.01a0e9fcf23b07629a7c3b51@hugovil.com>
In-Reply-To: <20231019192155.1735199-1-festevam@gmail.com>
References: <20231019192155.1735199-1-festevam@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v2 1/2] imx8mp_evk: Simplify Ethernet initialization
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

On Thu, 19 Oct 2023 16:21:54 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
> 
> With DM enabled, there is no need for board code to initialize
> the Ethernet interfaces.
> 
> The RTL8211FDI Ethernet PHYs have 25MHz oscillator, so there is no
> need to enable the RGMII TX clk output.
> 
> Also, there is no need for describing the deprecated phy-reset FEC
> properties, nor passing reset properties to the EQOS interface in
> u-boot.dtsi.
> 
> Remove all these unneeded pieces.
> 
> Tested both Ethernet interfaces after these changes.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


> ---
> Changes since v1:
> - Removed Ethernet related headers. (Hugo)
> - Also removed custom eqos reset properties from u-boot.dtsi.
> 
>  arch/arm/dts/imx8mp-evk-u-boot.dtsi     | 14 -------------
>  board/freescale/imx8mp_evk/imx8mp_evk.c | 28 +------------------------
>  2 files changed, 1 insertion(+), 41 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> index 0bf489b46248..51c84383673c 100644
> --- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> @@ -137,17 +137,3 @@
>  &wdog1 {
>  	bootph-pre-ram;
>  };
> -
> -&ethphy0 {
> -	reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> -	reset-delay-us = <15000>;
> -	reset-post-delay-us = <100000>;
> -};
> -
> -&fec {
> -	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
> -	phy-reset-duration = <15>;
> -	phy-reset-post-delay = <100>;
> -};
> -
> -
> diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
> index a24b8c1d8608..42291c958e39 100644
> --- a/board/freescale/imx8mp_evk/imx8mp_evk.c
> +++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
> @@ -7,8 +7,6 @@
>  #include <env.h>
>  #include <errno.h>
>  #include <init.h>
> -#include <miiphy.h>
> -#include <netdev.h>
>  #include <linux/delay.h>
>  #include <asm/global_data.h>
>  #include <asm/mach-imx/iomux-v3.h>
> @@ -20,33 +18,9 @@
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
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
> 
