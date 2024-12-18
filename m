Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11C8E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 16:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBCC80274;
	Wed, 18 Dec 2024 17:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UIdl6dv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7822480283; Wed, 18 Dec 2024 17:27:01 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 354AA80269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 17:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so11936348a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734539218; x=1735144018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DuSEYTjlcexowSVnhhO+rqhdadYB/8cWn+cpnqclNzc=;
 b=UIdl6dv1hxnYssb+zqh4YaofyQS/ZrkZai9iHrG7ojFCjHqoafX6N6L1pMZ+yiNH1A
 kpu0PD9V77DQoXvECvgDtNCKJs1JttRAIr2s29ippCbmVPwtQJKRIjGzOGkXBJL8fWMS
 B6aIw7D4/rQZdslwHGAZxNsydh4JJQ1skVvlEwvVnBnQGn+51zdOX2uIWM9srihmbmRS
 +PLGTJ+qSJbKQ1Ce6avxhq5X+ICgzUiA3zMDJht7KHiRS5Pz/jIuznz2NHW7QWnfq8Ah
 QgjkuDSakQ2/k5ql4CvhLkuCXn0kJIpFHusPDbf/fMz1fLojFQ3pOR4Adlv01tYTd0BX
 D7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734539218; x=1735144018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DuSEYTjlcexowSVnhhO+rqhdadYB/8cWn+cpnqclNzc=;
 b=Vjdkj9hl1BKUtpwm4ajYPomgqCaUWRccnD0pO6STZRTfbriK0YDr8FhmdU9P+FcaUl
 ozd7WkrAvBlGvRQrTAuh+ScV70SY2CFZWMvCeSbQLTsh0B6Xb2PHBGa/UtTE7Y6FWPqs
 196qEoZOLO/kTDLMi/xu48ln7wJg5Sz+3kpaB0hwE+PEWBNo0hmik08UkVD+Rq1BdU7B
 cEzZC7DG5Rp5a+vAFQmJ8fCiXArDXotzXmIhP3z0XEewWRUxgBKsohCN9ek1qd6+w2dU
 yMDe3Yfb2KKmqnzvUpythCbpjbKrhktjbU4qdJUGHoEaZY6Wn4LcuPWJUsPdGK110I3u
 dhBQ==
X-Gm-Message-State: AOJu0YzFVs69oiotep+kU+vHmm/MDcSxTq3XqKtC4Z88ERun3vZZwY4T
 NEYC05bKKiAMqQMhSCNPSwvdYELD0trVfZ2OdguR/g2vcSVqT+N8TY4uOO8ahu8Kl1490bCX1HQ
 WuroHn/Vd/ZFnboXDzj5sV2VQGcI=
X-Gm-Gg: ASbGnctR/FMqxBmIzrK/vRqL5wtoQXZjebvK9cmdpxzmbIDTbl+T4w+tv7mUCwIkvzd
 nhbTWUbT5MzP/7O6ft1e8qFey0jn7Ba5MwfJlEttWxiePVZRpC20=
X-Google-Smtp-Source: AGHT+IHqBjSOTWU1weu3NJzkaNXYhg7rteJvIr/Y6HLtk1EygZ3FctMTxvSQ2wXBRSa1Vx7GLGx3z20Bu5fXFFQp1zI=
X-Received: by 2002:a05:6402:35c2:b0:5cf:c33c:34cf with SMTP id
 4fb4d7f45d1cf-5d7ee3b3763mr3121221a12.15.1734539218125; Wed, 18 Dec 2024
 08:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-6-sjg@chromium.org>
 <CALeDE9M_Bgaxom1Ac3Uomu=Mnd+mvKeGNAsHxn63kve8qfwzUg@mail.gmail.com>
 <CAFLszTitLSCc71TUV8fB0dzWFQwRxO8mVwhwao6ornPGc3AamQ@mail.gmail.com>
