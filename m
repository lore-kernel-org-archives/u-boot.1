Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF670EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B101788D9E;
	Thu, 12 Sep 2024 02:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g2i4bCM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B13888D54; Thu, 12 Sep 2024 02:59:04 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA2988D60
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so279194b3a.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102740; x=1726707540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wDFdjOzDs6ECvyTIgY+ZGg1j2cqbv2GaEtp454JrEe4=;
 b=g2i4bCM63OxfTHU/1wqLJarf6tLlHHgekQsJrbV1NXYrpwVWS7RsTK9FpYxAb9c0Eo
 z5CotiSSe+31nB1WMrJA9f9fD6oz+tTf2nC+okxJ8enxfnX/zOferK/9mJj3uYqPgFWC
 NF7iN/9p5K5qJVp6Y7X7sWo6P0dQItqAEBuQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102740; x=1726707540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wDFdjOzDs6ECvyTIgY+ZGg1j2cqbv2GaEtp454JrEe4=;
 b=udmgnDKLVOBVuXUQW9oYkKnznuEeK9811pv8JulSuYrsr/PnNzOPL7cARYHgoT5Btr
 tOyg/t4MuNtTeplA9TycF92xHFLtyTFg+Ou4uIyMQv+cpFZkczMediD1Hp8WbDQyj12S
 mqqw2dELJx3zQrgIhOcIIb7UuzU73lTkAho/ViIx7+KnAvYn3DKUi+8PwUuE39P1GRlo
 0I1Rn4Z9xScwUkZ4VUt3tfDo4gW7dfriUGYxNjJaR1rOTOCG8BF4cQ3Uuu5mfyF7pJJK
 aC/D+N2GtJDIK05Qlb4ZxJnm59yUDllQ7gQFz3qQMdvQJbS6hbuq+mM1xb6vXb6Aq6cg
 Onzg==
X-Gm-Message-State: AOJu0Yz8hAT4d+Hg+VTHNgfobGn8l64WcWDr4MjVLneV02stVYh3gQui
 9bpsl52p6BOJqd1uQR0vcqWSGZK/d6VPCLKDOyuFVRARwK4Dwfv6qIII59dv9gPc3n3/4eZvV1F
 YDSK8yx6f4MyI3t7PzwgkoIAXPJro+OtCae5t
X-Google-Smtp-Source: AGHT+IHPhitm/4+QLSUd7kbLgR/oYHmtv+6wNyEtXVE5CrlALlOWTr10Zlxewa0TfXUoU9+bMyvJKSW4nMw2szqk/rE=
X-Received: by 2002:a05:6a00:2e94:b0:706:6962:4b65 with SMTP id
 d2e1a72fcca58-719260915c1mr1700186b3a.14.1726102739781; Wed, 11 Sep 2024
 17:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-9-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-9-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:16 -0600
