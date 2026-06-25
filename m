Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7DACDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C33E684962;
	Thu, 25 Jun 2026 17:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UhSpBD0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55AFC8494B; Thu, 25 Jun 2026 17:28:21 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4BF8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so8139905e9.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401298; cv=none;
 d=google.com; s=arc-20260327;
 b=ZGQtG3X+6KzE8nupIkfWxJ/9m7YyUGHOGzlYyAeZ8KuRwU+gBLpYZgoDvPLDDYt28p
 gA8YUKlBRgIJ8MxZ9Y3LenTel8TFQuaYAv6FpYpzzoiYztoQdq5HC/4rnSO9rCPXfDZz
 n5g5CVMFJkUqheEsl1dtNBgt8mdbsz+n6SiyfM2UcLwsLmQLAjzeiZl86DHMdkRuoO5U
 4t5wxlfTsf7dxpmcpWqAOKqkeQ9ywA4QMwcT6NlQIErHZnFfmmj/Ex/BTO76FfQWX2/c
 nrgztODEgj3rpSKdRaroYsRNLNQgm5hsp+XFpXWePXqwL8PdmaFdwVUMsNRkJssRXNh0
 7WCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mV7BuwklSCI3bp1FNU/RPxfAPsPDhJ4LBCFfNKPAQPQ=;
 fh=pqQDfe3LJMDmm+c9NDum1Jzf1ll4C62eeHhIID4fPOY=;
 b=UfgQzn7CUEd2vz2xJOpc7yDFbYdhSaIUzg/N91CWm5o0aoCzH9k2b2tYHaXN+kRa9L
 soxDZjR1Wh63664n5iCAnII1ykfvlV6Hmh2ksY94XYoPhe4QOhbPsGyiQ0iwzDuj3JTd
 YOHEnz2AcBz/Po1ymRtzDnStIma7IDf28xXaJLQH+khKJx/0a6cAIBhFx/daktfWKyx6
 0XW1acYz7qOnvzjShHrXYoYouJw8tum9NbjhG9GW8QIOkcrPh2+hG3oZQLM2sUvNI+UJ
 bAfmzwXjT/656XZSIezbg0ICCejalMqq6/s7uFh7KOzZeMo+Q40MW7U5KYKzsSW/yku4
 ujwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401298; x=1783006098; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mV7BuwklSCI3bp1FNU/RPxfAPsPDhJ4LBCFfNKPAQPQ=;
 b=UhSpBD0DC4k/XxIDHgSEIQQFw1NrVT5O2P7UAMIG0hZRUs3w3m4r+4MtED7WEYX7mk
 /03e8S+7efWRTuJ4WA7xF4YQsmI/s4jymPWDe/K/rjuJrVeG4SKqw/6MtlxRUF9aCFl+
 67eQIqLAkzthY1k54lzoWbzhHoZMdHLBtQmHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401298; x=1783006098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mV7BuwklSCI3bp1FNU/RPxfAPsPDhJ4LBCFfNKPAQPQ=;
 b=l70ZpiR+A/ZbxnULtUAa+KMN6nCG2hDk2Ko8O7PCxdwWJaoKpJ40yd9YHOLBDRzaPo
 J5MGV5oPN8sYoeGbNCRIMUnAfOLMoeT0peWFdItfvj854uDISyqqzj6f027ObWoRt3R8
 IwOxhUgyFrf8YZmAFnamP+t6CMpXY9oQDNJZlGZqC3Fkbb7vIMj9ElevX2/v6DZ/jWM7
 mnbQwfCIZBL47bxwZApY2Pb3ieHF41pBUK/Pkw+EE5VI7rfyoHY3TebU3AkY2WWBV8yd
 lY+nF4ifIkqxHwhNC3pu3TmkeMqOKHz5lPWXVfjNFA7jdLTJiYLrupsG+8iV7TFVpgS9
 cHaw==
X-Gm-Message-State: AOJu0Yw+rQVWO/S1YnZ1H3ZzXseobCPDO4Y1NxzXFBccX37U2zRP0V5b
 sZnvAwqFXvVWFni3830eGDGH/4v9dnRFns6VQVynjxGL9Pt3xEey/qmLv+ErSdLohO+QDGeP5kA
 ul0Ri1U+lmJJnxAv7EMFbuEFNK7RTB8H6afxQyahU
X-Gm-Gg: AfdE7cnC64l13mZ4Kjo/ee5fqzsA4Xu/QNG1EMZ+5ouAbiD2hRvJvg3WsWKM/CR54we
 EKudpXulKSING+KXODiWEYLtr9IKei40fEBtn2FvXVrkayy+yzHe1fZukknDCDFjJ+rTGnOVip9
 zvcBdJFd5LWBcnDPAMp8teGMIgtfA/00i4w12vmaQCsocJkr1WouQpL4xmbGCY13o0VQ7/eg4Es
 Y20N3GIQX1Vqmvn8um11FF2J4i4eLoRiTb8bERwAw4N3zTUqHYoDgGCkkftG86aoIR3tzdIhw==
X-Received: by 2002:a17:907:ec0a:b0:c0f:cbe9:9e7a with SMTP id
 a640c23a62f3a-c10309ba1acmr722826666b.15.1782401297824; Thu, 25 Jun 2026
 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:28:05 +0100
X-Gm-Features: AVVi8CfxGfcipUU8x5NBBCj1dSDKw_cN_ghfuWtiKjcZ0WMLFmXthKLCkQ3P4sM
Message-ID: <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
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
order of those two non-obvious. Please can you add a comment like the
one in bootmeth_extlinux.c explaining the choice, and say in the
commit message why this position is the right one?

Regards,
Simon
