Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAF6C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F76D88684;
	Wed, 29 May 2024 18:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6A2g/dV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D3488210; Wed, 29 May 2024 18:30:16 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9558D8860D
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6ab9ce75777so11878096d6.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000213; x=1717605013; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDrs9w2KJrczj5PKOQysaPqhj6AY2R9mRu/Hyd9gQsk=;
 b=c6A2g/dVIlUz/XSn6/fShpCXui3pXtWhHiigypO1JLYqes/StsLn7ug1YY2G7rREL0
 3qGVGW7/gsIuvlKHjPwYNUiGqupm2kmmYT7jhHDvCpDpttYjNDsTDaYYH1axfERSrALb
 ECzUW4D1+4JWGXJ9OnEV+tKeCM4F46rN8AnrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000213; x=1717605013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDrs9w2KJrczj5PKOQysaPqhj6AY2R9mRu/Hyd9gQsk=;
 b=KHS6NViG6sWU3Aiw+8Ht4Ibxt0f38c47ePVJCQECX97Ni0W7bRHx2Pr5G2J9VU2yvk
 UeIURfZyK8rMyuD2Ld1ZB3xEBo7xLk/se5qZ9GOHfdbjOe5/VJ04hppX6OMXLI31KSVm
 HQF8rrglFvwJdaoGRjIH40Kl9U0JDOKqI+S+NCKoXMxTweYbgHKTEK1Pd97k2F4UhBVJ
 bX0raI89uhTZHZ+XgoouG5HV5+lp1ULxjX/YDB5CmoUFBfxdjAtvnF4EAKuA8aNayLXB
 rivWbXPa1WLq6DkoQFAj2hBsQSRe0O9NdJsymcXW/P2nx7ShwnA9IpeaLZaQM5TmtT4V
 oT6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz6B1tNikpNvPjtu7+s08x9fmxsYwHjKPWGJSaEEZueJj6FSUeXNLyhyCIkox+/SL0ZWkx2MAignxfLpIXUICChphsgA==
X-Gm-Message-State: AOJu0YyfAdAo/tcIvHg1ksjlPXIYw0xXMrYGEqGe+2YA0jHjer+J8sjW
 0OwVKQ/CYZ6VcQtolixCggyuWbDPLg/hvscVt3KpwoZdbKp8W9pNCQxFJdzYFrFHEwAW/bOHLW9
 RGttZYtdc4gaX44F0K73jjLkFpdb7Rp8YU28wONVkqZDldlE=
X-Google-Smtp-Source: AGHT+IEL0jdnXocq0Af3Y6dWn/FSB4wL/kktv4ToLZe3SWR9wi87HMlK4nEd5MTFfululdZCdDnDuAhj+1VfsovkDcU=
X-Received: by 2002:a05:6214:5244:b0:6ad:62a9:839a with SMTP id
 6a1803df08f44-6ad62a98459mr169259506d6.27.1717000213278; Wed, 29 May 2024
 09:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <CANV2PTOAc50sXtz2V6s7bgnEk02TV_7+VArxBpHhF_tCGNjsmA@mail.gmail.com>
In-Reply-To: <CANV2PTOAc50sXtz2V6s7bgnEk02TV_7+VArxBpHhF_tCGNjsmA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:30:01 -0600
Message-ID: <CAFLszTikFOL3MCOLr+MVg+sGdt3sxcjq6zhbgZxCMyVf-scRdQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] efi_loader: improve device-tree loading
To: E Shattow <lucent@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

Hi,

On Tue, 28 May 2024 at 18:38, E Shattow <lucent@gmail.com> wrote:
>
> Hi,
>
> On Tue, May 28, 2024 at 7:43=E2=80=AFAM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > In U-Boot EFI boot options can already specify both an EFI binary and
> > an initrd. With this series we can additionally define the matching
> > device-tree to be loaded in the boot option.
> >
> > With the last patch the boot manager will fall back the device-tree
> > specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
> > on the boot device if no device-tree is specified in the boot
> > option or via a bootefi command parameter.
> >
>
> As tested the $fdtfile environment variable has no effect on
> global EFI boot when i.e. EFI/BOOT/BOOTRISCV64.EFI
> on EFI System Partition and no user-added boot option;
> $fdtfile env variable is not used with "mmc 0" or whichever
> global boot option is enabled by default in the boot order.
>
> Adding a boot option for EFI/BOOT/BOOTRISCV64.EFI
> and giving this priority in the boot order allows $fdtfile to
> be effective here. This is consistent with what is described
> by the series. Would the global EFI boot also get support
> for $fdtfile either with this or a later series?
>
> > v2:
> >         Update efi_dp_concat() instead of new function efi_dp_merge().
> >         Carve out a function efi_load_option_dp_join() which we can
> >         use both for the eficonfig and the efidebug command.
> >         Rename variables id_dp, final_dp_size.
> >         Rename create_initrd_dp() to create_lo_dp_part().
> >         Use enum as parameter for create_lo_dp_part().
> >         Put all related changes into one patch.
> >
> > Heinrich Schuchardt (8):
> >   efi_loader: allow concatenation with contained end node
> >   cmd: eficonfig: add support for setting fdt
> >   cmd: efidebug: add support for setting fdt
> >   efi_loader: load device-tree specified in boot option
> >   efi_loader: move distro_efi_get_fdt_name()
> >   efi_loader: return binary from efi_dp_from_lo()
> >   efi_loader: export efi_load_image_from_path
> >   efi_loader: load distro dtb in bootmgr
> >
> >  boot/bootmeth_efi.c                        |  60 +---------
> >  cmd/eficonfig.c                            |  83 +++++++++----
> >  cmd/efidebug.c                             | 130 +++++++++++++++------
> >  include/efi_loader.h                       |  24 +++-
> >  lib/efi_loader/Makefile                    |   1 +
> >  lib/efi_loader/efi_bootbin.c               |   2 +-
> >  lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
> >  lib/efi_loader/efi_boottime.c              |   3 +-
> >  lib/efi_loader/efi_device_path.c           |  40 ++++---
> >  lib/efi_loader/efi_device_path_utilities.c |   2 +-
> >  lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
> >  lib/efi_loader/efi_helper.c                |  44 +++++++
> >  12 files changed, 445 insertions(+), 136 deletions(-)
> >  create mode 100644 lib/efi_loader/efi_fdt.c
> >
> > --
> > 2.43.0
> >
>

Can we use the best-match compatible approach as expected by the new
'make image.fit' in Linux?

Filenames should be deprecated IMO. I am happy to help work on how to
do that if you agree.

Regards,
Simon

> Tested-by: E Shattow <lucent@gmail.com>
