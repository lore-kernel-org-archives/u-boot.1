Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C29AC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6AB81FEE;
	Fri,  6 Jun 2025 11:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OeHXaXbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A872C8291D; Fri,  6 Jun 2025 11:20:34 +0200 (CEST)
Received: from mail-m49234.qiye.163.com (mail-m49234.qiye.163.com
 [45.254.49.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FB5803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c35c117;
 Fri, 6 Jun 2025 17:20:25 +0800 (GMT+08:00)
Message-ID: <c410941b-7f62-4f94-aa06-2723852832d5@rock-chips.com>
Date: Fri, 6 Jun 2025 17:20:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] rockchip: io-domain: Add debug logging for
 regulators during probe
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman
 <jonas@kwiboo.se>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250523165406.40915-1-justin@tidylabs.net>
 <20250523165406.40915-2-justin@tidylabs.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250523165406.40915-2-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh5MVkNKSxofQxhDQklOT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a97448aa28a03afkunm2bd8942f1ebe7f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6HQw4NDEwIRkSQ0pDSCg3
 FRAwCzVVSlVKTE9CSUtKTUlMQ0NJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlPSks3Bg++
DKIM-Signature: a=rsa-sha256;
 b=OeHXaXbulU54xLNaBVqnilIf882OdShWcT8W1NVb1tdfIER6Rz1tTOHLWG+Z+Fxm/p7AW8H/X/0nvgaxfjCpr5lYXrBY6Tgtge6OnbMGPjLBBUnq+HcXdJbRMs83BQ9XQTXB6O7pKFv/m6P40ecs7arHjsCZ8wppK90ZYzBd5ZE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=MxQhAGfPutfRwZfUpObNi6neLDqHqWwbUpOz+5YRy8s=;
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


On 2025/5/24 00:53, Justin Klaassen wrote:
> Log the value of the regulators during initialization of the IO-domain
> driver to aid in debugging GPIO voltage configuration problems.
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Use dev_dbg instead of log_debug
>
> Changes in v2:
> - Made added IO-domain driver logs verbose and consistent
>
>   drivers/misc/rockchip-io-domain.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
> index 025b6049a9f..a0573c52193 100644
> --- a/drivers/misc/rockchip-io-domain.c
> +++ b/drivers/misc/rockchip-io-domain.c
> @@ -344,8 +344,10 @@ static int rockchip_iodomain_probe(struct udevice *dev)
>   			continue;
>   
>   		ret = device_get_supply_regulator(dev, supply_name, &reg);
> -		if (ret)
> +		if (ret) {
> +			dev_dbg(dev, "%s: Regulator not found\n", supply_name);
>   			continue;
> +		}
>   
>   		ret = regulator_autoset(reg);
>   		if (ret && ret != -EALREADY && ret != -EMEDIUMTYPE &&
> @@ -353,6 +355,7 @@ static int rockchip_iodomain_probe(struct udevice *dev)
>   			continue;
>   
>   		uV = regulator_get_value(reg);
> +		dev_dbg(dev, "%s: Regulator %s at %d uV\n", supply_name, reg->name, uV);
>   		if (uV <= 0)
>   			continue;
>   
