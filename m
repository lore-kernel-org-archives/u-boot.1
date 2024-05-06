Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D73C25B5C
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19A78848B;
	Mon,  6 May 2024 12:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FT3VHihE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86DD8848B; Mon,  6 May 2024 12:37:24 +0200 (CEST)
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com
 [103.129.254.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DA48801F
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FT3VHihEVuQnfpBTOgL3NBU7muBDSflMUx/OmY6kgfrHwWs/Z3qA8bhfSmwzLBFEG9qwtll3f0WMhE4CpHQ7pmPgPqLN9Zd8Ft/VPTo8r/prkGEmgJK3qDCHst+LnloMlAt10yjYo/i8b4z0GB7PnAcuhpImQeMp5mkTnL3ugFw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=VnRL/CxoXuDisNjb0rKe8BXX9FtFMfKqhaVVoOi7o5U=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EDE8F9002F9;
 Mon,  6 May 2024 18:37:13 +0800 (CST)
Message-ID: <be7aa0a9-25aa-4afc-88ae-7b4d57bb84da@rock-chips.com>
Date: Mon, 6 May 2024 18:37:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/18] rockchip: rk3399: Include uart related pinctrl
 nodes in TPL/SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-17-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-17-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4eQ1YdT0geSBkZGENMTUhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d7aa4ff03a9kunmede8f9002f9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6STo5DzNOCBYeCz45OjNK
 Lk1PFDdVSlVKTEpPQkJKQ0hPTExIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSkxDNwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> The initial serial console UART iomux is typically configured in
> board_debug_uart_init() at TPL stage on Rockchip platform.
>
> Later stages typically use pinctrl driver to configure iomux UART once
> again based on the control FDT.
>
> Include uart related pinctrl nodes in TPL/SPL control FDT to make it
> possible for pinctrl driver to configure UART iomux at TPL/SPL stage.
>
> Following debug log message may also be seen at U-Boot pre-reloc stage:
>
>    ns16550_serial serial@ff1a0000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19
>
> This can be resolved by including bootph prop for U-Bood pre-reloc
> phase (bootph-some-ram or bootph-all). However, this has intentionally
> been excluded due to including it unnecessarily slows down boot around
> 200-400 ms.
>
> Also add the clock-frequency prop similar to what has been done for
> other Rockchip SoCs.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from "Fix loading FIT from SD-card" patch
> v2: Change to only include pinctrl nodes in TPL and SPL phase
>
> Hopefully the clock-frequency prop can be used to help speed up boot in
> a future patch series, loading the uart rate from clock driver currently
> delays boot at i.e. U-Boot proper pre-reloc.
> ---
>   arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 16 ++++++++++++++++
>   arch/arm/dts/rk3399-u-boot.dtsi             |  6 ++++++
>   2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> index 390cf24152a6..d1912a2ef6a9 100644
> --- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> @@ -113,4 +113,20 @@
>   
>   &uart0 {
>   	bootph-all;
> +	clock-frequency = <24000000>;
> +};
> +
> +&uart0_cts {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
> +};
> +
> +&uart0_rts {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
> +};
> +
> +&uart0_xfer {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
>   };
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 9815dc53e8ed..b39fe39fa2b3 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -136,6 +136,12 @@
>   
>   &uart2 {
>   	bootph-all;
> +	clock-frequency = <24000000>;
> +};
> +
> +&uart2c_xfer {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
>   };
>   
>   &vopb {
