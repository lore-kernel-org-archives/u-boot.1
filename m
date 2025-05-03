Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E03C3ABAA
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 02:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD8882836;
	Sat,  3 May 2025 04:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XSaBL1TK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E22826AD; Sat,  3 May 2025 04:10:50 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE3168214F
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 04:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-acb415dd8faso392937766b.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 19:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746238247; x=1746843047; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LWLaxifDj3Z7ALTIcoH2VeetPGKrRTdSPrHC7/WbweQ=;
 b=XSaBL1TKnp9npoETIZr2f6pkPNGWhs9m6aaf8TX3YFHSZonXSDvHdWuDx/DN6tXjob
 JbGNzbf1WvOID2+07cFrwJWbLwid10jgEyRYYe6bXq0Fxf8URrVL1kbUHePWpAJxsK0J
 pIBBKwZ1UTfo/wZIYBtObCK1Wz4RcFIWkicRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746238247; x=1746843047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LWLaxifDj3Z7ALTIcoH2VeetPGKrRTdSPrHC7/WbweQ=;
 b=PaOylaIZX75KVgsu6UxwtmP85M7hCpZQWfzPAB3Ki220Q50m/DJ6FMjcNrfMWzISv8
 PBhk1m9Rf89PQ9LmTCIQUeWUwvN2jaM7wZ/wtOmcZ/zRIfetGRayzK913wBshVPujezB
 LdPJVmor8PBjueb/xl0v2EXvA/87chuLRUjKV4iI/5JA3fD9n2Uw2JSW+YiT7ttSvGnT
 MrbGszPoJNj9KtAXNLKSPHJfNDLnPWTb13AEB2ZP8P3lTc/lttEcgy+6s61ldDCQ6Ase
 BEDxNzycfm3NA6m4zdzJzxiER+Dajp0ZgopZijLjHpbmZ2PX9twPEDgQZg4/wlFdnqUd
 J12w==
X-Gm-Message-State: AOJu0YxGx3hSCDDK428CBETFog0rzz8ZdlgZFIzfCuMayid/MOEhjhX+
 nnwEot005Kqt88JwU7285Fhy/5usGBWotyQkTeoUYbPbsh7MdJvHT3S+hPBMgR9M3xKl4xZ7126
 BYizcf9o+59qeEzVEr0kwAabu2ZApBSBZa7DU
X-Gm-Gg: ASbGncsyHYcM/rZEKTSKczuXMIdnbbDX1K7DUoY8fF9KQFIKt1/cS0PxmnOWUGBTdgJ
 v4/T10XJd3XPhkklsuVhSPYDp3bIa/jrRds3oeumqZqFz4I7pfce0Rw+MiCW2bAJ8Cp17rInhTn
 AJ8o6pqFBR8NQvr3BtESywXo4=
X-Google-Smtp-Source: AGHT+IEG+LeW0C1oD7ELHEJ0VhxY8AiUgNePumnBnjxcgAIC4mjWmqak/4ofUj3ufSKvKMjPBuRjfFJEMbCcLNZa/II=
X-Received: by 2002:a17:907:86a9:b0:ac7:e815:6e12 with SMTP id
 a640c23a62f3a-ad17addbe0amr421416066b.33.1746238247195; Fri, 02 May 2025
 19:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
In-Reply-To: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 20:10:33 -0600
X-Gm-Features: ATxdqUEqWp-knMPE-dZvuD30Bw6vDBbUNI_6Y9YIyJ9zEENKCmQIEyjywLNtyUo
Message-ID: <CAFLszTiPKbz20+=Du4L7fq442dO2QUh+wV7qH3z5FZy0mNZNmg@mail.gmail.com>
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
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

Hi Eric,

On Fri, 2 May 2025 at 14:06, Eric Schikschneit
<eric.schikschneit@novatechautomation.com> wrote:
>
> This will allow arch(s) that use device tree blobs to pad the end of the
> device tree so they can be modified by board files at run time. This will
> help prevent errors such as FDT_ERR_NOSPACE from occuring.
>
> Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
> ---
>  arch/Kconfig                 | 11 +++++++++++
>  arch/arc/dts/Makefile        |  6 +++++-
>  arch/arm/dts/Makefile        |  4 ++++
>  arch/m68k/dts/Makefile       |  6 +++++-
>  arch/microblaze/dts/Makefile |  6 +++++-
>  arch/nios2/dts/Makefile      |  6 +++++-
>  arch/powerpc/dts/Makefile    |  4 ++++
>  arch/riscv/dts/Makefile      |  6 +++++-
>  arch/sandbox/dts/Makefile    |  6 +++++-
>  arch/x86/dts/Makefile        |  8 +++++++-
>  10 files changed, 56 insertions(+), 7 deletions(-)
>

This is not a board-specific feature. You could try this:

https://patchwork.ozlabs.org/project/uboot/patch/20241206131113.2865416-3-sjg@chromium.org/

Regards,
Simon
