Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73938C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 07:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9F287A10;
	Mon,  8 Jan 2024 08:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WRHXXNJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 307A987A21; Mon,  8 Jan 2024 08:18:37 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD1387946
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 08:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4670b3554ccso59604137.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 23:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704698313; x=1705303113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3IJUtLA31KDEmQZJf2wIpr2FmV2YYPsu2bBaA+p5br4=;
 b=WRHXXNJ1+x4+kmA4MUrgWICaUj71dd9olBi38afb1tdRHA8kPdOL2CAOPwaa3vByhP
 WsAHzMA4BDvVJlzWvb6rLlKSFVZsUcIC15+T0FzpmihkfNFNCOYkB7vv6+fVBrArbVej
 MxWY+DaZxN6Aa0y909cfmRGui8shtO0WMJWNn78D0tCumpmwqyPixgGYSluOLwZ4qrNS
 kLfH3KjeLK48BXM8bslXyupxUQAveiSO1dAaX6vsj5u6MeXrUo41nkd+6JjQ2DnRP7q7
 RwLC9lY/FoPJeOXWt7hJuqOwjifZD2E14+EnSXGYSFTCy/8I08FdO5bvYU+TCWEOePt3
 SNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704698313; x=1705303113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3IJUtLA31KDEmQZJf2wIpr2FmV2YYPsu2bBaA+p5br4=;
 b=cKt0PbGcc2gnZBTKM0V3rbgoA9MYMYIIwTUfJPlMv09D3LegkTQ7gJuzAdhTNUBNF6
 lppSqIbExmetk/ezvqyF8hPXjmYYYJbNdcaXXKHRCedFPFT5OvxvdvC4qvzzhXQtAWCt
 LqVC7wvYynqHWU+dgCU1QDn3KnRS8GuEcp4vkZuerYVSE2L+0TwOCt8usbj64soGnaDu
 ZAf4snBZ7z+DfJPH9iP5/lHU6wE1vktzpNdGSjwrSEXxRsg47b/X2rGVMFoQ74ymOeoa
 KiUeQggzcnCE5ZmrTiVWf8lImL9/4RNHXVkXZGDdUlTzlD1k3dBCejcm3OZS4igi+sD8
 FtKw==
X-Gm-Message-State: AOJu0YwsZEIzeRfrTdlonLpeHtePv5fRvUMVcPtjzcBxGh5SH715nhZA
 LnCBmtPY52s9+fCDfO5JuMTMzT4g1tcEiOC5YYXPK4i/zX5fXQ==
X-Google-Smtp-Source: AGHT+IEqifHfiawO1ux4wVSt0x4QBRSGCEXwFGMXQJVkCVeLcEt+yYRhusHGoVOekYV9T4VLUAIfePeDLXIv22KwSb8=
X-Received: by 2002:a05:6102:32c1:b0:467:b9e2:6898 with SMTP id
 o1-20020a05610232c100b00467b9e26898mr1298185vss.34.1704698313671; Sun, 07 Jan
 2024 23:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-4-sumit.garg@linaro.org>
 <20240105204137.pdzgacapwpgpualp@bryanbrattlof.com>
In-Reply-To: <20240105204137.pdzgacapwpgpualp@bryanbrattlof.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 8 Jan 2024 12:48:22 +0530
Message-ID: <CAFA6WYMoEcg+niaf+3+a29c9Fon5LrJQ9E5X7YtWyjEX_1RKDA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

Hi Bryan,

