Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12314E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3C08921B;
	Fri,  6 Dec 2024 20:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cBBgdwf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23198971C; Fri,  6 Dec 2024 20:16:19 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E5688F0C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa62f1d2b21so269029766b.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512577; x=1734117377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x7lQTkP/Nff9nZjLQQpLFmFmVb4QZD8L/kfFuvY5V3w=;
 b=cBBgdwf9/GwAieCSOI/CR4YnEQOQwPL7SBZ9wDBncYkPmlegGblwdClXcvQkAFY5up
 JlVIqqn+FCyGEHrowtYo6ceq1fKy7hBQU9SPwwLR9GDmemur69EyeHx5TPxqQn+S+wgR
 m0C4ZY7k7vadanVyy8Cvs2MtbfMpTibiF1S1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512577; x=1734117377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7lQTkP/Nff9nZjLQQpLFmFmVb4QZD8L/kfFuvY5V3w=;
 b=I9qzy6dpOwjdlxwaHtk7nADwMbooYlPSm1t3+HiHB6FPiqHSrSEEON9cPaljKa1Baz
 ZXZixxYiqOKFg2J6auQO1rkHOV0q4TrXSar4nHLr30ENovRY3TwTLVg95cFE5BWkTU4u
 Nmy0F3CGWbU5y37GAi0f1DR8EdEDLc1I3TMSujHN+WDq4/bRKBZ731xiffQ1UV2Teoqu
 if3spemUSwWqiQPkvWWVQow2bXDWWC2vkHVjUXrcxWP+nbw23qQfJntegZBN5uWSCLTl
 zYrYuX/ALWiwouRAYsjCrPBQR/MLqjWkcN/4ZQa6z2ugHba46gO1epgm7CwDNdibyLOh
 vxKg==
X-Gm-Message-State: AOJu0YxdsssiKJSKFvTGDULLK7juQusD50RroIXvKpvUDgU0wPLqF019
 YHRz6cXNqAbHen6oTQTAkStoaC99MZboRO2JYh7nxRo1WzkmXRgipbk/uWIaXs0iVTCLeyJ1hEb
 3OVL5eiwiSg91MInhjfSBKbtVqs1XbR5vbhav
X-Gm-Gg: ASbGncv0oGEsk5kL06vccRM0fcO86ul0RJrNLMHHW7a1fN30c50JWCpWXMhOuLaTXka
 dSndP6pMkAlifQ63kxDdwpLlxX8LrnSeelRCy
X-Google-Smtp-Source: AGHT+IHFHFrlsjjMyHtywWubT3bJkmmOcQD+MFLe3UQShzZdo+Huqm0/ob8ncEfyXjFnYTBZ31xfW9w/kcWD7j5iDZo=
X-Received: by 2002:a17:906:23ea:b0:a9a:bbcc:508c with SMTP id
 a640c23a62f3a-aa639fa5f5emr252281566b.2.1733512577073; Fri, 06 Dec 2024
 11:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
 <20241125181654.1182646-3-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125181654.1182646-3-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:16:04 -0700
Message-ID: <CAFLszTjPZs2f+r2KefTSG7kcWU+2is79uoEp5SKHCNd+NC41gA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: binman: etype: fit: Append DTB directory to
 the list of input directories
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

Hi Paul,

On Mon, 25 Nov 2024 at 11:17, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> When specifying a directory containing DTBs with 'fit,fdt-list-dir', it can be
> handy not to have to also specify this directory to the input directories of
> binman with '-I' option and use the method tools.append_input_dirs() append it.
> This avoids to have to specify the DTB directory in both the device tree
> provided to binman and through '-I' option to binman.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/binman/etype/fit.py | 2 ++
>  tools/binman/ftest.py     | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But please add something to the FIT docs (and regenerate entries.rst)
so people know about this.

I would actually prefer something ephemeral, i.e. that just adds the
extra dirs for FIT and not the whole of Binman, but that's a minor
point and would be more complicated to implement.

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index 343094a16e..803fb66ea8 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -477,6 +477,8 @@ class Entry_fit(Entry_section):
>              self._fdt_dir = fdt_util.GetString(self._node, 'fit,fdt-list-dir')
>              if self._fdt_dir:
>                  indir = tools.get_input_filename(self._fdt_dir)
> +                if indir:
> +                    tools.append_input_dirs(indir)
>                  fdts = glob.glob('*.dtb', root_dir=indir)
>                  self._fdts = [os.path.splitext(f)[0] for f in sorted(fdts)]
>              else:
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 4a2a9f2288..a553ca9e56 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -4285,14 +4285,17 @@ class TestFunctional(unittest.TestCase):
>          entry_args = {
>              'default-dt': 'test-fdt2',
>          }
> +        extra_indirs = None
>          if use_fdt_list:
>              entry_args['of-list'] = 'test-fdt1 test-fdt2'
>          if default_dt:
>              entry_args['default-dt'] = default_dt
> +        if use_fdt_list:
> +            extra_indirs = [os.path.join(self._indir, TEST_FDT_SUBDIR)]
>          data = self._DoReadFileDtb(
>              dts,
>              entry_args=entry_args,
> -            extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])[0]
> +            extra_indirs=extra_indirs)[0]
>          self.assertEqual(U_BOOT_NODTB_DATA, data[-len(U_BOOT_NODTB_DATA):])
>          fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
>
> --
> 2.43.0
>

Regards,
Simon
