Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC71C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 03:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21BD8714F;
	Thu,  9 Nov 2023 04:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IYLMyRh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C8D8714F; Thu,  9 Nov 2023 04:33:56 +0100 (CET)
Received: from mail-m24125.xmail.ntesmail.com (mail-m24125.xmail.ntesmail.com
 [45.195.24.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51B986EA3
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 04:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IYLMyRh9OebyPS7eZdhoJwdRPNqD6ImYpVBoX7SewYGsWmOzzNurhSfQGf1yL9HM8nJBgHscHG5w6V/KBs3+8lHJ7rRgxTPLmh6HiZjTWDjnhcdvIqDp4Zxo+/9b73UAWq7NZBAxmYCFT5/oYfvYjH4rFTJNnZdLJi+QOn0/GNc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=En3S31XvIWgw9E/cI8132B3eK7+5GtOEY05riKW6FzQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id CA6C54001E7;
 Thu,  9 Nov 2023 11:33:46 +0800 (CST)
Message-ID: <39d822ca-a9a2-4729-b509-cf88828ca0c9@rock-chips.com>
Date: Thu, 9 Nov 2023 11:33:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] rockchip: puma-rk3399: only declare functions in
 U-Boot proper
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-3-cb493bfdeffd@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231108-env_default_theobroma-v1-3-cb493bfdeffd@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpCT1ZNGUtMSE5DHkpLTRlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8bb224a1ab2eb3kusnca6c54001e7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006KAw4FDwyPQg2H0lCTD8t
 SgkKCj9VSlVKTUJCTktLQ0lMTUNJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0JPNwY+
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


On 2023/11/8 22:20, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Those functions are useless in anything but U-Boot proper for now, so
> let's compile them out explicitly.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/puma_rk3399/puma-rk3399.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> index 614a60ee8f9..1b7a39b0474 100644
> --- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> +++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> @@ -26,6 +26,7 @@
>   #include <power/regulator.h>
>   #include <u-boot/sha256.h>
>   
> +#ifndef CONFIG_SPL_BUILD
>   static void setup_iodomain(void)
>   {
>   	const u32 GRF_IO_VSEL_GPIO4CD_SHIFT = 3;
> @@ -192,3 +193,4 @@ int misc_init_r(void)
>   
>   	return 0;
>   }
> +#endif
>
