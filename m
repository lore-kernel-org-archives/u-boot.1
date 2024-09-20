Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD30CF9C58
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CB688B1F;
	Fri, 20 Sep 2024 17:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Anv6/S/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B9D88883; Fri, 20 Sep 2024 17:59:24 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 753B988B49
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c35b72f943so19144926d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847960; x=1727452760; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XLKCg/IJFL8dR14RVBEJTol/L4dxaesX08xJgDQiRqI=;
 b=Anv6/S/XG3jESDh0WMxps4/d9ZY5WN+ccglOIzrlU/smTgC9NQUn0SOsfb6DkbbwqV
 spr6WWUpXoXbDCVbMgQVxYSSyK54UO7mu2A8VvgaVVuygW7wPryDjmeS73Av6AO9ClnW
 JR2rqN4TQr+qkWA/EWUUG0k7kTz8rCiNjdqFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847960; x=1727452760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLKCg/IJFL8dR14RVBEJTol/L4dxaesX08xJgDQiRqI=;
 b=hn/ertS9Btn6US8uUt53XUf4Z2OFFnySScQ5RFU8jp+KOGddf0cWW+O5I7C31odFRF
 FrwbNoa7akBAt9zTHJDa41jqDx7YW246L2C/mkg/u7X/ZNu+gdbg5NV/XIIgGWH3umTl
 v7MM0SsYV31RY+c0rQUQGgAr85C1tZAc0arCTrsmC6bnXuTobYff7opcjYsQ3eCtRTgq
 9nEfyMtzKcviA+9p/lLJfYT+2vZD32hDu8/4YRMsGNXqP3tIj1ej/f1WOqVztzbfxpNi
 BNImaKH5AogrocGafD6lUppmSMUJTQFaKySKTLVk7ncEBRG+eRO+hN7JqOzAU61KuDsR
 YkKQ==
X-Gm-Message-State: AOJu0YwF4M/a+sUZuGr1UetIeDxFZHjo6AzSOIon7xiTXatKD5EqY4pU
 jjBrmQ1wzoGEQvTxA2WVlyjUlC97hmlLaep//VWd+UMC1YhP/yYq+AFvcAm3at/cvlswJbYm5Ly
 fRzB0Os2xAZPI7VNq2rWbfiPkhoduSL4X/o0yfbIwrZeslr0saW3B
X-Google-Smtp-Source: AGHT+IE8DPQTFQPSWNF0CXQfhBPQCmYGYzZEnYqLX9v62JcwE50AXCoXyg66nIjI4wl9o2POh0bjSVH4OTWUDA+BsE8=
X-Received: by 2002:a05:6214:4a02:b0:6c5:54e4:be44 with SMTP id
 6a1803df08f44-6c7bb9b508dmr61502436d6.8.1726847960267; Fri, 20 Sep 2024
 08:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240920081309.140426-1-sjg@chromium.org>
 <20240920081309.140426-5-sjg@chromium.org>
In-Reply-To: <20240920081309.140426-5-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:59:10 +0200
Message-ID: <CAFLszTiD5Cz5Vauj-aJ+0BvAKkd4BHu-maPtDJRiQyBcOm232w@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] boot: Respect the load_op in fit_image_load()
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
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

On Fri, 20 Sept 2024 at 10:13, Simon Glass <sjg@chromium.org> wrote:
>
> Some code has crept in which ignores this parameter. Fix this and add a
> little debugging.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  boot/image-fit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>

As requested:

Fixes: b1307f884a9 ("fit: Support compression for non-kernel
components (e.g. FDT)")

Or at least that is my reading of the situation


> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 439ff51edf6..db7fb61bca9 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2226,6 +2226,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>         data = map_to_sysmem(buf);
>         load = data;
>         if (load_op == FIT_LOAD_IGNORED) {
> +               log_debug("load_op: not loading\n");
>                 /* Don't load */
>         } else if (fit_image_get_load(fit, noffset, &load)) {
>                 if (load_op == FIT_LOAD_REQUIRED) {
> @@ -2262,10 +2263,13 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>         /* Kernel images get decompressed later in bootm_load_os(). */
>         if (!fit_image_get_comp(fit, noffset, &comp) &&
>             comp != IH_COMP_NONE &&
> +           load_op != FIT_LOAD_IGNORED &&
>             !(image_type == IH_TYPE_KERNEL ||
>               image_type == IH_TYPE_KERNEL_NOLOAD ||
>               image_type == IH_TYPE_RAMDISK)) {
>                 ulong max_decomp_len = len * 20;
> +
> +               log_debug("decompressing image\n");
>                 if (load == data) {
>                         loadbuf = malloc(max_decomp_len);
>                         load = map_to_sysmem(loadbuf);
> @@ -2280,6 +2284,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>                 }
>                 len = load_end - load;
>         } else if (load != data) {
> +               log_debug("copying\n");
>                 loadbuf = map_sysmem(load, len);
>                 memcpy(loadbuf, buf, len);
>         }
> @@ -2289,8 +2294,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>                      " please fix your .its file!\n");
>
>         /* verify that image data is a proper FDT blob */
> -       if (image_type == IH_TYPE_FLATDT && fdt_check_header(loadbuf)) {
> -               puts("Subimage data is not a FDT");
> +       if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
> +           fdt_check_header(loadbuf)) {
> +               puts("Subimage data is not a FDT\n");
>                 return -ENOEXEC;
>         }
>
> --
> 2.43.0
>
