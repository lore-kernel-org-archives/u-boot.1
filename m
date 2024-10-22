Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C59D2C548
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8356388EBA;
	Tue, 22 Oct 2024 14:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OzoOgpXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0230B88F31; Tue, 22 Oct 2024 14:56:23 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0803F80245
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so28288035e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729601780; x=1730206580;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QnNtK7N/98RDsZJ/GZKkZgrYYLQdsPv9TL7fYQGchrQ=;
 b=OzoOgpXv86DzX0j8hXe9s+wZoraclpv8k8qQhyWGatOkKkPHCELezDHoQkzSOk10vH
 Ko2ZWYYMdmfUkhr3iiWUckhu0Yb2LTNx1lUsahhvlISloSCd2WP+/pcJeQhxyvqs3eZB
 4K+oF8a8elRNb8scDYyjfqOzbqp5iN//q1A2m091Gwf+OP4/oNDdRijb23f7ukADhklN
 DiA/ldNZ4F7orY29Qd5aI9Z7/T+1kz9gl5re1712gchEPcKrAuTmREnCR6SU2sqY7KUM
 LbyjNTOeS+Wn2E7HeFRXYdeoWbgwA0PaBazzkAvK/uALIae1B9tNMqGKNr2hAphiWtrQ
 N1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729601780; x=1730206580;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QnNtK7N/98RDsZJ/GZKkZgrYYLQdsPv9TL7fYQGchrQ=;
 b=WZHce9uM5xdc3aWdnIh1azbiiEjAQ44maPkHQDetO7y6TLilIVZTN551kHpeuyMEF5
 FXs0VhCs7GfC4xsmRaGIYxGbE5cZAUBHqWl7fIsLOUSwgDFTXopZTK8VRk+qIfVBNZX4
 kldrpYXdFS82gJMymXSwrk2mcL6CtigeU6ooUELeeVRSw2/bEDxEFAKjIndOMidSCvJL
 lkOQVzhNjM5ptF/z63W5U7pR/acpvBrJszkLBIDqcfbaISzwSa57RnsRul9coWfGlVqc
 j+9E0HO7ZvnbDLcIznmMzAToowKhLpJ8DDw/Lx3X/7LVYJuMrqeYF5R3j6LKHs6JYymT
 qvYA==
X-Gm-Message-State: AOJu0YwzaHLPRYXlBqUk6jixMM43k6wLJuE3Zo1Oj1aXeVB4eWDtDXp3
 hPdxJCC6vRrogryrPv1ZnDfxIikqrhrBh46v5Xngsao7R+mQxDMFJXLmvSm2oq4=
X-Google-Smtp-Source: AGHT+IGWOe/hCdE2hhTD3wH9tbT4N8YjZeJD4b6dr7JQIwGRytnUTd3c3wh71lXdr8aQVZcCUUpMKg==
X-Received: by 2002:a05:600c:5250:b0:431:3b80:6ca7 with SMTP id
 5b1f17b1804b1-4317be9ced7mr19937815e9.13.1729601780344; 
 Tue, 22 Oct 2024 05:56:20 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc596sm86731165e9.44.2024.10.22.05.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:56:19 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 6/6] bootstd: Add test for Android boot image v2
In-Reply-To: <20241017-adnroidv2-v1-6-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-6-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:56:17 +0200
Message-ID: <87v7xkuwi6.fsf@baylibre.com>
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

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Rename actual android bootmethod test to specify it's for boot image
> version 4.
> Add a unit test for testing the Android bootmethod with boot image
> version 2.
>
> This requires another mmc image (mmc8) to contain the following
> partitions:
> - misc: contains the Bootloader Control Block (BCB)
> - boot_a: contains a fake generic kernel image
>
> we can test this with:
>
> $ ./test/py/test.py --bd sandbox --build -k test_ut # build the mmc8.img
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  arch/sandbox/dts/test.dts | 10 +++++++++-
>  test/boot/bootflow.c      | 29 +++++++++++++++++++++++++---
>  test/py/tests/test_ut.py  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 9bf44ae3b0bc..108633a727f9 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -44,6 +44,7 @@
>  		mmc5 = "/mmc5";
>  		mmc6 = "/mmc6";
>  		mmc7 = "/mmc7";
> +		mmc8 = "/mmc8";
>  		pci0 = &pci0;
>  		pci1 = &pci1;
>  		pci2 = &pci2;
> @@ -1135,13 +1136,20 @@
>  		filename = "mmc6.img";
>  	};
>  
> -	/* This is used for Android tests */
> +	/* This is used for Android tests image v4 tests */

Nit: we are repeating "tests" twice here.
Maybe rephrase to "This is used for Android boot image v4 tests" ?

With the nit addressed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

[...]

>  	mmc7 {
>
> -- 
> 2.34.1
