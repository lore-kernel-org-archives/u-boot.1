Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498F9E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 06:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70F988DFE;
	Sun,  8 Dec 2024 07:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jL1C3Ht+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C9C89492; Sun,  8 Dec 2024 07:59:52 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E1688DFE
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 07:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6eff5f6fe07so6957387b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 22:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733641189; x=1734245989; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t1UdMd5WKQvplbQSYVjdPLYfQtKLBM1AnslBxAiiZoE=;
 b=jL1C3Ht+QPRDKdmTPEOFfNcs5byj1O5cfqj1h8ImOgVUqMkZBteShU/pdAPw/se8by
 Ex0C4zO9e76Cp1kODi4WiY9iiiG9DRnI38gMBqpggnf5/CL/0j5/fRp9F9BQjfrUVTLy
 bIBd0blg9PNRybw8MnwCaxo4HUMv6pMNgN1LPfNusGTw/K8hwu77Hotiy0gOUPo0j/kA
 5Z0k/GMTOOTcrnTCXgk3vaQPdaxcBhyk7xGqIVSIh1d12dAE2CK17bK5mIyF7Xra8Xau
 39WRjN5cBAzdtO+K6d0fFTU8SQpIXrQDsJ31J/1IVi8VI9+SiYVNfym0Eo1NQS3fYIel
 M/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733641189; x=1734245989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t1UdMd5WKQvplbQSYVjdPLYfQtKLBM1AnslBxAiiZoE=;
 b=eKKFVSryFmEqTRAxV1/pC+hZCvksVH5ayXBgDff36R838cyk/0090PEniUDG6RRnFp
 xvTX1Lr6yETvPPXt1cH+jDIzDK59MtzPT8WnYzl2tGYas5jyeABBgLxWJcocwjMLdGHa
 K/Z1nKEq/umPN2NMiBq2Mt1j5IBxLEB1d+rCvw8RaLkiLJ+PCd16tieMdzr6YtYLHKVO
 wsK4miH3E2VzBBx8OwCpfetpqHOGJ2ShVRHCscCSck4FETJjm9sfURWvLXtouvgmda6H
 zstMqgiToDVn/vkWe6AoZloCLl6yq2ezXiM5eSFiyxA2AYjhAzPC+El1BXqDL7LuPEbG
 8mtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnN6RU9zJ0VBVecICmnyzGAvKHa5uhbGQmjiG2D+6grIUhtBun8dYnn7TzOVMkSEtt4sriuNk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa/JTxrQTyd++uvyTtvGvPzLs4LdmDbKhjuSrUQtw6rfQW0jFI
 W1VKHmtsSC+p5kHpAIo0KsOiji8C2c7DwIiXt4s3tIGHtqxQ6Rd+/jQn0iyenBypk8TxDRIA4mw
 4QwYpr2HMb27yKsBDLys7dz+mvcptWhEYcAEArw==
X-Gm-Gg: ASbGncsJJgfmc2TFf3oOT41bDW94r1D5oWnb+4Zu5zVPWHbI0wLNncAIy5d21mGgOZM
 nltVQjxBWDI4U2Z91RGQ1oPYXwyW7v0Q=
X-Google-Smtp-Source: AGHT+IEx1atrtRw8TJs2lgSP0B4iNpIGUIAl6Oc86AJjPdW5HSrBxOS5OiTiG0kl1BU1PloR+W7GOuFTeJ0Jrz8oEgs=
X-Received: by 2002:a05:690c:6108:b0:6ee:6a2a:a517 with SMTP id
 00721157ae682-6efd04daademr105143407b3.18.1733641188894; Sat, 07 Dec 2024
 22:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
In-Reply-To: <20241208002121.31887-1-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 08:59:13 +0200
Message-ID: <CAC_iWjJ80YacXKr_eUdVUuwm5=dWEQx2_5oj4tJz_Lf_4xX_0w@mail.gmail.com>
Subject: Re: [PATCH 0/6] lmb: Fix reserving the same region multiple times
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

Hi Sam,

On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Since commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping
> memory areas with !LMB_NONE") the lmb_add_region_flags() returns -1 when
> the caller tries to add the already existing region with !LMB_NONE
> flags (it was returning 0 before that patch). That causes
> boot_fdt_reserve_region() function to print erroneous error messages
> when it's called consequently more than one time.
>
> Make lmb_add_region_flags() return -EEXIST when the already added region
> with !LMB_NONE flags is being added, and then check that error code in
> boot_fdt_reserve_region() to avoid printing the misleading error
> messages.

Thanks for cathing this. It's a print only error, but still misleading

>
> I didn't want to change lmb_add_region_flags() behavior back to always
> returning 0 on attempts to add already existing regions with !LMB_NONE
> flags, as the unit tests in test/lib/lmb.c would break, and also
> commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory
> areas with !LMB_NONE") specifically states that behavior is expected and
> required for efi_allocate_pages() calls with type=EFI_ALLOCATE_ADDRESS.

TBH it's not only the EFI code that needs this. I don't think
returning 0 for a region that's already allocated and the flags that
happen to match is a good idea to begin with. The code should be as
precise as possible.

Thanks
/Ilias
>
> All unit tests pass in sandbox U-Boot, with a small test modification in
> [PATCH 2/6]. I also made a bit of LMB cleanups in this series, while at
> it. Only [PATCH 6/6] introduces an actual functional change.
>
> Sam Protsenko (6):
>   lmb: Fix flags data type in lmb_add_region_flags()
>   lmb: Return -EEXIST in lmb_add_region_flags() if region already added
>   lmb: Make const flag_str[] in lmb_print_region_flags() more const
>   lmb: Improve coding style
>   lmb: Improve kernel-doc comments
>   boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()
>
>  boot/image-fdt.c |   2 +-
>  include/lmb.h    | 125 ++++++++++++++++++++++++++++-------------------
>  lib/lmb.c        | 105 +++++++++++++--------------------------
>  test/lib/lmb.c   |   2 +-
>  4 files changed, 109 insertions(+), 125 deletions(-)
>
> --
> 2.39.5
>
