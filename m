Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0F2C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 06:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DBE088C3A;
	Thu,  2 May 2024 08:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714629758;
	bh=eTQVfBgzCzH1N37ZI5jFDG4CqVi3bIizu9OHRB4kAsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QZ2STjWuSuFuTeh81zVj3Mju8/8MuyiB4w/MgTz7t1xMGi2s/a34Sd2DKyu+yQ2Lg
	 8Uny6uzRVxGpvzRWmg9OgGwFhy6iqXU6ThScHSoD3i4XhRA86tuvYvIEfpJbhHtNAF
	 jJH9MBz24SkotTUNEvWSuhBwMhwix2M6yIB0MGI9EU8jKzwMKl+gILiM7ne4xXvXCG
	 cZua5c8z6V0PQuD8QD+QTjST2D2uE8gLGQfqMbP6b5Dbimt3oK1lw55lUWebGe//yr
	 uEBZ1AW53hTxEC+JKGg49TSh046yiNzeOVABC8YxbJ2W/mPeDWQzXRUprxO2vP3UPV
	 XcDjq8HiaV5Uw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2458F88C31; Thu,  2 May 2024 08:02:37 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6698988305
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 08:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VVNd40KZMz9sRn;
 Thu,  2 May 2024 08:02:32 +0200 (CEST)
Message-ID: <98205e85-5d4f-411c-bf7e-c0cf417ef062@denx.de>
Date: Thu, 2 May 2024 08:02:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 010/149] board: Marvell: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tony Dinh <mibodhi@gmail.com>, Jason Cooper <u-boot@lakedaemon.net>,
 Siddarth Gore <gores@marvell.com>, Aaron Williams <awilliams@marvell.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-10-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240501024316.1767971-10-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VVNd40KZMz9sRn
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

