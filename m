Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3FAC197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 15:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BCCF8721C;
	Mon, 20 Nov 2023 16:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="DsjTK4cO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497BC87575; Mon, 20 Nov 2023 16:04:25 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F4687552
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 16:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 14ac0dfa-87b6-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 14ac0dfa-87b6-11ee-91e7-005056994fde;
 Mon, 20 Nov 2023 16:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=Uy4R0P7PsZxtrcPMiFXYcGU5SjGjyrdIFbr1IIkguAs=;
 b=DsjTK4cOKUTGJ3+m4XRmNnTqixXvv7NdvzF1qP64P4IMXFKWx3aH+EHnB6x8vHdmcC/UVkjJ+70w3
 WVmj4VtoKzMD1cPS3feTWdsZTt4CqPhbRGhZR/CHaOjjd+VY/f+JOV/J62b1xxy7GpcBYr2BGdROxW
 5FLWtr+Mpu3l/HXAzUCOxAXIzSr/OiSYNNK22v2i6rXq2ppF66jsktguGMwuosc2lhmEj7d0Yj5II7
 RwXm5j/uELHhymnYqL8eG7fH2xpBuzKqBGVvJm4dBh/qkhE958JuHFDCZHbSm4O6lf1/SDdaOpys3T
 WVOweGsjCSU0GbBGSOVyhryB9GPFKbg==
X-KPN-MID: 33|/aZ8Q7W/Iw4gwKRvzndO3f1yQIIxcVlXbXJb2c9MfqYxlIFOW5JJ0yLZ+wsIQKp
 7FrKb1eYfxyWhODYgNVlWdtycugov7UsQosEz+cd1Qg0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|bm9KxZqsWpuvWSKe65+vP/9spqYYYiiBe9xho5kCMm0pLUqubWKuSm7GB709w3W
 uxrOEH8LAOgfb6a1Ceq/BAg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 160e57a4-87b6-11ee-ad2d-005056998788;
 Mon, 20 Nov 2023 16:04:22 +0100 (CET)
Date: Mon, 20 Nov 2023 16:04:21 +0100
Message-Id: <8734x0tqiy.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: marex@denx.de, clamor95@gmail.com, michal.simek@amd.com,
 angelo@kernel-space.org, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
In-Reply-To: <20231120145636.110466-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Mon, 20 Nov 2023 15:56:36 +0100)
Subject: Re: [PATCH 1/1] usb: USB_XHCI_PCI depends on PCI
References: <20231120145636.110466-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Mon, 20 Nov 2023 15:56:36 +0100
> 
> Compiling with CONFIG_USB_XHCI_PCI and CONFIG_PCI=n results in
> 
>     usb/host/xhci-pci.c:48:(.text.xhci_pci_probe+0x44):
>     undefined reference to `dm_pci_write_config32
> 
> Add the missing Kconfig dependency.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/usb/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index b501ea514b..35610ffc2b 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -90,7 +90,7 @@ config USB_XHCI_OMAP
>  
>  config USB_XHCI_PCI
>  	bool "Support for PCI-based xHCI USB controller"
> -	depends on DM_USB
> +	depends on DM_USB && PCI
>  	default y if X86
>  	help
>  	  Enables support for the PCI-based xHCI controller.
> -- 
> 2.40.1
> 
> 
