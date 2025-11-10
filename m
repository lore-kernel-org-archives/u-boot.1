Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734EBCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 11:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FC6839A5;
	Mon, 10 Nov 2025 12:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IAQy8gxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49090839F1; Mon, 10 Nov 2025 12:55:00 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B50683980
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63fbed0f71aso2356149d50.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775697; x=1763380497; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MmeBq5FS25inSoWYQgK+mqJHgkmRkQ+VzvSmAYMtbBs=;
 b=IAQy8gxPo8ZsEnq5Z0iFCdvZjpCDVpuQICNtoV/EjBTn6uF3MM9AO8SrG/HJ4Wr8XV
 NbaO3AFRVkSkOjJR51c4P+upUbxSA8hsE48yxARdIHkKni3NCqa9eQ+2Y9z9xaeBRNwr
 WwPDn3E0vlAEf8kBsmo6+SI4aHEgerIgsio1pRQPlZxm9rzDd5UEMwS8t5wKWqqMRQD8
 4NFZmIWrPTyW+cZ7r+gpGmOlc/rVOETd22B/S69eCobI9MOY/dzVJBxcUzNvk9hpvhvE
 cTtMr+XDkuCHvaYnoDD8V6X49qxnOebRbsMxcKISyN9mprELYLK5Qu214PFySiMn6P6J
 PrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775697; x=1763380497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmeBq5FS25inSoWYQgK+mqJHgkmRkQ+VzvSmAYMtbBs=;
 b=Vekk+djicZ06LLkrt0TZNTOVlMaFu5RoH+RvTRUxyTiREuE26BUuNQSUcKiaBtwQBP
 wu3VV09C5oosSRA7p1wnyoyxGfdjiISQ9bY7gj4IoHMtmqs5PT7FdBxB7xHXGaoIj87f
 WA5YsLhkq++C46xgtR1j93Hvioyq/A8ufk3IOCc7lVcjaQFFkG5mWoKeyXa7yAdLT7Zf
 YeV/xH4pb1hc0VDxU0HEaLdKw65QXP/SKfGMwKaRlYIJkV9tFaVFfqVCaUXTgVXGNMlP
 qRzI98OpQ4bGnJr7bVsl0PNQalT9CPD6psxt3SkvQaeEdBdtnjwD9KVdv9L/Ua7Lp3pB
 gQgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZeITVt1EnJFGabNHXMGGtAlktOEHpPfbobwLY1rXjzE3bmQjpoteGj20R3zjV9B60mo3s8qk=@lists.denx.de
X-Gm-Message-State: AOJu0YxYo7D82jOKHWBez5t9yJjDopDHNT5XQ9hfnOUI3sWAk8P/lx5C
 cslYadfnp37c1L+GcTXBjRwgUuowhxnUrhgYf0KqVIM8qOa/9eGR+KXeTQ/+xLBQpCibxvjYp19
 kWmSuICacNyliHiMvY/6VOX5IaeMxDsjJeHTJKttbyA==
X-Gm-Gg: ASbGncuFHM6EKKF9v4CNxYOW+g9g7JyF0D3+n4e8FUtTXE5LRqaaWb7UWwSxOlWpghy
 UtH7YdLQco8n0gcH7l6jVyVeo8i8kBshNlo/shN34jLtW/J7K9mD0OoTrjwq122VYnNHo6nj6tL
 h6lU+yUE+qmt6ZO2yhpv1LqiAOUY80m+usZlDD2p1hHj9RsfOwiw0EJxmblxvoA9kD7lFOvPSer
 3dYx1YVDv6NOwjvveYBmQoCwaN5pekGIdznc9CXiKuS+RaUogOW4wtIwOJzfEnSJV2bdKZKRocG
 wkqk0u2puaMs3HZH74+PMrm2JhoiXqfKP8M/C3Gr
X-Google-Smtp-Source: AGHT+IEeIQVu5NHtvQYkozIWXxQGGES8pDDHGpvGmOSF4CIl/mfxgTq94mbF8j68RsmY5b4PpbUOv6tAvwITfWKImg8=
X-Received: by 2002:a05:690e:d58:b0:640:db91:33c4 with SMTP id
 956f58d0204a3-640db915665mr4806333d50.18.1762775696826; Mon, 10 Nov 2025
 03:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031195931.622513-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Nov 2025 13:54:21 +0200
X-Gm-Features: AWmQ_bkRC8TyJ6tEEVBtD0L0QVyuRK77u23nU2r2pXFNeDlppFZ6h0eXB47yo6I
Message-ID: <CAC_iWj+TxAxc2SE9ffekhCf0Td8EQEzsjH2TNgWNXhkZrXXAwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] test: provide test for 'acpi list' command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
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

On Fri, 31 Oct 2025 at 21:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Check that some mandatory ACPI tables exist:
>
>   - RSDP
>   - RSDT or XSDT
>   - FADT
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  test/cmd/Makefile |  3 +++
>  test/cmd/acpi.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 test/cmd/acpi.c
>
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index e71c80a5b2e..ae545b03b79 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -13,6 +13,9 @@ endif
>  obj-y += exit.o
>  obj-$(CONFIG_X86) += cpuid.o msr.o
>  obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
> +ifdef CONFIG_CONSOLE_RECORD
> +obj-$(CONFIG_CMD_ACPI) += acpi.o
> +endif
>  obj-$(CONFIG_CMD_BDI) += bdinfo.o
>  obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
>  obj-$(CONFIG_CMD_FDT) += fdt.o
> diff --git a/test/cmd/acpi.c b/test/cmd/acpi.c
> new file mode 100644
> index 00000000000..ae6157d3d56
> --- /dev/null
> +++ b/test/cmd/acpi.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Tests for acpi command
> + */
> +
> +#include <linux/bitops.h>
> +#include <test/cmd.h>
> +#include <test/ut.h>
> +
> +#define HAVE_RSDP BIT(0)
> +#define HAVE_XSDT BIT(1)
> +#define HAVE_FADT BIT(2)
> +#define HAVE_ALL (HAVE_RSDP | HAVE_XSDT | HAVE_FADT)
> +
> +/**
> + * cmd_test_acpi() - test the acpi command
> + */
> +static int cmd_test_acpi(struct unit_test_state *uts)
> +{
> +       unsigned int actual = 0;
> +       int ret;
> +
> +       /*
> +        * Check that some mandatory ACPI tables exist:
> +        * - RSDP
> +        * - RSDT or XSDT
> +        * - FADT
> +        */
> +       ut_assertok(run_commandf("acpi list"));
> +       ut_assert_nextline("Name              Base   Size  Detail");
> +       ut_assert_nextline("----  ----------------  -----  ----------------------------");
> +       for (;;) {
> +               ret = console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +               if (ret == -ENOENT) {
> +                       ut_asserteq(HAVE_ALL, actual);
> +
> +                       return 0;
> +               }
> +               if (ret < 0)
> +                       ut_asserteq(0, ret);
> +
> +               if (!strncmp("RSDP", uts->actual_str, 4))
> +                       actual |= HAVE_RSDP;
> +               else if (!strncmp("RSDT", uts->actual_str, 4))
> +                       actual |= HAVE_XSDT;
> +               else if (!strncmp("XSDT", uts->actual_str, 4))
> +                       actual |= HAVE_XSDT;
> +               else if (!strncmp("FACP", uts->actual_str, 4))
> +                       actual |= HAVE_FADT;
> +       }
> +}
> +CMD_TEST(cmd_test_acpi, UTF_CONSOLE);
> --
> 2.51.0
>
