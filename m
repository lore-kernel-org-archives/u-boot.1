Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F4E95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D443D86F0C;
	Sun,  8 Oct 2023 01:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="OgnB0E6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B5786D61; Sun,  8 Oct 2023 01:12:23 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDF886EC6
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a505762c9dso40754127b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8lYYVm91pBV7qU1FZVOnZ0/8TRj+hosvtLu6vZrv674=;
 b=OgnB0E6UFJnAZO2ZdlGbeaYf8J58K+192t46X5/yOYdyLJHa7Gzr9+S36eA3i8t877
 k1jXkAMkCmcbAhUqMB2Sem/87raPGhlOR5XmamK6Jvt6eSvKUJjXG14nuaa5MoYKxsxC
 vlzGHN7RD4tJuZ+C4yW8huuLT0wrCbsgNQwcSWy+ZoIzcbe47u8f9uEPVHyVUdbRHohi
 qCgJ4iaXzgCbU0BOqK3jYAqroEY6Fbaqn/j9hENiZ0AyM+9VVTcj01E/srO3Qk7KbEDS
 YO/XQFL6lB8A09uazFe6X8avElN5zBnkju81caRo1fRH7W7uq3ye/TdIji42p6f64sqf
 YeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lYYVm91pBV7qU1FZVOnZ0/8TRj+hosvtLu6vZrv674=;
 b=oOmGeSRqkgEYcOMDed2KtlvOX9E7MW+HRekGhVTM7TgNfOKCe6gdygyV7B5qjVq8hB
 uDrMhZ8juUwM7pPkHmlEaebgXXbx/TovcxbtF08aMDh6vyi6ooxmdwIoPVp1MqWdx4hG
 t1BuLnzfsoVS2P3r8JlvfGmHyEhTIDw5nshrzmLvuNBQ668GMket1DtuxOw4+Lh47tC2
 nCq7DSGACnAhcrHDqikBOCGYF0hQ0VkCAUcIvm3UyVqHLIBUvWZJeKUGUcww+51S3JQT
 K6ffgz01t1yI6FlDCX9vxMP9nXElhkDDFTrjEiczKx0PCt4b+dl0y57IhmLyY+1Uzq6s
 cd8g==
X-Gm-Message-State: AOJu0YwcSpytcV4tMJek4gdpuk+MN57VezU2IjZzJ2ArkIyIzgFmRWhG
 2zUwVLu/Rnd7c+9MW0wH3KEZ4ldHD7HF0xR4cY1rCA==
X-Google-Smtp-Source: AGHT+IFOB60RdCjxAKQr+pN+52+CTbotGbYRqwo2ck045Kl/2dWY4OjKxa/FBVgdxcbnj3LW4L1Oh5WV35sEDsKl6NY=
X-Received: by 2002:a0d:ddc2:0:b0:59b:e97e:f7ce with SMTP id
 g185-20020a0dddc2000000b0059be97ef7cemr12769007ywe.22.1696720299237; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231006112351.2275090-1-randolph@andestech.com>
 <20231006112351.2275090-6-randolph@andestech.com>
In-Reply-To: <20231006112351.2275090-6-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 17:09:58 -0600
Message-ID: <CAPnjgZ3ep=2D_Sv17T6re46jRmrrPOdWpGrBOWS-2T71Hp+17A@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/7] spl: riscv: add os type for next booting stage
To: randolph@andestech.com
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

Hi Randolph,

On Fri, 6 Oct 2023 at 05:27, Randolph <randolph@andestech.com> wrote:
>
> If SPL_LOAD_FIT_OPENSBI_OS_BOOT is enabled, the function
> spl_invoke_opensbi should change the target OS type to IH_OS_LINUX.
> OpenSBI will load the Linux image as the next boot stage.
> The os_takes_devicetree function returns a value of true or false
> depending on whether or not SPL_LOAD_FIT_OPENSBI_OS_BOOT is enabled.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  common/spl/spl_fit.c     | 4 ++++
>  common/spl/spl_opensbi.c | 7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 730639f756..750562721a 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -351,7 +351,11 @@ static bool os_takes_devicetree(uint8_t os)
>         case IH_OS_U_BOOT:
>                 return true;
>         case IH_OS_LINUX:
> +#ifdef CONFIG_RISCV

Can you not set CONFIG_SPL_OS_BOOT in this case, and avoid this extra
condition? We really don't want arch-specific code in a generic file.

> +               return IS_ENABLED(CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT);
> +#else
>                 return IS_ENABLED(CONFIG_SPL_OS_BOOT);
> +#endif
>         default:
>                 return false;
>         }
> diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
> index a0c5f35dab..708869ad48 100644
> --- a/common/spl/spl_opensbi.c
> +++ b/common/spl/spl_opensbi.c
> @@ -58,9 +58,14 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
>
>         /*
>          * Find next os image in /fit-images
> -        * The next os image default is u-boot proper
> +        * The next os image default is u-boot proper, once enable
> +        * OpenSBI OS boot mode, the OS image should be linux.
>          */
> +#if CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT)
> +       os_type = IH_OS_LINUX;
> +#else
>         os_type = IH_OS_U_BOOT;
> +#endif

Please use if().

>         ret = spl_opensbi_find_os_node(spl_image->fdt_addr, &os_node, os_type);
>         if (ret) {
>                 pr_err("Can't find %s node for opensbi, %d\n",
> --
> 2.34.1
>

Regards,
Simon
