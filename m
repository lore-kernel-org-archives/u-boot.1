Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4594F3ED50
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 17:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED2484207;
	Sat, 11 Apr 2026 19:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WmyoqRV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45CB841C2; Sat, 11 Apr 2026 19:19:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450F7841D5
 for <u-boot+nodisclaimer@lists.denx.de>; Sat, 11 Apr 2026 19:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9c9d03524cso359707866b.3
 for <u-boot+nodisclaimer@lists.denx.de>; Sat, 11 Apr 2026 10:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775927968; cv=none;
 d=google.com; s=arc-20240605;
 b=WP3zWAKf3Vs1uN4rK0sfho0EFYC5Y9+zK8Ng3K+FCSP7EF62vh2Y4A+WDx0gB3CYdt
 AG+4nhzmKLRhqMA601rfDfvjIm9NRIBTB2M/YHDzUbTyRUmhfYF3nKVq+oExMgB6PBZN
 5bJ5h4XKi7Bf0GQ5RrYbEFWBPIL7R1IoEqLQJO7ZOnNyHw5wY2ewixM8LDca4yNaSqOm
 7o1FRAcuWjOIaqQ3nvjpLzU+bJQBMxyroVIzK+z8MqJSLAMT2eQQ4St/cPVEK6BXUmxz
 Xjrrrs7bshnjMl3e3jX0r2JBKixexdklElSmy73uveH1toBIKZqaBZV3kbZDpE7QXVl7
 dBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lv/nqiqALfGGmDWafYOQbmws+VY32KvMOsXhKcAgJ3g=;
 fh=2Ai/DF/OygrgX5KD/xptwaXayaptkAAlqyY5KCXDcm8=;
 b=ikt15hRGWWjQQpfin1zqwjgGSQ/Ha0AimVafNIohdzNcd59Y3VUzlrTw5UMdkugbdU
 0qDefR8PMn4U6rdyaxFiWQPZjBlgE2bG7Jax/4k+ziRKC1n+9Em3hD+qoil1XU9BUAPf
 uyz65JS0tJpVLTXdYPKtK6eBfQBL3xTl7GZuJ/ryGf3MvtUulQjdRr4lwJjfI9N4PEW/
 3LYcjyNPDFsSiyJsM1LHUxFePgdHV0ydPTqcl1xTZqJWg1ZzRQLB7XpyezzwJS9WhP0c
 9HmCVm6T6bdTAHoW/0wTgHU/86nFrnywxSE0lyuU0WC2E9ur8iovZMHuwSn8voO1hpM8
 DSug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775927968; x=1776532768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lv/nqiqALfGGmDWafYOQbmws+VY32KvMOsXhKcAgJ3g=;
 b=WmyoqRV31qNiZTkmiUXejeDm3b/dwBuEkEqbvh73z195UscQz85av19ZO0SyZ6U95Z
 OCofMc/cBLwXLWcoKJSNkA1GiYD6Gs8+pSQhGm2I7iW4hhTL8OJUO4wYqyX6xxCNN9vP
 xprpmvnhNootJHHnA9BtDwev++3FgpeRzRUXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775927968; x=1776532768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lv/nqiqALfGGmDWafYOQbmws+VY32KvMOsXhKcAgJ3g=;
 b=iWeWFph28JTL/02JbDkJ7IAQHE7bXwAbyW5HYkIbZhUY+dj6RgcxBF5Wq/XmL22J8v
 9hV5PRdN33SBAqs6+Zx1art3jXNShWrUzGk96It14G2gEAS5DDxWn9GsFhiCL1QFBqWY
 G5hK90BcRI5CmChGmsjsfviyvSxeaT6Ub6yYFdLab8cmLLik+gb1vqEi/pkqY5mDy8kw
 vnDQZ+lbP4CgajJa8AgLP/Y3ae83LhJa6OtFJhkxq958ulTwfvcLF43M/QZPhUrIJDHx
 XSKy+I5W/ZVQOaZS+Ir3Hkn+KjSZWVuIUCgin140uydtipLtbGe5/DUB6Zw26yR1vyjz
 hdIA==
X-Gm-Message-State: AOJu0Yw4mzBoCtmxuJ/aomv9ElB9hHAko5pgnQCxm1F6lOA6C6717JYj
 cG04d/ew5LD+vybqLyeCsYsyf7Aa/bYVu6zQDu6y2lbYxZMJvgfj1M0UDQyk7wXPd+hCWrJp5f1
 NeKDNnbHX8nQ8SjoWOOHSDBVx3e4a7CIoMfd01S67
X-Gm-Gg: AeBDieuz15cu1bNy9VIFbwIGBRFjuUECdnQUCmURdi4gbkkZO8z+6FZRH3ygfPug3/B
 tU37fWlo83r7XLougmLUKNiCAlcqQiq/Tw15Aq8xaus7fef0/OLI6OUBay4ZCuad35nQGlFbk09
 z020Gn8/tazfK4EqnvPYzUIjiANW1tJKsaJN4sIGsHe54Ig+UlRFfo2kG53+2q+ApxrNlucyQRh
 fWItbQIBHpPafZscjvM057bzmS9vz1TgLDdd5V+Rdd2+MwVRijHmQAmClxvDDp0WKDhFRFLKWTw
 9BykwQ==
X-Received: by 2002:a17:906:d013:b0:b98:2641:be5e with SMTP id
 a640c23a62f3a-b9d72980762mr302623866b.27.1775927967683; Sat, 11 Apr 2026
 10:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
 <20260408150201.217942-1-paul.henrys_ext@softathome.com>
 <20260408150201.217942-4-paul.henrys_ext@softathome.com>
In-Reply-To: <20260408150201.217942-4-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 11:19:11 -0600
X-Gm-Features: AQROBzBvLP0FJUtfQgPcS8PRnRjl4TXTDiiODRraFHRxfONpcuM7ICfo2xHWkf4
Message-ID: <CAFLszTjKJ=6CCqczeWD2OtbWW6d4Js2tyZZAiTFekD6=71CNoQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tools: binman: Test signing an encrypted FIT with
 a preload header
To: paul.henrys_ext@softathome.com
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org, 
 trini+nodisclaimer@konsulko.com, alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, u-boot@lists.denx.de
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

On 2026-04-08T15:02:01, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
> tools: binman: Test signing an encrypted FIT with a preload header
>
> Add a test to verify the preload header correctly signs an encrypted
> FIT. This test exercises the case where encryption uses random IVs that
> would change between mkimage calls.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/binman/ftest.py                              | 21 ++++++++
>  .../test/security/pre_load_fit_encrypted.dts       | 63 ++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
