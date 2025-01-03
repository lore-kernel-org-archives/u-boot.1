Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9745E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE3780196;
	Fri,  3 Jan 2025 07:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dTec3XLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6CE800D7; Fri,  3 Jan 2025 07:43:54 +0100 (CET)
Received: from mail-m15574.qiye.163.com (mail-m15574.qiye.163.com
 [101.71.155.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6765C803CE
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79772eb6;
 Fri, 3 Jan 2025 14:43:46 +0800 (GMT+08:00)
Message-ID: <7b31566b-941f-4b5e-b9e4-6f4b64c32888@rock-chips.com>
Date: Fri, 3 Jan 2025 14:43:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value
 in offset prop
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212235735.164272-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhoZHVZITBlLGUhLTE0aH0pWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae7e22103afkunm79772eb6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohg6Exw4FzIcSCwaDAoBORAw
 IjNPC09VSlVKTEhOQ0NNTUlDT09IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEhKNwY+
DKIM-Signature: a=rsa-sha256;
 b=dTec3XLKbFIThhSLWjvsBqUsjzBOowZIo+pRg29BOtvMRHX+bfvtehZ+OBG7SnNcOn0dUwbQSPS/c5xqiMwRrUKv7dFjO158B6h2nyg5B5bgzasm7gchPVMI8bbbRQQ533V3ExSuSal3j/xTxsv7gbNeqgMPHfQQJ9y092ZTDaU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=JFWQqIfNMuLutkUWd2e9PXmXKrrdHUr3Iw5cTBUKfAc=;
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
> Use the offset configured with SYS_SPI_U_BOOT_OFFS Kconfig option
> instead of a hardcoded 0x40000 for the FIT payload offset.
>
> This has no intended impact as SYS_SPI_U_BOOT_OFFS=0x40000.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-gru-u-boot.dtsi | 2 +-
>   arch/arm/dts/rk3399-u-boot.dtsi     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> index 6bdc892bd913..2505d9b01b8a 100644
> --- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> @@ -11,7 +11,7 @@
>   	};
>   
>   	config {
> -		u-boot,spl-payload-offset = <0x40000>;
> +		u-boot,spl-payload-offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 2bec139d8338..81a3c6fc972b 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -43,7 +43,7 @@
>   			};
>   		};
>   		u-boot-img {
> -			offset = <0x40000>;
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>   		};
>   		u-boot {
>   			offset = <0x300000>;
