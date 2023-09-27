Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F86E7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1871786DBC;
	Wed, 27 Sep 2023 04:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iS1FaaV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D7086DC3; Wed, 27 Sep 2023 04:49:53 +0200 (CEST)
Received: from mail-m12760.qiye.163.com (mail-m12760.qiye.163.com
 [115.236.127.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0204B80282
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iS1FaaV7NHKU5YkRUME0DOYSjq2lX+GtMopapvBLrXjzlAlnn1/eI1q93ciQhH34Q50b2AMqxrteCLT+2XvhbZxX9hciyJzSZIkyB27+sXBx1ihH1Jf5/WwdLa27P34C1l7MArcTgmI6Twh5edUKpvyMKrGXteOUaQ5xWk1TcVo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=QIqvFQPj0800U1aY8OvndLUYpqhHzM+CrR2qPnYhSRo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 481EC400329;
 Wed, 27 Sep 2023 10:49:42 +0800 (CST)
Message-ID: <28f8fc1d-8ed5-6ea7-62a4-4611495dde1e@rock-chips.com>
Date: Wed, 27 Sep 2023 10:49:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/5] regulator: rk8xx: Return correct voltage for
 switchout converters
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>, Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.denx.de, shengfei Xu <xsf@rock-chips.com>
References: <20230821223020.3918620-1-jonas@kwiboo.se>
 <20230821223020.3918620-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230821223020.3918620-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pIHVYfGENMTh1OT0lNHkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8ad48ad49c2eb3kusn481ec400329
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46Phw4SzwyGDYYFTpIGSIJ
 LDVPFDdVSlVKTUJOTENJQkNISENDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISElMNwY+
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
> From: shengfei Xu <xsf@rock-chips.com>
>
> The voltage value for switchout converters is always reported as 0 uV.
> When the switch is enabled, it's voltage is same as input supply.
>
> Fix this by implementing get_value for switchout converters.
>
> Fixes: ee30068fa574 ("power: pmic: rk809: support rk809 pmic")
> Signed-off-by: shengfei Xu <xsf@rock-chips.com>
> [jonas@kwiboo.se: fix checkpatch error, update commit message]
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - New patch
>
>   drivers/power/regulator/rk8xx.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 9444daa85c19..e80bd6c37230 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -1032,6 +1032,25 @@ static int switch_get_suspend_enable(struct udevice *dev)
>    */
>   static int switch_get_value(struct udevice *dev)
>   {
> +	static const char * const supply_name_rk809[] = {
> +		"vcc9-supply",
> +		"vcc8-supply",
> +	};
> +	struct rk8xx_priv *priv = dev_get_priv(dev->parent);
> +	struct udevice *supply;
> +	int id = dev->driver_data - 1;
> +
> +	if (!switch_get_enable(dev))
> +		return 0;
> +
> +	if (priv->variant == RK809_ID) {
> +		if (!uclass_get_device_by_phandle(UCLASS_REGULATOR,
> +						  dev->parent,
> +						  supply_name_rk809[id],
> +						  &supply))
> +			return regulator_get_value(supply);
> +	}
> +
>   	return 0;
>   }
>   
