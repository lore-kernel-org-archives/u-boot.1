Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390FDD0C5F9
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 09:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7C288FCB;
	Fri, 25 Oct 2024 11:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y82msKbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37CB488FCB; Fri, 25 Oct 2024 11:53:40 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584DA88E65
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 11:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20ceb8bd22fso14114075ad.3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729850016; x=1730454816; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uf4wNSc6HoiXhv0e2sO89MVFom4xRQ08FSGQiGO/MmQ=;
 b=Y82msKbWWYzo4om/7wps4HmEAGpIA52Q+jtIKK4ilBXQREJlE+8KVqq0T1aUxX3aFI
 s6sM8qkPSx26r12oKUUWLS07uKmFb4dz1ancF7zADBfGW8AksYhGqmA44yiLnipipiid
 csdK2mskPkVcWX7nIuNC9Crabp73qxH/OMJmcyvxet2XS5i7wNjY8CBQV68TQrY19Ent
 qJqvzWipPmYQFrtOQWxf79TBf59Nxp4xIqRJJaoovCLgBr9XZk6tPpOBbbES7YpCYX3/
 ArMYSzbqt1Z94vZgGcfl5IbZBaP4NrQOKGSXN4ekwK+uaMflIFLUCm2E39AqiwZqU/b3
 3tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729850016; x=1730454816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uf4wNSc6HoiXhv0e2sO89MVFom4xRQ08FSGQiGO/MmQ=;
 b=pmlXw+qZqPZkuFQAm5fgptQsaiBlxFa8muWBZYY/tx0UJZGOAH0Q8RJ/sar6b8XSao
 cyijVLy7rO9p0kvFnMrohaW/b09lWTZedRJQ5UFLXgnB9u6E3lLhaIJpSCULj8yKAQsr
 M26sLZldmoc76KO8dQ/4TrQS5o23PeW/J2Y7z2Dgd2WtglHhO01BgrKIWVd2Qn7Yaw3Y
 CUH/ttX1qwPDk1AB8I45+rTr54Qf1t8W2DAKoOu0roLPEJxH24Om2bMiDlBnYzm4PaiT
 5RmV4KAux2i2RPhZetm+NE4M3GdG/2HOrLSmfxyLx+5SVpsIT6cc+oJdXVoI8rzhDm5F
 zZjA==
X-Gm-Message-State: AOJu0YzSjh79rKI9OXjdHcrBh/zZVMWe+SuHF+PdgzO96wTfxh0uDGOj
 mr8sqGgSt1009n7BstaffVIBNQ+WTi+0v38EBmgNc0LTEJRT/C4b047G0DcewMnVbOC2rXk1aco
 KfA8yvtHeS6dCArCUITk0KpyMt+h6JaQO2pViIA==
X-Google-Smtp-Source: AGHT+IH9XblKARMIMZaplV3jNgEQXymH5pm2HOpMviEO1roazQG705bFwFrCr0fgl1ZMPUxWVH6HQY0nGb9fM3m4xP4=
X-Received: by 2002:a05:6a21:2fc7:b0:1d9:1274:b769 with SMTP id
 adf61e73a8af0-1d978b2da2emr11281165637.26.1729850015726; Fri, 25 Oct 2024
 02:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-4-sjg@chromium.org>
In-Reply-To: <20241022120032.196311-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 12:52:59 +0300
Message-ID: <CAC_iWjKuNrRKtik1uY0++o5JzM5iKdUYH7jRCTiJo2=hJZWoCw@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] efi: Move default filename to a function
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
>
> Use a function to obtain the device EFI filename, so that we can control
> how sandbox behaves.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v8:
> - Add new patch to move default filename to a function
>
>  boot/Makefile                                      |  4 +++-
>  boot/bootmeth_efi.c                                |  4 ++--
>  include/efi_default_filename.h => boot/efi_fname.c | 11 +++++------
>  include/efi.h                                      |  9 +++++++++
>  lib/efi_loader/efi_bootmgr.c                       | 10 +++++++---
>  test/boot/bootflow.c                               |  6 +++---
>  6 files changed, 29 insertions(+), 15 deletions(-)
>  rename include/efi_default_filename.h => boot/efi_fname.c (93%)

Let's not spread efi files all around the place. Can you add the
function you want in lib/efi_loader/efi_helped.c which is there to add
helper files?


