Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FC8CF9C7B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 18:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3BF8405F;
	Thu, 20 Nov 2025 19:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYxN5nFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6486684067; Thu, 20 Nov 2025 19:20:38 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF54C83F2E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 19:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-29845b06dd2so14887405ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763662834; x=1764267634; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6GIuDUYj1MfIYq8ddXc/BEu73uG2LS1ceU5HTos67w=;
 b=ZYxN5nFkS/fzx7Q6bHuba02uUF2PQYceTjRQA/xyvIAWEtiUxrzbdNvzDaBFoi8tAw
 ZX+XhKGJBJa7o2gFhR803lWH7xVVqrEDG2/cmY9PAkC8NC4KTAg45mPyaKVQUFapYdNS
 ZY7GqWhq+yc8A+IIEaRjjK21cVDjaGRyVTWmroooJ2vcn+VxDCaCh6o4uH/QORgxrzRB
 A6IajRZ7shA9DNiuctGUb1InxWgM89v3X7gKVzKbufGy+3RzeY4AtoR2/ZQRHO3TT9Q5
 G2G2VpxNqWE2efLmeNFTB5FQEdrFMaa64hxlwtOQs3H8iwVT9SOwSLlgeF1z3fGvi0Zs
 3Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763662834; x=1764267634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y6GIuDUYj1MfIYq8ddXc/BEu73uG2LS1ceU5HTos67w=;
 b=MtE1sWqNmKyfzBNxJnMsjh6SKf0u2JOh9xPxMbuSIyT3M3JSmBi6/F3r294TEmgTqx
 Korrv/wZD5bZOsWLPF3vaATw1iW2uodZh9wGkyct7iJ4h1oMHkkQwXla1/1eIjEaEWfD
 qR2rq16EA486OE43AlhCsE/fbzjXF8Heam9jBCh3q6G7HNyyBAS/XMfWkAhaIoXdzJq6
 2lKl2Ja2wDTOYqLLglIeMIJhmAWMDnq338IhLMH8VgzvqhMFKQnKtiXLQz0AhfdBh7Nl
 Pn2Q7deSErsucINwIguXSkaenawDeOIOZ53ZTGYthoHvWtPI4pH6IBBl84eXTbmYZ1OI
 y6zg==
X-Gm-Message-State: AOJu0Yx2uLboSvveKkjkw0roz0FXWDDNl5wJ8VPe0AldMtoXpZi8OB41
 y+6StLhodIOj2isWrFQizJU4YO9/2aC8g1E7jaPNeskjT2hd0Yn9G9VpWTwnaYNpUA2/rOJdeI7
 xW7M1nUTWQ9H+4OgmeOMHoO+vtzvdzw==
X-Gm-Gg: ASbGncvSsqFZEU6w5XNOeofsyQulJL9H2SXfh59l5243HUf+LkHRR7vH9FdIBsesalj
 x81bbGE0vpvhTZDD8lO3vZ0ioEYA/aZKpqxTlZsI5Pr9yLrWb0hkyO8EFWfvhr3DjRle4Tshxlf
 tp4smeMPLgI81fyFnUuAWIMjbQtevgJ3i2KFk+2bmmlO6nYUZ143VP0dEbl+Mp3lGUB57SNO1Eb
 G3/PyyZMd2PYaCYAYqo5o9Vc+luCp2k/fUqno2TGAr4eHP5bUj02n/DDlEGW0bCmkg7Oig6Dmcm
 fPe0bfQtmiaGXKdYTGndsUS6wXY=
X-Google-Smtp-Source: AGHT+IFYRvffirjG8KJ51HIilYLVSsffmWvuv3RpdCEyRTN27wGMrY7aKqlsVrWrRFY2EDT6x+dn5/rdtdlZeJtcwnU=
X-Received: by 2002:a05:7022:3895:b0:11a:5ee1:fd8a with SMTP id
 a92af1059eb24-11c938139e6mr1715678c88.13.1763662834152; Thu, 20 Nov 2025
 10:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20251118064000.14613-1-malysagreg@gmail.com>
 <20251118064000.14613-6-malysagreg@gmail.com>
 <20251118143918.GS2125796@bill-the-cat>
