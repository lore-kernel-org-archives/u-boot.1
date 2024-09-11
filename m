Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C51EE0219
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 08:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A7889215;
	Wed, 11 Sep 2024 10:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726043763;
	bh=vUYqmtEvZtmzXmVRCwVtDy6QfbGtz7DCBRxTR9ICaH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IVtUuy+0XTIaeM23VFKrRg/v9XObCNxVditClVLspR94Sa9sh+Uaa5P4Or0AIJFB7
	 9XQmcxiWghi4N6HsowbMk9dv5yjcCUQPNNBM0QdKU2ATzMHkKnQ/fpwyRrf6lLQNvJ
	 Y7amyfpAL8wPKJ/MHFbks/e195FA7Fjo4BWhi3c3ueqVAHYLEFXZJP3tnkUq/G4/42
	 uEzd0nc/mXEAGSrojWDx12/Os74M4bI1S+lPK+oK1NmgPeqcRGzBByGhHoLXwcVafU
	 247XUImHBsBuszkuPJRuEMRVRjEswcKorYv+2+UBrIE5od9+LdedDsOE8tsjcTdLxa
	 Cd76/lgC91F3A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CF945891ED;
 Wed, 11 Sep 2024 10:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726043762;
 bh=vUYqmtEvZtmzXmVRCwVtDy6QfbGtz7DCBRxTR9ICaH0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pDFT/HswtWBqLsRs36mvFLLHUJYGTJyY9Zfxiy/pJFymz+Eifw2S6RmibTN1uyHGl
 OE+HrfEm+F/rHZOKB1Nv+c9btgcOhmLEgdxWk9ryoPNW0Uz2eJP88CWRxnifwDsKyF
 U4WW2mU3X+ebc6jjrGAjusAQhF1tquao8oT28pMH8/0LtMXU+fEhqWRXjwszY4sn+x
 0YyW9anV2Pzo+gm67pQe4s2Acl/N45YyNaekruzArxQIkWfLjVublYFAYjXrzAXCo/
 dqYSG2nhoLwFLLxHHm8ScOH9UF+Q4gY4jomnN/Zow+RoKaWc6kg+K4wXQyRc9BE/ht
 afU/StlYdE+rA==
Message-ID: <e0ae1337-32d1-466a-b134-d60729f95ca8@denx.de>
Date: Wed, 11 Sep 2024 10:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/30] drivers: usb: Add generic XHCI
To: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-17-patrick.rudolph@9elements.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240911062511.494855-17-patrick.rudolph@9elements.com>
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

On 9/11/24 8:24 AM, Patrick Rudolph wrote:

[...]

> +static int xhci_usb_of_to_plat(struct udevice *dev)
> +{
> +	struct generic_xhci_plat *plat = dev_get_plat(dev);
> +
> +	/*
> +	 * Get the base address for XHCI controller from the device node
> +	 */
> +	plat->hcd_base = dev_read_addr(dev);
> +	if (plat->hcd_base == FDT_ADDR_T_NONE) {
> +		debug("Can't get the XHCI register base address\n");

dev_dbg(dev, ...)

> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
With the above dev_dbg() fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
