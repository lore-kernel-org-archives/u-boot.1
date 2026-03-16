Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7754F46441
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 10:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6AD8401A;
	Mon, 16 Mar 2026 11:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YhoTYQkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A6E8401F; Mon, 16 Mar 2026 11:04:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AFE84010
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dbc6=BQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773655460;
 bh=Sp+I+O82MzTKZzarZr2aryXlj/1BPRY/+CtbUnpc8Cw=;
 b=YhoTYQkXqn5fafx1fQz59i0mL7r8uCR1+nBnZZnrrHf+L/AdT6SoHz6as4aUgmCXvA0QUclM5
 AZWQhgx3L9W4UgWCILJeunpYhi87BfLG/Go69yuPKpfwmYm6xETg7FZFEscSX/E5E6Az8tMRRzk
 2MPVpeztAmbEl49OvGJ6q4vwqDTFA/UsFbnLu+gebYjk2Va/2mWSQxBFdlu7+Ab3xrQXCpil+p0
 UkvC4A1z5aCPqEakVlAIzYcL58x9ZtXe946M474lHofTSpf0leQuj+jhfVAJodPbZN6FxU/JsRX
 VyNx1CDy/PSsf18PVuvJ8bDPQbdU+Fl/NST8/z1f1s4A==
X-Forward-Email-ID: 69b7d5a02326cf9cee486a98
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.50
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <942c0020-e43d-4d86-b8c0-ccc8f7ed2b2c@kwiboo.se>
Date: Mon, 16 Mar 2026 11:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: dwc2: allow usb start even if usbphy is not found
To: Marius Dinu <m95d+git@psihoexpert.ro>
References: <20260316092639.2377-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260316092639.2377-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
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

Hi Marius,

On 3/16/2026 10:26 AM, Marius Dinu wrote:
> RK3288 uses rockchip_usb2_phy, but that driver doesn't register iself
> as a usbphy driver and "usb start" fails with this error:
> 
>   drivers/usb/host/dwc2.c:1254- dwc2_setup_phy() dwc2_usb usb@ff580000:
>   Failed to get USB PHY: -19.
> 
> Until a proper fix is made for rockchip_usb2_phy, this patch allows
> usb start to continue even if usbphy is not found.
> 
> Tested on Asus TinkerBoard.

I am not seeing this issue on my TinkerBoard, what U-Boot version are
you testing and have you made any config changes compared to
tinker-rk3288_defconfig?

  => usb start
  starting USB...
  USB DWC2
  USB DWC2
  Bus usb@ff540000: 2 USB Device(s) found
  Bus usb@ff580000: 1 USB Device(s) found
         scanning usb for storage devices... 0 Storage Device(s) found

  => dm tree -e usb
   Class     Seq    Probed  Driver                Name
  -----------------------------------------------------------
   usb           0  [ + ]   dwc2_usb              usb@ff540000
   usb_hub       0  [ + ]   usb_hub               `-- usb_hub
   usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
   usb           1  [ + ]   dwc2_usb              usb@ff580000
   usb_hub       2  [ + ]   usb_hub               `-- usb_hub

Have something changed recently that broke this?

Anyway if something needs fixing it is probably rockchip_usb2_phy.

Regards,
Jonas

> 
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> ---
>  drivers/usb/host/dwc2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index 16f21fa9083..74d71f23d88 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -1329,7 +1329,7 @@ static int dwc2_usb_probe(struct udevice *dev)
>  
>  	ret = dwc2_setup_phy(dev);
>  	if (ret)
> -		return ret;
> +		dev_dbg(dev, "Failed to setup PHY: %d. Continuing anyway...\n", ret);
>  
>  	return dwc2_init_common(dev, priv);
>  }
> @@ -1345,8 +1345,7 @@ static int dwc2_usb_remove(struct udevice *dev)
>  
>  	ret = dwc2_shutdown_phy(dev);
>  	if (ret) {
> -		dev_dbg(dev, "Failed to shutdown USB PHY: %d.\n", ret);
> -		return ret;
> +		dev_dbg(dev, "Failed to shutdown USB PHY: %d. Continuing anyway...\n", ret);
>  	}
>  
>  	dwc2_uninit_common(priv->regs);

