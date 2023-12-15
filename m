Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D78CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 08:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320D28767B;
	Fri, 15 Dec 2023 09:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="qrPd6nsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97EF787AE6; Fri, 15 Dec 2023 09:15:11 +0100 (CET)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A40875B9
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1702628106; x=1734164106;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=P5Z4sUT/PmplV6OVEMlRleAiLKtwoYX7IQpaFkcv57g=;
 b=qrPd6nsxSHP3UthV7QwTznJJAry2LPhZvu4TvLBt+UqlRMTxxoyfKeTV
 aXa40HGkYpNBP6yzbSz3WNs8oBKfHzeH3Z3YkboIGdj/vzpjPcVWrWxd7
 /Z2ggL21fQSmTe+gauUk2hzuCzgTsuYhP/wJsgQoEgDRRpMtKLndqdpwk
 KkNmI0MCCpBP5xA+wZvOVBI7Bj/MVLUSPGoxThXESw/Xav6Z2n5tP0H2D
 Z2MXNbz4vWC6ZUcHiNm7Lz9Bv7NEUyaxLWJltKd/2aSRZqK3sv0kUAV7z
 WWC4AcbYUj8fNGfFsum9mfjNXnJcUNj1Jxjd7wugLToqvRrnx+OGYZx2B g==;
X-IronPort-AV: E=Sophos;i="6.04,278,1695679200"; d="scan'208";a="34525002"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 15 Dec 2023 09:15:06 +0100
Received: from [192.168.2.128] (SCHIFFERM-M2.tq-net.de [10.121.53.15])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 21F20280075;
 Fri, 15 Dec 2023 09:15:06 +0100 (CET)
Message-ID: <36da0b3bf24834e08759a5fbdc5ebfea27a61fb6.camel@ew.tq-group.com>
Subject: Re: [PATCH] boot: add support for fdt_fixup command in environment
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>
Date: Fri, 15 Dec 2023 09:15:06 +0100
In-Reply-To: <CAPnjgZ1iF6k8Dv+nk7p7Jq-+jqfOGXYUtFTyMSThN28bM=e3zQ@mail.gmail.com>
References: <20231211110317.697011-1-matthias.schiffer@ew.tq-group.com>
 <CAPnjgZ1iF6k8Dv+nk7p7Jq-+jqfOGXYUtFTyMSThN28bM=e3zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
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

On Wed, 2023-12-13 at 19:52 +0000, Simon Glass wrote:
> ********************
> Achtung externe E-Mail: =C3=96ffnen Sie Anh=C3=A4nge und Links nur, wenn =
Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher sind. L=
eiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung an den IT-Helpdesk we=
iter.
> Attention external email: Open attachments and links only if you know tha=
t they are from a secure source and are safe. In doubt forward the email to=
 the IT-Helpdesk to check it.
> ********************
>=20
> On Mon, 11 Dec 2023 at 04:04, Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> >=20
> > The "fdt" command is convenient for making small changes to the OS FDT,
> > especially during development. This is easy when the kernel and FDT are
> > loaded separately, but can be cumbersome for FIT images, requiring to
> > unpack the image, manually apply overlays, etc.
> >=20
> > Add an option to execute a command "fdt_fixup" from the environment at
> > the beginning of image_setup_libfdt() (after overlays are applied, and
> > before the other fixups).
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  boot/Kconfig     |  9 +++++++++
> >  boot/image-fdt.c | 19 +++++++++++++++++--
> >  2 files changed, 26 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> How about a test?

Makes sense, I'll add a unit test.


>=20
>=20
> >=20
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index ef71883a502..7eea935f490 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -1502,6 +1502,15 @@ if OF_LIBFDT
> >=20
> >  menu "Devicetree fixup"
> >=20
> > +config OF_ENV_SETUP
> > +       bool "Run a command from environment to set up device tree befo=
re boot"
> > +       depends on CMD_FDT
> > +       help
> > +         This causes U-Boot to run a command from the environment vari=
able
> > +         fdt_fixup before booting into the operating system, which can=
 use the
> > +         fdt command to modify the device tree. The device tree is the=
n passed
> > +         to the OS.
> > +
> >  config OF_BOARD_SETUP
> >         bool "Set up board-specific details in device tree before boot"
> >         help
> > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > index f10200f6474..78b5c639381 100644
> > --- a/boot/image-fdt.c
> > +++ b/boot/image-fdt.c
> > @@ -9,6 +9,7 @@
> >   */
> >=20
> >  #include <common.h>
> > +#include <command.h>
> >  #include <fdt_support.h>
> >  #include <fdtdec.h>
> >  #include <env.h>
> > @@ -608,8 +609,22 @@ int image_setup_libfdt(struct bootm_headers *image=
s, void *blob,
> >  {
> >         ulong *initrd_start =3D &images->initrd_start;
> >         ulong *initrd_end =3D &images->initrd_end;
> > -       int ret =3D -EPERM;
> > -       int fdt_ret;
> > +       int ret, fdt_ret;
> > +
> > +       if (IS_ENABLED(CONFIG_OF_ENV_SETUP)) {
> > +               const char *fdt_fixup;
> > +
> > +               fdt_fixup =3D env_get("fdt_fixup");
> > +               if (fdt_fixup) {
> > +                       set_working_fdt_addr(map_to_sysmem(blob));
>=20
> Is that not already done?

Not necessarily in all code paths that lead to image_setup_libfdt().


>=20
> > +                       ret =3D run_command_list(fdt_fixup, -1, 0);
> > +                       if (ret)
> > +                               printf("WARNING: fdt_fixup command retu=
rned %d\n",
> > +                                      ret);
> > +               }
>=20
> Would it make sense to put this code near the end of the function,
> after other fixups have been done?

With separate image and FDT, one would usually run the fdt command to modif=
y the FDT before bootm,
so the modifications also happen before other fixups. My intention was to g=
et the same behavior for
FIT images.

I don't care much either way though, for most fixups the order shouldn't ma=
tter too much, and we can
always add an fdt_fixup_early or fdt_fixup_late if an actual usecase for su=
ch a sequence of fixups
comes up.

Regards,
Matthias


>=20
> > +       }
> > +
> > +       ret =3D -EPERM;
> >=20
> >         if (fdt_root(blob) < 0) {
> >                 printf("ERROR: root node setup failed\n");
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/
> >=20
>=20
> Regards,
> Simon
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
