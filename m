Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D11E9A756
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95EB380087;
	Tue, 24 Mar 2026 10:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CSJZoW59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0547380087; Tue, 24 Mar 2026 10:51:42 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2705880077
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad79df972so5627060d50.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 02:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774345898; cv=none;
 d=google.com; s=arc-20240605;
 b=MTDusPF3FqFArXyE1ULdlwE1D3SFfMUm+5tFVGUJtHU307Q1Opk4XGk2bkdXwQGlUt
 yqb/nCPfwi75kkaNLSTZp+IjlXmBRn3K+RpvoEaQYTQoyCRyEk6D/lGfVkWvVPgNSu+1
 gFHZaKnhbE0LAP3s/e5mgd83GyTO/dhNeUCm2GYAJp4OoH5XPm44deulpJwUKKEcSNjs
 MGGeU211A2KfIvHIsTQSLH3SqNmmGaVBU3iSQoTiL/FAq75OkT87JHp9v/ITcKWwLAj/
 neciXUj7UtiF/GbQdtnoTnfWf890lAyfKaL4VDBs+8bHC23WqivvROx141T7w2ywYCWB
 t5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FOq1le/ZjK5QXH87OwnbFgf8vpRzLS3iJiUcSKtPJ44=;
 fh=PHfh1F4dNVf/Z0An1v4suYIt/PW4tbVpeinhhA6xsC4=;
 b=hq2hSyTnMKNZr4P1FQGKNnu7Ju8rItNnw08yZn4dHahILW6b8colQgOnlIz3ThC5iP
 2g+ncPLdGL74qwnQFAB4BOVXWapyvPwr+nmjHIS2PHXlZZtAMZ8l3AmazfI5EXxjeimL
 t8MPTDiuku+NZNnlBXaqR3ti4sgqauGXHlnWK4fDLpeCM44Q9Kyg6yrtawO5Hpo+S2Ql
 WRousxtJewk54IGOqGqUsBDEsBCsCUVka1ALRCZiD633CZfJYXtBp9v1nQp6x+1dlTRv
 AM6Q5GOH2EW0T29usCeVWfaHA5mj2F6NR4pTvYd7vFqRQooAKieGSg9je4S/UoVuqhwh
 AgAw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774345898; x=1774950698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FOq1le/ZjK5QXH87OwnbFgf8vpRzLS3iJiUcSKtPJ44=;
 b=CSJZoW59j3/KN1Y9XT8g26SoSbMLw44qCOZ2NyCuelm7AHG7xUGBTgB+VEXXBF4WzE
 vu7bv3G5k720BiDc8ROTiWKcTXMa2ST+sE7ykgE4wBwsyt40WaNTieBKTvNe8OfK9hh0
 rDqb1npzoD1vQ8y8iwIBQQbayxrcYcHGoXWDuScLG5H1oPM3o8I87zbz8Vrjm7jUno8E
 LW5QoTDG4XLa3YKwH2q4kId3gMurEGT5FadAcgc7pUWPYZCbKaYWFhJXZsOyORwp7n+/
 EAUr2kUNjOPVHrjz1acssIDvZWcfvYQye3bOcUGN3TX3+AAr6eOwHf7z8SqSbMZxCt6M
 jdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774345898; x=1774950698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOq1le/ZjK5QXH87OwnbFgf8vpRzLS3iJiUcSKtPJ44=;
 b=njLS3maDRMaT5IOrJ/lSsm/xPWgosP77yrIXzGdefzhMyT6+reOAcl4NkhRQkkWIz0
 Q9Gm1LbFE7DDA3KMi8SduOKP6Uip52MqyWbODf6i9b53q0Jc24Lx+siUn1OV/TNcd5xs
 CARvnL+OFTbo0lM99qqQb6wrAMG1qbi0YeUa1AoDrzT5taDc6yV1LCynNPBQBfoyfSJL
 ddxxoa83EarMnJvHpOS+pDlAr7YVf91+zWDJxECy7Fbj9WPAoLTGVHF8qWMOWZRDbioX
 g8l7zzpuEHGS8L+C2uo4lnSmcDieE61inTK6ACtWpaLC8Dh0Xjta9EX06k3adzk8lOay
 yjOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCGgPDgR75Vpe8AIO1x1vIowk16ztiL1e2Zuy7nMKYSAYnQn2lE9I3L6PaOibPi6OsX2pOEYw=@lists.denx.de
X-Gm-Message-State: AOJu0YywZPAquBzMJZMgCjAJw+ZSX6KCjgIvpv3emeGio2tDmmpp5Z12
 9ZcLFf7e8B2ChM/RCeSRYd0MgzeEy+ZtH80Wdp/sIXHFTRnEHpCjB3rU5sfnLmXTNQ9lJoMWBVM
 w9Zb1p506Fa70nEhiyBynsShhRof6NfioHnfD/strUQ==
