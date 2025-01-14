Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC906C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76DC80703;
	Tue, 14 Jan 2025 14:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UD8Z4/11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C95F806FE; Tue, 14 Jan 2025 14:14:10 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31164806C6
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so772844966b.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736860448; x=1737465248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V7dpEvbH0p0POYl+mow2vq40eSfdRaxbqQznC1fdHRc=;
 b=UD8Z4/11Y7Tf4vqKdhrYghPbDT3Jo1KufaAQsSF98EGcam3jCuXVIIsmtGfy3mM7/P
 zt9AlvDt5Q5xZjIoVeeqgowg4yfaaZjCVOf+6Y3HURMzmOvOv21d8kVfhTRfEYbXizhZ
 ZGn1A1Mz0Y/ffqyrV16v5iUXRGFvvFxxqVLmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860448; x=1737465248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7dpEvbH0p0POYl+mow2vq40eSfdRaxbqQznC1fdHRc=;
 b=N0/JJnQRqmxUpll2mVHURr8B1bqcSOj1TPHDZRg52wQRh7bZML6ozG5H51wJY1qws3
 45zZt/dXIckFVJay1SSOvcnlVwOAV7VyPIzRuXpnVdp+FqF3lU9Yufo+Nm2U5iVyJwgE
 rNbfjSa1stx7wOQrZDBMvnFJM4/tOZfDDunBU2FSDy54phZzh++orqDmPut2ISi/ExHp
 eKWS29szxLHQyOj5xinfiEMoBJBhn8gNGQNPucwHt9qpu9UH+bLgPS2xrqsEQqhsN3Ck
 ILVyST8zfiTY3j7iC5iIrDs543I6F5Qr2/cYMOWwN5YpFG8lavwDa76yO++y7cCWlP7W
 r6tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFalKKTPccIGkI6j7EvigCjlG2WKll+u4tpPQAgVedanI2c9xEjZAgJle2SQKgS7fdUW0Hxus=@lists.denx.de
X-Gm-Message-State: AOJu0Yxw39FsJikHtZ4CAswyetUhUkU3JCXiUxh6uHR7KQPcmOfIsIf1
 6uKNY+W8xOyTE8hzwxuTbI+c7fOyDXG+PxPsOXg/AqTWzEFLIyVsgTjQa+/DFuOw6+9nJhqKHdE
 xuchDmsM23Kw4pkTr0ZW6F+Yw6a3uzIA5mtWQ
X-Gm-Gg: ASbGncs/msMPQ8yrEUrR1jG7He65pmf2ZtP82GC6Zgt1wONBquTY2nyo5dTD1AS1b4M
 trwzSV8bVprYR0v3hI/vxVTj5KJh4unSp5jC3hOU=
X-Google-Smtp-Source: AGHT+IEGi/X2qTHbt9cpJ3gJonoGm+j3p2se/+Ap2WeHqt2ScZa+xuesYzlWE519kVcpsnoiYbEJ2U+qzjmUFT0zBBU=
X-Received: by 2002:a05:6402:51c9:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d972e0e3a0mr64869002a12.13.1736860447633; Tue, 14 Jan 2025
 05:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
In-Reply-To: <20250112034213.13153-2-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 06:13:56 -0700
X-Gm-Features: AbW1kva6S1UZVn8EQWskfZUEpo8cKd9WnGI9XaHNebD6w-CkAEG1ACVRo3Tp998
Message-ID: <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
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

On Sat, 11 Jan 2025 at 20:42, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Free memory allocated for 'order' (array of bootmeths) on error paths in
> bootmeth_setup_iter_order() function.
>
> Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths separately")
> Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  boot/bootmeth-uclass.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

How about adding a test to check there is no leak? You can see
test/lib/abuf.c for similar tests.
