Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4FCC27C44
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 12:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057CC87E1D;
	Wed, 29 May 2024 14:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EzGynodK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDFF88253; Wed, 29 May 2024 14:00:26 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D03587D6B
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 14:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-48a314805d9so655802137.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716984023; x=1717588823; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSTnH6aTsxO6wau3x/iUz2y8jt6jsKSRm87FmNLMEIY=;
 b=EzGynodKDUMEBTsjAyhU8NZi9Pbg2NIlG98+Hjhpm4Q7xHA7c5kSdMCIGZ79dmorbb
 8JI42DhrfQ+Z8l8zQ2JY3E3CGD37+yN40pcZLg1eyRaTFa4GCgT4kCTE/DqEslwPgGm5
 BpT+q1XBI8JuC71L/tTfnQX11GIeJorb4+is6eLEahL73sIcGTbMlY/lX8BmhHLEQ5+G
 hixXsIPfBLnO0a6KoCwclj2vQO27McyqtD1SlYqvpBZTI5A6h6KQIE6AOgGaeL/VVfcb
 Kjb/mVe88lE2ORrEriruwGkjHv2ivXyYKk5LN3nNBvTIJY44NL4+Upqreygao0d5Eodn
 CGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716984023; x=1717588823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSTnH6aTsxO6wau3x/iUz2y8jt6jsKSRm87FmNLMEIY=;
 b=SgI3YFQsYNQO75EaWlJi2IsShoq99dau3T/GDFTDErJP8ngAVwosx+gMDM3lSAwTWd
 HbOaSvdNpXTEy8z07NaWHqB6s7GvUXRiyFJNmwqR1iX7UxwMIEVRDvDhG7zVzuGIlyqb
 RYrJWu77zH/nM/3xBwNQW/DMoDDTzR7X6h1aVyM+iT5PlTQHx+zygbYHJnVM2ohbjpCM
 efUImoII26wXwFh8jagFpJY/7Th1eLpQBIH2i3/uBpnccnXJKhuLeIsV05j4tVv8EIDq
 LoTARjnsllBRgTffcpx7aHW4G7Il6AY9WvemOw/eQ/H2O7DsLHfpVtmBUulY5fEQKBov
 TdlQ==
X-Gm-Message-State: AOJu0YxYd6z571xNnD0Ntk+Qr1Xqiq7db8cGaTFJN8F7TASWz0hqiuHn
 sCDoT735mvxdF0LvqKcR1OUbVkpv8q8/niPx+xbLRiwcMj0UOjTs03RxNML1oGlZxc2rlp7TCxx
 SDaLplmcSK8CZHK7boje+HR3/2poYO8HGSb/x2A==
X-Google-Smtp-Source: AGHT+IGncamoO8uNS8jZXvXO/qeYbwl6X5HRswUbmNKWPTv6x/srtCYatg2AmMNT/Bg2UCi0rkkyR5/dBsvd3hf+5Xg=
X-Received: by 2002:a05:6102:dcb:b0:486:5556:cbab with SMTP id
 ada2fe7eead31-48a666c60d5mr9272301137.11.1716984021295; Wed, 29 May 2024
 05:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240528084224.113385-1-patrick.barsanti@amarulasolutions.com>
 <CAFA6WYOGXA7rPoVG_dJTfMYmKXS=Zik+9saP70Sc82C2L_mFUQ@mail.gmail.com>
 <CABxfhNcAArLz618Z4441uVqFZrBATrRJweoU2RjMPP2WyxGnWA@mail.gmail.com>
In-Reply-To: <CABxfhNcAArLz618Z4441uVqFZrBATrRJweoU2RjMPP2WyxGnWA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 17:30:09 +0530
Message-ID: <CAFA6WYN1SH-f8p3-odQz2cfHiS625jMgR_NXninVExcdjyynYg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix include directory for OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, afd@ti.com, marek.vasut+renesas@mailbox.org, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu, 
 linux-amarula@amarulasolutions.com
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

