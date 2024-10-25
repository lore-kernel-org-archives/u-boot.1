Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA09BD0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EF789017;
	Fri, 25 Oct 2024 14:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fbr1PaEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF4189023; Fri, 25 Oct 2024 14:36:16 +0200 (CEST)
Received: from mail-m11871.qiye.163.com (mail-m11871.qiye.163.com
 [115.236.118.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A976B88DB7
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec47377;
 Fri, 25 Oct 2024 20:35:57 +0800 (GMT+08:00)
Message-ID: <ab004efe-cbf7-4b7e-8285-46c13f2465d8@rock-chips.com>
Date: Fri, 25 Oct 2024 20:35:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] adc: Allow use of adc with DM_REGULATOR disabled
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de
References: <20241017200039.1235524-1-jonas@kwiboo.se>
 <20241017200039.1235524-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241017200039.1235524-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1KSVYfH0pMSU9KSx8ZTk5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3ad26b509d6kunmec47377
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBA6Qhw5SjIuLRc0EkoDAjU#
 Vh0wFDxVSlVKTElCQ05CTE5DTEhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUpDNwY+
DKIM-Signature: a=rsa-sha256;
 b=fbr1PaEAlhuAviuNnNz8D14GUm2VYRYMagOwtwwztOCrWR5cr7ZKAXcvFl3FDHN5D2HtE1ds2RKS7aEQ32L7GeCxvFAd3+WEgI38r6VM7jEjh1ibyvIKrLgjcU8OdwjlJv0R1fqbBpn4cksztefrfL2TJLxKbxYIrvaXf35XtF8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=5PWGN7zY/w0OSZUisYxnnYDAA2G5XSMjv7AtHuvukr4=;
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
> When DM_REGULATOR=n is used the device_get_supply_regulator() function
> always return -ENOSYS.
>
> Change to treat missing support for regulators as a missing optional
> vdd/vss-supply regulator to reduce error messages being logged.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/adc-uclass.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/adc/adc-uclass.c b/drivers/adc/adc-uclass.c
> index 16600be821c9..b02430eb7d7f 100644
> --- a/drivers/adc/adc-uclass.c
> +++ b/drivers/adc/adc-uclass.c
> @@ -382,7 +382,7 @@ static int adc_vdd_plat_set(struct udevice *dev)
>   	if (!ret)
>   		return adc_vdd_plat_update(dev);
>   
> -	if (ret != -ENOENT)
> +	if (ret != -ENOSYS && ret != -ENOENT)
>   		return ret;
>   
>   	/* No vdd-supply phandle. */
> @@ -406,7 +406,7 @@ static int adc_vss_plat_set(struct udevice *dev)
>   	if (!ret)
>   		return adc_vss_plat_update(dev);
>   
> -	if (ret != -ENOENT)
> +	if (ret != -ENOSYS && ret != -ENOENT)
>   		return ret;
>   
>   	/* No vss-supply phandle. */
