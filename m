Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C07103E193
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F1A83952;
	Wed, 18 Mar 2026 15:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qp6F8zM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95DC4839A8; Wed, 18 Mar 2026 15:56:42 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12FA880325
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CAE1600AE;
 Wed, 18 Mar 2026 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5850DC2BC87;
 Wed, 18 Mar 2026 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773845798;
 bh=KwzCzXUilMDfQ7gfGfRyvV0QpLmyxBCM9qB++60j9uk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Qp6F8zM/jRrpp8SMm3/XfwRZM8lwcvRv+fKS1568eCh8Od6YYhjtYQCskGJwfqOOP
 QIffYZ4lmJqEgxcq2VhyLYEm+CY9edq1HBaS4PybOcI4WTWRUAByan4czCqUprQQKD
 FMQFAzW6irgKQNim8aQYfTB+M57C42bg7PMpQZGYISjXX5Af8YVDUt6TEfNvNyHUqK
 M11pVsNCABBaJWKisChB1JqpLuMNe1f+5Fhv6ClqlsjIwGxID3hapLfaQUImDUXkXw
 BrmpzDuS48SN00q20zsjHzJeS5ckaIJqFAdZPTFIwv/dy0If5qNbqUYSIaZHtwGQwT
 1QTd095oU1yFA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Tom Rini <trini@konsulko.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, David Lechner
 <dlechner@baylibre.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Julien Stephan
 <jstephan@baylibre.com>
Subject: Re: [PATCH] configs: mediatek: rename genio boards defconfigs to
 match the device tree name
In-Reply-To: <20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com>
References: <20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com>
Date: Wed, 18 Mar 2026 15:56:36 +0100
Message-ID: <87pl51rxsr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Mar 18, 2026 at 13:41, Julien Stephan <jstephan@baylibre.com> wrote:

> Rename defconfig for genio boards to match the device tree name:
> mt8370_evk_defconfig --> mt8370_genio_510_evk_defconfig
> mt8390_evk_defconfig --> mt8390_genio_700_evk_defconfig
> mt8395_evk_defconfig --> mt8395_genio_1200_evk_defconfig
>
> While at it, we also
> - update the CONFIG_IDENT_STRING to be consistent.
> - create a mt8188.config file shared by mt8370_genio_510_evk_defconfig
>   and mt8390_genio_700_evk_defconfig files
> - refactor MT8188/MT8370/MT8390 under the same entry in
>   boards/mediatek/MAINTAINERS
> - add myself as maintainer for these boards
> - remove useless CONFIG_SYS_BOARD for MT8390

Seems this patch is doing multiple things (multiple logical changes)
The doc says to split those out [1]

Can we split this a bit, please?

For example:
1. remove useless CONFIG_SYS_BOARD for MT8390
2. create a mt8188.config file shared by mt8370_genio_510_evk_defconfig
   and mt8390_genio_700_evk_defconfig files
3. refactor MT8188/MT8370/MT8390 under the same entry in
   boards/mediatek/MAINTAINERS
4. Do the rename
5. add myself as maintainer for these boards

This is just an example, feel free to split this however you'd like but
please, one logical change per patch

