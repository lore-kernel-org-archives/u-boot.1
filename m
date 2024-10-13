Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4C4CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 16:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFE788E75;
	Sun, 13 Oct 2024 18:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xdgkaT1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FE4882EF; Sun, 13 Oct 2024 18:36:19 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1616882EF
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 18:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so2090425f8f.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728837377; x=1729442177; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ObYqYt+JwvbACZxSTxrcCMR0dYuLoYggVvrOJB3GMq0=;
 b=xdgkaT1wRaJ9pwxNeTbkp/wx/QXF0Hv2rwIlwxY8Vd9PD5fU6BE1eOu5OR14cDdIt8
 1r4t0l6CBZ+rpglqOx7XaIYtzTX9GzN66dCmaWFLcOW1b4tLbxtWX1dCX2RWOcIl9guA
 /NhO/GeNXM594JTs4Z2SD2KAp5nUngFtPhngE4Ud/QDFu44ERRpGTnBIICK5p3SXQ/BC
 uGHkZ2zWTLpTFa6S8z6WlvfDdwyElbZ4sdAewKh8SIoPbJNBywPGspBE8rY2PmmX+J83
 iyoKMYOvOMoeziXAIOT25gWSotRGydJgEkZmY8Z4q0XRXPzalDFLbwloYoUVwoE8SnIm
 v++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728837377; x=1729442177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ObYqYt+JwvbACZxSTxrcCMR0dYuLoYggVvrOJB3GMq0=;
 b=i60yApCFSv/RJoOpuzP/CjXxBxzheRFQWBcz07If6bX5SRgj/jroV9FHDNUSh3UJC8
 Kvy1PxVUIqRvsRdebvcKb+NAo0M98ZBU3RPhnSF9AFFgBAfDQVLS4cdfdGq4ruarSZvA
 wqbqFjcdFuIVaswKu1VyTV9bvVtHlbkFbQQM4qSCbGJHKdZZ/gyXHXhVBwceHkE2O2WA
 0otfkVhrPPpX7DQ/DFBwJnmX/x7wbPWUyzcu5VU1jdFksbFIJWT4UKOG8YIbqQkF0aog
 q1kOu1mfudCU54+bC/v2+lBW8/4qEjDO5D/EGr/uT8kWBZw9y7EWl6/KhSl/6wVm1Sr8
 SiWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxiqxRiXnIzXAQal0xJD+wNADkJ5WvMt0W39IOOkYw7vAGksipeTyA4gRl4RMN0mvwXaiVu5I=@lists.denx.de
X-Gm-Message-State: AOJu0YwPxmWUiIP2h3lsQL0TwTbbfetVIxkBKch6xpHMFcYhstc1Cb6t
 vK6IParrI0HtJu0140aWomcN1M5Dr37NtVelpENRngVGfcnDKcSdAhUFWpew5Zs=
X-Google-Smtp-Source: AGHT+IEDa+iHnk6mlHgkECEuFGGjjLFKREq+lvUEwYZFFMOxI5xtdv3kzfec9zP3dyTqU75uZI4PjQ==
X-Received: by 2002:adf:f449:0:b0:37d:2db5:b50c with SMTP id
 ffacd0b85a97d-37d5518e16emr5800992f8f.8.1728837376962; 
 Sun, 13 Oct 2024 09:36:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:705a:8bb3:8b50:341e?
 ([2a01:e0a:982:cbb0:705a:8bb3:8b50:341e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf1f6f5sm130950675e9.7.2024.10.13.09.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:36:16 -0700 (PDT)
Message-ID: <b35d5508-e162-487a-b38c-a21e3a541216@linaro.org>
Date: Sun, 13 Oct 2024 18:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] configs: khadas-vim3{l}: Android bootflow updates
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
Content-Language: en-GB
From: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Le 11/10/2024 à 17:51, Mattijs Korpershoek a écrit :
> Hello, 2 small fixes for Khadas VIM3 and VIM3L to boot Android.
> 
> Recently, some effort has been made to use the
> upstream android-mainline kernel on these boards [1].
> 
> To use android-mainline kernel, we should:
> * Increase the boot/recovery partition sizes (so that it fits)
> * Drop dtbo support, since these are not part of android-mainline
> 
> [1] https://android-review.googlesource.com/c/kernel/common/+/3296472
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Mattijs Korpershoek (2):
>        configs: khadas-vim3{l}: Increase boot/recovery partition size
>        configs: meson64_android: Remove dtbo support
> 
>   include/configs/khadas-vim3_android.h  |  8 ++++----
>   include/configs/khadas-vim3l_android.h |  8 ++++----
>   include/configs/meson64_android.h      | 26 +-------------------------
>   3 files changed, 9 insertions(+), 33 deletions(-)
> ---
> base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
> change-id: 20241011-yukawa-aosp-parts-77d255a19cda
> 
> Best regards,

Thanks !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