On Wed, 29 May 2024 at 14:45, Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Hi Sumit,
>
> On Wed, 29 May 2024 at 08:57, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> Hi Patrick,
>>
>> On Tue, 28 May 2024 at 14:16, Patrick Barsanti
>> <patrick.barsanti@amarulasolutions.com> wrote:
>> >
>> > Always prioritizing u-boot includes causes problems when trying to
>> > migrate boards to OF_UPSTREAM that have divergent devicetree files with
>> > respect to the upstream ones.
>> >
>> > For example, migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
>> > breaks it, as there are some missing defines in the local dtsi file;
>> > the solutions would be to either patch it, which defeats the purpose of
>> > OF_UPSTREAM, or delete it entirely. This last option would then break all
>> > the other boards which have not yet been migrated to OF_UPSTREAM.
>>
>> Can you elaborate more here regarding which dt-bindings headers
>> conflict? Also, is it only the DTS files consumer for those headers or
>> there are U-Boot drivers depending on them too?
>>
>> -Sumit
>
>
> Sorry, I think I have worded my commit message wrong. I should
> have used differ instead of diverge, which is slightly misleading.
>
> The specific case I am talking about can be found in:
> include/dt-bindings/clock/imx6ul-clock.h
> dts/upstream/include/dt-bindings/clock/imx6ul-clock.h
>
> The local header is missing the last commit from the kernel, which is
> 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support").
> This added some new defines, which are not present in the u-boot
> header.
> Following this commit, the `imx6ul.dtsi` was patched in the kernel to
> use one of the new defines.
>
> Because of this, at the current state, migrating a board which is
> somehow based on `imx6ul.dtsi` will give a dtc error given by a value
> being used in the upstream dtsi which is not defined in the local
> header, because local includes always have priority with respect
> to upstream ones even when setting OF_UPSTREAM.

So you should just drop the local DT bindings header:
include/dt-bindings/clock/imx6ul-clock.h and that should resolve the
problem for you, right?

-Sumit

>
> Regards,
> Patrick
>
>>
>> >
>> > The opposite problem also exists: by always prioritizing upstream
>> > includes, if changes are made in the kernel headers and devicetree
>> > files that are not backwards compatible, again all boards which have not
>> > been migrated to OF_UPSTREAM will break.
>> >
>> > This patch fixes this problem by prioritizing upstream includes when
>> > `CONFIG_OF_UPSTREAM=y`, while keeping current prioritization when
>> > it is not.
>> >
>> > Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
>> > ---
>> >  Makefile | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 79b28c2d81..899ae664ca 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -826,6 +826,19 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>> >
>> >  # Use UBOOTINCLUDE when you must reference the include/ directory.
>> >  # Needed to be compatible with the O= option
>> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
>> > +UBOOTINCLUDE    := \
>> > +       -I$(srctree)/dts/upstream/include \
>> > +       -Iinclude \
>> > +       $(if $(KBUILD_SRC), -I$(srctree)/include) \
>> > +       $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
>> > +               $(if $(CONFIG_HAS_THUMB2), \
>> > +                       $(if $(CONFIG_CPU_V7M), \
>> > +                               -I$(srctree)/arch/arm/thumb1/include), \
>> > +                       -I$(srctree)/arch/arm/thumb1/include)) \
>> > +       -I$(srctree)/arch/$(ARCH)/include \
>> > +       -include $(srctree)/include/linux/kconfig.h
>> > +else
>> >  UBOOTINCLUDE    := \
>> >         -Iinclude \
>> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
>> > @@ -837,6 +850,7 @@ UBOOTINCLUDE    := \
>> >         -I$(srctree)/arch/$(ARCH)/include \
>> >         -include $(srctree)/include/linux/kconfig.h \
>> >         -I$(srctree)/dts/upstream/include
>> > +endif
>> >
>> >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>> >
>> > --
>> > 2.43.0
>> >
