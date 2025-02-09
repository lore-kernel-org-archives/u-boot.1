Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984DEC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D48807D7;
	Sun,  9 Feb 2025 22:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QaWAGhxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5C5807FE; Sun,  9 Feb 2025 22:04:37 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F1C803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so691389566b.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135074; x=1739739874; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xysC8pRsBWt1EKiQXPeD6S5rwE0A7GGLfTzpJjp2AsY=;
 b=QaWAGhxYPI1Am+4TPI8wRcpTxuAsDcP02wpsj+fmwry5rPCbIVvm8fkVTypQJ+3MeL
 aK7GIR79UqPrKqM9mVXsbDzUVx2fDYZXHLeOwXDMawmXxjtUHq31F4BwHCu3YzmnUvfc
 /UEEeNBvTTPf0NbGiQTTo2pxR3FqYUiOQCSWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135074; x=1739739874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xysC8pRsBWt1EKiQXPeD6S5rwE0A7GGLfTzpJjp2AsY=;
 b=R/aw3XQAGtviTgFo/VnbrsHkq1vHIhA3+yJfTEpD8gfQ6l2XighMjkOBbL0aQjaEbC
 RAmo2dspdmKYASQ1tc+D2cNWR8sWcWspnWCPjgvDDeuN3yETKjfKO1AdETwNIw0pBVoE
 /YxbCHt0TDHD9kEKojONoTfwEWHFqiptiHxB3ktehIX3tnSvw1ekU4udIC+y2mIvRgxP
 amsFRYZtFMvixXsTxOcwOcO7b5GW8Olk0UfxERBHDNLQrGmhWXcL2Exd6cLrGotM2xhe
 SwRw6d2nnNQzcXAIf8UfBz11TE1T1gj/zhmIwf2wEhPnFtl2k0u5m9+dd792GO/eSfkT
 l4iA==
X-Gm-Message-State: AOJu0Yy0IOrYE47y5zg6jZtSCZz3wNxP77zFv+T/VHUbBx/Yl1x0rS8A
 It2ZurJaATgmN/Q8ieY7oRWrxJ/a7wjahI6TBScoaojCdDl0Xm4gvx3CVrlzDYB/0/YYTpeJp3g
 0wWbiI+09/1FVhqLa8g0AsO+4+pS/2V17zYN+
X-Gm-Gg: ASbGncu1opjI5J5rrn9Fs3zT1z7zAv4Gmf1v79y6eennGb8tTBYztfe/luZQBPEBNtt
 wN+mWBQTgNY0mODC/t7MIu4dWH658Pwt4n2FyUxLETFLZ5EmevLVzKXFRlthIYC9aUSBvaz2Ejw
 ==
X-Google-Smtp-Source: AGHT+IF+y6is+7O8uvrh3IBpeSo8qkw4RlXBCdRRuJIU2+cYvVUs5+YkSJA5e7PjTw6ERrxn5TRuX/xPD5457+eSeXE=
X-Received: by 2002:a17:906:c144:b0:ab7:b2a7:9cb8 with SMTP id
 a640c23a62f3a-ab7b2a7a565mr356594766b.15.1739135074590; Sun, 09 Feb 2025
 13:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-26-sjg@chromium.org>
 <20250209181404.GW1233568@bill-the-cat>
In-Reply-To: <20250209181404.GW1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 14:04:22 -0700
X-Gm-Features: AWEUYZk1uPinutIxSkOd0tjPwtBgdeGeCo3raovjAp6AYpQMfghmhTiZa2gqf-Q
Message-ID: <CAFLszTjBVFY5AnscRhCa9St+mi9zfSdeeTMEStNcgnjRUGSigg@mail.gmail.com>
Subject: Re: [PATCH v2 25/29] efi: Generate the app as a shared library
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>
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

On Sun, 9 Feb 2025 at 11:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 08, 2025 at 10:11:45AM -0700, Simon Glass wrote:
>
> > The app should be built as a shared library, with position-independent
> > code and the -shared flags. Update the Makefile to handle this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index f989c31073f..b3b13e29c26 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -452,9 +452,13 @@ KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> >  KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> >  endif
> >
> > +ifdef CONFIG_EFI_APP
> > +KBUILD_CFLAGS += -shared
> > +else
> >  # Don't generate position independent code
> >  KBUILD_CFLAGS        += $(call cc-option,-fno-PIE)
> >  KBUILD_AFLAGS        += $(call cc-option,-fno-PIE)
> > +endif
> >
> >  # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
> >  UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
>
> This should be tidied up with x86 being updated as well. In fact the
> comment there isn't entirely useful as we still pass that with
> CONFIG_POSITION_INDEPENDENT=y.

They are slightly different things.

POSITION_INDEPENDENT - controls how TEXT_BASE is figured out before relocaiton
position-independent code - tells the compiler what to do. and we want
this so we can relocate at the end of board_init_f()

I can enable POSITION_INDEPENDENT in the ARM EFI app (like it is in
x86, probably erroneously). Yes it gets rid of TEXT_BASE, but more as
a side effect.

Perhaps POSITION_INDEPENDENT should be called POSITION_INDEPENDENT_F ?

Or perhaps it can have a dual meaning?

>
> Setting flags should also likely be handled in board/efi/config.mk.

Oh yes, good idea.

Regards,
Simon
