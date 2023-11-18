Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA61C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2151874EC;
	Sat, 18 Nov 2023 18:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SNdXIAtX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E9C874A5; Sat, 18 Nov 2023 18:11:57 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A4186D11
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-daead9cde1eso2833245276.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+oZ9X1Muiy571IrY33ehp9c9cPLllmdt61z0tW2YjSw=;
 b=SNdXIAtXqFa5OrKJPI9l9aiCGOIcBUB75WV9vYqORM9vV1ZqVLJ4dB45Zgnq1qDdi4
 YAY38ESl6hbgwMyuCnEEEeTJ7QYNyWoBjSXJxp0kOxHbhghUUtbCvzXZAuLaRlvxHWal
 Gkv9MaP3t40qlaK0AWZTXLBIsmmvKzH4KoKRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+oZ9X1Muiy571IrY33ehp9c9cPLllmdt61z0tW2YjSw=;
 b=IAh0q+yLx1NUiRE6dvMJ06RTyAs1wrtCNEewErvlUQFFjXtBEhWcM/RjJjJ3Zb2h9r
 wLYpDeGxhW1MdJW3Bh6v7jqRN7PMd8vRELFoOVF827msmrMVpOW4pq7CTQDmIE9q9vkF
 QEY9q+jsvzQldByCMLmIZpOVxMIlzfBBsQgUs9Hs9tM9eSR9hLIMOJnF9vp/o7TLgt1H
 W6FZrFC4o5GlspQ4G/ZScWB7v0zIF5oW1kbkSmU8RYo4fTY3PivvBizctE9R8GQgPUpY
 RbBDWG/AsP281GdU1izriLr7eiwUN/X3AS3YQ3/M8zCWLaHKvSaPYD+ZXZDnL6rk8HAD
 fXgw==
X-Gm-Message-State: AOJu0YzD7mYRgcEnh1yrepnLseum5hQ1CL3o/kfh9wSWSbB2UxvDCkgB
 qqhz/YISO7V1L73G7fzA0rBKr+uGLV1AxIQ79n3+8A==
X-Google-Smtp-Source: AGHT+IF9zqJp8Dc6q4bKuKzsO7+4vhxsL6bzoCZH72TcR0wx6Oajf1mTpGGzMDzTYid61iU9Cb8rsAu6EYLueceILbA=
X-Received: by 2002:a25:3618:0:b0:da0:3b6c:fc22 with SMTP id
 d24-20020a253618000000b00da03b6cfc22mr2030930yba.31.1700327504836; Sat, 18
 Nov 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231116092928.21633-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231116092928.21633-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:13 -0700
Message-ID: <CAPnjgZ27mmK9BYE=rbGKGe9=xvZdG9reU659n-0D_wRfNemX5Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: create memory reservations in ACPI case
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 16 Nov 2023 at 02:29, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> ACPI tables cannot convey memory reservations for least ARM and RISC-V.
> x86 uses the BIOS E820 table for this purpose. We cannot simply ignore the
> device-tree when booting via ACPI.

Why is that? I had thought that we had to use one or the other. Isn't
the devicetree irrelevant when booting with ACPI, so we can just drop
it?

> We have to assign EfiReservedMemory
> according to the prior stage device-tree ($fdtaddr) or as fallback the
> control device-tree ($fdtcontroladdr).
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/bootefi.c           | 25 ++++++++++---------------
>  lib/efi_loader/Makefile |  2 --
>  2 files changed, 10 insertions(+), 17 deletions(-)
>

The code looks fine, but I would like to better understand why this is needed.

Regards,
Simon
