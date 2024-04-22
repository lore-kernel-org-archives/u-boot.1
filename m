Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD4AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8079988356;
	Mon, 22 Apr 2024 10:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XGXb+ff3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E040D88356; Mon, 22 Apr 2024 10:08:58 +0200 (CEST)
Received: from mail-m127164.xmail.ntesmail.com
 (mail-m127164.xmail.ntesmail.com [115.236.127.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2089A88353
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=XGXb+ff3AGfoevuq8Re77cag4aZR2PdTI6FSrlo7L78PH7wTU8HNCTnqZ9vGnjf6xXhjkllMeRwe4focMvMloIP5B79ck78BoE3UB4QGvJQ6PQAezl8NKqreyUrt/o6zBvCXn6WzZRSZEyOEsVQn37Y8II5V/Dk7JIJKEJkKLT8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=6bJ1JDMO7cWxqXPo1gBB1yYp3u1BGTtr0sYYx3z8ioA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id CE857900300;
 Mon, 22 Apr 2024 16:08:47 +0800 (CST)
Message-ID: <bb8ed2e8-8559-4cfa-9fc3-aec6a45016a4@rock-chips.com>
Date: Mon, 22 Apr 2024 16:08:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/28] rockchip: rk3588-toybrick: Add .dtb-file entry
 in Makefile
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>, Elon Zhang <zhangzj@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-21-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-21-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4dSlZDGEsaSk9OSUgfQ09VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d9b82f03a9kunmce857900300
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6Ljo5NjNOKjoBCCkXTC8I
 OQEKFC1VSlVKTEpITExISElDQktJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkxLNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> Add Rockchip Toybrick TB-RK3588X .dtb-file entry in Makefile.
>
> Fixes: 9fdd9a546986 ("board: rockchip: add Rockchip Toybrick TB-RK3588X board")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: New patch split from rk3588-toybrick defconfig patch
> v2: Fix Makefile entry from .dts to .dtb (Quentin)
> ---
>   arch/arm/dts/Makefile | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 313ef34f5cb7..77c31d7b1edd 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -180,6 +180,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>   	rk3588-quartzpro64.dtb \
>   	rk3588s-rock-5a.dtb \
>   	rk3588-rock-5b.dtb \
> +	rk3588-toybrick-x0.dtb \
>   	rk3588-turing-rk1.dtb
>   
>   dtb-$(CONFIG_ROCKCHIP_RV1108) += \
