Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24721C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A3D885F5;
	Mon, 10 Jun 2024 17:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MPqdvEJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE93D87DB0; Mon, 10 Jun 2024 17:03:20 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C755D8822D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c2eb5b1917so16570a91.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031797; x=1718636597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NhUSVTiNkmYgeAexsVAPmhtCB3brq/aGJ+ePkSko8J4=;
 b=MPqdvEJrUznBPZWqgRGKPzFI7Y6sEmluyJ9/EgI3ngalNkY5ig+DPi+Yvbux3eoQfe
 T9l7UMZAcgwJgK/RWZiyzbh/VNXqHXojJcUg9eYFr2OyBi+tjtHTGTrzLIhtFmp1VjZJ
 SyCtn3PR+RIs9BA/6DR8220pU2Bc6x+OOeQ/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031797; x=1718636597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhUSVTiNkmYgeAexsVAPmhtCB3brq/aGJ+ePkSko8J4=;
 b=OotShEqF3Yi5wWByZ9gt+qNw3UhLWTLN1K06gMNsYB/HtKGEIhCGeWfnlQFS5XquLS
 UZw5dCUKO/taKKa5Ld9Dxw7rrdA2rgPOppGijGYszXQze335njb0fVOlq5B6GZbI1a1/
 NHux/ocIKtqNuAE6t9xZjoUXLwxB3jejhn4hbcHoNY7wekGtRAP7/VM0nNLhRJu5tEgv
 RnwGgwMLt+NFWP5DHKJRZ3IIgYtsedLHWNuOy9APA8wakUvaJZdofoMZuAmXyGSXRqJ2
 cZ7QwlhUJWnT0+jI5j+RtAvJdEfSHZPi7OkJGawNTSPrRHftcgvZCXItLaKtC91AMjOJ
 XLCg==
X-Gm-Message-State: AOJu0YwWZfjqFRiqA9uGyprv9TqUlmkvEcIiB5VFFbw+1B+AQ2OpKb1J
 zkNTG83xZ39izWCX3ykPvhuhISwYPryKQRFqNGt855bVuW/h1LXWdopblIXaC5ASefLRg+gkPhz
 xPss+V3zFUZHyinBSkNjHStfCxsdDdki+YEMnZyO8tSA0zZI=
X-Google-Smtp-Source: AGHT+IH3OdynKp721roPWoRx2HsVYCtwh2+gUVMCxCZzbjr7jnCvlDCdGoQ8JagElDShRmJfrFAthZsNgZ7CVhi7NOo=
X-Received: by 2002:a17:90b:4f8c:b0:2c3:195d:8cc1 with SMTP id
 98e67ed59e1d1-2c3195d8deamr1344064a91.37.1718031797309; Mon, 10 Jun 2024
 08:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1714138688.git.michal.simek@amd.com>
 <4e7e75bae7104bfca3964f7a442cac9f084a1f5b.1714138688.git.michal.simek@amd.com>
In-Reply-To: <4e7e75bae7104bfca3964f7a442cac9f084a1f5b.1714138688.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:03:03 -0600
Message-ID: <CAFLszTh+JDDHFUZiWX9_NDY_jLngqw14QLsn+8O8nt77Ok-8ng@mail.gmail.com>
Subject: Re: [PATCH 2/3] lib: smbios: Let detect the system via sysinfo
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Fri, 26 Apr 2024 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>
> Currently code looks like that it sysinfo drivers are supported but
> actually none checking that system is detected. That's why call
> sysinfo_detect() to make sure that priv->detected in sysinfo uclass is
> setup hence information from driver can be passed to smbios.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  lib/smbios.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
