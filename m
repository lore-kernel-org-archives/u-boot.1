Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05591C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 08:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACAD88984;
	Fri,  5 Jul 2024 10:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J+jtLRc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BB488981; Fri,  5 Jul 2024 10:36:21 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F2D88254
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 10:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b5d42758a7so8362756d6.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 01:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720168578; x=1720773378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sBG1Uy4r4Vn4uurs0Zmo1x7Nzwk9b0RODO+f93TMtxQ=;
 b=J+jtLRc9U4zKTUh9qkKbZ2O6S/3/pss/qonVK+ywy2ThAviFyPE6PPoXMFIdas0ZW1
 xK/EkuciT0U5YK9FfB6hHThPW+NldsOj8KRbaPwZ9g62yGyrqvZj5Ecw5sSVmzXpFULG
 HDmlCoEYqMe5XOHVn9kkNF6IR+ZKoBEzE9MqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168578; x=1720773378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBG1Uy4r4Vn4uurs0Zmo1x7Nzwk9b0RODO+f93TMtxQ=;
 b=PFwfJRbzAEDlrckntohDdSlHA2AlxqSXI7zYvkYzBXaaFUqSiIQ/Cg7mc9z86/qfp5
 /cB/WttSS+jpxwdNSVNgKkrYw3OF9sf5FaQ0qZl+jejyRh9Tbh8bxAeAKPD7nOCgultk
 tLW3hg4sGQEa1L/aOFFppnazt8jgLiGmu0Cp7vM6rYqLhw754lZH8dIyqdJjKQLCCblK
 ywRbCyxZDhkiC1C0NqVEJNggMOtqgOER3x4bBfNJYf1x9KLeRE973jFG3d/+gmq2JYtO
 jyG9TKMtVb6xJybMonAZXC1PDWegZpkT0cojlIv0d2jp74xPUi4iBnJ2ttGzq2F3JAbi
 Wqig==
X-Gm-Message-State: AOJu0YwOs/kt3reL6VAFBv3rgCiLk3Qx+i99K809LbN/0ntyGlPWg771
 /dvMnUkaabGKDgqfge6fNAdw9vuppDj3Y5h/JdjHi2pZk7NHz8AgyJgB8ICFQln0tvl9x2+seBt
 X1hQj1lguwwIMv5dTRKXuepVQepndhF/bR2861SwZ6GFhplM=
X-Google-Smtp-Source: AGHT+IEaDd6KzHxte7Oq2kipgUtcpsNU3Bc/t0h5xFZx3zuvtHwJQuBC1Veli3gPLzsN4VTuSCw3+wm+rLVilgG1NKs=
X-Received: by 2002:a05:6214:2408:b0:6b5:32de:bfe7 with SMTP id
 6a1803df08f44-6b5ecfb7bb5mr54001006d6.22.1720168578123; Fri, 05 Jul 2024
 01:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240703212338.1436606-1-trini@konsulko.com>
In-Reply-To: <20240703212338.1436606-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jul 2024 09:36:07 +0100
Message-ID: <CAFLszThPRMsH+d5f+-3EKrT2_EPauZ55aD9owUaWoLaCB3vs1g@mail.gmail.com>
Subject: Re: [PATCH] bootstash: Do not provide a default address for all
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Wed, 3 Jul 2024 at 22:23, Tom Rini <trini@konsulko.com> wrote:
>
> A valid memory location to stash bootstage information at will be
> architecture dependent. Move the existing defaults to the main Kconfig
> file for this option and set 0x0 as the default only for sandbox.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/mach-stm32mp/Kconfig.13x | 3 ---
>  arch/arm/mach-stm32mp/Kconfig.15x | 3 ---
>  arch/arm/mach-stm32mp/Kconfig.25x | 3 ---
>  boot/Kconfig                      | 4 +++-
>  4 files changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But from my previous investigations, having no default for a hex
option can cause the build to hang unless the user is presentt, since
the build keeps asking for the value. I added support in buildman to
try to detect this, so we'll see how it goes.

Regards,
Simon
