Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E64C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 01:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AAD86C0E;
	Fri, 18 Aug 2023 03:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A6386C0B; Fri, 18 Aug 2023 03:14:32 +0200 (CEST)
Received: from mail-m127102.qiye.163.com (mail-m127102.qiye.163.com
 [115.236.127.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9404886BF8
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 03:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m127102.qiye.163.com (Hmail) with ESMTPA id C74A16C019F;
 Fri, 18 Aug 2023 09:14:06 +0800 (CST)
Message-ID: <aaa2e1a7-a8a9-fa1f-f10b-b780045315d7@rock-chips.com>
Date: Fri, 18 Aug 2023 09:14:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] rockchip: rk3566-anbernic-rgxx3: Rename defconfig to
 include SoC name
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Chris Morgan <macromorgan@hotmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20230817215245.692612-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230817215245.692612-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJNS1ZLHUNPQx4YTUlLTktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8a0634eee5b280kuuuc74a16c019f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6Syo4UT1PCgILHTcfKBoz
 MxUwC0lVSlVKTUJJSElKSU9MSExIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUlNNwY+
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


On 2023/8/18 05:52, Jonas Karlman wrote:
> Rename defconfig to include SoC name, use similar pattern as other
> RK356x boards: <soc>-<name>.dts -> <name>-<soc>_defconfig
>
> Suggested-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/anbernic/rgxx3_rk3566/MAINTAINERS                         | 2 +-
>   ...anbernic-rgxx3_defconfig => anbernic-rgxx3-rk3566_defconfig} | 0
>   doc/board/rockchip/rockchip.rst                                 | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename configs/{anbernic-rgxx3_defconfig => anbernic-rgxx3-rk3566_defconfig} (100%)
>
> diff --git a/board/anbernic/rgxx3_rk3566/MAINTAINERS b/board/anbernic/rgxx3_rk3566/MAINTAINERS
> index 6be16a47e8eb..7970e5a4aad7 100644
> --- a/board/anbernic/rgxx3_rk3566/MAINTAINERS
> +++ b/board/anbernic/rgxx3_rk3566/MAINTAINERS
> @@ -3,7 +3,7 @@ M:	Chris Morgan <macromorgan@hotmail.com>
>   S:	Maintained
>   F:	board/anbernic/rgxx3_rk3566
>   F:	include/configs/anbernic-rgxx3-rk3566.h
> -F:	configs/anbernic-rgxx3_defconfig
> +F:	configs/anbernic-rgxx3-rk3566_defconfig
>   F:	arch/arm/dts/rk3566-anbernic-rgxx3.dts
>   F:	arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
>   F:	arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> diff --git a/configs/anbernic-rgxx3_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> similarity index 100%
> rename from configs/anbernic-rgxx3_defconfig
> rename to configs/anbernic-rgxx3-rk3566_defconfig
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 4668e598515e..de9fe8e642b1 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -91,7 +91,7 @@ List of mainline supported Rockchip boards:
>        - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
>   
>   * rk3566
> -     - Anbernic RGxx3 (anbernic-rgxx3)
> +     - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
>        - Pine64 Quartz64-A Board (quartz64-a-rk3566)
>        - Pine64 Quartz64-B Board (quartz64-b-rk3566)
>        - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
