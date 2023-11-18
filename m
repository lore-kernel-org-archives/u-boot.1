Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62648C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727BE874E8;
	Sat, 18 Nov 2023 18:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ONQyiDQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46651871E1; Sat, 18 Nov 2023 18:11:58 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99D186EE5
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d9ca471cf3aso2897432276.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9eih0m5Eu8/QiVnqtzoKRCDjBX7NIbP/CuaQp0CtJw4=;
 b=ONQyiDQttVClGP+5WX4GSw1sYPNvJBBuseShCBQj+k4nCaftWccr/CEaw6HzIoeA+Q
 78dD3ptHrID9NjATvlnTc/U8l1S7cRKfQaBshDQv8kP2BEAJBsdkXWPqj6fJfL/c/fQh
 1EdXntE2fsRiLZTrZdD/PofNycHM0hjW+q+2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eih0m5Eu8/QiVnqtzoKRCDjBX7NIbP/CuaQp0CtJw4=;
 b=r9+fpdqc9yr/hzefQ1mRmm0brz2DefBPWHXLPRYYq5kMBONty0a+crt+uwgnVTpyji
 UqUtF0afJ8+6VQgsjz/t15bSUYaz65GeYOzWZ4SNAUfW2biLn8TBTaLPpjqyjS5/qPS1
 dOpQbBq1sM/gnLNqyclJVd56NRE9xQtuTNAyrPqqEZTSvIKiSAiIEJHr0M5RGz4FqS6E
 VQxSvs1Vupq7FZNOOj1v8bd6clAUHu7YKcXkekdGv6+Z41XLpmfPnN8kHR3tdPpeNPBD
 HSa6WtLf0820hehjNIvRMoE0YlD2vGAJkoupyfD1lzCQZaEWsY7pLL6mIz8bm/jG21Eo
 iazQ==
X-Gm-Message-State: AOJu0YzXgQT4rgiSBsIkHr2IgvpoqxN2QjhqI5WVxPw4gXFoK7oPJQdH
 2cBKWwT92puZJqFtjpn3NnE5znl9s0+P6TQmL3xxrfGpYEPmW0Dtb+A=
X-Google-Smtp-Source: AGHT+IFPJC2v4yj+Mcx1vQCBPml8Akf6ZxIT5apGWNiFOeynROyUUR87ed1cmDKs8Z+pKFfdOrsxD0Wr2gKPUu6qm7E=
X-Received: by 2002:a25:8751:0:b0:dae:e8f2:b7dd with SMTP id
 e17-20020a258751000000b00daee8f2b7ddmr2405328ybn.13.1700327504819; Sat, 18
 Nov 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231114163924.23225-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231114163924.23225-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:14 -0700
Message-ID: <CAPnjgZ1aUBXG6A3SSSHReg-kK6Y2bGq=yLAW7PG8K7YhG4NSNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: consider XSDT in acpi_find_table()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 14 Nov 2023 at 09:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The RSDT table is deprecated and does not exist on all systems.
>
> By preference scan XSDT for the table to find. If no XSDT table exists, try
> to use the RSDT table.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/acpi/acpi.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
> index 14b15754f4..3938946fc6 100644
> --- a/lib/acpi/acpi.c
> +++ b/lib/acpi/acpi.c
> @@ -16,18 +16,30 @@ struct acpi_table_header *acpi_find_table(const char *sig)
>  {
>         struct acpi_rsdp *rsdp;
>         struct acpi_rsdt *rsdt;
> +       struct acpi_xsdt *xsdt;
>         int len, i, count;
>
>         rsdp = map_sysmem(gd_acpi_start(), 0);
>         if (!rsdp)
>                 return NULL;
> -       rsdt = map_sysmem(rsdp->rsdt_address, 0);
> -       len = rsdt->header.length - sizeof(rsdt->header);
> -       count = len / sizeof(u32);
> +       xsdt = map_sysmem(rsdp->xsdt_address, 0);
> +       if (xsdt) {
> +               len = xsdt->header.length - sizeof(xsdt->header);
> +               count = len / sizeof(u64);
> +       } else {
> +               rsdt = map_sysmem(rsdp->rsdt_address, 0);
> +               if (!rsdt)
> +                       return NULL;
> +               len = rsdt->header.length - sizeof(rsdt->header);
> +               count = len / sizeof(u32);
> +       }
>         for (i = 0; i < count; i++) {
>                 struct acpi_table_header *hdr;
>
> -               hdr = map_sysmem(rsdt->entry[i], 0);
> +               if (xsdt)
> +                       hdr = map_sysmem(xsdt->entry[i], 0);
> +               else
> +                       hdr = map_sysmem(rsdt->entry[i], 0);
>                 if (!memcmp(hdr->signature, sig, ACPI_NAME_LEN))
>                         return hdr;
>                 if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN)) {
> --
> 2.40.1
>

Can you please expand test/dm/acpi.c to check the above? Perhaps only
on sandbox64 ?

Regards,
Simon
