Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB64CDE00B
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D87847C8;
	Thu, 25 Jun 2026 16:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OdAcL790";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED86084956; Thu, 25 Jun 2026 16:36:45 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F3F84704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bebb72b845aso97263066b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 07:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782398203; cv=none;
 d=google.com; s=arc-20260327;
 b=JX9kglK76Oaiy3AudWYhNgoxTaTWI9vemq4Q3hAGZr24rzkyxuhU7+3JePt7tMPjOZ
 1Ft/OdqoKAdofAB5n8d7qS27ootvZpE+TA8b7v46TFgEdyS0CXGajB2fRp1OKjbL2tmL
 Loo1wnYIVYPXYEZtA2fqKi2qI1s5C6GhAwKaMkB/Zn8TQC+yAA1khS/gTUvR9il6aIWY
 TJuKsJLlRZRLCpwyQEAjB6PytWaPewGATA1nCYjc/Sdu9CriyeMBamB574XbofcDAJXa
 Wk4x+6YF18ReSWITMWjfZanY4M1IwRyhpkkKs0aeR7LpzS5fEx2VwzDRyXJqGITaTQw1
 tTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ypHiuOTijGqJWmOeLM9iT0jcf7Ilw7Th22La9yX0IlE=;
 fh=ap3JSCHKFlQxe3PRZHqNaZKWCMHl64M2z/wxOe58JVc=;
 b=LCMt9oIsfmTAQIfUmFyh0jk+qMF7YwxM2UMFRVsrGfb6hGHyzBM/GG0qmG/NAEwhoG
 V2BLt6+8Lj92Z+9fAICjN33QyeZKC1X/I7kGAwwUgYHNcnA03oU+PXa4MM6QgVSgfe6I
 SKvJZRKNU7sXHVbg1d+t46LxL8mjKM97V/5+tdDmW/Un+95/4BOPK3HTS9z4Jci0vNgX
 bgzCLChlWgMeAmUkJfLfww3JVMMDk1rc62FDgE5YaOX1xh9TMhgBqCFleg8pJRlZjpQO
 f+3J5Ohalc8F15WS6u8qBU9FBpf9dVw4K5N3vJu56NUJ5H8ZoRfuXvN1d2AmgnPBpzK4
 rSxQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782398203; x=1783003003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ypHiuOTijGqJWmOeLM9iT0jcf7Ilw7Th22La9yX0IlE=;
 b=OdAcL790u7KQn8HB7+S2/JNy6Huz+rKhxEv7Pby4k0laXNJyfiZdL5YaskS/2tsCrX
 FdzakzTLtesSZ21HMA2RfaBu2HPCoHS+rgnr342QVxy0x1dItFajqmb/v0qrqnFlj1Cu
 7iEk2aqk66XcARWjnMy4hYeEci+yOEMoP467Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398203; x=1783003003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypHiuOTijGqJWmOeLM9iT0jcf7Ilw7Th22La9yX0IlE=;
 b=s6w9eHraXADfpzhmCG9tTV7Ff6ULumEtl23GsTfrorn8VVE8rQJT9O/1P7QnYgrL5T
 zAmmJv7Jhi4A3NWlmXUaTMlaaYZm5D98R9BUknFl0buvyJBTkf4c77XUmFKNkKO1yWJQ
 +WA59IcwBx1P9vmppRa1yyy46aLSh6hCdNYWw3NP8TCm/GIvFCKif9zEhWuniObSR4VD
 1lDfTAerZt7Whg6WmBMmb6v+2UjER1Iw0iQ6q+1jMOhn+v9tFhEix/UgYei3FZsqbS4L
 kEJeAcJH8Nik8ajh/fK2iA+JTAFshCVYTcPA/7HZBQoygERP3rQOyjC1GgYk9vSAe9/8
 6jhA==
X-Gm-Message-State: AOJu0Yw0y6BS2BNcdeWuJty/0M2jjkexEPIBc+NhFXX2WVkxLmc0SsCB
 sXuxax9+ySA2rFoqhU6FiTq6Jvktjnr/uajTMgB2DZMCGBf+nREOR/J9wsjz1mpv1wgxzx0W3EX
 UFFFoQkwkECKk/R8dhkrWm+kY+xwhE+49CfSW8sat
X-Gm-Gg: AfdE7cnHDUksEzDDILEGI/e30MebRrN3mCgYpYMr8chVEk6TXFUnmrVSCR96vdn1z3v
 gxYUv/aTHDMjyeXFlTYBVcZ9Zoq0Xp2aG+jKOYmP8qvP7vZxTHEUEaFEBIIvGBQFPsW046AdL0O
 EsTm5a7GuDxi/0y54pC/c8yolItUObg017i3XeTkl+o+OtZojgMB2BlzDOrQ+CxOhg9nHK86uQE
 tYxTE7DtyFR7V6D7sUh4i9Jk/VDm4SbFD3wvc2p8/xofmoCd+Ca4SHyulO5HYJrAr0gQ3azbQ==
