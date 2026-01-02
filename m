Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521CBFA3738
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 12:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A257384207;
	Fri,  2 Jan 2026 13:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lxX+6X6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADA984221; Fri,  2 Jan 2026 13:30:12 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A09984206
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 13:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so13377827a12.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 04:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767357010; x=1767961810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K1llqnU0PWQB6Mc/wycEGJekChckhLlde29sc6/EVMM=;
 b=lxX+6X6CXX2mAHePJDh9hQE2AWnRCvyouf1rsBNDJ9OZdvZndDnE8YMzzF+KVnViMT
 qvCE9AqxDVd3ooRUOD8rkg6oXmMNWQRA+ut5Fvf1wd5tRqs/wyw5jeD3eS9NMNTJgS7Q
 O9hnRUWQiTkrDNKYSi2yuBIHQxO7Lw2rMYogA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767357010; x=1767961810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1llqnU0PWQB6Mc/wycEGJekChckhLlde29sc6/EVMM=;
 b=GZ8MBWj5LOCJpYBUCZNi4UHAevxltKD6h3b8UWpWegWzit5Gkg1X8vjs6qO2R4PgKk
 yzW8EqdRpEWrKJfT6d6+nAssurjAghjncSGAFjc1tRWPGF+L1UfXapc/Dqi795bxsl2h
 IJ6XXSpUD0RtOv5HZAwhQPrOSZW8PiwzkADBIa65cLguqn5+3fyEg7KxQRZ8ELB0koX4
 hpIhg5ExrIsj8wloiwyqOxw5GH2i2amuGYREd+aP+p+OrGaruIheKz6g1zZsRuVyRFVI
 aWkNRG9igtLtEvDVUX4K5HNh6RPMrjqPNqKKaX1pEiP96Xe2ayOJUWusoW1euUPuZVJ8
 sGHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4oflD2TAlWo70gQyiV0q6CoVtbyIDK7+0l5WpdNlYJh0Tyc3/lUwUUpEYaeaqGhVdUjWY/4Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwPR2lzUwmS3RCfBQBwj6EPn+Tbtw01SmEGsF+lVXroD1Ym2yhE
 xW+FlQvqWhTOeaec6VaJbXXZXV8yzrL7fBFgubrAVFZsGNzXLFHCzOvO+QYPkGdk1hqyVymny8c
 4o5tVwmd2J8U3vSXUumTPqIG80LvyKMlRSvGlODFW
X-Gm-Gg: AY/fxX7YVbgyNwXU620DJ+TD0nU3H2K2Nc+Aksz7gtk0etClLXaEx2WeBa3EoonEjB8
 X6c/lmh+RboaDSDNRyP9qqm5ULWhoJRVB6X81ZHzeGQLbv/LvtjUkc5LpAwarZjV7wlnnnbwT4q
 d3nYTHHKntyRGr9fWXKhMoJMhEXCpfblBy/1NjgTnN+eJ3x7hduRsutWczkOBqUXvU+vbpWCfko
 AhyBkE4kQXeZpstq40lbnePfMtSSDFMFT1bDshNO+KcyB9QiXaghI5CCrtE0hbCwrNOMA==
X-Google-Smtp-Source: AGHT+IFfYrKw8OW8PKbesrIUsafEtVxJZ2nQiWKc436w4FSD7glulylVMD0XUAmddQdPnhK9PYyxeas7DJA5b4Hp+G0=
X-Received: by 2002:a17:907:97c2:b0:b73:4b22:19c5 with SMTP id
 a640c23a62f3a-b803722a7f4mr3999303266b.44.1767357010042; Fri, 02 Jan 2026
 04:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251231191054.247270-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 Jan 2026 05:29:58 -0700
X-Gm-Features: AQt7F2rT905NXD5AbEeAssYqoULHaGj5z94XvJNaJQgvmbfVHFzc2dWTxx-jXPQ
Message-ID: <CAFLszTinaB_wvQKijgW=CvP8Qz5dgjOv0ykGrSfEpUG3Jjevtw@mail.gmail.com>
Subject: Re: [PATCH 2/4] test: do not imply os_malloc() outside of the sandbox
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 31 Dec 2025 at 12:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y the C compiler does not
> execute all optimization paths and add a reference to os_malloc().
>
> Remove the reference if CONFIG_SANDBOX=n using #ifdef.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/test-main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/test/test-main.c b/test/test-main.c
> index 3254325e8b1..1815d60acf7 100644
> --- a/test/test-main.c
> +++ b/test/test-main.c
> @@ -734,6 +734,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
>
>         uts->of_root = gd_of_root();
>         uts->runs_per_test = runs_per_test;
> +#ifdef CONFIG_SANDBOX
>         if (fdt_action() == FDTCHK_COPY && gd->fdt_blob) {
>                 uts->fdt_size = fdt_totalsize(gd->fdt_blob);
>                 uts->fdt_copy = os_malloc(uts->fdt_size);
> @@ -743,6 +744,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
>                 }
>                 memcpy(uts->fdt_copy, gd->fdt_blob, uts->fdt_size);
>         }
> +#endif
>         uts->force_run = force_run;
>         ret = ut_run_tests(uts, prefix, tests, count, select_name,
>                            test_insert);
> --
> 2.51.0
>

Oddly I hit this same problem some months back but I didn't end up
needing to patch it.

Which board are you building here and which toolchain?

Regards,
Simon
