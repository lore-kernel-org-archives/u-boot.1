Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB0FC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 07:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49FA782ADA;
	Tue,  1 Jul 2025 09:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HrFGS0mB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A1D82F03; Tue,  1 Jul 2025 09:54:11 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806EB8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 09:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e302191a3so53072967b3.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751356440; x=1751961240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SfFX/nr4MSqLxvj12UCsP8Yo+9WAWwjHXwSWqtTGx5E=;
 b=HrFGS0mBGZxh3hsCkvscoLJLVUe+/SyQpW4qwVvtlIAfnwV9DpG71PvKmEcMFo9Crh
 4f3ORryuyjNZui21KPBqul/qpheP8k374/KcIHh5qvR5EpnMz8VSJqGmjEOYp3/iFsem
 0jb7XtOrvqzM+xcDi8oOks59Of8VVXp1vv2CzEOjZAJK+eAmiAfg+IDL1XxiNCQPmd9d
 h8C2fiumKzzuCGPO17hdwJ/Ax5rEKnx4oUboHu4eJbp2Mco7ZwCSugF1YfcQqYQ5CKj7
 f9+L6kVIg+sKKplwgsYv4SUMXeyAgtLnI9rnUK0GYU+VfyLLWqDA13tUK/wYTqySRcoW
 UpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751356440; x=1751961240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfFX/nr4MSqLxvj12UCsP8Yo+9WAWwjHXwSWqtTGx5E=;
 b=U/IjPdKiPTMCkHItG0uIg2tmyoAIV/DCx6agtuLaMNgeLpMsPTnhGnysOT2wXWSWmn
 cV0AeA5Qqquq5LXffb463a50j7eS2B2+2bq+awXRPMUzasDktLYAES9GUtiCorqMXcmL
 4J0VSBihBdb6duywmjcZ310bd/jacus3VBNTaixSq+b+BCcsyWwow3FUgG1t9yFOXbYl
 QK8GYyEqQeD5fTsLzDMFugwbdGQC/5eJ7gdc/nrvyzev6VxZJhwkxFedEFyccE9+E2MY
 ZXZFX5M5hM0hld9teBzS9IZgXz4d0VxLmDTdQDaRmOTYA7xDNUcG7DcqiqMJCTShrma3
 5IDQ==
X-Gm-Message-State: AOJu0YzItJnrH/It8vieeTHowt7eUg1FDhyKChhxAmCWeYAUOJlS4C8Z
 QxMM2i2eNW2fH3mmhgLMVLeyWugGLwlJ/wPZphgf3HW01StWNI7t1RPdoncjUy1ApjgJJGcyYDU
 UCONBlbO6mFbNLYVb9i8d4ys187bkJrKB5mN+YUFS/g==
X-Gm-Gg: ASbGncucXDtMx/alAzkOGBdh/7UMLdwdzuhpR8DQ5CvNxA4ruQO4E78fwLHYEKQ3iwg
 WQXhecCqXVV7Zm+d6bs8x5gQfDU7UehJZsZOxySECOOagaAuxFJQb1tqyHE2PzW+SBNIagTlkLl
 ytsHIfs0a8iieIduO9s8460i51/L3Pbo+jXsVIsFoL8Knn
X-Google-Smtp-Source: AGHT+IH/ZRe/nslxhljq0zd/sFCQKpsDZ+bzSgcxI6IWMD4Xre9NV9kDhFVMLjpTcb3jchBMNaARTM+a+14ihBVBM0A=
X-Received: by 2002:a05:690c:7207:b0:715:969:ce31 with SMTP id
 00721157ae682-715171b7c33mr248835047b3.35.1751356440304; Tue, 01 Jul 2025
 00:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250627112509.264221-1-sughosh.ganu@linaro.org>
 <20250627112509.264221-3-sughosh.ganu@linaro.org>
In-Reply-To: <20250627112509.264221-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Jul 2025 10:53:24 +0300
X-Gm-Features: Ac12FXylFU__iPPiSNXPARBJ45jRjOoIl9nWyYFhGeWcVYHWN7I_R8WbE78mKng
Message-ID: <CAC_iWjKk8YXhLGkf69rRRdyxYwCt0MvRpzkUrpjrROoe7QFrEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] test: wget: add a test case for validating URI
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Fri, 27 Jun 2025 at 14:25, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The wget module has a function wget_validate_uri() which is used for
> validating the URI to be used by wget. Add a basic test case for this
> function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  test/cmd/wget.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/test/cmd/wget.c b/test/cmd/wget.c
> index 445750660c2..1005392b952 100644
> --- a/test/cmd/wget.c
> +++ b/test/cmd/wget.c
> @@ -241,3 +241,23 @@ static int net_test_wget(struct unit_test_state *uts)
>         return 0;
>  }
>  CMD_TEST(net_test_wget, UTF_CONSOLE);
> +
> +static int net_test_wget_uri_validate(struct unit_test_state *uts)
> +{
> +       ut_asserteq(true, wget_validate_uri("http://foo.com/bar.html"));
> +       ut_asserteq(true, wget_validate_uri("http://1.1.2.3/bar.html"));
> +       ut_asserteq(false, wget_validate_uri("http://foo/ba r.html"));
> +       ut_asserteq(false, wget_validate_uri("http://"));
> +
> +       if (CONFIG_IS_ENABLED(WGET_HTTPS)) {
> +               ut_asserteq(true,
> +                           wget_validate_uri("https://foo.com/bar.html"));
> +               ut_asserteq(true,
> +                           wget_validate_uri("https://1.1.2.3/bar.html"));
> +               ut_asserteq(false, wget_validate_uri("https://foo/ba r.html"));
> +               ut_asserteq(false, wget_validate_uri("https://"));
> +       }
> +
> +       return 0;
> +}
> +CMD_TEST(net_test_wget_uri_validate, UTF_CONSOLE);
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
