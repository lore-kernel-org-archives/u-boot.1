Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE86C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 20:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1B580BAE;
	Mon, 17 Feb 2025 21:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="T/x3f22b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD7380F0B; Mon, 17 Feb 2025 21:58:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B058083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 21:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739825928;
 bh=hnRazCBmZnpW3GDvBFrj+xG+i7Hvrhp3Sm+kvzf8sNM=;
 b=T/x3f22b26tKShK1AZwLoxqwRHNqb+HsK/edMqRwI01HiY9ag5KTHTp+itAeL/cVROsUc/W6M
 y7IRgHV4q3hrW1NMEP+5vm8MWvMvvfcCMerm1Aicsh9F62ZZ9qUdT4RXEVVpw4HWSFe+xXrf2wY
 sfZyKsevXNufR2HhVbqJrpdESPx9aoKsIPwPpKHernUAO0gb38xmdjV2+tg2E/fwVg1orJV0AI7
 LPVCdKB5Qi9WJBM/TtfpmVjwyo6ZiDD6r3nmb/RWUjKX8Z3tS7jAsb8Scasp+8msfHe70ThbmJ3
 y7Jj25pz5jI1CpN70MXzU+a2nrLEcQ12lNDplg9h147w==
X-Forward-Email-ID: 67b3a305179e723bb8e57505
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1632d340-e117-41c1-a73b-beff118a1c28@kwiboo.se>
Date: Mon, 17 Feb 2025 21:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/35] rockchip: Provide a bootstd configuration
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-17-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-17-sjg@chromium.org>
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

Hi Simon,

On 2025-02-09 22:14, Simon Glass wrote:
> Add bootstd information for VBE. Put it in a separate file to avoid
> cluttering the main one.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Move VPL things into a separate file
> 
>  arch/arm/dts/rockchip-u-boot.dtsi     |  4 ++++
>  arch/arm/dts/rockchip-vpl-u-boot.dtsi | 31 +++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c899e8e6005..10563e273a9 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -224,3 +224,7 @@
>  #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
>  };
>  #endif /* CONFIG_SPL */
> +
> +#ifdef CONFIG_VPL
> +#include "rockchip-vpl-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> new file mode 100644
> index 00000000000..26b77e67c80
> --- /dev/null
> +++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +/ {
> +	bootstd {
> +		bootph-verify;
> +		compatible = "u-boot,boot-std";
> +
> +		/*
> +		 * This is used for the VBE OS-request tests. A FAT filesystem
> +		 * created in a partition with the VBE information appearing
> +		 * before the partition starts.
> +		 *
> +		 * Offsets are aligned to the media block-size, typically 0x200
> +		 */
> +		firmware0 {
> +			bootph-verify;
> +			compatible = "fwupd,vbe-abrec";
> +			storage = "mmc0";

This is probably board specific and can mean either emmc or sd-card in
Linux depending on the DT for the board. U-Boot will for most Rockchip
SoCs always treat mmc0 as emmc and mmc1 as sd-card thanks to override
in <soc>-u-boot.dtsi and/or driver code.

> +			skip-offset = <0x8000>;
> +			area-start = <CONFIG_SPL_PAD_TO>;

SPL_PAD_TO is defined as "Image offset to which the SPL should be padded
before appending the SPL payload." so should probably not be used to
declare offset in storage.

> +			area-size = <0x800000>;
> +			state-offset = <(CONFIG_SPL_PAD_TO - 0x400)>;
> +			state-size = <0x40>;
> +			version-offset = <(CONFIG_SPL_PAD_TO - 0x200)>;
> +			version-size = <0x100>;

All these offsets and sizes seem a bit arbitrary without any context.
Please add more details about the layout used in a comment and/or commit
message.

Regards,
Jonas

> +		};
> +	};
> +};

