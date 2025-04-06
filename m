Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38714C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834BD82B54;
	Sun,  6 Apr 2025 17:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XQ8I6oVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D6C82B89; Sun,  6 Apr 2025 17:11:51 +0200 (CEST)
Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com
 [220.197.32.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61EC82B54
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0205b0;
 Sun, 6 Apr 2025 23:11:42 +0800 (GMT+08:00)
Message-ID: <849ce408-d05e-42a0-bfa9-6a80a793dbce@rock-chips.com>
Date: Sun, 6 Apr 2025 23:11:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/3] rockchip: ringneck-px30: enable DT overlay
 support
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
 <20250129-px30-overlay-v1-3-4729b3fcb4c0@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-px30-overlay-v1-3-4729b3fcb4c0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0IaVkhLGR5JHUtCT04YH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960ba850a903afkunm10d0205b0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Tyo6IjJISElJCkkTMzdJ
 ER8KCTpVSlVKTE9IQk5JSEtIS05JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJS0JNNwY+
DKIM-Signature: a=rsa-sha256;
 b=XQ8I6oVQ15T7EHBeYW8Y3qO+co8beHHql7z79kxDYXExh8k+ixEva7FA9Tk4uQohlMReBaDXBfmGQ7JlXNICsTW+aO56HJ/anJA94fHD8VBvNxqp+jaR4rjANN/317P0iYJrySAS6gzVZ6JgsK/UlI3U+lsaW+UYzR7/afpUTp0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=lzqyniLJqB6AIqcJ9sLa18OJ5r5Z7O/OSbiOfLJRKVY=;
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
> Haikou carrierboard allows multiple adapter boards to be connected, for
> now there exists the following adapter boards compatible with PX30
> Ringneck:
>   - Haikou Video Demo on the Video Connector,
>   - Haikou LVDS 9904379 on the Video Connector,
>
> So support DT overlays so we can use this mechanism instead of full DTB
> containing both the carrierboard and the adapter.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index 324581b4082e12e56dc806df64d8dff4deef3067..b6b3d3e2b3f40f58ed44a044e35534e291674236 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -5,6 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-ringneck-haikou"
> +CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_PX30=y
>   # CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
>
