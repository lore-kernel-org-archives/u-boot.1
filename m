Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF93DC369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A555B80FA8;
	Tue, 22 Apr 2025 16:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Lhh6E0yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A0068209C; Tue, 22 Apr 2025 16:52:27 +0200 (CEST)
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com
 [45.254.49.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685A98070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf5b43d;
 Tue, 22 Apr 2025 22:52:20 +0800 (GMT+08:00)
Message-ID: <55edc0a7-accc-4867-a323-f6ac121ea4de@rock-chips.com>
Date: Tue, 22 Apr 2025 22:52:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] mmc: rockchip_dw_mmc: Add support for rk3576
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-11-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-11-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUhNVhhMGRgYTB5IThpLSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfc559303afkunm12bf5b43d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6ETo*TTIBMEktLwE6AzoQ
 Aj1PCi5VSlVKTE9OSEhITk9KTkJIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlLSUw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=Lhh6E0yoj3D2j70RRjKsuizTavDXg42htKZ+yIWlaF9WqViiUJfiQUDm9RidjuHvzV1MEKWgoH2ia1jYLbltNVzW19tpY5y88+vTXGsqO0JYwGJnoaYtcKTrX4BqDZnYP9Tr3cmfL4eZmE2iz1cM25MYqwn8LAUeRISNJ7X6xdU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=ysUfLUTkrtsTcEDQxg4oOZ1JuIjjlQsrVkiTQ7nwMAQ=;
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


On 2025/4/16 05:51, Heiko Stuebner wrote:
> The rk3576 uses a different base-compatible, as starting with this
> generation, the clock phase tuning is done via registers inside
> the mmc controller and not from inside the CRU.
>
> In U-Boot we do not tune at all, so no other code changes are
> necessary.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/mmc/rockchip_dw_mmc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 422b8f7e4c8..7a72abaa38a 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -171,6 +171,7 @@ static int rockchip_dwmmc_bind(struct udevice *dev)
>   static const struct udevice_id rockchip_dwmmc_ids[] = {
>   	{ .compatible = "rockchip,rk2928-dw-mshc" },
>   	{ .compatible = "rockchip,rk3288-dw-mshc" },
> +	{ .compatible = "rockchip,rk3576-dw-mshc" },
>   	{ }
>   };
>   
