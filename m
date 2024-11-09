Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0184D5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223E189145;
	Sat,  9 Nov 2024 18:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U1B6Jatn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F3889148; Sat,  9 Nov 2024 18:34:32 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E33A88D3C
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso493068066b.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731173669; x=1731778469; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J34ONu2oNVFZPqRnwEFWjp3xuNT4nNq64zcC0gGWBlc=;
 b=U1B6JatnzV5DjJkzf7S8c/fQtR+r0rumliVmQfKtTd+dXOoJ+Kn0yI1ANoI4ldKJXR
 yZyyd3T7HGuWA7H0j+PziyGPLJHVykZKjDuP4d5RAJnaIlt1uP2/JnqZx85zkro2KB6J
 Da4hXHssbsVYjMi0gD50oF4mTWQuBen5Fxhmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731173669; x=1731778469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J34ONu2oNVFZPqRnwEFWjp3xuNT4nNq64zcC0gGWBlc=;
 b=gNhMh7ZE8uViac+V46diVkg+sWqvfIkgxXhvfp/iS+80lS3wXa8KeTJO8uVtRVZ1ax
 L23zjL1N/9lkAZ5uLRfXxJ80q7abxbNkWFL1MQYtE8ds9krsPPNGDC2sdhdcWj9gsiGM
 ALtVOeW9dJs5tcdVNEWNfq2culu9QsOf1gy1qREfsRjgDFWpYIRuRalmGhZxMqcYOdij
 wqjS3YFAbFhm55NdN5LilCABld7h7eVIrJgOQLQExL8oPs4i3trd2x4vgNj8qPQM+neX
 ia9KQHWmNVUunkE8aR9pUqAyuQfPUnIBObpFlOc2D3o3u9vniSz9c2PiEspLbYEe1Jqn
 TVgg==
X-Gm-Message-State: AOJu0Yxq+zgBJ/xwqy0GESl1jCxMe1r8YiMz+6okEjtiajXURTaqbSAS
 uQgb5n519NIeR9tAF+szl986TUN0mX0LbZDtNKqEgsqj4hl/iPEPdyis5C/DzFYgZaWou55mgOl
 fk5tPjatC0SQ4xa0zvZ0CFJ+KTpK5FgvFvEwtwmY8nwmidPw=
X-Google-Smtp-Source: AGHT+IHLlokDGq4BGjWLlSoVV4ny+oZDZYg7M6UN+qEEHhzah20IQKqXKo2xGePqyzeb+VLGlGbM/cE6fAac/5rCnmw=
X-Received: by 2002:a17:907:3e1d:b0:a99:4aa7:4d6f with SMTP id
 a640c23a62f3a-a9eefebc409mr723487366b.12.1731173669220; Sat, 09 Nov 2024
 09:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20241105165357.620796-1-trini@konsulko.com>
 <CAFLszThU2T2A4DG-=isO6vP=149Lw6jQaB3vs8ggJ2H8CcDwBg@mail.gmail.com>
In-Reply-To: <CAFLszThU2T2A4DG-=isO6vP=149Lw6jQaB3vs8ggJ2H8CcDwBg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Nov 2024 10:34:15 -0700
Message-ID: <CAFLszTjYy-wCuOx5Nv-F1uDcVYJEqi2pwTBTws=UHWB0z026ww@mail.gmail.com>
Subject: Re: [PATCH RFC v1] Dockerfile: Have "sandbox" build with i386
 toolchain not x86_64 toolchain
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, 5 Nov 2024 at 10:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 5 Nov 2024 at 09:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > A long time ago, we had to use "i386" and "x86_64" toolchains for our
> > x86 platforms, depending on the target. We then moved to being able to
> > use the single "i386" toolchain to support all x86 platforms. At the
> > same time, we had been building sandbox with our "x86_64" toolchain in
> > CI. When x86 switched to being able to use a single toolchain we did not
> > update our CI buildman file to match. Do this now as we want to ensure
> > that sandbox is built with the same compiler version the rest of our
> > platforms are and not the host one.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> >
> > I'm posting this as an RFC to start the discussion as when I mentioned
> > this to Simon on IRC, he was very much not in agreement.
> >
> > My main argument is this, sandbox needs to use the same toolchain that
> > we compile (virtually) all other platforms with as one of the points is
> > to be able to catch warnings and compiler behavior changes as soon as
> > possible in our CI. And just like how developers can use
> > distribution-provided toolchains today, nothing changes in that regard,
> > we only make CI be more consistent now.
>
> OK, that makes some sense to me, actually. It isn't the toolchain that
> people will be using, but catching things earlier seems good.
>
> The main concern I have is that we are not testing sandbox on the
> toolchain that everyone will be using. But I haven't noticed failures
> in CI which I cannot repeat locally, so we can cross that bridge when
> we come to it.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

This doesn't seem to work, for a few reasons:

1. Buildman doesn't support setting HOSTCC and CC unless using -O to
override the toolchain (so the setting in this patch has no effect)
2. Using the toolchains from kernel.org gives this error:

NO_LTO=1 make O=/tmp/b/sandbox defconfig all
HOSTCC=/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-x86_64-linux-gcc
CC=/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-x86_64-linux-gcc
 -j30 -s
/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../lib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
cannot find crt1.o: No such file or directory
/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../lib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
cannot find crti.o: No such file or directory
/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../lib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
cannot find -lc: No such file or directory
/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../lib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
cannot find crtn.o: No such file or directory
collect2: error: ld returned 1 exit status
make[3]: *** [scripts/Makefile.host:95: scripts/basic/fixdep] Error 1
make[2]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:503:
scripts_basic] Error 2
make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:568:
__build_one_by_one] Error 2
make: *** [Makefile:177: sub-make] Error 2

Regards,
Simon
