Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529C0CF6482
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 21:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B2889150;
	Fri, 27 Sep 2024 23:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727474153;
	bh=Y2OTnxSRPTZGopcnrGUJI52nBebo2/fAdjM6V0YOQ4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xpX9XhMFz2Xfi5gbNJHvvRjLavvucImRNvkOi3XzjnXQZ/StZ4+bRzpRmcMMVSZH/
	 oW+IH0c1QYh5QybVcUW3X5FcrX9UDx16jupOX74TYEY78UZaFEcgolSxzIX9kWLR5U
	 fzDd3hnkBAKlZ+5BMW25suOa55+UlfwPrMGi4rdGAMgQT5phWk3KFaFEfOzzIVv8nr
	 Jb+DfMhlUE9IysNYELPR3KYkPsHuySvt7Tc8tuhbg3mVHa6KBSDYlh3GvrgHyhgvxZ
	 4Yf2YahI/bASgjTyqVkMx4hTmdrMxzZVDfeKZuaDVByyOD7pkqQ7HqPYon2l3KNkmV
	 lXmpL8M44gQ+Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0D9708913E;
 Fri, 27 Sep 2024 23:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727474152;
 bh=Y2OTnxSRPTZGopcnrGUJI52nBebo2/fAdjM6V0YOQ4s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mgMfnLpdjZ6S65dFkLSfS3eg/Gi2SnWRL+jDlcXNZH2QFJDv07YLF746NaqcO26SJ
 FdvoDoIQMtF4rVeMSjadyGKK5WWUAXXqfcXMPkOToIloo2So5VLThXryFcbHtLfcxK
 NvpTPUFPQ68CqVvk4sYtaXqQOjfBIsw/7uDy+8NM483PMQoU7hif8w44MQe4muhkbN
 MoGxVdDGpP82RTFna8/X4E6bjakFH57pfEQQzCx29GxMNyPtk5JKiMHpOIoog/dj1r
 gx5xy08x6VXULrNjvo0SRqosZXWBARmIqkDpTYvuBFtZPQHz7dqqK07/CP0wKMViVM
 AMDTyfHGF02Ww==
Message-ID: <b03e60f9-dcdd-48ef-9b5d-ac75b0f3dda8@denx.de>
Date: Fri, 27 Sep 2024 22:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] usb: onboard-hub: Add reset-gpio support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
 <20240927070137.21816-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240927070137.21816-2-venkatesh.abbarapu@amd.com>
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

On 9/27/24 9:01 AM, Venkatesh Yadav Abbarapu wrote:

[...]

> @@ -30,7 +40,24 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   	if (ret)
>   		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
>   
> -	return ret;
> +	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +	/* property is optional, don't return error! */
> +	if (hub->reset_gpio) {
> +		ret = dm_gpio_set_value(hub->reset_gpio, 1);
> +		if (ret)
> +			return ret;
> +
> +		udelay(data->reset_us);

Where is this assigned ?

> +
> +		ret = dm_gpio_set_value(hub->reset_gpio, 0);
> +		if (ret)
> +			return ret;
> +
> +		udelay(data->power_on_delay_us);
> +	}

Is the reset asserted time and post-reset time identical for all USB 
HUBs ? I don't think it is.

> +	return 0;
>   }
[...]
