Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544D4C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 04:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EFE868D3;
	Wed, 16 Aug 2023 06:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J1Pjq2NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6D8869A3; Wed, 16 Aug 2023 06:28:57 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C92A833F5
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 06:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso7904120a12.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692160134; x=1692764934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bB38AEmO9hL+dxcpWQQCGjMTKcSs5Wj6uGpmbTQoLjQ=;
 b=J1Pjq2NZZ/1IlMC8cHEjC1h/gBykxPVKJVAZ+HauKjq6qU/vvSpbnprnXur+2vkfPy
 4XLsWJflvO/NOnX/nhh4Fpyk7hFS0tMHmE5phCSZAPeyHw1q8dHcUmxwd8F6DsN6dVQP
 sRbGnSSdCbt/1fTAPcp+sGUwsQLqTPBicY9Py4zqjrhHaoxCrXJQyTwqSQ8kRGS9QEN/
 YZsrtJiqXxqOYfiVVhNvBcgYuHoG6OlB9Jr8wH/uJ0l9+4x6KL9ephwJgggiPYao5T7Y
 u0BTYNXrRGPF6Jef5CTc6v1c6rL3TlmXAG06Go6ch4nEE6CAzLkXmi5I2ZMSsqvj+jnB
 yUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692160134; x=1692764934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bB38AEmO9hL+dxcpWQQCGjMTKcSs5Wj6uGpmbTQoLjQ=;
 b=csd0BaSQVv77UwG7BJ20QclQYF/wVjF1wOh8lWNaFSMOXgXn5PvDHubC/+d4CoXvlG
 Ns3L+heQLf4z7dJYVwG9Zj8rCXpxTFFghTVI2ZJ4r2a7kDPAVBuHQy0tKnIJEspeoQMy
 61CP6RikledAtw/VVLb062pQDAb/ZNx7jZ9CGnoI/skt8Sdy6hID71+u2aUkxm1uZmOL
 EpvgnWJuKHtUavPXP1OOrynXzdcCmiGSZ09gwRjE6Wf4mmpb3XjS5pVjWBpGIxEauhXM
 lwDeg6YwN2p9b5Ec6WmtpjNeTej91UTEeo54rKV3ki2UiVhebI+20VJz83w0b51k3xOD
 pggw==
X-Gm-Message-State: AOJu0YyJXdb/ywIiaTgWYg9pH1bdQ96CCp/Xu6pQp7/eAfUsSYdsLO78
 Vvl5+isUV7sW9+hckuNkLmLb9AV8OvnOPLzsvxW4Ew==
X-Google-Smtp-Source: AGHT+IHcdmhjn5mQhCWZ0hEsEmPSgQKRAKk7afoUsoXIxv4PyhjmQKMIOHpPXZHHES8h7p8J4UJKnk4n71z6T9LiC5I=
X-Received: by 2002:aa7:ca55:0:b0:525:644f:134b with SMTP id
 j21-20020aa7ca55000000b00525644f134bmr638343edt.25.1692160133721; Tue, 15 Aug
 2023 21:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
 <CAPnjgZ0U7x1FUDNBztecDUFdYDp=3j4kkY0RdWGzPoZ-9WU-Zg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0U7x1FUDNBztecDUFdYDp=3j4kkY0RdWGzPoZ-9WU-Zg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 16 Aug 2023 09:58:42 +0530
Message-ID: <CADg8p96k4S67og6REPt5vF9TruYP+hK+1HcDU_XiauvsF4wXjg@mail.gmail.com>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

hi Simon,

