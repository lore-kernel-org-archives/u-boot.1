Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8B6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88CFF87E95;
	Mon, 15 Apr 2024 13:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F7mNi6XQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8FC87D5F; Mon, 15 Apr 2024 13:18:34 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604D187E95
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-346f4266e59so2340680f8f.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713179911; x=1713784711; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4fuxsb3T/ty4KcOyKPHLvX++k2UA2/FQuR3FZ7o18g=;
 b=F7mNi6XQUqJTTSHAgxW6cMjuS8Ci7V6g5XQA275CesSea3CNwZEo2WWz9uaPC/6S9d
 2lSSdR+mWO5RZiEiLOaKdCtqIh1vXByRbVNoLYL+TzYTNttSPYWj19egRLBHZqCijOy/
 ibs7c4w93mCruxwFj0T3b3b/l+YS1EzUrX42R/DkT11NuCq+/b4n3gFPGr9d/5VtbkUt
 qOfg5Q1cmnDvl+T/YoNOBb8MXLaftl2hzn7PT0emWJr2S7ZfJMX1hCncb/a79QLnA4tq
 mDOzZTgFy7uAQAyLQeOfKOLbPYcK3CcN3ymTrjShC1z0sb806i8/g6Y8ZajD5nzJNWTd
 KpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713179911; x=1713784711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y4fuxsb3T/ty4KcOyKPHLvX++k2UA2/FQuR3FZ7o18g=;
 b=wetVs6fV+0yvFo3QpKf5Xi33zL4XSY0xStuvAHIpIvW49Ga0GjNkKsnnh6zSd8+qCb
 BDF4t+Fk63hH12cVldccANCKolC3ejF1NXoLOsy3JXD9qRS0YSt0pnEesz7XEACJ6QBg
 QmDOM9Np3ikRL8Agyq8qzfEwo01KjzomoLOJ/4rjfesJnxyiRPXIwIHn1dA3+6VzCVMb
 F3XrE28uQVTeMcuwieLO4jk8rz+mNfVhTxu3WnQs708FcxommWBazehkusI/aINI5q3s
 ByyTljqq8oveUbuMRnKIRnD93mfyQRKVBefUfJO35OUDWUVyqnlwniLPiBaPx7dekk04
 Wmpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxCx8ZgIOTO8THANZipgchrZ1yUanmT7/td0fvsCJ2R3V1XNxsn0juFJp/uEHfpnJjRkjLIDuujNzpNhwvov5jwTJAHA==
X-Gm-Message-State: AOJu0YwITQrU2gFRnTMAxT7gAA4t/PDzO33otHpToT+KXin8PI7c9A91
 /LCGRyLFtnnApdBk9vIIwK3prAN7hTr/x2nuoNNTpi8iNLQKmz+G1A7niwQMz9w=
X-Google-Smtp-Source: AGHT+IH0U9CEAFV0uY+muhmthamv1SBdXsWGsOi/vpnZD4OJEmpT+eSgSDwExpHSTHPRDBksmSxhQg==
X-Received: by 2002:a5d:6a8b:0:b0:341:907a:bee9 with SMTP id
 s11-20020a5d6a8b000000b00341907abee9mr4473700wru.16.1713179910780; 
 Mon, 15 Apr 2024 04:18:30 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a5d6807000000b0034354a99d43sm11834420wru.43.2024.04.15.04.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 04:18:30 -0700 (PDT)
Message-ID: <ed463461-2e96-462f-8b43-1e6ca4aad7a3@linaro.org>
Date: Mon, 15 Apr 2024 12:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix support without DM_REGULATOR
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Robert Marko <robert.marko@sartura.hr>
Cc: marex@denx.de, trini@konsulko.com, jonas@kwiboo.se,
 kever.yang@rock-chips.com, jagan@amarulasolutions.com,
 mkorpershoek@baylibre.com, peter@korsgaard.com, sjg@chromium.org,
 neil.armstrong@linaro.org, u-boot@lists.denx.de, j.beck@linefinity.com
References: <20240415105405.432679-1-robert.marko@sartura.hr>
 <a2ea41b8-8656-4734-8594-c1d38a30e25e@linaro.org>
 <CA+HBbNH=UGLY63-bSoNmmV7ZBkt2zkbS0sdqbTLTmqikzhrb_g@mail.gmail.com>
 <85a712c7afa962b227d16a2fced6f57c@manjaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <85a712c7afa962b227d16a2fced6f57c@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 15/04/2024 12:14, Dragan Simic wrote:
