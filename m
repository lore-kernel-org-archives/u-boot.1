Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB3DE7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D97186DB1;
	Wed, 27 Sep 2023 04:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IqXVANgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5357686DB4; Wed, 27 Sep 2023 04:49:42 +0200 (CEST)
Received: from mail-m12793.qiye.163.com (mail-m12793.qiye.163.com
 [115.236.127.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38AB80282
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IqXVANgQSSe8QLlWU+kSCcrUwybUntty2v54U4650Hvnvoxv/HykWzuBja4yFGH7zUiTHJhJ+4+z5/TYTif8HQeKVqQC/qrqh0gApfnXhMWgnedn/OtZDVkNtiU9TxBYiAC8woSCH0MUUAITYtiWb9xyTXPtX3s2V2smb07NyBY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=yvK7FCtMDQs1CDMXqyiz1URwrW1lij3zAn7GpGVtuuE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id D6A9340031C;
 Wed, 27 Sep 2023 10:49:31 +0800 (CST)
Message-ID: <be4bb156-b44d-6898-5ef6-6b287815d8fa@rock-chips.com>
Date: Wed, 27 Sep 2023 10:49:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] regulator: rk8xx: Return correct voltage for buck
 converters
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20230821223020.3918620-1-jonas@kwiboo.se>
 <20230821223020.3918620-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230821223020.3918620-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIdGlYeQh4ZSBlLQkJCH09VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8ad48aaaaf2eb3kusnd6a9340031c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6Tio*Njw3MjY3FT8*GSJW
 EB1PCh1VSlVKTUJOTENJQkxJTUhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU1PSjcG
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


On 2023/8/22 06:30, Jonas Karlman wrote:
> From: Joseph Chen <chenjh@rock-chips.com>
>
> Information from the first range group is always used to calculate the
> voltage returned for buck converters. This may result in wrong voltage
> reported back to the regulator_get_value caller.
>
> Traverse all the possible BUCK ranges to fix this issue.
>
> Fixes: addd062beacc ("power: pmic: rk816: support rk816 pmic")
> Fixes: b62280745e55 ("power: pmic: rk805: support rk805 pmic")
> Fixes: b4a35574b38d ("power: pmic: rk817: support rk817 pmic")
> Fixes: ee30068fa574 ("power: pmic: rk809: support rk809 pmic")
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
> [jonas@kwiboo.se: fix checkpatch error, simplify buck get_value, update commit message]
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Simplify locating correct rk8xx_reg_info
> - Update max_sel to include range up to and including vsel_mask
> - Drop range_num
> - Collect r-b tag
>
>   drivers/power/regulator/rk8xx.c | 76 +++++++++++++++++----------------
>   1 file changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index e95640a39b0a..9444daa85c19 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -88,62 +88,63 @@ struct rk8xx_reg_info {
>   	u8 config_reg;
>   	u8 vsel_mask;
>   	u8 min_sel;
> +	u8 max_sel;
>   };
>   
>   static const struct rk8xx_reg_info rk808_buck[] = {
> -	{ 712500,   12500, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG, RK808_BUCK_VSEL_MASK, },
> -	{ 712500,   12500, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG, RK808_BUCK_VSEL_MASK, },
> -	{ 712500,   12500, NA,		      NA,		  REG_BUCK3_CONFIG, RK808_BUCK_VSEL_MASK, },
> -	{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK808_BUCK4_VSEL_MASK, },
> +	{  712500,  12500, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG,  RK808_BUCK_VSEL_MASK, 0x00, 0x3f },
> +	{  712500,  12500, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG,  RK808_BUCK_VSEL_MASK, 0x00, 0x3f },
> +	{      NA,     NA,		  NA,		      NA, REG_BUCK3_CONFIG,		       NA,   NA,   NA },
> +	{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK808_BUCK4_VSEL_MASK, 0x00, 0x0f },
>   };
>   
>   static const struct rk8xx_reg_info rk816_buck[] = {
>   	/* buck 1 */
> -	{  712500,  12500, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG, RK818_BUCK_VSEL_MASK, 0x00, },
> -	{ 1800000, 200000, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG, RK818_BUCK_VSEL_MASK, 0x3c, },
> -	{ 2300000,      0, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG, RK818_BUCK_VSEL_MASK, 0x3f, },
> +	{  712500,  12500, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG,  RK818_BUCK_VSEL_MASK, 0x00, 0x3b },
> +	{ 1800000, 200000, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG,  RK818_BUCK_VSEL_MASK, 0x3c, 0x3e },
> +	{ 2300000,	0, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG,  RK818_BUCK_VSEL_MASK, 0x3f, 0x3f },
>   	/* buck 2 */
> -	{  712500,  12500, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG, RK818_BUCK_VSEL_MASK, 0x00, },
> -	{ 1800000, 200000, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG, RK818_BUCK_VSEL_MASK, 0x3c, },
> -	{ 2300000,      0, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG, RK818_BUCK_VSEL_MASK, 0x3f, },
> +	{  712500,  12500, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG,  RK818_BUCK_VSEL_MASK, 0x00, 0x3b },
> +	{ 1800000, 200000, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG,  RK818_BUCK_VSEL_MASK, 0x3c, 0x3e },
> +	{ 2300000,	0, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG,  RK818_BUCK_VSEL_MASK, 0x3f, 0x3f },
>   	/* buck 3 */
> -	{ 712500,   12500, NA,		      NA,		  REG_BUCK3_CONFIG, RK818_BUCK_VSEL_MASK, },
> +	{      NA,     NA,		  NA,		      NA, REG_BUCK3_CONFIG,                    NA,   NA,   NA },
>   	/* buck 4 */
> -	{  800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, },
> +	{  800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, 0x00, 0x1f },
>   };
>   
>   static const struct rk8xx_reg_info rk809_buck5[] = {
>   	/* buck 5 */
> -	{ 1500000,	0, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x00, },
> -	{ 1800000, 200000, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x01, },
> -	{ 2800000, 200000, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x04, },
> -	{ 3300000, 300000, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x06, },
> +	{ 1500000,	0, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x00, 0x00 },
> +	{ 1800000, 200000, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x01, 0x03 },
> +	{ 2800000, 200000, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x04, 0x05 },
> +	{ 3300000, 300000, RK809_BUCK5_CONFIG(0), RK809_BUCK5_CONFIG(1), NA, RK809_BUCK5_VSEL_MASK, 0x06, 0x07 },
>   };
>   
>   static const struct rk8xx_reg_info rk817_buck[] = {
>   	/* buck 1 */
> -	{  500000,  12500, RK817_BUCK_ON_VSEL(1), RK817_BUCK_SLP_VSEL(1), RK817_BUCK_CONFIG(1), RK817_BUCK_VSEL_MASK, 0x00, },
> -	{ 1500000, 100000, RK817_BUCK_ON_VSEL(1), RK817_BUCK_SLP_VSEL(1), RK817_BUCK_CONFIG(1), RK817_BUCK_VSEL_MASK, 0x50, },
> -	{ 2400000,	0, RK817_BUCK_ON_VSEL(1), RK817_BUCK_SLP_VSEL(1), RK817_BUCK_CONFIG(1), RK817_BUCK_VSEL_MASK, 0x59, },
> +	{  500000,  12500, RK817_BUCK_ON_VSEL(1), RK817_BUCK_SLP_VSEL(1), RK817_BUCK_CONFIG(1), RK817_BUCK_VSEL_MASK, 0x00, 0x4f },
> +	{ 1500000, 100000, RK817_BUCK_ON_VSEL(1), RK817_BUCK_SLP_VSEL(1), RK817_BUCK_CONFIG(1), RK817_BUCK_VSEL_MASK, 0x50, 0x58 },
> +	{ 2400000,	0, RK817_BUCK_ON_VSEL(1), RK817_BUCK_SLP_VSEL(1), RK817_BUCK_CONFIG(1), RK817_BUCK_VSEL_MASK, 0x59, 0x7f },
>   	/* buck 2 */
> -	{  500000,  12500, RK817_BUCK_ON_VSEL(2), RK817_BUCK_SLP_VSEL(2), RK817_BUCK_CONFIG(2), RK817_BUCK_VSEL_MASK, 0x00, },
> -	{ 1500000, 100000, RK817_BUCK_ON_VSEL(2), RK817_BUCK_SLP_VSEL(2), RK817_BUCK_CONFIG(2), RK817_BUCK_VSEL_MASK, 0x50, },
> -	{ 2400000,	0, RK817_BUCK_ON_VSEL(2), RK817_BUCK_SLP_VSEL(2), RK817_BUCK_CONFIG(2), RK817_BUCK_VSEL_MASK, 0x59, },
> +	{  500000,  12500, RK817_BUCK_ON_VSEL(2), RK817_BUCK_SLP_VSEL(2), RK817_BUCK_CONFIG(2), RK817_BUCK_VSEL_MASK, 0x00, 0x4f },
> +	{ 1500000, 100000, RK817_BUCK_ON_VSEL(2), RK817_BUCK_SLP_VSEL(2), RK817_BUCK_CONFIG(2), RK817_BUCK_VSEL_MASK, 0x50, 0x58 },
> +	{ 2400000,	0, RK817_BUCK_ON_VSEL(2), RK817_BUCK_SLP_VSEL(2), RK817_BUCK_CONFIG(2), RK817_BUCK_VSEL_MASK, 0x59, 0x7f },
>   	/* buck 3 */
> -	{  500000,  12500, RK817_BUCK_ON_VSEL(3), RK817_BUCK_SLP_VSEL(3), RK817_BUCK_CONFIG(3), RK817_BUCK_VSEL_MASK, 0x00, },
> -	{ 1500000, 100000, RK817_BUCK_ON_VSEL(3), RK817_BUCK_SLP_VSEL(3), RK817_BUCK_CONFIG(3), RK817_BUCK_VSEL_MASK, 0x50, },
> -	{ 2400000,	0, RK817_BUCK_ON_VSEL(3), RK817_BUCK_SLP_VSEL(3), RK817_BUCK_CONFIG(3), RK817_BUCK_VSEL_MASK, 0x59, },
> +	{  500000,  12500, RK817_BUCK_ON_VSEL(3), RK817_BUCK_SLP_VSEL(3), RK817_BUCK_CONFIG(3), RK817_BUCK_VSEL_MASK, 0x00, 0x4f },
> +	{ 1500000, 100000, RK817_BUCK_ON_VSEL(3), RK817_BUCK_SLP_VSEL(3), RK817_BUCK_CONFIG(3), RK817_BUCK_VSEL_MASK, 0x50, 0x58 },
> +	{ 2400000,	0, RK817_BUCK_ON_VSEL(3), RK817_BUCK_SLP_VSEL(3), RK817_BUCK_CONFIG(3), RK817_BUCK_VSEL_MASK, 0x59, 0x7f },
>   	/* buck 4 */
> -	{  500000,  12500, RK817_BUCK_ON_VSEL(4), RK817_BUCK_SLP_VSEL(4), RK817_BUCK_CONFIG(4), RK817_BUCK_VSEL_MASK, 0x00, },
> -	{ 1500000, 100000, RK817_BUCK_ON_VSEL(4), RK817_BUCK_SLP_VSEL(4), RK817_BUCK_CONFIG(4), RK817_BUCK_VSEL_MASK, 0x50, },
> -	{ 3400000,	0, RK817_BUCK_ON_VSEL(4), RK817_BUCK_SLP_VSEL(4), RK817_BUCK_CONFIG(4), RK817_BUCK_VSEL_MASK, 0x63, },
> +	{  500000,  12500, RK817_BUCK_ON_VSEL(4), RK817_BUCK_SLP_VSEL(4), RK817_BUCK_CONFIG(4), RK817_BUCK_VSEL_MASK, 0x00, 0x4f },
> +	{ 1500000, 100000, RK817_BUCK_ON_VSEL(4), RK817_BUCK_SLP_VSEL(4), RK817_BUCK_CONFIG(4), RK817_BUCK_VSEL_MASK, 0x50, 0x62 },
> +	{ 3400000,	0, RK817_BUCK_ON_VSEL(4), RK817_BUCK_SLP_VSEL(4), RK817_BUCK_CONFIG(4), RK817_BUCK_VSEL_MASK, 0x63, 0x7f },
>   };
>   
>   static const struct rk8xx_reg_info rk818_buck[] = {
> -	{ 712500,   12500, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG, RK818_BUCK_VSEL_MASK, },
> -	{ 712500,   12500, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG, RK818_BUCK_VSEL_MASK, },
> -	{ 712500,   12500, NA,		      NA,		  REG_BUCK3_CONFIG, RK818_BUCK_VSEL_MASK, },
> -	{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, },
> +	{ 712500,   12500, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG,  RK818_BUCK_VSEL_MASK, 0x00, 0x3f },
> +	{ 712500,   12500, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG,  RK818_BUCK_VSEL_MASK, 0x00, 0x3f },
> +	{     NA,      NA,		  NA,		      NA, REG_BUCK3_CONFIG,		       NA,   NA,   NA },
> +	{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, 0x00, 0x1f },
>   };
>   
>   #ifdef ENABLE_DRIVER
> @@ -706,7 +707,6 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>   static int buck_get_value(struct udevice *dev)
>   {
>   	int buck = dev->driver_data - 1;
> -	/* We assume level-1 voltage is enough for usage in U-Boot */
>   	const struct rk8xx_reg_info *info = get_buck_reg(dev->parent, buck, 0);
>   	int mask = info->vsel_mask;
>   	int ret, val;
> @@ -717,9 +717,12 @@ static int buck_get_value(struct udevice *dev)
>   	ret = pmic_reg_read(dev->parent, info->vsel_reg);
>   	if (ret < 0)
>   		return ret;
> +
>   	val = ret & mask;
> +	while (val > info->max_sel)
> +		info++;
>   
> -	return info->min_uv + val * info->step_uv;
> +	return info->min_uv + (val - info->min_sel) * info->step_uv;
>   }
>   
>   static int buck_set_value(struct udevice *dev, int uvolt)
> @@ -732,7 +735,6 @@ static int buck_set_value(struct udevice *dev, int uvolt)
>   static int buck_get_suspend_value(struct udevice *dev)
>   {
>   	int buck = dev->driver_data - 1;
> -	/* We assume level-1 voltage is enough for usage in U-Boot */
>   	const struct rk8xx_reg_info *info = get_buck_reg(dev->parent, buck, 0);
>   	int mask = info->vsel_mask;
>   	int ret, val;
> @@ -745,8 +747,10 @@ static int buck_get_suspend_value(struct udevice *dev)
>   		return ret;
>   
>   	val = ret & mask;
> +	while (val > info->max_sel)
> +		info++;
>   
> -	return info->min_uv + val * info->step_uv;
> +	return info->min_uv + (val - info->min_sel) * info->step_uv;
>   }
>   
>   static int buck_set_suspend_value(struct udevice *dev, int uvolt)
