Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F11C2A07E
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 09:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3524783AB7;
	Mon,  5 Jan 2026 10:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qpND0Ndz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB1283CE3; Mon,  5 Jan 2026 10:41:03 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DFD83A9F
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BBFD60128;
 Mon,  5 Jan 2026 09:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F246C116D0;
 Mon,  5 Jan 2026 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767606054;
 bh=UXs6QSKq5jSPYh3aeasDd+zYn+jBXHuoRYeIcquiusA=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=qpND0Ndzg2aXNdim0Yccm5WB5t+PzRH69yGZRMoMqsj5DTSUW4Pt9e5E7wl9onrge
 869wskYOVR/fA/YfCz13L6BmTSFNQD2wkVNhBPpRZUobYHmaKXMdOzLFoF+mClAyXU
 TqlCt6qUkQB1/rPHZByxK1caYuZUr+Vduw06UM4Gxrfa2q/8W0kbMDsI5595QQ3HNh
 xjPhUDKcPL17ZeFXwHVHblXqwXUZ6gN0krmgyvb/9h0TdiMgAdJ8b3EMsUT0RJSPYy
 dEX7Pwy/Bh88B0hzjNnQ5qwbO+1k3po88LXnJb+id6sXdbcODyzQATGdTT1uuc43b0
 v4U5VvuK80GyQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, lukma@denx.de,
 mkorpershoek@kernel.org, marex@denx.de, trini@konsulko.com,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 gchan9527@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH v2] usb: gadget: Kconfig: Correct Qualcomm config name used
In-Reply-To: <20251224044747.3898137-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251224044747.3898137-1-balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 10:40:52 +0100
Message-ID: <87wm1wflcr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Balaji,

Thank you for the patch.

On Wed, Dec 24, 2025 at 10:17, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> Correct ARCH_QCOM to ARCH_SNAPDRAGON as ARCH_QCOM is outdated/unused
> config. Using ARCH_QCOM was causing USB fastboot mode to fail.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Casey, this is assigned to you on patchwork. Feel free to pick it up.

If you want me to take it instead, please assign to me on patchwork!

Mattijs

> ---
> v2:
> - Corrected ARCH_QCOM to ARCH_SNAPDRAGON
> - Link to v1: https://lore.kernel.org/u-boot/20251114063507.3834973-1-balaji.selvanathan@oss.qualcomm.com/
> ---
>  drivers/usb/gadget/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
