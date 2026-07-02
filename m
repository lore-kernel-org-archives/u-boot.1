Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B279C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3AC84CB3;
	Thu,  2 Jul 2026 10:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FnBMit+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B9384CC0; Thu,  2 Jul 2026 10:49:00 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 938D984CA3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6647bc8f900so1675611d50.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782982135; cv=none;
 d=google.com; s=arc-20260327;
 b=obwHi269n8AU18nMTXiz8TKunPe+JyoSnZvMBFvpOlFFDD1jjBuls3V3QmJe/kIcQr
 BAq+dBZsHZNYj6MnBNeEGR3aiD+J7pHGuuk/HcYfIpdG5qK42UOKlvzYgiGsec8rT67w
 aaCY9JE220Wx2v6zwWvqF+rx6cUJ+yoQv9rQ25NZvccitgD9xVsi4zKUfAiH+K0TyYjn
 Mbvz7OgbNTY+D/rGflXORYDpTzRZ+d+SLyEyzvZuvDJodn57pKYAmVZH6Ycdjuin3Byd
 5vcuHwClCLOpGqof/zyj3XQfnZGvjHENUUVu7ZezgCqlpHIJVwHGG4jv6vU3/itPgMhU
 4awQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LkNb/efGYN6pGg+r3cxzYWUr7AKdEOd3jeByt2ycZCg=;
 fh=JWRTbG5mTqsSgCAGaVDbHisB2XHaqWYlgt3Ohdi48AM=;
 b=E6w5Spns4tBgLvpN2huzkRwPar9qA7eH86uZ9QnlwaG3s1vS1JDO2QAT9eBdrg8nCJ
 Ym4C4Ohsv5NfEqRFOU5Z1vPxgK/y/e5Yjl5xLsBk5FzTFAhoWg1N9cgVXlFrjh3q8JCq
 hWHSBJ3kQJfFU4YA9VhzruE/OUJpop+4j8hfJURAPPkA4l6ECoztkBPXY6nscP5aDPC1
 6utW2zWh6YgjnJVFiv+ATP/nprZigrJTJ0UgARicqCF+HuVSZmTtZYTb12WSB33L+gvA
 TLvu1Puu9OX4tjWreboY994S6ysCPyq/q2jZUxJByTXQIGxNitxVJBTNjEz3vWXlKpTi
 aKUA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782982135; x=1783586935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LkNb/efGYN6pGg+r3cxzYWUr7AKdEOd3jeByt2ycZCg=;
 b=FnBMit+xyMkwdLyPVJAdNhpLC5FeqWO1CnspGNvjMfBhr+YSwhMpGY1SasCY5jmTCj
 tz3jA3iWGmpOkgcJvN7zGtMtTdIVkHPSD41ZXh5r/PAIFrKFy4Z1E8IBdKlwR8pLPMxc
 tN+HJ1kA65h/PjH/UhV5LbLb9x/vG9carkxza4VfQ1BRNKYDKeTC1hF5RVe//257+848
 kb8HY3yK7FfeNR6DKgqbMnbzWzWMy4IG4jLQAR5GZ8/gNKxWadTT8LvJRisWjIBtAygP
 IoraKT6B9wz1knMMo9R4wqKnwtB48w5XOj9eDSntdubEsg4IFQThSKWRMNNrZZDDikWa
 NylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982135; x=1783586935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkNb/efGYN6pGg+r3cxzYWUr7AKdEOd3jeByt2ycZCg=;
 b=gq2oqmVHyiqRp5VwZ4PG0+nqYYD1VPoogMUlT5darTDHdYW663JNxu02pQqzRpYDU2
 G/DLOtlsoB9Vs3qTLDN33iqvixDhDApksCKD5xCeYu3OopxhEbYyCorrWj6LuNfVm0nG
 KONLHze95VlCdbcyBb5pAnQIdbYhEMc9/4kxZH0/yVZaYZeeFoNBEOl7hBut8Opizdtl
 4TGe7U77Zj+z4RvsPaFYxUpjj7f1wo0aQN4iSwR8zdhPRXrWi50EIlLgog3vDKJNEzQy
 yN7KtidUcZ6Pr67BMHkqzNDhcMF+5le3Who+OSO+58kBYEhuhAxnVFTobNVmujhCkhUU
 2IPg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9t2/ZzCyR+4ml0dD1Ww8+vdHghBJ8wUu7zPNPRrBoyUkKQPf778uOazXFAgkgy0xoTq6ZWEo=@lists.denx.de
