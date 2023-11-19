Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E147C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 18:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439E4870E7;
	Sun, 19 Nov 2023 19:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LNCq2CJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A74868D1; Sun, 19 Nov 2023 19:24:03 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5EF869C4
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 19:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso5350770a12.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 10:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700418238; x=1701023038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OpWbDZKk0t9YGxJOtind4x9VtkT+kSzaDiHZa/vRsdY=;
 b=LNCq2CJyW5Gv+Drq2+ceFStzLcfDiJdRmLPA9uUoLwv8hT2pwjguhH0hK1Eo3iBibz
 PYlnAAG4+8ewDyWc4yhhkQm56miznyC+6lXV7c+rpXzEenzqRFVOdFRXJvaJP69DMrEC
 WNvshnnvvtpbxYBzHbp2fnc4FhnzImvsuJNLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700418238; x=1701023038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OpWbDZKk0t9YGxJOtind4x9VtkT+kSzaDiHZa/vRsdY=;
 b=NhNwPUBud8+L8GujEaC3qPJbgo+cXqybaHezZ8b4K9RRK1g+uEg62bEf4w5/HSJ5od
 B1WcJssIY6uwr8OjBB7UgmGz+BAUAAXMciv5TyKuBr/yu9uYPdidALsQ/EsTrTggOviN
 2iWG/Lb7HWHdHkZVoPHOhaWKa9Ps1GY3ULmt4jfoHKFpvlRchKbs1Wdg2Q5ia6t7B7BD
 G4tWiwtZ+VEyqkXdzHd18lXk5Qc0xrapNS43fnc5Bp3NVdgqnkdsAdz7NvDSIAOuQGhp
 cRCCne64scKkmdAvDEGsT6hPixa4OQGItpYbF/aUXxAgBcQNuG7H0E8t3d4WlwybEYaS
 YrEA==
X-Gm-Message-State: AOJu0YwvmTVwBaYQjud6ZLSYgJ73OZJJ5GDf0jxnFjwFg/RUFy8psprb
 FUi9sN+IiNHpSTLHlRs9Xyj7xjGX7ELylkPdc/gzBg==
X-Google-Smtp-Source: AGHT+IFzgbWjkgx2J8IGboo54K/y15YBiOB2xzx+4SxOdcAE/b+S8a1A8jz0z+ssi1V56Hn9dRN4XnEwQfXU/w12nKw=
X-Received: by 2002:a17:907:3f19:b0:9d0:51d4:4d87 with SMTP id
 hq25-20020a1709073f1900b009d051d44d87mr5528778ejc.62.1700418238123; Sun, 19
 Nov 2023 10:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20231119144700.631322-1-sjg@chromium.org>
 <20231119144700.631322-2-sjg@chromium.org>
 <20231119155909.GC2513409@bill-the-cat>
In-Reply-To: <20231119155909.GC2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Nov 2023 11:23:41 -0700
Message-ID: <CAPnjgZ0LDXcstrAgx8nb53Cw1=1Y8Zait-e884A5i8H5CY6hnQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] cyclic: Disable in SPL builds
To: Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Sun, 19 Nov 2023 at 08:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 19, 2023 at 07:46:39AM -0700, Simon Glass wrote:
>
> > The cyclic subsystem is currently enabled in all build phases or none.
> > So far it doesn't have any purpose within SPL builds, so adjust the
> > rules to prevent it being built in that case.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/Makefile  | 2 +-
> >  include/cyclic.h | 6 ++++--
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/common/Makefile b/common/Makefile
> > index 1495436d5d45..27443863bf9b 100644
> > --- a/common/Makefile
> > +++ b/common/Makefile
> > @@ -77,7 +77,7 @@ obj-$(CONFIG_CROS_EC) += cros_ec.o
> >  obj-y += dlmalloc.o
> >  obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
> >
> > -obj-$(CONFIG_CYCLIC) += cyclic.o
> > +obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
> >  obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
> >
> >  obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
>
> This is fine, but I suspect we're missing SPL_CYCLIC as a symbol and
> SPL_WDT should be select'ing that, same as "WDT".

Ooops I had assumed that it wasn't used in SPL but of course watchdog
is completely migrated to it now...I will add a symbol.

BTW the watchdog Kconfig seems a little confusiing. There is only one
board using WATCHDOG without WDT and only 3 using HW_WATCHDOG

Setfan, I wonder if some more clean-up could be done?

>
> > diff --git a/include/cyclic.h b/include/cyclic.h
> > index 44ad3cb6b803..d3b368dd90df 100644
> > --- a/include/cyclic.h
> > +++ b/include/cyclic.h
> > @@ -11,6 +11,7 @@
> >  #ifndef __cyclic_h
> >  #define __cyclic_h
> >
> > +#include <linux/kconfig.h>
> >  #include <linux/list.h>
> >  #include <asm/types.h>
>
> Is this really needed? What's blowing up since we should have -include
> .../linux/kconfig.h cover this.

It is the CONFIG_IS_ENABLED() when building. We have kconfig.h in a
few other places (used by tools) too.

In file included from include/watchdog.h:13,
                 from tools/../lib/sha1.c:25,
                 from tools/generated/lib/sha1.c:1:
include/cyclic.h:47:22: error: missing binary operator before token "("
   47 | #if CONFIG_IS_ENABLED(CYCLIC)
      |                      ^

Regards,
Simon