In-Reply-To: <20251118143918.GS2125796@bill-the-cat>
From: Greg Malysa <malysagreg@gmail.com>
Date: Thu, 20 Nov 2025 13:20:21 -0500
X-Gm-Features: AWmQ_bkRSzazHgtc2e5osOTLLvVudfGTsPNkbZz8wAauRa75bpJ9bIb_vy2ER8k
Message-ID: <CABdDSeVDLPM7ahFS_rn9N7GhdpOssoFRp3M7xWnr9PK=G6F9RA@mail.gmail.com>
Subject: Re: [PATCH 05/12] docker: add Analog Devices tools to docker image
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Simon Glass <sjg@chromium.org>
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

Hi Tom,

On Tue, Nov 18, 2025 at 9:39=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> [snip]
> > +# Build ldr tool for Analog Devices boards and create prefixed symlink=
s to match
> > +# $(CROSS_COMPILE) as used by different supported platforms
> > +RUN git clone https://github.com/analogdevicesinc/lnxdsp-arm-poky-linu=
x-gnueabi-ldr.git /opt/lnxdsp-arm-poky-linux-gnueabi-ldr && \
>
> We need to be getting a specific branch/tag (or worst case, commit) and
> using --depth=3D1.

I'll address this in v3, thanks. There's a release tag I can use.

>
> [snip]
> > +ENV PATH=3D"${PATH}:/opt/lnxdsp-arm-poky-linux-gnueabi-ldr"
>
> Does this actually do what you want, update the PATH for the shell that
> we spawn and run CI in?

It does appear to do what I want, which is allow buildman to find and
invoke the ldr tool, but as for whether it is the right way to do it,
I am unsure. If I run and attach to a container to manually go through
the steps, without the ENV line I get:

~/adi-u-boot$ tools/buildman/buildman sc598-som-ezkit-spl
Building current source for 1 boards (1 thread, 32 jobs per thread)
   aarch64:  +   sc598-som-ezkit-spl
+/bin/sh: 1: aarch64-linux-ldr: not found

and with it, I get

$ ./tools/buildman/buildman sc598-som-ezkit-spl
Building current source for 1 boards (1 thread, 32 jobs per thread)
   aarch64:  w+   sc598-som-ezkit-spl
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CONFIG_OF_EMBED is enabled. This option should only
+be used for debugging purposes. Please use
+CONFIG_OF_SEPARATE for boards in mainline.
+See doc/develop/devicetree/control.rst for more info.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
    0    1    0 /1              sc598-som-ezkit-spl

so it is sufficient for finding aarch64-linux-ldr. The CI build also
passes, which has previously failed on the world build stage for me,
when it was unable to locate the ldr executable.

Bigger picture though, is hacking up $PATH the right way to do this?
Buildman inherits the env it runs in, so it picks up the modified PATH
and then adds the toolchain directory to PATH itself, so I could drop
symlinks into the aarch64 and armv7 folders as well and have it work,
but I thought that might be even less appropriate. ADI's packaging
(for amd64 only) currently installs it as "ldr" (no CROSS_COMPILE
prefix) into /usr/bin, which won't work for us either, because the
yocto SDK build does add CROSS_COMPILE prefixes if one were to use
that to build uboot outside of CI, and we need to somehow be
compatible with all three options, which PATH+CROSS_COMPILE achieves
for now.

So the options are probably:
1) Create local symlinks to rename the binary and hack up env/$PATH to
attach this
2) Drop symlinks into
/opt/gcc-${TCVER}-nolibc/(aarch64-linux,arm-linux-gnueabi)/bin
3) Modify buildman to be aware of ldr and have a separate
configuration section where we can round up settings
4) (Cannot be done for now) ldr tool rewrite as python
package+executable wrapper, update binman to use the library and
package in LDR format

Option 4 actually makes a lot of sense, but it is not something I can
get support for from ADI for the time being, but it would solve the
other big problem: u-boot can produce a stage 1 and stage 2 boot ldr
file for us by calling ldr with uboot artifacts only, but the stage 2
ldr is rarely useful in production and is only used for standalone
testing. It is typically repackaged in a separate yocto recipe to add
optee and tfa, or to replace u-boot proper with a kernel for falcon
boot, and being able to generate ldrs from binman would allow us to
combine the other files as well.

Thanks,
Greg
