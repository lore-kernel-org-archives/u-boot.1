Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB93CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E40886DD8;
	Fri, 13 Oct 2023 09:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YKnKLqb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318A686E22; Fri, 13 Oct 2023 09:20:40 +0200 (CEST)
Received: from mail-m127155.qiye.163.com (mail-m127155.qiye.163.com
 [115.236.127.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B74086D20
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YKnKLqb4xPS1KSoVcri/bZput8oZLXtVQgywwdfMfC2FXG2fc6yhH/kOEEiMxx2WvYyYM9PLzaq6vzAQRr5SVtk6pHPF4pRUmB2O+1ddXh57SEq5sviaZOOORtj9r9MNp585wlcCvPDK7wnmkK6XhoryHI32LmyYUNlrdlJk9mo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=zD0Sr812rvT/N3hoOJ5NecxNcuXHFU/4Kve4HQeTH8E=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 77BBF400365;
 Fri, 13 Oct 2023 15:19:50 +0800 (CST)
Message-ID: <10f744e9-e7a3-d110-c6fc-4b9426a65183@rock-chips.com>
Date: Fri, 13 Oct 2023 15:19:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] rockchip: dts: rk3328: Sync rock64 device tree file from
 Linux
Content-Language: en-US
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: u-boot@lists.denx.de
References: <20231010182738.31929-1-matwey.kornilov@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231010182738.31929-1-matwey.kornilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01JTVYZTUJIT0pCSUweGEJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b27e7e4312eb3kusn77bbf400365
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6Ojo6ETw6OgkMGRQtPzoh
 KDNPCQtVSlVKTUJMSkNKTkJKSktIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0lLNwY+
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


On 2023/10/11 02:27, Matwey V. Kornilov wrote:
> Sync the rk3328-rock64 dts from v6.6-rc5.
>
> See Linux kernel commit for details:
>
>      03633c4ef1fb ("arm64: dts: rockchip: fix USB regulator on ROCK64")
>
> Signed-off-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3328-rock64.dts | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-rock64.dts b/arch/arm/dts/rk3328-rock64.dts
> index f69a38f42d..0a27fa5271 100644
> --- a/arch/arm/dts/rk3328-rock64.dts
> +++ b/arch/arm/dts/rk3328-rock64.dts
> @@ -37,7 +37,8 @@
>   		vin-supply = <&vcc_io>;
>   	};
>   
> -	vcc_host_5v: vcc-host-5v-regulator {
> +	/* Common enable line for all of the rails mentioned in the labels */
> +	vcc_host_5v: vcc_host1_5v: vcc_otg_5v: vcc-host-5v-regulator {
>   		compatible = "regulator-fixed";
>   		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
>   		pinctrl-names = "default";
> @@ -48,17 +49,6 @@
>   		vin-supply = <&vcc_sys>;
>   	};
>   
> -	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
> -		compatible = "regulator-fixed";
> -		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&usb20_host_drv>;
> -		regulator-name = "vcc_host1_5v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
>   	vcc_sys: vcc-sys {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc_sys";
