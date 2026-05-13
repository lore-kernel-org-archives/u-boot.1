Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521AACD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 16:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A81836AC;
	Wed, 13 May 2026 18:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZoQf9bNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA51883EF9; Wed, 13 May 2026 18:35:02 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544AC80F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd3d7c29b4dso158387566b.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690099; cv=none;
 d=google.com; s=arc-20240605;
 b=K/k2o/EX3t6MggztkrYRFSFIf6BWQdIrEjVS4SOklTwJKhlx2TtD3ICStaMczp/ous
 6CJ7xLaK3uS8iBoKsw7tXKgdwzC3MQwMTFNv94GO0rJODvcy6oxnsjTw1x8GaBt+APqs
 VonAKUsvDpKt9wtlWAdDMGNxLrw+O9f/ONwbp+2SpiFtkd4nLsbNjkPaqq0ueLDVqUZ0
 IiotFCGvyQ54Nz+epfHQOS9FTG1lZgPIlp3KqcnS7xhRh6niBL5vWHS9wdk2AWSIcDhn
 alNzawH2DXq4Cyi31fD7EJRUdwJNOt/9lZR4+Gs50fjZH+Wif9iy3GtiB8UEvLVuuK1i
 Y3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W9oNXVJXjcNVvJcFaGx1SNvKPcBSfAkDSRND8piDANQ=;
 fh=v6gdkGcUJpUpHa/R0oOi3ebuX33ZRHzAFtOCHgAuhq8=;
 b=hiHU9Kjrqk3KsE4QZ0kGhgLJmvXlW/gpxZwQs8d8v7ppGjxvu4eVVfAJAIv0foEvcn
 SPeUadQqvQ0IGUl/4j6KD0BN4xKKEQPYUsOL4n++CbHFE1hRLgpe/WtTovqzD6xQBtBh
 vT41e1dOIr+8a2taxnp++mpMKJCvX0uJuPlLwNv3kCYI9/xYeKgtydrIgIzhbzuq548B
 0hnpTPJKhqtDSB3vgLdN5EC7SJdUcGP8bbdE58o09UeGG5DoKD/s4YOvOINy3rbuyr/X
 R3fuuNjpdtrqee74ylKxaTjJnjiFmSRuNV1MbBMBblz7GXHJndgAdsH3FVg4E9uAlVDG
 VQ0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778690099; x=1779294899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W9oNXVJXjcNVvJcFaGx1SNvKPcBSfAkDSRND8piDANQ=;
 b=ZoQf9bNv1tE0jAMLyoKhzP2Uun6lxysDuaJooX5kk5ZUOXPOZ+nk4E+7TYBIxy7UkB
 CDxSeDu7DuFSw/6SFyD4g5vTqnm2KmETZKIs/wOvryVcyohkBBnACU3X70dB/RuDCF1B
 jN/5kdufIXd7qiz4dPjgLhJ3R1KDesVQTc+vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778690099; x=1779294899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9oNXVJXjcNVvJcFaGx1SNvKPcBSfAkDSRND8piDANQ=;
 b=e8sXS8OW4+fu+aUQxJ+qaPrAF2msMgcb3Tli9AEe27zl3+jK/fC3pgOhz2oLYNUY06
 fpGgSmotgzUitc6owe8Jk5rUQLHeVwuy2TP8KBnJjOt8ZBB7xY1HxtCKeRJ2EABOt+pA
 bwcP271P88pPwg+lJezRAP6QLjSUBWQQVke+SMgqWfXNWVMJaRslsJokCD552g9XjRyF
 dNN/NpXJ8TqskdHLSyJobEKCpdSEC22++Fe15gjMi0+Rj0CFJAf0slFfLBwwLdUM+WWL
 NRltDZprqH4gAdhJKcEOsaZY5VabOSrqM7mKCmslU9LDgSYmltSAsd9dU2YokF2lNrGU
 UpyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+In2aR4qZ3ABKNwDUv1LvVglcL5NeIIQSx+hsRnfaXDBiaL+UQSx9AkGGmf6NHGbQpZ4NqF5c=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz27+BZBmLktemPRCU2Ti+hEFqLIllGLgWsnvJt48xSe06OB5v
 xpcPaCsdcWzEiZqxXU58zjwFl6icVN8bugcXrY/LZagN9gkxfBXVOalZX41iWb6UirrKclPu1OC
 x/HYQX8lfYOJ2KZP1gBo++BoDiFVDVkGfRsVBiOoj
