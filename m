Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58197C25B10
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 01:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F8488011;
	Sat, 11 May 2024 03:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CC+hGclB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD1F88027; Sat, 11 May 2024 03:09:30 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA13C87FC7
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 03:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-602801ea164so1816841a12.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 18:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715389766; x=1715994566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bSySRaTmCw4tv8iXaqJNFUyCXuCC53jTyjixrDGvrlg=;
 b=CC+hGclBzNpIOJaA+ru7ffJRuyZBf+wh09HeHlP/a15RWBLvbi1k6CNW4hDTbTLYxC
 2TvIhaexvx/AnRKksynlPiTgcaGs+wiJW2ycBO1w3gHypmde/I3N4s6gD9rIp1kEIvmP
 tTawxrdlo1UFIE5rxtYJlpBorW/NKVy9RR5+yQPOmKYoX5rYcXAOlhqeGC8otUXBvjL2
 4QdN9Lk+ZG70l5p9n2pD1p9eDAUicy1Iv5UxFYfByeuySZAcnHzCEl2KKuREtuc9MVjm
 aDPZ4hAgC0dZco9kEZzuAXh0ThWUJknuASdSikShALowkh2PYXurAz62OnQJ2Z1y0Zp+
 UW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715389766; x=1715994566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSySRaTmCw4tv8iXaqJNFUyCXuCC53jTyjixrDGvrlg=;
 b=IRQgCMiwWwTl0bBqxhUWoboTEcnz0YfAgryX+dOFAbP0ZWYFqE+SoeMcGrNaeB3bPT
 XK3qw3pU45mQTO0v0poQAeCp4dNccVhEtMzkFw8Oi4hyJfFMWjqyQqe9Y+ZgzUotcDww
 kwQSNYjP1CHzhs0fhm34VjhG5Hsb4IJb9mc2O9Z2FONLMfWYpEXB+ubLChQBSIHKltV8
 6b8R9yPSFJA+V7M6hdPETP3jbKo59h2jJe9vbcvkYB9tq1kNacOmymNMnVDeHvpyYHeA
 Qrdxb8WMCAUQnTswJBFa5N7mnAij6ZNR4ZichRPZs1zjYlBSgL9D6hTibCF8gsZvBbs8
 wAaA==
X-Gm-Message-State: AOJu0YzoNnvk5NZ2Z+0F8uz/4b6xUHGJzs1xcrSuVsrEjUiGBaVNeB9b
 j13MKMSuSzLJiMEPOQ+82bgRipLleK6UhZC6Jmen8luNR1jgU+pRFrb59CLqXGzpGXsO2FxjKWQ
 Z++t9RCyoygGd40OQk3HDmcqMfr+VsQrZG8N7qg==
X-Google-Smtp-Source: AGHT+IG5gpwxu9Kioifs4aXxcUHn6MQBBpkpKNp4/zgducQE5eB8mJNo5MrcB2K/BgArfUyQHY6aMemLiqEpFwRBHL8=
X-Received: by 2002:a05:6a20:d80a:b0:1ae:42b1:abb2 with SMTP id
 adf61e73a8af0-1afde0a4182mr5043359637.2.1715389766225; Fri, 10 May 2024
 18:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
 <20240507211643.GY2568172@bill-the-cat>
 <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
 <20240509151133.GJ2568172@bill-the-cat>
 <CAEfUkU+Ax6o8NnL=e3Tm+-75HMbXpa5zqMm5TS3EpqY79GAEXw@mail.gmail.com>
 <20240509153100.GK2568172@bill-the-cat>
 <CAEfUkULtQdPYmSdj0qgRaWsNBQvxSFZP00+u0F57J4K+tLhfyQ@mail.gmail.com>
 <20240509154306.GL2568172@bill-the-cat>
In-Reply-To: <20240509154306.GL2568172@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 10 May 2024 21:09:13 -0400
Message-ID: <CAEfUkULvHMqdD4ZaF7kXthoBvvEFb5DZEUgw5UyoWf1xoU8HLQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] mbedtls: add mbedtls into the build system
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Davis <afd@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 9 May 2024 at 11:43, Tom Rini <trini@konsulko.com> wrote:

> On Thu, May 09, 2024 at 11:36:37AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Thu, 9 May 2024 at 11:31, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Thu, May 09, 2024 at 11:23:11AM -0400, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 9 May 2024 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Thu, May 09, 2024 at 11:04:07AM -0400, Raymond Mao wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 7 May 2024 at 17:16, Tom Rini <trini@konsulko.com>
> wrote:
> > > > > >
> > > > > > > On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:
> > > > > > >
> > > > > > > > Port mbedtls with dummy libc header files.
> > > > > > > > Add mbedtls default config header file.
> > > > > > > > Optimize mbedtls default config by disabling unused features
> to
> > > > > > > > reduce the target size.
> > > > > > > > Add mbedtls kbuild makefile.
> > > > > > > > Add Kconfig and mbedtls config submenu.
> > > > > > > [snip]
> > > > > > > > diff --git a/include/stdio.h b/include/stdio.h
> > > > > > > > index 3241e2d493f..874279c60dd 100644
> > > > > > > > --- a/include/stdio.h
> > > > > > > > +++ b/include/stdio.h
> > > > > > > > @@ -3,6 +3,7 @@
> > > > > > > >
> > > > > > > >  #include <stdarg.h>
> > > > > > > >  #include <linux/compiler.h>
> > > > > > > > +#include <vsprintf.h>
> > > > > > > >
> > > > > > > >  /* stdin */
> > > > > > > >  int getchar(void);
> > > > > > >
> > > > > > > Is this really needed? I know our include structure is a bit
> odd.
> > > > > Should
> > > > > > > we perhaps look at moving a prototype or two around to be more
> > > broadly
> > > > > > > compatible?
> > > > > > >
> > > > > > Then we need to move  prototypes of snprintf, _vprintf,
> putc_outstr
> > > and
> > > > > > printf_info from tiny-printf to stdio.h. Is this good for you?
> > > > >
> > > > > I don't quite follow you but yes, please work it up for review at
> least
> > > > > as I'm not too thrilled with adding <vsprintf.h> to <stdio.h>
> after the
> > > > > work I did removing <common.h> showed some fun around those
> headers as
> > > > > well, and I'd like to sort it out correctly.  Thanks.
> > > > >
> > > > > When MbedTLS native codes include <stdio.h>, they expect to have a
> > > > prototype
> > > > 'snprintf', that is the reason why I hijacked <stdio.h> as we are not
> > > going
> > > > to
> > > > change MbedTLS native codes.
> > > > I mean in v3, I can move 'snprintf' related stuff to <stdio.h> so
> that we
> > > > don't
> > > > need to include <vsprintf.h>.
> > >
> > > Yes, I would suggest doing a branch where you just make that change to
> > > stdio.h and see what the build fall out is on -next. I would not be
> > > surprised if it requires a bit of work. It's work that needs to be done
> > > and is worth doing, but might be... large.
> > >
> > > Yes, I can do this before posting v3.
> > If it affects too much, it would prefer to just keep the <vsprintf.h>
> > though...
>
> No, if it effects too much I'll just have to do a series to move things
> around. Which I will do, soon, if needed.
>
> I made a patch to move snprintf to stdio.h, please see the last commit from
https://github.com/u-boot/u-boot/pull/533

If you are fine with it, I will include it into the prerequisite series v2.

Regards,
Raymond
