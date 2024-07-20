Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811A0C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39E98886C;
	Sat, 20 Jul 2024 14:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b4vz0PQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19CA888747; Sat, 20 Jul 2024 14:36:25 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44ADC886F0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e0885b4f1d5so56813276.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478981; x=1722083781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U4CXguAoCbFcSZq6Bo8DAF1AJYIkZMrivajiq08AOcE=;
 b=b4vz0PQQLye1z+hkSkwaCD5arCfkuun0LOhoxo8NNSHETb1Vr+pr9cwNs8OZx74oJH
 xtnBB8Yjz8iAc2hVEOA9nosey60s4HmFP3G24C+W0JmuMIIcXQkysphvCO0JviBeGm4s
 fSnBFd3iF7KR/1vrg/7/t3teaGZkCBFM3ExLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478981; x=1722083781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U4CXguAoCbFcSZq6Bo8DAF1AJYIkZMrivajiq08AOcE=;
 b=rVtaOGmP6i7K5oFV/BBSl4Dpe23kyKl/lKUUfG4rEeW6T9artAlTGCHdjRJ900jlsH
 K3Qtt2vOrQXl2SL9h+WDVU7ERA28MGgN7rxOZumv5mK9bEEXtV+U5grBk826z1tJ/BMo
 DojoPOVlGsF7GaRlw27KjU3tP3CO9vUnxzUs+VnUY/8Pm8X31dxI8btSf7ZGls7zA/YE
 rsSO4ryS7RFYvqh+MC48sD2bp7945C1JAHLzfa3izYYWG7FPEKZ3/2WiA8bbRLTYFt+S
 4wgeZ9FfnczWkZ2ihQQZmPrcaCvF/Hv41iWfQ2R4rtVjYVyR4EzZf2p5rruFeVcROAMi
 ZAQA==
X-Gm-Message-State: AOJu0YxeasyTRLrXY+GAt4i6ANkDCyNF6ZYwZRDmJnpbA5LJC3VBS8VC
 PfY8ATCNymgVRodv2TSGPIkEjsQZxZzD8xO6gEnUJTLsm7Yhi4C59ij2eTtVqGPOk4zrYzBDqAe
 41QoJZsrZyVunHUJcYt6N8Q682fvq8Q2nj7xQ
X-Google-Smtp-Source: AGHT+IGlqbirTNJRn8/Qkd8nMFk4bWmX3A+yyPIkMNdqYJtcSRzYXvR1i/ak3lag87BaPWDXCSD50fjnsEW6BropAGI=
X-Received: by 2002:a05:6902:a07:b0:e08:78ce:c92d with SMTP id
 3f1490d57ef6-e087b7b5eacmr1554083276.3.1721478981136; Sat, 20 Jul 2024
 05:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-20-sjg@chromium.org>
 <ea2af812-f6a5-478d-5069-ee918bf507a8@gmail.com>
In-Reply-To: <ea2af812-f6a5-478d-5069-ee918bf507a8@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:10 +0100
Message-ID: <CAFLszTg+i+iiHjpU-Ps=MJhmwf9V3aJ0zmTVDGjDAUYebyeaNA@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] sandbox: Add an SPL loader for UPL
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Sean,

On Thu, 18 Jul 2024 at 15:12, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/13/24 03:00, Simon Glass wrote:
> > Add support for loading a UPL image from SPL. This uses the simple FIT
> > implementation, but also loads the full FIT just to permit more testing.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   arch/sandbox/cpu/spl.c         | 49 +++++++++++++++++++++++++++++++++-
> >   arch/sandbox/include/asm/spl.h |  1 +
> >   2 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> > index 39869f27a7b..f665f86d64c 100644
> > --- a/arch/sandbox/cpu/spl.c
> > +++ b/arch/sandbox/cpu/spl.c
> > @@ -3,14 +3,18 @@
> >    * Copyright (c) 2016 Google, Inc
> >    */
> >
> > +#define LOG_CATEGORY LOGC_BOOT
> > +
> >   #include <dm.h>
> >   #include <hang.h>
> >   #include <handoff.h>
> >   #include <image.h>
> >   #include <init.h>
> >   #include <log.h>
> > +#include <mapmem.h>
> >   #include <os.h>
> >   #include <spl.h>
> > +#include <upl.h>
> >   #include <asm/global_data.h>
> >   #include <asm/spl.h>
> >   #include <asm/state.h>
> > @@ -52,7 +56,8 @@ void board_init_f(ulong flag)
> >   void board_boot_order(u32 *spl_boot_list)
> >   {
> >       spl_boot_list[0] = BOOT_DEVICE_VBE;
> > -     spl_boot_list[1] = BOOT_DEVICE_BOARD;
> > +     spl_boot_list[1] = BOOT_DEVICE_UPL;
> > +     spl_boot_list[2] = BOOT_DEVICE_BOARD;
> >   }
> >
> >   static int spl_board_load_file(struct spl_image_info *spl_image,
> > @@ -246,3 +251,45 @@ int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
> >
> >       return 0;
> >   }
> > +
> > +static int upl_load_from_image(struct spl_image_info *spl_image,
> > +                            struct spl_boot_device *bootdev)
> > +{
> > +     long long size;
> > +     char *fname;
> > +     int ret, fd;
> > +     ulong addr;
> > +
> > +     if (!CONFIG_IS_ENABLED(UPL_OUT))
> > +             return -ENOTSUPP;
> > +
> > +     spl_upl_init();
> > +     fname = os_malloc(256);
> > +
> > +     ret = sandbox_spl_load_fit(fname, 256, spl_image);
> > +     if (ret)
> > +             return log_msg_ret("fit", ret);
> > +     spl_image->flags = SPL_SANDBOXF_ARG_IS_BUF;
> > +     spl_image->arg = map_sysmem(spl_image->load_addr, 0);
> > +     /* size is set by load_simple_fit(), offset is left as 0 */
> > +
> > +     /* now read the whole FIT into memory */
>
> Why do we have to do this? Didn't we just load the FIT in sandbox_spl_load_fit?

Sort-of, but really SPL the simple FIT loader just loads the images,
not the entire FIT. It is loaded here just for the benefit for the
test, which wants to check that the offsets provided in UPL are
correct.

>
> > +     fd = os_open(fname, OS_O_RDONLY);
> > +     if (fd < 0)
> > +             return log_msg_ret("op2", -ENOENT);
> > +     if (os_get_filesize(fname,  &size))
> > +             return log_msg_ret("fis", -ENOENT);
> > +
> > +     /* place it after the loaded image, allowing plenty of space */
> > +     addr = ALIGN(spl_image->load_addr + size, 0x1000);
> > +     log_debug("Loading whole FIT to %lx\n", addr);
> > +     if (os_read(fd, map_sysmem(addr, 0), size) != size)
> > +             return log_msg_ret("rea", -EIO);
> > +     os_close(fd);
> > +
> > +     /* tell UPL where it is */
> > +     upl_set_fit_addr(addr);
> > +
> > +     return 0;
> > +}
> > +SPL_LOAD_IMAGE_METHOD("upl", 4, BOOT_DEVICE_UPL, upl_load_from_image);
> > diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
> > index d50d9ad6b48..d824b2123a2 100644
> > --- a/arch/sandbox/include/asm/spl.h
> > +++ b/arch/sandbox/include/asm/spl.h
> > @@ -18,6 +18,7 @@ enum {
> >       BOOT_DEVICE_NOR,
> >       BOOT_DEVICE_SPI,
> >       BOOT_DEVICE_NAND,
> > +     BOOT_DEVICE_UPL,
> >   };
> >
> >   /**
>

Regards,
Simon
