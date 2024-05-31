Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84056C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 07:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4CE8882C4;
	Fri, 31 May 2024 09:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PFZeMNgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3793882C4; Fri, 31 May 2024 09:22:57 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D06881E5
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 09:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so2962430a12.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1717140175; x=1717744975;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMDp6v3QAFgj4Y8QehryMXv/AmIyFkMuzG0Bi0/pfMs=;
 b=PFZeMNgYU/akO6eKXlDlawA9GWyQJUqpry8flzavargFoJctmDNR6ahMc3dIpKTZEj
 M8dH4LUu8HkZfoYnph1vps97mLfsCO1Swbtnw0fv8atHn9tbLrke1AzHREFt+u+H8JT3
 DEcvYkV3xGnwyAmiesAmDlu8gLlhmD/DlXVm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717140175; x=1717744975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMDp6v3QAFgj4Y8QehryMXv/AmIyFkMuzG0Bi0/pfMs=;
 b=QamFZvKsPEcII8qLlrWl1NzLDRtDUcNcHPglACa7Vns5f8pSpQsbguQb4giful2GYN
 0UrYDt7v9PejBtGEkU0JOyH5ygZU1tobXdy6TxVBPYccQa1liZ5f0tLYJJTZjDX+T1VX
 KgnCaeakKdeWt8eN3GZJ90C1WRZoioVp0u1P7oIlkQ31JgjXMc/dFoVZ8Van3SQJt/tq
 VJeicCqrVKzAhfPuxvv7idIqa8rMOovDqA77agSCe9aQv+/qipXWaafrvZ8xGPCQAGpT
 PAmlmj34FW2kHXZT0a0jEqbaGlBgXRhvuXEdWolyHps0B8ANs1C7ePtVBH5mYXQBHxte
 IZrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7enRlMCQe2dFPUtXiEgupN9UsJxEoB8tVJFtMaB19/69PHJbkG3W6GTdvbzLMPt3b0cStMuYRPKPRtzfhh9moI1W0qA==
X-Gm-Message-State: AOJu0YzPyWnoo3OJ6cRm6bXWZEnIBStBmvr0q1WJxxpG6DHgtDZc6yO/
 jQ/nOgn3MNQ/EdV4bDdqqnZWyhRvQWQjsa8xl1cErKNpe6luVrInEOkiQFPTQrsgGbUfaZaNL7k
 CDfCMPehEoAv7diFB/d8nyJ/lsSOP3FKo6ZZKSwNnCEbG/ISFR7U=
X-Google-Smtp-Source: AGHT+IGcVAPiw7XOj4Dbi/n82rGEb2tVV7426GgWKYpGjEB+Jvg7ufjjhodqagrK6POhOreXNsduNuQK5u0EdI7LHxI=
X-Received: by 2002:a50:c052:0:b0:574:ea0b:c1a3 with SMTP id
 4fb4d7f45d1cf-57a19d4e99dmr4014408a12.1.1717140174673; Fri, 31 May 2024
 00:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240528084224.113385-1-patrick.barsanti@amarulasolutions.com>
 <CAFA6WYOGXA7rPoVG_dJTfMYmKXS=Zik+9saP70Sc82C2L_mFUQ@mail.gmail.com>
 <CABxfhNcAArLz618Z4441uVqFZrBATrRJweoU2RjMPP2WyxGnWA@mail.gmail.com>
 <CAFA6WYN1SH-f8p3-odQz2cfHiS625jMgR_NXninVExcdjyynYg@mail.gmail.com>
 <CABxfhNfWdD0NjPNskaxZxDTg9pDoDx5vBHrN9chvMh5Xo_7Kzg@mail.gmail.com>
In-Reply-To: <CABxfhNfWdD0NjPNskaxZxDTg9pDoDx5vBHrN9chvMh5Xo_7Kzg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 31 May 2024 09:22:43 +0200
Message-ID: <CAOf5uwmHoQZxs_XmRAiWXBhqE9DAwJORXAmBO8ELUQz1DFTHaw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix include directory for OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, afd@ti.com, 
 marek.vasut+renesas@mailbox.org, bb@ti.com, mr.bossman075@gmail.com, 
 leon@georgemail.eu, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Patrick

