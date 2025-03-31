Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0D2C36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 07:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 357B2812BC;
	Mon, 31 Mar 2025 09:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KA89AavZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E538144A; Mon, 31 Mar 2025 09:54:39 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24D58129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso3974593f8f.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743407677; x=1744012477;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CEboYt2lYaUV9zXm4N1B2pF3Qz1HPcMrKq4NPNiG+a8=;
 b=KA89AavZ3cQMXiwjB8s6RHvAWgEZrqC6gD83IX9QMOzgwziEYlCK2CgxMjzenONWkQ
 q04PIo1KOHOl6mfDUyQEcnRTuUg+6teRhacsYnKtwXjDUSxyLArg0fb7hw/GN+Yy2+bH
 QEFOAl5p2L1h/TcRrbzZQYHcdTaHJjkgbfs5oFTWldcitCJpCtvyBillSvnhFucAXYX4
 33gEc+m44defT26Yvm4NjR6aprwZYQm20HqN+O3UMHvtlJQAkQbAyxGI7Kwy2pNPlBX3
 L38ZVTV3bLquG8vx6pG8sCLwH8/4wjGa/HwIZO4uM+hEUb6Plf3TBd+ygixjrxgUcqRp
 7Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743407677; x=1744012477;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CEboYt2lYaUV9zXm4N1B2pF3Qz1HPcMrKq4NPNiG+a8=;
 b=AFBblJAQvcj0jLKWgXb1UxiMmMtndJKqWBW+D5zqNdzKwiQBQBvJ6Gg0cbdOBCkNQz
 mr9iU4OlvH8BbbExo0+brPFsuBbsmh2lhWLOHR5qqzhFRMhV7LggnopPnSHUp04obXCD
 O8irPV9tou0cF4oJpy5PeXhZ5h1uTOpobzwPMWb3NRmAzBP8Xn+gY0RRVsXNTZ4uwtsy
 GbZ3lHCjpir+0WOE3vuRzYAXEGdon3ZKwt/PZgVFLQaxQ6rrwpmAqws7KaekOLmhCOO+
 VHgkIV5j3s3MdnqyAmskNWsNqRwsUhMvwKXtP49AJ50OOQjUU2Z2NExVBRMXNdVm+aIE
 cOSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvrxxawUGdVBI9V+LsOkn1ANi+GVYqEtDQgceV8DKW11CbdPyGJNhVVVuaXUV2lExJKNlvspY=@lists.denx.de
X-Gm-Message-State: AOJu0YxMMOiy75AnDyyzWWfuJ4hWh4yo8y6jof1fEb04Yfs0JnR0JAbj
 XDdi3ZwPdxcwQJx2aUBbDdsMIEJu0HCRNuz2+rB9+y+hSO+s0qCyykBPXHcHN6IXtQFxE/It2KB
 7
X-Gm-Gg: ASbGnctPyIPd7NWxsqAR+QdCyUFT96MijCDhD/5ZB4FTlWXIiL7EC1AxtEoSUutgoco
 HhkfZ4vJBlbwzeTo4FuiLwrYo/dBbQQfWRf13jQ4HjJyjr03gWawUOmXeY9mrFYWLEqaWX9kLSn
 zmo9MOvYNhSgXMzDHIaSZa27IbiS+UiSdNr85wp4Z/GOVDfYf3LETO3LBpI4kEkU1bVhqSw7VgB
 8cTonGDIozT/KLjvF3JNR6W2FYcly7M9AK2N7Kl9BKiitjw3nP9jVLR8a7gnHWOnB7dxXk9Z+P/
 F2YLjUKtxKj06bL1/gPLfSkazhTSEOgVB0D/PAbHjKqhos9PRWb8WW0tpp8Zor27elL7qXt+Zeu
 XdNx+ts+JSLqURyMASCu3Paqjn4LD
X-Google-Smtp-Source: AGHT+IG3cxQROrtKF1+z5esPF753YToEJ480p7lXMNrXFvVwC2tNkaXVjZ9Vna4NOZrWYKdrSjvBJA==
X-Received: by 2002:a05:6000:2a5:b0:390:e8e4:7e3e with SMTP id
 ffacd0b85a97d-39c120ccb86mr6021776f8f.6.1743407677166; 
 Mon, 31 Mar 2025 00:54:37 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b5dsm10442911f8f.3.2025.03.31.00.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 00:54:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>, Michal Simek <michal.simek@amd.com>, Caleb
 Connolly <caleb.connolly@linaro.org>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v4 12/14] cmd: add spawn and wait commands
In-Reply-To: <20250318104659.1114340-13-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-13-jerome.forissier@linaro.org>
Date: Mon, 31 Mar 2025 09:54:35 +0200
Message-ID: <87msd1prd0.fsf@baylibre.com>
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

Hi Jerome,

Thank you for the patch.

On mar., mars 18, 2025 at 11:46, Jerome Forissier <jerome.forissier@linaro.org> wrote:

[...]

>  
>  obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
>  
> +obj-$(CONFIG_CMD_SPAWN) += spawn.o
> +
>  obj-$(CONFIG_ARM) += arm/
>  obj-$(CONFIG_RISCV) += riscv/
>  obj-$(CONFIG_SANDBOX) += sandbox/
> diff --git a/cmd/spawn.c b/cmd/spawn.c
> new file mode 100644
> index 00000000000..f7a9f225f93
> --- /dev/null
> +++ b/cmd/spawn.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2011 The Chromium OS Authors.
> + */

Nitpick: Is this the correct copyright? For the test code in the next
patch you used

  * Copyright 2025, Linaro Ltd.

Besides that:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

[...]

> +
