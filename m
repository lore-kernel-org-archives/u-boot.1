Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD2CF58C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3C680077;
	Wed, 19 Nov 2025 18:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L5ZYpMRS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4528006D; Wed, 19 Nov 2025 18:35:07 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F4B80077
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1592166b.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763573703; x=1764178503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M5GLEp/RXFlmxEIXk49udbq1gZS16m4ZaQIQ59220MI=;
 b=L5ZYpMRSQZenkW1bwRqrNbOPu4gNxTaUyDV2jUbTYX2r4mRU/Fi3sA7etGBaUkcTaP
 8nS+ZqTWwgWV+n2Um2OmQzscu3nv79Paeu4tD2waV6hhWeWMOFixqV5NjP3LcQwUWaIV
 nEgGb0wAr1Z1E/pYU+Ak3TGJZpaC3om1dtQ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573703; x=1764178503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5GLEp/RXFlmxEIXk49udbq1gZS16m4ZaQIQ59220MI=;
 b=WuZVeGLSU82FZbKJ3LaTx7ROeN2VlXtTACuENcdD0gochKhESXRmXflKfVVSB6t7U4
 5fbr625Bpwz+ILjimy0lQvpX4mv0XRh61t/Igr2g5akVKqZt2AW+SWiuT0PkxgZPOtBP
 tEuDphlIM9b+JBBhgn2Ezj2XjmSNbj5WJE3lXjZwzbFPQlAJXLx0uBABdXeMnbfIW58P
 Bl6SL7jqVy5aVwpzSgQJGrSjqKUT5Spi3k2rvIQJ5KNe744KOPWfYBdEMh0FWYeC+GtN
 ZRUllOP6Cr45HpS61E38Qi1wDsaZxbpmxLIXI+HzvQJsolfsV5EmxZ2EJCatoo7arm4D
 EXVg==
X-Gm-Message-State: AOJu0Yw5IjdlO67jy4gCSyIUUVS625PQeypjwcfDGRs5qbFS8U08CvU7
 DaJM1yTrQry6Z9lKINqQu1iExupeJW555baK0MMRg36MTTd9pDKK2BtzfqS5FzWAkwB/pFPAcA0
 oSkw5uaZAuSp9Ygjdxa/pQdns/d1Yn/NlQGXCuxSd
X-Gm-Gg: ASbGnct7rAgqcI9M+UIytvy55JfDWgO/Sed4zRJhbeIRvyGvYVa3xha13DAx+pn/1It
 UfWNgIEStBndt9soMyV76pCyWk2MR6QVv6Ns/RNBffDb48YtJmuDIC49D9F0hXoa/e4WNZL8jlG
 U1bFJVANOJYkxLVWmAv1LtRtR/9Mui9Yz/NvcmtExHJOw5X9zcIEKs8YD7JGfUfG5svWZANGiWD
 ekeufeBYw1AeeaU5nX6LcsZ+kC4ACUc0arJ7OL7mD9JHELDU/LGvrg2UJnKSTuePWczmnZCw0Zf
 9GMtwSmT/tut4TA=
X-Google-Smtp-Source: AGHT+IH4wkXWRmRm2evC6GH0DFHh48Wqu/QLrparsN8UhsWEKCv+1MzismmAxRxu1vzq0yneZSlBgbknUgFU7ynQRIA=
X-Received: by 2002:a17:907:6d0b:b0:b73:58b4:1247 with SMTP id
 a640c23a62f3a-b7367926438mr2187878766b.25.1763573703300; Wed, 19 Nov 2025
 09:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20251119130609.540014-1-adriana@arista.com>
In-Reply-To: <20251119130609.540014-1-adriana@arista.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 10:34:50 -0700
X-Gm-Features: AWmQ_bkb9MbUkx_mRmwTUHSTzW7zTT4FgRmLonVqVu_rigJ81xYmqI34A7xV7y8
Message-ID: <CAFLszTisAErn1_2uD3AjodhXa=gveHAeitn2huR31VUpyiLutg@mail.gmail.com>
Subject: Re: [PATCH v3] boot/bootfdt: Add smbios3-entrypoint to FDT for
 non-EFI boots