> Hello all,
> 
> On 2024-04-15 13:11, Robert Marko wrote:
>> On Mon, Apr 15, 2024 at 12:57 PM Caleb Connolly
>> <caleb.connolly@linaro.org> wrote:
>>>
>>> On 15/04/2024 11:53, Robert Marko wrote:
>>> > Recent addition of vbus-supply support has broke platform which
>>> dont use
>>> > controllable regulators for USB.
>>> >
>>> > Issue is that even withou DM_REGULATOR being enabled regulator related
>>> > functions will still build as there is a stub in regulator.h but
>>> they will
>>> > simply return -ENOSYS which will then make dwc3_generic_host_probe()
>>> > return the same error thus breaking probe.
>>>
>>> Rather than stubbing out the code, could you check for -ENOSYS and
>>> ignore the error in that case? I believe there's only one place where
>>> this matters (marked below).
>>
>> Sure, that was my first approach but it did not seem right to me.
>> But if its OK with you, I can do that.
> 
> FWIW, ifdef'ing the code out seems like a cleaner approach to me.

Given that the stub functions exist, imho it makes sense to use them.
It's also easy to forget to add those #ifdefs if there are other
regulator changes in future patches.

But overall I don't feel too strongly about this, for what it does this
code is fine, I'll defer to Marek.

> 
>>> > Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus
>>> regulator")
>>> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> > ---
>>> >  drivers/usb/dwc3/dwc3-generic.c | 8 ++++++++
>>> >  1 file changed, 8 insertions(+)
>>> >
>>> > diff --git a/drivers/usb/dwc3/dwc3-generic.c
>>> b/drivers/usb/dwc3/dwc3-generic.c
>>> > index 7a00529a2a..784d3ec2ed 100644
>>> > --- a/drivers/usb/dwc3/dwc3-generic.c
>>> > +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> > @@ -242,6 +242,7 @@ static int dwc3_generic_host_probe(struct
>>> udevice *dev)
>>> >       if (rc)
>>> >               return rc;
>>> >
>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>> >       rc = device_get_supply_regulator(dev, "vbus-supply",
>>> &priv->vbus_supply);
>>> >       if (rc)
>>> >               debug("%s: No vbus regulator found: %d\n", dev->name,
>>> rc);
>>> > @@ -250,14 +251,17 @@ static int dwc3_generic_host_probe(struct
>>> udevice *dev)
>>> >       rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>>> >       if (rc)
>>> >               return rc;
>>>
>>> Here, if (rc && rc != -ENOSYS)
>>> or even if (CONFIG_IS_ENABLED(DM_REGULATOR) && rc) to be verbose (maybe
>>> not the preferred style though).
>>>
>>> All the other regulator_* calls either ignore the result or only print a
>>> debug message.
>>> > +#endif
>>> >
>>> >       hccr = (struct xhci_hccr *)priv->gen_priv.base;
>>> >       hcor = (struct xhci_hcor *)(priv->gen_priv.base +
>>> >                       HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
>>> >
>>> >       rc = xhci_register(dev, hccr, hcor);
>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>> >       if (rc)
>>> >               regulator_set_enable_if_allowed(priv->vbus_supply,
>>> false);
>>> > +#endif
>>> >
>>> >       return rc;
>>> >  }
>>> > @@ -265,14 +269,18 @@ static int dwc3_generic_host_probe(struct
>>> udevice *dev)
>>> >  static int dwc3_generic_host_remove(struct udevice *dev)
>>> >  {
>>> >       struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>> >       int rc;
>>> > +#endif
>>> >
>>> >       /* This function always returns 0 */
>>> >       xhci_deregister(dev);
>>> >
>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>> >       rc = regulator_set_enable_if_allowed(priv->vbus_supply, false);
>>> >       if (rc)
>>> >               debug("%s: Failed to disable vbus regulator: %d\n",
>>> dev->name, rc);
>>> > +#endif
>>> >
>>> >       return dwc3_generic_remove(dev, &priv->gen_priv);
>>> >  }
>>>
>>> -- 
>>> // Caleb (they/them)

-- 
// Caleb (they/them)
