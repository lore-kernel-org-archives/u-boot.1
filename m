Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3A6C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 19:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA62E8033D;
	Thu, 16 Jan 2025 20:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7MIGAQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3568069D; Thu, 16 Jan 2025 20:19:40 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CF68022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 20:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so1774426a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737055178; x=1737659978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tyA9I3uaLIZk1vmTcgT/9Ea9tpzh+9EPFk2Wu+xZlC8=;
 b=i7MIGAQcdakWUn95UnC8jad64ZOKATW7PJypV21XlOYCpKx4nbOrn80M/AybOYkEnX
 xTAaLPfwxMPb9s9xq+w3wtXdKVwK1Q7XmnGzU3YJbr6OjzUzGslNb+tQZp/lfo1xgnH4
 F9QlKnxttaCGyq0p6GgGXGMJ2sJz3yGzjGU20PdW4lS0aXq/1EnfWoT4kRj/HPi+xZ7K
 tWgkMzjB7yGc4hc9srej+iZk5WcYwf2fioOiOk4d2WiED/RBBZVPbidCn3zFz9ehlYqZ
 dVWrapvtZdN1Z/7tjTHqIXFoX7Azs+brCA06wDY10/7ymnZ5TPcq9wHWET0a2gbhoyEU
 CzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737055178; x=1737659978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyA9I3uaLIZk1vmTcgT/9Ea9tpzh+9EPFk2Wu+xZlC8=;
 b=oePmGhzfaNMDft66+lGToxSR/Z0r4cz7iNDURXQ/jxU3RT9+VqI2+uaIk0OZwdvrS2
 WQBegv8XTnk0l4k9YamKE2yryZLvzY2lprLCXzd4hjS6rdUSuDEj6Hq1I/tpHrHRSAY1
 2G/DRktQyetPmaBTz4WEBYmh6WMr8BMorTDZg2pchyYZRkpL7EYAgwkaAJxOg+eUh5WY
 nmCDj829srZJK8UEPdGL0L7qwEVETur7nSkvpxKLRAy64Z71a1HNZGTuUFWnghoM7dj6
 Ocecl7sPigimLsetN6dO0Y6tPSp0FbGpQ7Pnxmgq354UDmUGfpW1PKVQyFjRlDiz5Lqa
 JIog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTNtP6N/jA//mLeLGF4t5Zl6s1H0tXOLUvN5MSHA1ISJQEOsCbdYqHPUsJeTwfOo+ASEnYhj4=@lists.denx.de
X-Gm-Message-State: AOJu0YxbB+lP/gVPV6oeaqNHrVk2dYUIQSA55OmIHAqqY0LxXrbT2PdU
 naCpcU000OdCiVYpMB4WdETkF+eLLwgXDs4J5/0YEKLkq1axR7a5E/rxdPQBTB0pPO0nyv9E0E7
 PuA3RB3QMHiSbOzQhmCkLjOL8aH5vkAaUNGk=
X-Gm-Gg: ASbGncv0tXxFL4+ym9OjKNUYzOU0+OT5YUn3+JRTjStVO89EK3ZBQJDXkF655emlplf
 2eJGTC/jxLg95sZ7aqwRMG9xtnMfMnpsx8dotNg==
X-Google-Smtp-Source: AGHT+IG1GX7I6qaXBEVuYORxMXVzudz52i1onIIX8dt2eayLwjJ/2L7ocsSkvl5gNZqn4y8D55I/YnF6YHQoiAzD8jM=
X-Received: by 2002:a05:6402:3493:b0:5d0:bcdd:ffa7 with SMTP id
 4fb4d7f45d1cf-5d972dfbbe3mr33902451a12.3.1737055177596; Thu, 16 Jan 2025
 11:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20250101063610.260296-1-e@freeshell.de>
In-Reply-To: <20250101063610.260296-1-e@freeshell.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 17 Jan 2025 00:49:21 +0530
X-Gm-Features: AbW1kvZ6IEUYvfI6uAZcmAqYgrPrE0tYINaJuYc90n8t7CD-IKeU-GuZJmYfuG8
Message-ID: <CANAwSgQAFngCswXhemAqRNmUOL6-n80YFgkLigWNs5=FLwJswQ@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: split out visionfive2 target
 specific configuration
