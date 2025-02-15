Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7B3C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 21:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F154980F32;
	Sat, 15 Feb 2025 22:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RViXw7tV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC8980EFB; Sat, 15 Feb 2025 22:29:01 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3366180141
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 22:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220ec47991aso26313155ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739654938; x=1740259738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gg1+5QKfScKLbk2t/s0l/CT3CxJTO6WLliuxjGHDRy4=;
 b=RViXw7tVdnwunSY0p8EKLWZ3el5HCOTKw5roigEhlP5OXVYeawrS/Bs9t/fKSbjqnK
 /RpgeePM6voXGidx5QK/eMfC318mouskuiO94N2IJfg+/3Xtpj9UNogJQnYAE2+VNU0C
 ma/6F5JPSHN/rWm+0BPCjVWJ363bnESQ8ots4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739654938; x=1740259738;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gg1+5QKfScKLbk2t/s0l/CT3CxJTO6WLliuxjGHDRy4=;
 b=N6x2VGfOzXUhR0LJssYVnR7NwAeLfx1gTWlBWYPrKNEbPJVhPcN6KTrrKgmVkitT9V
 jSK0Y/gndcjQxO2VoY042PX1rc8tFBLt2Cte+eysbHHwf5bde6laFK71CuyGQXBPzV4Y
 KK953rCM0QvLpI0iA7wx8ayT4CehN6jfJ4woaduO6yyv8tI8jVvDRFEeLml56oiLdVR5
 VPvbYNBbRxgLS8l2o7xZiG+texJvvwJJ7ZDGCaAal+wv71OiFJAUy47j1+6hoKCre/cK
 3fxAtmvB9xu+HrgadOlBy1sXtnW5d3L1/rDialfJKysiD8emV6RGnv3zx8qFGlGpgPV8
 nLqw==
X-Gm-Message-State: AOJu0YzTm+B65gLEDQ5kG/taOJ6twd/GomIt1jA+ziZiloDwPO/hKbXL
 bzELrDHbisyLNbbLRcwTn79no9HGFkb8xn6moP71yOA8eR/4jI0FJ3sQ3ADq96U=
X-Gm-Gg: ASbGncsx4klPuV6YtGbHzpDituqVI0mSlbK2l2BqU5TsDrGTuGfZ74fv5ufCR0WKK4G
 hXxkCq/1iSIOPRqoH5MqKqTlPGyqvVtmnAfCHMcAByLX00fZoutI8mtk+E7oCBdsYmqeLT9XwGz
 gnEvq7m84e1kwzvPEFCSXAy2BBSrH3iClGueiF3p8eHbhm/ytYKQ1Og0Esby141DnpzISX8CDud
 ncppQ6pFUXIZUa6NfxBm8tHORuPaLATGU3jUyhxEg50EPsBGPQHkB0CIqgLzqySVPPA5rF7AYre
 C+D1pieMmmQd
X-Google-Smtp-Source: AGHT+IGRxsZrueK6Xt45OFhUeTBZd0DYYMX1wGNG5GsZr957A7Q5fBp/0ryBG0nhNZTP3HASlgaPng==
X-Received: by 2002:a05:6a21:6b05:b0:1ee:5f3f:cde0 with SMTP id
 adf61e73a8af0-1ee8cbf7bcamr8834784637.34.1739654937770; 
 Sat, 15 Feb 2025 13:28:57 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732521b82b3sm3532985b3a.92.2025.02.15.13.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 13:28:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Dominik Wernberger <dominik.wernberger@gmx.de>, 
 Software Engineering <wd@denx.de>
In-Reply-To: <20250131013843.3844148-1-kikuchan98@gmail.com>
References: <20250131013843.3844148-1-kikuchan98@gmail.com>
Subject: Re: [PATCH v2 0/1] spi: soft_spi: Add support for SPI_3WIRE
Message-Id: <173965493579.125355.9840994436285630685.b4-ty@konsulko.com>
Date: Sat, 15 Feb 2025 15:28:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 31 Jan 2025 10:38:40 +0900, Hironori KIKUCHI wrote:

> Add support for SPI_3WIRE on soft_spi driver.
> 
> v2:
> 	- Remove the wrong patch
> 	- Add `GPIOD_PULL_UP` to prevent the bus from floating
> 
> Hironori KIKUCHI (1):
>   spi: soft_spi: Add support for SPI_3WIRE
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


