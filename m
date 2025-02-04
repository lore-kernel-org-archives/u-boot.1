Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CA9C0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5BC1800CF;
	Tue,  4 Feb 2025 09:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PdNT1ngY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217BC801DE; Tue,  4 Feb 2025 09:47:16 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFAF8800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e589c258663so5088793276.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 00:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738658833; x=1739263633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eKNJ525lr0rjJDD4YGJJdNhKQiNsioqKdrxXypUnYcQ=;
 b=PdNT1ngYRAqf1j2hAKCsoz2PvVRdmIGwlozW7r6TOowWCfzr9WFO2rcTNdv6g65RaU
 nYr/IVHyVgVvnNm4oGQYUsMKuogvKqlmw0RZZOxz0Q+2Vbxg3o2HhbIkdyXlQMf5PIdO
 TJmDJ/S8UBoAvw9Mjbd1Ck/QR684kBGiFjIIPBwdMwzD5TGZ5nLAKEUTicIYQCY3zlTL
 /G5yyzOOfdg3uRb9kbBMNbj3skCsglw5Hl/DlIGI9PSjZGI8uFCCgTzKmJVeEwf7XNS3
 /kndJv7I1cO6s2NsA+fI1Ej+3XCXPgbQMMxr/EBmgdtTwDCrYEl8KDZyUKsjXzCHXV1w
 IPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738658833; x=1739263633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eKNJ525lr0rjJDD4YGJJdNhKQiNsioqKdrxXypUnYcQ=;
 b=n+owAmzVcCtWQPibKzwEQTiGrzNa7OVzpsfz8Mpm5n33stR8hPzfvxqE5eoznY1J1v
 0HNfV5yNIkoTwLnlrhbK+OSyRBaakQ5HXiBWJ7grgW0yv/7IIkKIfH59B2IvMy/NFfgc
 hEC9VxW1SwocK6rHVdaYtJLEzvAIOl29X9oBQPRY535fP365yrkFe4okrgZcP5LXVq8H
 JTT+6MZTaKFX1z+QfeNo8ZDYWJzwx+h9cFPRqoEv8BCK8NxWuQBdxC3969m9TRTrKbM4
 eOyMm2JDH62LIptzNThONvwadShvsV4wQRch6GsguExw0kcOmH+oiJRvCR3UqhnGBVL+
 gtkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOuvtN7O4yAyjJimSc6plNDNVK3aUBxrO2jo8qOdY8ga0eIsj0Il5d15xmMZ2tNk+olUpScTA=@lists.denx.de
X-Gm-Message-State: AOJu0YzLJy0vWYYJB6FNDAbPZzr29zrVDCHYE+unAYxIT4wJbsEoWmE9
 pbv3ON54Hg9Zbfb5zhOC3xCkseNbUeaxojzgX863crVCifXxnmX47FHKKhr16ujIpRJRfA/z1gk
 SvPXKIvPU56UnAml38YJflavUz+hV1wcr5Yj72Q==
X-Gm-Gg: ASbGncuw4OYQSaF8JJ6c4RnMW1MEvwDjuCInrstqBltDMs3HgON3zesKeVsoKlqiUOn
 mYN1TfTJui4XTaRh1flJA4fJ/eMvST7ysFjPKwMrwdJBEdA/Zn4wvFz2v2mBEE29BxPqv1eBY
X-Google-Smtp-Source: AGHT+IFf+YGRb1VuqPre36p1tnbMSsY/aPbv1TvHYVUUxL7ePhJ2MaYePP+YatVdn9siGtHQsU2mAkMRcQd9EATQ/E4=
X-Received: by 2002:a05:6902:144c:b0:e57:4b14:6fdb with SMTP id
 3f1490d57ef6-e58a4baaa4fmr18501832276.34.1738658832763; Tue, 04 Feb 2025
 00:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
 <20250203091203.47590-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250203091203.47590-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 10:46:37 +0200
X-Gm-Features: AWEUYZnElt8maaIkT44Rp1O_4yYiaPrHukkmO1RAFgTRC99-LrGjmNK0L-ZyjpU
Message-ID: <CAC_iWjK15snQ+bSHShMp3GCVUj+MAoUCtWzoTJSxTcrP2t2d2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] test: unit tests for strstr() and strnstr()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Mon, 3 Feb 2025 at 11:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add unit tests for the library functions.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> v3:
>         no change
> v2:
>         no change
> ---
>  lib/string.c      |  2 +-
>  test/lib/string.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index 691c9985692..3a74493d223 100644
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
