Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D119C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF6687C8F;
	Sat, 16 Dec 2023 19:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aFeiMT6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C0C87C18; Sat, 16 Dec 2023 19:48:37 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA9F87C3C
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e4fda12ef0so7484687b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pFpP7CrvtcN5Q3YEHp0JmeCtQKqknDu3KMGjustUJnU=;
 b=aFeiMT6ovC8kN2g9WAPussvfAv4dAYsJpIjawbghwtiwRUCgFxwy4BbyE5TnsD5Ox+
 S9eptZ5/2KBRmCqJVuKhb1wOmtvGh2i/dSAEzJmPOoZX5YPMVXna5B+tpLrFKxFkUmaW
 SAah393pYzIuw6/ZjVsPBJJ71BuIHhPCvp7C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pFpP7CrvtcN5Q3YEHp0JmeCtQKqknDu3KMGjustUJnU=;
 b=MwWHvq05tJroGvswj6ihFc40UW4uZVmn47DhgTyKRMBP90m1VlPtWeV41Dg837nsnT
 REXb8jKSs7PY8xIGcQ4JVcc+evhaZ7N7PYFU7E4gEAW6T2RPo6KGPWZcLwn/UQ/o4lGf
 xt9s8w9+7z814sNma8a8nqjKPu95mb/tAtW6m/Qq5i8dqIXJh+PyzozUuPNHwKuXTOLE
 zTVpHVNn8Tb0YMsUxsG198sYkYQC/D7Z6Fe1OImwv3aplfPirxoqnuHo58U44vjA9ln9
 Xd18f1cVdQhMW1Me2phEVhI2XzzAM294aooj8f6t/rwGCp1F6mS61dsV3wrsTrZDop/K
 ZOow==
X-Gm-Message-State: AOJu0YxoFyooli+t5d6o2zHUkqYGJlL4tN6IxO2XIsO4DaSAZeFG3DZU
 OTuDCXgHbnRQyHuHdSKg5Hk56385CGPJKJl3+D4bsg==
X-Google-Smtp-Source: AGHT+IF8hOsrR2Hmzcoo3LvddSeUKZNlPJmgqtSarSlP/5Y+nWjyrQNvk9QbWm2IY0xv3cVTAohYZFvXfoTxaeOqkGc=
X-Received: by 2002:a81:4e0d:0:b0:5e5:b359:8340 with SMTP id
 c13-20020a814e0d000000b005e5b3598340mr429940ywb.9.1702752514126; Sat, 16 Dec
 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215133245.7923-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:10 -0700
Message-ID: <CAPnjgZ2hieRq3v5MCsS3qeHJ8DN+vrQTwwzks=z-R5AbcQLjFg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] acpi: enable writing ACPI tables on QEMU
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Fri, 15 Dec 2023 at 06:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Invoke write_acpi_tables() via EVT_LAST_STAGE_INIT on QEMU except on X86.
> X86 calls write_acpi_tables() in write_tables().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  drivers/misc/qfw_acpi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>

This is fine for now.

Reviewed-by: Simon Glass <sjg@chromium.org>

I would like to collect all tables generation into one piece, using a
bloblist to hold them, so they are contiguous. This is implemented on
x86, but is optional.

Still, this patch gets things running and makes it possible to make
such a change later.

> diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
> index 6e14b2a504..7ffed1e8c0 100644
> --- a/drivers/misc/qfw_acpi.c
> +++ b/drivers/misc/qfw_acpi.c
> @@ -9,9 +9,11 @@
>  #include <acpi/acpi_table.h>
>  #include <errno.h>
>  #include <malloc.h>
> +#include <mapmem.h>
>  #include <qfw.h>
>  #include <tables_csum.h>
>  #include <stdio.h>
> +#include <linux/sizes.h>
>  #include <asm/byteorder.h>
>  #include <asm/global_data.h>
>
> @@ -254,3 +256,26 @@ ulong acpi_get_rsdp_addr(void)
>         file = qfw_find_file(dev, "etc/acpi/rsdp");
>         return file->addr;
>  }
> +
> +#ifndef CONFIG_X86
> +static int evt_write_acpi_tables(void)
> +{
> +       ulong addr, end;
> +       void *ptr;
> +
> +       /* Reserve 64K for ACPI tables, aligned to a 4K boundary */
> +       ptr = memalign(SZ_4K, SZ_64K);
> +       if (!ptr)
> +               return -ENOMEM;
> +       addr = map_to_sysmem(ptr);
> +
> +       /* Generate ACPI tables */
> +       end = write_acpi_tables(addr);
> +       gd->arch.table_start = addr;
> +       gd->arch.table_end = addr;
> +
> +       return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, evt_write_acpi_tables);
> +#endif
> --
> 2.40.1
>

Regards,
Simon
