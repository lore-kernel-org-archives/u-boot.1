Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F4FC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785638764D;
	Thu, 30 Nov 2023 03:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mXERyHya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB63587600; Thu, 30 Nov 2023 03:45:55 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC2E870EB
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a049d19b63bso56437466b.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312350; x=1701917150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hwE2fzIaxM2Y6+h6gtwfr3Oq6cmU8PHkld2PA/b+J9Y=;
 b=mXERyHyaw47BlGlciiSQHbMy60Rfp4MhkI5yJm1xDYCZEYv3fXODzrBj3nVO3QFzzm
 FGBSah97MyM8FWt8T8pYcZZZXz5ecnWQWQRTenz8UuUCpAQ9binqLWzaibrigjsNcjvc
 sE+p9jWldM65aT65hOjJBI4ooEHmfUZLM9W28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312350; x=1701917150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hwE2fzIaxM2Y6+h6gtwfr3Oq6cmU8PHkld2PA/b+J9Y=;
 b=tuhVnW+sL8Z4nHmvY36gVTMoF7pY+Z9tMq55gQ2Dx46ywtPMTYqQE/AvBzCqXhNliW
 XPzF+bd0i6ljiwucBDi4sz7LfRIRSzxmWYUUhniX/iWGRtJOv14YlNRFlLqwoWmSJfeN
 Q8T0FhFN1uqqhjQDOCuwGMCr02YzT6PbqYnbOswVuNvPEtW3mPOa5vC1I2Z8Q5tOJnX6
 +EGb3nZ7VSzWm47R8A+Yct5IDKI3quBh4+xdGo23gk2zTno7cZBxPe92xVG9vQWCzogf
 MuXOnNG/37cvdaMjfhfDBR6A/EwcnwTdGBZtNYUbeS7/u9M0yMsEw6JKNKwfgo1tGRcb
 jS4A==
X-Gm-Message-State: AOJu0YyH5G61pXrfH7Jd3IzzlIptP9zorMaLBntnaq1TqxxPSa/wHfcl
 yrZzHunEV9CTlGBAN/P013c7NHo8yPvNhZku3s3L4g==
X-Google-Smtp-Source: AGHT+IFSZrlvAJskZ5zhhsuHk4urXh4L7Zl66yiUY6lG3QwCqW0BQ6+tcnCTBsXJUFd5gvjynkRwQdpmlU8nw9Lgbgs=
X-Received: by 2002:a17:906:7493:b0:a18:5f93:d53e with SMTP id
 e19-20020a170906749300b00a185f93d53emr531244ejl.14.1701312350115; Wed, 29 Nov
 2023 18:45:50 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8@epcas2p1.samsung.com>
 <20231127010520.3170033-1-chanho61.park@samsung.com>
In-Reply-To: <20231127010520.3170033-1-chanho61.park@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:32 -0700
Message-ID: <CAPnjgZ29dUuD1uZMWAH-Eqx7RsGgy27ixHROAvMB8=Hm-TdT2A@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Correct watchdog timeout print message
To: Chanho Park <chanho61.park@samsung.com>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

On Sun, 26 Nov 2023 at 18:06, Chanho Park <chanho61.park@samsung.com> wrote:
>
> The wdt_start function takes timeout_ms as a parameter and starts the
> watchdog with this value. However, when you output the message, it shows
> the default timeout value for the watchdog device.
> So this patch fixes that part to output the correct timeout value.
>
> Before -->
> StarFive # wdt start 3000
> WDT:   Started watchdog@13070000 without servicing  (60s timeout)
>
> After -->
> StarFive # wdt start 3000
> WDT:   Started watchdog@13070000 without servicing  (3s timeout)
>
> Fixes: c2fd0ca1a822 ("watchdog: Integrate watchdog triggering into the cyclic framework")
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/watchdog/wdt-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
