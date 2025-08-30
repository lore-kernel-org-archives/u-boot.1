Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9035FCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD938380E;
	Sat, 30 Aug 2025 17:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EftIW4bY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF5A83826; Sat, 30 Aug 2025 17:14:05 +0200 (CEST)
Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com
 [220.197.31.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671F5836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4f1b;
 Sat, 30 Aug 2025 23:13:58 +0800 (GMT+08:00)
Message-ID: <b87797f1-e26b-41a5-8d66-7a80a7a9f95f@rock-chips.com>
Date: Sat, 30 Aug 2025 23:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] rockchip: odroid-go2: Use appropriate bootph props
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250713233429.1376172-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb8addcd03afkunmcab4ea3441248b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0tCVkpLTkhDSUlITktPGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=EftIW4bYMjSEozlNyY5qbo9Ysyc+7fClgroKFdkbLQGvMScTeX3Md6KlZopNFttZw3QfvRGiMZXfpJi9V70N545xsk2ViupqZq0/ZNcYQZ5Ia9z1R7TyBTCJT8P6fYYK7KJX+3ktZxroPtNNR9szzcCc7mrW5vxqP3Yfz2cg1V8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=l6TXq9Vn9bblvr8NqD8TUcHKRN3ze91vbQwSMjk8D24=;
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


On 2025/7/14 07:33, Jonas Karlman wrote:
> GPIO devices are needed in U-Boot proper phase, sdmmc and sfc devices
> are needed in SPL and pre-reloc phase.
>
> Update bootph- props to match what boot phase devices are needed at.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> index df21747fad78..a27994e450c0 100644
> --- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> @@ -27,22 +27,18 @@
>   };
>   
>   &gpio0 {
> -	bootph-all;
>   	gpio-ranges = <&pinctrl 0 0 32>;
>   };
>   
>   &gpio1 {
> -	bootph-all;
>   	gpio-ranges = <&pinctrl 0 32 32>;
>   };
>   
>   &gpio2 {
> -	bootph-all;
>   	gpio-ranges = <&pinctrl 0 64 32>;
>   };
>   
>   &gpio3 {
> -	bootph-all;
>   	gpio-ranges = <&pinctrl 0 96 32>;
>   };
>   
> @@ -78,28 +74,30 @@
>   };
>   
>   &sdmmc {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   
>   	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
>   	u-boot,spl-fifo-mode;
>   };
>   
>   &sfc {
> -	bootph-all;
> +	bootph-some-ram;
>   };
>   
>   &{/spi@ff3a0000/flash@0} {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &uart1 {
> -	clock-frequency = <24000000>;
>   	bootph-all;
> +	clock-frequency = <24000000>;
>   };
>   
>   &uart2 {
> -	clock-frequency = <24000000>;
>   	bootph-all;
> +	clock-frequency = <24000000>;
>   };
>   
>   &xin24m {