To: E Shattow <e@freeshell.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi E Shattow,

On Wed, 1 Jan 2025 at 12:07, E Shattow <e@freeshell.de> wrote:
>
> Split out StarFive VisionFive2 multi-board target specific configuration
> into starfive-visionfive2-binman.dtsi in preparation for removal of
> jh7110-u-boot and jh7110-common-u-boot in part or whole as sent upstream.
>
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/dts/jh7110-common-u-boot.dtsi      |  95 ----------------
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |   1 +
>  .../dts/jh7110-pine64-star64-u-boot.dtsi      |   1 +
>  ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   1 +
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |   1 +
>  .../dts/starfive-visionfive2-binman.dtsi      | 102 ++++++++++++++++++
>  6 files changed, 106 insertions(+), 95 deletions(-)
>  create mode 100644 arch/riscv/dts/starfive-visionfive2-binman.dtsi
>
> diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> index 7871294e90d..6d85b2d91a7 100644
> --- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2023 StarFive Technology Co., Ltd.
>   */
>
> -#include "binman.dtsi"
>  #include "jh7110-u-boot.dtsi"
>  / {
>         aliases {
> @@ -19,11 +18,6 @@
>                 bootph-pre-ram;
>         };
>
> -       config {
> -               bootph-pre-ram;
> -               u-boot,spl-payload-offset = <0x100000>;
> -       };
> -
>         memory@40000000 {
>                 bootph-pre-ram;
>         };
> @@ -104,92 +98,3 @@
>                 pagesize = <16>;
>         };
>  };
> -
> -&binman {
> -       itb {
> -               fit {
> -                       images {
> -                               fdt-jh7110-milkv-mars {
> -                                       description = "jh7110-milkv-mars";
> -                                       load = <0x40400000>;
> -                                       compression = "none";
> -
> -                                       blob-ext {
> -                                               filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
> -                                       };
> -                               };
> -
> -                               fdt-jh7110-pine64-star64 {
> -                                       description = "jh7110-pine64-star64";
> -                                       load = <0x40400000>;
> -                                       compression = "none";
> -
> -                                       blob-ext {
> -                                               filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
> -                                       };
> -                               };
> -
> -                               fdt-jh7110-starfive-visionfive-2-v1.2a {
> -                                       description = "jh7110-starfive-visionfive-2-v1.2a";
> -                                       load = <0x40400000>;
> -                                       compression = "none";
> -
> -                                       blob-ext {
> -                                               filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
> -                                       };
> -                               };
> -
> -                               fdt-jh7110-starfive-visionfive-2-v1.3b {
> -                                       description = "jh7110-starfive-visionfive-2-v1.3b";
> -                                       load = <0x40400000>;
> -                                       compression = "none";
> -
> -                                       blob-ext {
> -                                               filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> -                                       };
> -                               };
> -                       };
> -
> -                       configurations {
> -                               conf-jh7110-milkv-mars {
> -                                       description = "jh7110-milkv-mars";
> -                                       firmware = "opensbi";
> -                                       loadables = "uboot";
> -                                       fdt = "fdt-jh7110-milkv-mars";
> -                               };
> -
> -                               conf-jh7110-pine64-star64 {
> -                                       description = "jh7110-pine64-star64";
> -                                       firmware = "opensbi";
> -                                       loadables = "uboot";
> -                                       fdt = "fdt-jh7110-pine64-star64";
> -                               };
> -
> -                               conf-jh7110-starfive-visionfive-2-v1.2a {
> -                                       description = "jh7110-starfive-visionfive-2-v1.2a";
> -                                       firmware = "opensbi";
> -                                       loadables = "uboot";
> -                                       fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
> -                               };
> -
> -                               conf-jh7110-starfive-visionfive-2-v1.3b {
> -                                       description = "jh7110-starfive-visionfive-2-v1.3b";
> -                                       firmware = "opensbi";
> -                                       loadables = "uboot";
> -                                       fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
> -                               };
> -                       };
> -               };
> -       };
> -
> -       spl-img {
> -               filename = "spl/u-boot-spl.bin.normal.out";
> -
> -               mkimage {
> -                       args = "-T sfspl";
> -
> -                       u-boot-spl {
> -                       };
> -               };
> -       };
> -};
> diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> index 9df1e5db553..ab882d07f6f 100644
> --- a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> @@ -4,3 +4,4 @@
>   */
>
>  #include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> index 9df1e5db553..ab882d07f6f 100644
> --- a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> @@ -4,3 +4,4 @@
>   */
>
>  #include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> index 9df1e5db553..ab882d07f6f 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> @@ -4,3 +4,4 @@
>   */
>
>  #include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> index e6bc6630dcd..874074174ff 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> @@ -4,3 +4,4 @@
>   */
>
>  #include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"
> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> new file mode 100644
> index 00000000000..4cce001e80d
> --- /dev/null
> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + */
> +
> +#include "binman.dtsi"
> +
> +/ {
> +       config {
> +               bootph-pre-ram;
> +               u-boot,spl-payload-offset = <0x100000>;
> +       };
> +};
> +
> +&binman {
> +       itb {
> +               fit {
> +                       images {
> +                               fdt-jh7110-milkv-mars {
> +                                       description = "jh7110-milkv-mars";
> +                                       load = <0x40400000>;
> +                                       compression = "none";
> +
> +                                       blob-ext {
> +                                               filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
> +                                       };
> +                               };
> +
> +                               fdt-jh7110-pine64-star64 {
> +                                       description = "jh7110-pine64-star64";
> +                                       load = <0x40400000>;
> +                                       compression = "none";
> +
> +                                       blob-ext {
> +                                               filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
> +                                       };
> +                               };
> +
> +                               fdt-jh7110-starfive-visionfive-2-v1.2a {
> +                                       description = "jh7110-starfive-visionfive-2-v1.2a";
> +                                       load = <0x40400000>;
> +                                       compression = "none";
> +
> +                                       blob-ext {
> +                                               filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
> +                                       };
> +                               };
> +
> +                               fdt-jh7110-starfive-visionfive-2-v1.3b {
> +                                       description = "jh7110-starfive-visionfive-2-v1.3b";
> +                                       load = <0x40400000>;
> +                                       compression = "none";
> +
> +                                       blob-ext {
> +                                               filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> +                                       };
> +                               };
> +                       };
> +
> +                       configurations {
> +                               conf-jh7110-milkv-mars {
> +                                       description = "jh7110-milkv-mars";
> +                                       firmware = "opensbi";
> +                                       loadables = "uboot";
> +                                       fdt = "fdt-jh7110-milkv-mars";
> +                               };
> +
> +                               conf-jh7110-pine64-star64 {
> +                                       description = "jh7110-pine64-star64";
> +                                       firmware = "opensbi";
> +                                       loadables = "uboot";
> +                                       fdt = "fdt-jh7110-pine64-star64";
> +                               };
> +
> +                               conf-jh7110-starfive-visionfive-2-v1.2a {
> +                                       description = "jh7110-starfive-visionfive-2-v1.2a";
> +                                       firmware = "opensbi";
> +                                       loadables = "uboot";
> +                                       fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
> +                               };
> +
> +                               conf-jh7110-starfive-visionfive-2-v1.3b {
> +                                       description = "jh7110-starfive-visionfive-2-v1.3b";
> +                                       firmware = "opensbi";
> +                                       loadables = "uboot";
> +                                       fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
> +                               };
> +                       };
> +               };
> +       };
> +
> +       spl-img {
> +               filename = "spl/u-boot-spl.bin.normal.out";
> +
> +               mkimage {
> +                       args = "-T sfspl";
> +
> +                       u-boot-spl {
> +                       };
> +               };
> +       };
> +};
>

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

> base-commit: 43cae09eabf398ede30fd4ed1664e2ee6c447d34

> --
> 2.45.2
>
