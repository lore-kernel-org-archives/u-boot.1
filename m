Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86C6E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 07:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB1D803DC;
	Wed,  8 Jan 2025 08:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AMOwV6CU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16FE2805E2; Wed,  8 Jan 2025 08:13:25 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE60B8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 08:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e54bd61e793so5003862276.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 23:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736320401; x=1736925201; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HX+sOadEwAPyZY299SkTVtmrJAFtRZ6LGZYlf6ECnQs=;
 b=AMOwV6CU33zi2Rj9oos2G/nFZRxX5BSLWRiOEk+Y0NE0k1d1ozwJQfnBlc5b4O6y+6
 /aZ/g8yviR9ZmmDObT+neyVGLRU7cr/X3ZLRtIehn7q2UClUW5+znLyKECJRcxLcMDl3
 aoAyEnPE1dS6zxeaETmrpz+52WGPyVQZIiYKfh+KxFf6tbH2F+6nlifIadSQq4HMtz05
 ybQR4ThzNnjL8xxLWJDNsTSDc0U14O1LnAXWGJ+WtK9ZhFs0Aq4lVzXZRXrh46bzwewL
 Smn27kHnjp5HuVA8VWJae1i1u1U4v3uXHTRVlpr6WmB21UgU0XeLgiWPuefG2Nrt62KO
 u0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736320401; x=1736925201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HX+sOadEwAPyZY299SkTVtmrJAFtRZ6LGZYlf6ECnQs=;
 b=T30O7ZoNPhv+Kmdp3qHZ2aTVF+yGOr+yspzz3g/PvKaM72Ny2IW/5OfphCxA5HTMPe
 J57OJl7fTn9pgBiuWGIqb/1KTg9+iEPsCOs9GxNXqrwr/h4FlNe0TlP/cO3xD0YuvMPF
 Bp1HCMUGSrxX0Qll5S8nt/GOZNCRE2QKZnURCAVLEfbMnZQ0ncqNkuDcYzsm/XVtsxMI
 JqkDPM2O6WqyqwK+BjZHmS2dX/t+ygKMHrdK92MfLztKYlr44qvZrG1vvywC78VNFeC2
 Tn3Fsfg0WjwAO6Asiailn6XGgIyFTV4S7/2t1GJ8jYXoaIHW6IRHdqapO68I90MRJoKI
 dIFw==
X-Gm-Message-State: AOJu0YxnyYoBH61wGuu1d7XTZaSFV2h42MsgKuEAYRlApYN9rDH6y0kO
 ACs5l4XF62dEo92JUPzqUT5JHk/ru/9fAyBF9//K+uImiTD+azam4OIk18+ZekpuzrFJmBbbdyL
 fYcrgNN0FR3/oqC3ORQpCzYAiBhtM3kwHAYFcHA==
X-Gm-Gg: ASbGnct+L4WnVp5vOFAyDtvN0CIjb0TbYu1Zl94PRSggU8o9sKJk4jQzWvwSOLSyRU0
 6Egxe7JdrS4tAKcBwu2E9fwgt4vMiJs4UFb9H0g==
X-Google-Smtp-Source: AGHT+IFYjfNwdKa29eAympM6N5pUOabm446p3SHRy+umKP4qUtvt2zHxoHLXPf4m8i+PFflS0QpEzV5kvvVWID6wccM=
X-Received: by 2002:a05:6902:188a:b0:e4e:95b3:4fe1 with SMTP id
 3f1490d57ef6-e54ee2401ebmr1196000276.53.1736320401445; Tue, 07 Jan 2025
 23:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20250107150258.813289-1-raymond.mao@linaro.org>
In-Reply-To: <20250107150258.813289-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Jan 2025 09:12:44 +0200
X-Gm-Features: AbW1kvaOYmsQ0pSLF-t_kxSpkyGAGH_To0xbBXb4Nl8PkN_79HOjiXsujWYHWlA
Message-ID: <CAC_iWjK31eCOudcxoiOnj6BB2HW3gf-X6qWjReojPLshKzo7Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bloblist: add api to get blob with size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
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

On Tue, 7 Jan 2025 at 17:03, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> bloblist_find function only returns the pointer of blob data,
> which is fine for those self-describing data like FDT.
> But as a common scenario, an interface is needed to retrieve both
> the pointer and the size of the blob data.
>
> Add a few ut test cases for the new api.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Rename function argument.
> - Add ut tests.
>
>  common/bloblist.c      | 17 +++++++++++++++--
>  include/bloblist.h     | 18 ++++++++++++++++++
>  test/common/bloblist.c |  4 ++++
>  3 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 110bb9dc44..ab48a3cdb9 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
>  }
>
>  void *bloblist_find(uint tag, int size)
> +{
> +       void *blob = NULL;
> +       int blob_size;
> +
> +       blob = bloblist_get_blob(tag, &blob_size);
> +
> +       if (size && size != blob_size)
> +               return NULL;
> +
> +       return blob;
> +}
> +
> +void *bloblist_get_blob(uint tag, int *sizep)
>  {
>         struct bloblist_rec *rec;
>
>         rec = bloblist_findrec(tag);
>         if (!rec)
>                 return NULL;
> -       if (size && size != rec->size)
> -               return NULL;
> +
> +       *sizep = rec->size;
>
>         return (void *)rec + rec_hdr_size(rec);
>  }
> diff --git a/include/bloblist.h b/include/bloblist.h
> index f999391f74..52ba0ddcf8 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -250,6 +250,24 @@ static inline void *bloblist_check_magic(ulong addr)
>         return ptr;
>  }
>
> +#if CONFIG_IS_ENABLED(BLOBLIST)
> +/**
> + * bloblist_get_blob() - Find a blob and get the size of it
> + *
> + * Searches the bloblist and returns the blob with the matching tag
> + *
> + * @tag:       Tag to search for (enum bloblist_tag_t)
> + * @sizep:     Size of the blob found
> + * Return: pointer to bloblist if found, or NULL if not found
> + */
> +void *bloblist_get_blob(uint tag, int *sizep);
> +#else
> +static inline void *bloblist_get_blob(uint tag, int *sizep)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  /**
>   * bloblist_find() - Find a blob
>   *
> diff --git a/test/common/bloblist.c b/test/common/bloblist.c
> index 4bca62110a..324127596f 100644
> --- a/test/common/bloblist.c
> +++ b/test/common/bloblist.c
> @@ -98,10 +98,12 @@ static int bloblist_test_blob(struct unit_test_state *uts)
>         struct bloblist_hdr *hdr;
>         struct bloblist_rec *rec, *rec2;
>         char *data;
> +       int size = 0;
>
>         /* At the start there should be no records */
>         hdr = clear_bloblist();
>         ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
> +       ut_assertnull(bloblist_get_blob(TEST_TAG, &size));
>         ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
>         ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
>         ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
> @@ -114,6 +116,8 @@ static int bloblist_test_blob(struct unit_test_state *uts)
>         ut_asserteq_addr(rec + 1, data);
>         data = bloblist_find(TEST_TAG, TEST_SIZE);
>         ut_asserteq_addr(rec + 1, data);
> +       ut_asserteq_addr(bloblist_get_blob(TEST_TAG, &size), data);
> +       ut_asserteq(size, TEST_SIZE);
>
>         /* Check the data is zeroed */
>         ut_assertok(check_zero(data, TEST_SIZE));
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
