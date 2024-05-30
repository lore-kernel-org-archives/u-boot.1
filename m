Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15EBC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 09:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8798849A;
	Thu, 30 May 2024 11:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Jr24n506";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5744E88253; Thu, 30 May 2024 11:13:22 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6658867C
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 11:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=patrick.barsanti@amarulasolutions.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52ac0c4b62cso684111e87.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1717060399; x=1717665199;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NXzUq4GK8fK5Dhgix1LfLJxl4xpC6KZn9H1pdvvEmno=;
 b=Jr24n506AmswcLUviOSRVf3HbxpiXyA3OiYOWp1bYvKa2+4IT8XkFjoG6wbefFwrKy
 UbvXWVFuU3tNaImvYogELoCEZKdRJ/LCB7Mb5IiG2J6jPQikkg8OJ4vNOw4tUGWlU2Tj
 QC4e/UA3bFRZJW71EB4lsBby3Rm1PZch6sP74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717060399; x=1717665199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXzUq4GK8fK5Dhgix1LfLJxl4xpC6KZn9H1pdvvEmno=;
 b=ftls1iIMHP5q+pc3abtx34fFbM3azsslPTfnu8gtPMsaPRmAA4ax2TVrUnCCYJUFhk
 Co0HGQG1X0vKOPFtPjFkieJbuWG+o8K29+R2eNeaiI27JIaX+W5dt7FQPjLuKvXX1JEc
 XHCGvYTEfSqEgYmBxx+PJqoovbEvxGi2/BYhej89l0D0siOq7GZu9ZB+TkiF7VsPZ2V8
 J44PMlbIaUTOLcwl46xqBUc9jw2xA6t0nKEGv8nMFtv/y7QA0IH63WJCBiXZ5g1DyDmk
 4uH2cpvKWQxGBCUBE+JUgMxFbBABbu7GGZ1yfuSnZz3GHbV4XnZwO9s9j42JjHuvYhSv
 s+PA==
X-Gm-Message-State: AOJu0Yz54OSZ2KEmM12Kh/T77ygtr9Rdkr+8fDyXYtDIPlTzfuXqbxsv
 zSmyOSd1oA5SfkSA7/KA9oEt1RjhGRSLETv+DlGSc8NoXCEnHxT6q6T5GPXHRpgcu1P+Bgwz0ky
 OSxysA5GvqA3sRon4CdCS4EpTL28SdnGQ06XS/g==
X-Google-Smtp-Source: AGHT+IGpJBcvXhQyBQ1J03HKWQ2H56OIumO6StJILsTxlUf1BwK3okOOr9Yad3cj1vdUxYr6Sy8/IjRSRGCri+TIJuM=
X-Received: by 2002:ac2:44cb:0:b0:52b:7c6f:cef3 with SMTP id
 2adb3069b0e04-52b7d4288c9mr835307e87.25.1717060399068; Thu, 30 May 2024
 02:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240528084224.113385-1-patrick.barsanti@amarulasolutions.com>
 <CAFA6WYOGXA7rPoVG_dJTfMYmKXS=Zik+9saP70Sc82C2L_mFUQ@mail.gmail.com>
 <CABxfhNcAArLz618Z4441uVqFZrBATrRJweoU2RjMPP2WyxGnWA@mail.gmail.com>
 <CAFA6WYN1SH-f8p3-odQz2cfHiS625jMgR_NXninVExcdjyynYg@mail.gmail.com>
In-Reply-To: <CAFA6WYN1SH-f8p3-odQz2cfHiS625jMgR_NXninVExcdjyynYg@mail.gmail.com>
From: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Date: Thu, 30 May 2024 11:13:08 +0200
Message-ID: <CABxfhNfWdD0NjPNskaxZxDTg9pDoDx5vBHrN9chvMh5Xo_7Kzg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix include directory for OF_UPSTREAM
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, afd@ti.com, marek.vasut+renesas@mailbox.org, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu, 
 linux-amarula@amarulasolutions.com
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

Hi Sumit,

On Wed, 29 May 2024 at 14:00, Sumit Garg <sumit.garg@linaro.org> wrote:

