Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F344CC021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 06:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 258C6801DE;
	Thu, 20 Feb 2025 07:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wc24en+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E69A80A46; Thu, 20 Feb 2025 07:57:44 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A059E801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 07:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so488350276.3
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 22:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740034660; x=1740639460; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sKBOYrbN85yLLyrw7FrDCWANn0opBBQk2JIu5fdFmR4=;
 b=wc24en+a7JMciHgwYcrQuuTrFlOJwcRbgsyNZABcH2F3IBSSOHJgPvcyiZBJGKTW+j
 XMGFikP4w2CNq85G08fcU1XwlyMNi+CbCjAePLeNkntYD1QzeZVt3NOTEmGN6idaue84
 QmeEKhrFbGaubUIMHjMPVIy0s4/vNdlvv++u745gXQL0PpKn07rZHMjw8TnS77dGv/K4
 LdyvExLgMhjJDTQtnVDU+xr2yZbOvq+wydXFlRDy/6r8/kFsm3SQtbgeUITIbKTopo/Q
 glEzNv67ZfVwl18tvrWG2/bFYdtrB/Y2qQisD+3ahML61LmPjqspib0CNMJcxbkNZoSk
 zwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740034660; x=1740639460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKBOYrbN85yLLyrw7FrDCWANn0opBBQk2JIu5fdFmR4=;
 b=UjRlz2n1ydndQXBJFL/JiXi4v8ZpWfP/VK9MHjlJPEmgPeW7lBNQ5Itn44Bd//HrrN
 63e+/ShMto5oawQkuD18bBvidVHlYsCDCTwvt2S/updNh4cSyhfoFl4ggqLKqrlL7LI+
 HuO77+3JsWS4YxeYkOF6JK2jOTkp0VpSTBJSXkr0SC2FZcHLKYoNnQPptTfPYwzsBhXc
 6RKl66ohX3Y3idWoeSCRcptNUJBNDN/cVIo6P3tPECKAmxMXY1o5YBC64PRdOL5BBfMr
 6UA7H1jC34IIN8AeDlhjaE4wPSJCpthd73V+L6uqaiB35szYA8POVbDM4ehwzJDSdv6Q
 6cfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN0+E8ITusAY19yHKgnaeIgoN0cI2DXni3FPEACwnjfPrw0ny610npE2AklKKlYyx6dsTawLg=@lists.denx.de
X-Gm-Message-State: AOJu0YwRfLS4IsSc5TgNKW9henpS0kZU/GXjtb5q1vqST7VsnMynRASv
 KuE87TNM4CtWYUndX4/ZBVu7yqd8GcZLB1IanNwUehHGgr3WN/yGCM2isfYNUMq3iGh0XDGpAop
 fHuqe/4hjkt4HQP/bA/tO7Ur24IuwriwuoDlGmw==
X-Gm-Gg: ASbGnctJyZk+DvSWjcfAQHCpYJPRVrLtKHPiu3JavaXd4rA9eEej3OY0kA9fRz9O0ag
 SpIz4Qdlf4F8IulfT4Jew/wf1vqMEuE845bnquR7Nke1lLIiLRSNSIMUFMVSJVu7wd0IId1lpvQ
 ==
X-Google-Smtp-Source: AGHT+IFNyygx3dBRRC3DkYKTBVPWzhKHb0XK7Owe5ahhzS81a24qHMkWsBQyLrl6uIFIx6lKhHD9fKPVdX4A32Je6SY=
X-Received: by 2002:a05:6902:1b12:b0:e5b:21e4:d891 with SMTP id
 3f1490d57ef6-e5e0a0de7c5mr5497284276.29.1740034660230; Wed, 19 Feb 2025
 22:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
 <20250216111241.6846-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250216111241.6846-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 08:57:03 +0200
