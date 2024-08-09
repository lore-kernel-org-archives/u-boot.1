Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBFC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5670F88100;
	Fri,  9 Aug 2024 11:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Yg3ZrukH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83557881C3; Fri,  9 Aug 2024 11:15:13 +0200 (CEST)
Received: from mail-m12784.qiye.163.com (mail-m12784.qiye.163.com
 [115.236.127.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2067D880D1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Yg3ZrukHf/DE49eVN4zOrDyl5Tyya5RJpDraZIc/53OB444hfxBgK/fCdLAximx30KTLqsy20WRjKZktUjCHuK5Z3LG9Lf14s0YuYx1SLlBWlO0tYAjcr/T9bdnfLRd8Ym22RRSc9T2kuJU1g5iazZgkyKVDQYa+sMklpO2wG+Q=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=3ycsss0+2yFxpDDdGdcfzgA7KmcF637UhWfVnFFKoog=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7BFDB900588;
 Fri,  9 Aug 2024 17:14:56 +0800 (CST)
Message-ID: <317839d3-ab28-426d-8869-f9783ad5aabb@rock-chips.com>
Date: Fri, 9 Aug 2024 17:14:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: disable "usb_host0_ohci" to make boot
 faster for Radxa ROCK 3A
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, gajjar04akash@gmail.com,
 jonas@kwiboo.se
References: <20240802024949.122688-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802024949.122688-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0JKVk9DHUsaSRpLGBhJQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91366b732803a9kunm7bfdb900588
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTo6Thw*TzI6SA4BEkIBEBcC
 CygwFE5VSlVKTElISkJPQ0JMTUpPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9PTEM3Bg++
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

Hi Naoki,

On 2024/8/2 10:49, FUKAUMI Naoki wrote:
> on-board USB 2.0 hub, FE1.1s, has Transaction Translator which can
> handle USB 1.x devices via "usb_host0_ehci". so we can omit
> "usb_host0_ohci" and make boot faster (a little).

The OHCI is in use when the direct connect device is USB1.1; and if the 
board

connect with usb2.0 hub, then only EHCI is working and OHCI has no use.


>
> => usb start
> starting USB...
> Bus usb@fd000000: Register 2000140 NbrPorts 2
> Starting the controller
> USB XHCI 1.10
> Bus usb@fd800000: USB EHCI 1.00
> Bus usb@fd880000: USB EHCI 1.00
> Bus usb@fd8c0000: USB OHCI 1.0
> scanning bus usb@fd000000 for devices... 1 USB Device(s) found
> scanning bus usb@fd800000 for devices... 2 USB Device(s) found
> scanning bus usb@fd880000 for devices... 1 USB Device(s) found
> scanning bus usb@fd8c0000 for devices... 3 USB Device(s) found
>         scanning usb for storage devices... 1 Storage Device(s) found
> => usb tree
> USB device tree:
>    1  Hub (5 Gb/s, 0mA)
>       U-Boot XHCI Host Controller
>
>    1  Hub (480 Mb/s, 0mA)
>    |  u-boot EHCI Host Controller
>    |
>    +-2  Hub (480 Mb/s, 100mA)
>          USB 2.0 Hub
>
>    1  Hub (480 Mb/s, 0mA)
>       u-boot EHCI Host Controller
>
>    1  Hub (12 Mb/s, 0mA)
>    |   U-Boot Root Hub
>    |
>    +-2  Hub (12 Mb/s, 100mA)
>      |  ALCOR Generic USB Hub
>      |
>      +-3  Mass Storage (12 Mb/s, 300mA)
>           JetFlash Mass Storage Device 02K1RNH5MJFV4TX6
>
> => usb reset
> resetting USB...
> Host not halted after 16000 microseconds.
> Bus usb@fd000000: Register 2000140 NbrPorts 2
> Starting the controller
> USB XHCI 1.10
> Bus usb@fd800000: USB EHCI 1.00
> Bus usb@fd880000: USB EHCI 1.00
> Bus usb@fd8c0000: USB OHCI 1.0
> scanning bus usb@fd000000 for devices... 1 USB Device(s) found
> scanning bus usb@fd800000 for devices... 4 USB Device(s) found
> scanning bus usb@fd880000 for devices... 1 USB Device(s) found
> scanning bus usb@fd8c0000 for devices... 1 USB Device(s) found
>         scanning usb for storage devices... 1 Storage Device(s) found
> => usb tree
> USB device tree:
>    1  Hub (5 Gb/s, 0mA)
>       U-Boot XHCI Host Controller
>
>    1  Hub (480 Mb/s, 0mA)
>    |  u-boot EHCI Host Controller
>    |
>    +-2  Hub (480 Mb/s, 100mA)
>      |   USB 2.0 Hub
>      |
>      +-3  Hub (12 Mb/s, 100mA)
>        |  ALCOR Generic USB Hub
>        |
>        +-4  Mass Storage (12 Mb/s, 300mA)
>             JetFlash Mass Storage Device 02K1RNH5MJFV4TX6
>
>    1  Hub (480 Mb/s, 0mA)
>       u-boot EHCI Host Controller
>
>    1  Hub (12 Mb/s, 0mA)
>        U-Boot Root Hub
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 9d18f5d0b36..9078b9a67a2 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -40,3 +40,7 @@
>   		spi-tx-bus-width = <1>;
>   	};
>   };
> +
> +&usb_host0_ohci {
> +	status = "disabled";
> +};
