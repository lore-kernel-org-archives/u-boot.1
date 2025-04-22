Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEBFC369D7
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9808171B;
	Tue, 22 Apr 2025 16:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="S0FKPglq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22A6815D1; Tue, 22 Apr 2025 16:50:55 +0200 (CEST)
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com
 [220.197.32.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452D68070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf175e3;
 Tue, 22 Apr 2025 22:50:46 +0800 (GMT+08:00)
Message-ID: <83455e52-f00c-4599-8bfe-7cf8c43262a2@rock-chips.com>
Date: Tue, 22 Apr 2025 22:50:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] rockchip: mkimage: Add rk3576 support
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-3-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkweVk5ISk4dTxhJQk5DSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfae86703afkunm12bf175e3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogw6Lgw4FjJWMEktLwNMDAEo
 SgNPCR1VSlVKTE9OSEhIT09MQkJCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUpDTE83Bg++
DKIM-Signature: a=rsa-sha256;
 b=S0FKPglqyyWQp6ApgTdWcaFMogfgTigRPKmHPuROdy+V8a+Tk8If9VzZhOHEF4qph7qi4YgPtP9+bc5P/zisK5o44JDY4dief3BbbqJkBlLXWHOEvPsdjFi1mSWqoxh/wLtxmDVNvMABIF1Od2g1m7WzLBGByqSJhH/oz38LSBw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=/neeb9LLPBaNfvMfT7/6Exl9s1qzkdtPkQ6aMuIM0WQ=;
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
> From: Xuhui Lin <xuhui.lin@rock-chips.com>
>
> Add support for rk3576 package header in mkimage tool.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   tools/rkcommon.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index f158d156228..a0caa029cc0 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -136,6 +136,7 @@ static struct spl_info spl_infos[] = {
>   	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>   	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
> +	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
>   };
>   
