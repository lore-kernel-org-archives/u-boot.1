Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89F0C48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 08:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34C6787C35;
	Thu,  1 Feb 2024 09:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n7ENTOyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274BB87C34; Thu,  1 Feb 2024 09:42:15 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4771787C44
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 09:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51124d43943so941546e87.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 00:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706776930; x=1707381730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/nuo2TK7vitFQx3rGkT/GMNueg3CErDV+389NqPNlMA=;
 b=n7ENTOylAuZTQyVoeoD9v9FAfeF9bB0h1XwP+a4Xm8ibNTjX8ZsP4IRgml95P9srW3
 RY/9oqi3ClRaJtCcruWuhIpKA0M4TlWEQ9ENGcij4BVHSYGWwoyRwhC8qmspuvljln/a
 uEWWC/E46QSJoJjdZsMM66/C+yXt9nU3Fri6SwsW8dKFJVLlB+TJGE7Kf5PGVprF/IGS
 z970nLNxrF2hw1UIQlcbf4yalUBtYSbC3VrB0Fgat9hIWb061IXhTpTNP5HiC3tULxgn
 cjtBq/MP0u73dFe4l/Ye2xFI6mtL0QSCaVd3H+Hzrw6xdbCc3usPM9W7PjZsdtiNLKFk
 zPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706776930; x=1707381730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/nuo2TK7vitFQx3rGkT/GMNueg3CErDV+389NqPNlMA=;
 b=ovpG/8ODb3iZU4XiXQZhDf876DFr2KjnrRN5085ZvFifUPQ/dqPv1xRvagFqM/rcPn
 pdORQFBepw2aKtHQF+ie071ufufoUiBFNttcMtkxmDuIVxKRCLH8kocRxXW9CP926DDH
 3aPHjiTqtcGHxD/dxPorg8ChiT4nlrOFjO2dUqw96rcAogoh2YOXHasIA0VyJD/BCMk1
 NQI05jjo1Tbqisks/NEXcm1frNI2v0/xRziMQ5tRcDulNH+kchC62rHC5mMdZ7Gg0kxf
 tx75FkFDNXWXFvIFWGWZwD9/9ZtSF/hVhu1iRxqPu9ZNu6SgHZ12t6LKBGX+Z5kGkw9Y
 K/Pg==
X-Gm-Message-State: AOJu0YwnOpMf/Cq8M3mTymMFrxBbFBEMV/1nc6gdn9dJQ/tFjl8SQGFa
 Aw3zbBX1UlWyCOGeL2R/AiE0FDrhomKwwueM10sner56UnqzGCvbAB4xpP/lirKUGa1RDKWbf/R
 08uZnu+7Rk2P9hKO1v4kQpJCBqqDLB0cJBxUBgQ==
X-Google-Smtp-Source: AGHT+IGzjV+PUGH9ylqUsoXvoTG6Wako/K0r+1Qo16r6WsR+uZgVPcEJ2yeS1oZ1Dd6Ydym2F+7pRLGzEAunQTbEHqA=
X-Received: by 2002:a19:5f5c:0:b0:510:ffd:31c9 with SMTP id
 a28-20020a195f5c000000b005100ffd31c9mr1417784lfj.4.1706776930529; Thu, 01 Feb
 2024 00:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
 <20240129210453.31070-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240129210453.31070-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Feb 2024 10:41:34 +0200
Message-ID: <CAC_iWjL1=kR+W1Q6Cox+L8b4+TCGPDPAxYcDNEjANSrFyPbu4w@mail.gmail.com>
Subject: Re: [PATCH 5/7] smbios: if a string value is unknown, use string
 number 0
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

On Mon, 29 Jan 2024 at 23:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The SMBIOS specification describes: "If a string field references no
> string, a null (0) is placed in that string field."
>
> Accordingly we should avoid writing a string "Unknown" to the SMBIOS table.
>
> dmidecode displays 'Not Specified' if the string number is 0.
>
> Commit 00a871d34e2f ("smbios: empty strings in smbios_add_string()")
> correctly identified that strings may not have length 0 as two
> consecutive NULs indentify the end of the string list. But the suggested
> solution did not match the intent of the SMBIOS specification.
>
> Fixes: 00a871d34e2f ("smbios: empty strings in smbios_add_string()")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/smbios.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 81908e89610..50072adb4e8 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -135,13 +135,16 @@ static const struct map_sysinfo *convert_sysinfo_to_dt(const char *node, const c
>   *
>   * @ctx:       SMBIOS context
>   * @str:       string to add
> - * Return:     string number in the string area (1 or more)
> + * Return:     string number in the string area. 0 if str is NULL.
>   */
>  static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
>  {
>         int i = 1;
>         char *p = ctx->eos;
>
> +       if (!str)
> +               return 0;
> +
>         for (;;) {
>                 if (!*p) {
>                         ctx->last_str = p;
> @@ -216,7 +219,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>         int ret;
>
>         if (!dval || !*dval)
> -               dval = "Unknown";
> +               dval = NULL;
>
>         if (!prop)
>                 return smbios_add_string(ctx, dval);
> @@ -378,19 +381,19 @@ static int smbios_write_type1(ulong *current, int handle,
>         memset(t, 0, sizeof(struct smbios_type1));
>         fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
> -       t->product_name = smbios_add_prop(ctx, "product", "Unknown");
> +       t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
> +       t->product_name = smbios_add_prop(ctx, "product", NULL);
>         t->version = smbios_add_prop_si(ctx, "version",
>                                         SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
> -                                       "Unknown");
> +                                       NULL);
>         if (serial_str) {
>                 t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
>                 strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
>         } else {
> -               t->serial_number = smbios_add_prop(ctx, "serial", "Unknown");
> +               t->serial_number = smbios_add_prop(ctx, "serial", NULL);
>         }
> -       t->sku_number = smbios_add_prop(ctx, "sku", "Unknown");
> -       t->family = smbios_add_prop(ctx, "family", "Unknown");
> +       t->sku_number = smbios_add_prop(ctx, "sku", NULL);
> +       t->family = smbios_add_prop(ctx, "family", NULL);
>
>         len = t->length + smbios_string_table_len(ctx);
>         *current += len;
> @@ -409,12 +412,12 @@ static int smbios_write_type2(ulong *current, int handle,
>         memset(t, 0, sizeof(struct smbios_type2));
>         fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
> -       t->product_name = smbios_add_prop(ctx, "product", "Unknown");
> +       t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
> +       t->product_name = smbios_add_prop(ctx, "product", NULL);
>         t->version = smbios_add_prop_si(ctx, "version",
>                                         SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> -                                       "Unknown");
> -       t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", "Unknown");
> +                                       NULL);
> +       t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", NULL);
>         t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
>         t->board_type = SMBIOS_BOARD_MOTHERBOARD;
>
> @@ -435,7 +438,7 @@ static int smbios_write_type3(ulong *current, int handle,
>         memset(t, 0, sizeof(struct smbios_type3));
>         fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
> +       t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
>         t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
>         t->bootup_state = SMBIOS_STATE_SAFE;
>         t->power_supply_state = SMBIOS_STATE_SAFE;
> @@ -453,8 +456,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
>                                   struct smbios_ctx *ctx)
>  {
>         u16 processor_family = SMBIOS_PROCESSOR_FAMILY_UNKNOWN;
> -       const char *vendor = "Unknown";
> -       const char *name = "Unknown";
> +       const char *vendor = NULL;
> +       const char *name = NULL;
>
>  #ifdef CONFIG_CPU
>         char processor_name[49];
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
