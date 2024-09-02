Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE40ACD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 07:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC3C88717;
	Mon,  2 Sep 2024 09:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VOfIHP2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255D488A12; Mon,  2 Sep 2024 09:06:37 +0200 (CEST)
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com
 [220.197.32.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9393087FCD
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 09:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VOfIHP2LrpjRksY1EDi4rLB2Btm1Vf7KnYmyfZvxb4A02Qdk1cA5p4j7pFpaQV4SMziSPz5wNoxbIY+fcw9eoyh5p5khIav0C4llbqIllmt0W+lFwQncD2HNbZT1S6fwNrkoc9N1kfnZNn4JbZKHw5pIvjDNav8GVaFafUYSkIo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=1gfoGFeJ2wDFq1fAFTdrgS2cOase29JlzHnTJcAzK/M=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D1273900512;
 Mon,  2 Sep 2024 15:06:20 +0800 (CST)
Message-ID: <14067aea-8986-44da-afdd-b163e07b3bcb@rock-chips.com>
Date: Mon, 2 Sep 2024 15:06:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: rk8xx: Fix buck get and set enabled state on
 RK806
To: Jonas Karlman <jonas@kwiboo.se>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
References: <20240830224207.2568205-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240830224207.2568205-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE1OVksaTRhLQkNNTB9LSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91b18e581403a9kunmd1273900512
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46SDo4ODI0HlFJP05NQgk3
 CwkaCRRVSlVKTElOSU1LTENJSEhMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhOTUI3Bg++
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

Hi Jonas,

On 2024/8/31 06:42, Jonas Karlman wrote:
> Wrong POWER_EN reg is used to get and set enabled state for the RK806
> buck 4 and 8 regulators, also wrong POWER_SLP_EN0 bit is used for
> suspend state for the RK806 buck 1-8 regulators.
>
> Fix this by not adding one to the zero based buck variable.
>
> Fixes: f172575d92cd ("power: rk8xx: add support for RK806")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
>   drivers/power/regulator/rk8xx.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 34e61511d884..3f5ec02b3824 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -415,7 +415,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>   		break;
>   	case RK806_ID:
>   		value = RK806_POWER_EN_CLRSETBITS(buck % 4, enable);
> -		en_reg = RK806_POWER_EN((buck + 1) / 4);
> +		en_reg = RK806_POWER_EN(buck / 4);
>   		ret = pmic_reg_write(pmic, en_reg, value);
>   		break;
>   	case RK808_ID:
> @@ -494,7 +494,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
>   		break;
>   	case RK806_ID:
>   		mask = BIT(buck % 4);
> -		ret = pmic_reg_read(pmic, RK806_POWER_EN((buck + 1) / 4));
> +		ret = pmic_reg_read(pmic, RK806_POWER_EN(buck / 4));
>   		break;
>   	case RK808_ID:
>   	case RK818_ID:
> @@ -541,10 +541,10 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
>   
>   			if (buck + 1 >= 9) {
>   				reg = RK806_POWER_SLP_EN1;
> -				mask = BIT(buck + 1 - 3);
> +				mask = BIT(buck - 2);
>   			} else {
>   				reg = RK806_POWER_SLP_EN0;
> -				mask = BIT(buck + 1);
> +				mask = BIT(buck);
>   			}
>   			ret = pmic_clrsetbits(pmic, reg, mask, enable ? mask : 0);
>   		}
> @@ -592,10 +592,10 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>   
>   			if (buck + 1 >= 9) {
>   				reg = RK806_POWER_SLP_EN1;
> -				mask = BIT(buck + 1 - 3);
> +				mask = BIT(buck - 2);
>   			} else {
>   				reg = RK806_POWER_SLP_EN0;
> -				mask = BIT(buck + 1);
> +				mask = BIT(buck);
>   			}
>   			val = pmic_reg_read(pmic, reg);
>   		}
