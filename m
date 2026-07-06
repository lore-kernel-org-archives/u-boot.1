Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746CBC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 19:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79186846FD;
	Mon,  6 Jul 2026 21:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aPC5BWBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545CB84852; Mon,  6 Jul 2026 21:43:26 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A24846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 21:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5bd95de6865so1378458e0c.0
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 12:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783367003; cv=none;
 d=google.com; s=arc-20260327;
 b=cb6LA3ejxFFh5wgjvnxMkvWpvLJojals4H+RkhKtbtr1j3vOOeD7P/OZ/fsb6aNW24
 OvP/Bh9QnPJIC2UR91D5rD8Vl9ibshj5eXkD7Qk1iBVq3bhQ6MvhppvxaDZ1X4QFLJQb
 0QXWjbvtSGMN1w2hmsWXYlPXCpHTMymZ5zQmMMRDw8nSskvC5M2s8AmcBhBsa6t1lF9w
 TtSXbTbY+nQ8EuOMk5pllauihXU23iCoiilfmLZCIn0VroEjmxSwZ5E1sTALmnT79Or7
 xZ+t+FHfSVGiPovLbnT25wpizjYbAyCf0sQaB7AAtpuXS0Yacw7iUZac2VhfGPiawa7v
 rOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wJr7tOnmv5o623WIDdPGLjJkR3IsIIEWnBoPNyOWxFE=;
 fh=5N1WtHFlGlqAtpOKocoBc9rshZ+zvdEVoFifWCfmkJM=;
 b=W+Wcho1ZCSHcFTEvNe9EFwEmRd7MMyGy37jGFdgrcbu56wC8j8mJ2t5Uyh7au8Iney
 BbcW6LZRAJoNVcjFhhM/sX4PbocvfluOkTVS0GFSm3XT3of4CfOiOnJKqk194zNHkTPl
 /WUw0+7cYepfPdcjXVm+kHRaqG+go7owfOTV3JlwK4lEXUSBwSGG1sHL8FIIz3n4iYtx
 09YNpxBokQC8v4SYawdJhpkPPGc15FpoCXmrw+UiKtXXq/VuO8lI2bxUfE2aQDeHwEj6
 uFj4X8sWSxsru3RO1ty0I6zvh1Gbpa79XQY2+mvnORByJHLaEbg+18WrLdNhE6nPCbVW
 e8hA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783367003; x=1783971803; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJr7tOnmv5o623WIDdPGLjJkR3IsIIEWnBoPNyOWxFE=;
 b=aPC5BWBH4zeRLlTx/iq2Zgw7aWoj9b1aISfwn5/nuv1R4N4WV+HYNvj50ap4KqcKKR
 x9x4lAVu+ZPWgYi3CXO6UoVrWdNNVq1hT/Wf+Oxga+WWlDzSDd7JlKjlGbrG6RvsmG7O
 nGC/qG0haebiAumL2FVxwifQFcj4AyU1I739bSYi5axdLuLdLyLf3gOWU4t2nuGvhuC6
 9SBQH9LEONBqPApB3FoxypSJsJCYWkMoTkA/xjUFSrmvIeQGH4dGmy9KheIDFHlzkxrR
 gS/hoJRoK29VfZQYZU2ExVxZjQXDx+R3Dpnu6GrXS4zJQHyLahRwWlaqhlJUhjxHXmIA
 yL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783367003; x=1783971803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJr7tOnmv5o623WIDdPGLjJkR3IsIIEWnBoPNyOWxFE=;
 b=mUpoFYdh2VaSZXtSog22JM7+MhpiQVgXoZRX9ugrQu5dizBZmLUTKoGaMuttJJ0dS+
 UTTYq+66OIjpkdbz2F2LrpwIa3ninIV7TmNRgOFWlyQq4DszVqK2xI4YmshPNEAMSeXe
 ip3U4+TneMf2mIWWgFVq415y/U/T01zZNp+QNYpitV5/NFVtNKoJrPoOoCEnqYk1EvMj
 geqgn/IT2xB2jdabJ7ZUSDADK9yLfLafQo279kP8eTLGswoWzzGRbTjn9SXHAX6TeIFf
 RKZ5R4CU3PTvNf6Uc+1ESNKhg6S8Qo6UgI0PXUeWhayKsTE7lePURtusAvGwYEnNvAeK
 4BHw==
