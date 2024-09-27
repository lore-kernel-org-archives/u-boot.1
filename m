Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BC6CEBF75
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 03:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584E38906C;
	Fri, 27 Sep 2024 05:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Fa85WazI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2858905F; Fri, 27 Sep 2024 05:15:39 +0200 (CEST)
Received: from mail-m12751.qiye.163.com (mail-m12751.qiye.163.com
 [115.236.127.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0208905F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Fa85WazINFa4/iI+H6hPNxHxtyjm8KGURS2Do7pGarJ7b1fQojJlLHI8C3Rqat78Zu9LyMMBVRarQt7Z/UkOTflgKN2yzJx4gkp7n34Y4aF1qjFW0T42KEraMtoDgrmkQhLSPu6L+4ZfJgnzgc58fer597Mvx5rB7coaOL3AL10=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=T0ZJ9AZ7CbXzm0n/gKtN41tmOsx9aaRpOydBHZFq7gk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E42E5280433;
 Fri, 27 Sep 2024 11:15:04 +0800 (CST)
Message-ID: <09fb1197-ad2d-47cc-a1a8-221d18d10e5b@rock-chips.com>
Date: Fri, 27 Sep 2024 11:15:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] regulator: rk8xx: Use buck variable consistently
To: Jonas Karlman <jonas@kwiboo.se>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
References: <20240917205922.648088-1-jonas@kwiboo.se>
 <20240917205922.648088-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240917205922.648088-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9DGVZMSxpCSBhNSkNNS05WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a923179976909d3kunme42e5280433
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Ojo*MjIvNjczMCo#Fww6
 EywwCwxVSlVKTElMT0tNQktOTEJJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ09JNwY+
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


On 2024/9/18 04:59, Jonas Karlman wrote:
> The buck variable is zero based, i.e. buck=0 match BUCK1 in datasheet.
>
> Remove any buck + 1 calculation to be more consistent in usage of the
> buck variable across the different RK8xx variants in the driver.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Move buck + 1 related changes into a separate patch
> - Remove all buck + 1 use to be fully consistent
> ---
>   drivers/power/regulator/rk8xx.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index b910943c2c46..375d06e3207f 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -381,7 +381,7 @@ static int _buck_set_value(struct udevice *pmic, int buck, int uvolt)
>   		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
>   
>   	debug("%s: volt=%d, buck=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
> -	      __func__, uvolt, buck + 1, info->vsel_reg, mask, val);
> +	      __func__, uvolt, buck, info->vsel_reg, mask, val);
>   
>   	if (priv->variant == RK816_ID) {
>   		pmic_clrsetbits(pmic, info->vsel_reg, mask, val);
> @@ -470,7 +470,7 @@ static int _buck_set_suspend_value(struct udevice *pmic, int buck, int uvolt)
>   		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
>   
>   	debug("%s: volt=%d, buck=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
> -	      __func__, uvolt, buck + 1, info->vsel_sleep_reg, mask, val);
> +	      __func__, uvolt, buck, info->vsel_sleep_reg, mask, val);
>   
>   	return pmic_clrsetbits(pmic, info->vsel_sleep_reg, mask, val);
>   }
> @@ -539,9 +539,10 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
>   		{
>   			u8 reg;
>   
> -			if (buck + 1 >= 9) {
> +			if (buck >= 8) {
> +				/* BUCK9 and BUCK10 */
>   				reg = RK806_POWER_SLP_EN1;
> -				mask = BIT(buck + 1 - 3);
> +				mask = BIT(buck - 2);
>   			} else {
>   				reg = RK806_POWER_SLP_EN0;
>   				mask = BIT(buck);
> @@ -590,9 +591,10 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>   		{
>   			u8 reg;
>   
> -			if (buck + 1 >= 9) {
> +			if (buck >= 8) {
> +				/* BUCK9 and BUCK10 */
>   				reg = RK806_POWER_SLP_EN1;
> -				mask = BIT(buck + 1 - 3);
> +				mask = BIT(buck - 2);
>   			} else {
>   				reg = RK806_POWER_SLP_EN0;
>   				mask = BIT(buck);
