Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06197C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D95B86813;
	Wed, 20 Dec 2023 05:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N7muQ1Jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D8C876C0; Wed, 20 Dec 2023 05:47:52 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C0D7807D9
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33678156e27so497395f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047670; x=1703652470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kAVYF8zMbbeSRptMp0piciVuVCSIiXV7VVXvv87BbpA=;
 b=N7muQ1JolQnPGOV4BT8hYHRKxsd2RMVfOfX06bmbzxMetjT4aLR1qH+u/K5bOvuCNl
 kzF80eanZrvadUtNZkPKgod7+k/+fzJNk84z87vPHTn8rYs2YK4oZL5w2ZJdpGmEmEgQ
 rvbxokjzzqhpiPzenTkIF1hUuw1fv8CrUX5Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047670; x=1703652470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAVYF8zMbbeSRptMp0piciVuVCSIiXV7VVXvv87BbpA=;
 b=jBCp/aBGiHk0g0ZiFz8aS3rhzU10s2/resVJyGciBSUTJLoDL3Ur8KpPOEftc6eeu3
 SCW9AuSYdgQCtYfj70Z7+36VUF8xFCSeF+Z0cMOiM5JN/H1Jp+UxN5YUqxkLiDzyTKvr
 SoMuJNyaqpS81ITNAeJHL4sa/FZdStXvnyADluEV5iRwWIYQNavPNyesyuNrBSh/069h
 NdME5SfVhLhTSnVTtEKFjGjt1HvNTH4sVmLMbrhTB2av8GLqHdo3e/7xjNr+w5kgC/RU
 XJ7kUWJnIgJHE5TekD4bVEioUUWlbPegG2c4TydBQZ+F/QtS3WjkH3HXMUoTSpkYO5Fq
 EzRg==
X-Gm-Message-State: AOJu0YzxApMm5zwZVV7t/sHGSXuX1092MTMs0SGZUOU26Plng9Mad5oE
 Ksu7g8Mlf3mxqUMeKjz2hqld2wEVwqIrhrYBUOuftUkMt6Hl3mae9KI=
X-Google-Smtp-Source: AGHT+IGz7UuauJkWmRvsgeDcPDAm/Gg3/HL6qLIhb3me9kc+hnH6afdpU8BR1GaS0mXzpk5JkNbrJKjt7VrdSt57oC8=
X-Received: by 2002:a17:906:109a:b0:a26:8dd9:7bf5 with SMTP id
 u26-20020a170906109a00b00a268dd97bf5mr352058eju.44.1703047649290; Tue, 19 Dec
 2023 20:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-5-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-5-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:17 -0700
Message-ID: <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Sumit Garg <sumit.garg@linaro.org>
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

Hi Sumit,

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Allow platform owners to mirror devicetree files from devitree-rebasing
> directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
> build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
> directory.

Also add a new Makefile for arm64.

>
> This will help easy migration for platforms which currently are compliant
> with upstream Linux kernel devicetree files.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  dts/Kconfig             | 11 +++++++++++
>  dts/Makefile            | 17 ++++++++++++++---
>  dts/arch/arm64/Makefile | 14 ++++++++++++++
>  3 files changed, 39 insertions(+), 3 deletions(-)
>  create mode 100644 dts/arch/arm64/Makefile
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 00c0aeff893..96396f12b67 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -85,6 +85,17 @@ config OF_LIVE
>           enables a live tree which is available after relocation,
>           and can be adjusted as needed.
>
> +config OF_UPSTREAM
> +       bool "Enable use of devicetree imported from Linux kernel release"
> +       help
> +         Traditionally, U-boot platforms used to have their custom devicetree

U-Boot

(I think I mentioned this, but you thought I said U-boot...but it
really is U-Boot). Perhaps grep your patches next time.

> +         files or copy devicetree files from Linux kernel which are hard to
> +         maintain and can usually get out-of-sync from Linux kernel. This
> +         option enables platforms to migrate to devicetree-rebasing repo where
> +         a regular sync will be maintained every major Linux kernel release
> +         cycle. However, platforms can still have some custom u-boot specific
> +         bits maintained as part of *-u-boot.dtsi files.

I'm a bit nervous about this. It means that boards chose between this
dir of the local files. It means there is some effort to switch.

I wonder if we could default to using the rebasing thing, with boards
having to 'opt out'? So this should be 'default y' ?


> +
>  choice
>         prompt "Provider of DTB for DT control"
>         depends on OF_CONTROL
> diff --git a/dts/Makefile b/dts/Makefile
> index 3437e54033d..8098bf8191a 100644
> --- a/dts/Makefile
> +++ b/dts/Makefile
> @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
>  DEVICE_TREE := unset
>  endif
>
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifeq ($(CONFIG_ARM64),y)
> +DEVICE_TREE_LOC := dts/arch/arm64

dt_dir ?

Should we move the arm64 DTs to arch/arm64 ?

What about the subdirs used in Linux?

> +else
> +DEVICE_TREE_LOC := dts/arch/$(ARCH)
> +endif
> +else
> +DEVICE_TREE_LOC := arch/$(ARCH)/dts
> +endif
> +
>  ifneq ($(EXT_DTB),)
>  DTB := $(EXT_DTB)

>
>  else
> -DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
> +DTB := $(DEVICE_TREE_LOC)/$(DEVICE_TREE).dtb
>  endif
>
>  $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
> @@ -41,7 +51,7 @@ $(DTB): arch-dtbs
>
>  PHONY += arch-dtbs
>  arch-dtbs:
> -       $(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
> +       $(Q)$(MAKE) $(build)=$(DEVICE_TREE_LOC) dtbs
>
>  ifeq ($(CONFIG_SPL_BUILD),y)
>  obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
> @@ -65,4 +75,5 @@ clean-files := dt.dtb.S
>  # Let clean descend into dts directories
>  subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts     \
>            ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts     \
> -          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts
> +          ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts        \
> +          ./arch/arm64 ./arch/$(ARCH)
> diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> new file mode 100644
> index 00000000000..16e9fea622d
> --- /dev/null
> +++ b/dts/arch/arm64/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +targets += $(dtb-y)
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS += -a 0x8
> +
> +PHONY += dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files := */*.dtb */*.dtbo */*_HS
> --
> 2.34.1

Regards,
Simon
