Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF3C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 11:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF77887E3;
	Wed,  3 Jul 2024 13:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JWbtK6Qj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B724F887EA; Wed,  3 Jul 2024 13:32:23 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64785887D5
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 13:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c97aceb6e4so315124a91.2
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720006340; x=1720611140; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zwnkDYufwJq8Cx58pBYQOAR/E6qS+UgvAiJgoF7nL70=;
 b=JWbtK6QjdgZ6kIXIcc+M41GYbLJ5WbcAY1bQoO+FYkChAGxWjYNevA1tfznwlOzXns
 0lVdLXiP8nX+TK+obBaBSF+uCPqVqwT4Ei/5ShbyZV5vfmdAxPm2H/orCcLcGUOUAFFF
 LZqiXKVLM4OnJHN0Vj44mkDIciN9We4PQpppqyqFzc3Eu7QGRR4dbYFeKggllNECSGre
 QBPR8cFiWhJaAImQ0XMtSEycVQs2oGaH2xlPFviEPQ9U1O2za0M6wWtAKkGAaQNbVr48
 oC0FBq4go0SnuyZrl9SpUd5uwgdNqng/OwArF+MksyGh/tnUNNkRcsvGvWNIGSJMAgXb
 Ghdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720006340; x=1720611140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zwnkDYufwJq8Cx58pBYQOAR/E6qS+UgvAiJgoF7nL70=;
 b=WM+xgLMFbRDGWvBw0irZAgXSH2I5VtFnevg8vuGSMg/rtxGCO0nXpKqwrjW2xbMfmt
 di+yqBKKSyBA3NUn0DsDjKYFHCvRxnxcu7Ssc4Dip5d1kLcX/hd5x4URj3OIS128fp6f
 PQV9v4c+jvcn/D0bOPSUTmuR0IszoQ32dXo3Jx969wnRViOuXiuHT8f79xwGGE3SMBRu
 4QFpOHs9/5HvmFwzNmpJsW5xzHk33sLgwQ7IPhDuBQK/j/ZljGmyvdho4r6C46KNQvLr
 gSamYA10OjCp94QBGVmVVvXBmkTj1A75QsYUEerYWL2zutLAIpnscqqKVo0P0SIVgK6z
 tWOw==
X-Gm-Message-State: AOJu0Yy+zK1LPnzaQ+zeNYUGjIqzezGLXuK7BPkfEalofRldZ0N98UvJ
 OFMcK5B25GqU2/aawQRG4EQNEKMIrTreTPJAEtPjdeKK/mw6/vvnNzUhHyg2XvWb4HqB/7lkoJh
 sx7L7wBFPUkTrtfY8jtGwITuLail+u9rOjk6Dtw==
X-Google-Smtp-Source: AGHT+IHLSi/SXjW2UG0OVFi4J2i67n8Fo9JSv+CB2618LTSk2CGNtBuLKcLK367uIAzPoj9O8zC47a9z4A6T/36qRvQ=
X-Received: by 2002:a17:90a:6388:b0:2c8:716f:b46e with SMTP id
 98e67ed59e1d1-2c93d704341mr8533746a91.16.1720006339646; Wed, 03 Jul 2024
 04:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-15-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-15-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 14:31:43 +0300
Message-ID: <CAC_iWjK1Gn5FtoeSYDhCeR4QDZkajCZufZ0CugDLyygpsgKK4g@mail.gmail.com>
Subject: Re: [PATCH v4 14/29] public_key: move common functions to public key
 helper
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Raymond

On Tue, 2 Jul 2024 at 21:29, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Move public_key_free and public_key_signature_free as helper
> functions that can be shared by legacy crypto lib and MbedTLS
> implementation.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v4
> - Initial patch.
>
>  lib/crypto/Makefile            |  4 +++-
>  lib/crypto/public_key.c        | 31 -------------------------
>  lib/crypto/public_key_helper.c | 42 ++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 32 deletions(-)
>  create mode 100644 lib/crypto/public_key_helper.c
>
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index bec1bc95a65..4ad1849040d 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -7,7 +7,9 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
>
>  asymmetric_keys-y := asymmetric_type.o
>
> -obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
> +obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
> +       public_key_helper.o \
> +       public_key.o
>
>  #
>  # RSA public key parser
> diff --git a/lib/crypto/public_key.c b/lib/crypto/public_key.c
> index 6efe951c057..408742907f1 100644
> --- a/lib/crypto/public_key.c
> +++ b/lib/crypto/public_key.c
> @@ -51,38 +51,7 @@ static void public_key_describe(const struct key *asymmetric_key,
>  }
>  #endif
>
> -/*
> - * Destroy a public key algorithm key.
> - */
> -void public_key_free(struct public_key *key)
> -{
> -       if (key) {
> -               kfree(key->key);
> -               kfree(key->params);
> -               kfree(key);
> -       }
> -}
> -EXPORT_SYMBOL_GPL(public_key_free);
> -
>  #ifdef __UBOOT__
> -/*
> - * from <linux>/crypto/asymmetric_keys/signature.c
> - *
> - * Destroy a public key signature.
> - */
> -void public_key_signature_free(struct public_key_signature *sig)
> -{
> -       int i;
> -
> -       if (sig) {
> -               for (i = 0; i < ARRAY_SIZE(sig->auth_ids); i++)
> -                       free(sig->auth_ids[i]);
> -               free(sig->s);
> -               free(sig->digest);
> -               free(sig);
> -       }
> -}
> -EXPORT_SYMBOL_GPL(public_key_signature_free);
>
>  /**
>   * public_key_verify_signature - Verify a signature using a public key.
> diff --git a/lib/crypto/public_key_helper.c b/lib/crypto/public_key_helper.c
> new file mode 100644
> index 00000000000..4cb21edddf3
> --- /dev/null
> +++ b/lib/crypto/public_key_helper.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * X509 helper functions
> + *
> + * Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>

Similar comments here, the patch is ok, just remove the copyright and author

> + */
> +#include <linux/compat.h>
> +#include <crypto/public_key.h>
> +
> +/*
> + * Destroy a public key algorithm key.
> + */
> +void public_key_free(struct public_key *key)
> +{
> +       if (key) {
> +               kfree(key->key);
> +               kfree(key->params);
> +               kfree(key);
> +       }
> +}
> +
> +/*
> + * from <linux>/crypto/asymmetric_keys/signature.c
> + *
> + * Destroy a public key signature.
> + */
> +void public_key_signature_free(struct public_key_signature *sig)
> +{
> +       int i;
> +
> +       if (sig) {
> +               for (i = 0; i < ARRAY_SIZE(sig->auth_ids); i++)
> +                       kfree(sig->auth_ids[i]);
> +               kfree(sig->s);
> +               kfree(sig->digest);
> +               kfree(sig);
> +       }
> +}
> --
> 2.25.1
>

With the above fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
