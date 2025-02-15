Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293A3C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985CE80F10;
	Sat, 15 Feb 2025 04:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XS+V6pxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C2880F30; Sat, 15 Feb 2025 04:23:28 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D941780EFB
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso448103766b.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589805; x=1740194605; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ml15YZQQfeDjCBh9y8F3bob+wASit6ubub67jvul4ik=;
 b=XS+V6pxNCdMFB1rRT4XSq9WCBq8q3MoGh5kA8uZFP2M3RJ0Nc7LpamQgmY5j1cZsqO
 fK05dKsFni0clItZ2Kb7FEaLVEGHS/u3m/nIrxvtF6hV7CEM8Rv4wPEv0WboCQLoYB9h
 mT0po3TPF43+GtQvrRm8JU5F3112lle0jo2v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589805; x=1740194605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ml15YZQQfeDjCBh9y8F3bob+wASit6ubub67jvul4ik=;
 b=a5MkJNew0yozJ1rCJnV8/7IGMM8OAUePDB0+Fo9FOW4F8WOeZ3PlLlC017GUU8ozuD
 mBKJ+ht1wNkZ/Pm/zz0aBJuJFmPuc0Z2T7uxfYz9h/ewC0uHxl4K0PbD6Jx6SqQb21p6
 aZQYJcGRQ5huhmqwz3j1XKN9zZ37d+9Ytcfl06UYSCC9RMmAnrkESv2R+yV9fcjvU+AG
 nnMHrTBYbCHHxgvyiyli1smyPn1OSZh/j4yVMqHNL2873r7Dv+dhq4qDixvIrDKCrJ4M
 R0DMsNyHDtmooNAevIMu6Yt5mgSu/qkpuwqhiaUwYtRDaQ2rIvccnui3XcudN4BXNmb0
 G59g==
X-Gm-Message-State: AOJu0YzkcJqdoDwU+VVOn1rFWXFx4V5SFMDGR1Nl/EriIuFt8e7bzBen
 APxVAhYYKuu0h4gH3Jh3RoTUepASoKbx/Y1E5FIw3tWVphStsxxAbTZyv9CCTeJbqwP55yZVuFz
 ujwRPai3oiqHFfXOFpgk3kNRVJ6GlglMgcMN0
X-Gm-Gg: ASbGncvfS4yCQhrS5gtfEXQsKTaDVpE6ZxS8FORZosKk7rjGzAkQ3gOYyXtE4LB20/I
 mCPojG4t2on4CQM9jopRt/xkGzM6z1IsvHsYb8vDYm59ifiE2jH4SB7Hi8kR+QFdGMNOInxO7bg
 ==
X-Google-Smtp-Source: AGHT+IGd2NfU76O7ZxqJk8/pjtsmaqMPzk7ggsAKOU0sjb4td8xW8Mc2LgB9IwMSQkfp0U7v0yPK6SFpHybtfXoX+/M=
X-Received: by 2002:a17:907:70d:b0:aba:5e4b:b0b6 with SMTP id
 a640c23a62f3a-abb70e53b7dmr112668366b.54.1739589805566; Fri, 14 Feb 2025
 19:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-2-sjg@chromium.org>
 <20250209180525.GR1233568@bill-the-cat>
 <CAFLszTirjS5kcqGc=NV1RF_7bHhhGPyKhnfV8WyV0H2y=GCW_A@mail.gmail.com>
 <20250210145115.GG1233568@bill-the-cat>
In-Reply-To: <20250210145115.GG1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Feb 2025 20:23:10 -0700
X-Gm-Features: AWEUYZl5io3APD2ousUf-xC_dTRaXAtoUgPfo_Q-IcVRNHtSPFae2TM-8H7hOC0
Message-ID: <CAFLszThrOcKcPg3b+EZfAe15W+O4mUNCJbzhT3kV1gZTXzqr8g@mail.gmail.com>
Subject: Re: [PATCH v2 01/29] Makefile: Avoid using TEXT_BASE if not present
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
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

On Mon, 10 Feb 2025 at 07:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 10, 2025 at 06:06:38AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 9 Feb 2025 at 11:05, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 08, 2025 at 10:11:21AM -0700, Simon Glass wrote:
> > > > This value is only available if CONFIG_HAVE_TEXT_BASE is enabled. Add
> > > > conditions to avoid introducing errors in link scripts when it is not.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Depend on CONFIG_EFI_APP instead
> > > > - Drop change to u-boot-elf rule
> > > >
> > > >  Makefile | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 2f7614191a1..f989c31073f 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1050,8 +1050,10 @@ LDFLAGS_u-boot += -z notext $(call ld-option,--apply-dynamic-relocs)
> > > >  LDFLAGS_u-boot += --build-id=none
> > > >
> > > >  ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
> > > > +ifndef CONFIG_EFI_APP
> > > >  LDFLAGS_u-boot += -Ttext $(CONFIG_TEXT_BASE)
> > > >  endif
> > > > +endif
> > > >
> > > >  # make the checker run with the right architecture
> > > >  CHECKFLAGS += --arch=$(ARCH)
> > >
> > > We should just test for ifdef CONFIG_HAVE_TEXT_BASE as the second
> > > condition, that's already going to be never-true for EFI_APP.
> >
> > Yes, that's what I had in v1.
> >
> > The problem though is that the ARM app does have HAVE_TEXT_BASE
> > enabled at present.
>
> How?
> config HAVE_TEXT_BASE
>         bool
>         depends on !NIOS2 && !XTENSA
>         depends on !EFI_APP
>         default y
>
> is how we define the symbol.

I'm not sure what I was doing wrong, but it works now, sorry for
noise. I'll revert this patch back to v1.

Regards,
Simon
