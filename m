Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3637CC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916B983DEC;
	Thu, 10 Apr 2025 19:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744307809;
	bh=tvKHLS3R6k8/HFJp827nvHOUEd/VTcyjzOpeC8mOr68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zPntBW22uqHP/CHKqKfpHk1JvTSGle2pcxHsIHfH7jfxAda5B80W/fwIDeWqPa3ms
	 XXfcjD8pdKeWRry0/hEbEXkTMu5LRwE/8uRrDNH3LG9GA2T4cB49Wh/jhuJ75xonT9
	 pLcDGeSgXa0wzHGloKnyhNF+RLci8NWlaTQKEmsMuxZB8hTAcaskoLpzNfTH5IrSzA
	 x42hRv1stPaB8s0rmIvxQyE9xT3S2dyHDx3sR2hXFCVDvLE7RktV1DoGch9TSuXn2Q
	 y0EQGW/b0MMY5bpLOxRtbOBMrV8lF6vmxG7UXDZ0S/o0/p1xtmrNesy2Dn/EYHaxKC
	 yiTA/HbeouAAQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDA483DBF; Thu, 10 Apr 2025 19:56:48 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E1F83DB6
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 19:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="O9egX9qA"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 77CF9103B92D7; 
 Thu, 10 Apr 2025 19:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744307805; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=tvKHLS3R6k8/HFJp827nvHOUEd/VTcyjzOpeC8mOr68=;
 b=O9egX9qAgl+8pxYPp0D1BZQxYa/7cFE7k7vDwHWluSFKFGny13KJybNseIOYRftr+RBr0G
 LgX/TSvobv15fA6KyAxwY60IgRk+oEd3brUPb+mLAaRT0aSVZbHN9MLgw1Xe5TPIOZXsX5
 Sv39kpyHn+7yeZDI8LQvYVRM71aUGRdwKJd3K5xpUq8ZWxXQ9lvBsTQK6xcjS4YtV3LpqU
 ddhjij8YKWb2y5MxqW3HXWUwi21Z6BpLx9YQ7ccZ4Kz950uTbtvd97UAWnxeKy5auxrN/0
 0p8jApx6CnlYHz44N6jRAZvVgna6SkZ/X4zgZ+iMMIAp4RO9BZlWmKkCKm68gQ==
Message-ID: <e12fef56-38ac-4762-9c58-fac72e5195a2@denx.de>
Date: Thu, 10 Apr 2025 19:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Fix return type for regulator APIs
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <7bd352562bfe638588acfee524c5df635a77c8a8.1744273054.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7bd352562bfe638588acfee524c5df635a77c8a8.1744273054.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/10/25 10:17 AM, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Apart from ENOENT observing return value as ENOSYS when
> !DM_REGULATOR that's why cover both configurations.
> Changed code is not working as operation should be "&&"
> not "||" (ret != -ENOENT && ret != -ENOSYS).
> 
> Also fix the remove function where the regulator_set_enable_if_allowed()
> function is returning an error.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   common/usb_onboard_hub.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 7fe62b043e6a..57c84e7fce2c 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -146,7 +146,7 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   	int ret;
>   
>   	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
> -	if (ret && ret != -ENOENT) {
> +	if (ret && ret != -ENOENT && ret != -ENOSYS) {
>   		dev_err(dev, "can't get vdd-supply: %d\n", ret);
>   		return ret;
>   	}
> @@ -204,16 +204,21 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>   static int usb_onboard_hub_remove(struct udevice *dev)
>   {
>   	struct onboard_hub *hub = dev_get_priv(dev);
> -	int ret;

int ret = 0;

>   
>   	if (hub->reset_gpio)
>   		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
>   
> -	ret = regulator_set_enable_if_allowed(hub->vdd, false);
> -	if (ret)
> -		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
> +	if (hub->vdd) {
> +		int ret;
>   
> -	return ret;
> +		ret = regulator_set_enable_if_allowed(hub->vdd, false);
> +		if (ret)
> +			dev_err(dev, "can't disable vdd-supply: %d\n", ret);
> +
> +		return ret;

Drop this

> +	}
> +
> +	return 0;
return ret;