>
> diff --git a/boot/Makefile b/boot/Makefile
> index b24f806d5bf..d3f2c02068c 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -28,7 +28,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
>
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
> -obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
> +obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o efi_fname.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
> @@ -40,6 +40,8 @@ obj-$(CONFIG_$(PHASE_)EXPO) += bootflow_menu.o
>  obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootflow_menu.o
>  endif
>
> +obj-$(CONFIG_EFI_LOADER) += efi_fname.o
> +
>  obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdt_support.o
>  obj-$(CONFIG_$(PHASE_)FDT_SIMPLEFB) += fdt_simplefb.o
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 2ad6d3b4ace..371b36d550b 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -13,7 +13,7 @@
>  #include <bootmeth.h>
>  #include <command.h>
>  #include <dm.h>
> -#include <efi_default_filename.h>
> +#include <efi.h>
>  #include <efi_loader.h>
>  #include <fs.h>
>  #include <malloc.h>
> @@ -168,7 +168,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>         }
>
>         strcpy(fname, EFI_DIRNAME);
> -       strcat(fname, BOOTEFI_NAME);
> +       strcat(fname, efi_get_basename());
>
>         if (bflow->blk)
>                  desc = dev_get_uclass_plat(bflow->blk);
> diff --git a/include/efi_default_filename.h b/boot/efi_fname.c
> similarity index 93%
> rename from include/efi_default_filename.h
> rename to boot/efi_fname.c
> index 77932984b55..a6b11383bba 100644
> --- a/include/efi_default_filename.h
> +++ b/boot/efi_fname.c
> @@ -8,13 +8,9 @@
>   * Copyright (c) 2022, Linaro Limited
>   */
>
> -#ifndef _EFI_DEFAULT_FILENAME_H
> -#define _EFI_DEFAULT_FILENAME_H
> -
> +#include <efi.h>
>  #include <host_arch.h>
>
> -#undef BOOTEFI_NAME
> -
>  #ifdef CONFIG_SANDBOX
>
>  #if HOST_ARCH == HOST_ARCH_X86_64
> @@ -53,4 +49,7 @@
>
>  #endif
>
> -#endif
> +const char *efi_get_basename(void)
> +{
> +       return BOOTEFI_NAME;
> +}
> diff --git a/include/efi.h b/include/efi.h
> index 84640cf7b25..1b8093bd4d3 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -669,4 +669,13 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
>   */
>  void efi_show_tables(struct efi_system_table *systab);
>
> +/**
> + * efi_get_basename() - Get the default filename to use when loading
> + *
> + * E.g. this returns BOOTAA64.EFI for an aarch target
> + *
> + * Return: Default EFI filename
> + */
> +const char *efi_get_basename(void);
> +
>  #endif /* _LINUX_EFI_H */
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a3aa2b8d1b9..cb9664c91a2 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -11,10 +11,10 @@
>  #include <blkmap.h>
>  #include <charset.h>
>  #include <dm.h>
> +#include <efi.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <net.h>
> -#include <efi_default_filename.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <asm/unaligned.h>
> @@ -82,8 +82,12 @@ struct efi_device_path *expand_media_path(struct efi_device_path *device_path)
>                                  &efi_simple_file_system_protocol_guid, &rem);
>         if (handle) {
>                 if (rem->type == DEVICE_PATH_TYPE_END) {
> -                       full_path = efi_dp_from_file(device_path,
> -                                                    "/EFI/BOOT/" BOOTEFI_NAME);
> +                       char fname[30];
> +
> +                       snprintf(fname, sizeof(fname), "/EFI/BOOT/%s",
> +                                efi_get_basename());
> +                       full_path = efi_dp_from_file(device_path, fname);
> +
>                 } else {
>                         full_path = efi_dp_dup(device_path);
>                 }
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index cc894e804a4..539abe63ebe 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -12,7 +12,7 @@
>  #include <bootstd.h>
>  #include <cli.h>
>  #include <dm.h>
> -#include <efi_default_filename.h>
> +#include <efi.h>
>  #include <expo.h>
>  #ifdef CONFIG_SANDBOX
>  #include <asm/test.h>
> @@ -184,8 +184,8 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
>         ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
>         ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
>         ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
> -       ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/"
> -                          BOOTEFI_NAME);
> +       ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/%s",
> +                          efi_get_basename());
>
>         ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
>         ut_assert_skip_to_line(
> --
> 2.43.0
>

Thanks
/Ilias
