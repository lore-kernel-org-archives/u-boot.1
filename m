Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA2C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2D988116;
	Thu, 28 Mar 2024 11:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711620746;
	bh=XMXjKHdEOXzsSOrsg7sJojdClH0eh9kdr/UQM4irneY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tc5p9OaVuLEC2OJYS1hSR6u3rSCAwSNEdi24uo6biRv+WlPsnKzautlPTKIlY90rl
	 HH3mvb9xQ27RPXCKguG3AE1lHqK96WNITsMNrQkorKWlooEwM+D3T3k8G1g7+/OXL8
	 T1uKzhWhHL1HcXiwXVEjFFfsSGsUxWBms7f6FYtQ/xb1QWOBlB1B4awQmtZdLDRtcW
	 Y/DFTY2LM1lTPLu4JoTv1ajuo98Uy48lD8wjY2wxKZxk8j2ZOxdhaBVJNY9hJWAUYa
	 GKU9mAbPwfRzO0i8wFIWgNFVVwTx8GlCq6LkG01OeK5xr8xm6oqYb0U5X7DR1goV43
	 LUFU+ABeYULRQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FDFD88125; Thu, 28 Mar 2024 11:12:25 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870FE87F95
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V4zqT3WYHz9snQ;
 Thu, 28 Mar 2024 11:12:21 +0100 (CET)
Message-ID: <36aa2506-ad0a-4fa0-a950-c241829e244f@denx.de>
Date: Thu, 28 Mar 2024 11:12:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 12/18] gpio: turris_omnia_mcu: Use
 byteorder conversion functions
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-13-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-13-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V4zqT3WYHz9snQ
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

