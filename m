Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73680CF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5775889231;
	Thu, 19 Sep 2024 16:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X1jeYWmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236CE891F7; Thu, 19 Sep 2024 16:12:14 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F7589229
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d88690837eso842420a91.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755130; x=1727359930; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dj331A630Qr+hMwO8MMoADRiJH76fH4VSfzmBoZOz1U=;
 b=X1jeYWmvGG4iXfb37YaMdhafhIarwWAsUHaOxYKg2pmV7UzipjtOeayLEXNIAxT1Rt
 EUYjbqjUCC+3b0in7wM2za8T4DnbpCIYXouPhE7zBDWAGpR6GvDyDKS56EQHqTOF1l10
 2lxxBSWynDUuGZE/nMXkPXMkWb55ZQXaf8jvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755130; x=1727359930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dj331A630Qr+hMwO8MMoADRiJH76fH4VSfzmBoZOz1U=;
 b=eb3lx/uDvS/xm7J1lsInQzjEP1YdDOAey6QMd8Z/zTo0Hw/4hX3+N1wZ2XGvshcZMc
 gr8xoFt/IFqH5T+qpjv7rs94znjwJP81IB5sgLAOMWUbSZBEggR+nmo+mqbzporf1WI9
 Yjkv1m1u4IvKm6r/V5jOqYonXWrqiXzPte/RERgbyrnftL7n+jrsqgS43/0izQN6Os99
 dMrwKf9uZoQ0sBHP8l1GVw5ooF2/A3xuUCpkaGKo28ezjeeDYBuppNQwSfJ9NubEL9mv
 7LhSFFhNM9WK1SVAoxnV4YRktCBVFUQ/3vSKz8MuJyokxp8ZWsAEYdyJmYdO1IDknO1j
 oY5A==
X-Gm-Message-State: AOJu0Yw+xjLWvNVx+7bQDPJaO/ZH3ROxRZxGb8h4TJ2HQYEW/bRpZ+ta
 3zvm8bwL+YddcTVwJHpyZMMXN4L1d99WOfCZKZVtyKtTz2bOZe/qhdgasF0FgPi9a1uEfy0KApb
 hHCK+xfe8mg624zJN9XB6m1h4bt6GpMgnW9di
X-Google-Smtp-Source: AGHT+IHxxjQd5XtJtShA+a8yV4Dr2L23Zz4GN9d/1lvow2mROHaZjevSCvSj+bpBPt1oOmNon4R8jLmGsQneKpVKwPg=
X-Received: by 2002:a17:90b:524c:b0:2da:5edd:c165 with SMTP id
 98e67ed59e1d1-2dba0060fb3mr28308439a91.30.1726755130568; Thu, 19 Sep 2024
 07:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-9-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-9-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:47 +0200
Message-ID: <CAFLszTjsWGBv-apAn-sRQGDqc1t3ii+YCwEH6NToZGz-vif4dA@mail.gmail.com>
Subject: Re: [PATCH v4 08/35] acpi: Add fill_madt to acpi_ops
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a new method to acpi_ops to let drivers fill out ACPI MADT.
> The code is unused for now until drivers implement the new ops.
>
> TEST: Booted on QEMU sbsa using driver model generated MADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> Changelog v4:
> - Drop __weak attribute and make driver model mandatory on Arm
>
> ---
>  arch/arm/lib/acpi_table.c | 13 ++++++++++++
>  drivers/core/acpi.c       | 16 +++++++++++++++
>  include/dm/acpi.h         | 26 +++++++++++++++++++++++
>  lib/acpi/acpi_table.c     |  2 +-
>  test/dm/acpi.c            | 43 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 99 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
