Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB30EA854A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 03:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7508063E;
	Mon,  9 Mar 2026 04:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AKHJue1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E3E83EEF; Mon,  9 Mar 2026 04:02:49 +0100 (CET)
Received: from mail-m12812.netease.com (mail-m12812.netease.com
 [103.209.128.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEF783A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 04:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36304abb3;
 Mon, 9 Mar 2026 11:02:43 +0800 (GMT+08:00)
Message-ID: <9d16a26e-1e69-4ea7-945d-417387388d60@rock-chips.com>
Date: Mon, 9 Mar 2026 11:02:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Remove USB-C controller from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de
References: <20260126215601.837587-1-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260126215601.837587-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd08c055103afkunm1a416669162befb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk4eVklDT0tNSklLS0tPGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=AKHJue1H4a5C2usCapDECuGp4zdfk/OkSFcy9Bhm5vt8xfghgk/Bd21pCdoe+HkQBz33AkYGq82VEoa7eItwt7G+6ycV6BaJwE/qB8ggzkNY8tZCKWk1QEqY6/yF+8jLxM1O3n2jfNUO220Pql3Nk9BDiAIEEE81J5L0f4uI/8s=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=U3jVtx1S0f8dKuc13oqjrYCb5JXpyJvKCTGhC6sZWfE=;
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


On 2026/1/27 05:55, Jonas Karlman wrote:
> The commit 12049db76437 ("rockchip: rk3588-rock-5b: Add USB-C controller
> to u-boot.dtsi") added the USB-C controller node to the ROCK 5B board
> u-boot.dtsi, this and related usb nodes are now part of upstream DT.
>
> Remove the upstream USB-C controller related DT nodes from u-boot.dtsi,
> keep usbc0 status = "okay" to keep USB-C power delivery working.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 43 +------------------------
>   1 file changed, 1 insertion(+), 42 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index e07b549c767f..ddc177344ebd 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -19,33 +19,6 @@
>   	bootph-some-ram;
>   };
>   
> -&i2c4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c4m1_xfer>;
> -	status = "okay";
> -
> -	usbc0: usb-typec@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		status = "okay";
> -
> -		usb_con: connector {
> -			compatible = "usb-c-connector";
> -			label = "USB-C";
> -			data-role = "dual";
> -			power-role = "sink";
> -			try-power-role = "sink";
> -			op-sink-microwatt = <1000000>;
> -			sink-pdos =
> -				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
> -				<PDO_VAR(5000, 20000, 5000)>;
> -		};
> -	};
> -};
> -
>   &saradc {
>   	bootph-pre-ram;
>   	vdd-microvolts = <1800000>;
> @@ -63,20 +36,6 @@
>   	};
>   };
>   
> -&u2phy0 {
> -	status = "okay";
> -};
> -
> -&u2phy0_otg {
> -	status = "okay";
> -};
> -
> -&usbdp_phy0 {
> -	status = "okay";
> -};
> -
> -&usb_host0_xhci {
> -	dr_mode = "peripheral";
> -	maximum-speed = "high-speed";
> +&usbc0 {
>   	status = "okay";
>   };
