Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E862BEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 09:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCC486667;
	Mon, 21 Aug 2023 11:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CSxrX0uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3699887037; Mon, 21 Aug 2023 11:24:09 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B4D865D0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4ffa6e25ebbso2960095e87.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 02:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692609846; x=1693214646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pb3qaZaOdEQr5hNhwcrfTmHfnHtUT5oHIToo+opw7SE=;
 b=CSxrX0uzk97Mshzs6Lzr0FysjX4AVB+cxZK5TBPJSD7LqnoSq1G9ejcmdjzBWWWs+k
 WzkZHjyjzqVI5sgWhJdu3n/0gxOtIo6hq0Y/LnvPTDfBv2MnpqOpAc9nj4FDrmwRyQuD
 S3G2z1/lhyKBMgVFgmUqQ/vl/gNaWLYCVuN/1aYsrugpDsCra+kupgt7bUr4dfX4m9NE
 Oeq/NqtA8LBgEH6amp8NSWNzz6SJfTQg5fwsYP5NkW7vuFrg18LkfB2ms4YXEv+NFjpT
 4Xeaw+FOZ3PjLelqPKijfgqHo9g4E2I7hftx6Eq8iL/uG0sF6T4JBk9n9awlFt2eMRG+
 qDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692609846; x=1693214646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pb3qaZaOdEQr5hNhwcrfTmHfnHtUT5oHIToo+opw7SE=;
 b=MFi0j6l3oq1DUBQbgF4DJkqS4pD70DN6bb8YSf2w/cKR55N2Z4bhe3nifEGp1+9hRV
 K5QkiJcTx4qunVrQjOjH3suaWDpW5NkBTmKvJHPE07x0ec7WXpxJtIHIl9b8EV4uumOC
 5MkClYJxKnRWx+EBU09Q1Kb/4UbV5a5/lTKdGaTDUAlNprE1tUU/seF83VsA5tumH8GS
 T8YOa23Wv1+LxL2h8uOyOE8zH1kPlKNJSbTGy49Y5tj5eqZvKILmH+OYeXpS4LU/s70R
 U1gq/H2qfEpQGVYvZPeJ8OF2Dwou4IPEGlvzWvDOpbdZLQfglmk7xA2RREB8vgUcEn/1
 a/yA==
X-Gm-Message-State: AOJu0YxzZzJXxoCQcN7037cIe0DyrxWtBz5sJ7KA2Vc7z69wAm8oL5yG
 xnsvyy5d1GUwtRgb+dBB9PnHJr+1Tq7UEBbGuszDHQ==
X-Google-Smtp-Source: AGHT+IGiS8u8A2Kmpv27DJOS/Nt9KRaLsc4BXDKO18uqNmADhlmiRjXF4jT3Ki3DrG/fXU5Jut+XaB9qkxWz37jX+8E=
X-Received: by 2002:ac2:4a6e:0:b0:4fe:4896:b6ab with SMTP id
 q14-20020ac24a6e000000b004fe4896b6abmr1668855lfp.15.1692609845883; Mon, 21
 Aug 2023 02:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230821072909.2387400-1-sughosh.ganu@linaro.org>
 <20230821072909.2387400-7-sughosh.ganu@linaro.org>
In-Reply-To: <20230821072909.2387400-7-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Aug 2023 12:23:29 +0300
Message-ID: <CAC_iWjLqkusxskjxkCxOGC3WfCEUQE8ZpNwuFxEFBYi8sPt83A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc: capsule: Document the new mechanism to embed
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

On Mon, 21 Aug 2023 at 10:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Update the document to specify how the EFI Signature List(ESL) file
> can be embedded into the platform's dtb as part of the U-Boot build.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Rephrase the statements in a couple of places as suggested by Ilias.
>
>  doc/develop/uefi/uefi.rst | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 3ce579d46e..f422915ef5 100644
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
> +You can perform step-4 through the Kconfig symbol
> +CONFIG_EFI_CAPSULE_ESL_FILE. This symbol points to the esl file
> +generated in step-2. Once the symbol has been populated with the path
> +to the esl file, it will automatically get embedded into the
> +platform's dtb as part of U-Boot build.
>
>  Anti-rollback Protection
>  ************************
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
