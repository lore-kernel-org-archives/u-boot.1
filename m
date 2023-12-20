Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4310BC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27503876C0;
	Wed, 20 Dec 2023 13:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A2a4mqLZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1908771E; Wed, 20 Dec 2023 13:01:56 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC38876C0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ba46a19689so4518748b6e.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703073711; x=1703678511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IKGoDZ48ZEczAEgArq9tcfMOds642x44asCqXniP7yw=;
 b=A2a4mqLZAqgl+/84GhzNJeFZSbJExU1MJfFzEdp+auNIRUGuUAfglmxfNhGvlfc/D4
 qAvA3jstcZDX85RLMS9oz3gm7uJlGpsCxYhnBYm4EnuMSNtGYHpIf08HdLP2kWfo7A2J
 HIyOjjRuyrqkUBF346BSk6x1+zpYTISv/yrqICuoXPHqOfFob2CsW2cXpOmyjd1M8qS6
 bgEcs57Fgl8Vml24RKmNo/g4q3F9YeiOuRTwcboaqHgRa9ckQe/2A0g26xtF1jeSKmYE
 hXLXl83wW1mDos69tV4wTrX8VMGA2jorucMAJ5jtVyNhR6ECctRTTZ8wYy35GNsM7pEL
 8rGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703073711; x=1703678511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IKGoDZ48ZEczAEgArq9tcfMOds642x44asCqXniP7yw=;
 b=VeDQo8IZNn4cVElq4xTk1/1/cKM0LDjSx7Z8f0/eQ0MaY73x1oGkiyOkcfVoKsl9q0
 86T2AOp7YVgklU4h7Y4VR1Wf8D/Fshga7Bq/7LY+LvpHuIRCE5ZcVgNkFaiBc/O3btGh
 /Tjnyarp4rIfgPmWnTVUkmDb5j064qUvUIRMQLVNRiNKRdH/tbbd+hGcI15RFayzea3u
 Si6B7vEajuMNmeYlA1CiqMC8sGTlSrpXeyecMqqCQBcHh5cs5C0Do7IH/3Sxrr6cD5D/
 Rg8zLlc8X90BMZsDOgVvkPxJiUPz/wssbJKwkR2WuCx5QUp9k3ll39goWPtupjLBW2Ga
 Y3/w==
X-Gm-Message-State: AOJu0YwNpUak6dDDV33WOvDJsphU1VwH4YJxUG5NL6xQwht6fhdDSpn6
 plFn91mjL0vzrMxHs7YO1VF67iGjjrhVXlnPpUXdTw==
X-Google-Smtp-Source: AGHT+IFVOHk/KR8nGQ9GxeOkB1v+ACQBkyFEjY07+zftdemeE06DM43suts4BOVHjOBkeurrg2BDhDI/ll5A7dpONjI=
X-Received: by 2002:a05:6808:f09:b0:3b9:d5e3:8f28 with SMTP id
 m9-20020a0568080f0900b003b9d5e38f28mr26593640oiw.57.1703073710627; Wed, 20
 Dec 2023 04:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-5-sumit.garg@linaro.org>
 <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 17:31:39 +0530
Message-ID: <CAFA6WYMeLoD_z1W+iK3C6yj44dO_pdM71bhd6gK14gB==75gxw@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

Hi Simon,

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Allow platform owners to mirror devicetree files from devitree-rebasing
> > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
> > build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
> > directory.
>
> Also add a new Makefile for arm64.

I suppose you are referring to dts/arch/arm64/Makefile which has been
added by this patch.

>
> >
> > This will help easy migration for platforms which currently are compliant
> > with upstream Linux kernel devicetree files.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  dts/Kconfig             | 11 +++++++++++
> >  dts/Makefile            | 17 ++++++++++++++---
> >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> >  3 files changed, 39 insertions(+), 3 deletions(-)
> >  create mode 100644 dts/arch/arm64/Makefile
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 00c0aeff893..96396f12b67 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -85,6 +85,17 @@ config OF_LIVE
> >           enables a live tree which is available after relocation,
> >           and can be adjusted as needed.
> >
> > +config OF_UPSTREAM
> > +       bool "Enable use of devicetree imported from Linux kernel release"
> > +       help
> > +         Traditionally, U-boot platforms used to have their custom devicetree
>
> U-Boot
>
> (I think I mentioned this, but you thought I said U-boot...but it
> really is U-Boot). Perhaps grep your patches next time.

Ah, I see. It looks like I missed that bit, and will take care of it
in the next revision.

>
> > +         files or copy devicetree files from Linux kernel which are hard to
> > +         maintain and can usually get out-of-sync from Linux kernel. This
> > +         option enables platforms to migrate to devicetree-rebasing repo where
> > +         a regular sync will be maintained every major Linux kernel release
> > +         cycle. However, platforms can still have some custom u-boot specific
> > +         bits maintained as part of *-u-boot.dtsi files.
>
> I'm a bit nervous about this. It means that boards chose between this
> dir of the local files. It means there is some effort to switch.
>
> I wonder if we could default to using the rebasing thing, with boards
> having to 'opt out'? So this should be 'default y' ?

Ideally that should be our migration path going forward once we get
enough boards migrated to use rebasing repo. But at this initial stage
we have to put some effort on migrating boards to use rebasing
subtree, although effort should be just adding (given DT bindings
compliance) following to defconfig (see patch #7):

CONFIG_OF_UPSTREAM=y
CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"

and create a mirrored copy of:
../../../devicetree-rebasing/src/arm64/amlogic/ into
dts/arch/arm64/amlogic/ with modifications to add targets to
dts/arch/arm64/Makefile.

I am happy to put in that effort but certainly for new board support
that would like to import DT from Linux it should be the default. That
stands true for the Qcom platform series for which Caleb is currently
working on.

>
>
> > +
> >  choice
> >         prompt "Provider of DTB for DT control"
> >         depends on OF_CONTROL
> > diff --git a/dts/Makefile b/dts/Makefile
> > index 3437e54033d..8098bf8191a 100644
> > --- a/dts/Makefile
> > +++ b/dts/Makefile
> > @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
> >  DEVICE_TREE := unset
> >  endif
> >
> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > +ifeq ($(CONFIG_ARM64),y)
> > +DEVICE_TREE_LOC := dts/arch/arm64
>
> dt_dir ?

Okay I will rename it.

>
> Should we move the arm64 DTs to arch/arm64 ?

IMO, the migration path should be to use rebasing subtree via
dts/arch/arm64/ and dropping DTs except *-u-boot.dtsi from
arch/$(ARCH)/dts. So moving DTs from arch/arm/ to arch/arm64/ seems
like a redundant change to me.

>
> What about the subdirs used in Linux?

I hope I have described above regarding how subdirs are mirrored.
However, have a look at patch #7 for the amlogic/ subdir example.

-Sumit

>
> > +else
> > +DEVICE_TREE_LOC := dts/arch/$(ARCH)
> > +endif
> > +else
> > +DEVICE_TREE_LOC := arch/$(ARCH)/dts
> > +endif
> > +
> >  ifneq ($(EXT_DTB),)
> >  DTB := $(EXT_DTB)
>
> >
> >  else
> > -DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
> > +DTB := $(DEVICE_TREE_LOC)/$(DEVICE_TREE).dtb
> >  endif
> >
> >  $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
> > @@ -41,7 +51,7 @@ $(DTB): arch-dtbs
> >
> >  PHONY += arch-dtbs
> >  arch-dtbs:
> > -       $(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
> > +       $(Q)$(MAKE) $(build)=$(DEVICE_TREE_LOC) dtbs
> >
> >  ifeq ($(CONFIG_SPL_BUILD),y)
> >  obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
> > @@ -65,4 +75,5 @@ clean-files := dt.dtb.S
> >  # Let clean descend into dts directories
> >  subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts     \
> >            ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts     \
> > -          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts
> > +          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts        \
> > +          ./arch/arm64 ./arch/$(ARCH)
> > diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> > new file mode 100644
> > index 00000000000..16e9fea622d
> > --- /dev/null
> > +++ b/dts/arch/arm64/Makefile
> > @@ -0,0 +1,14 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +include $(srctree)/scripts/Makefile.dts
> > +
> > +targets += $(dtb-y)
> > +
> > +# Add any required device tree compiler flags here
> > +DTC_FLAGS += -a 0x8
> > +
> > +PHONY += dtbs
> > +dtbs: $(addprefix $(obj)/, $(dtb-y))
> > +       @:
> > +
> > +clean-files := */*.dtb */*.dtbo */*_HS
> > --
> > 2.34.1
>
> Regards,
> Simon
