Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB32C4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 20:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EA7877FD;
	Tue,  9 Jan 2024 21:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OySe06+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6532A87855; Tue,  9 Jan 2024 21:48:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECD980245
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 21:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704833305; x=1705438105; i=xypron.glpk@gmx.de;
 bh=p0OaoPX1gOUjyuJJPrlTrL8au+DEDBEVyJZAVb+vRmQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=OySe06+Dtlk7o4n0Dyi5X7jXLPUErKN4RzYC6RLe0qp4tqOFS8eVekzMO/VknKSB
 gTkUMPY7QlFy/H/vuKRMJWy8B8NwA4kqNUSz0BZFzVRxCj0yP+YJNPRkPOngIjjck
 O7BHo+EvR74qBhXexwCRpUjP4weyxQ5rWA5MpUHhmfDIePQL1XyTzVuYVlsc+2QwG
 8RfudTKI7UqiYJ6aD1IzCYyruYaKMFWWlc62tdkyFO0emzxu+kssa3gBjJl4CcqPj
 2Jnj9/SX77LDCWif0NXRK8tBtjdeQwIE+9UtvvkJzwtgLzuW9JcTuuAH8MJbwxkzd
 Hu5wEhyEwfLv6nV0Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1qpqsr4BRZ-00p4Lv; Tue, 09
 Jan 2024 21:48:25 +0100
Message-ID: <41008bde-d8a2-4119-a23c-75ad411f8675@gmx.de>
Date: Tue, 9 Jan 2024 21:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] smbios: copy QEMU tables
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20231223010334.248291-1-xypron.glpk@gmx.de>
 <20231223010334.248291-3-xypron.glpk@gmx.de>
 <CAFLszTjLj2s+RKwikofXtAebW42o7J4M2yajjaeWX0OBp_e+rg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjLj2s+RKwikofXtAebW42o7J4M2yajjaeWX0OBp_e+rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DAv1GvGmi0EHYoi1rGhvtIw3yby2/8hIWh9xr/el/oYlfXetgBG
 DcaDzavyvAGtfkcuOag3HH02PBu20y2EETNIv07vtJF+2LQf1aJ67TkoSN+/m/sWMwCKooT
 z+EBdMP74pzgrj+/YTsuugwByUftIoLfcswELseeSLfd4ds6aab2TyUroeK3pxmtWI54OYS
 ytFVP8PBBsG+/LvlRbKqw==
UI-OutboundReport: notjunk:1;M01:P0:JYQYSUc+l0M=;8MZw5OXvWY5szWIII9dw6JFkKAC
 g1Tc5vniDXWaO8IMqJrNrRbKeckAlmz8BXiTzMnAobGgUbrMVCEA35yxDFlBaAWcNYIJRQ8pg
 FFOSMoHLrfuS+NckpmcpO3yB2wDJmwzzXw/JmDTTIZQnO/OgFKM/yj29j1pX4uwpPFPgB3Irc
 kDXJPDiMxwdcZWoNRXr0mD9DW6CCUUTioyh7zJ5aLBWctbQSabbMT83r7fST8nh7Y0/6h/sCw
 VeBbdnjU8le98jtwj+vhk7b0pbpLQXMt5vbhu448fdaKhMoV6gaLt3OZmxoB8fZ+IgTTzW92i
 B7v1t3zG4HdMfQPvoaDUwBM1T+5dX4gpa4zISAgzs0R8PO8VB/X36BJdlXM2u9bC0Ng2SZIOa
 kPMXw+E8Q4mVDeAHPBWWT7OfwbrueBLv7s0sZtRDvAcIvX9zgCD/eAsc6YveCN1TTEQW/VLbV
 wq1xUbaz5LnGFBVt7j0MWYZf0Xp9OSICM6Emuam+aPp0/5y+J+QLa09dYxy3MVABBEHolGMzU
 8fvcPXhDhgzf9wR9NJ30hb/iQPKz+XnsSXJ/AYkEEJOpCNM5+Dc7JM0eH9FF7cOU+ZVgvWDOD
 Iybpjl5ujHcWc8t5sNLCAuyriVznlpHi1ct1YKd9bdFBLoe6BxfBoF2cg2wbaTckHshOudE0M
 ClKSy3l60WKg+TE0YW9IWoJTdU8YhmzXfzYcnQWakEFJp8JznQUFLvnJJ3fWe95lcTuk1c2k5
 gw/66LnRKMLVxWrcQWWK7qQmtOMhR0Sks4LVdR261AxReX/VrwrXd89N7O+vuLsebroc+YGoq
 VD5NKSEFjaISj2p79evBlLMUfNH9W1+KIH2AUCXSXMFiZuDb2JHKypYU39kLTf+UsOX6oDQD3
 TGLdeJKzrXkKhohtZ6r4lAiLJKygUPoN3t+khO6Q81ntg1SmLA1p6NEbK4TzgejBfcePjoL3q
 X1xlo0PYP/tqp9IxfvsUR8gTq6c=
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

