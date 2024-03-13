Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85B7C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBB38758B;
	Wed, 13 Mar 2024 11:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EUwSaomV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE382875FA; Wed, 13 Mar 2024 11:13:36 +0100 (CET)
Received: from mail-m127223.xmail.ntesmail.com
 (mail-m127223.xmail.ntesmail.com [115.236.127.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CCF87572
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 11:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EUwSaomVfHuYcUbUqvuIj/ltPJGnK8jKt8AtXMyymTm5LHtMgnVJdq2gMfyqO08heWerbewkK06xQG/6fM9uq6wtnj0aaoY821BD3ZizWoiDjMKj7nD7PeG9IhLxS4aMbdppb9zIkzX92oBD5ZzOuByXKdiU8kEx+AiccbNpTvs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=U9gV3GMAeKeO1H6nfhfi2nPUnkI3lu9PHvvVpBm7DF0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 77FCF9003BE;
 Wed, 13 Mar 2024 18:13:19 +0800 (CST)
Message-ID: <437dabf3-735b-4012-944c-e3970171012a@rock-chips.com>
Date: Wed, 13 Mar 2024 18:13:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] board: rockchip: rk3399: Add device tree files
 to MAINTAINERS
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240312233636.1428749-1-jonas@kwiboo.se>
 <20240312233636.1428749-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240312233636.1428749-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MZH1ZJT0sZTx0fHkNKSExVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e374d5a3a03a9kunm77fcf9003be
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6Ojo5FTMIFilIOBo1EhYN
 LSMKFANVSlVKTEpLSElPQ0tLT0JDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCQklCNwY+
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


On 2024/3/13 07:36, Jonas Karlman wrote:
> Update MAINTAINERS files for RK3399 boards to include related device
> tree files. Also correct a few filenames.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Use glob pattern where appropriate
> ---
>   board/firefly/roc-pc-rk3399/MAINTAINERS       |  1 +
>   board/pine64/pinebook-pro-rk3399/MAINTAINERS  |  5 ++-
>   board/pine64/pinephone-pro-rk3399/MAINTAINERS |  5 ++-
>   board/pine64/rockpro64_rk3399/MAINTAINERS     |  2 +-
>   board/rockchip/evb_rk3399/MAINTAINERS         | 35 ++++++++++---------
>   board/vamrs/rock960_rk3399/MAINTAINERS        |  2 ++
>   6 files changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/board/firefly/roc-pc-rk3399/MAINTAINERS b/board/firefly/roc-pc-rk3399/MAINTAINERS
> index 68a5b757d1df..2c0de4432fa8 100644
> --- a/board/firefly/roc-pc-rk3399/MAINTAINERS
> +++ b/board/firefly/roc-pc-rk3399/MAINTAINERS
> @@ -6,3 +6,4 @@ F:	board/firefly/roc-pc-rk3399
>   F:	include/configs/roc-pc-rk3399.h
>   F:	configs/roc-pc-rk3399_defconfig
>   F:	configs/roc-pc-mezzanine-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-roc-pc*
> diff --git a/board/pine64/pinebook-pro-rk3399/MAINTAINERS b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
> index 7300ca1b1b81..287ed4346050 100644
> --- a/board/pine64/pinebook-pro-rk3399/MAINTAINERS
> +++ b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
> @@ -2,7 +2,6 @@ PINEBOOK_PRO
>   M:	Peter Robinson <pbrobinson@gmail.com>
>   S:	Maintained
>   F:	board/pine64/pinebook-pro-rk3399/
> -F:	include/configs/rk3399-pinebook-pro.h
> -F:	arch/arm/dts/rk3399-pinebook-pro.dts
> -F:	arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> +F:	include/configs/pinebook-pro-rk3399.h
> +F:	arch/arm/dts/rk3399-pinebook-pro*
>   F:	configs/pinebook-pro-rk3399_defconfig
> diff --git a/board/pine64/pinephone-pro-rk3399/MAINTAINERS b/board/pine64/pinephone-pro-rk3399/MAINTAINERS
> index bc2dcdd8d423..959566a877ec 100644
> --- a/board/pine64/pinephone-pro-rk3399/MAINTAINERS
> +++ b/board/pine64/pinephone-pro-rk3399/MAINTAINERS
> @@ -2,7 +2,6 @@ PINEPHONE_PRO
>   M:	Peter Robinson <pbrobinson@gmail.com>
>   S:	Maintained
>   F:	board/pine64/pinephone-pro-rk3399/
> -F:	include/configs/rk3399-pinephone-pro.h
> -F:	arch/arm/dts/rk3399-pinephone-pro.dts
> -F:	arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +F:	include/configs/pinephone-pro-rk3399.h
> +F:	arch/arm/dts/rk3399-pinephone-pro*
>   F:	configs/pinephone-pro-rk3399_defconfig
> diff --git a/board/pine64/rockpro64_rk3399/MAINTAINERS b/board/pine64/rockpro64_rk3399/MAINTAINERS
> index 220ee21f230f..d9e11f4bab34 100644
> --- a/board/pine64/rockpro64_rk3399/MAINTAINERS
> +++ b/board/pine64/rockpro64_rk3399/MAINTAINERS
> @@ -3,5 +3,5 @@ M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	board/pine64/rockpro64_rk3399
>   F:	include/configs/rockpro64_rk3399.h
> -F:	arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-rockpro64*
>   F:	configs/rockpro64-rk3399_defconfig
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
> index acdb840f2093..f45f81623a3a 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -4,48 +4,53 @@ S:      Maintained
>   F:      board/rockchip/evb_rk3399
>   F:      include/configs/evb_rk3399.h
>   F:      configs/evb-rk3399_defconfig
> +F:      arch/arm/dts/rk3399-evb*
>   F:      configs/firefly-rk3399_defconfig
> +F:      arch/arm/dts/rk3399-firefly*
>   
>   EAIDK-610
>   M:      Andy Yan <andy.yan@rock-chips.com>
>   S:      Maintained
>   F:	configs/eaidk-610-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-eaidk-610*
>   
>   KHADAS-EDGE
>   M:	Nick Xie <nick@khadas.com>
>   S:	Maintained
>   F:	configs/khadas-edge-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-khadas-edge.dts
> +F:	arch/arm/dts/rk3399-khadas-edge.dtsi
>   F:	arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
>   
>   KHADAS-EDGE-CAPTAIN
>   M:	Nick Xie <nick@khadas.com>
>   S:	Maintained
>   F:	configs/khadas-edge-captain-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-khadas-edge-captain-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-khadas-edge-captain*
>   
>   KHADAS-EDGE-V
>   M:	Nick Xie <nick@khadas.com>
>   S:	Maintained
>   F:	configs/khadas-edge-v-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-khadas-edge-v-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-khadas-edge-v*
>   
>   LEEZ-P710
>   M:	Andy Yan <andy.yan@rock-chips.com>
>   S:      Maintained
> -F:	arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-leez-p710*
>   F:	configs/leez-rk3399_defconfig
>   
>   NANOPC-T4
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/nanopc-t4-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-nanopc-t4-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-nanopc-t4*
>   
>   NANOPI-M4
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/nanopi-m4-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-nanopi-m4.dts
>   F:	arch/arm/dts/rk3399-nanopi-m4-u-boot.dtsi
>   
>   NANOPI-M4-2GB
> @@ -53,55 +58,53 @@ M:	Jagan Teki <jagan@amarulasolutions.com>
>   M:	Deepak Das <deepakdas.linux@gmail.com>
>   S:	Maintained
>   F:	configs/nanopi-m4-2gb-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-nanopi-m4-2gb-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-nanopi-m4-2gb*
>   
>   NANOPI-M4B
>   M:	Alexandre Vicenzi <linux@alxd.me>
>   S:	Maintained
>   F:	configs/nanopi-m4b-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-nanopi-m4b-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-nanopi-m4b*
>   
>   NANOPI-NEO4
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/nanopi-neo4-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-nanopi-neo4-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-nanopi-neo4*
>   
>   NANOPI-R4S
>   M:	Xiaobo Tian <peterwillcn@gmail.com>
>   S:	Maintained
>   F:	configs/nanopi-r4s-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-nanopi-r4s*
>   
>   ORANGEPI-RK3399
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/orangepi-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-u-boot.dtsi
> -F:	arch/arm/dts/rk3399-orangepi-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-orangepi*
>   
>   ROCK-4C+
>   M:	FUKAUMI Naoki <naoki@radxa.com>
>   S:	Maintained
>   F:	configs/rock-4c-plus-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-4c-plus.dts
> +F:	arch/arm/dts/rk3399-rock-4c-plus*
>   
>   ROCK-4SE
>   M:	Christopher Obbard <chris.obbard@collabora.com>
>   S:	Maintained
>   F:	configs/rock-4se-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-rock-4se*
>   
>   ROCK-PI-4
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/rock-pi-4-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>   F:	configs/rock-pi-4c-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-rock-pi-4*
>   
>   ROCK-PI-N10
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/rock-pi-n10-rk3399pro_defconfig
> -F:	arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> +F:	arch/arm/dts/rk3399pro-rock-pi-n10*
> diff --git a/board/vamrs/rock960_rk3399/MAINTAINERS b/board/vamrs/rock960_rk3399/MAINTAINERS
> index 8821672a3abb..f2121b191450 100644
> --- a/board/vamrs/rock960_rk3399/MAINTAINERS
> +++ b/board/vamrs/rock960_rk3399/MAINTAINERS
> @@ -4,8 +4,10 @@ S:      Maintained
>   F:      board/vamrs/rock960_rk3399/
>   F:      include/configs/rock960_rk3399.h
>   F:      configs/rock960-rk3399_defconfig
> +F:      arch/arm/dts/rk3399-rock960*
>   
>   FICUS EE
>   M:      Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   S:      Maintained
>   F:	configs/ficus-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-ficus*
