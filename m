Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD962C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDAC987B98;
	Thu, 18 Jan 2024 08:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Tdyw3VoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C594687B93; Thu, 18 Jan 2024 08:21:33 +0100 (CET)
Received: from mail-m17210.xmail.ntesmail.com (mail-m17210.xmail.ntesmail.com
 [45.195.17.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE03F87B8F
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Tdyw3VoBfPjVS2ZPCG+ee9RUTb3RceqrdmewVe3gjGW7ttbguO7RndYLbVtxcgD80mcWL/HY4OVea32UT/RAcnFZF7NQ4dAqPDdpHZZ1k5tJlbc8S1TV1GaxZv7IZTL/ukmxHqRUwWMzIVADGJGgEXijSb4EDQTf5h2EQDDr2zo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=9BvoZSMIbDLStyBs1Ua5UWsizhXUcoL+jYkiGcZJ8wA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 8751D900392;
 Thu, 18 Jan 2024 15:21:27 +0800 (CST)
Message-ID: <74c7cdd7-a6ae-406a-900b-ec64d582b5e3@rock-chips.com>
Date: Thu, 18 Jan 2024 15:21:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 6/7] board: rockchip: Add support for new boards to
 RGxx3
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: andre.przywara@arm.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jagan@edgeble.ai, jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
 <20240102154654.191055-7-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240102154654.191055-7-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhJGFZMSU1NShlKTkgdTUtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b723bde2eafkusn8751d900392
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Djo*GTwtEBA1Ihg9DVFL
 GUMaCh9VSlVKTEtOTk1JT0NDSUxIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQk1INwY+
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


On 2024/1/2 23:46, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add support for the Anbernic RG-ARC-D, Anbernic RG-ARC-S, Powkiddy
> RK2023, and Powkiddy RGB30 to the Anbernic RGxx3. While the Powkiddy
> devices are manufactured by Powkiddy instead of Anbernic,
> the hardware is so similar they can all use the same bootloader.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 44 +++++++++++++++++++---
>   1 file changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index 7bef5a53f0..e12a85a02a 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -48,9 +48,13 @@ enum rgxx3_device_id {
>   	RG353P,
>   	RG353V,
>   	RG503,
> +	RGB30,
> +	RK2023,
> +	RGARCD,
>   	/* Devices with duplicate ADC value */
>   	RG353PS,
>   	RG353VS,
> +	RGARCS,
>   };
>   
>   static const struct rg3xx_model rg3xx_model_details[] = {
> @@ -83,6 +87,27 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
>   		.detect_panel = 0,
>   	},
> +	[RGB30] = {
> +		.adc_value = 383, /* Gathered from second hand information */
> +		.board = "rk3566-powkiddy-rgb30",
> +		.board_name = "RGB30",
> +		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
> +		.detect_panel = 0,
> +	},
> +	[RK2023] = {
> +		.adc_value = 635, /* Observed average from device */
> +		.board = "rk3566-powkiddy-rk2023",
> +		.board_name = "RK2023",
> +		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
> +		.detect_panel = 0,
> +	},
> +	[RGARCD] = {
> +		.adc_value = 183, /* Observed average from device */
> +		.board = "rk3566-anbernic-rg-arc-d",
> +		.board_name = "Anbernic RG ARC-D",
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
> +		.detect_panel = 0,
> +	},
>   	/* Devices with duplicate ADC value */
>   	[RG353PS] = {
>   		.adc_value = 860, /* Observed average from device */
> @@ -98,6 +123,13 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
>   		.detect_panel = 1,
>   	},
> +	[RGARCS] = {
> +		.adc_value = 183, /* Observed average from device */
> +		.board = "rk3566-anbernic-rg-arc-s",
> +		.board_name = "Anbernic RG ARC-S",
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
> +		.detect_panel = 0,
> +	},
>   };
>   
>   struct rg353_panel {
> @@ -332,19 +364,21 @@ int rgxx3_detect_device(void)
>   	}
>   
>   	/*
> -	 * Try to access the eMMC on an RG353V or RG353P. If it's
> -	 * missing, it's an RG353VS or RG353PS. Note we could also
> -	 * check for a touchscreen at 0x1a on i2c2.
> +	 * Try to access the eMMC on an RG353V, RG353P, or RG Arc D.
> +	 * If it's missing, it's an RG353VS, RG353PS, or RG Arc S.
> +	 * Note we could also check for a touchscreen at 0x1a on i2c2.
>   	 */
> -	if (board_id == RG353V || board_id == RG353P) {
> +	if (board_id == RG353V || board_id == RG353P || board_id == RGARCD) {
>   		mmc = find_mmc_device(0);
>   		if (mmc) {
>   			ret = mmc_init(mmc);
>   			if (ret) {
>   				if (board_id == RG353V)
>   					board_id = RG353VS;
> -				else
> +				else if (board_id == RG353P)
>   					board_id = RG353PS;
> +				else
> +					board_id = RGARCS;
>   			}
>   		}
>   	}
