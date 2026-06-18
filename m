Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EF8CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C874849BF;
	Thu, 18 Jun 2026 17:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B7qkrrCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76CB6849AE; Thu, 18 Jun 2026 17:53:18 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E919849BF
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c07ea058c0cso131446966b.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797995; cv=none;
 d=google.com; s=arc-20240605;
 b=E9k2HXedctwwVodu5yoPi/rUAF/C0Bt4oKWkqTSWvwD8fpPELNZeCKHwSsd8Nox+Cf
 5kmYFWZJOCPmrORg982fpKxhKxQuJvWc48lpvt2zNvVanX0r+7WzQhQ6eevZXoDbYFNG
 8fp0GS1+wfSraqO/+0j1BjBModaB6aOfUtjFZwR6ctpIFo5XMRPpFHm8p0IHn+NlyXBl
 T+8O3ZU4JmGmzL/fSpzENi8VV63bmH/wBzBMGmYlwJWNxKhoi9KP7s7B6vjbfdileczd
 5YAb5PEWQZQVx9WbX27kL8enXDMzqztEhFg6YHFotwGCJVpASdDsxcHwY9AnBZVvQ1ci
 Cn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dZfrH+T58CAyu/FxHGkORGIYVVqHpbYLmMyHAfiYYR4=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=NGPNqv1+cwewii7b5aTMFscVMLKBgz2c+QZDKt+Mf5tznftf2ZYg5Yyyu7IGWtxOKb
 U0iMNIAsUBtsC3BCr0Ag2YX0nCYqCdPUD6dfYTZHTn5OKv3GN0mnSKr2fZG6shr6O0tp
 CgXs/+o/uQ2XzHQHwdpXZ1ACDSSeJR1qsHEGz3BFtqS+Q9s43mk3dXy7RWJVz/4/qrn6
 /zbV4M+gjorEj+UxLMzlaDsWUTONVkgfvarNLo/b/PSg0Ht+kMrQkdrVbXYn+Ujw0wKf
 g4B8aaoIpWs6JEQlsLPMNakmfLEPf4LD5NzL5umC0bLiWBzNV+IGBTUZbU/zzXh3+OUx
 wVRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781797995; x=1782402795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dZfrH+T58CAyu/FxHGkORGIYVVqHpbYLmMyHAfiYYR4=;
 b=B7qkrrClatG0GecV+KneGcTkII4hebfSPaDEQCaChqmqU65lxdtbe9Ac8w70bG8iwP
 RJJTyTlE+pNswSONVHlODhY1DGAPlwQopzhOBRuY38dMDQzO3+/5HNJMKpi89ea5kyib
 4qMIOmiei2NPF1q34Yn1Q1vZ5sbV2GSlKncIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797995; x=1782402795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZfrH+T58CAyu/FxHGkORGIYVVqHpbYLmMyHAfiYYR4=;
 b=oAvCSII4U7gZGhTe8Rv7YsCgTKiw0mKNFbNDLmdiZWvZGWBRfPLvj5qrbRibpdWS+R
 0twQRX+peqV1u9Y5v47yBwra/OmE8TEYTzaug8plGYo3NjDwOzdNd3Ey/8DOi13WRYmw
 Vd22BQyq5R+Llw2wa1H6pAfI83tFobGWMxIBKqhJYMJriEO0ZFhdXY4WpBqw1dBcTl+0
 nAaRdhJ91etsTIvm/JQrQ1oKTgV9nVu6KfhvmuAx5VXTqeMtm8XBCfF0JmxYEHnPD8OW
 EqH4fpG9mtAOFrMdlTMkBMe0WuTIFrwfH5DorlvAzlerCG7GfD3NFjU2FrEjYIopZDUu
 DZ+Q==
X-Gm-Message-State: AOJu0YyOYCqDYEEgAoAnud792WTIXOh966MVW7vhC9borxnSPPQFsBLR
 GtgNwwm2b1cr7j8Kc4XlQwgDKsWnUqcwrd4AsvNmoC43EqieN66uY/jvu9ZqLPVUDFtW/WWBIms
 +ev9J6dEAYaqodcspakRKtoc8orIK3+6vWE8D+SWy
X-Gm-Gg: AfdE7cmmVfyowwtpmlb09QZieYbwIxxQsfCG+moNoF7Rk7QnHhk8s1iuTXFI7hMysyw
 kR6jYDrd9vaR/UzYdlsDz7mGJfDWyU/iauGM/v9d69XpHBKBfoM2PD5rQto2rUdcG4wngp9uqOa
 NlLvnSU2CAVFJPDiv+VWPtCLX5V2DWN0q1pZ7+YWWFfl17LSCddzFmWoR9xR7xTO5akBoWMTy8+
 pHSi4rOvbUmbCCIIFlLn894CZR2IHQOOF3Vmrh6ZePbCA36HOBCU6NqOZ+MHt+N127+5VfTrA==
X-Received: by 2002:a17:907:1dce:b0:bfa:f563:9294 with SMTP id
 a640c23a62f3a-c05d215b625mr391856366b.18.1781797994944; Thu, 18 Jun 2026
 08:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-7-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-7-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:53:03 +0100
X-Gm-Features: AVVi8CeUxbuHZpV8bRj80eWy0duWNpXjszP-64y4uTI_Q77t8OJm2z0KpWWVm3U
Message-ID: <CAFLszTiWAyb2nv=PJ6FX-Yjhp0MwRp_-8+aYgkEo7UO-oeEWcA@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] bootcount: gpt: introduce GPT-backed bootcount
 device
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:
> bootcount: gpt: introduce GPT-backed bootcount device
>
> Introduce bootcount device backed by GPT PTE attributes (bits 48:63).
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/bootcount/Kconfig         |   7 ++
>  drivers/bootcount/Makefile        |   1 +
>  drivers/bootcount/bootcount-gpt.c | 140 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)