X-Gm-Message-State: AOJu0Yy4Zpppmks5cp2LyPogloYvE2TlgqaZ2S4RP0u42MO36EUTdrYT
 PKHjPuF5/Gk/rutrI6VRmjV97pl9zVWEa+YqQJGjpAZ4k1IvsrDMZGk6PIn4rZaZ9TF0sG34scn
 rVB4KxTtxGj3QmHAkZ14+CZNVQxU1D4Q=
X-Gm-Gg: AfdE7cm7oT4C2j+bhTDANquN+aNS9VZ6ZC76TLoFNoVbqcXr7wBIT+C/uwvDXk6tfp6
 iOuceXzMKoTp1iwI2/zB/5DqIMYiNOWLX1MX5Zl5AmPd4oSXEE9FPDRWh/4K5G7T3yjJixdJQNV
 G8KEFVghlTS8D2FlIwHbtTSeN/HFOOziSK4I96KjmbfX1zJitQoGcpv9q8pl1PUaO2+lLI0RGt3
 i/4phFbGAzGhzZqAncuDWC4bZScCMSkodJUArRZXKuGa1P5ooJV++D5ZLs/bZsx1lAT4paw73qz
 KEBx8I0lhcB29MhH0mj+won1YeJqTuKtQdenxIZ7bjJv9zZ2KxvgqYImg+sfFwIlT4h7FymhFVP
 c0agIyoALFkiDRQO0dZaRLQ==
X-Received: by 2002:a05:6122:6591:b0:56f:6cc0:681e with SMTP id
 71dfb90a1353d-5be8974062dmr1064939e0c.1.1783367002559; Mon, 06 Jul 2026
 12:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260703213308.3804461-1-james.hilliard1@gmail.com>
 <f9a77b79-d47c-4853-93f4-4e346a489d72@cherry.de>
In-Reply-To: <f9a77b79-d47c-4853-93f4-4e346a489d72@cherry.de>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 6 Jul 2026 13:43:10 -0600
X-Gm-Features: AVVi8Cds_hAv-bVKYnAQ_T8UNH77Q3xgZ4MMaKd7yNwsIjLXLZ5KomHl01lENS0
Message-ID: <CADvTj4rEGkEJAgdMeFPxTRbsR_AcaGFqv8Tv1VYBY7r=0gSw-w@mail.gmail.com>
Subject: Re: [PATCH] tools: binman: add build key directory option
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, 
 Yannic Moog <y.moog@phytec.de>, Aristo Chen <jj251510319013@gmail.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
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

On Mon, Jul 6, 2026 at 2:51=E2=80=AFAM Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
>
> Hi James,
>
> On 7/3/26 11:33 PM, James Hilliard wrote:
> > U-Boot's Makefile passes KEYDIR to direct mkimage invocations, but
> > internal binman builds only received the generic BINMAN_INDIRS search
> > path. FIT entries with fit,sign or fit,encrypt therefore had to infer
> > the key directory from include directories before invoking mkimage -k.
> >
>
> You don't explain why that is an issue? Simply add KEYDIR to BINMAN_INDIR=
S?

I think for consistency it's better to separate KEYDIR since adding
KEYDIR to BINMAN_INDIRS doesn't actually mean KEYDIR will
be the KEYDIR that gets passed to mkimage due to BINMAN_INDIRS
only acting as a searchpath for keys.

IMO if KEYDIR has been explicitly passed then no other directories
should be searched for keys.

