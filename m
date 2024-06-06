Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4825C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 10:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4914E883EA;
	Thu,  6 Jun 2024 12:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tSeDMiO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1799088423; Thu,  6 Jun 2024 12:08:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7C687F5C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 12:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-354be94c874so565451f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717668479; x=1718273279;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Df73NAHe71ICYdA1lf9Ll42gD67/5NWHpektfFo0Hsk=;
 b=tSeDMiO8aL/FbBLfs8GC1qHie3wEIvicVvtGUAQ+BOUZOvmbO95JIqb5qlfR1aGOaG
 IjDnTF+hqRFLzr8d2EADYazxwHAXXgDNUyNutJ5o36zEo+Kqpsw9SLSCRLgxkCu7b1or
 D+kwv2D/RrfqrUWg1hxYyb+4oHEaFfN1qQ4PTjEJ2WibSS4DDoNfIb6qNOjNu7bMoTCE
 YWPg+085Xaqq8pz8cvFXJn70Z3ubvSKioL4vKO3kwx6bzQ6ieOsJ2iAtFpRoUCuyTscR
 0Vrm4aCCUAx5refFFi+OTc8bZoI2BjR6JhN7BdJjsdkAKqd1Rp5DJwdneY1uo73FgmAq
 NTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717668479; x=1718273279;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Df73NAHe71ICYdA1lf9Ll42gD67/5NWHpektfFo0Hsk=;
 b=Tkq5+Ve7exK1rbFwjy17OzYzUjY8O8JHhBRz40HMbJ8zHgXGXl12TK3FPQ+GdsnkVS
 iWnCV5felCbicRAiY12s7GG7reJpotsqCP6Ksj5TC3TCyT+/sJsHwl4Oa7FH04lt5xWn
 /Orf/fj6GxMGw3BhRsuH8VjM6bdKcrkT3jRl+SQ4XjsjVYdCSR4C0GPplevlmOlQX47l
 qw1qqmlkKHLZxQvG7j/8jvMWTsZYO/McjHW5J43XtpUxDDb7BOm/t/wj85rL8erqRAC+
 xyzz5nC0ngSmupqzuEdbRhhviosOW8m9MiUUbXOOny6oh8I3jCY0fM4zsbE9QlhJ7q3v
 4mpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhqYPVFdJQTILYr+nInA9MC+EbfzEJWR+8wcw+yyU1HEpCT90r+tdFpMqtV1lr9ccGTOhKQhw0aAGOczSqWfVy+51p4w==
X-Gm-Message-State: AOJu0Yws6PmkWVFIv6IxT3O5YLzuEe8bJr7zm3Q6K0joH64HbsTt6hnT
 u6yTU+JkhVffc934gWxS7UZoeRUKMpiovUfS+qyLV8aK1INK5lO1WEfSf9To7hc=
X-Google-Smtp-Source: AGHT+IETqeuDMGkLlm6MHjvR0klDrl+wrdPWAiQNrmPaxP7Xux6oYwhm6ctzngE9btNyGPnoTmrMkw==
X-Received: by 2002:adf:f186:0:b0:355:1b5:befb with SMTP id
 ffacd0b85a97d-35e8ef8fd2emr4264489f8f.43.1717668479282; 
 Thu, 06 Jun 2024 03:07:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35efa97b15dsm83305f8f.81.2024.06.06.03.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 03:07:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240606
In-Reply-To: <87o78e1k0c.fsf@baylibre.com>
References: <87o78e1k0c.fsf@baylibre.com>
Date: Thu, 06 Jun 2024 12:07:56 +0200
Message-ID: <87ikym1j0j.fsf@baylibre.com>
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

Hi everyone,

On jeu., mai 16, 2024 at 17:12, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Tom,
>
> Please find some fixes for master:
>
> - dwc3 fix crash when ep0 stalls or gadget is stopped
> - Kconfig build fix for DFU_SF (SPI flash DFU driver)
>
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/20990

Please ignore this one, my mail client screwed up the send date.

Sorry about that :(

Mattijs

>
> Thanks,
> Mattijs
>
> The following changes since commit c0ea27bccfb7d2d37fd36806ac2a2f7389099420:
>
>   Prepare v2024.07-rc4 (2024-06-03 18:34:59 -0600)
>
> are available in the Git repository at:
>
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240606
>
> for you to fetch changes up to 4339138a2086f8449b9356130cb6e97a81aa8679:
>
>   dfu: add missing dependency for SPI flash DFU driver (2024-06-06 09:11:21 +0200)
>
> ----------------------------------------------------------------
> u-boot-dfu-20240606
>
> - dwc3 fix crash when ep0 stalls or gadget is stopped
> - Kconfig build fix for DFU_SF (SPI flash DFU driver)
>
> ----------------------------------------------------------------
> Heinrich Schuchardt (1):
>       dfu: add missing dependency for SPI flash DFU driver
>
> Neil Armstrong (1):
>       usb: dwc3: gadget: fix crash in dwc3_gadget_giveback()
>
>  drivers/dfu/Kconfig       | 1 +
>  drivers/usb/dwc3/gadget.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
