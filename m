Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006BAE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A876803AB;
	Fri,  3 Jan 2025 04:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iOaOwYtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EB680107; Fri,  3 Jan 2025 04:39:51 +0100 (CET)
Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com
 [220.197.32.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2E980422
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79258e4e;
 Fri, 3 Jan 2025 11:39:39 +0800 (GMT+08:00)
Message-ID: <fe23ad1d-e342-463c-983a-9656ff928454@rock-chips.com>
Date: Fri, 3 Jan 2025 11:39:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Split up RK3588's PCIe pinctrls
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@linaro.org,
 jonas@kwiboo.se, Sam Edwards <cfsworks@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20241210033614.2292-1-naoki@radxa.com>
 <20241210033614.2292-3-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241210033614.2292-3-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxgdQlYdSExPTk0aThpIS0NWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942a3f4d4d03afkunm79258e4e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46OTo4DDIVDy0pEE88HA8v
 PwoKCRNVSlVKTEhOQ0xOTkNLTU1IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSE5CQjcG
DKIM-Signature: a=rsa-sha256;
 b=iOaOwYtCfairPxCnaWUlng8ac7/2m4uT3BfXxn9afQIV4aWEqmtLe+C/JYiFziF3LLRXZlRNuY5IdhWtayu89Gdj3FoAa2ZAFDJ7nm+ZyxT3/j6weOy8qmxGn2Q+GOjcytPduJMT1WUvE72ZJT1Nk/IzH5oMARDTr0jx3RzayTY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=KQF2tPwdN8niN+t2gfH4WDMFJnx87BUYqd0M2Tub21s=;
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


On 2024/12/10 11:36, FUKAUMI Naoki wrote:
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
> (cherry picked from commit 4294e32111781b3de4d73b944cbd1bc1662a9a7a)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../arm64/rockchip/rk3588-base-pinctrl.dtsi   | 271 ++++++++++++++----
>   .../src/arm64/rockchip/rk3588s-rock-5a.dts    |   6 +-
>   2 files changed, 228 insertions(+), 49 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi
> index 30db12c4fc82..b12562e9a985 100644
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
> index a385e0991990..d6a0b559edca 100644
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
