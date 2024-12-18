Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E954E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F4D80241;
	Wed, 18 Dec 2024 16:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Me2cDJb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D5780269; Wed, 18 Dec 2024 16:23:30 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387208022B
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 18 Dec 2024 16:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ee11ff7210so4870952a12.1
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 18 Dec 2024 07:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734535407; x=1735140207; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xRzbCM0EcnPQyoNx7uRDpsQ37ZGKBidRge/fq63yODM=;
 b=Me2cDJb8fAtv8XmDzyXx1wa+TUvnjMF8w6Q/ipD0y8xYB7GaDOYbJ8y1hZFNt7nboD
 hgRcVA3NlBqSMPZpFp2Md+1JSqM4LjsS+RzRSBaSOrPsYb9i9TAIghlknSEhKEf6JjyB
 v2hawyB60GiRyeDPRBUly1sIBcjNTeu0bNm43h7ULBYY71V8e3UABwhjfjSu3KVidHIA
 T+qbITs87+ZHmjOTI7J/fdV6YCgu7Hp1dIqL70/i0LaBayhbDLsm66XS2SpwhpFcB893
 ZeQIPTLAJQq81vbQNYFbPffqabE+txwVlvWBHyM8rZel4FSA1J5xq8nmSskZ7qCSIuw8
 K2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734535407; x=1735140207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xRzbCM0EcnPQyoNx7uRDpsQ37ZGKBidRge/fq63yODM=;
 b=hkdCBeLUQ6EYlrUO5U1wjgMS4aX6FdB1t/skjNcjFIPJ/50HlEQLhyS257GmW/MO6o
 PHB8E9ZoX1up8AVAzC8vV9/o0MLKxx25xiaLFb+cou5g5tEEcgIt+MCbOACNzLDZIgln
 2lCDlCdKtp8XHPFRci7925TDXro+HBdG+qfYFurq6GmVjwkvxrrGHcwrHsVCn2GpmiMp
 WQFvqewjY+o4wOvB9bWurEFrMkFaphxrYJLwFVVHWzLndSXOfve8X6BlGXLLwXz13X0F
 7Xr7S15MhMda2NA2EZ6dQjulEC0gsZSVT5DM67vsywvBrITbqObf4DKyZgluZfc8kjVi
 rydg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOgpHP6ZrdA+1xaNcVvISK2NIdnWMWrdGRq1WJJpQ/QLwXtUXIecCj2KonW9K9N+TVmwILevg=@lists.denx.de
X-Gm-Message-State: AOJu0YxQw0RYK/DpZAMt7OAx8bezc4nipPJI9vyGr7t+oqsAAGwID0wo
 hkqra4Jk/GXBAeWL0mKkeTYgPnAnAjZHFWcteaDgI109/x1hQ8hO5LvMeFKLgClwQyByxfN2Dpk
 aoECn/iFCXFKHglfalgU241UcDvma5ArNdI/J6A==
X-Gm-Gg: ASbGncs5DjBB/kmXz3YqXVHqqDTdAOEGgOGPGRObzjEXtCcN+7UyQpZcTfrFG9gCZ2y
 T8jqsvhvPRgMHH5vDf/FCnbXQX5rTv5p5S5u5uy9YBT0JL8pp1Dz3Jmi0fqGsEF2ZjWqH648=
X-Google-Smtp-Source: AGHT+IGyNFum66S/XMytt2YFfKap8mdP7O7/k0vMYwiNaLC5bdFvbWwW5qv4T6aBU5f69/HaCjptKfDOQYb/Efobna8=
X-Received: by 2002:a17:90b:2543:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2f2e933d4d3mr4948787a91.29.1734535406771; Wed, 18 Dec 2024
 07:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 18 Dec 2024 10:23:14 -0500
Message-ID: <CAEfUkUK3=yia5kmG7YO-niUUVSLtSZfjZS-k_4qEAe-6V5F9nQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] add the support of sha256_hmac and sha256_hkdf
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, raymond.mao+nodisclaimer@linaro.org, 
 u-boot+nodisclaimer@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Philippe,

On Tue, 17 Dec 2024 at 16:36, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> This serie adds the support of sha256_hmac and sha256_hkdf.
> A first version was sent several months ago just before the
> integration of mbedtls. This new version is based on mbedtls.
>
> The first patch of this serie add the support of hkdf
> using mbedtls.
>
> v6:
> - use const for test
> - set buffer to 0 before using to to compute hmac
>
> v5:
> - use mbedtls to compute hmac
> - add tests for hkdf
> - enabled mbedtls in sandbox_defconfig
> - some cleanup
>
> v4:
> - fix computation of the hmac
> - add more test for hmac
> - move sha256 common functions to sha256_common.c
> - some cleanup
>
> v3:
> - also define sha256_hmac for legacy sha256
> - add some #if to define function only when needed
>
>
Can you add my review tag to the commit messages for those ones I stated if
there are no new changes?
So that I can skip them in the next round.


> Philippe Reynes (9):
>   tools: kwbimage.h: use linux/compiler_attributes.h
>   tools: renesas_spkgimage.h: use linux/compiler_attributes.h
>   mbedtls: enable support of hkdf
>   lib: sha256: move common function to sha256_common.c
>   lib: sha256: add feature sha256_hmac
>   test: lib: add test for sha256_hmac
>   lib: mbedtls: sha256: add support of key derivation
>   test: lib: add test for key derivation
>   configs: sandbox: enable mbedtls
>
>  configs/sandbox_defconfig        |   2 +
>  include/u-boot/sha256.h          |  24 +++
>  lib/Makefile                     |   1 +
>  lib/mbedtls/Kconfig              |  14 ++
>  lib/mbedtls/Makefile             |   2 +
>  lib/mbedtls/mbedtls_def_config.h |   4 +
>  lib/mbedtls/sha256.c             |  59 ++++---
>  lib/sha256.c                     |  67 ++++---
>  lib/sha256_common.c              |  50 ++++++
>  test/lib/Makefile                |   2 +
>  test/lib/test_sha256_hkdf.c      | 198 +++++++++++++++++++++
>  test/lib/test_sha256_hmac.c      | 294 +++++++++++++++++++++++++++++++
>  tools/Makefile                   |   1 +
>  tools/kwbimage.h                 |   6 +-
>  tools/renesas_spkgimage.h        |   6 +-
>  15 files changed, 670 insertions(+), 60 deletions(-)
>  create mode 100644 lib/sha256_common.c
>  create mode 100644 test/lib/test_sha256_hkdf.c
>  create mode 100644 test/lib/test_sha256_hmac.c
>
> --
> 2.25.1
>
>
Thanks and regards,
Raymond
