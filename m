Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450BECE7D19
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC075891B0;
	Tue,  1 Oct 2024 14:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727784808;
	bh=Rr7KwQGq6VJ7YSHmx9/PoJEyuHrfxrfgSsHUwuVWb3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wHNSx1m5IYnESg0v3lv7JSiVgtnWxsae+rf7vSOonMcpLNoa5/z+BrV6xLf1a0NvA
	 Ft91jqvX6cgEMVzGxXbP1lk8gio1o8qJsBwjqJAhuVJei82MJ5nWsE8s50LTq56PKl
	 RWuay3PkSTfsHRCohP4JB9FCFFd95OK3WElogIiQ3qa6O6c5nqnv4gE88jCTRzwwf2
	 V3np9mmQAeF/FQ1QTH6I5nzI3cJC8EFfuqHI89YmEead6Cj3obL5SGIn5QdjBjS9ai
	 74tgYsqGgdb92InmoHjyVJY8sLc8ia0foT9SCgnDpGbTOsNKU25BYZU927Xbe4a3BV
	 KudJVgP6syy+Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4B0D789062;
 Tue,  1 Oct 2024 14:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727784806;
 bh=Rr7KwQGq6VJ7YSHmx9/PoJEyuHrfxrfgSsHUwuVWb3E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n+tv5yE68ZjZ70OQYV+G71WGc/Siq25kdIG4n2CuBLgHNhYjTGZasZUAWVfU7djN0
 jx44Eg8cosjeBGfLQftcKAVmCNX1X7DPMn7k3nJECQn4SPJBBFY82jhCLD843exz4N
 2UDcNm7IGzAFgYx7Zmo+hRRyndqTgebnGtMnm8tYp2jyUrPwACjm7hJMfID6wGpgCM
 p5HuJAkuHjxsFFuTxQPqYZ04eKbssGtylH4UFXZ+Z/j7VJBRnKs0IhWbx14QuJZ4zu
 +FxNhCkLDalnWab6oIPptlNYD+EtpRmELbug2iODjKEQsR5QBmayLp5PcycZtbmDmI
 UT9JSo+k16xVw==
Message-ID: <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
Date: Tue, 1 Oct 2024 13:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
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

On 10/1/24 7:05 AM, Venkatesh Yadav Abbarapu wrote:

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

if (!hub->reset_gpio)
   return 0;

to reduce indent .

> +		ret = dm_gpio_set_value(hub->reset_gpio, 1);
> +		if (ret)
> +			return ret;
> +
> +		udelay(data->reset_us);
> +
> +		ret = dm_gpio_set_value(hub->reset_gpio, 0);
> +		if (ret)
> +			return ret;
> +
> +		udelay(data->power_on_delay_us);
> +	}
> +
> +	return 0;
>   }
[...]
