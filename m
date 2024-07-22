Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2E9C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32473886AF;
	Tue, 23 Jul 2024 01:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721692693;
	bh=ofVe72+wTeG0l6ruNZqPd0/8MLi8/hcQAotAfV5sXXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hcmfwjrjxNBL4MUZT3/ltRZDhqn2zhpKCpIkV2OQ+9NAluEdjBFpJyOZzX3JtarcK
	 DO1FDz2JhYQrmgYmIQpeaJGH20XdomCDo8zoOjKwdIHYSRfBVFmoFgq6Vefj/licda
	 mZBlFY3tNAjVsNSmpoMByvc6+4Hg8wZmbrFsTfXEpvKgH10qNOd/7VjLL3QIQE5VcN
	 d/XRoQrYy6SiGyMKl4wGjD2vdrZC9jJ6SHXLfyg/KpDLvytjem8Xp/8W2Ji+UujUwE
	 kh1r8ACLlnYa767p9ZyGs//NQMrnt/J66m60AnzxemGfkCe0Y0BvjX9BaKoCfnsqqE
	 osfQI/ipEB6Rg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 42A6B8867C;
 Tue, 23 Jul 2024 01:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721692691;
 bh=ofVe72+wTeG0l6ruNZqPd0/8MLi8/hcQAotAfV5sXXE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lYnHZKD1OCFPtA5jHlZtJQLsP7OYK9huJkmcS+C6Hb0ed8s7yo7i8LScJwNx3ItVM
 aZoBOXjLHxW3iCEmit9oiZxjqA+DFEFuXrK7bN3XdfbUbsGVVVdWTjI4WQ9LI1wUYl
 oLg+YcO9N+kjeNvf2yBU4KlbjvfZ3yoTKLP0olnM3RasuwD3ZaUilHbtpiuZvOzCbI
 TaR00p3isbEv4zlFqNcKxnWY2R+ybvSHChzZ3oft1CkrKInYaHo/hwTZ3r6qfAR2bO
 UqS4h8cDd0YSBNwqlbVaEBzorNrLf82fZckYmXKBf5a+n0D8qhDR0ld/dQuup8DQ66
 H13VHre3fYFIw==
Message-ID: <1f9b506f-b698-4b4c-ada6-146fa98ebafb@denx.de>
Date: Tue, 23 Jul 2024 01:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] usb: gadget: atmel: Add DM_USB_GADGET support
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240722202426.190986-1-zli@ogga.fr>
 <20240722202426.190986-5-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240722202426.190986-5-zli@ogga.fr>
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

On 7/22/24 10:23 PM, Zixun LI wrote:

[...]

> +static int usba_udc_probe(struct udevice *dev)
> +{
> +	struct usba_priv_data *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = usba_udc_clk_init(dev, &priv->clks);
> +	if (ret)
> +		return ret;
> +
> +	controller = &udc_controller;

Is it possible to extract the controller point from udevice private data?

> +	controller->usba_ep = usba_udc_pdata(&pdata, controller);
> +
> +	controller->driver = 0;

Please use = NULL if -> driver is a pointer.
