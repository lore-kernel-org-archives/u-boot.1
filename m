Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7104BCAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 06:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4A383390;
	Tue, 23 Sep 2025 08:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W1mprUbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1662D833E9; Tue, 23 Sep 2025 08:33:57 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9648004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 08:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-749399349ddso20694557b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758609233; x=1759214033; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YFtFPYjlgfgiIKrBkilVc2zwhXGbUDA2PjrMEh2VD/4=;
 b=W1mprUbXbrCp3cktCrhOqXc1pftD/TYJCB6SvodilEBiXu2wmoCOqiKzWjJcmX/7Nv
 9dGyztKT0cWbhuMSinaGxiRNwptrvqM4qRP4h5ZRT9KvjQNO/6acY9FmUB2OLSdchLFt
 gDU0ZlY5qmEhqWNOt7wsmVHti/7tYdoDiMRIX+CElUxZM+hTErzturmoA4jmW6YCj1mF
 fw1ESx927NKUsClIoRgMDZI6gOPFFf43fyDVoLUGYlBJiXlHFRKeKdreu2a86o7NiNQZ
 YTEZmjSL5pXfqWkZLNvmw0RjVoP9zYEqYRVJrX2Gde0zaX18XWKbD9V0bY5A+rz/F6tl
 iHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758609233; x=1759214033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFtFPYjlgfgiIKrBkilVc2zwhXGbUDA2PjrMEh2VD/4=;
 b=p4vdVJ2he6MWd/aDg9QEH40483XjtqLfxgHPe4L0sZWfuzYyAfyePGOni+prz7eX1H
 hGtmB/NY49muqWqZtjVQiG7E0lPkm2Rv70LA3cbeqsV0SEHvDLkb7VwJ6Yvv9RMfaX13
 XZFbbcGzEavUYslQ9e/Ew86pASoH7u5P4F363nlpILAALbJlXJDn/+484o2He55BfjbT
 u7UtH7T6L3RDEzVEImzkad0/AuKyZ9gDmSgcB6lYwLdkAsQTlKnmALtCiPmgWFjtaK8I
 jNFTRA4f1xn8Wiv3AsoZ6tasdRGjeHRoAe6UucuYFM1OuTKNgkwY4P78qQDREkj/8So/
 vP7w==
X-Gm-Message-State: AOJu0YxiEbQDt6dcN8eK0cmtspivpi6dQAPiTrk9VdGe9LLrMBjR2TW6
 Yp4fAcN8xn7WuYicxeeYKruROabFhjXoDecogkpZMSRlNtvY4sxmZQhg68CaeT1X4FXQZwlugU5
 FTXvvPv6yuMqiIFqcVLEQkhtWJsbOhRmBmXAUZtxxMA==
X-Gm-Gg: ASbGncsYKd23qAd3KtjSLKiTVLjJkzEow1GfAKDS3YyFswK9Mk0ZKu1nPmiCnYQ8x3C
 lrdDjdb4x0ufzy+nC/SFyoKmw8jdgmmTMzO9FI9gdMQcNzyeWlOQflrCYu31FE2fAN7GNseOWDz
 5QAu6eh/aawOvCwb+SS16jTBXzubuVeTZEJJct4BnLtdrEcfNqqQf/gTfTfy1IzSzauvTwVLnqg
 HN4L8c=
X-Google-Smtp-Source: AGHT+IG1oL7zorGoYS7mS+szuBMKXxVho/dK3JPTM7MLwVjR/qPdAPZ55is+xk61IxXP+wfCqc7yp6R1W1940D9WIrs=
X-Received: by 2002:a05:690c:d1b:b0:747:8a32:4614 with SMTP id
 00721157ae682-75895212f99mr10346367b3.16.1758609232560; Mon, 22 Sep 2025
 23:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250919205605.291108-1-raymond.mao@linaro.org>
