Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44587C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 00:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9444D876C7;
	Tue, 12 Dec 2023 01:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WpW7pHrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3269B876C7; Tue, 12 Dec 2023 01:18:56 +0100 (CET)
Received: from mail-m12828.netease.com (mail-m12828.netease.com
 [103.209.128.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB07887652
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 01:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WpW7pHrTMqJvw+IpsJy3zg1ovHmV5HSJ9F5TrmJZ2nz01Y7ln3ixpNDkI+wG6K1vNkBE9BrcIYBQM/9W/E68ShiI3tSDYHy2pwP5F99EkVDpT3zkoolMZE84HbIkdMszqUeDeXN1eFYbpN7jwLRXr8UIJ5Z3oiztKoCGdgE4yTg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=WEsE3E9USvSzdWNe2vCztcjawHrtDszIK376ldyGl9M=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 036F3400189;
 Tue, 12 Dec 2023 08:18:42 +0800 (CST)
Message-ID: <42239d46-1355-48a3-b5fe-406a45d8556f@rock-chips.com>
Date: Tue, 12 Dec 2023 08:18:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 jagan@amarulasolutions.com, akash@openedev.com
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231113112309.730323-1-i@shantur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5IGlYYGEkZGE5OSEoZSUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8c5b63e7582eb3kusn036f3400189
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06Azo4OjwwQjoBNwkSDg8j
 NDRPFDlVSlVKTEtJSE9LSElITUNCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISENNNwY+
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


On 2023/11/13 19:23, Shantur Rathore wrote:
> Add smbios information for Pine64 RockPro64 board and enable in
> config
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   Changes
>   v4: Change PINE64 to Pine64
>   v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
>
>   arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 ++++++++++++++++++++++
>   configs/rockpro64-rk3399_defconfig        |  2 ++
>   2 files changed, 24 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> index 732727d9b0..089732524a 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -9,6 +9,28 @@
>   	chosen {
>   		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
>   	};
> +
> +        smbios {
> +                compatible = "u-boot,sysinfo-smbios";
> +                smbios {
> +                        system {
> +                                manufacturer = "Pine64";
> +                                product = "RockPro64";
> +                        };
> +
> +                        baseboard {
> +                                manufacturer = "Pine64";
> +                                product = "RockPro64";
> +                        };
> +
> +                        chassis {
> +                                manufacturer = "Pine64";
> +                                product = "RockPro64";
> +                        };
> +                };
> +        };
> +
> +
>   };
>   
>   &sdhci {
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 4cd6b76665..affb6137e0 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -90,6 +90,8 @@ CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
