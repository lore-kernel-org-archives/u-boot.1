Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25952CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 21:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEFE80422;
	Fri, 22 Aug 2025 23:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MKFjMfKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C56380548; Fri, 22 Aug 2025 23:12:33 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0168C8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 23:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61c325a4da7so458096a12.0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755897150; x=1756501950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJRZj7XkW7ZcJu8shF+/ApG+r1ifMxstaYCmtGNKd04=;
 b=MKFjMfKTB+TUltJgfPVGrvGiTtL8LlIkMka0mjsQHUXabqTNVRxF3XSxsZxfXF4iTY
 6ZEcnIiIiIUaPw8u1AF+qvYS0E9BVKeTRXwZVZq513CN8qKiw5+IYEXHNuEqSATsHTrL
 GsaeY0chErOKofCPNngY5bq6QjDnUMKiLv5pD2hS12bZFyGvBxyeO1MXVPqJERaTo1AR
 7TIs1Fkf3Gx4M8us9WhbTvm4KXykIqJ861Zz2awP5a8hIJ2wk+tt27rwo17PIIND4kVD
 3Hm1kD/B7jDdC03/hJvJw6cOucyKLImzFyZkAyy9c/XWxhK/3LjvwpEXN4268y46fBno
 RzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755897150; x=1756501950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJRZj7XkW7ZcJu8shF+/ApG+r1ifMxstaYCmtGNKd04=;
 b=NHamxjVQjDGVV7bwj1i/ujb1UpHIMS/k17beM4MPDdrAu3ETIm/2t2TkW1tjqh6Ury
 Bm3aFrO0ePqGlAMyoKX6Y2WD6MDP8P0sZ7W1CLf6ZczMvi4pj7DlDqIyS7QQJg14f9Qg
 +5dQovYIYr3Yvt3Zv8yo8By76mx1sb2xuQjU8YZuH7OH3xU8VH3KEOW8PzqaGJLLLan1
 vHEsFYtyxOQa2UHD9OVjfDLY95UKVHOwpqymAzXbDDksJM/PLf1Ivy4bJSvrxLmI8Xeb
 XkpGlZRgbd987D+fz2GB2hTWm/OYJFSkYUYen61ecWz/jNda+tYFg0tOQPH63I19LXEc
 1bDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvvIjzb1/nPayLY/X3nD424dIx5uMPRWioz27pC4m9doUht/77om8wp0pz2R4vkvWgWDmVjq4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1XlGUAJPajDSeCSKVI3Jytw91KF8FJOGXjCFe4l4vZ3+WbNRm
 JyJxD8RC2hrWsHq8RS3bmeSqw/KSBEhQgT2IZixajtjTfw3FnWLkcZYyV33bzZqXj78rDzW+Vda
 VNUnzrkoQnxIkDZOClYRlIJNq7QuL15w=
X-Gm-Gg: ASbGncvNkTAa9kNQd4MWgleBhrhQ5+K2vBh4vyOTtaB7gCCSKNnhFv4eZ8xIY0MhwVj
 tUODsE0H8n/GtZKiMChfBT9dr0VsVZhfuVOjdZK2HzqOAyZRFB7PcI7spKTs4mTw0z3UTt3gmyX
 7HLvy1EkZgcXIozucro1MxjCs5+eyVXVYcip89514Ut+Qn34duk/KtddZmR1nNS+kziEsLi4eEf
 knFCiK3t57Cug8GG+LjvmZxUpo/9qaDufzCFnEL
X-Google-Smtp-Source: AGHT+IF/iL5s0nolJFixoDdGv4gOtY5mL1eIboxI6Kw8pPL9uPU/+PB31GF1qwTXN5Hq8JNgiyx9pekg7+RHWggCTvM=
X-Received: by 2002:a05:6402:4406:b0:618:47a0:3ba2 with SMTP id
 4fb4d7f45d1cf-61c1b6f3a56mr3328648a12.24.1755897150187; Fri, 22 Aug 2025
 14:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
 <b8fa5fa1-0028-43e5-bb14-db94fd16bf3c@gmx.de>
 <CACAHuLDQ9gp6G1KnbPTH2bcdFChY4x_M1HC0fJU-SJ0ozkghKA@mail.gmail.com>
