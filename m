Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E880DC36010
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F0581DDF;
	Fri, 28 Mar 2025 12:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bE2mDCBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5CAB81E5A; Fri, 28 Mar 2025 12:34:55 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D2B81E13
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso5691326a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161693; x=1743766493; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k+vsZJIdQb5biRnGysjB2xoAc9c6adv2z2N/6HlcAMQ=;
 b=bE2mDCBDMMWdBTv9u+nY5NNs7lD2Kxe5Mcsg1X9rHXCPTJN+GXnewHhnBrTXyooYux
 cIniX6QEVrRTa6UnOJRxvnrx9dQEEkAAaDiTliA7ySX4gKk5uMGtt5g39GrU1syK/oem
 ExCkRwnHGKodl/Hfb4lJhFqQAxpE+EdyPHhYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161693; x=1743766493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k+vsZJIdQb5biRnGysjB2xoAc9c6adv2z2N/6HlcAMQ=;
 b=ZOPiAJkmyEpxJ+969xgurpROwSRdfcd6g4xa/cXK9QJCyUVbuIDZ0A9Jtt+EecaryR
 xlNJO7a11XS4Kc145C6jtzAlN9gmcBy/tOVe72fHPknb6OBV4OE403bz1995vDWGTVbN
 BqDft1GExqJt+JnigcVqbD7BrKeHzMscURMkER139bs5jzYbUnkJJHWj0ZqxKPussEa8
 K4YSF2ObOiYOHSlbaDtbAZ1YpvU2ec2Nlp6uDyZ2PcYxPaVe1G7zxZH8NJgSYp7xYqfy
 nMeI8t/9t9Ys0rQIRI0K6FkkAu4x2nSGMusxeSzFvBqABQXKNXyAMdg/0CDXx6xDkFLm
 +Y/w==
X-Gm-Message-State: AOJu0Yyd8iWikUZIECJfwRU3FUMgSfUQ59+h1976OnFz8dh1d3obznJW
 R3glfAEvbAe4/kqn8wg9dGDPSY/I/hIIOEt9ihxqFOrNXWvI5FmeMCB8YqUimpQsMikaWjBGbME
 ltLocXKHDwB1X1LcXkbA+TwtG7OK2AqjI8FgB
X-Gm-Gg: ASbGncu929Gt4Aou2n/IGVTOPl21O6j3RBcRzSAy0c80tPgxAF8TK31Cw4wMCtLIYCC
 K6uqNU9XUDzr+zmCT9z7ZRNOwH4N7uRbaOvNBagCly/U3w3LsW3ZUPUnnN+cDCaajEFRiJfAriU
 R9SznzNWXC6YOf+2f4e9y5yOccCE8=
X-Google-Smtp-Source: AGHT+IF+hpo+Y9v13X7etye+sUQ2tF8OpV6ulzv8SZnNBZsFzfiGQL730/9pG2tN4b8CAZ1z1CQAS2eQk5peJoz1wu4=
X-Received: by 2002:a17:907:86ab:b0:ac3:2747:9fe with SMTP id
 a640c23a62f3a-ac71ec68222mr197496066b.13.1743161693150; Fri, 28 Mar 2025
 04:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
In-Reply-To: <20250327231318.2713201-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:34:40 -0600
X-Gm-Features: AQ5f1Jq2GUsXAPWv46W9JimWhloTg568GWcnJsK7PCI6Zc49Ok0sUlwi_wZDewg
Message-ID: <CAFLszTjpbxH6_LEuv5mAyOjt812hXvTKL1nDpP42HMJXwMryWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Ravi Minnikanti <rminnikanti@marvell.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Raymond,

On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> When a bloblist is valid and contains fdt, it explicitly means
> a previous boot stage is passing transfer list compliant with
> Firmware Handoff specification, thus the fdt from bloblist should
> not be overridden with the ones from board or env variables.

Why is that? The board can choose to override it, if it wishes, but in
general, if gd->fdt_blob is already set up, it should return -EEXIST
from board_fdt_blob_setup().

>
> Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/fdtdec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index f09c9926a7a..c38738b48c7 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
>                                 gd->fdt_src = FDTSRC_BLOBLIST;
>                                 log_debug("Devicetree is in bloblist at %p\n",
>                                           gd->fdt_blob);
> -                               ret = 0;
> +                               goto setup_fdt;
>                         } else {
>                                 log_debug("No FDT found in bloblist\n");
>                                 ret = -ENOENT;
> @@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
>                 }
>         }
>
> +setup_fdt:
>         if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
>                 setup_multi_dtb_fit();
>
> --
> 2.25.1
>

Regards,
Simon
