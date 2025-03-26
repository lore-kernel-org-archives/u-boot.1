Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DF7C3600D
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 07:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84E8808B6;
	Wed, 26 Mar 2025 08:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IplbCds4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19A1809D0; Wed, 26 Mar 2025 08:29:42 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E5A8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 08:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso4463883276.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742974179; x=1743578979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZ2vu9jYCdalws2pkegrUFqXzNEyNnS0VHHzJu4eG24=;
 b=IplbCds4wyuhKq0Z4MC1BhZESWjK2UXSxrm6w2IR4DFQqu8dATgZx7gK7Vl5/DU3k4
 E/dom7E8SAO9xeihFy5V4QggOeMQh5omAxlWzB3hOyhYsRTZZC5Xh/Z+Oe17Ityne2ZW
 4KgF82QdHkNYGesp1opGtQeg9lD42O8FCUjhqJDTqqFgz5tnHyKwfAR5VclcyRh6pFid
 u6LkvrtKp2+li9qIwOGO+6vMSBQWrKeyEUYfwa9VAOlUVGZZ8fpqCBlPqlXc/eVM/TaU
 xzKQT7yrKMifJ0f8qeNY5m7FXNBI15Jhzy5h0UmqEneZ48eOZ2tSqLGtZmN8GGyDG25F
 f0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974179; x=1743578979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZ2vu9jYCdalws2pkegrUFqXzNEyNnS0VHHzJu4eG24=;
 b=T9RTnzSJr6cuWTFzOkxJ3EAvNQQs7nTyMxB+9HqYEWaJRLdEjk3hCNykYm2ldklKaR
 +NjN4aZhqQSE43qt7lQiNncwGrtKsyGTh+aK1ORMPy7YhPxbpuZvy+2YvQTICFZyI0qX
 hGqKsc+aZunAFWgPwzMHAV3a1qXgZhbcgM+kALaIeAI1HJhCPbC/LOVaJ5oTrkJgpBOS
 Kk66OT76zs/rHayS/E6jEwlFPr1pu1pVAQlVHA5WcXNm11TnLdQ9L1Gm9PwUnAa+UiJU
 B/tWilUhI7gMS5nlsGzKdY0og3KeInguJDQ6oQNGFYhuLXygYtIUfKiyh7oQvftaLoaw
 Hj2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6mCkqmtQC0Zbxe4panAwtsl+z3MhrlDXqaE7RniQo7T9wtcNF5paIgLhn+0zedrkdVEfAwgE=@lists.denx.de
X-Gm-Message-State: AOJu0YzaAZQJ5no4TZy4QlGXG6FTpzP2BihA5h1kCfuidshKks1FNJGy
 fNmur4DLogIfPdtLrPnAhNX0zhp40L4x4ZCfNb1AOke4f0vFhYoWMcnGwWc9gHKabtU/Jl5At+q
 +1BrYEe2isErRGKTBrqFdU557KTRxekU9/850uA==
X-Gm-Gg: ASbGncsQw6BIPu3RlyPaC+EpEqZHfE6BLadUdWLZsqHoIfSw4umy3Fk6/YUXIUD8tbR
 xHdkncYcaNNkXyQTEmqr0xATNdGGqTdL/VjXIydNADWYrJQEUyAE0ktH2lDoZVKAOx7g5fYIDQf
 XL7NbM4AIvdD0Uhk+E3UWxzndwDh6sRzrxEN61Ng==
X-Google-Smtp-Source: AGHT+IEInQXp8LU+0yJRzLrUJ2CCVLtmitgVickgf0IdiIMNi8p5B1KvCjkf1P8gnIrtbfLk18ry3tQmpoI7hJBCGxw=
X-Received: by 2002:a05:6902:e0b:b0:e60:8a06:1ddd with SMTP id
 3f1490d57ef6-e66a4fa4ff7mr22598897276.36.1742974179337; Wed, 26 Mar 2025
 00:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
 <20250321232121.251800-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250321232121.251800-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 09:29:03 +0200
X-Gm-Features: AQ5f1JqyskSubidRQYEluj8S5F0i_7cZs9YeePCrwuDBEdH5G_7AF2FiwT8RfC4
Message-ID: <CAC_iWjJJeqJ5k3GHx4aDRroMgDg6EeNEWgiEcGz1WZcmHU5JDw@mail.gmail.com>
Subject: Re: [PATCH 1/5] acpi: new function acpi_update_checksum()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
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

On Sat, 22 Mar 2025 at 01:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Introduce a new function to update ACPI table headers.
> This allows to simplify the existing code.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  include/acpi/acpi_table.h | 7 +++++++
>  lib/acpi/acpi.c           | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index b8b1f1338c6..f8e5f552ab1 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -1274,6 +1274,13 @@ ulong write_acpi_tables(ulong start);
>   */
>  struct acpi_table_header *acpi_find_table(const char *sig);
>
> +/**
> + * acpi_update_checksum() - update ACPI table checksum
> + *
> + * @header - header of an ACPI table
> + */
> +void acpi_update_checksum(struct acpi_table_header *header);
> +
>  #endif /* !__ACPI__*/
>
>  #include <asm/acpi_table.h>
> diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
> index f4d5c1e25d0..596301a43fe 100644
> --- a/lib/acpi/acpi.c
> +++ b/lib/acpi/acpi.c
> @@ -6,11 +6,18 @@
>   */
>
>  #include <mapmem.h>
> +#include <tables_csum.h>
>  #include <acpi/acpi_table.h>
>  #include <asm/global_data.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +void acpi_update_checksum(struct acpi_table_header *header)
> +{
> +       header->checksum = 0;
> +       header->checksum = table_compute_checksum(header, header->length);
> +}
> +
>  struct acpi_table_header *acpi_find_table(const char *sig)
>  {
>         struct acpi_rsdp *rsdp;
> --
> 2.48.1
>
