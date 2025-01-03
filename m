Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85675E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 09:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2086F80384;
	Fri,  3 Jan 2025 10:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E/U8k7W0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC4F80384; Fri,  3 Jan 2025 10:26:07 +0100 (CET)
Received: from mail-m12764.qiye.163.com (mail-m12764.qiye.163.com
 [115.236.127.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FD1803F0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 10:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79d1fb85;
 Fri, 3 Jan 2025 17:26:00 +0800 (GMT+08:00)
Message-ID: <6649c77d-db78-4ce6-81b0-43c34df97645@rock-chips.com>
Date: Fri, 3 Jan 2025 17:25:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 08/12] rockchip: rk3399-gru: Remove unused nodes from xPL
 control FDT
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-9-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241212235735.164272-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGk5LVk9JQ0JMQh0eHkpPH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a942b7c64f403afkunm79d1fb85
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxw6MRw4DzILFywSKzQXDwMo
 SCwKCRxVSlVKTEhOQ0JNSE1KTEJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpLTkk3Bg++
DKIM-Signature: a=rsa-sha256;
 b=E/U8k7W0KychkJPKBWWdbcJQAD94GKPCDDD1dSa2A6T6T7XoD72BvGFB7VCBWnKvRxLOBD7kb+0c21SNGGt5enApbHFH9W/woG8kU7mEgnPAmPpUr/yDSJahsCHr2+HBpZhIeXGsB3iUxKahXzgLuxkGk4gXxmGVu3JknDXt3cU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=4LvS38LCVC5IgXGMaSGPE4x0oBYnDHebRU1zRSbaZqA=;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> The eMMC PHY and SPI flash is not used in all xPL phases.
>
> Change to no longer include emmc_phy and spi_flash in all xPL phases.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-gru-u-boot.dtsi | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> index 2505d9b01b8a..5f44327736df 100644
> --- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> @@ -29,6 +29,11 @@
>   	rockchip,panel = <&edp_panel>;
>   };
>   
> +&emmc_phy {
> +	/delete-property/ bootph-pre-ram;
> +};
> +
> +
>   &pp1800_audio {
>   	regulator-min-microvolt = <1800000>;
>   	regulator-max-microvolt = <1800000>;
> @@ -80,7 +85,8 @@
>   
>   &spi1 {
>   	spi_flash: flash@0 {
> -		bootph-all;
> +		bootph-pre-ram;
> +		bootph-some-ram;
>   	};
>   };
>   
