Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7441C282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 12:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042198175D;
	Thu, 13 Mar 2025 13:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kjl1sHfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9743580540; Thu, 13 Mar 2025 13:52:00 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8BFF80F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab771575040so380639466b.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741870315; x=1742475115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+GP7JZTEB5+GYxlqfXf9ZuDs261q8bctM/+sZVGknVU=;
 b=Kjl1sHfMAbWQQbMhE7Xeu/SRqTAkNGG+imvUktQ2xduqj0adVngiD/3GXdzt7P6XEq
 YEGCTK435jQvz8wPKjmgdOXhnkIFUz1jj8if/45oLq2qwBGuGG8PTtYZUTCnxWova6hN
 hhE2z2CileVIB1RQ06iDvaekBd6la5c714hEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741870315; x=1742475115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+GP7JZTEB5+GYxlqfXf9ZuDs261q8bctM/+sZVGknVU=;
 b=A7lopPKCsONZAOHLFP8LypL8lVRITIrR9s93B90n24AUb1K1VJhb+ZIAEAAFzxM5sK
 M3HDXbJ2NkgZtDPmgAooR/NA/uOfsyezfYFnoTq4Z8wYh2jlzurSBZlnOP5AYHmfFYk9
 NGWk7zMj41XBsyWptqj+FTXAncRmQJKw5r9TtPOFFa0h4wW2ZAN+PnxSybRGhts+14QT
 gHbIvfbkXwnhpXx5dIMrdp5RoT5hrYHpnnhhbkMXHMKUONeKU4I3ma079KdQ0aB2SEpm
 E6iZAgxmz79+NmvPyN6jCknY0KexPy+kf1SUnkoUqXK3cDMO49Zwt/d3np20xodnLh75
 fDOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeA2TsxbB0RB/juSLKUpaGgn+5zeiSGIeixHQjYCTkjyFtYJPk916qHWnadAsfkta/NMMDEeg=@lists.denx.de
X-Gm-Message-State: AOJu0YyZpw1BRkm8E17t5d44zwE2PlYONlr6CH8zFgpnb5vDj6JRC+Aj
 doQGzP78jfmtsEZGmMGgUWmC+Lx0OjdGhDq+izS/J1m6KmYm+Yqnw/oq0RAI8kcaMC3JbyhLUvH
 w1vhc1gTvoWDekQGlZ+Vrd8nW5/MwUawNL6xX
X-Gm-Gg: ASbGncu00atO0fAGboQ+/gGoFyeALGnVIXDXyamoYHuYe+tvbLVLBYWMprvfxp+g/UI
 MOFblgIeaAjPPPO7hZhCf/AK2MXhP1ARg6nBhGy4krWrKkY5ppsTIQfPPpaIz4sgw3G600sff8a
 rzg6ly83URmzz5Eu9aJxh25gFU0ydV
X-Google-Smtp-Source: AGHT+IGJLHTsfIsN6ag5V8PyBtxnzrtPaTNyokGtVcUBAmah/mSbxqMIV+nVJwxpxu20Pkg0YJs+1IxGY5PBz+XY19w=
X-Received: by 2002:a17:907:cb1b:b0:abf:68b5:f78b with SMTP id
 a640c23a62f3a-ac3123e1adamr199828966b.24.1741870314650; Thu, 13 Mar 2025
 05:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250308155127.27893-1-clamor95@gmail.com>
 <20250308155127.27893-2-clamor95@gmail.com>
In-Reply-To: <20250308155127.27893-2-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Mar 2025 12:51:41 +0000
X-Gm-Features: AQ5f1JrPOQCFwBwzJ0PxcYrOrSEXNva-2utheo3epu6kRq11FdZaNqksSfiacIo
Message-ID: <CAFLszTif3hES=EOa7vYxx5zrmkte-YgvtjA0mjYNZC3YxP9ePw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sandbox: remap memory load addresses
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sat, 8 Mar 2025 at 15:52, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> The existing memory layout places the bloblist at 0xb000 and the fdt at
> 0x100, resulting in a 0xaf00 size constraint for the fdt. This constraint
> has been reached. Lets modify the layout by moving the bloblist to 0x100,
> device tree to 0x1000 and placing early memory allocation after pre-console
> buffer at 0xf4000. This should guarantee sufficient memory allocation for
> future expansion.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/sandbox/Kconfig         | 2 +-
>  common/Kconfig               | 2 +-
>  doc/arch/sandbox/sandbox.rst | 6 +++---
>  include/configs/sandbox.h    | 2 +-
>  test/lib/kconfig.c           | 8 ++++----
>  5 files changed, 10 insertions(+), 10 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
