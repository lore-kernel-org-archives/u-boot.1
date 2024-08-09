Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A453C52D7F
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7081088C19;
	Fri,  9 Aug 2024 11:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="T7mxd21B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 294A0885B3; Fri,  9 Aug 2024 11:55:09 +0200 (CEST)
Received: from mail-m127169.xmail.ntesmail.com
 (mail-m127169.xmail.ntesmail.com [115.236.127.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74F4885B3
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=T7mxd21BdCrvEdXMqD/XZ+PKOgSedn6nYkDpxKWD636sSOgH0y1Rrb6FO3t6HNNjdEvTkTvVL6GYdJ1uU7GcabOEnHOAMqYenh+ebyy+13XN5ijEOr7N6smdvT1WICvQ+lc9y1Okzvhjbmhm8vQiWcIiHnZ1QeXYNP6WbAMwPes=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=h75KZjJuc5+nH4rQygMWzpts2xJ0n9O374hq8gqmKXQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 639AC900652;
 Fri,  9 Aug 2024 17:54:57 +0800 (CST)
Message-ID: <0c36492b-8e10-4e2d-a55a-1c1bb9e51a66@rock-chips.com>
Date: Fri, 9 Aug 2024 17:54:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: enable "ums" command for Radxa ROCK 5B
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: eugen.hristev@collabora.com, jonas@kwiboo.se
References: <20240806034759.50646-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240806034759.50646-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHU1DVk4YSE0ZQxgYGUwdSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91369016a303a9kunm639ac900652
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06Kjo4NTI2NQ5NSyEPOT8a
 MTQKFApVSlVKTElISkJMSUJDQkxKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpCSEI3Bg++
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


On 2024/8/6 11:47, FUKAUMI Naoki wrote:
> USB Type-C port is configured as "peripheral" port. so enable "ums"
> command to use as USB Mass Storage device.
> ("rockusb" command is already enabled and working)
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/rock5b-rk3588_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index fc118cea7ba..80a2f2fed58 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -39,6 +39,7 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