X-Received: by 2002:a17:906:ef06:b0:c0c:9f16:90df with SMTP id
 a640c23a62f3a-c1205d8c0a1mr222783366b.13.1782398203235; Thu, 25 Jun 2026
 07:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260614103232.3586246-1-yordy1902@gmail.com>
In-Reply-To: <20260614103232.3586246-1-yordy1902@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 15:36:31 +0100
X-Gm-Features: AVVi8CfVT5wvfX8hxdxGjbquBn-39YTa2Kd2OgHfRo-Vnx_s6DpfXPc9K-dOOMU
Message-ID: <CAFLszTixG59bQQEsYU0nR=oLdvjHSRcy+4CUpEcR6ZWBAJGh_A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: single: parse gpio-range as a raw array (O(N^2)
 -> O(N))
To: yordy1902@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 vigneshr@ti.com, nm@ti.com
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

Hi Jordi,

On 2026-06-14T10:32:32, Jordi Trepat Mur <yordy1902@gmail.com> wrote:
> pinctrl: single: parse gpio-range as a raw array (O(N^2) -> O(N))
>
> single_add_gpio_func() calls ofnode_parse_phandle_with_args() once per
> gpio-range entry. With a flat device tree, every call re-iterates the
> property from index 0 and, because cellname is set, performs an
> fdt_node_offset_by_phandle() (a full-FDT scan) at every step. The total
> cost is therefore quadratic in the number of entries and proportional
> to the size of the device tree.
>
> On a TI J722S board this makes the pinctrl probe take 723 ms
> pre-relocation (caches off) for only 7 entries; with this change it
> takes 22 ms (-97%). Any pinctrl-single user with a populated
> pinctrl-single,gpio-range property pays this cost.
>
> Read the property once with ofnode_get_property() and iterate over the
> raw cells in memory instead. The phandle target node is never used by
> this function (only the three argument cells are stored), so resolve
> only the first entry with ofnode_parse_phandle_with_args() to validate
> the cell layout. Empty entries (phandle == 0) are skipped, matching the
> previous behaviour.
> [...]
>
> drivers/pinctrl/pinctrl-single.c | 62 +++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 14 deletions(-)

> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> @@ -511,27 +511,61 @@ static int single_add_gpio_func(struct udevice *dev)
> +             if (phandle_i == 0) {
> +                     /* empty entry - match original: skip without creating range */
> +                     continue;
> +             }

Not quite. ofnode_parse_phandle_with_args() returns an error for a
zero phandle, and the old loop treats any error as end-of-list and
breaks. So phandle == 0 used to terminate the scan; now it is silently
skipped. Either restore the break, or call out the behaviour change in
the commit message and update the comment.

> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> @@ -511,27 +511,61 @@ static int single_add_gpio_func(struct udevice *dev)
> +     if (gpiospec.args_count != 3) {
> +             dev_err(dev, "expected 3 gpio-range args/entry, got %d\n",
> +                     gpiospec.args_count);
> +             return -EINVAL;
> +     }
> +     cells_per_entry = 1 + gpiospec.args_count;      /* phandle + args */
> +     if (total_cells % cells_per_entry) {
> +             dev_err(dev, "gpio-range size %d cells not multiple of %d\n",
> +                     total_cells, cells_per_entry);
> +             return -EINVAL;
> +     }

These two turn a silent no-op (return 0) into a hard probe failure.
args_count is already pinned by #pinctrl-single,gpio-range-cells, and
the size-mismatch case did not exist as an error path before. Please
either keep the lenient behaviour (warn and return 0) or justify the
stricter validation in the commit message.

> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> @@ -511,27 +511,61 @@ static int single_add_gpio_func(struct udevice *dev)
> +     const __be32 *list;
> +     int size, total_cells, cells_per_entry, entries, ret, i;

Did you consider ofnode_read_u32_array() (or reading into a small u32
buffer) instead of open-coding the __be32 walk with be32_to_cpup() ?

> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> @@ -511,27 +511,61 @@ static int single_add_gpio_func(struct udevice *dev)
> +     int ret_total = 0;
...
> -                     ret = -ENOMEM;
> +                     ret_total = -ENOMEM;
>                       break;

The ret/ret_total split is unnecessary - by the time you enter the
loop the earlier ret has been consumed. Just reuse ret.

> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> @@ -511,27 +511,61 @@ static int single_add_gpio_func(struct udevice *dev)
> +             range->offset   = be32_to_cpup(entry + 1);
> +             range->npins    = be32_to_cpup(entry + 2);
> +             range->gpiofunc = be32_to_cpup(entry + 3);

Please drop the extra spacing - single space after the field name, as
in the rest of the file.

+1 to Anshui's suggestion of avoiding alloc. You can create a
variable-length local var, for example.

Is every entry in the 'propname' property always for the same device?
I might be a bit confused, but I am not sure where that is required in
the schema.

Regards,
Simon