>
> > Add a binman build -k/--keydir option and pass KEYDIR through with
> > that option from the top-level Makefile. FIT entries prefer this key
> > directory over include-dir discovery and then pass it to mkimage -k.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >   Makefile                  |  1 +
> >   tools/binman/binman.rst   | 10 +++++++-
> >   tools/binman/cmdline.py   |  2 ++
> >   tools/binman/control.py   |  1 +
> >   tools/binman/etype/fit.py | 24 +++++++++++-------
> >   tools/binman/ftest.py     | 51 ++++++++++++++++++++++++++++++++++++--=
-
> >   tools/binman/state.py     | 21 ++++++++++++++++
> >   7 files changed, 97 insertions(+), 13 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index d8287323c43..27be2a81e83 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1689,6 +1689,7 @@ cmd_binman =3D $(srctree)/tools/binman/binman $(i=
f $(BINMAN_DEBUG),-D) \
> >               -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=3D$(of_li=
st) \
> >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > +             $(if $(KEYDIR),-k $(KEYDIR)) \
> >               -a atf-bl1-path=3D${BL1} \
> >               -a atf-bl31-path=3D${BL31} \
> >               -a tee-os-path=3D${TEE} \
> > diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> > index 366491089ad..8770b279ff8 100644
> > --- a/tools/binman/binman.rst
> > +++ b/tools/binman/binman.rst
> > @@ -1711,7 +1711,7 @@ Usage::
> >
> >       binman build [-h] [-a ENTRY_ARG] [-b BOARD] [-d DT] [--fake-dtb]
> >           [--fake-ext-blobs] [--force-missing-bintools FORCE_MISSING_BI=
NTOOLS]
> > -        [-i IMAGE] [-I INDIR] [-m] [-M] [-n] [-O OUTDIR] [-p] [-u]
> > +        [-i IMAGE] [-I INDIR] [-k KEYDIR] [-m] [-M] [-n] [-O OUTDIR] [=
-p] [-u]
> >           [--update-fdt-in-elf UPDATE_FDT_IN_ELF] [-W]
> >
> >   Options:
> > @@ -1738,6 +1738,9 @@ Options:
> >       Add a path to the list of directories to use for input files. Thi=
s can be
> >       specified multiple times to add more than one path.
> >
> > +-k KEYDIR, --keydir KEYDIR
> > +    Directory containing keys for signing/encryption.
> > +
> >   -m, --map
> >       Output a map file for each image. See `Map files`_.
> >
> > @@ -2161,6 +2164,11 @@ BINMAN_INDIRS
> >       Sets the search path for input files used by binman by adding one=
 or more
