Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9F6C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57ADF87F95;
	Thu, 28 Mar 2024 11:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711620915;
	bh=Ehur7DpqmHhg555MmSB/8uRrP4YTNK0RfCQb4NW0cr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fguEj2Ftn3u0tJ6mP40l5tSUW1ecUl8a2oPAw3g9er6qaRJZtWivs/fdj+tmXbCfI
	 tV3hGsU1F+X84rp7Yo0w9lm6ONJHecgnbGcC+PHMX38rGdGZ6dbBb02a3hCupwGDIg
	 f2DDsCntuE9aF2ujfxSZcxd9Ne763QslxQXFZdkB/lII774u7JMwPHcgXZDXI234Ye
	 ToRVQjoKerOT6P/t5MReyMsTwWCJb8ml5Zc2Dfz4aT/RDn+PHOR4LeeUpr7uieWPho
	 585c3CavaTy9cwSSM9kNShEkVahcw2B5e1b9/4A04eNccQMOkjcGfai2cQRffxHA3S
	 St0ZjiBp9VwbA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7116788094; Thu, 28 Mar 2024 11:15:14 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98DBC87DE6
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4V4ztk3zKMz9sqw;
 Thu, 28 Mar 2024 11:15:10 +0100 (CET)
Message-ID: <ab15fe52-c157-4875-b8a4-affe7935d23f@denx.de>
Date: Thu, 28 Mar 2024 11:15:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 13/18] gpio: turris_omnia_mcu: Update
 firmware features reading
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-14-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-14-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Update firmware features reading to try reading 32 bits of features and
> fallback to reading 16 bits.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/gpio/turris_omnia_mcu.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/turris_omnia_mcu.c b/drivers/gpio/turris_omnia_mcu.c
> index c441d07d69..40ced261e3 100644
> --- a/drivers/gpio/turris_omnia_mcu.c
> +++ b/drivers/gpio/turris_omnia_mcu.c
> @@ -10,7 +10,7 @@
>   #include <linux/log2.h>
>   
>   struct turris_omnia_mcu_info {
> -	u16 features;
> +	u32 features;
>   };
>   
>   static int turris_omnia_mcu_get_function(struct udevice *dev, uint offset)
> @@ -228,25 +228,37 @@ static int turris_omnia_mcu_probe(struct udevice *dev)
>   {
>   	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
>   	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> -	u16 val;
> +	u32 dword;
> +	u16 word;
>   	int ret;
>   
> -	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&val, sizeof(val));
> +	ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&word, sizeof(word));
>   	if (ret < 0) {
>   		printf("Error: turris_omnia_mcu CMD_GET_STATUS_WORD failed: %d\n",
>   		       ret);
>   		return ret;
>   	}
>   
> -	if (le16_to_cpu(val) & STS_FEATURES_SUPPORTED) {
> -		ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&val,
> -				  sizeof(val));
> +	if (le16_to_cpu(word) & STS_FEATURES_SUPPORTED) {
> +		/* try read 32-bit features */
> +		ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&dword,
> +				  sizeof(dword));
>   		if (ret < 0) {
> -			printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n",
> -			       ret);
> -			return ret;
> +			/* try read 16-bit features */
> +			ret = dm_i2c_read(dev, CMD_GET_FEATURES, (void *)&word,
> +					  sizeof(word));
> +			if (ret < 0) {
> +				printf("Error: turris_omnia_mcu CMD_GET_FEATURES failed: %d\n",
> +				       ret);
> +				return ret;
> +			}
> +
> +			info->features = le16_to_cpu(word);
> +		} else {
> +			info->features = le32_to_cpu(dword);
> +			if (info->features & FEAT_FROM_BIT_16_INVALID)
> +				info->features &= GENMASK(15, 0);
>   		}
> -		info->features = le16_to_cpu(val);
>   	}
>   
>   	uc_priv->bank_name = "mcu_";

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
