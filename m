Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9638ECF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3897889110;
	Wed,  9 Oct 2024 03:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fSaFzS0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2037489126; Wed,  9 Oct 2024 03:57:05 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5C0890F7
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4a3075662b6so2208569137.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439022; x=1729043822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n4r1ZLz7BBtjCnUFs8BOd/sFDM2Oe4ncTeL5RTkav7Y=;
 b=fSaFzS0uXok831niIf1bnucUIDyIdgE7oOWz8ZUbYsWx5kFe/DFNouwMu5eH8NAB3j
 6Zdkj9F4HJ+oyn7Kv9mjDYjDu/dVyF1wpUpLzupxa2+y5mxUfKaD0y9m++2nCRA4EkMv
 Sn5BX8gAxDjfCdOJW5TGkVE9J9I7OSCg9zT50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439022; x=1729043822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n4r1ZLz7BBtjCnUFs8BOd/sFDM2Oe4ncTeL5RTkav7Y=;
 b=GIvLiVAxt81I/kbenEuvcSZGS3BgMs/zaykuj48rBd44Dla1F6h4I7GGO3i4MYEnVB
 HsElREARzEiP/xg5Cb49Cv/yzvkvooh0PYM5aeJbejdM9CDWm9me0SFvkSVh83BVi0H5
 MGs4Szhiv7RlhdA9V3uzcIIake2Vvn05P3bMJ/IJWdiqpqBG154FZoKROMKBEj68Q9Ef
 6Dk3NpSbxeQ7Q1MQlqyfOVhI7zkAFLSHY5mC7+cibIfmGXJrcXThx+M/oiGTwIkFDRkd
 N/j+kK1eAhkFu/GjeV7aN76HeBoPmhAWktJN/KWg6oNoTold23JTE/Lwa5MDdRQ8meDw
 Wk8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTYo9N+5oa634K0+poQlvaes5rwlM7D/AMAKYiZ5FPRHvy6KXK0AlPHcWdOaYdGiEkjGBkNDw=@lists.denx.de
X-Gm-Message-State: AOJu0YyKmJR6mOKlVm8/OBrLZryu4qobILP6pXB0E2XxZVlKFWkUSXxV
 bybuMne4gzS8YqBcaXOfWohUCTft/TL7yl1O/VvNH34Og8DF5WtKy/0Gp7mi2uF77+v8qDrfUfS
 eqD4hbBehEcV1i4BVfbzKc039hiQ+TFufJINp
X-Google-Smtp-Source: AGHT+IF+Yiwei8AxJ/IG6XNTm74bjruuKA8bMjEMYFHOIh9qZQs7O2zazbPrb0+tcf3ObvFZ09+BcLhz/a8CMjZtr70=
X-Received: by 2002:a05:6102:370c:b0:4a3:3d4f:edd2 with SMTP id
 ada2fe7eead31-4a448d7d503mr1226488137.17.1728439021866; Tue, 08 Oct 2024
 18:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
In-Reply-To: <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:56:46 -0600
Message-ID: <CAFLszTjW+a=jNvktZdix4LZmkVBr6WmyzQMuramf5rqMN_-Xsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com, 
 kernel@salutedevices.com
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

On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>
> To enhance code organization, it is beneficial to consolidate all A/B
> BCB management routines into a single super-command.
> The 'bcb' command is an excellent candidate for this purpose.
>
> This patch integrates the separate 'ab_select' command into the 'bcb'
> group as the 'ab_select' subcommand, maintaining the same parameter list
> for consistency.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  MAINTAINERS                               |  1 -
>  cmd/Kconfig                               | 15 +------
>  cmd/Makefile                              |  1 -
>  cmd/ab_select.c                           | 66 -------------------------------
>  cmd/bcb.c                                 | 63 +++++++++++++++++++++++++++++
>  configs/am57xx_hs_evm_usb_defconfig       |  1 -
>  configs/khadas-vim3_android_ab_defconfig  |  1 -
>  configs/khadas-vim3l_android_ab_defconfig |  1 -
>  configs/sandbox64_defconfig               |  4 +-
>  configs/sandbox_defconfig                 |  4 +-
>  doc/android/ab.rst                        | 12 +++---
>  include/configs/khadas-vim3_android.h     |  2 +-
>  include/configs/khadas-vim3l_android.h    |  2 +-
>  include/configs/meson64_android.h         |  4 +-
>  include/configs/ti_omap5_common.h         |  4 +-
>  test/py/tests/test_android/test_ab.py     |  8 ++--
>  16 files changed, 85 insertions(+), 104 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
