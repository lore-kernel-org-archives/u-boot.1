Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAA1C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C48878CE;
	Mon, 23 Oct 2023 12:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZEzEAN+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CC6878D4; Mon, 23 Oct 2023 12:05:30 +0200 (CEST)
Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com
 [101.71.155.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE37B86CF9
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ZEzEAN+CdJxl8CnCc1ywgkpHAw3INOdxiv0FjUa7G1rNeRs35NvZcnN+rIv+NCqTPyrmcCtYf9VnJvhW1bTFzLbGGTui30eNUBYYl35aMJJdXqUvQGCv6UkJpmNgznVhiZJXQMnX/epkkO4cMe/mORvid4XMzm0eG1MfV1JxM3Y=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=ovYvVVi6DysXAa4lTGOahWxSGPrxxixORVAoxEmAi54=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 38CC84003BC;
 Mon, 23 Oct 2023 18:04:59 +0800 (CST)
Message-ID: <6533415e-41c9-4d83-9dbe-c16d582078a7@rock-chips.com>
Date: Mon, 23 Oct 2023 18:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] board: rockchip: Add support for RGB30 and RK2023 to
 RGxx3
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20231017182414.321411-1-macroalpha82@gmail.com>
 <20231017182414.321411-4-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231017182414.321411-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpOSVZKHk4dSxlLQkwaSEJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b5bfeae592eb3kusn38cc84003bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6DTo6SzwyMTg2MgoQFTY1
 AT5PFEhVSlVKTUJDS05OT0JCQ0lNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS05NNwY+
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


On 2023/10/18 02:24, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add support for the Powkiddy RK2023 and RGB30 to the Anbernic RGxx3.
> While these devices are manufactured by Powkiddy instead of Anbernic,
> the hardware is so similar they can all use the same bootloader.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index a93b11cd47..dae9dc87c2 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -60,6 +60,8 @@ enum rgxx3_device_id {
>   	RG353P,
>   	RG353V,
>   	RG503,
> +	RGB30,
> +	RK2023,
>   	/* Devices with duplicate ADC value */
>   	RG353PS,
>   	RG353VS,
> @@ -95,6 +97,20 @@ static const struct rg3xx_model rg3xx_model_details[] = {
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
>   	/* Devices with duplicate ADC value */
>   	[RG353PS] = {
>   		.adc_value = 860, /* Observed average from device */
