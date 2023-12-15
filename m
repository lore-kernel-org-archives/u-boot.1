Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBAAC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9E487BE1;
	Fri, 15 Dec 2023 18:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IQa54Q4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C19987BE6; Fri, 15 Dec 2023 18:49:08 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D57E87B9E
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c64316a22so1078591a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702662545; x=1703267345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JBuVpyVPl02NbAP4Iee9VtAAARMZ3va30rYlRwhDALQ=;
 b=IQa54Q4fiev2SlTUxiLeGnUXb96u110lm0tmlPzZkrfBarguovVNOOLbDDdMVjE0Jy
 BnxkrziUcq7Mv+87qCM9IjqzpetyvuThWnW4P++pRPC8/E/PZLvjLyp1v1mFVaG8ExoO
 SnC4DrJNEtlkCY5i4eKeaEM+7IoTmwEQDxvs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702662545; x=1703267345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JBuVpyVPl02NbAP4Iee9VtAAARMZ3va30rYlRwhDALQ=;
 b=d/fzMdWJG6Cna3CmG8MlM565kfm3OhLzSRARgPa1PY3BUrD/8qrmKgiMSVG13GPJI/
 qcGcgYnvFdmLSKmdPELg5thciyD5gR0pXISQ/uUkB9tbvKaauIoUFg/pmrOCvLNHkyX7
 LcuIf5+VFMyTbKWEqo0A93axmkClsRrDxpnnjPrYdkaqf2ldd9JdK6+L5EBylDxq9TzH
 oXYWOEM2/Qormc2cs8lqT05OnQ8O2byrd+U99SYr6wD5zo1rcoWLQPpwhuAabLXyim53
 J/5xtbr5X7MJBBbLqCSMxh0pycEj6MTGCzb336Sm1tC0TLDxVDbDsooHADh9NEjF2HYs
 AIkw==
X-Gm-Message-State: AOJu0YxtWrdtmKOwNVscHwK+9qCxClDeb8SeMr7dlJa4G3fkkHxOSrQm
 HmIUD3/pF1988FHpHJ1stpPtLzKaPWS0vg58wLHIav4tigux6Ev0YGk=
X-Google-Smtp-Source: AGHT+IFdDS72FEO9mWRfqLdLPYhDf/rQ5yOHzyVJGSxOo7PYb+5hXrtVKe7JlUCHTn7mQryvcytihsKl0JVfYq53Zww=
X-Received: by 2002:a17:906:20d8:b0:a19:a19a:ea97 with SMTP id
 c24-20020a17090620d800b00a19a19aea97mr5920871ejc.80.1702662545346; Fri, 15
 Dec 2023 09:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
 <20231215164016.137794-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215164016.137794-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Dec 2023 10:48:53 -0700
Message-ID: <CAPnjgZ3j3PmV-FEkSP6hPfqpS3XQ_-f4b=5LCRpd3nj4Hi=2zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] acpi: fix FADT table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Fri, 15 Dec 2023 at 09:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Fields X_FIRMWAE_CTRL and X_DSDT must be 64bit wide. Convert pointers to
> to uintptr_t to fill these.
>
> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
> field X_DSDT is filled, field DSDT must be ignored. We should not fill
> unused fields.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/cpu/baytrail/acpi.c | 8 ++------
>  arch/x86/cpu/quark/acpi.c    | 8 ++------
>  arch/x86/cpu/tangier/acpi.c  | 8 ++------
>  arch/x86/lib/acpi_table.c    | 9 ++-------
>  include/acpi/acpi_table.h    | 6 ++----
>  5 files changed, 10 insertions(+), 29 deletions(-)
>

Just as a general comment, the word 'fix' does not really describe
things very well. There may be many fixes to a piece of code or
feature. I would suggest something a bit more specific.  Perhaps
something like 'Support 64-bit addresses in FADT table'

Also please use the U-Boot standard of ulong for addresses, not uintptr_t

For casts, it is better to use map_sysmem() and map_to_sysmem() so
that we can use the code in unit tests (although of course we
currently have no way of running x86-specific code in sandbox).

> diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
> index 4378846f8b..5c28c4d260 100644
> --- a/arch/x86/cpu/baytrail/acpi.c
> +++ b/arch/x86/cpu/baytrail/acpi.c
> @@ -31,8 +31,6 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
>         header->length = sizeof(struct acpi_fadt);
>         header->revision = 4;
>
> -       fadt->firmware_ctrl = (u32)ctx->facs;
> -       fadt->dsdt = (u32)ctx->dsdt;
>         fadt->preferred_pm_profile = ACPI_PM_MOBILE;
>         fadt->sci_int = 9;
>         fadt->smi_cmd = 0;
> @@ -79,10 +77,8 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
>         fadt->reset_reg.addrh = 0;
>         fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
>
> -       fadt->x_firmware_ctl_l = (u32)ctx->facs;
> -       fadt->x_firmware_ctl_h = 0;
> -       fadt->x_dsdt_l = (u32)ctx->dsdt;
> -       fadt->x_dsdt_h = 0;
> +       fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
> +       fadt->x_dsdt = (uintptr_t)ctx->dsdt;
>
>         fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
>         fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
> diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
> index 9a2d682451..583d4583c0 100644
> --- a/arch/x86/cpu/quark/acpi.c
> +++ b/arch/x86/cpu/quark/acpi.c
> @@ -26,8 +26,6 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
>         header->length = sizeof(struct acpi_fadt);
>         header->revision = 4;
>
> -       fadt->firmware_ctrl = (u32)ctx->facs;
> -       fadt->dsdt = (u32)ctx->dsdt;
>         fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
>         fadt->sci_int = 9;
>         fadt->smi_cmd = 0;
> @@ -74,10 +72,8 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
>         fadt->reset_reg.addrh = 0;
>         fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
>
> -       fadt->x_firmware_ctl_l = (u32)ctx->facs;
> -       fadt->x_firmware_ctl_h = 0;
> -       fadt->x_dsdt_l = (u32)ctx->dsdt;
> -       fadt->x_dsdt_h = 0;
> +       fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
> +       fadt->x_dsdt = (uintptr_t)ctx->dsdt;
>
>         fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
>         fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
> diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
> index 1c667c7d56..19ec6e3390 100644
> --- a/arch/x86/cpu/tangier/acpi.c
> +++ b/arch/x86/cpu/tangier/acpi.c
> @@ -31,8 +31,6 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
>         header->length = sizeof(struct acpi_fadt);
>         header->revision = 6;
>
> -       fadt->firmware_ctrl = (u32)ctx->facs;
> -       fadt->dsdt = (u32)ctx->dsdt;
>         fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
>
>         fadt->iapc_boot_arch = ACPI_FADT_VGA_NOT_PRESENT |
> @@ -45,10 +43,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
>
>         fadt->minor_revision = 2;
>
> -       fadt->x_firmware_ctl_l = (u32)ctx->facs;
> -       fadt->x_firmware_ctl_h = 0;
> -       fadt->x_dsdt_l = (u32)ctx->dsdt;
> -       fadt->x_dsdt_h = 0;
> +       fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
> +       fadt->x_dsdt = (uintptr_t)ctx->dsdt;
>
>         header->checksum = table_compute_checksum(fadt, header->length);
>
> diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
> index c5b33dc65d..f49b6933ab 100644
> --- a/arch/x86/lib/acpi_table.c
> +++ b/arch/x86/lib/acpi_table.c
> @@ -572,13 +572,8 @@ void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
>         memcpy(header->aslc_id, ASLC_ID, 4);
>         header->aslc_revision = 1;
>
> -       fadt->firmware_ctrl = (unsigned long)facs;
> -       fadt->dsdt = (unsigned long)dsdt;
> -
> -       fadt->x_firmware_ctl_l = (unsigned long)facs;
> -       fadt->x_firmware_ctl_h = 0;
> -       fadt->x_dsdt_l = (unsigned long)dsdt;
> -       fadt->x_dsdt_h = 0;
> +       fadt->x_firmware_ctrl = (uintptr_t)facs;
> +       fadt->x_dsdt = (uintptr_t)dsdt;
>
>         fadt->preferred_pm_profile = ACPI_PM_MOBILE;
>
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index 20ac3b51ba..e67562ef65 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -228,10 +228,8 @@ struct __packed acpi_fadt {
>         u8 reset_value;
>         u16 arm_boot_arch;
>         u8 minor_revision;
> -       u32 x_firmware_ctl_l;
> -       u32 x_firmware_ctl_h;
> -       u32 x_dsdt_l;
> -       u32 x_dsdt_h;
> +       u64 x_firmware_ctrl;
> +       u64 x_dsdt;
>         struct acpi_gen_regaddr x_pm1a_evt_blk;
>         struct acpi_gen_regaddr x_pm1b_evt_blk;
>         struct acpi_gen_regaddr x_pm1a_cnt_blk;
> --
> 2.40.1
>

Regards,
Simon

Regards,
Simon
