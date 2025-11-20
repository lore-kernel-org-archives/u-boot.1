Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B08CCF884F
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA108410D;
	Thu, 20 Nov 2025 13:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bIpZrfHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB8984111; Thu, 20 Nov 2025 13:24:41 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A39840F8
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-787eb2d8663so12413597b3.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 04:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763641477; x=1764246277; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zbrZ2Kw9gSTOvhi9yjmXqNaIpGOr39lGujRCvqL7/Wg=;
 b=bIpZrfHi++Nlh51RWfgQmAfiTrJPDVTkC5EU+nuOs9kyuwgb1Q+xwbAJenhXzyJaLA
 R7OGHLXULL/VPW41mUE2H8lGx164gCyOeop5I3hTyPkAIjrPSBQGSjf8XGE0WxKqpHLu
 d6k7/xHFGodd07a4dSZItBfuX9AwLahOzuILHTiHhbfDb/b+K9JCQgumRblGBKuGD2mK
 Ip04mhDNHa/XVBxzSeieGDle/YQ3DxNUoLRJt8dt+11qfliF3nAEt8Vhl/0hHAE8sUnx
 Al3QUqGkbdbUKlTeftyLLjUVT+Q4OjKtBFRcYaDg/bFcBJOaMHjuByIqcxRSk1rifstq
 HdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763641477; x=1764246277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbrZ2Kw9gSTOvhi9yjmXqNaIpGOr39lGujRCvqL7/Wg=;
 b=GhAFAMcK8wIAyWDlB9BrTRiqIZnlEFEwDLXZztxDHcckOwMxrI1z9sJlMZSCNh78K1
 qVvEfKynvAT8aSrqNUA+NYvNBBzHn1K19UC/vxhZacHvIXHYetz1ZmCLojdcg4bYhYZE
 5j9aUNZHw5FrCwYXyrcxMYA5by/KZ8YQToBl3TgUh8Xh39CJow48PJjNUTSilN1ci4sF
 6I82sucEgWl/JQURez1DDPxG/F9hXIHOnGaBrwBnVySFHU6aV3rT3KXYPVuw+DjAn9a7
 W1tS8augBt6Ez2eKM12Eg82ixLqCDL73Wy9RI0J46rwcEyyd9wQKlh8+bVbEIqX0AuNs
 Z7Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr9kcHwiXG3H7NKByRnF0qwUOVw2pN7rSINijllle554lWgbXzlvf5BHPtlGA7KZgXtRcxhDY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/RGocpvWjkxGXC12tberYZc6U9qRroTNCNvm+LqM/zs2CP72I
 SDmPYkpu75uLkRHTHGTkifJUmsLc923GP/qGYAFKcq4uw+Il32S0sSKZbGr9KjcYTk/dBf1vw9x
 Xrkd7EGrt/Jxvek8xRfs7KtP3coCfdy22+9nl94SEZw==
X-Gm-Gg: ASbGncvzBnlzx1rXzz4jiHILTKMttNqay0vo12kqwmc2vV/TDgJjtBltvk2cPdn+x9Q
 7gEptqgldGKNs9E9OwLPTvJ4Pqz4nJaTAFT7A7rCGMr+qafzpeLdy/v7LJCJqzQfLGRw/WrR9Kh
 JwmiNXgkkCzA41qF+GZwLNHBN5jQNoksGeSvLMRevSH85NkUe45q4qmigVt0NOEovpG6wviKwJh
 OMiDM7ZfX4uU79gtjkduYoZK9BStNGzDnzZ9U274VBoPaykhuaMiKM8d5V5dwT5W48jJYwwBDjC
 +EgvXCbqgcatG24w9OuiURXQwOAixnwvlEx0GsIsY4Ra+nl0RL0=
X-Google-Smtp-Source: AGHT+IG7cZbgjYUzviezCwd6lb+pOCGetW71OmeB+KjPljJ+0MaXvOm0TNlkbQAPqu7fKSuAfXHqmnHf799Wy1F7eR4=
X-Received: by 2002:a05:690e:16a0:b0:63f:b49c:6116 with SMTP id
 956f58d0204a3-642f8e2dbc5mr1604941d50.23.1763641476975; Thu, 20 Nov 2025
 04:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
 <20251118201733.67297-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251118201733.67297-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Nov 2025 14:24:01 +0200
X-Gm-Features: AWmQ_bmgnK_nJAwarxEY80EZjKPBFiYWCmT0aRTJZls6t5eLL6Nz-u4KmyPC7Hg
Message-ID: <CAC_iWjJO-x7R+m09NSz6dUBu9BqauVVOw2NbCTnbOKNLM4gMiQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: make writing DM test subsection of writing C test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich


On Tue, 18 Nov 2025 at 22:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> A driver model test is just a special case of a C test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/tests_writing.rst | 55 ++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
> index 062194659b5..b6972489d4c 100644
> --- a/doc/develop/tests_writing.rst
> +++ b/doc/develop/tests_writing.rst
> @@ -206,8 +206,36 @@ some common test tasks.
>
>  (there are also UEFI C tests in lib/efi_selftest/ not considered here.)
>
> +Add a C test to an existing suite
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Use this when you are adding to or modifying an existing feature outside driver
> +model. An example is bloblist.
> +
> +Add a new function in the same file as the rest of the suite and register it
> +with the suite. For example, to add a new mem_search test::
> +
> +   /* Test 'ms' command with 32-bit values */
> +   static int mem_test_ms_new_thing(struct unit_test_state *uts)
> +   {
> +         /* test code here */
> +
> +         return 0;
> +   }
> +   MEM_TEST(mem_test_ms_new_thing, UTF_CONSOLE);
> +
> +Note that the MEM_TEST() macros is defined at the top of the file.

Nit MEM_TEST() macro is defined, or 'are' defined.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> +
> +Example commit: 9fe064646d2 ("bloblist: Support relocating to a larger space") [1]
> +
> +[1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
> +
> +
>  Add a new driver model test
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +'''''''''''''''''''''''''''
> +
> +``dm`` is the test suite that contains C tests for U-boot
> +:doc:`Driver Model <driver-model/index>`.
>
>  Use this when adding a test for a new or existing uclass, adding new operations
>  or features to a uclass, adding new ofnode or dev_read_() functions, or anything
> @@ -249,31 +277,6 @@ Example commit: c48cb7ebfb4 ("sandbox: add ADC unit tests") [1]
>  [1] https://gitlab.denx.de/u-boot/u-boot/-/commit/c48cb7ebfb4
>
>
> -Add a C test to an existing suite
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -Use this when you are adding to or modifying an existing feature outside driver
> -model. An example is bloblist.
> -
> -Add a new function in the same file as the rest of the suite and register it
> -with the suite. For example, to add a new mem_search test::
> -
> -   /* Test 'ms' command with 32-bit values */
> -   static int mem_test_ms_new_thing(struct unit_test_state *uts)
> -   {
> -         /* test code here */
> -
> -         return 0;
> -   }
> -   MEM_TEST(mem_test_ms_new_thing, UTF_CONSOLE);
> -
> -Note that the MEM_TEST() macros is defined at the top of the file.
> -
> -Example commit: 9fe064646d2 ("bloblist: Support relocating to a larger space") [1]
> -
> -[1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
> -
> -
>  Add a new test suite
>  ~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.51.0
>
