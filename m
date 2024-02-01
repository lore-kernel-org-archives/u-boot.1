Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F2CC47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F0087C7B;
	Thu,  1 Feb 2024 04:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kxbagDqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A44287C87; Thu,  1 Feb 2024 04:19:37 +0100 (CET)
Received: from mail-m3296.qiye.163.com (mail-m3296.qiye.163.com
 [220.197.32.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7AB8799C
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kxbagDqfZR1CoMzl+drmRUYa4+DO33gjgUkyj3SCVkvjosOdpFTwD7fBc+zlDl8yCMr6XbB3T1mPwFqUFdFKvRnfurdM8z1Ov85rbqtJeRe4SCpfeLPRPLCi+DfLELro/zMsmFrdUOjbumf4IeWGBRk1pqdTGhAKYMub4NfsXW8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=jh/EBp1oilNnQLyr9dOg4tmX1b8+MHPvXpbuuBLFlCo=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6330D9001C2;
 Thu,  1 Feb 2024 11:19:21 +0800 (CST)
Message-ID: <1b2996c7-d5e8-42f4-b979-606f90db8880@rock-chips.com>
Date: Thu, 1 Feb 2024 11:19:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] rockchip: rv1126: Move RAM disk address
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@edgeble.ai>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240124032602.126059-1-tim@feathertop.org>
 <20240124032602.126059-7-tim@feathertop.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240124032602.126059-7-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxgeVhpDGR8fGkodS0NLQlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8d62ad9e9803a9kunm6330d9001c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6Mjo*SjMUDE0vSxUCAwsL
 Ci4KFBBVSlVKTEtNTE5MTk1JT0tPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlKTEw3Bg++
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


On 2024/1/24 11:26, Tim Lunn wrote:
> OPTEE gets loaded into a memory region overlapping with the ram disk.
>
> Fix the ramdisk address so it doesn't overlap with the OPTEE memory
> region.
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> ---
>
> (no changes since v1)
>
>   include/configs/rv1126_common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/configs/rv1126_common.h b/include/configs/rv1126_common.h
> index 168cd8b167..ea290f763c 100644
> --- a/include/configs/rv1126_common.h
> +++ b/include/configs/rv1126_common.h
> @@ -26,7 +26,7 @@
>   	"fdt_addr_r=0x08300000\0" \
>   	"fdtoverlay_addr_r=0x02000000\0" \
>   	"kernel_addr_r=0x02008000\0" \
> -	"ramdisk_addr_r=0x0a200000\0"
> +	"ramdisk_addr_r=0x0a400000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS \
>   	"fdt_high=0x0fffffff\0" \
