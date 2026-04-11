Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9591F3ED59
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 16:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588828418C;
	Sat, 11 Apr 2026 18:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X+JpLQR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F9C84198; Sat, 11 Apr 2026 18:41:27 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E19784154
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b24fede2acso17561075ad.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 09:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775925684; cv=none;
 d=google.com; s=arc-20240605;
 b=kE5Txzu4B6DV5sMYFNaWL4Ax/1kXq129q4O5CYIIO8C1S0D67yDQB8RAwKPPALE6Ut
 +7XZbaZhRkZosFLGPjeHjK1KZXVfoRd5il6rCYSI0fNDB5saFMtRj04X1py2XMAYoT83
 5Alo1dRnvVRq2uJEXuMVAG3DE/QzMp2Oi3qBqobWj1R8nYXm4JuvTDiv448Ub9FxCdid
 e8zdZDfXCNQap4xKI9iwPXgs/PF5ygpB2Ld/xKxTggzLIjzeOavuXVq7iPV0UfgDJztQ
 a4Fjga2E4SK1SYX/XXr6bbm3HY7HccnHl3eDwfnqlxdx51oRVV+SVC55m71ujl+M4faL
 Ncew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BQ4VF7uMFEabJsDPKKkBps/wsZCb4BGperFjLjVZYNs=;
 fh=pNEDl0BQNvwLbCb3G4NzSeubuTA8HYaPwm66nyYdgIY=;
 b=TM4fhZXlfaD4t6lLAtXYPf1nLewry7hzgEsWeN4Q9TebTnU0+PJp2vppWRwiZuOSR7
 EhJINsR/3u6DsBFh1+6IZ0XboGthKbF/uhTraEwBqdvxjMkGGLP9YnzcUaw6gh87Rnxi
 PTPQrdQj1I2DprJ95jir2efoQUbEft/4ShV9ofxJLEYprOMj56P2Y3SIhXyr33Ek/Yj+
 oGpPyKuHRdSvnVHGQ+maOG9XFmalAFRmNnCmZhYqm0ZIjs/7hjbmiJHpmw/P9DVo5wUt
 20dGwyLgGjJ5pkLHoXlNKU2mHJGo/NuVKk/iv2Kxb9YOdN9v3PmKev2sSYJ+lcCxkCIs
 zWvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775925684; x=1776530484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BQ4VF7uMFEabJsDPKKkBps/wsZCb4BGperFjLjVZYNs=;
 b=X+JpLQR0VsgJ4Mj7NpJ3Ue4NAduLwEGP+GleQa3fnaddOrZZs8yV4LeVne47eAfyv9
 TN7pnpsQX3Dv3mvbrtSvzLY72VBQV2ddwakA2iZsVq4G8ZF4ArNVZz+9ASz74NPMimB7
 nnQqMqQov+qKY/b/EH/1Bh4r4JGUTOppgF4j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775925684; x=1776530484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQ4VF7uMFEabJsDPKKkBps/wsZCb4BGperFjLjVZYNs=;
 b=n4vyAxyBTakyIrxr0aFdCAyAHlUkiWX5rowGtEwnwi+v9wyeRNIO+8oDsM1f291hAV
 Wjm3trYlWsQnCN7hQ8NVyC+bjt0nFiGUhkw9nfU1qlawLB67rV2vbCCu3DaijpCUtgpW
 co6z05OqQqXQA2vTqVB2WgMu2ygtUWqzB0i/qIUrns+RJfVc7EQo5bJRjCMZhlMx+KFM
 DaaIXc/7VTnV0evCbHcU5p5jJI2ayWXb5xPNROKzNKI1sywHT/i4EVXR1n3CKhj3OrBW
 ryzhZnEEiuv7qzbf+4CZYXd/Ti5HWycNtbLJtQO0s+d458VvDH6JLz5cWezgBJl2qjOZ
 /cgw==
X-Gm-Message-State: AOJu0YzEbhJZfizjsNSBWHdRaCXgGlCGuihCklzYvgjKcNYhASsHX6ZN
 SH9NVt4Dhlmz7x2orSWzDCj9hx+HfLkLFxWCGT4U4b75j32FMayp6WvM+3UZ4alVd4DglmdKUGf
 fPH1pX2FHKKvClPIdovXV59ABCYHI2utHX6RHPrg7
X-Gm-Gg: AeBDiet0xI+voo7zcfgsFTmTuXqpQ+b517QKxOl36yM+AKmPMV/irGC1QbScyX4nJQG
 leEjFQofFmXFFIfPseAj2e9opVnz1WdokJdZggWsdnFNsDYpllbxGhK60pUxd1eqdE/qYI8KmYf
 Zkw/xfXBVktBsnX0nKUxwqPLAb3ub94frz4aevl1OJDJwAcrFL3nT518a2hMcewm2iT1ylz9FEx
 RupxDNYTZ5kcva2i++dIjT3PW4PUyjh8U5QkraeomERzppOgUCenvzD82Q5zIl/y6vr42Sgd1yO
 cN2RSA==
X-Received: by 2002:a17:903:acf:b0:2b2:497e:3f6d with SMTP id
 d9443c01a7336-2b2d5940e59mr77341005ad.8.1775925683584; Sat, 11 Apr 2026
 09:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260407063453.18679-1-gregor.herburger@linutronix.de>
 <20260407063453.18679-2-gregor.herburger@linutronix.de>
In-Reply-To: <20260407063453.18679-2-gregor.herburger@linutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 10:41:00 -0600
X-Gm-Features: AQROBzDhsMLs3wPv77_t8b63TE_MXNObMvbxDToC3oigDUuKoFtbzsUZQ5lHYQk
Message-ID: <CAFLszTgOx73JFqH9+ES4w6oVP=DeM81QJFqQP9dR4_g4eOm15w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cli: flush stdin before enabling cli
To: gregor.herburger@linutronix.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
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

Hi Gregor,

On 2026-04-07T06:33:10, Gregor Herburger <gregor.herburger@linutronix.de> wrote:
> cli: flush stdin before enabling cli
>
> Currently there is no possibility to flush stdin after autocommands are
> executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
> serial, it could happen that junk characters sit in the fifo and appear
> on the cli.
>
> Add a option to clear stdin before starting the CLI.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
>
> cmd/Kconfig  | 8 ++++++++
>  common/cli.c | 4 ++++
>  2 files changed, 12 insertions(+)

> diff --git a/cmd/Kconfig b/cmd/Kconfig
> @@ -47,6 +47,14 @@ config HUSH_SELECTABLE
> +config CMDLINE_FLUSH_STDIN
> +     bool "Enable flushing input before starting cli"
> +         When this option is enabled the stdin buffer will be flushed before
> +         starting the CLI. This is useful when stdin is changed during boot
> +         (e.g. from nulldev to serial) and junk characters may be pending
> +         in the buffer.

Thanks for expanding the help text!

Reviewed-by: Simon Glass <sjg@chromium.org>
