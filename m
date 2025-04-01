Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E240CC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 20:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5638171B;
	Tue,  1 Apr 2025 22:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gpx0/pwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E53817C4; Tue,  1 Apr 2025 22:47:40 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAA481703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 22:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301493f45aeso9799530a91.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743540456; x=1744145256; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AZyvHMW8i2Y3E1QoGQN7qXXPWFMnmTSLsAL0rzafiFI=;
 b=gpx0/pwX68dLngW6ZqZEF2ACJcyyyZnOqRIQKRlFR7dQ6emDNrOrsDEPH7Rmggyh5f
 RhhlaPvbMX7otEj74VvHLQx2ttRP+/whKPTIu8g5MlAaSx23Phm+GgLvQSEp7AN+P1VH
 3kBlb2jodSUH/8IXHOT9ZV8BZcJyGZK9zxgEEd+YMd+MccDRPzGZT17+mS2O1b0q2ZrY
 sKXHCIjfH4G2koCZbPsMWNztCYm3iqXgOLsS25cnYdbq4fDRandcH5JFweGbtnSTlqnC
 7dO4Xh+9ZVIcKDoVJE2mLa9n62c9oEKBj+53s5WXYcjtha2ksATXWkB5c+xY7Hh2phgH
 TWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743540456; x=1744145256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZyvHMW8i2Y3E1QoGQN7qXXPWFMnmTSLsAL0rzafiFI=;
 b=kivvWbCyGMgJWe3PszXsurSz5LBTi3WMOpo5pWRblctmOqU7lEEXbPjjlzN0MNP/yp
 CMXbhADsxLtJ96PUml6mKTQdze0c4aGcl5YuZmsc6rKmEZuffS/Kp7mG7+ttMx8IKjVQ
 8Y7Zz743HRmkpv9TaBBAKbU2rmn+my+rAi61lQZsYi+2sALXUgO0KX8nCWG1hgc4+DoC
 eiIppLU3ydYjqENEuK4DT1ygiTK8VbysvuWEtbsccjOJ1MBKO9nPnkt9uz62trXfnUSB
 zdoU6gqKbQfCumoOw69iVuVyyvuLzwhBGYWg1h3A1giwvVA4hWwFX2qJaU08E7u/CkOW
 kTSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQoWEk93kgRl6s+0qRLHw5LB1K/HNb2gV7AhxqYm3bK8mCMKdOqnBOkr8OppnZwuxc+eDsDhA=@lists.denx.de
X-Gm-Message-State: AOJu0YxPAK3P+hWL6trK2yGbzSLJt1OolmLLyAYAWf1WYCViphvJ1vFI
 hXo8ObIT7gJCpagmfKrPpRQHpBWroh+V6Mhvszv1puPUXhkWSwkWDdWsIy5lskM0IJxELvr7Xnl
 Jcy3hmNfp32Vg0NFgaXK6UAZxIHJ9Gb/9Fvnx/g==
X-Gm-Gg: ASbGnctWE8jo94NNx/zkmM4mdEDb8Re6BCaxCXe6PGKBSOD6vsmHQflrwj0BuEX0mEx
 Qn1Mp/sxru3wRdprNoNnck9jA/+Nbn0GREUJJJACtnZeSXBvDIN94mt5KyfdAcPwhJMUz6JmW4m
 zazKIRhD61kJl+5te26DIgeFpxN2Y=
X-Google-Smtp-Source: AGHT+IHR/duRZ7jJTsqoeNjxtxaMUrDHGRgK+TUgaA6Dpw6jzJKkwFzTxv6846H5KkbLuhspjPeEsAbaqzGJJ9Gh7H0=
X-Received: by 2002:a17:90a:d643:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-305321784camr19666836a91.32.1743540455870; Tue, 01 Apr 2025
 13:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250401112729.2181793-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250401112729.2181793-1-ilias.apalodimas@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 1 Apr 2025 16:47:24 -0400
X-Gm-Features: AQ5f1JoD8bv2ONxE3cISuNVfYafgcgJ6H9AB_ftivZV-Q2onck5QA94UHw9_J_0
Message-ID: <CAEfUkUKd=jJEFMXxrgD1ghVKJ4qkkV2_ztZv-iOn3-QtCtKz-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: Move public cert for capsules to .rodata
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
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

Hi Ilias,

