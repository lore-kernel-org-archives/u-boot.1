Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDABE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 13:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29426896DB;
	Mon,  9 Dec 2024 14:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/Q5Z/Fx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767E98969C; Mon,  9 Dec 2024 14:20:19 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9F18972B
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 14:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5617FA414F0;
 Mon,  9 Dec 2024 13:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E73AC4CED1;
 Mon,  9 Dec 2024 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733750414;
 bh=1NcP/K1eg0DcrZWdYIgx8DU3mDO0p7E4Xe+fzl7zw54=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J/Q5Z/Fxic01f0FSbLjBR1PwOA/2uYoHwhHt4BA+X9FhpP/TtksnS2VNiKw6BTM7O
 PslKHziufijhyHcBu31Y1wgijuNK5lYzVpP91LLokxVIAGEF02NCS3X5Ci4yksg3RD
 1vTYa5+GI+xfyPsKOMxq5u6aRPLLAA/lTUJEvyOG8YBqy458lkF5oRBmW2ihWrwMLL
 fAf9I+qZpZoefDfn93vcX+CMtYwwdguIt3n7wq+eV5mp6P4npVC7ao/0J+wVgEy2Mq
 2iEr7YVn37+RQkAQQo6/OPKspL/QRoT44jWnUNYG4sBTc4kkGZLnkLOxgdR3WCRJej
 JqkjuZjEIwkHw==
Message-ID: <ceb060fa-d430-458d-b711-508a4bd34d48@kernel.org>
Date: Mon, 9 Dec 2024 15:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci-dwc3: Bail out if "dr_mode" is "peripheral"
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 marex@denx.de, bmeng.cn@gmail.com, mkorpershoek@baylibre.com, jonas@kwiboo.se
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241206110424.897283-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241206110424.897283-1-s-vadapalli@ti.com>
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

Hi Siddharth,

On 06/12/2024 13:04, Siddharth Vadapalli wrote:
> Since the compatible "snps,dwc3" can be specified in the device-tree for
> the Designware USB Controller configured for not only Host and OTG modes
> of operation, but also for Peripheral mode of operation, bail out if
> "dr_mode" is "peripheral".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 448add55297 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-pmic
> of the master branch of U-Boot.
> 
> Regards,
> Siddharth.
> 
>  drivers/usb/host/xhci-dwc3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
> index e3e0ceff43e..7b1311503fe 100644
> --- a/drivers/usb/host/xhci-dwc3.c
> +++ b/drivers/usb/host/xhci-dwc3.c
> @@ -208,6 +208,9 @@ static int xhci_dwc3_probe(struct udevice *dev)
>  	writel(reg, &dwc3_reg->g_usb2phycfg[0]);
>  
>  	dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> +	if (dr_mode == USB_DR_MODE_PERIPHERAL)
> +		return -ENODEV;
> +
>  	if (dr_mode == USB_DR_MODE_OTG &&
>  	    dev_read_bool(dev, "usb-role-switch")) {
>  		dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));

Although this proposal was suggested in [1] and later clarified in
[2] I will summarize the discussion here.

This patch fix is not sufficient for all cases as the xhci-dwc3.c
driver will still be probed if dr_mode is OTG or HOST along with
other platform drivers if enabled in config.

The only current solution is not not enable CONFIG_USB_XHCI_DWC3
together with another platform driver config (e.g. CONFIG_USB_DWC3_GENERIC)
if snps,dwc3 should not be managed by xhci-dwc3.c.

[1] - https://lore.kernel.org/all/unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t6up7aldqim2@mxhhtb53gw4x/
[2] - https://lore.kernel.org/all/a9c458f8-68e5-448b-9977-e7bf37b00d35@kernel.org/

-- 
cheers,
-roger

