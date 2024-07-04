Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897A6C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 17:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF2488363;
	Thu,  4 Jul 2024 19:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VxODCp3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C7788499; Thu,  4 Jul 2024 19:07:37 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F97288261
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 19:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-706524adf91so595061b3a.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720112854; x=1720717654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UHMxzXVnhHDvBvWmDjIS8J77niJujjeNSz2bGTfNOBU=;
 b=VxODCp3+XnswZ2henwNh88sEPn1EqpVWc3YI44674XHctSrDTkDrzBfgPdIP0V8jFG
 h3IGabmfM2cUHdjj/mBhIFpkCrKzyE+hgkjAYLoCj8FdV/GXSu0OB4v2uot+DaimveJV
 isJHLGvVnP4ea32ls8eohxRLcDC0rwHbtQU9jpqr/SKbDI4xW/5fLnsNJ4mQ9SU7Fbof
 oyDSter4ElknQQ+rfGi2fGbmFzfcfedq41YLo2VGwUV5Wo8xa1d8U95j9dHFGFvbb1gZ
 FmpPd9gI96pPvc33qH4cluLr1rCvbKjNFMGoXpxl5oP7k+SUF59PNuJrhjofusAF8x61
 OCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720112854; x=1720717654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHMxzXVnhHDvBvWmDjIS8J77niJujjeNSz2bGTfNOBU=;
 b=v2LOEAv6a4+B2Y9dtmnYPg+TWOeTP5TeBH0l3tzfibbudQhawyyGRr5khnyA2+ucBk
 b7jnyJtcE6XlzXrrWMkmRVg4kvHoaZG4BmADJfhrtv/fKv/EbbqcitHxh2eGPjyaGFho
 vXhEtaGX4tk29sJSbo3zu78+2K5kkBCfMzwyl3QNhXmpptUDSYh1bjPAugbHfYi0AVTH
 IbAShUsrhEjwRSacjfZ8+NDkCGD9gwc9npq9TdwxSKwNuOs9eI7LGZsINh0vzBGmCKow
 ba+cUngCYzRxKf/ys3bAwjVSXsCkYR33N4ilqhP9Do9nzxq9rBBidAY8ZsBupvinWn0V
 0Xxw==
X-Gm-Message-State: AOJu0YzvDNxRb7CrVFAt4Am8tRFqVih0iFPsemXyfpff2/3HzEqdzXip
 7ZsvXmM6d1t0Fi37FsF7ozyWy6Uccw5CSHd7oJ3yQEQq/MWZsCb0wNNJxz3mLknLJ+NuWsf5wAb
 RoA1iokEskDbyoBMbVHYTjmHVKA4LCiB0gGc5cg==
X-Google-Smtp-Source: AGHT+IHw926wzde5hKnrUbsgiJ4K8r/mFvPkiXzIy+QeGkFLpApNSAy9ZuHL5MhIZ9l/qpSBlnU05WwyZdQW1qMWr5I=
X-Received: by 2002:a05:6a20:7490:b0:1be:e53c:7fa2 with SMTP id
 adf61e73a8af0-1c0cc7422c8mr2624432637.25.1720112823818; Thu, 04 Jul 2024
 10:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240620201531.321110-1-ilias.apalodimas@linaro.org>
 <2a1d9bf4-1790-4186-b8e0-3a5001af9f72@gmx.de>
 <CAC_iWjKLdkbaxFXbogprgcaBMXtVGnp+j0_ED-izZaydQcAxEQ@mail.gmail.com>
 <6783af44-4d10-48ff-817d-d0434900319e@gmx.de>
 <CAC_iWjL=gopWJj9DV026Hkq5QYfZHj0HcrqNLq88CJFy_U0Pog@mail.gmail.com>
In-Reply-To: <CAC_iWjL=gopWJj9DV026Hkq5QYfZHj0HcrqNLq88CJFy_U0Pog@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Jul 2024 20:06:27 +0300
Message-ID: <CAC_iWj+LOrg-ZUCuEixzGKMc_GYpobuDARaR4G4nna2KdBmbsg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, jhumphreysti@gmail.com
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

Hi Heinrich

On Sun, 30 Jun 2024 at 15:47, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Sun, 30 Jun 2024 at 15:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 6/22/24 18:38, Ilias Apalodimas wrote:
> > > On Sat, 22 Jun 2024 at 19:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> On 20.06.24 22:15, Ilias Apalodimas wrote:
> > >>> EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
> > >>> at runtime is not supported and allow the platform to perform capsule
> > >>> updates on disk. With the recent changes boards can conditionally enable
> > >>> setvariable at runtime using EFI_RT_VOLATILE_STORE.
> > >>>
> > >>> Let's make that visible in our Kconfigs and enable EFI_IGNORE_OSINDICATIONS
> > >>> when set variable at runtime is disabled.
> > >>>
> > >>> Since EFI_RT_VOLATILE_STORE needs help from the OS to persist the
> > >>> variables, allow users to ignore OsIndications even if setvariable at
> > >>> runtime is enabled.
> > >>>
> > >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >>
> > >> So this v2:
> > >
> > > Yes sorry, forgot to add the tile and log...
> >
> > With this patch I get a failure on the sandbox in the CI:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21382
>
> Yes, this test is trying to test updates with OsIndications not set
> and it obviously fails, because it expects the update to stop.
>
> I'll send a v3 and adjust the tests.

I don't have to send a v3 eventually. The CI failure is a pre-existing
problem and the solution is posted here [0]. This can be merged as-is
after we merge the CI fixes

[0] https://lore.kernel.org/u-boot/20240704144316.251029-1-ilias.apalodimas@linaro.org/T/#u

Regards
/Ilias

>
> Cheers
> /Ilias
> >
> > Without the patch the sandbox runs fine:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21383
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > >>
> > >> v2:
> > >>          allow EFI_IGNORE_OSINDICATIONS if EFI_RT_VOLATILE_STORE=y
> > >>
> > >> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >
> > > Thanks Heinrich
> > >
> > >>
> > >>> ---
> > >>>    lib/efi_loader/Kconfig | 1 +
> > >>>    1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > >>> index ee71f417147a..6006e845cb1f 100644
> > >>> --- a/lib/efi_loader/Kconfig
> > >>> +++ b/lib/efi_loader/Kconfig
> > >>> @@ -220,6 +220,7 @@ config EFI_CAPSULE_ON_DISK
> > >>>    config EFI_IGNORE_OSINDICATIONS
> > >>>        bool "Ignore OsIndications for CapsuleUpdate on-disk"
> > >>>        depends on EFI_CAPSULE_ON_DISK
> > >>> +     default y if !EFI_RT_VOLATILE_STORE
> > >>>        help
> > >>>          There are boards where U-Boot does not support SetVariable at runtime.
> > >>>          Select this option if you want to use the capsule-on-disk feature
> > >>> --
> > >>> 2.43.0
> > >>>
> > >>
> >
