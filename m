Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3086C3271E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 13:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E61E88581;
	Thu,  4 Jul 2024 15:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eg0QYL9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8465E888A9; Thu,  4 Jul 2024 15:30:15 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5484B8823C
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 15:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 60550CE33B6;
 Thu,  4 Jul 2024 13:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A868BC4AF07;
 Thu,  4 Jul 2024 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720099810;
 bh=Gjmdlce/iX0i4HmFMJLxKBFDoDnkKNYDggK0qLiCwpo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Eg0QYL9lDVU/XQMt0kd0omC8ENnjzE6vW6uKp4hZe5AxfIwzB/fPT36VsRVw1PA2E
 Jxlc5YFYhD/awbWz1jZgBpRRm13PzWsU83lEiQxJRFAm1yrp3GTbDUwbQ2JX7Y6iXc
 DH99jAh3DhAdAzEH9EswTPUvqQvzZ5w635fFjzvBGaCnP8vXaXMAr9o/B8qb8aZ2ts
 Tunts3s1XyrddJcb4QCdgYNGON/WlowAq88Bn8+avhwvJ2jhh/1G4Pkq/RDzk8eg77
 PwaR8R++QmP+NKGXFiFj9yhCRfVj8zN1Mzq66tXzcR7lssl0RpYfVxaOGsI/CowfhD
 73kK0y8QYci5g==
Message-ID: <cacb69e4-1710-4162-8ec6-3850ec5f4a80@kernel.org>
Date: Thu, 4 Jul 2024 16:30:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] usb: cdns3: Set USB PHY mode in
 cdns3_core_init_role()
To: Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <20240704055014.55117-2-minda.chen@starfivetech.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240704055014.55117-2-minda.chen@starfivetech.com>
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

Hi,

On 04/07/2024 08:50, Minda Chen wrote:
> USB PHY maybe need to set PHY mode in different USB
> dr mode. So translate to generic PHY mode and call
> generic_phy_set_mode().
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/usb/cdns3/core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 12a741c6ea..1e863bed89 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -107,6 +107,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  {
>  	struct udevice *dev = cdns->dev;
>  	enum usb_dr_mode best_dr_mode;
> +	int mode = PHY_MODE_INVALID;
>  	enum usb_dr_mode dr_mode;
>  	int ret = 0;
>  
> @@ -173,6 +174,30 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  
>  	cdns->dr_mode = dr_mode;
>  
> +	if (cdns->dr_mode == USB_DR_MODE_HOST) {
> +		mode = PHY_MODE_USB_HOST;
> +	} else if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		mode = PHY_MODE_USB_DEVICE;
> +	} else if (cdns->dr_mode == USB_DR_MODE_OTG) {
> +		mode = PHY_MODE_USB_OTG;
> +	} else {
> +		dev_err(dev, "Unknown dr mode %d\n", cdns->dr_mode);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = generic_phy_set_mode(&cdns->usb2_phy, mode, 0);
> +	if (ret) {
> +		dev_err(dev, "Set usb 2.0 PHY mode failed %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = generic_phy_set_mode(&cdns->usb3_phy, mode, 0);
> +	if (ret) {
> +		dev_err(dev, "Set usb 3.0 PHY mode failed %d\n", ret);
> +		goto err;
> +	}
> +

Should we be doing the above inside cdns3_drd_update_mode() so that the
PHY can be put in the correct state even during role switches?

>  	ret = cdns3_drd_update_mode(cdns);
>  	if (ret)
>  		goto err;

-- 
cheers,
-roger
