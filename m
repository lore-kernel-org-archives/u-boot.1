Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598CBCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DADCE832AD;
	Sun, 26 Oct 2025 16:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TdqGt3aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD3E9836B4; Sun, 26 Oct 2025 16:40:35 +0100 (CET)
Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com
 [101.71.155.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC3F82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748ef8;
 Sun, 26 Oct 2025 23:40:30 +0800 (GMT+08:00)
Message-ID: <60261551-968f-476f-9969-8609a7346635@rock-chips.com>
Date: Sun, 26 Oct 2025 23:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] spi: rockchip_sfc: Support sclk_x2 version
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jon Lin <jon.lin@rock-chips.com>
References: <20251019154728.846096-1-jonas@kwiboo.se>
 <20251019154728.846096-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019154728.846096-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212da2f703afkunm82aef7cc4d2109
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0wfVh8dS0wdSkxDHx5IHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=TdqGt3aLtZeAghDQwLcDFykHx0oLQkGkAkjsxd5f7YebAu8kPj0QPPMjucQPOldQbVIasvGxCnnpdxc+9ri15L4ajMpk+ocaf3zbCwJj7wyffnV+97bSfU7IOGOuDsTq7nGGWougYVr+1AHp9yUCZfQnMP2hZoWlnW/0485PzIU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=C1Ypfwu1HFbIIRI62SOovG2lLTUHWSCk9tvjWACCL6I=;
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


On 2025/10/19 23:47, Jonas Karlman wrote:
> From: Jon Lin <jon.lin@rock-chips.com>
>
> SFC after version 8 supports dtr mode, so the IO is the binary output of
> the controller clock.
>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v4: No change
> v3: No change
> v2: No change
> ---
>   drivers/spi/rockchip_sfc.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
> index 73738ab26d33..60e74117057a 100644
> --- a/drivers/spi/rockchip_sfc.c
> +++ b/drivers/spi/rockchip_sfc.c
> @@ -108,6 +108,7 @@
>   #define  SFC_VER_3			0x3
>   #define  SFC_VER_4			0x4
>   #define  SFC_VER_5			0x5
> +#define  SFC_VER_8			0x8
>   
>   /* Delay line controller resiter */
>   #define SFC_DLL_CTRL0			0x3C
> @@ -589,6 +590,16 @@ static int rockchip_sfc_adjust_op_size(struct spi_slave *mem, struct spi_mem_op
>   	return 0;
>   }
>   
> +#if CONFIG_IS_ENABLED(CLK)
> +static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, uint speed)
> +{
> +	if (sfc->version >= SFC_VER_8)
> +		return clk_set_rate(&sfc->clk, speed * 2);
> +	else
> +		return clk_set_rate(&sfc->clk, speed);
> +}
> +#endif
> +
>   static int rockchip_sfc_set_speed(struct udevice *bus, uint speed)
>   {
>   	struct rockchip_sfc *sfc = dev_get_plat(bus);
> @@ -600,7 +611,7 @@ static int rockchip_sfc_set_speed(struct udevice *bus, uint speed)
>   		return 0;
>   
>   #if CONFIG_IS_ENABLED(CLK)
> -	int ret = clk_set_rate(&sfc->clk, speed);
> +	int ret = rockchip_sfc_clk_set_rate(sfc, speed);
>   
>   	if (ret < 0) {
>   		dev_err(sfc->dev, "set_freq=%dHz fail, check if it's the cru support level\n",

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

