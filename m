Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864FACD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 21:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E28384C0C;
	Thu,  7 May 2026 23:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kQloTDSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC4584C04; Thu,  7 May 2026 23:12:03 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4D2384B9D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 23:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bc356898256so227630866b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 14:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778188320; cv=none;
 d=google.com; s=arc-20240605;
 b=VeOm4cOBc2NXxAxFiGeapYUIc3XeFA5e/38/Zdl2TfZfmqRxlyqSgW5wU+pZmdugNT
 LEcg5a2pW6ktgCUMVVLrH0Tm1hDgKMvqb7R6MjhWae/MNMJ5HYd1NMJ9VrStiYM95F3G
 novFybY5irj5Le0W2U+lKR3rBLY7ZV5lV01x6kIAqBRf9e2JUv0ywJpqK+YeHey+S5ls
 MtXbE1Ms3v6kWuHkSKbQiH5RoZgFvrOiiCP9X2yl7IBhnkICC9vpZ/8MyvJY8/BXggcq
 J0bDHQIVBlcDiSqDY4Yrmmx+LWZzgpNOZwR+m6RSfoVWQj7A7AIA9bjtY9Fwn/siV2JL
 aDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dvcqagHg03g3xJi7B7bMKxFSAJGkfF4RN56t07OdKtw=;
 fh=pG65kes1vWDQ1AvYIebNuLUz/8pQiTkb3lwpDruQbts=;
 b=IB9CHdQOFm0HrC0rWHZDT6yYhbkfkLGd50xkNffwubPxNqgBizZgN9fR++kehLt9ho
 Se2QgTyWghMmtih5gvres2PyVc9gye8+XdHT+TR+Oyz4aj9DtaxG4RaOK+NqNBrucYCX
 iDJjwf/73tyxFHemFXRkid4o/gIE8nfOija6jpgAZ0vcESrHBepfBzvS6178DfcY7+qy
 z/IKw4zIo2vmxx7iSHUVvN83v5Xe3abBRyO/nQHkfRcg6nInQX4gYEg0QabFHcHZWB4S
 6A+PmBP9ydLz/P6LmlfL2Hnc38OYYFtrn1j8wF9Hm1WklmoSGG036qWm9qUaJ8r0ucXB
 cBMA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778188320; x=1778793120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dvcqagHg03g3xJi7B7bMKxFSAJGkfF4RN56t07OdKtw=;
 b=kQloTDSsflWA0Dh+vaAkohzU3GLfrNfR8o4IvpFJEAIxbEWI8s6rpgM2q2CUrLEq8K
 6a8qj54+ShaWgz1fk3MMP+4EDJ+Js4QvAyqyHSNAPrhfYSu/rgTgm3XInxpg9LnHeRj7
 Sw5kKgBDTgveX4x7g1J2cnMYdHnYc4tH8Ay3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778188320; x=1778793120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvcqagHg03g3xJi7B7bMKxFSAJGkfF4RN56t07OdKtw=;
 b=nhHZtErO+m9P8goxJGf6dOAkZwDctdq1B+R+fXlac39mjI6NrRfwOo5GkHUCAhHma9
 5FKhafsVmdn8gTwIry+BzR9lqc/ffPoyu/okhVo90shEcFL9nlTfWz42Yk+1chHMRPLl
 JIJ+4dvzVt7KNBUA3JhdD24aqJRsOC+PudQ521S6gO42JamynmUCkLODAfHuFh0SGQDR
 h4NJ4E2lYWjheAhZlATOpIFuVh19pD2qG+GzvDMSXUuU1Hewqb4eVr5TOuzcKDi1x2Zi
 wbhTHl3en4TIIoI2gjlneweUMk0AD6GTs2NCw2GaA3Xj4J2ZO+8aCevVw379b0POnMjy
 60nw==
X-Gm-Message-State: AOJu0YyeGWeBVev1Htuk0O1E0Z/oTdNMABZxrcVjLv4EeZkr5bI2XMXo
 C8xPHWSaCFHwKq+MukVh1fyFLzhSyrwKl80xlfAXSOor3vK3N6T+quCwBSY9SLWdbNFWWb+xVy7
 etRIx9+dVA7j+rkcCHQsbId96Dkzx6Bl2GdRdwQT8o6Baap6yS6c=
