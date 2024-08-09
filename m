Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F0BC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2419688B80;
	Fri,  9 Aug 2024 11:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CpKq0R2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEDC887E6; Fri,  9 Aug 2024 11:25:27 +0200 (CEST)
Received: from mail-m11883.qiye.163.com (mail-m11883.qiye.163.com
 [115.236.118.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F1C88B81
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CpKq0R2UhanYFvcfRhO2VSZT1TeQIp8HjNLYDnoAzrdq+JLFODD56so3TJmduxCMavQKSl8bI8o64504BB8VZRgaFOVchBJCe7Od/6qSkCGAAlORbqDk0hEKCQzd7nj/EIfV/uX7xkGDyWIciW4agBMQIBwFpE/5JYyJIZ9EO9c=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=wHbS/ysiLFglNvcQ8FU6bP3A5lL88sAwrCf50jlUE/Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 3A4B1900603;
 Fri,  9 Aug 2024 17:25:17 +0800 (CST)
Message-ID: <2999cdc3-a059-4f49-949a-fd46b63edbd9@rock-chips.com>
Date: Fri, 9 Aug 2024 17:25:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] board: rock5b-rk3588: enable USB-C in operating
 system
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-5-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802180027.139193-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUlMVkJLQ0MfSkgYQh8ZQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913674ed2b03a9kunm3a4b1900603
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46Mxw4SzIwMQ5CAUlODA4U
 MjIKCzBVSlVKTElISkJOTkpDQ0xKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhKTUg3Bg++
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


On 2024/8/3 01:59, Sebastian Reichel wrote:
> Since older U-Boot releases do not negotiate USB PD, the kernel
> DT may not enable the USB-C controller by default to avoid a
> regression. The plan is to upstream it with 'status = "fail";'
> instead. U-Boot should then mark it as 'status = "okay";' if
> it negotiated USB PD. Currently existing upstream kernel DTs do
> not yet have the USB-C controller at all, so we ignore any
> failures.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> index 1c17ae93c76c..4e926ebf2cb0 100644
> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -3,6 +3,8 @@
>    * Copyright (c) 2023-2024 Collabora Ltd.
>    */
>   
> +#include <fdtdec.h>
> +#include <fdt_support.h>
>   #include <usb/tcpm.h>
>   
>   #ifdef CONFIG_MISC_INIT_R
> @@ -33,3 +35,12 @@ int misc_init_r(void)
>   	return 0;
>   }
>   #endif
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	if (IS_ENABLED(CONFIG_MISC_INIT_R))
> +		fdt_status_okay_by_compatible(blob, "fcs,fusb302");
> +	return 0;
> +}
> +#endif