In-Reply-To: <20250919205605.291108-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Sep 2025 09:33:16 +0300
X-Gm-Features: AS18NWA_t8f9-TqkYo7ZwIyKPQGTpu3rVRRpKWxhmwvBXwU4uGjrKD-JoYGcBmk
Message-ID: <CAC_iWj+=5pZq539tunamO9=U4fbRCHujqG2WGq1uK70O2sQ4Bg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] smbios: Fix duplicated smbios handles
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Peng Fan <peng.fan@nxp.com>, Samuel Holland <samuel.holland@sifive.com>
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

Hi Raymond,

On Fri, 19 Sept 2025 at 23:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Some smbios types can have multiple instances (e.g. Type 7, 9, 16, 17,
> 19), thus the 'handle' argument should be a pointer so that the value
> can be accumulated when writing all the instances.
> This also fix the observed duplicated Type 7 handles.

This was wrong as well because the write methods were called with
method->write((ulong *)&addr, &handle, &ctx); right?


>
> Fixes: bcf456dd369e ("smbios: add detailed smbios information")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v3:
> - Initial patch.
>
>  lib/smbios.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index b8c2846277a..85508c06547 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -103,7 +103,7 @@ struct smbios_ctx {
>   * @ctx:       context for writing the tables
>   * Return:     size of the structure
>   */
> -typedef int (*smbios_write_type)(ulong *addr, int handle,
> +typedef int (*smbios_write_type)(ulong *addr, int *handle,
>                                  struct smbios_ctx *ctx);
>
>  /**
> @@ -364,7 +364,7 @@ static int smbios_string_table_len(const struct smbios_ctx *ctx)
>         return (ctx->next_ptr + 1) - ctx->eos;
>  }
>
> -static int smbios_write_type0(ulong *current, int handle,
> +static int smbios_write_type0(ulong *current, int *handle,
>                               struct smbios_ctx *ctx)
>  {
>         struct smbios_type0 *t;
> @@ -372,7 +372,7 @@ static int smbios_write_type0(ulong *current, int handle,
>
>         t = map_sysmem(*current, len);
>         memset(t, 0, len);
> -       fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
> +       fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, *handle);
>         smbios_set_eos(ctx, t->eos);
>         t->vendor = smbios_add_prop_si(ctx, NULL, SYSID_SM_BIOS_VENDOR,
>                                        "U-Boot");
> @@ -423,7 +423,7 @@ static int smbios_write_type0(ulong *current, int handle,
>         return len;
>  }
>
> -static int smbios_write_type1(ulong *current, int handle,
> +static int smbios_write_type1(ulong *current, int *handle,
>                               struct smbios_ctx *ctx)
>  {
>         struct smbios_type1 *t;
> @@ -434,7 +434,7 @@ static int smbios_write_type1(ulong *current, int handle,
>
>         t = map_sysmem(*current, len);
>         memset(t, 0, len);
> -       fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
> +       fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, *handle);
>         smbios_set_eos(ctx, t->eos);
>
>         t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
> @@ -471,7 +471,7 @@ static int smbios_write_type1(ulong *current, int handle,
>         return len;
>  }
>
> -static int smbios_write_type2(ulong *current, int handle,
> +static int smbios_write_type2(ulong *current, int *handle,
>                               struct smbios_ctx *ctx)
>  {
>         struct smbios_type2 *t;
> @@ -485,7 +485,7 @@ static int smbios_write_type2(ulong *current, int handle,
>          */
>         t = map_sysmem(*current, len);
>         memset(t, 0, len);
> -       fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
> +       fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, *handle);
>
>         /* eos is at the end of the structure */
>         eos_addr = (u8 *)t + len - sizeof(t->eos);
> @@ -519,7 +519,7 @@ static int smbios_write_type2(ulong *current, int handle,
>          * t->number_contained_objects = <obj_handle_num>;
>          */
>
> -       t->chassis_handle = handle + 1;
> +       t->chassis_handle = *handle + 1;
>
>         len = t->hdr.length + smbios_string_table_len(ctx);
>         *current += len;
> @@ -528,7 +528,7 @@ static int smbios_write_type2(ulong *current, int handle,
>         return len;
>  }
>
> -static int smbios_write_type3(ulong *current, int handle,
> +static int smbios_write_type3(ulong *current, int *handle,
>                               struct smbios_ctx *ctx)
>  {
>         struct smbios_type3 *t;
> @@ -548,7 +548,7 @@ static int smbios_write_type3(ulong *current, int handle,
>
>         t = map_sysmem(*current, len);
>         memset(t, 0, len);
> -       fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
> +       fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, *handle);
>  #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
>         elem_addr = (u8 *)t + offsetof(struct smbios_type3, sku_number);
>         sku_num_addr = elem_addr + elem_size;
> @@ -669,7 +669,7 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
>  #endif
>  }
>
> -static int smbios_write_type4(ulong *current, int handle,
> +static int smbios_write_type4(ulong *current, int *handle,
>                               struct smbios_ctx *ctx)
>  {
>         struct smbios_type4 *t;
> @@ -679,7 +679,7 @@ static int smbios_write_type4(ulong *current, int handle,
>
>         t = map_sysmem(*current, len);
>         memset(t, 0, len);
> -       fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, handle);
> +       fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, *handle);
>         smbios_set_eos(ctx, t->eos);
>         t->socket_design = smbios_add_prop_si(ctx, "socket-design",
>                                               SYSID_SM_PROCESSOR_SOCKET, NULL);
> @@ -828,13 +828,14 @@ static int smbios_write_type7_1level(ulong *current, int handle,
>         return len;
>  }
>
> -static int smbios_write_type7(ulong *current, int handle,
> +static int smbios_write_type7(ulong *current, int *handle,
>                               struct smbios_ctx *ctx)
>  {
>         int len = 0;
>         int i, level;
>         ofnode parent = ctx->node;
>         struct smbios_ctx ctx_bak;
> +       int hdl_base = *handle;
>
>         memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
>
> @@ -850,15 +851,17 @@ static int smbios_write_type7(ulong *current, int handle,
>                         return 0;
>                 ctx->subnode_name = buf;
>                 ctx->node = ofnode_find_subnode(parent, ctx->subnode_name);
> -               len += smbios_write_type7_1level(current, handle++, ctx, i);
> +               *handle = hdl_base + i;
> +               len += smbios_write_type7_1level(current, *handle, ctx, i);
>                 memcpy(ctx, &ctx_bak, sizeof(*ctx));
>         }
> +
>         return len;
>  }
>
>  #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
>
> -static int smbios_write_type32(ulong *current, int handle,
> +static int smbios_write_type32(ulong *current, int *handle,
>                                struct smbios_ctx *ctx)
>  {
>         struct smbios_type32 *t;
> @@ -866,7 +869,7 @@ static int smbios_write_type32(ulong *current, int handle,
>
>         t = map_sysmem(*current, len);
>         memset(t, 0, len);
> -       fill_smbios_header(t, SMBIOS_SYSTEM_BOOT_INFORMATION, len, handle);
> +       fill_smbios_header(t, SMBIOS_SYSTEM_BOOT_INFORMATION, len, *handle);
>         smbios_set_eos(ctx, t->eos);
>
>         *current += len;
> @@ -875,7 +878,7 @@ static int smbios_write_type32(ulong *current, int handle,
>         return len;
>  }
>
> -static int smbios_write_type127(ulong *current, int handle,
> +static int smbios_write_type127(ulong *current, int *handle,
>                                 struct smbios_ctx *ctx)
>  {
>         struct smbios_type127 *t;
> @@ -883,7 +886,7 @@ static int smbios_write_type127(ulong *current, int handle,
>
>         t = map_sysmem(*current, len);
>         memset(t, 0, len);
> -       fill_smbios_header(t, SMBIOS_END_OF_TABLE, len, handle);
> +       fill_smbios_header(t, SMBIOS_END_OF_TABLE, len, *handle);
>
>         *current += len;
>         unmap_sysmem(t);
> @@ -954,7 +957,8 @@ ulong write_smbios_table(ulong addr)
>                                 ctx.node = ofnode_find_subnode(parent_node,
>                                                                method->subnode_name);
>                 }
> -               len += method->write((ulong *)&addr, handle++, &ctx);
> +               len += method->write((ulong *)&addr, &handle, &ctx);
> +               handle++;
>         }
>
>         /*
> --
> 2.25.1
>
