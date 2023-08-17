Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AD0C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC6586A68;
	Thu, 17 Aug 2023 10:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E1586A68; Thu, 17 Aug 2023 10:32:55 +0200 (CEST)
Received: from mail-m127102.qiye.163.com (mail-m127102.qiye.163.com
 [115.236.127.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C560486A4F
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m127102.qiye.163.com (Hmail) with ESMTPA id D6A1F6C01D2;
 Thu, 17 Aug 2023 16:32:41 +0800 (CST)
Message-ID: <32a6441a-cafe-2cef-7b36-cad3fb0232c3@rock-chips.com>
Date: Thu, 17 Aug 2023 16:32:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] doc: rockchip: Add supported RK3566/RK3568 boards
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230817060422.477759-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklLHVZJSUNJGUlOGUkYSUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8a02a01bf6b280kuuud6a1f6c01d2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46GQw5NT1WSwNONwg4NTI0
 Ti0wCxpVSlVKTUJJSU1KSk1JT0lMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUNJNwY+
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

Hi Jonas,

     Thanks for your patch.

On 2023/8/17 14:04, Jonas Karlman wrote:
> Update Rockchip documentation to include RK3566/RK3568 boards already
> supported. Also list Pine64 boards under RK3566 and drop defconfig to
> match other listed boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   doc/board/rockchip/rockchip.rst | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 31aeb8567607..4668e598515e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -91,18 +91,22 @@ List of mainline supported Rockchip boards:
>        - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
>   
>   * rk3566
> -     - Anbernic RGxx3 (rgxx3-rk3566)
> +     - Anbernic RGxx3 (anbernic-rgxx3)

This board is using anbernic-rgxx3 as defconfig name, but I would prefer 
update this defconfig to

use name rgxx3-rk3566_defconfig instead, to follow all the other boards 
with SoC name.


Thanks,

- Kever

> +     - Pine64 Quartz64-A Board (quartz64-a-rk3566)
> +     - Pine64 Quartz64-B Board (quartz64-b-rk3566)
> +     - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
> +     - Pine64 SOQuartz on CM4-IO (soquartz-cm4-rk3566)
> +     - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566)
> +     - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
>   
>   * rk3568
>        - Rockchip Evb-RK3568 (evb-rk3568)
> -     - EmbedFire Lubancat 2 (lubancat-2-rk3568_defconfig)
> +     - EmbedFire LubanCat 2 (lubancat-2-rk3568)
> +     - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
> +     - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
>        - Hardkernel ODROID-M1 (odroid-m1-rk3568)
> -     - Pine64 Quartz64-A Board (quartz64-a-rk3566_defconfig)
> -     - Pine64 Quartz64-B Board (quartz64-b-rk3566_defconfig)
> -     - Pine64 SOQuartz on Blade (soquartz-blade-rk3566_defconfig)
> -     - Pine64 SOQuartz on CM4-IO (soquartz-cm4-rk3566_defconfig)
> -     - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566_defconfig)
> -     - Radxa E25 Carrier Board (radxa-e25-rk3568_defconfig)
> +     - Radxa E25 Carrier Board (radxa-e25-rk3568)
> +     - Radxa ROCK 3 Model A (rock-3a-rk3568)
>   
>   * rk3588
>        - Rockchip EVB (evb-rk3588)
