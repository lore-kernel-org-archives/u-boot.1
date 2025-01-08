Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3258AE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 06:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F23801E8;
	Wed,  8 Jan 2025 07:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JWjaqCjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 931B88036B; Wed,  8 Jan 2025 07:57:00 +0100 (CET)
Received: from mail-m118212.qiye.163.com (mail-m118212.qiye.163.com
 [115.236.118.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544EC8005B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 07:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 8153569f;
 Wed, 8 Jan 2025 14:56:48 +0800 (GMT+08:00)
Message-ID: <e4ea02b8-69b2-4a7e-bae8-3036d91f8743@rock-chips.com>
Date: Wed, 8 Jan 2025 14:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] arm64: dts: rockchip: Split up RK3588's PCIe
 pinctrls
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 sumit.garg@linaro.org, jonas@kwiboo.se, eugen.hristev@linaro.org,
 quentin.schulz@cherry.de, michal.simek@amd.com, seb-dev@mail.de,
 liujianfeng1994@gmail.com, heiko@sntech.de, zhangzj@rock-chips.com,
 macromorgan@hotmail.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 cfsworks@gmail.com, sebastian.reichel@collabora.com, alchark@gmail.com,
 didi.debian@cknow.org, cassel@kernel.org, boris.brezillon@collabora.com,
 cristian.ciocaltea@collabora.com, jing@jing.rocks
References: <20250104015704.1238-1-naoki@radxa.com>
 <20250104015704.1238-2-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250104015704.1238-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5PSFYdSB4fTUsfH09MSRpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9444b39abc03afkunm8153569f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6ASo6CDIIDxcILBASPB1O
 QkMaCwFVSlVKTEhNSEpCT0pKTUpJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSE1NQzcG
DKIM-Signature: a=rsa-sha256;
 b=JWjaqCjQt2Xk8AMWrV4Sk+RmdV4EV7yIzoJGZRy+6xx6EG9vIbY8sp7tfLQlOi85d8VSoAT6ZN2Ej14Q2mGNwgYu80NIgdzOqN4UcfERYE2xp+vJDplvrYjOt/isuI9f8rSGXaLs/pshIC1vppT+qBudClCj9W717vBYLofVDKE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=yJL8EwjINJ0zntzA2WBVH1GQXNjWg7+/wr8bZvfAUe4=;
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


On 2025/1/4 09:57, FUKAUMI Naoki wrote:
> From: Sam Edwards <cfsworks@gmail.com>
>
> These pinctrls manage the low-speed PCIe signals:
> - CLKREQ#: An output on the RK3588 (both RC or EP modes), used to
>    request that external clock-generation circuitry provide a clock.
> - PERST#: An input on the RK3588 in EP mode, used to detect a reset
>    signal from the RC. In RC mode, the hardware does not use this signal:
>    Linux itself generates it by putting the pin in GPIO mode.
> - WAKE#: In EP mode, this is an output; in RC mode, this is an input.
>
> Each of these signals serves a distinct purpose, and more importantly,
> PERST# should not be muxed when the RK3588 is in the RC role. Bundling
> them together in pinctrl groups prevents proper use: indeed, almost none
> of the current board-specific .dts files make any use of them.
> (Exception: Rock 5A recently had a patch land that misuses _pins; this
>   patch corrects that.)
>
> However, on some RK3588 boards, the PCIe 3 controller will indefinitely
> stall the boot if CLKREQ# is not muxed (details in the next patch).
> This patch unbundles the signals to allow them to be used.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Link: https://lore.kernel.org/r/20240912025034.180233-2-CFSworks@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 4294e32111781b3de4d73b944cbd1bc1662a9a7a ]
>
> (cherry picked from commit 8713425fa162b61bcf5f7a6dcd171fddfb12be36)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../arm64/rockchip/rk3588-base-pinctrl.dtsi   | 271 ++++++++++++++----
>   .../src/arm64/rockchip/rk3588s-rock-5a.dts    |   6 +-
>   2 files changed, 228 insertions(+), 49 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi
> index d1368418502a..7f874c77410c 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi
> @@ -1612,23 +1612,43 @@
>   
>   	pcie20x1 {
>   		/omit-if-no-ref/
> -		pcie20x1m0_pins: pcie20x1m0-pins {
> +		pcie20x1m0_clkreqn: pcie20x1m0-clkreqn {
>   			rockchip,pins =
>   				/* pcie20x1_2_clkreqn_m0 */
> -				<3 RK_PC7 4 &pcfg_pull_none>,
> +				<3 RK_PC7 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie20x1m0_perstn: pcie20x1m0-perstn {
> +			rockchip,pins =
>   				/* pcie20x1_2_perstn_m0 */
> -				<3 RK_PD1 4 &pcfg_pull_none>,
> +				<3 RK_PD1 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie20x1m0_waken: pcie20x1m0-waken {
> +			rockchip,pins =
>   				/* pcie20x1_2_waken_m0 */
>   				<3 RK_PD0 4 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie20x1m1_pins: pcie20x1m1-pins {
> +		pcie20x1m1_clkreqn: pcie20x1m1-clkreqn {
>   			rockchip,pins =
>   				/* pcie20x1_2_clkreqn_m1 */
> -				<4 RK_PB7 4 &pcfg_pull_none>,
> +				<4 RK_PB7 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie20x1m1_perstn: pcie20x1m1-perstn {
> +			rockchip,pins =
>   				/* pcie20x1_2_perstn_m1 */
> -				<4 RK_PC1 4 &pcfg_pull_none>,
> +				<4 RK_PC1 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie20x1m1_waken: pcie20x1m1-waken {
> +			rockchip,pins =
>   				/* pcie20x1_2_waken_m1 */
>   				<4 RK_PC0 4 &pcfg_pull_none>;
>   		};
> @@ -1654,52 +1674,127 @@
>   
>   	pcie30x1 {
>   		/omit-if-no-ref/
> -		pcie30x1m0_pins: pcie30x1m0-pins {
> +		pcie30x1m0_0_clkreqn: pcie30x1m0-0-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x1_0_clkreqn_m0 */
> -				<0 RK_PC0 12 &pcfg_pull_none>,
> +				<0 RK_PC0 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m0_0_perstn: pcie30x1m0-0-perstn {
> +			rockchip,pins =
>   				/* pcie30x1_0_perstn_m0 */
> -				<0 RK_PC5 12 &pcfg_pull_none>,
> +				<0 RK_PC5 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m0_0_waken: pcie30x1m0-0-waken {
> +			rockchip,pins =
>   				/* pcie30x1_0_waken_m0 */
> -				<0 RK_PC4 12 &pcfg_pull_none>,
> +				<0 RK_PC4 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m0_1_clkreqn: pcie30x1m0-1-clkreqn {
> +			rockchip,pins =
>   				/* pcie30x1_1_clkreqn_m0 */
> -				<0 RK_PB5 12 &pcfg_pull_none>,
> +				<0 RK_PB5 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m0_1_perstn: pcie30x1m0-1-perstn {
> +			rockchip,pins =
>   				/* pcie30x1_1_perstn_m0 */
> -				<0 RK_PB7 12 &pcfg_pull_none>,
> +				<0 RK_PB7 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m0_1_waken: pcie30x1m0-1-waken {
> +			rockchip,pins =
>   				/* pcie30x1_1_waken_m0 */
>   				<0 RK_PB6 12 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x1m1_pins: pcie30x1m1-pins {
> +		pcie30x1m1_0_clkreqn: pcie30x1m1-0-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x1_0_clkreqn_m1 */
> -				<4 RK_PA3 4 &pcfg_pull_none>,
> +				<4 RK_PA3 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m1_0_perstn: pcie30x1m1-0-perstn {
> +			rockchip,pins =
>   				/* pcie30x1_0_perstn_m1 */
> -				<4 RK_PA5 4 &pcfg_pull_none>,
> +				<4 RK_PA5 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m1_0_waken: pcie30x1m1-0-waken {
> +			rockchip,pins =
>   				/* pcie30x1_0_waken_m1 */
> -				<4 RK_PA4 4 &pcfg_pull_none>,
> +				<4 RK_PA4 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m1_1_clkreqn: pcie30x1m1-1-clkreqn {
> +			rockchip,pins =
>   				/* pcie30x1_1_clkreqn_m1 */
> -				<4 RK_PA0 4 &pcfg_pull_none>,
> +				<4 RK_PA0 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m1_1_perstn: pcie30x1m1-1-perstn {
> +			rockchip,pins =
>   				/* pcie30x1_1_perstn_m1 */
> -				<4 RK_PA2 4 &pcfg_pull_none>,
> +				<4 RK_PA2 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m1_1_waken: pcie30x1m1-1-waken {
> +			rockchip,pins =
>   				/* pcie30x1_1_waken_m1 */
>   				<4 RK_PA1 4 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x1m2_pins: pcie30x1m2-pins {
> +		pcie30x1m2_0_clkreqn: pcie30x1m2-0-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x1_0_clkreqn_m2 */
> -				<1 RK_PB5 4 &pcfg_pull_none>,
> +				<1 RK_PB5 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m2_0_perstn: pcie30x1m2-0-perstn {
> +			rockchip,pins =
>   				/* pcie30x1_0_perstn_m2 */
> -				<1 RK_PB4 4 &pcfg_pull_none>,
> +				<1 RK_PB4 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m2_0_waken: pcie30x1m2-0-waken {
> +			rockchip,pins =
>   				/* pcie30x1_0_waken_m2 */
> -				<1 RK_PB3 4 &pcfg_pull_none>,
> +				<1 RK_PB3 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m2_1_clkreqn: pcie30x1m2-1-clkreqn {
> +			rockchip,pins =
>   				/* pcie30x1_1_clkreqn_m2 */
> -				<1 RK_PA0 4 &pcfg_pull_none>,
> +				<1 RK_PA0 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m2_1_perstn: pcie30x1m2-1-perstn {
> +			rockchip,pins =
>   				/* pcie30x1_1_perstn_m2 */
> -				<1 RK_PA7 4 &pcfg_pull_none>,
> +				<1 RK_PA7 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x1m2_1_waken: pcie30x1m2-1-waken {
> +			rockchip,pins =
>   				/* pcie30x1_1_waken_m2 */
>   				<1 RK_PA1 4 &pcfg_pull_none>;
>   		};
> @@ -1721,45 +1816,85 @@
>   
>   	pcie30x2 {
>   		/omit-if-no-ref/
> -		pcie30x2m0_pins: pcie30x2m0-pins {
> +		pcie30x2m0_clkreqn: pcie30x2m0-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x2_clkreqn_m0 */
> -				<0 RK_PD1 12 &pcfg_pull_none>,
> +				<0 RK_PD1 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m0_perstn: pcie30x2m0-perstn {
> +			rockchip,pins =
>   				/* pcie30x2_perstn_m0 */
> -				<0 RK_PD4 12 &pcfg_pull_none>,
> +				<0 RK_PD4 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m0_waken: pcie30x2m0-waken {
> +			rockchip,pins =
>   				/* pcie30x2_waken_m0 */
>   				<0 RK_PD2 12 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x2m1_pins: pcie30x2m1-pins {
> +		pcie30x2m1_clkreqn: pcie30x2m1-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x2_clkreqn_m1 */
> -				<4 RK_PA6 4 &pcfg_pull_none>,
> +				<4 RK_PA6 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m1_perstn: pcie30x2m1-perstn {
> +			rockchip,pins =
>   				/* pcie30x2_perstn_m1 */
> -				<4 RK_PB0 4 &pcfg_pull_none>,
> +				<4 RK_PB0 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m1_waken: pcie30x2m1-waken {
> +			rockchip,pins =
>   				/* pcie30x2_waken_m1 */
>   				<4 RK_PA7 4 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x2m2_pins: pcie30x2m2-pins {
> +		pcie30x2m2_clkreqn: pcie30x2m2-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x2_clkreqn_m2 */
> -				<3 RK_PD2 4 &pcfg_pull_none>,
> +				<3 RK_PD2 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m2_perstn: pcie30x2m2-perstn {
> +			rockchip,pins =
>   				/* pcie30x2_perstn_m2 */
> -				<3 RK_PD4 4 &pcfg_pull_none>,
> +				<3 RK_PD4 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m2_waken: pcie30x2m2-waken {
> +			rockchip,pins =
>   				/* pcie30x2_waken_m2 */
>   				<3 RK_PD3 4 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x2m3_pins: pcie30x2m3-pins {
> +		pcie30x2m3_clkreqn: pcie30x2m3-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x2_clkreqn_m3 */
> -				<1 RK_PD7 4 &pcfg_pull_none>,
> +				<1 RK_PD7 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m3_perstn: pcie30x2m3-perstn {
> +			rockchip,pins =
>   				/* pcie30x2_perstn_m3 */
> -				<1 RK_PB7 4 &pcfg_pull_none>,
> +				<1 RK_PB7 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x2m3_waken: pcie30x2m3-waken {
> +			rockchip,pins =
>   				/* pcie30x2_waken_m3 */
>   				<1 RK_PB6 4 &pcfg_pull_none>;
>   		};
> @@ -1774,45 +1909,85 @@
>   
>   	pcie30x4 {
>   		/omit-if-no-ref/
> -		pcie30x4m0_pins: pcie30x4m0-pins {
> +		pcie30x4m0_clkreqn: pcie30x4m0-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x4_clkreqn_m0 */
> -				<0 RK_PC6 12 &pcfg_pull_none>,
> +				<0 RK_PC6 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m0_perstn: pcie30x4m0-perstn {
> +			rockchip,pins =
>   				/* pcie30x4_perstn_m0 */
> -				<0 RK_PD0 12 &pcfg_pull_none>,
> +				<0 RK_PD0 12 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m0_waken: pcie30x4m0-waken {
> +			rockchip,pins =
>   				/* pcie30x4_waken_m0 */
>   				<0 RK_PC7 12 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x4m1_pins: pcie30x4m1-pins {
> +		pcie30x4m1_clkreqn: pcie30x4m1-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x4_clkreqn_m1 */
> -				<4 RK_PB4 4 &pcfg_pull_none>,
> +				<4 RK_PB4 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m1_perstn: pcie30x4m1-perstn {
> +			rockchip,pins =
>   				/* pcie30x4_perstn_m1 */
> -				<4 RK_PB6 4 &pcfg_pull_none>,
> +				<4 RK_PB6 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m1_waken: pcie30x4m1-waken {
> +			rockchip,pins =
>   				/* pcie30x4_waken_m1 */
>   				<4 RK_PB5 4 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x4m2_pins: pcie30x4m2-pins {
> +		pcie30x4m2_clkreqn: pcie30x4m2-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x4_clkreqn_m2 */
> -				<3 RK_PC4 4 &pcfg_pull_none>,
> +				<3 RK_PC4 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m2_perstn: pcie30x4m2-perstn {
> +			rockchip,pins =
>   				/* pcie30x4_perstn_m2 */
> -				<3 RK_PC6 4 &pcfg_pull_none>,
> +				<3 RK_PC6 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m2_waken: pcie30x4m2-waken {
> +			rockchip,pins =
>   				/* pcie30x4_waken_m2 */
>   				<3 RK_PC5 4 &pcfg_pull_none>;
>   		};
>   
>   		/omit-if-no-ref/
> -		pcie30x4m3_pins: pcie30x4m3-pins {
> +		pcie30x4m3_clkreqn: pcie30x4m3-clkreqn {
>   			rockchip,pins =
>   				/* pcie30x4_clkreqn_m3 */
> -				<1 RK_PB0 4 &pcfg_pull_none>,
> +				<1 RK_PB0 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m3_perstn: pcie30x4m3-perstn {
> +			rockchip,pins =
>   				/* pcie30x4_perstn_m3 */
> -				<1 RK_PB2 4 &pcfg_pull_none>,
> +				<1 RK_PB2 4 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pcie30x4m3_waken: pcie30x4m3-waken {
> +			rockchip,pins =
>   				/* pcie30x4_waken_m3 */
>   				<1 RK_PB1 4 &pcfg_pull_none>;
>   		};
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> index 294b99dd50da..87fce8d9a964 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> @@ -310,7 +310,7 @@
>   };
>   
>   &pcie2x1l2 {
> -	pinctrl-0 = <&pcie20x1m0_pins>;
> +	pinctrl-0 = <&pcie2_reset>, <&pcie20x1m0_clkreqn>, <&pcie20x1m0_waken>;
>   	pinctrl-names = "default";
>   	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>   	vpcie3v3-supply = <&vcc3v3_wf>;
> @@ -328,6 +328,10 @@
>   		pow_en: pow-en {
>   			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
> +
> +		pcie2_reset: pcie2-reset {
> +			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
>   	};
>   
>   	power {
