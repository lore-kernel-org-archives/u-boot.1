Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8EDC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14AA87C6F;
	Sat, 16 Dec 2023 19:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aM+Pw/7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314BD87C6A; Sat, 16 Dec 2023 19:48:40 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA9E87C6F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5cd81e76164so15711787b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yRp7Ez5Vx5p4ZtAgwExCJxq1fkHR2WmvvAYMRLJvK5A=;
 b=aM+Pw/7jaS7rBr+Ut3aYhxbgMYtC1XDuMrvJkVwp/BREpAqlbTbwF7IOdtS5G02uHh
 U5j5dzZQ1kIGfaL56/wS68SYSfcW6kXxprpIjksRef4ZHUil1fL3mBs1WqMdZg8JkIJ4
 4kia+l70BdcCWQt9zYVK/BObJ3TNnKPI/tuQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yRp7Ez5Vx5p4ZtAgwExCJxq1fkHR2WmvvAYMRLJvK5A=;
 b=FJeSJx6yMyt2lL498Rl1rmXdNNCVBpeAFcW+CrEF1N9O0KtI3E19C2y8kUVBlaP5ic
 sv8XXcJnMgChi+XwGrqRLQikMQcClOJMl8I+CttXwCmUvS5Ehl/sqjsqONu/HvylW72g
 iXSE8DAexTcox0zHpr5EEF+B0fwgQYN+GdgnxEEfVIdzBn7cA3LY7DWKtp5QH8kBtKKH
 xztyPyPxfFxknlt1omzWwdTNqn311p23o3OoD/6H+iBnp2FG69mKuZwGXMfxpEd5F7xQ
 BnZnH7oy1zDGzkNDbF1hYi8CHkifenReo4IPh8q1ET2MCMdi68uhUru2LTlN2Ngeb1wi
 yebg==
X-Gm-Message-State: AOJu0YyGwcgjPIJqFJ+JwqkuSpfT4/jEblkDqAUEEbN8Qm+aE/uXagQR
 rHWrvbVe9UxvgvtrJM39pIWwJGSTU4r7Wzmxj26SgNnJ8SrX/AwIN5w=
X-Google-Smtp-Source: AGHT+IH69sFOfdL+Le5WXfYbR/pZNMLSsqRn8GqAQxiiNt/LZMpik2q0j9BhUlWuyQm2Zx7hlxCatNbs+x+3CCoFfGo=
X-Received: by 2002:a81:5258:0:b0:5e5:6c05:904e with SMTP id
 g85-20020a815258000000b005e56c05904emr736243ywb.11.1702752514132; Sat, 16 Dec
 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215133245.7923-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:09 -0700
Message-ID: <CAPnjgZ23cv=i+9_vuM3EaQ2-vUhEvzcd7Dynowd41M5hsSGHrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] arrm: add ACPI fields to global data
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

On Fri, 15 Dec 2023 at 06:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fields for the location of ACPI tables to the global data.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  arch/arm/include/asm/global_data.h | 4 ++++
>  1 file changed, 4 insertions(+)

These need to be #ifdefed as they affect global_data size,
particularly in SPL. In fact, we have a problem there.

>
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
> index 75bd9d56f8..9505399bb1 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -19,6 +19,10 @@ struct arch_global_data {
>  #if defined(CONFIG_FSL_ESDHC) || defined(CONFIG_FSL_ESDHC_IMX)
>         u32 sdhc_clk;
>  #endif
> +       ulong table_start;              /* Start address of ACPI tables */
> +       ulong table_end;                /* End address of ACPI tables */
> +       ulong table_start_high;         /* Start address of high ACPI tables */
> +       ulong table_end_high;           /* End address of high ACPI tables */
>
>  #if defined(CONFIG_FSL_ESDHC)
>         u32 sdhc_per_clk;
> --
> 2.40.1
>

Regards,
Simon
