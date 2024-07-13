Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A484C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E1087E13;
	Sat, 13 Jul 2024 17:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cNGhMqAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F21888F1; Sat, 13 Jul 2024 17:15:46 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B02888F5
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-78aeee1068aso1143953a12.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883742; x=1721488542; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/WQ6XG7qBW6VyH4fVnnEnhziRK/gNVQfmj5rMi21kpY=;
 b=cNGhMqAQuJiazbEhVHXCZKVqEGSfqMSMpKy0zMoks2h7nnXq45mB3xNL0LNKlhLkHa
 SXPkXRBKB83/Xfu58WP3u9WcRgUIvBoXzmghrnsU5kKPNUuh0qtUdViSWH8v8TxDxkyv
 n3UH8JzLC6j+4znsvAMzci6NP1prHWBsXSBbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883742; x=1721488542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/WQ6XG7qBW6VyH4fVnnEnhziRK/gNVQfmj5rMi21kpY=;
 b=wZN8lZH1XHnxrGGk4BfCXuaibB0L5X2ATCQq1zVRqad4YUM3OgmnFBLOMIuqgQavQg
 3AMKxVGFMsyI+ZNNB2RUaSUjN9ldqPMfuy8utM/0kQJ/vCJuc0O2S1joEuXxZ3N0kU8b
 XgDSHVaPN2Vdwwba0ZZfvs63xXadCl7JSDHi/+1jq5H6oiqUEQA/ks3DG6Z4tNK/6dju
 JNdKiWXIPEl/sOad3LO8Fy1j8Ub7knsGLPJt5QPG1rnd58d/RC+xCpEx5iUO8/e28MDy
 BlUUxFYG6jpTbTRFTBSNjnmYeGlsvxmljLtwq5FVAVoUKYdW+4M+veJWL2lD3/4OpYwA
 3/DA==
X-Gm-Message-State: AOJu0YyUYfIOiQEdkOPvZCo6kpjUn/wlmA26jessaOsgREZvdUyTuSRK
 4T5qnGqxisd0QVlOaAFPirheYgr53629UEkLmh48s3CiT1TfK8z1g27+T0ApnimFEs0LxKd6cwQ
 bqXFRz5jz01NUQz0ym7rDzgMx/xRbgxigARa5
X-Google-Smtp-Source: AGHT+IEHLlkKhz92kQWRYCwgsBWq7NY91/WN5cW0MtUGL9I5vI4j8+BYyyBoWgqyKdQmF6RQFruOVAT2VpIllnriexs=
X-Received: by 2002:a05:6a21:6da2:b0:1c3:b0d6:e496 with SMTP id
 adf61e73a8af0-1c3b0d6e5b7mr10522253637.45.1720883742328; Sat, 13 Jul 2024
 08:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-12-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-12-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:28 +0100
Message-ID: <CAFLszTizi1ZQ+0L8f=7BEviRwzX2_BUThNZW46viqKxwNM1HbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/48] lmb: pass a flag to image_setup_libfdt() for
 lmb reservations
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The image_setup_libfdt() function optionally calls the LMB API to
> reserve the region of memory occupied by the FDT blob. This was
> earlier determined through the presence of the pointer to the lmb
> structure, which is no longer present. Pass a flag to the
> image_setup_libfdt() function to indicate if the region occupied by
> the FDT blob is to be marked as reserved by the LMB module.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Use true/false identifiers for bool instead of 1/0
> * Fix the argument passed to the function in arch/mips/lib/bootm.c
>
>  arch/mips/lib/bootm.c         | 2 +-
>  boot/image-board.c            | 2 +-
>  boot/image-fdt.c              | 7 +++----
>  cmd/elf.c                     | 2 +-
>  include/image.h               | 5 ++---
>  lib/efi_loader/efi_dt_fixup.c | 2 +-
>  lib/efi_loader/efi_helper.c   | 2 +-
>  7 files changed, 10 insertions(+), 12 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
