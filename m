Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F5606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1JzgDPxx;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=OdeU2eSl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 017A660ABC;
	Thu, 26 Nov 2026 18:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UsLow_OeYb5x; Thu, 26 Nov 2026 18:43:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0BFC1608B1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795718637;
	b=JmjiXDQm/0jFXQ301czm1J5ZKevea3m/8cZcJyFKdVznVlp4tJUB40dLZ2Q9cZNo+dz1
	 M0/OPaET+w+/zkkzxeQu9sW5BsPEFPRh+8FJYYLteimedt7zfuSSjxu5qPxwM4JlOBV+e
	 rcAYPkSStJR630ptzMrP556B6d6Nf3baYKh5jZ5Nf1BuV+XHsalNlqVyvB3qgTNmNIhaT
	 4MXo82D6krLJBd3cYfGhB56h+LPfYPnerXeGOrrDuLZw9YQkhdLGtiPMo3Phk+PkmTarJ
	 M3Z5TXOox7+WL+D+Mdt0ZNVW/hRKgRK2+McYgcItxhsfSL1U92InGGRk5tG/YNq63lA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795718637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WTmsgQEJ+JFAGs9Rn0vEO7hng/J4Xv4d2mJL14gYHQI=;
	b=D7Y2xCw7cWeE2di9pJxaXq2t2k5ffNwE3Fzz4A2TEfWuAiaxmYhmpQ/+Os4Pczw1Dy8P
	 +tNGF4njWcef+2tMGxBmgGRr392xQsNR3MLykTDh5GS4EyeEcGxap8VNLQtaRY7QyuqO+
	 8EvMPcWstAnR4O8JroKBypfiNiWyEBtf/e8A6hmBkAHFnk2szWOy2pj+cPiK8NxJt4nrU
	 vQgEpvnoCRZynl3D0C1AT+ngwRTO9gJ9pZYasadn7GNPX0z0eahKrX2kVfSvn2IdMd7rO
	 NQ0/X9ZAieTcVxNRQDBrftWRszXjC79WU2jV2WIW3uhXlZBLd43JsmOQk40JPDao6dQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795718637;
	bh=WTmsgQEJ+JFAGs9Rn0vEO7hng/J4Xv4d2mJL14gYHQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1JzgDPxxif6AJr2vPqrJ5esgtOKqkEzaxCA8+hTqjqj+0LcQAslxk4DCRUf28UEjT
	 4lUjuHsniV0//mg6EWfsr3icnVF2h5H6pdx4/ReDjFzMlzIbV2HMRXJoKuqZoKrJ0e
	 vbJbFVlmwS8m9qANxtwEb5gbmF8Vl/lGyxJDs339Lo/14GQIZ5RaENs56CfwAx7jqQ
	 ZSs3FXmP6tVBQ4SfbVhs8E8OgZOigU5V9ZlFybQdIBcVr04gEMX4gKFFGqOsfMTgD6
	 TW7DCcsIwGp93/jYyl/CWD3fZe/ak2MZyqtj4jg0hKHiQQYCICEajJdS8Recli2SZc
	 I0ftvZ7lRUZoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BFC1608B1;
	Thu, 26 Nov 2026 18:43:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D9EE22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F39781175
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glGUO5idb8M1 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 18:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 24DD28116C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::42a9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::42a9; helo=smtp-42a9.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=OdeU2eSl
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::42a9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24DD28116C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:43:53 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000 (Postfix) with ESMTPS id 4jb56Z6P68zwbg;
 Thu, 26 Nov 2026 19:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795718630;
 bh=WTmsgQEJ+JFAGs9Rn0vEO7hng/J4Xv4d2mJL14gYHQI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OdeU2eSl58koL4Da2aptokxn0i7MA3b/ev1tIccay+JvwQnSqcRf63aizVidySdmQ
 dOUEeF2TuGECG7Bmbb6qei07lyaFYaZd7F3KbnkD9s6BvaxrxpR2vgO1rnUTR5swap
 gQLQcHBtigww/PmkHOOxKd2PZUcPBlch7KQ7JSsA3ePIEZogAV9ao0zSzcyOm83QIA
 DQIGFWyp+xd5Jnx4SH4QzBdYRHmpiqXePEJYyMOrUYAysQ0Gh6zcMqFfJsjB5e8HVf
 YvEsnv7Icx6JfpLOahYKBS+1sMgrYXcmsExHNuaBj8CddKolXnZan1Sv3e+sdlvlLY
 z6APzW8M74LOw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jb56Y08CMz96S; Thu, 26 Nov 2026 19:43:48 +0100 (CET)
