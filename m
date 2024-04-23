Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEACAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD898857E;
	Tue, 23 Apr 2024 13:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TbH0fJj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D9B88599; Tue, 23 Apr 2024 13:02:10 +0200 (CEST)
Received: from mail-m49252.qiye.163.com (mail-m49252.qiye.163.com
 [45.254.49.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA5C8857E
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=TbH0fJj5BUa5DtLJ3avhpz33ZKwvHgeJMILjuGjJ0z3WQnoYyUiLHT+kZk+9oRC+UAZPnxwHdnPfsQ7T/KaH4cWLmYvTMqveOT4q9cHNabxP1iStsOgTZkayJGzVBAfrXy0YD9/t8+BTvvezXnNjjPa50pD7nMfNS/2rfnTgMns=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=DwhTiaiwablNO9t8PTtcfshd01yfdToy3iK0abEZg6I=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A62F090010D;
 Tue, 23 Apr 2024 19:01:54 +0800 (CST)
Message-ID: <ed7ce483-d5f8-47c1-a9c3-8c04e4505b0d@rock-chips.com>
Date: Tue, 23 Apr 2024 19:01:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/31] rockchip: rk3399: Imply support for GbE PHY
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkYTVYfGh9DGEpNTRpLHRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0a9e915303a9kunma62f090010d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Hyo6GjMBUT0pA04fGk8d
 Sk4aFExVSlVKTEpIQ0xLSkpOT0NKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0xONwY+
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
> Imply support for GbE PHY status parsing and configuration when support
> for onboard ethernet is enabled.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index e18d7f373f77..a07ad38f2efc 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -270,6 +270,7 @@ config ROCKCHIP_RK3399
>   	imply MISC_INIT_R
>   	imply OF_LIVE
>   	imply PARTITION_TYPE_GUID
> +	imply PHY_GIGE if GMAC_ROCKCHIP
>   	imply PRE_CONSOLE_BUFFER
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
