Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E496C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3537A88875;
	Sat, 13 Jul 2024 17:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LXx4sl88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EDD488852; Sat, 13 Jul 2024 17:13:59 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105E988820
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6ad86f3cc34so16186866d6.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883636; x=1721488436; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ReXEx8tKTccIQ/t619BcqTj59LV+ADpHD5InBUyCQJg=;
 b=LXx4sl885C892F4pbkojAlcKrbjHlCylFRKtPXC/X/R+PSkwRMVz5x2bqD9t/tPsle
 vgxtrlfZbTjwkiiCdt16t2iRCGj01qU6BZJ0J4B95vf3k/RHXA0Zwes9wXTb+VpaF8cN
 G7HLNS8ZVufljzYmvlSesH84wkGtt9TOs7gDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883636; x=1721488436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ReXEx8tKTccIQ/t619BcqTj59LV+ADpHD5InBUyCQJg=;
 b=lQ6TEA1qjxoLGVHNvAc9SWLYWV4bLBeXkYEGjgtTSMDyAC1+PvDlV9IHIKWnxvxN+y
 1M1VQichBbs8kYeo+OeKPMLUgNWYuXvtLC9YwxQXMmdw7QpXxn4Cx71/9ZmKxF99SwPZ
 sRiH1yvys/z9AQhxNwS7I5k42JvCZiJkGGawDBwgt4XhOUIMxOMO5/WIMBi7Onmyonu+
 1942fcQHHP+/gL+yJYgobJE1cVE5IDBnyy/CuD+rnX952ri3XormIzY3t0JwZlab/ltA
 vl16oTXm/6zMYpa7cQjMk0OG6NEqJMvx3N1NJi82sZtM9DJQACzM4FNBK1+AaTBZPzz/
 mOYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtpOlLV7clzpcZnRV2SYw6+RboegZk1pmvz1gQkxwnqTHoIhTPgZh7RbPWycW4vHL79FxgME4Ob1UkYvhNNwQ4XpMqkw==
X-Gm-Message-State: AOJu0Yzj2E5PvQM8O4aPujLu9xxvetAdaJOd8TwVsGXJCWjaBruU0a+k
 svTuZnZURC8EZqqn0eHOKn9BYMm1PvbK0UYcGvVFYGvhHyiLbjN7WYl3xUzyVm/oPXIarNTeG9D
 wF0DjsCOMzLYz6IiX0NaqhkPaTEDA2FBKt4vfrO0OouC4v0s=
X-Google-Smtp-Source: AGHT+IEkVYNXFD4yfqmg23t9omzTiQCi5jfzyVUalN7S5bWIifpyjSxwRX9ec8ohk7drBHEPAAP7UZ0aR1rPJYHB+oM=
X-Received: by 2002:a05:6214:5013:b0:6b5:7f22:d7ca with SMTP id
 6a1803df08f44-6b61bc7f05emr169386606d6.5.1720883635957; Sat, 13 Jul 2024
 08:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
 <20240710-bootmeth-android-v3-5-b99406e22da3@baylibre.com>
In-Reply-To: <20240710-bootmeth-android-v3-5-b99406e22da3@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:44 +0100
Message-ID: <CAFLszTh7vbMUJNVwSm-6sVRm=z86PbcNUNCBs8SyXje7NbumrQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] bootstd: Add test for bootmeth_android
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 10 Jul 2024 at 09:40, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Add a unit test for testing the Android bootmethod.
>
> This requires another mmc image (mmc7) to contain the following partitions:
> - misc: contains the Bootloader Control Block (BCB)
> - boot_a: contains a fake generic kernel image
> - vendor_boot_a: contains a fake vendor_boot image
>
> Also add BOOTMETH_ANDROID as a dependency on sandbox so that we can test
> this with:
>
> $ ./test/py/test.py --bd sandbox --build -k test_ut # build the mmc7.img
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  arch/sandbox/dts/test.dts |  8 +++++
>  configs/sandbox_defconfig |  2 +-
>  test/boot/bootflow.c      | 68 ++++++++++++++++++++++++++++++++++++++--
>  test/py/tests/test_ut.py  | 79 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 153 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
