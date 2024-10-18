Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BBDD3C54C
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 05:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965E68904B;
	Fri, 18 Oct 2024 07:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A9cgzwaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7028588E6B; Fri, 18 Oct 2024 07:49:48 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF278904B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso743405e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729230585; x=1729835385;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JmDZiUEAjKmOthJoJ/EcxqklVPkFxlDcCooGM0X1zso=;
 b=A9cgzwaPwf0smETx/EZjKCwUIl5Me0f6wbTG+jMDRCVs1myB2yW5n/NgFGWKikutx1
 PcfW3d0K679KLfnweMGhnh+oehR3DNIeIfDXqdCrk5mmvW8IOgfT2WI81vShvBveHvX0
 5UBqqgx8NVdHKHrsSZj/KA+IEuarjugMEDcj/HnphzG0niOHq7rd83C54QC/6/xmnlJQ
 X079s1AsJ6x6bwDW8P2r7sa8d7ZDiHMf+xmKa5ZWDpuVRWk8fpdP2CVJiBEr/BlWz0Tq
 mWrDprNy+eDjR81LUZjpm7EBXdXhV/cDK/qQYpPoYaR0YXHp/peTSWDvWpF1fWcsc5ZW
 H2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729230585; x=1729835385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JmDZiUEAjKmOthJoJ/EcxqklVPkFxlDcCooGM0X1zso=;
 b=b58Vt8xUPwKNLXQWQcEGR63xLqa7xADINf7of1rm/H5WPO6rNhYSk928HbWAwcDZac
 qRkYA8MF04MGR2/F3xJl9ZSHnJ5Yh4p4ZkRGO5F/Ln1/a/B/UTUdde8/QOHBcFWCMK9T
 VznJnmixpDMJJ2H3SlW+Wu4oYBXMrgAKKEQFLKuem8Xl5sSPL5haTscYxo4lzUaYP0yB
 Z6VuePsKNgW8UHZ9SzL1MiCo6lrsYIjlfBHoIhVVuJ6vsBgTbPsR4y6C30rhWdh7tSAL
 uddXywHTr8dSm7QgdhMIgmfnFfx03JQSRjV8u0segxTgACFwujH7LmJqEJs96ouA1KR2
 JrlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI5M84LAbJTVpPh/A+HSXWWHMlFy1W5kAqtdTEEB0a0yTEnDqrbDxCPL1Z5tiwcCC+c0ZzYhA=@lists.denx.de
X-Gm-Message-State: AOJu0YxbN0Oqche/vBZSaGOHB2ted6sj/+48g9S/ewbg2U4hRS9JLn3s
 B5z1FxYTN+cA2Yd+k/84FPgRgL70dAoR1DaP3pyQ2AP5ddZIcUEfxWd3iKirV+c=
X-Google-Smtp-Source: AGHT+IE8wULt/scUye4VCjlRGbMwu3VnBZXkv5JsicnTNwKyfWxx/Sbr5bfsuKDfCHNteI5e9cGvxA==
X-Received: by 2002:a05:600c:354e:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-431616a3c84mr6242635e9.33.1729230585463; 
 Thu, 17 Oct 2024 22:49:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:9522:f79c:d512:33d7?
 ([2a05:6e02:10a5:e010:9522:f79c:d512:33d7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160e0a87csm13663605e9.25.2024.10.17.22.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 22:49:45 -0700 (PDT)
Message-ID: <29e5d4b3-ce3b-46a3-96f5-1dd6148ae712@baylibre.com>
Date: Fri, 18 Oct 2024 07:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] image: android: misc fixes when using on Qualcomm
 platforms
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
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

Hi,

thanks for this fixes.
I just test this series on Khadas VIM3 with android image version 2 non 
A/B  and AB,
on TI AM62P with android image version 4 with AB, both boards boot fine.

Tested-by: Guillaume La Roque <glaroque@baylibre.com>

Guillaume

Le 17/10/2024 à 16:44, Neil Armstrong a écrit :
> When trying to use the Android boot image with header version 2
> on recent Qualcomm platforms, we get into some troubles.
>
> First the kernel in-place address can be > 32bit, then since
> we use the Android mkbootimg, it uses the default load address
> which isn't big enough to uncompress the kernel.
>
> Finally, the ramdisk also uses a default load address, and
> it should be taken in account like for the kernel address.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Fix patch 2 prefix
> - Fix patch 3 commit msg
> - Fix patch 3 behavior when using boot image header version > 2, use the original ramdisk_ptr
> - Link to v1: https://lore.kernel.org/r/20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org
>
> ---
> Neil Armstrong (3):
>        image: android: use ulong for kernel address
>        image: android: do not boot XIP when kernel is compressed
>        image: android: handle ramdisk default address
>
>   boot/image-android.c    | 62 +++++++++++++++++++++++++++++++++++++------------
>   include/android_image.h |  2 +-
>   2 files changed, 48 insertions(+), 16 deletions(-)
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
>
> Best regards,