Message-ID: <CAFLszTjhO17mAXTt7nfFuYwQ21c2ZcFiaK_T_z2SMwn75yZ94A@mail.gmail.com>
Subject: Re: [PATCH v3 08/30] acpi: Add fill_madt to acpi_ops
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a new method to acpi_ops to let drivers fill out ACPI MADT.
> The code is unused for now until drivers implement the new ops.
>
> TEST: Booted on QEMU sbsa using driver model generated MADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/lib/acpi_table.c |  7 +++++++
>  drivers/core/acpi.c       | 16 +++++++++++++++
>  include/dm/acpi.h         | 26 ++++++++++++++++++++++++
>  lib/acpi/acpi_table.c     |  2 +-
>  test/dm/acpi.c            | 42 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 92 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
> index db6e40bdef..8c17e9eb36 100644
> --- a/arch/arm/lib/acpi_table.c
> +++ b/arch/arm/lib/acpi_table.c
> @@ -112,3 +112,10 @@ int acpi_pptt_add_cache(struct acpi_ctx *ctx, const u32 flags,
>
>         return offset;
>  }
> +
> +__weak void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
> +{
> +       /* TODO: Drop __weak once all SoCs are migrated to driver model */
> +       acpi_fill_madt_subtbl(ctx);
> +       return ctx->current;
> +}
> diff --git a/drivers/core/acpi.c b/drivers/core/acpi.c
> index 9f78422892..4763963914 100644
> --- a/drivers/core/acpi.c
> +++ b/drivers/core/acpi.c
> @@ -48,6 +48,7 @@ enum method_t {
>         METHOD_FILL_SSDT,
>         METHOD_INJECT_DSDT,
>         METHOD_SETUP_NHLT,
> +       METHOD_FILL_MADT,
>  };
>
>  /* Prototype for all methods */
> @@ -282,6 +283,8 @@ acpi_method acpi_get_method(struct udevice *dev, enum method_t method)
>                 switch (method) {
>                 case METHOD_WRITE_TABLES:
>                         return aops->write_tables;
> +               case METHOD_FILL_MADT:
> +                       return aops->fill_madt;
>                 case METHOD_FILL_SSDT:
>                         return aops->fill_ssdt;
>                 case METHOD_INJECT_DSDT:
> @@ -328,6 +331,19 @@ int acpi_recurse_method(struct acpi_ctx *ctx, struct udevice *parent,
>         return 0;
>  }
>
> +int acpi_fill_madt_subtbl(struct acpi_ctx *ctx)
> +{
> +       int ret;
> +
> +       log_debug("Writing MADT table\n");
> +       ret = acpi_recurse_method(ctx, dm_root(), METHOD_FILL_MADT, TYPE_NONE);
> +       log_debug("Writing MADT finished, err=%d\n", ret);
> +       if (ret)
> +               return log_msg_ret("build", ret);
> +
> +       return ret;
> +}
> +
>  int acpi_fill_ssdt(struct acpi_ctx *ctx)
>  {
>         void *start = ctx->current;
> diff --git a/include/dm/acpi.h b/include/dm/acpi.h
> index 3adfe21767..d6bc0c099a 100644
> --- a/include/dm/acpi.h
> +++ b/include/dm/acpi.h
> @@ -146,6 +146,22 @@ struct acpi_ops {
>          */
>         int (*write_tables)(const struct udevice *dev, struct acpi_ctx *ctx);
>
> +       /**
> +        * fill_madt() - Generate MADT sub-tables for a device
> +        *
> +        * This is called to create the MADT table. The method should write out
> +        * whatever sub-table is needed by this device. It will end up in the
> +        * MADT table.
> +        *
> +        * Note that this is called 'fill' because the entire contents of the
> +        * MADT is build by calling this method on all devices.
> +        *
> +        * @dev: Device to write
> +        * @ctx: ACPI context to use
> +        * @return 0 if OK, -ve on error
> +        */
> +       int (*fill_madt)(const struct udevice *dev, struct acpi_ctx *ctx);
> +
>         /**
>          * fill_ssdt() - Generate SSDT code for a device
>          *
> @@ -231,6 +247,16 @@ int acpi_copy_name(char *out_name, const char *name);
>   */
>  int acpi_write_dev_tables(struct acpi_ctx *ctx);
>
> +/**
> + * acpi_fill_madt_subtbl() - Generate ACPI tables for MADT
> + *
> + * This is called to create the MADT sub-tables for all devices.
> + *
> + * @ctx: ACPI context to use
> + * Return: 0 if OK, -ve on error
> + */
> +int acpi_fill_madt_subtbl(struct acpi_ctx *ctx);
> +
>  /**
>   * acpi_fill_ssdt() - Generate ACPI tables for SSDT
>   *
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index d7deed2df1..96ca3b05a0 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -261,11 +261,11 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>         header->revision = ACPI_MADT_REV_ACPI_3_0;
>
>         acpi_inc(ctx, sizeof(struct acpi_madt));
> +       /* TODO: Get rid of acpi_fill_madt and use driver model */
>         current = acpi_fill_madt(madt, ctx);
>
>         /* (Re)calculate length and checksum */
>         header->length = (uintptr_t)current - (uintptr_t)madt;
> -
>         header->checksum = table_compute_checksum((void *)madt, header->length);
>         acpi_add_table(ctx, madt);
>         ctx->current = (void *)madt + madt->header.length;
> diff --git a/test/dm/acpi.c b/test/dm/acpi.c
> index 7da381f1a5..cc032a4618 100644
> --- a/test/dm/acpi.c
> +++ b/test/dm/acpi.c
> @@ -95,6 +95,21 @@ static int testacpi_get_name(const struct udevice *dev, char *out_name)
>                 return acpi_copy_name(out_name, ACPI_TEST_DEV_NAME);
>  }
>
> +static int testacpi_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
> +{
> +       u64 *data = ctx->current;
> +
> +       /* Only fill madt once */
> +       if (device_get_uclass_id(dev->parent) != UCLASS_TEST_ACPI)
> +               return 0;
> +
> +       *data = 0xdeadbeef;
> +
> +       acpi_inc(ctx, sizeof(u64));
> +
> +       return 0;
> +}
> +
>  static int testacpi_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
>  {
>         const char *data;
> @@ -124,6 +139,7 @@ static int testacpi_inject_dsdt(const struct udevice *dev, struct acpi_ctx *ctx)
>  struct acpi_ops testacpi_ops = {
>         .get_name       = testacpi_get_name,
>         .write_tables   = testacpi_write_tables,
> +       .fill_madt      = testacpi_fill_madt,
>         .fill_ssdt      = testacpi_fill_ssdt,
>         .inject_dsdt    = testacpi_inject_dsdt,
>  };
> @@ -532,6 +548,32 @@ static int dm_test_acpi_fill_ssdt(struct unit_test_state *uts)
>  }
>  DM_TEST(dm_test_acpi_fill_ssdt, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
>
> +/* Test acpi_fill_madt() */
> +static int dm_test_acpi_fill_madt(struct unit_test_state *uts)
> +{
> +       struct acpi_ctx ctx;
> +       u64 *buf;
> +
> +       buf = malloc(BUF_SIZE);
> +       ut_assertnonnull(buf);
> +
> +       acpi_reset_items();
> +       ctx.current = buf;
> +       buf[1] = 'z';   /* sentinel */
> +       ut_assertok(acpi_fill_madt_subtbl(&ctx));
> +
> +       /*
> +        * These values come from acpi-test2's acpi-ssdt-test-data property.
> +        * This device comes first because of u-boot,acpi-ssdt-order
> +        */
> +       ut_asserteq(0xdeadbeef, buf[0]);
> +
> +       ut_asserteq('z', buf[1]);
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_acpi_fill_madt, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
> +
>  /* Test acpi_inject_dsdt() */
>  static int dm_test_acpi_inject_dsdt(struct unit_test_state *uts)
>  {
> --
> 2.46.0
>
