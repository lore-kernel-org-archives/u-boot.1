Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987FFD711B8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69FC89350;
	Wed, 20 Nov 2024 16:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bWuw33DS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B83B88FAA; Wed, 20 Nov 2024 16:34:14 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6292D892DE
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso1843950b3a.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116851; x=1732721651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kIp3uId5pIDj8tHI7vZ8aGwKnMV7TrAQWTy6iP5YiHg=;
 b=bWuw33DS6wqUbqgGxJoxbm5z5+KyZqw+l3/qV/BUjzylzpsj9hI6YGZz621AN10r3S
 XmcjWyJwZndIYnbNDnW1GPHQTwNWrSz/VLkg2MSlwrjKHr7u/SDYydkfNcFg0eShuiGF
 ngn6R39j1lWIic2HZHsbRCnAv28dzFJwJlrC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116851; x=1732721651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kIp3uId5pIDj8tHI7vZ8aGwKnMV7TrAQWTy6iP5YiHg=;
 b=CcOYF21lPBoOCmCloFtgwRwuBfJQJ3Wg9i44bKjwP9ckjnrX5h3VFQNXg7QXHdvU7O
 3GUpotHIqR4M48ziw+pQuRio/2eUNghC+S+4/beyzBYlri6hjFtN8n2/YY2y5f77s2vn
 2RCocZ3hTF4S60TPqQChn3oBcmP8geJLsZsv/ESCHoyRVRkHUCndqX+vXzqZSE1WSHXX
 0fU+EdlAzpwWaZWmh8ydJozC5dXTO+ykT34flfgkz+ohVt32116jXbXSu1HQiQHbPcWW
 boJIy5CsZma1Byw4WnJ2EKIXHCVlbV/G9x9rVVYBIVwpriiqkvXSPgroF4C5JA0Ri4fb
 ztpQ==
X-Gm-Message-State: AOJu0YwLs45KfH525LOXisdn2Col21XEn76Ont9NjzLMlYD7K60vrMn1
 zfLOA9l4+wWDrhP3OXewrxmgr6k6pn3cvVnKlHxFWquKnZTZAonQVqHVTRWhuWb1K84MOUcE44M
 nVGs9b8BgcDhx1dPRzvd4boTRf6U1ND1lhfyb
X-Google-Smtp-Source: AGHT+IE69sBb6CoSkvtNP0V5kUu7esWtTnPtoZIv6I9RreVgGb4kF1Fjih0N28viD9sb2SYmWqfrzX9sSETByjKVOu8=
X-Received: by 2002:a05:6a00:3a12:b0:71e:5d1d:1aa2 with SMTP id
 d2e1a72fcca58-724bec9ad56mr3521369b3a.7.1732116850927; Wed, 20 Nov 2024
 07:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20241101130254.473017-1-andrew.goodbody@linaro.org>
 <20241101130254.473017-3-andrew.goodbody@linaro.org>
In-Reply-To: <20241101130254.473017-3-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:33:51 -0700
Message-ID: <CAFLszTjvPaMe7QW6Qc0Q+3KQeMO9TcXaE4oWkGiC8-phekbwUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: bootm: Ensure GD_FLG_SILENT is reset
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Fri, 1 Nov 2024 at 07:03, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> Some bootm tests expect that GD_FLG_SILENT is reset in order
> to work as expected. This is the state if the test is run with
> 'pytest --verbose' but not if run from, say, the sandbox command
> line.
> So reset the flag for those tests that rely on it being reset. This
> has to be done in each test as the test infrastructure will set it
> again before every test when not invoked with 'pytest --verbose'.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
>  test/bootm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/bootm.c b/test/bootm.c
> index 5f57ecb337..52b83f149c 100644
> --- a/test/bootm.c
> +++ b/test/bootm.c
> @@ -26,6 +26,9 @@ static int bootm_test_nop(struct unit_test_state *uts)
>  {
>         char buf[BUF_SIZE];
>
> +       /* This tests relies on GD_FLG_SILENT not being set */
> +       gd->flags &= ~GD_FLG_SILENT;
> +
>         *buf = '\0';
>         ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
>         ut_asserteq_str("", buf);
> @@ -43,6 +46,9 @@ static int bootm_test_nospace(struct unit_test_state *uts)
>  {
>         char buf[BUF_SIZE];
>
> +       /* This tests relies on GD_FLG_SILENT not being set */
> +       gd->flags &= ~GD_FLG_SILENT;
> +
>         /* Zero buffer size */
>         *buf = '\0';
>         ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, 0, BOOTM_CL_ALL));
> @@ -70,6 +76,9 @@ static int bootm_test_silent(struct unit_test_state *uts)
>  {
>         char buf[BUF_SIZE];
>
> +       /* This tests relies on GD_FLG_SILENT not being set */
> +       gd->flags &= ~GD_FLG_SILENT;
> +
>         /* 'silent_linux' not set should do nothing */
>         env_set("silent_linux", NULL);
>         strcpy(buf, CONSOLE_STR);
> --
> 2.39.5
>
