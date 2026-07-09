Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665EBC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 20:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 776E584BF6;
	Thu,  9 Jul 2026 22:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tqdt09ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6707084BFC; Thu,  9 Jul 2026 22:18:31 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F15B984BF4
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 22:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so337317a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 13:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783628308; cv=none;
 d=google.com; s=arc-20260327;
 b=PthohS+ei40waGbpeyPpjKmCudoTNrWZly4R45URuK3RqKZJFqx4Es745zaQ9teNYI
 caKLgi1jvqddwwBbAcoJ9q1yPKPb7B9vZtm8F8XOcROGGVY3hrmv/57pF6RlXvnEtqnq
 /Gxs8F/n3cHI4raks5n8eWLMtbBb8sIO71HJaUv7gfJRboMyRK+6fyMsPi6jkBoi6V5y
 MnYMdrhvJGDULPC1ZsXWe5/ok4xOmmCKwIGryYAVaCCzkwSEY9L8SlG3pbaYrOenS6wL
 o5DmvlrGrlcVnHZH7r30BcIfA+9qCQQgK+T5xTKlaRdsaFrO/l6RiLvMl1tGwRhEM94w
 0upQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PKZxNaM24vFnYl6SUAkXvR/W6GLK+9rG+JqibTS130k=;
 fh=Pxq0yxYGRjphnM+U5aBE5iEiDvtwTenPIVGTvPAHeLA=;
 b=e2E+BgTYxA16q+Wer4ux/oLkR2lKKdJ8t7u4afSogG79PfOU0ZnBUmHaYLL6xN9n7k
 +QHAVqwEJACm6KukPOFvJgiBUZHCP0pSu3LiGicGUYnUmsPr5HXTcUzza9dZhF6WTdMd
 B/pnhI+XaYwkvr9LKaVAKTm5l4R+/IRjrHD6mRtGItuVPamzxf3n2uPrrH7Jhw606c8/
 RaXgm+DhdlhymkGshchQfVQOMtcaRkZ9dvlpZXIbmnakpgPheVgctnmjUWklqatcu6y+
 RDDwWp9gQVwQBgTBgvK/PFN0Ss2EoXPJ31KtHUiZUn0MVYcK4tft/eAzEXrzOVmd2yn6
 jycw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783628308; x=1784233108; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PKZxNaM24vFnYl6SUAkXvR/W6GLK+9rG+JqibTS130k=;
 b=Tqdt09ap5LYVaBSgHtcNnmOpa0qHurmWimOgJWucLYmb9HdANRk2KcbC3kY8YLRWlc
 +rYEqYuFEhbDJChpAN9IzivCy+wwyzKzYFkrbzJ0JlWdYi3vhJtUzutFo+PVCKMzILPB
 TUOQota293tTQHgDu0enavOj25GHAXMcPafjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783628308; x=1784233108;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PKZxNaM24vFnYl6SUAkXvR/W6GLK+9rG+JqibTS130k=;
 b=Uq9IhY5TDJjcX4211U/toFClt2A0GFC1xOl6wETtRkC6j8fQKnTVj0dlnrQd9XG8lJ
 K2YEYgErTsEXppRC7Wd2h+8zutVsV6g2SVLsEqARTY+6dfzyOolLXBDuLibb6BuWF9xp
 VxHM4qBK157BuemYlhieGtNfXwQUj2flhgkwy5qFKB/Wz5yTX2O/RRVZryT21b12njwy
 hrXP+wVgWMGKpS8M84jbZibuyGGRs86OSW0s4jne7OA3tu5qJkzt7pbCynrb2B+QiK8K
 0vCkwAQ7PNuL/hISXxNanI6ny2XlH0ccCyQpWw+cySFu/4ZYloUW8JXqVgGK4PCMG8lt
 gEsg==
X-Gm-Message-State: AOJu0Yxk1zAg6MGloCbooB2r0E31/AXLZTBktA7yEVBktgv+iA2WCPAT
 0Xnmt0gyi+evNlt1Vvi2rkrfIqsiH2zt+/oFUmiV/ILIbMnOLbOGQOMfg0SpBuVqmL+3J4Ftvr+
 hSMS4HcPArSzCFXf6/XZnVTiMzZIGtczC1J6CQnVW
X-Gm-Gg: AfdE7clAEySnZRWPGq7YdI5ReRPMoUl/UC1idqA3C67Jd9EfxnXNFIYYfxZ5Fy2FOC8
 0greA4cPDySewcRalIe5fu6lhxdn9yw/L4e47RN92Tfk7TVf+KEHvzC0TdAYfIgMpODAE3NxFGd
 wH9F8CRT8HSzduNl8Sq6Gc+w/tHi6QHh6s2OpOjzSPYuh4e10crPNMbAIrfc2YtZacj35iy8ssw
 +G4hkDnWEyoXaiG7qU4rpGWJsVlvzHydBRK47OuYuXk6ZEKi+60kn4JHul9pMToq1m4naM=
X-Received: by 2002:a05:6402:1f89:b0:69a:9355:ec35 with SMTP id
 4fb4d7f45d1cf-69ab44b5e42mr3879480a12.41.1783628308384; Thu, 09 Jul 2026
 13:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 14:18:16 -0600
