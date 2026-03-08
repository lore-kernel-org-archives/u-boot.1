Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD5DEA852E
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 534FB83EC9;
	Sun,  8 Mar 2026 16:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dLyGqHQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC1E83EC9; Sun,  8 Mar 2026 16:42:10 +0100 (CET)
Received: from mail-m32107.qiye.163.com (mail-m32107.qiye.163.com
 [220.197.32.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2B280517
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 362542e5b;
 Sun, 8 Mar 2026 23:42:02 +0800 (GMT+08:00)
Message-ID: <8eb5f46d-4cc2-48ae-a9dd-18bb19877a97@rock-chips.com>
Date: Sun, 8 Mar 2026 23:42:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] ARM: dts: rockchip: Remove mshc aliases from RK3288
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
 <b1f8dbad-fcb2-467d-882f-25c8023ed9cb@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <b1f8dbad-fcb2-467d-882f-25c8023ed9cb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cce1cd60d03afkunma30fc64315be8f5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDThlDVhlPSxhJTBhIT09PTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=dLyGqHQFWPtblS+XJuRk2e9wtUbygN+7ohYjJtsoVxYA3Kp9Vh4UzVtvu2wJqomqYQOigGmzUeuhEtRCozXTYpKxBYDZBCst0ENh595LwHNxFAbf8drPD+E71gfhVeBz82KOorVBSWu+HI92PZo/NkWlYG0ngwqhFy0qmTUE7eE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=rydOkec7qmcfYHp/aZHjpoyWcpoXeM8adq6ULyALX2Y=;
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


On 2026/1/17 06:11, Johan Jonker wrote:
> The use of mshc aliases is deprecated for some while,
> so remove them from the rk3288.dtsi file.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Link: https://patch.msgid.link/3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: cafaf99e4a790f8492a034a3470f878779c8c535 ]
>
> (cherry picked from commit faefae4ca217961a0d96a54c9618e56aa8fd37b3)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm/rockchip/rk3288.dtsi | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
> index 42d705b544ec..7e284b4fecdc 100644
> --- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
> +++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
> @@ -34,10 +34,6 @@
>   		i2c3 = &i2c3;
>   		i2c4 = &i2c4;
>   		i2c5 = &i2c5;
> -		mshc0 = &emmc;
> -		mshc1 = &sdmmc;
> -		mshc2 = &sdio0;
> -		mshc3 = &sdio1;
>   		serial0 = &uart0;
>   		serial1 = &uart1;
>   		serial2 = &uart2;
> --
> 2.39.5
>
>