X-Gm-Message-State: AOJu0YxPScs8EyIAxtoaU1Odvvz8Arnv9ecowSFh3zLHkVlpT2MVs5hK
 l2cAKDNM4QwTii515sKSZll8vYEevKCdQfg+4qUyASX7JalL5UdY0SDTZIviaF7nizuHgjGcmCl
 3pOyGks7HNyjRXdXULbtZLgFwk0cZfv+gauqKvUCIRqVSb/KjcmhRbew=
X-Gm-Gg: AfdE7cldm6sajIDejIeCg4A8v6nmTGj6VVJ+HzD1LSJtUcuG4Pa5Py5d17IzVR/ER5J
 eF6/pWIew0NoV/sdcqWJtOPdgIX9ZUhWLTBIE78lZoGmSkVLa/xsg40jgj2NxVr90/WmajnQl0F
 kyoW7Ik79I0s2qZuf/gWd90XtO1nF/UcVHCuIcV20DlhmM2z9w6/6mR2iWRBG+FKkTeI7NgM+Z1
 e8BVyWFiukfWapWE7oB1nz/Cmt73YQFBsa/tNaqET4fPagzaGZ7Fh8PF+0x0qKKB/kc+/sJK3N7
 YfsZiEBNWneq17OApMWXQm+sg61i+V6XA6N0dTh1djTrwtOTpMkoGkqdmhNZN25Ikv2Q9mNI45U
 HxbQyLBrOI+ODcIW7+Fa4NZRZ+t8SPuJqIpm01IwWY4KUJRyyAInyVI4Jim/9q7ueMr/Nksnuh9
 2wz+Dyemv6BVH4Hfz/NY19KKSlMP6NAZZMwq0fWh/N9bxDlN7Xz4D8LrqipyKF/EykLrl3gAwR0
 d2VVY0vf2Zqbzyaxjb85FIeac3aQiUiC/Rq0+U4jYLonCmimbSUtnGZNkgQqdbTwDmYNmAnEBVW
 N+cO62KFP9+MdQHHQg/5JK3Z0vi+AprWyMSdecxPOTXqarGIKMtL9ZOnmB1IGa/Mt4niFjU=
X-Received: by 2002:a05:690e:1183:b0:664:ca5e:1b6c with SMTP id
 956f58d0204a3-66521b86b3bmr5954781d50.41.1782982134945; Thu, 02 Jul 2026
 01:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-12-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-12-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 11:48:18 +0300
X-Gm-Features: AVVi8CffTTXYnaX_56EWAp40h3u5JKNSmMyUEhmXbRXxbnM8Tf3aFVeVvm5awcM
Message-ID: <CAC_iWjJkZ7zegZCbhgZB0VLCf6CF=mtP7PzYmx6rF3+tetoM5Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] efi_loader: add ACPI table dump EFI app
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Heinrich,

Didn't I have a tested-by and acked-by tag on this?

Cheers
/Ilias

