Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60042E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 14:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A17801F5;
	Fri, 10 Jan 2025 15:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ojR63B52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CF68036B; Fri, 10 Jan 2025 15:38:33 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC63800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 15:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so3087117a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736519909; x=1737124709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hAf2sz/P+vqeCXOvAePuHgX8skepnaGh41vTxw1lQc0=;
 b=ojR63B52y1QkcegxaM66d/z6rpJWrK4nPgRj3FtQBBzKCCOnco7R4CqsVN2GAMhKha
 aUVckx5gGqqQVMOlkdgKJYJI7je7OOCzY29TVvtK6iutr4hP2U6wVwx3nx1HbXjf0+r3
 NVIc1tphzVu2dmexmuzCRzeomkfQyvsH2xDjAq0qxTVQK45S068GzWm9msxbPT9LnV0G
 lyRIyGir41cMHRvCBdwcYEifQCUyr2cNeeJgy2dXwhYCFa1lzm+6SbopFn/OIITG1hC8
 6HvmDGaynElaQOKm4jWGbcUbhlXfA1i4G4rzFl+CgKei4w80K63Prk0oclL4ycdD71DZ
 TjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736519909; x=1737124709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hAf2sz/P+vqeCXOvAePuHgX8skepnaGh41vTxw1lQc0=;
 b=gqXH2cLaWSAa1mNdXqn56aq6PgzmzFzsIfkqH0T2dQ2PG6CIeow4stPiRmAj1DNlAD
 0Gaa4/h/w1uENnwQyiYFn24fLYtEwmFuhyXxuy4NvZKiVaOcxOXciBWJeJ0OtYZPjuPb
 5+9RrmgAT7k20o6/vAviS32fGZpO99dbCd3L9Xdvq7kyH81m8sWeueEq2VPsoasOIg2O
 g/6ag7CAc9HA5xJiLvEIXe4BCtJUAD192wNd9jurbwyOG4dwdfPfRHRtsLQujTTTT8vn
 w0IJPqcdkzYBdNED/bwRvIteO4N5w3Cm2mYuF45NGp0LjM3JVxRziQK579dUbgLrHVJc
 u83Q==
X-Gm-Message-State: AOJu0Yzm8P+uFbq5Do8ritnsQvozJQCIb9cjbepAl6XGvWBd/Ne+wVVz
 QELDDMjegC56yppwd7akgYeBVg25fArLwohd74G3tMFuqMt3ubAuD84tbjbdVFsfFEn1iD1uDf0
 jkqfbewyGVtFDRJWHcjhWu0cUxt/1RlbAMIdQgQ==
X-Gm-Gg: ASbGnctXbJUSd+UT/M9s7typnPN/RsWdRDTdir4paGtZdIRIh8h0sQ/CzvN86kXCVor
 Zza6HadQQLOeCINPrvtYinShGUIfJJa5wv0NUhW6eTAgpbL2Pig9YWsWyF08mQNKFjC8dklY=
X-Google-Smtp-Source: AGHT+IHWhmnWt9vUL2b6ja7wF+2wT7TZ/GoVjT8opqqgrXHRLgTrWzBn6fRz3V2lBOKjMp11Pd/OI0Mt0KR9fKtLiio=
X-Received: by 2002:a17:90b:2dc5:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2f548e9862amr15318439a91.5.1736519909206; Fri, 10 Jan 2025
 06:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20250109150928.878849-1-raymond.mao@linaro.org>
 <20250109150928.878849-2-raymond.mao@linaro.org>
 <CAC_iWjLLMiu_B=A3g-r6d9MiQpwRnyghSFVCJ5GNQGmMHb4DuQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLLMiu_B=A3g-r6d9MiQpwRnyghSFVCJ5GNQGmMHb4DuQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 10 Jan 2025 09:38:16 -0500
X-Gm-Features: AbW1kvbpUKXMmL0C7KQRUBqed4t3FV6uaiHD-hcNg9-oU4PdEbNEGbFC9jTZUzI
Message-ID: <CAEfUkUJXL+i6OBj4HoPspq-oQrWGzs2jy9cEzeghof9_3eccYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tpm: get tpm event log from bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
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

Hi Ilias,

On Fri, 10 Jan 2025 at 08:32, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Thu, 9 Jan 2025 at 17:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Get tpm event log from bloblist instead of FDT when bloblist is
> > enabled and valid from previous boot stage.
> >
> > As a fallback, when no event log from previous stage is observed
> > and no user buffer is passed, malloc an 8KB buffer to initialize
> > the event log.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Remove patch dependency.
> > - Remove the fallback to FDT when BLOBLIST is selected.
> > Changes in v3
> > - Malloc an 8KB buffer when user eventlog buffer does not exist.
> >
> >  include/tpm_tcg2.h |  2 ++
> >  lib/tpm_tcg2.c     | 55 ++++++++++++++++++++++++++++++----------------
> >  2 files changed, 38 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> > index 6519004cc4..6ea316888b 100644
> > --- a/include/tpm_tcg2.h
> > +++ b/include/tpm_tcg2.h
> > @@ -65,6 +65,8 @@
> >  #define EFI_DTB_EVENT_STRING \
> >         "DTB DATA"
> >
> > +#define EVENT_LOG_DEF_BUF_SIZE 0x2000
>
> That's too small for an eventlog. We have a confog option for the TCG
> eventlog size (EFI_TCG2_PROTOCOL_EVENTLOG_SIZE). I'd prefer decoupling
> this from EFI only and using that instead.
>
>
I got this size from "reg" of "memory-region", but yes I agree with what
you suggested.

[snip]

Regards,
Raymond
