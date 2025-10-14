Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA499CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 23:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B25880107;
	Wed, 15 Oct 2025 01:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z/7frbFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BCFF807B1; Wed, 15 Oct 2025 01:59:07 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00397800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 01:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-43f5ec02724so1289914b6e.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760486344; x=1761091144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNXXMMpxDFJtSbc0RO45qqHIotA7DYKG8IXqVfosQ3g=;
 b=Z/7frbFTEgHTlznnLB5NYBptV3KawNlgiDoz+uNEyZFZud7J8aROu8rr9xQs4xh8Ex
 1OoWVe5N/FMAq5C5RBoPnvGOsb1rHH5Umog7JCIu75YljN2SkzPjhCskAAUm7XJKT4Wk
 7MxAuHttX2D5bOtcaQ4qvkgnGyJ67Yb0d5KUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760486344; x=1761091144;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNXXMMpxDFJtSbc0RO45qqHIotA7DYKG8IXqVfosQ3g=;
 b=d+CjjUQKcc70T1YcN6I7jZ1bnwMmOofyFPAiA3HF75usCZLTBxGr9pKi8mG6PekLFu
 e/LVWAUiGMLBQuFM1O60lqox/Vt6xoah0hWFSknQbIhMJFkTn4JEwdUw4iBIpCDRZhz8
 JDgbn+f2aK3EJwOpITqqP2Osvm1Kwm6A8gRuaOeLNKZO+8zxY8LLwqvUL6y1ce4EexS9
 wvn64ofJjX1XTy3pPqR3izEJ1x1dBAaAViZ9z+eoF8tDOq8kcUCOeiYhaMvglK9BLQHM
 WRpNHGwXahaIJIv7m2turnBbBUvsg7RfS6+1977cg2Vxu2bMBmrcf4+uX77Na1g8dwVk
 VZ9A==
X-Gm-Message-State: AOJu0YwtBPj/uNgiKEHC21JCcEtIPbhogywhjO0Rpa9/WdPuKAzSRPje
 btY/wH/9N9qCNdEnokntZFRzpzK5gKzPz24E94l7cYVmcIRbFJkkwLPxtcc+seyJPDc=
X-Gm-Gg: ASbGncsWAAYyB73RzKOb6IUgmDK09CW0yiY4iYNrn/JeHZDpCNilC1l+mp/wu5FR51j
 cbJSUHU6NcRuFVoK0A9SvELJd6EISDnHCtoaAon1O98QPa+Czxwk1DDkw6MAG8uxFe7eG/x4H5Z
 Z/2v5/Jh5YaQk+XCeM8u0BnQW9YD6WLlronVJc0FPiFrtW2PoYOHypWKscMWQHiX/1Nrao99zVo
 lMqKGChHYIQrGflIkGaAvvz3z3FRvjciqd2QEOHDLuxef0biPGf1++WnxnQk/elvljLCnjxePwB
 3JQJeNN4/uv39gcDUE9DtkUHzSIkZL4H4KBo0e9JrzCkZlo6upJM2uGIchApLtT9/F3fa4Unq9b
 fxZfDWYNs2PE2BiFF3eNukrY2VmROYWB4XyBVuIWon1QSxW//lrmEwm5NrefoOAGONCGT0Xvt9h
 JLwvdTXwkSDg+sUg==
X-Google-Smtp-Source: AGHT+IGSGTjd/iKmIwlBQ8JuxHslR2kpKeGBS9Y2UW5NCo0jzXhjcZ+EGpWp+Gh1/XV925r0b5S/Qw==
X-Received: by 2002:a05:6808:5286:b0:441:8f74:e86 with SMTP id
 5614622812f47-4418f741af5mr9713311b6e.64.1760486343705; 
 Tue, 14 Oct 2025 16:59:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419893b4dcsm3617870b6e.16.2025.10.14.16.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 16:59:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Moritz Fischer <moritzf@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20251012064412.2892979-1-sjg@chromium.org>
References: <20251012064412.2892979-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH v5 0/4] boot: Precursor series for global
 bootmeths
Message-Id: <176048634189.565337.16709740738268545957.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 17:59:01 -0600
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

On Sun, 12 Oct 2025 00:43:52 -0600, Simon Glass wrote:

> This series contains a few patches pulled out from the global-bootmeth
> series. No functional change is intended.
> 
> I left out this one:
> 
>    boot: Move showing of bootflows out of the command
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] boot: Improve comments related to global bootmeths
      commit: f6cd0a36cee32e89449f71ce495dc8f4cd175ad8
[4/4] boot: Move preparing bootdev into a function
      commit: 996ded5463fd48497b6aa904a5647c2533d73ab3
-- 
Tom


