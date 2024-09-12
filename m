Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D5FEE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D12988DF5;
	Thu, 12 Sep 2024 03:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ypnro3bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC71988E0E; Thu, 12 Sep 2024 03:01:05 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510B888DCD
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718d606726cso218946b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102861; x=1726707661; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CYnH3QumKeyFOHUdVUweRGGCSp7AbmDByXeoUMx1hCE=;
 b=Ypnro3bxr+OGbEfJmx4UwlQzN83CkWe74+Dk8fbDf0qxkXwLLCZYyAe/2YFQn/pggM
 EGU+tTNwh0/UULZq0y19soQilXqDfCuSyKrtVumB2xVo8XoV8AGIfx5Euwt9dUXanGNN
 NPfl565AUzkStETJhK2eAbI/slp/7gdF+zPks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102861; x=1726707661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CYnH3QumKeyFOHUdVUweRGGCSp7AbmDByXeoUMx1hCE=;
 b=O+Hgf+M0Ucg33qKizOAMTMW8S8UGdD+tBVWSuz1KJGqqme1C2MEoOaBk/ni65eUUeo
 VJumsh7cUzuIj8YY9NWV3OoWe1jVU92RhRghmLzeTv+2gMu0DkCDIbWFqC/UE7sMSpa8
 iwVV8llkdWaYogmPXKghl9jUFGa2yNN7awKlGlEoSJi1MZqCPPyq5CxX4+QNRaWOySOs
 1qIsyb0C+IG6zEdO5NuUkdIKX5MJWf6pIqj7XKEak7d9s26w5y/iqnCCzd9N7a/Pcx6w
 XLbZpRaO7DDkxSJ+7GLQVZTPiluxVMYCvZKuswFv1wEbyS7pyOwryXHStp5H2Ip5LB43
 kaFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9wjV5+W9BGGN0QENW/pkupHxMJQj1EX7V/PoQqduwCYZUVzJUP32UZVR8y4CU5Z28NCnxvUQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwhMHq807wdBYVTjscoieqQJnMbrg4x89yj+YxAdt4eOsPkQYYW
 i/1pkM897pi2ph64stg/ClTT5kyilFz53sgqPjng2knkcBf8Ew57kSO1vc4VAUgqQkFrPT+oIuM
 IoKl+UEAuAUrgCsL/Lkz5McJIbZOpv1a7qUue
X-Google-Smtp-Source: AGHT+IFKhWNiZUCQcFmV4Waf2zktTqOivt9mKxk6nliv3k9iGjauBCcAF9vtuOjijWpL8htfVxT3NVJoiLBJzoH6tEE=
X-Received: by 2002:a05:6a00:2d17:b0:714:2d05:60df with SMTP id
 d2e1a72fcca58-71926091d24mr1637254b3a.15.1726102861231; Wed, 11 Sep 2024
 18:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-3-ddrokosov@salutedevices.com>
In-Reply-To: <20240911214945.15873-3-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:00:27 -0600
Message-ID: <CAFLszTic6ivmhxR08=XY6PMQ4cKZ04U9vAjh7VxPOz6RVzVmGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

On Wed, 11 Sept 2024 at 15:49, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
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
>  cmd/Kconfig                               | 15 +----
>  cmd/Makefile                              |  1 -
>  cmd/ab_select.c                           | 66 --------------------
>  cmd/bcb.c                                 | 73 +++++++++++++++++++----
>  configs/am57xx_hs_evm_usb_defconfig       |  1 -
>  configs/khadas-vim3_android_ab_defconfig  |  1 -
>  configs/khadas-vim3l_android_ab_defconfig |  1 -
>  configs/sandbox64_defconfig               |  4 +-
>  configs/sandbox_defconfig                 |  4 +-
>  doc/android/ab.rst                        | 12 ++--
>  include/configs/khadas-vim3_android.h     |  2 +-
>  include/configs/khadas-vim3l_android.h    |  2 +-
>  include/configs/meson64_android.h         |  4 +-
>  include/configs/ti_omap5_common.h         |  4 +-
>  test/py/tests/test_android/test_ab.py     |  8 +--
>  16 files changed, 84 insertions(+), 115 deletions(-)
>  delete mode 100644 cmd/ab_select.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
