Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40D0C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA8A88C82;
	Thu, 15 Aug 2024 22:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/Gggz1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 953E988107; Thu, 15 Aug 2024 22:34:37 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ED6988C6E
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d3c396787cso979940a91.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754073; x=1724358873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+r9j+Dpn6tu2OvfENxzQwDP5SPSs7XOy4QOmrh7joUg=;
 b=m/Gggz1mqtibX9PaSDTqYueTpGhhWPjfM+Ke4kIhTXcO59NKiuxOsp4aolAkra7iy1
 MkA/tREUl0ITnDfhIBSn0vmKS4XiVFu/eaDeW6ZcO+ZLn31cRwehlBy3hxpAthbCK5sP
 z6DdG79iJTVgThfWXX6VbvOPM3Q2iEnJF/d5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754073; x=1724358873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+r9j+Dpn6tu2OvfENxzQwDP5SPSs7XOy4QOmrh7joUg=;
 b=uIG/8TB+3YONfU0hn4hn81plP8vJ4QBq0lnYqH57nZvPgdUAyzq9qOZBqomyQdgkHP
 1eXK3TSI2hxcRImOZWrMRqngjYbc5PlRsICphpSGCEstnpIYSEUHIcxt3G98AX8TML5B
 nS/wlVaaNZHnZWM1Tw4EBX9FSLPLccg5DapQLuZy7YLly3KFeBLldZZcBkMnpVnXBO+Q
 h0dXvZv0mRoRJuaxubeBjGytaynKSVtb0Dbuv/DgeaboUgdU9QYvT3Fqp0QXpS3XWasd
 BDgPXNIScKP2cDTymAJ9eOj4U3yFg0gOiNPa9kG0ksD31YhuHA6lwWrNlTr1Dgb+ovMl
 jYSQ==
X-Gm-Message-State: AOJu0YxA401va8S5AgTNsFdmP0RZDS82okoITFsNalFJzzvK4kcK+eN5
 JHfVahKZw3pywtPDQ41E6f1eXLFIbaTG2iMkKWayyJ2iGjlC0KGtBnQkZPbGC6S3AKJHIyOOrtX
 Q8FYBnaB9c2CB6jUDla8L9xyDC4+kXVRNbfYz
X-Google-Smtp-Source: AGHT+IGdS3ssj0sTd5f5lpSs43TuYvFheNnECuDOwf057C6lnf/04HzRHMqWdBndCGSsyFzs1bLl+il2+d2mh71vdGQ=
X-Received: by 2002:a17:90a:e018:b0:2c9:9f2a:2b20 with SMTP id
 98e67ed59e1d1-2d3dfc89089mr1002152a91.22.1723754073556; Thu, 15 Aug 2024
 13:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-18-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-18-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:34:22 +0100
Message-ID: <CAFLszThRP1Grj3iM9o-LtQFOXm+xPGovdFo6QMaAKF+RvcrNzg@mail.gmail.com>
Subject: Re: [PATCH v2 17/32] lmb: init: initialise the lmb data structures
 during board init
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
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

On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The memory map maintained by the LMB module is now persistent and
> global. This memory map is being maintained through the alloced list
> structure which can be extended at runtime -- there is one list for
> the available memory, and one for the used memory. Allocate and
> initialise these lists during the board init.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Move the initr_lmb() function to board_r.c
> * Call lmb_init() from spl.c instead of initr_lmb().
>
>  common/board_r.c | 17 +++++++++++++++++
>  common/spl/spl.c |  3 +++
>  2 files changed, 20 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

> diff --git a/common/board_r.c b/common/board_r.c
> index f445803d7a..0943ed3d01 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -22,6 +22,7 @@
>  #include <hang.h>
>  #include <image.h>
>  #include <irq_func.h>
> +#include <lmb.h>
>  #include <log.h>
>  #include <net.h>
>  #include <asm/cache.h>
> @@ -510,6 +511,21 @@ int initr_mem(void)
>  }
>  #endif
>
> +static int initr_lmb(void)
> +{
> +#if CONFIG_IS_ENABLED(LMB)

This should use if()

> +       int ret;
> +
> +       ret = lmb_init();
> +       if (ret)
> +               printf("Unable to initialise the LMB data structures\n");
> +
> +       return ret;
> +#else
> +       return 0;
> +#endif
> +}
> +
>  static int dm_announce(void)
>  {
>         int device_count;
> @@ -612,6 +628,7 @@ static init_fnc_t init_sequence_r[] = {
>  #ifdef CONFIG_CLOCKS
>         set_cpu_clk_info, /* Setup clock information */
>  #endif
> +       initr_lmb,
>  #ifdef CONFIG_EFI_LOADER
>         efi_memory_init,
>  #endif
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index d6a364de6e..4102e25115 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -723,6 +723,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>             IS_ENABLED(CONFIG_SPL_ATF))
>                 dram_init_banksize();
>
> +       if (IS_ENABLED(CONFIG_SPL_LMB))
> +               lmb_init();
> +
>         if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
>                 ret = pci_init();
>                 if (ret)
> --
> 2.34.1
>

Regards,
Simon
