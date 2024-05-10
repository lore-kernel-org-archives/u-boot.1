Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A609BC10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31EA488858;
	Fri, 10 May 2024 02:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VZ0vtYBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B13A88858; Fri, 10 May 2024 02:43:52 +0200 (CEST)
Received: from mail-m17235.xmail.ntesmail.com (mail-m17235.xmail.ntesmail.com
 [45.195.17.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF0088853
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VZ0vtYBKjj1ZwtX/6ABngwF8adEnvTnE9JccvekBm11xQB2wgJrV6vKb+Xjsd7DPOU67C7TZtBcEZIFw1kXpP9L17G6bqZdCU0Bbx4SEIbFftOMhU8kCTbJ8CO6kZ4rbnLTAZXGK9PEKOyROJEsTJT/w3n7Cg3bhHpLGJuxKDk8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=VDvLsvGog2/uAyIHCV/wzTjpq4p3SXoVBkrJa6rRhrk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C364890018C;
 Fri, 10 May 2024 08:43:44 +0800 (CST)
Message-ID: <55e07f63-961e-4f41-8ef3-db679856c481@rock-chips.com>
Date: Fri, 10 May 2024 08:43:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 57/81] reset: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-57-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-57-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh8ZSFZIGBhLHx9PGU5LSEhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff4b98203a9kunmc364890018c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6Tjo4AjNOMgI2NykzFzw9
 FB5PC0JVSlVKTEpOSEtKQ0lOT01MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTkpKQzcG
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


On 2024/5/2 09:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Yang Xiwen <forbidden405@outlook.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: John Keeping <john@metanate.com>
> Cc: Etienne Carriere <etienne.carriere@foss.st.com>
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> ---
>   drivers/reset/reset-ast2500.c      | 1 -
>   drivers/reset/reset-ast2600.c      | 1 -
>   drivers/reset/reset-bcm6345.c      | 1 -
>   drivers/reset/reset-dra7.c         | 1 -
>   drivers/reset/reset-hisilicon.c    | 1 -
>   drivers/reset/reset-hsdk.c         | 1 -
>   drivers/reset/reset-imx7.c         | 1 -
>   drivers/reset/reset-jh7110.c       | 1 -
>   drivers/reset/reset-mediatek.c     | 1 -
>   drivers/reset/reset-meson.c        | 1 -
>   drivers/reset/reset-mtmips.c       | 1 -
>   drivers/reset/reset-raspberrypi.c  | 1 -
>   drivers/reset/reset-rockchip.c     | 1 -
>   drivers/reset/reset-scmi.c         | 1 -
>   drivers/reset/reset-sifive.c       | 1 -
>   drivers/reset/reset-socfpga.c      | 1 -
>   drivers/reset/reset-sunxi.c        | 1 -
>   drivers/reset/reset-syscon.c       | 1 -
>   drivers/reset/reset-ti-sci.c       | 1 -
>   drivers/reset/reset-uclass.c       | 1 -
>   drivers/reset/reset-uniphier.c     | 1 -
>   drivers/reset/reset-zynqmp.c       | 1 -
>   drivers/reset/rst-rk3588.c         | 1 -
>   drivers/reset/sandbox-reset-test.c | 1 -
>   drivers/reset/sandbox-reset.c      | 1 -
>   drivers/reset/sti-reset.c          | 1 -
>   drivers/reset/stm32-reset.c        | 1 -
>   drivers/reset/tegra-car-reset.c    | 1 -
>   drivers/reset/tegra186-reset.c     | 1 -
>   29 files changed, 29 deletions(-)
>
> diff --git a/drivers/reset/reset-ast2500.c b/drivers/reset/reset-ast2500.c
> index d9cecf3a72e8..0ed5396b3e91 100644
> --- a/drivers/reset/reset-ast2500.c
> +++ b/drivers/reset/reset-ast2500.c
> @@ -4,7 +4,6 @@
>    * Copyright 2020 ASPEED Technology Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <misc.h>
> diff --git a/drivers/reset/reset-ast2600.c b/drivers/reset/reset-ast2600.c
> index 1732a450efc0..ec7b9b6625dc 100644
> --- a/drivers/reset/reset-ast2600.c
> +++ b/drivers/reset/reset-ast2600.c
> @@ -3,7 +3,6 @@
>    * Copyright 2020 ASPEED Technology Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <misc.h>
> diff --git a/drivers/reset/reset-bcm6345.c b/drivers/reset/reset-bcm6345.c
> index 5383f59ca375..6f140574216d 100644
> --- a/drivers/reset/reset-bcm6345.c
> +++ b/drivers/reset/reset-bcm6345.c
> @@ -6,7 +6,6 @@
>    *	Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/reset/reset-dra7.c b/drivers/reset/reset-dra7.c
> index 05101a94f9bc..2f0ec4c042f7 100644
> --- a/drivers/reset/reset-dra7.c
> +++ b/drivers/reset/reset-dra7.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <reset-uclass.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/reset/reset-hisilicon.c b/drivers/reset/reset-hisilicon.c
> index 85e02b296b02..aca54cd6701c 100644
> --- a/drivers/reset/reset-hisilicon.c
> +++ b/drivers/reset/reset-hisilicon.c
> @@ -6,7 +6,6 @@
>   #include <log.h>
>   #include <malloc.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <dt-bindings/reset/ti-syscon.h>
>   #include <reset-uclass.h>
> diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
> index 74b1173e8878..747e73b17fcb 100644
> --- a/drivers/reset/reset-hsdk.c
> +++ b/drivers/reset/reset-hsdk.c
> @@ -8,7 +8,6 @@
>   
>   #include <log.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <linux/bitops.h>
>   #include <linux/iopoll.h>
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index a3b3132f2fae..65a352b71fd7 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -6,7 +6,6 @@
>   #include <log.h>
>   #include <malloc.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <dt-bindings/reset/imx7-reset.h>
>   #include <dt-bindings/reset/imx8mp-reset.h>
> diff --git a/drivers/reset/reset-jh7110.c b/drivers/reset/reset-jh7110.c
> index d6bdf6bb00c4..adf722d5871a 100644
> --- a/drivers/reset/reset-jh7110.c
> +++ b/drivers/reset/reset-jh7110.c
> @@ -5,7 +5,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/ofnode.h>
>   #include <dt-bindings/reset/starfive,jh7110-crg.h>
> diff --git a/drivers/reset/reset-mediatek.c b/drivers/reset/reset-mediatek.c
> index 97ed221f739a..4b3afab92ea7 100644
> --- a/drivers/reset/reset-mediatek.c
> +++ b/drivers/reset/reset-mediatek.c
> @@ -6,7 +6,6 @@
>    *	   Weijie Gao <weijie.gao@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 9d0c8b354f4a..6337cdaaffa2 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -6,7 +6,6 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/reset-mtmips.c b/drivers/reset/reset-mtmips.c
> index 7bb8469823c8..2db6766280f2 100644
> --- a/drivers/reset/reset-mtmips.c
> +++ b/drivers/reset/reset-mtmips.c
> @@ -5,7 +5,6 @@
>    * Author: Weijie Gao <weijie.gao@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/reset/reset-raspberrypi.c b/drivers/reset/reset-raspberrypi.c
> index 804e32b8dd14..1792f0813f79 100644
> --- a/drivers/reset/reset-raspberrypi.c
> +++ b/drivers/reset/reset-raspberrypi.c
> @@ -4,7 +4,6 @@
>    *
>    * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <reset-uclass.h>
>   #include <asm/arch/msg.h>
> diff --git a/drivers/reset/reset-rockchip.c b/drivers/reset/reset-rockchip.c
> index 6cabaa10a35b..876eb7dddaa8 100644
> --- a/drivers/reset/reset-rockchip.c
> +++ b/drivers/reset/reset-rockchip.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2017 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
> index b76711f0a8fb..6dc1fcb33653 100644
> --- a/drivers/reset/reset-scmi.c
> +++ b/drivers/reset/reset-scmi.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_RESET
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <reset-uclass.h>
> diff --git a/drivers/reset/reset-sifive.c b/drivers/reset/reset-sifive.c
> index 23513b2f541b..65f857149b96 100644
> --- a/drivers/reset/reset-sifive.c
> +++ b/drivers/reset/reset-sifive.c
> @@ -4,7 +4,6 @@
>    * Author: Sagar Kadam <sagar.kadam@sifive.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <reset-uclass.h>
>   #include <asm/io.h>
> diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
> index 6e3f03e24843..866437fd24fe 100644
> --- a/drivers/reset/reset-socfpga.c
> +++ b/drivers/reset/reset-socfpga.c
> @@ -12,7 +12,6 @@
>    * Maxime Ripard <maxime.ripard@free-electrons.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
> index e484d1fff449..fd47e1f9e377 100644
> --- a/drivers/reset/reset-sunxi.c
> +++ b/drivers/reset/reset-sunxi.c
> @@ -4,7 +4,6 @@
>    * Author: Jagan Teki <jagan@amarulasolutions.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/reset/reset-syscon.c b/drivers/reset/reset-syscon.c
> index ff387ab6b22f..5be8c9492af2 100644
> --- a/drivers/reset/reset-syscon.c
> +++ b/drivers/reset/reset-syscon.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 Sean Anderson
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <regmap.h>
>   #include <reset.h>
> diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
> index fd654a08f13a..e69bcd41cbe8 100644
> --- a/drivers/reset/reset-ti-sci.c
> +++ b/drivers/reset/reset-ti-sci.c
> @@ -8,7 +8,6 @@
>    * Loosely based on Linux kernel reset-ti-sci.c...
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
> index b972faf01328..fe4cebf54f15 100644
> --- a/drivers/reset/reset-uclass.c
> +++ b/drivers/reset/reset-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_RESET
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <log.h>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index 35e3ccebd72e..49b001f05942 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -5,7 +5,6 @@
>    *   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index 87b4df5bf81a..b9c4f09fdfde 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_RESET
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <reset-uclass.h>
> diff --git a/drivers/reset/rst-rk3588.c b/drivers/reset/rst-rk3588.c
> index 2c524e4c4033..eae2eb10de24 100644
> --- a/drivers/reset/rst-rk3588.c
> +++ b/drivers/reset/rst-rk3588.c
> @@ -5,7 +5,6 @@
>    * Author: Sebastian Reichel <sebastian.reichel@collabora.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
> index 51b79810c89e..dfacb764bc77 100644
> --- a/drivers/reset/sandbox-reset-test.c
> +++ b/drivers/reset/sandbox-reset-test.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
> index 97b1b92e4a6c..adf9eedcba6d 100644
> --- a/drivers/reset/sandbox-reset.c
> +++ b/drivers/reset/sandbox-reset.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/sti-reset.c b/drivers/reset/sti-reset.c
> index 5305270fbf20..412a0c5b452b 100644
> --- a/drivers/reset/sti-reset.c
> +++ b/drivers/reset/sti-reset.c
> @@ -4,7 +4,6 @@
>    * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/stm32-reset.c b/drivers/reset/stm32-reset.c
> index 0bbde29810b4..9d4f361b2519 100644
> --- a/drivers/reset/stm32-reset.c
> +++ b/drivers/reset/stm32-reset.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_RESET
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/reset/tegra-car-reset.c b/drivers/reset/tegra-car-reset.c
> index 501e9cab8f7c..e3ecc8d37357 100644
> --- a/drivers/reset/tegra-car-reset.c
> +++ b/drivers/reset/tegra-car-reset.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/reset/tegra186-reset.c b/drivers/reset/tegra186-reset.c
> index d43da454114d..89624227c293 100644
> --- a/drivers/reset/tegra186-reset.c
> +++ b/drivers/reset/tegra186-reset.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
