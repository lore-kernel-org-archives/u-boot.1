Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0328AE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 07:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502E6801FD;
	Thu,  9 Jan 2025 08:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RAj6piE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB6C80317; Thu,  9 Jan 2025 08:54:23 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09570801F5
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 08:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so775000276.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 23:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736409260; x=1737014060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0aIWE1dvz5k1gvxycNOrZ/racvZGATcUzvwkjI4C3pM=;
 b=RAj6piE/YPKbNz9vsG8QcD6gTq6QpCsXKoPs8KMeCYw9qLrF4JSSzBRM9hdbDoZw9K
 /E1hEhVB/TrAElKeWH92Qu3d4gAi5wMDq5wf4I29Ituiq4qxnOHfEKaIUjwVY8odBprL
 rCbngWSEW/7706f47NkiPVy5OVvGnOZ5TgPw6pENwIiTuDFtHcg/yfZTQkEg+eZEQEVV
 YBTMkitBOFKXArXsIWrELKcxz/agL+KveFOlQvh8aLngWJqw28tfrg4auH2iion+KIuD
 9tpikeW+yOojsqsinOZv2poNBdXeNtEQ5PvNzAs3uVIqvMWBT9UVLQowj2dvDPp4flgF
 dfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736409260; x=1737014060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0aIWE1dvz5k1gvxycNOrZ/racvZGATcUzvwkjI4C3pM=;
 b=CRoKL42/FMuHvXWLs4eTc6UpiML5H/Uq9XOuAeHWH+8exiqbaDq2FDvfczUs82WrVu
 0GXuDvP//MUwfZsVa0MH0eFcgheiGjZUFON5EbrMAF436hqCqSkyYn4AxfwNo3rmsZKZ
 Z+hlvK86oGBprmCIbp937lgsEsGRJgguGk1b7LnT7K6umtY/iMiZ2ktsT5JSKHlUvlSu
 oJVG+yooc6hVYeIENxc/vN+87FWPU2bzJXk7iNKvqM3ojWKIkM+7XtkpACdMVjV8LKHv
 pjJ5JqszON78lb7CSU+k5avNZdyhoEu54M6AB3bUo1duiFNEcg4Mk4aO/VYtowK2Xb1D
 q7cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJdV0YFemz5NdzJLafrgSVFd3izgbv2CqXwuXXvUNQdVvcs2wh6/N8sBS+pDiVDtOD9gJvIjY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9B6dAZtCYLDy3YKun8R5BqIrNNMN+Xvf+/jnmX1k6moapL7CS
 cIOMBrLsazId7uLus0pjmozppD5bIIsLx3iaRxx9vAn/9N8znMnV0UyHjhnFHML6lm0QNqiyZgX
 iSKRogtae5YfEHMWgBRo+32G/eyBpHbAWvk+Kgg==
X-Gm-Gg: ASbGncvH4T3qb/KahJ2wOd7H/JvFCAJOziRFIK2mYvrq5s6AYryEP4JqMdfL4hyiQz6
 CdIiH29arT552vr5HhfPnF5ZxlNvB63+5a9sEUg==
X-Google-Smtp-Source: AGHT+IF9gY9dUqdywTLncdHkyXu+48DS3PFdDmhNVTItyVv1CTpHpYtPJH8LX9mWVauNof1zvqKCFC/l3x9XZv2d+PQ=
X-Received: by 2002:a05:6902:230b:b0:e4b:f516:38b7 with SMTP id
 3f1490d57ef6-e54edf39aa6mr4725232276.20.1736409259930; Wed, 08 Jan 2025
 23:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250103232118.711135-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Jan 2025 09:53:44 +0200
X-Gm-Features: AbW1kvbCthb81d0cBxrv3XXbEN88wjCrKWCjOxXMqZwM0iYOFS8XL01z-nu5twA
Message-ID: <CAC_iWjKn4WNV+e0+vxCzgt5LO9jovt+s6aS+zCExzGrMCFSu1Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] test: unit tests for strstr() and strnstr()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Sat, 4 Jan 2025 at 01:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add unit tests for the library functions.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/string.c      |  2 +-
>  test/lib/string.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index d5a486fb89d..66aae583940 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -16,8 +16,8 @@
>   */
>
>  #include <config.h>
> +#include <limits.h>
>  #include <malloc.h>
> -#include <stdint.h>
>  #include <linux/compiler.h>
>  #include <linux/ctype.h>
>  #include <linux/types.h>
> diff --git a/test/lib/string.c b/test/lib/string.c
> index 8d22f3fd68f..31391a387b9 100644
> --- a/test/lib/string.c
> +++ b/test/lib/string.c
> @@ -11,6 +11,7 @@
>
>  #include <command.h>
>  #include <log.h>
> +#include <string.h>
>  #include <test/lib.h>
>  #include <test/test.h>
>  #include <test/ut.h>
> @@ -221,3 +222,42 @@ static int lib_memdup(struct unit_test_state *uts)
>         return 0;
>  }
>  LIB_TEST(lib_memdup, 0);
> +
> +/** lib_strnstr() - unit test for strnstr() */
> +static int lib_strnstr(struct unit_test_state *uts)
> +{
> +       const char *s1 = "Itsy Bitsy Teenie Weenie";
> +       const char *s2 = "eenie";
> +       const char *s3 = "eery";
> +
> +       ut_asserteq_ptr(&s1[12], strnstr(s1, s2, SIZE_MAX));
> +       ut_asserteq_ptr(&s1[12], strnstr(s1, s2, 17));
> +       ut_assertnull(strnstr(s1, s2, 16));
> +       ut_assertnull(strnstr(s1, s2, 0));
> +       ut_asserteq_ptr(&s1[13], strnstr(&s1[3], &s2[1], SIZE_MAX));
> +       ut_asserteq_ptr(&s1[13], strnstr(&s1[3], &s2[1], 14));
> +       ut_assertnull(strnstr(&s1[3], &s2[1], 13));
> +       ut_assertnull(strnstr(&s1[3], &s2[1], 0));
> +       ut_assertnull(strnstr(s1, s3, SIZE_MAX));
> +       ut_assertnull(strnstr(s1, s3, 0));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_strnstr, 0);
> +
> +/** lib_strstr() - unit test for strstr() */
> +static int lib_strstr(struct unit_test_state *uts)
> +{
> +       const char *s1 = "Itsy Bitsy Teenie Weenie";
> +       const char *s2 = "eenie";
> +       const char *s3 = "easy";
> +
> +       ut_asserteq_ptr(&s1[12], strstr(s1, s2));
> +       ut_asserteq_ptr(&s1[13], strstr(&s1[3], &s2[1]));
> +       ut_assertnull(strstr(s1, s3));
> +       ut_asserteq_ptr(&s1[2], strstr(s1, &s3[2]));
> +       ut_asserteq_ptr(&s1[8], strstr(&s1[5], &s3[2]));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_strstr, 0);
> --
> 2.47.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
