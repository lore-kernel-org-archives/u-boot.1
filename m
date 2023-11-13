Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F78C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 12:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF5E870C4;
	Mon, 13 Nov 2023 13:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Qptlyon3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E72C86F80; Mon, 13 Nov 2023 11:16:53 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FD086B2E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 11:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1699870610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jq7UYih02uSba10wG/55DMvW8AMjQC48mww/MIR6Ftc=;
 b=Qptlyon3YFA5RvNDoQBOlOYK4J1hfva814XcPkZ0oiC/KPDFVMazFq9EnAUKZ/BcXepY3R
 G5nhYvAEGgTnnUJinDXNb4yUKRrVt7BHgCYTW2DRqSJfPzgqr11Xsde5sw/k+zDS7vZ0lq
 Zw41FRygheB4cDkiYHiXikpGYliYfbsy6a4X7yl9zHKAQueMWAI7mD+i90hykfeda3qPvo
 BPEuYNs5CzjWIdW3xIKctFhUssQPHFYuEGN5rObYx/mJl4Ltp0gtXoOAf+s3xp253Shb8K
 0K7D9R2pd81VwiPe5vs49kozIhbQpgarFcCrZy14ptIUEFtK+Kfr9dXGN080lw==
Date: Mon, 13 Nov 2023 11:16:50 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, trini@konsulko.com, agan@amarulasolutions.com
Subject: Re: [PATCH v3] arm: dts: rockpro64: Add RockPro64 smbios
In-Reply-To: <20231113100128.710860-1-i@shantur.com>
References: <20231110235806.525529-1-i@shantur.com>
 <20231113100128.710860-1-i@shantur.com>
Message-ID: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Mailman-Approved-At: Mon, 13 Nov 2023 13:26:24 +0100
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

On 2023-11-13 11:01, Shantur Rathore wrote:
> Add smbios information for Pine64 RockPro64 board and enable in
> config
> 
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  Changes v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
> 
>  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 ++++++++++++++++++++++
>  configs/rockpro64-rk3399_defconfig        |  2 ++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> index 732727d9b0..a4453e76f6 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -9,6 +9,28 @@
>  	chosen {
>  		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
>  	};
> +
> +        smbios {
> +                compatible = "u-boot,sysinfo-smbios";
> +                smbios {
> +                        system {
> +                                manufacturer = "PINE64";
> +                                product = "RockPro64";
> +                        };
> +
> +                        baseboard {
> +                                manufacturer = "PINE64";
> +                                product = "RockPro64";
> +                        };
> +
> +                        chassis {
> +                                manufacturer = "PINE64";
> +                                product = "RockPro64";
> +                        };
> +                };
> +        };
> +
> +
>  };

Perhaps it would be better to use "Pine64" instead of "PINE64", because 
"Pine64" is already used in multiple places. Also, it might be better to 
use "ROCKPro64" instead of "RockPro64", because that's actually the 
official name of the board, but I'm also perfectly fine with 
"RockPro64".

>  &sdhci {
> diff --git a/configs/rockpro64-rk3399_defconfig
> b/configs/rockpro64-rk3399_defconfig
> index 4cd6b76665..affb6137e0 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -90,6 +90,8 @@ CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