> >       `-I` arguments. See :ref:`External blobs`.
> >
> > +KEYDIR
> > +    Sets the key directory passed to FIT entries by adding a `-k` argu=
ment.
> > +    FIT entries use this directory for mkimage's `-k` argument when `f=
it,sign`
> > +    or `fit,encrypt` is enabled.
> > +
> >   BINMAN_TOOLPATHS
> >       Sets the search path for external tool used by binman by adding o=
ne or more
> >       `--toolpath` arguments. See :ref:`External tools`.
> > diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
> > index 9632ec115e5..cd4d05dfb69 100644
> > --- a/tools/binman/cmdline.py
> > +++ b/tools/binman/cmdline.py
> > @@ -128,6 +128,8 @@ controlled by a description in the board device tre=
e.'''
> >               help=3D'Image filename to build (if not specified, build =
all)')
> >       build_parser.add_argument('-I', '--indir', action=3D'append',
> >               help=3D'Add a path to the list of directories to use for =
input files')
> > +    build_parser.add_argument('-k', '--keydir', type=3Dstr,
> > +            help=3D'Directory containing keys for signing/encryption')
> >       build_parser.add_argument('-m', '--map', action=3D'store_true',
> >           default=3DFalse, help=3D'Output a map file for each image')
> >       build_parser.add_argument('-M', '--allow-missing', action=3D'stor=
e_true',
> > diff --git a/tools/binman/control.py b/tools/binman/control.py
> > index 816f7c1eba2..84586d1baf1 100644
> > --- a/tools/binman/control.py
> > +++ b/tools/binman/control.py
> > @@ -923,6 +923,7 @@ def Binman(args):
> >               tools.set_input_dirs(args.indir)
> >               tools.prepare_output_dir(args.outdir, args.preserve)
> >               state.SetEntryArgs(args.entry_arg)
> > +            state.SetKeydir(args.keydir)
> >               state.SetThreads(args.threads)
> >
> >               images =3D PrepareImagesAndDtbs(dtb_fname, args.image,
> > diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> > index f28b1e6b4cb..404e33d3022 100644
> > --- a/tools/binman/etype/fit.py
> > +++ b/tools/binman/etype/fit.py
> > @@ -14,6 +14,7 @@ import os
> >   from binman.entry import Entry, EntryArg
> >   from binman.etype.section import Entry_section
> >   from binman import elf
> > +from binman import state
> >   from dtoc import fdt_util
> >   from dtoc.fdt import Fdt
> >   from u_boot_pylib import tools
> > @@ -105,18 +106,20 @@ class Entry_fit(Entry_section):
> >           fit,sign
> >               Enable signing FIT images via mkimage as described in
> >               verified-boot.rst.
> > -            If the property is found and fit,engine is not set, the pr=
ivate
> > -            keys path is detected among binman include directories and=
 passed to
> > -            mkimage via -k flag. All the keys required for signing FIT=
 must be
> > -            available at time of signing and must be located in single=
 include
> > -            directory.
> > +            If the property is found and fit,engine is not set, the ke=
y
> > +            directory passed with binman build -k is passed to mkimage=
 via the
> > +            -k flag. If no key directory is provided, the private keys=
 path is
> > +            detected among binman include directories. All the keys re=
quired for
> > +            signing FIT must be available at time of signing and must =
be
> > +            located in a single directory.
> >
> >           fit,encrypt
> >               Enable data encryption in FIT images via mkimage. If the =
property
> > -            is found, the keys path is detected among binman include
> > -            directories and passed to mkimage via  -k flag. All the ke=
ys
> > +            is found, the key directory passed with binman build -k is=
 passed
> > +            to mkimage via the -k flag. If no key directory is provide=
d, the
> > +            keys path is detected among binman include directories. Al=
l the keys
> >               required for encrypting the FIT must be available at the =
time of
> > -            encrypting and must be located in a single include directo=
ry.
> > +            encrypting and must be located in a single directory.
> >
> >               Incompatible with fit,engine.
> >
> > @@ -485,6 +488,8 @@ class Entry_fit(Entry_section):
> >                   includes 'generator' entries which are used to create=
 the FIT,
> >                   but should not be processed as real entries. This is =
set up once
> >                   we have the entries
> > +            _keydir (str): Key directory from the binman build -k opti=
on, if
> > +                provided
> >               _loadables (list of str): List of generated split-elf nod=
es, each
> >                   a node name
> >               _remove_props (list of str): Value of of-spl-remove-props=
 EntryArg,
> > @@ -500,6 +505,7 @@ class Entry_fit(Entry_section):
> >           self._fit_list_prop =3D None
> >           self._fit_default_dt =3D None
> >           self._priv_entries =3D {}
> > +        self._keydir =3D state.GetKeydir()
> >           self._loadables =3D []
> >           self._remove_props =3D []
> >           props =3D self.GetEntryArgsOrProps(
> > @@ -701,7 +707,7 @@ class Entry_fit(Entry_section):
> >               args.update({'engine': engine})
> >               # If no engine, keys must exist locally, find them
> >               if engine is None:
> > -                keydir =3D self._get_keys_dir(data)
> > +                keydir =3D self._keydir or self._get_keys_dir(data)
>
> Then we don't even check if the keys exist in _keydir anymore.

That was intentional since keydir here is designed to explicitly override
any directory autodetection logic. Missing keys will still result in errors
when mkimage is invoked which I think should be sufficient.

>
> Cheers,
> Quentin
