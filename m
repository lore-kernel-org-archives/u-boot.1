Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EE0C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B846F82E76;
	Tue,  8 Apr 2025 02:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gNdMd7Lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2410F82E76; Tue,  8 Apr 2025 02:52:29 +0200 (CEST)
Received: from mail-m2499.xmail.ntesmail.com (mail-m2499.xmail.ntesmail.com
 [45.195.24.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF58582F6A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd8a57;
 Tue, 8 Apr 2025 08:52:20 +0800 (GMT+08:00)
Message-ID: <df3cc6c7-b553-4640-9f5f-963a1ee11008@rock-chips.com>
Date: Tue, 8 Apr 2025 08:52:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rockchip: avoid rebuilding most binaries for
 u-boot-rockchip-spi.bin
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-0-d1768ee87808@cherry.de>
 <20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEhPVhpNT0gZGEhJTUlPQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e2447203afkunm10fbd8a57
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgw6TSo4HzJDOUMOLgI5CBY6
 HxJPFD1VSlVKTE9PS0xITk9JSE5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhJTU43Bg++
DKIM-Signature: a=rsa-sha256;
 b=gNdMd7Lvv6GJCXLKhQPQ6vXPYCaHkk1O4/n4gioW5gNkKYTsGVxQHupzSTkohSXwqSbpGrJMRW0QsGHPy2OcIaIZM+a4iKLkd8s6tP9XRKa3dJfLb8yR0bHhFXXi+9mfC1o7q8YewlHB3dew3TypiT5DvG82J/vxdfXFCPu+jbE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=YWu9n/9IBBfFFS1SW+9a/d0YLGPZcm6FC40jOqFIY6k=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/2/21 00:56, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Essentially the only differences between u-boot-rockchip.bin and
> u-boot-rockchip-spi.bin are the formatting of idbloader.img which is
> handled by mkimage (via -T rkspi/rksd) and the offset at which U-Boot
> proper is flashed, the content of the binaries are identical otherwise.
>
> This fixes some issues[1] where binman tries to find the symbols defined
> in the proper binary to install them in an xPL binary. However, because
> we use the binary for proper (on Aarch64) generated in simple-bin image
> node and not simple-bin-spi image node, binman doesn't have access to
> that symbol anymore. Therefore, let's depend entirely on binaries built
> by simple-bin in simple-bin-spi so those issues do not arise anymore as
> nothing is compiled essentially, just assembled.
>
> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c8c928c7e5089db3a2239f2564e6dee1d82aad95..2e8a3bd09e49ed73a8cea3fadfb6d2b592082365 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -187,18 +187,28 @@
>   			};
>   #elif defined(CONFIG_TPL)
>   			u-boot-tpl {
> +				type = "blob";
> +				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
> +				filename = "tpl/u-boot-tpl.bin";
>   			};
>   #endif
>   			u-boot-spl {
> +				type = "blob";
> +				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
> +				filename = "spl/u-boot-spl.bin";
>   			};
>   		};
>   
>   #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>   		fit {
>   			type = "blob";
> +			/* sync with /binman/simple-bin/fit */
>   			filename = "u-boot.itb";
>   #else
>   		u-boot-img {
> +			type = "blob";
> +			/* sync with /binman/simple-bin/u-boot-img */
> +			filename = "u-boot.img";
>   #endif
>   			/* Sync with u-boot,spl-payload-offset if present */
>   			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>