On 3/27/24 17:23, Marek Behún wrote:
> Use byteorder conversion function instead of manually assembling data
> from/to MCU.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/gpio/turris_omnia_mcu.c | 80 +++++++++++++++++++--------------
>   1 file changed, 46 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpio/turris_omnia_mcu.c b/drivers/gpio/turris_omnia_mcu.c
> index da9a6efe6d..c441d07d69 100644
> --- a/drivers/gpio/turris_omnia_mcu.c
> +++ b/drivers/gpio/turris_omnia_mcu.c
> @@ -5,6 +5,7 @@
>   #include <dm.h>
>   #include <i2c.h>
>   #include <turris-omnia-mcu-interface.h>
> +#include <asm/byteorder.h>
>   #include <asm/gpio.h>
>   #include <linux/log2.h>
>   
> @@ -51,27 +52,31 @@ static int turris_omnia_mcu_get_function(struct udevice *dev, uint offset)
>   static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
>   {
>   	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
> -	u8 val16[2];
> -	u8 val32[4];
> +	u32 val32;
> +	u16 val16;
>   	int ret;
>   
>   	switch (offset) {
>   	/* bank 0 */
>   	case 0 ... 15:
> -		ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, val16, 2);
> +		ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&val16,
> +				  sizeof(val16));
>   		if (ret)
>   			return ret;
> -		return ((((u16)val16[1] << 8) | val16[0]) >> offset) & 0x1;
> +
> +		return !!(le16_to_cpu(val16) & BIT(offset));
>   
>   	/* bank 1 - supported only when FEAT_EXT_CMDS is set */
>   	case (16 + 0) ... (16 + 31):
>   		if (!(info->features & FEAT_EXT_CMDS))
>   			return -EINVAL;
> -		ret = dm_i2c_read(dev, CMD_GET_EXT_STATUS_DWORD, val32, 4);
> +
> +		ret = dm_i2c_read(dev, CMD_GET_EXT_STATUS_DWORD, (void *)&val32,
> +				  sizeof(val32));
>   		if (ret)
>   			return ret;
> -		return ((((u32)val32[3] << 24) | ((u32)val32[2] << 16) |
> -			 ((u32)val32[1] << 8) | val32[0]) >> (offset - 16)) & 0x1;
> +
> +		return !!(le32_to_cpu(val32) & BIT(offset - 16));
>   
>   	/* bank 2 - supported only when FEAT_EXT_CMDS and FEAT_PERIPH_MCU is set */
>   	case (16 + 32 + 0) ... (16 + 32 + 15):
> @@ -79,10 +84,13 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
>   			return -EINVAL;
>   		if (!(info->features & FEAT_PERIPH_MCU))
>   			return -EINVAL;
> -		ret = dm_i2c_read(dev, CMD_GET_EXT_CONTROL_STATUS, val16, 2);
> +
> +		ret = dm_i2c_read(dev, CMD_GET_EXT_CONTROL_STATUS,
> +				  (void *)&val16, sizeof(val16));
>   		if (ret)
>   			return ret;
> -		return ((((u16)val16[1] << 8) | val16[0]) >> (offset - 16 - 32)) & 0x1;
> +
> +		return !!(le16_to_cpu(val16) & BIT(offset - 16 - 32));
>   
>   	default:
>   		return -EINVAL;
> @@ -92,30 +100,33 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
>   static int turris_omnia_mcu_set_value(struct udevice *dev, uint offset, int value)
>   {
>   	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
> -	u8 val16[2];
> -	u8 val32[4];
> +	u16 valmask16[2];
> +	u8 valmask8[2];
>   
>   	switch (offset) {
>   	/* bank 0 */
>   	case 0 ... 15:
>   		switch (offset) {
>   		case ilog2(STS_USB30_PWRON):
> -			val16[1] = CTL_USB30_PWRON;
> +			valmask8[1] = CTL_USB30_PWRON;
>   			break;
>   		case ilog2(STS_USB31_PWRON):
> -			val16[1] = CTL_USB31_PWRON;
> +			valmask8[1] = CTL_USB31_PWRON;
>   			break;
>   		case ilog2(STS_ENABLE_4V5):
> -			val16[1] = CTL_ENABLE_4V5;
> +			valmask8[1] = CTL_ENABLE_4V5;
>   			break;
>   		case ilog2(STS_BUTTON_MODE):
> -			val16[1] = CTL_BUTTON_MODE;
> +			valmask8[1] = CTL_BUTTON_MODE;
>   			break;
>   		default:
>   			return -EINVAL;
>   		}
> -		val16[0] = value ? val16[1] : 0;
> -		return dm_i2c_write(dev, CMD_GENERAL_CONTROL, val16, sizeof(val16));
> +
> +		valmask8[0] = value ? valmask8[1] : 0;
> +
> +		return dm_i2c_write(dev, CMD_GENERAL_CONTROL, valmask8,
> +				    sizeof(valmask8));
>   
>   	/* bank 2 - supported only when FEAT_EXT_CMDS and FEAT_PERIPH_MCU is set */
>   	case (16 + 32 + 0) ... (16 + 32 + 15):
> @@ -123,11 +134,12 @@ static int turris_omnia_mcu_set_value(struct udevice *dev, uint offset, int valu
>   			return -EINVAL;
>   		if (!(info->features & FEAT_PERIPH_MCU))
>   			return -EINVAL;
> -		val32[3] = BIT(offset - 16 - 32) >> 8;
> -		val32[2] = BIT(offset - 16 - 32) & 0xff;
> -		val32[1] = value ? val32[3] : 0;
> -		val32[0] = value ? val32[2] : 0;
> -		return dm_i2c_write(dev, CMD_EXT_CONTROL, val32, sizeof(val32));
> +
> +		valmask16[1] = cpu_to_le16(BIT(offset - 16 - 32));
> +		valmask16[0] = value ? valmask16[1] : 0;
> +
> +		return dm_i2c_write(dev, CMD_EXT_CONTROL, (void *)valmask16,
> +				    sizeof(valmask16));
>   
>   	default:
>   		return -EINVAL;
> @@ -216,25 +228,25 @@ static int turris_omnia_mcu_probe(struct udevice *dev)
>   {
>   	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
>   	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> -	u16 status;
> -	u8 val[2];
> +	u16 val;
>   	int ret;
>   
> -	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, val, 2);
> -	if (ret) {
> -		printf("Error: turris_omnia_mcu CMD_GET_STATUS_WORD failed: %d\n", ret);
> +	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&val, sizeof(val));
> +	if (ret < 0) {
> +		printf("Error: turris_omnia_mcu CMD_GET_STATUS_WORD failed: %d\n",
> +		       ret);
>   		return ret;
>   	}
>   
> -	status = ((u16)val[1] << 8) | val[0];
> -
> -	if (status & STS_FEATURES_SUPPORTED) {
> -		ret = dm_i2c_read(dev, CMD_GET_FEATURES, val, 2);
> -		if (ret) {
> -			printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n", ret);
> +	if (le16_to_cpu(val) & STS_FEATURES_SUPPORTED) {
> +		ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&val,
> +				  sizeof(val));
> +		if (ret < 0) {
> +			printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n",
> +			       ret);
>   			return ret;
>   		}
> -		info->features = ((u16)val[1] << 8) | val[0];
> +		info->features = le16_to_cpu(val);
>   	}
>   
>   	uc_priv->bank_name = "mcu_";

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
