Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C038BCD6E55
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD198493E;
	Sat,  6 Jun 2026 06:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZwykYdxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793BB84979; Sat,  6 Jun 2026 00:07:35 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D68F848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69165354c87so118381a12.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697253; cv=none;
 d=google.com; s=arc-20240605;
 b=CgQwYGpu0YawsTXsre5MnHsYu8/HPWjc2cmPmh85TIuGQ22tcqYyxFDAF9k31mVx+r
 roPp22TplimS5hYAqxPcl+0+5h/ZwX6dvxcT1hzHXFOmlvTSwQCci1eKkFghslOJjf3x
 B60Fv2K49suXGBNmg64vzqHdjRyaxdRqFmFD02Z095tXuAhYCHzsLwap88c/2+f/hNJ9
 KW/9vmM6otCncpzHm9YZ6IfDJIkld1LbVwiIVZRXDyDfnQRISxFcdLlSL87LKGm/gD4k
 1lKsOk0IYQuN/8dzamq+1JWsWBHElh7JEa+SMABFZHKTOjuDAjWqG4T7bjfQBSq3pkZH
 3v1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MH4rV7TZVXpI/YemLUaO8PUN4HtdDZgwj22L+6rpfPE=;
 fh=nV0L4IGYsNIUJA/V3S2E2udnqjaIjcTStY5jkyIIeKs=;
 b=O9Dv/1ki3R0q7pB+LTEJ7u3AD0WpfdFORToETI/YrMeRNXvmvpMGRn9dvymlhJC/3M
 zYHWwLIUdyIO/utya4/VwtpoK7mZHApGE74wrUa4O6wlMwiT9KFUMvRA4dgNVfyNtcED
 JYCIIna4t7BAzMu0yv/8M8SBQWUdkmpSVg+/AJPPI5N43zHJlOO4MRMSCup100kh58IU
 cZjfUY/Rd2B4ZlepexVMMH7duOItzGbJlV98Qys5vYN3PCairaDro2T0Jz0wIflRUVfZ
 JUIlr2EfE+IkC+IaeKX5rNGC/DwPvdokXWPomfmm9FS3PSkKq7KyWUhWcoZh1bkaCeqB
 kQiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697253; x=1781302053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MH4rV7TZVXpI/YemLUaO8PUN4HtdDZgwj22L+6rpfPE=;
 b=ZwykYdxR5ZrRbDqfHtGiv0+TODdqDpRhqxkxgHBZpOkFkjT8r67N599hdpjWEkcXPM
 fWRVFT0FSyHkXaToVpPvOqf9fvtQvuOW06/pQ7cVjk0ErgYDoady/AOpCE1FxaK4D5ZC
 MEN48nMDkm/Jafj+4hqETvNErk1SYQbjCIu+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697253; x=1781302053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MH4rV7TZVXpI/YemLUaO8PUN4HtdDZgwj22L+6rpfPE=;
 b=KDNDl5YIsAPOK0sfRXS3e3ZgZHe037VaQioSQHvz5P76JOeisMD4BSG4+EhTXbl/nB
 87z6bs0hYCO4qxSQoeEnX/sJjn/DP+Pzkov7GtHQ/2fFNGqKYT/XlqIbeFo2JUu5R4e6
 cZT23RLWbDMptfJFUf09q5WyVxRG/doQcnCCTDyZmx7dYtTHIbmWhO2Bf8frFf3i4xYC
 aoUxYNDvcvIVPj6I8hwjnYpy8W1uv4zZuHdbbwAqD7lLwSJcEirARbZtWTgHGtZX4ge+
 VBYc/L04Lud/srDGt/CYmJ4eBvNG88f7giKB9k30zTTjfUjwh7EH4w/R9xY0PMFRnOL+
 jPbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tbriPrucDcGybtNYg//eCmxULqVJkq5/ay1q/AOq9CKH7T41Z3o0Nuj06WxGxG4+qll2DA/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YykjFF4+ds5JGIuRc6EX7Y+uA5eo7rMux1Ylut4iP32HfaA+2L/
 xvOWXX97leZ7aq0Y8oGeo7gMysTv73fOoukftkchtS0+pGZj76tIG7A97ou/9nBAVwk5oEyGDSA
 hV85EdF8tpsotWLbZ44t5ZEAL8mLTrU6U9qr0/P0K
