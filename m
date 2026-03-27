Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35B910ED664
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A73083DA7;
	Fri, 27 Mar 2026 13:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f0A1pY5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822AE83DBF; Fri, 27 Mar 2026 13:44:46 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F77E8394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9795ca4e6dso320470766b.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 05:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774615483; cv=none;
 d=google.com; s=arc-20240605;
 b=EkLchUl4uUsW1A+xNNeCTttaw41EVCbJLCPI0yzzIOpYGbh9Z9IHCbEPSxy/L/IUt0
 9ansYx8E28JMs12ZpLkRQL7GR/vz/2XM3JzK9BvOgnhWUUD+Qm+8WFSY8ztmVieNxbms
 Kp2SGjSlIJ7+89QPj8rjfYYlVJ04Bgu5RqovfgMaDzMYWntXzS6kqWinNWyW8sR03rpF
 h0uy1F+UNxa1XeV7KmRko3JdNTlb0toaRoQnOrmZ/Lu5BxuSKeAE0GK5wllkLYR0T49i
 azBBbpJWRaodNmnOnq6TR1Z9p2AXWv4f2LSlapI4aI2pf5VWnoxLkmmDNTEN9Ib+BEdL
 P4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CeI6vEPQknH36BT2avnJyMpixlYADC4qBCJmp7k7Re0=;
 fh=rXvbdCKXd6BT7xBh3jRTexWkacKLjaJLI3zNaituv3c=;
 b=MQVYPVAkvUe5OSjYzF/bZq/VePCSq+ztq4Lc2PCxfYfgqf8mdtBHD1WFmikJG6Md2i
 codF0XehZceD2qGLUPbR2RadA6XCq01bJxRNf7wal5lQ4QcUMIDWm0dvZsavI28NF9iV
 v0BXsLtOijj9Vkw3XKiiqPK9iSP3RO8zf//g4JWo+N9xDs0OmojuOjBYtLu9sxMCsmSJ
 vUgOq5h33YPILS2RNAypTJXwAXvogd07JA2v/nNR5V+7+Z+OdYYjUz3crGdmz505p4vb
 zvkxjPWxbUinieC17Nn026oaRcv7kHiEK1T8YWs/HAcTRxWTOyg9FWqupA3fI7EMx2Sz
 cjFQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774615483; x=1775220283; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CeI6vEPQknH36BT2avnJyMpixlYADC4qBCJmp7k7Re0=;
 b=f0A1pY5hEN605mb5GmPMYRBO6xZvyfWCKcP0upz8YyL4daIo6EGwHxd8/uMhn2wJaS
 4nmsWeue38vgmNu9YRR1FI6gVsBdohSOsAub8t7ZVB1hVmGb9vVqoSaWbi+yqBPJojFz
 6cf0mHBRYQuYoFb50Ng6AfkXCsZ73lfi2T9es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774615483; x=1775220283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeI6vEPQknH36BT2avnJyMpixlYADC4qBCJmp7k7Re0=;
 b=ZS+78q8vplhMTYXf/PYtnX529NcmZ0RXXFRGZu3Qs7hW4iXzeQqjyUtcK6v7Pg2TKw
 CtkHhbKjY1efO8a0xbzwwmlQKcu856kSwmwTtN9DSTI3xsaPL29iR7EBKs5mJotWSOWo
 zzBQCqBYWK32KCfP3VDHWFHNpkHSnyPCCVaj7Zr524gSbL0PEi9ySBvwqHl+Ju3VU6dw
 aQFI3rlwpAL43QIfrmsWjE/757SC2QE7C/a7SpI9/dMoW9ZcThXkQtrXngsKMgnmolgA
 Tk4OUdS3Ld9nVOvFBcTX8mMyVpb/r0fbp/aNtVx5vgBF0pL3RpWcbQpimEGXI+g/cb6I
 ESQQ==
X-Gm-Message-State: AOJu0Yx5Gzqb37XDnyRBQcBvmoZLkiVObE2/pALpM0YeDxo4Txxt9YNp
 zsDNhBG/YaF4FgLu9AXU89KhF/gRg56fiyWZtIBEpnjmvaxWL7nZXquZvUIlUWpFxYunlgiiYRw
 vG2gDxguqjodj1FfapjKO/DPgIlvCQgcVXHvREBiu
