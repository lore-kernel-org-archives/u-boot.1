Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B71CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BAC86D5A;
	Thu, 21 Sep 2023 03:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IXTeIh3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFB786D1C; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E1D86D28
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59c00b5c8b2so5339327b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQkOagCLtG3SnpfT0Zo4ikhAMgK932Hy1naQ/yvGpQE=;
 b=IXTeIh3CoGz/eFWTMoBcJZGgPWf8Kz9BgfKFYFdgblKry9ytmnovupXBBQLPwWIhIR
 +X0HXDhMRLWcJ/2lDbVSEqlrQsyUpo4lCBlQayx7fxk7k1AOdNDwTjqZbQOeRFtY2PyH
 NE8IVbER1J8wqEjD6LVUsas/2kzkexcJ6A25M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQkOagCLtG3SnpfT0Zo4ikhAMgK932Hy1naQ/yvGpQE=;
 b=P3vQPDWhUvrtdi0hCkU7oH6U7OEco+DpVLRsAgtB41+0md4/PVWyMsA0Af9qvthF59
 0HSRvkWhuqAnneeEiE84vfhaiZJXIkpaGRFGoyF4X3mQwA8gfxJA4FgEBasbo3ZmhakD
 NRjEmtzGDnX0nWiAV6RvEngKJM6y2EyRgTfdW9csLGc8LKRhtnHw1cTtUJBhTe6G37wN
 iGFq29LWWR5Aij29DEnZ/6ozGxDSiBS6cyTKtDDCNfBZ04k58Ak7ofHrZLq8IlotfYdz
 /7VdhT03Ujt7AeWAqbuuFK7AbZVjOeLonvLuFLsP3qn02PfCfdhz9SkSP6hwu7YX/qdD
 OzlQ==
X-Gm-Message-State: AOJu0YwwA/6mzJu+KHl1DVVmpMac15AayS2JQFyeszN+4IOR36VRB7ai
 yEZVJygENBN0XRkNN7qFTNbK3+Q+/GECKFaltpP69w==
X-Google-Smtp-Source: AGHT+IEmzuA8l1TPaSTbRmQ4b6BBREjiAOCLwn0szHGo59Ys+2zFZihZgRjpgSEyN4jvroD/VYwPJITPE9lF2vFie14=
X-Received: by 2002:a0d:df14:0:b0:57a:2e83:4daf with SMTP id
 i20-20020a0ddf14000000b0057a2e834dafmr4282277ywe.32.1695258357395; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
 <20230915175050.4109711-2-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230915175050.4109711-2-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:04 -0600
Message-ID: <CAPnjgZ0JdA5_2oF+hVEpSE4ztzOpjDMkxE2J6M6FfCx3TA+eww@mail.gmail.com>
Subject: Re: [PATCH 1/2] spl: make SYS_SPL_MALLOC depend on !(SPL_STACK_R &&
 SPL_SYS_MALLOC_SIMPLE)
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>
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

On Fri, 15 Sept 2023 at 11:51, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Currently, one can have both SYS_SPL_MALLOC=y and
> SPL_SYS_MALLOC_SIMPLE=y.
>
> However, while the former does make board_init_r() in spl.c call
> mem_malloc_init(), that has no effect at all, because that just
> updates a few bookkeeping variables, but as the linker map shows, the
> latter setting has (as expected) caused most of dlmalloc.o to be
> garbage-collected. That is, those bookkeeping variables are not used
> for anything.
>
> IOWs, with SYS_SPL_MALLOC=y and SPL_SYS_MALLOC_SIMPLE=y, the value of
> CONFIG_SYS_SPL_MALLOC_SIZE is irrelevant, and one still only has the
> small, SRAM-backed, malloc arena available.
>
> Now I want to change that so that the mem_malloc_init() instead
> updates the gd->malloc* variables to point at the SDRAM area.
>
> However, there's a small complication, namely when SPL_STACK_R=y is
> also in the mix. In that case, the "simple" malloc arena is indeed
> updated to point at the SDRAM area carved out of the new stack (see
> spl_relocate_stack_gd()). So that case works in the sense that one
> does get a "large" "simple" malloc arena (of size
> SPL_STACK_R_MALLOC_SIMPLE_LEN) - but CONFIG_SYS_SPL_MALLOC_SIZE is
> still irrelevant. Once I change the mem_malloc_init() logic, this
> would then break, because the gd->malloc* variables would be updated
> again. Also, it doesn't really make sense to allow the .config to
> essentially specify two different SDRAM-backed malloc arenas.
>
> So since CONFIG_SYS_SPL_MALLOC and its dependent options are no-ops
> currently when SPL_STACK_R && SPL_SYS_MALLOC_SIMPLE, simply forbid
> that combination.
>
> Simple grepping suggests that these boards/configs are affected, in
> that they become a tiny bit smaller, and the defconfig will need
> refreshing:
>
>   am62ax_evm_r5_defconfig
>   am62x_evm_r5_defconfig
>   am64x_evm_a53_defconfig
>   am64x_evm_r5_defconfig
>   am65x_evm_a53_defconfig
>   am65x_hs_evm_a53_defconfig
>   iot2050_defconfig
>   j7200_evm_a72_defconfig
>   j721e_evm_a72_defconfig
>   j721s2_evm_a72_defconfig
>   j721s2_evm_r5_defconfig
>   verdin-am62_r5_defconfig
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  common/spl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
