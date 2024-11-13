Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FAFD462B3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B7888DD0;
	Wed, 13 Nov 2024 15:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VfGzstDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A621D88F94; Wed, 13 Nov 2024 15:39:52 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E7088CEC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso1241248766b.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731508790; x=1732113590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9meZZPRCb9fsfHiCEXDFyQ+4gbyqLh2HW23iWi1h46E=;
 b=VfGzstDv/FP+f/zuRupd7LoMCkJB4b2pZzS2meOD0raQIeoDGhfzuKoFLYeSuSpQxL
 EZqCcNDOU3tU6q3lIRzuWvkrizG8htZCvjnn5G+watjTlJ0CSDzHtv45P9adV3KrMMkM
 PbvZMK+gBWBtxqtUbmwYb2AGo9j0du5XMkDps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731508790; x=1732113590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9meZZPRCb9fsfHiCEXDFyQ+4gbyqLh2HW23iWi1h46E=;
 b=NSn3/FGCk0v/OGzll8VLJVz1k1eD/f7MaM0+VjYU3t7RaRQe2qRbKspp/VSwXE5bPK
 bLmXkf6TKqt11udmoWkVEDw3Ax93e1Q32WK0f6+mZoWgrKNddEVoJugavMTbMhP4bhtA
 xaJE//Phmfur/CT45ovgGx93JQxnFCBmt8CyAIi38RcLfzap8CSKMX//OV5DAqs3G4RS
 CjvoI3jlemapGaKL1yzHUGpA3uKq3b/NNN18y75rIO42pmufT0OTK3elJIaFRQMP1KWC
 b6wge8XMrhtGBRwfvmLhrZ6s9pd/evIJVAqOX7s7h4I0Mnf2bMXdsC587r7YWD9AUrC2
 ZwCQ==
X-Gm-Message-State: AOJu0YzsK9zU00HQvNyMmO0VDwdZhTWQ1UWdqHqpMLuEvaKvEpD28sdd
 65JVDCc8qGFC486jcV/dynPUb63ovU+okYlmbVzehOcpighqwAt+Z5d9tWfP1Ev4AxOpwJt8tLH
 A+EL7whW9qK6n6McaBYNFgEakI1F3f8kP17AqT3wdeSJZ99Y=
X-Google-Smtp-Source: AGHT+IF6nk+Uz1etTa/mKvZ1bwj1DYjRNMlxa0TUaMRwjgATohMo7BknrNPWYIcBtpH76UvhFiq9s7bNSOCrt2lr404=
X-Received: by 2002:a17:907:a4b:b0:a9a:55de:11f4 with SMTP id
 a640c23a62f3a-a9ef0016b6emr1971198766b.54.1731508789717; Wed, 13 Nov 2024
 06:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-4-sjg@chromium.org>
 <20241113024035.GI3600562@bill-the-cat>
In-Reply-To: <20241113024035.GI3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 07:39:37 -0700
Message-ID: <CAFLszTibM9CwXeTbF6OuFrW4YSSs058qa0OysY+fWy7vV6WRkQ@mail.gmail.com>
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

On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 08, 2024 at 08:23:44AM -0700, Simon Glass wrote:
>
> > This is used by some boards in U-Boot and is a convenient way to deal
> > with common settings where using a Kconfig files is not desirable.
> >
> > Detect #include files and process them as if they were part of the
> > original file.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/30
> [snip]
> > +defconfig fragments
> > +-------------------
> > +
> > +Buildman provides some initial support for configuration fragments. It can scan
> > +these when present in defconfig files and handle the resuiting Kconfig
> > +correctly. Thus it is possible to build a board which has a ``#include`` in the
> > +defconfig file.
> > +
> > +For now, Buildman simply includes the files to produce a single output file,
> > +using the C preprocessor. It does not call the ``merge_config.sh`` script. The
> > +redefined/redundant logic in that script could fairly easily be repeated in
> > +Buildman, to detect potential problems. For now it is not clear that this is
> > +useful.
>
> I don't like this logic because the whole point of merge_config.sh is
> that it IS the canonical way to handle Kconfig config files + fragments
> and provides handy feedback like "You expected CONFIG_FOO=y but you
> ended up with '# CONFIG_FOO is not set'". It's frankly an at least small
> problem of our current cpp rule, but calling that for every defconfig
> would be a performance nightmare too.

Here is the part of scripts/kconfig/merge_config.sh which actually
does something:

# Merge files, printing warnings on overridden values
for MERGE_FILE in $MERGE_LIST ; do
        echo "Merging $MERGE_FILE"
        if [ ! -r "$MERGE_FILE" ]; then
                echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
                exit 1
        fi
        CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2"
$MERGE_FILE)

        for CFG in $CFG_LIST ; do
                grep -q -w $CFG $TMP_FILE || continue
                PREV_VAL=$(grep -w $CFG $TMP_FILE)
                NEW_VAL=$(grep -w $CFG $MERGE_FILE)
                if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
                        echo Value of $CFG is redefined by fragment $MERGE_FILE:
                        echo Previous  value: $PREV_VAL
                        echo New value:       $NEW_VAL
                        echo
                elif [ "$WARNREDUN" = "true" ]; then
                        echo Value of $CFG is redundant by fragment $MERGE_FILE:
                fi
                sed -i "/$CFG[ =]/d" $TMP_FILE
        done
        cat $MERGE_FILE >> $TMP_FILE
done

So for every line in the fragment it greps the file to check for
redefines/redundancies. I feel we can do this in a much more efficient
way in Python.

>
> > +To specify the C preprocessor to use, set the ``CPP`` environment variable. The
> > +default is ``cpp``.
>
> Uh, I was hoping it would get the correct CPP and flags from the
> Makefile? Otherwise this is going to fall down in some corner cases such
> as I expect clang.

I don't want to parse Makefile, if that's what you're suggesting.

It shouldn't really matter which cpp we use. U-Boot seems to use
'$(CC) -E' so we could do the same in buildman, perhaps.

But actually, having thought about this patch a bit, I think the
better thing is to process the #include in buildman, rather than
running the CPP. That way we can avoid people adding #defines in
there, etc. It locks down the format a bit better.

>
> > +Note that Buildman does not support adding fragments to existing boards, e.g.
> > +like::
> > +
> > +    make qemu_riscv64_defconfig acpi.config
> > +
> > +This is partly because there is no way for Buildman to know which fragments are
> > +valid on which boards.
>
> That seems like a really weird deficiency and non-sequitur. I don't know
> why buildman would be attempting any sort of validation beyond syntax
> validation. It's more that we don't have any way to pass additional
> arguments to the "make defconfig" part of the build, yes? And then in
> turn because buildman reads the defconfig itself too, prior to that
> stage?

Yes, everything is seeming weird at the moment for me too.

Buildman needs to know the architecture, so it can select the
toolchain. So it generates a boards.cfg file. It does this using
Kconfiglib, which processes the defconfig along with the Kconfig files
in U-Boot, to produce a final .config - see KconfigScanner

Anyway, this problem[1] is exactly why I complained about fragments a
year or so back[2]. I'm not sure what the disconnect here is. IMO
unless we build boards with the fragments in CI they may stop working
at any time. Therefore IMO we need a file which collects the defconfig
and its fragments, so we can build the valid combination in CI.

What am I missing?

Regards,
Simon

[1] https://lore.kernel.org/u-boot/4d55f212-ee39-4886-9246-3596fc4268f7@gmx.de/
[2] https://lore.kernel.org/u-boot/CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com/
