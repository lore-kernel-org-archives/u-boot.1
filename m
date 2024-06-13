Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED53BC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 07:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1460C888C6;
	Thu, 13 Jun 2024 09:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UPNsG3++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E314888C8; Thu, 13 Jun 2024 09:15:00 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 054A8888C5
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 09:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6f176c5c10so76212266b.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718262897; x=1718867697;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pis2J/MZujKYANYwldS7yqL0yC6kqEuuZDGaL2FP7fM=;
 b=UPNsG3++pxLaF88ZO52+22/pXBmijZBk4gk2hL52cp0Ty2Y2M3gZ/h7rYEeUJVo/BX
 Gd+9qZzxCAsLD0/OUQkCqcgn+QZ+3LI0cf/CGJxYlrMwfMflsTjR2vxYoyeyg+KcGIGb
 SzkKBg4UTbOc1xnUDJESGa/iJoCmSVymxpUQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718262897; x=1718867697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pis2J/MZujKYANYwldS7yqL0yC6kqEuuZDGaL2FP7fM=;
 b=O51/nXMwQwE2GQsK0V2oqiyYyiLz9vpJ216Cbo2GoNR6t9TMQLmbm1Lenms3ZXnAEI
 QfsRCLJI/iOPv82foZGi4+q/uzcJGdehQm+3Ma5RtsI9YJp/ZHxIuD5FmAMFZFScGzwf
 2/CGXQjWdkSMorSnextChURyyhvIONaeWzuc6Ywa9wTaZNVGfbOxKglMfh0QMAqkNe05
 aaoMkPAkA0gpSzZtkkZE19LU554xvADZsvMKfVBKgAbSevqFBC1/uliyvzlL8HCYgMsL
 eop91QWqfJNkWQ+0EDXIacbcQ0oYu1QuNPSaxC9rwcgvd2gyPTOVKXh+jbWGyVZdKiqr
 E57Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvEl9eyt8/ilTZTKfclWU2GKbZtkNjfb24+deTOAp3h4dcHflf8FOjW/eQHgCbwQGOMfQZfdD8Tdi5TYbmOitXn0lMCg==
X-Gm-Message-State: AOJu0YxVg9w+p6yYm9em+RdrYg3GjYa4ao5GiMfEfhmHUjbzlhPptDq8
 en4zQnUI94mA5tg4Af0vEwz7nSChhoDSnoHuNnmmt/dhVctNfb8809qqHP4/pFMlzMUvzamqbEV
 wEfpXr1vNVHyKXn9fBSAQolUKl8gcy6ce+EhWwg==
X-Google-Smtp-Source: AGHT+IGVP7z1DHcE7b7SwASFqVekpuSbX7lQlEOCAZgU6slIaBXjBBFNfz959gq6oCHzOukbyWGiTlt6zVMkLcylNXg=
X-Received: by 2002:a17:906:4fc7:b0:a6f:5b9a:4a70 with SMTP id
 a640c23a62f3a-a6f5b9a4c12mr28486466b.67.1718262897142; Thu, 13 Jun 2024
 00:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
 <CAFA6WYPB17=YNabDyGTqo3p=uYD=Vy+Ec2P2VepXT6P+75f+VQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPB17=YNabDyGTqo3p=uYD=Vy+Ec2P2VepXT6P+75f+VQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 13 Jun 2024 09:14:45 +0200
Message-ID: <CAOf5uwneUKJXJqgBMOQHs+d8-GQ6nr+vBAZ4ek2au1kngs8mXA@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 u-boot@lists.denx.de, 
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, 
 marek.vasut+renesas@mailbox.org, afd@ti.com, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu
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

Hi Sumit

