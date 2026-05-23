Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8ACCD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E9C8470E;
	Sat, 23 May 2026 11:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dMEF8wY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3D7847B0; Sat, 23 May 2026 11:43:59 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56CA84704
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so670675a12.3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779529436; cv=none;
 d=google.com; s=arc-20240605;
 b=kp+jWyvQxHfiRJTGYp+PYmbKVs06bKzvvA1TO/vBz6vCzQmL+jHUqkQMoeOcSICQdK
 0UIsBVm1Rmoqhq0h1jSXmRcavBCkH33ocEWYYgNeinBPnseKv2fBqGGI/OyFzPvGWBU4
 SqRMHqs7JHI0ZcxdF81uIWKGmTEZcPFoT+HIXmxOTic+lWInXT3qNWsaMU2SKPD0JrWi
 lsz7+8NqOrvnTUzbT5v1AEjzPd7oidwX10d+ehJaxiPG1a8N0JuDn0LGCs94mBXsLIQc
 Mc1HGiaHWF/tn5gquf04HKBEtCMFz0bMLjWDgYtkh7UG5OtZ2g31Se8K9K07lAhfv73R
 saVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MvqlT2XvaPEbpDytCRwBXMzHXzqDS6qcMgerTwhLF/I=;
 fh=ZpZEtjbI1ZOMBq+TgxRlCbgL+50toe5EUK8Fw5e+JyM=;
 b=Jj0gPJi014CAP8eQaFTF6gJor7AUGh0TZU8qcK2lggmcCcrt4ehnkN2VCB7m8RstMr
 5+V/+CeHKKbrHlrVkKc503KtLS2mCY/Lpu1Jz73BscJYjOGt9WnPOzlmKlW1GREZectJ
 QHjZzVUVHIdENzKZ+Mn86F7xG0rbWYP8Ijenzj5R1TCqqJGJkhSz8OiHOLqb3fX78ro8
 wxbv5xGRuaY8Jb2pgprtxkwjbRhkrp+vYiM7ZreU5lCD92wpE2TsbrnRFMZuxAj26ODO
 UEJ54/122U7Nx71Bb4rulp2n65aQ1tW4AvM31Ys30DHbhU91lrTQ/R7ryrKhF6XJwPiV
 QyKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779529436; x=1780134236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MvqlT2XvaPEbpDytCRwBXMzHXzqDS6qcMgerTwhLF/I=;
 b=dMEF8wY7eP2RVzUyFCKN5wbYVTmmgmEg0idx6W5e9hMR9+uKB+V5kHASuuC72J70iH
 vZwn+8seafMRy+l1+Kib0LhKnqloCITTWJulp7/3ZKk41F360IFKWtgr+1j8Pj9VESNn
 IK8McS3QxkvF5nq52FkhZgJXSfVw8vJ+EuXyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779529436; x=1780134236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvqlT2XvaPEbpDytCRwBXMzHXzqDS6qcMgerTwhLF/I=;
 b=sgLn0KE5q+HsI8UyC04bDKgp0fplxatoi45UEe52giFsOJL5/oipEoI+pyJR7hoz2Z
 4rZLd4hxfgn1smriBCxGVC9qbLhIDwvphosXhm1ejY3G/hKehcWhvWWC9ICS0RrXRSy5
 TPbh93YDmgXaaEcgdtek1RHiam38xSteghUFRnaNdBdZEOpxbJnkgdYUx3oEzl0/+6eQ
 KIHl5CyjgjJiVcdGbGRUEilD5/Mnk6KC5Ksui327l3OpRdjC+K5CG7PSrAE/K9RKfWqo
 gXNuNzvJe3zoGcgcS56jA4pB1AqGB6uwTVSs6PCOmQlbNyTQmMkblzHcJykgV9wCS/lG
 TNsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IIsLL0cBWt5YF9NZVOf1sDNAtJ+F6WmfqxqdvCYhoKPs/73PM5vN5GJvRBhd1Qw9cMNzGwho=@lists.denx.de
X-Gm-Message-State: AOJu0YyOUXq2dVnVw+RWkjuWc4kz6n2dJ81S/7iABBYu0NVBDOLAts9Z
 54F2eD/VCFW8ysmeSjrHAPHTXEfOnxChSyMEVLt3bjnWscvieb6rDZVRVijsuetA37nynX3xgL1
 bvSxSis4GEUkihaj1n6OvKDbK3ZLDcHY9AM/uwsxZ
X-Gm-Gg: Acq92OFWvcfqjZ+YLY3HKrsV21TOLzLWYBWgR5BPM+52UkWtvDquRkdqCv6pdMr72Eu
 5Qcix/Wv28yo8sX8sfGX6BVzijL83kNq6ULoB0ldRezUmlRsz+h3sKOm3d8cW0NovmxO8RZj/G5
 XZwSKCJ83l+fndJCEStkBAnvWXhvcYe1QHRNAsE9h565W6ShHJWACOC1COCUVIrwQ+RQjuMXPvQ
 7Z/EwFbZcJsoAV/ME29cm5DOIvCfYERUHMHS0lT1X3fVXQeeuGK9QDg+BnT3TtwQBYq9NsaLLHv
 BQvtbCqSMYN9ajSu