On 5/1/24 04:40, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <sr@denx.de>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Tony Dinh <mibodhi@gmail.com>
> Cc: Jason Cooper <u-boot@lakedaemon.net>
> Cc: Siddarth Gore <gores@marvell.com>
> Cc: Aaron Williams <awilliams@marvell.com>
> ---
>   arch/arm/mach-kirkwood/include/mach/mpp.h     | 2 ++
>   board/Marvell/db-88f6720/db-88f6720.c         | 1 -
>   board/Marvell/db-88f6820-amc/db-88f6820-amc.c | 2 +-
>   board/Marvell/db-88f6820-gp/db-88f6820-gp.c   | 2 +-
>   board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c   | 1 -
>   board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c   | 1 -
>   board/Marvell/dreamplug/dreamplug.c           | 1 -
>   board/Marvell/guruplug/guruplug.c             | 1 -
>   board/Marvell/mvebu_alleycat-5/board.c        | 2 +-
>   board/Marvell/mvebu_armada-37xx/board.c       | 2 +-
>   board/Marvell/mvebu_armada-8k/board.c         | 2 +-
>   board/Marvell/octeontx2/soc-utils.c           | 1 -
>   board/Marvell/openrd/openrd.c                 | 1 -
>   board/Marvell/sheevaplug/sheevaplug.c         | 1 -
>   14 files changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> diff --git a/arch/arm/mach-kirkwood/include/mach/mpp.h b/arch/arm/mach-kirkwood/include/mach/mpp.h
> index 4d1f58c0cbdf..e2757942590b 100644
> --- a/arch/arm/mach-kirkwood/include/mach/mpp.h
> +++ b/arch/arm/mach-kirkwood/include/mach/mpp.h
> @@ -8,6 +8,8 @@
>   #ifndef __KIRKWOOD_MPP_H
>   #define __KIRKWOOD_MPP_H
>   
> +#include <linux/types.h>
> +
>   #define MPP(_num, _sel, _in, _out, _F6180, _F6190, _F6192, _F6281) ( \
>   	/* MPP number */		((_num) & 0xff) | \
>   	/* MPP select value */		(((_sel) & 0xf) << 8) | \
> diff --git a/board/Marvell/db-88f6720/db-88f6720.c b/board/Marvell/db-88f6720/db-88f6720.c
> index 26c30647fbb0..920421366f11 100644
> --- a/board/Marvell/db-88f6720/db-88f6720.c
> +++ b/board/Marvell/db-88f6720/db-88f6720.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <miiphy.h>
>   #include <net.h>
> diff --git a/board/Marvell/db-88f6820-amc/db-88f6820-amc.c b/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
> index 122c63d11f99..0f92cc385bc8 100644
> --- a/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
> +++ b/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
> @@ -3,7 +3,7 @@
>    * Copyright (C) 2015 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <i2c.h>
>   #include <init.h>
>   #include <miiphy.h>
> diff --git a/board/Marvell/db-88f6820-gp/db-88f6820-gp.c b/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
> index 1edc1cb6515c..8f8b2720107a 100644
> --- a/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
> +++ b/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
> @@ -3,7 +3,7 @@
>    * Copyright (C) 2015 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <i2c.h>
>   #include <init.h>
>   #include <miiphy.h>
> diff --git a/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c b/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
> index 9e1fdecfca4d..6bca1f91a0a4 100644
> --- a/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
> +++ b/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2014 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <miiphy.h>
>   #include <net.h>
> diff --git a/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c b/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
> index 0abdca1cd210..a7a84798a53b 100644
> --- a/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
> +++ b/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2015 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <i2c.h>
>   #include <init.h>
>   #include <asm/global_data.h>
> diff --git a/board/Marvell/dreamplug/dreamplug.c b/board/Marvell/dreamplug/dreamplug.c
> index d15faa1cb7ff..381275061318 100644
> --- a/board/Marvell/dreamplug/dreamplug.c
> +++ b/board/Marvell/dreamplug/dreamplug.c
> @@ -8,7 +8,6 @@
>    * Written-by: Siddarth Gore <gores@marvell.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <netdev.h>
>   #include <asm/arch/cpu.h>
> diff --git a/board/Marvell/guruplug/guruplug.c b/board/Marvell/guruplug/guruplug.c
> index ea87ded222e6..7c3cea22b936 100644
> --- a/board/Marvell/guruplug/guruplug.c
> +++ b/board/Marvell/guruplug/guruplug.c
> @@ -5,7 +5,6 @@
>    * Written-by: Siddarth Gore <gores@marvell.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <miiphy.h>
>   #include <net.h>
> diff --git a/board/Marvell/mvebu_alleycat-5/board.c b/board/Marvell/mvebu_alleycat-5/board.c
> index 0c4f8e03b859..c1b7cc3b613c 100644
> --- a/board/Marvell/mvebu_alleycat-5/board.c
> +++ b/board/Marvell/mvebu_alleycat-5/board.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -#include <common.h>
> +#include <config.h>
>   #include <asm/global_data.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
> index 1685b12b8478..df3fb6d21645 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -3,7 +3,7 @@
>    * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <dm/device-internal.h>
>   #include <env.h>
> diff --git a/board/Marvell/mvebu_armada-8k/board.c b/board/Marvell/mvebu_armada-8k/board.c
> index a8899af6e5af..6d7042117424 100644
> --- a/board/Marvell/mvebu_armada-8k/board.c
> +++ b/board/Marvell/mvebu_armada-8k/board.c
> @@ -3,7 +3,7 @@
>    * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <init.h>
> diff --git a/board/Marvell/octeontx2/soc-utils.c b/board/Marvell/octeontx2/soc-utils.c
> index 43a19a90717c..64eb95f3b400 100644
> --- a/board/Marvell/octeontx2/soc-utils.c
> +++ b/board/Marvell/octeontx2/soc-utils.c
> @@ -5,7 +5,6 @@
>    * https://spdx.org/licenses
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <malloc.h>
>   #include <errno.h>
> diff --git a/board/Marvell/openrd/openrd.c b/board/Marvell/openrd/openrd.c
> index 581e2e084d6f..dda56a582b3e 100644
> --- a/board/Marvell/openrd/openrd.c
> +++ b/board/Marvell/openrd/openrd.c
> @@ -10,7 +10,6 @@
>    * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <miiphy.h>
>   #include <net.h>
> diff --git a/board/Marvell/sheevaplug/sheevaplug.c b/board/Marvell/sheevaplug/sheevaplug.c
> index 26ee39ef77f9..23e761d5febf 100644
> --- a/board/Marvell/sheevaplug/sheevaplug.c
> +++ b/board/Marvell/sheevaplug/sheevaplug.c
> @@ -6,7 +6,6 @@
>    * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <netdev.h>
>   #include <asm/global_data.h>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