In-Reply-To: <CAFLszTitLSCc71TUV8fB0dzWFQwRxO8mVwhwao6ornPGc3AamQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 18 Dec 2024 16:26:46 +0000
Message-ID: <CALeDE9Mya5U1LfcUuNU9SQtpqpKUG9vXOkYmjo=9H39nz=YvQg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] rpi: Use the U-Boot control FDT for fdt_addr
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>, Francois Berder <fberder@outlook.fr>, 
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Hi Simon.

On Mon, 16 Dec 2024 at 00:27, Simon Glass <sjg@chromium.org> wrote:

> Hi Peter,
>
> On Wed, 11 Dec 2024 at 09:36, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> >
> >
> > On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> The fdt_addr variable is used in extlinux as a fallback devicetree if
> >> none is provided by the boot command.
> >
> >
> > And what about where extlinux isn't used?
> >
> >>
> >> The existing mechanism uses the devicetree provided to U-Boot, but in
> >> its original, unrelocated position. For the rpi_4 I am using, this is
> >> at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> >> is large.
> >>
> >> U-Boot already deals with this sort of problem by relocating the FDT
> >> to a safe address.
> >>
> >> So use the control-FDT address instead.
> >
> >
> > Please re-word the above, it doesn't make sense to me, "the rpi_4 I am
> using" .... what about the other millions of RPis out there?
> >
> >>
> >> Remove the existing comment, which is confusing, since the FDT is not
> >> actually passed unmodified to the kernel: U-Boot adds various things
> >> using its FDT-fixup mechanism.
> >
> >
> > Don't remove it, re-word it so it's up to date.
> >
> >>
> >> Note that board_get_usable_ram_top() reduces the RAM top for boards with
> >> less RAM. This behaviour is left unchanged as there is no other
> >> mechanism for U-Boot to handle this.
> >
> >
> > The below looks irrelevant to the patch at hand, it looks like it should
> be in the cover letter.
>
> Do you have any comments on the code in this series?
>

I did already comment on it, please go back through your emails ;-)


> >
> >>
> >> In version 2, it incorporates some changes to fdt_addr, etc. suggested
> >> by Tom, as well as adding myself as a maintainer.
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >> (no changes since v2)
> >>
> >> Changes in v2:
> >> - Drop patch to allow expanding the devicetree during relocation
> >>
> >>  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
> >>  1 file changed, 8 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> >> index 9122f33d88d..8f6ab1b1b9b 100644
> >> --- a/board/raspberrypi/rpi/rpi.c
> >> +++ b/board/raspberrypi/rpi/rpi.c
> >> @@ -3,6 +3,8 @@
> >>   * (C) Copyright 2012-2016 Stephen Warren
> >>   */
> >>
> >> +#define LOG_CATEGORY   LOGC_BOARD
> >> +
> >>  #include <config.h>
> >>  #include <dm.h>
> >>  #include <env.h>
> >> @@ -325,19 +327,10 @@ static void set_fdtfile(void)
> >>         env_set("fdtfile", fdtfile);
> >>  }
> >>
> >> -/*
> >> - * If the firmware provided a valid FDT at boot time, let's expose it
> in
> >> - * ${fdt_addr} so it may be passed unmodified to the kernel.
> >> - */
> >> +/* Allow U-Boot to use its control FDT with extlinux if one is not
> provided */
> >>  static void set_fdt_addr(void)
> >>  {
> >> -       if (env_get("fdt_addr"))
> >> -               return;
> >> -
> >> -       if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
> >> -               return;
> >> -
> >> -       env_set_hex("fdt_addr", fw_dtb_pointer);
> >> +       env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
> >>  }
> >>
> >>  /*
> >> @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> >>  {
> >>         int node;
> >>
> >> -       update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> >> +       if (blob == gd->fdt_blob)
> >> +               log_debug("Same FDT: nothing to do\n");
> >> +       else
> >> +               update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> >>
> >>         node = fdt_node_offset_by_compatible(blob, -1,
> "simple-framebuffer");
> >>         if (node < 0)
> >> --
> >> 2.34.1
> >>
>
> Regards,
> Simon
>
