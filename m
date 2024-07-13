Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687CFC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26DDF888FC;
	Sat, 13 Jul 2024 17:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CWinrvMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE8A88929; Sat, 13 Jul 2024 17:15:57 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1DF88912
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c964f5a037so2135242a91.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883752; x=1721488552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/piog46XhkaIzMrHOgyxNNaL/7JiYXHD6w78KFAuaQ=;
 b=CWinrvMKo7CFvMWe8Ia0fc0v/tXkLgFzTDCdmrST2THcJ8BVXdT32t6uj2D1Utc0Hq
 ekAlZHXh4TxUXyEJv91JSStEGOGc+m7CMmwsFySBU/e6hzBVyvR9Mk8CdpRoAc5bSgaz
 TyzUfbAR/6X9ZoOiRT3UzvKKFF5sf719SH9BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883752; x=1721488552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/piog46XhkaIzMrHOgyxNNaL/7JiYXHD6w78KFAuaQ=;
 b=NVBpnj7tyEStEPdBNMAJUGOCYeYHi038dJlIqcXuqAspNviPn1rSxTpWZIYi5Xx5kA
 J2AXEXJPNPu5wfKw3t5rx29ED2l9JTat8p0o2TL+F7ooOPscp6xwMvWhr2HpD4ZhVHZ5
 E8+YpBH3EE7vbsEZIBS4pzS8VNTljOIVUmX0QQpd+qnXIT3Gid22tGYShNUIjoqtEDvn
 RbIUWmjvB//IIwSRY0gbASRzDVy0AZC8etcs7Fo+XfT2eYkYuwlFSC+Jz2CYSf7miv5q
 EWJ3rSbAZsLQ2gjmrpDoaIWDksiP6NjucnFaZVll37v+xg8IdKyDGqVkG2Mod8WfrHR9
 zPcw==
X-Gm-Message-State: AOJu0Yyef9/lA/VYTi2PqMBxJfzaRPTXDTSW7JWR66c3tq2EWBj2DGGB
 OW4nLci7N0rcrnZGzbrwDyoycknHZTjywIOte8Xq4tZfqwKZoTUrInZ6g0VTNB49cSveyuj9Nro
 uXQ2KI8b9WknB6niwfVzrpM1pCbBiR1EEruoo
X-Google-Smtp-Source: AGHT+IHqZsoTiIEg5PoVr3qNs/FFlbXREFXmv+GObEvGrwx3WesaVCte2GnNvKe61gBGGVHnzqUTjaasiK+LWeg+KRc=
X-Received: by 2002:a17:90a:f482:b0:2c9:7e9e:70b3 with SMTP id
 98e67ed59e1d1-2ca35d488acmr10248795a91.33.1720883752513; Sat, 13 Jul 2024
 08:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-10-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-10-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:33 +0100
Message-ID: <CAFLszTiN1K4tazqaBBCS37VHVtJ0ise2RQC2AGaLKg1SMFj9JQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/48] lmb: remove call to lmb_init()
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

kHi Sughosh,

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB module will be changed to have persistent and global memory
> maps of available and used memory. With this change, there won't be
> any need to explicitly initialise the LMB memory maps. Remove the call
> to the lmb_init() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  arch/arm/mach-stm32mp/dram_init.c |  1 -
>  board/xilinx/common/board.c       |  1 -
>  drivers/iommu/apple_dart.c        |  1 -
>  drivers/iommu/sandbox_iommu.c     |  1 -
>  include/lmb.h                     |  1 -
>  lib/lmb.c                         | 18 ------------------
>  test/lib/lmb.c                    | 18 ------------------
>  7 files changed, 41 deletions(-)

I can't actually find the call to lmb_init(). Where is it?

Regards,
Simon
