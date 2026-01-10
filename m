Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42561D232FF
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 19:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABC183B72;
	Sat, 10 Jan 2026 20:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Hxg+brja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D4283B99; Sat, 10 Jan 2026 20:13:52 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 542A683B4E
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 20:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7dc0aab4-ee58-11f0-89d8-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7dc0aab4-ee58-11f0-89d8-00505699b430;
 Sat, 10 Jan 2026 20:13:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=FmNUNchhXYD2+HGqqF9G7SmeOdg9hoimFKhVXz1TY0c=;
 b=Hxg+brja1Yq1AotGMcJpsutRE3IJiAW1AvbAHVVrfZnHDg054U+JDakbduNFwXyW3xKlf6v0obOkT
 L4JvVOy1TqiKV27boiEx04hjM9HiZ6iUX5S2QkmqUO1eAxBtclRpUU2n5nhtz8xEXtDhBV3x2jHaaK
 p3OUy8XqLPxqmmw3W3ycf/eNYbX9QSfFrTo8ylJ2Jhj6RhSyGwKcTASne35BvraT70eGAY8HKSmuSp
 kqd9Y2TtJQ+NSRm3zatNvAgDfNpzS17T4Sw49Y4Ni06naohLaj3sk0aJzQOso2OjfiPP14K4fLlQFW
 fd/fBy8ZyGEXue7euKlPAguwNRKVr9w==
X-KPN-MID: 33|0wgyXI7qLuaXMgedYKB6L2q5i5jrAI6DXbreMhXV2EOGQOxotndPOSwmXPYn4fD
 q+Drw/KNN90oPmHwQVLbLuB65iN6tskP7AWg+9EN0hwY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|UMkPAj4XxmK3uM9kKexgYdRbUSYEHWMRoVn2kRXu9wwft0chV616W058oCJ1jlP
 HnBUov/2rXYT1L5JpoHQmbw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7deda2c6-ee58-11f0-bff6-00505699772e;
 Sat, 10 Jan 2026 20:13:49 +0100 (CET)
Date: Sat, 10 Jan 2026 20:13:48 +0100
Message-Id: <87y0m58emr.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org, trini@konsulko.com,
 asahi@lists.linux.dev, j@jannau.net
In-Reply-To: <20260109-apple-defconfig-smbios-v1-1-16477009c034@jannau.net>
 (message from Janne Grunau on Fri, 09 Jan 2026 18:20:30 +0100)
Subject: Re: [PATCH] configs: apple: Enable SMBIOS / sysinfo
References: <20260109-apple-defconfig-smbios-v1-1-16477009c034@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Fri, 09 Jan 2026 18:20:30 +0100
> 
> Enable verbose SMBIOS table generation so that user space applications
> can use the SMBIOS table to provide details about the system. The
> desired information is chassis-type to determine whether the system is
> laptop.
> Adding the chassis-type property is proposed for the upstream device
> trees in the Linux kernel in [1].

Given that we have no real space constraint, should we add
CONFIG_CMD_SMBIOS=y as well?

> Link: https://lore.kernel.org/asahi/20260109-apple-dt-usb-c-atc-dwc3-v1-0-ce0e92c1a016@jannau.net/ [1]
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> I do not plan to update u-boot's in-tree device trees. The Linux device
> trees have almost reached feature parity. The main missing features are
> the USB Type-C ports (on track for next merge window) and the laptop
> keyboards. I think it makes more sense to close the feature gap and
> switch to upstream device trees instead of adding to the in-tree device
> trees.
> ---
>  configs/apple_m1_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index 2d685da8c9eee2084b0144050e12c03c77e5184e..52672f59566dc0ebbb1c829cff6c7d8f798e7c50 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -16,6 +16,8 @@ CONFIG_SYS_64BIT_LBA=y
>  CONFIG_APPLE_SPI_KEYB=y
>  # CONFIG_MMC is not set
>  CONFIG_NVME_APPLE=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_XHCI_PCI=y
> @@ -25,4 +27,4 @@ CONFIG_VIDEO_FONT_16X32=y
>  CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_NO_FB_CLEAR=y
>  CONFIG_VIDEO_SIMPLE=y
> -# CONFIG_SMBIOS is not set
> +CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
> 
> ---
> base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
> change-id: 20260109-apple-defconfig-smbios-a37802021452
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
