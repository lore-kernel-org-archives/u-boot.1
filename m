Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D2E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A8E89613;
	Fri,  6 Dec 2024 16:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q/3qpgCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCAF8964B; Fri,  6 Dec 2024 16:33:19 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500D489655
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee51c5f000so1625955a91.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733499194; x=1734103994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tAeKiWAQtTt1MzuXbSt+hVIo9bRXCmwHvQHagsaxSIA=;
 b=Q/3qpgCuLokvjknXKBD/Wph6LRqf/NlQrVsu/VE/x6yu7l+xTE2c1VgQEGhPhw6s44
 GKr6atNAUmjjSAPeI77F74RWKzk1Htbnc5HVdtWGocMCLTwmTB3x0hxRRevMSGb8hgff
 Rh4pLl0F5zYsLfT/kcIEk8uDq2Vd91swvJzYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499194; x=1734103994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAeKiWAQtTt1MzuXbSt+hVIo9bRXCmwHvQHagsaxSIA=;
 b=Wo1aTSuMTPlUMgGPPEcCEg8u8TXDP4A4g/wqD2x+3QCEGygkFa8tPEnJe7f58P9x66
 M7vmuJH6uQQhGFS7Y8C+O3vcVdb9JnUKzyU5XWvosi8IfkqB7V15GYgFDG/tdpcDdNEV
 24/6quNUNZ98Icpm9PMLRLQj6mhGjgOgGMH7iFS6iZm6YuRJh5Ed9j3x3umZqncviMbJ
 mcJ9avMMZCUQzWInEWb+T4MVof2ms0eUciYbJZtpR/lrzXFpFOAGRur9hCA2jcvNmi1Q
 P07PZQzrxbbsg+JxG+3g4mBDdnXpVSTTN8ZerskUf7srTJrdltXG6sxUL78lCu32YQ1L
 0joA==
X-Gm-Message-State: AOJu0YwDeUwaVQrUjjOv36hXec0im6GxzC/lesJurE0JYNWX/yfQDkbA
 cc0+1xWF04rRumFj8UWKqcxez58rWvuG1iKeJDaAyeoA5wJX95VvUUeBEMzgpjYcINzQ8ge4rTy
 ibsTi4O1MccqEvAFpsgtX3/AsMKsrE4cBsRh4hQV6xy5K2UA=
X-Gm-Gg: ASbGnctaTlWMwY0fj+JZKYSlF6qIqmdkpAXebh4IH5tLmoJjA3gfOKF8963hrVS8A1d
 Nxab9Qt3BY8uEsjaK0uKIH+MSfTNYTvCcPK9G
X-Google-Smtp-Source: AGHT+IGgb0zzulEY4Y58jZxNo6pOt5Z7A0ko1d3qH9SquOmHcZqomjelyzeJLQGaP0thG+Ks6Z6eEfa6U1baoFydBVQ=
X-Received: by 2002:a17:90b:5204:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-2ef6a6bdc2amr6020204a91.17.1733499193905; Fri, 06 Dec 2024
 07:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
 <20241125175111.1181749-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125175111.1181749-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 08:32:53 -0700
Message-ID: <CAFLszTi-0uJFjaEcM8bpuHCjTbM5p_GDyqvrLDVyrFOSFm2hrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools: binman: Pass a list of input directory to
 EnsureCompiled()
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com
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

On Mon, 25 Nov 2024 at 10:51, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Input directories can be passed to binman using the '-I' option and those
> input directories are now also passed to 'dtc' when run by binman.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v2:
> - No change
>
>  tools/binman/control.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

indirs would be a better name, but the comment makes it clear enough


> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index 542c2b4564..e73c598298 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -526,7 +526,7 @@ def _RemoveTemplates(parent):
>          if node.name.startswith('template'):
>              node.Delete()
>
> -def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
> +def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
>      """Prepare the images to be processed and select the device tree
>
>      This function:
> @@ -543,6 +543,7 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
>          use_expanded: True to use expanded versions of entries, if available.
>              So if 'u-boot' is called for, we use 'u-boot-expanded' instead. This
>              is needed if update_fdt is True (although tests may disable it)
> +        indir: List of directories where input files can be found
>
>      Returns:
>          OrderedDict of images:
> @@ -558,7 +559,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
>      # Get the device tree ready by compiling it and copying the compiled
>      # output into a file in our output directly. Then scan it for use
>      # in binman.
> -    dtb_fname = fdt_util.EnsureCompiled(dtb_fname)
> +    if indir is None:
> +        indir = []
> +    dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
>      fname = tools.get_output_filename('u-boot.dtb.out')
>      tools.write_file(fname, tools.read_file(dtb_fname))
>      dtb = fdt.FdtScan(fname)
> @@ -846,7 +849,7 @@ def Binman(args):
>              state.SetThreads(args.threads)
>
>              images = PrepareImagesAndDtbs(dtb_fname, args.image,
> -                                          args.update_fdt, use_expanded)
> +                                          args.update_fdt, use_expanded, args.indir)
>
>              if args.test_section_timeout:
>                  # Set the first image to timeout, used in testThreadTimeout()
> --
> 2.43.0
>
