Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD607CA0EC8
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 01:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA10186D5C;
	Tue, 12 Sep 2023 03:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MC7XO+pW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D0AF86D5C; Tue, 12 Sep 2023 03:24:05 +0200 (CEST)
Received: from mail-m12747.qiye.163.com (mail-m12747.qiye.163.com
 [115.236.127.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694BA86D23
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 03:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MC7XO+pWp2HiqcCVJPoMg00zuUu9Esp5WyGBz17dswd0Cc2y5ZQRbI6x+W/yANhS8FelSO2Rl1m58PtE8MTjQZ3qXCDjIuvLbMVG2ETeYZXbk137QUT0LV3hUdCeeFKNYbzvXUPak1qizDX6JSATp257b7JbDSAXt6+ZABP5TVg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=daPl1/qDc7Tx2YywdeNCtzui7beHOS7HKdBDvbMoPnY=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by mail-m127102.qiye.163.com (Hmail) with ESMTPA id 05DF16C01A7;
 Tue, 12 Sep 2023 09:23:45 +0800 (CST)
Message-ID: <a681b5df-0344-d274-4536-716286cec701@rock-chips.com>
Date: Tue, 12 Sep 2023 09:23:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] rockchip: Kconfig: Enable external TPL binary for
 rk3308
Content-Language: en-US
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 FUKAUMI Naoki <naoki@radxa.com>, Johan Jonker <jbx6244@gmail.com>
References: <20230909093324.11954-1-massimo.pegorer+oss@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230909093324.11954-1-massimo.pegorer+oss@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkJDVh8aSx0fGU8aGkwfTFUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8a86fcc4f8b280kuuu05df16c01a7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODo6SCo6CD1JGQs0EzNMExMp
 Cg4aFBxVSlVKTUJPT0NKQ0lMTExLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhLSE43Bg++
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


On 2023/9/9 17:33, Massimo Pegorer wrote:
> There is no support to initialize DRAM on rk3308 SoC using U-Boot
> TPL or SPL, and therefore an external TPL binary must be used to
> package a bootable u-boot-rockchip.bin image.
>
> Default ROCKCHIP_EXTERNAL_TPL to yes if ROCKCHIP_RK3308.
> Remove useless TPL_SERIAL.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index a279582f4f..3b044269bd 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -166,7 +166,6 @@ config ROCKCHIP_RK3308
>   	imply SPL_SYSCON
>   	imply SPL_RAM
>   	imply SPL_SERIAL
> -	imply TPL_SERIAL
>   	imply SPL_SEPARATE_BSS
>   	help
>   	  The Rockchip RK3308 is a ARM-based Soc which embedded with quad
> @@ -436,7 +435,7 @@ config TPL_ROCKCHIP_COMMON_BOARD
>   
>   config ROCKCHIP_EXTERNAL_TPL
>   	bool "Use external TPL binary"
> -	default y if ROCKCHIP_RK3568 || ROCKCHIP_RK3588
> +	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
>   	help
>   	  Some Rockchip SoCs require an external TPL to initialize DRAM.
>   	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
