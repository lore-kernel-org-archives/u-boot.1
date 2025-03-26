Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4966C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 07:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7069B808B6;
	Wed, 26 Mar 2025 08:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pwc77D5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 643E681B4B; Wed, 26 Mar 2025 08:31:46 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A0980756
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 08:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so4836304276.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 00:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742974303; x=1743579103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QhOO5crtjeYB+adY7JmnlDKjNxr65bqD5LVjyfecDAU=;
 b=pwc77D5eQoHrWQzNmjC6zXCUP22ukZ0KKMMoXNs510vsjq3+viZ2flXJAO1nvi7r1h
 i6nXkKHk8XZDbKi2s3pXUm1/6heUAQM1MYnFshE/4JMKgRqkUo459MG/akCKwIlVb5wn
 HC9c9zde//743P1BYSGU3lGf6x6a10A9wTQhjFfFmq+oucYEtE8y1hIunVibmb7GB3MY
 3rJzwn1MmXyXImU+L0nK+8IYe3b0ctdNtaw9ayXTnwmxSf0hskjtpi0HJbcPMhFIZZan
 5bnFo4ioPZK/Qg3wNgxggFhLJe7Nd+trAZRnnLEZ9jHg/pisQ5NoEJsyX2KOfEdka29f
 fXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974303; x=1743579103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QhOO5crtjeYB+adY7JmnlDKjNxr65bqD5LVjyfecDAU=;
 b=XFOfOhWeUgOsP6+49/qkLlPub1uemJ1LCm12aY7XPfs0eUs3BzEPmQuf7wPYvA7gRq
 8qQU6V0B4RC7zE2G79X6IOnsK5zy3wYiqeKVyhqC2FpliA4i+Cm0rJDpg7aFCvEyo/bm
 KaH9FrKhf/X62RwNiXHt4XYRZTa1gIIxK/GnqWJYq22N1yeHDNWPL2De0c9ODEjWwcAs
 rI188YIdpK1BaX0Nt69Y63bkF4QnYBSpd0EbPhoc6MKdxZK8c+B+l1sdmrDVzxrA69JP
 gofIOnDAmI0409CTXc5zs78wqYHcEr32auXTSH0a/zJISiSSTM0Xb0lLOVxb5TVicuMa
 wzbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQfP4NHRTxCtvl70ZH5HA9LtQSIyDGi7WkqAeGX4rlc8Ti6Do1C26CDE9T9jl56HhAgfM17Ik=@lists.denx.de
X-Gm-Message-State: AOJu0YzPdr4+2PvU1LUuPjYUN8heMD+Lw0pC/41V1KdC3R2z8oTgU/3C
 IpGC8AHdc6K1uppQcqpJ+dJ9LS3kn2HJ8K5urF24mxQKlbtIUZ4obFdegvREMkFLO8t10ejhH8I
 C7y9lutEZps8jZmbQnYjFGp+913Ex+qvEdxQMLA==
X-Gm-Gg: ASbGncuw9lLk3x9w1wTk4erpLzIcWAFRue82XoUQpRQZoj9HrhjzmFl8wWhyxblbmEz
 kOEVrBwcn2UPmC7oR+DvIp62N3GZ1l/+i20jmPT9kLx/u4uS45yA6mEYcPFKxT6O7cvkvwO4J1Y
 26/6dcyDuZ5wPpgoYrpx9XRAy1k4w=
X-Google-Smtp-Source: AGHT+IEZFofbFNa4IF785xtk6koKqyooeV+yZlYDS5p/FsY0/ZsglDZ9Olf4iGeka1KOv+ntpmxpDuxD1ZNEgxnJCBg=
X-Received: by 2002:a05:6902:15c4:b0:e63:ef84:1098 with SMTP id
 3f1490d57ef6-e66a4f82ebamr27433525276.34.1742974302906; Wed, 26 Mar 2025
 00:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
 <20250321232121.251800-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250321232121.251800-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 09:31:06 +0200
X-Gm-Features: AQ5f1Jq8bgnAIXAG1C8BlDA_CbiOxflh6OH-Y2eMMlv_YnZK10I2ZraRMU52rV8
Message-ID: <CAC_iWjLPeSzACGTq9L7BxbiAfJ5kQsWmZv63UUxzrp-vmVsJaw@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm: simplify updating ACPI table header checksum
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
> Use acpi_update_checksum() to update table header.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  arch/arm/mach-bcm283x/bcm2711_acpi.c | 4 ++--
>  board/raspberrypi/rpi/rpi.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-bcm283x/bcm2711_acpi.c b/arch/arm/mach-bcm283x/bcm2711_acpi.c
> index 79b283353cf..58f8ee232b9 100644
> --- a/arch/arm/mach-bcm283x/bcm2711_acpi.c
> +++ b/arch/arm/mach-bcm283x/bcm2711_acpi.c
> @@ -81,7 +81,7 @@ static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry
>         }
>
>         header->length = ctx->current - ctx->tab_start;
> -       header->checksum = table_compute_checksum(header, header->length);
> +       acpi_update_checksum(header);
>
>         acpi_inc(ctx, header->length);
>         acpi_add_table(ctx, header);
> @@ -116,7 +116,7 @@ static int rpi_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>         gtdt->el2_flags = GTDT_FLAG_INT_ACTIVE_LOW;
>         gtdt->cnt_read_base = 0xffffffffffffffff;
>
> -       header->checksum = table_compute_checksum(header, header->length);
> +       acpi_update_checksum(header);
>
>         acpi_add_table(ctx, gtdt);
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 70d3c35499b..6ecd3eb120f 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -791,7 +791,7 @@ static int rpi_acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *e
>
>         /* (Re)calculate length and checksum */
>         ssdt->length = ctx->current - (void *)ssdt;
> -       ssdt->checksum = table_compute_checksum((void *)ssdt, ssdt->length);
> +       acpi_update_checksum(ssdt);
>         log_debug("SSDT at %p, length %x\n", ssdt, ssdt->length);
>
>         /* Drop the table if it is empty */
> --
> 2.48.1
>
