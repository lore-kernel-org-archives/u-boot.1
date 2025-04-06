Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2102C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4772E82B9D;
	Sun,  6 Apr 2025 17:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GSbdQNcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0CB82C03; Sun,  6 Apr 2025 17:34:23 +0200 (CEST)
Received: from mail-m32103.qiye.163.com (mail-m32103.qiye.163.com
 [220.197.32.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA8F82B6C
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0680e5;
 Sun, 6 Apr 2025 23:34:17 +0800 (GMT+08:00)
Message-ID: <8618e564-d02c-4d20-8ff4-9267647c852c@rock-chips.com>
Date: Sun, 6 Apr 2025 23:34:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] rockchip: Add SPL_PAD_TO Kconfig default value
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk9JVh9NGB9LSEhNTk0YHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bbcff9f03afkunm10d0680e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6ORw4LzJRD0kpGT0UPEM6
 VjcKCglVSlVKTE9IQk5ITU5DTENIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJSkpPNwY+
DKIM-Signature: a=rsa-sha256;
 b=GSbdQNcbKUJB4sA3Rsze7JpvvZQBGNu3eHAQSLDhgtXRsGabAPSSCD6V0Fx4WnOvoReEYkcoeqQkTjnL72ilowWNc1cXQPpTguwzwIeFYEgqKMz50N7EGproVG68d19lBvFhOMc8nSH+v1YlR2KfePlBlq4reCPqyDUTrDjKV8k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=NG3PlK1X2uPdog0Z95OKXlxolXYdl49gvjh3jHg7Kto=;
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


On 2025/3/29 23:06, Jonas Karlman wrote:
> Almost all Rockchip boards use the same Kconfig value for SPL_PAD_TO,
> 0x7f8000.
>
> Add this value as a default value for ARCH_ROCKCHIP.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - New patch
>
> This patch does not drop SPL_PAD_TO from existing defconfigs that would
> be affected by this change, something that can wait until next "configs:
> Resync with savedefconfig".
>
> Following boards does not set a SPL_PAD_TO due to not using SPL:
> - elgin-rv1108_defconfig
> - evb-rk3128_defconfig
> - evb-rv1108_defconfig
> - geekbox_defconfig
> - sheep-rk3368_defconfig
> ---
>   common/spl/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 97f542fcc8a5..322fc3cbdced 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -97,6 +97,7 @@ config SPL_MAX_SIZE
>   
>   config SPL_PAD_TO
>   	hex "Offset to which the SPL should be padded before appending the SPL payload"
> +	default 0x7f8000 if ARCH_ROCKCHIP
>   	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>   	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
>   	default 0x10000 if ARCH_KEYSTONE
