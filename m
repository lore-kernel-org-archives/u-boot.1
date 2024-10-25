Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A1AD0C606
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353C488F64;
	Fri, 25 Oct 2024 14:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="O56DI0J0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA6C88F64; Fri, 25 Oct 2024 14:37:05 +0200 (CEST)
Received: from mail-m11883.qiye.163.com (mail-m11883.qiye.163.com
 [115.236.118.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A780A89030
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec473a6;
 Fri, 25 Oct 2024 20:36:44 +0800 (GMT+08:00)
Message-ID: <78d6204b-959c-4a32-b9ec-3f905496e969@rock-chips.com>
Date: Fri, 25 Oct 2024 20:36:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] adc: rockchip-saradc: Use vdd-microvolts prop as
 fallback
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de
References: <20241017200039.1235524-1-jonas@kwiboo.se>
 <20241017200039.1235524-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241017200039.1235524-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8dHlYaTR8eThgfHh4dGhpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3addc8a09d6kunmec473a6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46TBw4CTIpFxcfOFEXAjg0
 NxwwFD9VSlVKTElCQ05CQ0tOSU9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUxONwY+
DKIM-Signature: a=rsa-sha256;
 b=O56DI0J0W24N9egZnE3vIZhG+I7pnCrYiwwih9J9nR/bi2ZToBMmiGztwDsuQler0lAg+bfPL83zPcn6TWiLDZ9fIsMZyLkdgV87BaQN2i4jslDTwTUq45CdVezZViz9KVd1ca7Bj9RIzo2a7lCDkB/y5sTytTy3akmi2lOU/18=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gMr5QdgmDSz+13d94sX0GOvsXdUhoZGI86XLIoRW2cs=;
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


On 2024/10/18 04:00, Jonas Karlman wrote:
> Change to use vdd-microvolts prop value as voltage reference when the
> supply regulator is missing or when DM_REGULATOR=n is used.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/rockchip-saradc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index f6832ab30731..7cf9735f60d0 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -241,7 +241,7 @@ int rockchip_saradc_probe(struct udevice *dev)
>   {
>   	struct adc_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
>   	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> -	struct udevice *vref;
> +	struct udevice *vref = NULL;
>   	struct clk clk;
>   	int vref_uv;
>   	int ret;
> @@ -259,7 +259,7 @@ int rockchip_saradc_probe(struct udevice *dev)
>   	priv->active_channel = -1;
>   
>   	ret = device_get_supply_regulator(dev, "vref-supply", &vref);
> -	if (ret) {
> +	if (ret && uc_pdata->vdd_microvolts <= 0) {
>   		printf("can't get vref-supply: %d\n", ret);
>   		return ret;
>   	}
> @@ -267,7 +267,10 @@ int rockchip_saradc_probe(struct udevice *dev)
>   	if (priv->reset)
>   		rockchip_saradc_reset_controller(priv->reset);
>   
> -	vref_uv = regulator_get_value(vref);
> +	if (vref)
> +		vref_uv = regulator_get_value(vref);
> +	else
> +		vref_uv = uc_pdata->vdd_microvolts;
>   	if (vref_uv < 0) {
>   		printf("can't get vref-supply value: %d\n", vref_uv);
>   		return vref_uv;
