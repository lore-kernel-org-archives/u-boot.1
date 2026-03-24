Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20954E9A743
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9204982A9E;
	Tue, 24 Mar 2026 10:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kmryXXmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BB38366F; Tue, 24 Mar 2026 10:30:35 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCC380517
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-793fdbb8d3aso49723787b3.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 02:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774344632; cv=none;
 d=google.com; s=arc-20240605;
 b=hSpFXRAf58ZV5yVisx2bt703Ie8JFjMWYKUzRuCksjxY3ehojFNDiVjj4FWzUiqrDP
 8yfSD+FR33Yd7JZavTHbHicWvZvPfSefqnA+Ax3VwxDE7C1zyayncHJhxcVU2TK632XJ
 /MvgcdJD6Tl9NkWd4iIi4c/BzZElHgRFPenkPwcDs4nTdjsHxMcgaFqH20dy419DZ5oe
 M+o9307G8OOAtuqoW76Ya57Gh8fhQzMRNgOncionVUUE8jwHskWb4pxi5TZVnq1DSeZ5
 iD9S5PPH0tArvepUGthQppwznBv7P3hOqQUOBRo3q3IevYG/gpoJExiKa9XvKJpFE6wb
 BWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tVUpZCYnHaxysdlf+drvJnN0V8RdoIj2kFoJyLHiMhc=;
 fh=x+hhjjJc/60gntzIcb8RvYudSSdxcKS9dWUybTmFFzs=;
 b=PA5ni7BwEGZ2AT52FM6vJcLe5UqVGp/x7fYkNDBCAAeDmVqyKkPrAMgPfT0qXEKBnM
 mmbQywnBXGwfu7AvCt25BVHfa/inEZ12g1VFZgvWtVucWuwBnOdIDycushbE1GqwhTVs
 V8uLeZ0kRSkEsgO8tNk5D/4l1mp/fGrhGWx5+hCbxE47gdFYkC07KfbUNS5Gqb70BjKV
 jTaND4hSwPwp2RWJky0peyDAy0U11dZvvictcvOIzIqhRvX6UiQEfe9+d1QwPOcA4tYj
 1wiUCjISn078r/OTHw7Y5CUExgYLJqNJwxwfOP69DzXDdwzgzatR4I5GkqYsPiQEdP9Q
 CpLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774344632; x=1774949432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tVUpZCYnHaxysdlf+drvJnN0V8RdoIj2kFoJyLHiMhc=;
 b=kmryXXmxoAfmUKPTfZGTJeVXcqLPGl4eXEO43yqpMihbIc02OP1LWzpq7qDlhcPGgY
 /uPUgxuFWW7Pm7ssXmi3pmNc2lfTcdlw6UsslQBFqt+miQom49vte90LJQWk4Ly56cvM
 fMjs4/0m9aldInncNaVoxBG9RRbi8TkdDcvRGZcvMB83JLz6IoOxq0tzFfe+/wS/Emwc
 4HFsYBQJBvhcqsWiEydK5NhtGD1qFBEVRCWJNLvE8VJlem0wipCanF5/LGDwZfSuDtFT
 DR6trpGJQcNflD0WtVAwSTwinmGRhnEjmABL2l9t/TF2B266w0D5iHMr5uP1yVCkxFAt
 G09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774344632; x=1774949432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVUpZCYnHaxysdlf+drvJnN0V8RdoIj2kFoJyLHiMhc=;
 b=ArvkRjwLMSTT/GegM8NV5srMVVcARCxxMQ6M1kJRIuTpclOJeuYoAJFrUFpoD8epGp
 Yyj5lQzBWyJSGo1tCDxXQbOeOj42rCODXYsNojEim4/cDeGR8p3+Jc1piyVB/GhSh34H
 Qa7o8lujz75KW7v8ylzdHDonnmJ0p32vQA7PdIdlWUoFC6JOwMN9yKAP1XQfuE18X04v
 uLjGz737nhO69SptvdCP39+SazUWaXV6E+ASxl0oXBc7/RVcY1ev3/BHlI6zCYecBiTA
 5hcUZ7hEK3qI1wnicKWj6u5zmAE0IRra3HdCFsLn9tG7cJUgDLVcEcfGMCMT9lTlvqSU
 QqVQ==
X-Gm-Message-State: AOJu0Yw2IIyMDDb/YmiKHFKV6L6xHgDWpfkgl/Fbr4h4n/1wYJ1JGmT3
 aA3CVttgYrpfwx/kFMFFnlvokYABu0VQLPvnJnK0OVLhJVaLQ66LBLFu29QuLNccSqil+DnXxxh
 sYM+GtkCGF1ILadyXwTsUP9+F2MORXz6g5FKCXiOasA==
