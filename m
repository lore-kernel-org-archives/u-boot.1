Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB559C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 12:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD39885E1;
	Sun, 30 Jun 2024 14:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QWa4NfGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CAB188618; Sun, 30 Jun 2024 14:48:28 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F02F088481
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 14:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c5362c7c0bso1109550a91.1
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719751704; x=1720356504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xbdMt3SsV2rooNP1mmkch3S3Opu0+HtcdyMcoxUjrV0=;
 b=QWa4NfGOP19KYJLsAYLbPo4IsguQTkguQBY8FwlG0OELhEPHStzw2Dpfu1PaSO8VOK
 oS5oEkj4GZRMXfBKoo8VFm9vBwWT/BQmIYqNDGax+h8YjbBPKXZytds3lRYwT9ni67rT
 0NKos5hCuOYqFvbZASBUVv6H/Rm8YLydupxtT9R+JlUnGglYACazclwO7KzpBVlRsUgd
 1s/fC+OP2+hrq/YT3/gL6OHWEosRyv5S89HrgR+mCMx6dTWOjsz+rhmPbMMFvIcWu64e
 mebks3GZSzb+OfXxqq8473HdLNuBhYombJgSyYKtuUedI2IOhN6f62j5+MH85Dab25nB
 +5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719751704; x=1720356504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbdMt3SsV2rooNP1mmkch3S3Opu0+HtcdyMcoxUjrV0=;
 b=lBW2lVJ1vfbj52TAe1l/7lJmR7IY6x+hcHYSWElsX1ep6h6zDavYGAaRFMMNkSq2yi
 c3XJYS3AQ428v4/BQYln/D9S0soHwWkWT2wX4TBEsywofyY7LVcBFIPMD6Ar85ADZiTu
 7UmGkC8ljRUdZwG29mIUxxdPMZvnX+T4338g0IWTbxus1BOMrSsTrhltaAB/kr/mP9f/
 EEwpjSAhb3zAclAYyDiar0D4/beRZNOXN47emUON/8vZOHwEhlTeCv5EBXvH1t7rI3oT
 0zO+Z0jJJ8lVE1VV09w16M2r/V3ytQpR5mkIIDediUIzw10RYBobYaPGTMrvAC2e31Ii
 gR7w==
X-Gm-Message-State: AOJu0Yzcc58anHS8VeDvOu9O/ewrdCm6jAnycLLD0Xhh9nhzYjDnjdSt
 5lysi75+GA9UNdLmrm4iaZ2BHaYT2HuxTO6jg8k/eBrRWwTpWeJ0yHqnFt865EKchs8H1em6kU/
 vNcUZpfa6Cp36BrqliExeHAFZC7pEc1mcsCg3Ow==
X-Google-Smtp-Source: AGHT+IGNfO0QHxw0B6LaHYyiG6HLPcxhtmE1fojS0SVBMGImdrQOhy4JQZwgoKMiuj2vmdUrRyzkRQxzyezVeMLrthE=
X-Received: by 2002:a17:90a:a58a:b0:2c7:c7e6:eb89 with SMTP id
 98e67ed59e1d1-2c93d7277ecmr1238505a91.23.1719751704176; Sun, 30 Jun 2024
 05:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240620201531.321110-1-ilias.apalodimas@linaro.org>
 <2a1d9bf4-1790-4186-b8e0-3a5001af9f72@gmx.de>
 <CAC_iWjKLdkbaxFXbogprgcaBMXtVGnp+j0_ED-izZaydQcAxEQ@mail.gmail.com>
 <6783af44-4d10-48ff-817d-d0434900319e@gmx.de>
In-Reply-To: <6783af44-4d10-48ff-817d-d0434900319e@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 30 Jun 2024 15:47:48 +0300
Message-ID: <CAC_iWjL=gopWJj9DV026Hkq5QYfZHj0HcrqNLq88CJFy_U0Pog@mail.gmail.com>
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

Hi Heinrich,

On Sun, 30 Jun 2024 at 15:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/22/24 18:38, Ilias Apalodimas wrote:
> > On Sat, 22 Jun 2024 at 19:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 20.06.24 22:15, Ilias Apalodimas wrote:
> >>> EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
> >>> at runtime is not supported and allow the platform to perform capsule
> >>> updates on disk. With the recent changes boards can conditionally enable
> >>> setvariable at runtime using EFI_RT_VOLATILE_STORE.
> >>>
> >>> Let's make that visible in our Kconfigs and enable EFI_IGNORE_OSINDICATIONS
> >>> when set variable at runtime is disabled.
> >>>
> >>> Since EFI_RT_VOLATILE_STORE needs help from the OS to persist the
> >>> variables, allow users to ignore OsIndications even if setvariable at
> >>> runtime is enabled.
> >>>
> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>
> >> So this v2:
> >
> > Yes sorry, forgot to add the tile and log...
>
> With this patch I get a failure on the sandbox in the CI:
>
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21382

Yes, this test is trying to test updates with OsIndications not set
and it obviously fails, because it expects the update to stop.

I'll send a v3 and adjust the tests.

Cheers
/Ilias
>
> Without the patch the sandbox runs fine:
>
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21383
>
> Best regards
>
> Heinrich
>
> >
> >>
> >> v2:
> >>          allow EFI_IGNORE_OSINDICATIONS if EFI_RT_VOLATILE_STORE=y
> >>
> >> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >
> > Thanks Heinrich
> >
> >>
> >>> ---
> >>>    lib/efi_loader/Kconfig | 1 +
> >>>    1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>> index ee71f417147a..6006e845cb1f 100644
> >>> --- a/lib/efi_loader/Kconfig
> >>> +++ b/lib/efi_loader/Kconfig
> >>> @@ -220,6 +220,7 @@ config EFI_CAPSULE_ON_DISK
> >>>    config EFI_IGNORE_OSINDICATIONS
> >>>        bool "Ignore OsIndications for CapsuleUpdate on-disk"
> >>>        depends on EFI_CAPSULE_ON_DISK
> >>> +     default y if !EFI_RT_VOLATILE_STORE
> >>>        help
> >>>          There are boards where U-Boot does not support SetVariable at runtime.
> >>>          Select this option if you want to use the capsule-on-disk feature
> >>> --
> >>> 2.43.0
> >>>
> >>
>
