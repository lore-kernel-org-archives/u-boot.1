Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39735C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D860885C5;
	Fri, 26 Jul 2024 01:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TNBo01PC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D597488637; Fri, 26 Jul 2024 01:32:46 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F6E885FA
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b5d42758a7so420186d6.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950362; x=1722555162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0H+mJLdor3nyd8uayDvMpZ/PKzvqi9rxmE110ltNafg=;
 b=TNBo01PCmjQo+4DsCaVI4Guynj5tSM6qFtjI+/TpVoZtXgI1S8TofEWUyKFjDahtzl
 O5C6GRqaBBtOEfqvLALNLdfR977qGhA8K+ZXCbvfVlcT5cfTRvnRjmgyJUPZvUEYxPEw
 HKURhUMc01bP//1ZWXaU6EIHCz99HbC/6kIOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950362; x=1722555162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0H+mJLdor3nyd8uayDvMpZ/PKzvqi9rxmE110ltNafg=;
 b=R2yxPcQ4zdafctPbhok9pV9qFusQ93ifKQ0gSlFFYjHtpsPfSk/d3JtlPgvb1iBFOH
 Cam2DKXThOxetKrW09Cfa6OG5GP0lJUFg0blRVMcUfGtLO7JWG+hbeJJrR6FI0I3DxYO
 PWhjP3qSc9d9BsMDJzuKpqo0zRGVx77nVnCllVdK1MyjxpKJmenMd2kkais9SNzf9757
 ePonpuS+rPrzhBg1xwWiLciiqNA5XMD20KtSOp8g7eAhufSuWDbZmaooSBE/kU4zsDAl
 PoA6r2pHlHZsH7RuWTOlcT9nWbBOxjD5JTsUNvaKXGFzLUFVtsTtm9+Uq7EHgG0U44vm
 fwig==
X-Gm-Message-State: AOJu0YwZu1tkEjWUl1K6iTjLvCwmXJ0OgbKyeYZ+rTCA4bKxqfD1Rshs
 OSfWGQqU5OrGO3CYwu/0EIVf8SkVEBv3wkqxPZ25Ytqab2QVPCCZ3D/fQTSSy/Hpckqg3TCslLg
 kAta3BF6aQKP3JrL04mMfedOvuV/fXiQTjdsO
X-Google-Smtp-Source: AGHT+IEoG6DIxLBTgz9jzSd9m8HcV/i49mYDnVhfjFxv+DYZcDqj4sZGvN5Z0SjKeW29WgAvgQly/1b2YKb/6KtTH0k=
X-Received: by 2002:a05:6214:c43:b0:6b5:485:ea30 with SMTP id
 6a1803df08f44-6bb3c9ccd69mr54609796d6.3.1721950362005; Thu, 25 Jul 2024
 16:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-24-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-24-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:31 -0600
Message-ID: <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
Subject: Re: [PATCH 23/40] lmb: add a flags parameter to the API's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a flags parameter to the LMB API functions. The parameter can then
> be used to pass any other type of reservations or allocations needed
> by the callers. These will be used in a subsequent set of changes for
> allocation requests coming from the EFI subsystem.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  arch/arm/mach-apple/board.c       |  17 ++--
>  arch/arm/mach-snapdragon/board.c  |   2 +-
>  arch/arm/mach-stm32mp/dram_init.c |   4 +-
>  arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
>  arch/powerpc/lib/bootm.c          |   2 +-
>  board/xilinx/common/board.c       |   4 +-
>  boot/bootm.c                      |   5 +-
>  boot/image-board.c                |  15 ++-
>  boot/image-fdt.c                  |  15 +--
>  cmd/booti.c                       |   2 +-
>  cmd/bootz.c                       |   2 +-
>  cmd/load.c                        |   4 +-
>  drivers/iommu/apple_dart.c        |   6 +-
>  drivers/iommu/sandbox_iommu.c     |   6 +-
>  fs/fs.c                           |   2 +-
>  include/lmb.h                     |  23 ++---
>  lib/lmb.c                         |  48 ++++------
>  test/lib/lmb.c                    | 150 +++++++++++++++---------------
>  18 files changed, 150 insertions(+), 159 deletions(-)

This negates any code-size advantage of dropping the lmb parameter.

All of these are LMB_NONE. Can we have a separate function (e.g.
lmb_alloc_type()) for when we actually need to specify the type?

Regards,
Simon
