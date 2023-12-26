Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D42C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3DB8788F;
	Tue, 26 Dec 2023 10:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jq91w3vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D208792A; Tue, 26 Dec 2023 10:48:18 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4317D87908
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6dbbef36fe0so2442426a34.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584095; x=1704188895; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wy6JlWEVxk0I41u9/jDa4Js1fVOX8ONGEaKapVmGPj4=;
 b=Jq91w3vmVvL0Nh18ilMQcNj1UAQqBM+Cx4tazF8lWEtQwYnh/2qCIhbyVgnBxaUU5F
 YCOTCdqhX1aqQD+cd29Kt7/YI+HadxdBCwliWhAHiUjsimV0ospMSCHZmoyKGLeKom9c
 ToUlRIQAT4TkvPUr5BncZHIx1MbHFneEgy8yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584095; x=1704188895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wy6JlWEVxk0I41u9/jDa4Js1fVOX8ONGEaKapVmGPj4=;
 b=bIH1A2kQs0wLQ4FHnhJ4dTKDIaHpaImOkRMClo3JnFLukr8GUVp+jhMPXydGkVUMEr
 xVZFDn9n1WHkzf01vrOyBnAa9eBsSw0zA549R4vM6UGNWVp2hPEHu/4zeIgegq3RxhxC
 8UbkEjlIWeSe808Vj2ub9YSQWMc72abRtp+qx/gZlC263icXcuVifjiyCBJCb9Ayt1/d
 X+60tIhXGMfSlU95bgmxwJwmdXyPwy/LMOqrIGG9HRG7ZcWxBc1qnW5RKdRdkbxe451U
 IhpSU0dRoZV05N/q/d1unLPBAKeXW6XDGd71U0UTt0zZxMXd+Edqp5dkm0xtGuwIGNRx
 WdAw==
X-Gm-Message-State: AOJu0YwEl1G8oIfsxKPmK9EOMWTqmq9swbnydtr6gcDnZSQkHxK/4Tnb
 o7tk7XhN0vkPHurCTSOD6ODnU/jiAMq0yjejvYiwrMojZPpB
X-Google-Smtp-Source: AGHT+IFXt1A3/EVuNN20JcQ1LsAfOaEQefNCf4dN10Eril9JkODIlvMfbg+bGp1evTDOLkGxwG1Up03cIjGint5vN0Q=
X-Received: by 2002:a05:6808:114c:b0:3bb:7700:b7bf with SMTP id
 u12-20020a056808114c00b003bb7700b7bfmr8310669oiu.18.1703584094916; Tue, 26
 Dec 2023 01:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20231223010334.248291-1-xypron.glpk@gmx.de>
 <20231223010334.248291-3-xypron.glpk@gmx.de>
In-Reply-To: <20231223010334.248291-3-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:38 +0000
Message-ID: <CAFLszTjLj2s+RKwikofXtAebW42o7J4M2yajjaeWX0OBp_e+rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] smbios: copy QEMU tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

