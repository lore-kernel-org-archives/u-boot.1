Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8264CD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4348063E;
	Fri, 12 Jun 2026 20:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EeEpGmSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B33AE8484A; Fri, 12 Jun 2026 20:24:51 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A718F8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so2111362a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288689; cv=none;
 d=google.com; s=arc-20240605;
 b=Er0+GbNGZa2gvqbtkZ8uPO2NSJ+Nup+dCAEZREmbPuJRB2FNWt9HPcwpJ/VsK+cRtI
 TA3sLQ1RlqjlkHlBKzDEVKrC5lNXnoO6eRVdVDAmWJuwEqZiYg9aDucCWBdOj6Mwf2N5
 nzQL+CFOF4h/5K+L/aoMU4buCd1Ba7YOxUi9tespiseZQgtNManGXGeM1hwR3N1yGixQ
 EM9X4NhkM98cQJMQmIY4Vf9kYamX7vgoOqosk5570achIjSUf/D1lj8phdPNt6kS0j72
 yO82rKLYiFrpYeKzynr6xu+poHBLek6pRNk9wH9p7VbY2msBFa9d7dknYRQjoLamftT2
 l7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QjxAUOOlfnVglbueh4x8YW062ZaoOGY3yzXLwEKQxJw=;
 fh=pqQDfe3LJMDmm+c9NDum1Jzf1ll4C62eeHhIID4fPOY=;
 b=EJuM2LXSAaXPy0HckU/UQj7PEnpa3dl8bnbSPj//l1SprvJ5K/+SmMS7tDCtqqTsZ+
 ysDyzhaVl3hIMVFS8zJVbL8GFcZ3/KgzZ4klmkExFx+G68WK77aUKs5DjDfU6DshpYln
 rjgdFJAeDHjHryYb9G36oJxjlITTJgFu+nYizbCAlggnJBxJouvVL4l/Vgkw5yTsKs80
 QqtuZFlqyFbAcAfm2aLzxDdgyFUrRkB9k3oflHFQEVJ4wCdSWBKdEJkO8CpZYzfFg3DN
 kO+gv7JKJBS1IMApNt5XCl4C8xxqMqhkLfnEAB/4KHDtq3btcTOPF9IP3dTjJsDxY8v1
 K1BQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288689; x=1781893489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QjxAUOOlfnVglbueh4x8YW062ZaoOGY3yzXLwEKQxJw=;
 b=EeEpGmSuG4/uGQ7FiOMyAUUShqckcm5cvroR1mANOgOi+ThYVK5xMVnsFl6gyFiGeY
 5i2pdrdvzNsT4yvDSNa2/j3ZTLeNDnspaPgzO+oGs0ptqPMzzHIMKpd7Drlja4rA4v0J
 75nLbg8FqZij6K1PPHimlJe8/kh03URN5Sq00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288689; x=1781893489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjxAUOOlfnVglbueh4x8YW062ZaoOGY3yzXLwEKQxJw=;
 b=E8jYk+LaNYdsNyqmjZ5ASwpaBfUUKQbXQMwUjOQytcXWaAldcVEWUH70Pkk2Ek5YVl
 VHUTnIqjg1zMBR3GhiwwlbSUUkUqhcIukj1kjgTww5dwDxO0yzdlBI3ShPEViSWOT5KD
 25feTSkk3had9ZtE7O3vCcYKJqyZCaxQN7uRqq5QVCFYlt1rdGY+8VEytxCTeMXhVGV+
 UTl9GUaYzuiyl/dN8WRxeO6gegkdH6aeu6qgTqJbQvYbLPopZbsWuhwa/0eplZoh3k+h
 kgeRC5Xke6WqAcUxoJLSi5wG5jZyYzKXD+Sf+IGwR7z6U4d/JBLSiSzLwEVFcInZSYx5
 1maA==
X-Gm-Message-State: AOJu0YwB1Si4CsMA0kvYBNm3K9c4BsCzrp7Tpymc/JVr714HGE68RXLM
 rxm93gM+/cl0YbyT5KprLUWIsHe2altM6SljW5G5i17/ywY0ldkAxDqX0gqEABRHk7msIsb9t6W
 lrmEC09YhqyiLDEEqZg/32IJuPlAj7Fwyjlo8Sq+A
X-Gm-Gg: Acq92OHZONY4TQ4QWBHZUdcUmpVU+/woX8X7JsC2+DliSzGqhSFPkNxKucM8ua/jJ1R
 Gzq7AOlUqrxkkrVW4OBXp9ykUF6axThiGHRQNntstqWmx7mLkLa+9Otx9HOPhAKpyBWsTbIT3q7
 EHYGV0K7dNRQt1lVMlSGifOxjNxJN/IVB8Hxa87a+kD2YwaYXIj+Fy8MVpdOSYnbNbkRpjHQQIZ
 +E/Jt7/JsSq5zrdShP42ojoPTc73EI75YxOSPG1UGR2qaMfy0Y8Bd9NQLL9uDtRgHSTewu4H1pO
 JMNrYg==
