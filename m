Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD8BC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D4A8803A;
	Wed, 27 Mar 2024 15:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oWHUDXje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 380668803A; Wed, 27 Mar 2024 15:07:33 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F7C88019
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5a47cecb98bso3887515eaf.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711548449; x=1712153249; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YkBuoe4BKrrTOna0fyn4iW7YlEsNFn+gDMEvvkEjyG0=;
 b=oWHUDXjeGmRIHvve28UVJnbuYe4ss8juuAIQJkZaj/AY/fWnCcoVYZE+4viF9T3fk4
 LUlTyNhZqLMTekOFE+RmycrRhsg/dkbWHXoK7hCiV6TKc/1VrF5AUrHyrQx3Y3kHqwTc
 +0vMy00afptJW0OuRBlUMzmSNYVuvVSQGd0TpdY5mlZP/VZtQdTaEmQSuLNtyiK3UlBK
 Eit9I/VXroNUbtfI+MvOBbGKplAXS7ylSV8kn/qtCJNwNsl5uh03yt3zyHGM2XB0ozDm
 Z6MsreYkm+EZf/NHZc2/6KQLDwipPbQi5Sni0qNRinAx4PvKfPRIoBbIajQCQZW8245X
 IFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711548449; x=1712153249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkBuoe4BKrrTOna0fyn4iW7YlEsNFn+gDMEvvkEjyG0=;
 b=b8XjIX6bM2xPv/aSs9i+cMbzKO/kOz0foLeyEiECbY+N5QgnxM9JYHBwLSbz7IKwBv
 1+V8K3aZ5EFlLS80SeXhiSXt18EpyjXeorfwomMGI+hvQTTaUHFSZkTL9YjWWBUXTXjh
 2k9boUQf+pL8PDXo5EpdzuPuv2AALNPAhmGzFB9UgUuTCeX3EL1bI0uoyWJMWfj9/6p7
 f4oJ6yqdMwaBLMKwkr10DqJrkkPmYTw+UfXG3sS8H1FSTCcE6xqEQdIAavaeEqvRIiqO
 MAp0VOGhq+m4Wwzn98/hxKVmRUwIVL1bB3dnLf9I4ZU4ghSmY+61SRtHahcAqyYdrkcT
 LfXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURm4vZCeUMBVLo+1SQqv3ZP/5nyZ8tfmhFzbkeOWF0IubhKBJYVJypAhAdqq+EQ/GlrQQzNZak5JxplRZiStT8cK4zHA==
X-Gm-Message-State: AOJu0Yz7pIFHdtaHrUYFUFfFYqVWxB+1QBQ5Vb6HepzhGNXv7OCRvzcX
 EnvT9n5m7+iM7tqo2jdMq079Xma/heKFKy87hFqzDMwtI7xCW4MEbG69Y0erud/dmn1L0YIyq4G
 3bBwXfV+6M45Fl/yYk4jA+iu6UipKzD0btYngHg==
X-Google-Smtp-Source: AGHT+IFtmEdjK2hWywcRBJHfEmugkNhPXzwqIExMcNFSEAO2SZemlJ3Q7+dljZU5fYkZA+jeZMkgYjYW+1x65cVj2eU=
X-Received: by 2002:a05:6359:4c15:b0:17c:1b6e:e4f5 with SMTP id
 kj21-20020a0563594c1500b0017c1b6ee4f5mr1325068rwc.27.1711548448696; Wed, 27
 Mar 2024 07:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
 <20240327-imx93-of-v1-5-afab6b31422a@nxp.com>
 <CAFA6WYPb9wg128rYu_76d1vh2q47TfRgkF1e3LOaJfGMpGEaQg@mail.gmail.com>
 <DU0PR04MB94178343791A449EEEB4811788342@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94178343791A449EEEB4811788342@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 27 Mar 2024 19:37:17 +0530
Message-ID: <CAFA6WYMn=Ndq0S7TJbFe=yDBG7RkL9OZA_JXj9Cm5TVEKWF5uw@mail.gmail.com>
Subject: Re: [PATCH 5/6] Makefile: tune the include order
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, 27 Mar 2024 at 19:01, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH 5/6] Makefile: tune the include order
> >
> > Hi Peng,
> >
> > On Wed, 27 Mar 2024 at 18:41, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > For OF_UPSTREAM support, the U-Boot headers under dt-bindings/ maybe
> > > different with OF_UPSTREAM headers. So let OF_UPSTREAM headers be
> > > included first when migrating to OF_UPSTREAM.
> >
> > No, please don't do that. The current include order gives preference to the U-
> > Boot headers under dt-bindings/ such that we don't break platforms which
> > haven't converted to OF_UPSTREAM.
> >
> > So while migrating to OF_UPSTREAM, you should just drop redundant
> > headers under dt-bindings/ instead.
>
> But while in the middle that some boards using OF_UPSTREAM, some not,
> we could not drop that.

That's the real reason why we should try to migrate to OF_UPSTREAM at
SoC level rather than at board level. If a particular board isn't
supported upstream then they can opt out for the time being.

>
> I could sync the dt-bindings header first to avoid break anyway.

Once you do that sync then there won't be any reason to keep headers
under dt-bindings/.

-Sumit

>
> Regards,
> Peng.
>
> >
> > -Sumit
> >
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  Makefile | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index b80924241ec..b9c2d896c2e 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -827,6 +827,7 @@ KBUILD_HOSTCFLAGS += $(if
> > > $(CONFIG_TOOLS_DEBUG),-g)  # Use UBOOTINCLUDE when you must
> > reference the include/ directory.
> > >  # Needed to be compatible with the O= option
> > >  UBOOTINCLUDE    := \
> > > +       -I$(srctree)/dts/upstream/include \
> > >         -Iinclude \
> > >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> > >         $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
> > > @@ -835,8 +836,7 @@ UBOOTINCLUDE    := \
> > >                                 -I$(srctree)/arch/arm/thumb1/include), \
> > >                         -I$(srctree)/arch/arm/thumb1/include)) \
> > >         -I$(srctree)/arch/$(ARCH)/include \
> > > -       -include $(srctree)/include/linux/kconfig.h \
> > > -       -I$(srctree)/dts/upstream/include
> > > +       -include $(srctree)/include/linux/kconfig.h
> > >
> > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> > > -print-file-name=include)
> > >
> > > @@ -907,7 +907,7 @@ ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
> > > PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a  else  ifndef
> > > CONFIG_CC_IS_CLANG -PLATFORM_LIBGCC := -L $(shell dirname `$(CC)
> > > $(c_flags) -print-libgcc-file-name`) -lgcc
> > > +PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags)
> > > +-print-libgcc-file-name`)
> > >  endif
> > >  endif
> > >  PLATFORM_LIBS += $(PLATFORM_LIBGCC)
> > >
> > > --
> > > 2.35.3
> > >
