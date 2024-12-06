Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75219E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1380D89376;
	Fri,  6 Dec 2024 20:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eyebB++X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AF28972B; Fri,  6 Dec 2024 20:20:04 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2648974E
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso1787484a91.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512800; x=1734117600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pW4CBIBWxge20BFfVm5QyusiePgwyKRb+EU69o5QIB4=;
 b=eyebB++X/HlESwM8TH0YDhg+5rZFUfEI2rQ1/QqFiakogAZypEhMG5LWISUVcDEaxv
 VBB9by++mxGj7HJ+cDHWNcjNSRrTUtlfQxnLedALDA7Q10nNSqwrZmSAKgSz+Ey8jQNV
 BtfrUCMHaAW8KSFPUBPiw0g8GtEhPSuBJ7CIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512800; x=1734117600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pW4CBIBWxge20BFfVm5QyusiePgwyKRb+EU69o5QIB4=;
 b=iCoy88ATNp3TUM83MSa5pBdGLuSbP22WnHQqPM0jgHgI73dZiV5OLhHb7Bm4pS43d+
 wieQW4Q9ASg/ODXYw1yqgqcm1bChwA6IHn8koyqmSvoJ23Tj7PlMkQLD2tsxkd6FOYwH
 7j4OLJJ1t0w8hmQMZ4L0XTGpx2H0szeup+meIkhUTI4TQq67BPX18anOI6dlEyr6AUSn
 vz6a9fYh3HqipVSi7a+qUC47EKKbuUe2NMNt8Qwvc4NwPX0LStI9DUAhMRc6gdgjPNZE
 czgXR/DVxaACx8qbNJfDVbwySPl5Cx7Nz36MnTkl8LBugVvSpeu3FROx9ef/HTpHDVF1
 Kphw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAa99icNj1BYe40lCmD/bfJ5AjkjdUDVPvizn6Yq13nq66924AM5dmyfQET4DkYGh+uhsSdkM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw22SI6zpr/rz1/N5cKoD8Rd/8XHhZfBVccP/Y/bIF9XqlI/QlO
 cxaDJ2rn/qk9dtMUWhjk9u+peJvLgBw3ivMlArowFUUVdKKdPSfTfoDEHVpZ2YyutaccX8VAU8C
 HaWOnz9elIBL68DcZK4Vl5uBmWAJY1z8D6lNkyTKLRVnQbjs=
X-Gm-Gg: ASbGncs3uk/ggkjxzMLGW2AYcka5w22JYYm4shE9UNebdiK79pr43a0aZRTVXr8Hbod
 ltqbomRoeVY2cAkeO6nQvaUu37cZzUBjY
X-Google-Smtp-Source: AGHT+IF4DNd9ROTtpeicbLAXtXGzblRf+iVNgjtPp/QDW3nXcq4pjTHsfjexQefN+O4H0Bvpb3ro/hO1HyHDCzf6TFo=
X-Received: by 2002:a17:90b:3f45:b0:2ee:dd79:e046 with SMTP id
 98e67ed59e1d1-2ef69f0b093mr6476984a91.13.1733512800001; Fri, 06 Dec 2024
 11:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:19:42 -0700
Message-ID: <CAFLszTic80ddU1QRxD0dKG0fruZnMXxpoZVEAuK76ji3pM2vMg@mail.gmail.com>
Subject: Re: [PATCH 0/5] sandbox: repair compile and run-time for OF_EMBED case
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

Hi Evgeny,

On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
> This patch-set repairs ability to use sandbox with CONFIG_OF_EMBED=y.
>
> For now, to use OF_EMBED, the following must be done
> 1) sandbox64_defconfig should have:
>   ```
>   -CONFIG_OF_LIVE=y
>   +CONFIG_OF_EMBED=y
>   ```
>
> 2) On sandbox when CONFIG_OF_EMBED=y, the u-boot process can't start
> due to:
>   ```
>   Bloblist at b000 not found (err=-2)
>   initcall failed at call 000000000011829c (err=-2: No such file or \
>       directory)
>   ### ERROR ### Please RESET the board ###
>   ```
>   So, it is natural desire to disable CONFIG_BLOBLIST just to test
> sandbox with OF_EMBED=y (disable it one way or another):
>   ```
>     config SANDBOX
>   -     select BLOBLIST
>   +     select BLOBLIST if SOME_NON_EXISTING_OPTION
>   ```
>
> 3) As a result, having such changes (CONFIG_OF_EMBED=y &&
> CONFIG_BLOBLIST=n) leads to the link & run-time errors, being fixed
> by this patch series.
>
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
> Tested:
> * locally with aforementioned options applied
> * CI - https://github.com/u-boot/u-boot/pull/704
>   * No regression
>
> ---
> Evgeny Bachinin (5):
>       sandbox: fix bloblist_finish() linker error if BLOBLIST=n
>       test: sandbox: fix invalid_use_of_IF_ENABLED_INT if BLOBLIST=n
>       test: sandbox: fix link error with do_ut_bloblist if BLOBLIST=n
>       test: sandbox: fix link error with do_ut_bootm if BLOBLIST=n
>       sandbox: set retval early in board_fdt_blob_setup()
>
>  arch/sandbox/cpu/cpu.c |  2 +-
>  include/bloblist.h     |  7 +++++++
>  test/cmd_ut.c          |  2 ++
>  test/lib/kconfig.c     | 10 ++++++----
>  4 files changed, 16 insertions(+), 5 deletions(-)
> ---
> base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
> change-id: 20241120-sandbox_repair_of_embed-2188465eb22b
>
> Best regards,
> --
> Evgeny Bachinin <EABachinin@salutedevices.com>
>

Thanks for looking at this.

You could add a test for ~OF_EMBED in
test/py/tests/test_sandbox_opts.py if you want to keep this working in
future.

Regards,
Simon
