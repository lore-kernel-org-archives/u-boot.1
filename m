Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F438C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF8088719;
	Tue,  7 May 2024 05:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EfwViM8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC26E8871A; Tue,  7 May 2024 05:28:22 +0200 (CEST)
Received: from mail-m127230.xmail.ntesmail.com
 (mail-m127230.xmail.ntesmail.com [115.236.127.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6583A88651
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EfwViM8qlI70o9LXNNGxri1pWQ0zTVs30cq7tRJJwns6G3iGPW/HNt0Fpo1/rNr3tvtq4N1jSJd/y/snithJ2+UlDTKsfkuEzOmXXrZBoV0JU3sVjNM9qNwVtLc2zHKlohh9MhwpzsSuUC+8Z9i4NhhheDzRtNyJCoDnf2GG0Qs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=jPaYXQ6IEDrsrMMhSQyxM/xga2xDfILE9zSiLbD8SlU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C8B85900205;
 Tue,  7 May 2024 11:28:03 +0800 (CST)
Message-ID: <51603d40-ee6b-499a-9576-bacb07e91551@rock-chips.com>
Date: Tue, 7 May 2024 11:28:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3328: Add SCLK_USB3OTG_REF support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240501192352.962891-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240501192352.962891-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tDTlYeSkMdHklLQ0MdSBlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5118165003a9kunmc8b85900205
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46Sww*NDNRFBQ#ShY1GS4d
 OTFPC0xVSlVKTEpOS05JT0NPTkxKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTk1INwY+
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


On 2024/5/2 03:23, Jonas Karlman wrote:
> The SCLK_USB3OTG_REF clocks is used as reference clock for USB3 block.
>
> Add simple support to get rate of SCLK_USB3OTG_REF clocks to fix
> reference clock period configuration.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This has been runtime tested on a Rock64 and NanoPi R2S Plus.
> ---
>   drivers/clk/rockchip/clk_rk3328.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
> index 87075ec71340..314b903eaa03 100644
> --- a/drivers/clk/rockchip/clk_rk3328.c
> +++ b/drivers/clk/rockchip/clk_rk3328.c
> @@ -706,6 +706,9 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
>   	case PCLK_HDMIPHY:
>   		rate = rk3328_hdmiphy_get_clk(priv->cru);
>   		break;
> +	case SCLK_USB3OTG_REF:
> +		rate = OSC_HZ;
> +		break;
>   	default:
>   		return -ENOENT;
>   	}
> @@ -780,6 +783,7 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
>   	case PCLK_DDR:
>   	case ACLK_GMAC:
>   	case PCLK_GMAC:
> +	case SCLK_USB3OTG_REF:
>   	case SCLK_USB3OTG_SUSPEND:
>   	case USB480M:
>   		return 0;
