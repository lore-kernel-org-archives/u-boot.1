Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD0AE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 17:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996F180377;
	Wed, 11 Dec 2024 18:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IkPx573b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE14803A9; Wed, 11 Dec 2024 18:22:39 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59B180316
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 18:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so700369366b.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733937756; x=1734542556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8w5pnuxrbnTGjEvN4Gd/TW04qK6YEVawKnqyxvivmxE=;
 b=IkPx573byRlbMzAUmTUSYgLSYmQxyBHQotaioYfEcr43VAkx5WFfisQ4m3nzxJ0DtC
 B3x0jEHzBn1fA7oUIibzVt5itFgxf4dtBClziNG7gzXE4PoZfPSCCXwMR62li8ztw/P6
 da65XUtaqoME5U3AlNqmqAtqmI0CLmQEzG+2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733937756; x=1734542556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8w5pnuxrbnTGjEvN4Gd/TW04qK6YEVawKnqyxvivmxE=;
 b=e07KJssgRewFBqU0EoQfUYaw2DNsxT/K/f0LfK3DN+T1o4i+8P0cdHmZZWPDskkiHI
 94XqOmBd+eY9t7obDPXAS0JxjBYHcdwRZxMH9hPLr1DO3Dh1zvfZAv3LK6UKMWhmD/dk
 G0vTM/Zm3/ACuWpBxI7upQaxo+mH8/sqf3Qdt9fiPTXWOVUGCaAZq6OMAIrIkMF6G3OF
 N1Z3s4RwWUhE8SIuXwsbrNVzvUZPOH9ejswSMchMANfBDXDFBoDhce4spCC9h5Aio8BO
 A5K+LYy3G9Y+PF5hKbIt7MRv/fdieKgcQX6GbHlJmi1TyqmCHYHH7uzU/S8VsfqNBHyg
 YGcg==
X-Gm-Message-State: AOJu0Yym9LUM3OVS/4Vz8pXmTe3r4fWLwaQ9wNku5fb0KH3FrWrODbwU
 5Vi97HKA1UU21PVlonlxGS8gfHsEwI6C1FKCUWj4lS/kQf1k9ou0HVd20VFTHRSxXP350UoCXrh
 FbCcJrECH+wvr63xG6/W6+YbxS6FaeCx4/yh+
X-Gm-Gg: ASbGncuLFszGz6veFA2doBF+yxR4jfXmMaAqc7j7bW6c+NlYExqLRB8O355ONeh7dCQ
 FGCnFxtimHHE7irL/7y2y6+24UIrRF6J9xDgC
X-Google-Smtp-Source: AGHT+IEXZJJ3Wo0ncyYD2c1WcglSlPC40A4AmlwSxBKZVwe2q6PBreFqCzaPqgmcc0Tvh0ckCs3avy7vsThzy5jtvJg=
X-Received: by 2002:a17:907:3a98:b0:aa6:53f2:b37 with SMTP id
 a640c23a62f3a-aa6b11dd522mr310583666b.32.1733937756192; Wed, 11 Dec 2024
 09:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-6-sjg@chromium.org>
 <20241209190202.GU2457179@bill-the-cat>
 <CAFLszTgqahZeBccxEt+DUGy2CivC3ed-v8Dd1qR8SZ2mfyRoow@mail.gmail.com>
 <20241209203325.GX2457179@bill-the-cat>
In-Reply-To: <20241209203325.GX2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 10:22:24 -0700
Message-ID: <CAFLszTgJ0kRkBOCpa9YbMdMQ+yL2bKfKXTm54vLHKHX-AV2feA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rpi: Use the U-Boot control FDT for fdt_addr
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>, 
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Hi Tom,

