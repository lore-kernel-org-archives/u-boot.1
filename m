Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD03C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166998842A;
	Thu,  6 Jun 2024 10:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AQf3abhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B87EC88611; Thu,  6 Jun 2024 10:16:08 +0200 (CEST)
Received: from mail-m12797.qiye.163.com (mail-m12797.qiye.163.com
 [115.236.127.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B9588611
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=AQf3abhneB8kkboAXQsz2EC4VgTeuedTJ5dhSYBDAD+ijZn64rA2dxW1OOxc11X9FC8Kpt2PEIRchQnrYoTMMOnr3/eGshFHaPAR/+lvEjfRYq0xYIdWW4VH6MnJngaQlp0QnYwSrO7qyZ/jS55SpJOyqlc4Zln9oe/GwFI8T7s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=5E8Hqz8S+CtDS3tOEIteRqr5q/ZzmEPUpCRAmXYfqwY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 41E3C9005FE;
 Thu,  6 Jun 2024 16:15:39 +0800 (CST)
Message-ID: <1e193424-8ba6-415a-bfcc-60aeb6923b45@rock-chips.com>
Date: Thu, 6 Jun 2024 16:15:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH next v2 3/6] rockchip: rk3399-puma: remove unnecessary
 simple-bin:fit:offset override
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
 <20240605-misc-tsd-v2-3-12479432c90f@cherry.de>
Content-Language: en-US
In-Reply-To: <20240605-misc-tsd-v2-3-12479432c90f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4YTFZMTE0dHk1MS0hIGR1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec9e2b1903a9kunm41e3c9005fe
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Lww*SDMDQzUSLk9NCitM
 LBpPFCpVSlVKTEpMTU1KTE9LSkJDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkNLNwY+
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


On 2024/6/5 23:56, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Since commit 6007b69d544e ("rockchip: rk3399-puma: Update SPL_PAD_TO
> Kconfig option"), SPL_PAD_TO matches
> (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512 and the default
> value for simple-bin:fit:offset in rockchip-u-boot.dtsi is
> SPL_PAD_TO, so let's remove this override.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> index 5a9bd320ec4..55895d0dd19 100644
> --- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> @@ -33,12 +33,6 @@
>   };
>   
>   &binman {
> -	simple-bin {
> -		fit {
> -			offset = <((CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512)>;
> -		};
> -	};
> -
>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>   	simple-bin-spi {
>   		fit {
>