On Thu, May 30, 2024 at 11:13=E2=80=AFAM Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Hi Sumit,
>
> On Wed, 29 May 2024 at 14:00, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Wed, 29 May 2024 at 14:45, Patrick Barsanti
>> <patrick.barsanti@amarulasolutions.com> wrote:
>> >
>> > Hi Sumit,
>> >
>> > On Wed, 29 May 2024 at 08:57, Sumit Garg <sumit.garg@linaro.org> wrote=
:
>> >>
>> >> Hi Patrick,
>> >>
>> >> On Tue, 28 May 2024 at 14:16, Patrick Barsanti
>> >> <patrick.barsanti@amarulasolutions.com> wrote:
>> >> >
>> >> > Always prioritizing u-boot includes causes problems when trying to
>> >> > migrate boards to OF_UPSTREAM that have divergent devicetree files =
with
>> >> > respect to the upstream ones.
>> >> >
>> >> > For example, migrating a board based on `imx6ul.dtsi` to OF_UPSTREA=
M
>> >> > breaks it, as there are some missing defines in the local dtsi file=
;
>> >> > the solutions would be to either patch it, which defeats the purpos=
e of
>> >> > OF_UPSTREAM, or delete it entirely. This last option would then bre=
ak all
>> >> > the other boards which have not yet been migrated to OF_UPSTREAM.
>> >>
>> >> Can you elaborate more here regarding which dt-bindings headers
>> >> conflict? Also, is it only the DTS files consumer for those headers o=
r
>> >> there are U-Boot drivers depending on them too?
>> >>
>> >> -Sumit
>> >
>> >
>> > Sorry, I think I have worded my commit message wrong. I should
>> > have used differ instead of diverge, which is slightly misleading.
>> >
>> > The specific case I am talking about can be found in:
>> > include/dt-bindings/clock/imx6ul-clock.h
>> > dts/upstream/include/dt-bindings/clock/imx6ul-clock.h
>> >
>> > The local header is missing the last commit from the kernel, which is
>> > 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support").
>> > This added some new defines, which are not present in the u-boot
>> > header.
>> > Following this commit, the `imx6ul.dtsi` was patched in the kernel to
>> > use one of the new defines.
>> >
>> > Because of this, at the current state, migrating a board which is
>> > somehow based on `imx6ul.dtsi` will give a dtc error given by a value
>> > being used in the upstream dtsi which is not defined in the local
>> > header, because local includes always have priority with respect
>> > to upstream ones even when setting OF_UPSTREAM.
>>
>> So you should just drop the local DT bindings header:
>> include/dt-bindings/clock/imx6ul-clock.h and that should resolve the
>> problem for you, right?
>
>
> Yes, that indeed solves my problem.
> But if I drop it, I will force all other boards which are not yet
> migrated to OF_UPSTREAM and include `imx6ul.dtsi` to
> use the upstream header instead of the local one.
> I did not feel comfortable in doing so, because if any change is made
> to the upstream header in the future which is somehow not backwards
> compatible, then all boards which are still not using OF_UPSTREAM
> would not compile.
>
> I also thought this would not be limited to the single header file which
> caused my problem. I imagine there would be other cases of local
> headers which are missing one or more commits from mainline kernel
> and cause the same type of problem when moving to OF_UPSTREAM.
>
> The opposite problem also exists.
> For example:
> 675575880f ("phycore-am64x: Migrate to OF_UPSTREAM")
> does not drop include/dt-bindings/net/ti-dp83867.h, and I think the
> migration worked properly only because at the moment there is no
> difference between local and upstream headers.
> If and when the upstream headers and devicetrees will be patched,
> this will cause problems, because the local include will be used
> even if it's out-of-date.
> I have tested this: by simulating a kernel patch to the upstream files,
> which adds an extra define in ti-dp83867.h and updates
> k3-am64-phycore-som.dtsi to use this new define, current state
> u-boot will fail to build because that define is not present in the local
> include header.
> By including my patch, the build is successful.
>
> This is the reason why I proposed this Makefile patch, but of course I
> am completely open to suggestions and ideas better than mine, which
> I suspect are fairly easy to come by :)
>

Based on the discussion so far, you can extend the commit message so
other people can comment on it

Michael

> Thank you,
> Regards,
> Patrick
>
>>
>>
>> -Sumit
>>
>>
>> >
>> > Regards,
>> > Patrick
>> >
>> >>
>> >> >
>> >> > The opposite problem also exists: by always prioritizing upstream
>> >> > includes, if changes are made in the kernel headers and devicetree
>> >> > files that are not backwards compatible, again all boards which hav=
e not
>> >> > been migrated to OF_UPSTREAM will break.
>> >> >
>> >> > This patch fixes this problem by prioritizing upstream includes whe=
n
>> >> > `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when
>> >> > it is not.
>> >> >
>> >> > Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.=
com>
>> >> > ---
>> >> >  Makefile | 14 ++++++++++++++
>> >> >  1 file changed, 14 insertions(+)
>> >> >
>> >> > diff --git a/Makefile b/Makefile
>> >> > index 79b28c2d81..899ae664ca 100644
>> >> > --- a/Makefile
>> >> > +++ b/Makefile
>> >> > @@ -826,6 +826,19 @@ KBUILD_HOSTCFLAGS +=3D $(if $(CONFIG_TOOLS_DEB=
UG),-g)
>> >> >
>> >> >  # Use UBOOTINCLUDE when you must reference the include/ directory.
>> >> >  # Needed to be compatible with the O=3D option
>> >> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
>> >> > +UBOOTINCLUDE    :=3D \
>> >> > +       -I$(srctree)/dts/upstream/include \
>> >> > +       -Iinclude \
>> >> > +       $(if $(KBUILD_SRC), -I$(srctree)/include) \
>> >> > +       $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
>> >> > +               $(if $(CONFIG_HAS_THUMB2), \
>> >> > +                       $(if $(CONFIG_CPU_V7M), \
>> >> > +                               -I$(srctree)/arch/arm/thumb1/includ=
e), \
>> >> > +                       -I$(srctree)/arch/arm/thumb1/include)) \
>> >> > +       -I$(srctree)/arch/$(ARCH)/include \
>> >> > +       -include $(srctree)/include/linux/kconfig.h
>> >> > +else
>> >> >  UBOOTINCLUDE    :=3D \
>> >> >         -Iinclude \
>> >> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
>> >> > @@ -837,6 +850,7 @@ UBOOTINCLUDE    :=3D \
>> >> >         -I$(srctree)/arch/$(ARCH)/include \
>> >> >         -include $(srctree)/include/linux/kconfig.h \
>> >> >         -I$(srctree)/dts/upstream/include
>> >> > +endif
>> >> >
>> >> >  NOSTDINC_FLAGS +=3D -nostdinc -isystem $(shell $(CC) -print-file-n=
ame=3Dinclude)
>> >> >
>> >> > --
>> >> > 2.43.0
>> >> >



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
