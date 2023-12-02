Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F356BC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32BB87706;
	Sat,  2 Dec 2023 19:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cTgIUKpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCDA8772A; Sat,  2 Dec 2023 19:24:21 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2877D87706
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5d7084b6bb1so10004437b3.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541455; x=1702146255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fiwWe+wa77b3t57tItY5yPGw9SAfrMfMMD3h53JPEoU=;
 b=cTgIUKpO9DdjoDYufQ0KXmwKYpnBlyAf96ddwFGFa8CvPjJB4DXnsDHsihUVNDlVhs
 fTStiQnPNQuk5SypBOYY5tiF6lG2O4NvXAjhhoYFxtH6HbUtaxhwt6d1+yFRdnq5MYKC
 /+9GJ+47axaZiDwicVQYz/EBseuxTkdyQIvuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541455; x=1702146255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fiwWe+wa77b3t57tItY5yPGw9SAfrMfMMD3h53JPEoU=;
 b=XBRBtqOvO7a7IFFwB4iOLacdz7Jlkli/Zb2ViXIRHTzH9AD9T27cB5bNpPsATLMv75
 3186hwXCxECxHQMw5AIoO0aZ9hXHsBchq0474oMcePSHKGohmw5d/K1tMC8bukIUGrFS
 s3R1VzsTLMc1cwEh4UK3cQXNEMJeK9ReIb7Mu0HmtlJFuRdNAzr0mMsSsFLqrq4+3AL3
 j15LuE+HCKnuNR8iufv9kJFELTEx7cciuuZP0KXBYyYKwNlO8kK12byzVBD2tlTyJ1sd
 cC5MFI6T7n6uwp6qTMBE5fUeGvnD40Su3gRC+f6mpMacWhydXWjwaA1IUdyiXQ5o3wjD
 MWlg==
X-Gm-Message-State: AOJu0YzVTTywbnT+21KlgOIYvu47lxylQ8pTC4MbEjZZt81w2r+LUJVC
 VaIklD5f6jlYtoFeRayCZTHTeK0fwsvrwd83fSHmReizK0vOWhSdCa4ktQ==
X-Google-Smtp-Source: AGHT+IGVV4XkPJWbACMGM14r+YW0Y1+38BMBnJqdDhUOm53gFLopB+NrY9AV5T16O89cfgIGIUqF5kmZP7IbtF4nj4M=
X-Received: by 2002:a81:98d0:0:b0:5d7:1940:f3f9 with SMTP id
 p199-20020a8198d0000000b005d71940f3f9mr1124381ywg.97.1701541455228; Sat, 02
 Dec 2023 10:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121152740.24783-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:19 -0700
Message-ID: <CAPnjgZ0jM5QiTTn7f88daZpO2qmR2fh8WMqDO=faRdfJ6kFcCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] riscv: qemu: copy ACPI tables from QEMU
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Tom Rini <trini@konsulko.com>,
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

On Tue, 21 Nov 2023 at 08:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If CONFIG_GENERATE_ACPI_TABLES=y, read the ACPI tables provided by QEMU
> and make them available to U-Boot.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  board/emulation/qemu-riscv/qemu-riscv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Can we not use common code to do this? What is different about ARM and x86?


>
> diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
> index 181abbbf97..2cebce2128 100644
> --- a/board/emulation/qemu-riscv/qemu-riscv.c
> +++ b/board/emulation/qemu-riscv/qemu-riscv.c
> @@ -4,17 +4,20 @@
>   */
>
>  #include <common.h>
> +#include <acpi/acpi_table.h>
>  #include <dm.h>
>  #include <dm/ofnode.h>
>  #include <env.h>
>  #include <fdtdec.h>
>  #include <image.h>
>  #include <log.h>
> +#include <malloc.h>
>  #include <spl.h>
>  #include <init.h>
>  #include <usb.h>
>  #include <virtio_types.h>
>  #include <virtio.h>
> +#include <linux/sizes.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -46,6 +49,20 @@ int board_late_init(void)
>         if (CONFIG_IS_ENABLED(USB_KEYBOARD))
>                 usb_init();
>
> +       if (IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> +               uintptr_t addr;
> +               void *ptr;
> +
> +               /* Reserve 64K for ACPI tables, aligned to a 4K boundary */
> +               ptr = memalign(SZ_4K, SZ_64K);
> +               addr = (uintptr_t)ptr;
> +
> +               /* Generate ACPI tables */
> +               write_acpi_tables(addr);
> +               gd->arch.table_start = addr;
> +               gd->arch.table_end = addr;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.40.1
>
