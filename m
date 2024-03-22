Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98EFC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF6F881EB;
	Fri, 22 Mar 2024 12:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711108600;
	bh=Zrv9sEJQbbqZE4BV8WdANZAePtMJnKYlQBZZIBqydj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HJcdOdVG3WhdMUBRBr1ReCWllNF4Oq6DBYnc7SlX1yxljPwj7ILKwE7iKgS62m482
	 fjn/Bfxam4h8bGqxL5bjYzbsjJQPnoWm6OWeN9ePE3ye4fMyOs9aKfMRyxRbSO1BNR
	 Zx+Xw0EmnIa8wraFalTcqD22lnBtbnPHP/ZWi8xZ+x4040MV+RTTEIY6GIUZAxaCH1
	 T4bg87i0N4kgXI8e/Nvi6Azm+2Er9dcaKDxZkbZZbCh0rdFQQj+HmmMvMS4Yja1LW7
	 Q9R4yUH5c6HMfn1wGaaXIax8HnU27Rf2kFDyJA+Ra6C8iC4wkIZ9S/ouLH5SjlHxaB
	 tdh4Il/06cc4w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F0E64881E9;
 Fri, 22 Mar 2024 12:56:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711108598;
 bh=Zrv9sEJQbbqZE4BV8WdANZAePtMJnKYlQBZZIBqydj4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cFug038s+3YqF2dYBxvLo87ZPKuC7FDvGHNBJE3YOUTp9JmhWxRgwEqZ6ko9iO7xU
 syw9Ith6VuRd7WdiP8k7jojOBKsyterrylqoNLLak44x0dv1EsEcF/A1PrGPlrSnpe
 aALRuNp9ISRDMjMdB/WDMFX9nJVKA678U5XQQhWrizyaFk5ggWXXg9t9+FLv/Rrw9S
 sYhsoUQH8FDtPFutpJmSXdwzZMCXjKlShVXCuZaliXe90Yb4DUixUuIqfoDQ8VYplb
 kO3PeFN7bCJzMsBbJ+laGOIuYG//qvWzI+JZoqsMwP5HX+0desysrdn+I1mYudtJv+
 M8ABxptA1p8LQ==
Message-ID: <fcc7e54e-5e52-4b27-bc0c-801954ccf0ca@denx.de>
Date: Fri, 22 Mar 2024 12:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] usb: Add environment based device ignorelist
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
References: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
 <20240322-asahi-keyboards-v3-4-3106dd4c4e19@jannau.net>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240322-asahi-keyboards-v3-4-3106dd4c4e19@jannau.net>
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

On 3/22/24 8:47 AM, Janne Grunau via B4 Relay wrote:

[...]

> @@ -1099,6 +1142,20 @@ int usb_select_config(struct usb_device *dev)
>   	le16_to_cpus(&dev->descriptor.idProduct);
>   	le16_to_cpus(&dev->descriptor.bcdDevice);
>   
> +	/* ignore devices from usb_ignorelist */
> +	err = usb_device_is_ignored(dev->descriptor.idVendor,
> +				    dev->descriptor.idProduct);
> +	if (err == -ENODEV) {
> +		dev_dbg(dev->dev, "Ignoring USB device 0x%x:0x%x\n",
> +			dev->descriptor.idVendor, dev->descriptor.idProduct);
> +		return err;
> +	} else if (err == -EINVAL) {
> +		printf("usb_ignorelist parse error in \"%s\"\n",
> +		       env_get("usb_ignorelist"));

Please use dev_err() here consistently with dev_dbg() above.

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
