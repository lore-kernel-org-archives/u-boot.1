Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC32D63933
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433708969B;
	Wed, 20 Nov 2024 13:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hqHpBrLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F64895D7; Wed, 20 Nov 2024 13:40:45 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F60A896A6
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ed7d8d4e0so664892266b.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 04:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732106441; x=1732711241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K0aOOc+ssSQEXUlWVa6FituUdmW5QwI3JJYHGGO5kj4=;
 b=hqHpBrLMUWPRdbPjvNT+BoJ9POIZ/0cfCXEFy56TAJ3pMB3H/ecEG1NjHCX9G9hdtS
 NzWuF7UTZw5Fs+mn4JnalpgLGCJ+vMowvywn/eXLPUXZMWrHzpSQBjLpmycY4jZuvto5
 Gc3u3HQRVWyeAQEFOKRVx6+iWaVtIyw4wUHvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732106441; x=1732711241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K0aOOc+ssSQEXUlWVa6FituUdmW5QwI3JJYHGGO5kj4=;
 b=eac/DjbM+aEOO+miyFmYC5IA+ZoWEkOR7zDMhiZyQG6pXmND9LCCkEvKwM0lGm91Hu
 sPD0v/8B5Fn9+JpXNLajbUuFvHW5cU/BYx7qLBnYgJh8vuGnyco1czEBX2T9uSbnORrz
 6pHzS7oiBBfg8AdZ64MqtPe/pSOnCodYQBmfPONI3sFUQNyxuz0aRmznTXtTaXbLm+ai
 zDEi2iUvEqMfsFe9ZXG3IUuC4VkAtt3z+v/Vfsm43y5tNJMBSer4KKdUIsEtiIkAQCd7
 N2LnsK53I0z2Q1enFHnuj2K2hWwgPEU6DzAGTcWX4HMHyPl9PVMnpRJe9ns6UJMJYF6c
 3a2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUccUMSf/k/Xbv8L/yi2B6CKh06g0R/5UqUAFmIFw1VCEiPn4GSEKMIVtB3GbWDLwzKvsiyQAM=@lists.denx.de
X-Gm-Message-State: AOJu0YyuaK00m5GP/D+qCnaiMjUwtCrKRiAlq3Mh6rttfjUY99qQK3cg
 +qRqDsjp6VN2CBxjM5mz0OhOUfXmzoCvq8WeVRoJcd37RTmxD3+6TDfPFbT1ETCBRWL95wPMyRf
 93czzlAj/pkqNU6Y5KeKUg7CG9bu69b9CtWhp
X-Google-Smtp-Source: AGHT+IEHl+rkqy3VdJ7YEWjhGaz18ZG8mVra4uC6C4qcr/h35xgKFTcSh6B5M8ZaxTaJrkyao+yIMa1Jzd9nZjZjjoI=
X-Received: by 2002:a17:907:2da3:b0:aa2:c79:c93d with SMTP id
 a640c23a62f3a-aa4dd547f70mr237941066b.2.1732106440427; Wed, 20 Nov 2024
 04:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20241116200822.27160-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241116200822.27160-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 05:40:29 -0700
Message-ID: <CAFLszTg=E5ScwSQm6Msm7+AUic5GL+rNCq1Cy4_3wnRWgsJPPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: cmd/hash: check return value of
 ut_check_console_line
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sat, 16 Nov 2024 at 13:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> ut_check_console_line() does include an assert.
> Pass the result to ut_assertok().
>
> Addresses-Coverity-ID:  514958 Error handling issues
> Fixes: 7dfafcd65ef3 ("test: unit test for hash command")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/hash.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/test/cmd/hash.c b/test/cmd/hash.c
> index 2fcec9cadcd..296dd762b31 100644
> --- a/test/cmd/hash.c
> +++ b/test/cmd/hash.c
> @@ -33,11 +33,13 @@ static int dm_test_cmd_hash_md5(struct unit_test_state *uts)
>                         strstr(uts->actual_str, "md5 for "));
>         ut_assert(strstr(uts->actual_str,
>                          "d41d8cd98f00b204e9800998ecf8427e"));
> -       ut_check_console_line(uts, "d41d8cd98f00b204e9800998ecf8427e");
> +       ut_assertok(ut_check_console_line(uts,
> +                                         "d41d8cd98f00b204e9800998ecf8427e"));
>
>         if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
>                 ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
> -               ut_check_console_line(uts, "hash - compute hash message digest");
> +               ut_assertok(ut_check_console_line(
> +                               uts, "hash - compute hash message digest"));

ut_assert_nextline("hash - compute hash message digest")

>
>                 return 0;
>         }
> @@ -77,12 +79,13 @@ static int dm_test_cmd_hash_sha256(struct unit_test_state *uts)
>                         strstr(uts->actual_str, "sha256 for "));
>         ut_assert(strstr(uts->actual_str,
>                          "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
> -       ut_check_console_line(uts,
> -                             "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
> +       ut_assertok(ut_check_console_line(
> +                       uts, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
>
>         if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
>                 ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
> -               ut_check_console_line(uts, "hash - compute hash message digest");
> +               ut_assertok(ut_check_console_line(
> +                               uts, "hash - compute hash message digest"));
>
>                 return 0;
>         }
> --
> 2.45.2
>

Regards,
Simon