X-Gm-Features: AWEUYZkrcWekK-2dhM-GuSryHoobwQ08-XstlOLfHT69ZUocGO-pBS0UYwnCbDE
Message-ID: <CAC_iWjKW0S6MzQ7c9cAtD0PH62pM1rBh5UkkS_jqTkmmeV7iug@mail.gmail.com>
Subject: Re: [PATCH 1/3] lmb: avoid superfluous value check in
 lmb_map_update_notify()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Liya Huang <1425075683@qq.com>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de
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

On Sun, 16 Feb 2025 at 13:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Instead of testing the value of parameter op at runtime use an enum to
> ensure that only valid values are used.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/lmb.h | 12 ++++++++++++
>  lib/lmb.c     | 23 +++++++----------------
>  2 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index d9d7435a431..09297a4f530 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -31,6 +31,18 @@
>  #define LMB_NOOVERWRITE BIT(1)
>  #define LMB_NONOTIFY BIT(2)
>
> +/**
> + * enum lmb_map_op - memory map operation
> + */
> +enum lmb_map_op {
> +       /** @LMB_MAP_OP_RESERVE:        reserve memory */
> +       LMB_MAP_OP_RESERVE = 1,
> +       /** @LMB_MAP_OP_FREE:           free memory */
> +       LMB_MAP_OP_FREE,
> +       /** @LMB_MAP_OP_ADD:            add memory */
> +       LMB_MAP_OP_ADD,
> +};
> +
>  /**
>   * struct lmb_region - Description of one region
>   * @base: Base address of the region
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7ca44591e1d..7534a231c99 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -23,10 +23,6 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> -#define MAP_OP_RESERVE         (u8)0x1
> -#define MAP_OP_FREE            (u8)0x2
> -#define MAP_OP_ADD             (u8)0x3
> -
>  /*
>   * The following low level LMB functions must not access the global LMB memory
>   * map since they are also used to manage IOVA memory maps in iommu drivers like
> @@ -436,18 +432,13 @@ static bool lmb_should_notify(u32 flags)
>                 CONFIG_IS_ENABLED(EFI_LOADER);
>  }
>
> -static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
> -                                u32 flags)
> +static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
> +                                enum lmb_map_op op, u32 flags)
>  {
>         u64 efi_addr;
>         u64 pages;
>         efi_status_t status;
>
> -       if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
> -               log_err("Invalid map update op received (%d)\n", op);
> -               return -1;
> -       }
> -
>         if (!lmb_should_notify(flags))
>                 return 0;
>
> @@ -456,7 +447,7 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
>         efi_addr &= ~EFI_PAGE_MASK;
>
>         status = efi_add_memory_map_pg(efi_addr, pages,
> -                                      op == MAP_OP_RESERVE ?
> +                                      op == LMB_MAP_OP_RESERVE ?
>                                        EFI_BOOT_SERVICES_DATA :
>                                        EFI_CONVENTIONAL_MEMORY,
>                                        false);
> @@ -642,7 +633,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>         if (ret)
>                 return ret;
>
> -       return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
> +       return lmb_map_update_notify(base, size, LMB_MAP_OP_ADD, LMB_NONE);
>  }
>
>  long lmb_free_flags(phys_addr_t base, phys_size_t size,
> @@ -654,7 +645,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
>         if (ret < 0)
>                 return ret;
>
> -       return lmb_map_update_notify(base, size, MAP_OP_FREE, flags);
> +       return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
>  }
>
>  long lmb_free(phys_addr_t base, phys_size_t size)
> @@ -671,7 +662,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
>         if (ret)
>                 return ret;
>
> -       return lmb_map_update_notify(base, size, MAP_OP_RESERVE, flags);
> +       return lmb_map_update_notify(base, size, LMB_MAP_OP_RESERVE, flags);
>  }
>
>  static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
> @@ -712,7 +703,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>                                         return 0;
>
>                                 ret = lmb_map_update_notify(base, size,
> -                                                           MAP_OP_RESERVE,
> +                                                           LMB_MAP_OP_RESERVE,
>                                                             flags);
>                                 if (ret)
>                                         return ret;
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
