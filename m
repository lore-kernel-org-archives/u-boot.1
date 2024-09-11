Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A597EE4983
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A6D885A5;
	Wed, 11 Sep 2024 11:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HbBq8Qcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3761E89232; Wed, 11 Sep 2024 11:46:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2E988549
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so1129786a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726047965; x=1726652765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n5322mb/FrjIW1JXplp1MkpsiFd9OP32TqeA8Keonw4=;
 b=HbBq8QcbE7ahx8/Q4ekdUb6Hr1zKmG1tHtrY/Sk/HI4BEq8RKzYbADNgDA/jXtF3p/
 jmaNfBpwnSrKgELN/gI276UJL7IInKhrxuCaxbg65p46dm9gOC15pB/a2x5kl+wy9pnS
 sGe1Xhtl2jWB0E9Xz6JF4SnpGZa7PhrSDXS58jbyAwzVbpdYyCzfxniTh2A0N9lcM9yS
 WLHPj6ra7p53rZGYJW9gOQSrgz44I1WUFhFAvQJMzPruIRizi6VDoS+cUI/N9RJdhO04
 HuLJhEFVPI1rhRgIc1n/yuU/UwZJkcnOHEAcZYML3jcTgdhVTr3gZWAZfir1l8bnuQBy
 pOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047965; x=1726652765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5322mb/FrjIW1JXplp1MkpsiFd9OP32TqeA8Keonw4=;
 b=E68OEaJn50ULMiGRWNUHpWRYIXtJ/gQh0Er+xPl+rEFWSAHe6V4Ixlw9llX3f7Jgg0
 6yjWvK4PsU75zBSMLjtcXAbiCTnDvSFIf/WzXOHvwD1SsqXpXYEoUni71+eF3qohYLoG
 hyWTSi41edFyY/KMNsi+6aRszWGosAxm3BJtP4meiBNjln99FCk7u6oUD+UiBs9yP/L9
 vk0wm2Dt2hfjCAe7tFMzuNdEokyadURxFx9fQJRNLovK8bhsk3TUOuppcaCwNkMKVR3+
 TLrPtRQNu5z8DFg6MJ3+kjsQdG1N4mVxyXGCYWRen68cJukzkOFZb9JNsdLuqzwFq5AG
 Q5Kg==
X-Gm-Message-State: AOJu0Ywr3hFqR0D8qZexHAhH9j/yn+vFkKDOvZ6bD4nsvrac3ABCzkdN
 r1T74qktODAsDab44CXn/pjb9C9QErhpE5bbwbwjmCtUs8HnSRQ6Ntwcp40MNZrXetrKlHmBCc2
 Ydx+ObJnwcJQbXpQBH7eBA4o4Auc=
X-Google-Smtp-Source: AGHT+IH8IPBM/2XAsqsMgGDQilZxHYXXnqfh3GBiELIAn53wNk8QZdIHBBgy+I6s3HEoUUnE+AvuRsO6ksba2/5gADc=
X-Received: by 2002:a05:6402:5d2:b0:5c2:7699:92ef with SMTP id
 4fb4d7f45d1cf-5c4015ef7ddmr7650585a12.16.1726047963797; Wed, 11 Sep 2024
 02:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-14-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-14-patrick.rudolph@9elements.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Sep 2024 10:45:30 +0100
Message-ID: <CALeDE9O6fbvfjyqcd32vo6SYBy9OUm+xfz9DV7akiGRS9jGNCg@mail.gmail.com>
Subject: Re: [PATCH v3 13/30] acpi: acpi_table: Support ACPI 2.0 platforms
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

> On platforms that do not have usable DRAM below 4GiB, like QEMU sbsa,
> the RSDT cannot be used. Allow both RSDT and XSDT to be null and only
> fill those tables that are present in acpi_add_table().

I'm not sure what ACPI 2.0 from the subject has to do with the above,
eg ACPI only started supporting aarch64 with ACPI 5.1