On Sat, 6 Jan 2024 at 02:12, Bryan Brattlof <bb@ti.com> wrote:
>
> Hi Sumit!
>
> On December 28, 2023 thus sayeth Sumit Garg:
> > Allow u-boot to build DTB from a different directory tree such that
> > *-u-boot.dtsi files can be included from a common location. Currently
> > that location is arch/$(ARCH)/dts/, so statically define that common
> > location.
> >
> > This is needed for platform owners to start building DTB files from
> > devicetree-rebasing directory but still being able to include
> > *-u-boot.dtsi files.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
>
> ...
>
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 27b9437027c..09330421856 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
>
> ...
>
> >  # Uncomment for debugging
> > @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> >  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
> >                $(UBOOTINCLUDE)                                         \
> >                -I$(dir $<)                                             \
> > +              -I$(u_boot_dtsi_loc)                                     \
> >                -I$(srctree)/arch/$(ARCH)/dts/include                   \
> >                -I$(srctree)/include                                    \
> >                -D__ASSEMBLY__                                          \
> > @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >         echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> >       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >       $(DTC) -O dtb -o $@ -b 0 \
> > -             -i $(dir $<) $(DTC_FLAGS) \
> > +             -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
> >               -d $(depfile).dtc.tmp $(dtc-tmp) || \
> >               (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
> >               ; \
>
> One of the issues I see with having a separate OF_UPSTREAM and U-Boot dt
> directory is when we have U-Boot board files that use dtsi files in the
> OF_UPSTREAM folder.
>
> For example our reference boards uses the primary bootloader's dtb (eg:
> k3-am62a7-r5-sk.dts) which #includes the k3-am62a7-sk.dts that will be
> found in the OF_UPSTREAM directory and modifies it to give it the
> perspective of the micro-controller it will be running on during boot.

Thanks for bringing this up. I have been playing with the idea to
reuse DT includes from upstream.

>
> What do you think if we have both paths included regardless if
> OF_UPSTREAM is selected or not? IDK if this will break anyone else

Sure, we should be able to do that if we maintain the correct order of
include paths as per following patch [1]. If this works for you let me
know and I will include it for v4.

[1]

commit 7fcebc044c69c57b43ff0e59f2d8c3713bc68b6c
Author: Sumit Garg <sumit.garg@linaro.org>
Date:   Tue Jan 2 19:20:01 2024 +0530

    Makefile: Allow upstream DT subtree to provide DT includes

    Allow platforms to reuse DT headers and dtsi includes directly form
    upstream DT subtree which will be frequently synced with Linux kernel.
    This will further allow us to drop corresponding DT includes copy from
    U-Boot tree.

    Also, since the DT includes from upstream DT subtree are done after DT
    includes from U-Boot tree, so it shouldn't cause any conflicts.

    Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

diff --git a/Makefile b/Makefile
index d8d168cd4c3..0160e827a29 100644
--- a/Makefile
+++ b/Makefile
@@ -834,7 +834,8 @@ UBOOTINCLUDE    := \
                                -I$(srctree)/arch/arm/thumb1/include), \
                        -I$(srctree)/arch/arm/thumb1/include)) \
        -I$(srctree)/arch/$(ARCH)/include \
-       -include $(srctree)/include/linux/kconfig.h
+       -include $(srctree)/include/linux/kconfig.h \
+       -I$(srctree)/devicetree-rebasing/include

 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 09330421856..30033092597 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -189,12 +189,17 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)

 # Modified for U-Boot
+upstream_dtsi_include = $(addprefix -I, $(srctree)/devicetree-rebasing/src/ \
+       $(sort $(dir $(wildcard
$(srctree)/devicetree-rebasing/src/$(ARCH)/*/*))) \
+       $(if (CONFIG_ARM64), \
+                $(sort $(dir $(wildcard
$(srctree)/devicetree-rebasing/src/arm64/*/*)))))
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
                 $(UBOOTINCLUDE)                                         \
                 -I$(dir $<)                                             \
                 -I$(u_boot_dtsi_loc)                                     \
                 -I$(srctree)/arch/$(ARCH)/dts/include                   \
                 -I$(srctree)/include                                    \
+                $(upstream_dtsi_include)                                \
                 -D__ASSEMBLY__                                          \
                 -undef -D__DTS__

-Sumit
