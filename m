Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6B6CF6491
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 06:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 082B988D8B;
	Mon, 30 Sep 2024 08:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zbLlkrDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10BA88DCC; Mon, 30 Sep 2024 08:04:19 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815BB885B3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4a3b679ac52so429917137.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 23:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727676256; x=1728281056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Brp0zPYqO1vFUyjeGizE+gFe5RMB452mHiVnOdtRxdY=;
 b=zbLlkrDUnYhTPWHh59kT/kjctvlg15zcaW6SANsZM4WyfAMRRbtefMfEWobENKrItJ
 PYbzgf+eQLstEnFrsLh6hjW5bNxh/0o8ygCzs1B8vyr2H+uXX4ZE5cXwF4MnchsEI5RW
 ldcSGhKg8jCVH1CcVMrWiy6dsnr6hgmkIZHFhSgxS/8G3FKtbu4AAwdiW0bXwkfXQlcg
 hbNgzNIuk0S3lMnDAYQrQnnj77/yf9Q9Uh5RLUTmGg2mxpmzWmb3QL+ruenxPigUj3LE
 8iLvIxbLVdEc4yAMt8/PTKQnMN5ZrB+UiBDygvCW1zATNviiAktklNCkqWIRpa+WysbY
 wh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727676256; x=1728281056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Brp0zPYqO1vFUyjeGizE+gFe5RMB452mHiVnOdtRxdY=;
 b=BY1VQeUVUy2NKYWHVm/pa6KSmbMvH0v2qm9GCODmF16GThWQHB1TzVTXqN+NE9/XKk
 SE3eFVA9ZKM8mns5ye6EghO+rx3JUZGjGgkIpNlfWvnxWDkeYZYdPPyPsIhYHZeUi88H
 snCid/ZOhv4WDYEnEArMAP+N89dG/GK6Cs9YPu41sSZAYQa+7VzVSdfz7k8heCc0fKJC
 /gAHKnajHbGew+dBA/QItX/30Pjud1W/smGNP7+eQk2GpYaZEuODq/Jue3ySIojF/n3H
 jYcIyiElUpmf3C2zN7wXtc1vy5Lh51vwJEdLU1Dn1R1f8e1NLy6/t56VF+LqwQ7ptVZD
 pF/A==
X-Gm-Message-State: AOJu0Yx1fLnAnGQ9UdZZzR7IDYvmiHA3dGy0m0a1VA5K+yVkVUSyFbvc
 9vsMpUd5rYOiiqyVvSHfcW8nYAo7nw8MMbpB7Y6L7mTrpn67wbPj/VQOLQhIGOrS7gT+Gijsm3s
 BRfagEBRGnk1x+tlI/otIwXJIolMSMHoaffTxjA==
X-Google-Smtp-Source: AGHT+IG899nF4iDMp880W3Qej3pLbdJ8wVTjWc1IL6uJb5nTg+I5oe7m86D9YoMF15q/oYbIzCQOUBpRw9lgKHNRp0Q=
X-Received: by 2002:a05:6102:3e85:b0:498:ccd9:5b1e with SMTP id
 ada2fe7eead31-4a2ceff0665mr7200813137.4.1727676256298; Sun, 29 Sep 2024
 23:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240927214955.394224-1-marex@denx.de>
