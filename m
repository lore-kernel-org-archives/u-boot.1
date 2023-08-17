Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A9FC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A52786B24;
	Thu, 17 Aug 2023 15:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y7NcwJ+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5A686B2B; Thu, 17 Aug 2023 15:28:11 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9578638B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-523bf06f7f8so8469427a12.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692278888; x=1692883688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4FRA8e/XPI9bHzYffZw3XwUua9baxdy8YcQNeV9Vin4=;
 b=Y7NcwJ+/O/XRdIfw2EsjaagMPUgEC3+YRe0pAJoRP7dkuqmnOu+bKuKcTw2mdEeSps
 jG30Y3PzQqbeM49q4UEU7FVUZlVYMWBaquEeNaNBy27PZmFOlR9mH8beeZy85ekU+gbe
 cxTd8bRuVkuX+bHhb1UbXJ8FvZHwsFsDBs0/dFXbvCLOLZBZ2maFQ3wu5QL3bfMxxtjP
 raBTOr630nDesSy1iMeUHO+M03GwCHrnJ9hGAJvR3Wld7+CMBRU5ylkdJ7bfMcMuqOS7
 rV2Ocn7cn5/2XPeUTWpWKJKAq139fGt3IEyZ2SlT3i4XlhYz1fw549E7QGwumatoeNPz
 OSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692278888; x=1692883688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4FRA8e/XPI9bHzYffZw3XwUua9baxdy8YcQNeV9Vin4=;
 b=lG/548I+3g1v/7e4k/OFowN9IpCJUwblkrQVSJ+ojVlJYKoHuCR/pZz9u33lnNt58S
 4M9i+EHbugjupWLXC0ZiBrUNKFYIjQK/PZ5FPo0uHpZfu5A2swvQ3VPKzrTBEc2Vhg2+
 iF8Qoe0fPBZ1pXbUJYYd2EQYo9pqkkdKNNfcVxFCVKR8DxDUCvBcjFygGrZzjC0zTsQo
 y9NIyazL95oK9SUqO6uwi1y92g4rL6zwXyWT7NaO5ssAgPVCBbkcLNqK4Br3kkz7PyzZ
 Z9jPpGjF6uYrKJbC0cnyapvXe7m5ihiKqhLiGxcTshvYgICXjr1Ss59mE0iRkPP/3KpS
 mGXA==
X-Gm-Message-State: AOJu0YyV1giLFYqPKNRbgD8LNgZ3N85MSEu6ZXBqVBqfzAq6YcClX8kt
 WJsEFVFzdi4htL2oSte6+Ifrlaw8kdKRmXQtSXV/ZQ==
X-Google-Smtp-Source: AGHT+IEgfodihjCHhmbU49h5Gg+Ucy/j0JG/puU/jtTmaQbb14AzvWgx0SawoerSZ5+8PlmBb6CzZfUh0qRZMq1BsuM=
X-Received: by 2002:aa7:d5c1:0:b0:522:4cd7:efb0 with SMTP id
 d1-20020aa7d5c1000000b005224cd7efb0mr3639734eds.17.1692278888119; Thu, 17 Aug
 2023 06:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-7-sughosh.ganu@linaro.org>
 <CAC_iWjJ-GoiyrTiAhS8RUvF7CeCPgcyydPkT_ArX6NDGkAef3w@mail.gmail.com>
In-Reply-To: <CAC_iWjJ-GoiyrTiAhS8RUvF7CeCPgcyydPkT_ArX6NDGkAef3w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 17 Aug 2023 18:57:57 +0530
Message-ID: <CADg8p95Kmod9yQ8ghJCFoYCDQBhB9njP5XLtkdFykXhDZ-g=VQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc: capsule: Document the new mechanism to embed
 ESL file into dtb
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

hi Ilias,

On Thu, 17 Aug 2023 at 17:31, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Thu, 17 Aug 2023 at 08:49, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Update the document to specify how the EFI Signature List(ESL) file
> > can be embedded into the platform's dtb as part of the U-Boot build.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: None
> >
> >  doc/develop/uefi/uefi.rst | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > index 3ce579d46e..950f4d1a5a 100644
> > --- a/doc/develop/uefi/uefi.rst
> > +++ b/doc/develop/uefi/uefi.rst
> > @@ -539,20 +539,11 @@ and used by the steps highlighted below.
> >              ...
> >      }
> >
> > -You can do step-4 manually with
> > -
> > -.. code-block:: console
> > -
> > -    $ dtc -@ -I dts -O dtb -o signature.dtbo signature.dts
> > -    $ fdtoverlay -i orig.dtb -o new.dtb -v signature.dtbo
> > -
> > -where signature.dts looks like::
> > -
> > -    &{/} {
> > -            signature {
> > -                    capsule-key = /incbin/("CRT.esl");
> > -            };
> > -    };
> > +You can perform step-4 by defining the Kconfig symbol
> > +CONFIG_EFI_CAPSULE_ESL_FILE. This symbol defines the path to the esl
> > +file generated in step-2.
>
> It doesn't define it.  It needs to point to the file generated in step-2 no?

Yes, I will rephrase.

>
> > Once the symbol has been populated with the
> > +path to the esl file, the esl file will automatically get embedded
>
> it will automatically get included etc

Okay

-sughosh

>
> Thanks
> /Ilias
> > +into the platform's dtb as part of U-Boot build.
> >
> >  Anti-rollback Protection
> >  ************************
> > --
> > 2.34.1
> >
