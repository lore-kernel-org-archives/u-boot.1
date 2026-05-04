Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812D1FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE16D84664;
	Mon,  4 May 2026 14:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XJhSRoz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BC88466F; Mon,  4 May 2026 14:29:01 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F3383FEC
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so646732966b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897739; cv=none;
 d=google.com; s=arc-20240605;
 b=XnpmmMztjFE0MTmYvuThVUMMmQgJ0/BxYi+rIUVRKOHGqAEUbahMovWoRt+vM7XkgS
 2XkbAU5/ZeCj5UK005zonJOyiKobNXF1reeWMBIaxOPiy7sf8T6HSQbYqX2LC9x/B76+
 4ZpeM1vweppagre//s5J2JS0qEZ2j8qTNKCMOzrokXy53ko2ShMuCfqEcdo8gUw1Yai9
 sZJdcRpfWQk9sq65NbMLy+QRJD8Tgs+PqF1r+DwQ5m9C/dw5sVyTJ+DqMkNcx6nnlL7A
 kU8FwtGWcJWWc3r7/InyICEXn52JcBOdBNAE9VQzrdapNhhRgfKt/1MDQ+v8KK0R51Ze
 BRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+vdKBymygNLAp+8uCV6J/SFzNs44XwI6oAySA2KF2a0=;
 fh=DsMtUIjL6u0T9HJtY7KJbKDS0cPi91XNsRYH8TdDrwA=;
 b=PIcte6iT1wL0WdtGteeGLOGxxYnWo3bt5Vu8lY4Irm6uviNsqOW9QRlEslW4ymXNLB
 B08bYyqLm4luZG6YLf/m8QU8nu53a8/DoraeSw4zT5NWNnXj6tmOVfbe4sOGajyaYXsv
 OgrlmGvMEVSYeG+nCXcKvE0dLGkpbRZbMcpvoSOHXgMJrHffACTZwzGrToLF3Wxz/E/0
 1/VRu3h4e35BgbU1J7G5FhbRkOLg0Uv6j685Qtk/uqTW8DZVksqPctmxY+X4H3oWCYR5
 by/KX4+RYo355yX52icAre1CinLqz70HNzc45jvUWtvkq4U9GLyugFNN+mXkqSmeiIwK
 Sd1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897739; x=1778502539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+vdKBymygNLAp+8uCV6J/SFzNs44XwI6oAySA2KF2a0=;
 b=XJhSRoz9N7yVZlenoQ+hROFe0ctRctS6+6U+hIQEhy1vGNBzbUXBavmvZFuwIhh/6q
 f5O//fTEPlujXTrlYKZqi68bYAvwazBbh7l23L9I9OTx5dP4ls9G1dieOXuAZU7G7Ywy
 8xtGSK5T5RqDDkKc0bm7DnUBqzl+9XqpdXfr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897739; x=1778502539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vdKBymygNLAp+8uCV6J/SFzNs44XwI6oAySA2KF2a0=;
 b=DYkkfNQqFOjIzKaZnEGUjTuo6mtwqycwpOHdAf2zYXjHTXctJUsm470yJJqbMd/VNd
 Z/rHVtUERfh0YwTizcdoG7UiwPsPOBTIVTsn0IWkii0bo796dCNY/egj1mEkndOExwPe
 DopED/VYSNd2061DLoxtVSxrIx7hTGVM0plXWTXL1ouSOFDsdTpRn5xf6tHEfhhjNqVI
 lMlK5MWdHwtfn5ylMOhLcudGmKpZg5WQ41um/VOS6rhPGmkNH8zOqYi/DOKnprxEhLnj
 Y06W+Yl/fZYT1CMSyguVkA1dEAW5IDZilHMBMrlPql2Tj/artutq7CsvzG+fjEdb0V/c
 eIng==
X-Gm-Message-State: AOJu0YyBGAvZvpNQWFu4hFe1OEgLSvwXotRTfAcgunLbV/aEZRcE9p9d
 /6rB4qYKbykveF2fJtmwXlAS+HZHpvlw3m+E5fbPvAyMlGeWd73E2P40saF4uNoaPrd2q9nDFdh
 7u5LXQuOJpWotraXGsEqLJdZ8++FZUNc86xFRgNM/
X-Gm-Gg: AeBDiesYshAUQCfcTwGqHNafgKdc/sI14AGIbuGLOddQJdTiBdA8XSzq3ojJ40ziRNP
 CgZA5qsNAh99ZtuQk/6PCmu81UAlou4lxySJy5Vh5EOergPeNzaipze0lABUwvFd3LScsrvbhiM
 GRPLlnO/OOggITOOD12VGiN1chrHFCSjHP8kFHjC7ck1Ey38HFrsQYeiGaJJ7fp9LmG3s+vR1Dl
 vpiWtS751fcbjIM+4OO2+hNOM7RIblTE9bsp7wqiXjTVHRlQ0TM90I+FnPvLaZlyaU/3FNuaOPu
 xTxvQKpldpNffJN2
X-Received: by 2002:a17:907:6d13:b0:b98:50b:e94a with SMTP id
 a640c23a62f3a-bbffb749e38mr497007166b.16.1777897738966; Mon, 04 May 2026
 05:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114250.791663-1-ludwig.nussel@siemens.com>
 <20260429134142.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
In-Reply-To: <20260429134142.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:28:46 -0600
X-Gm-Features: AVHnY4LyjtpSQOSDFPQUksyeGW8rF7hAy24k0Gsghr_N65Gl5KpXWc9IlyNdrcY
Message-ID: <CAFLszTgbai8a+VK8TAjuXUJf99JhpuoEaq538qMNwTSJ-KAoog@mail.gmail.com>
Subject: Re: [PATCH 3/3] tpm: allocate tpm event log if missing
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>, 
 George Chan <gchan9527@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On 2026-04-29T11:41:40, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> tpm: allocate tpm event log if missing
