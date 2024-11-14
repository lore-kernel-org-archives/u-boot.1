Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56303D65C42
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 06:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B4E88B16;
	Thu, 14 Nov 2024 07:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lPl2QSWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8013788B16; Thu, 14 Nov 2024 07:38:47 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E84807F4
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 07:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-720c2db824eso208246b3a.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 22:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731566323; x=1732171123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LnMumFZWmBVMarxMSaquMyoRmtnDj6OrWOCRt+O9Ld0=;
 b=lPl2QSWsw501cVOTKcRy3RWvtCeWFgAvnNBcuH+3VpL5AiqHq+ydL+aeFgORmRaRQb
 h4KpexiAAjBWjEzOwY4ftC8BUDo6YxRGhWip4DoHs4G9JHhs0rmzfd+FHdx1w+VtbwYv
 KrB8WG83AQ6TsIrLpkf5ZccAn9UHApRSDUBgmgzn8q6EFQqUuxuLes20mWQwrfqN9Abd
 jUMcM1f45QU+0BwJHOYwH7M6DLoBMO9OgsnnrWKV3vW4ZLq3lYcOCALk2AKA2WDPAPqv
 Myla2G40hj8S3buwImgBfTVCG/HwbiBrDJfzWD4RMWsK9aWLxypHIU0g8DeUsDbvqOnV
 oo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731566323; x=1732171123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LnMumFZWmBVMarxMSaquMyoRmtnDj6OrWOCRt+O9Ld0=;
 b=S+vF6jyrvxu7bBYycfQGR2UcTMdQh4fKMGV83k9nOr8PI1JbKnruqaeN585h8PexQg
 mcWQewaaZ91sLJbP8wiXsUJ07LaTxN9O4hMqi5hnkmWILwwfHKpl9t6tpAhejvbf0iaW
 QqPu/w4aYg41woxkWQvHLmalmEyIt8AvWBSJob4tqDh00e+qPHqAOKUnczUPNIexnbOT
 nJB48UZM/Yeld55DiYU+++5XkGqU/XufTL8Rdi0gEuhSJWELOiwSUqdlREdkzpQjSh0N
 ZP47oM6aMxCzFLZ2PMx5cJQJ0fCXrYO1yZaBtppD2JrzvIBbXuyKZuM9+Vvb3HWQEb3p
 IvnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWm3jjlaUWgsp1zkYxzOX8ztv1HZNkSpfO7/mptfAyXD9HLHLFFKnsKA5e4IKabSMouHCrxTw=@lists.denx.de
X-Gm-Message-State: AOJu0YzNCvTD2yAjXW7mMvV02EzJZpGFHr0i8QVnmVXZ+SkPQ9kGbTp0
 PjCokVb9F3K8m4ZZVlvDf/BZ56oldRVqgIbMTTRHf+Y92GzCHBlAvQLLIVHSyEp1DT9WSVJszJ8
 AXEGl6EKDLDmTGnwzRMddOZaAgQE+gW5EG7Favg==
X-Google-Smtp-Source: AGHT+IEQjrPura8rH10qIA+r8hGuApvisXEPFxDZ5T773XJFUA2x6NVM3OrVfGC70l295n9OGQfED3vAy9COgwVI92Q=
X-Received: by 2002:a05:6a00:17aa:b0:71e:2a0:b0d0 with SMTP id
 d2e1a72fcca58-724132c04bbmr31736369b3a.13.1731566323216; Wed, 13 Nov 2024
 22:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
 <CAFLszThV5a16Q2BqxNn6jX=EavRf--gWESs-4riz_paqgzo9dQ@mail.gmail.com>
In-Reply-To: <CAFLszThV5a16Q2BqxNn6jX=EavRf--gWESs-4riz_paqgzo9dQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Nov 2024 08:38:07 +0200
Message-ID: <CAC_iWj+h7WSyx_0ffzHMPUsc4cRGpK7dU8-MrGRE+hxWvuZNqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

Hi Simon,

On Thu, 14 Nov 2024 at 05:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Wed, 13 Nov 2024 at 12:55, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Some hard devices need specific routines to scan for block devices,
> > e.g. NVMe (nvme scan), SCSI (scsi start).
> >
> > Invoke bootdev_hunt() to find all block devices.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_setup.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index aa59bc7779d..8e0ff16f3eb 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -7,6 +7,7 @@
> >
> >  #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <bootdev.h>
> >  #include <efi_loader.h>
> >  #include <efi_variable.h>
> >  #include <log.h>
> > @@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
> >          * Probe block devices to find the ESP.
> >          * efi_disks_register() must be called before efi_init_variables().
> >          */
> > +       if (CONFIG_IS_ENABLED(BOOTSTD)) {
> > +               int r;
> > +
> > +               r = bootdev_hunt(NULL, 0);
> > +               if (r)
> > +                       log_debug("No boot device available\n");
> > +       }
> >         ret = efi_disks_register();
> >         if (ret != EFI_SUCCESS)
> >                 goto out;
> > --
> > 2.45.2
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Can we do this later, e.g. when we need to boot? What specifically
> needs to scan for block devices? Perhaps a better question is: when is
> the ESP needed?

It depends on how the board is configured. There's generally 2 cases
where we need early access to the ESP
- Variables if they are stored in a file in the ESP
- Capsule update on disk, since we need to scan the ESP for a capsule

Cheers
/Ilias
>  It would be nice to have that info in the commit
> message.
>
> I wonder if we could/should delete efi_disks_register() now?
>
> Regards,
> Simon