> Fixes a crash on QEMU sbsa.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/acpi/acpi_table.c | 95 ++++++++++++++++++++++++++-----------------
>  1 file changed, 57 insertions(+), 38 deletions(-)
>
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index 4f5cfe522c..8aab41212a 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -157,51 +157,70 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
>         struct acpi_rsdt *rsdt;
>         struct acpi_xsdt *xsdt;
>
> -       /* The RSDT is mandatory while the XSDT is not */
> -       rsdt = ctx->rsdt;
> -
> -       /* This should always be MAX_ACPI_TABLES */
> -       entries_num = ARRAY_SIZE(rsdt->entry);
> -
> -       for (i = 0; i < entries_num; i++) {
> -               if (rsdt->entry[i] == 0)
> -                       break;
> -       }
> -
> -       if (i >= entries_num) {
> -               log_err("ACPI: Error: too many tables\n");
> -               return -E2BIG;
> -       }
> +       /* On legacy x86 platforms the RSDT is mandatory while the XSDT is not.
> +        * On other platforms there might be no memory below 4GiB, thus RSDT is NULL.
> +        */
> +       if (ctx->rsdt) {
> +               rsdt = ctx->rsdt;
>
> -       /* Add table to the RSDT */
> -       rsdt->entry[i] = nomap_to_sysmem(table);
> +               /* This should always be MAX_ACPI_TABLES */
> +               entries_num = ARRAY_SIZE(rsdt->entry);
>
> -       /* Fix RSDT length or the kernel will assume invalid entries */
> -       rsdt->header.length = sizeof(struct acpi_table_header) +
> -                               (sizeof(u32) * (i + 1));
> +               for (i = 0; i < entries_num; i++) {
> +                       if (rsdt->entry[i] == 0)
> +                               break;
> +               }
>
> -       /* Re-calculate checksum */
> -       rsdt->header.checksum = 0;
> -       rsdt->header.checksum = table_compute_checksum((u8 *)rsdt,
> -                                                      rsdt->header.length);
> +               if (i >= entries_num) {
> +                       log_err("ACPI: Error: too many tables\n");
> +                       return -E2BIG;
> +               }
>
> -       /*
> -        * And now the same thing for the XSDT. We use the same index as for
> -        * now we want the XSDT and RSDT to always be in sync in U-Boot
> -        */
> -       xsdt = ctx->xsdt;
> +               /* Add table to the RSDT */
> +               rsdt->entry[i] = nomap_to_sysmem(table);
>
> -       /* Add table to the XSDT */
> -       xsdt->entry[i] = nomap_to_sysmem(table);
> +               /* Fix RSDT length or the kernel will assume invalid entries */
> +               rsdt->header.length = sizeof(struct acpi_table_header) +
> +                                       (sizeof(u32) * (i + 1));
>
> -       /* Fix XSDT length */
> -       xsdt->header.length = sizeof(struct acpi_table_header) +
> -                               (sizeof(u64) * (i + 1));
> +               /* Re-calculate checksum */
> +               rsdt->header.checksum = 0;
> +               rsdt->header.checksum = table_compute_checksum((u8 *)rsdt,
> +                                                              rsdt->header.length);
> +       }
>
> -       /* Re-calculate checksum */
> -       xsdt->header.checksum = 0;
> -       xsdt->header.checksum = table_compute_checksum((u8 *)xsdt,
> -                                                      xsdt->header.length);
> +       if (ctx->xsdt) {
> +               /*
> +                * And now the same thing for the XSDT. We use the same index as for
> +                * now we want the XSDT and RSDT to always be in sync in U-Boot
> +                */
> +               xsdt = ctx->xsdt;
> +
> +               /* This should always be MAX_ACPI_TABLES */
> +               entries_num = ARRAY_SIZE(xsdt->entry);
> +
> +               for (i = 0; i < entries_num; i++) {
> +                       if (xsdt->entry[i] == 0)
> +                               break;
> +               }
> +
> +               if (i >= entries_num) {
> +                       log_err("ACPI: Error: too many tables\n");
> +                       return -E2BIG;
> +               }
> +
> +               /* Add table to the XSDT */
> +               xsdt->entry[i] = nomap_to_sysmem(table);
> +
> +               /* Fix XSDT length */
> +               xsdt->header.length = sizeof(struct acpi_table_header) +
> +                                       (sizeof(u64) * (i + 1));
> +
> +               /* Re-calculate checksum */
> +               xsdt->header.checksum = 0;
> +               xsdt->header.checksum = table_compute_checksum((u8 *)xsdt,
> +                                                              xsdt->header.length);
> +       }
>
>         return 0;
>  }
> --
> 2.46.0
>
