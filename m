Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1AAC10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57968817B;
	Fri, 10 May 2024 02:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JyCshnaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80B18804F; Fri, 10 May 2024 02:40:23 +0200 (CEST)
Received: from mail-m1287.netease.com (mail-m1287.netease.com [103.209.128.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461618804F
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JyCshnaXvj7gsftHbhN6xH6PBdy99bnDsuy3VytgEawKd/7/NkmlsbcgdmOvSRx+mgKkW1uTufIQ8iuFR3osW1+nOLPyfLUInoKZeUS25DZe3+fPxRZ89O91kq2q34pEjFgYsGR9DkDOeuQ1NJdd+CS6NlCYVGRAo+tlBbXGLPk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=rLkFP7jpqw99RLTxD4CDpxSxX7AzryZpsdlOBgU88as=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 93A4A90019D;
 Fri, 10 May 2024 08:40:02 +0800 (CST)
Message-ID: <96e1c16b-2ec4-45de-8002-8806791d8129@rock-chips.com>
Date: Fri, 10 May 2024 08:40:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/81] block: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Tobias Waldekranz <tobias@waldekranz.com>, Simon Glass
 <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bin Meng <bmeng@tinylab.org>,
 Johan Jonker <jbx6244@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-14-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-14-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5OQlZOGEweSB9MGk0aQ01VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff1572103a9kunm93a4a90019d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MyI6Tyo*MTNNSQIzCTA8Ly0K
 Cg1PFBpVSlVKTEpOSEtKTUtITkxLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNQ05NNwY+
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


On 2024/5/2 09:30, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tobias Waldekranz <tobias@waldekranz.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Bin Meng <bmeng@tinylab.org>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   drivers/block/blk-uclass.c       | 1 -
>   drivers/block/blk_legacy.c       | 1 -
>   drivers/block/blkcache.c         | 1 -
>   drivers/block/blkmap.c           | 1 -
>   drivers/block/efi-media-uclass.c | 1 -
>   drivers/block/efi_blk.c          | 1 -
>   drivers/block/host-uclass.c      | 1 -
>   drivers/block/host_dev.c         | 1 -
>   drivers/block/ide.c              | 1 -
>   drivers/block/sandbox.c          | 1 -
>   drivers/block/sb_efi_media.c     | 1 -
>   11 files changed, 11 deletions(-)
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 77066da352a3..512c952f4d7a 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_BLK
>   
> -#include <common.h>
>   #include <blk.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/block/blk_legacy.c b/drivers/block/blk_legacy.c
> index 5bf1d0471524..f36932183d1f 100644
> --- a/drivers/block/blk_legacy.c
> +++ b/drivers/block/blk_legacy.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <blk.h>
>   #include <part.h>
>   #include <linux/err.h>
> diff --git a/drivers/block/blkcache.c b/drivers/block/blkcache.c
> index 26bcbea43533..0e69160249c7 100644
> --- a/drivers/block/blkcache.c
> +++ b/drivers/block/blkcache.c
> @@ -4,7 +4,6 @@
>    * Author: Eric Nelson<eric@nelint.com>
>    *
>    */
> -#include <common.h>
>   #include <blk.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 21201409ed4b..34eed1380dca 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -4,7 +4,6 @@
>    * Author: Tobias Waldekranz <tobias@waldekranz.com>
>    */
>   
> -#include <common.h>
>   #include <blk.h>
>   #include <blkmap.h>
>   #include <dm.h>
> diff --git a/drivers/block/efi-media-uclass.c b/drivers/block/efi-media-uclass.c
> index e012f6f2f4c4..dc5e4f59b7f3 100644
> --- a/drivers/block/efi-media-uclass.c
> +++ b/drivers/block/efi-media-uclass.c
> @@ -5,7 +5,6 @@
>    * Copyright 2021 Google LLC
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   
>   UCLASS_DRIVER(efi_media) = {
> diff --git a/drivers/block/efi_blk.c b/drivers/block/efi_blk.c
> index 917a19f60254..9766cd6f8327 100644
> --- a/drivers/block/efi_blk.c
> +++ b/drivers/block/efi_blk.c
> @@ -8,7 +8,6 @@
>    * Copyright 2021 Google LLC
>    */
>   
> -#include <common.h>
>   #include <blk.h>
>   #include <dm.h>
>   #include <efi.h>
> diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
> index b3647e3ce335..cf42bd1e07ac 100644
> --- a/drivers/block/host-uclass.c
> +++ b/drivers/block/host-uclass.c
> @@ -9,7 +9,6 @@
>   
>   #define LOG_CATEGORY UCLASS_HOST
>   
> -#include <common.h>
>   #include <blk.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
> index 52313435a0cb..b3ff3cd1fab9 100644
> --- a/drivers/block/host_dev.c
> +++ b/drivers/block/host_dev.c
> @@ -9,7 +9,6 @@
>   
>   #define LOG_CATEGORY UCLASS_HOST
>   
> -#include <common.h>
>   #include <blk.h>
>   #include <bootdev.h>
>   #include <dm.h>
> diff --git a/drivers/block/ide.c b/drivers/block/ide.c
> index c698f9cbd558..b16623d7a3ab 100644
> --- a/drivers/block/ide.c
> +++ b/drivers/block/ide.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_IDE
>   
> -#include <common.h>
>   #include <ata.h>
>   #include <blk.h>
>   #include <bootdev.h>
> diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
> index be4e02cb601a..ec34f1ad8c2e 100644
> --- a/drivers/block/sandbox.c
> +++ b/drivers/block/sandbox.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2013 Henrik Nordstrom <henrik@henriknordstrom.net>
>    */
>   
> -#include <common.h>
>   #include <blk.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/block/sb_efi_media.c b/drivers/block/sb_efi_media.c
> index 52af155a6001..3255db064961 100644
> --- a/drivers/block/sb_efi_media.c
> +++ b/drivers/block/sb_efi_media.c
> @@ -5,7 +5,6 @@
>    * Copyright 2021 Google LLC
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   
>   static const struct udevice_id sandbox_efi_media_ids[] = {
