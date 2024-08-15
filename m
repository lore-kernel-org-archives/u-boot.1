Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB80C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4C988BCF;
	Thu, 15 Aug 2024 22:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L5yH3HY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C968657F; Thu, 15 Aug 2024 22:33:05 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F99288BCF
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d3c05dc63eso974524a91.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753981; x=1724358781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CAgmFiQqXZJcTN0TejYBV2jDzka/+RDbUgsiS2BE1Jg=;
 b=L5yH3HY4F6GiormjTdSXk8yzYWNo8ohcLUZosMjx6o5LsywtW6JNrSAcKqtu+zkMB7
 oeNjqJW9olQCIz5kM8c6dTToreZFlctAcnix6Lk9AMZdO5tqFQ7yTQa/KVKd8f2xlYs1
 rePhQe2RMaNSt5UjB4Sv51DHph6h2sIMskcIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753981; x=1724358781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CAgmFiQqXZJcTN0TejYBV2jDzka/+RDbUgsiS2BE1Jg=;
 b=cZvGSbC39iRKW5bqiVkPPB4cH2coaYPaomLPZDTIf6vPORgfA+iStcPfQPOeTabJ1G
 XVEstMxsKs/ZakO7svFz4TkYDqiKE2hexmAW/5/mpcQLq8/XcAz9bWrDronpuGmOrkyF
 HlN4OQMb71XRydHrf8KrnaCEtitRMtVUFpfruQKbHOiyMyxikIL2IOURqJQFIvRg1XrR
 0TUgMYnDmO4xVQzvDD9mcox1UYtqruOHObIREiCRL/SnNnSSEuS9v4W4GT+jAcylZ1dI
 9B2v1rJyHR1ncYC3sOPZId6dkOKHV2763bwgdiAytVGXv3iiyC7un2s0eU2d38ctjpXl
 X3cg==
X-Gm-Message-State: AOJu0Yx++qLzHU5aikUah0vcvxKuVSqnHSc7DtzgVGSCj1We+B2hcgxq
 fv06EGwOItleUKE2T392ixGKWVPwRK8WXPivjWUkdscR0MgkJtKRHP0RlkPJcnDnD9kE7ESOHlc
 u6GvDr+LeE8Z2UAhOBcoe5s8d1GrISeEGh3rq
X-Google-Smtp-Source: AGHT+IEiHVCJ9p4+2xqr4TT6ceA0ZqTpMk+/TjNhmjBvjIvbp4VKoP78+BPrU8ze+QekbswnsR4sCewHARb4JwihYQA=
X-Received: by 2002:a17:90a:ad83:b0:2d0:d82:60ae with SMTP id
 98e67ed59e1d1-2d3e04007f5mr933279a91.37.1723753981336; Thu, 15 Aug 2024
 13:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-33-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-33-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:32:49 +0100
Message-ID: <CAFLszTigDtzrLWzVfrVmq_Uet_GRoQWq7YVQcgerpk8XAT8BvQ@mail.gmail.com>
Subject: Re: [PATCH v2 32/32] lmb: add logic to print lmb flag strings
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 14 Aug 2024 at 05:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Instead of printing the LMB flags as numerical values, print them as
> strings. This makes it easier to understand what flags are associated
> with the lmb region. Also make corresponding changes to the bdinfo
> command's test code.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  lib/lmb.c         | 18 ++++++++++++++++--
>  test/cmd/bdinfo.c |  4 ++--
>  2 files changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But see below

>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 37d2a72951..5c5b3e9bb5 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  static struct lmb lmb;
>
> +static void print_region_flags(enum lmb_flags flags)
> +{
> +       uint64_t bitpos;
> +       const char *flag_str[] = { "LMB_NONE", "LMB_NOMAP", "LMB_NOOVERWRITE" };

As mentioned, LMB_NONE shouldn't be a flag. For the other two, how
about "no-map" and "no-overwrite"?

> +
> +       do {
> +               bitpos = fls(flags) - 1;
> +               printf("%s", flag_str[bitpos]);
> +               flags &= ~(1ull << bitpos);
> +               flags ? puts(", ") : puts("\n");
> +       } while (flags);
> +}
> +
>  static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>  {
>         struct lmb_region *rgn = lmb_rgn_lst->data;
> @@ -41,8 +54,9 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>                 end = base + size - 1;
>                 flags = rgn[i].flags;
>
> -               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
> -                      name, i, base, end, size, flags);
> +               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
> +                      name, i, base, end, size);
> +               print_region_flags(flags);
>         }
>  }
>
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 7dd3f7ca5b..887defc28a 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -120,8 +120,8 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
>                         ut_assert_nextlinen(" %s[%d]\t[", name, i);
>                         continue;
>                 }
> -               ut_assert_nextline(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x",
> -                                  name, i, base, end, size, flags);
> +               ut_assert_nextlinen(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
> +                                  name, i, base, end, size);
>         }
>
>         return 0;
> --
> 2.34.1
>

Regards,
Simon
