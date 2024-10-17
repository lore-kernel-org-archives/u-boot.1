Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA54ED2F7F5
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 07:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F219688E5F;
	Thu, 17 Oct 2024 09:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oPnpNqZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2350E88EAE; Thu, 17 Oct 2024 09:16:23 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C236288E43
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso5284265ad.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 00:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729149377; x=1729754177; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dnoyS0AXLxcP6yPzCaxXRa6EP29RpWzl8mMlL8mYCY=;
 b=oPnpNqZ82QVwN3BjOQ6nby1NrF7huPtM/jrrwYTgFnhG43/CdAAknsw6nT3yfukAc8
 SWsLuUCaQnjOxJT3L3rzs9ZvAYPEtDrvfNNKU+Ndwd6CjDhzOZ21I+9iZ+57kYkAZ2Oi
 qbugA2jcpioCOIOjKS6Bz99UoxrRuNyiMT0YhJYIN0dKYi5u7fV7yMIzEaBfyynyRff3
 R7L/1lKMyrSCLONFNOUdJ76R2H3vdqAyh0xxpMMxG1UhMldSkxuqNQxUCm61xFgz8Zha
 SnJ8BgV14a+jtsIfsG9qeEuNJCzyW9xL+NueBMYXyXSKkfGVzAi2Cuhi1lIUCCWhqZLk
 yyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729149377; x=1729754177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dnoyS0AXLxcP6yPzCaxXRa6EP29RpWzl8mMlL8mYCY=;
 b=K8a7x7unlQYfRuNkFc5vzwkUV/aDe9QlHoTqh/sGF2Lfw3UfyDN8MHU3MJriZIUtQA
 8UKFX1tose83aXViJqDyl0sLm+AyxDxpUKbbeeWj4fsj/gPS4TgX+ZlKzoIrBLRbU5Gg
 lXiQw5GishGzPWxNDrpmOxFUl/dqtdiXkusl6Ftf9h1RMjXat0Nx9sCiwYqMDtv7Qtdl
 JB/g/C1c/O17wHV5MO2Bv0IpZXt4eYePeRQV0o5sQAFzojMTB5xLstERtDIeR1ra2dV/
 9fyJvZ0wtHj86Iaa3bH4hC7FMPX/YViCDbKCzOegoSUYg/rnp59RVXWeoxBZxNQ5ufv4
 hqLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1t1MvccAAnkahkWZIoSnmSyqvCNe5SCQT4e6AkyWFkY84LWsPuTs6zkiBgLFS4I0uATC8ipI=@lists.denx.de
X-Gm-Message-State: AOJu0YxotVNLGlI8aRTRJRj8PT04hepYF4CW9Vg/eSOahypgvwytCOHq
 B5S1q9/5sTApO2FfZ/dfjSPlVzEBPD8Yqz//gqlkxHU9xDrYJ7+2mebh0Dsq6y52l8TxSaQp1UY
 GIp5Qp5AB2QPWn7zKghx9NuldkIrZmGljCTtBTg==
X-Google-Smtp-Source: AGHT+IEWWf5xG73EWOwwF6GwNcFo7TZfKnLExSsYbb1IUG7WNF/4+Ne8O5V1CK2Ajwd7PtrLTwkdfTW3fjlhQI+KTM8=
X-Received: by 2002:a17:90a:b00d:b0:2e2:c98e:c33f with SMTP id
 98e67ed59e1d1-2e3ab7c78a3mr8317278a91.1.1729149377263; Thu, 17 Oct 2024
 00:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
 <c0be587c-af2c-4e23-b0a0-a7196b607442@gmx.de>
In-Reply-To: <c0be587c-af2c-4e23-b0a0-a7196b607442@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Oct 2024 10:15:39 +0300
Message-ID: <CAC_iWjJqcc1MGpuEAbg4_jv5obmECbyTMyJ4rZsDKz9GFoxhwQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Don't allocate from Special purpose memory
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Wed, 16 Oct 2024 at 19:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> On 17.09.24 11:02, Ilias Apalodimas wrote:
> > The EFI spec defines special-purpose memory in =C2=A77.2. That memory
> > serves as a hint to the OS to avoid allocating this memory for core
> > OS data or code that can not be relocated. So let's ignore it when
> > allocating from conventional memory.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/efi_memory.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index c6f1dd09456e..74732e37f8aa 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -422,7 +422,8 @@ static efi_status_t efi_check_allocated(u64 addr, b=
ool must_be_allocated)
> >
> >               if (addr >=3D start && addr < end) {
> >                       if (must_be_allocated ^
> > -                         (item->desc.type =3D=3D EFI_CONVENTIONAL_MEMO=
RY))
> > +                         (item->desc.type =3D=3D EFI_CONVENTIONAL_MEMO=
RY) &&
> > +                         !(item->desc.attribute & EFI_MEMORY_SP))
> >                               return EFI_SUCCESS;
> >                       else
> >                               return EFI_NOT_FOUND;
> > @@ -460,6 +461,9 @@ static uint64_t efi_find_free_memory(uint64_t len, =
uint64_t max_addr)
>
> Now that Sushosh's LMB patches are merged this function does not exist
> anymore.
>
> I think we should next move the EFI memory map to LMB to avoid double
> book keeping.
>

Yea, I sent that patch before LMB as a fix, but I agreed to wait till
the LMB patches get merged. Now that they are in we'll rework it.

Thanks
/Ilias
> Best regards
>
> Heinrich
>
> >               if (desc->type !=3D EFI_CONVENTIONAL_MEMORY)
> >                       continue;
> >
> > +             if (desc->attribute & EFI_MEMORY_SP)
> > +                     continue;
> > +
> >               /* Out of bounds for max_addr */
> >               if ((ret + len) > max_addr)
> >                       continue;
>
