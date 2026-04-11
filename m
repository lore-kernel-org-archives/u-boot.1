Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93606F3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C47841C2;
	Sat, 11 Apr 2026 15:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ExeMDjAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586CF8416F; Sat, 11 Apr 2026 15:12:47 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7B784118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9c62fc8debso463521866b.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775913165; cv=none;
 d=google.com; s=arc-20240605;
 b=hwMDifEegFx8DbxbFpQ26MCwlcophEOjl6ZxHPlhizmjnC4kOoyMjN53OfTCOAYE1n
 XwEuwFSuiJayRqqfuyr2HDJkBeURCxAgufOki6MLez/qk6lA7/fX06qcwlWX9OZ4aaf8
 M44t7IVLFwDrew0+PnO7h1sXYjaftIYpxomAidLwqzBd1sMewhA3Oo6yg+D187yOu4WC
 /DbVS+sfhkrzoveoAW1oMRmVhcb7UTLB+1Ai5zUcHuLtVuN/veoyC8uXqr7jKqORg9Dl
 Rygv8bo6iuHoTAtCvehf0/gPkLyvkfrwgZfwh8oEO5xDKNdpy95DI7Swz+47tkDBTLqE
 1XaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FH6YGr1UM9kC5KsVHNGpgCm008bXJXGhNlko/OfDuB0=;
 fh=GpBASHTCKpcW9ZTiByhEpOUkXFtuj+tpsq7zmcHSQL0=;
 b=SzTDCJWg1peVHtZWCACtbKrXn9NUcb+1Qkv5kZulPdLgkstzMZL8wM/F0mgJuiNCA+
 EAHJxWGi8VdEA0oYehFDEjnQBE3Y+vIxZzuZGF9NZUZeLDTuKqvibCc0PoglQ/LHZFWy
 /Sf9U7vWnxreM4u93qhLX/FFIIVbt1tdB2FJLGbDyKZUOMtp5ANlAdKKo8M+W4mcQ06T
 I4AkxC30rtez/fsQYtcR4CwbHI69t81hyVJbpFQO2+G0i3v/Y7HT73/cToycYnCD65UO
 sJgEM1n4HpQTGQ/6K/F0cISWvWzMIPwcFWjk8VzTshRejvRgY7lHn9riAJF04P2lg39O
 Vx2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775913165; x=1776517965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FH6YGr1UM9kC5KsVHNGpgCm008bXJXGhNlko/OfDuB0=;
 b=ExeMDjAagFcnCYpuQSP/hpQlPIS3AsZyiP1e/psI6aoGVNSUc+wO07PJY0WHr2hqLD
 kmAU+qZIptNaglHkv9x/tp1Uob9qwJ78n06mT0Vlza1P9WkUklSwncmeCkf6qVUzd6sg
 8S36SlXrECBRNVZKtNxKxjz3kvejRAAbamhNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775913165; x=1776517965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FH6YGr1UM9kC5KsVHNGpgCm008bXJXGhNlko/OfDuB0=;
 b=E8T5WtbgEEmjEOmpL9mQgKL7CTSVC1KdiLj8KDKM2aTF08XAWBUYVi9PHgv1qU9mGI
 N5JTw6iWenUKfxbPZZl3PJDWkV/ZdMqwRW+hAhUC/XD1d7dKb/rQGT0zAm5XA8t3oSON
 jTU0Mc40K+5fL2XW2XQy4D5MzlLkL1D3jDVUMgwSpMgH9EClGYkT9z/bVrx6DzJW9Vwp
 8UEo6LcTasquLlsgVmUPWF+hvwDFHKkmnWPdR+Ibk5IZ00xN6Y6WDwj9LNjnPx75t5YQ
 Brv1DAspCAKy6ctE/jWLqtIIl3v5NgLaYAYxExBO4cb4J5u+OOxP/E6UUajRW9AQ4lJm
 4n2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHzhn7Xn/klmfBiClF87h35W7KtPbdUYd1dQlI8BkLZMzA6v8u/i/AlUpTTlC64pTY+osbuZQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyjh9lIT2zuTmxWpRJKgL/WX9GKViUC0ySJ5tjU9z7Xxi7b/e/o
 YyyfPPVEKMVmVZXlXcf7ywd3k72Gb9yiv4WJzqCA7h3VXM27wq10/qrOWKAzzcU/jTC76uuEWPu
 DEsgu4YXLb4Pe7yylwrcFvz4uqAzso3fwyUQePrHl
