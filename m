Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB596C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 04:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCBB870C5;
	Tue,  7 Nov 2023 05:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="I/Y9rGf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C68F86CB1; Tue,  7 Nov 2023 05:02:44 +0100 (CET)
Received: from mail-m17236.xmail.ntesmail.com (mail-m17236.xmail.ntesmail.com
 [45.195.17.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43968709A
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 05:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=I/Y9rGf4tMVg59JH5bkaYNsfkZsJaYvjEQjYV7od5XWKTo2q7vBPe0IWQEh9G3IzCtl/ZQ0Mw+BB5rgHEPBVM8DoiO0teS0b6fgE2jn6a3Kj1MZVTqVDNmVlEjyrD3df4i8P9zhhTeml6oNyM3XN+EfUoescIlfBwvYL05P9rW4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=bz7HuaEqqyAzUg9obZfAboVlnPeFWx27MjFniXF8374=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 90CE7400231;
 Tue,  7 Nov 2023 12:02:27 +0800 (CST)
Message-ID: <5a529a07-f091-414b-988a-a180f12d2d32@rock-chips.com>
Date: Tue, 7 Nov 2023 12:02:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: ringneck-px30: enable SPL_BOARD_INIT
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
References: <20231103-ringneck-stm32-reset-v2-0-a0e5559f89bf@theobroma-systems.com>
 <20231103-ringneck-stm32-reset-v2-2-a0e5559f89bf@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231103-ringneck-stm32-reset-v2-2-a0e5559f89bf@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4dHVYZT05JQx5JSE1IHR9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8ba7f22b512eb3kusn90ce7400231
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46PBw5Ejw8IRUeLy0sMToS
 Mi8wCRpVSlVKTUJCSElCTE9DSE5JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTExJNwY+
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


On 2023/11/3 17:28, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Now that Ringneck requires some board-specific code (namely resetting
> the MCU companion controller) to be run during SPL stage, let's enable
> SPL_BOARD_INIT.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index b4666d0e90f..420c9cd1e89 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -38,6 +38,7 @@ CONFIG_SPL_PAD_TO=0x0
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0x4000000
>   CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_BOARD_INIT=y
>   CONFIG_SPL_BOOTROM_SUPPORT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>