Message-ID: <855edbbc-31e9-4402-a3d3-12a7bf236ef7@0leil.net>
Date: Thu, 26 Nov 2026 19:43:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm: mach-k3: Set /chosen/bootsource for the next
 boot stage
To: Wadim Egorov <w.egorov@phytec.de>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, quentin.schulz@cherry.de
Cc: kever.yang@rock-chips.com, anshuld@ti.com, aristo.chen@canonical.com,
 alchark@flipper.net, u-boot@lists.u-boot-project.org,
 upstream@lists.phytec.de
References: <20261117135124.207113-1-w.egorov@phytec.de>
 <20261117135124.207113-3-w.egorov@phytec.de>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261117135124.207113-3-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

You seem to be the custodian for the two files changed here, can you 
please give this a review?

I'm fine picking up patches 1 and 3 independently, and patch 2 lives its 
own life (possibly with more versions) or wait for your review for patch 
2 and take everything at once, up to you.

Thanks!
Quentin

On 11/17/26 2:51 PM, Wadim Egorov wrote:
> Call fdt_fixup_bootsource() from spl_perform_arch_fixups() so the next
> boot stage knows the device the ROM booted from.
> 
> Implement bootsource_get_ofpath() for AM62x by mapping the boot device
> from get_boot_device() to its device tree node. For OSPI boot the path
> points to the flash chip and not the controller, since the flash node
> is what the OS maps to an MTD device. All AM62 boards name it flash@0.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>   arch/arm/mach-k3/am62x/boot.c | 26 ++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.c     |  1 +
>   2 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
> index a3a6cda6bdb..db07a550caf 100644
> --- a/arch/arm/mach-k3/am62x/boot.c
> +++ b/arch/arm/mach-k3/am62x/boot.c
> @@ -2,6 +2,7 @@
>   #include <asm/io.h>
>   #include <asm/arch/hardware.h>
>   #include <asm/arch/am62_spl.h>
> +#include <fdt_support.h>
>   
>   static u32 __get_backup_bootmedia(u32 devstat)
>   {
> @@ -102,6 +103,31 @@ u32 get_boot_device(void)
>   	return bootmedia;
>   }
>   
> +const char *bootsource_get_ofpath(void)
> +{
> +	switch (get_boot_device()) {
> +	case BOOT_DEVICE_MMC1:
> +		return "/bus@f0000/mmc@fa10000";
> +	case BOOT_DEVICE_MMC2:
> +		return "/bus@f0000/mmc@fa00000";
> +	case BOOT_DEVICE_SPI:
> +		/*
> +		 * The flash chip is described by the board device tree. All
> +		 * AM62 boards name it flash@0.
> +		 */
> +		return "/bus@f0000/bus@fc00000/spi@fc40000/flash@0";
> +	case BOOT_DEVICE_ETHERNET:
> +		return "/bus@f0000/ethernet@8000000/ethernet-ports/port@1";
> +	case BOOT_DEVICE_UART:
> +		return "/bus@f0000/serial@2800000";
> +	case BOOT_DEVICE_USB:
> +	case BOOT_DEVICE_DFU:
> +		return "/bus@f0000/dwc3-usb@f900000/usb@31000000";
> +	}
> +
> +	return NULL;
> +}
> +
>   const char *get_reset_reason(void)
>   {
>   	u32 reset_reason = readl(CTRLMMR_MCU_RST_SRC);
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 6e382efdb3b..c7fd7b4f44c 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -570,6 +570,7 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
>   		return;
>   
>   	fdt_fixup_reserved(fdt);
> +	fdt_fixup_bootsource(fdt);
>   
>   	if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
>   		k3_falcon_fdt_fixup(fdt);

