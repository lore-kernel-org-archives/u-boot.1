Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5ECC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4858620C;
	Wed, 23 Aug 2023 20:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692815386;
	bh=aHmpTRQfoMsaoiggBO71Vf9scpClImfTtfs6ZgzhOAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bm8BtJ2+MeuZEHrcI6NNMIp8wDxh7RMKJSR73y3mvuCNtl86jne5zwSDv7NWgkJKQ
	 dhR9nbHOjWDmXqfULZi/+ilNdnb/+ymTlESfhbYpiAHOONTwILnuRmOHkCtiQoOoik
	 P/k1dotu2Up7vhYJl+fJFG09EN0zLYITQtZRP3QvmkImd4prMHSy5vfTz4cuEJa296
	 WIg8JezfXEnMRTK9tEgILJBkB442weymj9mdVm3HHg2PYVlgyu0SGHvecorO97FSoK
	 3OpsXDC3tuDpbc0S/c5Z1a+iB0+iLL2AjMiT6cgwdiqiwuzbSP1fLOSW8pdPLKg4TX
	 RVj+SmxPfVo+A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D2AA386146;
 Wed, 23 Aug 2023 20:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692815385;
 bh=aHmpTRQfoMsaoiggBO71Vf9scpClImfTtfs6ZgzhOAU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ayy/RkJEv9g3zCtRlCdKF6GQuK3YYaMM+xAgrpC64tsRP9MTd5wtXFENJI+zeWY+I
 7nbG9eB1ApBPWaucye5fzBPoss2lbQl6wl/f4nvT7tSqdE/ZKPPTbSofnyzk//fhwk
 7yWznawn3VR2+cQ267TZunuSkg/1NuJjbe7HA4PkTMf7+C58uMul9kGxTY9tNb+X4t
 kmwS1yKhTydsZXKXfInQJJABKCbw7CBXwBMo8eHBK+Nfp5lMr/GnDzRgJSnxEh2fmj
 nbqNG67xgusI5OkxdJ+kxtEU8c5N5mONcNPIayBmGBnCH7Fi5Y6/rudJ3/2ZdNt7wk
 8PumGY2LAmXNg==
Message-ID: <3ff9dce0-4eee-16b8-9e8b-26842b4c9aef@denx.de>
Date: Wed, 23 Aug 2023 20:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
Content-Language: en-US
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
References: <20230823182156.32353-1-oleksandr.suvorov@foundries.io>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230823182156.32353-1-oleksandr.suvorov@foundries.io>
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

On 8/23/23 20:21, Oleksandr Suvorov wrote:
> In the usb/dwc3-layerscape driver the first option should be renamed
> to the latter as well. Do it.
> 
> Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> ---
> 
> Changes in v2:
> - [asked by Tom Rini] shrink the code using CONFIG_IS_ENABLED()
> 
>   drivers/usb/dwc3/dwc3-layerscape.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
> index 79cf71f7a85..58baa017ad1 100644
> --- a/drivers/usb/dwc3/dwc3-layerscape.c
> +++ b/drivers/usb/dwc3/dwc3-layerscape.c
> @@ -134,8 +134,7 @@ U_BOOT_DRIVER(dwc3_layerscape_peripheral) = {
>   };
>   #endif
>   
> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
> -	!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST)
> +#if CONFIG_IS_ENABLED(USB_HOST)
>   static int dwc3_layerscape_host_probe(struct udevice *dev)
>   {
>   	struct xhci_hcor *hcor;
> @@ -194,7 +193,7 @@ static int dwc3_layerscape_bind(struct udevice *dev)
>   		driver = "dwc3-layerscape-peripheral";
>   		break;
>   #endif
> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || !defined(CONFIG_SPL_BUILD)
> +#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)

Why not CONFIG_IS_ENABLED(USB_HOST) here too ?
