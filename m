Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB823C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 02:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E08687090;
	Thu,  9 Nov 2023 03:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TvQuYoyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92056870DD; Thu,  9 Nov 2023 03:57:41 +0100 (CET)
Received: from mail-m1285.netease.com (mail-m1285.netease.com [103.209.128.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF0B86E2F
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 03:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=TvQuYoyrbKJNJuYVmrxunQDVzo5CNPdE2m9bs4kKAwnUL+oYivicRUi3chL2rZ6VNVYIUXsnoKjSW3+8rEHNJTNUe/HXVVVxdxKwllhfuDsedn0e/QTO0P97UDt8Ldh2RZ5IjySnY6cFAc/Jo7LBWWAajQ9EquNvTm5TREPYJUo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=2eAZM+VDz+qvsTsKyl7mSgNqTgjVfpDJFi8Eb0Da/jc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 853604002F3;
 Thu,  9 Nov 2023 10:57:20 +0800 (CST)
Message-ID: <4fd92938-2d46-4a1c-bc6f-0c2df0204036@rock-chips.com>
Date: Thu, 9 Nov 2023 10:57:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ringneck-px30: enable i2c command
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de, heiko@sntech.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20231025-ringneck-i2c-cmd-v1-1-e8671d1f20e8@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231025-ringneck-i2c-cmd-v1-1-e8671d1f20e8@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IZHVZPSUpOTxpCQkkdSE9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8bb203450f2eb3kusn853604002f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6Lyo*CDw*EwghNwgdITg2
 EDxPChRVSlVKTUJCT0JDTU9KSU1IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSEJJNwY+
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


On 2023/10/25 19:17, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> This is a useful tool to check the presence of a device on a specific
> i2c bus, so let's enable it.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index b4666d0e90f..f47dfa58782 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -53,6 +53,7 @@ CONFIG_SPL_ATF=y
>   # CONFIG_CMD_LZMADEC is not set
>   # CONFIG_CMD_UNZIP is not set
>   CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
>   # CONFIG_CMD_LOADB is not set
>   # CONFIG_CMD_LOADS is not set
>   CONFIG_CMD_MMC=y
>
> ---
> base-commit: 351da15f71e3d70dbc63e90781b403415452d864
> change-id: 20231025-ringneck-i2c-cmd-6417b86bc9a8
>
> Best regards,
