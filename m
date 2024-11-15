Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D38D6A25E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6371889348;
	Fri, 15 Nov 2024 15:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ekeer/mV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886CA89618; Fri, 15 Nov 2024 15:27:12 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC3108909F
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9ec86a67feso341328866b.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680829; x=1732285629; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f3KhCQlxxsBybPnJK9yT3hKZbo3dJwyuYC+wUwIPL48=;
 b=Ekeer/mVXyf82viUKeEbIdhzN0Kk2qXrr5EoAvR5eYaGtNN9jlivJ0qEt0+++l3VUY
 b00utKnshp8UoDT4f5KmMrtHSG16bIFBf62fePZueThwaH5B5/J/z8g48H7aHEdMAfa8
 i2EojWNKi6izo3ZWkM6U0TLMP9qXy3GABysxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680829; x=1732285629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f3KhCQlxxsBybPnJK9yT3hKZbo3dJwyuYC+wUwIPL48=;
 b=qfPMlNsk2/OnMcX1/7eLveb7Sm7ERc7l/PTLmVqytB287ubIotlaQI/RpBQsqg5UEs
 lk1wpCD5J1H6jNfu3v4CFhIVJ6V5GnmuydTq2b23e8eYlqqMd2begs0GgM62HohZpRiv
 l+BOcSbF0afHcwhKaTztW8JJj21WChvqCRphtPbOvk8nOoS9nC5aS2INprEw3sga8CpK
 jFedyB3fmtQHFCkUOHhWfQZc4EpVEC4j6WU9SuRhPI0zDM+czfG0TdMr5CjHu0XDG317
 bf4jiBWvv/6HL4iX7U12/+s/HGHH61pXQBcRUFcrb8enEFBSAqENrMuWvV7tJ4h4IDYT
 IhkA==
X-Gm-Message-State: AOJu0YxGauvf0D8QXJr7SUIhIMPZRMihK6lJ52xUB48xA0wcpJIRBbLv
 Y2LYYw6SN59xXccrHrM1dB5lqm5JdWYYY1m5OdBiZYIPztR5f/AXhqi9xor0uySAXQ4NLvt/Ayb
 tZLVDiozSwYTc7KXyPEylKjSejIoKswcvqnKH
X-Google-Smtp-Source: AGHT+IEoR/ND21W1EdgFTsW2j9utPMYT4AWGNnMNmFubu6fYbXXcs3VDBpobLbK9AubxUpBPZM2mwbV5LLbG7hQHZok=
X-Received: by 2002:a17:907:1c04:b0:a9a:2afc:e4cc with SMTP id
 a640c23a62f3a-aa483557bb1mr241234066b.58.1731680829326; Fri, 15 Nov 2024
 06:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-4-sjg@chromium.org>
 <20241113024035.GI3600562@bill-the-cat>
 <CAFLszTibM9CwXeTbF6OuFrW4YSSs058qa0OysY+fWy7vV6WRkQ@mail.gmail.com>
 <20241113215324.GW3600562@bill-the-cat>
In-Reply-To: <20241113215324.GW3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:26:56 -0700
Message-ID: <CAFLszTh71mmqUL62NdS_M6=0nOi22+4FKZNMHm2CibqM+gD_CA@mail.gmail.com>
Subject: Re: [PATCH 3/9] buildman: Support #include files in defconfigs
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 13 Nov 2024 at 14:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 07:39:37AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 08:23:44AM -0700, Simon Glass wrote:
> > >
> > > > This is used by some boards in U-Boot and is a convenient way to deal
> > > > with common settings where using a Kconfig files is not desirable.
> > > >
> > > > Detect #include files and process them as if they were part of the
> > > > original file.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/30
> > > [snip]
> > > > +defconfig fragments
> > > > +-------------------
> > > > +
> > > > +Buildman provides some initial support for configuration fragments. It can scan
> > > > +these when present in defconfig files and handle the resuiting Kconfig
> > > > +correctly. Thus it is possible to build a board which has a ``#include`` in the
> > > > +defconfig file.
> > > > +
> > > > +For now, Buildman simply includes the files to produce a single output file,
> > > > +using the C preprocessor. It does not call the ``merge_config.sh`` script. The
> > > > +redefined/redundant logic in that script could fairly easily be repeated in
> > > > +Buildman, to detect potential problems. For now it is not clear that this is
> > > > +useful.
> > >
> > > I don't like this logic because the whole point of merge_config.sh is
> > > that it IS the canonical way to handle Kconfig config files + fragments
> > > and provides handy feedback like "You expected CONFIG_FOO=y but you
> > > ended up with '# CONFIG_FOO is not set'". It's frankly an at least small
> > > problem of our current cpp rule, but calling that for every defconfig
> > > would be a performance nightmare too.
> >
> > Here is the part of scripts/kconfig/merge_config.sh which actually
> > does something:
> >
> > # Merge files, printing warnings on overridden values
> > for MERGE_FILE in $MERGE_LIST ; do
> >         echo "Merging $MERGE_FILE"
> >         if [ ! -r "$MERGE_FILE" ]; then
> >                 echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
> >                 exit 1
> >         fi
> >         CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2"
> > $MERGE_FILE)
> >
> >         for CFG in $CFG_LIST ; do
> >                 grep -q -w $CFG $TMP_FILE || continue
> >                 PREV_VAL=$(grep -w $CFG $TMP_FILE)
> >                 NEW_VAL=$(grep -w $CFG $MERGE_FILE)
> >                 if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> >                         echo Value of $CFG is redefined by fragment $MERGE_FILE:
> >                         echo Previous  value: $PREV_VAL
> >                         echo New value:       $NEW_VAL
> >                         echo
> >                 elif [ "$WARNREDUN" = "true" ]; then
> >                         echo Value of $CFG is redundant by fragment $MERGE_FILE:
> >                 fi
> >                 sed -i "/$CFG[ =]/d" $TMP_FILE
> >         done
> >         cat $MERGE_FILE >> $TMP_FILE
> > done
> >
> > So for every line in the fragment it greps the file to check for
> > redefines/redundancies. I feel we can do this in a much more efficient
> > way in Python.
>
> I was too literal then. Yes, we should do the above, but in a more
> python way.