To: Adriana Nicolae <adriana@arista.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ddrokosov@salutedevices.com, 
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de, 
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.or, 
 joao.goncalves@toradex.com
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

Hi Adriana,

On Wed, 19 Nov 2025 at 06:06, Adriana Nicolae <adriana@arista.com> wrote:
>
> From: adriana <adriana@arista.com>
>
> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> device tree.
>
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
>
> This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
> address into the device tree if there is a table generated by U-boot.
> The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
> for specific boards to select custom SMBIOS addresses.
>
> The changes in this patch are added in the context of supporting this
> device tree property in linux kernel:
> https://lkml.org/lkml/2025/10/24/1393
>
> Device tree schema was updated to include the "smbios3-entrypoint" node
> in pull request: https://github.com/devicetree-org/dt-schema/pull/177
>
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---
> Changes in v3:
>   - Moved "board_fdt_chosen_smbios" function to lib/smbios.c
>   - Return physical address of smbios entry and use map_sysmem to
>     access the entry point;
>   - Removed check for config enabled and added check for
>     GENERATE_SMBIOS_TABLE;
>   - Add test to check that smbios entry address is added into fdt;
>
> Changes in v2:
>   - Renamed device tree property to "smbios3-entrypoint".
>   - Removed redundant check for CONFIG_SMBIOS.
> ---
>  boot/fdt_support.c | 19 +++++++++++++++++
>  include/smbios.h   | 10 +++++++++
>  lib/smbios.c       | 38 +++++++++++++++++++++++++++++++++
>  test/dm/fdtdec.c   | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 119 insertions(+)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 92f2f534ee0..7da6e7cb2b3 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -27,6 +27,7 @@
>  #include <fdtdec.h>
>  #include <version.h>
>  #include <video.h>
> +#include <smbios.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -333,6 +334,7 @@ int fdt_chosen(void *fdt)
>         int   nodeoffset;
>         int   err;
>         const char *str;                /* used to set string properties */
> +       ulong smbiosaddr;               /* SMBIOS table address */
>
>         err = fdt_check_header(fdt);
>         if (err < 0) {
> @@ -387,6 +389,23 @@ int fdt_chosen(void *fdt)
>                 return err;
>         }
>
> +       if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
> +               /* Inject SMBIOS address when we have a valid address.
> +               * This is useful for systems using booti/bootm instead of bootefi.
> +               * Failure to set this property is non-fatal, we only generate a
> +               * warning.
> +               */
> +               smbiosaddr = board_fdt_chosen_smbios();

Please don't add weak functions. We can use gd_smbios_start() here.

> +               if (smbiosaddr) {
> +                       err = fdt_setprop_u64(fdt, nodeoffset, "smbios3-entrypoint",
> +                                       smbiosaddr);
> +                       if (err < 0) {
> +                               printf("WARNING: could not set smbios3-entrypoint %s.\n",
> +                               fdt_strerror(err));
> +                       }
> +               }
> +       }
> +
>         return fdt_fixup_stdout(fdt, nodeoffset);
>  }
>
> diff --git a/include/smbios.h b/include/smbios.h
> index b5fed57aba2..c37d79aa530 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -383,4 +383,14 @@ int smbios_update_version_full(void *smbios_tab, const char *version);
>  void smbios_prepare_measurement(const struct smbios3_entry *entry,
>                                 struct smbios_header *header);
>
> +/**
> + * board_fdt_chosen_smbios() - Provide SMBIOS address for /chosen node
> + *
> + * This function is called by fdt_chosen() to get the SMBIOS table address
> + * that should be added to the /chosen node for non-UEFI boot scenarios.
> + *
> + * Return: Physical address of SMBIOS table, or 0 if not available
> + */
> +ulong board_fdt_chosen_smbios(void);
> +
>  #endif /* _SMBIOS_H_ */
> diff --git a/lib/smbios.c b/lib/smbios.c
> index b8c2846277a..45ae2d11009 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -980,3 +980,41 @@ ulong write_smbios_table(ulong addr)
>
>         return addr;
>  }
> +
> +/**
> + * board_fdt_chosen_smbios - boards may override this function to provide
> + *                           specific SMBIOS address
> + */
> +__weak ulong board_fdt_chosen_smbios(void)
> +{
> +       ulong ret = 0;
> +       const struct smbios3_entry *entry;
> +
> +       ret = gd->arch.smbios_start;
> +       if (!ret)
> +               return 0;
> +
> +       /* Verify this is SMBIOS 3 */
> +       entry = map_sysmem(ret, sizeof(struct smbios3_entry));
> +
> +       /* Check for "_SM3_" signature */
> +       if (memcmp(entry->anchor, "_SM3_", 5) != 0) {
> +               printf("SMBIOS: Not version 3, skipping DTB injection\n");
> +               ret = 0;
> +               goto out;
> +       }
> +
> +       /* Verify entry point length and version */
> +       if (entry->length < sizeof(struct smbios3_entry)) {
> +               printf("SMBIOS: Invalid entry length %d\n", entry->length);
> +               ret = 0;
> +               goto out;
> +       }
> +
> +       printf("SMBIOS: Found version %d.%d at 0x%llx\n",
> +              entry->major_ver, entry->minor_ver, (u64)ret);
> +
> +out:
> +       unmap_sysmem(entry);
> +       return ret;
> +}
> \ No newline at end of file

