Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419FDC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0653588747;
	Sat, 20 Jul 2024 14:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kLrfbpWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F6188675; Sat, 20 Jul 2024 14:36:22 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ECC4886F0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b795574f9dso17046626d6.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478979; x=1722083779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ji0nkWSYhXyrjMUiSEGbiYwhqND0jvMljRF3PqE5j+U=;
 b=kLrfbpWPMWtdPNcnpT8DtwnShmuQwgHVMJ9NUiVMVwti3iI1eIX3ru7OAacMqHUq5a
 42Wh+Mi4gUEiGADvfmEu0e4etg2kUoWZFIc8zt9oQnEk21D1dvWCd8rgtsmTBcJscFdm
 wSyZ4cXCdMVjDjOG1lD1JfdoIXOe9Hi/F5UaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478979; x=1722083779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ji0nkWSYhXyrjMUiSEGbiYwhqND0jvMljRF3PqE5j+U=;
 b=fvEXSRvsOOfq5RD2G4yN/N9xoUUhgtUVwbRVfhdMRepHEY0P59SOLQ7bM5Hxba6lLE
 qT8GUT07no4TA3PhFfSCiOUNa4JqGnW1nQhemWg00j1jkRatNgHrlkS4XwcAagqtQXfS
 XtQCcdanmfKHwrWOzqw0jlYeuA4HwUNm4f1cL9nddO/IFU0fHqZcxJjtqDb2Qydre/kx
 VPlKP7WDXvkuwPpXscAxJLthksckZQDsiNaV3oxBMtcFVoFlzo2oWWnxHDKLcE93I2re
 HzXdQBWsq0aAsuem22D0wp161hNOd+ztBRtvnW+NVK1CvpysRHFs4U8iYNwZz0V2kYVd
 VptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNSjF4666XMXZs1ROXn2vqqE+6NWKseRS0k6kh41X8WNL1dD7QTB4q36uGQm7hh1/SoFjr2usyToRs/cg1GfPOxXgRbQ==
X-Gm-Message-State: AOJu0YxTDeKKmdV1AnzKlRBQ9ueXtbMkKNwO9TtqQAx2nkiZ+Rk5kxxV
 8g/4wFFR43TfJ3F/E/v9lCgF1Hl1REQ7DbLJ+JiL1YcjHV7mD6Ml3lLrDhhrNEVrJ8kjzzW6eqG
 j8HbnSS2xNdMhhPznS/xr4UneipFdVoPUikWw
X-Google-Smtp-Source: AGHT+IFogQKZ7rXek+BpGPgdwJ9yBPPOkewVpSKtdtFIhQfouUHwHsw3OPjjJXUX5EWaC8K8aDiOn6KyOnjp2jPciqE=
X-Received: by 2002:a05:6214:2a4f:b0:6b2:c840:7a2 with SMTP id
 6a1803df08f44-6b961182b79mr15012646d6.45.1721478978970; Sat, 20 Jul 2024
 05:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
 <20240719091213.3757300-4-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240719091213.3757300-4-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:08 +0100
Message-ID: <CAFLszTjG2vXnReX_cKUNPPPknunrcxV5hA1R2p5jrtd7a1w0Yw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] led: Add dts property to specify blinking of the
 led
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de, 
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
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

On Fri, 19 Jul 2024 at 10:12, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>
> The standard property
>
>     linux,default-trigger = "pattern";
>
> used to get an effect. No blinking parameters can be set yet.
>
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/led/led-uclass.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

One more thing - it should really have a test, like
dm_test_led_blink(), some ideas about how to fiddle the time are in
dm_test_rtc_set_get().
