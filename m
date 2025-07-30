Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D28AC83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F5D803CC;
	Wed, 30 Jul 2025 15:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SyybImcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF38180C93; Wed, 30 Jul 2025 15:06:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F40F5800C1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E04043F57D
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1753880764;
 bh=yM5WzJBQP/GqMp95QPTy/0tG8TyBtYRZmAgCa9HtOFA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SyybImcN1z2JK5F1pJ7FLiOcaMYuqEzZN2ufk5DIrub6oOHibqH2nqLaukIbDk2dR
 qUfMWb2/BySzAl0BWE9tieYSEdpweoTIfoRsFhf444a9mNA7NIrgMtPhz/KodoYtkx
 Upe1bx76eTpaAZS4z6yR1sopN/Si+MLNn+cA5ILpyY7JgVpIW/bJJWWsXx2oLSePe7
 MGUvkJWM9SdUkuZ4ehAAXOzHl9W4h4yL6I+/I/f+0g/XnAQMLeSaxIQUfMAZ3uTmrh
 2IjXwRoEI3Eu4lGx/nqGSkbwvf/2BOujmhPIf6WbUCmzCHBm0NwGA0nlJBayRu8QL1
 0mAJkmcT2e45Q==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b7891afb31so2175871f8f.2
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 06:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753880762; x=1754485562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yM5WzJBQP/GqMp95QPTy/0tG8TyBtYRZmAgCa9HtOFA=;
 b=M41gE7UjVB1ju46Gjav1Qgbi0bMpZc2Q42RiM3GL4sqoRk2z7g9iuPXBdRdAkPYdsx
 CemYqIe9mtMFdHipXmQLXuM4Zpys1wSTm+ooISSza1ELA+BbDEzl+mjIzDzdNfJiFbnM
 XMUE07KpcsDG8hABI5VSX4ohpVOOAeWO3E7+c268MwluMQm/WTe+k+4q3f0l6+PMzkri
 dnahcmslAO2qxhH1rgiYJWhjj4ynqc6+tBG9cl23UlE48QE6F0fNDSDIJeVcZrOabTtj
 B/TlrPBSM9QMLaOY2lEZ/VwJVt8RnCwGfs3E51ckK4dPJWwnjEAdZB6/UMD1AiUM+rp5
 sI+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBaK/uFvEaQRW6WPyyhuupg/whNIXUwFB9jYohu+WsZ7ogK2S1b521liYIqfIg9jyDudDe16Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwqwrL7trfirLV55oA7neQrIwd4W31uwPkNN2i81jA3NrjNXwIA
 JcUPGLf1GXPXPd3ptKbPgV4KpBbYvui0oe04K+sGmdB8LX5IwBEoyJ5I4xIfv0H0z6K7DwvG1VC
 N7T1o/1vZfWzuX99rKGY0ftf9WoWpBcvzU2KrLrfvd3JVHjMYVxuCQrw+FTeNSfbJSy4TRM8=
X-Gm-Gg: ASbGncvnFB0Ha4ngX/tQIeIBBz2DiunUwR4PWla/WHHoDrtmD0wPA7Iy3i+2qrsFMCh
 PLl5sEXm+QgjxKOiLWgrF8gAcmEl1M46AZ7rQVZK57TVrPynI9+fHDcnaaCqtj2gUNHwdVKpcDD
 G2gonpOtwHaXjQ4rCEv9XW5m8W4i+PHj6uIYcCPDWsPJQtPIwJP9R1gPBJrohfPLaNPzr0qmkbn
 e5pPgCUy9Kq9aeIEbLMdIGy98SXzpFV5m9jQXYxZTPY38Wl6+8HxOJHArKCC3pQvqf+WspF55lt
 f1U86OeSlv73CZtsqAhxvifCqlfpi3PR5Xzj5T0CTAxaLoJA/AT37czXcuWfT9/Y6rlPVVefyDw
 cqK7CHDuF03wIwD5DnWV7stEAxXCXXWIpZIFp
X-Received: by 2002:a05:6000:1889:b0:3b7:924a:998f with SMTP id
 ffacd0b85a97d-3b794fc2af3mr3088387f8f.5.1753880762525; 
 Wed, 30 Jul 2025 06:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+JG0h8dT2R8zLH4OaXlMjL50ejE6OHq1iqiayWpZoYPX+ktBYlvH3+hnj8SdwbpyOnyKPHA==
X-Received: by 2002:a05:6000:1889:b0:3b7:924a:998f with SMTP id
 ffacd0b85a97d-3b794fc2af3mr3088343f8f.5.1753880762105; 
 Wed, 30 Jul 2025 06:06:02 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b794e03328sm3292571f8f.60.2025.07.30.06.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 06:06:01 -0700 (PDT)
Message-ID: <0b5e6888-6652-4ec7-971e-710dc9cd3a77@canonical.com>
Date: Wed, 30 Jul 2025 15:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Kconfig: typo restict
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Marek Vasut <marex@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
 <3f34945e-9e4f-451e-85eb-5a5e4e5cd265@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <3f34945e-9e4f-451e-85eb-5a5e4e5cd265@cherry.de>
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

On 30.07.25 14:58, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 7/30/25 2:54 PM, Heinrich Schuchardt wrote:
>> %s/restict/restrict/
>>
>> SPL and TPL have separate options (plural).
>>
> 
> Looks good to me.
> 
> Wondering if we couldn't add which options are to be used for TPL/SPL 
> Would that be TPL_MAX_SIZE and SPL_MAX_SIZE maybe?
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Thanks for reviewing.

With VPL_SIZE_LIMIT and a patch for UBOOT_WITH_SPL_SIZE_LIMIT pending 
things get even more involved.

We should think about a documentation page on size limits:

CONFIG_HAS_BOARD_SIZE_LIMIT
CONFIG_BOARD_SIZE_LIMIT
CONFIG_SPL_SIZE_LIMIT
CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD
CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC
CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK
CONFIG_TPL_SIZE_LIMIT
CONFIG_VPL_SIZE_LIMIT

Best regards

Heinrich

