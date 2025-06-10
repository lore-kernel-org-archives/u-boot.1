Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9DAC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B31E8070C;
	Tue, 10 Jun 2025 09:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vje+C07/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AF280C83; Tue, 10 Jun 2025 09:27:31 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF14805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ff4faf858cso33654327b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749540448; x=1750145248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OiVsGGKUOnwR24eMALg7R510Hx/lGkhVs4JtyYc5p7s=;
 b=Vje+C07/Fl/DGZbCDav3cd9V7x1JA4+ck7hTpIooX16zpxmoUgR6vGGINHtz/DZI7b
 v5/Q/IiSspf9B5XtxlDJzRFEuoVbBUH9jn2/+JkPqA3aBRHrr7vup917hNUzs2N/2iXx
 eIml18KTu+eat9KYm39snttrM0c5j7zWb9V1l6j5zjIxyr9k95QAP0uOSM2440b0WdsK
 xf/cV+fnSJEXcoTvniPOigk/EZsnODfaJCuOQ4YmLpiSXRQeHijM/A1IoxNE+teV/b0y
 SqFwtdEUu8w+r4XxtWNU5cRZwr1NxYXUXAXgpdXmKUmGaBQ6ihibslMFOAcWf4zGTyE3
 VvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749540448; x=1750145248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiVsGGKUOnwR24eMALg7R510Hx/lGkhVs4JtyYc5p7s=;
 b=jDsh765FNRv20qIuGkL46hU8BoMDQ25ONORMgBIjb3otbwts4YE8j+GESBOFE8HJ4L
 u+MQn7dDTAKN4yB6nggQqjLY0a2T+UFAbPCXSCElTE5CMMjr0N5UbwGjaQZAGJWgMUuN
 voG/MiJlt28G6RyEkh57uAwohqEH55Gbpoynyi8BGzy/YYyskikCnWnAxbAchnXS5e3I
 Yl7WLoB69BwSamAArRVKwtKPxeX/LRA8XnKsDpPU4ypSrN9xdkHhTJS2ORBPc9aMZzzu
 rS0PLnFcRsnxQ9MMGnfN7IJ1xC0SHzC5RUV9qTfQ/XEgWbeKY6DGpLon4Bq1hx300Ohv
 Rh6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCp8UAWh5EfAAcB55LkRPFuJjlZtOr4x7pbFcIZ81Xj4pS4dijJ4NHSuRJGAMIvWS4t1nm6uA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj5PVrTH1No6QTMaXWLNRW3DiIkpwE6lXlcIZAkUt0rH6piDT5
 BDV5NviTfweA5wEFF79w0ljuPNO3ajxcR6xtZA6odf9sTemURSqIHDYIQEmzp53TZwGyYcgCb3k
 9LqTnf8GTOjbD/4H3o4zwmm0vzNllny1u+t951e5yLA==
X-Gm-Gg: ASbGncvxu4H3paI6CSyRhcC8PI2YDABP0jrKUU42iUTgU717GOzUwlbmc/cvoTrXYfS
 hRbJ+z7ghD/s8ODsuXz77hR6fL5wFYhw1YkqxBKhRRgfBgBlYmNzQjM8JKeredKhvVJSxMtWaxY
 1gx9owYaiYp567i4PeCo5n4igAcPj9G6RfONBk6g6HD9Nn
X-Google-Smtp-Source: AGHT+IG8PsBPF0NK6fSK0cvLjayAU2+y7zqOF9kDlFhLpTonZxBXe/ob6HlOnZaVknrtn+A6Nun3gW+vcvTLC+nKUEo=
X-Received: by 2002:a05:690c:670d:b0:70d:ed5d:b4b4 with SMTP id
 00721157ae682-710f772fc81mr227793857b3.24.1749540448359; Tue, 10 Jun 2025
 00:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
 <20250608075428.32631-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250608075428.32631-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:26:52 +0300
X-Gm-Features: AX0GCFsaXcJME4X3KcUb5cvaBhA_x27rKHiD6T3VAFgTXEGCpss8fPso9EHbyD4
Message-ID: <CAC_iWjJxANsseUR4jP-N_qfwyF0pQVZVgSiAEQa_uyV4fLJG4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test: unit test for efi_alloc_aligned_pages()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Sun, 8 Jun 2025 at 10:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide unit tests for efi_alloc_aligned_pages() and
> efi_allocate_pages().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> v2:
>         no change
> ---
>  test/lib/Makefile     |  2 +-
>  test/lib/efi_memory.c | 63 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 1 deletion(-)
>  create mode 100644 test/lib/efi_memory.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index ff4ff63270d..35b40b584c4 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -8,7 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
>  ifeq ($(CONFIG_XPL_BUILD),)
>  obj-y += abuf.o
>  obj-y += alist.o
> -obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
> +obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
>  obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
>  obj-y += hexdump.o
>  obj-$(CONFIG_SANDBOX) += kconfig.o
> diff --git a/test/lib/efi_memory.c b/test/lib/efi_memory.c
> new file mode 100644
> index 00000000000..d2e1ab6b4a3
> --- /dev/null
> +++ b/test/lib/efi_memory.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Test memory functions
> + *
> + * Copyright (c) 2025 Heinrich Schuchardt <xypron.glpk@gmx.de>
> + */
> +
> +#include <efi_loader.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +static int lib_test_efi_alloc_aligned_pages(struct unit_test_state *uts)
> +{
> +       efi_status_t ret;
> +
> +       void *addr;
> +       unsigned long align = 0x400000;
> +
> +       addr = efi_alloc_aligned_pages(4096, EFI_PERSISTENT_MEMORY_TYPE,
> +                                      EFI_PAGE_SIZE);
> +       ut_asserteq_ptr(NULL, addr);
> +
> +       addr = efi_alloc_aligned_pages(4096, 0x6FFFFFFF, EFI_PAGE_SIZE);
> +       ut_asserteq_ptr(NULL, addr);
> +
> +       align = 0x200;
> +       addr = efi_alloc_aligned_pages(4096, EFI_ACPI_RECLAIM_MEMORY, align);
> +       ut_assertnonnull(addr);
> +       ut_asserteq_64(0, (uintptr_t)addr & (align - 1));
> +
> +       ret = efi_free_pages((uintptr_t) addr, 1);
> +       ut_asserteq_64(ret, EFI_SUCCESS);
> +
> +       align = 0x400000;
> +       addr = efi_alloc_aligned_pages(4096, EFI_ACPI_RECLAIM_MEMORY, align);
> +       ut_assertnonnull(addr);
> +       ut_asserteq_64(0, (uintptr_t)addr & (align - 1));
> +
> +       ret = efi_free_pages((uintptr_t) addr, 1);
> +       ut_asserteq_64(ret, EFI_SUCCESS);
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_alloc_aligned_pages, 0);
> +
> +static int lib_test_efi_allocate_pages(struct unit_test_state *uts)
> +{
> +       efi_status_t ret;
> +       u64 memory;
> +
> +       ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +                                EFI_ACPI_RECLAIM_MEMORY,
> +                                1, &memory);
> +       ut_asserteq_64(ret, EFI_SUCCESS);
> +       ut_asserteq_64(0, memory & EFI_PAGE_MASK);
> +
> +       ret = efi_free_pages(memory, 1);
> +       ut_asserteq_64(ret, EFI_SUCCESS);
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_allocate_pages, 0);
> --
> 2.48.1
>
