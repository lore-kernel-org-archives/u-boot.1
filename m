Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AA8E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFD38959D;
	Fri,  6 Dec 2024 16:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Od5g+w77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EEAB8914F; Fri,  6 Dec 2024 16:33:10 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FA08959D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee6c2d6db0so1979829a91.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733499187; x=1734103987; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lBjXc//uc41Ai7ggdD7KWQhE0twBXJ1oaKEH4Pwoyto=;
 b=Od5g+w77hb8O1Po+nJ93Ozu/RhzItfSc37RMLLfjFP8aRNNzvHfHfJas7VoQ1v/6Bb
 ABykrj4DW/8O7xticJK9QYSEiZp9yd0rxfm3k1TTXIBuUty2CoLIm3h/ftEHAdz02UhN
 icOybv5p+OzKm0pfIe9x3BZIe0OKTEb1sVFl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499187; x=1734103987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBjXc//uc41Ai7ggdD7KWQhE0twBXJ1oaKEH4Pwoyto=;
 b=OmrG5er5IygPf3HvWluiVhAEL6s1SD9h5AvymSG31VwFxJBgD9Ki8Tnqz2m4C7OnRY
 aUcQZNb6A2YfjZHjeF1o6y0jMur8frRd+tIvbz+azWl7EQRTIUYnjb9pGd9BN7oqFMCs
 Ppyx97KahAo0fCOEIeFMAF0lfiWnyX4JBiDVQWkWffUEUiWjd41KwDkuwS124+yT+dXR
 dw85nF7aZdixfTiincs8doN84mkKrzTHAgCUgUpKwI4wCZN7iJgG4+m7E7rXCxUazGNE
 fpmv0jY1bX9JYs8uFvTqqEAmNC/jeWk/K1fokiq2SI8NCNH8/m6M+nh+sPFscLa1cvq8
 wjyA==
X-Gm-Message-State: AOJu0Yy7QZf4k2zhZgNGBC7bm+yB1SWsv2JqFH4nTuKYRO+lKHif+Ati
 3JOK113cu8EXp3w8KKGvWeDBB6tQl47tyRM/Hxqg7ZcwF1mcCD6tRQG+Mjy1iMuYnz31iztZn8u
 mvMK0z7a1vRKMjs4UOKHj7FlchYXBlyigSI3h
X-Gm-Gg: ASbGnctmItCg7kKYArA6jq46LzNcFU5rXa4hSV7ko8sfMz1l93E8FhflgKcM8pKraR3
 GdqCpMPR0+pUMyv/783b6KZrBhZH38IP1
X-Google-Smtp-Source: AGHT+IECiO3sJ/DKQsNv9wYm0xrMbhjnX1IuS9dRDluq7gpapufkda/6st85chOm8CGX0e9sjIz8NSq8KkZCp8zRiAY=
X-Received: by 2002:a17:90b:3bce:b0:2ee:acb4:fee0 with SMTP id
 98e67ed59e1d1-2ef69e1279bmr6130986a91.16.1733499186915; Fri, 06 Dec 2024
 07:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 08:32:49 -0700
Message-ID: <CAFLszTghdnYM0_FuSMCcT+_Jgtbi0=1CtAeQKfnHe+ONnUxfYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools: dtoc: Allow passing optional input
 directories
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
> An optional list of input directories can be passed to EnsureCompiled() which
> allows to pass a list of directories where input files can be searched.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v2:
> - Use 'None' instead of a list as a default argument for EnsureCompiled()
>
>  tools/dtoc/fdt_util.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/tools/dtoc/fdt_util.py b/tools/dtoc/fdt_util.py
> index f1f70568cf..d5ecc4207d 100644
> --- a/tools/dtoc/fdt_util.py
> +++ b/tools/dtoc/fdt_util.py
> @@ -55,7 +55,7 @@ def fdt_cells_to_cpu(val, cells):
>          out = out << 32 | fdt32_to_cpu(val[1])
>      return out
>
> -def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
> +def EnsureCompiled(fname, tmpdir=None, capture_stderr=False, indir=None):
>      """Compile an fdt .dts source file into a .dtb binary blob if needed.
>
>      Args:
> @@ -63,6 +63,7 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
>              left alone
>          tmpdir: Temporary directory for output files, or None to use the
>              tools-module output directory
> +        indir: List of directories where input files can be found
>
>      Returns:
>          Filename of resulting .dtb file
> @@ -79,6 +80,8 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
>          dtb_output = tools.get_output_filename('source.dtb')
>
>      search_paths = [os.path.join(os.getcwd(), 'include')]
> +    if indir is not None:
> +        search_paths += indir
>      root, _ = os.path.splitext(fname)
>      cc, args = tools.get_target_compile_tool('cc')
>      args += ['-E', '-P', '-x', 'assembler-with-cpp', '-D__ASSEMBLY__']
> --
> 2.43.0
>
