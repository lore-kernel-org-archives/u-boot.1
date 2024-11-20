Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF913D6393C
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749EA892DE;
	Wed, 20 Nov 2024 14:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GXJGKIB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE3E89353; Wed, 20 Nov 2024 14:48:07 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9686A892B8
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so845584966b.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110485; x=1732715285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F3Yh6OPhYRAi1BYh+M3n6HvzJimyLPnB88qI+WGsPBA=;
 b=GXJGKIB5hgMUwAttiIrPsU2hpEcxGRoZGH9OK6g4pY1n/+EOgKV2UU9M9k+m6TD+K8
 7+WJwT9UNMlBSjokU9U9di3JrVcOUZfqw6IK1QMTmj5g+eQnqy3mWlhA42FQXAxNUCSW
 g6Hhfx5qLdn0XnRor8MIjAE2NwrdsVdlCtQm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110485; x=1732715285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3Yh6OPhYRAi1BYh+M3n6HvzJimyLPnB88qI+WGsPBA=;
 b=a25ECyH3Wi3IhNb8r73L1ONKQMfmhDAL1SOXJmzwOL3aDAB1v1c2MovlTxzrnxkq4U
 jKQi017V5J969hik1VY8WZsm5CnFqZpLlTrFmW5JH32mXmOvZRxRq3BGapPD8PDlfhQZ
 E9pUFG/TZtk/EpruSWfSxjTWNvzD9ULd59EXXuJaqyBkTW0F8w9q7TbzCYN/zx1/2t4G
 THw1ECYDVZQ6TArm7qLaBK8DSEaL87IAYBrIAxw5tCjK61njTRJxp0j/C3jOoM/n1N9W
 VVw1Zf/kNXtW9GvbZzLjamV3FVSEmEURsAWFoHEpwWbrnv17MrBhb9cDvgjiZoVkQp6s
 CfJA==
X-Gm-Message-State: AOJu0Yztk4M3UiJpDc9mIuK0ozt48u+y53+2NLYxbjmA/hl3pPnYeQjR
 9M5b02OUFGwEtFSgQ67D/6xnAXT+CvlW2pluBRRBgV4Zo3JmgxLicZbcPSATd2F4nocYgAf6cm4
 a8EI/DY74IszEAmsF69OP3uFFb2cpER7bbJgc
X-Google-Smtp-Source: AGHT+IF9juR+LyZTqKJezTKvgg3OQV9k0+EmjlaXbR7YQiCWTxZW200xO3dtI6P8Kp/8PxTVpK3dv625WPu+SJu/CCE=
X-Received: by 2002:a17:906:fe0d:b0:aa4:777d:73b5 with SMTP id
 a640c23a62f3a-aa4dd551bd2mr254358166b.21.1732110485115; Wed, 20 Nov 2024
 05:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20241120103722.886708-1-paul.henrys_ext@softathome.com>
 <20241120103722.886708-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120103722.886708-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:47:30 -0700
Message-ID: <CAFLszTgfrk-ydUOq3c8hJhEdYVWiYFxh1-5NSf7Dgq2FRce-mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: dtoc: Allow passing optional input directories
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd@gmail.com
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

Hi Paul,

On Wed, 20 Nov 2024 at 03:37, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> An optional list of input directories can be passed to EnsureCompiled() which
> allows to pass a list of directories where input files can be searched.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/dtoc/fdt_util.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/tools/dtoc/fdt_util.py b/tools/dtoc/fdt_util.py
> index f1f70568cf..3e5832fb07 100644
> --- a/tools/dtoc/fdt_util.py
> +++ b/tools/dtoc/fdt_util.py
> @@ -55,7 +55,7 @@ def fdt_cells_to_cpu(val, cells):
>          out = out << 32 | fdt32_to_cpu(val[1])
>      return out
>
> -def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
> +def EnsureCompiled(fname, tmpdir=None, capture_stderr=False, indir=[]):

Just a note that I tend to avoid a default argument of a list, since I
understood that changing indir within this function will apparently
change the default from then on. I've never tried it though, so could
be wrong. So I tend to use None as a default rather than a list or
dict.

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
> @@ -79,6 +80,7 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
>          dtb_output = tools.get_output_filename('source.dtb')
>
>      search_paths = [os.path.join(os.getcwd(), 'include')]
> +    search_paths += indir
>      root, _ = os.path.splitext(fname)
>      cc, args = tools.get_target_compile_tool('cc')
>      args += ['-E', '-P', '-x', 'assembler-with-cpp', '-D__ASSEMBLY__']
> --
> 2.43.0
>
[..]

Regards,
Simon