X-Gm-Gg: ATEYQzzwWiLaLBGhyo6OIT0lcI1zcDnMz1RevZ/dX6kATzuBIzcfiLONj1MwwkbglOu
 uEtvdmebQSxC+HlosEpeUApq522vEXOGTv0oiK98T0rZJUCrGnKo1auMtXgA+c6cjWh7I+3ERWh
 muIYXVArS9aWw8jNoLMNbDP+yzkUfiAf/iEwDCnR4GF5vM50TCYgPbIodV6Z13ukzyZbvrk8ain
 4QInBJIDH8U5gno27Oiu9ALM+N7TeseF6HX4q4VGaiLBMMw59vP6YHKIKlRoFwyB3Yktx6PsCUc
 nzfWvIGpUIYXn4KfE9d7mI4VvEzcWAe579ttFKkiUqJzI15yMTCfxbCdQxUGDx4JRE21s9GLVfE
 n+JXNLqIr7e9w2vyO4h4+DR4rfyfDUIR9rETdTUuivH4FC0vt/WHy8Cyc8Flh4ZEt11mCU72Fx8
 AQGVhEAIH0ADEhWpEqbmeabeiFNoBzyM6e2+5uD/llvgkViNwI4F2cC4zD2aTys6iwm50TmCqAj
 2Oe1b07B8/K+bkvHPpF8GckKDXMD9crAX+k26xD/s/WJB4syG/HR4Hggdz57gLjjwm5NQNqLCp4
 Cy5IhLX7qkAIHhrpj9Sn4LVaw1wwjNDmlJgeAtRx11X06xjGb3v8ukQ=
X-Received: by 2002:a05:690c:22c4:b0:796:2fde:5dfe with SMTP id
 00721157ae682-79a90ba0251mr167979557b3.38.1774344631989; Tue, 24 Mar 2026
 02:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <85854708c4d707d9db8ec84c11e1686a32198d91.1773843890.git.michal.simek@amd.com>
In-Reply-To: <85854708c4d707d9db8ec84c11e1686a32198d91.1773843890.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Mar 2026 11:29:56 +0200
X-Gm-Features: AaiRm51Wuv1ngOqX500CSKnBziQc_83rtGLxP2T71xzhoufv4B3F9FrncOKrijc
Message-ID: <CAC_iWj+85eztMnt8G-cDsUgBJ7Jhpa+mB19F=d_VsKv4T2si-Q@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Allow disabling ANSI console queries via
 Kconfig
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, pbrobinson@gmail.com, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Shantur Rathore <i@shantur.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Wed, 18 Mar 2026 at 16:25, Michal Simek <michal.simek@amd.com> wrote:
>
> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
> introduced efi_console_set_ansi() to suppress ANSI escape sequences
> during unit tests. Extend this mechanism to be configurable via a new
> Kconfig option CONFIG_EFI_CONSOLE_DISABLE_ANSI.
>
> When CONFIG_EFI_CONSOLE_DISABLE_ANSI is enabled,
> efi_console_set_ansi(false) is called at the start of
> efi_setup_console_size(). This prevents query_console_serial() from
> sending ANSI escape sequences to the terminal, using default 25x80
> dimensions instead. This is useful for platforms where the serial
> console cannot handle ANSI queries.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>
> Changes in v2:
> - Replace runtime 'no_ansi' env variable with compile-time
>   CONFIG_EFI_CONSOLE_DISABLE_ANSI Kconfig option (Ilias, Peter)
>
>  lib/efi_loader/Kconfig       | 11 +++++++++++
>  lib/efi_loader/efi_console.c |  3 +++
>  2 files changed, 14 insertions(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index b5f81e0ff530..bae98e07d238 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -576,6 +576,17 @@ config EFI_EBBR_2_1_CONFORMANCE
>         help
>           Enabling this option adds the EBBRv2.1 conformance entry to the ECPT UEFI table.
>
> +config EFI_CONSOLE_DISABLE_ANSI
> +       bool "Disable ANSI escape sequence queries for console size"
> +       help
> +         Select this option to disable ANSI escape sequence queries for
> +         detecting serial console size. When enabled,
> +         efi_setup_console_size() will not send ANSI escape sequences to
> +         the terminal and will use default 25x80 dimensions instead.
> +         This is useful for platforms where the serial console cannot
> +         properly handle ANSI queries, causing boot delays or garbled
> +         output.
> +
>  config EFI_SCROLL_ON_CLEAR_SCREEN
>         bool "Avoid overwriting previous output on clear screen"
>         help
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 068d1a0a7b74..a798d5604a31 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -365,6 +365,9 @@ void efi_setup_console_size(void)
>         int rows = 25, cols = 80;
>         int ret = -ENODEV;
>
> +       if (IS_ENABLED(CONFIG_EFI_CONSOLE_DISABLE_ANSI))
> +               efi_console_set_ansi(false);
> +
>         if (IS_ENABLED(CONFIG_VIDEO))
>                 ret = query_vidconsole(&rows, &cols);
>         if (ret) {
> --
> 2.43.0
>
> base-commit: 0d7293676b1e644b9b9ee2e45fb1ed10337cef31
> branch: debian-sent3
