Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9026CC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 04:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11E9801FB;
	Wed, 12 Mar 2025 05:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rrA+r70F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB936807D7; Wed, 12 Mar 2025 05:22:21 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C56801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 05:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51eb1a714bfso6028654e0c.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 21:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741753338; x=1742358138; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yk0WaEKpieRvkDYWdcac7T6L7oEGzQCk6hm3gZXJbBs=;
 b=rrA+r70Fgce3jR8QHJ6BkoVeQluHPxtlpbAahUuKWcVlCU4Q8I/A6V00gllL2puYD+
 r0+usgOgjMka0rf1U19wiqge5kHgsKzVue7sTLZsqAbEovk1AJNZMl9MBYI/23irJ4pV
 9ZsvDJN4fgBiRVyf+9JSqWTNihkcr86fthKYP0WnaDBSKMDgc374HAJp1XxmTNMbPVVt
 jBzeXUzSpd2DZh3hlIYgCJuMOo/5os8BcmMReJ5TwetmIaW8XwKbNugi9KXn8QsDY1EV
 XnpW1olgNitOqvGMcErQxVDvaOEqFSkIUTbEzWnKaj1ZjRZ32QdE4sWvZyZAeimGs80l
 0MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741753338; x=1742358138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yk0WaEKpieRvkDYWdcac7T6L7oEGzQCk6hm3gZXJbBs=;
 b=wlyXKyOLEXeSVoM9hYE1ntHvB94g3gBWExQKd8fHb+jgX+hEbh0slR319N1nLC6uEr
 18WDKboFLAlkm9Vf8NgYqJ0zhPGfDqZ5yAP7yMeMkeDJrZRqoR6nyHTuKDQC+wKNgsQU
 de/tMThLygNUzMmNcKxtGTj14MmS83vwiLQYy52xi1/YGxvJ5ra+BpW8YKf7aZ1fBKLk
 1V8nnXPapHsOiU6g1JDHxmubIVUzLoecRziQO6Y8o/b1VUEbdLq/lCJ0dCKkYIJbTZGB
 BiAiSSeJ22i3yoZIrr3Chx4+tUUzzNLFCpyINt0tatCpJUKbJHGRaFn3q3XdjV2fXNbj
 t5eg==
X-Gm-Message-State: AOJu0Yyvw8O4GQhw88d3SIK2c0f80KNnP7/8ICS75JYB08oU53otP31V
 Q4cUVc6qZj+ait1PhPaiToD9LHbNM7LyzUT0Vl1UUj8B5xroRwUEDdupuK7bUIE1N6kAANVZ3Jj
 ZKPFFL2yZlm+9w+NZZJKYYUgM54dv4KRwY8dGTc9frQesgLW78V8=
X-Gm-Gg: ASbGnctGcGqgAVVWvOgfmGP5K2Cph5wRqJeHHw/EE2GpC/i5JHYkjNRLKoyfZmYZ1PR
 0etQrfHw3By8BpllGeCOeZ06hJJWi2feN7KYPAyRwRMdxFdVvs6rexHjYfjCXvaNNUEfpi06haS
 FIB5PMmNm0ogeJn3CcmvFdaqqatg==
X-Google-Smtp-Source: AGHT+IH7CNQUsn34OeP7R25iTBRwYAia3qBDzIfuQiCBdPyuy+3NsY0hIyYImrPdq8LiN7i03Q30ksDfzX7bTvPlFm8=
X-Received: by 2002:a05:6102:5109:b0:4bb:9b46:3f6f with SMTP id
 ada2fe7eead31-4c34d1f760amr5096165137.1.1741753338349; Tue, 11 Mar 2025
 21:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
 <20250310115750.1019051-3-sughosh.ganu@linaro.org>
 <CAC_iWjKesPeOfH=Nt6kQZS2nKa+jgt8vtVazNJhc1wm-VzJutQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKesPeOfH=Nt6kQZS2nKa+jgt8vtVazNJhc1wm-VzJutQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 12 Mar 2025 09:52:07 +0530
X-Gm-Features: AQ5f1JoiJYGWwMGrXUvxW-gigRIvknE2uo20ulxHThSXm_2UAnethureoYIZH4A
Message-ID: <CADg8p94qbxADF5anHike22wfY20KHxoNJEiLFCidNsCB8F+LYw@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

On Tue, 11 Mar 2025 at 19:13, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh,
>
> [...]
>
> >  {
> > -       unsigned long fdt_pages;
> >         efi_status_t ret = 0;
> >         void *fdt, *new_fdt;
> > -       u64 new_fdt_addr;
> > -       uint fdt_size;
> > +       static u64 new_fdt_addr;
> > +       static ulong fdt_pages;
>
> efi_uintn_t fdt_pages

Okay

>
> > +       ulong fdt_size;
> > +
> > +       if ((new_fdt_addr && !fdt_pages) || (fdt_pages && !new_fdt_addr)) {
>
> Is there a case when this can happen? I think we can just get rid of it entirely

Yeah, I was just trying to be defensive here. But it can be removed,
since these values are not coming from a separate caller.

-sughosh

>
> > +               log_err("%s: Fdt address/size not in the right state\n",
> > +                       __func__);
> > +               return EFI_INVALID_PARAMETER;
> > +       }
> > +
> > +       if (new_fdt_addr) {
> > +               log_debug("%s: Found allocated memory at %#llx, with %#lx pages\n",
> > +                       __func__, new_fdt_addr, fdt_pages);
> > +               ret = efi_free_pages(new_fdt_addr, fdt_pages);
> > +               if (ret != EFI_SUCCESS) {
> > +                       log_err("Unable to free up existing FDT memory region\n");
> > +                       return ret;
> > +               }
> > +       }
> >
> >         /*
> [...]
>
> Chers
> /Ilias
