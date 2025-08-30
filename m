Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A698CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A97E483043;
	Sat, 30 Aug 2025 16:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CPiXXmdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724E98380E; Sat, 30 Aug 2025 16:34:52 +0200 (CEST)
Received: from mail-m49233.qiye.163.com (mail-m49233.qiye.163.com
 [45.254.49.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA4B82E34
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123985b7;
 Sat, 30 Aug 2025 22:34:45 +0800 (GMT+08:00)
Message-ID: <dcc14a6b-7e20-48d3-9549-4f8b12545206@rock-chips.com>
Date: Sat, 30 Aug 2025 22:34:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rk3288: add fdtoverlay_addr_r to default env
To: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20250611110454.23428-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250611110454.23428-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb66f40303afkunm3907eeeb406e4d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQh0aVkpMTEJJGh5PSxkeTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=CPiXXmdcENX7EhA+J8yh+prvYdUJvsoRfnsb1Lz0pFWIcS69UkP6Prvuh4V33FopbYPL2ijZ3INx5tb9qp69f22rKY9FckVZ73AOExtsbJ6RlhqvviQU8lQyP7vEftMX0OVoX1IYe1pOELbSjoxKf2viHsUd8zqNNQrCi6t16Pk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=cpxUlUcWoSXMSjRwP+D6n8AEbmkymq2YqtVYo0fnQiM=;
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


On 2025/6/11 19:04, Marius Dinu wrote:
> rk3288 is missing fdtoverlay_addr_r.
> The new addresses match those used by rk3308.
> Tested on Asus TinkerBoard S.
>
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/configs/rk3288_common.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_common.h
> index 0c449e31099..52c3695ff8e 100644
> --- a/include/configs/rk3288_common.h
> +++ b/include/configs/rk3288_common.h
> @@ -18,7 +18,8 @@
>   #define ENV_MEM_LAYOUT_SETTINGS \
>   	"scriptaddr=0x00000000\0" \
>   	"pxefile_addr_r=0x00100000\0" \
> -	"fdt_addr_r=0x01f00000\0" \
> +	"fdt_addr_r=0x01e00000\0" \
> +	"fdtoverlay_addr_r=0x01f00000\0" \
>   	"kernel_addr_r=0x02000000\0" \
>   	"ramdisk_addr_r=0x04000000\0"
>   
