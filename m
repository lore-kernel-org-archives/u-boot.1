Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA64AC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED8C87FC8;
	Fri, 14 Jun 2024 11:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BzTwjOT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC01187FC8; Fri, 14 Jun 2024 11:01:34 +0200 (CEST)
Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com
 [45.254.49.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1724787D9B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BzTwjOT1Sj8m3B5XleJDo7uTZRDNNJFrk4Voyb/SIQIn0XQYK7ZTmd+4LL6DIoq7hBPE9K9k0Ksw9njjpPtRMA6OmyBiGCutTUsXk3HEOKOODjoa71YfpZWJeLRnt7HJwPENobiLgS/YboBnSFsrcteDYzEq+n8mh9tciRp92jg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=BhtKcwyJ/DnrkXdH9HfkbfxhFgVT+e87RmTNaIqWAOU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E1E649006F2;
 Fri, 14 Jun 2024 17:00:47 +0800 (CST)
Message-ID: <ca562976-c1ca-4409-9b52-ab5362dc6a23@rock-chips.com>
Date: Fri, 14 Jun 2024 17:00:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v3 3/8] arm64: dts: rockchip: correct gpio_pwrctrl1
 typos on rk3588(s) boards
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Jing Luo <jing@jing.rocks>, Heiko Stuebner <heiko@sntech.de>
References: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
 <20240610-tiger-v3-3-2b4731f95757@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240610-tiger-v3-3-2b4731f95757@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwaTVZCSxgeSUtLTU8eTh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9015fa60e203a9kunme1e649006f2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6PCo5GjNKFhQ1MDkVPkk2
 CCIwCihVSlVKTEpDSE5OTU9CSEhDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMQktJNwY+
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


On 2024/6/10 21:13, Quentin Schulz wrote:
> From: Jing Luo <jing@jing.rocks>
>
> gpio_pwrctrl2 gets duplicated by both rk806_dvs1_null and rk806_dvs2_null
> gpio_pwrctrl1 is unset. This typo appears in multiple files. Let's fix them.
>
> Note: I haven't had the chance to test them all because I don't own all
> of these boards (obviously). Please test if it's needed.
>
> Signed-off-by: Jing Luo <jing@jing.rocks>
> Link: https://lore.kernel.org/r/20240420130355.639406-1-jing@jing.rocks
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> [ upstream commit: d7f2039e5321636069baa77ef2f1e5d22cb69a88 ]
>
> (cherry picked from commit cb2b6d1d19ed10fcaec5f5859c08a3355d1c66e0)
> ---
>   dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi           | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts                | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi                | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi           | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts            | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts      | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts           | 2 +-
>   dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts              | 2 +-
>   9 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
> index 94ecb9b4f98..170501a879d 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
> @@ -357,7 +357,7 @@
>   		vcca-supply = <&vcc5v0_sys>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi
> index c0d4a15323e..d9bf67525e8 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi
> @@ -182,7 +182,7 @@
>   		#gpio-cells = <2>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> index 39d65002add..7d7303f8ecb 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> @@ -452,7 +452,7 @@
>   		vcca-supply = <&vcc5v0_sys>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
> index 4984e36a8c2..29f8e536de1 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
> @@ -401,7 +401,7 @@
>   		vcca-supply = <&vcc5v0_sys>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi
> index dc08da518a7..6b9206ce4a0 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi
> @@ -318,7 +318,7 @@
>   		#gpio-cells = <2>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts b/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
> index e037bf9db75..7f4d7bb9a07 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
> @@ -479,7 +479,7 @@
>   		vcca-supply = <&vcc5v0_sys>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts b/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
> index ce8119cbb82..a5b76e24ceb 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
> @@ -528,7 +528,7 @@
>   		vcca-supply = <&vcc5v0_sys>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
> index 25de4362af3..73700d77eed 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
> @@ -336,7 +336,7 @@
>   		#gpio-cells = <2>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> index 00afb90d4eb..5c99636a1d0 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> @@ -414,7 +414,7 @@
>   		#gpio-cells = <2>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>   			function = "pin_fun0";
>   		};
>   
>