In-Reply-To: <20240927214955.394224-1-marex@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 30 Sep 2024 11:34:05 +0530
Message-ID: <CAFA6WYOr1SoyY+OVLrUPPWZWmH23P3fn=NzucmnHcTEM9OpEDQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dts: Deduplicate dtbs target
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
>
> The dtbs: target is almost identical in all architecture Makefiles.
> All architecture Makefiles include scripts/Makefile.dts . Deduplicate
> the dtbs: target into scripts/Makefile.dts . No functional change.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Lothar Rubusch <l.rubusch@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
>  arch/arc/dts/Makefile            | 9 +--------
>  arch/arm/dts/Makefile            | 8 --------
>  arch/m68k/dts/Makefile           | 9 +--------
>  arch/microblaze/dts/Makefile     | 9 +--------
>  arch/mips/dts/Makefile           | 8 --------
>  arch/nios2/dts/Makefile          | 9 +--------
>  arch/powerpc/dts/Makefile        | 8 --------
>  arch/riscv/dts/Makefile          | 9 +--------
>  arch/sandbox/dts/Makefile        | 9 +--------
>  arch/sh/dts/Makefile             | 8 --------
>  arch/x86/dts/Makefile            | 8 --------
>  arch/xtensa/dts/Makefile         | 8 --------
>  dts/upstream/src/arm/Makefile    | 8 --------
>  dts/upstream/src/arm64/Makefile  | 8 --------
>  dts/upstream/src/xtensa/Makefile | 8 --------
>  scripts/Makefile.dts             | 8 ++++++++
>  16 files changed, 14 insertions(+), 120 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arc/dts/Makefile b/arch/arc/dts/Makefile
> index 532a8131c59..fe6ad7b849a 100644
> --- a/arch/arc/dts/Makefile
> +++ b/arch/arc/dts/Makefile
> @@ -10,12 +10,5 @@ dtb-$(CONFIG_TARGET_IOT_DEVKIT) +=  iot_devkit.dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>  DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index cdb90f1d358..5976ebd09fc 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1304,16 +1304,8 @@ dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  # Add any required device tree compiler flags here
>  DTC_FLAGS += -a 0x8
>
>  DTC_FLAGS_imx8mp-dhcom-som-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
>  DTC_FLAGS_imx8mp-dhcom-pdk3-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb *.dtbo *_HS
> diff --git a/arch/m68k/dts/Makefile b/arch/m68k/dts/Makefile
> index 7988522eb98..8b354b9c570 100644
> --- a/arch/m68k/dts/Makefile
> +++ b/arch/m68k/dts/Makefile
> @@ -20,12 +20,5 @@ dtb-$(CONFIG_TARGET_STMARK2) += stmark2.dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>  DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
> index 427a8f9aaca..9be902d3bb1 100644
> --- a/arch/microblaze/dts/Makefile
> +++ b/arch/microblaze/dts/Makefile
> @@ -4,12 +4,5 @@ dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>  DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
> index 14fbce597b9..752e771514f 100644
> --- a/arch/mips/dts/Makefile
> +++ b/arch/mips/dts/Makefile
> @@ -39,13 +39,5 @@ dtb-$(CONFIG_SOC_SERVAL) += serval_pcb105.dtb serval_pcb106.dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  # Add any required device tree compiler flags here
>  DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/nios2/dts/Makefile b/arch/nios2/dts/Makefile
> index 2b29fa90f6c..d77db9762a1 100644
> --- a/arch/nios2/dts/Makefile
> +++ b/arch/nios2/dts/Makefile
> @@ -4,12 +4,5 @@ dtb-y += $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%).dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>  DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
> index 321c644804e..766b0c05951 100644
> --- a/arch/powerpc/dts/Makefile
> +++ b/arch/powerpc/dts/Makefile
> @@ -35,13 +35,5 @@ dtb-$(CONFIG_TARGET_CMPCPRO) += cmpcpro.dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  # Add any required device tree compiler flags here
>  DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index c4c44057bad..f3dfd751cb4 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -15,12 +15,5 @@ dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>  DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/sandbox/dts/Makefile b/arch/sandbox/dts/Makefile
> index f810b4752f5..1c9fb4a4566 100644
> --- a/arch/sandbox/dts/Makefile
> +++ b/arch/sandbox/dts/Makefile
> @@ -10,12 +10,5 @@ dtb-$(CONFIG_CMD_EXTENSION) += overlay0.dtbo overlay1.dtbo
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>  DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb *.dtbo
> diff --git a/arch/sh/dts/Makefile b/arch/sh/dts/Makefile
> index 144fd3e7d22..e9153e42534 100644
> --- a/arch/sh/dts/Makefile
> +++ b/arch/sh/dts/Makefile
> @@ -2,13 +2,5 @@ dtb-y += sh7751-r2dplus.dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  # Add any required device tree compiler flags here
>  DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb *_HS
> diff --git a/arch/x86/dts/Makefile b/arch/x86/dts/Makefile
> index cd77f4c4e81..9a46726e026 100644
> --- a/arch/x86/dts/Makefile
> +++ b/arch/x86/dts/Makefile
> @@ -24,12 +24,4 @@ dtb-y += bayleybay.dtb \
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  DTC_FLAGS += -R 4 -p $(if $(CONFIG_EFI_APP),0x8000,0x1000)
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/arch/xtensa/dts/Makefile b/arch/xtensa/dts/Makefile
> index c22c50ac4e5..aa582b85e5c 100644
> --- a/arch/xtensa/dts/Makefile
> +++ b/arch/xtensa/dts/Makefile
> @@ -4,12 +4,4 @@ dtb-$(CONFIG_XTENSA) += ml605.dtb ml605_nommu.dtb kc705.dtb kc705_nommu.dtb
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb
> diff --git a/dts/upstream/src/arm/Makefile b/dts/upstream/src/arm/Makefile
> index 9a8f6aa3584..c86a2be5d85 100644
> --- a/dts/upstream/src/arm/Makefile
> +++ b/dts/upstream/src/arm/Makefile
> @@ -2,13 +2,5 @@
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  # Add any required device tree compiler flags here
>  DTC_FLAGS += -a 0x8
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := */*.dtb */*.dtbo
> diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
> index 26a83d3d29d..b6db0dc6b26 100644
> --- a/dts/upstream/src/arm64/Makefile
> +++ b/dts/upstream/src/arm64/Makefile
> @@ -2,17 +2,9 @@
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  # Add any required device tree compiler flags here
>  DTC_FLAGS += -a 0x8
>
>  ifdef CONFIG_RCAR_64
>  DTC_FLAGS += -R 4 -p 0x1000
>  endif
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := */*.dtb */*.dtbo
> diff --git a/dts/upstream/src/xtensa/Makefile b/dts/upstream/src/xtensa/Makefile
> index 2a81acb32bc..c86a2be5d85 100644
> --- a/dts/upstream/src/xtensa/Makefile
> +++ b/dts/upstream/src/xtensa/Makefile
> @@ -2,13 +2,5 @@
>
>  include $(srctree)/scripts/Makefile.dts
>
> -targets += $(dtb-y)
> -
>  # Add any required device tree compiler flags here
>  DTC_FLAGS += -a 0x8
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -       @:
> -
> -clean-files := *.dtb *.dtbo */*.dtb */*.dtbo
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 790f3c508f1..1fe142f2bbf 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -14,3 +14,11 @@ dtb-vendor_dts := $(patsubst %.dts,%.dtb,$(wildcard $(dt_dir)/$(subst ",,$(CONFI
>  dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
>
>  endif
> +
> +targets += $(dtb-y)
> +
> +PHONY += dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS
> --
> 2.45.2
>