[1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#general-patch-submission-rules

>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  board/mediatek/MAINTAINERS                         | 18 +++++++-------
>  configs/{mt8390_evk_defconfig => mt8188.config}    |  3 ---
>  configs/mt8370_evk_defconfig                       | 28 ----------------------
>  configs/mt8370_genio_510_evk_defconfig             |  5 ++++
>  configs/mt8390_genio_700_evk_defconfig             |  4 ++++
>  ...k_defconfig => mt8395_genio_1200_evk_defconfig} |  2 +-
>  6 files changed, 18 insertions(+), 42 deletions(-)
>
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 446a9e8e53c..08cbd2ce49f 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -3,18 +3,16 @@ M:	Julien Masson <jmasson@baylibre.com>
>  S:	Maintained
>  F:	configs/mt8365_evk_defconfig
>  
> -MT8370 EVK
> +MT8188/MT8370/MT8390
>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
> +M:	Julien Stephan <jstephan@baylibre.com>
>  S:	Maintained
> -F:	configs/mt8370_evk_defconfig
> +F:	configs/mt8188.config
> +F:	configs/mt8370_genio_510_evk_defconfig
> +F:	configs/mt8390_genio_700_evk_defconfig
>  
> -MT8390 EVK
> -M:	Julien Masson <jmasson@baylibre.com>
> -M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
> -S:	Maintained
> -F:	configs/mt8390_evk_defconfig
> -
> -MT8395 EVK
> +MT8395
>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
> +M:	Julien Stephan <jstephan@baylibre.com>
>  S:	Maintained
> -F:	configs/mt8395_evk_defconfig
> +F:	configs/mt8395_genio_1200_evk_defconfig
> diff --git a/configs/mt8390_evk_defconfig b/configs/mt8188.config
> similarity index 81%
> rename from configs/mt8390_evk_defconfig
> rename to configs/mt8188.config
> index 06437be625e..9dfba6bf99f 100644
> --- a/configs/mt8390_evk_defconfig
> +++ b/configs/mt8188.config
> @@ -1,14 +1,11 @@
>  CONFIG_ARM=y
> -CONFIG_SYS_BOARD="mt8390_evk"
>  CONFIG_COUNTER_FREQUENCY=13000000
>  CONFIG_POSITION_INDEPENDENT=y
>  CONFIG_ARCH_MEDIATEK=y
>  CONFIG_TEXT_BASE=0x4c000000
>  CONFIG_NR_DRAM_BANKS=1
> -CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
>  CONFIG_TARGET_MT8188=y
>  CONFIG_SYS_LOAD_ADDR=0x4c000000
> -CONFIG_IDENT_STRING="mt8390-evk"
>  # CONFIG_BOARD_INIT is not set
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
> diff --git a/configs/mt8370_evk_defconfig b/configs/mt8370_evk_defconfig
> deleted file mode 100644
> index 48d3f64a42e..00000000000
> --- a/configs/mt8370_evk_defconfig
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_COUNTER_FREQUENCY=13000000
> -CONFIG_POSITION_INDEPENDENT=y
> -CONFIG_ARCH_MEDIATEK=y
> -CONFIG_TEXT_BASE=0x4c000000
> -CONFIG_NR_DRAM_BANKS=1
> -CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
> -CONFIG_TARGET_MT8188=y
> -CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
> -CONFIG_SYS_LOAD_ADDR=0x4c000000
> -CONFIG_IDENT_STRING="mt8370-evk"
> -# CONFIG_BOARD_INIT is not set
> -CONFIG_CMD_CLK=y
> -CONFIG_CMD_GPT=y
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_PART=y
> -CONFIG_OF_UPSTREAM=y
> -CONFIG_CLK=y
> -CONFIG_MMC_MTK=y
> -CONFIG_PINCTRL=y
> -CONFIG_PINCONF=y
> -CONFIG_PINCTRL_MT8188=y
> -CONFIG_BAUDRATE=921600
> -CONFIG_DM_SERIAL=y
> -CONFIG_MTK_SERIAL=y
> -CONFIG_WDT=y
> -CONFIG_WDT_MTK=y
> -# CONFIG_RANDOM_UUID is not set
> diff --git a/configs/mt8370_genio_510_evk_defconfig b/configs/mt8370_genio_510_evk_defconfig
> new file mode 100644
> index 00000000000..e3530571cc4
> --- /dev/null
> +++ b/configs/mt8370_genio_510_evk_defconfig
> @@ -0,0 +1,5 @@
> +#include <configs/mt8188.config>
> +
> +CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
> +CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
> +CONFIG_IDENT_STRING="mt8370-genio-510-evk"
> diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
> new file mode 100644
> index 00000000000..0b07e3be2c4
> --- /dev/null
> +++ b/configs/mt8390_genio_700_evk_defconfig
> @@ -0,0 +1,4 @@
> +#include <configs/mt8188.config>
> +
> +CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
> +CONFIG_IDENT_STRING="mt8390-genio-700-evk"
> diff --git a/configs/mt8395_evk_defconfig b/configs/mt8395_genio_1200_evk_defconfig
> similarity index 92%
> rename from configs/mt8395_evk_defconfig
> rename to configs/mt8395_genio_1200_evk_defconfig
> index 2edf3cb3e35..2d73af353f7 100644
> --- a/configs/mt8395_evk_defconfig
> +++ b/configs/mt8395_genio_1200_evk_defconfig
> @@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>  CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
>  CONFIG_TARGET_MT8195=y
>  CONFIG_SYS_LOAD_ADDR=0x60000000
> -CONFIG_IDENT_STRING=" mt8395-evk"
> +CONFIG_IDENT_STRING="mt8395-genio-1200-evk"
>  # CONFIG_BOARD_INIT is not set
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
>
> ---
> base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
> change-id: 20260318-rename-genio-defconfigs-bc4070c90e9e
>
> Best regards,
> -- 
> Julien Stephan <jstephan@baylibre.com>
