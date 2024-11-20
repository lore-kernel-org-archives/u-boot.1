Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6FAD63933
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D368589353;
	Wed, 20 Nov 2024 13:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bFLYAHO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B55895D7; Wed, 20 Nov 2024 13:40:35 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD898932B
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa4d257eb68so168883766b.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 04:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732106433; x=1732711233; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OJk3DQ8o43s/CTMlBYM+gExCpm2eQUF2GwhMOeK9BzI=;
 b=bFLYAHO8EWEivDsPI9Wj6C/X7Qpsy7xNqjE31SSfY21k/8VLiHWuAum644kLwIBRnh
 jvQtWeoEM/vlwn0vElWP8UsagQs+Pm4WoYCXpR3vMSgHgEr8wZZ+4c66RyeHRxIVeuEI
 uuJei49if7CrIz+bhpWJQUmAazw44X1tKAMkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732106433; x=1732711233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OJk3DQ8o43s/CTMlBYM+gExCpm2eQUF2GwhMOeK9BzI=;
 b=cQPzGlDHh9qUkXdg946Srplzb2BX/gFQO4SBRlathClKaHTDybJe5j/nLJ+HBp4iQ+
 SxEeqgwXMVZ245WmuOX/wNx+PohrCw7zhZeVJ5aux5hzC0+V78KMyfYgKaXi8w1CfUIb
 D4KtrCQc/1DM8HWG6hsmWYzn6j8gfVbzzj52PF8qBHH41O4POSuBoFFNvQG57OXW2MJs
 92CHYeFguS+bx7bCdE3dTUCuZrP6rh4DePqgHr8dgwMA0g4Xaigfvf4LUHp9v6GyL9rZ
 3n17vND2iUYN1JDBIdG9iT/4qGSV8o1fPTNj66ohxKKLeMM4vBRUYNzUoKGp40RaK09h
 T7Bw==
X-Gm-Message-State: AOJu0YxAeWtTqroarqbp+ayLbd2JmbSVX/NFZ+d20ymfGLCKNKsz0Iz7
 V91cP2CJ4UpwvpOa//u/vkUq4HtzB91CsCwuTYb/hbf2kwWAgYBTLvcTWOZtgt9+78G2iDizw2G
 QGyK0MSAwIV+DODioXq8JtgrMVD3EhKYdGeAEB9RSYN9Pckk=
X-Google-Smtp-Source: AGHT+IG1b0D58i06lmU0xorbFnuohXNob9MWpHDdr7c1zA8bNnBk8JUstdCGLupY5CHNy4XhwnPVv0VDnOsOvvnJD/c=
X-Received: by 2002:a17:907:9725:b0:a9e:85f8:2a49 with SMTP id
 a640c23a62f3a-aa4c7e18c2dmr744640266b.8.1732106432904; Wed, 20 Nov 2024
 04:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20241119140526.3485208-1-trini@konsulko.com>
In-Reply-To: <20241119140526.3485208-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 05:40:20 -0700
Message-ID: <CAFLszTi6e7tSg2+nqyBEK=ZukE7ngtgPs1+mGafiR=fXY9wODQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "test: Update time tests to use unit-test asserts"
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

Hi Tom,

On Tue, 19 Nov 2024 at 07:05, Tom Rini <trini@konsulko.com> wrote:
>
> While at the base level, this conversion looks equivalent, we now see
> both of these tests failing (due to exceeding their allowed margin for
> being too slow) in Azure with a very high frequency.
>
> This reverts commit 88db4fc5fec20429881896740df61d402b4b1f66.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/lib/time.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Not sure what we should do here, to fix this for good...


>
> diff --git a/test/lib/time.c b/test/lib/time.c
> index b99e738c500f..2095bef75892 100644
> --- a/test/lib/time.c
> +++ b/test/lib/time.c
> @@ -22,7 +22,11 @@ static int test_get_timer(struct unit_test_state *uts)
>                         next = get_timer(0);
>                 } while (start == next);
>
> -               ut_asserteq(start + 1, next);
> +               if (start + 1 != next) {
> +                       printf("%s: iter=%d, start=%lu, next=%lu, expected a difference of 1\n",
> +                              __func__, iter, start, next);
> +                       return -EINVAL;
> +               }
>                 start++;
>         }
>
> @@ -31,7 +35,11 @@ static int test_get_timer(struct unit_test_state *uts)
>          * an extra millisecond may have passed.
>          */
>         diff = get_timer(base);
> -       ut_assert(diff == iter || diff == iter + 1);
> +       if (diff != iter && diff != iter + 1) {
> +               printf("%s: expected get_timer(base) to match elapsed time: diff=%lu, expected=%d\n",
> +                      __func__, diff, iter);
> +                       return -EINVAL;
> +       }
>
>         return 0;
>  }
> @@ -49,8 +57,11 @@ static int test_timer_get_us(struct unit_test_state *uts)
>                 next = timer_get_us();
>                 if (next != prev) {
>                         delta = next - prev;
> -                       ut_assert(delta >= 0);
> -                       if (delta) {
> +                       if (delta < 0) {
> +                               printf("%s: timer_get_us() went backwards from %lu to %lu\n",
> +                                      __func__, prev, next);
> +                               return -EINVAL;
> +                       } else if (delta != 0) {
>                                 if (delta < min)
>                                         min = delta;
>                                 prev = next;
> @@ -59,7 +70,11 @@ static int test_timer_get_us(struct unit_test_state *uts)
>                 }
>         }
>
> -       ut_asserteq(1, min);
> +       if (min != 1) {
> +               printf("%s: Minimum microsecond delta should be 1 but is %lu\n",
> +                      __func__, min);
> +               return -EINVAL;
> +       }
>
>         return 0;
>  }
> @@ -80,7 +95,8 @@ static int test_time_comparison(struct unit_test_state *uts)
>         error = delta_us - 1000000;
>         printf("%s: Microsecond time for 1 second: %lu, error = %ld\n",
>                __func__, delta_us, error);
> -       ut_assert(abs(error) <= 1000);
> +       if (abs(error) > 1000)
> +               return -EINVAL;
>
>         return 0;
>  }
> @@ -99,7 +115,8 @@ static int test_udelay(struct unit_test_state *uts)
>         error = delta - 1000;
>         printf("%s: Delay time for 1000 udelay(1000): %lu ms, error = %ld\n",
>                __func__, delta, error);
> -       ut_assert(abs(error) <= 100);
> +       if (abs(error) > 100)
> +               return -EINVAL;
>
>         return 0;
>  }
> --
> 2.43.0
>