X-Gm-Gg: AeBDievZAcTzQep9RTWXoHZ/ZtbCCs/2JlvBmXdKl+y9B/jnBhzW2kMMupY/OsKBMia
 Mrcfp4MklFtYJW5lKigrP3kr/DjpmxbTMe0lFijgC6JuS36DMmp5BEySLPLb6Ttily+NpctkmM4
 iX3WBIU8CpjnueOeY9/5Qx8sN5sCPyikCOjv3CxegCgRopLT5w6VNzOq+aTjXuhJ43nRLEf2IFn
 dfM1yP1LmJVESNfmnQTLRMmBd3ys4Z/TfdLgGy1v8oTwbaC94Lat94Nd6VC8BG4oSW+ABgwswab
 u5nVyneApVXj3io5
X-Received: by 2002:a17:907:3e96:b0:b9d:94e4:d35e with SMTP id
 a640c23a62f3a-b9d94e4d591mr238170466b.29.1775913164634; Sat, 11 Apr 2026
 06:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-8-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-8-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:12:33 -0600
X-Gm-Features: AQROBzB8U_PVbPgZLP_5a3Fdgw2REjDTc8nFOW1zUEqOqR3MGCecezwDPpBN7_A
Message-ID: <CAFLszThd_aCr2sB+1YcuP7ZPvAjT31-rNs2_T6Xfw281Q2pvuQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] mach-snapdragon: Add initial support for IPQ5210
 SPL
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

Hi Varadarajan,

On 2026-04-10T09:11:45, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add initial support for IPQ5210 SPL
>
> Add basic SPL infrastructure for IPQ5210 SoC. This handles basic serial
> console init, identifying the boot media, loading the additional
> firmware binaries to setup DDR, TFA and eventually jump to U-Boot.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/Kconfig                  |   5 +-
>  arch/arm/mach-snapdragon/Makefile |   3 +
>  arch/arm/mach-snapdragon/spl.c    | 701 ++++++++++++++++++++++++++++++++++++++
>  include/smem.h                    |   3 +
>  4 files changed, 710 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> @@ -0,0 +1,701 @@
> +#include <hang.h>
> +#include <cpu_func.h>
> +#include <init.h>

You should add DECLARE_GLOBAL_DATA_PTR here as the code uses gd in
qcom_spl_malloc_init_f(), for example.

> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> @@ -0,0 +1,701 @@
> +#define QCOM_SPL_DLOAD_MASK          GENMASK(4, 4)
> +#define QCOM_SPL_DLOAD_SHFT          0x4

GENMASK(4, 4) is just BIT(4). Please use BIT(4) directly.

> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> @@ -0,0 +1,701 @@
> +static int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
> +                                         char *name,
> +                                         struct interface_table_entry *entry)
> +{
> +     u8 uc_index;
> +...
> +     for (uc_index = 0; uc_index < MAX_ENTRIES; uc_index++) {

This should iterate up to if_tbl->num_entries rather than MAX_ENTRIES,
otherwise you will search uninitialised entries. Also name should be
const char *

Also how about uint instead of u8 ?

> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> @@ -0,0 +1,701 @@
> +     fit = (const void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
> +
> +     if (!fit) {
> +             pr_err("FIT image not found at CONFIG_SPL_LOAD_FIT_ADDRESS\n");
> +             return -EINVAL;
> +     }

CONFIG_SPL_LOAD_FIT_ADDRESS is a compile-time constant which (08cbe000
?) so cannot be zero.

> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> @@ -0,0 +1,701 @@
> +void board_init_f(ulong dummy)
> +{
> +...
> +     qclib_post_process_from_spl();
> +
> +     board_init_r(NULL, 0);

The return value from qclib_post_process_from_spl() is ignored. If it
fails, you should call qcom_spl_error_handler() like you do for the
other errors in this function.

> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> @@ -0,0 +1,701 @@
> +void reset_cpu(void)
> +{
> +}

Please add a comment as to why it is empty.

Regards,
Simon