X-Gm-Gg: Acq92OE6g1ZI3ZDcTIEvmUL01y5Ihc6GEh7TAKsqJHJM0bB2Pjy4Xuu7lSvaONQmtpz
 Z2qmn0kBANN+NVQywWbUP7BwvsU5Tu38U5FzoSDRkSM24i2+bnwpqeREvMr2hQWABD0k84Ieph+
 FqrA9WQxPLmCwjpN04rs3Leq98cTVuem3WjQCORGuFhN5FpL0IMExN2SxzCDe9YKqVXgGaYRhN6
 JVbeqyAbMRLNluCkzl3+D6pzV6Eyl8ic8lxvG1dMg+lMRrL6se7OdA4lvP/xForW8e+Qt2lCRKe
 i9io5g==
X-Received: by 2002:a17:907:9455:b0:bcb:4eec:a879 with SMTP id
 a640c23a62f3a-bd3c1407256mr291596066b.34.1778690098588; Wed, 13 May 2026
 09:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260513015606.591384-1-rs@ti.com>
 <20260513015606.591384-3-rs@ti.com>
In-Reply-To: <20260513015606.591384-3-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 May 2026 10:34:42 -0600
X-Gm-Features: AVHnY4LnEpnQ8XspDY0ocJEgwetAPzlxglcc2xX2OTRXBIk7Kt5N0WGYxOVNhJI
Message-ID: <CAFLszTg+rP=UirpTzUZcg+qo0M2gY7T=BRxPfH=PV+aDSvnjHQ@mail.gmail.com>
Subject: Re: [PATCHv7 2/3] test: boot: add a fdt reserved region check
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
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

Hi Randolph,

On 2026-05-13T01:56:06, Randolph Sapp <rs@ti.com> wrote:
> test: boot: add a fdt reserved region check
>
> Add a image_fdt suite and a check for boot_fdt_add_mem_rsv_regions. This
> will ensure the user is properly informed of any reservation failures.
> It will also validate that reservations are cleaned up correctly when
> switching FDTs.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> test/boot/Makefile          |  1 +
>  test/boot/image_fdt.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c               |  2 ++
>  test/py/tests/test_suite.py |  2 +-
>  4 files changed, 57 insertions(+), 1 deletion(-)

Change log?

> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> @@ -0,0 +1,53 @@
> +#include <fdt_support.h>
> +#include <asm/global_data.h>
> +#include <config.h>
> +#include <image.h>
> +#include <lmb.h>
> +#include <malloc.h>
> +#include <test/test.h>
> +#include <test/ut.h>

Please sort these: config.h (if needed) first, then the plain
top-level headers alphabetically (fdt_support.h, image.h, lmb.h,
malloc.h), then asm/global_data.h, then test/*.

> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> @@ -0,0 +1,53 @@
> +#define FDTDEC_MAX_SIZE (2 * 1024 * 1024)
> +
> +#define IMAGE_FDT_TEST(_name, _flags) UNIT_TEST(_name, _flags, image_fdt)

FDTDEC_MAX_SIZE is never referenced - looks copied from
test/dm/fdtdec.c - please drop it.

> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> @@ -0,0 +1,53 @@
> +     /* Loading a new device tree should be allowed */
> +     blob = malloc(fdt_sz);
> +     ut_assertok_ptr(blob);
> +     memcpy(blob, gd->fdt_blob, fdt_sz);
> +
> +     nodeoffset = fdt_path_offset(blob, '/reserved-memory');
> +     ut_assertok(fdt_del_node(blob, nodeoffset));

If /reserved-memory is missing, fdt_path_offset() returns a negative
libfdt error and fdt_del_node() then fails with a confusing message.
Please ut_assert(nodeoffset >= 0) first.

Also, blob is malloc()'d but never freed.

> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> @@ -0,0 +1,53 @@
> +     boot_fdt_add_mem_rsv_regions(blob);
> +     ut_assert_console_end();
> +     boot_relocate_fdt((char **)&blob, &fdt_sz);
> +
> +     /* Reservation should not exist now */
> +     ut_asserteq(0, lmb_is_reserved_flags(start, LMB_NOMAP));

What is the boot_relocate_fdt() call testing - could you add a
comment? The reservation at start is already gone after
boot_fdt_add_mem_rsv_regions(blob), so the final ut_asserteq() does
not depend on it. It also allocates from LMB for the relocated copy,
which then leaks. I'd drop it, or split it into a separate test with
its own assertions. The (char **)&blob cast is a hint that the call
doesn't belong here.

> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> @@ -0,0 +1,53 @@
> +IMAGE_FDT_TEST(test_boot_fdt_add_mem_rsv_regions, UTF_LIVE_TREE | UTF_CONSOLE);

Just to check: the test only touches gd->fdt_blob (the flat tree), so
why UTF_LIVE_TREE? If you want it to run regardless of OF_LIVE, drop
the flag (or use UTF_FLAT_TREE). If the intent was to avoid running
twice, please mention that in a comment.

Regards,
Simon
