Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2B4D3B98D
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06158972F;
	Tue, 26 Nov 2024 14:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2lpeBJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013FC89734; Tue, 26 Nov 2024 14:16:09 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47EB89189
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 14:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ffc86948dcso19344511fa.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732626966; x=1733231766; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7M9Ip7Nr5oEa/uMmJSJ6TQ+t3JKx8mut9/ewOabwl2A=;
 b=C2lpeBJHsDmcsB8vEOrPtA0YFBAVK0VTXwaxODGVDatT3LqhJEoBQ80DdbSfo3DC77
 FbGgp1TX1++KvfEU0rVd0gQ/Unu1TRbEJH5VZ9W5ep2tUFXKzSShB8Q/aXXCmopfT5H0
 ePp9zYSngKgaGp6O835FHf2f1NfG0gRGo0lRWCewdMmc2/zIRK5vtXKPOSXAjuyEwBac
 DeUJaFY48fzB/RDCtvsPP6hXh+/JMNj8grfNXkjGzxXbJZw7kjgKdIi2v1XISUrhfubT
 7+jKSgoacmUpecrbury0ajc7lr8stbWjRzpA3bCFdbb8ryqEInimj9qjp8oR2xmGpuy0
 axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626966; x=1733231766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7M9Ip7Nr5oEa/uMmJSJ6TQ+t3JKx8mut9/ewOabwl2A=;
 b=QMkY/ywnX2T4L74TUXAdV6c1DUVKycPx4uqAslduK4zl37XaBtjfdBgpkXYEjVbVjm
 7X/OBgToLhNBJ0VtxR9IVHjxvqMft7wSOxCkIY94gcmuiJ/A0CiNv0cBlXRaLdWBCIC6
 xtfxy6c7H/0VI3WkaAI2mlzNqvXVvPG+T78ga/cbJvYaRtlq/adTgjLoU8hc6wOoM1I4
 HCF/3nuK1gmG6rr+Tg7eci0hYe9e9WBjTFnRRaqr93iNrq8iB7hutEB6+rvSL8Glvbn7
 8K1jsYfcJsa/ArrQ1J8jpvJp9eKifDajMoJCkxtlEvU4I42esXHl3/mOnVBlvlHesHs2
 wC2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo9yGdiiBlEs4XBW4yWEj5ddVq06907lJo7a9f1o65AOt21OokVZVy1LRIX0J4hLWaBpSm1k8=@lists.denx.de
X-Gm-Message-State: AOJu0YzElyf0RdeUpO9GUb9iSGhlFqhH6sxmovlDfvRzFx9g8l+2m8MI
 m1cFW1hXy3I/EXSak2bSHT56MbgdHHrZeREe3bNog4zi5987kmgodVgyccQx6YwTzMWj/curp2r
 Kq7vk1sGuXjgrGZp3+jxq/sUyfL4=
X-Gm-Gg: ASbGncsIE9HFEg/Y41fyyURxUXtff7W0KFbyEHdy1DB+L9K0JboK04wRe4tfRZO9dIQ
 rfbOT4xJL2e02wrHegkD4MRW++9ie89yYZOToywXtzlOvqVvQUeCyCT/5Vfm3HZX8bg==
X-Google-Smtp-Source: AGHT+IHHXbc4cvcIw3i6DqdhjF47hIrAQFrIg8zgBSRe98Fc9kmgDRuIgXiupNLQH1B0kBsph8thE7TxZo6YySe3w54=
X-Received: by 2002:a2e:a809:0:b0:2ff:8137:60a9 with SMTP id
 38308e7fff4ca-2ffa712ac11mr86953211fa.23.1732626965923; Tue, 26 Nov 2024
 05:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
 <20241125003205.75327-6-hal.feng@starfivetech.com>
In-Reply-To: <20241125003205.75327-6-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 26 Nov 2024 05:15:54 -0800
Message-ID: <CANV2PTOs_ZLX6=H0ZS1zizKum1VzZE2LHm6dE+OgF9O+XPXAGg@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Nov 24, 2024 at 4:33=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> To support the other JH7110 based boards, add u-boot
> device tree for them.
>
> Tested-by: E Shattow <lucent@gmail.com>
> Reviewed-by: E Shattow <lucent@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: H Bell <dmoo_dv@protonmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi               | 7 +++++++
>  arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi            | 6 ++++++
>  .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi     | 6 ++++++
>  3 files changed, 19 insertions(+)
>  create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-b=
oot.dtsi
>

> diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dt=
s/jh7110-milkv-mars-u-boot.dtsi
> new file mode 100644
> index 0000000000..f56528c988
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +

delete newline at end of file

> diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv=
/dts/jh7110-pine64-star64-u-boot.dtsi
> new file mode 100644
> index 0000000000..9df1e5db55
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dts=
i b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> new file mode 100644
> index 0000000000..9df1e5db55
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> --
> 2.43.2
>

Reviewed-by: E Shattow <lucent@gmail.com>
