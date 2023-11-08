Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F13C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B22DF8768F;
	Wed,  8 Nov 2023 05:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gf/Qfr/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1A2874E9; Wed,  8 Nov 2023 05:25:01 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79DCD876F1
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a81ab75f21so77624067b3.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417493; x=1700022293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5d8HGAcqOv+7OEPX0W8cunmzxXC5UVMG8tdQ43T4fIA=;
 b=gf/Qfr/QNXTF/peggjJaZ9RyBxcid3eomOEGhGEgehMK7SamKdJZb+0iTNSXIsGPau
 vtJFODYHdFa+72kSlf1sZi+OPNrFR7U6QRC+5FE1TNavEYiwnACdhSUBsQ1xm/eYL8b2
 Z6KnG9f2yM82IN3cBOy++cAhmnpuQk6gCxj2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417493; x=1700022293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5d8HGAcqOv+7OEPX0W8cunmzxXC5UVMG8tdQ43T4fIA=;
 b=KzEwxwD9/gel2xe+52nLwVJewqMl/uBiMFKjSeYVptDYMG0ns2DEZ1pLNThsRSbCq7
 0GVeE7GuyyHGlVK+rm8ix3aO3af/Ey1O+gl2HOutZzYZ7Md2oAgOE9C7yrShVLt/8IQQ
 QfE/2sw1RccuNTD0xE8RTnGpNAkR2trut8C9hCtKf19rzR3vby7iO/SG1N39yl0dHTAN
 mh9FBE5Nlf6eL7rKOeQQJ+3SaTCLanVmNeoDbJGPDvR8IAd+Om6Wjw7xOCITlz9rSN0A
 B5e77i/+c9zXQ4MSs7MiN89bRVMLibItSOSvcioE4C0Q6D03RagZSD9lURwmkQPtTOOi
 vR5Q==
X-Gm-Message-State: AOJu0YyxHUyVItGj+jumuu/geuoHsp6Zovl0RJn4lWYL7WTU1L6P1ylp
 3wRXo/QUjtKCalRiXS+vLWNfTPHJwZf9v5gvdbGgqA==
X-Google-Smtp-Source: AGHT+IHNWkAlDVfK7NnsKQm0z8o5NAFMi8krL30hAwBPswAttLUKFNkfZSXP+q+lEm6KLnVxwFB5Ecj8/1Y5XveItI4=
X-Received: by 2002:a0d:cd46:0:b0:5a1:d352:9fe1 with SMTP id
 p67-20020a0dcd46000000b005a1d3529fe1mr681080ywd.42.1699417493005; Tue, 07 Nov
 2023 20:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-10-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-10-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:35 -0700
Message-ID: <CAPnjgZ3BDP8-eT29EdkDz7tW4036WSHq=iR5PyHDPuKQ_bchhQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/25] spl: Remove filename from spl_load_info
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> For filesystems, filename serves the same purpose as priv. However,
> spl_load_fit_image also uses it to determine whether to use a DMA-aligned
> buffer. This is beneficial for FAT, which uses a bounce-buffer if the
> destination is not DMA-aligned. Remove this logic, and instead achieve it
> by setting bl_len to ARCH_DMA_MINALIGN. With this done, we can remove
> filename entirely.
>
> One wrinkle bears mentioning: because filesystems are not block-based, we
> may read less than the size passed to spl_load_info.read. This can happen
> if the file size is not DMA-aligned. This is fine as long as we read the
> amount we originally wanted to. Modify the conditions for callers of
> spl_load_info.read to check against the original, unaligned size to avoid
> failing spuriously.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  arch/arm/mach-sunxi/spl_spi_sunxi.c |  1 -
>  common/spl/spl_blk_fs.c             | 10 ++++++----
>  common/spl/spl_fat.c                |  6 +++---
>  common/spl/spl_fit.c                | 23 +----------------------
>  common/spl/spl_imx_container.c      |  8 +++++---
>  common/spl/spl_mmc.c                |  2 --
>  common/spl/spl_nand.c               |  3 ---
>  common/spl/spl_semihosting.c        |  1 -
>  common/spl/spl_spi.c                |  2 --
>  common/spl/spl_ymodem.c             |  1 -
>  include/spl.h                       |  2 --
>  test/image/spl_load_os.c            |  1 -
>  12 files changed, 15 insertions(+), 45 deletions(-)

Er, I think

Reviewed-by: Simon Glass <sjg@chromium.org>

but I wonder if this patch could be split?
