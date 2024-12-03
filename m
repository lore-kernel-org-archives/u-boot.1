Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9EBE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD9C89550;
	Wed,  4 Dec 2024 00:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q1b8wGBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5BB89655; Wed,  4 Dec 2024 00:12:46 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9430B8857C
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa51d32fa69so924922666b.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733267564; x=1733872364; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SmPKciqOw3KI+YmJ8rrGImtEjqfjZYy1OEY2dZK7sg4=;
 b=Q1b8wGBUb4f9g2GJd+rp4YSTSZz09KIe5NNnwPxb17j26KJDk6LXNZ9ALQJZ8wx5VE
 AD10lvGtWyrtt5BipBWHVgl0bpSrHekQQ9FhK5lNPVeqWDMl6kaLwcWoKX5+XXEI3Ews
 AR4Gwy371Y+p+Dmgomc2YiNDKqhCtvyr5fVdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267564; x=1733872364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SmPKciqOw3KI+YmJ8rrGImtEjqfjZYy1OEY2dZK7sg4=;
 b=d9Lgo6DcOC3O41sK02JdGqUEFti02LdUAok50VC8FrnLYCJpqiCQoS+V9CnGIGd/A+
 99OBtY/0GKpYEP1nbta7MhYZpy1ck10bcOuWeSQvy8buwzyQT01lK4QVxZAV27IMvS0e
 sXEwPLvsL2QjjZF8/3EsJOwNRG8JbZmjxFi9uLMTijcdB9NAESSL5iLYAPnFFWX4VMSO
 fhE8i9JcFeZkDxXZemrfZj2Ue+HJlsh9IFxy5bBzpyidRQ1TwNZQcqD23zUihh6fNpIK
 /1ilGKai5M72ypVfchvsoqmfKNua3LjsJRW+fiK3Q5t3hgFVsJcv9XY4qlmyEaIswW0y
 7roQ==
X-Gm-Message-State: AOJu0YzFmdJ3zGt8pBJwXGWGjfX6s0FQe1208q32aa5SlkmJ+7f/a35H
 peXcIlW2cArwc/5PEfhkEmqKop+pypydeJa1we1KrKIcG1Cnx4Hd2E9UsP/mwlkWfhoOlehdp1B
 soWP+lVkPpHTGC8F266w6ag75bmCgRAxwuCgg
X-Gm-Gg: ASbGncuaaUumF/XCZ6ptY+hDrdASG3CzyCvq4YyiLS5yYnkKtjnNatMBubHPmJ+Wv3o
 B9NW+HUEINbC/cXzIWFgaRd7GOCZn6Q5I
X-Google-Smtp-Source: AGHT+IFcCRnCzBlMpstXGHyVHxB9bp/SN4GfvnH1uvvzr9/gGBtIa6X5kTzook8yM0EEQ9LwGe25C3mFjyCIoonkHUI=
X-Received: by 2002:a17:906:1bb1:b0:aa1:e695:f60 with SMTP id
 a640c23a62f3a-aa5f7eef9dbmr328948866b.41.1733267563979; Tue, 03 Dec 2024
 15:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-14-sjg@chromium.org>
 <64ede47f-42e8-4205-b78e-35eb69352b0e@cherry.de>
In-Reply-To: <64ede47f-42e8-4205-b78e-35eb69352b0e@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 16:12:32 -0700
Message-ID: <CAFLszThPw71zP18kR-yrCPC7ekM3z=BVRr6G7KTWvKcQ5YOScA@mail.gmail.com>
Subject: Re: [PATCH 13/39] boot: pxe: Use bootm_...() functions where possible
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

Hi Quentin,

