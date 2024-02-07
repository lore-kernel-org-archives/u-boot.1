Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221B9C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 13:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5667F87C9A;
	Wed,  7 Feb 2024 14:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707311228;
	bh=VhMUZOss3/wro///vgSAm/j9d+wcXALUAV6emBiQa5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Np16lUY4FCHG3ivC28Tbah6HtmB5zxr/hseaDuMWNpQSk80Y/yxWuhiQeUbco6XAB
	 5KVDuwOkgjZ4Zj1w59ab/8PH4BNGFcRlNxeT0k6cG+GRXYLl1w3MfeyvzhyTXzJb2K
	 ImrebXjhXAoeydhZhZcWwxMDWUDThXwueM0M+88aWHxcXQf6sb/OGMipksID9dOBPQ
	 rZjg45bHn2TIRcPK4ptxFo7dMw2DrXPdZs2pM0h90UpclPeq/+nf9LQoYppWmJSON6
	 pggVi2JrE3VoPd3KO9+Nt+t92hTeYbk9berI7a0TsxrwQe+1zrvoER/97aMXi+2llH
	 kmFWoydxfglkw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 24E4187C58;
 Wed,  7 Feb 2024 14:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1707311226;
 bh=VhMUZOss3/wro///vgSAm/j9d+wcXALUAV6emBiQa5c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EA9OFl6no3QvBL8f/8dEgiM9e3GRcJdu0n0exzvrDoHu/4eCeIadrjPhNseadyq7U
 IAZ6QURvy7y553L4FLkC5gBATbXGdMM7L2l2AMz6ymclynCPOi+CDyrcEqnKL+T0zP
 gSJz7kSGqVeIUQjsaFNuPeKUcSo2CcRBI2/496qTA0qpo9m1RaaO+swQwMzqsBL4ws
 iqA9SbiaZl2Jh7wJCOGSeW2+cNA5cweC/SDaiXT6lLwIZDqq3K1q3Smg82tZNtGsg8
 yTclIzDFxfIP0NKeXLQWlCh4eHvd4IJBTyEnGpqLybyKaOr6PGlilr/xYh4v0r+YIN
 wFeB++Tr5CA5w==
Message-ID: <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
Date: Wed, 7 Feb 2024 14:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
To: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
Cc: andre.przywara@arm.com, dsimic@manjaro.org,
 Hector Martin <marcan@marcan.st>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240207102327.35125-1-i@shantur.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240207102327.35125-1-i@shantur.com>
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

On 2/7/24 11:23, Shantur Rathore wrote:
> USB 3.0 spec requires hub to reset device while
> enumeration. Some USB 2.0 hubs / devices don't
> handle this well and after implementation of
> reset some USB 2.0 disks weren't detected on
> Allwinner based boards.
> 
> Resetting only when hub is USB 3.0 fixes it.

It would be good to include as many details about the faulty hardware in 
the commit message as possible, so that when someone else runs into 
this, they would have all that information available.

> Tested-by: Andre Przywara <andre.przywara@arm.com>
> 
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
> 
>   common/usb_hub.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/usb_hub.c b/common/usb_hub.c
> index 3fb7e14d10..2e054eb935 100644
> --- a/common/usb_hub.c
> +++ b/common/usb_hub.c
> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
>   
>   	debug("enabling power on all ports\n");
>   	for (i = 0; i < dev->maxchild; i++) {
> -		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> -		debug("Reset : port %d returns %lX\n", i + 1, dev->status);
> +		if (usb_hub_is_superspeed(dev)) {

Should this condition be "all which are lower than superspeed" instead , 
so when the next generation of USB comes, this problem won't trigger ?

What does Linux do btw ?
