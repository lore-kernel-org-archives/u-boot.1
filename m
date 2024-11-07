Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18153D4335D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5CA889282;
	Thu,  7 Nov 2024 14:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MCZlEjO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4034892DA; Thu,  7 Nov 2024 14:45:43 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90329892B5
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2dcf4b153so744975a91.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 05:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730987139; x=1731591939; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WxX15PlEeBoSIYH5ap3A1YeDrDoM1QNY5eIKQt6Xkew=;
 b=MCZlEjO++oEqAGOHHkH00rM2gyOBiAvEKxjVabuJuU5ng43VMDuICtzYHePQ6ZlIfR
 D08CXGTZALAWqTgo7/lm77mQTS2gyXNBCSp7qRLnVmngXEQMhRznojQ5kqa5CfdRgLSX
 u0AXCiRkTVvSvaUCPBIVeZmU5Z1hyA5x/rhQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987139; x=1731591939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WxX15PlEeBoSIYH5ap3A1YeDrDoM1QNY5eIKQt6Xkew=;
 b=laHxW2OAE20t2tCHx9rISa1x5mWgnaojGc1NYfk/SdfdvyWgcYRNNUiIyXnQuIPpr9
 imx00nUkc96G3HCgU+tqDKMwHlIXnHtB8M8csXkFRMlJlXuPRa6gLLDZO8g/jyMLjA9D
 +6rNzSH2ZBUzG9QM0lRyf7h12nA1LxXhNRH5E4N/1qbm6r00qnKKBEa01+in1ek7+6Wf
 STDz7ZzIAXySViOakTxRXQJa/c3S6xp5XiSN1f9YnoSUvKOief4Boh8S5wHstcwedyTY
 A4EsU07h7e2q4PyVYVBa0JDKyG7/WVLA1D1oQtfDRglORt1Ffq/CYz4WzmSDFyWuraib
 y0rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZRIM3iRiaRYswvdrJ2/J0euXnWAD4rfItaKwECpRx8+Px60ADIxtY0Ev5hQqDZlSEzocM/2U=@lists.denx.de
X-Gm-Message-State: AOJu0YxZdIwCg3Yv6irW54EHkMkyRX+dLDce+pNV2Ws5TjtaRlYNZSDY
 Dl9PhrTJOwG0GPWH1WtDISj4zo0VzYakh3uxWcdQXVh5D3UdZPZvX9Hvj+sobz+JtJYjKTJwTCA
 q/wNJsl7mjAyqA/oeVZ/f9/P2S8lT0mPFjBm0
X-Google-Smtp-Source: AGHT+IECywiV9efhizq5/Jp4fC7f8+/tDRColKJ+m6mDkvlhRby/R09YSGKxwI0IzPie0wc5aKrg4ts4WnA+Rbu9KLI=
X-Received: by 2002:a17:90b:3906:b0:2dd:5e86:8c2f with SMTP id
 98e67ed59e1d1-2e9af9d2b17mr66403a91.21.1730987139124; Thu, 07 Nov 2024
 05:45:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730909884.git.namcao@linutronix.de>
 <eab1fcfd3165975fba61424441615782d9738fb7.1730909884.git.namcao@linutronix.de>
In-Reply-To: <eab1fcfd3165975fba61424441615782d9738fb7.1730909884.git.namcao@linutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Nov 2024 06:44:32 -0700
Message-ID: <CAFLszTg28DUhw24--sVJV+JGxaTi5hXy0x4qg5q+CWTVd3bJtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: Use ARCH_DMA_MINALIGN as default alignment for
 fs_read_alloc()
To: Nam Cao <namcao@linutronix.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>, u-boot@lists.denx.de
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

Hi Nam,

On Wed, 6 Nov 2024 at 09:34, Nam Cao <namcao@linutronix.de> wrote:
>
> The comment above fs_read_alloc() explains:
>
>     @align: Alignment to use for memory allocation (0 for default)
>
> However, in the actual implementation, there is no alignment when @align is
> zero.
>
> This current default is probably fine for most cases. But for some block
> devices which transfer data via DMA, ARCH_DMA_MINALIGN is needed.
>
> Change the default alignment to ARCH_DMA_MINALIGN.
>
> Fixes: de7b5a8a1ac0 ("fs: Create functions to load and allocate a file")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> ---
>  fs/fs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Please update the function comment in fs.h to specify the default value

Regards,
Simon