>
> Allocate and attach the TPM event log to the TPM device if not
> initialized yet. The address is copied into the device tree for the
> kernel so the event log is accessible from Linux userspace too.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/Kconfig         |   1 +
>  boot/bootm.c         |  18 ++++-----
>  boot/image-fdt.c     |  67 ++++++++++++++++++++++++++++++++++
>  include/tpm-common.h |   1 +
>  include/tpm_tcg2.h   |   9 +++--
>  lib/tpm_tcg2.c       | 101 ++++++++++++++++++++++++++++++++++++++++-----------
>  6 files changed, 160 insertions(+), 37 deletions(-)

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -973,7 +969,7 @@ unmap_initrd:
>
>  unmap_image:
>               unmap_sysmem(image_buf);
> -             tcg2_measurement_term(dev, &elog, ret != 0);
> +             tcg2_measurement_term(dev, NULL, ret != 0);

This passes NULL for elog, but tcg2_measurement_term() still does if
(elog->log) unmap_physmem(...) and calls tcg2_measure_event() which
ends up in tcg2_log_append_check() doing if (!elog->log_size). Both
deref a NULL pointer. tcg2_measure_data() looks the log up via
tcg2_platform_get_dev_log() when elog is NULL - so _term and
tcg2_measure_event() need the same treatment.

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -24,6 +24,10 @@
>  #include <asm/io.h>
>  #include <dm/ofnode.h>
>  #include <tee/optee.h>
> +#if defined(CONFIG_MEASURED_BOOT)
> +#include <tpm_tcg2.h>
> +#include <dm/device.h>
> +#endif

Please drop the #if around the includes, and inside the function body
prefer if (IS_ENABLED(CONFIG_MEASURED_BOOT)) over #if defined(...) so
the compiler still type-checks the body when the option is off. That
is the U-Boot convention.

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -589,6 +593,67 @@ __weak int arch_fixup_fdt(void *blob)
> +     strlcat(path, '/linux,sml-base', sizeof(path));
> +     if (fdt_path_offset(blob, path) >= 0) {
> +             log_warning("kernel dt already defines an event log address at %s\n", path);
> +             return 0;
> +     }
> +     end = strrchr(path, '/');
> +     *end = 0;

fdt_path_offset() resolves nodes, not properties, so this never
matches - linux,sml-base is a property of the TPM node. Use
fdt_getprop() against the node offset you already located above.

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -589,6 +593,67 @@ __weak int arch_fixup_fdt(void *blob)
> +     fdt64_t a = cpu_to_fdt64((u64)virt_to_phys(log->log));
> +     fdt32_t s = cpu_to_fdt32((u32)log->log_position);

linux,sml-size is documented (and used by Linux) as the size of the
reserved buffer, not the bytes written so far. Otherwise the kernel
cannot append further entries. This should be log->log_size. Please
also give the locals descriptive names (sml_base/sml_size).

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -631,6 +696,8 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
> +     copy_tpm_event_log(blob);
> +

The return value is silently dropped. At minimum log a warning when it
fails with anything other than -ENOENT, otherwise misconfigurations
(e.g. allocation succeeded but fdt_find_and_setprop failed) will be
invisible.

> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> @@ -564,11 +576,29 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
> +     } else if (tcg2_platform_get_dev_log(dev)) {
> +             return -EEXIST;
> +     }
>
>       rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
> -     if (!rc) {
> +     /* no existing event log found and none allocated yet */
> +     if (rc && !elog) {
> +             /* magic size value. Same as in acpi_table.c */
> +             log.log_size = 0x10000;
> +             log.log = devm_kzalloc(dev, log.log_size, 0);
> +             if (log.log) {
> +                     log.allocated = true;
> +                     ignore_existing_log = true;
> +             } else {
> +                     log_err("Failed to allocate %u bytes event log\n", log.log_size);
> +             }
> +     }
> +
> +     if (log.log) {

When tcg2_platform_get_log() fails and elog is non-NULL we fall
through with log.log uninitialised, then test if (log.log) on stack
garbage. Either zero-initialise struct tcg2_event_log log = {} at the
top, or skip the block explicitly.

For 0x10000, please introduce a named constant (e.g.
TPM2_EVENT_LOG_SIZE) shared with acpi_table.c rather than duplicating
the comment.

> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> @@ -580,26 +610,40 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
> +             } else {
> +                     struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
> +
> +                     elog = devm_kzalloc(dev, sizeof(struct tcg2_event_log), 0);
> +
>                       elog->log = log.log;

devm_kzalloc() can return NULL - this dereferences it immediately, and
on failure leaks the 64KB buffer allocated above. Please check and
unwind cleanly.

> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> @@ -662,6 +710,15 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
> +struct tcg2_event_log *tcg2_platform_get_dev_log(struct udevice *dev)
> +{
> +     struct tpm_chip_priv *priv;
> +
> +     priv = dev_get_uclass_priv(dev);
> +
> +     return priv->log;
> +}

Missing kernel-doc.

> diff --git a/include/tpm-common.h b/include/tpm-common.h
> @@ -83,6 +83,7 @@ struct tpm_chip_priv {
>       u32 active_banks[TPM2_NUM_PCR_BANKS];
>  #endif
>       bool plat_hier_disabled;
> +     void *log; /* struct tcg2_event_log */

Please use a forward declaration ('struct tcg2_event_log;') and type
the field properly as struct tcg2_event_log *log. Hiding the type
behind void * loses compiler checking and forces every reader to trust
the comment.

Regards,
Simon
