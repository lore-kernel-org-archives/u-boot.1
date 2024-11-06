Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772E3D44D42
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E915588FF6;
	Wed,  6 Nov 2024 11:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="d00JGnKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A3B89035; Wed,  6 Nov 2024 11:13:54 +0100 (CET)
Received: from mail-m1026.netease.com (mail-m1026.netease.com [154.81.10.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE9888DB6
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f7e3e1d;
 Wed, 6 Nov 2024 18:13:48 +0800 (GMT+08:00)
Message-ID: <e96e7248-1591-4f4c-ab8b-a72e4e7cc955@rock-chips.com>
Date: Wed, 6 Nov 2024 18:13:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3288: Fix bootph prop for vop nodes
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241104202543.977008-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241104202543.977008-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5PT1YeH00ZGR1LSR9IHh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300f7523403afkunm1f7e3e1d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTY6MQw5OjIiGjEcGTVOTBwv
 LAEaChpVSlVKTEhLQ0NDS0lCSEJPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTkI3Bg++
DKIM-Signature: a=rsa-sha256;
 b=d00JGnKhIs+/LhSEaDWqcyj5p+wh3ZJ02QmAK9jBeGdJr6FZHFhUvrqt2/bNat6bvLz4+JRUvNhcG3nQl3GFpvRgD07j1hiFL7vMh+GK8RM0XjzLsaWa9fym9w6kqF89Zxm81ONKFSs4r+kvtZhrM2EiwBwQ6klRx6sgiy94HVg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=oknWDkxDOWGqBfSQ34YMhkJfIBG5C0eza7IwznXp9yY=;
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


On 2024/11/5 04:25, Jonas Karlman wrote:
> The vop nodes does not need to be included in xPL control FDT, they only
> need to be included at U-Boot proper pre-reloc phase.
>
> Change to use bootph-some-ram prop to fix this.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-u-boot.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
> index a43d320ade7b..c51bfca65604 100644
> --- a/arch/arm/dts/rk3288-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-u-boot.dtsi
> @@ -128,11 +128,11 @@
>   };
>   
>   &vopb {
> -	bootph-all;
> +	bootph-some-ram;
>   };
>   
>   &vopl {
> -	bootph-all;
> +	bootph-some-ram;
>   };
>   
>   &xin24m {
