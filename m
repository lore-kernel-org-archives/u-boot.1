Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97787C369CB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0C882893;
	Fri, 18 Apr 2025 13:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QnYEzp8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683E182C15; Fri, 18 Apr 2025 13:40:40 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6676282012
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5e61da95244so3049819a12.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744976378; x=1745581178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WszXyvhGEk+ouVR2Zig2XTaL3XwBu9vumO6hfMRjpM8=;
 b=QnYEzp8nL/LyFLTeVfY6woucLhExzoKbF4jsZgpDQeUcIenSyiA3T2E5qFLaLdB+p0
 RfMeNI7IIpYZhBiVfdqv/yfsO7xA+T76H4eIsCXPDNaTDtkAlvQJPX9LktR4qt/bROEU
 FAvfPiUt5XXyumOoRyhrYfXFNGauHcNzasuqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744976378; x=1745581178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WszXyvhGEk+ouVR2Zig2XTaL3XwBu9vumO6hfMRjpM8=;
 b=Limq7nFJ/KMw4xr+yyh8DskN/HfIplf9eYROFna37PiCRhru1zsOAdZf0o3V07Iwd1
 Z90M81XxIX4YE/49F5RbnwuETF+ENFISVoVnr4fNXcN6qrUOGlGJfe8mrncfBpA3n6+/
 N16zcmCEnY0/uiOShlH8QcUA9+6mxcgHyjNU1xXCpbBaSiNpqVGyn+4zMgL7SpAeJUI7
 UZ4DWR5+L8gP1mrNzwp6StW+kLXahhV5TTbrrJeSMv+Uw15V0Kau8U5j1getimOh8wqg
 lzjV14a/Zwe1cjRQBd8jOCwIexnFH0EwSt6T5gmqOG3ZFSLTZ94SwZ0TC/+0cesOYOjq
 84rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULQ7ZX29gCqB4ElEtBCz/dmWSOaNdNfGEnhRVAO1ga7xoVlSmcLNlZA/ZNsHVTo5YleMv1P7U=@lists.denx.de
X-Gm-Message-State: AOJu0YzgjYwlWHqfznKwGdjmROAn9F4+p97I0opLsTDN9Rx9YbbMFtfJ
 V9E6RDQgQuaY1Bd/1Z3I1hdl7upfobd8n+WgbgHlv7ysnhmYCMcXAmoNWpnK6w9bSrJDlq/IKw4
 PG4d0XQi+MInLF8YXT16Yzm2qDIjga3naGvKAyYFjq6gCk1A=
X-Gm-Gg: ASbGncv/opeRVBJ3tkbvYfoq9IXP92in3fra7JHFDtISM58X3+ZRvn0hFxrPhdhnI0L
 xrFTZdGhQLbJaTKwEYGKmse68BRp9MElbZndQohXV2rku2BJ1HlzbAaEqiE55uAIjBxLXm9lG0o
 pqIO46lJ4H1nORILEQk4V+r5Q=
X-Google-Smtp-Source: AGHT+IHS1xjR7op/oMJGTdk2dNwHrOXzcF51CEboel42ySYnMBjBWqJfEL4fDWk/e/ZEQ2bwW+5OpqLIn6oNjmnKaTE=
X-Received: by 2002:a17:906:f58c:b0:abf:6cc9:7ef2 with SMTP id
 a640c23a62f3a-acb74dbfb8cmr168565366b.42.1744976377834; Fri, 18 Apr 2025
 04:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
In-Reply-To: <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 05:39:25 -0600
X-Gm-Features: ATxdqUFjGs13z3ZnCxU_OmpMquKvjMpBcE2y3NQbmhRBUhLbzBVTv8tVjBYayZY
Message-ID: <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
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

Hi Quentin,

On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Heinrich,
>
> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> > Currently we are no able to build with configuration fragments in our CI.
> > With this patch buildman gets a new argument --fragments for passing a
> > comma separated list of configuration fragments to add to the board
> > defconfigs, e.g.
> >
> >      tools/buildman/buildman \
> >      -o build \
> >      -k qemu-riscv64_smode \
> >      --fragments acpi.config
> >
>
> What about using:
>
> --fragment acpi.config --fragment fragment2.config
>
> ?

Yes that could be useful. It would also allow wildcards, although the
code would need to drop the config/ directory prefix. Also, I see that
-z is available so perhaps that could be a (bad) short option?

Another idea would be to also allow specifying the fragment name
without the '.config' suffix. Less to type.

>
> ...
>
> [...]
> > @@ -412,6 +413,8 @@ class BuilderThread(threading.Thread):
> >           args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
> >                                                 work_dir, commit_upto)
> >           config_args = [f'{brd.target}_defconfig']
> > +        if fragments != None:
> > +            config_args.extend(fragments.split(','))
> >           config_out = io.StringIO()
> >
> >           _remove_old_outputs(out_dir)
> [...]
> > diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
> > index 7573e5bdfe8..38ea7f9f335 100644
> > --- a/tools/buildman/cmdline.py
> > +++ b/tools/buildman/cmdline.py
> > @@ -62,6 +62,8 @@ def add_upto_m(parser):
> >             help="Fetch a toolchain for architecture FETCH_ARCH ('list' to list)."
> >                 ' You can also fetch several toolchains separate by comma, or'
> >                 " 'all' to download all")
> > +    parser.add_argument('--fragments', type=str,
> > +          help="Comma separated list of configuration fragments to be applied")
>
> ... and here have an action="append" instead, which will create a Python
> list already, which seems to be what you want to use anyway considering
> you later split this by comma? This would also allow to have config
> fragments with comma in their filename (which is maybe valid?).

Regards,
Simon