> diff --git a/drivers/bootcount/bootcount-gpt.c b/drivers/bootcount/bootcount-gpt.c
> @@ -0,0 +1,140 @@
> +static int bootcount_gpt_get(struct udevice *dev, u32 *val)
> +{
> +     struct bootcount_gpt_priv *priv = dev_get_priv(dev);
> +     int rc;
> +
> +     if (!priv->blk_desc) {
> +             rc = bootcount_gpt_find(dev);
> +             if (rc < 0)
> +                     return rc;
> +     }
> +
> +     rc = read_disk_flags(priv->blk_desc, priv->partnum, (u16 *)val);

Not portable. read_disk_flags() writes 16 bits at the address; on
big-endian that lands in the high half of *val, and the other half is
left uninitialised either way. Please use a local u16, then *val =
local

> diff --git a/drivers/bootcount/bootcount-gpt.c b/drivers/bootcount/bootcount-gpt.c
> @@ -0,0 +1,140 @@
> +static int bootcount_gpt_set(struct udevice *dev, const u32 val)
> +{
> +     struct bootcount_gpt_priv *priv = dev_get_priv(dev);
> +     int rc;
> +
> +     if (!priv->blk_desc) {
> +             rc = bootcount_gpt_find(dev);
> +             if (rc < 0)
> +                     return rc;
> +     }
> +
> +     pr_debug("partnum %d: write GPT flags 0x%04x\n", priv->partnum, val);
> +
> +     rc = write_disk_flags(priv->blk_desc, priv->partnum, (u16)val);

The driver passes the raw 16 bits straight through but does not use
the cros_flags helpers added in patch 1. The standard generic path is
roughly:

   val = bootcount_load();
   bootcount_store(val + 1);

Against this driver, that increments the whole 16-bit attribute word,
so priority (bits 0..3), successful (bit 8) etc. all get clobbered the
moment the tries field overflows nibble 1. Either the get/set ops
should isolate the tries field via
cros_flags_get_tries()/cros_flags_set_tries(), or the commit message
needs to spell out that this driver is intended only for callers that
know the cgpt layout and that bootcount_inc()/bootcount_error() must
not be used (which is what patch 8 enforces). As it stands the
relationship between this driver and patch 1 is not obvious.

> diff --git a/drivers/bootcount/bootcount-gpt.c b/drivers/bootcount/bootcount-gpt.c
> @@ -0,0 +1,140 @@
> +static int bootcount_gpt_probe(struct udevice *dev)
> +{
> +     struct bootcount_gpt_priv *priv = dev_get_priv(dev);
> +     const char *str;
> +     int uclass_id, devnum;
> +
> +     str = dev_read_string(dev, 'device-type');
> +     if (!str)
> +             return -ENOSYS;
> +
> +     uclass_id = uclass_get_by_name(str);
> +     if (uclass_id == UCLASS_INVALID)
> +             return -ENOSYS;
> +
> +     devnum = dev_read_s32_default(dev, 'devnum', 0);
> +     if (devnum < 0)
> +             return -ENOSYS;
> +
> +     str = dev_read_string(dev, 'partition-name');
> +     if (!str)
> +             return -ENOSYS;

Please move the DT parsing into an of_to_plat() callback (and a plat
struct), matching bootcount-syscon and the rest of DM. Also -ENOSYS is
the wrong errno for missing/invalid DT properties - use -EINVAL.
dev_err() rather than pr_err()/pr_warn() throughout would identify
which bootcount device is complaining.

> diff --git a/drivers/bootcount/bootcount-gpt.c b/drivers/bootcount/bootcount-gpt.c
> @@ -0,0 +1,140 @@
> +     if (info.bootable & PART_BOOTABLE) {
> +             pr_warn("partition %s: legacy boot flag enabled, no GPT accounting\n",
> +                     priv->partition_name);
> +             return -EPERM;
> +     }

Why does the legacy-BIOS bootable bit disqualify the partition from
holding a counter in the top 16 bits of attributes? Those bits are
independent of bit 2. If there is a real reason please put it in a
comment; otherwise drop the check. Also -EPERM reads oddly here.

> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> @@ -171,6 +171,13 @@ config DM_BOOTCOUNT_ZYNQMP
> +config DM_BOOTCOUNT_GPT
> +     bool "Support GPT PTE-backed boot counter"
> +     depends on EFI_PARTITION
> +     help
> +       Add support for maintaining boot count within bits 48:63 of GUID
> +       partition table entry attributes (similarly to ChromiumOS).

The commit message could explain the motivation (why GPT, why bits
48:63, relationship to the cgpt layout) rather than restating the
subject line.

> diff --git a/drivers/bootcount/bootcount-gpt.c b/drivers/bootcount/bootcount-gpt.c
> @@ -0,0 +1,140 @@
> +     priv->blk_desc = dev_get_uclass_plat(bdev);
> +     priv->partnum = partnum;
> +
> +     return 0;
> +}

blk_desc and partnum are cached on first get/set and never refreshed.
If the underlying block device is re-probed (or the disk
re-partitioned) the driver keeps using a stale descriptor. At minimum
worth a comment; ideally a .remove that clears the cache, or simply
re-resolve on every call since this is not a hot path.

Regards,
Simon
