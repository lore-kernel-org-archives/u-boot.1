Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ED4C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 10:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C7786F70;
	Wed, 25 Oct 2023 12:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2778A8722C; Wed, 25 Oct 2023 12:41:44 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE3C86E8A
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 12:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875a19.versanet.de ([83.135.90.25] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1qvbKT-0005AE-UL; Wed, 25 Oct 2023 12:41:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 2/2] rockchip: ringneck-px30: enable SPL_BOARD_INIT
Date: Wed, 25 Oct 2023 12:41:37 +0200
Message-ID: <20462913.Yz81rIOvuz@diego>
In-Reply-To: <20231025-ringneck-stm32-reset-v1-2-052562bec53f@theobroma-systems.com>
References: <20231025-ringneck-stm32-reset-v1-0-052562bec53f@theobroma-systems.com>
 <20231025-ringneck-stm32-reset-v1-2-052562bec53f@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Mittwoch, 25. Oktober 2023, 11:51:15 CEST schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Now that Ringneck requires some board-specific code (namely resetting
> the MCU companion controller) to be run during SPL stage, let's enable
> SPL_BOARD_INIT.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  configs/ringneck-px30_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index b4666d0e90f..420c9cd1e89 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -38,6 +38,7 @@ CONFIG_SPL_PAD_TO=0x0
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>  CONFIG_SPL_BSS_START_ADDR=0x4000000
>  CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_BOARD_INIT=y
>  CONFIG_SPL_BOOTROM_SUPPORT=y
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> 
> 




