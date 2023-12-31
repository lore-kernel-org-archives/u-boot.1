Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF27C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 14:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5036986C68;
	Sun, 31 Dec 2023 15:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dfer06Or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFAD877DA; Sun, 31 Dec 2023 15:03:44 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3A987687
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 15:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55569b59f81so3770886a12.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704031418; x=1704636218; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4S7owcWhQYL4lRr+rSEa/IgnBJzJ0fiw4v8wc3Cnyc=;
 b=Dfer06OrstLg+MOcZxNF1mK9vDm7TEHc56Shucp1Z3HaFttIupIMPmfv1QptQelNAD
 uiLRUJ3MrCqt3kPDaJPALsHPbPWnN83CNhdqKZ/9WqxRoeYWPH2ihStj0dJ0ES/CLt3Z
 6w5WvYF7rEelq3sYApRBRzLZ7bPHfpYDI0Xh23eeYi6eqRiBSa/sTH9EzDNQg8bQWT+C
 tmF484uZ6svOh88UnHQ94Axilu1HteSs2H+ZmuvBQKT1QSZ6U1r6uBThYq7VHVkTDoFL
 BP3DeNRB8FfJoafD7n6hGKHg/hMmkyd/LjvuA4GnTy/DnWjahXooJytU1dGXOWQga4lo
 4xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704031418; x=1704636218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4S7owcWhQYL4lRr+rSEa/IgnBJzJ0fiw4v8wc3Cnyc=;
 b=eX1Zrmhsrf8L3PcBKCumeRjdwynNHLJ1Qe0lHcnf4W4IR/kM5dGSWgtQo0f5uEg8AZ
 ORhMH0eqmjEgnGimvDDEC4A6lPILZZKpzmhxuWoMWmOPmgy4kIQ+loLKJsNJaIf7ZyAQ
 wQ/bVn9oyJB/mqI5SbSoxlOzfJh/L7g+FtWT0jMNFtxxiJpPVTkJqRbaP09JfhlHHuNO
 4pWN6e58f6zpZGntHU1PWbiFziANgY+jrB+zTqMXWE1qN+QlH5ywF/86nZDx1/2rMyxC
 KbAwR2uJjSP7CzAoWB7zyyu26Q8cvTvoUHksk7R/NSOQw9UcNVnL2vhM63mUThPRFNk9
 V9rA==
X-Gm-Message-State: AOJu0Ywhb/hjk4OL4Dj7v632U6EHCa22SzD7By7UGfo3ACgEpu5R/47Z
 nBdfOZHs8t6Lde5bIdmbpyFZhcgGjnnuNBAXxTkoaHDK
X-Google-Smtp-Source: AGHT+IHbZ5THRZD8hdQ/J6Mg4IYf/gdZhTgUenIal4tEdPXwCRPeeqdMqRW1ZFs55a/W4rfd0UpFESk7bAaK4e8/0Qg=
X-Received: by 2002:a50:cd56:0:b0:54b:5a6:d083 with SMTP id
 d22-20020a50cd56000000b0054b05a6d083mr8584461edj.11.1704031417677; Sun, 31
 Dec 2023 06:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-4-xypron.glpk@gmx.de>
In-Reply-To: <20231223004429.247301-4-xypron.glpk@gmx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 31 Dec 2023 14:03:26 +0000
Message-ID: <CALeDE9MpOngV-_BGKSm+D+bguKSX+e1NcdgQfa4PCDFb3e6mRw@mail.gmail.com>
Subject: Re: [PATCH 3/5] cmd: provide command to display SMBIOS information
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Sat, Dec 23, 2023 at 12:53=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> U-Boot can either generated an SMBIOS table or copy it from a prior boot
> stage, e.g. QEMU.
>
> Provide a command to display the SMBIOS information.
>
> Currently only type 1 and 2 are translated to human readable text.
> Other types may be added later. Currently only a hexdump and the list of
> strings is provided for these.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  cmd/Kconfig  |   7 ++
>  cmd/Makefile |   1 +
>  cmd/smbios.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 cmd/smbios.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5a7678f0ac..580aeec8ee 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -206,6 +206,13 @@ config CMD_SBI
>         help
>           Display information about the SBI implementation.
>
> +config CMD_SMBIOS
> +       bool "smbios"
> +       depends on SMBIOS
> +       default y

