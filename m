Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A278FE8FDA5
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 07:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C3084285;
	Fri, 26 Dec 2025 08:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sv3XEpP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277B384286; Fri, 26 Dec 2025 08:40:34 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D557D83B95
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 08:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 377664053A;
 Fri, 26 Dec 2025 07:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9F8C4CEF7;
 Fri, 26 Dec 2025 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766734830;
 bh=7lREY8Ba7C9WvIyxc6t0cg1vf2euoQXFQ4IvUXcdtM8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sv3XEpP/xXFQXvo6I6vSWwRl8fiV1ym/3lalyPP6Qng3uqFJ9mGI+T4kuFGR4ve+W
 PMRH+F1jEOv8YD7BiYw3/vEzasmn/cOLzXIjO1G4KJhLRaPXX3i0TLjr72fqZQ3zP2
 +jL9Fd864JRN6s68ntnzwXIloo6MXuYB9JUeDBqG6ZLOqD7CixQZEl/YLDNrTV70BR
 KepT6Hkd8Cw3Sx+Rddj0OdPvPGvhV33QUkgSGEFY2R7xtBB3UtaiDZQxUS8dtqrmq4
 zsQFgGvsJ+86gE0MlGDGYL7JldarnQ2M+N6r/8UsjNrH2gQS/HmNKwgqzx7DVSB10D
 JMaexus2MzBUg==
Date: Fri, 26 Dec 2025 13:10:19 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: lukma@denx.de, mkorpershoek@kernel.org, marex@denx.de,
 trini@konsulko.com, kever.yang@rock-chips.com, jonas@kwiboo.se,
 quentin.schulz@cherry.de, gchan9527@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: gadget: Kconfig: Correct Qualcomm config name used
Message-ID: <aU474_9eCyOfuYcj@sumit-xelite>
References: <20251224044747.3898137-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224044747.3898137-1-balaji.selvanathan@oss.qualcomm.com>
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

On Wed, Dec 24, 2025 at 10:17:47AM +0530, Balaji Selvanathan wrote:
> Correct ARCH_QCOM to ARCH_SNAPDRAGON as ARCH_QCOM is outdated/unused
> config. Using ARCH_QCOM was causing USB fastboot mode to fail.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v2:
> - Corrected ARCH_QCOM to ARCH_SNAPDRAGON
> - Link to v1: https://lore.kernel.org/u-boot/20251114063507.3834973-1-balaji.selvanathan@oss.qualcomm.com/
> ---
>  drivers/usb/gadget/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 7e08aeab904..ebb306852a6 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -61,7 +61,7 @@ config USB_GADGET_VENDOR_NUM
>  	default 0x0955 if ARCH_TEGRA
>  	default 0x1f3a if ARCH_SUNXI
>  	default 0x2207 if ARCH_ROCKCHIP
> -	default 0x18d1 if ARCH_QCOM
> +	default 0x18d1 if ARCH_SNAPDRAGON
>  	default 0x0
>  	help
>  	  Vendor ID of the USB device emulated, reported to the host device.
> @@ -89,7 +89,7 @@ config USB_GADGET_PRODUCT_NUM
>  	default 0x350b if ROCKCHIP_RK3588
>  	default 0x350c if ROCKCHIP_RK3528
>  	default 0x350e if ROCKCHIP_RK3576
> -	default 0x4ee0 if ARCH_QCOM
> +	default 0x4ee0 if ARCH_SNAPDRAGON
>  	default 0x0
>  	help
>  	  Product ID of the USB device emulated, reported to the host device.
> -- 
> 2.34.1
> 