On Thu, Jun 13, 2024 at 9:02=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Mon, 3 Jun 2024 at 20:38, Patrick Barsanti
> <patrick.barsanti@amarulasolutions.com> wrote:
> >
> > Always prioritizing u-boot includes causes problems when trying to migr=
ate
> > boards to OF_UPSTREAM that have different local devicetree files with
> > respect to the upstream ones, if local DT headers are not dropped.
> > At the same time if local and upstream files are the same, migrations
> > can be, and have been, introduced without dropping local DT headers.
> > This also causes problems whenever upstream DTS and DT headers are patc=
hed.
> >
> > For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTREA=
M
> > breaks it, as there are some missing defines in a local DT header file
> > (`imx6ul-clock.h`); the solution would be to drop it, which has not alw=
ays
> > been done in previous OF_UPSTREAM migration patches for other boards
> > because most of the time the two are the same. This solution is also
> > vulnerable to ABI breakage, although this has not yet happened since th=
e
> > introduction of OF_UPSTREAM support and is unlikely.
> >
> > Maintainers assure backwards compatibility for DT headers when syncing =
the
> > upstream folder with the kernel.
> > The problem is that, at the current state, all boards that have not dro=
pped
> > their local headers when migrating to OF_UPSTREAM will break once the
> > upstream devicetrees are patched, for example, to use any newly added
> > define which is not present in the local DT header file, even if those
> > changes are backwards compatible.
> >
> > This patch fixes these problems by prioritizing upstream includes when
> > `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when it =
is
> > not.
> >
> > Also in case of ABI breakage in the kernel, keeping redundant header fi=
les
> > (only until strictly necessary, e.g. until all boards including them ha=
ve
> > been migrated to OF_UPSTREAM) together with this selective prioritizati=
on
> > of the include folder is a solution for keeping not-yet-migrated boards
> > from breaking.
>
> Let's just not try to make assumptions about DT ABI breakage due to
> using upstream headers for not-yet-migrated boards but rather talk
> about some real world examples. Have you come across any DT ABI
> breakage with usage of upstream headers? The breakage you have
> reported is due to usage of an old local copy of DT header.
>

The include priority is broken, and this a Makefile problem anyway.
This patch fix
anyway includes priorities. The imx6 board migration for us does not work

> However, if this patch is only needed to address fear of DT ABI
> breakage (which hasn't happened in the past) then I can live with it
> such that it can help convince more people for OF_UPSTREAM migration.
> We can drop local DT headers as and when people feel comfortable with
> upstream.

It's not abi breakage only but path inclusion order.

Michael


>
> -Sumit
>
> >
> > Link: https://lore.kernel.org/u-boot/20240528084224.113385-1-patrick.ba=
rsanti@amarulasolutions.com/
> > Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
> > Tested-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >
> > Changes in v2:
> > - Reword and correct the commit message following the discussion
> > with Sumit, per Michael's suggestion.
> >
> >  Makefile | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 79b28c2d81..899ae664ca 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -826,6 +826,19 @@ KBUILD_HOSTCFLAGS +=3D $(if $(CONFIG_TOOLS_DEBUG),=
-g)
> >
> >  # Use UBOOTINCLUDE when you must reference the include/ directory.
> >  # Needed to be compatible with the O=3D option
> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > +UBOOTINCLUDE    :=3D \
> > +       -I$(srctree)/dts/upstream/include \
> > +       -Iinclude \
> > +       $(if $(KBUILD_SRC), -I$(srctree)/include) \
> > +       $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
> > +               $(if $(CONFIG_HAS_THUMB2), \
> > +                       $(if $(CONFIG_CPU_V7M), \
> > +                               -I$(srctree)/arch/arm/thumb1/include), =
\
> > +                       -I$(srctree)/arch/arm/thumb1/include)) \
> > +       -I$(srctree)/arch/$(ARCH)/include \
> > +       -include $(srctree)/include/linux/kconfig.h
> > +else
> >  UBOOTINCLUDE    :=3D \
> >         -Iinclude \
> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> > @@ -837,6 +850,7 @@ UBOOTINCLUDE    :=3D \
> >         -I$(srctree)/arch/$(ARCH)/include \
> >         -include $(srctree)/include/linux/kconfig.h \
> >         -I$(srctree)/dts/upstream/include
> > +endif
> >
> >  NOSTDINC_FLAGS +=3D -nostdinc -isystem $(shell $(CC) -print-file-name=
=3Dinclude)
> >
> > --
> > 2.45.1
> >



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