Should this be default? Maybe default if SMBIOS or similar?

> +       help
> +         Display the SMBIOS information.
> +
>  endmenu
>
>  menu "Boot commands"
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 5ed0e4011d..8a5dfd8ca9 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -168,6 +168,7 @@ obj-$(CONFIG_CMD_SETEXPR) +=3D setexpr.o
>  obj-$(CONFIG_CMD_SETEXPR_FMT) +=3D printf.o
>  obj-$(CONFIG_CMD_SPI) +=3D spi.o
>  obj-$(CONFIG_CMD_STRINGS) +=3D strings.o
> +obj-$(CONFIG_CMD_SMBIOS) +=3D smbios.o
>  obj-$(CONFIG_CMD_SMC) +=3D smccc.o
>  obj-$(CONFIG_CMD_SYSBOOT) +=3D sysboot.o
>  obj-$(CONFIG_CMD_STACKPROTECTOR_TEST) +=3D stackprot_test.o
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> new file mode 100644
> index 0000000000..63f908e92c
> --- /dev/null
> +++ b/cmd/smbios.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The 'smbios' command displays information from the SMBIOS table.
> + *
> + * Copyright (c) 2023, Heinrich Schuchardt <xypron.glpk@gmx.de>
> + */
> +
> +#include <command.h>
> +#include <hexdump.h>
> +#include <mapmem.h>
> +#include <smbios.h>
> +#include <tables_csum.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/**
> + * smbios_get_string() - get SMBIOS string from table
> + *
> + * @table:     SMBIOS table
> + * @index:     index of the string
> + * Return:     address of string, may point to empty string
> + */
> +static const char *smbios_get_string(void *table, int index)
> +{
> +       const char *str =3D (char *)table +
> +                         ((struct smbios_header *)table)->length;
> +
> +       if (!*str)
> +               ++str;
> +       for (--index; *str && index; --index)
> +               str +=3D strlen(str) + 1;
> +
> +       return str;
> +}
> +
> +static struct smbios_header *next_table(struct smbios_header *table)
> +{
> +       const char *str;
> +
> +       if (table->type =3D=3D SMBIOS_END_OF_TABLE)
> +               return NULL;
> +
> +       str =3D smbios_get_string(table, 0);
> +       return (struct smbios_header *)(++str);
> +}
> +
> +static void smbios_print_generic(struct smbios_header *table)
> +{
> +       char *str =3D (char *)table + table->length;
> +
> +       if (CONFIG_IS_ENABLED(HEXDUMP)) {
> +               printf("Header and Data:\n");
> +               print_hex_dump("\t", DUMP_PREFIX_OFFSET, 16, 1,
> +                              table, table->length, false);
> +       }
> +       if (*str) {
> +               printf("Strings:\n");
> +               for (int index =3D 1; *str; ++index) {
> +                       printf("\tString %u: %s\n", index, str);
> +                       str +=3D strlen(str) + 1;
> +               }
> +       }
> +}
> +
> +void smbios_print_str(const char *label, void *table, u8 index)
> +{
> +       printf("\t%s: %s\n", label, smbios_get_string(table, index));
> +}
> +
> +static void smbios_print_type1(struct smbios_type1 *table)
> +{
> +       printf("System Information\n");
> +       smbios_print_str("Manufacturer", table, table->manufacturer);
> +       smbios_print_str("Product Name", table, table->product_name);
> +       smbios_print_str("Version", table, table->version);
> +       smbios_print_str("Serial Number", table, table->serial_number);
> +       if (table->length >=3D 0x19) {
> +               printf("\tUUID %pUl\n", table->uuid);
> +               smbios_print_str("Wake Up Type", table, table->serial_num=
ber);
> +       }
> +       if (table->length >=3D 0x1b) {
> +               smbios_print_str("Serial Number", table, table->serial_nu=
mber);
> +               smbios_print_str("SKU Number", table, table->sku_number);
> +       }
> +}
> +
> +static void smbios_print_type2(struct smbios_type2 *table)
> +{
> +       u16 *handle;
> +
> +       printf("Base Board Information\n");
> +       smbios_print_str("Manufacturer", table, table->manufacturer);
> +       smbios_print_str("Product Name", table, table->product_name);
> +       smbios_print_str("Version", table, table->version);
> +       smbios_print_str("Serial Number", table, table->serial_number);
> +       smbios_print_str("Asset Tag", table, table->asset_tag_number);
> +       printf("\tFeature Flags: 0x%2x\n", table->feature_flags);
> +       smbios_print_str("Chassis Location", table, table->chassis_locati=
on);
> +       printf("\tChassis Handle: 0x%2x\n", table->chassis_handle);
> +       smbios_print_str("Board Type", table, table->board_type);
> +       printf("\tContained Object Handles: ");
> +       handle =3D (void *)table->eos;
> +       for (int i =3D 0; i < table->number_contained_objects; ++i)
> +               printf("0x%04x ", handle[i]);
> +       printf("\n");
> +}
> +
> +static void smbios_print_type127(struct smbios_type127 *table)
> +{
> +       printf("End Of Table\n");
> +}
> +
> +static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
> +                    char *const argv[])
> +{
> +       ulong addr;
> +       void *entry;
> +       u32 size;
> +       char version[12];
> +       struct smbios_header *table;
> +       static const char smbios_sig[] =3D "_SM_";
> +       static const char smbios3_sig[] =3D "_SM3_";
> +       size_t count =3D 0;
> +       u32 max_struct_size;
> +
> +       addr =3D gd_smbios_start();
> +       if (!addr) {
> +               log_warning("SMBIOS not available\n");
> +               return CMD_RET_FAILURE;
> +       }
> +       entry =3D map_sysmem(addr, 0);
> +       if (!memcmp(entry, smbios3_sig, sizeof(smbios3_sig) - 1)) {
> +               struct smbios3_entry *entry3 =3D entry;
> +
> +               table =3D (void *)(uintptr_t)entry3->struct_table_address=
;
> +               snprintf(version, sizeof(version), "%d.%d.%d",
> +                        entry3->major_ver, entry3->minor_ver, entry3->do=
c_rev);
> +               table =3D (void *)(uintptr_t)entry3->struct_table_address=
;
> +               size =3D entry3->length;
> +               max_struct_size =3D entry3->max_struct_size;
> +       } else if (!memcmp(entry, smbios_sig, sizeof(smbios_sig) - 1)) {
> +               struct smbios_entry *entry2 =3D entry;
> +
> +               snprintf(version, sizeof(version), "%d.%d",
> +                        entry2->major_ver, entry2->minor_ver);
> +               table =3D (void *)(uintptr_t)entry2->struct_table_address=
;
> +               size =3D entry2->length;
> +               max_struct_size =3D entry2->max_struct_size;
> +       } else {
> +               log_err("Unknown SMBIOS anchor format\n");
> +               return CMD_RET_FAILURE;
> +       }
> +       if (table_compute_checksum(entry, size)) {
> +               log_err("Invalid anchor checksum\n");
> +               return CMD_RET_FAILURE;
> +       }
> +       printf("SMBIOS %s present.\n", version);
> +
> +       for (struct smbios_header *pos =3D table; pos; pos =3D next_table=
(pos))
> +               ++count;
> +       printf("%zd structures occupying %d bytes\n", count, max_struct_s=
ize);
> +       printf("Table at 0x%llx\n", (unsigned long long)map_to_sysmem(tab=
le));
> +
> +       for (struct smbios_header *pos =3D table; pos; pos =3D next_table=
(pos)) {
> +               printf("\nHandle 0x%04x, DMI type %d, %d bytes at 0x%llx\=
n",
> +                      pos->handle, pos->type, pos->length,
> +                      (unsigned long long)map_to_sysmem(pos));
> +               switch (pos->type) {
> +               case 1:
> +                       smbios_print_type1((struct smbios_type1 *)pos);
> +                       break;
> +               case 2:
> +                       smbios_print_type2((struct smbios_type2 *)pos);
> +                       break;
> +               case 127:
> +                       smbios_print_type127((struct smbios_type127 *)pos=
);
> +                       break;
> +               default:
> +                       smbios_print_generic(pos);
> +                       break;
> +               }
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_LONGHELP(smbios, "- display SMBIOS information");
> +
> +U_BOOT_CMD(smbios, 1, 0, do_smbios, "display SMBIOS information",
> +          smbios_help_text);
> --
> 2.43.0
>
