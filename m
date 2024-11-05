Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C6AD2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D588904C;
	Tue,  5 Nov 2024 17:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Trfxzalb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C008917B; Tue,  5 Nov 2024 17:07:18 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FFC88FD2
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so750061166b.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822835; x=1731427635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bdNCrJsp7gubHIoEJnYBEE4F6ZlRwsxG48bfZ7WBCXM=;
 b=TrfxzalbDfxoGVxIjVSV1Tm+SjVVAdsm+P0X4beASZ0H8iSz0ebx1SNb5Vnhys3Cxx
 Xn5kceEutE+oNP7PO44BL9J8SeXxMkRCDss2TY79cEOi+C72f/xrS8G4y7tCGn7FEcbW
 DOY7ZV++KMju6zBpUaBGLDyrBD0vYVQUUJx6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822835; x=1731427635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bdNCrJsp7gubHIoEJnYBEE4F6ZlRwsxG48bfZ7WBCXM=;
 b=BQMxFxUSJh6SXF1x2ltAxB4WBnDAPc+NLJCMLxSbAYY6PT7sdXx6DT4nQnMkhiMVlt
 K5LzrdUv4Qsg7ArSz+NzZHMNjsRgOZpAH+vuZeZyA/S7a5rS4TPEPRrxFHvu5/CT3tZB
 zeR+PjSRLJX7QvjmoMa+r4ZA2jG8RrsupK2TZc/fjQfWWl/P7ijJ1oZDVH6IK/yodiet
 AvT8yPGvHuIFZDxckouoPtzddRSZYcnX6fGE5cilMv3v0t5v0L6r0DGdzuAXylX04nTr
 SvaIrljVNA89qX4Yw5zeHX+0a1zzlPqpjPx+eWCVksyr6uIq3hFqVq/lm0oJIDnKwTLf
 5okQ==
X-Gm-Message-State: AOJu0YyfspqWhqlNnNRCXJRf/y3kPBYl4Q/XYmBKIkphx7zVADZf+Bye
 d7aCHRYvi3KIaZpZ4LpaG9shOCIkIC50gD4dJzLXKb2yjoYB//vfh3nYEO6IGRqpat6kpx2t1fJ
 vskjkqIgGW1u9nAkjC4FD7eiLW79A6UaNoiDF
X-Google-Smtp-Source: AGHT+IEd+JBwSx2CwY5LcA1bqXGWsMAXS2ME+4N5XZLtLt5VEv/DFMLJNEjEohY4RPpyiTa+PQ2g8Gcci90j7UmyGwo=
X-Received: by 2002:a17:907:2da7:b0:a9d:e1d6:41fc with SMTP id
 a640c23a62f3a-a9e50cad380mr1851046966b.53.1730822835529; Tue, 05 Nov 2024
 08:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-6-sjg@chromium.org>
 <20241104135632.GK3600562@bill-the-cat>
 <CAFLszTi4YEqRCVJ=vRTVHtSP=Ux2C8W=vg=3+VedVAdZuef3+A@mail.gmail.com>
 <20241105154447.GH3600562@bill-the-cat>
In-Reply-To: <20241105154447.GH3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 09:07:03 -0700
Message-ID: <CAFLszTi3ME4bcKY++YRL1euUWUtEp6sgubtxYoSvtbP3Kqxh-g@mail.gmail.com>
Subject: Re: [PATCH 5/9] docker: Drop grub for arm64
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Tue, 5 Nov 2024 at 08:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 05, 2024 at 08:15:05AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 4 Nov 2024 at 06:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Nov 04, 2024 at 06:39:49AM -0700, Simon Glass wrote:
> > >
> > > > This doesn't build on arm64 at present, so drop it for now. We only
> > > > expect to run sandbox tests, so perhaps it isn't needed.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  tools/docker/Dockerfile | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > What is the build failure? Depending on what other prospects for arm64
> > > build hardware come through I'm hoping to look harder at more build
> > > options, not just sandbox (but of course, QEMU shouldn't matter what the
> > > host is).
> >
> > field-initializers -Wnonnull -Woverflow -Wvla -Wpointer-to-int-cast
> > -Wstrict-aliasing -Wvariadic-macros -Wvolatile-register-var
> > -Wpointer-sign -Wmissing-include-dirs -Wmissing-prototypes
> > -Wmissing-declarations -Wformat=2
> > 686.0 checking for aarch64-gcc...
> > /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
> > 686.0 checking for aarch64-objcopy...
> > /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-objcopy
> > 686.0 checking for aarch64-strip...
> > /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-strip
> > 686.0 checking for aarch64-nm...
> > /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-nm
> > 686.0 checking for aarch64-ranlib...
> > /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-ranlib
> > 686.0 ./configure: line 32517:
> > /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc: No such
> > file or directory
> > 686.1 checking which extra warnings work...
> > 689.6 checking if compiling with clang... yes
> > 689.8 checking for options to compile assembly...
> > 689.8 checking whether -freg-struct-return works... no
> > 690.0 checking for options to get soft-float... no
> > 690.8 configure: error: could not force soft-float
> >
> > I suspect it is just that the toolchains need fiddling. I'd much
> > rather get something running and iterate on it after that.
>
> That's the toolchain that should be used to build sandbox, so you should
> figure out what's going on. And I think you missed fiddling with
> ~/.buildman so that it sets the sandbox toolchain to the right one and
> not x86_64.

sandbox should be built with the host toolchain, right? The one it is
complaining about is the amd64-host aarch64 toolchain, which we don't
want or need yet.

The grub part (and the cross toolchains) needs more work, but we don't
need it for sandbox, or at least the sandbox tests seem to pass
without it. Are you wanting to run qemu on arm64 to boot grub?

I believe I've taken a reasonable stab at a good starting point for
this work. Do you agree?

Regards,
Simon
