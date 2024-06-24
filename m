Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEDEC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 15:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D0F882B8;
	Mon, 24 Jun 2024 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="OqLmuzFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28C4882B8; Mon, 24 Jun 2024 17:48:04 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C7E8831F
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 17:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so541708066b.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719244080; x=1719848880; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUWhlX4pU9k16kWSpqHc+NY7UAGYcnj1oPXetnLgeDA=;
 b=OqLmuzFQJKrVooriqgPkxAfMUQujWgcM9XhE/oQ0S5ZxDDtJfFZJMru04A7qfKDl1D
 yiyfot0d3zSVT/l3aAZLg7gK4yEO5W0/DvODDEA+uWet0rz7CBqjU/T+s6oQ869hU66f
 ikciWvQq20OPQ/NY5wcb1kuRnMDFgYUK+89/ISXxJxap0TPxodSH4o8PqIKIOQKgxVpr
 eKfLdQ3mcnHtuuv3YLDMT+kvYoC3wSL4AB7Zi8dC5tBiUthUxXWTkMlxOQ5wM2Y/d7/w
 gsgoS2wjQLzqTX36uQ1gnBfNGX3I1G9CyiEEfZ8Jti4XIcI92ZZmTDuZoasXVUY9bkEZ
 u2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719244080; x=1719848880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUWhlX4pU9k16kWSpqHc+NY7UAGYcnj1oPXetnLgeDA=;
 b=S+1gcygcWJodgoaxcfSVk+inGyj63ggW7OwFBvepgXfZmR+M3BUD2i1jLsLwpHxqSo
 cqpNkOKbm1Sv3r3FfFwemuHap7i5FXPrFyMRpkeBv8lV2taCn4SLo44b+bES1R4aoCzJ
 Ablk2D1L/LSnzJaVZuuduxtuLNil4Eqy0yA4WDRmW8pHBewGAMfmGBY46QUuKs5wu8JJ
 YfHHtGxqQouC94ifsFY/EolpBZB2CdO7x9PqJq5OT29FHUln2pSn5nErHqGcap6+OuPj
 ecprayLx5cKM9BfngpcY+CrPPS0H8qgGXnoO90qZMl+FrZKU449AcknbxhlwQtSQEqbF
 23cg==
X-Gm-Message-State: AOJu0YwgkC3ORdxk6+Xht1HmP7YbwM4d2tn9miP/a76YB15tcfDBwp/r
 3dBoKzmnCzuLFxZ988hH8RIkazwP4oPKY49CktpSWlBuT6yxpUniO32kZDMM78i8XualJGW8PYm
 pUwh8lPpmhsOCXWgz/hrZgRfjPCVkUI3rz4M35w==
X-Google-Smtp-Source: AGHT+IHTBgDxMWa4XCp6RncMxW3LHVnCuKAqPu5a7LWnBp7uzs4htGaTgg7vYcXjoZ+uGtq5SYeu6l7WSUi6BRglTvQ=
X-Received: by 2002:a17:906:454:b0:a6f:1443:1e24 with SMTP id
 a640c23a62f3a-a7242c48cf9mr385202466b.34.1719244079542; Mon, 24 Jun 2024
 08:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240618210609.1744727-1-tharvey@gateworks.com>
 <20240618210609.1744727-2-tharvey@gateworks.com>
 <7c12b0ac-5785-4199-9faf-5661b8809137@linaro.org>
