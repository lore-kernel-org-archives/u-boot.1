Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F8C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 08:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293A988C9F;
	Tue, 20 Aug 2024 10:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RdsvHI+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E0188D47; Tue, 20 Aug 2024 10:17:21 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA1488C9F
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 10:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f3e2f07f41so14718421fa.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724141838; x=1724746638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wIeXYQiVrjBMcLy3BTnQEhG2gx6LHREvcfeCH+AQUr0=;
 b=RdsvHI+6N0q5E8js5beluJJeQvF1nNAVmuLnh4qoo0Ur7D/L1DFDAQBr5C7U8Zjogj
 GOg+LX9jEkiJcY3S2WFxbJVH8mgnzVsJ6HqNojKE1NUGLkw9ur8SlxjMRliXFF7KZIR3
 TCsivi7l+pHwbFnHvOKu84tD3cu23o+saFVNRtaVZ/W1oDCQzpCCT9e6COJKBwkjIUys
 SDHTtDFMv+rxEsVTbOJD0QHm7LEfHLaAueP6YIvQvaezECSn8zrrBkrdOo+A50YLhotb
 zlhzpFZEuZmi0aanaoEJI8mBwndVatRSaLvAvK6LGmJqPmqafAlsq9Z3zVyHnl9SEGfS
 gDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724141838; x=1724746638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIeXYQiVrjBMcLy3BTnQEhG2gx6LHREvcfeCH+AQUr0=;
 b=dVisq7DLL0lDxLn4Wr58a1nomqga3XGTjv+YCVIvCv6uvz0a6GMQtRuJavLPT0q3qz
 a5ypqr2dvy/IWZft52/fwf9Mch1ven38m4RkQ1GGLKtmOqnFADUTs42NUxj1EQul7eW5
 WQ7o5o7458byXANVkZsRx7utK3hmmcznQdKoxPVgxwRChINaZLz3/2qB7m8RhvWSXrrd
 FJiy/g0EWWcPTBke2GseypFuDFZVznlJgBZn37SkP2dJDg0rKIEwEpd8J5+70LH6BZta
 rsvyrfMHqHx4w6OeAFzHFsbFsil36/+u+qpGPCm5Mxj75u7YYD/WWMIauyAJ9y++GWkz
 /2Bg==
X-Gm-Message-State: AOJu0Yyka85tT9Oxvh+r6QQrkZhp7+2EtcpPKzB9pjOhxm5/02haLLKX
 rPsYLT16ME0cZeD2737yPMjOW+F4Mj7iOX8/nnc1xdKFIG6sEqo9x1wS8q6MKc5IKwYSdM/iklJ
 3I+FFdLQrzKuLM3/HbvvwC3lz8xzBrgzm+HtOwA==
X-Google-Smtp-Source: AGHT+IGbFHncu1nIPGqqJid/v3/co2ychTWD/E/3TjsadtLO+s+/I2vhornd/iHTGr4POhivC2bCYfhpjXAIIOHAGZc=
X-Received: by 2002:a2e:b895:0:b0:2f3:e2f0:f76 with SMTP id
 38308e7fff4ca-2f3e2f0127amr30344851fa.38.1724141837800; Tue, 20 Aug 2024
 01:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
 <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
In-Reply-To: <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 20 Aug 2024 13:47:06 +0530
Message-ID: <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] lmb: introduce a function to add memory to the
 lmb memory map
To: Simon Glass <sjg@chromium.org>
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

On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Introduce a function lmb_add_memory() to add available memory to the
> > LMB memory map. Call this function during board init once the LMB data
> > structures have been initialised.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Call the lmb_add_memory() from lmb_init() instead of
> >   lmb_mem_regions_init().
> >
> >
> >  include/lmb.h | 10 ++++++++++
> >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But this should not be weak.

This is being made weak, as there would be lmb_add_memory()
definitions added for powerpc and x86 arch's in the EFI part of my
patches. Moreover, the lmb_add_memory() function would be called even
in the SPL stage when LMB is enabled for that stage. So I am not sure
how do we get around this. You can check the relevant branch [1] on my
github to check for the specific commits [2][3] that I am referring
to. Thanks.

-sughosh

[1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_v3
[2] - https://github.com/u-boot/u-boot/commit/077ced7aaa6d495b1b87b324fb1c60658c203ce1
[3] - https://github.com/u-boot/u-boot/commit/d0fa3a89865b796f3bbebffebbe4f7b5b048c140

>
> > diff --git a/include/lmb.h b/include/lmb.h
> > index f6b2a81546..a82ea63d6c 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -63,6 +63,16 @@ struct lmb {
> >   */
> >  int lmb_init(void);
> >
> > +/**
> > + * lmb_add_memory() - Add memory range for LMB allocations
> > + *
> > + * Add the entire available memory range to the pool of memory that
> > + * can be used by the LMB module for allocations.
> > + *
> > + * Return: None
> > + */
> > +void lmb_add_memory(void);
> > +
> >  long lmb_add(phys_addr_t base, phys_size_t size);
> >  long lmb_reserve(phys_addr_t base, phys_size_t size);
> >  /**
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 3ccee26a46..f35a94c41b 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -225,6 +225,46 @@ static void lmb_reserve_common(void *fdt_blob)
> >                 efi_lmb_reserve();
> >  }
> >
> > +/**
> > + * lmb_add_memory() - Add memory range for LMB allocations
> > + *
> > + * Add the entire available memory range to the pool of memory that
> > + * can be used by the LMB module for allocations.
> > + *
> > + * This can be overridden for specific boards/architectures.
> > + *
> > + * Return: None
> > + *
> > + */
> > +__weak void lmb_add_memory(void)
> > +{
> > +       int i;
> > +       phys_size_t size;
> > +       phys_addr_t rgn_top;
> > +       u64 ram_top = gd->ram_top;
> > +       struct bd_info *bd = gd->bd;
> > +
> > +       /* Assume a 4GB ram_top if not defined */
> > +       if (!ram_top)
> > +               ram_top = 0x100000000ULL;
> > +
> > +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > +               size = bd->bi_dram[i].size;
> > +               if (size) {
> > +                       if (bd->bi_dram[i].start > ram_top)
> > +                               continue;
> > +
> > +                       rgn_top = bd->bi_dram[i].start +
> > +                               bd->bi_dram[i].size;
> > +
> > +                       if (rgn_top > ram_top)
> > +                               size -= rgn_top - ram_top;
> > +
> > +                       lmb_add(bd->bi_dram[i].start, size);
> > +               }
> > +       }
> > +}
> > +
> >  static long lmb_resize_regions(struct alist *lmb_rgn_lst,
> >                                unsigned long idx_start,
> >                                phys_addr_t base, phys_size_t size)
> > @@ -674,5 +714,7 @@ int lmb_init(void)
> >                 return ret;
> >         }
> >
> > +       lmb_add_memory();
> > +
> >         return 0;
> >  }
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
