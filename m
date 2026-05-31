Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2BACD6E55
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 22:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0408039B;
	Mon,  1 Jun 2026 00:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Dk8vZoiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3122E838D7; Mon,  1 Jun 2026 00:12:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BF180077
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 00:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cd95=D5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780265546;
 bh=QfnWcLlHeMIrHDyxNFlqJ2RxtUM46XFSP1MURh6vPsQ=;
 b=Dk8vZoiXmMX02e3mBYZF4GSNTuVISiwzkzi9tlWoUAZEnJ06HwFiEDMQ6uOLGsgvx6JPs5J7G
 wze5DOQljxkJVbhmfK93TCDd4LGo1DarLhOsbnVkmhHcyN0imX8PvG3XAzfPH8HT0v0Gkhr3RBZ
 ntXlbFyvUSZj+xJHMa5VhLg96PN4DuTHjjRJKwbS4kW/tiJnKc5OI1Z+T+JmJVIBKVcCHFKgr2s
 b3dzToDMRDu7+12XnwnBEVvgul+1wtROmLi/mh57glSDOvLHfMyECjjWtmkV1zNGe9Y/h9tOqS3
 +V6pv95j1HdBZ+ubBQUySOz2ClVQsjeuTmyL5a+Y0/6g==
X-Forward-Email-ID: 6a1cb248611a3f33823c8cb5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1c8a2d09-6db7-421d-8175-5c3b49cf4949@kwiboo.se>
Date: Mon, 1 Jun 2026 00:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] rockchip: phy: make phy-rockchip-usb2 available
 in SPL
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, hl@rock-chips.com, jernej.skrabec@gmail.com,
 w.egorov@phytec.de, jagan@amarulasolutions.com, heiko@sntech.de,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
 <54982f90-0cea-498e-bafa-fe2bf3a43dda@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <54982f90-0cea-498e-bafa-fe2bf3a43dda@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Johan,

On 5/31/2026 11:03 PM, Johan Jonker wrote:
> Make phy-rockchip-usb2 available as phy for dwc2 USB
> in SPL to load U-boot (full) from a USB disk.

This patch can be merged with the addition of the new phy driver, why
the need to keep it separate?

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/phy/rockchip/Kconfig  | 10 ++++++++++
>  drivers/phy/rockchip/Makefile |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 745e0ea67b8d..754b178a0bbb 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -60,6 +60,16 @@ config PHY_ROCKCHIP_USB2
>  	bool "Rockchip USB2 PHY"
>  	depends on ARCH_ROCKCHIP
>  	select PHY
> +	select RESET_ROCKCHIP

The code in driver did not seem to depend on the reset feature, so we
should likely not need to select the RESET_ROCKCHIP driver here,
if you think it is needed, please only imply and try the driver compiles
with RESET_ROCKCHIP=n.

Regards,
Jonas

> +	help
> +	  Support for Rockchip USB 2.0 PHY.
> +
> +config SPL_PHY_ROCKCHIP_USB2
> +	bool "Rockchip USB2 PHY in SPL"
> +	depends on ARCH_ROCKCHIP && SPL
> +	default n
> +	select SPL_PHY
> +	select SPL_RESET_ROCKCHIP
>  	help
>  	  Support for Rockchip USB 2.0 PHY.
> 
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index f296dc8f3d2a..c5577dfe86e8 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -10,5 +10,5 @@ obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY) += phy-rockchip-naneng-combphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
>  obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
> -obj-$(CONFIG_PHY_ROCKCHIP_USB2)		+= phy-rockchip-usb2.o
> +obj-$(CONFIG_$(PHASE_)PHY_ROCKCHIP_USB2)	+= phy-rockchip-usb2.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o
> --
> 2.39.5
> 

