Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025CCE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFFD88E32;
	Mon,  9 Dec 2024 20:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FiBLQVG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8387E89786; Mon,  9 Dec 2024 20:27:33 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71CF188A43
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so858995066b.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733772451; x=1734377251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dpqSz3jqCaHG/GlnuQN0/AMRlEPfgTkDggcRVikiLQE=;
 b=FiBLQVG2RaPheRzspO52QoSHG8peiwhzU7fOJTRurVB95WGhNynxQdNKVhMlihrKN5
 B23pvMKLbp2tGhBpeTdC0nt4fpQLHGJMFGAhKMc4bPM3Tob3WCKotbILPAjLL9fKXSkP
 IyBjmZZMNcTsgHfws5wSVjusMJNnpPrlE+Vnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733772451; x=1734377251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dpqSz3jqCaHG/GlnuQN0/AMRlEPfgTkDggcRVikiLQE=;
 b=qFk0P0ud+naaE75fIHnHiZg6Pti0E109irZz9rDbAn6U88dxgQgONancqRHal2diFW
 8E0DGRzVS3gV3GPlbgxKyPwx+xgcvrmuSOl7vDyvwJvaKshbfR0PimXAEGFtxJjjlsU5
 MneHbIJMhvZmfh0lXe3BxKnVx4988r29xx0qjV+jAS0R8nqfx3det9B5zOEtfyc7Op20
 20VtzgMMVPIjD/BX3gJiw+GJv2h3k3I6No5SJ27Oc74zSgT8iKOLKMkZ7FGgjC+mKa+K
 A77/S54kqmXCQQWHQJxqqOYQpkHd3jBA23tihneBxJpXhWX9UuYBV6zsdpKNKyxU5QZa
 0csg==
X-Gm-Message-State: AOJu0YwQQLofUlKoCTPat2U370YjXXWulULZ5gfnIEluLulwB2hw988Y
 k7g8KYZBZsv6+w99lhOpKSUehJ3g5MFHo8vMRSXqyIbLOlxVmQA8lNioCHBh3ZQc9y4740gsujO
 V/H6WTh1+eo5rXflPRlBgMT0UDvUnreuk9INO
X-Gm-Gg: ASbGncs2bhm5GqK9U0/MDjiokg67KpTl9w9N1V0WdHwh8k3EP8CBTvbPOG8LI7d2kuc
 YtxOTVVly49mVnlPyilLvVAYJ2+eMuTNPcns9
X-Google-Smtp-Source: AGHT+IHtPortlF4JWSzOL9xf8Qep3sh+fqUGE+Xt8/AeKwoxl09E8Nr/PPnjT+dZ75lYMA6fk3zshRYucStU6sL/Om8=
X-Received: by 2002:a17:907:c26:b0:aa6:1afe:b0a5 with SMTP id
 a640c23a62f3a-aa69ffdad93mr54316266b.2.1733772450851; Mon, 09 Dec 2024
 11:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-6-sjg@chromium.org>
 <20241209190202.GU2457179@bill-the-cat>
In-Reply-To: <20241209190202.GU2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 12:27:18 -0700
Message-ID: <CAFLszTgqahZeBccxEt+DUGy2CivC3ed-v8Dd1qR8SZ2mfyRoow@mail.gmail.com>
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

HI Tom,

On Mon, 9 Dec 2024 at 12:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 09, 2024 at 11:20:01AM -0700, Simon Glass wrote:
>
> > The fdt_addr variable is used in extlinux as a fallback devicetree if
> > none is provided by the boot command.
> >
> > The existing mechanism uses the devicetree provided to U-Boot, but in
> > its original, unrelocated position. For the rpi_4 I am using, this is
> > at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> > is large.
> >
> > U-Boot already deals with this sort of problem by relocating the FDT
> > to a safe address.
> >
> > So use the control-FDT address instead.
> >
> > Remove the existing comment, which is confusing, since the FDT is not
> > actually passed unmodified to the kernel: U-Boot adds various things
> > using its FDT-fixup mechanism.
> >
> > Note that board_get_usable_ram_top() reduces the RAM top for boards with
> > less RAM. This behaviour is left unchanged as there is no other
> > mechanism for U-Boot to handle this.
> >
> > In version 2, it incorporates some changes to fdt_addr, etc. suggested
> > by Tom, as well as adding myself as a maintainer.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Drop patch to allow expanding the devicetree during relocation
> >
> >  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index 9122f33d88d..8f6ab1b1b9b 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -3,6 +3,8 @@
> >   * (C) Copyright 2012-2016 Stephen Warren
> >   */
> >
> > +#define LOG_CATEGORY LOGC_BOARD
> > +
> >  #include <config.h>
> >  #include <dm.h>
> >  #include <env.h>
> > @@ -325,19 +327,10 @@ static void set_fdtfile(void)
> >       env_set("fdtfile", fdtfile);
> >  }
> >
> > -/*
> > - * If the firmware provided a valid FDT at boot time, let's expose it in
> > - * ${fdt_addr} so it may be passed unmodified to the kernel.
> > - */
> > +/* Allow U-Boot to use its control FDT with extlinux if one is not provided */
> >  static void set_fdt_addr(void)
> >  {
> > -     if (env_get("fdt_addr"))
> > -             return;
> > -
> > -     if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
> > -             return;
> > -
> > -     env_set_hex("fdt_addr", fw_dtb_pointer);
> > +     env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
> >  }
> >
> >  /*
> > @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> >  {
> >       int node;
> >
> > -     update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> > +     if (blob == gd->fdt_blob)
> > +             log_debug("Same FDT: nothing to do\n");
> > +     else
> > +             update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> >
> >       node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
> >       if (node < 0)
>
> Have you tested this to make sure that assorted overlays specified in
> config.txt are still passed on correctly to the kernel? Or do we end up
> being OK here due to board_fdt_blob_setup() meaning that we set
> gd->fdt_blob to fw_dtb_pointer much earlier on, and that hook simply
> didn't exist back in 2016 when commit
> ade243a211d6 ("rpi: passthrough of the firmware provided FDT blob")
> introduced some of what you're removing here?

No I have not tested what happens with overlays, but I believe they
are handled by the pre-U-Boot firmware. U-Boot certainly doesn't look
at the config.txt file.

Regards,
Simon
