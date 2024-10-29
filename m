Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3928FD3A661
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD7A8919D;
	Tue, 29 Oct 2024 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dlGehbRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469078919B; Tue, 29 Oct 2024 16:45:47 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDCB88D29
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso680910066b.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216745; x=1730821545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=46dfr8iDD5Vw6kEd+4KQNsTWwHocgA/QdmQce6djXcQ=;
 b=dlGehbRZrMagtmqhmLmTkwXHZPvJqfSwupR2dVYaGVqDsOzKYr1esr3qyrJpSNiaui
 kZ2gxLSeF04OPCFQWe3TYrXAoGRj2t8zN1XyfOZDEyXaoX+z6croLbNefZ+zTC6pRAtl
 IiwENnYi8LGZv2hiziO9XYBLcaPuxGC8Vd1uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216745; x=1730821545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=46dfr8iDD5Vw6kEd+4KQNsTWwHocgA/QdmQce6djXcQ=;
 b=wr5Dba/ahizOi2dbsnLK+hb9Uu/N6sRcq1Mc/6B0b9e3Zg4vqy3ZeN8O1S++jsr+mb
 Kb4T1szE+rsMTX/GXsuKwFyIQeqDtPA2xYoAUgpUjlnhimW8NElrSm77L4F+xOGZKJT8
 EgmI89j9H7yoZHoHT+OFO4Ou360aqkhH/evjmMaOOwq3kjZ+Hlbl+cX9CHBSRon6nQ3Q
 8nkJbx8qrkg7OIjtqqQ3SqNlsOl0MXHku0JIzsIpMuZbNbrJxHAWcfE+4rL5fFd3yz9B
 VHsOfC1/S0ElJmpnZCFQ6PZxxK4riJcYsFhF1wCzU6vmvB4rnLKjryedEnv6QAy9tTlT
 zOkw==
X-Gm-Message-State: AOJu0YxkpLgK2Y1qz1uerxAnT9XuubKPdFnLbwOQR2UzjntT3E5CbTe2
 Qb96IabDowVNRPpeeELDqk5CGyG+UOQZzYY5yA5Dy8QGd9yKwvsrAXiQL/o8NLxMwIwtxu2IY1D
 Ou2MI01lDsi2ULTI2nkG7aNzBk3ia6/iEk36i
X-Google-Smtp-Source: AGHT+IHUDuXLULDrVMuTnDrQIB5sCWFK6W74F5vFP+/CE+vDZ+CKsy0MFwC61xnFJUWAfkuzqeMaaHSpEneoJMVF2o0=
X-Received: by 2002:a17:906:730f:b0:a9a:1565:1051 with SMTP id
 a640c23a62f3a-a9de5d6e1fdmr1174273066b.10.1730216744734; Tue, 29 Oct 2024
 08:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-10-sjg@chromium.org>
 <CAC_iWj+H_m3jiQ-Q-BK=9vtdMEnw0GHyQT2_LFHUYyEnnZh3EQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+H_m3jiQ-Q-BK=9vtdMEnw0GHyQT2_LFHUYyEnnZh3EQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:29 +0100
Message-ID: <CAFLszTgG423MQ0iK-2XnOHZN+qVy_-xZNkaPGGsQM=Th=kaeGA@mail.gmail.com>
Subject: Re: [PATCH 09/15] efi_loader: Fix free in
 ..._media_device_boot_option()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Ilias,

On Tue, 29 Oct 2024 at 11:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Freeing a NULL pointer is an error in EFI, so check the pointer first,
> > before freeing it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  lib/efi_loader/efi_bootmgr.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a3aa2b8d1b9..431a38704e9 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -1180,7 +1180,8 @@ out:
> >                         free(opt[i].lo);
> >         }
> >         free(opt);
> > -       efi_free_pool(handles);
> > +       if (handles)
> > +               efi_free_pool(handles);
>
> We don't need this, efi_free_pool() checks the pointer already.

Yes, but it then returns an error (EFI_INVALID_PARAMETER), which gets
logged, with this series.

Regards,
Simon
