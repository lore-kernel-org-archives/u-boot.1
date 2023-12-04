Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EB6C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 19:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B50877D6;
	Mon,  4 Dec 2023 20:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GrCSirDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6A186501; Mon,  4 Dec 2023 20:35:10 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD48877DC
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 20:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-286b22b9302so1139725a91.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 11:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701718507; x=1702323307; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QJ+0o0a+iGaAi5Et15442mX2IVFYPhT07lX3cZzaMKY=;
 b=GrCSirDfoa75/Lxmn36W6fyd1rJ4yD7Z9oJBingM/3pZhh8v7Uctn5xIKTe3puWeb9
 c3ViiUVrahXBSHBMz7ID2lShRdjc7i/uLc9wpVMzztBX2fvoq7TJ8w4u7xxXOHl7OCsh
 EKRNOX143vLQP+E4ax4PCKrYuplUN3y60SuQIco343Ve+3K/BzDdY3dk9pfHuo27MdTc
 O6ijpt6AIFx/gBLLpu/TTzbxGd4Y7F31A7Vs9aUWtfJ9RJNi0plw/E1Gebvamzj5mh+T
 aaMTNKOrHKgu+Z+VLg6Q5xqWtxuALwew3qFPKkrGNYovraY/3GuJQU+UOcvBetPpZcgW
 aJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701718507; x=1702323307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJ+0o0a+iGaAi5Et15442mX2IVFYPhT07lX3cZzaMKY=;
 b=pXF+ZGS+VdUfo1BAfy44u0wbasDhZN8em7Xh4S9UESEjxKt87UdsGG6bDzhA66ZnGQ
 55WBRW4oM+7+ubHTb8pU8yvu4NCgXUxWgmc4WGzgSB+uq0DRwKHnySRERg3VwE1/wSXE
 oNoZwxEK0sa10MWJQXF0tFM2SUDjGM2/qTlOWLC4tHcIforB7aPzhz+c6vjMJ9t2UBlo
 AsqYxEdG47aIxrQA+pXCWpkkrki3fLbhlF8EZxiZzHV4ub/GY7+S2s/vNxcF0pbQgt+E
 z/LyIAZzc2r/usRz5B0ULDdzjddIVOSc0vt+e/iS0sEcyGWw+KUDuuzNNtOWnDxJxLH8
 PegQ==
X-Gm-Message-State: AOJu0Yw1hod97ef64nS0r4fUmcTYy66gSNM5nuIuR2Qo8gma2lVqMItB
 4b6M5KwY/DQvBEwkLLOxNX8hMOTPQ7YTzSDFTDg7Qg==
X-Google-Smtp-Source: AGHT+IFLULZerjYVlgBuz4z/F05zRowA2wsFltiOPAyupT2PtQ5Oekuky8RIxt28U8MYZJiDhDGsoXBSoP7L9c1mECA=
X-Received: by 2002:a17:90b:e07:b0:286:6cc1:77fe with SMTP id
 ge7-20020a17090b0e0700b002866cc177femr89242pjb.65.1701718506806; Mon, 04 Dec
 2023 11:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-18-raymond.mao@linaro.org>
 <6bf6f903-ca3a-42ff-aa62-be3098615dd3@amd.com>
In-Reply-To: <6bf6f903-ca3a-42ff-aa62-be3098615dd3@amd.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 14:34:57 -0500
Message-ID: <CAEfUkUJgJQQzFq0DBBHc3fTTMW6Sf2V6yqDMQyxKTrjYLcnbEw@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] qemu-arm: Get bloblist from boot arguments
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Michal,

I will remove "#if IS_ENABLED(CONFIG_OF_BOARD)" from below:

>+#if IS_ENABLED(CONFIG_OF_BOARD)
>+/* Boot parameters saved from lowlevel_init.S */
>+struct {
>+ unsigned long arg0;
>+ unsigned long arg1;
>+ unsigned long arg2;
>+ unsigned long arg3;
>+} qemu_saved_args __section(".data");
>+#endif

Saving the args does not really dependent on OF_BOARD or BLOBLIST

Thanks and regards,
Raymond

On Mon, 4 Dec 2023 at 02:54, Michal Simek <michal.simek@amd.com> wrote:

>
>
> On 11/27/23 20:50, Raymond Mao wrote:
> > Add platform custom function to get bloblist from boot arguments.
> > Check whether boot arguments aligns with the register conventions
> > defined in FW Handoff spec v0.9.
> > Add bloblist related options into qemu default config.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> >
> >   board/emulation/qemu-arm/Makefile        |  1 +
> >   board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++++
> >   board/emulation/qemu-arm/qemu-arm.c      | 54 ++++++++++++++++++++++++
> >   configs/qemu_arm64_defconfig             |  3 ++
> >   configs/qemu_arm_defconfig               |  3 ++
> >   5 files changed, 80 insertions(+)
> >   create mode 100644 board/emulation/qemu-arm/lowlevel_init.S
> >
> > diff --git a/board/emulation/qemu-arm/Makefile
> b/board/emulation/qemu-arm/Makefile
> > index a22d1237ff..12821e7083 100644
> > --- a/board/emulation/qemu-arm/Makefile
> > +++ b/board/emulation/qemu-arm/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0+
> >
> >   obj-y       += qemu-arm.o
> > +obj-$(CONFIG_OF_BOARD)       += lowlevel_init.o
> > diff --git a/board/emulation/qemu-arm/lowlevel_init.S
> b/board/emulation/qemu-arm/lowlevel_init.S
> > new file mode 100644
> > index 0000000000..d72d7c938a
> > --- /dev/null
> > +++ b/board/emulation/qemu-arm/lowlevel_init.S
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: BSD-2-Clause */
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#include <config.h>
> > +
> > +.global save_boot_params
> > +save_boot_params:
> > +#ifdef CONFIG_ARM64
> > +     adr x9, qemu_saved_args
>
> Based on logic below this is available only when CONFIG_OF_BOARD is
> enabled.
> Please look below.
>
> > +     stp x0, x1, [x9]
> > +     /* Increment the address by 16 bytes for the next pair of values */
> > +     stp x2, x3, [x9, #16]
> > +#else
> > +     ldr r12, =qemu_saved_args
> > +     stm r12, {r0, r1, r2, r3}
> > +#endif
> > +     b       save_boot_params_ret
> > diff --git a/board/emulation/qemu-arm/qemu-arm.c
> b/board/emulation/qemu-arm/qemu-arm.c
> > index 942f1fff57..a3892630d8 100644
> > --- a/board/emulation/qemu-arm/qemu-arm.c
> > +++ b/board/emulation/qemu-arm/qemu-arm.c
> > @@ -4,6 +4,9 @@
> >    */
> >
> >   #include <common.h>
> > +#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
> > +#include <bloblist.h>
> > +#endif
>
> you have dependency on OF_BOARD and BLOBLIST.
>
> >   #include <cpu_func.h>
> >   #include <dm.h>
> >   #include <efi.h>
> > @@ -102,6 +105,16 @@ static struct mm_region qemu_arm64_mem_map[] = {
> >   struct mm_region *mem_map = qemu_arm64_mem_map;
> >   #endif
> >
> > +#if IS_ENABLED(CONFIG_OF_BOARD)
>
> And here OF_BOARD.
>
> Not all should be aligned but I don't think current #if
>
>
> Thanks,
> Michal
>