> On Wed, 29 May 2024 at 14:45, Patrick Barsanti
> <patrick.barsanti@amarulasolutions.com> wrote:
> >
> > Hi Sumit,
> >
> > On Wed, 29 May 2024 at 08:57, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> Hi Patrick,
> >>
> >> On Tue, 28 May 2024 at 14:16, Patrick Barsanti
> >> <patrick.barsanti@amarulasolutions.com> wrote:
> >> >
> >> > Always prioritizing u-boot includes causes problems when trying to
> >> > migrate boards to OF_UPSTREAM that have divergent devicetree files
> with
> >> > respect to the upstream ones.
> >> >
> >> > For example, migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
> >> > breaks it, as there are some missing defines in the local dtsi file;
> >> > the solutions would be to either patch it, which defeats the purpose
> of
> >> > OF_UPSTREAM, or delete it entirely. This last option would then break
> all
> >> > the other boards which have not yet been migrated to OF_UPSTREAM.
> >>
> >> Can you elaborate more here regarding which dt-bindings headers
> >> conflict? Also, is it only the DTS files consumer for those headers or
> >> there are U-Boot drivers depending on them too?
> >>
> >> -Sumit
> >
> >
> > Sorry, I think I have worded my commit message wrong. I should
> > have used differ instead of diverge, which is slightly misleading.
> >
> > The specific case I am talking about can be found in:
> > include/dt-bindings/clock/imx6ul-clock.h
> > dts/upstream/include/dt-bindings/clock/imx6ul-clock.h
> >
> > The local header is missing the last commit from the kernel, which is
> > 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support").
> > This added some new defines, which are not present in the u-boot
> > header.
> > Following this commit, the `imx6ul.dtsi` was patched in the kernel to
> > use one of the new defines.
> >
> > Because of this, at the current state, migrating a board which is
> > somehow based on `imx6ul.dtsi` will give a dtc error given by a value
> > being used in the upstream dtsi which is not defined in the local
> > header, because local includes always have priority with respect
> > to upstream ones even when setting OF_UPSTREAM.
>
> So you should just drop the local DT bindings header:
> include/dt-bindings/clock/imx6ul-clock.h and that should resolve the
> problem for you, right?


Yes, that indeed solves my problem.
But if I drop it, I will force all other boards which are not yet
migrated to OF_UPSTREAM and include `imx6ul.dtsi` to
use the upstream header instead of the local one.
I did not feel comfortable in doing so, because if any change is made
to the upstream header in the future which is somehow not backwards
compatible, then all boards which are still not using OF_UPSTREAM
would not compile.

I also thought this would not be limited to the single header file which
caused my problem. I imagine there would be other cases of local
headers which are missing one or more commits from mainline kernel
and cause the same type of problem when moving to OF_UPSTREAM.

The opposite problem also exists.
For example:
675575880f ("phycore-am64x: Migrate to OF_UPSTREAM")
does not drop include/dt-bindings/net/ti-dp83867.h, and I think the
migration worked properly only because at the moment there is no
difference between local and upstream headers.
If and when the upstream headers and devicetrees will be patched,
this will cause problems, because the local include will be used
even if it's out-of-date.
I have tested this: by simulating a kernel patch to the upstream files,
which adds an extra define in ti-dp83867.h and updates
k3-am64-phycore-som.dtsi to use this new define, current state
u-boot will fail to build because that define is not present in the local
include header.
By including my patch, the build is successful.

This is the reason why I proposed this Makefile patch, but of course I
am completely open to suggestions and ideas better than mine, which
I suspect are fairly easy to come by :)

Thank you,
Regards,
Patrick


>
> -Sumit


> >
> > Regards,
> > Patrick
> >
> >>
> >> >
> >> > The opposite problem also exists: by always prioritizing upstream
> >> > includes, if changes are made in the kernel headers and devicetree
> >> > files that are not backwards compatible, again all boards which have
> not
> >> > been migrated to OF_UPSTREAM will break.
> >> >
> >> > This patch fixes this problem by prioritizing upstream includes when
> >> > `CONFIG_OF_UPSTREAM=y`, while keeping current prioritization when
> >> > it is not.
> >> >
> >> > Signed-off-by: Patrick Barsanti <
> patrick.barsanti@amarulasolutions.com>
> >> > ---
> >> >  Makefile | 14 ++++++++++++++
> >> >  1 file changed, 14 insertions(+)
> >> >
> >> > diff --git a/Makefile b/Makefile
> >> > index 79b28c2d81..899ae664ca 100644
> >> > --- a/Makefile
> >> > +++ b/Makefile
> >> > @@ -826,6 +826,19 @@ KBUILD_HOSTCFLAGS += $(if
> $(CONFIG_TOOLS_DEBUG),-g)
> >> >
> >> >  # Use UBOOTINCLUDE when you must reference the include/ directory.
> >> >  # Needed to be compatible with the O= option
> >> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> >> > +UBOOTINCLUDE    := \
> >> > +       -I$(srctree)/dts/upstream/include \
> >> > +       -Iinclude \
> >> > +       $(if $(KBUILD_SRC), -I$(srctree)/include) \
> >> > +       $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
> >> > +               $(if $(CONFIG_HAS_THUMB2), \
> >> > +                       $(if $(CONFIG_CPU_V7M), \
> >> > +
>  -I$(srctree)/arch/arm/thumb1/include), \
> >> > +                       -I$(srctree)/arch/arm/thumb1/include)) \
> >> > +       -I$(srctree)/arch/$(ARCH)/include \
> >> > +       -include $(srctree)/include/linux/kconfig.h
> >> > +else
> >> >  UBOOTINCLUDE    := \
> >> >         -Iinclude \
> >> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> >> > @@ -837,6 +850,7 @@ UBOOTINCLUDE    := \
> >> >         -I$(srctree)/arch/$(ARCH)/include \
> >> >         -include $(srctree)/include/linux/kconfig.h \
> >> >         -I$(srctree)/dts/upstream/include
> >> > +endif
> >> >
> >> >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> -print-file-name=include)
> >> >
> >> > --
> >> > 2.43.0
> >> >
>
