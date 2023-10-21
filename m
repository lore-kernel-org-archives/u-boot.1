Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0D8C004C0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 15:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B46875DD;
	Sat, 21 Oct 2023 17:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CQBOeS2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E70D875AF; Sat, 21 Oct 2023 17:43:20 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9996787596
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 17:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so2834161a12.0
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697902995; x=1698507795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H7dYoqdjgFAw4EZarVbIqowGO/xd3/MzOR4tW+7uUn0=;
 b=CQBOeS2TkJvpK6fYEdUA8PyUZ4CRIUHkagdPGd7uzoqvOxlqqh7enV7izz90b4Xp6+
 q0VJTxZ7bg42XzBZm+bfynk2y1zADyB2DcoGEzFKer4F4+yFwpNMkkO5LLGp8hfystsN
 06T83c2WHaz/lRwKkOaXZnRKkGAMoLk7hswGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697902995; x=1698507795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7dYoqdjgFAw4EZarVbIqowGO/xd3/MzOR4tW+7uUn0=;
 b=DMN7Jp6Lmq9jqLEtfz+DPFgvnvL9tGQ7faNCDpaLGRQFb8ciox2f+/UIGrvzhCqzCB
 mD2dPC2E0rZ/paLsmhP6gTFByYn6J1neqQe7s1tok2XrPFmheoKcOOUY1y8VCeVJ/toB
 Zx/RsGyioyB1dcYM3TY1yc2EwhPiY4vtc0WKuFqIiWoaiXF1R+Znvjwio9rS+ftTV5+h
 Y96zNgd9Q1MyrBKZpRV0DKqFiKNSis27hLBfmrQC8qagtF3+YTralDAf35+6u9GIuF2j
 5/lwC5KosnX08762bbilk9ihG9Eu0AGAeXHMgu65nwPw6FI5kYzzSRbN+PkZiPsMhLYR
 QYCg==
X-Gm-Message-State: AOJu0YyvuNI9+X9z7N7KRX0/hbME6sXgRNCTdHAW4F6WiqoPChKKWINX
 +UBSP0Yhvi15gLn1/yOsQDlyS3lO7DnX4T4qE466Eg==
X-Google-Smtp-Source: AGHT+IHh90Xg3Iy12IKtWjV0/PrgczAUnDepC+pkyLj8sa+9+V2r6ESoyuy0/y+ByyGJLqPkNJOuUhNL32pH62sjYms=
X-Received: by 2002:a50:955c:0:b0:53e:7cd3:9522 with SMTP id
 v28-20020a50955c000000b0053e7cd39522mr3522439eda.39.1697902994825; Sat, 21
 Oct 2023 08:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
In-Reply-To: <20231020215302.3511807-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 21 Oct 2023 08:43:00 -0700
Message-ID: <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, 20 Oct 2023 at 14:53, Tom Rini <trini@konsulko.com> wrote:
>
> The primary motivation for having a sandbox without LTO build in CI is
> to ensure that we don't have that option break. We now have the ability
> to run tests of specific options being enabled/disabled, so drop the
> parts of CI that build and test that configuration specifically and add
> a build test instead. We still test that "NO_LTO=1" rather than editing
> the config file works via the ftrace tests.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This creates a small bisectability gap in CI itself, but I think is more
> reasonable than reworking the introduction of
> test/py/tests/test_sandbox_opts.py
>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  .azure-pipelines.yml               |  3 ---
>  .gitlab-ci.yml                     | 12 ------------
>  test/py/tests/test_sandbox_opts.py | 10 ++++++++++
>  3 files changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Q below

>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 6f91553e8613..65533b36dde4 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -287,9 +287,6 @@ stages:
>          sandbox64_clang:
>            TEST_PY_BD: "sandbox64"
>            OVERRIDE: "-O clang-16"
> -        sandbox_nolto:
> -          TEST_PY_BD: "sandbox"
> -          BUILD_ENV: "NO_LTO=1"
>          sandbox_spl:
>            TEST_PY_BD: "sandbox_spl"
>            TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 6decdfdee334..97c964fb8079 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -258,12 +258,6 @@ sandbox with clang test.py:
>      OVERRIDE: "-O clang-16"
>    <<: *buildman_and_testpy_dfn
>
> -sandbox without LTO test.py:
> -  variables:
> -    TEST_PY_BD: "sandbox"
> -    BUILD_ENV: "NO_LTO=1"
> -  <<: *buildman_and_testpy_dfn
> -
>  sandbox64 test.py:
>    variables:
>      TEST_PY_BD: "sandbox64"
> @@ -275,12 +269,6 @@ sandbox64 with clang test.py:
>      OVERRIDE: "-O clang-16"
>    <<: *buildman_and_testpy_dfn
>
> -sandbox64 without LTO test.py:
> -  variables:
> -    TEST_PY_BD: "sandbox64"
> -    BUILD_ENV: "NO_LTO=1"
> -  <<: *buildman_and_testpy_dfn
> -
>  sandbox_spl test.py:
>    variables:
>      TEST_PY_BD: "sandbox_spl"
> diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
> index 91790b3374b4..422b43cb3bc1 100644
> --- a/test/py/tests/test_sandbox_opts.py
> +++ b/test/py/tests/test_sandbox_opts.py
> @@ -18,3 +18,13 @@ def test_sandbox_cmdline(u_boot_console):
>      out = util.run_and_log(
>          cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
>                 '-a', '~CMDLINE', '-o', TMPDIR])
> +
> +@pytest.mark.slow
> +@pytest.mark.boardspec('sandbox')
> +def test_sandbox_lto(u_boot_console):
> +    """Test building sandbox without CONFIG_LTO"""
> +    cons = u_boot_console
> +
> +    out = util.run_and_log(
> +        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
> +               '-a', '~LTO', '-o', TMPDIR])

Don't you need sandbox64 here?

> --
> 2.34.1
>

Regards,
Simon