OK good

>
> > > > +To specify the C preprocessor to use, set the ``CPP`` environment variable. The
> > > > +default is ``cpp``.
> > >
> > > Uh, I was hoping it would get the correct CPP and flags from the
> > > Makefile? Otherwise this is going to fall down in some corner cases such
> > > as I expect clang.
> >
> > I don't want to parse Makefile, if that's what you're suggesting.
> >
> > It shouldn't really matter which cpp we use. U-Boot seems to use
> > '$(CC) -E' so we could do the same in buildman, perhaps.
>
> It doesn't matter up until it matters. In the Linux Kernel:
> commit feb843a469fb0ab00d2d23cfb9bcc379791011bb
> Author: Masahiro Yamada <masahiroy@kernel.org>
> Date:   Sun Apr 9 23:53:57 2023 +0900
>
>     kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
>
> is what I was remembering. But it's likely not going to be a problem for
> just handling Kconfig fragments (the above failed on parsing out linker
> scripts, iirc)
>
> > But actually, having thought about this patch a bit, I think the
> > better thing is to process the #include in buildman, rather than
> > running the CPP. That way we can avoid people adding #defines in
> > there, etc. It locks down the format a bit better.
>
> It's a defined format, and "make foo_defconfig bar.config" must work.
>
> > > > +Note that Buildman does not support adding fragments to existing boards, e.g.
> > > > +like::
> > > > +
> > > > +    make qemu_riscv64_defconfig acpi.config
> > > > +
> > > > +This is partly because there is no way for Buildman to know which fragments are
> > > > +valid on which boards.
> > >
> > > That seems like a really weird deficiency and non-sequitur. I don't know
> > > why buildman would be attempting any sort of validation beyond syntax
> > > validation. It's more that we don't have any way to pass additional
> > > arguments to the "make defconfig" part of the build, yes? And then in
> > > turn because buildman reads the defconfig itself too, prior to that
> > > stage?
> >
> > Yes, everything is seeming weird at the moment for me too.
> >
> > Buildman needs to know the architecture, so it can select the
> > toolchain. So it generates a boards.cfg file. It does this using
> > Kconfiglib, which processes the defconfig along with the Kconfig files
> > in U-Boot, to produce a final .config - see KconfigScanner
>
> Right. And this won't have any idea about the contents of #include
> because that's not a normal feature. The Linux Kernel only supports
> merging fragments via that script and then dealing with a complete
> ".config". That's the behavior we need to emulate in order for something
> like configs/am68_sk_a72_defconfig work without duplicating entries from
> configs/j721s2_evm_a72_defconfig.
>
> > Anyway, this problem[1] is exactly why I complained about fragments a
> > year or so back[2]. I'm not sure what the disconnect here is. IMO
> > unless we build boards with the fragments in CI they may stop working
> > at any time. Therefore IMO we need a file which collects the defconfig
> > and its fragments, so we can build the valid combination in CI.
> >
> > What am I missing?
> >
> > Regards,
> > Simon
> >
> > [1] https://lore.kernel.org/u-boot/4d55f212-ee39-4886-9246-3596fc4268f7@gmx.de/
> > [2] https://lore.kernel.org/u-boot/CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com/
>
> What you're missing is that the solution is that only
> configs/*defconfigs are valid config files for CI to test, and buildman
> doesn't support handling #include files correctly yet. It's clunky to
> use in that we have to have duplicate information in the combined
> defconfig file and so it's non-obvious to fix and I believe discouraging
> to more developers.
>
> A CI-only feature of "buildman knows how to combine foo_defconfig +
> feature.config" is duplicating the work of "make foo_defconfig
> feature.config" that regular developers will use or "make
> foo_feature_defconfig" like we have numerous examples of now. Telling
> developers they need to update some file to validate their new defconfig
> is likely to result in a new and differently perplexing CI error along
> the lines of "Why did the test for building every board not count my
> board?".

This patch fixes the 'buildman doesn't support handling #include files
correctly yet' problem. My other patch proposes a way to allow
buildman to build things with fragments. I'm sure there are other
options, but since buildman can potentially build all the boards in
U-Boot, it needs some way to know whether to apply a fragment.

For building a single board (e.g. with --board), buildman could
perhaps allow fragments to be specified?

It seems you are asking people to create boards containing the
required combinations? I see with TI there are two possible fragments.
How do we keep those working in CI? If you are wanting people to
create boards for each (which is fine by me), can we produce an error
when a fragment is not used by any board?

Regards,
Simon
