Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3844DCF9C6F
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 09:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B01788BAE;
	Mon, 23 Sep 2024 11:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ugW330yI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C6088BA7; Mon, 23 Sep 2024 11:49:19 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F0F88CE5
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 11:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so3365189a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727084955; x=1727689755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dy/+6zMzjDH7Bj90+yep4G6BqvbBj+y1gwjbJL1wTvk=;
 b=ugW330yI0bIlib4igvuCVNI3i+f903b0nuExvElbDKm4tQRZQ6k8SyclEwcfS0218v
 l3mmB4wjNGTxmoM4xr39ncvI9KghgxA/5yHfn4fqOVY9KfqIiiZH55t7euiFMPv+wivB
 MnFYLyLtgvQNoggVVpcZkoAlQX8AAcl2HM4c70TIRaUVjw53zYxWU+CZMpa6NSYGqXYp
 srzbNOlikWqhhdjwvFNBJCJKLNHuxtoBuIGh3bVlKLvte6MA1vvX7itzmUQnhUUT8CO8
 JAJH+hXITdYBbY9RuGI4t2Chnt7P+rfpnHMuOhaYIvX071xwn163DfPy+WLSmiAAcWTl
 3P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727084955; x=1727689755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dy/+6zMzjDH7Bj90+yep4G6BqvbBj+y1gwjbJL1wTvk=;
 b=fYYt66sVGa0UR8CFy3MiIaoiROXbu7rM4962neq3uI20JGemyPk/5YzfUDwogd8d40
 iAusVU5rYpA8SIBCpbqp8Rbh2e2DKu3Ap4ViE8u5tctAX/euP1N5njQ+DqvL7f7fNzY4
 VrDvk3nJhorL+UZgV8c9Hj//CmkqM65Z7nAxR2GmWyLVg8UYvewHiyu51Qft+eHprPp/
 icHwdHRglpfu8qYnY1pbcV3nJTIT2WKUIGDa7yeUHVLn5m+LP7pDU7U4wp0n2fNnfl9z
 7QlYAjiGTVIy16KWN3zPqOzbm2BbgCmo3Rfkn0zhNy06iU+nF7UHZuFwkJwa1p2qTVYv
 jfeQ==
X-Gm-Message-State: AOJu0YwE5zQFnk3T1EzbD3Yb4UdUs5pivmuxSHZ1/cyba232j8mXW3kc
 DNwxBYz7Jp6iyjxooYOUdTCK3R3YwGs9z7uTKs+2Bc8ZqIsUqQW8sssPQCFYMHWDE6VXcXjoZEc
 Fh+5QpSitCXm57r/Ymr6KF65o5VDbQyJbMDZrAw==
X-Google-Smtp-Source: AGHT+IHTfETs6d0YBCm4EbTdpNNoh0e06aBs2zIZqMheWnifFbzL6rjIirIcO+G0CHry3kAii5969MJcrdeugeiZE+o=
X-Received: by 2002:a05:6a21:1583:b0:1cf:38cf:dfb6 with SMTP id
 adf61e73a8af0-1d30a9aac1emr17874163637.20.1727084955378; Mon, 23 Sep 2024
 02:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-10-sjg@chromium.org>
In-Reply-To: <20240920072444.134997-10-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Sep 2024 12:48:38 +0300
Message-ID: <CAC_iWj+NMLSAmAqiDRMsSO+SWRKu=7rSFm+BkngO0kpOwRV1JQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] armv8: Support not having separate BSS
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Richard Henderson <richard.henderson@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
>
> Separate BSS is current mandatory on armv8 but this is not useful for
> early boot phases. Add support for the combined BSS.
>
> Use an #ifdef to avoid using CONFIG_SPL_BSS_START_ADDR which is not
> valid in this case.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm/cpu/armv8/u-boot-spl.lds | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> index 215cedd69a8..fed69644b55 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -13,8 +13,10 @@
>
>  MEMORY { .sram : ORIGIN = IMAGE_TEXT_BASE,
>                 LENGTH = IMAGE_MAX_SIZE }
> +#ifdef CONFIG_SPL_SEPARATE_BSS
>  MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
>                 LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
> +#endif
>
>  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
>  OUTPUT_ARCH(aarch64)
> @@ -56,12 +58,22 @@ SECTIONS
>         _end = .;
>         _image_binary_end = .;
>
> +#ifdef CONFIG_SPL_SEPARATE_BSS
>         .bss : {
>                 __bss_start = .;
>                 *(.bss*)
>                 . = ALIGN(8);
>                 __bss_end = .;
>         } >.sdram
> +#else
> +       .bss (NOLOAD) : {
> +               __bss_start = .;
> +               *(.bss*)
> +                . = ALIGN(8);
> +               __bss_end = .;
> +       } >.sram
> +#endif

This is still going to be separate. The only difference isn't that
it's not loaded. If you want to combine it with a region, you got to
do something similar to what we have in armv7, where it overlaps with
rel.dyn

Thanks
/Ilias
> +       __bss_size = __bss_end - __bss_start;
>
>         /DISCARD/ : { *(.rela*) }
>         /DISCARD/ : { *(.dynsym) }
> --
> 2.43.0
>
