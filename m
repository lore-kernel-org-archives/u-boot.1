Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6071A885AE;
	Tue, 23 Apr 2024 13:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="J8uO0ZS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033CA885AF; Tue, 23 Apr 2024 13:03:29 +0200 (CEST)
Received: from mail-m127157.xmail.ntesmail.com
 (mail-m127157.xmail.ntesmail.com [115.236.127.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A469885C0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=J8uO0ZS0SpclJt/Hu/mVvKMsKNR0HC9mU46ctOEghcPXY0jaKuCfWrct0Kgvi1NMT8VJib0W9LoTfGVTBOCTPRyRhuYOQ1KC3xI+K7E02r4uMwbHuRzJsmw7vh9awUdIvOvueZrow4Y2cgXXciwLX2YDtE9WZSJY5QjROMOOmWA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=cSJ4i6N95Q+tXXTVYiq1cqJHw1FskCU1vE3MC1llpRw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 17D8290031F;
 Tue, 23 Apr 2024 19:03:17 +0800 (CST)
Message-ID: <413426f1-708e-4fd1-8414-0b839b4bc5ba@rock-chips.com>
Date: Tue, 23 Apr 2024 19:03:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/31] clk: rockchip: rk3399: Add dummy support for
 ACLK_VDU clock
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-13-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5PTVZNSktMQksZH0NNGExVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0a9fd2c103a9kunm17d8290031f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6Dgw6LzNJED0rA0lRGSgQ
 AzcaFAtVSlVKTEpIQ0xLSkJMTE5NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUJNNwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> rk3399.dtsi from linux v5.19 and newer try to set VDU clock rate to
> 400 MHz using an assigned-clock-rates prop of the CRU node.
>
> U-Boot does not use or need this clock so add dummy support for getting
> and setting ACLK_VDU clock rate to allow CRU driver to be loaded with an
> updated rk3399.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3399.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index f0ce54067f8c..5934771b4096 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -971,6 +971,7 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
>   	case ACLK_HDCP:
>   	case ACLK_GIC_PRE:
>   	case PCLK_DDR:
> +	case ACLK_VDU:
>   		break;
>   	case PCLK_ALIVE:
>   	case PCLK_WDT:
> @@ -1061,6 +1062,7 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
>   	case ACLK_HDCP:
>   	case ACLK_GIC_PRE:
>   	case PCLK_DDR:
> +	case ACLK_VDU:
>   		return 0;
>   	default:
>   		log_debug("Unknown clock %lu\n", clk->id);