On Sat, Dec 23, 2023 at 1:03=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> QEMU provides SMBIOS tables with detailed information. We should not try =
to
> replicate them in U-Boot.
>
> If we want to inform about U-Boot, we can add a Firmware Inventory
> Information (type 45) table in future.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         fix parsing of SMBIOS anchor
>         enable copying on x86 and 32bit ARM/RISC-V
> ---
>  arch/x86/lib/tables.c       |   2 +-
>  drivers/misc/Kconfig        |   7 ++
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/qfw_smbios.c   | 197 ++++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_smbios.c |   4 +-
>  5 files changed, 209 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/misc/qfw_smbios.c
>
> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
> index 5b5070f7ca..914d9de0cb 100644
> --- a/arch/x86/lib/tables.c
> +++ b/arch/x86/lib/tables.c
> @@ -61,7 +61,7 @@ static struct table_info table_list[] =3D {
>  #ifdef CONFIG_GENERATE_ACPI_TABLE
>         { "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0x10=
00},
>  #endif
> -#ifdef CONFIG_GENERATE_SMBIOS_TABLE
> +#if defined(CONFIG_GENERATE_SMBIOS_TABLE) && !defined(CONFIG_QFW_SMBIOS)
>         { "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x1000, =
0x100},
>  #endif
>  };
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e8e4400516..d2536c54e0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -561,6 +561,13 @@ config QFW_MMIO
>           Hidden option to enable MMIO QEMU fw_cfg interface. This will b=
e
>           selected by the appropriate QEMU board.
>
> +config QFW_SMBIOS
> +       bool
> +       default y
> +       depends on QFW && SMBIOS && !SANDBOX
> +       help
> +         Hidden option to read SMBIOS tables from QEMU.
> +
>  config I2C_EEPROM
>         bool "Enable driver for generic I2C-attached EEPROMs"
>         depends on MISC
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index cda701d38e..64bea92f51 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -66,6 +66,7 @@ obj-y +=3D qfw.o
>  obj-$(CONFIG_QFW_ACPI) +=3D qfw_acpi.o
>  obj-$(CONFIG_QFW_PIO) +=3D qfw_pio.o
>  obj-$(CONFIG_QFW_MMIO) +=3D qfw_mmio.o
> +obj-$(CONFIG_QFW_SMBIOS) +=3D qfw_smbios.o
>  obj-$(CONFIG_SANDBOX) +=3D qfw_sandbox.o
>  endif
>  obj-$(CONFIG_ROCKCHIP_EFUSE) +=3D rockchip-efuse.o
> diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
> new file mode 100644
> index 0000000000..9019345783
> --- /dev/null
> +++ b/drivers/misc/qfw_smbios.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * (C) Copyright 2023 Heinrich Schuchardt <heinrich.schuchardt@canonical=
.com>
> + */
> +
> +#define LOG_CATEGORY UCLASS_QFW
> +
> +#include <efi_loader.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <qfw.h>
> +#include <smbios.h>
> +#include <tables_csum.h>
> +#include <linux/sizes.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/**
> + * qfw_load_smbios_table() - load a QEMU firmware file
> + *
> + * @dev:       QEMU firmware device
> + * @size:      parameter to return the size of the loaded table
> + * @name:      name of the table to load
> + * Return:     address of the loaded table, NULL on error
> + */
> +static void *qfw_load_smbios_table(struct udevice *dev, uint32_t *size,
> +                                  char *name)
> +{
> +       struct fw_file *file;
> +       struct bios_linker_entry *table;
> +
> +       file =3D qfw_find_file(dev, name);
> +       if (!file) {
> +               log_debug("Can't find %s\n", name);
> +               return NULL;
> +       }
> +
> +       *size =3D be32_to_cpu(file->cfg.size);
> +
> +       table =3D malloc(*size);
> +       if (!table) {
> +               log_err("Out of memory\n");
> +               return NULL;
> +       }
> +
> +       qfw_read_entry(dev, be16_to_cpu(file->cfg.select), *size, table);
> +
> +       return table;
> +}
> +
> +/**
> + * qfw_parse_smbios_anchor() - parse QEMU's SMBIOS anchor
> + *
> + * @dev:       QEMU firmware device
> + * @entry:     SMBIOS 3 structure to be filled from QEMU's anchor
> + * Return:     0 for success, -ve on error
> + */
> +static int qfw_parse_smbios_anchor(struct udevice *dev,
> +                                  struct smbios3_entry *entry)
> +{
> +       void *table;
> +       uint32_t size;
> +       struct smbios_entry *entry2;
> +       struct smbios3_entry *entry3;
> +       const char smbios_sig[] =3D "_SM_";
> +       const char smbios3_sig[] =3D "_SM3_";
> +       int ret =3D 0;
> +
> +       table =3D qfw_load_smbios_table(dev, &size, "etc/smbios/smbios-an=
chor");
> +       if (!table)
> +               return -ENOMEM;
> +       if (!memcmp(table, smbios3_sig, sizeof(smbios3_sig) - 1)) {
> +               entry3 =3D table;
> +               if (entry3->length !=3D sizeof(struct smbios3_entry)) {
> +                       ret =3D -ENOENT;
> +                       goto out;
> +               }
> +               memcpy(entry, entry3, sizeof(struct smbios3_entry));
> +       } else if (!memcmp(table, smbios_sig, sizeof(smbios_sig) - 1)) {
> +               entry2 =3D table;
> +               if (entry2->length !=3D sizeof(struct smbios_entry)) {
> +                       ret =3D -ENOENT;
> +                       goto out;
> +               }
> +               memset(entry, 0, sizeof(struct smbios3_entry));
> +               memcpy(entry, smbios3_sig, sizeof(smbios3_sig));
> +               entry->length =3D sizeof(struct smbios3_entry);
> +               entry->major_ver =3D entry2->major_ver;
> +               entry->minor_ver =3D entry2->minor_ver;
> +               entry->max_struct_size =3D entry2->max_struct_size;
> +       } else {
> +               ret =3D -ENOENT;
> +               goto out;
> +       }
> +       ret =3D 0;
> +out:
> +       free(table);
> +
> +       return ret;
> +}
> +
> +/**
> + * qfw_write_smbios_tables() - copy SMBIOS tables from QEMU
> + *
> + * @addr:      target buffer
> + * @size:      size of target buffer
> + * Return:     0 for success, -ve on error
> + */
> +static int qfw_write_smbios_tables(u8 *addr, uint32_t size)
> +{
> +       int ret;
> +       struct udevice *dev;
> +       struct smbios3_entry *entry =3D (void *)addr;

map_sysmem() so you can use a sandbox test

> +       void *table;
> +       uint32_t table_size;
> +
> +       ret =3D qfw_get_dev(&dev);
> +       if (ret) {
> +               log_err("No QEMU firmware device\n");
> +               return ret;
> +       }
> +
> +       ret =3D qfw_read_firmware_list(dev);
> +       if (ret) {
> +               log_err("Can't read firmware file list\n");
> +               return ret;
> +       }
> +
> +       ret =3D qfw_parse_smbios_anchor(dev, entry);
> +       if (ret) {
> +               log_debug("Can't parse anchor\n");
> +               return ret;
> +       }
> +
> +       addr +=3D entry->length;
> +       entry->struct_table_address =3D (uintptr_t)addr;
> +       entry->checksum =3D 0;
> +       entry->checksum =3D table_compute_checksum(entry,
> +                                                sizeof(struct smbios3_en=
try));
> +
> +       table =3D qfw_load_smbios_table(dev, &table_size,
> +                                     "etc/smbios/smbios-tables");
> +       if (table_size + sizeof(struct smbios3_entry) > size) {
> +               free(table);
> +               return -ENOMEM;
> +       }
> +       memcpy(addr, table, table_size);
> +       free(table);
> +
> +       return 0;
> +}
> +
> +/**
> + * qfw_evt_write_smbios_tables() - event handler for copying QEMU SMBIOS=
 tables
> + *
> + * Return:     0 on success, -ve on error (only out of memory)
> + */
> +static int qfw_evt_write_smbios_tables(void)
> +{
> +       phys_addr_t addr;
> +       void *ptr;
> +       int ret;
> +       /*
> +        * TODO:
> +        * This size is currently hard coded in lib/efi_loader/efi_smbios=
.c.
> +        * We need a field in global data for the size.

Is that because it might be >4KB?

> +        */
> +       uint32_t size =3D SZ_4K;
> +
> +       /* Reserve 64K for SMBIOS tables, aligned to a 4K boundary */
> +       ptr =3D memalign(SZ_4K, size);
> +       if (!ptr) {
> +               log_err("Out of memory\n");
> +               return -ENOMEM;
> +       }
> +       addr =3D map_to_sysmem(ptr);
> +
> +       /* Generate SMBIOS tables */
> +       ret =3D qfw_write_smbios_tables(ptr, size);
> +       if (ret) {
> +               if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
> +                       log_info("Falling back to U-Boot generated SMBIOS=
 tables\n");
> +                       write_smbios_table(addr);

Should we do this? Perhaps better to produce an error? If not, please
add a comment as to why.

> +               }
> +       } else {
> +               log_debug("SMBIOS tables copied from QEMU\n");
> +       }
> +
> +       gd_set_smbios_start(addr);
> +
> +       return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qfw_evt_write_smbios_tables);
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index bbb8421ce1..c4837da969 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -51,7 +51,9 @@ static int install_smbios_table(void)
>         u64 addr;
>         efi_status_t ret;
>
> -       if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CONFI=
G_X86))
> +       if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) ||
> +           IS_ENABLED(CONFIG_X86) ||
> +           IS_ENABLED(CONFIG_QFW_SMBIOS))

Hmm it seems we need an new Kconfig for this condition?

>                 return 0;
>
>         addr =3D SZ_4G;
> --
> 2.43.0
>

Otherwise:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