In-Reply-To: <7c12b0ac-5785-4199-9faf-5661b8809137@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 24 Jun 2024 08:47:47 -0700
Message-ID: <CAJ+vNU2LN9PTbEanEbHGgHG6qGL2jV8fDy8K-1W9Am1VbPyOsA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] Add fdt_kaslrseed function to add kaslr-seed to
 chosen node
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 20, 2024 at 6:58=E2=80=AFAM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Hi Tim,
>
> On 18/06/2024 23:06, Tim Harvey wrote:
> > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > randomize the virtual address at which the kernel image is loaded, it
> > expects entropy to be provided by the bootloader by populating
> > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> >
> > Add a fdt_kaslrseed function to accommodate this allowing an existing
> > node to be overwritten if present. For now use the first rng device
> > but it would be good to enhance this in the future to allow some sort
> > of selection or policy in choosing the rng device used.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Cc: Michal Simek <michal.simek@amd.com>
> > Cc: Andy Yan <andy.yan@rock-chips.com>
> > Cc: Akash Gajjar <gajjar04akash@gmail.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > Cc: Devarsh Thakkar <devarsht@ti.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Chris Morgan <macromorgan@hotmail.com>
> > ---
> > v6:
> >   - collected tags
> > v5:
> >   - move function to boot/fdt_support.c
> >   - remove ability to select rng index and note in the commit log
> >     something like this as a future enhancement.
> >   - fixed typo in commit message s/it's/its/
> >   - use cmd_process_error per Michal's suggestion
> > v4:
> >   - add missing /n to notice in kaslrseed cmd
> >   - combine ints in declaration
> >   - remove unused vars from board/xilinx/common/board.c ft_board_setup
> > v3:
> >   - skip if CONFIG_MEASURED_BOOT
> >   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
> >   - pass in rng index and bool to specify overwrite
> >   - remove duplicate error strings printed outside of fdt_kaslrseed
> >   - added note to commit log about how EFI STUB weeds out kalsr-seed
> > v2:
> >   - fix typo in commit msg
> >   - use stack for seed to avoid unecessary malloc/free
> >   - move to a library function and deduplicate code by using it
> >     elsewhere
> > ---
> >   boot/fdt_support.c    | 44 ++++++++++++++++++++++++++++++++++++++++++=
+
> >   include/fdt_support.h | 10 ++++++++++
> >   2 files changed, 54 insertions(+)
> >
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 2bd80a9dfb18..b1b2679dea0c 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -7,12 +7,15 @@
> >    */
> >
> >   #include <common.h>
> > +#include <dm.h>
> >   #include <abuf.h>
> >   #include <env.h>
> >   #include <log.h>
> >   #include <mapmem.h>
> >   #include <net.h>
> > +#include <rng.h>
> >   #include <stdio_dev.h>
> > +#include <dm/device_compat.h>
> >   #include <dm/ofnode.h>
> >   #include <linux/ctype.h>
> >   #include <linux/types.h>
> > @@ -274,6 +277,47 @@ int fdt_initrd(void *fdt, ulong initrd_start, ulon=
g initrd_end)
> >       return 0;
> >   }
> >
> > +int fdt_kaslrseed(void *fdt, bool overwrite)
> > +{
> > +     int len, err, nodeoffset;
> > +     struct udevice *dev;
> > +     const u64 *orig;
> > +     u64 data =3D 0;
> > +
> > +     err =3D fdt_check_header(fdt);
> > +     if (err < 0)
> > +             return err;
>
> All the paths that call fdt_kaslrseed() call fdt_check_header()
> beforehand, I think it's safe to drop this.

Hi Caleb,

The do_kaslr_seed path does not check for this and instead passes
working_fdt - perhaps your point is still valid if working_fdt is
guaranteed to always be a valid fdt?

> > +
> > +     /* find or create "/chosen" node. */
> > +     nodeoffset =3D fdt_find_or_add_subnode(fdt, 0, "chosen");
> > +     if (nodeoffset < 0)
> > +             return nodeoffset;
>
> Arguably, this shouldn't be the responsibility of this function, maybe
> it would be better to error our here?

I'm not sure what your point is here... it is erroring out.

Best Regards,

Tim

> > +
> > +     /* return without error if we are not overwriting and existing no=
n-zero node */
> > +     orig =3D fdt_getprop(fdt, nodeoffset, "kaslr-seed", &len);
> > +     if (orig && len =3D=3D sizeof(*orig))
> > +             data =3D fdt64_to_cpu(*orig);
> > +     if (data && !overwrite) {
> > +             debug("not overwriting existing kaslr-seed\n");
> > +             return 0;
> > +     }
> > +     err =3D uclass_get_device(UCLASS_RNG, 0, &dev);
> > +     if (err) {
> > +             printf("No RNG device\n");
> > +             return err;
> > +     }
> > +     err =3D dm_rng_read(dev, &data, sizeof(data));
> > +     if (err) {
> > +             dev_err(dev, "dm_rng_read failed: %d\n", err);
> > +             return err;
> > +     }
> > +     err =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(=
data));
> > +     if (err < 0)
> > +             printf("WARNING: could not set kaslr-seed %s.\n", fdt_str=
error(err));
> > +
> > +     return err;
> > +}
> > +
> >   /**
> >    * board_fdt_chosen_bootargs - boards may override this function to u=
se
> >    *                             alternative kernel command line argume=
nts
> > diff --git a/include/fdt_support.h b/include/fdt_support.h
> > index 4b71b8948d99..741e2360c224 100644
> > --- a/include/fdt_support.h
> > +++ b/include/fdt_support.h
> > @@ -463,4 +463,14 @@ void fdt_fixup_board_enet(void *blob);
> >   #ifdef CONFIG_CMD_PSTORE
> >   void fdt_fixup_pstore(void *blob);
> >   #endif
> > +
> > +/**
> > + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> > + *
> > + * @blob:    fdt blob
> > + * @overwrite:       do not overwrite existing non-zero node unless tr=
ue
> > + * Return:   0 if OK, -ve on error
> > + */
> > +int fdt_kaslrseed(void *blob, bool overwrite);
> > +
> >   #endif /* ifndef __FDT_SUPPORT_H */
>
> --
> // Caleb (they/them)
