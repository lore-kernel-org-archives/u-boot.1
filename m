Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C06EC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B725C884BA;
	Fri,  5 Apr 2024 10:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PZEH7l8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BBC884C7; Fri,  5 Apr 2024 10:34:14 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE2B883EA
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516d4d80d00so397684e87.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712306052; x=1712910852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/bJQuFeYkunuGNOO1uhYWew1//M5yUAHbIJJOzVQNeo=;
 b=PZEH7l8FIEAv7ZBru2sNLt2JZhBeqGJdu3U9MQYVjvSXUi6LV3295mlJziD5jO+tTT
 4PI/DK6cCVJvWpwWX1EpIgAp7sdgnwXbpev1XQk+L8xawB8Ej13cF7+DW4dWTaxuBUIt
 zeLZBCocq1jz2QPhJXIlvotbMp+lusQafb8clPjVGZhPV0XxEjSXqTNosq3ZO9eU29bw
 KF22UY8U68KdXo1AhzcNOIVCHqV2/i/vLPQ39+dG+cIj24AYpjE3czkXJzY9c5GG/v/b
 rY1yNlRR5UK7poQvL5qPW7fjXYuXFQLqCfsA7DpgctVVw+VEH3US4EBAERfSY42cyjzJ
 q4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712306052; x=1712910852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/bJQuFeYkunuGNOO1uhYWew1//M5yUAHbIJJOzVQNeo=;
 b=juN8dipbkJSNOdJBJrs5ZI+ubY/scrbNSzdgIm0HbhiXVNEVVZscKJHbR/naYvMXUm
 tjkofkNJlneDLk8Hw3B80K7SXRiJOVJgMSNeUYVLzoRmxVbStIttApbI8Z28mIO+3qBF
 6swnaWot1/TvQQKu3+dLqes1CykBUG8PkduOibHZ1hioFSlfJdp39CglMeMPwnUsrq4g
 E1FRVYClSwXySgCnS0BN4A5V31emE05L7b9FjCCDn2L9um1kygLBsP9g9Wi+FOQIrkhP
 zIm2y2E9HkgRaKEgxNK9VgiI1i4gNOtmMrNFRydLTSVYtog0HHWx03Oo2DD2SwMiZuIs
 Uvmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMF1PRNWpN2JhgXg4cE5Dr0LJvemsiQG/fanFRK4ExqbS8GsKJtcx7i9R1Ql8xOQoVE5YcH2T+hDzOiZNhExSOlwo9Fw==
X-Gm-Message-State: AOJu0Yw5MkPmA9RB2zy/dSjD9kinv74j9X6DlI+AaPiyXXyUNjx4FgLg
 AGJ30NEBGdcb2dAvDS+LvC1WLmgfvr3MTDh1bF7RrZJRHg/7tOud5wcjiDpAYh5x4DRHDTyzpLk
 VZLILJXjax2uUFiLk8PtV2eQKPFVNYvxBZQqcFQ==
X-Google-Smtp-Source: AGHT+IFlFLEbUq/wUVH12zYnOnEsk8P2a4LF9zO4Wyi9P8SPnLnZ03C4hCjYNoa9WBMMHys6Qsh6TcZQ1maCtKjsAI8=
X-Received: by 2002:ac2:4430:0:b0:513:ce4c:93f1 with SMTP id
 w16-20020ac24430000000b00513ce4c93f1mr568347lfl.33.1712306051760; Fri, 05 Apr
 2024 01:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240404063535.469995-1-ilias.apalodimas@linaro.org>
 <e9a8767d-27af-45cd-87b7-e2cbe188db56@canonical.com>
In-Reply-To: <e9a8767d-27af-45cd-87b7-e2cbe188db56@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Apr 2024 11:33:35 +0300
Message-ID: <CAC_iWjL57gtJVkDMPGak4qYE3rff9hDEBGpKw0bK+LRDtX7cyQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: access __efi_runtime_start/stop without &
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Fri, 5 Apr 2024 at 10:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 4/4/24 08:35, Ilias Apalodimas wrote:
> > A symbol defined in a linker script (e.g. __efi_runtime_start = .;) is
> > only a symbol, not a variable and should not be dereferenced.
> > The common practice is either define it as
> > extern uint32_t __efi_runtime_start or
> > extern char __efi_runtime_start[] and access it as
> > &__efi_runtime_start or __efi_runtime_start respectively.
> >
> > So let's access it properly since we define it as an array
>
> Thanks for investigating this.
>
> Beyond this patch I guess we should eliminate these duplicate defintions:
>
> include/asm-generic/sections.h:38:extern char __efi_runtime_start[],
> __efi_runtime_stop[];
> include/efi_loader.h:348:extern char __efi_runtime_start[],
> __efi_runtime_stop[];

Yes, you've already sent a patch on this, thanks

>
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/efi_memory.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index edfad2d95a1d..98f104390c8d 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -933,8 +933,8 @@ static void add_u_boot_and_runtime(void)
> >        * Add Runtime Services. We mark surrounding boottime code as runtime as
> >        * well to fulfill the runtime alignment constraints but avoid padding.
> >        */
> > -     runtime_start = (ulong)&__efi_runtime_start & ~runtime_mask;
> > -     runtime_end = (ulong)&__efi_runtime_stop;
> > +     runtime_start = (ulong)__efi_runtime_start & ~runtime_mask;
>
> Using (uintptr_t) would make it clearer that we are converting from a
> pointer to an integer type.
>

Sure, I would prefer this to be on a followup with a commit message of
its own, but I am fine with amending it, if you merge this

Thanks
/Ilias
> Best regards
>
> Heinrich
>
> > +     runtime_end = (ulong)__efi_runtime_stop;
> >       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> >       runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> >       efi_add_memory_map_pg(runtime_start, runtime_pages,
>
