Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAE7E94139
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 02:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23D7867EF;
	Sat,  7 Oct 2023 04:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BmjqCUGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B20869F5; Sat,  7 Oct 2023 04:48:16 +0200 (CEST)
Received: from mail-m12736.qiye.163.com (mail-m12736.qiye.163.com
 [115.236.127.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A393C85894
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 04:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BmjqCUGMIXKAZhmDMrfD1v6Z9gP55H2qsbvBECgAItj7UwCMAdj6RGzDYf5D1NoMoytXpK91vwy9RFb0yAduwHSsEqo2fmWvWGlJ/D8BEr4KjssnaOsqH7oXeUtKJcgAwkc5jwgfNTeuQMGlz8q9lhqX+xtFoj8hSBTRfeSMFMA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=MrHMvWJL9q0IWATA7h6jeW5Jd/jXBvfw3Hi007Fmpjs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 9C2974001DE;
 Sat,  7 Oct 2023 10:47:30 +0800 (CST)
Message-ID: <ac3eb083-76ad-e960-63a8-dfbbd90896c7@rock-chips.com>
Date: Sat, 7 Oct 2023 10:47:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] configs: rockchip: rk3308: enable
 CONFIG_OF_LIBFDT_OVERLAY
Content-Language: en-US
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: andy.yan@rock-chips.com, gajjar04akash@gmail.com, sjg@chromium.org,
 jonas@kwiboo.se
References: <20230911100121.122228-1-naoki@radxa.com>
 <20230911100121.122228-2-naoki@radxa.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230911100121.122228-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhpNHlZLGUIYSE1IH0pJGU9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b0808691c2eb3kusn9c2974001de
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6Cio4DDw1TRksFTNJEBNJ
 MktPFA1VSlVKTUJNTU9NQ05KTUJMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEpLNwY+
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


On 2023/9/11 18:01, FUKAUMI Naoki wrote:
> enable CONFIG_OF_LIBFDT_OVERLAY and use it on Radxa ROCK Pi S.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/rock-pi-s-rk3308_defconfig | 1 +
>   include/configs/rk3308_common.h    | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index e2abe4b4f7..ca4a1800e7 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -9,6 +9,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
> +CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
>   CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x0
> diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
> index a413af1bd4..861154fbeb 100644
> --- a/include/configs/rk3308_common.h
> +++ b/include/configs/rk3308_common.h
> @@ -17,6 +17,7 @@
>   	"scriptaddr=0x00500000\0" \
>   	"pxefile_addr_r=0x00600000\0" \
>   	"fdt_addr_r=0x03e00000\0" \
> +	"fdtoverlay_addr_r=0x03f00000\0" \
>   	"kernel_addr_r=0x00680000\0" \
>   	"ramdisk_addr_r=0x04000000\0"
>   