X-Gm-Gg: ATEYQzx4BqWGOcxWDOAmT2DLEGDnZ2+V4xhcr9kysinZDXvaYww4rOrlSp5q1P9yRqM
 U6iJ1Io+VFhko/tG+avi1w15nw5wnCx+yxrjUeU3tckpJdmOQKJogWI+PHor8LJG4QPsDcxBh+G
 YylNqmcUqOB2hh+B8R07KJKDWzDkW6PJAWYRF2/fitOGYvoac21jxj/tLl2/rZwMzfmfaMwtnJ7
 zMzLQNI1rHvzWheR7OL0qLI2GOou6tQltpE3d+R3HEn6cJN0mr29oTrhMMPeUD2HFhPOxSO0Cdk
 PsNGtb8=
X-Received: by 2002:a17:907:3ccb:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b9b502a8e9fmr170544466b.15.1774615483322; Fri, 27 Mar 2026
 05:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260326115500.955388-1-sjg@chromium.org>
 <20260326115500.955388-2-sjg@chromium.org>
 <87cy0plmh8.fsf@prevas.dk> <875x6hlg8k.fsf@prevas.dk>
In-Reply-To: <875x6hlg8k.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Mar 2026 06:44:30 -0600
X-Gm-Features: AQROBzDxgjACUAKdJzxG0vbIjwclK_xc-W4luGVbJhLrp_0ZtiOqjha4Lp7S3o0
Message-ID: <CAFLszTj-SBhSsrrsDwS0qWeRysno+M9fGhcZL6i0N+tbzbREUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Use relative paths in generated .incbin
 directives
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Fri, 27 Mar 2026 at 04:27, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Fri, Mar 27 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> > On Thu, Mar 26 2026, Simon Glass <sjg@chromium.org> wrote:
> >
> >> The generated .S files for fonts and splash screens use .incbin with the
> >> full prerequisite path. When building with O= this bakes an absolute
> >> path into the .S file. If the build directory is later used on a
> >> different machine (e.g. in a container), the assembler cannot find the
> >> source file.
> >
> > I must be missing something, because I can't see how this can be a
> > problem, while all the other absolute paths to the source dir that go
> > into files generated in the build directory is not. For example, there's
> > a top-level "source -> /path/to/u-boot" symlink created, and as far as I
> > can tell, all the .foo.o.cmd files end up full of such references as
> > well, e.g. $BUILD/lib/.vsprintf.o.cmd contains
> >
> > source_lib/vsprintf.o := /path/to/u-boot/lib/vsprintf.c

Thanks for looking at this.

When I build outside the container and then build inside I get:
$ um -n b sandbox
buildman -L -I -w -W --boards sandbox -o /tmp/b/sandbox
$ um b sandbox
drivers/video/fonts/cantoraone_regular.S: Assembler messages:
drivers/video/fonts/cantoraone_regular.S:5: Error: file not found:
/home/sglass/files.local/u-boot/drivers/video/fonts/cantoraone_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/cantoraone_regular.o] Error 1
drivers/video/fonts/nimbus_sans_l_regular.S: Assembler messages:
drivers/video/fonts/nimbus_sans_l_regular.S:5: Error: file not found:
/home/sglass/files.local/u-boot/drivers/video/fonts/nimbus_sans_l_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/nimbus_sans_l_regular.o] Error 1
make[3]: *** [scripts/Makefile.build:492: drivers/video/fonts] Error 2
drivers/video/u_boot_logo.S: Assembler messages:
drivers/video/u_boot_logo.S:5: Error: file not found:
/home/sglass/files.local/u-boot/drivers/video/u_boot_logo.bmp
make[3]: *** [scripts/Makefile.build:344: drivers/video/u_boot_logo.o] Error 1
make[2]: *** [scripts/Makefile.build:492: drivers/video] Error 2
make[1]: *** [Makefile:2201: drivers] Error 2
make: *** [Makefile:189: __sub-make] Error 2
drivers/video/fonts/cantoraone_regular.S: Assembler messages:
drivers/video/fonts/cantoraone_regular.S:5: Error: file not found:
/home/sglass/files.local/u-boot/drivers/video/fonts/cantoraone_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/cantoraone_regular.o] Error 1
drivers/video/fonts/nimbus_sans_l_regular.S: Assembler messages:
drivers/video/fonts/nimbus_sans_l_regular.S:5: Error: file not found:
/home/sglass/files.local/u-boot/drivers/video/fonts/nimbus_sans_l_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/nimbus_sans_l_regular.o] Error 1
make[3]: *** [scripts/Makefile.build:492: drivers/video/fonts] Error 2
drivers/video/u_boot_logo.S: Assembler messages:
drivers/video/u_boot_logo.S:5: Error: file not found:
/home/sglass/files.local/u-boot/drivers/video/u_boot_logo.bmp
make[3]: *** [scripts/Makefile.build:344: drivers/video/u_boot_logo.o] Error 1
make[2]: *** [scripts/Makefile.build:492: drivers/video] Error 2
make[1]: *** [Makefile:2201: drivers] Error 2
make: *** [Makefile:189: __sub-make] Error 2

