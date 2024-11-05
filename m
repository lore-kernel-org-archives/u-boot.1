Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19E9D2C122
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4830B891DE;
	Tue,  5 Nov 2024 16:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HnnY4J20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A20E891D7; Tue,  5 Nov 2024 16:15:20 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867A6891AC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso3487066e87.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819718; x=1731424518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qs8CIJI9FNLgFYKQ95LnbrwZ5pacpTewgyat0QZZtVU=;
 b=HnnY4J20phQ3hXNcrmLZHkmwpc10fCGAyKeWR2KkFTFNZI75Sc1zFAzizCp9wrP+Nk
 BpV2f14z7RN8AsDm9gi3qOebVZuGNt7Rd5YseZUaqHCT62ZT/7aFEawZq8pd7DMzG/V9
 dHILi72sw3qVg71n09MqfNGyQjJekbMuuV1SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819718; x=1731424518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qs8CIJI9FNLgFYKQ95LnbrwZ5pacpTewgyat0QZZtVU=;
 b=pvDyoBZ6ZfhbI1PgajYsd2Glxn/wOlzM7+EZ+P+NrdNsEagmGMtj0uIZpGljUgLVi4
 b9Vy55AbcEQPt1rGCwro1LNtzZ4iQfqQp7YyxAk2VFyxYsp4/SU41NBMxBkFs9vLXVoO
 gHBFR/kNCs37cmUlq4fO9RC06mvgErcu91c10l65w4cBnKuzpa04aRqP65Y/L3X+U1qL
 Ols+m4BtAaia9phBk5mqQBnt0VYkF7XvfX0q5zz6NRd/dQxyqnf29k5imjFPRl5028kz
 imkU7OX3t8r4eNSKhUTXqZVE2wU4cl3ZevElSiUnLzBPN2S4QF8wXobH8fkT2EB6c8By
 iBAQ==
X-Gm-Message-State: AOJu0Yzn+dwXcdec2V1m9lbCH9c3f9hBGf2qhIhzWQWFBQxwpP2ogVvU
 CfcRaS8y/JganFgZ7cveSfqGjrOSnNb0TThLajAV1BLP65awk3QRyi4klwM6mmZeROzucYFbzXJ
 g7he2ppjIlI6C2gZ8WxBr6Ac/oS2z3xV0IwER
X-Google-Smtp-Source: AGHT+IGtpU35j0ZU50W/w637a4UTIgsBeIjDE0GceUb4IoWwm/yzRM/1DG8SiU+SJW5YjlGSf6gfstIx6UMdxj1Ok08=
X-Received: by 2002:a05:6512:308a:b0:539:8d67:1b1b with SMTP id
 2adb3069b0e04-53b7ecf1ff6mr13159030e87.26.1730819717738; Tue, 05 Nov 2024
 07:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-6-sjg@chromium.org>
 <20241104135632.GK3600562@bill-the-cat>
In-Reply-To: <20241104135632.GK3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:15:05 -0700
Message-ID: <CAFLszTi4YEqRCVJ=vRTVHtSP=Ux2C8W=vg=3+VedVAdZuef3+A@mail.gmail.com>
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

On Mon, 4 Nov 2024 at 06:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 04, 2024 at 06:39:49AM -0700, Simon Glass wrote:
>
> > This doesn't build on arm64 at present, so drop it for now. We only
> > expect to run sandbox tests, so perhaps it isn't needed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  tools/docker/Dockerfile | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
>
> What is the build failure? Depending on what other prospects for arm64
> build hardware come through I'm hoping to look harder at more build
> options, not just sandbox (but of course, QEMU shouldn't matter what the
> host is).

field-initializers -Wnonnull -Woverflow -Wvla -Wpointer-to-int-cast
-Wstrict-aliasing -Wvariadic-macros -Wvolatile-register-var
-Wpointer-sign -Wmissing-include-dirs -Wmissing-prototypes
-Wmissing-declarations -Wformat=2
686.0 checking for aarch64-gcc...
/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
686.0 checking for aarch64-objcopy...
/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-objcopy
686.0 checking for aarch64-strip...
/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-strip
686.0 checking for aarch64-nm...
/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-nm
686.0 checking for aarch64-ranlib...
/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-ranlib
686.0 ./configure: line 32517:
/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc: No such
file or directory
686.1 checking which extra warnings work...
689.6 checking if compiling with clang... yes
689.8 checking for options to compile assembly...
689.8 checking whether -freg-struct-return works... no
690.0 checking for options to get soft-float... no
690.8 configure: error: could not force soft-float

I suspect it is just that the toolchains need fiddling. I'd much
rather get something running and iterate on it after that.

Regards,
Simon
