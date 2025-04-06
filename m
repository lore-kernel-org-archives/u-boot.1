Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D55FC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3176182B53;
	Sun,  6 Apr 2025 17:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hl4e/BJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE05F82B54; Sun,  6 Apr 2025 17:11:39 +0200 (CEST)
Received: from mail-m3279.qiye.163.com (mail-m3279.qiye.163.com
 [220.197.32.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9720982B46
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0205a7;
 Sun, 6 Apr 2025 23:11:31 +0800 (GMT+08:00)
Message-ID: <27124864-a98d-4d37-bb80-b1d39c3e0a98@rock-chips.com>
Date: Sun, 6 Apr 2025 23:11:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/3] rockchip: px30: add fdtoverlay_addr_r default
 value to support FDTO
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
 <20250129-px30-overlay-v1-2-4729b3fcb4c0@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-px30-overlay-v1-2-4729b3fcb4c0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR8dVkNPSx9IHU4aHk8dTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960ba8269203afkunm10d0205a7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6MAw4ODJDLUkTCkk8MzIq
 IzcwFClVSlVKTE9IQk5JSUJJTktCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFKQkhINwY+
DKIM-Signature: a=rsa-sha256;
 b=Hl4e/BJKS17Xy8H06jk/hScNh6lH0Jd4YxUeXSefy4LWBeGrv1OrFHoGO4sPZDEZnzq6ci0WcAWoUrnfK0vRZoXu7BYUIoEgaXdxRXQSDHYQlJRK2RW0QzYCYxzBmoCYNJI2URZwkdEFjdBfzNKydjz9fDlJfXRqa5ovrdq1saU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=CT1vgQPOQkJCrHu/3IaGcodOnRikW0Z5wakneJ2Y6m4=;
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


On 2025/1/29 18:43, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> In order to be able to use Device Tree Overlays, the fdtoverlay_addr_r
> needs to be specified.
>
> Follow what's been done for other Rockchip SoCs and leave 1MiB for the
> base DTB before the address for the overlay.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/configs/px30_common.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/configs/px30_common.h b/include/configs/px30_common.h
> index 13ed9011764b90068ca0a13499271f31c76f4c81..d0539003fd596334d07eee36e03da616cf69ee67 100644
> --- a/include/configs/px30_common.h
> +++ b/include/configs/px30_common.h
> @@ -20,6 +20,7 @@
>   	"scriptaddr=0x00500000\0" \
>   	"pxefile_addr_r=0x00600000\0" \
>   	"fdt_addr_r=0x08300000\0" \
> +	"fdtoverlay_addr_r=0x08400000\0" \
>   	"kernel_addr_r=0x00280000\0" \
>   	"ramdisk_addr_r=0x0a200000\0" \
>   	"kernel_comp_addr_r=0x03e80000\0" \
>
