Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE61DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 10:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A46887E87;
	Mon, 15 Apr 2024 12:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wxv5yLj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A57D88158; Mon, 15 Apr 2024 12:57:46 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139D987E87
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 12:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4185e80adfbso2872005e9.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713178663; x=1713783463; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvJLBwozfldJrDSK9XFqFb3eKtTyHTbIeyIfALsMIEk=;
 b=wxv5yLj+/n3pYVQxpRyG41HbmKd8alDpGvtOj7ita8n+w4NO2lPoy1slVKSHkvceNo
 Nlmj5bkdoQgO6PB6VV0zR/y4UavzhobysCgkVXzBiWZuQJYp/LTebpWfWYO6kiTAotcF
 JT5rCbZH3Tkb5JNX76iXQdhgGmUPe1nEI/KfUGNxB5hoE2UOAawt10uobDSu1vOlvLp0
 SZhgxg4KHHLeVBwouTkrnWffx3qGgHXnYEHMr/xFl74IWDs7K1MUizGQ3WCy5eZKLzZO
 5iAKkc2/OMNkjGyhPjIumuAnbdaoHuyj6HG2rIZ9JHjoeoYwUMowS0Tgewu+pyhWiNrq
 8NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178663; x=1713783463;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dvJLBwozfldJrDSK9XFqFb3eKtTyHTbIeyIfALsMIEk=;
 b=AO0AMdMZ/Z9bcCJGHd+hlWFYfrUb2v6xhQQQJGOSxw0vNjhXwMPPVUr5qC9Q6F/bQR
 Jxn9QWUysx6YJDd52VdUTqnVoPVqOeaa4wNZ9Br+3SqA/zGAXYbdCIDaOo9RSFzrYUdo
 NtFlq4HSOhTIvf6XjqtmHiI5s/1NdT9Enhk2Uf9IbvtqpLeNfMqunqcXQTGLABqSugnC
 sx3+BDhDvi+9nXJslp9EKDF/VmBo1nb9n6x8o+xFNf558nyxXAnMCp3MXNuypwhZbCNh
 7Kn4NEC4arowpMDU2TmjBfXNWrqyQxlwHnglgifEXyKSP+96aFRhLunKZEy397l2Phlo
 AWYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLgHUQL7o4KM4yO+NIrjCK0JnopXmaZv4kCvtpiOJQLrE9blkAP0EG8LIYuReIz5qLw4K7OnUuNh/jWQ3Tnu3Gr6Wm4Q==
X-Gm-Message-State: AOJu0Yxsq3DtwCfQq7GG0pWfP4ai0GURXL8KCeS0wPFHH4hJ4ZxO5yZM
 2NNXbvqGNt8H24pOAmHtXZzoPyYUNKeiP4ZtPKLKe80jixqwAzB+NpsfN/vNpgU=
X-Google-Smtp-Source: AGHT+IHTt066bnthbyzCQBDVp/Fv8gvPrJmU/leG7wKz/fJvpl5NwOlXrW0m5tNowJtyn1VauaAN+g==
X-Received: by 2002:a05:600c:1d8c:b0:418:7d90:6b4 with SMTP id
 p12-20020a05600c1d8c00b004187d9006b4mr232069wms.4.1713178663488; 
 Mon, 15 Apr 2024 03:57:43 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c314900b004161bffa48csm15866867wmo.40.2024.04.15.03.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 03:57:43 -0700 (PDT)
Message-ID: <a2ea41b8-8656-4734-8594-c1d38a30e25e@linaro.org>
Date: Mon, 15 Apr 2024 11:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix support without DM_REGULATOR
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, marex@denx.de,
 trini@konsulko.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 jagan@amarulasolutions.com, mkorpershoek@baylibre.com, peter@korsgaard.com,
 sjg@chromium.org, neil.armstrong@linaro.org, u-boot@lists.denx.de,
 j.beck@linefinity.com
References: <20240415105405.432679-1-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240415105405.432679-1-robert.marko@sartura.hr>
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



On 15/04/2024 11:53, Robert Marko wrote:
> Recent addition of vbus-supply support has broke platform which dont use
> controllable regulators for USB.
> 
> Issue is that even withou DM_REGULATOR being enabled regulator related
> functions will still build as there is a stub in regulator.h but they will
> simply return -ENOSYS which will then make dwc3_generic_host_probe()
> return the same error thus breaking probe.

Rather than stubbing out the code, could you check for -ENOSYS and
ignore the error in that case? I believe there's only one place where
this matters (marked below).
> 
> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulator")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 7a00529a2a..784d3ec2ed 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -242,6 +242,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>  	if (rc)
>  		return rc;
>  
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>  	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_supply);
>  	if (rc)
>  		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
> @@ -250,14 +251,17 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>  	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>  	if (rc)
>  		return rc;

Here, if (rc && rc != -ENOSYS)
or even if (CONFIG_IS_ENABLED(DM_REGULATOR) && rc) to be verbose (maybe
not the preferred style though).

All the other regulator_* calls either ignore the result or only print a
debug message.
> +#endif
>  
>  	hccr = (struct xhci_hccr *)priv->gen_priv.base;
>  	hcor = (struct xhci_hcor *)(priv->gen_priv.base +
>  			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
>  
>  	rc = xhci_register(dev, hccr, hcor);
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>  	if (rc)
>  		regulator_set_enable_if_allowed(priv->vbus_supply, false);
> +#endif
>  
>  	return rc;
>  }
> @@ -265,14 +269,18 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>  static int dwc3_generic_host_remove(struct udevice *dev)
>  {
>  	struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>  	int rc;
> +#endif
>  
>  	/* This function always returns 0 */
>  	xhci_deregister(dev);
>  
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>  	rc = regulator_set_enable_if_allowed(priv->vbus_supply, false);
>  	if (rc)
>  		debug("%s: Failed to disable vbus regulator: %d\n", dev->name, rc);
> +#endif
>  
>  	return dwc3_generic_remove(dev, &priv->gen_priv);
>  }

-- 
// Caleb (they/them)
