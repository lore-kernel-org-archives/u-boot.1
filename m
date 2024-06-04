Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B70BC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 15:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A808988494;
	Tue,  4 Jun 2024 17:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z2NboRP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9B78849A; Tue,  4 Jun 2024 17:17:54 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EAA88418
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 17:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-354dfe54738so3656469f8f.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717514272; x=1718119072;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kgb88kYJt5if+ocKGCMrLg7EyOFpGNjFAkFQOEuZ1Aw=;
 b=Z2NboRP9793sFwYgTSm7yUGfdoSBkyyXt3XiXrkMQRpqhaP8Y0lBm+nMzXIoeSqZrT
 tI2Fy60jPBBeiiKlGKAdjBgk+ot6AaTCUKa097ZI4RkH4kU/9ezJDh6QWU5SEGmrR3/N
 j2tLO1iOJz2y1Vqx7rRjZQg+0qI70V3Cftc4quej129EiDFxJHlXcMErkWU3JJDYAruC
 ezdnfUGqGeG8qr370l6/+wMyZyT4dd3ZAFSKOTtx/Oqk93fk8aH/0vNzEbPTfIiH0wr+
 pVj99V/vFTSPibd2Jqk18b8eUk0lJu45B8rIUGn+e24McChXPTD2kQYAgaHJZ2bzapty
 viQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514272; x=1718119072;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgb88kYJt5if+ocKGCMrLg7EyOFpGNjFAkFQOEuZ1Aw=;
 b=g1k1XPnluJMMCd2OTx8dc76syEi7l4VE3s8kVCt9MP4By4ic84DxAZoJsH9Vkvdkh5
 VQJbPV4FzQBit3hybrPtSErp3YwATVxVoz09Eco43KRT/dUs0A+tx5wrZvZuYAXddJuM
 DeXl2luAdzhKoISzbDniDQWxa0Nir9aH1IYjwAXGYdD34B8w+vnkZhJbNEGeNH+szcGz
 yOjdupvpnIgGF1BseXv6UvAo7vcIb4W4rkkH2WBUwkJ75pg+AnF658y66TyPKHJQRu+b
 bGmoucuaCIZBU2cBeX48NS28GlOzCOkSM4u9OuamHx1hHr2ySTKW3L+Q5v18CcOExyRm
 O2NA==
X-Gm-Message-State: AOJu0YwbNredTfPX3BflH0XOIqGfbhf/rrh/dAh2fsQrBcsGQBf7Vqwx
 1Qif5xRzvq83WhUHyImQbiA7UszQQ3dHMoljUbQk7vlYjAGvuLmGw5ydrI/EJFo=
X-Google-Smtp-Source: AGHT+IEftTZhaKEcDBeHMbKYenzUXgrkP46QHclPMWjXJ/J9w/IgakVIV4VTUSUaRVK7rXFEa6slfg==
X-Received: by 2002:adf:ef4a:0:b0:354:cdb5:a9ad with SMTP id
 ffacd0b85a97d-35e0f2a97a6mr9157350f8f.42.1717514271872; 
 Tue, 04 Jun 2024 08:17:51 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d9c68sm11765831f8f.56.2024.06.04.08.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 08:17:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: Fix a handful of doc typos in bootmeth
In-Reply-To: <a57a03d8-5e45-4ebc-884c-9626a03c6aa9@cherry.de>
References: <20240603-bootmeth-typos-v1-1-6edbdb469f7c@baylibre.com>
 <3bb636fd-39b7-472a-8715-e306dc8c3ac7@cherry.de>
 <87wmn429sw.fsf@baylibre.com>
 <a57a03d8-5e45-4ebc-884c-9626a03c6aa9@cherry.de>
Date: Tue, 04 Jun 2024 17:17:48 +0200
Message-ID: <87tti820v7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Quentin,

Thanks for the review!

On mar., juin 04, 2024 at 14:22, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Mattijs,
>
> On 6/4/24 2:04 PM, Mattijs Korpershoek wrote:

[...]

>> 
>> There seems indeed to be some inconsistencies around bootmeths versus
>> bootmethods.
>> 
>> To me, we should use 'bootmeth' everywhere.
>> 
>> Simon, as the maintainer of bootflow, do you agree ?
>> 
>> I can spin up another patch to fix this.
>> 
>
> c.f. https://lore.kernel.org/u-boot/20211023232635.9195-1-sjg@chromium.org/
>
> """
> For version 2, a new naming scheme is used as above:
>
>     - bootdev is used instead of bootdevice, because 'device' is overused,
>         is everywhere in U-Boot, can be confused with udevice
>     - bootmeth - because 'method' is too vanilla, appears 1300 times in
>         U-Boot
> """
>
> SO I think we should change it to bootmeth(s) indeed.

Ah, thank you for the link, that is helpful.

I've done the global rename, made this into a series here:

https://lore.kernel.org/all/20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com

>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks,
> Quentin
