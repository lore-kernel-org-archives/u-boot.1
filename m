Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EFEC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 275DB88C5C;
	Fri, 23 Aug 2024 22:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R9IEoJbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C834288915; Fri, 23 Aug 2024 22:47:40 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9B788936
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6bf8a662467so11269546d6.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446057; x=1725050857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X2wotS6Uu+6uMPqrYwLUteQdeoVdfq4BIDlV8rxfTkE=;
 b=R9IEoJbnArA/hEo0buAV5/KwiOY1Hh7/zix3s6scv2CUfBp9K84/B2XJLMk3MpbP2t
 A5LxuL7ov3roD5d5G1igkClkUTuKbcGcqp0t2vQhRhOQjVumj+sdaPORT5cbX03UwzXf
 MtEhJrj+su86v2W7UETHbYX8hVuk+f8aFJpo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446057; x=1725050857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2wotS6Uu+6uMPqrYwLUteQdeoVdfq4BIDlV8rxfTkE=;
 b=SvzxI9mR1bbbLPTI4eAwrNyhKkNobXAKzMa6L7EYqmBYE761sH6fAb6lnwFytF8ila
 QbzygtfK9F3aDLqWPOZJfgrZRuvAFPQYdq3EfKRxzx61azM3zhzQ46oANR5761DXcQz6
 7piTCz0SZ9MKI9gvek1YHx9ymGe6GUGTPgzs6GdV2lAEnmea2Fu1GwnTyx/InCKdeTvK
 u/XJLBURgzXi6zSF9C1eJpaAXSItzE98ntcdhYIqFRI2T747IjTvy96icYnT26p6pCvt
 lLxWoC8gBYAWGy4klbXEwUCmoVFtDCPavzdV4RC9vmjw1Y3B0INzEyA/SpE2TNI5gA4N
 Hwcw==
X-Gm-Message-State: AOJu0Yx1pNVTS3sKLVk1hjPEeMgjjgQ2u/IzozFHvCVI36ZeH7aivrUb
 u0QoQogfZ8A54cDhpquyb3JzHED664wJQiHvECrh7L4LK2I59TRlUfk3dfetmklAd4f9fg7tn4W
 JAZQTvpKrqPPJctZF+zcc7BKYZ8/sj8K0EkdF
X-Google-Smtp-Source: AGHT+IHPMuv73g92rIHXlvvNsyqBhvMQhQSnapB+nwl5mEkK5zXM4bmvHceJ/2cJdSAn4AbiRfLgzcmvogO1x4WlejY=
X-Received: by 2002:a05:6214:5981:b0:6bd:69a1:7667 with SMTP id
 6a1803df08f44-6c16dcbfcfamr38891726d6.39.1724446057668; Fri, 23 Aug 2024
 13:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-19-sughosh.ganu@linaro.org>
In-Reply-To: <20240821105839.2870293-19-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:27 -0600
Message-ID: <CAFLszTiogW5dvXb+C86NDsD273CjgszEkEp_YsYqCK2S9SHaVg@mail.gmail.com>
Subject: Re: [PATCH v3 18/27] lmb: remove the unused board_lmb_reserve()
 function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

On Wed, 21 Aug 2024 at 05:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The board_lmb_reserve() function is not being used, and currently
> there is only an empty weak function defined. Remove this unused
> function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: New patch
>
>  include/lmb.h | 2 --
>  lib/lmb.c     | 6 ------
>  2 files changed, 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

One less weak function!


>
> diff --git a/include/lmb.h b/include/lmb.h
> index 6e435bd35c..79bd2457d3 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -107,8 +107,6 @@ long lmb_free(phys_addr_t base, phys_size_t size);
>  void lmb_dump_all(void);
>  void lmb_dump_all_force(void);
>
> -void board_lmb_reserve(void);
> -
>  #if CONFIG_IS_ENABLED(UNIT_TEST)
>  struct lmb *lmb_get(void);
>  int lmb_push(struct lmb *store);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 1116b2b868..11959760b6 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -221,7 +221,6 @@ static void lmb_reserve_uboot_region(void)
>
>  static void lmb_reserve_common(void *fdt_blob)
>  {
> -       board_lmb_reserve();
>         lmb_reserve_uboot_region();
>
>         if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
> @@ -688,11 +687,6 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags)
>         return 0;
>  }
>
> -__weak void board_lmb_reserve(void)
> -{
> -       /* please define platform specific board_lmb_reserve() */
> -}
> -
>  static int lmb_setup(void)
>  {
>         bool ret;
> --
> 2.34.1
>
