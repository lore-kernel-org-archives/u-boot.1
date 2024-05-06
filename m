Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235C6C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D83A88134;
	Mon,  6 May 2024 12:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H4yPVfKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A678801F; Mon,  6 May 2024 12:37:03 +0200 (CEST)
Received: from mail-m92248.xmail.ntesmail.com (mail-m92248.xmail.ntesmail.com
 [103.126.92.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 178D88850B
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=H4yPVfKEJ6TBZoHmm0ii/IhVUrTuVX7IMSQlNUCC8sGWFB1o99cszzMbDBNK7/HEwTQHrqbZeVjit3nV5i/FSB/bU+O2CFEk0hV05DEKVO3FhZLTepKfy8tzT17ryMR21cQujvvmjN+tUk5F+OXveEQpNOYdQe//ppH1ILAWolU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=rsOSLl+N62EDgH+5gbnBvo6hBt/nTyFNxDbeoacmRzs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 23E9E90031B;
 Mon,  6 May 2024 18:36:51 +0800 (CST)
Message-ID: <1068d7d5-a82b-4718-a3aa-0edd2d9c27c2@rock-chips.com>
Date: Mon, 6 May 2024 18:36:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] rockchip: rk3399-puma: Move uart0 bootph to
 board u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-16-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-16-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4eHVZCHxgeGUxPGB5IQkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d7a4cb603a9kunm23e9e90031b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSo6Fww5MjNPMhYdSDMrOjAq
 EhIwCUpVSlVKTEpPQkJKQ0pJSk1DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0hONwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> rk3399-puma is the only supported board that use uart0 for serial
> console, other RK3399 boards typically use uart2 for serial console
> and may use uart0 for bluetooth.
>
> Move setting bootph prop to board u-boot.dtsi to only include the uart0
> node in TPL/SPL control FDT for the rk3399-puma target.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from "Fix loading FIT from SD-card" patch
> ---
>   arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 4 ++++
>   arch/arm/dts/rk3399-u-boot.dtsi             | 4 ----
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> index 2b3ea6da88db..390cf24152a6 100644
> --- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> @@ -110,3 +110,7 @@
>   &sdmmc_cmd {
>   	bootph-all;
>   };
> +
> +&uart0 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 496f25d9fbf6..9815dc53e8ed 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -134,10 +134,6 @@
>   	bootph-all;
>   };
>   
> -&uart0 {
> -	bootph-all;
> -};
> -
>   &uart2 {
>   	bootph-all;
>   };