On 12/26/23 10:47, Simon Glass wrote:
> Hi Heinrich,
>
> On Sat, Dec 23, 2023 at 1:03=E2=80=AFAM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> QEMU provides SMBIOS tables with detailed information. We should not tr=
y to
>> replicate them in U-Boot.
>>
>> If we want to inform about U-Boot, we can add a Firmware Inventory
>> Information (type 45) table in future.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          fix parsing of SMBIOS anchor
>>          enable copying on x86 and 32bit ARM/RISC-V
>> ---
>>   arch/x86/lib/tables.c       |   2 +-
>>   drivers/misc/Kconfig        |   7 ++
>>   drivers/misc/Makefile       |   1 +
>>   drivers/misc/qfw_smbios.c   | 197 +++++++++++++++++++++++++++++++++++=
+
>>   lib/efi_loader/efi_smbios.c |   4 +-
>>   5 files changed, 209 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/misc/qfw_smbios.c
>>
>> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
>> index 5b5070f7ca..914d9de0cb 100644
>> --- a/arch/x86/lib/tables.c
>> +++ b/arch/x86/lib/tables.c
>> @@ -61,7 +61,7 @@ static struct table_info table_list[] =3D {
>>   #ifdef CONFIG_GENERATE_ACPI_TABLE
>>          { "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0=
x1000},
>>   #endif
>> -#ifdef CONFIG_GENERATE_SMBIOS_TABLE
>> +#if defined(CONFIG_GENERATE_SMBIOS_TABLE) && !defined(CONFIG_QFW_SMBIO=
S)
>>          { "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x100=
0, 0x100},
>>   #endif
>>   };
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index e8e4400516..d2536c54e0 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -561,6 +561,13 @@ config QFW_MMIO
>>            Hidden option to enable MMIO QEMU fw_cfg interface. This wil=
l be
>>            selected by the appropriate QEMU board.
>>
>> +config QFW_SMBIOS
>> +       bool
>> +       default y
>> +       depends on QFW && SMBIOS && !SANDBOX
>> +       help
>> +         Hidden option to read SMBIOS tables from QEMU.
>> +
>>   config I2C_EEPROM
>>          bool "Enable driver for generic I2C-attached EEPROMs"
>>          depends on MISC
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index cda701d38e..64bea92f51 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -66,6 +66,7 @@ obj-y +=3D qfw.o
>>   obj-$(CONFIG_QFW_ACPI) +=3D qfw_acpi.o
>>   obj-$(CONFIG_QFW_PIO) +=3D qfw_pio.o
>>   obj-$(CONFIG_QFW_MMIO) +=3D qfw_mmio.o
>> +obj-$(CONFIG_QFW_SMBIOS) +=3D qfw_smbios.o
>>   obj-$(CONFIG_SANDBOX) +=3D qfw_sandbox.o
>>   endif
>>   obj-$(CONFIG_ROCKCHIP_EFUSE) +=3D rockchip-efuse.o
>> diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
>> new file mode 100644
>> index 0000000000..9019345783
>> --- /dev/null
>> +++ b/drivers/misc/qfw_smbios.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * (C) Copyright 2023 Heinrich Schuchardt <heinrich.schuchardt@canonic=
al.com>
>> + */
>> +
>> +#define LOG_CATEGORY UCLASS_QFW
>> +
>> +#include <efi_loader.h>
>> +#include <errno.h>
>> +#include <log.h>
>> +#include <malloc.h>
>> +#include <mapmem.h>
>> +#include <qfw.h>
>> +#include <smbios.h>
>> +#include <tables_csum.h>
>> +#include <linux/sizes.h>
>> +#include <asm/global_data.h>
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +/**
>> + * qfw_load_smbios_table() - load a QEMU firmware file
>> + *
>> + * @dev:       QEMU firmware device
>> + * @size:      parameter to return the size of the loaded table
>> + * @name:      name of the table to load
>> + * Return:     address of the loaded table, NULL on error
>> + */
>> +static void *qfw_load_smbios_table(struct udevice *dev, uint32_t *size=
,
>> +                                  char *name)
>> +{
>> +       struct fw_file *file;
>> +       struct bios_linker_entry *table;
>> +
>> +       file =3D qfw_find_file(dev, name);
>> +       if (!file) {
>> +               log_debug("Can't find %s\n", name);
>> +               return NULL;
>> +       }
>> +
>> +       *size =3D be32_to_cpu(file->cfg.size);
>> +
>> +       table =3D malloc(*size);
>> +       if (!table) {
>> +               log_err("Out of memory\n");
>> +               return NULL;
>> +       }
>> +
>> +       qfw_read_entry(dev, be16_to_cpu(file->cfg.select), *size, table=
);
>> +
>> +       return table;
>> +}
>> +
>> +/**
>> + * qfw_parse_smbios_anchor() - parse QEMU's SMBIOS anchor
>> + *
>> + * @dev:       QEMU firmware device
>> + * @entry:     SMBIOS 3 structure to be filled from QEMU's anchor
>> + * Return:     0 for success, -ve on error
>> + */
>> +static int qfw_parse_smbios_anchor(struct udevice *dev,
>> +                                  struct smbios3_entry *entry)
>> +{
>> +       void *table;
>> +       uint32_t size;
>> +       struct smbios_entry *entry2;
>> +       struct smbios3_entry *entry3;
>> +       const char smbios_sig[] =3D "_SM_";
>> +       const char smbios3_sig[] =3D "_SM3_";
>> +       int ret =3D 0;
>> +
>> +       table =3D qfw_load_smbios_table(dev, &size, "etc/smbios/smbios-=
anchor");
>> +       if (!table)
>> +               return -ENOMEM;
>> +       if (!memcmp(table, smbios3_sig, sizeof(smbios3_sig) - 1)) {
>> +               entry3 =3D table;
>> +               if (entry3->length !=3D sizeof(struct smbios3_entry)) {
>> +                       ret =3D -ENOENT;
>> +                       goto out;
>> +               }
>> +               memcpy(entry, entry3, sizeof(struct smbios3_entry));
>> +       } else if (!memcmp(table, smbios_sig, sizeof(smbios_sig) - 1)) =
{
>> +               entry2 =3D table;
>> +               if (entry2->length !=3D sizeof(struct smbios_entry)) {
>> +                       ret =3D -ENOENT;
>> +                       goto out;
>> +               }
>> +               memset(entry, 0, sizeof(struct smbios3_entry));
>> +               memcpy(entry, smbios3_sig, sizeof(smbios3_sig));
>> +               entry->length =3D sizeof(struct smbios3_entry);
>> +               entry->major_ver =3D entry2->major_ver;
>> +               entry->minor_ver =3D entry2->minor_ver;
>> +               entry->max_struct_size =3D entry2->max_struct_size;
>> +       } else {
>> +               ret =3D -ENOENT;
>> +               goto out;
>> +       }
>> +       ret =3D 0;
>> +out:
>> +       free(table);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * qfw_write_smbios_tables() - copy SMBIOS tables from QEMU
>> + *
>> + * @addr:      target buffer
>> + * @size:      size of target buffer
>> + * Return:     0 for success, -ve on error
>> + */
>> +static int qfw_write_smbios_tables(u8 *addr, uint32_t size)
>> +{
>> +       int ret;
>> +       struct udevice *dev;
>> +       struct smbios3_entry *entry =3D (void *)addr;
>
> map_sysmem() so you can use a sandbox test

This is a static function which never can be called directly by a test.
The caller already has a map_sysmem(). See below.

>
>> +       void *table;
>> +       uint32_t table_size;
>> +
>> +       ret =3D qfw_get_dev(&dev);
>> +       if (ret) {
>> +               log_err("No QEMU firmware device\n");
>> +               return ret;
>> +       }
>> +
>> +       ret =3D qfw_read_firmware_list(dev);
>> +       if (ret) {
>> +               log_err("Can't read firmware file list\n");
>> +               return ret;
>> +       }
>> +
>> +       ret =3D qfw_parse_smbios_anchor(dev, entry);
>> +       if (ret) {
>> +               log_debug("Can't parse anchor\n");
>> +               return ret;
>> +       }
>> +
>> +       addr +=3D entry->length;
>> +       entry->struct_table_address =3D (uintptr_t)addr;
>> +       entry->checksum =3D 0;
>> +       entry->checksum =3D table_compute_checksum(entry,
>> +                                                sizeof(struct smbios3_=
entry));
>> +
>> +       table =3D qfw_load_smbios_table(dev, &table_size,
>> +                                     "etc/smbios/smbios-tables");
>> +       if (table_size + sizeof(struct smbios3_entry) > size) {
>> +               free(table);
>> +               return -ENOMEM;
>> +       }
>> +       memcpy(addr, table, table_size);
>> +       free(table);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * qfw_evt_write_smbios_tables() - event handler for copying QEMU SMBI=
OS tables
>> + *
>> + * Return:     0 on success, -ve on error (only out of memory)
>> + */
>> +static int qfw_evt_write_smbios_tables(void)
>> +{
>> +       phys_addr_t addr;
>> +       void *ptr;
>> +       int ret;
>> +       /*
>> +        * TODO:
>> +        * This size is currently hard coded in lib/efi_loader/efi_smbi=
os.c.
>> +        * We need a field in global data for the size.
>
> Is that because it might be >4KB?
>
>> +        */
>> +       uint32_t size =3D SZ_4K;
>> +
>> +       /* Reserve 64K for SMBIOS tables, aligned to a 4K boundary */
>> +       ptr =3D memalign(SZ_4K, size);
>> +       if (!ptr) {
>> +               log_err("Out of memory\n");
>> +               return -ENOMEM;
>> +       }
>> +       addr =3D map_to_sysmem(ptr);
>> +
>> +       /* Generate SMBIOS tables */
>> +       ret =3D qfw_write_smbios_tables(ptr, size);
>> +       if (ret) {
>> +               if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
>> +                       log_info("Falling back to U-Boot generated SMBI=
OS tables\n");
>> +                       write_smbios_table(addr);
>
> Should we do this? Perhaps better to produce an error? If not, please
> add a comment as to why.

Error messages are written.

If QEMU provides SMBIOS tables depends on the QEMU version. E.g for
RISC-V patches enabling SMBIOS table generation are still pending.

Stopping the boot process because SMBIOS tables are not supplied by QEMU
is not very helpful for users stuck on an old QEMU version. We should
always do our best to complete the boot process.

>
>> +               }
>> +       } else {
>> +               log_debug("SMBIOS tables copied from QEMU\n");
>> +       }
>> +
>> +       gd_set_smbios_start(addr);
>> +
>> +       return 0;
>> +}
>> +
>> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qfw_evt_write_smbios_tables);
>> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
>> index bbb8421ce1..c4837da969 100644
>> --- a/lib/efi_loader/efi_smbios.c
>> +++ b/lib/efi_loader/efi_smbios.c
>> @@ -51,7 +51,9 @@ static int install_smbios_table(void)
>>          u64 addr;
>>          efi_status_t ret;
>>
>> -       if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CON=
FIG_X86))
>> +       if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) ||
>> +           IS_ENABLED(CONFIG_X86) ||
>> +           IS_ENABLED(CONFIG_QFW_SMBIOS))
>
> Hmm it seems we need an new Kconfig for this condition?

I think we have too many symbols with unclear meaning.

Should we really use CONFIG_GENERATE_SMBIOS_TABLE=3Dy in conjunction with
CONFIG_QFW_SMBIOS=3Dy? Or should we have a Kconfig choice where we have
mutually exclusive sources for SMBIOS:

CONFIG SMBIOS_NONE - no SMBIOS table
CONFIG_QFW_SMBIOS - copy SMBIOS table from QEMU
CONFIG_SMBIOS_FROM DT - generate SMBIOS table from device-tree
CONFIG_SMBIOS_COREBOOT - copy SMBIOS table from coreboot
CONFIG SMBIOS_X86 - x86 specific code

There is nothing EFI specific in this function. Shouldn't we move it to
a different module?

For ACPI we have a folder lib/acpi/ Should we have a folder lib/smbios/?

Best regards

Heinrich

>
>>                  return 0;
>>
>>          addr =3D SZ_4G;
>> --
>> 2.43.0
>>
>
> Otherwise:
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon

