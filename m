Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07642D6A25E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A6789618;
	Fri, 15 Nov 2024 15:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kAApq6bR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7622089618; Fri, 15 Nov 2024 15:27:43 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE663896B9
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7f12ba78072so1455487a12.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680859; x=1732285659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D0SntURYapU/5d6WVQpx546mIzYVKfu76Rp/EYgZEno=;
 b=kAApq6bRA5JE9Z9AG205ToP4G1coITsnzCrjab8k7aEx7h/qD87zhAOoeM70KwYWAX
 dUL/DO2eQ0svE4XVIAzfrg09CQ7rcE/sPl3uG6kdi8g83cB0J7xF5yoMUFfk+E8T7FxM
 Y38Mzv7LxUwX423R1/Ximut/JvVHyYxWUWS6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680859; x=1732285659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D0SntURYapU/5d6WVQpx546mIzYVKfu76Rp/EYgZEno=;
 b=cn3/UucC14RiTJ72HIUViBL+jSWnJHvnTtldbtDgj6Uiw+8ecWGejyUtL3Uvcpqfmi
 TuOI5H3EMc3gKh3YrglKZuJOZQdBO3ZnMz0dXhtBKrK20kmDPJlgU7RjK5xCupco/mK4
 ENuReJZY2twSEwJynhUL7G9zPl+HKh9vDt+RyO+ZV5Tnauw5d4Rwzm9PPQrZK+hYNi1z
 +5wzP2gig6iJwdoX0ejdP/9Cr5aOjXwA4yi+Fiu9mOsTpL5RW6KHeZf9D2qJqDwCeWdD
 5WUGGKs+Qww46OhgJTb/H+1+w3ina4HKqcNF63fOuuhsVsw/ClB9UrI1E7Yd4irJfgHn
 Ub2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVclXOLg5zjcCZT0JRg5TDfCqpcXyabmuM6YG7Jw3Qw64Bsvi6ukC1B7gi8Rdz0sAX44o57jNA=@lists.denx.de
X-Gm-Message-State: AOJu0YwCxo8oNCeFfrcCWCKaCj8WcbjOSSKZi4O6zSU2RlAOU47qNWJo
 WTDCXDWdiin5bBH+QRuAJvjavfQ6B1wMc+mW+dSHFvaIRwPmpG0KVf3VvoC5Zxxs83w3eSaCqse
 5gmhYLxoELnt1rBZoiw0DeoKSE72VvQ5/8Kds
X-Google-Smtp-Source: AGHT+IH4zZkchJZ8c0JApXpcIZkh20pufCf0kYPeIOPXJmb1e4d+4ChwMg1OFXgDx2tlJGwofQUI3B1mYXrH7kh5Rvs=
X-Received: by 2002:a05:6a20:a125:b0:1dc:30b:324c with SMTP id
 adf61e73a8af0-1dc90ae8ab2mr3782731637.7.1731680859448; Fri, 15 Nov 2024
 06:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-13-sjg@chromium.org>
 <781168c2-355f-44c4-b2d8-341ba8132316@gmx.de>
In-Reply-To: <781168c2-355f-44c4-b2d8-341ba8132316@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:27:10 -0700
Message-ID: <CAFLszTgO0sE9e8BMKUh2J7_XWu9TD74G5OL-YNC26gx8OfsioA@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] test: Move str_ut test into lib
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 14 Nov 2024 at 04:10, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/2/24 20:36, Simon Glass wrote:
> > This test doesn't belong at the top level. Move it into the lib/
> > directory, to match (most of) its implementation. Rename it to drop the
> > unnecessary _ut suffix.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/Makefile                | 1 -
> >   test/lib/Makefile            | 1 +
> >   test/{str_ut.c => lib/str.c} | 0
> >   3 files changed, 1 insertion(+), 1 deletion(-)
> >   rename test/{str_ut.c => lib/str.c} (100%)
> >
> > diff --git a/test/Makefile b/test/Makefile
> > index 9f19bfa472b..220a249c397 100644
> > --- a/test/Makefile
> > +++ b/test/Makefile
> > @@ -14,7 +14,6 @@ endif
> >   ifneq ($(CONFIG_HUSH_PARSER),)
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
> >   endif
> > -obj-$(CONFIG_$(XPL_)CMDLINE) += str_ut.o
> >   obj-$(CONFIG_UT_TIME) += time_ut.o
> >   obj-y += ut.o
> >
> > diff --git a/test/lib/Makefile b/test/lib/Makefile
> > index ce22780eed8..be20bbc047f 100644
> > --- a/test/lib/Makefile
> > +++ b/test/lib/Makefile
> > @@ -17,6 +17,7 @@ obj-y += lmb.o
> >   obj-y += longjmp.o
> >   obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
> >   obj-$(CONFIG_SSCANF) += sscanf.o
> > +obj-$(CONFIG_$(XPL_)CMDLINE) += str.o
>
> Shouldn't this be CONFIG_$(PHASE_)STRTO, see lib/Makefile.

We don't allow the cmdline in any xPL build, so this is just checking
for U-Boot proper, in fact.

>
> I would not know why we need *CMDLINE as dependency here.
>
> Cf.
> https://patchwork.ozlabs.org/project/uboot/patch/20241113210646.88937-1-heinrich.schuchardt@canonical.com/

Yes, we don't.

Regards,
Simon