X-Gm-Gg: ATEYQzwfWtbunlM47VPBBIpmgq+NoChp3f0iBJpUNMVRnOOgvrcda04uc45yLpD1snn
 zVhUd4z3ZniI92mNoH5GE+WtM/wbrv1vD5T6c/VIT3yv7MPsfwUk5mrkiI0kB3KmYzQrd0sDraO
 +nVk+G5fpcLnLy5lsfQb2rsWZ1Quj02n83qyOACyvY5kEmqWnisLJ9vD/8f1TPKkuELY6LBwgSq
 qcIpaxJruXDLWJdef9YHYB1erGyvnW6qbUy5W02EpdbuR3h4YLOYUE6eryWS3jyBDu8AQwF/Qjj
 OXSIFfW8WeiNo+xRaq6kodjTOhI3S5oB2HWYM3/aUUwB17XSEswfj2R7lH4ozUsyt9B/Zog4zu6
 X1nWlas7LAFztjfrWeDksRQiWIyFRQvWsJOkLJ9yjgpzVG+4Lh8i86B2gbKzqAL1xz7Xhu2wbtU
 7igMmmyHJrfs91UT6eoVvNAccilFQAPvEiEWKVJ+KvmPHaL4DsNys/zac+5FYTnXWqb59cp+24x
 4v7XQF9s0LI+dJT0PZ0yQk/wf48+VJti+n+kUl33LL5HqUIyM4/xRFujJqVlLvnF4Mnm0+OCV0h
 hbRsTVkpQjxxKlUQ9WzOUxDXuexi4j7h9PM8M30TX3h3AwI7xlguXns=
X-Received: by 2002:a05:690c:1d:b0:79a:38a2:d8ca with SMTP id
 00721157ae682-79a90af1076mr166511707b3.23.1774345897932; Tue, 24 Mar 2026
 02:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
 <DHABV5ZOLJOQ.1H3Q6TEFCTBET@garyguo.net>
 <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
 <DHAD1Y4YFJGF.223KKI69PZKC0@garyguo.net>
In-Reply-To: <DHAD1Y4YFJGF.223KKI69PZKC0@garyguo.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Mar 2026 11:51:01 +0200
X-Gm-Features: AaiRm52Eu5vEMPMN7CUmpBF0EMaiYpLyjdbnrgX7GQYUbCPRmz_feejd9xn9VTQ
Message-ID: <CAC_iWjKOi57Wm5TaRviV2KEUhXoQGLr0WUgchPywt6qPxLTnvg@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Gary Guo <gary@garyguo.net>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com, 
 u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 yuya.hamamachi.sx@renesas.com, andrew.goodbody@linaro.org, 
 casey.connolly@linaro.org, xypron.glpk@gmx.de, 
 holger.brunck@hitachienergy.com, jonas@kwiboo.se, kettenis@openbsd.org, 
 semen.protsenko@linaro.org, sughosh.ganu@arm.com, 
 u-boot-bounces@lists.denx.de
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

On Mon, 23 Mar 2026 at 20:07, Gary Guo <gary@garyguo.net> wrote:
>
> On Mon Mar 23, 2026 at 5:26 PM GMT, Marek Vasut wrote:
> > On 3/23/26 6:11 PM, Gary Guo wrote:
> >> On Sun Mar 22, 2026 at 11:25 PM GMT, Mark Kettenis wrote:
> >>>> Does something like this make the issue go away ?
> >>>>
> >>>> "
> >>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >>>> index b77c2f980cc..44eccc0cf35 100644
> >>>> --- a/lib/efi_loader/efi_memory.c
> >>>> +++ b/lib/efi_loader/efi_memory.c
> >>>> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum
> >>>> efi_allocate_type type,
> >>>>           flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
> >>>>           switch (type) {
> >>>>           case EFI_ALLOCATE_ANY_PAGES:
> >>>> +               addr = map_to_sysmem((void *)(uintptr_t)0xffff0000);
> >>>> +
> >>>>                   /* Any page */
> >>>> -               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
> >>>> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
> >>>>                                       len, flags);
> >>>>                   if (err)
> >>>>                           return EFI_OUT_OF_RESOURCES;
> >>>> "
> >>>>
> >>>> If so, then maybe we need a temporary config option which limits the
> >>>> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.
> >>>
> >>> Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
> >>> below 4 GiB.  So that change must indeed be behind a config option and
> >>> care must be taken on what systems to enabled it.
> >>
> >> Perhaps a good short-term fix it to use gd->ram_top here rather than hardcoding
> >> 4 GiB. This way it should work on all systems without a config option.
> > Looking at my notes from last DMA32 investigation, this may indeed do
> > the trick in the meantime. But it would be really good to have this
> > temporary workaround guarded by some Kconfig symbol, so it can be fixed
> > up once the DMA32 allocator is available.
> >
> > Does the gd->ram_top fix the RPi5 too ?
>
> Yes, I can boot my RPi5 with the following diff, which makes sense as it has
> ram_top of 0x3fc00000. Testing on devices with ram_top > 4 GiB would be needed
> to know if this is a proper fix.
>
> Best,
> Gary
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b77c2f980cc0..76ae89e31f47 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>         flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
>         switch (type) {
>         case EFI_ALLOCATE_ANY_PAGES:
> +               addr = map_to_sysmem((void *)gd->ram_top);
> +
>                 /* Any page */
> -               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
>                                     len, flags);

When you boot to linux, what does the memory map say ? Can you try
booting with efi=debug and paste the dmg output?

Thanks
/Ilias
>                 if (err)
>                         return EFI_OUT_OF_RESOURCES;