X-Received: by 2002:a05:6402:50d4:b0:68a:de40:26e4 with SMTP id
 4fb4d7f45d1cf-69378a5119cmr1945448a12.25.1781288689035; Fri, 12 Jun 2026
 11:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:24:36 -0600
X-Gm-Features: AVVi8Ce2gUfk_VGMaZ8QPhJ5yIqiC22JwEe2MTWnMCX4v5issijG3p24J-8A5_M
Message-ID: <CAFLszTgTtAEMWLYYoAWd2ZEhHY0G6_DNE9+FWnD6A+087pF9Ag@mail.gmail.com>
Subject: Re: [PATCH 7/7] boot: add a minimal bootmeth for the Boot Loader
 Specification
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Alexey,

On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> boot: add a minimal bootmeth for the Boot Loader Specification
>
> Add a bootmeth that finds and boots Boot Loader Specification (BLS)
> type #1 entry files [1]. On each block-device partition it scans, the
> bootmeth looks for files matching '<prefix>loader/entries/*.conf'
> (where <prefix> comes from bootstd_get_prefixes(), typically '/' and
> '/boot/'), picks the highest-sorting filename, parses it, and exposes
> it as a bootflow.
>
> Implementation reuses the existing pxelinux infrastructure.
>
> For now the entry chosen on a partition is purely the lexicographic
> maximum of *.conf filenames; sort-key / version field handling
> (spec-mandated tiebreakers) and boot-counting (the '+TRIES_LEFT'
> filename suffix) are left as TODOs. Likewise, only the top-sorted entry
> is surfaced because the bootstd framework currently allows one bootflow
> per (bootmeth, partition); exposing every discovered entry will require
> a framework extension.
>
> Type #2 BLS (drop-in directory of EFI binaries) is out of scope here;
> [...]
>
> boot/Kconfig        |  17 +++
>  boot/Makefile       |   1 +
>  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 351 insertions(+)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> +config BOOTMETH_BLS
> +     bool "Bootdev support for Boot Loader Specification entries"
> +     select PXE_UTILS
> +     default y

Wherever the 'default y' discussion lands, this will be enabled on
sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c will
fail since they check the exact list and count. Please can you run the
sandbox tests and update them as needed?

Since you are adding a new bootmeth you also need a sandbox test that
exercises it (see the extlinux tests in test/boot/bootflow.c, with a
fixture disk image) and a documentation page, e.g.
doc/develop/bootstd/bls.rst with an entry in the index there.

> diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> @@ -0,0 +1,333 @@
> +static int bls_getfile(struct pxe_context *ctx, const char *file_path,
> +                    char *file_addr, enum bootflow_img_t type, ulong *sizep)

This is a verbatim copy of extlinux_getfile() - please can you export
that, or move it into a shared helper?

> diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> @@ -0,0 +1,333 @@
> +     ret = bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLINUX_CFG);

The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since the buffer
is filled by a block-device read which may use DMA on some platforms.
An alignment of 1 risks cache-line corruption there, so please use
ARCH_DMA_MINALIGN.

> diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> @@ -0,0 +1,333 @@
> +     bflow->bootmeth_priv = label;
> +     free(fpath);

This leaks memory: bootflow_free() releases bootmeth_priv with a plain
free(), so the label's string members (name, menu, kernel, append,
initrd, etc.) are never freed - for every bootflow discarded after a
scan, not just on error paths.

Since get_string() copies tokens out of the buffer rather than
modifying it in place, you could follow the extlinux approach: keep
only bflow->buf across the scan (already populated by
bootmeth_alloc_file() and freed by the framework), use a temporary
label in bls_read_bootflow() just to extract the title, destroy it
with label_destroy(), and re-parse the buffer in bls_boot(). Then
bootmeth_priv is not needed at all. What do you think?

> diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> @@ -0,0 +1,333 @@
> +     ret = pxe_setup_ctx(&ctx, &cmdtp, bls_getfile, &info, true,
> +                         NULL, false, false);

Just to check, how does this behave when the entry is found under a
non-empty prefix? bls_pick_entry() searches every bootstd prefix, but
the prefix the winning entry came from is not recorded. The spec says
paths in an entry are relative to the root of $BOOT, so for an entry
under '/boot/loader/entries/' the kernel must be fetched from
'/boot/...', yet with allow_abs_path set and a NULL bootfile,
get_relfile() uses the absolute path from the partition root and the
lookup will miss. I suspect you need to remember the discovered prefix
(bflow->subdir is a natural place, and is freed automatically) and
prepend it when fetching files.

> diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> @@ -0,0 +1,333 @@
> +U_BOOT_DRIVER(bootmeth_2bls) = {

The number prefix sets the default bootmeth ordering, so this places
BLS after extlinux but ahead of script, efi_mgr and efi on every board
- and '2' is already used by bootmeth_2script, making the relative
order of those two less obvious. Please can you add a comment like the
one in bootmeth_extlinux.c explaining the choice, and say in the
commit message why this position is the right one?

Regards,
Simon