X-Gm-Gg: Acq92OGUvDxOqGlaEqbG/Osj5HJvyr2eBYf7/uxArLEDmlHgrGuuAqFUoR0nHUL1TZe
 DtoPRKFMFvbrHo2tyYpl4u0FUNuMf1zQANjTqL82h5XLS77F/eGNJqjM3vXMvA3pj4RbnOPlre4
 v+M3cEdTXB7wydWa+kw1Mtwnoa0zmdywg1Xl7WzLdJEeP633AsYaaLgk1EeWGM7YbqA9BdM7+ml
 FXqysWMislESJRSg1Ls4KAt8rmrrbvWfiUrwpM+50w0ChiXBh5qNdRdJm8vTDtRGoidiI8EwowI
 nN7pj6RGvbOSuP9EruewZVnOjT8=
X-Received: by 2002:a05:6402:518c:b0:68d:aee2:7516 with SMTP id
 4fb4d7f45d1cf-68fa47b9d81mr3204845a12.0.1780697252781; Fri, 05 Jun 2026
 15:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260604093132.757583-3-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260604093132.757583-3-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:07:19 -0600
X-Gm-Features: AVVi8CfbRpo7f0W0-P69sekcVfeNOnr-rcZvOJ5x1-oUjYo_fhE2-BB9A66f7SY
Message-ID: <CAFLszTivKopo8v0v3yad5HCvSSaDygkQ-u7QJ5QR0WkKsTi-4A@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] binman: qcom: Add type definitions for Qualcomm
 binaries
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 alpernebiyasak@gmail.com, tien.fong.chee@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, afd@ti.com, marek.vasut+renesas@mailbox.org, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 andre.przywara@arm.com, h-salunke@ti.com, alchark@gmail.com, 
 dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com, 
 danila@jiaxyga.com, n-francis@ti.com, ycliang@andestech.com, 
 mateuslima.ti@gmail.com, justin@tidylabs.net, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 bdklingerman@gmail.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:47 +0200
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

On Thu, 4 Jun 2026 at 03:32, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> Add type definitions for Qualcomm's
>
>         appsbl  -> APPS Boot Loader (U-Boot)
>         config  -> Board/DDR related configuration
>         lib     -> Library of proprietary routines
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  tools/binman/etype/qcom_appsbl.py | 18 ++++++++++++++++++
>  tools/binman/etype/qcom_config.py | 21 +++++++++++++++++++++
>  tools/binman/etype/qcom_lib.py    | 21 +++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 tools/binman/etype/qcom_appsbl.py
>  create mode 100644 tools/binman/etype/qcom_config.py
>  create mode 100644 tools/binman/etype/qcom_lib.py
>
> diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
> new file mode 100644
> index 00000000000..e308ebd2fca
> --- /dev/null
> +++ b/tools/binman/etype/qcom_appsbl.py
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# Entry-type module for U-Boot MBN image
> +#
> +
> +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
> +
> +class Entry_qcom_appsbl(Entry_blob_named_by_arg):
> +    """U-Boot mbn image
> +
> +    Properties / Entry arguments:
> +        - filename: Filename of u-boot MBN (default 'u-boot.mbn')

U-Boot (not u-boot)

> +
> +    This is the U-Boot MBN image.

It is good to have this etype, but please document it properly. We
need to know what MBN stands for, along with a link to the spec, etc.
Also please describe its role in booting.

Please do the same for the others below too.

> +    """
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node, 'qcom-appsbl')
> diff --git a/tools/binman/etype/qcom_config.py b/tools/binman/etype/qcom_config.py
> new file mode 100644
> index 00000000000..a1787c97b34
> --- /dev/null
> +++ b/tools/binman/etype/qcom_config.py
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# Entry-type module for QC Config ELF
> +#
> +
> +from binman.entry import Entry
> +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
> +
> +class Entry_qcom_config(Entry_blob_named_by_arg):
> +    """QC Config ELF

Does QC Config mean Qualcomm Config? Is this a configuration file? If
so, why is it in elf format?

> +
> +    Properties / Entry arguments:
> +        - qcom-config-path: Filename of QC Config ELF (typically 'qcconfig.elf')
> +
> +    This will be part of the Qualcomm SPL based bootloader image
> +
> +    """
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node, 'qcom-config')
> +        self.external = True
> diff --git a/tools/binman/etype/qcom_lib.py b/tools/binman/etype/qcom_lib.py
> new file mode 100644
> index 00000000000..ca7666fe6e6
> --- /dev/null
> +++ b/tools/binman/etype/qcom_lib.py
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# Entry-type module for QC LIB ELF
> +#
> +
> +from binman.entry import Entry
> +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
> +
> +class Entry_qcom_lib(Entry_blob_named_by_arg):
> +    """QC LIB ELF
> +
> +    Properties / Entry arguments:
> +        - qcom-lib-path: Filename of QC LIB ELF (typically 'QCLib.elf')
> +
> +    This will be part of the Qualcomm SPL based bootloader image
> +
> +    """
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node, 'qcom-lib')
> +        self.external = True
> --
> 2.34.1
>

Regards,
Simon