X-Received: by 2002:a17:907:8f18:b0:bde:77c3:ff22 with SMTP id
 a640c23a62f3a-bde77c40074mr113828766b.29.1779529436338; Sat, 23 May 2026
 02:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260521185025.30857-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:43:44 -0600
X-Gm-Features: AVHnY4LJSy8yJA2L_Bx2W_cxImDaWcqJATF3kfBjFyZZS_Z-PThvg5S38RLI2JM
Message-ID: <CAFLszTgzt+5uf1ers66E3e+zfPOP-iEyz-0rPSHWsjtz=oO+dw@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: add ACPI table dump EFI app
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
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

Hi Heinrich,

On 2026-05-21T18:50:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: add ACPI table dump EFI app
>
> Provide an EFI binary that can dump all ACPI tables to files
> <table_name>.dat. These can then be further analyzed by decompiling
> with iasl.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/efi_loader/Makefile   |   1 +
>  lib/efi_loader/acpidump.c | 999 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1000 insertions(+)

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,999 @@
> +#include <efi_api.h>
> +#include <part.h>
> +#include <string.h>
> +#include <acpi/acpi_table.h>

At 999 lines this is the third copy of the same EFI-app skeleton
(after smbiosdump.c and dtbdump.c). color(), print(), cls(), error(),
efi_input_yn(), efi_input(), skip_whitespace(), starts_with(),
open_file_system(), save_file(), command_loop(), get_load_options()
and the efi_main() boilerplate are all near-verbatim from
smbiosdump.c.

Please factor the shared pieces into a small header/object (e.g.
lib/efi_loader/efi_app_helper.c) so the new app only contains the
ACPI-specific code. Otherwise every future fix has to be made in three
places.

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,999 @@
> +     rsdp = get_acpi_rsdp_addr();
> +     print(u"RSDP address: ");
> +     printp(rsdp);
> +     print(u'\r\n');
> +     if (!rsdp) {
> +             error(u"No ACPI configuration table\r\n");
> +             return EFI_NOT_FOUND;
> +     }

When there is no ACPI table we still print 'RSDP address:
0x0000000000000000' before the error. Please move the NULL check ahead
of the printing.

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,999 @@
> +             if (!memcmp(table->signature, 'FACP', 4)) {
> +                     struct acpi_fadt *fadt = (struct acpi_fadt *)table;
> +                     uintptr_t dsdt_addr;
> +                     uintptr_t facs_addr;
> +
> +                     dsdt_addr = read_u64(&fadt->x_dsdt);
> +                     if (!dsdt_addr)
> +                             dsdt_addr = read_u32(&fadt->dsdt);

x_dsdt and x_firmware_ctrl live past offset 0x8c - an ACPI 1.0 FADT
has a length below that, so this reads beyond the table's declared
(and checksummed) extent. Do we care about old tables? If so, please
gate the 64-bit reads on len >= offsetofend(struct acpi_fadt, x_dsdt)
(and similarly for x_firmware_ctrl).

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,999 @@
> +                             dsdt = (struct acpi_table_header *)dsdt_addr;
> +                             dsdt_len = read_u32(&dsdt->length);
> +                             if (dsdt_len < sizeof(*dsdt)) {
> +                                     error(u"Invalid DSDT length\r\n");
> +                                     ret = EFI_LOAD_ERROR;
> +                                     goto err_out;
> +                             }
> +                             if (!checksum_ok(dsdt, dsdt_len)) {
> +                                     error(u"Invalid DSDT checksum\r\n");
> +                                     ret = EFI_LOAD_ERROR;
> +                                     goto err_out;
> +                             }

For FACS you verify the signature before trusting the length, but not
for DSDT - a corrupt FADT pointing at random memory could pass length
and checksum here. Please add a memcmp(dsdt->signature, 'DSDT', 4)
check.

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,999 @@
> +             memcpy(buf, (void *)tables[i].addr, tables[i].len);
> +             ret = save_file(filename, buf, tables[i].len);
> +             if (ret == EFI_SUCCESS) {
> +                     print(filename);
> +                     print(u" written\r\n");
> +             }
> +
> +             bs->free_pool(buf);
> +             if (ret != EFI_SUCCESS)
> +                     break;

If the user answers 'n' to the overwrite prompt for one table,
save_file() returns EFI_ACCESS_DENIED and the whole dump aborts,
silently skipping the rest. Is that intended?

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,999 @@
> + * starts_with() - check if @string starts with @keyword
> + *
> + * @string:  string to search for keyword
> + * @keyword: keyword to be searched
> + * Return:   true fi @string starts with the keyword
> + */

'fi' should be 'if'

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,999 @@
> +     ret = collect_tables(&tables, &table_count);
> +     if (ret != EFI_SUCCESS)
> +             return ret;
> +
> +     if (!table_count) {
> +             print(u"No ACPI tables found\r\n");
> +             return EFI_NOT_FOUND;
> +     }

collect_tables() always seeds the array with RSDP + root before
returning EFI_SUCCESS, so this branch is unreachable - and if it ever
did fire it would leak 'tables'. Either drop the check or free
'tables' on the way out.

Regards,
Simon
