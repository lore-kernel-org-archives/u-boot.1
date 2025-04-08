Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081E5C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FFB830EE;
	Tue,  8 Apr 2025 05:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FFrOk/jP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28AA82F47; Tue,  8 Apr 2025 05:20:10 +0200 (CEST)
Received: from mail-m49196.qiye.163.com (mail-m49196.qiye.163.com
 [45.254.49.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF01830EE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e8af1;
 Tue, 8 Apr 2025 11:20:04 +0800 (GMT+08:00)
Message-ID: <44363e39-b2cc-405c-b793-4d7f4eef2fbb@rock-chips.com>
Date: Tue, 8 Apr 2025 11:20:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] rockchip: rk3588: Drop BOARD_LATE_INIT from target
 config
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250406002447.1555596-1-jonas@kwiboo.se>
 <20250406002447.1555596-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250406002447.1555596-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0waGVZPH0IYS0gaHU1CTkJWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961369833903afkunm1101e8af1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06NSo4LDJMOUI#ESE1L003
 KiswCyxVSlVKTE9PS0NJT0tOSE1NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTE9DNwY+
DKIM-Signature: a=rsa-sha256;
 b=FFrOk/jPkAYcM8wnkrFl64WS5bwZfsaCpW40MhakRYp8YaxyTpqECuK/DS3T6eL1+2Doa7MpWaj2yFgIEfPeYNW7KIAwOFTVcT+5ta+7D2xotsXdlrzRV+run/DkqD+BdAQHIKrZp/jm+25Iaoyf4nI3d7MNwlRkZ1oApyi0bYg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=aBbBM/LrVlVX4sY5eakjuXkKW+m/Ym2/3469S6kqR2o=;
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


On 2025/4/6 08:24, Jonas Karlman wrote:
> BOARD_LATE_INIT is already selected by ROCKCHIP_RK3588 so there is no
> need to select it under any board target config.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig | 20 --------------------
>   1 file changed, 20 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 8acb6618718f..dfc19c4fc8fa 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -2,13 +2,11 @@ if ROCKCHIP_RK3588
>   
>   config TARGET_EVB_RK3588
>   	bool "Rockchip EVB1 v10"
> -	select BOARD_LATE_INIT
>   	help
>   	  RK3588 EVB is a evaluation board for Rockchp RK3588.
>   
>   config TARGET_CM3588_NAS_RK3588
>   	bool "FriendlyElec CM3588 NAS"
> -	select BOARD_LATE_INIT
>   	help
>   	  The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based
>   	  on the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
> @@ -31,7 +29,6 @@ config TARGET_CM3588_NAS_RK3588
>   
>   config TARGET_GENBOOK_CM5_RK3588
>   	bool "Cool Pi CM5 GenBook"
> -	select BOARD_LATE_INIT
>   	help
>   	  GeenBook is a notebook based on Rockchip RK3588, and works as a carrier
>   	  board connect with CM5 SOM.
> @@ -49,7 +46,6 @@ config TARGET_GENBOOK_CM5_RK3588
>   
>   config TARGET_JAGUAR_RK3588
>   	bool "Theobroma Systems SBC-RK3588-AMR (Jaguar)"
> -	select BOARD_LATE_INIT
>   	help
>   	  The SBC-RK3588-AMR is a Single Board Computer designed by
>   	  Theobroma Systems for autonomous mobile robots.
> @@ -76,7 +72,6 @@ config TARGET_JAGUAR_RK3588
>   
>   config TARGET_KHADAS_EDGE2_RK3588
>   	bool "Khadas Edge2 RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
>   	  by Khadas.
> @@ -98,7 +93,6 @@ config TARGET_KHADAS_EDGE2_RK3588
>   
>   config TARGET_NANOPCT6_RK3588
>   	bool "FriendlyElec NanoPC-T6 RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  The NanoPC-T6 is a Rockchip RK3588 based SBC by FriendlyElec.
>   
> @@ -143,7 +137,6 @@ config TARGET_NANOPCT6_RK3588
>   
>   config TARGET_NANOPI_R6C_RK3588S
>   	bool "FriendlyElec NanoPi R6C"
> -	select BOARD_LATE_INIT
>   	help
>   	  The NanoPi R6C is a SBC by FriendlyElec based on the Rockchip
>   	  RK3588s.
> @@ -155,7 +148,6 @@ config TARGET_NANOPI_R6C_RK3588S
>   
>   config TARGET_NANOPI_R6S_RK3588S
>   	bool "FriendlyElec NanoPi R6S"
> -	select BOARD_LATE_INIT
>   	help
>   	  The NanoPi R6S is a SBC by FriendlyElec based on the Rockchip
>   	  RK3588s.
> @@ -167,7 +159,6 @@ config TARGET_NANOPI_R6S_RK3588S
>   
>   config TARGET_NOVA_RK3588
>   	bool "Indiedroid Nova RK3588"
> -	select BOARD_LATE_INIT
>   	help
>   	  Indiedroid Nova is a Rockchip RK3588s based SBC by Indiedroid.
>   	  It comes in configurations from 4GB of RAM to 16GB of RAM,
> @@ -176,13 +167,11 @@ config TARGET_NOVA_RK3588
>   
>   config TARGET_ODROID_M2_RK3588S
>   	bool "Hardkernel ODROID-M2"
> -	select BOARD_LATE_INIT
>   	help
>   	  Hardkernel ODROID-M2 single board computer with a RK3588S2 SoC.
>   
>   config TARGET_RK3588_NEU6
>   	bool "Edgeble Neural Compute Module 6(Neu6) SoM"
> -	select BOARD_LATE_INIT
>   	help
>   	  Neu6A:
>   	  Neural Compute Module 6A(Neu6A) is a 96boards SoM-CB compute module
> @@ -204,7 +193,6 @@ config TARGET_RK3588_NEU6
>   
>   config TARGET_ROCK5A_RK3588
>   	bool "Radxa ROCK5A RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  Radxa ROCK5A is a Rockchip RK3588S based SBC (Single Board Computer)
>   	  by Radxa.
> @@ -231,7 +219,6 @@ config TARGET_ROCK5A_RK3588
>   
>   config TARGET_ROCK5B_RK3588
>   	bool "Radxa ROCK5B RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  Radxa ROCK5B is a Rockchip RK3588 based SBC (Single Board Computer)
>   	  by Radxa.
> @@ -256,7 +243,6 @@ config TARGET_ROCK5B_RK3588
>   
>   config TARGET_ROCK_5_ITX_RK3588
>   	bool "Radxa ROCK-5-ITX RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  Radxa ROCK-5-ITX is a Rockchip RK3588 based SBC (Single Board
>   	  Computer) by Radxa in the ITX formfactor.
> @@ -284,7 +270,6 @@ config TARGET_ROCK_5_ITX_RK3588
>   
>   config TARGET_ROCK_5C_RK3588S
>   	bool "Radxa ROCK 5C RK3588S2 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
>   
> @@ -304,7 +289,6 @@ config TARGET_ROCK_5C_RK3588S
>   
>   config TARGET_SIGE7_RK3588
>   	bool "ArmSoM Sige7 RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board Computer)
>   	  by ArmSoM.
> @@ -329,14 +313,12 @@ config TARGET_SIGE7_RK3588
>   
>   config TARGET_QUARTZPRO64_RK3588
>   	bool "Pine64 QuartzPro64 RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  Pine64 QuartzPro64 is a Rockchip RK3588 based SBC (Single Board
>   	  Computer) by Pine64.
>   
>   config TARGET_TIGER_RK3588
>   	bool "Theobroma Systems SOM-RK3588-Q7 (Tiger)"
> -	select BOARD_LATE_INIT
>   	help
>   	  The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
>   	  connector) system-on-module from Theobroma Systems, featuring the
> @@ -366,7 +348,6 @@ config TARGET_TIGER_RK3588
>   
>   config TARGET_TURINGRK1_RK3588
>   	bool "Turing Machines RK1 RK3588 board"
> -	select BOARD_LATE_INIT
>   	help
>   	  The Turing RK1 is a Rockchip RK3588 based SoM from Turing Machines.
>   
> @@ -389,7 +370,6 @@ config TARGET_TURINGRK1_RK3588
>   
>   config TARGET_TOYBRICK_RK3588
>   	bool "Toybrick TB-RK3588X board"
> -	select BOARD_LATE_INIT
>   	help
>   	  Rockchip Toybrick TB-RK3588X is a Rockchip RK3588 based development board.
>   	  TB-RK3588X adopts core board and mainboard design. The core board is connected