On Wed, 16 Aug 2023 at 00:09, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 15 Aug 2023 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The EFI capsule authentication logic in u-boot expects the public key
> > in the form of an EFI Signature List(ESL) to be provided as part of
> > the platform's dtb. Currently, the embedding of the ESL file into the
> > dtb needs to be done manually.
> >
> > Add a target for generating a dtsi file which contains the signature
> > node with the ESL file included as a property under the signature
> > node. Include the dtsi file in the dtb. This brings the embedding of
> > the ESL in the dtb into the U-Boot build flow.
> >
> > The path to the ESL file is specified through the
> > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since RFC series:
> > * Remove the default value of the config symbol.
> > * s/include_files/dtsi_include_list
> > * Add all the dtsi files being included as dependency for the dtb
> >   target.
> >
> >  lib/efi_loader/Kconfig             |  8 ++++++++
> >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> >  scripts/Makefile.lib               | 18 +++++++++++++++++-
> >  3 files changed, 36 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 9989e3f384..d20aaab6db 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
> >           Select the max capsule index value used for capsule report
> >           variables. This value is used to create CapsuleMax variable.
> >
> > +config EFI_CAPSULE_ESL_FILE
> > +       string "Path to the EFI Signature List File"
>
> Do we need this, or could we name it as we do with the .env file? It
> seems confusing to have to set this for each board - it might be
> better to have it in a defined location.

The reason I put this is because I thought this gave the user the
flexibility to provide the location and name of the ESL. But I suppose
that the board directory would be a good location to expect this file.
Then this file can have a name like capsule_pub_key,esl. Tom, what are
your thoughts on this?

>
> Another idea is that we could use binman to pull this in, e.g. with an
> option to insert the capsule key during the build. Then it can be
> anywhere on the binman path.

So, if I understand you right, I believe you are suggesting using
binman for this task? Which, just to make it clear, I pretty much
understand what would be needed to be done to get this working in
binman. A typical binman image for for this task would look like

&binman {
        u-boot-capsule-esl {
                u-boot-no-dtb {
                };
                fdt-esl {
                        u-boot-dtb {
                        };
                };
        };
};

The fdt-esl entry type would then call the fdt_add_pubkey tool to do
the needful. We also support capsule update for FIT images, and that
would mean adding some logic to call the fdt_add_pubkey for the
fdt_list. So implementing this is not a difficult thing at all.

But the main issue, or rather the only issue with this is that we are
getting an image with a different name, like u-boot-capsule-esl.bin as
the resulting image. But like I had mentioned earlier in our
discussions, we have platforms which boot the u-boot.bin binary. We
also have the ST boards which generate the fip image and use the
u-boot.dtb as the BL33_CFG. So generating a new image binary, or a new
DTB would break these boards. Not to mention that these platforms
would not be interested in using a different image just because they
are enabling some functionality on the platform.

>
> As you know I am not a fan of these opaque binaries when we have a
> nice self-describing format like devicetre. But we can worry about
> that problem another time.

I know, but this is what we have when we follow the UEFI
specification. It is not our design.

-sughosh

>
> > +       depends on EFI_CAPSULE_AUTHENTICATE
> > +       help
> > +         Provides the path to the EFI Signature List file which will
> > +         be embedded in the platform's device tree and used for
> > +         capsule authentication at the time of capsule update.
> > +
> >  config EFI_DEVICE_PATH_TO_TEXT
> >         bool "Device path to text protocol"
> >         default y
> > diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
> > new file mode 100644
> > index 0000000000..61a9f2b25e
> > --- /dev/null
> > +++ b/lib/efi_loader/capsule_esl.dtsi.in
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/**
> > + * Devicetree file with the public key EFI Signature List(ESL)
> > + * node. This file is used to generate the dtsi file to be
> > + * included into the DTB.
> > +*/
> > +/ {
> > +       signature {
> > +               capsule-key = /incbin/("ESL_BIN_FILE");
> > +       };
> > +};
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 368b5a3e28..2e71f190bc 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -334,7 +334,23 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >                 ; \
> >         sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
> >
> > -$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> > +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> > +quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
> > +cmd_capsule_esl_gen = \
> > +       $(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
> > +
> > +$(obj)/.capsule_esl.dtsi:
> > +       $(call cmd_capsule_esl_gen)
> > +
> > +capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
> > +capsule_esl_dtsi = .capsule_esl.dtsi
> > +capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
> > +dtsi_include_list += $(capsule_esl_dtsi)
> > +endif
> > +
> > +dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
> > +
> > +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
> >         $(call if_changed_dep,dtc)
> >
> >  pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
