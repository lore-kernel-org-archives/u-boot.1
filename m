Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2986EE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF968066C;
	Thu,  9 Jan 2025 16:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Maju2ug+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D725280655; Thu,  9 Jan 2025 16:02:28 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E12E8066C
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so1526587a91.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434945; x=1737039745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5N4zg4qEZDzEXt3mpdFs5/y/HKEyYhhOn9xIBOZAM3U=;
 b=Maju2ug+eftZnq131vt+NgI7bjboSD+DG5poc6eHJzU47w8AQnp2hSeYNTuJk1IoJG
 QtS6c/U3jhp/ZuRKLjVJCLrfpKoi8Y6fgABfhLT0Qq7ZB0IkyfnHiirdjzbw0oqscpGc
 CKr2x9GEK9d69RgxqRmrxWbqT6UJQr0FODvow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434945; x=1737039745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5N4zg4qEZDzEXt3mpdFs5/y/HKEyYhhOn9xIBOZAM3U=;
 b=LwEGHY/P6nfmeCIIOrS5iPR1Mx6epREgIFN0MpvbHxgs42c8c4t56PdDz3Q9DT5/tj
 R8iH2fwb2FZcB/DjY0H3P2KPl9vlaJnQke5GpfFea8Bf6uX2uWdbfk/AlMGij4RPygxp
 59NLxhYUIhCa+Uai+QVh/t+b7BMdyhXucosc3NvqbDycNw/wHVriczWdpby0QZyVZLyG
 RcnUyJguv4DdweeWZe58Qn0ZSy7DoD0YYImgFMGSJai6Cza+Z1MlGA4WFCiWKAB70dbF
 FKHb4C9dKYOVW3+a3rgrqtlVwf8ObY1Up+EGgRcA39thvk/fGp0kjlWcs2xhWNKmCvn/
 KAAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD2yoU0VygSKj+SJg9AZMmvCxgbc1PXKL5kpkyrFOOhuAm+PO7BrcskAC1d4TiNxeRBRkkPis=@lists.denx.de
X-Gm-Message-State: AOJu0YxM4AQlcb1gsV+5GCLtpvq6i9kDmH/5VICnv9MPQ2eYNoH9pSrR
 niMYRhU/3aTtqIhSC1s8CM/3roqcypCamQNQVEfUJw+zVmDzVB+ckx09zd/E7fSayXaYvR89KxG
 hxyZ2VIPEnoOplO7+j4b4JWFyD+uh3z3uJO8V
X-Gm-Gg: ASbGncsBrJtZdICqq14rd3usM74ayu0BYXPzx7ByV8bmW2VR10zAN2AFm1Tvq8P4DN0
 vbexIJjXoqCFCsC2GA1Zpe7BM1pTyGtFm80gdJPU=
X-Google-Smtp-Source: AGHT+IG4usW+g9LmZK75Mib+QCpfxsMwKOnKJxHUb/CWgu488JCCj8ig1F2f5i2tHlwo+Szij7hwLgpkBDSDAZjRSKY=
X-Received: by 2002:a17:90b:54cb:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2f548ec9267mr11555393a91.17.1736434944760; Thu, 09 Jan 2025
 07:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <75414697-7f13-4f6c-b640-b2b4fad333e3@gmx.de>
In-Reply-To: <75414697-7f13-4f6c-b640-b2b4fad333e3@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:02:06 -0700
X-Gm-Features: AbW1kvaqRJniQr0g7MArD9zVUzfuSt9OZdkZY_NoVfbHIsmZw4Jfb8gQjmpHLnE
Message-ID: <CAFLszThA6stUizPmaqS+oxFgnUynAT-PzYu+Qqbo0Hj71_Fy7w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] efi: Start to chip away at the EFI workaround
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 22 Dec 2024 at 05:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/19/24 03:38, Simon Glass wrote:
> > At present there is a function, efi_set_bootdev(), which is used in
> > various places to tell the EFI loader which device a file came from.
>
> As long as we have a command line to download images we won't be able to
> avoid remembering the boot device in a global.

Watch this space.

>
> >
> > With bootstd, this information is available in the bootflow.
> >
> > This little series provides a way for bootstd to provide the bootflow to
> > the EFI loader, so that it is able to select the correct paths.
> >
> > For now only the EFI bootmeth is updated.
>
> This seems to be the wrong focus. The EFI boot method should be removed.
> It just duplicates the parts of the EFI boot manager boot method.

I don't agree with that at all. The boot manager doesn't play well
with other bootmeths and needs to be looked at more closely, as the
sunxi experience shows.

I'm going to resend this series with the changes you requested, except
for the networking side (recently introduced) which needs to be
handled separately.

> >
> > Changes in v3:
> > - Make calculate_paths() static and add a comment
> > - Add new patch to support PXE booting
> > - Rebase on Tom's tree (i.e. without the pointers/addresses series)
> >    https://patchwork.ozlabs.org/project/uboot/list/?series=436241
> >
> > Changes in v2:
> > - Adjust argument ordering for efi_run_image()
> > - Use efi_loader tag instead of efi
> > - Drop unnecessary path removal
> > - Fix 'require' typo
> > - Move calculation of dev-name into a separate function
> >
> > Simon Glass (7):
> >    efi_loader: Refactor device and image paths into a function
> >    efi_loader: Make efi_run_image() static
> >    efi_loader: Update efi_run_image() to accept image and device path
> >    efi_loader: Add a version of efi_binary_run() with more parameters
> >    efi_loader: Move the fallback code from efi_run_image()
> >    efi_loader: Pass in the required parameters from EFI bootmeth
> >    bootmeth_efi: Support PXE booting
> >
> >   boot/bootmeth_efi.c          |  64 +-------
> >   include/efi_loader.h         |  10 ++
> >   lib/efi_loader/efi_bootbin.c | 276 ++++++++++++++++++++++++++---------
> >   3 files changed, 218 insertions(+), 132 deletions(-)
> >
>

Regards,
Simon
