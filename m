Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C59DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C588770B;
	Sat,  2 Dec 2023 19:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JFnpl/xX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DECE876FF; Sat,  2 Dec 2023 19:32:25 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D9A877BD
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54c967010b2so696003a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541942; x=1702146742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P5BTEF7obGuwvOahC54rKlf1jDft5DntZ4Zl4gKP+TM=;
 b=JFnpl/xXciBHShNert6kn9qgBmHyQvK/2HJnXJRNsff9wKNsG7mRctWjtXL991BBol
 CuU3Fxjgd0F1vkJEd+MqHgnC18Kq95kxn5kcCZCWhn6LV9nXsHV7q11IRmwubKBMHEd8
 H+O3HsZsrxi9jYzbaNsfL71kSlyL0Hwn3dEbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541942; x=1702146742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P5BTEF7obGuwvOahC54rKlf1jDft5DntZ4Zl4gKP+TM=;
 b=OoI23mPsoU9pGxSZ7lKI+TVQUB+BkNNDTEp/42Usv7lY5rAkqFeT6Edc5vBReCHDaD
 He8lN8kfiD0whZHYdI8F6asQwvJlj13q/ozN4/eIyoMSZxtCMwHm4Vu0OQV4youlwSWC
 Jfrf5j42Vm9JtBTiOSxpsZOCP+gFXX4ejpmE1qzZE/PqS+dXillF76Hs6R/saURnPNpm
 zLkJdgVu7gnJIYiF4QXHvH6d7UQqktdviri+782wwUYp9bfWof1Oj4fCxdzoSxJqLlxO
 tcAyXnie5/RlQeNyptpwZ3qXgcrOIOhQFE4vjDVx1jeGNudaOGDgPrBBFgZdP8eTgWfw
 o6Cw==
X-Gm-Message-State: AOJu0YzDjL4DBXUmMYykYhjkcQeTAAZmqOg//YiAnqGT6xq3ZQT5QQr3
 +K7euggRGza9PN2dg4aCmBGC4gpKIGQxt9wr1ONiAg==
X-Google-Smtp-Source: AGHT+IGRfqDH+fwaKExlYiNbhDbffGf3lZ/myy0BEGcz3GztL+Ctn9tk0fAdKcxuL6+rahoDRzgU5iJZuWXLLp/wcQg=
X-Received: by 2002:a17:906:3b18:b0:a19:a409:37d0 with SMTP id
 g24-20020a1709063b1800b00a19a40937d0mr3622968ejf.41.1701541942302; Sat, 02
 Dec 2023 10:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-19-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-19-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:52 -0700
Message-ID: <CAPnjgZ0yJNrpSV7dxmJky_QynEmPQQv5mTXT9MRTdn8rhVxpEg@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] bloblist: Load the bloblist from the previous
 loader
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
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

Hi Raymond,

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> During bloblist initialization, when CONFIG_OF_BOARD is defined,
> invoke the platform custom function to load the bloblist via boot
> arguments from the previous loader.
> If the bloblist exists, copy it into the fixed bloblist memory region.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
>
>  common/bloblist.c  | 29 +++++++++++++----------------
>  include/bloblist.h | 14 ++++++++++++++
>  2 files changed, 27 insertions(+), 16 deletions(-)
>

This should already work so I am hoping that this patch is not
needed...these changes seem to break sandbox_spl

> diff --git a/common/bloblist.c b/common/bloblist.c
> index 91d69e9439..251093ecfa 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -477,15 +477,8 @@ int bloblist_init(void)
>         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>         int ret = -ENOENT;
>         ulong addr, size;
> -       bool expected;
> -
> -       /**
> -        * We don't expect to find an existing bloblist in the first phase of
> -        * U-Boot that runs. Also we have no way to receive the address of an
> -        * allocated bloblist from a previous stage, so it must be at a fixed
> -        * address.
> -        */
> -       expected = fixed && !u_boot_first_phase();
> +       bool expected = fixed;
> +
>         if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
>                 expected = false;
>         if (fixed)
> @@ -493,14 +486,17 @@ int bloblist_init(void)
>                                       CONFIG_BLOBLIST_ADDR);
>         size = CONFIG_BLOBLIST_SIZE;
>         if (expected) {
> -               ret = bloblist_check(addr, size);
> -               if (ret) {
> -                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> +               if (IS_ENABLED(CONFIG_OF_BOARD))
> +                       /* Get the bloblist from previous loader */
> +                       ret = board_bloblist_from_boot_arg(addr, size);
> +               else
> +                       ret = bloblist_check(addr, size);
> +
> +               if (ret)
> +                       log_warning("Bloblist at %lx not found, err=%d\n",
>                                     addr, ret);
> -               } else {
> -                       /* Get the real size, if it is not what we expected */
> +               else
>                         size = gd->bloblist->total_size;
> -               }
>         }
>         if (ret) {
>                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> @@ -510,7 +506,8 @@ int bloblist_init(void)
>                                 return log_msg_ret("alloc", -ENOMEM);
>                         addr = map_to_sysmem(ptr);
>                 } else if (!fixed) {
> -                       return log_msg_ret("!fixed", ret);
> +                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> +                                          ret);
>                 }
>                 log_debug("Creating new bloblist size %lx at %lx\n", size,
>                           addr);
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 0f5afec9f4..e65cd27b90 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -438,6 +438,20 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
>   */
>  int bloblist_init(void);
>
> +#if CONFIG_IS_ENABLED(ARCH_QEMU)
> +int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size);
> +#else
> +/*
> + * A board need to implement this custom function if it needs to retrieve
> + * bloblist from a previous loader
> + */
> +static inline int board_bloblist_from_boot_arg(unsigned long __always_unused addr,
> +                                              unsigned long __always_unused size)
> +{
> +       return -1;
> +}
> +#endif
> +
>  #if CONFIG_IS_ENABLED(BLOBLIST)
>  /**
>   * bloblist_maybe_init() - Init the bloblist system if not already done
> --
> 2.25.1
>

Regards,
Simon
