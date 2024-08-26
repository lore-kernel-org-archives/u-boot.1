Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8FAC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AC68847B;
	Mon, 26 Aug 2024 12:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YJv1yHid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C31D987873; Mon, 26 Aug 2024 12:21:36 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D6E8855C
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so1506419a12.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724667693; x=1725272493; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kJZtGWlCD4HXTKQxkNBmfy/EO+Cg0KT6+RLQJazLuwE=;
 b=YJv1yHidfHSo9OeCEkfdgZAvpmMTpC71igBXKxlt3IeS/BkiDpGcNOcIdjODO9e9PC
 ZfTjurRM1WHxKMkA5ikv6K99niHFNURNCDJjbdrzhZgzvOqt8aeaBVDynjBG/IydhUzx
 tKAuGN5+vM8QfQGR1wgT3RPAsnGBdbgtSoUsk8QD20z2fV7tsURnacyn3BhpZZ7hRLqx
 D4rSHxOjyftYq1U/fLIcx3x3hs98MHnYGX0/+eoQu6BoYU9kTzgZyVymGnAz+iPIN5SW
 9quYko3fg/byQjqydslcd+WKT5HbjhMmyRRohzR7bE771A4YciM4jjul93zXy5FJH6+4
 458w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724667693; x=1725272493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJZtGWlCD4HXTKQxkNBmfy/EO+Cg0KT6+RLQJazLuwE=;
 b=FPkdP6VMNYHGbdhzOYPLEEvF2Hzzeu8xnqqTQ6h7V3Qw8Oy/0DJ+tMHoK79ai3XekG
 kuYabhEKjeAlzaX96c4UoowjdmaoYtTyX92nBrwieGUDgQMjt7P/DTfhG5Z2fMPeZ2+w
 ZAI47skmyxTUEptyrbV0oMSioaQYS9y0gyM4H7KgklQvpxT+HHqtFx6F17/Dw54Z5xcH
 H2asXZEn6seczYmkq7Q2CgBuvYVrhyOI9ZWBlTKGlpPt/5P7cwgxQxmog5dlL/AGNkG8
 fzdzXs4VNTzj+7Iao6l/aA7kLx8hrIwVzc20TWnxoS2IXVxBvdKh9FhZAKSseZ+DLJVF
 SiIw==
X-Gm-Message-State: AOJu0YxkPQWCOoU6zNIRqk1M6sGTt0+Aw1fbTCTv3e7YyrDH+kskT5r1
 qDRyX8AbRiiu6vgyDyMUTo8SbeoSsIAZx8EouxUYRRlS1/uNh1kmi+mbHjJA+c/WmATx9WgYygV
 IDanjNFp7okvFYdC8GgBLNgls0stdGRb7+PWUGrJ7U43abQy6WPs=
X-Google-Smtp-Source: AGHT+IGiY0Uyb4yx1kMscaNjm+4nWxZ5N+kcZJ29isxJszLlwoSYyjnbagu12onfyh71fNP3I/b6RkBbzHtm2qrfrmw=
X-Received: by 2002:a17:90a:8c8a:b0:2cb:50b8:e59d with SMTP id
 98e67ed59e1d1-2d60a936245mr22329699a91.12.1724667692938; Mon, 26 Aug 2024
 03:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-3-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 13:20:56 +0300
Message-ID: <CAC_iWjKR5bScE_Vi8+e_dgsTs26-08Ce=apperOHWA4f9oYgoQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] efi_loader: Put back copyright message
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon

On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
>
> This was lost in a later commit, so add it back.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: dd860b90ff4 ("efi_loader: print boot device and file path in")

I think we should drop the Fixes tag, but in any case
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>
> (no changes since v1)
>
>  lib/efi_loader/helloworld.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index bd72822c0b7..586177de0c8 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -2,6 +2,9 @@
>  /*
>   * Hello world EFI application
>   *
> + * Copyright (c) 2016 Google, Inc
> + * Written by Simon Glass <sjg@chromium.org>
> + *
>   * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
>   *
>   * This test program is used to test the invocation of an EFI application.
> --
> 2.34.1
>