X-Gm-Gg: AeBDiesy3AdaT+JA9zSCyN+hun+KfkLVj9Re7uX9VZqo/IXWhhuF/ggjHNgEHxMRW6Y
 9fTjZYw6ijIXUC+fFMiTbYMyEBk7OPhORBjdErh9r+yiGDE9huovHETIiTJOkbmYWbn0oDOMYoE
 JOjAHwMJZuw8zO15p1A/blgcBkHEdXoItHOYOoo+S6rlzFRLAMhCi7UCBO7eFvtWwfxHGPIVPds
 bmQIL2YmkOeODPePsOWcFx6jbM3NPUA0vRhbh2teTL//r0acqHACgM3xr2aT23HBuMXrO7sMRFN
 loFVn+c7iM3sDYen
X-Received: by 2002:a17:907:d08d:b0:bc6:d873:fd5d with SMTP id
 a640c23a62f3a-bc6d87406c2mr382375766b.44.1778188320021; Thu, 07 May 2026
 14:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <20260507140624.v3.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260507140624.v3.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 15:11:48 -0600
X-Gm-Features: AVHnY4IxHcDb6khurhiVuBbTVQ35KwrBDTAV2tJ2i_vzRlK01IdGTga05m4naTw
Message-ID: <CAFLszTg8hL6-CkPr9ztGBxD2DEAuHyi0RBuNcOxu2L_eqc+a-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] qemu: overlay signature nodes
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

On 2026-05-07T12:06:22, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> qemu: overlay signature nodes
>
> The keys trusted for FIT signature verification are supposed to be
> embedded in the device tree built into u-boot. When running in Qemu it's
> convenient to use the device tree provided by the VM which doesn't know
> about signatures though. So merge both device trees at startup.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> board/emulation/qemu-arm/qemu-arm.c | 50 ++++++++++++++++++++++++++++++++++---
>  configs/qemu_arm64_defconfig        |  1 +
>  2 files changed, 48 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

a few things below

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,12 +144,56 @@ int dram_init_banksize(void)
> +/* QEMU loads a generated DTB for us at the start of RAM.
> + * When using signatures we may have a built-in FDT that contains our known
> + * public keys nevertheless. So merge those nodes into QEMU's FDT.
> + * We cannot merge the other way around (eg in fdtdec_board_setup()
> + * or board_fix_fdt() at this stage as U-Boot might be started from
> + * a ROM location.
> + * At the same time U-Boot needs QEMU's FDT to initialize serial
> + * devices even before relocation.
> + */

nits: The opening paren after 'eg' is never closed. Also the subject
says 'overlay signature nodes', but the code merges the whole root of
the built-in DT into QEMU's, not just /signature  - either narrow the
merge to /signature or reword the subject and commit message to
describe what really happens.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,12 +144,56 @@ int dram_init_banksize(void)
> +     void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
> +     int ret = -EINVAL;
> +
> +     if (fdt_check_header(qemu_fdt) != 0) {
> +             log_err("Invalid QEMU FDT at %p\n", qemu_fdt);
> +             goto out;
> +     }

On this error path you still execute '*fdtp = qemu_fdt' at out: and
return -EINVAL, so the caller is handed a pointer to garbage. Please
leave *fdtp untouched, or only assign it once the header has been
validated.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,12 +144,56 @@ int dram_init_banksize(void)
> +     ret = fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
> +     if (ret) {
> +             log_err("Failed to resize FDT overlay: %s", fdt_strerror(ret));
> +             goto out;
> +     }

fdt_increase_size() resizes in place - there is no bound on the buffer
at SDRAM_BASE, so on failure this writes past whatever QEMU put there.
This is fine, from my understanding, but a short comment about that
assumption would help.

Also missing the trailing '\n', unlike the other log_err() calls.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,12 +144,56 @@ int dram_init_banksize(void)
> +              * existing setups might have injected them into
> +              * QEMUS's FDT already.

QEMU's.

> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> @@ -7,6 +7,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DEFAULT_DEVICE_TREE='qemu-arm64'
>  CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_OF_OMIT_DTB=n
>  CONFIG_SYS_LOAD_ADDR=0x40200000

The convention for disabling a bool in a defconfig is '#
CONFIG_OF_OMIT_DTB is not set', not '=n' - please run 'make
savedefconfig' if you want to check the result.

Regards,
Simon