X-Gm-Features: AUfX_mx7TdfpMG07p1ZhklOxLiljKsjbR-BHmH0LYfpgdd4KA5hnAVgWE87fG0o
Message-ID: <CAFLszTjfHDNmydFwhM85OUtvrK0AVLreTYidfqNu+CaUNDQTrQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] bootstd: add a firmware-owned devicetree source
To: ccaione@baylibre.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <floss@jetm.me>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
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

Hi Carlo,

On 2026-07-06T15:06:41, Carlo Caione <ccaione@baylibre.com> wrote:
> bootstd: add a firmware-owned devicetree source
>
> Platforms following EBBR / Arm SystemReady IR keep the devicetree on
> a firmware-owned partition, updated independently of the operating
> system, rather than shipping it in the OS image or on the EFI System
> Partition. U-Boot has no generic way to source the devicetree from such
> a partition, so vendors carry out-of-tree machinery for it.
>
> Add a bootstd helper, firmware_fdt_load(), that assembles the OS
> devicetree from a FIT manifest carried on that partition: the FIT images
> hold the base DTB and its overlays, and each FIT configuration names one
> bootable combination through its 'fdt' property.
>
> The partition is described in the control devicetree: the bootstd node
> carries a 'firmware-fdt-source' phandle to a source node, a child of
> the media device owning the partition, which identifies it by GPT type
> UUID and/or name. The 'boot_dtb' environment variable may pin an A/B
> partition number.
>
> The error semantics are fail closed: -ENOENT strictly means "no source
> [...]
>
> MAINTAINERS                               |   3 +
>  boot/Kconfig                              |  23 ++
>  boot/Makefile                             |   1 +
>  boot/firmware_fdt.c                       | 382 ++++++++++++++++++++++++++++++
>  doc/develop/bootstd/firmware_fdt.rst      |  94 ++++++++
>  doc/develop/bootstd/index.rst             |   1 +
>  doc/device-tree-bindings/firmware-fdt.txt | 149 ++++++++++++
>  include/firmware_fdt.h                    |  78 ++++++
>  8 files changed, 731 insertions(+)

(See naming comment on the cover letter)

diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
new file mode 100644
index 00000000000..952299f1e1b
--- /dev/null
+++ b/boot/firmware_fdt.c
@@ -0,0 +1,382 @@

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Firmware-owned devicetree (FDT) source.
+ *
+ * Some platforms (EBBR / Arm SystemReady IR) keep the devicetree on a
+ * firmware-owned partition rather than in the OS image or the EFI System
+ * Partition. The devicetree is carried by a FIT manifest on that partition:
+ * the FIT images hold the base DTB and its overlays, and each FIT
+ * configuration names one bootable combination through its 'fdt' property.
+ *

By FIT manifest I think you mean a FIT?

> +static int fw_fdt_get_source(ofnode *srcp)
> +{
> +     ofnode bootstd, src;
> +     const void *prop;
> +
> +     bootstd = ofnode_by_compatible(ofnode_null(), 'u-boot,boot-std');
> +     if (!ofnode_valid(bootstd))
> +             return -ENOENT;

Please look the node up via the bootstd device rather than the raw
compatible string - every other bootstd consumer uses
uclass_first_device_err(UCLASS_BOOTSTD, &dev) and dev_ofnode(dev),
which also ensures the device is probed. Open-coding the compatible
walk bypasses the uclass and duplicates knowledge that lives in
bootstd-uclass.c

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,382 @@
> +void firmware_fdt_free(struct firmware_fdt *fw)
> +{
> +     u8 *fit = fw->fit;
> +
> +     /*
> +      * The assembled devicetree either points into the manifest buffer or
> +      * is a separate allocation (made when applying overlays, or when
> +      * aligning the devicetree); free it only in the latter case.
> +      */
> +     if (fw->fdt &&
> +         ((u8 *)fw->fdt < fit || (u8 *)fw->fdt >= fit + fw->fit_size))
> +             free(fw->fdt);

Comparing pointers from two different allocations is undefined in
strict C, and the "is fdt inside fit?" heuristic depends on assembly
internals that could change. Please track ownership explicitly, e.g.
a bool fdt_owned set at assemble time, and free based on that.
I am nervous about mentioning it, but an abuf could help here, since
it handles things which are allocated or not.

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,382 @@
> +     fname = ofnode_read_string(src, 'filename');
> +     if (!fname)
> +             fname = FW_FDT_FILENAME;
> ...
> +     out->fdt = fdt;
> +     out->size = len;
> +     out->name = fname;

out->name either points into the live devicetree or at a static
string; the caller (bootmeth_efi in patch 2) strdup()s it, but
nothing in the API contract says the caller must copy before the
tree is modified. Please strdup() here, or spell out the lifetime
rule in the header.

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -671,6 +671,29 @@ config BOOTMETH_EFILOADER
> +config BOOTSTD_FIRMWARE_FDT
> +     bool "Source the devicetree from a firmware-owned partition"
> +     depends on BOOTSTD && BLK && FIT
> +     select EFI_PARTITION
> +     select PARTITION_TYPE_GUID
> +     select OF_LIBFDT
> +     select OF_LIBFDT_OVERLAY

The cover letter advertises best-match against the control DT
(CONFIG_FIT_BEST_MATCH), but nothing here selects or depends on
FIT_BEST_MATCH - with the default config selection silently falls
through to the manifest default. Either select FIT_BEST_MATCH or
note in the help text and doc that best-match applies only when the
user turns it on.

Selecting it might have code-size implementation, though...

Regards,
Simon