If I then do a fresh build inside the container, then build outside, I get:

$ um b sandbox
drivers/video/fonts/cantoraone_regular.S: Assembler messages:
drivers/video/fonts/cantoraone_regular.S:5: Error: file not found:
/home/ubuntu/project/drivers/video/fonts/cantoraone_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/cantoraone_regular.o] Error 1
drivers/video/fonts/nimbus_sans_l_regular.S: Assembler messages:
drivers/video/fonts/nimbus_sans_l_regular.S:5: Error: file not found:
/home/ubuntu/project/drivers/video/fonts/nimbus_sans_l_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/nimbus_sans_l_regular.o] Error 1
make[3]: *** [scripts/Makefile.build:492: drivers/video/fonts] Error 2
make[2]: *** [scripts/Makefile.build:492: drivers/video] Error 2
make[1]: *** [Makefile:2201: drivers] Error 2
make: *** [Makefile:189: __sub-make] Error 2
drivers/video/fonts/cantoraone_regular.S: Assembler messages:
drivers/video/fonts/cantoraone_regular.S:5: Error: file not found:
/home/ubuntu/project/drivers/video/fonts/cantoraone_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/cantoraone_regular.o] Error 1
drivers/video/fonts/nimbus_sans_l_regular.S: Assembler messages:
drivers/video/fonts/nimbus_sans_l_regular.S:5: Error: file not found:
/home/ubuntu/project/drivers/video/fonts/nimbus_sans_l_regular.ttf
make[4]: *** [scripts/Makefile.build:344:
drivers/video/fonts/nimbus_sans_l_regular.o] Error 1
make[3]: *** [scripts/Makefile.build:492: drivers/video/fonts] Error 2
make[2]: *** [scripts/Makefile.build:492: drivers/video] Error 2
make[1]: *** [Makefile:2201: drivers] Error 2
make: *** [Makefile:189: __sub-make] Error 2

>
> OK, I can sort-of reproduce, though I don't know if what I did is
> representable for your use case. No containers involved, just moved the
> source directory.
>
>   # original source dir
>   $ cd /tmp/u-boot
>   $ make O=/tmp/build sandbox_defconfig
>   $ make O=/tmp/build -j7
>   $ cd /tmp ; mv u-boot u-boot-new ; cd u-boot-new
>   $ make O=/tmp/build -j7
>
> This breaks as you describe, but most files simply get rebuilt due to
> their .cmd files containing stale references to /tmp/u-boot/. Which
> suggests that the bug is really the lack of a .S.cmd file describing how
> the .S file was created in the first place.
>
> This seems to be a better fix, which also causes the .S files to be
> generated anew if one does some actual change to the rule:
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 7386353e0cc..b2441080e7e 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -526,8 +526,8 @@ cmd_S_ttf=                                          \
>         echo '.balign 16';                              \
>  ) > $@
>
> -$(obj)/%.S: $(src)/%.ttf
> -       $(call cmd,S_ttf)
> +$(obj)/%.S: $(src)/%.ttf FORCE
> +       $(call if_changed,S_ttf)
>
>  # Splash logos
>  # ---------------------------------------------------------------------------
> @@ -547,8 +547,8 @@ cmd_S_splash=                                               \
>         echo '.balign 16';                              \
>  ) > $@
>
> -$(obj)/%.S: $(src)/%.bmp
> -       $(call cmd,S_splash)
> +$(obj)/%.S: $(src)/%.bmp FORCE
> +       $(call if_changed,S_splash)
>
>  # EFI applications
>  # A Makefile target *.efi is built as EFI application.
>
> See e.g. kernel commit a7f9241909 which did essentially the same change
> to the .dtb -> .S rule back in 2018.
>
> It still makes sense to put these rules in a u-boot specific makefile,
> but this should avoid the need for each font .o file to need those
> AFLAGS changes.

Sure, but it causes the font/logo .S files to be rebuilt on every make
invocation. How did you test this?

It would be nice to use if_changed though. It needs the .cmd file to
be loaded via -include, which only happens for files in the targets
variable. The generated .S files are never added to targets, so cmd_$@
is always empty and if_changed always rebuilds.

The kernel commit you referenced (a7f9241909) works for DTB because
.dtb.o has a compound suffix with a matching intermediate_targets
entry. We could follow the same convention, renaming to .ttf.o/.bmp.o
and adding:

targets += $(call intermediate_targets, .ttf.o, .ttf.S) \
           $(call intermediate_targets, .bmp.o, .bmp.S)

The pattern stem stays the same, so symbol names are unaffected. What
do you think?

Regards,
Simon
