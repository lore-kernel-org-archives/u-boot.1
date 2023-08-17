Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD980C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 12:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39990867F6;
	Thu, 17 Aug 2023 14:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yEZFRHs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED5086AF8; Thu, 17 Aug 2023 14:01:39 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B181086751
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 14:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe7e67cc77so12401948e87.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692273696; x=1692878496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ztYSktvF5jcaQqcyCQCR1TrYljeigPnbKfAHUxJUuXk=;
 b=yEZFRHs+SGdFLbz3/dMsBPKycC7bapSegqoTsC8obzpce30lLsbSKDSTb5HyTNPxwG
 LRVLGqe/Sc7uk9haiISUbffZOK8Bfvoeoa5ECNFBHCOHrvUSbNvItaQ5h//KlScwFi/G
 xlNvnckhBKLDwWeQx0Krc31jMx5dkcaq2ud71Ahptl8VyOuSvsbqgsr7qVYdKpfR3oLg
 5yffwdnJVOaYd68efmdoRnWGk3gQkGo7uJSqabP0tQzH8e32oGL0ZsnIkvic1l9Q2s0f
 PFNztR/YM9fYvjg1fKrJxyFcm+1a84tsAYfUPxfAUSDx//2517KM7ZSU3tzZz5YU6deu
 g2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692273696; x=1692878496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ztYSktvF5jcaQqcyCQCR1TrYljeigPnbKfAHUxJUuXk=;
 b=TmPb0shK27xgepdhESJzBntH1ENkUB2r4SH5xM4/pHqQAE6zvTzO+9w+dDjsRv3kDC
 QFZuqQazX9k7ylfGuz20yajawOWhjcigOxqxmj0xJgFmFzi9UQVogruujE5ta6mJ3YkP
 mv9PdlyxCPNj2qksjACK/lZVskslrPpltMAuurkfZv+HjZY7dAeeIcBYgmx0zJM3Wsql
 mOVr7lCQB6MwsukGhPRFpe1TXcSe38wlwaUQOzWMIULutlMJHiapAxhPSh5Fi/GxUZRn
 21HBZeRc9YwE+ThVs1vNjrHzHDlh3TYxcruQ/GmD6kXhil/X054qwWUZGG+hn6RhUtas
 PQaw==
X-Gm-Message-State: AOJu0Yz4wlRW5s56jQ097s1/3b6UKNGb7Hn7OFfG/P2yk8RNdgkazJSX
 Z8zS1ni70BldpTlYXWJ7QO/qUBRzUGip8iDT23sn7Q==
X-Google-Smtp-Source: AGHT+IHxxhIj6UxVApf89ln4oiJ87Ucc1S7TunW0hnu2y+jszIEp/sPXh5P4o7N9onhuYD4sJ7YM6hoGPE7FYi88SOk=
X-Received: by 2002:a19:5042:0:b0:4f4:dbcc:54da with SMTP id
 z2-20020a195042000000b004f4dbcc54damr3562144lfj.27.1692273695873; Thu, 17 Aug
 2023 05:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-7-sughosh.ganu@linaro.org>
In-Reply-To: <20230817054856.2019253-7-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 15:00:59 +0300
Message-ID: <CAC_iWjJ-GoiyrTiAhS8RUvF7CeCPgcyydPkT_ArX6NDGkAef3w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc: capsule: Document the new mechanism to embed
 ESL file into dtb
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Sughosh

On Thu, 17 Aug 2023 at 08:49, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Update the document to specify how the EFI Signature List(ESL) file
> can be embedded into the platform's dtb as part of the U-Boot build.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  doc/develop/uefi/uefi.rst | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 3ce579d46e..950f4d1a5a 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -539,20 +539,11 @@ and used by the steps highlighted below.
>              ...
>      }
>
> -You can do step-4 manually with
> -
> -.. code-block:: console
> -
> -    $ dtc -@ -I dts -O dtb -o signature.dtbo signature.dts
> -    $ fdtoverlay -i orig.dtb -o new.dtb -v signature.dtbo
> -
> -where signature.dts looks like::
> -
> -    &{/} {
> -            signature {
> -                    capsule-key = /incbin/("CRT.esl");
> -            };
> -    };
> +You can perform step-4 by defining the Kconfig symbol
> +CONFIG_EFI_CAPSULE_ESL_FILE. This symbol defines the path to the esl
> +file generated in step-2.

It doesn't define it.  It needs to point to the file generated in step-2 no?

> Once the symbol has been populated with the
> +path to the esl file, the esl file will automatically get embedded

it will automatically get included etc

Thanks
/Ilias
> +into the platform's dtb as part of U-Boot build.
>
>  Anti-rollback Protection
>  ************************
> --
> 2.34.1
>
