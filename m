Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B5C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBD784CBB;
	Mon, 13 Jul 2026 22:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZtGSw7Dp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9CD84CBC; Mon, 13 Jul 2026 22:57:41 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BED84A6B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 22:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba3e6so6312014a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 13:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783976259; cv=none;
 d=google.com; s=arc-20260327;
 b=cohQ2evARpYcwjAMVkRw/02MFZWCvE7meoBt9RSAAQGkVc/0xINx6N3emfZL3/wSZg
 OireCuLKvPjxIV2ekWwDAzGReeNM7Ww/H2QJHqPZyFHutuIWEWg2GX4jrAiCG9hzTwjI
 xcKrY3XNVzc7hg19swtzr2J0uhK8jzmdqLmyHe0bVxHD4HJEarliBaNsO8YVmYzBumJy
 lBByELBXEung+l/5y1nUCv7mik7oiXkVYWXt6PFx8XVW2dQB8KuvGoSeESU+8up+NieD
 o35zHiZMm1our8wRCLVLxMXAL/MgM9TN6Tz+weWKIcSnqLirLAw5w0qWRFN4G/hQkqzp
 vMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5TfKVIneVTYieuSqpF0hXuL15IFY/vMKja6uzJkJVvA=;
 fh=RYRoxNOjuHPJgeepkDgPG4TS1YEj8vlj2h5gDMROLMQ=;
 b=ia2xqDxr0AXpN+e/us8a1z7wn+P9qMasLlzEvW/YU6n/RSHV6Ai5yMwqGEBlt/hDJX
 m6gmf4clqLPUwQRoKITF5AQaA9IPZnUEKLRRrWbG1kfvRX2MdaSDeisFsbSkiFDDexrU
 ZCHwqslJQ2S840jDGWRCdN9y/PgWBCoaeiWEKfbc1zML9jdvZxLsR+qwoktyWZbqZrLE
 hWiKg/+4beNtUrFOx//L0Z2E03X3OwiJ1ymN4m8fVtIfZzKELS42suiovWAKSMRxtegT
 lvP2sDK1SNDOnjdRUPdkBsJisXizlLFWRcs7ZZKqiK930javK6ycF9GbwfQMEbrsEwCi
 DLHg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783976259; x=1784581059; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5TfKVIneVTYieuSqpF0hXuL15IFY/vMKja6uzJkJVvA=;
 b=ZtGSw7DplP5g2skKdq+n4nNK7tixcQ9TUw4OmMouztCqCvBJsIUFCZqcNSn8rafkrT
 EY+0hI1SsBVIn/1JuqYssNHb/dD6ao9xZXtljFtMhGNG2wcDI2bdU83J+DSZV+gr5I/8
 GVkQWOKiE+gD0+5LZsah+piCqify6YkgMqK1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976259; x=1784581059;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5TfKVIneVTYieuSqpF0hXuL15IFY/vMKja6uzJkJVvA=;
 b=RaGe+YOIrItN3CrJEGX7Ko0GJygwbQjEKi78TG1fCLv7pUOdtsd042027V65/1mGnv
 jeG2s9KXF5vNvLT10t8lv0PmISKsE+58gjyVFQdCBvirYP7zXOWekEgXDiIlbprtONna
 KwVackdPT2HocVEwl7Gx9oE8NVEhU0R/YJiOqnKLRdmL+nG8YfgTQPTWpu5v6PwV8FZ4
 LqWGT4gbLfOk6CNAt2TS2gJlixmtpvTTsgDByHOWgdNA7mKHVbtsPnCM6iiYpgYzQU+n
 Ani/CU3qWg08YJXDjPYeKwZR5IWNk5Bs3stI5G8Z5aHCrb854q9pKhPakeyj/sE8dTpt
 lWcA==
X-Gm-Message-State: AOJu0Yxa4Cu01vtLlgytRI5h+FN5SUC/uoSW1On56Hm6wXP5lXoD69zD
 Zmwj6aeJKVEMfyfjd7IukaAfq2jXLu/kt2S9ZOV1L8xIXTxoH9Uzvy8Gt+8StI45ra3FUQiH272
 +qkVjdTHJqszjBOU7GldSPlq5AO6JSZucKt41qM3b
X-Gm-Gg: AfdE7ck0rwr+cY8B+O3lBLFQq/JmLdZ9Pt0a7U7fTCDEpt3Izw1V6Yb4Vfg/hFYz37t
 0QUSoGsy3AdNMdW6X4aDgsIpxNVLiONojpo2NrcDyU7YUGrRA5Odnq2aYNeMkTG2dATjk/POJVd
 6ReX7WqEoQ/wPgCA2jK6Ih80Z2EpZI9EMp79/g8/QxTrFVTTASubT15EjobQr5ZFJ/KXS9o93/N
 xCEESnC9qOm+niVh2MuKpwumESN396toq1PfmR57B7lF5hXuAi4g3qfcUFny3i9e3DNCuQ=
X-Received: by 2002:a05:6402:3208:b0:69a:2ee6:4ca5 with SMTP id
 4fb4d7f45d1cf-69c5f0c77bcmr5063606a12.4.1783976258940; Mon, 13 Jul 2026
 13:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
In-Reply-To: <20260709142901.2054431-1-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 14:57:26 -0600
X-Gm-Features: AUfX_mxdH20dXoSOnBHB-I4MBinWQMFdq9kZUtWo0DMV17EmbQVq3ioig23Ak6c
Message-ID: <CAFLszThNYaMRxxqcZa==hvGt+QiNpNYb+yoy6Dmamysrx6ZT_w@mail.gmail.com>
Subject: Re: [0/3] gpio: improve claim diagnostics and fix gpio-delay offset
 handling
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

> This series improves diagnosability of GPIO offset collisions in the
> uclass layer and fixes two related bugs in the gpio-delay driver that
> were uncovered while debugging such a collision.

Thanks for tracking this down.

One thing is missing, though: tests. The gpio-delay driver has no
sandbox coverage at all, which is presumably why these bugs went
unnoticed. Please can you add a gpio-delay node to the sandbox test
devicetree, wrapping at least two GPIO lines, along with a test in
test/dm/gpio.c that requests both consumers? That would have caught
the offset-propagation bug in patch 3 directly and would also
exercise the bounds check and array sizing from patch 2.

Regards,
Simon
