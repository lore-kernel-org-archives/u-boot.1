Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22335C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7858488815;
	Sat, 20 Jul 2024 14:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gE149dwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DA088671; Sat, 20 Jul 2024 14:36:21 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F63886F9
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e05f913e382so2576908276.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478978; x=1722083778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+bGH+gk+PuH9ubUKfxTAXkwfWNiby03oqWKcU/To+gM=;
 b=gE149dwxP3/xB3ORIiITyrIiRmKDaxDPZn3NuHkxSvXb+tGpG+oKjS5yuJRc7ThIfk
 T0Q43ASrqBRRd/15yD1d2AmkX1RtAlCjRtrCZLgNEhWZEB4asDQMWdgyGkNjWsHjdpi2
 ndezg7s3S6zx+Qk7LKXJCJgkuw4QffyzNEB5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478978; x=1722083778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bGH+gk+PuH9ubUKfxTAXkwfWNiby03oqWKcU/To+gM=;
 b=gkBAYZMdul/0UtKEER+HDuQf21lKY7gl3LJM6T2GSwkyqsKDx7c0vYErZDON+3FhM6
 QwFRDlWXxtWsMi0v3BQaxuca7/Kn1GUwKJBvJ97P+respxRLg6ZmFx5/RwkeuBCZgIf6
 yzgmxNRVtm3q4RCtQlhMS8IVrerBVVLX1myc3gX6h9yTsXVZW9xuhG/XmIb2hIlipcgZ
 kDFdhZLye+hdGEmN21xIsGqO/aZls+U7wviaUMVES/M2aEMgE9AVCMenXWGBaM0cE+t0
 BUHodYfRapiJBf0X9PMQnVVBRz7Jgni66g57d0QTG4MofsgkOVTlpaZMBVdsWh2nH75/
 3ZZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLVzUHwHi1lKcjFmlTMW1nJWBQLmLPsjTjHdXy7HM+GQt/FJi8LLF6JJgqe3Q776qrApIyv54DrYHXyHASDG80pRYt2Q==
X-Gm-Message-State: AOJu0YzhDhR8ZWcoR6leJxERGa9Ginb5XpNhSVPpgmXcWDv/X1MFhtrm
 +n4EpRyHLdNj/ifSSA6N1ETwXJFOqx3L3erE60u9AhfzuNLl3gVlgtFhcDcFrEBfu5eHW4Uv56m
 hvOxokGCQre8H6kxkPtew9lzqTJbvQLT4mk2N
X-Google-Smtp-Source: AGHT+IFxXLWOl8CaXVA6t8eFEtWLiQu7GI4YsHFTXQU2SeWOTb/AsHjTKMTdkae48AT6lSdXxdmux/y9XGQzzvovNnU=
X-Received: by 2002:a05:6902:2302:b0:e03:9e09:951e with SMTP id
 3f1490d57ef6-e087b8f3110mr1213876276.25.1721478977961; Sat, 20 Jul 2024
 05:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
 <20240719091213.3757300-3-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240719091213.3757300-3-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:07 +0100
Message-ID: <CAFLszTi4hmabQZ3T67_Q8d4wZ7Y_XN=nRpW2oDjqnAr-8K1=hQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] led: Implement software led blinking
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
> If hardware (or driver) doesn't support leds blinking, it's
> now possible to use software implementation of blinking instead.
> This relies on cyclic functions.
>
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/led/Kconfig        |  16 ++++-
>  drivers/led/Makefile       |   1 +
>  drivers/led/led-uclass.c   |  11 ++++
>  drivers/led/led_sw_blink.c | 117 +++++++++++++++++++++++++++++++++++++
>  include/led.h              |  22 +++++++
>  5 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/led/led_sw_blink.c

Reviewed-by: Simon Glass <sjg@chromium.org>
