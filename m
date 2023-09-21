Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F45CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7E586D66;
	Thu, 21 Sep 2023 03:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gUFfawat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4B386D21; Thu, 21 Sep 2023 03:06:07 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 158A186D30
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59bdad64411so5287027b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kYpzFxmPDJqfSb8/5EDk5QvnOjjIpz880kOQ4u1zTZQ=;
 b=gUFfawatHLLCuPlkVoY1D8hPEh+JZLR7/PFyEz2wpOVT8KRWnErCdEZhAPdAkyCEHQ
 ylAls49UWIwmrCFEjOpaeeIfU99kByjwXs2i6KK33gbR10ZJGKcvEIhJJRvn2IR3V7os
 wXZ/x8kDd+NjnjBVYZ1ynYmELBO7kJo5Fa1dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kYpzFxmPDJqfSb8/5EDk5QvnOjjIpz880kOQ4u1zTZQ=;
 b=jVquTyC9TX0DNnDAXhMwrGpkvD7+HIj0J3TlJpS6MeslAfteNy3U0JzIANfDm5ecOM
 QvQrJLsXuDx1EftvKPv+PebUU/K/UxOczA0PeAQG0or63gAVTXtV8WgfCETEED2v6zua
 gbWc1TsdaZp43skL+MQN7j0TejUfKtDSk96s2z3Ki8jDJOIeFtzFpg+JDYJ+GP067uy/
 bgraKmno0hNhpFpryDtPxWxZksQx/ubPAYCP4ZzDUuzDVlI0YA0kOtwvOYTGS8vkJ4Nf
 5PCSBjyNoguinrpZ4W1/cT2itJF4z1WKRZg9RmPl2U2u1rvI96Ibi0DWzqlg/fPHOw7K
 OLrw==
X-Gm-Message-State: AOJu0YwlPUxYJ/lBQjzj3E5AV/4DxFG1e1L+EXMsoPK+anBRL5NyqJxG
 b6PTbnLfIIGbUcypjcgAb+qinHJVIZHEpjItpuaq+Q==
X-Google-Smtp-Source: AGHT+IF2cCI+hOKcfMjyYxkLWKLj8knvvj/etX2Jl2rP+VO7WChAvbkc7cjF+ECBbRghW9oXmW+7/APW9GsRswCJzRQ=
X-Received: by 2002:a81:4e84:0:b0:58d:7599:676a with SMTP id
 c126-20020a814e84000000b0058d7599676amr4145056ywb.37.1695258357428; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:56 -0600
Message-ID: <CAPnjgZ2=Yx=rqWwi9_N+dzKQq0EViGohYd0QrJYxrUERpZwXyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

Hi Rasmus,

On Tue, 19 Sept 2023 at 05:37, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> In some cases, using the "external data" feature is impossible or
> undesirable, but one may still want (or need) the FIT image to have a
> certain alignment. Also, given the current 'mkimage -h' output,
>
>   -B => align size in hex for FIT structure and header
>
> it is quite unexpected for -B to be effectively ignored without -E.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  tools/fit_image.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Q below

>
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 9fe69ea0d9..2f5b25098a 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -712,6 +712,42 @@ err:
>         return ret;
>  }
>
> +/**
> + * fit_align() - Ensure FIT image has certain alignment
> + *
> + * This takes a normal FIT file (with embedded data) and increases its
> + * size so that it is a multiple of params->bl_len.
> + */
> +static int fit_align(struct image_tool_params *params, const char *fname)
> +{
> +       int fit_size, new_size;
> +       int fd;
> +       struct stat sbuf;
> +       void *fdt;
> +       int ret = 0;
> +       int align_size;
> +
> +       align_size = params->bl_len;
> +       fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
> +       if (fd < 0)
> +               return -EIO;
> +
> +       fit_size = fdt_totalsize(fdt);
> +       new_size = ALIGN(fit_size, align_size);
> +       fdt_set_totalsize(fdt, new_size);

Shouldn't this be fdt_open_into()?

> +       debug("Size extended from from %x to %x\n", fit_size, new_size);
> +       munmap(fdt, sbuf.st_size);
> +
> +       if (ftruncate(fd, new_size)) {
> +               debug("%s: Failed to truncate file: %s\n", __func__,
> +                     strerror(errno));
> +               ret = -EIO;
> +       }
> +
> +       close(fd);
> +       return ret;
> +}
> +
>  /**
>   * fit_handle_file - main FIT file processing function
>   *
> @@ -817,6 +853,10 @@ static int fit_handle_file(struct image_tool_params *params)
>                 ret = fit_extract_data(params, tmpfile);
>                 if (ret)
>                         goto err_system;
> +       } else if (params->bl_len) {
> +               ret = fit_align(params, tmpfile);
> +               if (ret)
> +                       goto err_system;
>         }
>
>         if (rename (tmpfile, params->imagefile) == -1) {
> --
> 2.37.2
>

Regards,
Simon
