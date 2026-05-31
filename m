Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131E8CD6E55
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 22:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785478405A;
	Mon,  1 Jun 2026 00:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iqq9Zx6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AD6840ED; Mon,  1 Jun 2026 00:17:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E4C839DF
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 00:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cd95=D5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780265867;
 bh=c99kIv1KakvMgdzDG7mbfzphN/ZTBMRmJlUU1O4KQNk=;
 b=iqq9Zx6Is1sS/9xrH/GpWiGwPJeRBTCl8n7EBoDNSvm/o2PtNZovu9esMmarOoLr6NO5+N7Qp
 0k9FW7Qd+JKZ+rFkQ4wjvS75zn2+T50U4L2zvVvyAySyKw57dVASzJBKOL600hDO/Q/B6sNCNWX
 lx8QZkqvPstztOFg0gJVbi9j8NINC6UxoqwaWlgkYVY8UiLw7s56A0D8TJb2BGO/RArqmBOeLD0
 UoaDj5hfiRp2h6CNf9NZ9tQNWd+GDNsJhorWatqHdm4XiOb0U8DoGa0diw1ovuiTo5sNBTmg8fQ
 3VrPb2VVvaADN28tu3K246K+8LpnniPnpYJgWq/07rbA==
X-Forward-Email-ID: 6a1cb389ebb34a99f106937d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8df77ddc-1b1d-4f70-88d9-da109feabf1f@kwiboo.se>
Date: Mon, 1 Jun 2026 00:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] usb: make dwc2_usb available in SPL
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, hl@rock-chips.com, jernej.skrabec@gmail.com,
 w.egorov@phytec.de, jagan@amarulasolutions.com, heiko@sntech.de,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
 <21cfdd2a-7811-4450-8b1d-d51145b3a0b0@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <21cfdd2a-7811-4450-8b1d-d51145b3a0b0@gmail.com>
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
> Make the dwc2_usb driver available in SPL to load U-boot (full)
> from a USB disk.

This seem to make it possible to disable inclusion of USB_DWC2 in SPL,
not make it available. It already looks to be available in SPL?

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/Makefile            |  3 ++-
>  drivers/usb/common/Makefile |  2 +-
>  drivers/usb/host/Kconfig    | 11 +++++++++++
>  drivers/usb/host/Makefile   |  2 +-
>  4 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba332818..87f755d8a35b 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -68,8 +68,9 @@ obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
>  obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
>  obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
>  obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
> -obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
> +obj-$(CONFIG_SPL_USB_HOST) += usb/common/
>  obj-$(CONFIG_SPL_USB_HOST) += usb/host/
> +obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
>  obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>  obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>  obj-$(CONFIG_SPL_THERMAL) += thermal/
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index db8f35c10c4f..5350cd668d03 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -4,7 +4,7 @@
>  #
> 
>  obj-$(CONFIG_$(PHASE_)DM_USB) += common.o
> -obj-$(CONFIG_USB_DWC2) += dwc2_core.o
> +obj-$(CONFIG_$(PHASE_)USB_DWC2) += dwc2_core.o
>  obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
>  obj-$(CONFIG_USB_ISP1760) += usb_urb.o
>  obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index d75883e28650..4fbca2886096 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -417,6 +417,17 @@ config USB_DWC2
>  	  operation is compliant to the controller Supplement. If you want to
>  	  enable this controller in host mode, say Y.
> 
> +config SPL_USB_DWC2
> +	bool "DesignWare USB2 Core support in SPL"
> +	depends on SPL_DM && SPL_OF_CONTROL

This should likely be default USB_DWC2 to not break any existing
platform/device already using this in SPL.

> +	select SPL_USB_HOST
> +	---help---

Please use plain help keyword, use of --help-- is deprecated.

Regards,
Jonas

> +	  The DesignWare USB 2.0 controller is compliant with the
> +	  USB-Implementers Forum (USB-IF) USB 2.0 specifications.
> +	  Hi-Speed (480 Mbps), Full-Speed (12 Mbps), and Low-Speed (1.5 Mbps)
> +	  operation is compliant to the controller Supplement. If you want to
> +	  enable this controller in host mode, say Y.
> +
>  if USB_DWC2
>  config USB_DWC2_BUFFER_SIZE
>  	int "Data buffer size in kB"
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index ef4ce62a680c..ec99d0b3882a 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -57,4 +57,4 @@ obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
>  obj-$(CONFIG_USB_XHCI_OCTEON) += dwc3-octeon-glue.o
> 
>  # designware
> -obj-$(CONFIG_USB_DWC2) += dwc2.o
> +obj-$(CONFIG_$(PHASE_)USB_DWC2) += dwc2.o
> --
> 2.39.5
> 

