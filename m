Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06C8C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 23:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD41A88717;
	Fri,  9 Aug 2024 01:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8F388ADE; Fri,  9 Aug 2024 01:46:30 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC2788599
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp83t1723160777tlbikgv1
X-QQ-Originating-IP: kpHLW/QDeNCCmlE/0YFp3G9IX0TkMiAib3V838m+liw=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with SMTP id 0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 07:46:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4604107742567216680
Message-ID: <A3197B6C8DC7AE20+de210e19-38e5-4d4c-863b-e8c12880bbf9@radxa.com>
Date: Fri, 9 Aug 2024 08:46:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: disable "usb_host0_ohci" to make boot
 faster for Radxa ROCK 3A
To: u-boot@lists.denx.de
References: <20240802024949.122688-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240802024949.122688-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

sorry, please ignore this patch.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 8/2/24 11:49, FUKAUMI Naoki wrote:
> on-board USB 2.0 hub, FE1.1s, has Transaction Translator which can
> handle USB 1.x devices via "usb_host0_ehci". so we can omit
> "usb_host0_ohci" and make boot faster (a little).
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