On Mon, 9 Dec 2024 at 13:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 09, 2024 at 12:27:18PM -0700, Simon Glass wrote:
> > HI Tom,
> >
> > On Mon, 9 Dec 2024 at 12:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 11:20:01AM -0700, Simon Glass wrote:
> > >
> > > > The fdt_addr variable is used in extlinux as a fallback devicetree if
> > > > none is provided by the boot command.
> > > >
> > > > The existing mechanism uses the devicetree provided to U-Boot, but in
> > > > its original, unrelocated position. For the rpi_4 I am using, this is
> > > > at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> > > > is large.
> > > >
> > > > U-Boot already deals with this sort of problem by relocating the FDT
> > > > to a safe address.
> > > >
> > > > So use the control-FDT address instead.
> > > >
> > > > Remove the existing comment, which is confusing, since the FDT is not
> > > > actually passed unmodified to the kernel: U-Boot adds various things
> > > > using its FDT-fixup mechanism.
> > > >
> > > > Note that board_get_usable_ram_top() reduces the RAM top for boards with
> > > > less RAM. This behaviour is left unchanged as there is no other
> > > > mechanism for U-Boot to handle this.
> > > >
> > > > In version 2, it incorporates some changes to fdt_addr, etc. suggested
> > > > by Tom, as well as adding myself as a maintainer.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Drop patch to allow expanding the devicetree during relocation
> > > >
> > > >  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
> > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > > > index 9122f33d88d..8f6ab1b1b9b 100644
> > > > --- a/board/raspberrypi/rpi/rpi.c
> > > > +++ b/board/raspberrypi/rpi/rpi.c
> > > > @@ -3,6 +3,8 @@
> > > >   * (C) Copyright 2012-2016 Stephen Warren
> > > >   */
> > > >
> > > > +#define LOG_CATEGORY LOGC_BOARD
> > > > +
> > > >  #include <config.h>
> > > >  #include <dm.h>
> > > >  #include <env.h>
> > > > @@ -325,19 +327,10 @@ static void set_fdtfile(void)
> > > >       env_set("fdtfile", fdtfile);
> > > >  }
> > > >
> > > > -/*
> > > > - * If the firmware provided a valid FDT at boot time, let's expose it in
> > > > - * ${fdt_addr} so it may be passed unmodified to the kernel.
> > > > - */
> > > > +/* Allow U-Boot to use its control FDT with extlinux if one is not provided */
> > > >  static void set_fdt_addr(void)
> > > >  {
> > > > -     if (env_get("fdt_addr"))
> > > > -             return;
> > > > -
> > > > -     if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
> > > > -             return;
> > > > -
> > > > -     env_set_hex("fdt_addr", fw_dtb_pointer);
> > > > +     env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
> > > >  }
> > > >
> > > >  /*
> > > > @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> > > >  {
> > > >       int node;
> > > >
> > > > -     update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> > > > +     if (blob == gd->fdt_blob)
> > > > +             log_debug("Same FDT: nothing to do\n");
> > > > +     else
> > > > +             update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> > > >
> > > >       node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
> > > >       if (node < 0)
> > >
> > > Have you tested this to make sure that assorted overlays specified in
> > > config.txt are still passed on correctly to the kernel? Or do we end up
> > > being OK here due to board_fdt_blob_setup() meaning that we set
> > > gd->fdt_blob to fw_dtb_pointer much earlier on, and that hook simply
> > > didn't exist back in 2016 when commit
> > > ade243a211d6 ("rpi: passthrough of the firmware provided FDT blob")
> > > introduced some of what you're removing here?
> >
> > No I have not tested what happens with overlays, but I believe they
> > are handled by the pre-U-Boot firmware. U-Boot certainly doesn't look
> > at the config.txt file.
>
> Yes, they're handled by being applied to the device tree we're passed by
> the previous stage and stored in fw_dtb_pointer. So checking that the
> device tree has the expected overlay applied is something that needs
> doing before this can be applied.

Just so I understand this request, the checks are:

1. That adding/removing an overlay in config.txt is reflected in the
devicetree seen by U-Boot
2. That U-Boot then passes that DT to Linux?

If I add this line:

dtoverlay=disable-bt

then Linux boots with serial output (I have enable_uart=1 in there as well)

If I remove the dtoverlay, it does not have serial output. So yes,
this seems to be working fine.


For the record, the flow (within U-Boot, with this series) is:

a. fw_dtb_pointer is set in lowlevel.S
b. board_fdt_blob_setup() is called to set gd->fdt_blob to that value
c. during relocation, U-Boot copies the devicetree to the top of
memory, setting gd->fdt_blob to the new value
d. during loading, U-Boot creates a copy of the gd->fdt_blob
devicetree and sets working_fdt to it*
e. U-Boot applies fix-ups to working_fdt

* fdt_high is unset and there is no devicetree packaged with the OS

Regards,
Simon