On Sun, 28 Jun 2026 at 11:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide an EFI binary that can dump all ACPI tables to files
> <table_name>.dat. These can then be further analyzed by decompiling
> with iasl.
>
> The DSDT and FACS tables are identified via FADT.
>
> The following commands are provided:
>
> * check - parse ACPI table list\r\n", do_check
> * write - save one file per ACPI table\r\n", do_write
>
> The file names are constructed from:
>
> * 4 character ACPI table name
> * number if there are multiple ACPI tables of the same type
> * '.dat' extension
>
> This matches the output of the Linux `acpidump -b` command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         extend the commit message
>         reformat with clang-format
>         roll in u32_to_utf16_dec()
>         in add_tables() check against max_tables
> v2:
>         Check checksums.
>         Check both RSDT and XSDT if both exist.
> ---
>  lib/efi_loader/Makefile   |   3 +-
>  lib/efi_loader/acpidump.c | 566 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 568 insertions(+), 1 deletion(-)
>  create mode 100644 lib/efi_loader/acpidump.c
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 94ad6721a70..b9a3433a0c5 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -16,6 +16,7 @@ CFLAGS_efi_boottime.o += \
>  apps-$(CONFIG_RISCV) += boothart
>  apps-$(CONFIG_BOOTEFI_HELLO_COMPILE) += helloworld
>  apps-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbiosdump
> +apps-$(CONFIG_GENERATE_ACPI_TABLE) += acpidump
>  apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
>  ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>  apps-y += dtbdump
> @@ -103,7 +104,7 @@ $(foreach f,$(apps-y) $(efi-obj-y),\
>         $(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))
>
>  # Link efi_app_common.o into each dump app
> -$(obj)/dbginfodump_efi.so $(obj)/dtbdump_efi.so \
> +$(obj)/acpidump_efi.so $(obj)/dbginfodump_efi.so $(obj)/dtbdump_efi.so \
>  $(obj)/initrddump_efi.so $(obj)/smbiosdump_efi.so: $(obj)/efi_app_common.o
>
>  always-y += $(foreach f,$(apps-y),$(f).efi)
> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> new file mode 100644
> index 00000000000..374d43d7a10
> --- /dev/null
> +++ b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,566 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2026, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> + *
> + * acpidump.efi saves the ACPI table set as file.
> + *
> + * Specifying 'nocolor' as load option data suppresses colored output and
> + * clearing of the screen.
> + */
> +
> +#include <efi_api.h>
> +#include <part.h>
> +#include <string.h>
> +#include <acpi/acpi_table.h>
> +#include "efi_app_common.h"
> +
> +#define MAX_FILENAME_LENGTH 32
> +
> +u16 app_banner[] = u"ACPI Dump\r\n=========\r\n\r\n";
> +
> +struct acpi_dump_table {
> +       char signature[5];
> +       uintptr_t addr;
> +       u32 len;
> +};
> +
> +static const efi_guid_t acpi2_guid = EFI_ACPI_TABLE_GUID;
> +static const efi_guid_t acpi1_guid = EFI_GUID_EFI_ACPI1;
> +
> +/**
> + * checksum_ok() - check if byte-sum of buffer is zero
> + *
> + * @buf:       buffer to check
> + * @len:       buffer length
> + * Return:    true if checksum is valid
> + */
> +static bool checksum_ok(const void *buf, efi_uintn_t len)
> +{
> +       const u8 *pos = buf;
> +       u8 sum = 0;
> +
> +       for (; len; --len, ++pos)
> +               sum += *pos;
> +
> +       return !sum;
> +}
> +
> +/**
> + * read_u32() - read 32-bit value via memcpy
> + *
> + * @src:       source address
> + * Return: value
> + */
> +static u32 read_u32(const void *src)
> +{
> +       u32 val;
> +
> +       memcpy(&val, src, sizeof(val));
> +
> +       return val;
> +}
> +
> +/**
> + * read_u64() - read 64-bit value via memcpy
> + *
> + * @src:       source address
> + * Return: value
> + */
> +static u64 read_u64(const void *src)
> +{
> +       u64 val;
> +
> +       memcpy(&val, src, sizeof(val));
> +
> +       return val;
> +}
> +
> +/**
> + * is_filename_char() - check if a signature byte is filename-safe
> + *
> + * @ch:        character to check
> + * Return: true if filename-safe
> + */
> +static bool is_filename_char(char ch)
> +{
> +       return (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') ||
> +              (ch >= '0' && ch <= '9') || ch == '_';
> +}
> +
> +/**
> + * append_uint_dec() - append decimal representation of integer to UTF-16 string
> + *
> + * @str:       destination UTF-16 string
> + * @pos:       current write position
> + * @size:      destination size in UTF-16 code units
> + * @val:       value to append
> + * Return:     updated write position
> + */
> +static efi_uintn_t append_uint_dec(u16 *str, efi_uintn_t pos, efi_uintn_t size,
> +                                  u32 val)
> +{
> +       u16 tmp[11];
> +       efi_uintn_t n = 0;
> +       efi_uintn_t i;
> +
> +       if (!val)
> +               tmp[n++] = u'0';
> +       while (val && n < ARRAY_SIZE(tmp)) {
> +               tmp[n++] = u'0' + val % 10;
> +               val /= 10;
> +       }
> +
> +       for (i = 0; i < n && pos + 1 < size; ++i)
> +               str[pos++] = tmp[n - i - 1];
> +
> +       if (pos < size)
> +               str[pos] = 0;
> +
> +       return pos;
> +}
> +
> +/**
> + * build_table_filename() - construct table filename
> + *
> + * @sig:       4-byte ACPI signature string
> + * @instance:  duplicate instance number (0 for first)
> + * @name:      output filename buffer (UTF-16)
> + * @name_size: output filename buffer size in UTF-16 code units
> + */
> +static void build_table_filename(const char *sig, u32 instance, u16 *name,
> +                                efi_uintn_t name_size)
> +{
> +       efi_uintn_t pos = 0;
> +       int i;
> +
> +       if (!name_size)
> +               return;
> +
> +       for (i = 0; i < 4 && pos + 1 < name_size; ++i)
> +               name[pos++] = is_filename_char(sig[i]) ? (u16)sig[i] : u'_';
> +
> +       if (instance)
> +               pos = append_uint_dec(name, pos, name_size, instance);
> +
> +       if (pos + 4 < name_size) {
> +               name[pos++] = u'.';
> +               name[pos++] = u'd';
> +               name[pos++] = u'a';
> +               name[pos++] = u't';
> +       }
> +       name[pos] = 0;
> +}
> +
> +/**
> + * get_acpi_rsdp_addr() - find ACPI RSDP via EFI config table GUID
> + *
> + * Return:     pointer to RSDP or NULL
> + */
> +static struct acpi_rsdp *get_acpi_rsdp_addr(void)
> +{
> +       struct acpi_rsdp *rsdp;
> +
> +       rsdp = get_config_table(&acpi2_guid);
> +       if (rsdp)
> +               return rsdp;
> +
> +       rsdp = get_config_table(&acpi1_guid);
> +
> +       return rsdp;
> +}
> +
> +/**
> + * add_table() - append one ACPI table entry
> + *
> + * @tables:            table array
> + * @table_count:       current table count
> + * @max_tables:                size of the table array
> + * @addr:              table address
> + * @len:               table length
> + * @sig:               4-character ACPI signature
> + * Return:             status code
> + */
> +static efi_status_t add_table(struct acpi_dump_table *tables, u32 *table_count,
> +                             u32 max_tables, uintptr_t addr, u32 len,
> +                             const char *sig)
> +{
> +       struct acpi_dump_table *table = &tables[*table_count];
> +
> +       if (*table_count >= max_tables) {
> +               error(u"add_table: buffer too small\r\n");
> +
> +               return EFI_BUFFER_TOO_SMALL;
> +       }
> +
> +       memset(table, 0, sizeof(*table));
> +       memcpy(table->signature, sig, 4);
> +       table->addr = addr;
> +       table->len = len;
> +       ++*table_count;
> +
> +       return EFI_SUCCESS;
> +}
> +
> +/**
> + * has_table_addr() - check if a table address is already in the list
> + *
> + * @tables:    table array
> + * @table_count:       number of used entries
> + * @addr:      table address to search
> + * Return: true if found
> + */
> +static bool has_table_addr(struct acpi_dump_table *tables, u32 table_count,
> +                          uintptr_t addr)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < table_count; ++i) {
> +               if (tables[i].addr == addr)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +/**
> + * collect_tables() - parse ACPI table structure and collect ACPI tables
> + *
> + * @tablesp:   output table array
> + * @table_count:       output table count
> + * Return:     status code
> + */
> +static efi_status_t collect_tables(struct acpi_dump_table **tablesp,
> +                                  u32 *table_count)
> +{
> +       struct acpi_rsdp *rsdp;
> +       struct acpi_table_header *root;
> +       struct acpi_dump_table *tables;
> +       uintptr_t root_addr;
> +       u32 rsdp_len, root_len, max_tables;
> +       u32 i, entries, entry_size;
> +       bool use_xsdt;
> +       efi_status_t ret;
> +
> +       rsdp = get_acpi_rsdp_addr();
> +       if (!rsdp) {
> +               error(u"No ACPI configuration table\r\n");
> +               return EFI_NOT_FOUND;
> +       }
> +       print(u"RSDP address: 0x");
> +       printx((uintptr_t)rsdp, 2 * sizeof(void *));
> +       print(u"\r\n");
> +
> +       if (memcmp(rsdp->signature, RSDP_SIG, sizeof(rsdp->signature))) {
> +               error(u"Invalid RSDP signature\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       if (!checksum_ok(rsdp, 20)) {
> +               error(u"Invalid RSDP checksum\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +
> +       rsdp_len = rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0 ?
> +                          read_u32(&rsdp->length) :
> +                          20;
> +       if (rsdp_len < 20) {
> +               error(u"Invalid RSDP length\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       if (rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0) {
> +               if (rsdp_len < sizeof(struct acpi_rsdp)) {
> +                       error(u"Invalid ACPI 2.0 RSDP length\r\n");
> +                       return EFI_LOAD_ERROR;
> +               }
> +               if (!checksum_ok(rsdp, rsdp_len)) {
> +                       error(u"Invalid ACPI 2.0 RSDP checksum\r\n");
> +                       return EFI_LOAD_ERROR;
> +               }
> +       }
> +
> +       if (rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0 &&
> +           read_u64(&rsdp->xsdt_address)) {
> +               root_addr = read_u64(&rsdp->xsdt_address);
> +               use_xsdt = true;
> +       } else {
> +               root_addr = read_u32(&rsdp->rsdt_address);
> +               use_xsdt = false;
> +       }
> +
> +       if (!root_addr) {
> +               error(u"Invalid RSDT/XSDT address\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +
> +       root = (struct acpi_table_header *)root_addr;
> +       root_len = read_u32(&root->length);
> +       if (root_len < sizeof(*root)) {
> +               error(u"Invalid RSDT/XSDT length\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       if (use_xsdt && memcmp(root->signature, "XSDT", 4)) {
> +               error(u"Invalid XSDT signature\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       if (!use_xsdt && memcmp(root->signature, "RSDT", 4)) {
> +               error(u"Invalid RSDT signature\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       if (!checksum_ok(root, root_len)) {
> +               error(u"Invalid RSDT/XSDT checksum\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +
> +       entry_size = use_xsdt ? sizeof(u64) : sizeof(u32);
> +       if ((root_len - sizeof(*root)) % entry_size) {
> +               error(u"Invalid RSDT/XSDT entry list\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       entries = (root_len - sizeof(*root)) / entry_size;
> +       /* RSDP + root + each root entry + up to DSDT/FACS per entry */
> +       max_tables = 2 + 3 * entries;
> +
> +       ret = bs->allocate_pool(EFI_LOADER_DATA,
> +                               max_tables * sizeof(struct acpi_dump_table),
> +                               (void **)&tables);
> +       if (ret != EFI_SUCCESS) {
> +               error(u"Out of memory\r\n");
> +               return ret;
> +       }
> +       *table_count = 0;
> +
> +       ret = add_table(tables, table_count, max_tables, (uintptr_t)rsdp,
> +                       rsdp_len, "RSDP");
> +       if (ret != EFI_SUCCESS)
> +               goto err_out;
> +
> +       ret = add_table(tables, table_count, max_tables, root_addr, root_len,
> +                       root->signature);
> +       if (ret != EFI_SUCCESS)
> +               goto err_out;
> +
> +       for (i = 0; i < entries; ++i) {
> +               uintptr_t addr;
> +               struct acpi_table_header *table;
> +               u32 len;
> +
> +               if (use_xsdt) {
> +                       u64 *entry = (u64 *)((u8 *)root + sizeof(*root));
> +
> +                       addr = read_u64(&entry[i]);
> +               } else {
> +                       u32 *entry = (u32 *)((u8 *)root + sizeof(*root));
> +
> +                       addr = read_u32(&entry[i]);
> +               }
> +               if (!addr)
> +                       continue;
> +               if (has_table_addr(tables, *table_count, addr))
> +                       continue;
> +
> +               table = (struct acpi_table_header *)addr;
> +               len = read_u32(&table->length);
> +               if (len < sizeof(*table)) {
> +                       error(u"Invalid ACPI table length\r\n");
> +                       ret = EFI_LOAD_ERROR;
> +                       goto err_out;
> +               }
> +               if (!checksum_ok(table, len)) {
> +                       error(u"Invalid ACPI table checksum\r\n");
> +                       ret = EFI_LOAD_ERROR;
> +                       goto err_out;
> +               }
> +
> +               ret = add_table(tables, table_count, max_tables, addr, len,
> +                               table->signature);
> +               if (ret != EFI_SUCCESS)
> +                       goto err_out;
> +
> +               /*
> +                * FADT (signature FACP) references DSDT and FACS outside RSDT/XSDT.
> +                * Include them so output matches acpidump -b style completeness.
> +                */
> +               if (!memcmp(table->signature, "FACP", 4)) {
> +                       struct acpi_fadt *fadt = (struct acpi_fadt *)table;
> +                       uintptr_t dsdt_addr;
> +                       uintptr_t facs_addr;
> +
> +                       if (len >= offsetof(struct acpi_fadt, x_dsdt) +
> +                                          sizeof(fadt->x_dsdt))
> +                               dsdt_addr = read_u64(&fadt->x_dsdt);
> +                       else
> +                               dsdt_addr = 0;
> +                       if (!dsdt_addr)
> +                               dsdt_addr = read_u32(&fadt->dsdt);
> +                       if (dsdt_addr &&
> +                           !has_table_addr(tables, *table_count, dsdt_addr)) {
> +                               struct acpi_table_header *dsdt;
> +                               u32 dsdt_len;
> +
> +                               dsdt = (struct acpi_table_header *)dsdt_addr;
> +                               if (memcmp(dsdt->signature, "DSDT", 4)) {
> +                                       error(u"Invalid DSDT signature\r\n");
> +                                       ret = EFI_LOAD_ERROR;
> +                                       goto err_out;
> +                               }
> +                               dsdt_len = read_u32(&dsdt->length);
> +                               if (dsdt_len < sizeof(*dsdt)) {
> +                                       error(u"Invalid DSDT length\r\n");
> +                                       ret = EFI_LOAD_ERROR;
> +                                       goto err_out;
> +                               }
> +                               if (!checksum_ok(dsdt, dsdt_len)) {
> +                                       error(u"Invalid DSDT checksum\r\n");
> +                                       ret = EFI_LOAD_ERROR;
> +                                       goto err_out;
> +                               }
> +
> +                               ret = add_table(tables, table_count, max_tables,
> +                                               dsdt_addr, dsdt_len,
> +                                               dsdt->signature);
> +                               if (ret != EFI_SUCCESS)
> +                                       goto err_out;
> +                       }
> +
> +                       if (len >= offsetof(struct acpi_fadt, x_firmware_ctrl) +
> +                                          sizeof(fadt->x_firmware_ctrl))
> +                               facs_addr = read_u64(&fadt->x_firmware_ctrl);
> +                       else
> +                               facs_addr = 0;
> +                       if (!facs_addr)
> +                               facs_addr = read_u32(&fadt->firmware_ctrl);
> +                       if (facs_addr &&
> +                           !has_table_addr(tables, *table_count, facs_addr)) {
> +                               struct acpi_facs *facs;
> +                               u32 facs_len;
> +
> +                               facs = (struct acpi_facs *)facs_addr;
> +                               if (memcmp(facs->signature, "FACS", 4)) {
> +                                       error(u"Invalid FACS signature\r\n");
> +                                       ret = EFI_LOAD_ERROR;
> +                                       goto err_out;
> +                               }
> +                               facs_len = read_u32(&facs->length);
> +                               if (facs_len < sizeof(*facs)) {
> +                                       error(u"Invalid FACS length\r\n");
> +                                       ret = EFI_LOAD_ERROR;
> +                                       goto err_out;
> +                               }
> +                               ret = add_table(tables, table_count, max_tables,
> +                                               facs_addr, facs_len,
> +                                               facs->signature);
> +                               if (ret != EFI_SUCCESS)
> +                                       goto err_out;
> +                       }
> +               }
> +       }
> +
> +       *tablesp = tables;
> +
> +       return EFI_SUCCESS;
> +
> +err_out:
> +       bs->free_pool(tables);
> +       return ret;
> +}
> +
> +/**
> + * do_check() - parse ACPI tables and report success/failure
> + *
> + * @args:      unused command arguments
> + */
> +static void do_check(u16 *__maybe_unused args)
> +{
> +       struct acpi_dump_table *tables;
> +       u32 table_count;
> +       u16 num[11] = { 0 };
> +       efi_status_t ret;
> +
> +       ret = collect_tables(&tables, &table_count);
> +       if (ret != EFI_SUCCESS)
> +               return;
> +
> +       append_uint_dec(num, 0, ARRAY_SIZE(num), table_count);
> +
> +       print(u"ACPI tables found: ");
> +       print(num);
> +       print(u"\r\n");
> +
> +       bs->free_pool(tables);
> +       print(u"OK\r\n");
> +}
> +
> +/**
> + * do_write() - ask filename and save ACPI table set
> + *
> + * @args:      unused command arguments
> + */
> +static void do_write(u16 *__maybe_unused args)
> +{
> +       struct acpi_dump_table *tables;
> +       u16 filename[MAX_FILENAME_LENGTH];
> +       u32 table_count;
> +       u32 i;
> +       efi_status_t ret;
> +
> +       ret = collect_tables(&tables, &table_count);
> +       if (ret != EFI_SUCCESS)
> +               return;
> +       if (!table_count) {
> +               print(u"No ACPI tables found\r\n");
> +               bs->free_pool(tables);
> +               return;
> +       }
> +
> +       for (i = 0; i < table_count; ++i) {
> +               u8 *buf;
> +               u32 instance = 0;
> +               u32 same_type = 0;
> +               u32 j;
> +
> +               for (j = 0; j < table_count; ++j) {
> +                       if (!memcmp(tables[i].signature, tables[j].signature,
> +                                   4))
> +                               ++same_type;
> +               }
> +
> +               if (same_type > 1) {
> +                       /* Number duplicates starting at 1 for the first instance. */
> +                       for (j = 0; j <= i; ++j) {
> +                               if (!memcmp(tables[i].signature,
> +                                           tables[j].signature, 4))
> +                                       ++instance;
> +                       }
> +               }
> +
> +               build_table_filename(tables[i].signature, instance, filename,
> +                                    ARRAY_SIZE(filename));
> +
> +               ret = bs->allocate_pool(EFI_LOADER_DATA, tables[i].len,
> +                                       (void **)&buf);
> +               if (ret != EFI_SUCCESS) {
> +                       error(u"Out of memory\r\n");
> +                       break;
> +               }
> +
> +               memcpy(buf, (void *)tables[i].addr, tables[i].len);
> +               ret = save_file(filename, buf, tables[i].len);
> +               if (ret == EFI_SUCCESS) {
> +                       print(filename);
> +                       print(u" written\r\n");
> +               }
> +
> +               bs->free_pool(buf);
> +               if (ret == EFI_ACCESS_DENIED)
> +                       continue;
> +               if (ret != EFI_SUCCESS)
> +                       break;
> +       }
> +
> +       bs->free_pool(tables);
> +}
> +
> +struct efi_app_cmd app_cmds[] = {
> +       { u"check", u"check - parse ACPI table list\r\n", do_check },
> +       { u"write", u"write - save one file per ACPI table\r\n", do_write },
> +       {}
> +};
> --
> 2.53.0
>
