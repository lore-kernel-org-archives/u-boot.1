Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A496C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A8487706;
	Wed, 20 Dec 2023 12:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bP1My5eW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0823876FF; Wed, 20 Dec 2023 12:30:35 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98F787702
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4669347c6b6so664539137.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 03:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703071831; x=1703676631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6/NnJBFiq7FYUkg4WYQtWt2kuFZ4wePHGcRAjEMRO7c=;
 b=bP1My5eWoaqASqKQ2IQm8Cnj3pT85ipl9Sxjusf8MToyd89Y4Ix4Ovsd8MN8MAc8DP
 OwkNDXg9Gl1QDBMq2i+zLveq+WBYOpbkNFdWsRMz7tDS62qpgwfvYSNxz79CTNzs40df
 IaP3w30gi7+XASJg0g6a6hc4IuSGORD4HJiovzg9N2ZNER86+QCU8ZCAFlyuMX84OxCY
 kUql6l1+xQ0GcDsD2MpJwqtF151wxVH3tHAn5uvfiP1Yeyt/i4TbBVg4eyBlSENkDoO6
 edn9Rx+CSwzQ74wdfEIy9wSjCu0VlEFVpdZRiEWcbb3uThOlPQgtzUsnwstrkb4Z0Bmo
 eVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703071831; x=1703676631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6/NnJBFiq7FYUkg4WYQtWt2kuFZ4wePHGcRAjEMRO7c=;
 b=Rg1zP918AAU2dklYHUdgvP59m1DpRzml2k+TKIhzdgMkm+TJtybAvwI9j7JEN6TiW/
 GZuHFpc71zWsXdoygNmfaofE6bx/tXQgMOwhfNyW4osuBScR+/cgSBVXQYlKG3ufwE4W
 HjNRfknjIQl9o1CujsVLdDlDXWsm0Y+T7kIk4nZgc724/OWZZcJrPtZpNqyFUu8A10cV
 gTMCaxWGcx/LxyuT0FJ8zvS+haBF5c91poSmCL1ieXLTDR0I3Ftsy0Ygb/8yie94SFyp
 PRDL/KaFLGHPQMEWbdgIS7/jUjpJ0fkOL0fBYF2nlgegUkBAAt+7EmqY9GX/ShWvvf+m
 QFlw==
X-Gm-Message-State: AOJu0YyAyu8WR9fjVKhsmLgLDO+tMC/m/FpeClzV8Hlx/LD0jz6HnG6k
 HiOnw36Au1GoWD4WiEUMyiQJAlS+coEGqb47px1Huw==
X-Google-Smtp-Source: AGHT+IGXe29Niiy5kV6p53MnUBl3AIcjeVE4XTxt9BKsFJ8tPKUoNSr3K0RAVhjn1lA4FPfa44+maGOuCFifbpwvbLQ=
X-Received: by 2002:a05:6102:6d3:b0:466:c048:49dd with SMTP id
 m19-20020a05610206d300b00466c04849ddmr309805vsg.6.1703071831562; Wed, 20 Dec
 2023 03:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-4-sumit.garg@linaro.org>
 <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 17:00:20 +0530
Message-ID: <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi
 files location
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

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Allow u-boot to build DTB from a different directory tree such that
> > *-u-boot.dtsi files can be included from a common location. Currently
> > that location is arch/$(ARCH)/dts/, so statically define that common
> > location.
> >
> > This is needed for platform owners to start building DTB files from
> > devicetree-rebasing directory but still being able to include
> > *-u-boot.dtsi files.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 27b9437027c..4a002b0e0ca 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
> >  ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
> >
> >  # Try these files in order to find the U-Boot-specific .dtsi include file
> > -u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> > -       $(wildcard $(dir $<)u-boot.dtsi))
> > +UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/
>
> How about lower case since it is internal. Also we know it is U-Boot,
> so perhap  ?

Although I just named it after *-u-boot.dtsi, I am fine with dtsi_loc
too. So I will use that instead.

>
> Otherwise looks OK to me.

Thanks,
-Sumit

>
> > +
> > +u_boot_dtsi_options = $(strip $(wildcard $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> > +       $(wildcard $(UBOOT_DTSI_LOC)u-boot.dtsi))
> >
> >  u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> > -       $(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
> > -       $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> > -       $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> > -       $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> > -       $(dir $<)u-boot.dtsi ... \
> > +       $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> > +       $(UBOOT_DTSI_LOC)u-boot.dtsi ... \
> >         found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
> >
> >  # Uncomment for debugging
> > @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> >  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
> >                  $(UBOOTINCLUDE)                                         \
> >                  -I$(dir $<)                                             \
> > +                -I$(UBOOT_DTSI_LOC)                                     \
> >                  -I$(srctree)/arch/$(ARCH)/dts/include                   \
> >                  -I$(srctree)/include                                    \
> >                  -D__ASSEMBLY__                                          \
> > @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> >         $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >         $(DTC) -O dtb -o $@ -b 0 \
> > -               -i $(dir $<) $(DTC_FLAGS) \
> > +               -i $(dir $<) -i $(UBOOT_DTSI_LOC) $(DTC_FLAGS) \
> >                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
> >                 (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
> >                 ; \
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
