Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D441EA852E
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CED583F53;
	Sun,  8 Mar 2026 16:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y7S3R6Pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13A683F6D; Sun,  8 Mar 2026 16:42:14 +0100 (CET)
Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com
 [220.197.31.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E8680517
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 362542e68;
 Sun, 8 Mar 2026 23:42:08 +0800 (GMT+08:00)
Message-ID: <acdfb715-85c1-4218-89df-4ce00b4dcc62@rock-chips.com>
Date: Sun, 8 Mar 2026 23:42:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ARM: dts: rockchip: Add spi_flash label to
 rk3288-veyron
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
 <12e44bc6-4e45-43e4-9c61-0816b90ce75f@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <12e44bc6-4e45-43e4-9c61-0816b90ce75f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cce1cef2003afkunma30fc64315be92e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ01CVh1LHxhPTE1LSEJLGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Y7S3R6PtOsX+wO99idjjBMQYZyEFR2YTtDe5CKdBtXP2xaOi9LejbkzMrUMXMljO8kuUM4Qg6UiOP40kz1v4Nk2m8wKdc+e8etl0NC+4XJOXR9v21bBRDYzEa1hPonkwY3+NOYyj9gwIjcoV86nX6LJQtfkTAxZ0MilZHjtiiqI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=TnAT9xFrH2p/GszcKSxg2z++9oUxroqnzNUUz0Nt0Z0=;
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


On 2026/1/17 06:12, Johan Jonker wrote:
> The u-boot,spl-boot-order property requires a label at a boot
> device node. In order to migrate to OF_UPSTREAM more easier
> add a spi_flash label to the rk3288-veyron.dtsi file.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Link: https://patch.msgid.link/8a423a6f-bfdc-4947-aef9-35ee7c4f6ca2@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: ac7116a626e00d3024adedb43b74bdf2ce45efc2 ]
>
> (cherry picked from commit 38e6f7cd300f66cc9f657cd0e8881a01acc664d0)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi b/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
> index 260d6c92cfd1..2d6cf08d00f9 100644
> --- a/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
> +++ b/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
> @@ -388,7 +388,7 @@
>
>   	rx-sample-delay-ns = <12>;
>
> -	flash@0 {
> +	spi_flash: flash@0 {
>   		compatible = "jedec,spi-nor";
>   		spi-max-frequency = <50000000>;
>   		reg = <0>;
> --
> 2.39.5
>
>
