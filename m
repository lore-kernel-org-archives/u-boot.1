Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5070AFD0045
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 22:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE5F283F1F;
	Sat, 28 Feb 2026 23:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fjikIS/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42AFA83EC9; Sat, 28 Feb 2026 23:16:55 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F8983EC6
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 23:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fNfgR3bdlz9tZ3;
 Sat, 28 Feb 2026 23:16:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772317011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZA+p3fvLIvS1mSr7YOvtkZzsJBaIF+jZ3lWEjc/FwI=;
 b=fjikIS/tGHLbPq5afMMOVT7yMjA1DQJUh2AKnojHHohsrJYBeIJ9/sB6qUVaw4cqoSKEv3
 DdV5ste7OctsO/gNldcBKq+ny8c09f6EP87aG2ntj8kiyjseaTNM2pH5+KXQXG9cdxH0Va
 BhBzo+eoO+dTrupiYl1lRWcqR9wYUEF7UXjZl3JQBM4+1YUDL0Xrx40vHMkvIbh80Sr38u
 uprzBqmKJLPnix+mbfrB62veLe419ontnpuCGWiMMOittgp9HPstJHF3Anzv3Z7pk6eXiM
 gdI9PhQintG5g0piCSR+lKCgSyXYr5zhqrIK+CSJSeV+DlBZpe4DvPfpwNRvpg==
Message-ID: <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
Date: Fri, 27 Feb 2026 12:51:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
To: Siddharth Vadapalli <s-vadapalli@ti.com>, marex@denx.de,
 trini@konsulko.com, minda.chen@starfivetech.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20260227055954.3916518-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260227055954.3916518-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c84ea563ec6c84e44f2
X-MBO-RS-META: ok1g5hscurwoe365gxdrsaed8i3r4qeu
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

On 2/27/26 6:59 AM, Siddharth Vadapalli wrote:
> While commit bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role
> for dr_mode OTG") enhances the driver, it causes boot failure for non-USB
> boot mode when the 'dr_mode' is 'otg'. The reason for it is that the
> cdns3_get_otg_mode() function reads the USB Controller registers to
> determine the appropriate role. If the boot mode happens to be USB, then
> the USB Controller will be powered ON and the registers are accessible.
> For non-USB boot modes, the USB Controller is not necessarily powered ON
> as a result of which the register accesses cause boot failure.
> 
> Another issue is that the error code from cdns3_get_otg_mode() is returned
> as-is by cdns3_bind(). The cdns3_bind() function already has a comment
> near the 'fail' label stating that an error code should __not__ be returned
> as it will cause the board to hang.
> 
> Fix the aforementioned issues in the following manner:
> 1. Probe the parent device before calling cdns3_get_otg_mode() to ensure
>     that the USB Controller is powered ON and its registers are accessible.
> 2. If cdns3_get_otg_mode() returns an error code, instead of returning
>     the error code, jump to the 'fail' label and return '0'.

[...]

> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 10bc4cabed4..a775567b3bc 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -461,9 +461,18 @@ int cdns3_bind(struct udevice *parent)
>   
>   	/* Use VBUS Valid to determine role */
>   	if (dr_mode == USB_DR_MODE_OTG) {
> +		/*
> +		 * Since we perform register accesses in cdns3_get_otg_mode(),
> +		 * we need to ensure that the parent has been probed and that
> +		 * the USB Controller is powered ON.
> +		 */
> +		ret = device_probe(parent);
> +		if (ret)
> +			goto fail;
> +
>   		ret = cdns3_get_otg_mode(parent, &dr_mode);
>   		if (ret < 0)
> -			return ret;
> +			goto fail;
>   	}
Can you instead move this logic into driver .probe() ? Then you wouldn't 
need the device_probe() hackage.