On Tue, 1 Apr 2025 at 07:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> commit ddf67daac39d ("efi_capsule: Move signature from DTB to .rodata")
> was reverted in
> commit 47a25e81d35c ("Revert "efi_capsule: Move signature from DTB to .rodata"")
> because that's what U-Boot was usually doing -- using the DT to store
> configuration and data. Some of the discussions can be found here [0].
>
> (Ab)using the device tree to store random data isn't ideal though.
> On top of that with new features introduced over the years, keeping
> the certificates in the DT has proven to be problematic.
> One of the reasons is that platforms might send U-Boot a DTB
> from the previous stage loader using a transfer list which won't contain
> the signatures since other loaders are not  aware of internal
> U-Boot ABIs. On top of that QEMU creates the DTB on the fly, so adding
> the capsule certificate there does not work and requires users to dump
> it and re-create it injecting the public keys.
>
> Now that we have proper memory permissions for arm64, move the certificate
> to .rodata and read it from there.
>
> [0] https://lore.kernel.org/u-boot/CAPnjgZ2uM=n8Qo-a=DUkx5VW5Bzp5Xy8=Wgmrw8ESqUBK00YJQ@mail.gmail.com/
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  Makefile                           |  2 +-
>  include/asm-generic/sections.h     |  2 ++
>  lib/efi_loader/Makefile            | 18 +++++++++++++++
>  lib/efi_loader/capsule_esl.dtsi.in | 11 ---------
>  lib/efi_loader/efi_capsule.c       | 37 ++++++++----------------------
>  lib/efi_loader/efi_capsule_key.S   | 17 ++++++++++++++
>  scripts/Makefile.lib               | 27 ----------------------
>  7 files changed, 47 insertions(+), 67 deletions(-)
>  delete mode 100644 lib/efi_loader/capsule_esl.dtsi.in
>  create mode 100644 lib/efi_loader/efi_capsule_key.S
>
> diff --git a/Makefile b/Makefile
> index 620996862e6d..7a77948006a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2229,7 +2229,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
>                itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
>                mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
>                idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
> -              Test* capsule*.*.efi-capsule capsule*.map
> +              Test* capsule*.*.efi-capsule capsule*.map capsule_esl_file
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 024b1adde270..d59787948fd1 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -28,6 +28,8 @@ extern char __efi_helloworld_begin[];
>  extern char __efi_helloworld_end[];
>  extern char __efi_var_file_begin[];
>  extern char __efi_var_file_end[];
> +extern char __efi_capsule_sig_begin[];
> +extern char __efi_capsule_sig_end[];
>
>  /* Private data used by of-platdata devices/uclasses */
>  extern char __priv_data_start[], __priv_data_end[];
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 2a0b4172bd7f..dc2912148951 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -29,6 +29,7 @@ obj-y += efi_boottime.o
>  obj-y += efi_helper.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
>  obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) += efi_firmware.o
> +obj-$(CONFIG_EFI_CAPSULE_AUTHENTICATE) += efi_capsule_key.o
>  obj-y += efi_console.o
>  obj-y += efi_device_path.o
>  obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
> @@ -73,6 +74,23 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
>  EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>  $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
>
> +ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
> +capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
> +capsule_crt_full=$(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
> +quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
> +cmd_capsule_esl_gen = cert-to-efi-sig-list $(capsule_crt_full) $@
> +$(srctree)/capsule_esl_file: FORCE
> +       @if [ ! -e "$(capsule_crt_full)" ]; then \
> +               echo "ERROR: path $(capsule_crt_full) is invalid." >&2; \
> +               echo "EFI CONFIG_EFI_CAPSULE_CRT_FILE must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled." >&2; \
> +               exit 1; \
> +       fi
> +       $(call cmd,capsule_esl_gen)
> +
> +$(obj)/efi_capsule.o: $(srctree)/capsule_esl_file FORCE
> +asflags-y += -DCAPSULE_ESL_PATH=\"$(srctree)/capsule_esl_file\"
> +endif
> +
>  # Set the C flags to add and remove for each app
>  $(foreach f,$(apps-y),\
>         $(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
> diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
> deleted file mode 100644
> index bc7db836faa8..000000000000
> --- a/lib/efi_loader/capsule_esl.dtsi.in
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Devicetree file with the public key EFI Signature List(ESL)
> - * node. This file is used to generate the dtsi file to be
> - * included into the DTB.
> - */
> -/ {
> -       signature {
> -               capsule-key = /incbin/("ESL_BIN_FILE");
> -       };
> -};
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index f8a4a7c6ef46..1aa52ac7bb69 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -22,6 +22,7 @@
>  #include <asm/global_data.h>
>  #include <u-boot/uuid.h>
>
> +#include <asm/sections.h>
>  #include <crypto/pkcs7.h>
>  #include <crypto/pkcs7_parser.h>
>  #include <linux/err.h>
> @@ -284,33 +285,12 @@ out:
>  }
>
>  #if defined(CONFIG_EFI_CAPSULE_AUTHENTICATE)
> -int efi_get_public_key_data(void **pkey, efi_uintn_t *pkey_len)
> +static int efi_get_public_key_data(const void **pkey, efi_uintn_t *pkey_len)
>  {
> -       const void *fdt_blob = gd->fdt_blob;
> -       const void *blob;
> -       const char *cnode_name = "capsule-key";
> -       const char *snode_name = "signature";
> -       int sig_node;
> -       int len;
> -
> -       sig_node = fdt_subnode_offset(fdt_blob, 0, snode_name);
> -       if (sig_node < 0) {
> -               log_err("Unable to get signature node offset\n");
> -
> -               return -FDT_ERR_NOTFOUND;
> -       }
> -
> -       blob = fdt_getprop(fdt_blob, sig_node, cnode_name, &len);
> -
> -       if (!blob || len < 0) {
> -               log_err("Unable to get capsule-key value\n");
> -               *pkey = NULL;
> -               *pkey_len = 0;
> -
> -               return -FDT_ERR_NOTFOUND;
> -       }
> +       const void *blob = __efi_capsule_sig_begin;
> +       const int len = __efi_capsule_sig_end - __efi_capsule_sig_begin;
>
> -       *pkey = (void *)blob;
> +       *pkey = blob;
>         *pkey_len = len;
>
>         return 0;
> @@ -321,7 +301,8 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
>  {
>         u8 *buf;
>         int ret;
> -       void *fdt_pkey, *pkey;
> +       void *pkey;
> +       const void *stored_pkey;
>         efi_uintn_t pkey_len;
>         uint64_t monotonic_count;
>         struct efi_signature_store *truststore;
> @@ -373,7 +354,7 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
>                 goto out;
>         }
>
> -       ret = efi_get_public_key_data(&fdt_pkey, &pkey_len);
> +       ret = efi_get_public_key_data(&stored_pkey, &pkey_len);
>         if (ret < 0)
>                 goto out;
>
> @@ -381,7 +362,7 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
>         if (!pkey)
>                 goto out;
>
> -       memcpy(pkey, fdt_pkey, pkey_len);
> +       memcpy(pkey, stored_pkey, pkey_len);
>         truststore = efi_build_signature_store(pkey, pkey_len);
>         if (!truststore)
>                 goto out;
> diff --git a/lib/efi_loader/efi_capsule_key.S b/lib/efi_loader/efi_capsule_key.S
> new file mode 100644
> index 000000000000..80cefbe16ae0
> --- /dev/null
> +++ b/lib/efi_loader/efi_capsule_key.S
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * .esl cert for capsule authentication
> + *
> + * Copyright (c) 2021, Ilias Apalodimas <ilias.apalodimas@linaro.org>
> + */
> +
> +#include <config.h>
> +
> +.section .rodata.capsule_key.init,"a"
> +.balign 16
> +.global __efi_capsule_sig_begin
> +__efi_capsule_sig_begin:
> +.incbin CAPSULE_ESL_PATH
> +__efi_capsule_sig_end:
> +.global __efi_capsule_sig_end
> +.balign 16
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 275c308154b1..83fd5ff6c31c 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -377,35 +377,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>                 ; \
>         sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>
> -capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
> -capsule_crt_file=$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
> -capsule_esl_dtsi=.capsule_esl.dtsi
> -
> -quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
> -cmd_capsule_esl_gen = cert-to-efi-sig-list $< $@
> -
> -$(obj)/capsule_esl_file: $(capsule_crt_file) FORCE
> -ifeq ($(CONFIG_EFI_CAPSULE_CRT_FILE),"")
> -       $(error "CONFIG_EFI_CAPSULE_CRT_FILE is empty, EFI capsule authentication \
> -       public key must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled")
> -else
> -       $(call cmd,capsule_esl_gen)
> -endif
> -
> -quiet_cmd_capsule_dtsi_gen = CAPSULE_DTSI_GEN $@
> -cmd_capsule_dtsi_gen = \
> -       $(shell sed "s:ESL_BIN_FILE:$(abspath $<):" $(capsule_esl_input_file) > $@)
> -
> -$(obj)/$(capsule_esl_dtsi): $(obj)/capsule_esl_file FORCE
> -       $(call cmd,capsule_dtsi_gen)
> -
>  dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
>
> -ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> -dtsi_include_list += $(capsule_esl_dtsi)
> -dtsi_include_list_deps += $(obj)/$(capsule_esl_dtsi)
> -endif
> -
>  ifneq ($(CHECK_DTBS),)
>  DT_CHECKER ?= dt-validate
>  DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> --
> 2.49.0
>
Tested-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