In-Reply-To: <CACAHuLDQ9gp6G1KnbPTH2bcdFChY4x_M1HC0fJU-SJ0ozkghKA@mail.gmail.com>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Fri, 22 Aug 2025 22:12:19 +0100
X-Gm-Features: Ac12FXyKrt9kC1QFe8-zX-45rJ-XIKm2_dEMbdSncKkgZKS6j9ZOfSfck5uX_9c
Message-ID: <CACAHuLD=fkEKq9e83f3ePQHO1N5dnVsRuFHwR6U12jv2EBJnew@mail.gmail.com>
Subject: Re: [PATCH 06/10] doc: Add riscv to the list of architectures in
 tools/buildman/buildman.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

On Fri, 22 Aug 2025 at 01:04, Adriano Carvalho
<adrianocarvalho.pt@gmail.com> wrote:
>
> On Wed, 20 Aug 2025 at 22:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 11.08.25 01:37, Adriano Carvalho wrote:
> > > Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> > > ---
> > >   tools/buildman/buildman.rst | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> > > index d5d22732088..7944adcd867 100644
> > > --- a/tools/buildman/buildman.rst
> > > +++ b/tools/buildman/buildman.rst
> > > @@ -478,7 +478,8 @@ Setting up
> > >
> > >      At the time of writing, U-Boot has these architectures:
> > >
> > > -      arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, sh, x86, xtensa
> > > +      arc, arm, m68k, microblaze, mips, nios2, powerpc, riscv, sandbox, sh, x86,
> > > +      xtensa
> >
> > The output examples above this line should also be updated to show RISC-V.
>
> Do you mean what's under "Check the available toolchains"?
>
> To reproduce, I would need to install quite a few toolchains. If
> anyone already has all those toolchains they could just send me the
> output. Do you know someone who can do that? Can you do that? Or
> should I just install all those toolchains and reproduce?
> [...]

With docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025,
I got the following:

$ ./tools/buildman/buildman --list-tool-chains
List of available toolchains (17):
aarch64   : /opt/gcc-14.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
arc       : /opt/gcc-14.2.0-nolibc/arc-linux/bin/arc-linux-gcc
arm       : /opt/gcc-14.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc
c89       : /usr/bin/c89-gcc
c99       : /usr/bin/c99-gcc
i386      : /opt/gcc-14.2.0-nolibc/i386-linux/bin/i386-linux-gcc
m68k      : /opt/gcc-14.2.0-nolibc/m68k-linux/bin/m68k-linux-gcc
microblaze: /opt/gcc-14.2.0-nolibc/microblaze-linux/bin/microblaze-linux-gcc
mips      : /opt/gcc-14.2.0-nolibc/mips-linux/bin/mips-linux-gcc
nios2     : /opt/gcc-14.2.0-nolibc/nios2-linux/bin/nios2-linux-gcc
powerpc   : /opt/gcc-14.2.0-nolibc/powerpc-linux/bin/powerpc-linux-gcc
riscv32   : /opt/gcc-14.2.0-nolibc/riscv32-linux/bin/riscv32-linux-gcc
riscv64   : /opt/gcc-14.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc
sandbox   : /usr/bin/gcc
sh2       : /opt/gcc-14.2.0-nolibc/sh2-linux/bin/sh2-linux-gcc
x86_64    : /opt/gcc-14.2.0-nolibc/x86_64-linux/bin/x86_64-linux-gcc
xtensa    : /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-gcc

Compare to the original:
- a few architectures are missing (e.g., alpha, am33_2.0, bfin, frv, h8300)
- No "Scanning for tool chains" at the beginning
- No "Tool chain test"

Have the missing architectures been removed since? All those in the
arch folder and some more are listed.

Has the output for Buildman changed to not include those lines?

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
