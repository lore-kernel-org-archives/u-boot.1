Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F09DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C4584C9B;
	Mon, 13 Jul 2026 22:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MjPXEhgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A6384CA3; Mon, 13 Jul 2026 22:56:30 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED5484A6B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 22:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso492613a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 13:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783976187; cv=none;
 d=google.com; s=arc-20260327;
 b=bmKqbwWxqvIuyk1REHeuAQNs31qfRJ6bQD4s1zRm/Xgc+HwNAaRAwv1l+b4g5iiQKx
 ub6O5OlU6nEaty30T1/G2hSUwmaT408qJeXyq7ZGl8U0j38J1+GqSTFFwMkrJqcl/Kt3
 h6y4CaugxWnnsa2uWbLejA6UBmfCAWVE7dlJTlSVrqcg/a3Hh7RmJWT81WVtCWqWSV0P
 5VhzwX9eWAyqG0+hVu2kBQlP1ARmXCLxFtXyA+1T8/hHcSvmazs+tJLBdibkzJMC1RdQ
 AWC0IghIor1zKZtYhh6YmAaPGdD+oGiZLy++c499rD/TOz5RjiepsKo2fKFDwpySQ1+A
 BshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w118OZLN3jK2xqXF8Ov0SA1dMx3VeHWxOQU3gRCeFT4=;
 fh=RYRoxNOjuHPJgeepkDgPG4TS1YEj8vlj2h5gDMROLMQ=;
 b=dd2ahFJoKV+rHyQ1LAbIaOe9Wg9J/dbfWDtExAvenE79mdGun1oxq/fyo24IRqyHZp
 vdJYasZSZh8wiMimh69uKaMDBdFh9neg1lBJLJww79BY0gepWxWXFT+HoO+Kn5c7Cfqh
 7C0EDR2IiYjpLjQRl4r5JGmYfxaGiTYfDufgQbxrP3pQdcC9PWsxBHsvpDUt03yaoNTy
 +yQ4ZOq/gzRIkEsWsP+VgWOVfw7qXImKExUNxO5HMzTymPdX3qOwsRCT5OL4I8CqxXAZ
 xbM+8mbILTuUR+VM7+HV63M+2uQG22KlVDP3ygYPF2MHc0dU75r3Jbx0sgQNEdEAkeu3
 QQUA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783976187; x=1784580987; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w118OZLN3jK2xqXF8Ov0SA1dMx3VeHWxOQU3gRCeFT4=;
 b=MjPXEhgmX2EfRCjKmu9Q2q1VxKCi8EcafMeZX8+l4Gjgb58Dd+g7XtfeOijtMD3j6p
 0yv6kO+CtdJ/cxAGxgsbqg8d0A6Tg2Kdr4v495caLSIku+bJO+YiJIo2GxNZ6Wq5zHvF
 Olk1nSBwEEZVnKdiz+CkiKB/Ced/rMF1ncGdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976187; x=1784580987;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w118OZLN3jK2xqXF8Ov0SA1dMx3VeHWxOQU3gRCeFT4=;
 b=osyq4yrySL7aR2NgmcNuNz3NZY0mjC40a/6Gie7v3S+vLNXp5ZuzGkcfC4x7mjmnWx
 JWQB747JblPqxt8K1O5yhYX56QiErOnQAvhvJ4HBbD64MBoYhG0+PmBf5bn7wBzRVLGa
 TwRdcBTFEpPxijyRZyq39JEfObEhyaA8aOqTvO45gNcr6rYPaLpRbuLM+/vRN34sp0OK
 grqmOsqdOZo52OS3xnYEn1db9ZIbIf5q2/W+yqys1nu/SuLtzmQWjKjnQjPoysj/YBaY
 k1yEF+iYn3Vxnr8hslyqARHQv7NcZ/muxXWCObQwr6C+j0oI49IzskRz3+erNkWVpGwJ
 4N8A==
X-Gm-Message-State: AOJu0YxOVgLwY7Ode9tNULjJrp313t3/3ovdZRVEV7I/903OGjZTeYb9
 eH+n3mBacQMZZspdLIqQM7qmPTcQiQEnCa1xgawpjcDfF2gLhQ9hLvMtQzHbJPGsuHINkAGdBT5
 vhP7WIcDftFFc38Nyr+ajRGPCcfgOqR1SMi3nTcuPLDYjWVqd7IX4Ew==
X-Gm-Gg: AfdE7cmGOBOUYeyiC71MBukAOj+VDIIIHl9f0tNsLt318popYRVOiDcBogW9sw6xJP5
 adPw48X+S8LdVQ4dw0O5IS9cz95KXliS5wTaEQwQRBAgBEJFBGO+1ybgnfuOCQAyuF4kmchWyAv
 weNrX/uQFMCfrfql62OBqhD58yiKoqrRTLM4MD6G22kzo91BUuy7qkuf99awaEh0QDIrrq6O+I0
 VFSBBIBXniuaszs9neIwtvpAiRZRABcHcjFZl6Is6S+thr0T5sEdnyEWyDsNcVYVT7iQ38=
X-Received: by 2002:a05:6402:3898:b0:69a:9355:d1d6 with SMTP id
 4fb4d7f45d1cf-69c5f254b8fmr4735216a12.42.1783976187222; Mon, 13 Jul 2026
 13:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
 <20260709142901.2054431-2-pranav.sanwal@amd.com>
In-Reply-To: <20260709142901.2054431-2-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 14:56:15 -0600
X-Gm-Features: AUfX_mxxsTkAPolB-FlIg7yhe7dShSFDmHiLZ7Qf0zoG9awS6gV19_d5gtebC88
Message-ID: <CAFLszTh3AtRZ-H2S8d2rvV5HzgVy6+KEMBWoKmTj-YDHP=f4Mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: uclass: warn when a gpio offset is already
 claimed
To: pranav.sanwal@amd.com
Cc: u-boot@lists.denx.de
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

Hi Pranav,

On 2026-07-09T14:28:59, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> gpio: uclass: warn when a gpio offset is already claimed
>
> dm_gpio_request() returns -EBUSY when the requested offset is
> already claimed, but gives no indication of which label is holding
> it, making an offset collision opaque to debug.
>
> Add a dev_warn() printing the label already holding the offset
> alongside the newly requested label.
>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> drivers/gpio/gpio-uclass.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> @@ -397,8 +397,12 @@ int dm_gpio_request(struct gpio_desc *desc, const char *label)
>       uc_priv = dev_get_uclass_priv(dev);
> -     if (gpio_is_claimed(uc_priv, desc->offset))
> +     if (gpio_is_claimed(uc_priv, desc->offset)) {
> +             dev_warn(dev, "gpio offset %u already claimed by '%s', requested label '%s'\n",
> +                      desc->offset, uc_priv->name[desc->offset], label);
>               return -EBUSY;
> +     }

The -EBUSY return from dm_gpio_request() is a normal, expected
condition for some callers, not just an error to be diagnosed. For
example, cmd/gpio.c deliberately tolerates it:

    ret = gpio_request(gpio, "cmd_gpio");
    if (ret && ret != -EBUSY) {

so with this patch every 'gpio set' or 'gpio toggle' on a pin already
claimed by a driver or hog prints a warning for a legitimate
operation. The sandbox tests also trigger this path on purpose
(dm_test_gpio_phandles and dm_test_gpio_devm expect -EBUSY), so test
runs will emit these warnings too.

We don't really want drivers to print warnings unless something is
actually wrong with the device.

Could this go into the gpio command instead?

Regards,
Simon
