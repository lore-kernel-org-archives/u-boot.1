Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D80CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893288489F;
	Mon,  1 Jun 2026 23:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mlGZqpTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6799848C6; Mon,  1 Jun 2026 23:16:14 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AB3F84894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-beab79b0978so450250166b.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348571; cv=none;
 d=google.com; s=arc-20240605;
 b=fXwyVljga+Mzw8AD5+aOYdFBpQ+mWgu8lhhMts6JxjbK14FPnj0Eub0lZwrA8pGQ7s
 TrB/mYczT/AWyFjeMRy+NEbmRa/x+VyYIGdSH7gb6m3Lo1LZSJzlSjSOEQEG8NCC2bOJ
 D6xv3FlxfwoRltzw++FXLxWzVVy5tDNe27NKVDV8sl3tHabwQtzTCgGPId9Q1ZAlUlAk
 ybGfJl6eHcBcowyX6CJ07Ar/JlXjmIR67UjYkW6q93oXk3QMPYgVBBPr0UgA4fbi/shQ
 RXqsM7IFUzgW6qW2bl6+hv0ho9nMfF3kzVtTx3k6PfBWjbEZ8qvi2R297xdxFfhZAzt1
 oghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qw2gs/jdcpV4ZrekTKnO6z0EThZNDmQHT5DwRlK0yt8=;
 fh=+l6ao+AJBZicbS+9JTYbSCO/L49L1Runw3XOeaSN+GE=;
 b=gwdaV0bBUi9ROPA4H9hHq4ROo9EHvAiMoQuyivyPRQV9L97VGq++y+2W5l926nfSqG
 hdbA9911Sx2zaHv0xILh9kJyMU2L8LVxb/SGXaDi7SmzwBUcj5AoKokew42Hh/No1Auq
 ftWZQe8OfEwPjdO6+WtwfVngr9TxAhnbbXUgaBYs6uA1QYFD1AwTHBJ0xAhnBnmVGcSz
 0q4LFZmQTit7hjBDk+QFDWsnFMspPNFnNVN/E820dpKuejB4mfpb3sYqtppUqMratEdf
 +MapHshpzf+3VfJUUieQq1c58m/zBznRmvqmxM01HOZWR7f9Y/owQI8fivsnYExSruMq
 iSNg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348571; x=1780953371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qw2gs/jdcpV4ZrekTKnO6z0EThZNDmQHT5DwRlK0yt8=;
 b=mlGZqpTgDSDwznHADnO5c5CVzUTVJ3VWzVPNsAcM71Oan0EGWzJe2sidSlRf2vF+NV
 NeQ7dIOfJsNAMpbKn/BEWADa/cE8zYt9XLtiYuv6U2QPV7dIgJaGtdF9OE4LZc6831fw
 IgTbIqEpCT1el+Ms4F8HAccjJ12hROGGy7y3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348571; x=1780953371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qw2gs/jdcpV4ZrekTKnO6z0EThZNDmQHT5DwRlK0yt8=;
 b=CWcMChrQz0kI1N50kZwlZEWpKDDH6iAcEuvE3mtNLCCuPBTBSbJN8O+xoYvX8Bj08T
 KCwTX+NhkaIcZjbWpTfxAYsZwE+KVFZmbQxl2Fm+URt3rVUPjSkZzTHufeg0ldb87Vjn
 rs0wKItXUv56K6lH9DFjpFI5DCaPy/UIdZAQAovyxzgy7vIdPSstA4nTJryWUF1p1NBS
 FZ/aPS+NXPUhG2K1YYmkQzwXvy+7V0oXWTTtM3oDYJRxlNOac5UsmLkcz0DUhphBAF2k
 Sklvf/ICgCw6BcCe/T68hf0R1TOOVI8JEkbgSP6VojlbpHI/tUFRU03/US0hRTJgFSHV
 BLPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9elq748f2q21OT9cfUmI/rXegN2e9uOQ9G5BC/wXvB0p0+f0+cK1xMMHcakIO5SrjSYmnRMzU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5odO0nquWSkyzU01EP4+Y5qLz97Eu/Yb+YH7O/hzhUYT7LSnV
 sz90WH9fCZP0xqxVN1OHoHG8Nsr94dc5fZO0METMcnnY5LZp/5pIRjnyKoVzCqUGMEtJlFgxnkT
 fEmCyhvZa5x5rh5BX3rNWUP9e9HxNY1m20yltTSRL
