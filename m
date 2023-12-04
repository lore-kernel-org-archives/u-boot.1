Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E46BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 20:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2C6875DB;
	Mon,  4 Dec 2023 21:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tCap0C1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8CFC86F42; Mon,  4 Dec 2023 21:06:48 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299FE87015
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 21:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-286b45c5a8dso1136715a91.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 12:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701720404; x=1702325204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NxxX/XIuGA+8DmTRh3gRUIMzqxfww7eoVX4QZJj0jUY=;
 b=tCap0C1z08mWZ/saUSxkIokYG9hDy0dSfYJUgkiKUUnba5SBPnQ/sohtZa2+MCkrHi
 B9jIpx838fHlDnE8N10PFzTk97OKK6xZy2y7jolNp9qCyHDYRerckXiAA2sbIlalZGaS
 AM9LpQzlRwF9V7PPhKyPBkOql84rYP0vsF2CxG8wXC13MdS4BhtgKFLG9mcPIF0t+F0a
 B5UqPnwEZA84QP1P07eYNt/Qe+xtBgAjQAfXb1/ov7VcaExi7uQ0r5Nl3ft/9aM3pD44
 gvLgk1WpyPRYBeW66hjLMoaH6h6UimWw61f2nRi/kU/Y5kKO82kDYaq1ITX39HUUTrWf
 B0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701720404; x=1702325204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NxxX/XIuGA+8DmTRh3gRUIMzqxfww7eoVX4QZJj0jUY=;
 b=q/jbltZUExgGKfRIMHbjD2Sj12fvo1dx8uiRh0ycoOkeaNJki6Rc15yfyqDSV5Z3gF
 c9sz6nrkW27M+dcGZkWigYtSWIqnYdP8/wGoa2FS+b4YiB+v9ASA5S52/GevoT6Thee6
 DBq2Y/m/BNPfVNmEctpujcjCRwoZC3Bzn8W4PtOSKbR/bHfw1hx7WhASrxOElSi20Jo3
 gd9+iq1LpS3zoPnLsUJ5iueHofA24T+7rfFrK47g4JvF4x+jdqtVDZMsIgMWqhR8USKd
 qyHZWI+fkAjzj/f4/HxsZrt3ZRqTX14GKQt1Sc0e1tOLDjlUlrjSlxwR9wuhKne/2K57
 OptQ==
X-Gm-Message-State: AOJu0YyjxNBmaSXFXns0yW0gpdLFSI3DJaOpo3mI+CqPX/HwWBC2CTgY
 Yw14uKgfhKqcZcR9YNE2PClaxHbqFhZD6fKmONnBPw==
X-Google-Smtp-Source: AGHT+IE5jQx7XHtE4bfR4dg96bPZGsDYE+GTA9hv8zjrRT5RISvsA7BVvPgObchZVr0J5V5c2UeayDViofuiRhhBDlE=
X-Received: by 2002:a17:90a:fe01:b0:286:6cc1:77ff with SMTP id
 ck1-20020a17090afe0100b002866cc177ffmr110487pjb.66.1701720404457; Mon, 04 Dec
 2023 12:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-18-raymond.mao@linaro.org>
 <CAPnjgZ16Cv5r6GB0j_WXTPTsASGj=Hi5Cdytyo-K7a-c73AeoA@mail.gmail.com>
In-Reply-To: <CAPnjgZ16Cv5r6GB0j_WXTPTsASGj=Hi5Cdytyo-K7a-c73AeoA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 15:06:34 -0500
Message-ID: <CAEfUkULfyrxaVhmcWrQEitWAiJHCA_WPZPbQ_5HyQArZonCE0g@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] qemu-arm: Get bloblist from boot arguments
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Simon

On Sat, 2 Dec 2023 at 16:16, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add platform custom function to get bloblist from boot arguments.
>
> This should be the same for all ARM platforms. The ultimate goal is
> something like [1]
>
Yes, I agree. The current series just focuses on Qemu but ultimately
should be adapted
to all Arm platforms.

>  #include <common.h>
> > +#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
> > +#include <bloblist.h>
> > +#endif
> >  #include <cpu_func.h>
> >  #include <dm.h>
> >  #include <efi.h>
> > @@ -102,6 +105,16 @@ static struct mm_region qemu_arm64_mem_map[] = {
> >  struct mm_region *mem_map = qemu_arm64_mem_map;
> >  #endif
> >
> > +#if IS_ENABLED(CONFIG_OF_BOARD)
>
> OF_BLOBLIST and please avoid #if
>
I will remove the build option for argument copying, as they don't
really depend on OF_BOARD
or _BLOBLIST.


> > +       /* Check the register conventions */
> > +       fdt = (unsigned long)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
>
> This should happen in fdtdec.c automatically. See [2]
>
The reason I have to call `bloblist_find()` here is to get the fdt address
and compare with
arg0 and arg2 (see below few lines of code) to check if it is compliant to
the register conventions
for AARCH64/32 defined by the FW Handoff spec.
This is better to be placed here instead of fdtdec.c

> +       if (IS_ENABLED(CONFIG_ARM64)) {
> > +               if (fdt != qemu_saved_args.arg0 || qemu_saved_args.arg2
> != 0)
> > +                       ret = -EIO;
> > +       } else {
> > +               if (fdt != qemu_saved_args.arg2 || qemu_saved_args.arg0
> != 0)
> > +                       ret = -EIO;
> > +       }
> > +
> > +       if (ret)
> > +               gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
> > +       else
> > +               memmove((void *)addr,  (void *)qemu_saved_args.arg3,
> > +                       gd->bloblist->total_size);
> > +#endif
> > +
> > +       return ret;
> > +}
> > +
>
> Thanks and regards,
Raymond
