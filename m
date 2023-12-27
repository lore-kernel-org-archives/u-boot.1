Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B81C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 16:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B0E877CD;
	Wed, 27 Dec 2023 17:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pS+GaGPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C72877F3; Wed, 27 Dec 2023 17:21:49 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB1B877B1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 17:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28bc7155755so2065506a91.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703694105; x=1704298905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Mhsi7S4/ATw4ohXL3Ob7oaJJQXGr+JTIzIzXm0RSe8=;
 b=pS+GaGPhRjZYfIMZlNExYE+7ofYQN76ARdrVzO5csqLkAf85CcxYtwflZvsCVua1uv
 WdJSC41uRD0mCkKUI4KT561ptCI9jzDwv+K/XaLqXnho78O652GAwpKEEydNpDqPn/3O
 n5bYI9deaqYfoMsMH4Dew/87wD7Hzc4uIdw3ZDkKUnKmC7xaSoq3oDgtBhlv75u8GDiH
 1dfKv7pZwllCtCiAHMcqE4LSRXCybqQ9RcYEcVcHcly8NSXi371vUoe1dbmSw7lP2tjc
 HglQDWC3QOp13HBpW9sto6De9G/xbMao91Hh/OVL1LEPnmItg5MO2MmnqPT7c9iOw4qw
 inrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703694105; x=1704298905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Mhsi7S4/ATw4ohXL3Ob7oaJJQXGr+JTIzIzXm0RSe8=;
 b=SccraMNltzyyLXlqsh65u1+lCkvndSsn9RfIvPcWasQ2uk0oOhv+AHAqBCqimAipgo
 LUaU07d3VeRgk9gVzsEtfV+wIzBZJGE6AhOVe56W8PcFxHwTSVHOaTFCmQg4K7tlelWN
 Oj2mu4FWtJTl6ecqTr+Bb2WIjLPFg5QutAcjgx0CnAir9NXSqUokD289SgJ1rsv0Di1b
 DvG+qM/bPMpj++6sBdUDSsa3yip0K8d6cwKvcNw4pIXfO8RCixsW2Mb+Fra1zK8EuYna
 +on4IbuHDcuZQv11+nUuXrGEZyoGf6n9ITvui/0cGcEM9r83RPP9TaIzKUKdakNgxcAi
 lbRg==
X-Gm-Message-State: AOJu0YxKHhffKe6+hoETy3Wi2QMtCt6N3bXRilOirCj+8I/MyVse403L
 /EzEsiLE1pg36iNw2OzQz6EEQtuGcZHaftD2Atq6+95DTsv0TQ==
X-Google-Smtp-Source: AGHT+IFHRBUheF1o7KRZKL+DSkBgVtChDLqm8KqDiZkNdBy/Uxh5ivwyN7InQBtxyZ/ngXs2jD4nZo8hF7s5xkJQi/U=
X-Received: by 2002:a17:90b:33cc:b0:28a:f2cc:e008 with SMTP id
 lk12-20020a17090b33cc00b0028af2cce008mr2881697pjb.54.1703694105586; Wed, 27
 Dec 2023 08:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-7-raymond.mao@linaro.org>
 <CAFLszTjoViZAxZy26k4aXuoBhvzt_P8zBwqx8Kr8wPHFns1RRQ@mail.gmail.com>
In-Reply-To: <CAFLszTjoViZAxZy26k4aXuoBhvzt_P8zBwqx8Kr8wPHFns1RRQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 11:21:35 -0500
Message-ID: <CAEfUkUKfC380JOkuz+x_vRVr2R2KXfJQ6gzKaS4fW55BkW5EFg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] qemu-arm: Get bloblist from boot arguments
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Add platform custom function to get bloblist from boot arguments.
> > Check whether boot arguments aligns with the register conventions
> > defined in FW Handoff spec v0.9.
> > Add bloblist related options into qemu default config.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Remove low level code for copying boot arguments.
> > - Refactor board_fdt_blob_setup() and remove direct access of
> gd->bloblist.
> > Changes in v3
> > - Optimize board_bloblist_from_boot_arg().
> >
> >  board/emulation/qemu-arm/qemu-arm.c | 30 +++++++++++++++++++++++++++++
> >  configs/qemu_arm64_defconfig        |  3 +++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/board/emulation/qemu-arm/qemu-arm.c
> b/board/emulation/qemu-arm/qemu-arm.c
> > index 942f1fff57..e225011bf0 100644
> > --- a/board/emulation/qemu-arm/qemu-arm.c
> > +++ b/board/emulation/qemu-arm/qemu-arm.c
> > @@ -4,6 +4,7 @@
> >   */
> >
> >  #include <common.h>
> > +#include <bloblist.h>
> >  #include <cpu_func.h>
> >  #include <dm.h>
> >  #include <efi.h>
> > @@ -102,6 +103,15 @@ static struct mm_region qemu_arm64_mem_map[] =3D {
> >  struct mm_region *mem_map =3D qemu_arm64_mem_map;
> >  #endif
> >
> > +/*
> > + * Boot parameters saved from start.S
> > + * saved_args[0]: FDT base address
> > + * saved_args[1]: Bloblist signature
> > + * saved_args[2]: must be 0
> > + * saved_args[3]: Bloblist base address
> > + */
> > +extern unsigned long saved_args[];
> > +
> >  int board_init(void)
> >  {
> >         return 0;
> > @@ -144,6 +154,26 @@ void *board_fdt_blob_setup(int *err)
> >         return (void *)CFG_SYS_SDRAM_BASE;
> >  }
> >
> > +int board_bloblist_from_boot_arg(unsigned long addr, unsigned long siz=
e)
> > +{
> > +       int ret =3D -ENOENT;
> > +
> > +       if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST=
))
> > +               return -ENOENT;
> > +
> > +       ret =3D bloblist_check(saved_args[3], size);
> > +       if (ret)
> > +               return ret;
>
> What about saved_args[1] ?
>
> The magic and version of register conventions cannot be checked now since
there is
a bug in the spec. PSB:
```
X1[23:0]: set to the TL signature (4a0f_b10b)
X1[31:24]: version of the register convention used. Set to 1 for the
AArch64 convention specified in this document.
```
Signature (4a0f_b10b) takes all [31:0] and no space for version of the
register convention.
This needs to be updated on TF-A and OP-TEE as well after the spec is
updated.
For now I will just skip the checking.


> > +
> > +       /* Check the register conventions */
> > +       ret =3D bloblist_check_reg_conv(saved_args[0], saved_args[2]);
> > +       if (!ret)
> > +               /* Relocate the bloblist to the fixed address */
> > +               ret =3D bloblist_reloc((void *)addr, CONFIG_BLOBLIST_SI=
ZE);
> > +
> > +       return ret;
> > +}
> > +
>
> This should be a generic function, e.g. in arch/arm
>
> I didn't find a place under arch/arm that is good for connect with the
saved boot
args. Do you have any suggestions?

[...]

Regards,
Raymond