X-Gm-Gg: Acq92OHODEncS6XJ9AI+eT935wMAIlAwS5ltxU019Ms5GOvLrDIfm3vFT9IRnfJQEAh
 IAH7EATRcBFCI5AjJG+z83pI7X0+u+smW+TLN3p3QNx0Q/zH0auGuLPiz9ZiBrlcWIZJ8RmCPFc
 9kcBVrZ+JCK8sMvY2FYxOEdr2y5oqeaEXa/cXn8cIsOgJyslLL/bz+Hbc/VOcPlOyRTsrFm38bc
 xo/ZmAm5nsNccX7I7RCbB2XzV5c5mkk+TNBY8dhgnhCV4UgB4AWmFEJ5Qz+ubQ9p6xwkbPLBW8J
 UenB02l0p0+JUQQt
X-Received: by 2002:a17:906:4185:20b0:bef:3ab2:bed1 with SMTP id
 a640c23a62f3a-bef3ab2c991mr10984866b.16.1780348571556; Mon, 01 Jun 2026
 14:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
 <20260527095123.50797-5-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260527095123.50797-5-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:15:59 -0600
X-Gm-Features: AVHnY4KJvkZsg3b2HoZ-8Z4ZPS4jzt1zYGpTjv3-qcnbpTVxU8q3IltOwGtIMZk
Message-ID: <CAFLszTiuqLMEsky+a+BQPGkCWHuL1f7iYUayM8=_myG=8Dif9w@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] board: tq: common: add sysinfo setup helper
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
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

Hi Nora,

On 2026-05-27T09:51:17, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> board: tq: common: add sysinfo setup helper
>
> Add a setup helper based on the tq_eeprom sysinfo driver
> and set up the U-Boot environment.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> board/tq/common/Kconfig      |  5 +++++
>  board/tq/common/Makefile     |  1 +
>  board/tq/common/tq_sysinfo.c | 32 ++++++++++++++++++++++++++++++++
>  board/tq/common/tq_sysinfo.h | 15 +++++++++++++++
>  4 files changed, 53 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

> diff --git a/board/tq/common/tq_sysinfo.c b/board/tq/common/tq_sysinfo.c
> @@ -0,0 +1,32 @@
> +#include <env.h>
> +#include <sysinfo/tq_eeprom.h>

The .c file does not include its own header tq_sysinfo.h - please add
it so the compiler can check the declaration matches the definition.
The sibling tq_som.c and tq_bb.c follow this pattern.

Also, pr_err() is used below without including <linux/printk.h> or
<log.h>; today it compiles only via transitive includes. Please add
the explicit include - or switch to log_err(), which is preferred for
new U-Boot code.

> diff --git a/board/tq/common/tq_sysinfo.c b/board/tq/common/tq_sysinfo.c
> @@ -0,0 +1,32 @@
> +void tq_common_sysinfo_setup(void)
> +{
> +     struct udevice *sysinfo;
> +     char buf[MAX_NAME_LENGTH] = "";
> +     int ret;
> +
> +     ret = sysinfo_get_and_detect(&sysinfo);
> +     if (ret) {
> +             pr_err("Failed to get sysinfo data: %d\n", ret);
> +             return;
> +     }

The zero-initialisation of buf is dead, i.e. strlcpy() in the driver
always writes when sysinfo_get_str() returns 0, and env_set_runtime()
is skipped otherwise. And since the helper cannot signal failure to
the caller, please return int so board_late_init() in patch 7 can
propagate or log some context rather than relying on a bare pr_err().

Regards,
Simon
