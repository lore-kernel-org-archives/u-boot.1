Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DA0CEF178
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B213488D91;
	Tue,  8 Oct 2024 15:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728395494;
	bh=vvF8/Rswa1aMAG/aikxBleIccSBWgx9uUlas2IcDRjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FPzd/b1rbFBnUtwZ+NUf/t1FEG7xpYYkSqy+81DdldPJleP6gQV2Qf65hSe9yWoKS
	 4KSBJdtETQSbaleemCYWl/s1WES1b7mlb1rPa5D3BO8++J6+J/LMZuVaTpzWoNjNWf
	 eZ4/R/GLZCi9SOT/M2tD1PdrPrYsOKBrmY/amNepP4xWq7nnbR4qJ9mDvdfxOTJIHX
	 o4z5b+XtDs/mrCFijrZ9Al9Y6xhjV6N1y+WH9ooSlpiLRNWiLZiRZl42gjNr6iCMJU
	 z21cczHC2iSEybeM9muI7iyCo8gU1gblMjtJP8vCd+82sBUp2gRzjVYIlPI1xXB0JA
	 xvBROh9mnbbsw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E944988D27;
 Tue,  8 Oct 2024 15:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728395493;
 bh=vvF8/Rswa1aMAG/aikxBleIccSBWgx9uUlas2IcDRjw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EQ0DyXD86wybWz/zwuxM1DTecjU/oT3+tu1ws+D9hE3Uzy8GwKrknYsea9Kn9nT7b
 m+ezEMG8YIrs2rylkgHAkUpBeVZBnZZGYEk6pAn4vVKOC9UDcdlmTZMkC2ovlARHtP
 qdYIUqWQ2xZdlBsDppXYTZDsvcFWXe/h5z7bGgRlSLAQ6tbrndQJcfuyM1oq/AA1pg
 3F9EkLAHldExYVgdbGyR0Td9y+8o89w/TurLntF8NHfZzdEz1EcjZnVPzGxSMBPo7D
 1LVEhQBYBKV5LNw6USsTHdu9Eu8OKJqLoRqT32czCXFkifv+eXZJi/Yxc/Df47aQ/X
 MZzFxUkUeB1XQ==
Message-ID: <2edafd93-9ac7-4700-b1f6-db163b7be3cc@denx.de>
Date: Tue, 8 Oct 2024 15:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] usb: onboard-hub: Add reset-gpio support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
 <20241008045808.28757-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241008045808.28757-2-venkatesh.abbarapu@amd.com>
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

On 10/8/24 6:58 AM, Venkatesh Yadav Abbarapu wrote:

[...]

> @@ -38,6 +75,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	struct onboard_hub *hub = dev_get_priv(dev);
>   	int ret;
>   
> +	if (hub->reset_gpio) {
> +		struct gpio_desc *hub_reset_gpio = hub->reset_gpio;
> +
> +		dm_gpio_free(hub_reset_gpio->dev, hub_reset_gpio);

dm_gpio_free(hub_reset_gpio->dev, hub->reset_gpio); , no need for the 
extra local variable.

[...]