Please add one

> diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
> index 1f24f1d5dff..6d695a84f5a 100644
> --- a/test/dm/fdtdec.c
> +++ b/test/dm/fdtdec.c
> @@ -7,6 +7,9 @@
>  #include <asm/global_data.h>
>  #include <dm/of_extra.h>
>  #include <dm/test.h>
> +#include <fdt_support.h>
> +#include <mapmem.h>
> +#include <smbios.h>
>  #include <test/ut.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -129,3 +132,52 @@ static int dm_test_fdtdec_add_reserved_memory(struct unit_test_state *uts)
>  }
>  DM_TEST(dm_test_fdtdec_add_reserved_memory,
>         UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
> +
> +static int dm_test_fdt_chosen_smbios(struct unit_test_state *uts)
> +{
> +       void *blob;
> +       ulong val;
> +       struct smbios3_entry *entry;
> +       int chosen, blob_sz;
> +       const fdt64_t *prop;
> +
> +       blob_sz = fdt_totalsize(gd->fdt_blob) + 128;
> +       blob = malloc(blob_sz);
> +       ut_assertnonnull(blob);
> +
> +       /* Make a writable copy of the fdt blob */
> +       ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
> +
> +       /* Mock SMBIOS table */
> +       entry = map_sysmem(gd->arch.smbios_start, sizeof(struct smbios3_entry));
> +       memcpy(entry->anchor, "_SM3_", 5);
> +       entry->length = sizeof(struct smbios3_entry);
> +       unmap_sysmem(entry);
> +
> +       /* Force fdt_chosen to run */
> +       ut_assertok(fdt_chosen(blob));
> +
> +       chosen = fdt_path_offset(blob, "/chosen");
> +       ut_assert(chosen >= 0);
> +
> +       /* Verify the property exists only when GENERATE_SMBIOS_TABLE */
> +       prop = fdt_getprop(blob, chosen, "smbios3-entrypoint", NULL);
> +       if (!CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {

This is a strange thing to do. If that is not enabled then we should
skip the test, i.e. return -EAGAIN at the top.

> +               ut_assertnull(prop);
> +               goto out;
> +       }
> +       ut_assertnonnull(prop);
> +
> +       /* Verify the property matches smbios_start */
> +       val = fdt64_to_cpu(*prop);
> +       ut_asserteq_64(gd->arch.smbios_start, val);
> +
> +       /* Remove property */
> +       fdt_delprop(blob, chosen, "smbios3-entrypoint");

no need; this is a temporary blob

> +
> +out:
> +       free(blob);
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_fdt_chosen_smbios, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> \ No newline at end of file

Please add one

Test looks good other than my nits.

Regards,
Simon
