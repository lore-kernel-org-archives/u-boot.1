Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF546C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BBCB828BC;
	Fri,  4 Apr 2025 00:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gaiZubfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5ECF82385; Fri,  4 Apr 2025 00:41:39 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364A082932
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 00:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso4611653a12.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743720095; x=1744324895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HtzXqFSBpJLHZluRL6lSdT3eh54Mdk7/7ZPGzo2hHq4=;
 b=gaiZubfv/L+1BbPxdduvEPB/APF8bm8tTPdLuTAgWMuQbZY1NrAJ9Jqr68pprcaCMn
 1LryTPDtc+ziTcWe1Q7q0kNeVpomH7isObDSszPIx+b7oDiN6mIxGtI2BKGIBrMNVjdq
 gGO7mFKMf+oqzxI17oA3OLJ/Lkd+qb3Nwsz60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743720095; x=1744324895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HtzXqFSBpJLHZluRL6lSdT3eh54Mdk7/7ZPGzo2hHq4=;
 b=owMMZygnsN+WTrjG/kHTrGOr1tWx2czT93voCBiPRB9gm/VAr0J6wjJaPIdct2Pc21
 IBzVWPbiuiMtWhnm/wsggNRNPrplyPli+vC+lZXnSVWsR/gTol7SYcHE4mwv0VZ10If6
 4gT5TZa3wfP3xDxT/Xjk5Zx1aL1QtkfLhgdJIyNSIsrZ/IkzKPxjOVm2nGNaU4U3v2dv
 YwwT/CjxbHYkeh7ZiN58sN+fHwO926AWzATNoAxCtQZR/Ydc5wK80KFFdl3hHzFr65ST
 6GRCGZbypQ0BTsxsdUpwqSUmnqsvvc5gHwR4+Kd4c5y88NSE3j6PJX23uO1j3E2eGjom
 TrYQ==
X-Gm-Message-State: AOJu0YxkHuLZfqMqeJmgAn7Fmr04wEwgrkxhiPftwRSfcshWhAXjIVkC
 6a4Vg4KItvSoOlkEMq9821HnCiwViLro8z6V2jVTJbL8lsXAfHuy4ZZzgn5BrNsbn30PIRjYo4n
 bf6w7ugkSxdLlUA9lOcGu+S/ZtclymiiCXNufg6aerylDkt+edA==
X-Gm-Gg: ASbGncuVdIYpb7R05+TN7QlLZE0Hglg1siSYSXwXwgyQin29+/FluHx2W+8RjJyGY93
 +DUEX+e3uVGJSva6KS9FATXsb1951GGe6XNTVSVcQZKrz0I7ZBi9ocrSbYCWuHlsvLdp64/E0Qa
 O0meEyvwg9GULkCDy3AAJhDBR0drtR
X-Google-Smtp-Source: AGHT+IG2nXzhDR94L+BUpTVOJZEiUmP8pWP0E2DGY/VV1sNNGLPkBb7xGwnuB+5yGPweev6W4LvYUkhr3CdRwRCA18I=
X-Received: by 2002:a17:907:970c:b0:ac7:3028:6d67 with SMTP id
 a640c23a62f3a-ac7d2e9734cmr84417466b.16.1743720095386; Thu, 03 Apr 2025
 15:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250403215522.1284502-1-anshuld@ti.com>
In-Reply-To: <20250403215522.1284502-1-anshuld@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 11:41:20 +1300
X-Gm-Features: AQ5f1JrUqOMwNReK0F5C6W9Eu_d1lVqePDJ7tuearhqr_-tYhNLHVJhv0ZM-1YQ
Message-ID: <CAFLszThmH69FKgKJSUz4pxCNOrzYO_B5X_CN8hqg5_CVD_TjAw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] spl: remove usage of CMD_BOOTx from image parsing
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, trini@konsulko.com
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

Hi Anshul,

On Fri, 4 Apr 2025 at 10:55, Anshul Dalal <anshuld@ti.com> wrote:
>
> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOTx with newly added configs
> SPL_HAS_BOOTx.
>
> SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
> SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV.
>
> The respective C files (image.c/zimage.c) are compiled based on library
> symbols LIB_BOOTx instead which are in turn selected by both CMD_BOOTx
> and SPL_HAS_BOOTx.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Tested:
>  * U-Boot CI: https://github.com/u-boot/u-boot/pull/757
> Changes in v6:
>  * Add LIB_BOOTx library symbols
>  * Update existing configs ensuring no change in size or build failure
> v5:
> https://lore.kernel.org/all/20250314035505.4029331-1-anshuld@ti.com/
> Changes in v5:
>  * Remove imply clause for CMD_BOOTZ instead add default y for
> SPL_HAS_BOOTZ
>  * Update commit message to reflect the changes
>  * Remove 'More info' link
> v4:
> https://lore.kernel.org/u-boot/20250313032842.1189977-1-anshuld@ti.com/
> Changes in v4:
>  * Don't set SPL_HAS_BOOTI for sandbox by default
>  * Updated prompts for SPL_HAS_BOOT[IZ]
>  * Removed check for SPL_HAS_FRAMEWORK from Makefile
> v3:
> https://lore.kernel.org/u-boot/20250312124757.789013-1-anshuld@ti.com/
> Changes in v3:
>  * Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
>  * Fix broken check for bootz_setup
> v2:
> https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.com/
> Changes in v2:
>  * Add SPL_HAS_BOOT[IZ] configs
> v1:
> https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.com/
> ---
>  arch/arm/lib/Makefile |  9 +++------
>  cmd/Kconfig           |  2 ++
>  common/spl/Kconfig    | 16 ++++++++++++++++
>  common/spl/spl.c      |  5 +++--
>  lib/Kconfig           |  6 ++++++
>  5 files changed, 30 insertions(+), 8 deletions(-)
>

I'm sorry that I am late to the party.

But you should start by creating BOOTM, BOOTI, etc. and select them
from CMD_BOOTM, etc.

Then you can create SPL_BOOTM, SPL_BOOTI, etc.

Then we can use CONFIG_IS_ENABLED(BOOTM)

LIB_BOOTx doesn't really make any sense, this the code is in boot/ , not /lib

Also, HAS_BOOTZ doesn't make any sense either. We use HAS_ or HAVE for
things which could be enabled (with a separate option) if the user
wants them enabled; they should not be used to actually enable
something.

Also, please check if this conflicts with my PXE series[1], part of
which Tom has so far not been willing to apply.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=435516&state=*
