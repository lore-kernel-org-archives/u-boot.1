Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B06ECD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 11:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4B387F4F;
	Tue, 26 Mar 2024 12:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711453817;
	bh=56nvxFJPadhA3CkOiFcKfP66uIwjvVYCB7aAyGUysKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+FIXff1+FgHiqtOOzBii9OZrFLCImVVxy3dxSWgib2e6MXA8MWgAzlNRel5m0f0t
	 24ihM93swfcQEtuNKHJoBZdCIUmMGWRk+yX/a362EQeHo5YJuy7ZQozEjcdVwKU4N7
	 W1tSP672lb//nc3OK3wDh6MV2ctYI/9Z3zUgMWTmX9Qvb049uhK+sGVe7qxkLWANuu
	 +uQL1J/06O2cDkKV+fUH62U8rAUrEDH89Kk6ZJnWqY/qFj7aO77TBvw3ZlnbIj+tbU
	 kBdBn4MOqQ/WUa2mddy4p9OFhCZJhA+V6F7mOdgL+0zXIYeEcY6mdYG+fBfxoBvCgm
	 GwQoO82Lban8g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5CA9287ABC;
 Tue, 26 Mar 2024 12:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711453816;
 bh=56nvxFJPadhA3CkOiFcKfP66uIwjvVYCB7aAyGUysKw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lWJoQeCgZrKp1Mv/n+rnU8Ocw+NnP7uTlnZ9kM9Wlb5AuyIpAB5QhFKcWutF7tAJa
 7h3i/Twfo/OCtByN5K4iqPrONrWv1tbXTTjoKp5nqbf4u4hA2Tr652762dfNoGLM//
 g7V7BJFByZgiG8CEw2iQcfX3Xb3b5TJp8pc5S5Z1mhbmS9RrP8LEBP89onIHtztyQi
 P4/TPa7s4ikM3dBKbVF6Hzxiq7CcEZypxiDjyLfF68G16H9gwTL0dHX0npsPuWl2kE
 LNmxT2ISVZaTAdAZLUl18O1XaKllmJipt3dsxYIMEygLUCwCBoW/+tjco7rXJ4odhW
 tkLlcy9PA0noQ==
Message-ID: <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
Date: Tue, 26 Mar 2024 12:50:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2: Add in version 4xx compatibility
To: Greg Malysa <greg.malysa@timesys.com>, u-boot@lists.denx.de
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>,
 Tom Rini <trini@konsulko.com>
References: <20240326023208.3525-1-greg.malysa@timesys.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240326023208.3525-1-greg.malysa@timesys.com>
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

On 3/26/24 3:32 AM, Greg Malysa wrote:
> From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> This adds the Synopsys device id for version 4xx of the designware
> IP block and extends the version check to include it to permit
> new hardware to run. It does not add any 4xx-specific features.
> 
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> ---
> 
> 
> ---
>   drivers/usb/host/dwc2.c | 3 ++-
>   drivers/usb/host/dwc2.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index 637eb2dd06..6fdde6a9a7 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -1180,7 +1180,8 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
>   		 snpsid >> 12 & 0xf, snpsid & 0xfff);
>   
>   	if ((snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_2xx &&
> -	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx) {
> +	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx &&
> +	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_4xx) {
>   		dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08x\n",
>   			 snpsid);
>   		return -ENODEV;
> diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
> index 6f022e33a1..f202d55eb2 100644
> --- a/drivers/usb/host/dwc2.h
> +++ b/drivers/usb/host/dwc2.h
> @@ -739,6 +739,7 @@ struct dwc2_core_regs {
>   #define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET			7
>   #define DWC2_SNPSID_DEVID_VER_2xx			(0x4f542 << 12)
>   #define DWC2_SNPSID_DEVID_VER_3xx			(0x4f543 << 12)
> +#define DWC2_SNPSID_DEVID_VER_4xx			(0x4f544 << 12)
>   #define DWC2_SNPSID_DEVID_MASK				(0xfffff << 12)
>   #define DWC2_SNPSID_DEVID_OFFSET			12

Maybe it would be better/easier/futureproof to simply check if (snpsid & 
0xffff0 == 0x4f540) ?