On Wed, 27 Nov 2024 at 05:08, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 11/19/24 2:18 PM, Simon Glass wrote:
> > Rather than building a command line for each operation, use the
> > functions provided by the bootm API.
> >
> > Make sure that the bootm functions are available if pxe_utils is used.
> >
> > Since SYS_BOOTM_LEN is not present for the tools-only build, adjust the
> > code to handle that.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   boot/Makefile    |  2 +-
> >   boot/pxe_utils.c | 43 ++++++++++++++++++++-----------------------
> >   2 files changed, 21 insertions(+), 24 deletions(-)
> >
> > diff --git a/boot/Makefile b/boot/Makefile
> > index 43def7c33d7..9ccdc2dc8f4 100644
> > --- a/boot/Makefile
> > +++ b/boot/Makefile
> > @@ -10,7 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
> >   obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
> >   obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
> >
> > -obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
> > +obj-$(CONFIG_PXE_UTILS) += bootm.o pxe_utils.o
> >
> >   endif
> >
> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > index 66f82d3fbc1..2517999d408 100644
> > --- a/boot/pxe_utils.c
> > +++ b/boot/pxe_utils.c
> > @@ -7,6 +7,7 @@
> >   #define LOG_CATEGORY        LOGC_BOOT
> >
> >   #include <bootflow.h>
> > +#include <bootm.h>
> >   #include <command.h>
> >   #include <dm.h>
> >   #include <env.h>
> > @@ -461,7 +462,7 @@ skip_overlay:
> >    * Scenario 4: fdt blob is not available.
> >    */
> >   static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
> > -                          char *kernel_addr, char **fdt_argp)
> > +                          char *kernel_addr, const char **fdt_argp)
> >   {
> >       /* For FIT, the label can be identical to kernel one */
> >       if (label->fdt && !strcmp(label->kernel_label, label->fdt)) {
> > @@ -584,72 +585,66 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
> >                         char *kernel_addr, char *initrd_addr_str,
> >                         char *initrd_filesize, char *initrd_str)
> >   {
> > -     char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
> >       char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
> > +     struct bootm_info bmi;
> >       ulong kernel_addr_r;
> > -     int bootm_argc = 2;
> >       int zboot_argc = 3;
> >       void *buf;
> >       int ret;
> >
> > -     bootm_argv[3] = env_get("fdt_addr_r");
> > +     bootm_init(&bmi);
> >
> > -     ret = label_process_fdt(ctx, label, kernel_addr, &bootm_argv[3]);
> > +     bmi.conf_fdt = env_get("fdt_addr_r");
> > +
> > +     ret = label_process_fdt(ctx, label, kernel_addr, &bmi.conf_fdt);
> >       if (ret)
> >               return ret;
> >
> > -     bootm_argv[1] = kernel_addr;
> > +     bmi.addr_img = kernel_addr;
> >       zboot_argv[1] = kernel_addr;
> >
> >       if (initrd_addr_str) {
> > -             bootm_argv[2] = initrd_str;
> > -             bootm_argc = 3;
> > +             bmi.conf_ramdisk = initrd_str;
> >
> >               zboot_argv[3] = initrd_addr_str;
> >               zboot_argv[4] = initrd_filesize;
> >               zboot_argc = 5;
> >       }
> >
> > -     if (!bootm_argv[3]) {
> > +     if (!bmi.conf_fdt) {
> >               if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
> >                       if (strcmp("-", label->fdt))
> > -                             bootm_argv[3] = env_get("fdt_addr");
> > +                             bmi.conf_fdt = env_get("fdt_addr");
> >               } else {
> > -                     bootm_argv[3] = env_get("fdt_addr");
> > +                     bmi.conf_fdt = env_get("fdt_addr");
> >               }
> >       }
> >
> >       kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
> >       buf = map_sysmem(kernel_addr_r, 0);
> >
> > -     if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
> > +     if (!bmi.conf_fdt && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
> >               if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
> >                       if (strcmp("-", label->fdt))
> > -                             bootm_argv[3] = env_get("fdtcontroladdr");
> > +                             bmi.conf_fdt = env_get("fdtcontroladdr");
> >               } else {
> > -                     bootm_argv[3] = env_get("fdtcontroladdr");
> > +                     bmi.conf_fdt = env_get("fdtcontroladdr");
> >               }
>
> Unrelated remark:
>
> This could be shortened to
>
> if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) || strcmp("-", label->fdt))
>      bmi.conf_fdt = env_get("fdtcontroladdr");
>
> Same for a few lines above.

OK, will add a patch for that, thanks.

>
> >       }
> >
> > -     if (bootm_argv[3]) {
> > -             if (!bootm_argv[2])
> > -                     bootm_argv[2] = "-";
> > -             bootm_argc = 4;
> > -     }
> > -
> >       /* Try bootm for legacy and FIT format image */
> >       if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
> >           IS_ENABLED(CONFIG_CMD_BOOTM)) {
> >               log_debug("using bootm\n");
> > -             do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> > +             ret = bootm_run(&bmi);
> >       /* Try booting an AArch64 Linux kernel image */
> >       } else if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
> >               log_debug("using booti\n");
> > -             do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> > +             ret = booti_run(&bmi);
> >       /* Try booting a Image */
> >       } else if (IS_ENABLED(CONFIG_CMD_BOOTZ)) {
> >               log_debug("using bootz\n");
> > -             do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> > +             ret = bootz_run(&bmi);
> >       /* Try booting an x86_64 Linux kernel image */
> >       } else if (IS_ENABLED(CONFIG_CMD_ZBOOT)) {
> >               log_debug("using zboot\n");
> > @@ -657,6 +652,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
> >       }
> >
> >       unmap_sysmem(buf);
> > +     if (ret)
> > +             return ret;
> >
> >       return 0;
>
> simply
>
> return ret;
>
> ?

Sure, but I try to end with success! It allows addition of logging or
other things without hacking the code too much.

>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Regards,
Simon
