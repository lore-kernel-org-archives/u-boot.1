Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01C1C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B65B87F19;
	Thu, 14 Mar 2024 05:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389754;
	bh=8c7U9C/VNEC3Z08uKhvYipiO0h3EqtK+AuBptVMiiTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SgEvecZhigLFvMyzF9JftHnm23npEXNNULryOwcYnvV3L9Rzj3K6iQfQmStOY24n3
	 IMPI+GwmX6UtZBQu3Fx9MovXZ/yZLydqH9X8zNB8BSZ9Ba0Yu+h/qKSAvlbIf4m5El
	 hE9wqNbtokCakpWF6eI5HGNDvF2pBkGGFyDlEJv+tR/CTDN/GSkwFIGtvlJ7efww+A
	 OZXhGI85c0UtUT5txrU9keUsAspobtIhdPGaDxdjo9q+rUv3N+nQNzIU6sRDjukxQ+
	 wim3xjkZ6lGlEVvfca21Oy9zxwTT4OIR6BAflbzKieY5hMRM+pH92IKlzNJoixtw4C
	 PPC9oVE+gXr6g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3F9AD87EF6;
 Thu, 14 Mar 2024 05:15:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389751;
 bh=8c7U9C/VNEC3Z08uKhvYipiO0h3EqtK+AuBptVMiiTs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SHu9hTtXeGOdIdzRg65sMmxzEkoOkq4uvuTOyv2NAOIBeE5XM3F0JhneihVfryPfO
 d/RMu/lYOl9u902nqW3/C0NUywNiboFyvvulezWzJECJ57clPWKv1VuC+z4meuukIw
 4nWDUuOtQH3ha2Yke2gpsj00FSwU+gMcCeknTmbZPIT4LJtMdVj1sempGfgoa4gzx3
 3qN9Pbi4aQh+8tz22BE9xy3EM/8FLcrbdDj5gq9hR0LTipgY9FrEmSgJ6vFQA7UUu0
 zr0qxTz+8tuI7lpoGURXu2vj8J6GsNUM8G33O6rpNyC19KEmuW6dzfNL9eJ4qiWtJG
 JcXq+QvMpgzuA==
Message-ID: <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
Date: Thu, 14 Mar 2024 04:59:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] imx8mp: power-domain: Don't power off pd_bus
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240312070338.86127-5-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/12/24 8:03 AM, Sumit Garg wrote:
> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
> turned off for a single peripheral domain as it would negatively affect
> other peripheral domains. So lets just skip turning off bus power
> domain.

What exactly is the issue and how did you trigger it ?

Details please.

> Fixes: 898e7610c62a ("imx: power-domain: Add i.MX8MP HSIOMIX driver")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/power/domain/imx8mp-hsiomix.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> index e2d772c5ec7..448746432a2 100644
> --- a/drivers/power/domain/imx8mp-hsiomix.c
> +++ b/drivers/power/domain/imx8mp-hsiomix.c
> @@ -50,7 +50,7 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>   
>   	ret = power_domain_on(domain);
>   	if (ret)
> -		goto err_pd;
> +		return ret;
>   
>   	ret = clk_enable(&priv->clk_usb);
>   	if (ret)
> @@ -63,8 +63,6 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>   
>   err_clk:
>   	power_domain_off(domain);
> -err_pd:
> -	power_domain_off(&priv->pd_bus);
>   	return ret;

Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
